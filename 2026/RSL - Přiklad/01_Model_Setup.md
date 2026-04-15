# Lab: Row-Level Security v Power BI
## Část 1 – Nastavení datového modelu

---

## Scénář

Firma **TechSales s.r.o.** prodává IT hardware ve 5 regionech ČR.  
Chceme, aby každý obchodní zástupce viděl jen data svého regionu,  
manažer regionu viděl svůj region, a vedení firmy vidělo vše.

### Uživatelé v labu

| E-mail (simulovaný) | Role | Region |
|---|---|---|
| `oz1.ostrava@firma.cz` | Obchodní zástupce | Ostrava |
| `oz2.ostrava@firma.cz` | Obchodní zástupce | Ostrava |
| `manazer.ostrava@firma.cz` | Manažer | Ostrava |
| `oz1.praha@firma.cz` | Obchodní zástupce | Praha |
| `manazer.praha@firma.cz` | Manažer | Praha |
| `oz1.brno@firma.cz` | Obchodní zástupce | Brno |
| `manazer.brno@firma.cz` | Manažer | Brno |
| `reditel@firma.cz` | Ředitel | Vše |

---

## Krok 1 – Import CSV souborů

1. Otevřete **Power BI Desktop**
2. Klikněte **Get Data → Text/CSV**
3. Nastavte oddělovač: **Semicolon (;)**, kódování: **UTF-8**
4. Importujte všechny CSV v tomto pořadí:

| Soubor | Typ tabulky |
|---|---|
| `Dim_Datum.csv` | Dimenze (Date Table) |
| `Dim_Region.csv` | Dimenze |
| `Dim_Produkt.csv` | Dimenze |
| `Dim_Zakaznik.csv` | Dimenze |
| `Dim_Zamestnanec.csv` | Dimenze |
| `Fact_Prodeje.csv` | Faktová tabulka |
| `Fact_Cile.csv` | Faktová tabulka |
| `Zabezpeceni_Uzivatele.csv` | Bezpečnostní tabulka |

> **Tip:** Importujte vše najednou pomocí Power Query → New Source.

---

## Krok 2 – Kontrola datových typů v Power Query

Po importu každého CSV zkontrolujte/opravte typy v Power Query Editoru:

### Dim_Datum
| Sloupec | Typ |
|---|---|
| DatumKey | Whole Number |
| Datum | **Date** |
| Rok | Whole Number |
| Mesic | Whole Number |
| Den | Whole Number |
| Ctvrtleti | Whole Number |
| TydenCislo | Whole Number |
| MesicNazev | Text |
| CtvrtletiNazev | Text |
| JePracovniDen | Whole Number |

### Dim_Region
| Sloupec | Typ |
|---|---|
| RegionID | Whole Number |
| Město | Text |
| Kraj | Text |

### Dim_Produkt
| Sloupec | Typ |
|---|---|
| ProduktID | Whole Number |
| Název | Text |
| Kategorie | Text |
| Podkategorie | Text |
| CenaCzk | Decimal Number |

### Dim_Zakaznik
| Sloupec | Typ |
|---|---|
| ZakaznikID | Whole Number |
| Jmeno | Text |
| Prijmeni | Text |
| Email | Text |
| Mesto | Text |
| RegionID | Whole Number |
| Typ | Text |
| Vek | Whole Number |

### Dim_Zamestnanec
| Sloupec | Typ |
|---|---|
| ZamestnanecID | Whole Number |
| Jmeno | Text |
| Prijmeni | Text |
| Email | Text |
| NadrizenyID | Whole Number |
| RegionID | Whole Number |
| Pozice | Text |

### Fact_Prodeje
| Sloupec | Typ |
|---|---|
| ProdejID | Whole Number |
| DatumKey | Whole Number |
| ZakaznikID | Whole Number |
| ProduktID | Whole Number |
| RegionID | Whole Number |
| ZamestnanecID | Whole Number |
| Mnozstvi | Whole Number |
| CenaPoSleve | Decimal Number |
| Sleva | Decimal Number |
| CelkemCzk | Decimal Number |
| NakupniNakladyCzk | Decimal Number |

