set serveroutput on;
/
--dbms_ouput.put_line('creating dependency table....');
CREATE TABLE department (
    deptno int,
    dname varchar(100),
    loc varchar(100)
);
/
--dbms_ouput.put_line('creating table constraints....');
alter table department
add constraint pk_department primary key (deptno);
/
--dbms_ouput.put_line('inserting sample data into dept table....');
insert into department values (153463013,'Accounting', 'IL' );
insert into department values (253463013,'Research', 'IL' );
insert into department values (353463013,'Operations', 'MA' );
insert into department values (453463013,'Cs', 'MA' );
insert into department values (553463013,'Hr', 'CA');
insert into department values (653463013,'Assembly', 'CA' );
insert into department values (753463013,'Supply', 'CA' );
/
--dbms_ouput.put_line('creating function/procedure/package....');
--select * from department;
/
---------------------------------------------------------------------------------------------------------------------------------------
create or replace package my_package as

    --dbms_ouput.put_line('creating dependency table....');
    procedure dept_upsert (pi_dname varchar, po_location  varchar , po_id out number);
    function CamelCase(pi_dname varchar) return varchar;
end my_package;
/
---------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace package body my_package as

    
    procedure dept_upsert (pi_dname varchar, po_location  varchar , po_id out number)
    is 
    invalid_dept_name exception;
    invalid_dept_as_number exception;
    invalid_location exception;
    invalid_dept_length exception;
    tmp number;
    begin 
        --dbms_output.put_line('CREATEING' );
        if po_location not in ('MA','TX','IL','CA','NY','NJ','NH','RH') then
            raise invalid_location;
        end if;
    
    
    
        if pi_dname is null or length(pi_dname) <= 0 then 
            raise invalid_dept_name;
        end if;
        
        if length(pi_dname) > 20 then 
            raise invalid_dept_length;
        end if;
        
       
        if pi_dname like '0%' or pi_dname like '1%' or pi_dname like '2%' or pi_dname like '3%' or pi_dname like '4%' or pi_dname like '5%' or pi_dname like '6%' or pi_dname like '7%' or pi_dname like '8%' or
          pi_dname like '9%' then
            raise  invalid_dept_as_number;
        end if;
       
       
        
     
    
        select deptno
         into po_id
         from department
         where nvl(dname,'~') = nvl(pi_dname,'~')
        ;
        
        update department
            set loc=po_location
            where dname = pi_dname;
          
        
    exception 
        when invalid_dept_length then
            dbms_output.put_line('DMDD ERROR: lenth of the department can not be more than 20 characters' );
        when invalid_location then
            dbms_output.put_line('DMDD ERROR: location can be only MA,TX,IL,CA,NY,NJ,NH,RH ' );
        when invalid_dept_as_number then
         dbms_output.put_line('DMDD ERROR: department name can not be number');
         
        when invalid_dept_name then 
         dbms_output.put_line('DMDD ERROR: department name can not be null or empty');
         
        when invalid_number then
         dbms_output.put_line('DMDD ERROR: not number allowed');
         
        when no_data_found then
         --tmp := tmp + 1;
         SELECT abs(dbms_random.random()) into tmp from dual;
         insert into department values (tmp,CamelCase(pi_dname), po_location );
         --dbms_output.put_line('new  department added in the system');
         po_id := tmp;
         
        when too_many_rows then 
         dbms_output.put_line('more than one department with same name');
         
        when others then 
         dbms_output.put_line('sqlerrm');
    end dept_upsert;
    
    function CamelCase(pi_dname varchar)
    return varchar
    is 
        result varchar(100) ;
        resultant varchar(100);
        
    begin 
       
        select upper(substr(pi_dname,1,1))  into result from dual; 
        select lower(substr(pi_dname,2))   into resultant from dual;
        select concat(result,resultant) into result from dual;
        return result;
    
    end CamelCase;
    
end my_package;
/    
    


--select * from department;
/
