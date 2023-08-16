Create Database Assesment04Db
use Assesment04Db
create table products
(PId int identity(500,1) primary key,
PName nvarchar(50) not null,
PPrice float,
PCompany nvarchar(50) check (PCompany in ('Samsung','Apple','Redmi','HTC','RealMe','Xiaomi')),
PQty int default(10) check (PQty>=1),
PTax as PPrice * 0.10 persisted,
);

insert into products values('Laptop','57000','samsung',2),
('Iphone','25000','Apple',5),
('Laptop','57000','Redmi',2),
('Tablet','15000','RealMe',2),
('Earpod','5000','Apple',3),
('MacBook','99000','Apple',1)
insert into products (PName,PPrice,PCompany)values('SmartWatch','2500','Samsung')
insert into products values('Laptop','57000','HTC',5),('Earpods','1200','Xiaomi',4),('Laptop','78000','Apple',7)

select * from products

create proc Electronics
with encryption
as
begin 
select PId,PName,PCompany,PTax,
(PQty * PTax)as TotalPrice 
from products
end
exec Electronics

drop  proc Electronics 
Create procedure TTax
@PCompany nvarchar(50),
@TotalTax Float Output
as
begin select @TotalTax = SUM(PTax) from Products where PCompany = @PCompany
end

exec TTax @PCompany = 'Apple', @TotalTax = @TotalTax output;
select @TotalTax as TotalTax
