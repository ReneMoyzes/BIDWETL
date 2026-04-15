# Lab: Row-Level Security v Power BI
## Část 3 – Nastavení RLS rolí

---

Implementujeme postupně čtyři typy RLS:

| Typ | Popis | Sekce |
|---|---|---|
| **Statické RLS** | Pevný filtr v roli | 3.1 |
| **Dynamické RLS** | Filtr dle identity uživatele | 3.2 |
| **Hierarchické RLS** | Manažer vidí svůj tým | 3.3 |
| **Management role** | Vedení vidí vše | 3.4 |

---

## Jak otevřít správu rolí

1. V Power BI Desktop klikněte záložku **Modeling**
2. Klikněte **Manage Roles** (sekce Security)
3. Zobrazí se dialog pro správu rolí

---

## 3.1 – Statické RLS

Vytvoříme samostatné role pro každý region.  
Vhodné pro malý počet skupin nebo demo/sandbox prostředí.

### Role: Ostrava_Static

1. Klikněte **Create**
2. Název role: `Ostrava_Static`
3. Vyberte tabulku **Dim_Region**
4. Do pole DAX filter zadejte:

```dax
[Město] = "Ostrava"
```

5. Klikněte zelené ✓ (Commit)

### Role: Praha_Static

1. Klikněte **Create**, název: `Praha_Static`
2. Tabulka: **Dim_Region**, DAX filter:

```dax
[Město] = "Praha"
```

### Role: Sever_Static (více regionů v jedné roli)

1. Klikněte **Create**, název: `Sever_Static`
2. Tabulka: **Dim_Region**, DAX filter:

```dax
[Město] IN { "Ostrava", "Olomouc" }
```

### Jak statické RLS funguje

Filtr `[Město] = "Ostrava"` se aplikuje na tabulku `Dim_Region`.  
Protože `Fact_Prodeje` je přes `RegionID` napojena na `Dim_Region`,  
Power BI automaticky omezí i prodeje – uvidíme jen ostravské transakce.

---

## 3.2 – Dynamické RLS

**Jedna role pro všechny uživatele** – filtr reaguje na identitu přihlášeného uživatele.

### Prerekvizita: tabulka `Zabezpeceni_Uzivatele`

Tabulka obsahuje:
```
Email                        | RegionID | Region
oz1.ostrava@firma.cz         | 1        | Ostrava
manazer.ostrava@firma.cz     | 1        | Ostrava
oz1.praha@firma.cz           | 2        | Praha
manazer.praha@firma.cz       | 2        | Praha
...
```

### Role: DynamicRLS_Region

1. Klikněte **Create**, název: `DynamicRLS_Region`
2. Vyberte tabulku **Dim_Region**
3. DAX filter:

```dax
[RegionID] IN
    CALCULATETABLE(
        VALUES( Zabezpeceni_Uzivatele[RegionID] ),
        Zabezpeceni_Uzivatele[Email] = USERPRINCIPALNAME()
    )
```

#### Jak to funguje krok za krokem:

1. `USERPRINCIPALNAME()` → vrátí e-mail přihlášeného uživatele, např. `oz1.ostrava@firma.cz`
2. `Zabezpeceni_Uzivatele[Email] = USERPRINCIPALNAME()` → vyfiltruje řádky bezpečnostní tabulky
3. `VALUES( Zabezpeceni_Uzivatele[RegionID] )` → vrátí seznam RegionID daného uživatele
4. `[RegionID] IN {...}` → ponechá jen regiony ze seznamu

**Výsledek:** Každý uživatel vidí jen svůj region. Přidání nového uživatele = přidat řádek do bezpečnostní tabulky, **bez změny role**.

---

## 3.3 – Hierarchické dynamické RLS

Manažer regionu vidí data celého regionu (stejně jako OZ ze stejného regionu).  
Ředitel vidí všechny regiony.

### Struktura tabulky Dim_Zamestnanec

```
ZamestnanecID | Jmeno    | Email                        | NadrizenyID | RegionID | Pozice
1             | Michal   | reditel@firma.cz             | NULL        | 1        | Ředitel
2             | Manažer  | manazer.ostrava@firma.cz     | 1           | 1        | Manažer
3             | OZ_Ostrava_1 | oz1.ostrava@firma.cz     | 2           | 1        | Obchodní zástupce
...
```

### Role: HierarchickyRLS

1. Klikněte **Create**, název: `HierarchickyRLS`
2. Vyberte tabulku **Dim_Region**
3. DAX filter:

```dax
[RegionID] IN
    CALCULATETABLE(
        VALUES( Dim_Zamestnanec[RegionID] ),
        FILTER(
            Dim_Zamestnanec,
            Dim_Zamestnanec[Email] = USERPRINCIPALNAME()
        )
    )
```

> Tato verze vrátí region daného zaměstnance (OZ i manažer patří do regionu).  
> Ředitel má speciální roli – viz 3.4.

### Rozšíření: Manažer vidí i podřízené z jiných regionů

Pokud chceme, aby manažer viděl i zaměstnance, kteří mu přímo podléhají:

```dax
[RegionID] IN
    CALCULATETABLE(
        VALUES( Dim_Zamestnanec[RegionID] ),
        FILTER(
            Dim_Zamestnanec,
            Dim_Zamestnanec[Email] = USERPRINCIPALNAME()
            || Dim_Zamestnanec[NadrizenyID] IN
                CALCULATETABLE(
                    VALUES( Dim_Zamestnanec[ZamestnanecID] ),
                    Dim_Zamestnanec[Email] = USERPRINCIPALNAME()
                )
        )
    )
```

---

## 3.4 – Management role (vidí vše)

### Role: Management

1. Klikněte **Create**, název: `Management`
2. Vyberte tabulku **Dim_Region**
3. DAX filter:

```dax
TRUE()
```

Hodnota `TRUE()` = žádné omezení – vidí všechny řádky.

> **Alternativa:** Neaplikovat filtr vůbec (nechat prázdné pole).  
> `TRUE()` je explicitní a čitelnější záměr.

---

## 3.5 – Uložení rolí

Po vytvoření all rolí klikněte **Save** v dialogu Manage Roles.

### Přehled všech rolí:

| Název role | Typ | Filtrovaná tabulka | DAX filtr |
|---|---|---|---|
| `Ostrava_Static` | Statická | Dim_Region | `[Město] = "Ostrava"` |
| `Praha_Static` | Statická | Dim_Region | `[Město] = "Praha"` |
| `Sever_Static` | Statická (více) | Dim_Region | `[Město] IN {"Ostrava","Olomouc"}` |
| `DynamicRLS_Region` | Dynamická | Dim_Region | `USERPRINCIPALNAME()` + bezpečnostní tabulka |
| `HierarchickyRLS` | Hierarchická | Dim_Region | USERPRINCIPALNAME() + Dim_Zamestnanec |
| `Management` | Bez omezení | Dim_Region | `TRUE()` |

---

**RLS je nastaveno!** Pokračujte souborem `04_Testovani_RLS.md`.
