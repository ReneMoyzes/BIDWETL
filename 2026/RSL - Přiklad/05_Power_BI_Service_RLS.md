# Lab: Row-Level Security v Power BI
## Část 5 – RLS v Power BI Service (Cloud)

---

## Publikování reportu

1. V Power BI Desktop klikněte **File → Publish → Publish to Power BI**
2. Přihlaste se svým účtem Microsoft / školním účtem
3. Vyberte workspace (např. "BI Lab" nebo "My Workspace")
4. Počkejte na dokončení publikace
5. Klikněte odkaz pro otevření reportu v Service

---

## Přiřazení uživatelů k rolím v Service

Po publikování **RLS role existují, ale nemají přiřazené uživatele**.  
Přiřazení se provádí na datasetu (sémantickém modelu):

1. Přejděte do workspacu v Power BI Service
2. Najděte **Dataset** (sémantický model) – stejný název jako PBIX soubor
3. Klikněte na tři tečky (...) u datasetu → **Security**
4. Zobrazí se stránka "Row-Level Security"

### Přiřazení uživatelů k rolím:

| Role | Přiřadit uživatele / skupinu |
|---|---|
| `Ostrava_Static` | Uživatelé odpovědní za Ostravu |
| `Praha_Static` | Uživatelé odpovědní za Prahu |
| `DynamicRLS_Region` | **Všichni** obchodní zástupci a manažeři |
| `HierarchickyRLS` | Alternativa k DynamicRLS_Region |
| `Management` | Vedení firmy (ředitel, CFO apod.) |

### Jak přidat uživatele:

1. Klikněte na název role
2. Do textového pole zadejte e-mail nebo skupinu Azure AD
3. Klikněte **Add**
4. Klikněte **Save**

> **Tip pro lab:** Pokud nemáte více účtů, přiřaďte svůj vlastní účet k různým rolím a testujte „Test as role".

---

## Testování v Power BI Service

### Test as Role

1. Dataset → Security → klikněte na název role → **Test as role**
2. Service zobrazí report jako daná role
3. V horní liště vidíte: *"Now viewing as [Role name]"*

### Test as Other User (pro admin/owner)

1. Dataset → Security
2. Klikněte **Test as role**
3. Zaškrtněte **Specific user**
4. Zadejte e-mail uživatele přiřazeného k roli

---

## Důležité poznámky k Service

### Kdo vidí vše (bez ohledu na RLS):

- **Workspace Admin** – vždy vidí vše
- **Workspace Member s právy Build** – vidí vše
- **Dataset Owner** – vidí vše
- Uživatel s přímou URL na PBIX export – viz níže

> **Doporučení:** Uživatelé, kteří mají podléhat RLS, by měli mít pouze roli **Viewer** ve workspace.

### Import mode vs Direct Query

| Typ | RLS chování |
|---|---|
| **Import mode** | RLS filtry aplikuje Power BI engine na importovaná data |
| **DirectQuery** | RLS filtry se přeloží na SQL WHERE klauzuli odeslanou do databáze |
| **Live Connection** | RLS definujete přímo na SSAS / Azure AS serveru (ne v Power BI) |
| **Composite Model** | RLS musí být nastaven na obou vrstvách (Import + DQ) zvlášť |

---

## Audit a monitoring přístupů

Power BI loguje přístupy do **Unified Audit Log** v Microsoft 365.

### Jak zobrazit audit logy:

1. Přejděte na `admin.microsoft.com` → Security & Compliance
2. Nebo použijte Power BI Admin Portal (admin.powerbi.com)
3. Admin Portal → Audit logs

### Sledované události:

| Událost | Popis |
|---|---|
| `ViewReport` | Uživatel zobrazil report |
| `ExportReport` | Uživatel exportoval data |
| `GetSnapshot` | Vizuál byl renderován (interakce) |
| `AnalyzeInExcel` | Uživatel otevřel v Excelu |

---

## Časté problémy a řešení

| Problém | Příčina | Řešení |
|---|---|---|
| Uživatel vidí prázdný report | Role nemá přiřazena žádná data pro daného uživatele (e-mail nenalezen v bezpečnostní tabulce) | Zkontrolujte `Zabezpeceni_Uzivatele.csv` – přidejte e-mail |
| Measure `Aktualni Uzivatel` vrací prázdnou hodnotu | USERPRINCIPALNAME() nefunguje při testování v Desktop bez zadání "Other user" | Použijte View as → Other user a zadejte e-mail |
| Všichni vidí vše | Uživatel má roli Admin/Member v workspace | Změňte roli na Viewer + přiřaďte k RLS roli |
| RLS nefunguje v DirectQuery | Chybí pass-through autentizace | Nastavte SSO (Single Sign-On) nebo nastavte RLS v zdrojové DB |
| `USERPRINCIPALNAME()` vs `USERNAME()` | USERNAME() vrací `DOMÉNA\jméno` – nefunguje v Service | V Power BI Service vždy USERPRINCIPALNAME() |
| Tržby se zdají být nulové | Bezpečnostní tabulka má odlišný formát e-mailu (velká/malá písmena) | DAX porovnání e-mailů je case-insensitive, ale ověřte překlepy |
