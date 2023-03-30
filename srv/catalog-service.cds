//using {com.lf as lf} from '../db/schema';
using com.lf as lf from '../db/schema';
using com.training as training from '../db/training';


// service CatalogService {
//     entity Products       as projection on lf.materials.Products;
//     entity UnitOfMeasures as projection on lf.materials.UnitOfMeasures;
//     entity Currencies     as projection on lf.materials.Currencies;
//     entity Categories     as projection on lf.materials.Categories;
//     entity Suppliers      as projection on lf.sales.Suppliers;
//     entity DimensionUnits as projection on lf.materials.DimensionUnits;
//     entity SalesData      as projection on lf.sales.SalesData;
//     entity ProductReview  as projection on lf.materials.ProductReview;
//     entity Orders         as projection on lf.sales.Orders;
//     entity OrderItems     as projection on lf.sales.OrderItems;
// }

define service CatalogService {

    entity Products          as
        select from lf.reports.Products {
            ID,
            Name          as ProductName     @mandatory,
            Description                      @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                            @mandatory,
            Height,
            Width,
            Depth,
            Quantity                         @(
                mandatory,
                assert.range : [
                    0.00,
                    20.00
                ]
            ),
            UnitOfMeasure as ToUnitOfMeasure @mandatory,
            Currency      as ToCurrency      @mandatory,
            Currency.ID   as CurrencyId,
            Category      as ToCategory      @mandatory,
            Category.ID     as CategoryId,
            Category.Name as Category        @readonly,
            DimensionUnit as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews,
            Rating,
            StockAvailability,
            ToStockAvailability
        };

    entity Supplier          as
        select from lf.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };

    @readonly
    entity Reviews           as
        select from lf.materials.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product as ToProduct
        };

    @readonly
    entity SalesData         as
        select from lf.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth.ID          as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct
        };

    @readonly
    entity StockAvailability as
        select from lf.materials.StockAvailability {
            ID,
            Description,
            Products as ToProduct
        };

    @readonly
    entity VH_Categories     as
        select from lf.materials.Categories {
            ID   as Code,
            Name as Text,
        };

    @readonly
    entity VH_Currencies     as
        select from lf.materials.Currencies {
            ID          as Code,
            Description as Text,
        };

    @readonly
    entity VH_UnitOfMeasure  as
        select from lf.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text,
        };

    @readonly
    entity VH_DimensionUnits as
        select
            ID          as Code,
            Description as Text
        from lf.materials.DimensionUnits;

}

define service testService {

    entity supplierProduct as
        select from lf.materials.Products[Name = 'Bread']{
            *,
            Name,
            Description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = '98074';

    entity SuppliersToSale as
        select
            Supplier.Email,
            Category.Name,
            SalesData.Currency.ID,
            SalesData.Currency.Description
        from lf.materials.Products;

    entity EntityInFix     as
        select Supplier[Name = 'Exotic Liquids'].Phone from lf.materials.Products
        where
            Products.Name = 'Bread';

    entity EntityJoin      as
        select Phone from lf.materials.Products
        left join lf.sales.Suppliers as Supp
            on(
                Supp.ID = Products.Supplier.ID
            )
            and Supp.Name = 'Exotic Liquids'
        where
            Product.Name = 'Bread';
}

define service Reports {
    entity AverageRating as projection on lf.reports.AverageRating;

    entity EntityCasting as
        select
            cast(Price as Integer) as Price,
            Price as Price2 : Integer
        from lf.materials.Products;
    
    entity EntityExists as
        select from lf.materials.Products{
            Name
        } where exists Supplier[Name = 'Exotic Liquids'];

}
