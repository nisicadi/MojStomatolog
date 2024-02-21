using Microsoft.EntityFrameworkCore;
using MojStomatolog.Models.Core;

namespace MojStomatolog.Database;

public partial class MojStomatologContext
{
    partial void OnModelCreatingPartial(ModelBuilder modelBuilder)
    {
        #region ProductCategory

        modelBuilder.Entity<ProductCategory>().HasData(new ProductCategory
        {
            ProductCategoryId = 1,
            Name = "Četkica za zube"
        });
        modelBuilder.Entity<ProductCategory>().HasData(new ProductCategory
        {
            ProductCategoryId = 2,
            Name = "Pasta za zube"
        });
        modelBuilder.Entity<ProductCategory>().HasData(new ProductCategory
        {
            ProductCategoryId = 3,
            Name = "Vodica za ispiranje usta"
        });

        #endregion

        #region Service

        modelBuilder.Entity<Service>().HasData(new Service
        {
            Id = 1,
            Name = "Liječenje karijesa"
        });
        modelBuilder.Entity<Service>().HasData(new Service
        {
            Id = 2,
            Name = "Parodontologija"
        });
        modelBuilder.Entity<Service>().HasData(new Service
        {
            Id = 3,
            Name = "Protetika"
        });
        modelBuilder.Entity<Service>().HasData(new Service
        {
            Id = 4,
            Name = "Pregled"
        });
        modelBuilder.Entity<Service>().HasData(new Service
        {
            Id = 5,
            Name = "Preventivna stomatologija"
        });

        #endregion

        #region Product

        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 1,
            Name = "Colgate 360 Max White Medium",
            Active = true, ProductCategoryId = 1,
            Description =
                "Colgate 360 Max White medium četkica za zube, odlična je za čišćenje zuba, jezika, obraza i desni. Zahvaljujući jedinstvenim spiralnim vlaknima pomažu u izbjeljivanju zuba, uklanjanju površinskih mrlja i čišćenju čak i teško dostupnih mjesta. Osim toga, čistač jezika na stražnjoj strani četkice efikasno i nježno uklanja bakterije koje uzrokuju loš zadah. Obogatite oralnu higijenu uz Colgate 360 Max white četkicu za zube!",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699963147/products/pim/5900273125941_P1_BG/colgate-360-max-white-cetkica-za-zube-medium",
            Price = 7.50
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 2,
            Name = "Curaprox CS 1560 Soft",
            Active = true,
            ProductCategoryId = 1,
            Description =
                "Curaprox CS 1560 Soft četkica za zube sa finim Curen vlaknima pruža temeljno čišćenje zuba. Zahvaljujući posebno tankim vlaknima od 0,15 mm, četkica dopire do teško dostupnih međuzubnih prostora i sprječava nastanak naslaga, karijesa i umanjuje nastanak upale zubnog mesa. Zahvaljujući maloj kompaktnoj glavi i osmerostrukom držaču osigurava jednostavno rukovanje i kvalitetnije četkanje zuba. Curaprox CS 1560 Soft četkica za zube – vaše desni i zubi će vam biti zahvalni!",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699840608/products/pim/7612412156003-3069130/curaprox-soft-1560-cetkica-za-zube-vise-vrsta",
            Price = 9.90
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 3,
            Name = "Curaprox Ultra Soft 5460",
            Active = true,
            ProductCategoryId = 1,
            Description =
                "Curaprox CS 5460 Ultra Soft četkica za zube sa finim Curen vlaknima pruža temeljno čišćenje zuba. Zahvaljujući posebno tankim vlaknima od 0,1 mm, četkica dopire do teško dostupnih međuzubnih prostora i sprječava nastanak naslaga, karijesa i umanjuje nastanak upale zubnog mesa. Zahvaljujući maloj kompaktnoj glavi i osmerostrukom držaču osigurava jednostavno rukovanje i kvalitetnije četkanje zuba. Curaprox CS 5460 Ultra Soft četkica za zube – vaše desni i zubi će vam biti zahvalni!",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699840603/products/pim/7612412423143-3059572/curaprox-ultra-soft-5460-cetkica-za-zube-vise-vrsta",
            Price = 9.90
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 4,
            Name = "Sensodyne Medium",
            Active = true,
            ProductCategoryId = 1,
            Description =
                "Sensodyne četkica za zube - medium, posebno je dizajnirana za osobe s osjetljivim desnima i zubima. Četkicu za zube odlikuje poseban i funkcionalan dizajn, jer sa mekim vanjskim vlaknima i zaobljenim unutrašnjim vlaknima nježno, ali učinkovito čisti zubnu caklinu, vaše desni i osjetljiva područja, a istovremeno temeljno uklanja zubne naslage. Praktična mala glava četkice dopire do teško dostupnih mjesta i omogućava temeljno čišćenje. Sensodyne četkica za zube - za savršenu oralnu njegu!",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700030477/products/pim/3830029296118-2367466/sensodyne-cetkica-za-zube-medium",
            Price = 7.15
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 5,
            Name = "Elmex Ultra Soft",
            Active = true,
            ProductCategoryId = 1,
            Description =
                "Elmex Ultra soft četkica za zube zahvaljujući specijalno dizajniranim svilenkastim vlaknima pruža nježno ali temeljno čišćenje zuba. Posebno oblikovana glava četkice za zube dopiru do teško dostupnih mjesta i međuzubnih prostora i tako sprječavaju nastanak naslaga i karijesa. Osim toga, svilenkasta vlakna četkice osim što temeljno čiste osiguravaju i ugodnu masažu desni. Elmex Ultra soft četkica za zube – za svršenu zubnu njegu.",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700286070/products/pim/8718951187658_SK/elmex-ultra-soft-cetkica-za-zube-vise-vrsta",
            Price = 7.65
        });

        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 6,
            Name = "Colgate Max Fresh",
            Active = true,
            ProductCategoryId = 2,
            Description =
                "Colgate MaxFresh Cool Blue pasta za zube, s osvježavajućim kristalima, nježno uklanja nečistoće i štiti zube od karijesa, naslaga i stvaranja zubnog kamenca. Osim toga, ima efekat izbjeljivanja te će vaši zubi biti za nijansu bjelji već nakon prvog pranja. Svjež dah će trajati i do 10 puta duže. Obogatite svoju svakodnevnu oralnu higijenu uz Colgate MaxFresh Cool Blue pastu za zube!",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700279921/products/pim/8718951313576-2360918/colgate-max-fresh-pasta-za-zube-cooling-crystals",
            Price = 3.60
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 7,
            Name = "Aquafresh Triple Protection Fresh & Minty",
            Active = true,
            ProductCategoryId = 2,
            Description =
                "Aquafresh Triple Protection Fresh & Minty pasta za zube pruža trostruku zaštitu tokom 24h. Zahvaljujući formuli s fluoridom, pasta za zube efikasno čisti zube i štiti od karijesa i šećernih kiselina. Osim toga, osvježavajući okus mente dugotrajno osvježava i ostavlja svjež i ugodan dah. Redovnom upotrebom paste za zube jača se zubna caklina. Za zdrave zube i svjež dah uz Aquafresh Triple Protection Fresh & Minty pastu za zube.",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700026010/products/pim/5999518578062-2360828/aquafresh-triple-protection-pasta-za-zube-fresh-minty",
            Price = 4.95
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 8,
            Name = "Elmex Anti Caries",
            Active = true,
            ProductCategoryId = 2,
            Description =
                "Elmex Anti Caries pasta za zube, s antibakterijskim djelovanje, nježno uklanja nečistoće i štiti zube od karijesa, naslaga i stvaranja zubnog kamenca. Zahvaljujući abrazivnom sredstvu, izbjeljuje zube i zubne vratove, vraća prirodnu boju i stvara zaštitni sloj koji štiti osjetljive zube i desni. Osim toga, svjež dah traje duže. Obogatite svoju svakodnevnu oralnu higijenu uz Elmex Anti Caries pastu za zube!",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700315632/products/pim/8718951477575/elmex-anti-caries-pasta-za-zube",
            Price = 8.50
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 9,
            Name = "Lacalut multi effect",
            Active = true,
            ProductCategoryId = 2,
            Description =
                "Lacalut multi effect pasta za zube zahvaljujući aktivnim sastojcima osigurava idealnu zaštitu za sve zube. Hidroksiapatit i kalcij potiču remineralizaciju zubi i jačanje zubne cakline, zubi postaju glatkiji i otporniji. Fosfati sprječavaju stvaranje zubnog kamenca, rastvaraju naslage na zubima i ublažavaju mrlje. Kalcijev laktat i cink djeluju antibakterijski i antiseptički. Aluminijev laktat zateže i učvršćuje zubno meso te štiti od upale zubnog mesa izazvane bakterijama. Natrijev fluorid štiti od karijesa i potiče remineralizaciju zubi. Za zdrave desni i blistavo bijele zube - Lacalut multi effect pasta za zube!",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699845196/products/pim/SK_4016369546246_B_P2/lacalut-multi-effect-pasta-za-zube",
            Price = 6.96
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 10,
            Name = "Sensodyne Complete Protection",
            Active = true,
            ProductCategoryId = 2,
            Description =
                "Sensodyne Complete Protection pasta za zube, s antibakterijskim djelovanjem, nježno uklanja nečistoće i štiti zube od stvaranja naslaga i zubnog kamenca. Osim toga, smanjuje osjetljivost zuba na toplo i hladno. Zahvaljujući aktivnoj formuli vraća prirodnu bjelinu zuba već nakon prvog pranja. Pomaže u jačanju zubne cakline i pruža dugotrajan osjećaj svježine u ustima. Obogatite svoju svakodnevnu oralnu higijenu uz Sensodyne Complete Protection pastu za zube!",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699845113/products/pim/5054563119759_1/sensodyne-complete-protection-pasta-za-zube",
            Price = 12.40
        });

        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 11,
            Name = "Listerine Total Care",
            Active = true,
            ProductCategoryId = 3,
            Description =
                "Listerine Total Care 6u1 antibakterijska vodica za ispiranje usta svojom efikasnom formulom sprječava nastanak zubnih naslaga i lošeg zadaha. Sa šesterostrukom zaštitom formulom bori se protiv bakterija, čak i na teško dostupnim mjestima u usnoj šupljini, gdje četkica za zube ne može doprijeti. Vodica za ispiranje usta pruža 12 sati zaštite od bakterija, jača caklinu, štiti od karijesa, smanjuje plak, štiti desni te osvježava dah. Listerine Total Care 6u1 antibakterijska vodica za ispiranje usta za blistavo bijele zube i intenzivno svjež dah!",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700277825/products/pim/3574660415506-2351437/listerine-total-care-antibakterijska-vodica-za-ispiranje-usta",
            Price = 10.70
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 12,
            Name = "Paradontax Active Care",
            Active = true,
            ProductCategoryId = 3,
            Description =
                "Parodontax Active Care vodica za ispiranje usta pomaže u održavanju svakodnevne oralne higijene usne šupljine. Osim toga, vodica za ispiranje usta je ne sadrži alkohol, osvježava dah i djeluje antibakterijski i do 12 sat. Redovnom primjenom uklanja plak između desni i zuba, pomaže u sprečavanju ponavljajućih problema s desnima, dok je istovremeno nježan za desni. Klinički dokazano. Za osjećaj trenutne svježine i čistoće - Parodontax Active Care vodica za ispiranje usta!",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700030464/products/pim/5054563052247-2367556/parodontax-active-care-vodica-za-ispiranje-usta",
            Price = 9.25
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 13,
            Name = "Lacalut Aktiv",
            Active = true,
            ProductCategoryId = 3,
            Description =
                "Lacalut Aktiv vodica za ispiranje usta pomaže u održavanju svakodnevne oralne higijene usne šupljine. Osim toga, vodica za ispiranje usta je ne sadrži alkohol, osvježava dah i djeluje antibakterijski i do 12 sat. Redovnom primjenom uklanja plak između desni i zuba, pomaže u sprečavanju ponavljajućih problema s desnima, dok je istovremeno nježan za desni. Klinički dokazano. Za osjećaj trenutne svježine i čistoće - Lacalut Aktiv vodica za ispiranje usta!",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700202061/products/pim/4016369726297-2403956/lacalut-aktiv-vodica-za-ispiranje-usta",
            Price = 9.95
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 14,
            Name = "Colgate Plax Cool Mint",
            Active = true,
            ProductCategoryId = 3,
            Description =
                "Colgate Cool Mint vodica za usta, pružit će svjež dah i zaštiti od bakterija. Vodica za ispiranje usta sa okusom mente ukloniti će bakterije koje nije moguće u potpunosti ukoniti samo četkanjem. Spriječit će stvaranje zubnog kamenca i karijesa. Obogatite oralnu higijenu uz Colgate Cool Mint vodicu za usta.",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1700273456/products/pim/8714789732671_cz/colgate-plax-vodica-za-ispiranje-usta-cool-mint",
            Price = 7.40
        });
        modelBuilder.Entity<Product>().HasData(new Product
        {
            ProductId = 15,
            Name = "Elmex Caries Protection",
            Active = true,
            ProductCategoryId = 3,
            Description =
                "Elmex Caries Protection vodica za usta, pružit će svjež dah i zaštiti od bakterija. Vodica za ispiranje uklonit će bakterije koje nije moguće u potpunosti odstraniti samo četkanjem. Spriječit će stvaranje zubnog kamenca i karijesa. Odlična je za osobe s ortodontskim aparatima i mostovima. Praktično pakovanje idealno je za putovanja ili situacije kada niste u prilici oprati zube. Obogatite oralnu higijenu uz Elmex Caries Protection vodicu za usta.",
            ImageUrl =
                "https://media.dm-static.com/images/f_auto,q_auto,c_fit,h_440,w_500/v1699839014/products/pim/7610108006878_SK/elmex-caries-protection-vodica-za-usta",
            Price = 7.95
        });

        #endregion

        #region Order

        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 1,
            UserId = 1,
            OrderDate = new DateTime(2023, 06, 15),
            TotalAmount = 29.30M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 2,
            UserId = 2,
            OrderDate = new DateTime(2023, 07, 10),
            TotalAmount = 24.10M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 3,
            UserId = 3,
            OrderDate = new DateTime(2023, 08, 05),
            TotalAmount = 19.80M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 4,
            UserId = 1,
            OrderDate = new DateTime(2023, 09, 20),
            TotalAmount = 32.10M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 5,
            UserId = 2,
            OrderDate = new DateTime(2023, 10, 25),
            TotalAmount = 32.21M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 6,
            UserId = 3,
            OrderDate = new DateTime(2023, 11, 30),
            TotalAmount = 24.80M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 7,
            UserId = 1,
            OrderDate = new DateTime(2023, 12, 15),
            TotalAmount = 15.95M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 8,
            UserId = 2,
            OrderDate = new DateTime(2024, 01, 05),
            TotalAmount = 27.10M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 9,
            UserId = 3,
            OrderDate = new DateTime(2024, 02, 01),
            TotalAmount = 40.26M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 10,
            UserId = 1,
            OrderDate = new DateTime(2023, 06, 25),
            TotalAmount = 15.00M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 11,
            UserId = 2,
            OrderDate = new DateTime(2023, 07, 15),
            TotalAmount = 19.80M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 12,
            UserId = 1,
            OrderDate = new DateTime(2023, 08, 10),
            TotalAmount = 33.25M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 13,
            UserId = 3,
            OrderDate = new DateTime(2023, 09, 05),
            TotalAmount = 20.41M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 14,
            UserId = 2,
            OrderDate = new DateTime(2023, 10, 30),
            TotalAmount = 23.10M,
            Status = 2
        });
        modelBuilder.Entity<Order>().HasData(new Order
        {
            Id = 15,
            UserId = 1,
            OrderDate = new DateTime(2023, 11, 25),
            TotalAmount = 28.45M,
            Status = 2
        });

        #endregion

        #region OrderItem

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 1,
            OrderId = 1,
            ProductId = 1,
            Quantity = 2,
            Price = 7.50M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 2,
            OrderId = 1,
            ProductId = 6,
            Quantity = 1,
            Price = 3.60M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 3,
            OrderId = 1,
            ProductId = 11,
            Quantity = 1,
            Price = 10.70M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 4,
            OrderId = 2,
            ProductId = 2,
            Quantity = 1,
            Price = 9.90M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 5,
            OrderId = 2,
            ProductId = 7,
            Quantity = 1,
            Price = 4.95M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 6,
            OrderId = 2,
            ProductId = 12,
            Quantity = 1,
            Price = 9.25M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 7,
            OrderId = 3,
            ProductId = 3,
            Quantity = 2,
            Price = 9.90M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 8,
            OrderId = 4,
            ProductId = 4,
            Quantity = 1,
            Price = 7.15M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 9,
            OrderId = 4,
            ProductId = 8,
            Quantity = 2,
            Price = 8.50M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 10,
            OrderId = 4,
            ProductId = 15,
            Quantity = 1,
            Price = 7.95M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 11,
            OrderId = 5,
            ProductId = 5,
            Quantity = 2,
            Price = 7.65M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 12,
            OrderId = 5,
            ProductId = 9,
            Quantity = 1,
            Price = 6.96M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 13,
            OrderId = 5,
            ProductId = 13,
            Quantity = 1,
            Price = 9.95M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 14,
            OrderId = 6,
            ProductId = 10,
            Quantity = 2,
            Price = 12.40M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 15,
            OrderId = 7,
            ProductId = 14,
            Quantity = 1,
            Price = 7.40M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 16,
            OrderId = 7,
            ProductId = 7,
            Quantity = 1,
            Price = 4.95M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 17,
            OrderId = 7,
            ProductId = 6,
            Quantity = 1,
            Price = 3.60M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 18,
            OrderId = 8,
            ProductId = 12,
            Quantity = 1,
            Price = 9.25M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 19,
            OrderId = 8,
            ProductId = 3,
            Quantity = 1,
            Price = 9.90M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 20,
            OrderId = 8,
            ProductId = 15,
            Quantity = 1,
            Price = 7.95M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 21,
            OrderId = 9,
            ProductId = 10,
            Quantity = 2,
            Price = 12.40M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 22,
            OrderId = 9,
            ProductId = 9,
            Quantity = 1,
            Price = 6.96M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 23,
            OrderId = 9,
            ProductId = 8,
            Quantity = 1,
            Price = 8.50M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 24,
            OrderId = 10,
            ProductId = 1,
            Quantity = 2,
            Price = 7.50M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 25,
            OrderId = 11,
            ProductId = 2,
            Quantity = 1,
            Price = 9.90M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 26,
            OrderId = 11,
            ProductId = 3,
            Quantity = 1,
            Price = 9.90M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 27,
            OrderId = 12,
            ProductId = 4,
            Quantity = 1,
            Price = 7.15M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 28,
            OrderId = 12,
            ProductId = 5,
            Quantity = 2,
            Price = 7.65M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 29,
            OrderId = 12,
            ProductId = 6,
            Quantity = 3,
            Price = 3.60M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 30,
            OrderId = 13,
            ProductId = 7,
            Quantity = 1,
            Price = 4.95M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 31,
            OrderId = 13,
            ProductId = 8,
            Quantity = 1,
            Price = 8.50M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 32,
            OrderId = 13,
            ProductId = 9,
            Quantity = 1,
            Price = 6.96M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 33,
            OrderId = 14,
            ProductId = 10,
            Quantity = 1,
            Price = 12.40M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 34,
            OrderId = 14,
            ProductId = 11,
            Quantity = 1,
            Price = 10.70M
        });

        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 35,
            OrderId = 15,
            ProductId = 12,
            Quantity = 2,
            Price = 9.25M
        });
        modelBuilder.Entity<OrderItem>().HasData(new OrderItem
        {
            Id = 36,
            OrderId = 15,
            ProductId = 13,
            Quantity = 1,
            Price = 9.95M
        });
        
        #endregion
        
        #region Rating

        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 1, UserId = 1, ProductId = 1, RatingValue = 4 });
        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 2, UserId = 1, ProductId = 2, RatingValue = 5 });
        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 3, UserId = 1, ProductId = 3, RatingValue = 3 });
        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 4, UserId = 1, ProductId = 5, RatingValue = 2 });

        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 5, UserId = 2, ProductId = 3, RatingValue = 4 });
        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 6, UserId = 2, ProductId = 5, RatingValue = 5 });
        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 7, UserId = 2, ProductId = 6, RatingValue = 5 });
        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 8, UserId = 2, ProductId = 10, RatingValue = 2 });
        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 9, UserId = 2, ProductId = 14, RatingValue = 4 });

        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 10, UserId = 3, ProductId = 7, RatingValue = 4 });
        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 11, UserId = 3, ProductId = 4, RatingValue = 4 });
        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 12, UserId = 3, ProductId = 13, RatingValue = 1 });
        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 13, UserId = 3, ProductId = 12, RatingValue = 5 });
        modelBuilder.Entity<Rating>().HasData(new Rating { RatingId = 14, UserId = 3, ProductId = 12, RatingValue = 5 });

        #endregion

        #region CompanySettings

        modelBuilder.Entity<CompanySetting>().HasData(new CompanySetting
        {
            SettingId = 1,
            SettingName = "WorkingHours",
            SettingValue = "08:30-18:00"
        });

        #endregion

        #region Article

        modelBuilder.Entity<Article>().HasData(new Article
        {
            ArticleId = 1,
            Title = "Važnost Redovitih Pregleda Kod Stomatologa",
            Content =
                "Redoviti posjeti stomatologu ključni su za očuvanje oralnog zdravlja. Stomatolog će pregledati vaše zube, desni i ukazati na potencijalne probleme prije nego što postanu ozbiljni.",
            Summary = "Očuvanje oralnog zdravlja kroz redovite posjete stomatologu.",
            PublishDate = DateTime.Now,
            UserCreatedId = 4
        });

        modelBuilder.Entity<Article>().HasData(new Article
        {
            ArticleId = 2,
            Title = "Pravilno Četkanje Zuba: Kako Postići Savršenu Tehniku",
            Content =
                "Pravilna tehnika četkanja zuba ključna je za sprječavanje karijesa i bolesti desni. Obratite pažnju na pritisak, kut četkanja i koristite kvalitetnu četkicu za zube.",
            Summary = "Savjeti za postizanje savršene tehnike četkanja zuba.",
            PublishDate = DateTime.Now,
            UserCreatedId = 3
        });

        modelBuilder.Entity<Article>().HasData(new Article
        {
            ArticleId = 3,
            Title = "Zdrava Ishrana za Zdrave Zube",
            Content =
                "Vaša ishrana igra ključnu ulogu u održavanju zdravlja vaših zuba. Ograničite unos šećera, konzumirajte mliječne proizvode i voće te pijte dovoljno vode za optimalnu oralnu hidrataciju.",
            Summary = "Kako ishrana utječe na zdravlje zuba i desni.",
            PublishDate = DateTime.Now,
            UserCreatedId = 5
        });

        modelBuilder.Entity<Article>().HasData(new Article
        {
            ArticleId = 4,
            Title = "Estetski Zahvati u Stomatologiji: Sve Što Trebate Znati",
            Content =
                "Estetski zahvati poput izbjeljivanja zuba, keramičkih faseta i ortodontskih tretmana mogu poboljšati izgled vašeg osmijeha. Posavjetujte se sa stomatologom o opcijama prilagođenim vašim potrebama.",
            Summary = "Pregled estetskih zahvata za ljepši osmijeh.",
            PublishDate = DateTime.Now,
            UserCreatedId = 6
        });

        #endregion

        #region Appointments

        modelBuilder.Entity<Appointment>().HasData(new Appointment
        {
            AppointmentId = 1,
            IsConfirmed = true,
            Notes = "",
            PatientId = 1,
            EmployeeId = 3,
            ServiceId = 1,
            AppointmentDateTime = DateTime.Today.AddHours(14).AddMinutes(30)
        });
        modelBuilder.Entity<Appointment>().HasData(new Appointment
        {
            AppointmentId = 2,
            IsConfirmed = true,
            Notes = "",
            PatientId = 1,
            EmployeeId = 3,
            ServiceId = 2,
            AppointmentDateTime = DateTime.Today.AddHours(38).AddMinutes(30)
        });
        modelBuilder.Entity<Appointment>().HasData(new Appointment
        {
            AppointmentId = 3,
            IsConfirmed = true,
            Notes = "",
            PatientId = 2,
            EmployeeId = 4,
            ServiceId = 3,
            AppointmentDateTime = DateTime.Today.AddHours(11).AddMinutes(30)
        });
        modelBuilder.Entity<Appointment>().HasData(new Appointment
        {
            AppointmentId = 4,
            IsConfirmed = true,
            Notes = "",
            PatientId = 3,
            EmployeeId = 5,
            ServiceId = 4,
            AppointmentDateTime = DateTime.Today.AddHours(10).AddMinutes(30)
        });
        modelBuilder.Entity<Appointment>().HasData(new Appointment
        {
            AppointmentId = 5,
            IsConfirmed = true,
            Notes = "",
            PatientId = 2,
            EmployeeId = 1,
            ServiceId = 5,
            AppointmentDateTime = DateTime.Today.AddHours(35).AddMinutes(30)
        });

        #endregion

        #region Employee

        modelBuilder.Entity<Employee>().HasData(new Employee
        {
            EmployeeId = 1,
            FirstName = "Ahmed",
            LastName = "Ahmedic",
            Gender = 'M',
            Email = "ahmedahmedic@mojstomatolog.ba",
            Number = "123456789",
            Specialization = "Stomatolog",
            StartDate = new DateTime(2023, 3, 15)
        });

        modelBuilder.Entity<Employee>().HasData(new Employee
        {
            EmployeeId = 2,
            FirstName = "Lejla",
            LastName = "Lejlic",
            Gender = 'F',
            Email = "lejlalejlic@mojstomatolog.ba",
            Number = "987654321",
            Specialization = "Asistent",
            StartDate = new DateTime(2023, 6, 7)
        });

        modelBuilder.Entity<Employee>().HasData(new Employee
        {
            EmployeeId = 3,
            FirstName = "Adnan",
            LastName = "Adnanic",
            Gender = 'M',
            Email = "adnanadnanic@mojstomatolog.ba",
            Number = "555666777",
            Specialization = "Higijeničar",
            StartDate = new DateTime(2023, 1, 22)
        });

        modelBuilder.Entity<Employee>().HasData(new Employee
        {
            EmployeeId = 4,
            FirstName = "Amina",
            LastName = "Aminic",
            Gender = 'F',
            Email = "aminaaminic@mojstomatolog.ba",
            Number = "111222333",
            Specialization = "Stomatolog",
            StartDate = new DateTime(2023, 9, 10)
        });

        modelBuilder.Entity<Employee>().HasData(new Employee
        {
            EmployeeId = 5,
            FirstName = "Haris",
            LastName = "Harisic",
            Gender = 'M',
            Email = "harisharisic@mojstomatolog.ba",
            Number = "444555666",
            Specialization = "Asistent",
            StartDate = new DateTime(2023, 12, 3)
        });

        #endregion

        #region User

        modelBuilder.Entity<User>().HasData(new User
        {
            UserId = 1,
            FirstName = "Mobile",
            LastName = "Test",
            Image = null,
            Username = "mobile",
            Email = "mobiletest@mojstomatolog.ba",
            PasswordSalt = "2irDvagQHwn9bhLo7RopCA==",
            PasswordHash = "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=",
            Number = "123456789"
        });

        modelBuilder.Entity<User>().HasData(new User
        {
            UserId = 2,
            FirstName = "Adi",
            LastName = "Nišić",
            Image = null,
            Username = "adinisic",
            Email = "adinisic@mojstomatolog.ba",
            PasswordSalt = "2irDvagQHwn9bhLo7RopCA==",
            PasswordHash = "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=",
            Number = "987654321"
        });

        modelBuilder.Entity<User>().HasData(new User
        {
            UserId = 3,
            FirstName = "Pero",
            LastName = "Peric",
            Image = null,
            Username = "peroperic",
            Email = "peroperic@mojstomatolog.ba",
            PasswordSalt = "2irDvagQHwn9bhLo7RopCA==",
            PasswordHash = "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=",
            Number = "111222333"
        });

        modelBuilder.Entity<User>().HasData(new User
        {
            UserId = 4,
            FirstName = "Amar",
            LastName = "Amaric",
            Image = null,
            Username = "amaramaric",
            Email = "amaramaric@mojstomatolog.ba",
            PasswordSalt = "2irDvagQHwn9bhLo7RopCA==",
            PasswordHash = "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=",
            Number = "555444333"
        });

        modelBuilder.Entity<User>().HasData(new User
        {
            UserId = 5,
            FirstName = "Aida",
            LastName = "Aidic",
            Image = null,
            Username = "aidaaidic",
            Email = "aidaaidic@mojstomatolog.ba",
            PasswordSalt = "2irDvagQHwn9bhLo7RopCA==",
            PasswordHash = "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=",
            Number = "999888777"
        });

        modelBuilder.Entity<User>().HasData(new User
        {
            UserId = 6,
            FirstName = "Desktop",
            LastName = "Test",
            Image = null,
            Username = "desktop",
            Email = "desktoptest@mojstomatolog.ba",
            PasswordSalt = "2irDvagQHwn9bhLo7RopCA==",
            PasswordHash = "eAgjVa5u+yP5GzGoMTpY0Sb5XowehZl3VNOjuUX8kJc=",
            Number = "123789456"
        });

        #endregion
    }
}