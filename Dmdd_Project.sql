clear screen;

drop table salePerson;
drop sequence salePersonID_seq;
drop table  store;
drop sequence storeID_seq; 
drop table location;
drop sequence locationID_seq;
drop table country;
drop sequence countryID_seq;
drop table region;
drop sequence regionID_seq;

-- begin creating tables

create table region
( regionID number not null
, regionName varchar(56) not null
, constraint PK_regions primary key(regionID)
);
create sequence regionID_seq
	start with 100
	increment by 10;
	
create table country
( countryID number not null
, regionID number not null
, countryName varchar(100) not null
, constraint pk_countryID primary key (countryID)
, constraint fk_regionID foreign key (regionID) references region(regionID)
);
create sequence countryID_seq
	start with 100
	increment by 1;
	
create table location 
( locationID number not null
, locationName varchar(100) not null
, countryID number not null
, constraint pk_locationID primary key (locationID)
, constraint fk_countryID foreign key (countryID) references country(countryID)
);
create sequence locationID_seq
	start with 1000
	increment by 1;
    
create table store
( storeID number not null
, storeName varchar(100) not null
, locationID number not null
, constraint pk_storeID primary key (storeID)
, constraint fk_locationID foreign key (locationID) references location(locationID)
);
create sequence storeID_seq
    start with 1000
    increment by 1;
    

create table salePerson
( salePersonID number not null
, name varchar(100) not null
, salary number not null
, storeID number not null
, constraint pk_salePersonID primary key (salePersonID)
, constraint fk_storeID foreign key (storeID) references store(storeID)
);
create sequence salePersonID_seq
    start with 1000
    increment by 1;

create table customer
( customerID number not null 
, name varchar(100) not null
, age varchar(100) not null
, sex varchar(100) not null
, constraint pk_customerID primary key (customerID)
);
create sequence customerID_seq
    start with 100
    increment by 1;

create table supplier
( supplierID number not null
, name varchar(100) not null
, email varchar(100) not null
, constraint pk_supplierID primary key(supplierID)
);
create sequence supplierID_seq
    start with 100
    increment by 1;


create table category 
( categoryID number not null
, type varchar(100) not null
, constraint pk_categoryID primary key (categoryID)
);
create sequence categoryID_seq
    start with 100
    increment by 1;




create table item
( itemID number not null
, name varchar(100) not null
, stock number not null
, price number not null
, categoryID number not null
, supplierID number not null
, constraint pk_itemID primary key (itemID)
, constraint fk_categoryID foreign key (categoryID) references category(categoryID)
, constraint fk_supplierID foreign key (supplierID) references supplier(supplierID)
);
create sequence itemID_seq
    start with 100
    increment by 1;


create table invoice
( invoiceID number not null
, order_date date not null
, sales number not null
, customer number not null
, constraint pk_invoiceID primary key (invoiceID)
, constraint fk_salePersonID foreign key (sales) references salePerson(salePersonID)
, constraint fk_customerID foreign key (customer) references customer(customerID)
);

create sequence invoiceID_seq
    start with 100
    increment by 1;


create table orderLine
( lineNumber number not null
, item number not null
, invoice number not null
, qty number not null
, constraint pk_orderlineID primary key (linenumber)
, constraint fk_itemID foreign key (item) references item(itemID)
, constraint fk_invoiceID foreign key (invoice) references invoice(invoiceID)
);
create sequence orderlineID_seq
    start with 100
    increment by 1;



