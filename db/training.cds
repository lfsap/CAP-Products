namespace com.training;

using {
    cuid,
    Country
} from '@sap/cds/common';

entity Course {
    key ID      : UUID;
        Student : Association to many StudentCourse
                      on Student.Course = $self;
};

entity Student {
    key ID     : UUID;
        Course : Association to many StudentCourse
                     on Course.Student = $self;
};

entity StudentCourse {
    key ID      : UUID;
        Student : Association to Student;
        Course  : Association to Course;
};

entity Orders {
    key ClientEmail : String(65);
        FirstName   : String(30);
        LastName    : String(30);
        CreatedOn   : Date;
        Reviewed    : Boolean;
        Approved    : Boolean;
        Country     : Country;
        Status      : String(1);
};

// entity ParamProducts(pName : String) as
//     select from Products {
//         Name,
//         Price,
//         Quantity
//     }
//     where
//         Name = : pName;

// entity ProjParamProducts(pName : String) as projection on
//     Products
//     where
//         Name = : pName;

// type Addresses_01 : array of {
//     kind  : String;
//     email : String;
// };

// type Addresses_02 {
//     kind  : String;
//     email : String;
// };

// entity Emails {
//     email_01 :      Addresses_01;
//     email_02 : many Addresses_01;
//     email_03 : many {
//         kind  : String;
//         email : String;
//     }
// }

// type Gender: String enum{
//     male;
//     female;
// };

// entity Order {
//     clientGender : Gender;
//     status : Integer enum {
//         submitted = 1;
//         fulfiller = 2;
//         shipped = 3;
//         cancel = 4;
//     };
//     priority: String @assert.range enum {
//         high;
//         medium;
//         low;
//     }
// };

// entity Car {
//     key ID                 : UUID;
//         Name               : String;
//         virtual Discount_1 : Decimal;
//         virtual Discount_2 : Decimal;
// };
