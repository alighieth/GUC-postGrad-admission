CREATE DATABASE PostGradOffice;
go
use PostGradOffice;
CREATE TABLE PostGradUser(
id int primary key identity(1,1),
email varchar(50) not null,
password varchar(30) not null
)
CREATE TABLE Admin(
id int primary key foreign key references PostGradUser on delete cascade
on update cascade
)
CREATE TABLE GucianStudent(
id int primary key foreign key references PostGradUser on delete cascade
on update cascade,
firstName varchar(20),
lastName varchar(20),
type varchar(3),
faculty varchar(30),
address varchar(50),
GPA decimal(3,2),
undergradID int
)
CREATE TABLE NonGucianStudent(
id int primary key foreign key references PostGradUser on delete cascade
on update cascade,
firstName varchar(20),
lastName varchar(20),
type varchar(3),
faculty varchar(30),
address varchar(50),
GPA decimal(3,2),
)
CREATE TABLE GUCStudentPhoneNumber(
phone int,
id int,
primary key(id, phone),
foreign key(id) references GucianStudent on delete cascade
on update cascade
)
CREATE TABLE NonGUCStudentPhoneNumber(
phone int,
id int,
primary key(id, phone),
foreign key(id) references NonGucianStudent on delete
cascade on update cascade
)
CREATE TABLE Course(
id int primary key identity(1,1),
fees int,
creditHours int,
code varchar(10)
)
CREATE TABLE Supervisor(
id int primary key foreign key references PostGradUser,
name varchar(20),
faculty varchar(30)
);
CREATE TABLE Examiner(
id int primary key foreign key references PostGradUser on delete cascade
on update cascade,
name varchar(20),
fieldOfWork varchar(100),
isNational BIT
)
CREATE TABLE Payment(
id int primary key identity(1,1),
amount decimal(7,2),
noOfInstallments int,
fundPercentage decimal(4,2)
)
CREATE TABLE Thesis(
serialNumber int primary key identity(1,1),
field varchar(20),
type varchar(3) not null,
title varchar(100) not null,
startDate date not null,
endDate date not null,
defenseDate date,
years as (year(endDate)-year(startDate)),
grade decimal(4,2),
payment_id int foreign key references payment on delete cascade on update
cascade,
noOfExtensions int
)
CREATE TABLE Publication(
id int primary key identity(1,1),
title varchar(100) not null,
dateOfPublication date,
place varchar(100),
accepted BIT,
host varchar(100)
);
Create table Defense (serialNumber int,
date datetime,
location varchar(15),
grade decimal(4,2),
primary key (serialNumber, date),
foreign key (serialNumber) references Thesis on delete cascade on update
cascade)
Create table GUCianProgressReport (
sid int foreign key references GUCianStudent on delete cascade on update
cascade
, no int
, date datetime
, eval int
, state int
, description varchar(200)
, thesisSerialNumber int foreign key references Thesis on delete cascade
on update cascade
, supid int foreign key references Supervisor
, primary key (sid, no) )
Create table NonGUCianProgressReport (sid int foreign key references
NonGUCianStudent on delete
cascade on update cascade,
no int
, date datetime
, eval int
, state int
, description varchar(200)
, thesisSerialNumber int foreign key references Thesis on delete cascade
on update cascade
, supid int foreign key references Supervisor
, primary key (sid, no) )
Create table Installment (date datetime,
paymentId int foreign key references Payment on delete cascade on update
cascade
, amount decimal(8,2)
, done bit
, primary key (date, paymentId))
Create table NonGucianStudentPayForCourse(sid int foreign key references
NonGucianStudent on
delete cascade on update cascade,
paymentNo int foreign key references Payment on delete cascade on update
cascade,
cid int foreign key references Course on delete cascade on update cascade,
primary key (sid, paymentNo, cid))
Create table NonGucianStudentTakeCourse (sid int foreign key references
NonGUCianStudent on delete
cascade on update cascade
, cid int foreign key references Course on delete cascade on update
cascade
, grade decimal (4,2)
, primary key (sid, cid) )
Create table GUCianStudentRegisterThesis (sid int foreign key references
GUCianStudent on delete
cascade on update cascade,
supid int foreign key references Supervisor
, serial_no int foreign key references Thesis on delete cascade on update
cascade
, primary key(sid, supid, serial_no))
Create table NonGUCianStudentRegisterThesis (sid int foreign key
references NonGUCianStudent on
delete cascade on update cascade,
supid int foreign key references Supervisor,
serial_no int foreign key references Thesis on delete cascade on update
cascade ,
primary key (sid, supid, serial_no))
Create table ExaminerEvaluateDefense(date datetime,
serialNo int,
examinerId int foreign key references Examiner on delete cascade on update
cascade,
comment varchar(300),
primary key(date, serialNo, examinerId),
foreign key (serialNo, date) references Defense (serialNumber, date) on
delete cascade on update
cascade)
Create table ThesisHasPublication(serialNo int foreign key references
Thesis on delete cascade on
update cascade,
pubid int foreign key references Publication on delete cascade on update
cascade,
primary key(serialNo,pubid))
go
create proc studentRegister
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@Gucian bit,
@email varchar(50),
@address varchar(50)
as
begin
insert into PostGradUser(email,password)
values(@email,@password)
declare @id int
SELECT @id=SCOPE_IDENTITY()
if(@Gucian=1)
insert into GucianStudent(id,firstName,lastName,faculty,address)
values(@id,@first_name,@last_name,@faculty,@address)
else
insert into NonGucianStudent(id,firstName,lastName,faculty,address)
values(@id,@first_name,@last_name,@faculty,@address)
end
go
create proc supervisorRegister
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@email varchar(50)
as
begin
insert into PostGradUser(email,password)
values(@email,@password)
declare @id int
SELECT @id=SCOPE_IDENTITY()
declare @name varchar(50)
set @name = CONCAT(@first_name,@last_name)
insert into Supervisor(id,name,faculty) values(@id,@name,@faculty)
end
go
Create proc userLogin
@id int,
@password varchar(20),
@success bit output,
@type int output
as
begin
if exists(
select ID,password
from PostGradUser
where id=@id and password=@password)
begin
set @success =1
-- check user type 0-->Student,1-->Admin,2-->Supervisor ,3-->Examiner
if exists(select id from GucianStudent where id=@id union select id from
NonGucianStudent where id=@id )
set @type=0
if exists(select id from Admin where id=@id)
set @type=1
if exists(select id from Supervisor where id=@id)
set @type=2
if exists(select id from Examiner where id=@id)
set @type=3
end
else
set @success=0
end
go
create proc addMobile
@ID varchar(20),
@mobile_number varchar(20)
as
begin
if @ID is not null and @mobile_number is not null
begin
--check Gucian student or not
if(exists(select * from GucianStudent where id=@ID))
insert into GUCStudentPhoneNumber values(@ID,@mobile_number)
if(exists(select * from NonGucianStudent where id=@ID))
insert into NonGUCStudentPhoneNumber values(@ID,@mobile_number)
end
end
go
CREATE Proc AdminListSup
As
Select u.id,u.email,u.password,s.name, s.faculty
from PostGradUser u inner join Supervisor s on u.id = s.id
go
CREATE Proc AdminViewSupervisorProfile
@supId int
As
Select u.id,u.email,u.password,s.name, s.faculty
from PostGradUser u inner join Supervisor s on u.id = s.id
WHERE @supId = s.id
go
CREATE Proc AdminViewAllTheses
As
Select
serialNumber,field,type,title,startDate,endDate,defenseDate,years,grade,payment_id,noOfExtensions
From Thesis
go
CREATE Proc AdminViewOnGoingTheses
@thesesCount int output
As
Select @thesesCount=Count(*)
From Thesis
where endDate > Convert(Date,CURRENT_TIMESTAMP)
go
CREATE Proc AdminViewStudentThesisBySupervisor
As
Select s.name,t.title,gs.firstName
From Thesis t inner join GUCianStudentRegisterThesis sr on
t.serialNumber=sr.serial_no
inner join Supervisor s on s.id=sr.supid inner join GucianStudent gs on sr.sid=gs.id
where t.endDate > Convert(Date,CURRENT_TIMESTAMP)
union
Select s.name,t.title,gs.firstName
From Thesis t inner join NonGUCianStudentRegisterThesis sr on
t.serialNumber=sr.serial_no
inner join Supervisors on s.id=sr.supid inner join NonGucianStudent gs on
sr.sid=gs.id
where t.endDate > Convert(Date,CURRENT_TIMESTAMP)
go
go
CREATE Proc AdminListNonGucianCourse
@courseID int
As
if(exists(select * from Course where id=@courseID))
Select ng.firstName,ng.lastName,c.code,n.grade
From NonGucianStudentTakeCourse n inner join Course c on n.cid=c.id inner
join NonGucianStudent ng
on ng.id=n.sid
where n.cid=@courseID
go
CREATE Proc AdminUpdateExtension
@ThesisSerialNo int
As
if(exists(select * from Thesis where serialNumber=@ThesisSerialNo))
begin
declare @noOfExtensions int
select @noOfExtensions=noOfExtensions from Thesis where
serialNumber=@ThesisSerialNo
update Thesis
set noOfExtensions=@noOfExtensions+1
where serialNumber=@ThesisSerialNo
end
go
CREATE Proc AdminIssueThesisPayment
@ThesisSerialNo int,
@amount decimal,
@noOfInstallments int,
@fundPercentage decimal
As
if(exists(select * from Thesis where serialNumber=@ThesisSerialNo))
begin
insert into Payment(amount,noOfInstallments,fundPercentage)
values(@amount,@noOfInstallments,@fundPercentage)
declare @id int
SELECT @id=SCOPE_IDENTITY()
update Thesis
set payment_id=@id
where serialNumber=@ThesisSerialNo
end
go
CREATE Proc AdminViewStudentProfile
@sid int
As
if(exists(select * from GucianStudent where id=@sid))
Select
u.id,u.email,u.password,s.firstName,s.lastName,s.type,s.faculty,s.address,
s.address,s.GPA
from PostGradUser u inner join GucianStudent s on u.id=s.id
WHERE @sid = s.id
else if(exists(select * from NonGucianStudent where id=@sid))
Select
u.id,u.email,u.password,s.firstName,s.lastName,s.type,s.faculty,s.address,
s.address,s.GPA
from PostGradUser u inner join NonGucianStudent s on u.id=s.id
WHERE @sid = s.id
go
CREATE Proc AdminIssueInstallPayment
@paymentID int,
@InstallStartDate date
As
if(exists(select * from Payment where id=@paymentID))
begin
declare @numOfInst int
select @numOfInst=noOfInstallments
from Payment
where id=@paymentID
declare @payAmount int
select @payAmount=amount
from Payment
where id=@paymentID
DECLARE @Counter INT
SET @Counter=1
WHILE (@counter<=@numOfInst)
BEGIN
declare @instdate date
set @instdate=@InstallStartDate
declare @instAmount int
set @instAmount=@payAmount/@numOfInst
if(@counter=1)
insert into
Installment(date,paymentId,amount,done)values(@InstallStartDate,@paymentID
,@instAmount,0)
else
begin
set @instdate=DATEADD(MM, 6, @instdate);
insert into
Installment(date,paymentId,amount,done)values(@instdate,@paymentID,@instAmount,0)
end
SET @counter=@counter+1
END
end
go
CREATE Proc AdminListAcceptPublication
As
select t.serialNumber,p.title
from ThesisHasPublication tp inner join Thesis t on
tp.serialNo=t.serialNumber
inner join Publication p on p.id=tp.pubid
where p.accepted=1
go
CREATE Proc AddCourse
@courseCode varchar(10),
@creditHrs int,
@fees decimal
As
insert into Course values(@fees,@creditHrs,@courseCode)
go
CREATE Proc linkCourseStudent
@courseID int,
@studentID int
As
if(exists(select * from Course ) and exists(select * from NonGucianStudent
where id=@studentID))
insert into
NonGucianStudentTakeCourse(sid,cid,grade)values(@studentID,@courseID,null)
go
CREATE Proc addStudentCourseGrade
@courseID int,
@studentID int,
@grade decimal
As
if(exists(select * from NonGucianStudentTakeCourse where sid=@studentID
and cid=@courseID))
update NonGucianStudentTakeCourse
set grade =@grade
where cid=@courseID and sid=@studentID
go
CREATE Proc ViewExamSupDefense
@defenseDate datetime
As
select s.serial_no,ee.date,e.name,sup.name
from ExaminerEvaluateDefense ee inner join examiner e on
ee.examinerId=e.id
inner join GUCianStudentRegisterThesis s on ee.serialNo=s.serial_no
inner join Supervisor sup on sup.id=s.supid
go
CREATE Proc EvaluateProgressReport
@supervisorID int,
@thesisSerialNo int,
@progressReportNo int,
@evaluation int
As
if(exists(select * from Thesis where serialNumber=@thesisSerialNo ) and
@evaluation in(0,1,2,3) )
begin
if(exists(select * from GUCianStudentRegisterThesis where
serial_no=@thesisSerialNo and
supid=@supervisorID))
begin
declare @gucSid int
select @gucSid=sid
from GUCianStudentRegisterThesis
where serial_no=@thesisSerialNo
update GUCianProgressReport
set eval=@evaluation
where sid=@gucSid and thesisSerialNumber=@thesisSerialNo and
no=@progressReportNo
end
else if(exists(select * from NonGUCianStudentRegisterThesis where
serial_no=@thesisSerialNo and
supid=@supervisorID))
begin
declare @nonGucSid int
select @nonGucSid=sid
from NonGUCianStudentRegisterThesis
where serial_no=@thesisSerialNo
update NonGUCianProgressReport
set eval=@evaluation
where sid=@nonGucSid and thesisSerialNumber=@thesisSerialNo and
no=@progressReportNo
end
end
go
CREATE Proc ViewSupStudentsYears
@supervisorID int
As
if(exists(select * from Supervisor where id=@supervisorID))
begin
select s.firstName,s.lastName,t.years
from GUCianStudentRegisterThesis sr inner join GucianStudent s on
sr.sid=s.id
inner join Thesis t on t.serialNumber=sr.serial_no
union
select s.firstName,s.lastName,t.years
from NonGUCianStudentRegisterThesis sr inner join NonGucianStudent s on
sr.sid=s.id
inner join Thesis t on t.serialNumber=sr.serial_no
end
go
CREATE Proc SupViewProfile
@supervisorID int
As
if(exists(select * from Supervisor where id=@supervisorID))
begin
select u.id,u.email,u.password,s.name,s.faculty
from PostGradUser u inner join Supervisor s on u.id=s.id
end
go
---------------------------------------
create proc UpdateSupProfile
@supervisorID int, @name varchar(20), @faculty varchar(20)
as
update Supervisor
set name = @name, faculty = @faculty
where id = @supervisorID
go
create proc ViewAStudentPublications
@StudentID int
as
select P.*
from GUCianStudentRegisterThesis GUC
inner join Thesis T
on GUC.serial_no = T.serialNumber
inner join ThesisHasPublication TP
on T.serialNumber = TP.serialNo
inner join Publication P
on P.id = TP.pubid
where GUC.sid = @StudentID
union all
select P.*
from NonGUCianStudentRegisterThesis NON
inner join Thesis T
on NON.serial_no = T.serialNumber
inner join ThesisHasPublication TP
on T.serialNumber = TP.serialNo
inner join Publication P
on P.id = TP.pubid
where NON.sid = @StudentID
go
create proc AddDefenseGucian
@ThesisSerialNo int , @DefenseDate Datetime , @DefenseLocation varchar(15)
as
insert into Defense
values(@ThesisSerialNo,@DefenseDate,@DefenseLocation,null)
go
create proc AddDefenseNonGucian
@ThesisSerialNo int , @DefenseDate Datetime , @DefenseLocation varchar(15)
as
declare @idOfStudent int
select @idOfStudent = sid
from NonGUCianStudentRegisterThesis
where serial_no = @ThesisSerialNo
if(not exists(select grade
from NonGucianStudentTakeCourse
where sid = @idOfStudent and grade < 50))
begin
insert into Defense
values(@ThesisSerialNo,@DefenseDate,@DefenseLocation,null)
end
go
create proc AddExaminer
@ThesisSerialNo int , @DefenseDate Datetime , @ExaminerName
varchar(20),@Password varchar(30),
@National bit, @fieldOfWork varchar(20)
as
insert into PostGradUser values(@ExaminerName,@Password)
declare @id int
set @id = SCOPE_IDENTITY()
insert into Examiner values(@id,@ExaminerName,@fieldOfWork,@National)
insert into ExaminerEvaluateDefense
values(@DefenseDate,@ThesisSerialNo,@id,null)
go
create proc CancelThesis
@ThesisSerialNo int
as
if(exists(
select *
from GUCianProgressReport
where thesisSerialNumber = @ThesisSerialNo
))
begin
declare @gucianEval int
set @gucianEval = (
select top 1 eval
from GUCianProgressReport
where thesisSerialNumber = @ThesisSerialNo
order by no desc
)
if(@gucianEval = 0)
begin
delete from Thesis where serialNumber = @ThesisSerialNo
end
end
else
begin
declare @nonGucianEval int
set @nonGucianEval = (
select top 1 eval
from NonGUCianProgressReport
where thesisSerialNumber = @ThesisSerialNo
order by no desc
)
if(@nonGucianEval = 0)
begin
delete from Thesis where serialNumber = @ThesisSerialNo
end
end
go
create proc AddGrade
@ThesisSerialNo int
as
declare @grade decimal(4,2)
select @grade = grade
from Defense
where serialNumber = @ThesisSerialNo
update Thesis
set grade = @grade
where serialNumber = @ThesisSerialNo
go
create proc AddDefenseGrade
@ThesisSerialNo int , @DefenseDate Datetime , @grade decimal(4,2)
as
update Defense
set grade = @grade
where serialNumber = @ThesisSerialNo and date = @DefenseDate
go
create proc AddCommentsGrade
@ThesisSerialNo int , @DefenseDate Datetime , @comments varchar(300)
as
update ExaminerEvaluateDefense
set comment = @comments
where serialNo = @ThesisSerialNo and date = @DefenseDate
go
create proc viewMyProfile
@studentId int
as
if(exists(
select * from GucianStudent where id = @studentId
))
begin
select G.*,P.email
from GucianStudent G
inner join PostGradUser P
on G.id = P.id
where G.id = @studentId
end
else
begin
select N.*,P.email
from NonGucianStudent N
inner join PostGradUser P
on N.id = P.id
where N.id = @studentId
end
go
create proc editMyProfile
@studentID int, @firstName varchar(20), @lastName varchar(20), @password
varchar(30), @email
varchar(50)
, @address varchar(50), @type varchar(3)
as
update GucianStudent
set firstName = @firstName, lastName = @lastName, address = @address, type
= @type
where id = @studentID
update NonGucianStudent
set firstName = @firstName, lastName = @lastName, address = @address, type
= @type
where id = @studentID
update PostGradUser
set email = @email, password = @password
where id = @studentID
go
create proc addUndergradID
@studentID int, @undergradID varchar(10)
as
update GucianStudent
set undergradID = @undergradID
where id = @studentID
go
create proc ViewCoursesGrades
@studentID int
as
select grade
from NonGucianStudentTakeCourse
where sid = @studentID
go
create proc ViewCoursePaymentsInstall
@studentID int
as
select P.id as 'Payment Number', P.amount as 'Amount of
Payment',P.fundPercentage as 'Percentage of
fund for payment', P.noOfInstallments as 'Number of installments',
I.amount as 'Installment Amount',I.date as 'Installment date', I.done as
'Installment done or not'
from NonGucianStudentPayForCourse NPC
inner join Payment P
on NPC.paymentNo = P.id and NPC.sid = @studentID
inner join Installment I
on I.paymentId = P.id
go
create proc ViewThesisPaymentsInstall
@studentID int
as
select P.id as 'Payment Number', P.amount as 'Amount of Payment',
P.fundPercentage as
'Fund',P.noOfInstallments as 'Number of installments',
I.amount as 'Installment amount',I.date as 'Installment date', I.done as
'Installment done or not'
from GUCianStudentRegisterThesis G
inner join Thesis T
on G.serial_no = T.serialNumber and G.sid = @studentID
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
union
select P.id as 'Payment Number',P.amount as 'Amount of Payment',
P.fundPercentage as
'Fund',P.noOfInstallments as 'Number of installments',
I.amount as 'Installment amount',I.date as 'Installment date', I.done as
'Installment done or not'
from NonGUCianStudentRegisterThesis NG
inner join Thesis T
on NG.serial_no = T.serialNumber and NG.sid = @studentID
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
go
create proc ViewUpcomingInstallments
@studentID int
as
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Installment I
inner join NonGucianStudentPayForCourse NPC
on I.paymentId = NPC.paymentNo and NPC.sid = @studentID and I.date >
CURRENT_TIMESTAMP
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join GUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date > CURRENT_TIMESTAMP
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join NonGUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date > CURRENT_TIMESTAMP
go
create proc ViewMissedInstallments
@studentID int
as
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Installment I
inner join NonGucianStudentPayForCourse NPC
on I.paymentId = NPC.paymentNo and NPC.sid = @studentID and I.date <
CURRENT_TIMESTAMP and
I.done = '0'
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join GUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date < CURRENT_TIMESTAMP and I.done = '0'
union
select I.date as 'Date of Installment' ,I.amount as 'Amount'
from Thesis T
inner join Payment P
on T.payment_id = P.id
inner join Installment I
on I.paymentId = P.id
inner join NonGUCianStudentRegisterThesis G
on G.serial_no = T.serialNumber and G.sid = @studentID
where I.date < CURRENT_TIMESTAMP and I.done = '0'
go
create proc AddProgressReport
@thesisSerialNo int, @progressReportDate date, @studentID
int,@progressReportNo int
as
declare @gucian int
if(exists(
select id
from GucianStudent
where id = @studentID
))
begin
set @gucian = '1'
end
else
begin
set @gucian = '0'
end
if(@gucian = '1')
begin
insert into GUCianProgressReport
values(@studentID,@progressReportNo,@progressReportDate,null,null,null,@thesisSerialNo,null)
end
else
begin
insert into NonGUCianProgressReport
values(@studentID,@progressReportNo,@progressReportDate,null,null,null,@thesisSerialNo,null)
end
go
create proc FillProgressReport
@thesisSerialNo int, @progressReportNo int, @state int, @description
varchar(200),@studentID int
as
declare @gucian bit
if(exists(
select * from GucianStudent
where id = @studentID
))
begin
set @gucian = '1'
end
else
begin
set @gucian = '0'
end
if(@gucian = '1')
begin
update GUCianProgressReport
set state = @state, description = @description, date = CURRENT_TIMESTAMP
where thesisSerialNumber = @thesisSerialNo and sid = @studentID and no =
@progressReportNo
end
else
begin
update NonGUCianProgressReport
set state = @state, description = @description, date = CURRENT_TIMESTAMP
where thesisSerialNumber = @thesisSerialNo and sid = @studentID and no =
@progressReportNo
end
go
create proc ViewEvalProgressReport
@thesisSerialNo int, @progressReportNo int,@studentID int
as
select eval
from GUCianProgressReport
where sid = @studentID and thesisSerialNumber = @thesisSerialNo and no =
@progressReportNo
union
select eval
from NonGUCianProgressReport
where sid = @studentID and thesisSerialNumber = @thesisSerialNo and no =
@progressReportNo
go
create proc addPublication
@title varchar(50), @pubDate datetime, @host varchar(50), @place
varchar(50), @accepted bit
as
insert into Publication values(@title,@pubDate,@place,@accepted,@host)
go
create proc linkPubThesis
@PubID int, @thesisSerialNo int
as
insert into ThesisHasPublication values(@thesisSerialNo,@PubID)
go
create trigger deleteSupervisor
on Supervisor
instead of delete
as
delete from GUCianProgressReport where supid in (select id from deleted)
delete from NonGUCianProgressReport where supid in (select id from
deleted)
delete from GUCianStudentRegisterThesis where supid in (select id from
deleted)
delete from NonGUCianStudentRegisterThesis where supid in (select id from
deleted)
delete from Supervisor where id in (select id from deleted)
delete from PostGradUser where id in (select id from deleted)




