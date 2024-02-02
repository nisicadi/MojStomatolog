using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MojStomatolog.Database.Migrations
{
    public partial class SeedData : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Articles",
                columns: new[] { "ArticleId", "Content", "PublishDate", "Summary", "Title" },
                values: new object[,]
                {
                    { 1, "Redoviti posjeti stomatologu ključni su za očuvanje oralnog zdravlja. Stomatolog će pregledati vaše zube, desni i ukazati na potencijalne probleme prije nego što postanu ozbiljni.", new DateTime(2024, 2, 2, 18, 28, 56, 971, DateTimeKind.Local).AddTicks(2268), "Očuvanje oralnog zdravlja kroz redovite posjete stomatologu.", "Važnost Redovitih Pregleda Kod Stomatologa" },
                    { 2, "Pravilna tehnika četkanja zuba ključna je za sprječavanje karijesa i bolesti desni. Obratite pažnju na pritisak, kut četkanja i koristite kvalitetnu četkicu za zube.", new DateTime(2024, 2, 2, 18, 28, 56, 971, DateTimeKind.Local).AddTicks(2277), "Savjeti za postizanje savršene tehnike četkanja zuba.", "Pravilno Četkanje Zuba: Kako Postići Savršenu Tehniku" },
                    { 3, "Vaša ishrana igra ključnu ulogu u održavanju zdravlja vaših zuba. Ograničite unos šećera, konzumirajte mliječne proizvode i voće te pijte dovoljno vode za optimalnu oralnu hidrataciju.", new DateTime(2024, 2, 2, 18, 28, 56, 971, DateTimeKind.Local).AddTicks(2314), "Kako ishrana utječe na zdravlje zuba i desni.", "Zdrava Ishrana za Zdrave Zube" },
                    { 4, "Estetski zahvati poput izbjeljivanja zuba, keramičkih faseta i ortodontskih tretmana mogu poboljšati izgled vašeg osmijeha. Posavjetujte se sa stomatologom o opcijama prilagođenim vašim potrebama.", new DateTime(2024, 2, 2, 18, 28, 56, 971, DateTimeKind.Local).AddTicks(2328), "Pregled estetskih zahvata za ljepši osmijeh.", "Estetski Zahvati u Stomatologiji: Sve Što Trebate Znati" }
                });

            migrationBuilder.InsertData(
                table: "CompanySettings",
                columns: new[] { "SettingId", "SettingName", "SettingValue" },
                values: new object[] { 1, "WorkingHours", "08:30-18:00" });

            migrationBuilder.InsertData(
                table: "Employees",
                columns: new[] { "EmployeeId", "Email", "FirstName", "Gender", "LastName", "Number", "Specialization", "StartDate" },
                values: new object[,]
                {
                    { 1, "ahmedahmedic@mojstomatolog.ba", "Ahmed", "M", "Ahmedic", "123456789", "Stomatolog", new DateTime(2023, 3, 15, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 2, "lejlalejlic@mojstomatolog.ba", "Lejla", "F", "Lejlic", "987654321", "Asistent", new DateTime(2023, 6, 7, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 3, "adnanadnanic@mojstomatolog.ba", "Adnan", "M", "Adnanic", "555666777", "Higijeničar", new DateTime(2023, 1, 22, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 4, "aminaaminic@mojstomatolog.ba", "Amina", "F", "Aminic", "111222333", "Stomatolog", new DateTime(2023, 9, 10, 0, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 5, "harisharisic@mojstomatolog.ba", "Haris", "M", "Harisic", "444555666", "Asistent", new DateTime(2023, 12, 3, 0, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "Orders",
                columns: new[] { "Id", "OrderDate", "TotalAmount", "UserId" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 6, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 29.30m, 1 },
                    { 2, new DateTime(2023, 7, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 24.10m, 2 },
                    { 3, new DateTime(2023, 8, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 19.80m, 3 },
                    { 4, new DateTime(2023, 9, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 32.10m, 1 },
                    { 5, new DateTime(2023, 10, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 32.21m, 2 },
                    { 6, new DateTime(2023, 11, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), 24.80m, 3 },
                    { 7, new DateTime(2023, 12, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 15.95m, 1 },
                    { 8, new DateTime(2024, 1, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 27.10m, 2 },
                    { 9, new DateTime(2024, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 40.26m, 3 },
                    { 10, new DateTime(2023, 6, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 15.00m, 1 },
                    { 11, new DateTime(2023, 7, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 19.80m, 2 },
                    { 12, new DateTime(2023, 8, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 33.25m, 1 },
                    { 13, new DateTime(2023, 9, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 20.41m, 3 },
                    { 14, new DateTime(2023, 10, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), 23.10m, 2 },
                    { 15, new DateTime(2023, 11, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 28.45m, 1 }
                });

            migrationBuilder.InsertData(
                table: "ProductCategories",
                columns: new[] { "ProductCategoryId", "Name" },
                values: new object[,]
                {
                    { 1, "četkica za zube" },
                    { 2, "Pasta za zube" },
                    { 3, "Vodica za ispiranje usta" }
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "UserId", "Email", "FirstName", "Image", "LastName", "Number", "PasswordHash", "PasswordSalt", "Username" },
                values: new object[,]
                {
                    { 1, "mobiletest@mojstomatolog.ba", "Mobile", null, "Test", "123456789", "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=", "2irDvagQHwn9bhLo7RopCA==", "mobile" },
                    { 2, "adinisic@mojstomatolog.ba", "Adi", null, "Nišić", "987654321", "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=", "2irDvagQHwn9bhLo7RopCA==", "adinisic" },
                    { 3, "peroperic@mojstomatolog.ba", "Pero", null, "Peric", "111222333", "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=", "2irDvagQHwn9bhLo7RopCA==", "peroperic" },
                    { 4, "amaramaric@mojstomatolog.ba", "Amar", null, "Amaric", "555444333", "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=", "2irDvagQHwn9bhLo7RopCA==", "amaramaric" },
                    { 5, "aidaaidic@mojstomatolog.ba", "Aida", null, "Aidic", "999888777", "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=", "2irDvagQHwn9bhLo7RopCA==", "aidaaidic" },
                    { 6, "desktoptest@mojstomatolog.ba", "Desktop", null, "Test", "123789456", "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=", "2irDvagQHwn9bhLo7RopCA==", "desktop" }
                });

            migrationBuilder.InsertData(
                table: "Appointments",
                columns: new[] { "AppointmentId", "AppointmentDateTime", "IsConfirmed", "Notes", "PatientId", "Procedure" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 2, 2, 14, 30, 0, 0, DateTimeKind.Local), true, "", 1, "Skidanje kamenca" },
                    { 2, new DateTime(2024, 2, 3, 14, 30, 0, 0, DateTimeKind.Local), true, "", 1, "Pregled" },
                    { 3, new DateTime(2024, 2, 2, 11, 30, 0, 0, DateTimeKind.Local), true, "", 2, "Skidanje kamenca" },
                    { 4, new DateTime(2024, 2, 2, 10, 30, 0, 0, DateTimeKind.Local), true, "", 3, "Popravak zuba" },
                    { 5, new DateTime(2024, 2, 3, 11, 30, 0, 0, DateTimeKind.Local), true, "", 2, "Pregled" }
                });

            migrationBuilder.InsertData(
                table: "Products",
                columns: new[] { "ProductId", "Active", "Description", "ImageUrl", "Name", "Price", "ProductCategoryId" },
                values: new object[,]
                {
                    { 1, true, "Colgate 360 Max White medium četkica za zube, odlična je za čišćenje zuba, jezika, obraza i desni. Zahvaljujući jedinstvenim spiralnim vlaknima pomažu u izbjeljivanju zuba, uklanjanju površinskih mrlja i čišćenju čak i teško dostupnih mjesta. Osim toga, čistač jezika na stražnjoj strani četkice efikasno i nježno uklanja bakterije koje uzrokuju loš zadah. Obogatite oralnu higijenu uz Colgate 360 Max white četkicu za zube!", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699963147/products/pim/5900273125941_P1_BG/colgate-360-max-white-cetkica-za-zube-medium", "Colgate 360 Max White Medium", 7.5, 1 },
                    { 2, true, "Curaprox CS 1560 Soft četkica za zube sa finim Curen vlaknima pruža temeljno čišćenje zuba. Zahvaljujući posebno tankim vlaknima od 0,15 mm, četkica dopire do teško dostupnih međuzubnih prostora i sprječava nastanak naslaga, karijesa i umanjuje nastanak upale zubnog mesa. Zahvaljujući maloj kompaktnoj glavi i osmerostrukom držaču osigurava jednostavno rukovanje i kvalitetnije četkanje zuba. Curaprox CS 1560 Soft četkica za zube – vaše desni i zubi će vam biti zahvalni!", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699840608/products/pim/7612412156003-3069130/curaprox-soft-1560-cetkica-za-zube-vise-vrsta", "Curaprox CS 1560 Soft", 9.9000000000000004, 1 },
                    { 3, true, "Curaprox CS 5460 Ultra Soft četkica za zube sa finim Curen vlaknima pruža temeljno čišćenje zuba. Zahvaljujući posebno tankim vlaknima od 0,1 mm, četkica dopire do teško dostupnih međuzubnih prostora i sprječava nastanak naslaga, karijesa i umanjuje nastanak upale zubnog mesa. Zahvaljujući maloj kompaktnoj glavi i osmerostrukom držaču osigurava jednostavno rukovanje i kvalitetnije četkanje zuba. Curaprox CS 5460 Ultra Soft četkica za zube – vaše desni i zubi će vam biti zahvalni!", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699840603/products/pim/7612412423143-3059572/curaprox-ultra-soft-5460-cetkica-za-zube-vise-vrsta", "Curaprox Ultra Soft 5460", 9.9000000000000004, 1 },
                    { 4, true, "Sensodyne četkica za zube - medium, posebno je dizajnirana za osobe s osjetljivim desnima i zubima. Četkicu za zube odlikuje poseban i funkcionalan dizajn, jer sa mekim vanjskim vlaknima i zaobljenim unutrašnjim vlaknima nježno, ali učinkovito čisti zubnu caklinu, vaše desni i osjetljiva područja, a istovremeno temeljno uklanja zubne naslage. Praktična mala glava četkice dopire do teško dostupnih mjesta i omogućava temeljno čišćenje. Sensodyne četkica za zube - za savršenu oralnu njegu!", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700030477/products/pim/3830029296118-2367466/sensodyne-cetkica-za-zube-medium", "Sensodyne Medium", 7.1500000000000004, 1 },
                    { 5, true, "Elmex Ultra soft četkica za zube zahvaljujući specijalno dizajniranim svilenkastim vlaknima pruža nježno ali temeljno čišćenje zuba. Posebno oblikovana glava četkice za zube dopiru do teško dostupnih mjesta i međuzubnih prostora i tako sprječavaju nastanak naslaga i karijesa. Osim toga, svilenkasta vlakna četkice osim što temeljno čiste osiguravaju i ugodnu masažu desni. Elmex Ultra soft četkica za zube – za svršenu zubnu njegu.", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700286070/products/pim/8718951187658_SK/elmex-ultra-soft-cetkica-za-zube-vise-vrsta", "Elmex Ultra Soft", 7.6500000000000004, 1 },
                    { 6, true, "Colgate MaxFresh Cool Blue pasta za zube, s osvježavajućim kristalima, nježno uklanja nečistoće i štiti zube od karijesa, naslaga i stvaranja zubnog kamenca. Osim toga, ima efekat izbjeljivanja te će vaši zubi biti za nijansu bjelji već nakon prvog pranja. Svjež dah će trajati i do 10 puta duže. Obogatite svoju svakodnevnu oralnu higijenu uz Colgate MaxFresh Cool Blue pastu za zube!", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700279921/products/pim/8718951313576-2360918/colgate-max-fresh-pasta-za-zube-cooling-crystals", "Colgate Max Fresh", 3.6000000000000001, 2 },
                    { 7, true, "Aquafresh Triple Protection Fresh & Minty pasta za zube pruža trostruku zaštitu tokom 24h. Zahvaljujući formuli s fluoridom, pasta za zube efikasno čisti zube i štiti od karijesa i šećernih kiselina. Osim toga, osvježavajući okus mente dugotrajno osvježava i ostavlja svjež i ugodan dah. Redovnom upotrebom paste za zube jača se zubna caklina. Za zdrave zube i svjež dah uz Aquafresh Triple Protection Fresh & Minty pastu za zube.", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700026010/products/pim/5999518578062-2360828/aquafresh-triple-protection-pasta-za-zube-fresh-minty", "Aquafresh Triple Protection Fresh & Minty", 4.9500000000000002, 2 },
                    { 8, true, "Elmex Anti Caries pasta za zube, s antibakterijskim djelovanje, nježno uklanja nečistoće i štiti zube od karijesa, naslaga i stvaranja zubnog kamenca. Zahvaljujući abrazivnom sredstvu, izbjeljuje zube i zubne vratove, vraća prirodnu boju i stvara zaštitni sloj koji štiti osjetljive zube i desni. Osim toga, svjež dah traje duže. Obogatite svoju svakodnevnu oralnu higijenu uz Elmex Anti Caries pastu za zube!", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700315632/products/pim/8718951477575/elmex-anti-caries-pasta-za-zube", "Elmex Anti Caries", 8.5, 2 },
                    { 9, true, "Lacalut multi effect pasta za zube zahvaljujući aktivnim sastojcima osigurava idealnu zaštitu za sve zube. Hidroksiapatit i kalcij potiču remineralizaciju zubi i jačanje zubne cakline, zubi postaju glatkiji i otporniji. Fosfati sprječavaju stvaranje zubnog kamenca, rastvaraju naslage na zubima i ublažavaju mrlje. Kalcijev laktat i cink djeluju antibakterijski i antiseptički. Aluminijev laktat zateže i učvršćuje zubno meso te štiti od upale zubnog mesa izazvane bakterijama. Natrijev fluorid štiti od karijesa i potiče remineralizaciju zubi. Za zdrave desni i blistavo bijele zube - Lacalut multi effect pasta za zube!", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699845196/products/pim/SK_4016369546246_B_P2/lacalut-multi-effect-pasta-za-zube", "Lacalut multi effect", 6.96, 2 },
                    { 10, true, "Sensodyne Complete Protection pasta za zube, s antibakterijskim djelovanjem, nježno uklanja nečistoće i štiti zube od stvaranja naslaga i zubnog kamenca. Osim toga, smanjuje osjetljivost zuba na toplo i hladno. Zahvaljujući aktivnoj formuli vraća prirodnu bjelinu zuba već nakon prvog pranja. Pomaže u jačanju zubne cakline i pruža dugotrajan osjećaj svježine u ustima. Obogatite svoju svakodnevnu oralnu higijenu uz Sensodyne Complete Protection pastu za zube!", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699845113/products/pim/5054563119759_1/sensodyne-complete-protection-pasta-za-zube", "Sensodyne Complete Protection", 12.4, 2 },
                    { 11, true, "Listerine Total Care 6u1 antibakterijska vodica za ispiranje usta svojom efikasnom formulom sprječava nastanak zubnih naslaga i lošeg zadaha. Sa šesterostrukom zaštitom formulom bori se protiv bakterija, čak i na teško dostupnim mjestima u usnoj šupljini, gdje četkica za zube ne može doprijeti. Vodica za ispiranje usta pruža 12 sati zaštite od bakterija, jača caklinu, štiti od karijesa, smanjuje plak, štiti desni te osvježava dah. Listerine Total Care 6u1 antibakterijska vodica za ispiranje usta za blistavo bijele zube i intenzivno svjež dah!", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700277825/products/pim/3574660415506-2351437/listerine-total-care-antibakterijska-vodica-za-ispiranje-usta", "Listerine Total Care", 10.699999999999999, 3 },
                    { 12, true, "Parodontax Active Care vodica za ispiranje usta pomaže u održavanju svakodnevne oralne higijene usne šupljine. Osim toga, vodica za ispiranje usta je ne sadrži alkohol, osvježava dah i djeluje antibakterijski i do 12 sat. Redovnom primjenom uklanja plak između desni i zuba, pomaže u sprečavanju ponavljajućih problema s desnima, dok je istovremeno nježan za desni. Klinički dokazano. Za osjećaj trenutne svježine i čistoće - Parodontax Active Care vodica za ispiranje usta!", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700030464/products/pim/5054563052247-2367556/parodontax-active-care-vodica-za-ispiranje-usta", "Paradontax Active Care", 9.25, 3 },
                    { 13, true, "Lacalut Aktiv vodica za ispiranje usta pomaže u održavanju svakodnevne oralne higijene usne šupljine. Osim toga, vodica za ispiranje usta je ne sadrži alkohol, osvježava dah i djeluje antibakterijski i do 12 sat. Redovnom primjenom uklanja plak između desni i zuba, pomaže u sprečavanju ponavljajućih problema s desnima, dok je istovremeno nježan za desni. Klinički dokazano. Za osjećaj trenutne svježine i čistoće - Lacalut Aktiv vodica za ispiranje usta!", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700202061/products/pim/4016369726297-2403956/lacalut-aktiv-vodica-za-ispiranje-usta", "Lacalut Aktiv", 9.9499999999999993, 3 },
                    { 14, true, "Colgate Cool Mint vodica za usta, pružit će svjež dah i zaštiti od bakterija. Vodica za ispiranje usta sa okusom mente ukloniti će bakterije koje nije moguće u potpunosti ukoniti samo četkanjem. Spriječit će stvaranje zubnog kamenca i karijesa. Obogatite oralnu higijenu uz Colgate Cool Mint vodicu za usta.", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700273456/products/pim/8714789732671_cz/colgate-plax-vodica-za-ispiranje-usta-cool-mint", "Colgate Plax Cool Mint", 7.4000000000000004, 3 },
                    { 15, true, "Elmex Caries Protection vodica za usta, pružit će svjež dah i zaštiti od bakterija. Vodica za ispiranje uklonit će bakterije koje nije moguće u potpunosti odstraniti samo četkanjem. Spriječit će stvaranje zubnog kamenca i karijesa. Odlična je za osobe s ortodontskim aparatima i mostovima. Praktično pakovanje idealno je za putovanja ili situacije kada niste u prilici oprati zube. Obogatite oralnu higijenu uz Elmex Caries Protection vodicu za usta.", "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699839014/products/pim/7610108006878_SK/elmex-caries-protection-vodica-za-usta", "Elmex Caries Protection", 7.9500000000000002, 3 }
                });

            migrationBuilder.InsertData(
                table: "OrderItems",
                columns: new[] { "Id", "OrderId", "Price", "ProductId", "Quantity" },
                values: new object[,]
                {
                    { 1, 1, 7.50m, 1, 2 },
                    { 2, 1, 3.60m, 6, 1 },
                    { 3, 1, 10.70m, 11, 1 },
                    { 4, 2, 9.90m, 2, 1 },
                    { 5, 2, 4.95m, 7, 1 },
                    { 6, 2, 9.25m, 12, 1 },
                    { 7, 3, 9.90m, 3, 2 },
                    { 8, 4, 7.15m, 4, 1 },
                    { 9, 4, 8.50m, 8, 2 },
                    { 10, 4, 7.95m, 15, 1 },
                    { 11, 5, 7.65m, 5, 2 },
                    { 12, 5, 6.96m, 9, 1 },
                    { 13, 5, 9.95m, 13, 1 },
                    { 14, 6, 12.40m, 10, 2 },
                    { 15, 7, 7.40m, 14, 1 },
                    { 16, 7, 4.95m, 7, 1 },
                    { 17, 7, 3.60m, 6, 1 },
                    { 18, 8, 9.25m, 12, 1 },
                    { 19, 8, 9.90m, 3, 1 },
                    { 20, 8, 7.95m, 15, 1 },
                    { 21, 9, 12.40m, 10, 2 },
                    { 22, 9, 6.96m, 9, 1 },
                    { 23, 9, 8.50m, 8, 1 },
                    { 24, 10, 7.50m, 1, 2 },
                    { 25, 11, 9.90m, 2, 1 },
                    { 26, 11, 9.90m, 3, 1 },
                    { 27, 12, 7.15m, 4, 1 },
                    { 28, 12, 7.65m, 5, 2 },
                    { 29, 12, 3.60m, 6, 3 },
                    { 30, 13, 4.95m, 7, 1 },
                    { 31, 13, 8.50m, 8, 1 },
                    { 32, 13, 6.96m, 9, 1 },
                    { 33, 14, 12.40m, 10, 1 },
                    { 34, 14, 10.70m, 11, 1 },
                    { 35, 15, 9.25m, 12, 2 },
                    { 36, 15, 9.95m, 13, 1 }
                });

            migrationBuilder.InsertData(
                table: "Ratings",
                columns: new[] { "RatingId", "ProductId", "RatingValue", "UserId" },
                values: new object[,]
                {
                    { 1, 1, 4, 1 },
                    { 2, 2, 5, 1 },
                    { 3, 3, 3, 1 },
                    { 4, 5, 2, 1 },
                    { 5, 3, 4, 2 },
                    { 6, 5, 5, 2 }
                });

            migrationBuilder.InsertData(
                table: "Ratings",
                columns: new[] { "RatingId", "ProductId", "RatingValue", "UserId" },
                values: new object[,]
                {
                    { 7, 6, 5, 2 },
                    { 8, 10, 2, 2 },
                    { 9, 14, 4, 2 },
                    { 10, 7, 4, 3 },
                    { 11, 4, 4, 3 },
                    { 12, 13, 1, 3 },
                    { 13, 12, 5, 3 },
                    { 14, 12, 5, 3 }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Appointments",
                keyColumn: "AppointmentId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Articles",
                keyColumn: "ArticleId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "CompanySettings",
                keyColumn: "SettingId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Employees",
                keyColumn: "EmployeeId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Employees",
                keyColumn: "EmployeeId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Employees",
                keyColumn: "EmployeeId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Employees",
                keyColumn: "EmployeeId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Employees",
                keyColumn: "EmployeeId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 34);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 35);

            migrationBuilder.DeleteData(
                table: "OrderItems",
                keyColumn: "Id",
                keyValue: 36);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Ratings",
                keyColumn: "RatingId",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Products",
                keyColumn: "ProductId",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "UserId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "ProductCategories",
                keyColumn: "ProductCategoryId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "ProductCategories",
                keyColumn: "ProductCategoryId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "ProductCategories",
                keyColumn: "ProductCategoryId",
                keyValue: 3);
        }
    }
}
