# Lab: Row-Level Security v Power BI
## Část 2 – DAX Measures

---

Všechna níže uvedená měřítka vytvořte v tabulce `_Measures`.  
**Jak vytvořit measure:** Klikněte na tabulku `_Measures` → Modeling → New Measure.

---

## Základní agregace

```dax
-- Celkové tržby
Celkove Trzby =
    SUM( Fact_Prodeje[CelkemCzk] )
```

```dax
-- Celkové náklady
Celkove Naklady =
    SUM( Fact_Prodeje[NakupniNakladyCzk] )
```

```dax
-- Hrubý zisk
Hrubý Zisk =
    [Celkove Trzby] - [Celkove Naklady]
```

```dax
-- Marže %
Marze Procent =
    DIVIDE( [Hrubý Zisk], [Celkove Trzby], 0 )
```

```dax
-- Počet prodejů (řádků)
Pocet Prodejů =
    COUNTROWS( Fact_Prodeje )
```

```dax
-- Počet unikátních zákazníků
Pocet Zakazniku =
    DISTINCTCOUNT( Fact_Prodeje[ZakaznikID] )
```

```dax
-- Celkové prodané množství
Celkove Mnozstvi =
    SUM( Fact_Prodeje[Mnozstvi] )
```

```dax
-- Průměrná hodnota transakce
Prumerna Transakce =
    DIVIDE( [Celkove Trzby], [Pocet Prodejů], 0 )
```

---

## Cíle a plnění

```dax
-- Celkový cíl (tržby)
Celkovy Cil =
    SUM( Fact_Cile[CilCzk] )
```

```dax
-- % plnění cíle
Plneni Cile Procent =
    DIVIDE( [Celkove Trzby], [Celkovy Cil], 0 )
```

```dax
-- Zbývá do cíle
Zbyva Do Cile =
    [Celkovy Cil] - [Celkove Trzby]
```

```dax
-- Stav plnění (text)
Stav Plneni =
    VAR Plneni = [Plneni Cile Procent]
    RETURN
        SWITCH(
            TRUE(),
            Plneni >= 1.0,  "✅ Splněno",
            Plneni >= 0.8,  "🟡 Blízko cíle",
            Plneni >= 0.5,  "🟠 Riziko",
            "🔴 Kritické"
        )
```

---

## Time Intelligence

> Tyto measures vyžadují správně nastavenou Date Table (viz Krok 4 v modelu).

```dax
-- Tržby YTD (Year-To-Date)
Trzby YTD =
    TOTALYTD( [Celkove Trzby], Dim_Datum[Datum] )
```

```dax
-- Tržby předchozí rok (stejné období)
Trzby PY =
    CALCULATE(
        [Celkove Trzby],
        SAMEPERIODLASTYEAR( Dim_Datum[Datum] )
    )
```

```dax
-- Meziroční změna (YoY)
YoY Zmena =
    [Celkove Trzby] - [Trzby PY]
```

```dax
-- YoY změna v %
YoY Zmena Procent =
    DIVIDE( [YoY Zmena], [Trzby PY], BLANK() )
```

```dax
-- Tržby předchozí měsíc
Trzby Predchozi Mesic =
    CALCULATE(
        [Celkove Trzby],
        DATEADD( Dim_Datum[Datum], -1, MONTH )
    )
```

---

## Podíl na celku (pro testování RLS)

```dax
-- Tržby celkem všech regionů (ignoruje filtr regionu)
Trzby Vsechny Regiony =
    CALCULATE(
        [Celkove Trzby],
        ALL( Dim_Region )
    )
```

```dax
-- % podíl regionu na celkových tržbách
Podil Na Celku =
    DIVIDE(
        [Celkove Trzby],
        CALCULATE( [Celkove Trzby], ALL( Dim_Region ) ),
        0
    )
```

> **Poznámka k RLS:** Toto measure zobrazí % z celku VŠECH dat.  
> Po zapnutí RLS uvidí uživatel jen svůj region. `ALL( Dim_Region )` v tomto  
> kontextu odstraní **filtr z reportu/sliceru**, ale RLS filtr je aplikován  
> na jiné úrovni a `ALL()` ho **neobejde**.  
> Chcete-li zobrazit % z celku dostupných dat (tzn. respektovat RLS), použijte `ALLSELECTED()`.

```dax
-- % podíl z dat viditelných uživateli (respektuje RLS)
Podil Z Viditelnych Dat =
    DIVIDE(
        [Celkove Trzby],
        CALCULATE( [Celkove Trzby], ALLSELECTED( Dim_Region ) ),
        0
    )
```

---

## RLS testovací measures

```dax
-- Zobrazí přihlášeného uživatele (pro ověření identity v RLS)
Aktualni Uzivatel =
    USERPRINCIPALNAME()
```

```dax
-- Zobrazí, ke kterým regionům má uživatel přístup
Dostupne Regiony =
    CONCATENATEX(
        VALUES( Dim_Region[Město] ),
        Dim_Region[Město],
        ", "
    )
```

```dax
-- Počet regionů viditelných uživatelem
Pocet Dostupnych Regionu =
    COUNTROWS( VALUES( Dim_Region ) )
```

---

## Formátování measures

Po vytvoření každého numerického measure nastavte formát v záložce **Measure tools**:

| Measure | Formát |
|---|---|
| Celkove Trzby | `#,##0 " Kč"` |
| Celkove Naklady | `#,##0 " Kč"` |
| Hrubý Zisk | `#,##0 " Kč"` |
| Marze Procent | `0.0%` |
| Plneni Cile Procent | `0.0%` |
| YoY Zmena Procent | `+0.0%;-0.0%` |
| Podil Na Celku | `0.0%` |
| Podil Z Viditelnych Dat | `0.0%` |
| Prumerna Transakce | `#,##0 " Kč"` |

---

**Measures jsou připraveny!** Pokračujte souborem `03_RLS_Nastaveni.md`.