/*INsertions*/
/*PAYMENTS SA7*/
INSERT INTO Payment VALUES(100000, 4, 30 ),
(30000, 3, 10),(5000, 1, 0);

/*Thesis SA7*/
insert into Thesis (field,type,title,startDate,endDate,defenseDate,grade,payment_id,noExtension)
			 values('AI','Master','AI Robots','2019-3-5','2021-4-3','2022-5-1',2.5,1,1),
				   ('History','Master','What is Operation Pastorius?','2019-3-6','2021-5-3','2022-5-2',1.25,2,2),
				   ('Criminal law','Master','What countries have the worst legal systems?','2021-3-7','2021-3-3','2022-5-3',2.45,3,3),
				   ('Technology','Master','Evidence of water and possible life on Mars', '2019-3-28','2021-11-3','2022-5-4',2.25,2,3),
				   ('Economics','Master','Influence of volatility of world commodity markets on financial stability','2019-3-16','2021-4-23','2022-5-5',1.25,2,2),
				   ('Business','Master','Is multitasking an effective method of work?','2019-3-15','2021-4-3','2022-5-6',1.1,2,1),
				   ('Education','Master','The efficiency of self-regulated schooling', '2019-3-5', '2021-4-3','2022-5-7',0.9,3,1),
				   ('Cs','Master','Development of a mobile application','2019-3-5','2021-4-3','2022-5-8',2.95,1,0),
				   ('Art and Culture','Master','Does Cultural Identity Influence the Creation of Art?','2019-3-5','2021-4-3','2022-5-9',1.35,1,0),
				   ('CS','Master','Signal processing algorithms for compact microphone arrays','2019-12-15','2021-4-13','2022-5-10',1.15,2,0),
				   ('CS','Master','Development of methods and informational technologies for modeling and recognition of emotions','2019-3-22','2021-12-3','2022-5-11',1.25,3,1),
				   ('CS','Master','Development of an automated system for managing food purchases','2019-3-5','2021-7-13','2022-5-12',1.35,2,2),
				   ('Education','Master','Metal detectors at schools','2019-3-5','2021-2-14','2022-5-13',1.45,1,3),
				   ('Education','Master','What are the most successful anti-bullying programs at school?','2019-3-5','2021-5-11','2022-5-14',1.55,2,1),
				   ('Economics','Master','The company objectives and their reflection in a pricing policy','2019-3-5','2021-12-2','2022-5-15',1.65,2,1),
				   ('Machine Learning','PHD',' 3D scene reconstruction from images','2019-3-5','2021-4-3','2022-5-17',2,2,0),
				   ('AI','PHD','Natural Language Processing','2019-3-6','2021-4-3','2022-5-18',2.6,3,1),
				   ('Robotics','PHD','AI Robots','2019-3-7','2021-4-3','2022-5-19',2.5,3,2),
				   ('Robotics','PHD','Computer Vision','2019-3-8','2021-4-3','2022-5-20',2.7,1,1),
				   ('AI','PHD','Deep semi-supervised methods for underwater target classification','2019-3-9','2021-4-3','2022-5-21',0.8,1,0),
				   ('Robotics','PHD','Testing Robotics and Autonomous Systems Using Search-based Techniques','2019-3-15','2021-4-3','2022-5-22',0.9,1,0),
				   ('AI','PHD','Artificial Intelligence and Machine Learning for Biomedical Data','2019-3-5','2021-4-3','2022-5-23',0.9,1,0),
				   ('AI','PHD',' Responsible AI for Health and Social Care','2019-3-5','2021-3-26','2022-5-24',3,2,2),
				   ('Cybersecurity','PHD',' Machine learning based cyber security in IoT appliances','2019-5-8','2021-3-4','2022-5-25',1.5,2,3),
				   ('Automation','PHD','Machine learning for Autonomous and Interconnected Vehicles','2019-5-13','2021-3-4','2022-5-26',2.5,2,3),
				   ('Machine Learning','PHD',' Application of machine learning techniques to the reconfiguration of automated systems','2019-5-28','2021-4-14','2022-5-27',2.5,2,1),
				   ('Automation','PHD','Optimization algorithms for electric cars','2019-3-24','2021-5-25','2022-6-9',2.3,1,2),
				   ('Robotics','PHD','Trustworthy Security Systems','2019-5-3','2021-4-3','2022-5-30',2.1,2,0),
				   ('CyberSecurity','PHD','Cyber Attacks Mitigation: Detecting Malicious Activities in Network Traffic','2019-5-23','2021-4-26','2022-3-25',2.66,2,0),
				   ('Economics','PHD','A Comparative Study of the Relationship between Life Satisfaction in China and Japan','2019-4-23','2021-4-7','2022-4-7',1.9,2,0);

