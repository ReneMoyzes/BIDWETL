# Lab: Row-Level Security v Power BI
## Část 4 – Testování a ověření RLS

---

## Jak testovat RLS v Power BI Desktop

### Metoda 1: View as Role

1. Záložka **Modeling → View as**
2. Zaškrtněte roli, kterou chcete testovat
3. Report nyní zobrazuje data **jako by jste byli v dané roli**
4. V horní části reportu se zobrazí žlutý banner: *"Now viewing as: [název role]"*
5. Pro vypnutí klikněte **Stop viewing**

### Metoda 2: View as Other User (simulace konkrétního uživatele)

1. Záložka **Modeling → View as**
2. Zaškrtněte **Other user**
3. Zadejte e-mail uživatele, např. `oz1.ostrava@firma.cz`
4. Zaškrtněte i roli, která se má aplikovat (např. `DynamicRLS_Region`)
5. Klikněte OK

> Tato metoda simuluje, co uvidí konkrétní uživatel po přihlášení.  
> `USERPRINCIPALNAME()` vrátí zadaný e-mail.

---

## Navrhnutý testovací report

Před testováním vytvořte jednoduchou stránku v reportu:

### Vizuály pro testování:

1. **Card** – measure `Aktualni Uzivatel`
2. **Card** – measure `Pocet Dostupnych Regionu`
3. **Card** – measure `Dostupne Regiony`
4. **Card** – measure `Celkove Trzby`
5. **Table** – sloupce: `Dim_Region[Město]`, `Celkove Trzby`, `Pocet Prodejů`
6. **Bar Chart** – osa X: `Dim_Region[Město]`, hodnota: `Celkove Trzby`

---

## Test A – Statické role

### Test A1: Role Ostrava_Static

**Akce:** Modeling → View as → Ostrava_Static

**Očekávaný výsledek:**

| Vizuál | Očekáváno |
|---|---|
| Dostupne Regiony | `Ostrava` |
| Pocet Dostupnych Regionu | `1` |
| Tabulka regionů | Pouze řádek **Ostrava** |
| Bar Chart | Pouze sloupec **Ostrava** |
| Celkove Trzby | ~⅕ celkových tržeb (jen Ostrava) |

**Ověřte:**
- [ ] Tabulka zobrazuje pouze Ostravu
- [ ] Graf zobrazuje pouze Ostravu
- [ ] Praha, Brno, Olomouc, Liberec nejsou viditelné

---

### Test A2: Role Sever_Static

**Akce:** Modeling → View as → Sever_Static

**Očekávaný výsledek:**

| Vizuál | Očekáváno |
|---|---|
| Dostupne Regiony | `Ostrava, Olomouc` nebo `Olomouc, Ostrava` |
| Pocet Dostupnych Regionu | `2` |
| Tabulka regionů | Pouze řádky **Ostrava** a **Olomouc** |

**Ověřte:**
- [ ] Přesně 2 regiony jsou viditelné
- [ ] Praha, Brno, Liberec nejsou viditelné

---

## Test B – Dynamické RLS

### Test B1: Obchodní zástupce Ostrava

**Akce:** Modeling → View as → Other user → `oz1.ostrava@firma.cz` + role `DynamicRLS_Region`

**Očekávaný výsledek:**

| Vizuál | Očekáváno |
|---|---|
| Aktualni Uzivatel | `oz1.ostrava@firma.cz` |
| Dostupne Regiony | `Ostrava` |
| Pocet Dostupnych Regionu | `1` |
| Tabulka regionů | Pouze **Ostrava** |

**Ověřte:**
- [ ] Measure `Aktualni Uzivatel` zobrazuje správný e-mail
- [ ] Pouze Ostrava je viditelná

---

### Test B2: Obchodní zástupce Praha

**Akce:** Modeling → View as → Other user → `oz1.praha@firma.cz` + role `DynamicRLS_Region`

**Očekávaný výsledek:**
- Pouze **Praha** viditelná
- Ostrava, Brno, Olomouc, Liberec skryté

**Ověřte:**
- [ ] Pouze Praha viditelná
- [ ] E-mail v Aktualni Uzivatel = `oz1.praha@firma.cz`

---

### Test B3: Manažer Brno

**Akce:** Modeling → View as → Other user → `manazer.brno@firma.cz` + role `DynamicRLS_Region`

**Očekávaný výsledek:**
- Pouze **Brno** viditelné
- (Manažer ve stejné roli jako OZ – vidí stejný region)

**Ověřte:**
- [ ] Pouze Brno viditelné
- [ ] E-mail správně zobrazen

---

## Test C – Hierarchické RLS

### Test C1: OZ v Hierarchické roli

