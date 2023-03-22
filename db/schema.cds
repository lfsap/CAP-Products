namespace com.lf;

using {
    cuid,
    managed
} from '@sap/cds/common';

define type Name : String(50);

define type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};

type Dec         : Decimal(16, 2);

context materials {
    entity Products : cuid, managed {
        Name             : localized String not null;
        Description      : localized String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Dec;
        Height           : type of Price; //Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        UnitOfMeasure    : Association to one UnitOfMeasures;
        Currency         : Association to one Currencies;
        Category         : Association to one Categories;
        Supplier         : Association to one sales.Suppliers;
        DimensionUnit    : Association to one DimensionUnits;
        SalesData        : Association to many sales.SalesData
                               on SalesData.Product = $self;
        Reviews          : Association to many ProductReview
                               on Reviews.Product = $self;
    };

    entity Categories : cuid {
        key ID   : String(1);
            Name : localized String;
    };

    entity StockAvailability {
        key ID          : Integer;
            Description : localized String;
            Products    : Association to Products;
    };

    entity Currencies {
        key ID          : String(3);
            Description : localized String;
    };

    entity UnitOfMeasures {
        key ID          : String(2);
            Description : localized String;
    };

    entity DimensionUnits {
        key ID          : String(2);
            Description : localized String;
    };

    entity ProductReview : cuid, managed {
        Name    : String;
        Rating  : Integer;
        Comment : String;
        Product : Association to one Products;
    };

    entity SelProducts   as select from Products;
    entity ProjProducts  as projection on Products;

    entity ProjProducts2 as projection on Products {
        *
    };

    entity ProjProducts3 as projection on Products {
        ReleaseDate,
        Name
    };

    extend Products with {
        PriceCondition     : String(2);
        PriceDetermination : String(3);
    };

};

context sales {
    entity Orders : cuid {
        Date     : Date;
        Customer : String;
        Items    : Composition of many OrderItems
                       on Items.Order = $self;
    };

    entity OrderItems : cuid {
        Order    : Association to Orders;
        Product  : Association to materials.Products;
        Quantity : Integer;

    };

    entity Suppliers : cuid, managed {
        Name    : type of materials.Products : Name; //String;
        //        Street     : String;
        //        City       : String;
        //        State      : String(2);
        //        PostalCode : String(5);
        //        Country    : String(3);
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
        Product : Association to many materials.Products
                      on Product.Supplier = $self;
    };

    entity Months {
        key ID               : String(2);
            Description      : localized String;
            ShortDescription : localized String(3);
    };

    entity SelProducts1 as
        select from materials.Products {
            *
        };

    entity SelProducts2 as
        select from materials.Products {
            Name,
            Price,
            Quantity
        };

    entity SelProducts3 as
        select from materials.Products
        left join materials.ProductReview
            on Products.Name = ProductReview.Name
        {
            Rating,
            Products.Name,
            sum(Price) as TotalPrice
        }
        group by
            Rating,
            Products.Name
        order by
            Rating;

    entity SalesData : cuid, managed {
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to one materials.Products;
        Currency      : Association to one materials.Currencies;
        DeliveryMonth : Association to one Months;
    };
};

context reports {
    entity AverageRating as
        select from lf.materials.ProductReview{
            Product.ID as ProductId,
            avg( Rating ) as AverageRating : Decimal(16,2)
        }
        group by Product.ID;
    
    entity Products as
        select from lf.materials.Products
        mixin{
            ToStockAvailability : Association to lf.materials.StockAvailability
            on ToStockAvailability.ID = $projection.StockAvailability;
            ToAverageRating : Association to AverageRating
            on ToAverageRating.ProductId = ID;
        }
        into{
            *,
            ToAverageRating.AverageRating as Rating,
            case 
            when Quantity >= 8 then 3
            when Quantity > 0 then 2
            else 1
            end as StockAvailability : Integer,
            ToStockAvailability

        }
}