insert into PostGradUser VALUES('Abdelrahman.salem@gmail.com', '1'),
							('ali.mohamed@hotmail.com', '2'),
							('ahmed.mohamed@hotmail.com', '3'),	
							('ali.mahmoud@outlook.com', '4'),	
							('zeiad.ahmed@hotmail.com', '5'),	
							('mahmoud.ali@hotmail.com', '6'),	
							('mostafa.tamer@hotmail.com', '7'),	
							('hussien.tamer@hotmail.com', '8'),	
							('mohamed.tamer@hotmail.com', '9'),
							('mohamed.hesham@hotmail.com', '10'),	
							('ali.tamer@hotmail.com', '11'),	
							('mohamed.hazem@hotmail.com', '12'),
							('mohamed.hassan@hotmail.com','13'),
							('ahmedmohamed@gmail.com','14'),
							('ahmedhussine@gmail.com','15'),					
							('ali@hotmail.com','16'),
							('ahmedahmed@gmail.com','17'),
							('ahmed@gmail.com','18');	
/*Defenses*/
INSERT INTO DEFENSE VALUES(10, '2022-5-10', 'H13', 1.15),
(30, '2022-4-7', 'Exam Hall 2', 1.9),(29, '2020-3-25', 'Exam Hall 1', 2.66);