### Fact_Cile
| Sloupec | Typ |
|---|---|
| CilID | Whole Number |
| Rok | Whole Number |
| Mesic | Whole Number |
| RegionID | Whole Number |
| CilCzk | Decimal Number |

### Zabezpeceni_Uzivatele
| Sloupec | Typ |
|---|---|
| Email | Text |
| RegionID | Whole Number |
| Region | Text |

Klikněte **Close & Apply**.

---

## Krok 3 – Nastavení relací (Model View)

Přejděte na záložku **Model** (ikona schématu).

### Relace k vytvoření:

| Z tabulky (Many) | Sloupec | Do tabulky (One) | Sloupec | Směr filtru |
|---|---|---|---|---|
| Fact_Prodeje | DatumKey | Dim_Datum | DatumKey | Jednosměrný (→) |
| Fact_Prodeje | RegionID | Dim_Region | RegionID | Jednosměrný (→) |
| Fact_Prodeje | ProduktID | Dim_Produkt | ProduktID | Jednosměrný (→) |
| Fact_Prodeje | ZakaznikID | Dim_Zakaznik | ZakaznikID | Jednosměrný (→) |
| Fact_Prodeje | ZamestnanecID | Dim_Zamestnanec | ZamestnanecID | Jednosměrný (→) |
| Fact_Cile | RegionID | Dim_Region | RegionID | Jednosměrný (→) |
| Dim_Zakaznik | RegionID | Dim_Region | RegionID | Jednosměrný (→) |
| Dim_Zamestnanec | RegionID | Dim_Region | RegionID | Jednosměrný (→) |
| Zabezpeceni_Uzivatele | RegionID | Dim_Region | RegionID | Jednosměrný (→) |

> **Důležité:** Všechny relace nastavte jako **jednosměrné** (Single direction).  
> Obousměrné relace mohou způsobit neočekávané chování RLS.

### Jak přidat relaci:
1. V Model View přetáhněte sloupec z jedné tabulky na druhou
2. Ve zobrazeném dialogu zkontrolujte:
   - Cardinality: **Many to One (*:1)**
   - Cross filter direction: **Single**
3. Klikněte OK

---

## Krok 4 – Označení Date Table

1. Klikněte pravým tlačítkem na tabulku **Dim_Datum**
2. Vyberte **Mark as date table → Mark as date table**
3. V dialogu vyberte sloupec **Datum** (typ Date, formát `YYYY-MM-DD`)
4. Potvrďte OK

> **Důležité:** Sloupec pro označení Date Table musí být typý **Date**, ne integer. Sloupec `DatumKey` je celé číslo (YYYYMMDD) a nelze ho použít. Sloupec `Datum` se po importu automaticky detekuje jako Date.

> **Poznámka:** Power BI bude Time Intelligence funkce (TOTALYTD, SAMEPERIODLASTYEAR, DATEADD atd.) vyhodnocovat správně pouze pokud je Date Table označena a measures odkazují na sloupec **Datum**.

---

## Krok 5 – Vytvoření tabulky pro Measures

1. V záložce **Modeling** klikněte **New Table**
2. Zadejte: `Measures = {0}`
3. Pojmenujte tabulku `_Measures`
4. Smažte automaticky vytvořený sloupec "Value"

> Všechna měřítka budeme definovat v tabulce `_Measures` – udržuje model přehledný.

---

## Krok 6 – Skrytí pomocných sloupců

Skryjte tyto sloupce (pravý klik → Hide in report view):

- Fact_Prodeje: DatumKey, ZakaznikID, ProduktID, RegionID, ZamestnanecID
- Fact_Cile: CilID, RegionID
- Dim_Zakaznik: RegionID
- Dim_Zamestnanec: NadrizenyID, RegionID
- Zabezpeceni_Uzivatele: RegionID
- Dim_Datum: DatumKey

**Model je připraven!** Pokračujte souborem `02_DAX_Measures.md`.
