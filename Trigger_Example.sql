select * from Employee

create table Employee_History
(
	EmployeeId int primary key not null,
	Name char(30),
	City char(30),
	Phone int,
	DepartmentId int,
	Gender char(6)
)

select * from Employee_History

create trigger Insert_Into_Employee_History
on Employee
for Delete
as
begin
 declare @empid int,
		 @name char(30),
		 @city char(30),
		 @phone int,
		 @deptid int,
		 @gender char(6)
 
 select @empid = EmployeeId, @name = Name, @city = City,
		@phone = Phone, @deptid = DepartmentId, @gender = Gender
		from deleted

 insert into Employee_History
 values(@empid, @name, @city, @phone, @deptid, @gender)
end

select * from Employee
select * from Employee_History


delete from Employee
where EmployeeId = 7

create trigger trgDenyDelete
on Employee
for Delete
as
begin
	print 'You are not authorized to delete data'
	rollback
end

select * from Employee

delete from Employee
where EmployeeId = 5

sp_help Employee

create table Employee_Test
(
	EmployeeId int primary key,
	City char(30)
)

insert into Employee_Test
values(2, 'Mumbai')

select * from Employee_Test


create trigger trgCheck_City
on Employee_Test
for insert, update
as
begin
	declare @city char(30)
	select @city = City from inserted
	if(@city = 'Mumbai')
	begin
		print 'Mumbai is not a valid city here'
		rollback
	end
end

select * from Employee_Test

begin try
begin transaction tran1
	insert into Employee_Test values(2, 'Mumbai')
	save transaction tran1
	insert into Employee_Test values(3, 'Delhi')
	insert into Employee_Test values(2, 'Mumbai')
commit tran tran1
end try
begin catch
	select error_message() as 'Error Message'
	rollback
end catch