/*INSTALLMENTS sa7*/
INSERT INTO Installment VALUES('2021-12-1', 1, 25000, 1),
('2022-2-11', 1, 25000, 0),('2022-4-11', 1, 25000, 0),('2022-1-6', 1, 25000, 0),
('2021-1-12', 2, 10000, 1),('2022-2-1', 2, 10000, 0),('2022-4-1', 2, 10000, 1),
('2020-5-3', 3, 5000, 1), ('2020-5-30', 3, 5000, 1);


/*sa7*/
insert into GucianStudent values(1,'Abdelrahman','salem','Gucian','engineering','cairo',1.3,43252),
                                (2,'Ali','mohamed','Gucian','pharmacy','cairo',1.4,55332),
                                (3,'ahmed','mohamed','Gucian','engineering','cairo',2.4,498765),
                                (4,'Ali','mahmoud','Gucian','mangement','alexandria',1.4,498765);
								select * from PostGradUser
								select * from GucianStudent
/*sa7*/ 
			/*sa7 sup*/
insert into Supervisor(supid,name,email,faculty )
            values(13,'ahmed','ahmed@gmail.com','Engineering'),
			      (14,'mohamed','mohamed@gmai.com','Applied Arts'),
				  (15,'zeiad','zeiad@gmail.com','Mangement');
				  
