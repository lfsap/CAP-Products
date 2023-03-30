using CatalogService as service from '../../srv/catalog-service';

annotate service.Products with @(

    Capabilities       : {DeleteRestrictions : {
        $Type     : 'Capabilities.DeleteRestrictionsType',
        Deletable : false
    },

    },

    UI.HeaderInfo      : {
        TypeName       : 'Product',
        TypeNamePlural : 'Products',
        ImageUrl       : ImageUrl,
        Title          : {Value : ProductName},
        Description    : {Value : Description}
    },

    UI.SelectionFields : [
        CategoryId,
        CurrencyId,
        StockAvailability
    ],
    UI.LineItem        : [
        {
            $Type : 'UI.DataField',
            Label : 'ImageUrl',
            Value : ImageUrl,
        },
        {
            $Type : 'UI.DataField',
            Label : 'ProductName',
            Value : ProductName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : Description,
        },
        {
            $Type  : 'UI.DataFieldForAnnotation',
            Label  : 'Supplier',
            Target : 'Supplier/@Communication.Contact'
        },
        {
            $Type : 'UI.DataField',
            Label : 'ReleaseDate',
            Value : ReleaseDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'DiscontinuedDate',
            Value : DiscontinuedDate,
        },
        {
            Label       : 'Stock Availability',
            Value       : StockAvailability,
            Criticality : StockAvailability
        },
        {
            //$Type : 'UI.DataField',
            //Value : Rating,
            $Type  : 'UI.DataFieldForAnnotation',
            Label  : 'Rating',
            Target : '@UI.DataPoint#AverageRating'
        },
        {
            $Type : 'UI.DataField',
            Label : 'Price',
            Value : Price,
        },
    ]
);

annotate service.Products with {
    CategoryId        @title : '{i18n>CategoryId}';
    CurrencyId        @title : '{i18n>CurrencyId}';
    StockAvailability @title : '{i18n>StockAvailability}';
}

annotate service.Products with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            // {
            //     $Type : 'UI.DataField',
            //     Label : 'ProductName',
            //     Value : ProductName,
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Label : 'Description',
            //     Value : Description,
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Label : 'ImageUrl',
            //     Value : ImageUrl,
            // },
            {
                $Type : 'UI.DataField',
                Label : 'ReleaseDate',
                Value : ReleaseDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DiscontinuedDate',
                Value : DiscontinuedDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Price',
                Value : Price,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Height',
                Value : Height,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Width',
                Value : Width,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Depth',
                Value : Depth,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Quantity',
                Value : Quantity,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ToUnitOfMeasure_ID',
                Value : ToUnitOfMeasure_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ToCurrency_ID',
                Value : ToCurrency_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ToCategory_ID',
                Value : ToCategory_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Category',
                Value : Category,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ToDimensionUnit_ID',
                Value : ToDimensionUnit_ID,
            },
            // {
            //     //$Type : 'UI.DataField',
            //     $Type  : 'UI.DataFieldForAnnotation',
            //     Label  : 'Rating',
            //     //Value: Rating,
            //     Target : '@UI.DataPoint#AverageRating',
            // },
            {
                $Type : 'UI.DataField',
                Label : 'StockAvailability',
                Value : StockAvailability,
            },
        ],
    },
    UI.Facets                      : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'GeneratedFacet1',
            Label  : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'GeneratedFacet2',
            Label  : 'General Information Copy',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        }
    ],
    UI.HeaderFacets                : [{
        $Type  : 'UI.ReferenceFacet',
        Target : '@UI.DataPoint#AverageRating',
    }

    ]
);

annotate service.Products with {
    ImageUrl @(UI.IsImageURL : true)
};

//Annotations for Search helps
annotate service.Products with {
    //Category
    ToCategory        @(Common : {
        Text      : {
            $value                 : Category,
            ![@UI.TextArrangement] : #TextOnly,
        },
        ValueList : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'VH_Categories',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ToCategory_ID,
                    ValueListProperty : 'Code',
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ToCategory_ID,
                    ValueListProperty : 'Text',
                }
            ]
        },
    });
    //Currency
    ToCurrency        @(Common : {
                                  //ValueListWithFixedValues : true,
                                 ValueList : {
        $Type          : 'Common.ValueListType',
        CollectionPath : 'VH_Currencies',
        Parameters     : [
            {
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : ToCurrency_ID,
                ValueListProperty : 'Code',
            },
            {
                $Type             : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Text',
            }
        ]
    }, });
    //StockAvailability
    StockAvailability @(Common : {
        ValueListWithFixedValues : true,
        ValueList                : {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'StockAvailability',
            Parameters     : [{
                $Type             : 'Common.ValueListParameterInOut',
                LocalDataProperty : StockAvailability,
                ValueListProperty : 'ID',
            }]
        },

    }

    );
};

//Annotations for Categories
annotate service.VH_Categories with {
    Code @(
        UI     : {Hidden : true},
        Common : {Text : {
            $value                 : Text,
            ![@UI.TextArrangement] : #TextOnly,
        }}
    );
    Text @(UI : {HiddenFilter : true});
};

//Annotations for Currencies
annotate service.VH_Currencies with {
    Code @(UI : {HiddenFilter : true});
    Text @(UI : {HiddenFilter : true});
};

//Annotations for Stock Availability
annotate service.StockAvailability with {
    ID @(Common : {Text : {
        $value                 : Description,
        ![@UI.TextArrangement] : #TextOnly,
    }, })
};

//Annotations for Units of Measure
annotate service.VH_UnitOfMeasure with {
    Code @(UI : {HiddenFilter : true});
    Text @(UI : {HiddenFilter : true});
};

//Annotations for Dimension Units
annotate service.VH_DimensionUnits with {
    Code @(UI : {HiddenFilter : true});
    Text @(UI : {HiddenFilter : true});
};

annotate service.Supplier with @(Communication : {Contact : {
    $Type : 'Communication.ContactType',
    fn    : Name,
    role  : 'Supplier',
    photo : 'sap-icon://supplier',
    email : [{
        type    : #work,
        address : Email
    }],
    tel   : [
        {
            type : #work,
            uri  : Phone
        },
        {
            type : #fax,
            uri  : Fax
        }
    ]
}});

//DataPoint Average Rating
annotate service.Products with @(UI.DataPoint #AverageRating : {
    Value         : Rating,
    Title         : 'Rating',
    TargetValue   : 5,
    Visualization : #Rating
});
