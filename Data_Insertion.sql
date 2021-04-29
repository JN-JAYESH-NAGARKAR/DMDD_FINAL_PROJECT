clear screen;
--
-- drop employee task
drop table region;
drop sequence regionID_seq;

-- begin creating tables

create table region
( regionID number not null
, regionName varchar(56) not null
, CONSTANT PK_regions primary key(regionID)
);
create sequence regionID_seq
	start with 100000
	increment by 10;