/*GUCianProgressReport*/
insert into GUCianProgressReport (sid,num,date,eval,state,thesisSerialNumber,supid)
                           Values(1, 5, '2019-3-5', 3, 15, 20, 13),
                                 (2, 8,'2020-12-3', 2, 15, 30, 14),
                                 (3, 11, '2001-9-20', 1, 10, 10, 15);
/*sa7*/
INSERT INTO NonGucianStudent values (9,'mohamed','tamer','non-gucian','economics','cairo',2.1),
(8,'hussien','tamer','non-gucian','law','cairo',2.1),
(5,'zeiad','ahmed','non-gucian','law','ismailia',1.5),
(6,'mahmoud','ali','non-gucian','mascom','cairo',1.2);

/*NonGUCianProgressReport*/
insert into NonGUCianProgressReport (sid,num,date,eval,state,thesisSerialNumber,supid)
                           Values(9, 14, '2007-2-2', 6, 5, 11, 13),
                                 (5, 17,'2020-9-3', 5, 50, 12, 14),
                                 (6, 20, '2001-4-12', 4, 100, 13, 15);

/**//*sa7*/
insert into Admin (id)
            values(12);

				  /*sa7*/
insert into Course(fees,creditHours,courseCode)
            values(6000,6,'CSEN501'),
                  (5400,5,'CSEN605'),
                  (5000,4,'CSEN502');
/* grade rounded*/ 
insert into NonGucianStudentTakeCourse(sid,cid,grade)
            values(9,1,1.4),
                  (5,2,2.1),
                  (8,3,1.7);
/*Examiner*/

INSERT INTO Examiner VALUES(16,'Ahmed Khaled', 'Computer Engineering', 1),
(17,'John cilia', 'Computer Engineering', 0),(18,'Mostafa el shirbiny', 'M. Engineering', 1);
select * from Examiner

insert into ExaminerEvaluateDefense(date,serialNumber,eid) Values('2022-05-10 00:00:00.000',10,17),
                                          ('2020-03-25 00:00:00.000',29,16),
                                          ('2022-04-07 00:00:00.000',30,18);

										 /* select * from Examiner
										  select * from DEFENSE
										  select * from ExaminerEvaluateDefense*/
insert into Publication(title, date, place, accepted, host)
		values('Is multitasking an effective method of work?', '2023-6-5', 'GUC', 0 , 'GUC ARATRONICS'),
		('What is Operation Pastorius?','2024-6-3', 'BUE', 1 , 'Dr. Milad');