**Akce:** Modeling → View as → Other user → `oz1.ostrava@firma.cz` + role `HierarchickyRLS`

**Očekávaný výsledek:** Pouze Ostrava (stejné jako dynamické RLS)

- [ ] Pouze Ostrava viditelná

---

### Test C2: Manažer v Hierarchické roli

**Akce:** Modeling → View as → Other user → `manazer.ostrava@firma.cz` + role `HierarchickyRLS`

**Očekávaný výsledek:**
- Manažer Ostrava patří do RegionID=1
- Vidí pouze **Ostrava**

- [ ] Pouze Ostrava viditelná
- [ ] E-mail správně zobrazen

---

## Test D – Management role

### Test D1: Management vidí vše

**Akce:** Modeling → View as → Management

**Očekávaný výsledek:**

| Vizuál | Očekáváno |
|---|---|
| Pocet Dostupnych Regionu | `5` |
| Dostupne Regiony | Všech 5 měst |
| Tabulka regionů | Všech 5 řádků |

**Ověřte:**
- [ ] Všech 5 regionů viditelných
- [ ] Tržby = celkové tržby celé firmy

---

## Test E – Ověření, že RLS nelze obejít přes ALL()

### Test E1: ALL() neobejde RLS

**Akce:** View as → Ostrava_Static

**Vizuál:** Přidejte Card s measure `Trzby Vsechny Regiony`

**Očekávaný výsledek:**  
`Trzby Vsechny Regiony` zobrazí **stejnou hodnotu** jako `Celkove Trzby`!

**Vysvětlení:**  
`ALL( Dim_Region )` odstraní filtry z reportu/slicerů, ale **RLS filtr je aplikován na engine úrovni** a `ALL()` ho neodstraní.

**Ověřte:**
- [ ] `Trzby Vsechny Regiony` = `Celkove Trzby` v roli Ostrava_Static
- [ ] Uživatel nevidí tržby jiných regionů ani přes ALL()

---

## Test F – ALLSELECTED() vs ALL()

### Test F1: Podíly s ALLSELECTED

**Akce:** View as → Ostrava_Static

**Přidejte vizuál:** Tabulka s `Dim_Region[Město]`, `Celkove Trzby`, `Podil Na Celku`, `Podil Z Viditelnych Dat`

**Očekávaný výsledek:**

| Město | Celkove Trzby | Podil Na Celku | Podil Z Viditelnych Dat |
|---|---|---|---|
| Ostrava | X Kč | 100% | 100% |

**Vysvětlení:**
- `Podil Na Celku` používá `ALL( Dim_Region )` → jmenovatel = tržby dostupné v RLS kontextu = jen Ostrava → 100%
- `Podil Z Viditelnych Dat` používá `ALLSELECTED()` → stejný výsledek v tomto kontextu

**Ověřte:**
- [ ] Oba podíly zobrazují 100% pro Ostravu v Ostrava_Static roli

---

## Test G – Kombinovaná role

### Test G1: Uživatel v více rolích najednou

**Akce:** Modeling → View as → zaškrtněte VÍCE rolí najednou (`Ostrava_Static` + `Praha_Static`)

**Očekávaný výsledek:**
- Uživatel vidí **Ostravu I Prahu** (sjednocení rolí)

**Ověřte:**
- [ ] Pocet Dostupnych Regionu = `2`
- [ ] Viditelné: Ostrava, Praha
- [ ] Skryté: Brno, Olomouc, Liberec

**Vysvětlení:**  
Když je uživatel přiřazen do více rolí, Power BI aplikuje **OR** logiku – vidí data ze všech rolí.

---

## Výsledková tabulka testů

| Test | Role | Email | Očekávaný počet regionů | Splněno? |
|---|---|---|---|---|
| A1 | Ostrava_Static | – | 1 | ☐ |
| A2 | Sever_Static | – | 2 | ☐ |
| B1 | DynamicRLS_Region | oz1.ostrava@firma.cz | 1 | ☐ |
| B2 | DynamicRLS_Region | oz1.praha@firma.cz | 1 | ☐ |
| B3 | DynamicRLS_Region | manazer.brno@firma.cz | 1 | ☐ |
| C1 | HierarchickyRLS | oz1.ostrava@firma.cz | 1 | ☐ |
| C2 | HierarchickyRLS | manazer.ostrava@firma.cz | 1 | ☐ |
| D1 | Management | – | 5 | ☐ |
| E1 | Ostrava_Static | – | ALL() = RLS (neobejde) | ☐ |
| G1 | Ostrava_Static + Praha_Static | – | 2 | ☐ |

---

**Testy jsou hotové!** Přejděte na `05_Power_BI_Service_RLS.md` pro nastavení v cloudu.
