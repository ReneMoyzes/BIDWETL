"""
RLS Lab – generátor CSV datových sad
Spusťte: python generate_data.py
Soubory se uloží do stejné složky jako tento skript.
"""
import csv, random, os
from datetime import date, timedelta

BASE = os.path.dirname(os.path.abspath(__file__))

random.seed(42)

# ─── helper ────────────────────────────────────────────────────────────────
def write_csv(filename, headers, rows):
    path = os.path.join(BASE, filename)
    with open(path, "w", newline="", encoding="utf-8-sig") as f:
        w = csv.writer(f, delimiter=";")
        w.writerow(headers)
        w.writerows(rows)
    print(f"  {filename}: {len(rows)} rows")

# ─── Dim_Region ────────────────────────────────────────────────────────────
regions = [
    (1, "Ostrava",  "Moravskoslezský"),
    (2, "Praha",    "Středočeský"),
    (3, "Brno",     "Jihomoravský"),
    (4, "Olomouc",  "Olomoucký"),
    (5, "Liberec",  "Liberecký"),
]
write_csv("Dim_Region.csv",
    ["RegionID", "Město", "Kraj"],
    regions)

# ─── Dim_Produkt ───────────────────────────────────────────────────────────
produkty_data = [
    (1,  "Notebook Pro 15",      "Elektronika", "Notebooky",    25900),
    (2,  "Notebook Air 13",      "Elektronika", "Notebooky",    18500),
    (3,  "Smartphone X12",       "Elektronika", "Telefony",     12900),
    (4,  "Smartphone Y8",        "Elektronika", "Telefony",      7990),
    (5,  "Monitor 27\" 4K",      "Elektronika", "Monitory",     15200),
    (6,  "Monitor 24\" FHD",     "Elektronika", "Monitory",      6800),
    (7,  "Tiskárna LaserJet",    "Příslušenství","Tiskárny",     4500),
    (8,  "Tiskárna InkJet",      "Příslušenství","Tiskárny",     1890),
    (9,  "Klávesnice MechPro",   "Příslušenství","Klávesnice",   2200),
    (10, "Myš ErgoPlus",         "Příslušenství","Myši",          890),
    (11, "Headset GamerX",       "Příslušenství","Audio",        1450),
    (12, "Webkamera HD",         "Příslušenství","Audio",         750),
    (13, "SSD 1TB",              "Komponenty",  "Úložiště",      2800),
    (14, "SSD 512GB",            "Komponenty",  "Úložiště",      1600),
    (15, "RAM 16GB DDR5",        "Komponenty",  "Paměť",         1200),
]
write_csv("Dim_Produkt.csv",
    ["ProduktID", "Název", "Kategorie", "Podkategorie", "CenaCzk"],
    produkty_data)

# ─── Dim_Zakaznik ──────────────────────────────────────────────────────────
jmena = ["Novák","Dvořák","Svoboda","Kučera","Pokorný",
         "Blažek","Horáček","Procházka","Veselý","Marek",
         "Fiala","Kratochvíl","Šimánek","Říha","Borůvka"]
krstni = ["Jan","Petr","Martin","Tomáš","Lukáš",
          "Eva","Jana","Lenka","Kateřina","Monika",
          "Pavel","Jiří","Ondřej","Michal","Radek"]
zak_rows = []
for i in range(1, 51):
    rid = random.randint(1, 5)
    zak_rows.append((
        i,
        random.choice(krstni),
        random.choice(jmena),
        f"zakaznik{i:02d}@example.cz",
        regions[rid-1][1],   # Město kopírováno z regionu
        rid,
        random.choice(["Fyzická osoba", "Firma"]),
        random.randint(18, 75),
    ))
write_csv("Dim_Zakaznik.csv",
    ["ZakaznikID","Jmeno","Prijmeni","Email","Mesto","RegionID","Typ","Vek"],
    zak_rows)

# ─── Dim_Zamestnanec ───────────────────────────────────────────────────────
# Každý region má 2 obchodní zástupce + 1 manažer + 1 ředitel
zam_rows = []
zid = 1
# Ředitel
zam_rows.append((zid, "Michal", "Ředitel", "reditel@firma.cz", None, 1, "Ředitel"))
zid += 1
for reg_id, mesto, _ in regions:
    # Manažer regionu
    zam_rows.append((zid, f"Manažer_{mesto}", "Vedoucí", f"manazer.{mesto.lower()}@firma.cz",
                     1, reg_id, "Manažer"))
    manazer_id = zid
    zid += 1
    # 2 obchodní zástupci
    for j in range(1, 3):
        zam_rows.append((zid, f"OZ_{mesto}_{j}", "Prodejce",
                         f"oz{j}.{mesto.lower()}@firma.cz",
                         manazer_id, reg_id, "Obchodní zástupce"))
        zid += 1
write_csv("Dim_Zamestnanec.csv",
    ["ZamestnanecID","Jmeno","Prijmeni","Email","NadrizenyID","RegionID","Pozice"],
    zam_rows)

# ─── Zabezpeceni_Uzivatele ─────────────────────────────────────────────────
# Mapování e-mail → přístup
sec_rows = []
for _, _, _, email, _, reg_id, _ in zam_rows[1:]:  # přeskočíme ředitele (vidí vše)
    sec_rows.append((email, reg_id, regions[reg_id-1][1]))
# Ředitel má záznam pro každý region (nebo použijeme speciální roli)
write_csv("Zabezpeceni_Uzivatele.csv",
    ["Email","RegionID","Region"],
    sec_rows)

# ─── Dim_Datum ─────────────────────────────────────────────────────────────
start = date(2022, 1, 1)
end   = date(2024, 12, 31)
dat_rows = []
d = start
while d <= end:
    ctvrtleti = (d.month - 1) // 3 + 1
    dat_rows.append((
        int(d.strftime("%Y%m%d")),
        d.strftime("%Y-%m-%d"),
        d.year,
        d.month,
        d.day,
        ctvrtleti,
        d.isocalendar()[1],
        ["Leden","Únor","Březen","Duben","Květen","Červen",
         "Červenec","Srpen","Září","Říjen","Listopad","Prosinec"][d.month-1],
        f"Q{ctvrtleti}",
        1 if d.weekday() < 5 else 0,
    ))
    d += timedelta(days=1)
write_csv("Dim_Datum.csv",
    ["DatumKey","Datum","Rok","Mesic","Den","Ctvrtleti",
     "TydenCislo","MesicNazev","CtvrtletiNazev","JePracovniDen"],
    dat_rows)

# ─── Fact_Prodeje ──────────────────────────────────────────────────────────
prod_rows = []
pid = 1
all_dates = [r[0] for r in dat_rows if r[9] == 1]  # jen pracovní dny
for _ in range(2000):
    reg_id  = random.randint(1, 5)
    # Vyber zákazníka ze stejného regionu
    zak_in_reg = [z[0] for z in zak_rows if z[5] == reg_id]
    zak_id  = random.choice(zak_in_reg)
    prod_id = random.randint(1, 15)
    cena    = produkty_data[prod_id-1][4]
    qty     = random.randint(1, 5)
    sleva   = random.choice([0, 0, 0, 0.05, 0.10, 0.15])
    datum_key = random.choice(all_dates)
    # Obchodní zástupce ze stejného regionu
    oz_in_reg = [z[0] for z in zam_rows if z[5] == reg_id and z[6] == "Obchodní zástupce"]
    zam_id  = random.choice(oz_in_reg) if oz_in_reg else 1
    celkem  = round(cena * qty * (1 - sleva), 2)
    nakupni = round(cena * 0.65, 2)
    prod_rows.append((
        pid, datum_key, zak_id, prod_id, reg_id, zam_id,
        qty, round(cena * (1 - sleva), 2), sleva,
        celkem, round(nakupni * qty, 2),
    ))
    pid += 1
write_csv("Fact_Prodeje.csv",
    ["ProdejID","DatumKey","ZakaznikID","ProduktID","RegionID","ZamestnanecID",
     "Mnozstvi","CenaPoSleve","Sleva","CelkemCzk","NakupniNakladyCzk"],
    prod_rows)

# ─── Fact_Cile ─────────────────────────────────────────────────────────────
cil_rows = []
cid = 1
for rok in [2022, 2023, 2024]:
    for mesic in range(1, 13):
        for reg_id, mesto, _ in regions:
            cil = random.randint(60000, 200000)
            cil_rows.append((cid, rok, mesic, reg_id, cil))
            cid += 1
write_csv("Fact_Cile.csv",
    ["CilID","Rok","Mesic","RegionID","CilCzk"],
    cil_rows)

print("\nVSE OK – všechny CSV soubory byly vytvořeny.")
