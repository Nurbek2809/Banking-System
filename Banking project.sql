create database Banking_System 
go
use Banking_System
/*=========================================
                 TITLE
NAME   : Ashuraliyev Nurbek 
DATE   : 26.01.2025
PORJECT: Banking System 
===========================================*/


-- ================ SCHEMA =====================
go
create schema core_banking;
go
create schema digital_banking;
go
create schema loans_credit;
go
create schema compliance;
go
create schema human_resources;
go
create schema investments;
go
create schema insurance_security;
go
create schema merchant_service;
go

-- core banking tables
-- ================= CORE BANKING =================
create table core_banking.customers (
    customerid int primary key,
    fullname varchar(100) not null,
    dob date not null,
    email varchar(100) not null,
    phonenumber varchar(20),
    address varchar(255),
    nationalid varchar(100),
    taxid varchar(20) unique,
    employmentstatus varchar(20),
    annualincome decimal(20,2),
    createdat date,
    updatedat date 
);

create table core_banking.accounts (
    accountid int primary key,
    customerid int,
    accounttype varchar(50),
    balance decimal(18,2),
    currency varchar(10),
    status varchar(50),
    branchid int,
    createddate date
);

create table core_banking.transactions (
    transactionid int  primary key,
    accountid int,
    transactiontype varchar(50),
    amount decimal(20,2),
    currency varchar(50),
    date date,
    status varchar(50),
    referenceno varchar(50)
);

create table core_banking.branches (
    branchid int primary key,
    branchname varchar(100),
    address varchar(255),
    city varchar(50),
    state varchar(50),
    country varchar(50),
    managerid int,
    contactnumber varchar(20)
);

create table core_banking.employees (
    employeeid int primary key,
    branchid int,
    fullname varchar(100),
    position varchar(50),
    department varchar(50),
    salary decimal(20,2),
    hiredate date,
    status varchar(50)
);

-- ================= DIGITAL BANKING =================

create table digital_banking.creditcards (
    cardid int primary key,
    customerid int,
    cardnumber varchar(20),
    cardtype varchar(50),
    cvv varchar(20),
    expirydate date,
    limit decimal(20,2),
    status varchar(50)
);

create table digital_banking.creditcardtransactions (
    transactionid int primary key,
    cardid int,
    merchant varchar(100),
    amount decimal(20,2),
    currency varchar(50),
    date date,
    status varchar(50)
);

create table digital_banking.onlinebankingusers (
    userid int primary key,
    customerid int,
    username varchar(50),
    passwordhash varchar(255),
    lastlogin date
);

create table digital_banking.billpayments (
    paymentid int primary key,
    customerid int,
    billername varchar(100),
    amount decimal(20,2),
    date date,
    status varchar(50)
);

create table digital_banking.mobilebankingtransactions (
    transactionid int primary key,
    customerid int,
    deviceid varchar(50),
    appversion varchar(50),
    transactiontype varchar(50),
    amount decimal(20,2),
    date date
);

-- ================= LOANS & CREDIT =================

create table loans_credit.loans (
    loanid int primary key,
    customerid int,
    loantype varchar(50),
    amount decimal(20,2),
    interestrate decimal(10,2),
    startdate date,
    enddate date,
    status varchar(50)
);

create table loans_credit.loanpayments (
    paymentid int primary key,
    loanid int,
    amountpaid decimal(20,2),
    paymentdate date,
    remainingbalance decimal(20,2)
);

create table loans_credit.creditscores (
    customerid int,
    credit_score int,
    updatedat date
);

create table loans_credit.debtcollection (
    debtid int primary key,
    customerid int,
    amountdue decimal(20,2),
    duedate date,
    collectorassigned varchar(100)
);

-- ================= COMPLIANCE & RISK =================

create table compliance.kyc (
    kycid int primary key,
    customerid int,
    documenttype varchar(50),
    documentnumber varchar(50),
    verifiedby varchar(100)
);

create table compliance.frauddetection (
    fraudid int primary key,
    customerid int,
    transactionid int,
    risklevel varchar(50),
    reporteddate date
);

create table compliance.aml (
    caseid int primary key,
    customerid int,
    casetype varchar(50),
    status varchar(50),
    investigatorid int
);

create table compliance.regulatoryreports (
    reportid int primary key,
    reporttype varchar(50),
    submissiondate date
);

-- ================= HUMAN RESOURCES =================

create table human_resources.departments (
    departmentid int primary key,
    departmentname varchar(50),
    managerid int
);

create table human_resources.salaries (
    salaryid int primary key,
    employeeid int,
    basesalary decimal(12,2),
    bonus decimal(12,2),
    deductions decimal(12,2),
    paymentdate date
);

create table human_resources.employeeattendance (
    attendanceid int primary key,
    employeeid int,
    checkintime date,
    checkouttime date,
    totalhours decimal(10,2)
);

-- ================= INVESTMENTS =================

create table investments.investments (
    investmentid int primary key,
    customerid int,
    investmenttype varchar(50),
    amount decimal(18,2),
    roi decimal(10,2),
    maturitydate date
);

create table investments.stocktradingaccounts (
    accountid int primary key,
    customerid int,
    brokeragefirm varchar(100),
    totalinvested decimal(20,2),
    currentvalue decimal(20,2)
);

create table investments.foreignexchange (
    fxid int primary key,
    customerid int,
    currencypair varchar(10),
    exchangerate decimal(20,6),
    amountexchanged decimal(20,2)
);

-- ================= INSURANCE & SECURITY =================

create table insurance_security.insurancepolicies (
    policyid int primary key,
    customerid int,
    insurancetype varchar(50),
    premiumamount decimal(20,2),
    coverageamount decimal(20,2)
);

create table insurance_security.claims (
    claimid int primary key,
    policyid int,
    claimamount decimal(20,2),
    status varchar(50),
    fileddate date
);

create table insurance_security.useraccesslogs (
    logid int primary key,
    userid int,
    actiontype varchar(50),
    timestamp date
);

create table insurance_security.cybersecurityincidents (
    incidentid int primary key,
    affectedsystem varchar(100),
    reporteddate date,
    resolutionstatus varchar(50)
);

-- ================= MERCHANT SERVICES =================

create table merchant_service.merchants (
    merchantid int primary key,
    merchantname varchar(100),
    industry varchar(50),
    location varchar(255),
    customerid int
);

create table merchant_service.merchanttransactions (
    transactionid int primary key,
    merchantid int,
    amount decimal(20,2),
    paymentmethod varchar(50),
    date date
);

go

---------------- ADDING FOREIGN KEYS 

-- ================= core banking =================

alter table core_banking.accounts
add foreign key (customerid) references core_banking.customers(customerid),
    foreign key (branchid) references core_banking.branches(branchid);
go

alter table core_banking.transactions
add foreign key (accountid) references core_banking.accounts(accountid);
go

alter table core_banking.employees
add foreign key (branchid) references core_banking.branches(branchid);
go


-- ================= digital banking =================

alter table digital_banking.creditcards
add foreign key (customerid) references core_banking.customers(customerid);
go

alter table digital_banking.creditcardtransactions
add foreign key (cardid) references digital_banking.creditcards(cardid);
go

alter table digital_banking.onlinebankingusers
add foreign key (customerid) references core_banking.customers(customerid);
go

alter table digital_banking.billpayments
add foreign key (customerid) references core_banking.customers(customerid);
go

alter table digital_banking.mobilebankingtransactions
add foreign key (customerid) references core_banking.customers(customerid);
go


-- ================= loans & credit =================

alter table loans_credit.loans
add foreign key (customerid) references core_banking.customers(customerid);
go

alter table loans_credit.loanpayments
add foreign key (loanid) references loans_credit.loans(loanid);
go

alter table loans_credit.creditscores
add foreign key (customerid) references core_banking.customers(customerid);
go

alter table loans_credit.debtcollection
add foreign key (customerid) references core_banking.customers(customerid);
go


-- ================= compliance & risk =================

alter table compliance.kyc
add foreign key (customerid) references core_banking.customers(customerid);
go

alter table compliance.frauddetection
add foreign key (customerid) references core_banking.customers(customerid),
    foreign key (transactionid) references core_banking.transactions(transactionid);
go

alter table compliance.aml
add foreign key (customerid) references core_banking.customers(customerid);
go


-- ================= human resources =================

alter table human_resources.salaries
add foreign key (employeeid) references core_banking.employees(employeeid);
go

alter table human_resources.employeeattendance
add foreign key (employeeid) references core_banking.employees(employeeid);
go

alter table human_resources.departments
add foreign key (managerid) references core_banking.employees(employeeid);
go


-- ================= investments =================

alter table investments.investments
add foreign key (customerid) references core_banking.customers(customerid);
go

alter table investments.stocktradingaccounts
add foreign key (customerid) references core_banking.customers(customerid);
go

alter table investments.foreignexchange
add foreign key (customerid) references core_banking.customers(customerid);
go


-- ================= insurance & security =================

alter table insurance_security.insurancepolicies
add foreign key (customerid) references core_banking.customers(customerid);
go

alter table insurance_security.claims
add foreign key (policyid) references insurance_security.insurancepolicies(policyid);
go

alter table insurance_security.useraccesslogs
add foreign key (userid) references digital_banking.onlinebankingusers(userid);
go


-- ================= merchant services =================

alter table merchant_service.merchants
add foreign key (customerid) references core_banking.customers(customerid);
go

alter table merchant_service.merchanttransactions
add foreign key (merchantid) references merchant_service.merchants(merchantid);


/*--------------------------------------------------
creating Temp table for bridge 
--------------------------------------------------*/

/* ================= CORE BANKING ================= */

/* ================= core banking ================= */
create table #customers (
    customerid int primary key,
    fullname varchar(100),
    dob date,
    email varchar(100),
    phonenumber varchar(30),
    address varchar(200),
    nationalid varchar(50),
    taxid varchar(50),
    employmentstatus varchar(50),
    annualincome decimal(15,2),
    createdat datetime,
    updatedat datetime
);

create table #branches (
    branchid int primary key,
    branchname varchar(100),
    address varchar(200),
    city varchar(100),
    state varchar(100),
    country varchar(100),
    managerid int,
    contactnumber varchar(30)
);

create table #employees (
    employeeid int primary key,
    branchid int,
    fullname varchar(100),
    position varchar(100),
    department varchar(100),
    salary decimal(15,2),
    hiredate date,
    status varchar(50)
);

create table #accounts (
    accountid int primary key,
    customerid int,
    accounttype varchar(50),
    balance decimal(18,2),
    currency varchar(10),
    status varchar(50),
    branchid int,
    createddate date
);

create table #transactions (
    transactionid int primary key,
    accountid int,
    transactiontype varchar(50),
    amount decimal(18,2),
    currency varchar(10),
    date datetime,
    status varchar(50),
    referenceno varchar(50),
    location varchar(100) null
);

/* ================= digital banking & payments ================= */
create table #creditcards (
    cardid int primary key,
    customerid int,
    cardnumber varchar(20),
    cardtype varchar(50),
    cvv int,
    expirydate date,
    limit decimal(15,2),
    status varchar(50)
);

create table #creditcardtransactions (
    transactionid int primary key,
    cardid int,
    merchant varchar(150),
    amount decimal(15,2),
    currency varchar(10),
    date datetime,
    status varchar(50)
);

create table #onlinebankingusers (
    userid int primary key,
    customerid int,
    username varchar(100),
    passwordhash varchar(200),
    lastlogin datetime
);

create table #billpayments (
    paymentid int primary key,
    customerid int,
    billername varchar(100),
    amount decimal(15,2),
    date date,
    status varchar(50)
);

create table #mobilebankingtransactions (
    transactionid int primary key,
    customerid int,
    deviceid varchar(50),
    appversion varchar(50),
    transactiontype varchar(50),
    amount decimal(15,2) null,
    date datetime
);

/* ================= loans & credit ================= */
create table #loans (
    loanid int primary key,
    customerid int,
    loantype varchar(50),
    amount decimal(18,2),
    interestrate decimal(5,2),
    startdate date,
    enddate date,
    status varchar(50)
);

create table #loanpayments (
    paymentid int primary key,
    loanid int,
    amountpaid decimal(18,2),
    paymentdate date,
    remainingbalance decimal(18,2)
);

create table #creditscores (
    customerid int primary key,
    creditscore int,
    updatedat date
);

create table #debtcollection (
    debtid int primary key,
    customerid int,
    amountdue decimal(15,2),
    duedate date,
    collectorassigned int
);

/* ================= compliance & risk ================= */
create table #kyc (
    kycid int primary key,
    customerid int,
    documenttype varchar(50),
    documentnumber varchar(50),
    verifiedby int
);

create table #frauddetection (
    fraudid int primary key,
    customerid int,
    transactionid int,
    risklevel varchar(50),
    reporteddate datetime
);

create table #amlcases (
    caseid int primary key,
    customerid int,
    casetype varchar(100),
    status varchar(50),
    investigatorid int
);

create table #regulatoryreports (
    reportid int primary key,
    reporttype varchar(100),
    submissiondate date
);

/* ================= human resources & payroll ================= */
create table #departments (
    departmentid int primary key,
    departmentname varchar(100),
    managerid int
);

create table #salaries (
    salaryid int primary key,
    employeeid int,
    basesalary decimal(15,2),
    bonus decimal(15,2),
    deductions decimal(15,2),
    paymentdate date
);

create table #employeeattendance (
    attendanceid int primary key,
    employeeid int,
    checkintime datetime,
    checkouttime datetime,
    totalhours decimal(5,2)
);

/* ================= investments & treasury ================= */
create table #investments (
    investmentid int primary key,
    customerid int,
    investmenttype varchar(100),
    amount decimal(18,2),
    roi decimal(10,2),
    maturitydate date
);

create table #stocktradingaccounts (
    accountid int primary key,
    customerid int,
    brokeragefirm varchar(100),
    totalinvested decimal(18,2),
    currentvalue decimal(18,2)
);

create table #foreignexchange (
    fxid int primary key,
    customerid int,
    currencypair varchar(20),
    exchangerate decimal(15,4),
    amountexchanged decimal(18,2)
);

/* ================= insurance & security ================= */
create table #insurancepolicies (
    policyid int primary key,
    customerid int,
    insurancetype varchar(100),
    premiumamount decimal(15,2),
    coverageamount decimal(18,2)
);

create table #claims (
    claimid int primary key,
    policyid int,
    claimamount decimal(18,2),
    status varchar(50),
    fileddate date
);

create table #useraccesslogs (
    logid int primary key,
    userid int,
    actiontype varchar(100),
    timestamp datetime
);

create table #cybersecurityincidents (
    incidentid int primary key,
    affectedsystem varchar(100),
    reporteddate date,
    resolutionstatus varchar(50)
);

/* ================= merchant services ================= */
create table #merchants (
    merchantid int primary key,
    merchantname varchar(150),
    industry varchar(100),
    location varchar(200),
    customerid int null
);

create table #merchanttransactions (
    transactionid int primary key,
    merchantid int,
    amount decimal(15,2),
    paymentmethod varchar(50),
    date datetime
);


--------------------------------------------------------

--================= BULK INSERT ========================

--------------------------------------------------------


/* ================= CORE BANKING ================= */
bulk insert #customers
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\Customers_unique.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #branches
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\Branches.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #employees
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\Employees.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #accounts
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\Accounts.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #transactions
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\Transactions.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

/* ================= DIGITAL BANKING & PAYMENTS ================= */
bulk insert #creditcards
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\CreditCards.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #creditcardtransactions
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\CreditCardTransactions.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #onlinebankingusers
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\OnlineBankingUsers.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #billpayments
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\BillPayments.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #mobilebankingtransactions
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\MobileBankingTransactions.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

/* ================= LOANS & CREDIT ================= */
bulk insert #loans
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\Loans.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #loanpayments
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\LoanPayments.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #creditscores
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\CreditScores.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #debtcollection
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\DebtCollection.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

/* ================= COMPLIANCE & RISK ================= */
bulk insert #kyc
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\KYC.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #frauddetection
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\FraudDetection.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #amlcases
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\AMLCases.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #regulatoryreports
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\RegulatoryReports.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

/* ================= HUMAN RESOURCES & PAYROLL ================= */
bulk insert #departments
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\Departments.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #salaries
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\Salaries.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #employeeattendance
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\EmployeeAttendance.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

/* ================= INVESTMENTS & TREASURY ================= */
bulk insert #investments
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\Investments.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #stocktradingaccounts
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\StockTradingAccounts.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #foreignexchange
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\ForeignExchange.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

/* ================= INSURANCE & SECURITY ================= */
bulk insert #insurancepolicies
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\InsurancePolicies.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #claims
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\Claims.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #useraccesslogs
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\UserAccessLogs.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #cybersecurityincidents
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\CyberSecurityIncidents.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

/* ================= MERCHANT SERVICES ================= */
bulk insert #merchants
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\Merchants.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);

bulk insert #merchanttransactions
from 'C:\Users\nashu\OneDrive\Desktop\python for banking project\banking_dataset_safe\MerchantTransactions.csv'
with (firstrow = 2, fieldterminator = '^', rowterminator = '\n', codepage = '65001', keepnulls);


--==============================================
-- MERGE: Move data from staging to main tables 
--=============================================


---------------CORE BANKING---------------


merge core_banking.customers as target 
using #customers as source 
on target.customerid = source.customerid 
when matched then 
	update set
		fullname = source.fullname,
		dob = source.dob,
		email = source.email,
		phonenumber = source.phonenumber,
		address = source.address,
		nationalid = source.nationalid,
		taxid = source.taxid,
		employmentstatus = source.employmentstatus,
		annualincome = source.annualincome,
		createdat = source.createdat,
		updatedat = source.updatedat
when not matched then 
	insert (customerid,fullname,dob,email,phonenumber,address,nationalid,taxid,employmentstatus,annualincome,createdat,updatedat)
	values (source.customerid,source.fullname,source.dob,source.email,source.phonenumber,source.address,source.nationalid,source.taxid,source.employmentstatus,source.annualincome,source.createdat,source.updatedat);

merge core_banking.employees trt
using #employees src
on trt.employeeid=src.employeeid
when matched then 
	update set 
		branchid=src.branchid,
		fullname=src.fullname,
		position=src.position,
		department=src.department,
		salary=src.salary,
		hiredate=src.hiredate,
		status=src.status
when not matched then 
	insert (employeeid,branchid,fullname,position,department,salary,hiredate,status)
	values (src.employeeid,src.branchid,src.fullname,src.position,src.department,src.salary,src.hiredate,src.status);

merge core_banking.branches trt
using #branches as src
on trt.branchid=src.branchid
when matched then 
	update set 
		branchname=src.branchname,
		address=src.address,
		city=src.city,
		state=src.state,
		country=src.country,
		managerid=src.managerid,
		contactnumber=src.contactnumber
when not matched then 
	insert (branchid,branchname,address,city,state,country,managerid,contactnumber)
	values (src.branchid,src.branchname,src.address,src.city,src.state,src.country,src.managerid,src.contactnumber);

merge core_banking.accounts as trt
using #accounts as src
on trt.accountid=src.accountid
when matched then 
	update set 
		customerid=src.customerid,
		accounttype=src.accounttype,
		balance=src.balance,
		currency=src.currency,
		status=src.status,
		branchid=src.branchid,
		createddate=src.createddate
when not matched then
	insert (accountid,customerid,accounttype,balance,currency,status,branchid,createddate)
	values (src.accountid,src.customerid,src.accounttype,src.balance,src.currency,src.status,src.branchid,src.createddate);

merge core_banking.transactions as trt
using #transactions as src
on trt.transactionid=src.transactionid
when matched then 
	update set 
		accountid=src.accountid,
		transactiontype=src.transactiontype,
		amount=src.amount,
		currency=src.currency,
		date=src.date,
		status=src.status,
		referenceno=src.referenceno
when not matched then 
	insert (transactionid,accountid,transactiontype,amount,currency,date,status,referenceno)
	values (src.transactionid,src.accountid,src.transactiontype,src.amount,src.currency,src.date,src.status,src.referenceno);


------------------ DIGITAL BANKING --------------


merge digital_banking.creditcards as trt
using #creditcards as src
on trt.cardid=src.cardid
when matched then 
	update set 
		customerid=src.customerid,
		cardnumber=src.cardnumber,
		cardtype=src.cardtype,
		cvv=src.cvv,
		expirydate=src.expirydate,
		limit=src.limit,
		status=src.status
when not matched then 
	insert (cardid,customerid,cardnumber,cardtype,cvv,expirydate,limit,status)
	values (src.cardid,src.customerid,src.cardnumber,src.cardtype,src.cvv,expirydate,src.limit,src.status);

merge digital_banking.creditcardtransactions as trt
using #creditcardtransactions as src
on trt.transactionid=src.transactionid
when matched then 
	update set 
		cardid=src.cardid,
		merchant=src.cardid,
		amount=src.amount,
		currency=src.currency,
		date=src.date,
		status=src.status
when not matched then 
	insert (transactionid,cardid,merchant,amount,currency,date,status)
	values (src.transactionid,src.cardid,src.merchant,src.amount,src.currency,src.date,src.status);

merge digital_banking.onlinebankingusers as trt
using #onlinebankingusers as src
on trt.userid=src.userid
when matched then 
	update set 
		customerid=src.customerid,
		username=src.username,
		passwordhash=src.passwordhash,
		lastlogin=src.lastlogin
when not matched then 
	insert (userid,customerid,username,passwordhash,lastlogin)
	values (src.userid,src.customerid,src.username,src.passwordhash,src.lastlogin);

merge digital_banking.billpayments as trt 
using #billpayments as src 
on trt.paymentid=src.paymentid
when matched then 
	update set 
		customerid=src.customerid,
		billername=src.billername,
		amount=src.amount,
		date=src.date,
		status=src.status
when not matched then 
	insert (paymentid,customerid,billername,amount,date,status)
	values (src.paymentid,src.customerid,src.billername,src.amount,src.date,src.status);

merge digital_banking.mobilebankingtransactions as trt
using #mobilebankingtransactions as src
on trt.transactionid=src.transactionid
when matched then 
	update set 
		customerid=src.customerid,
		deviceid=src.deviceid,
		appversion=src.appversion,
		transactiontype=src.transactiontype,
		amount=src.amount,
		date=src.date
when not matched then 
	insert (transactionid,customerid,deviceid,appversion,transactiontype,amount,date)
	values (src.transactionid,src.customerid,src.deviceid,src.appversion,src.transactiontype,src.amount,src.date);


---------------------- LOANS --------------------


merge loans_credit.loans as trt
using #loans as src 
on trt.loanid=src.loanid
when matched then
	update set
		customerid=src.customerid,
		loantype=src.loantype,
		amount=src.amount,
		interestrate=src.interestrate,
		startdate=src.startdate,
		enddate=src.enddate,
		status=src.status
when not matched then 
	insert (loanid,customerid,loantype,amount,interestrate,startdate,enddate,status)
	values (src.loanid,src.customerid,src.loantype,src.amount,src.interestrate,src.startdate,src.enddate,src.status);

merge loans_credit.loanpayments as trt
using #loanpayments as src
on trt.paymentid=src.paymentid
when matched then 
	update set 
		loanid=src.loanid,
		amountpaid=src.amountpaid,
		paymentdate=src.paymentdate,
		remainingbalance=src.remainingbalance
when not matched then 
	insert (paymentid,loanid,amountpaid,paymentdate,remainingbalance)
	values (src.paymentid,src.loanid,src.amountpaid,src.paymentdate,src.remainingbalance);

merge loans_credit.creditscores as trt
using #creditscores as src
on trt.customerid=src.customerid
when matched then 
	update set 
		credit_score=src.creditscore,
		updatedat=src.updatedat
when not matched then 
	insert (customerid,credit_score,updatedat)
	values (src.customerid,src.creditscore,src.updatedat);

merge loans_credit.debtcollection as trt
using #debtcollection as src 
on trt.debtid=src.debtid
when matched then 
	update set 
		customerid=src.customerid,
		amountdue=src.amountdue,
		duedate=src.duedate,
		collectorassigned=src.collectorassigned
when not matched then 
	insert (debtid,customerid,amountdue,duedate,collectorassigned)
	values (src.debtid,src.customerid,src.amountdue,src.duedate,src.collectorassigned);


-- ================= COMPLIANCE & RISK =================


merge compliance.kyc as trt
using #kyc as src
on src.kycid=trt.kycid
when matched then 
	update set 
		customerid=src.customerid,
		documenttype=src.documenttype,
		documentnumber=src.documentnumber,
		verifiedby=src.verifiedby
when not matched then 
	insert (kycid,customerid,documenttype,documentnumber,verifiedby)
	values (src.kycid,src.customerid,src.documenttype,src.documentnumber,src.verifiedby);

merge compliance.frauddetection as trt
using #frauddetection as src 
on trt.fraudid=src.fraudid
when matched then 
	update set 
		customerid=src.customerid,
		transactionid=src.transactionid,
		risklevel=src.risklevel,
		reporteddate=src.reporteddate
when not matched then 
	insert (fraudid,customerid,transactionid,risklevel,reporteddate)
	values (src.fraudid,src.customerid,src.transactionid,src.risklevel,src.reporteddate);

merge compliance.aml as trt
using #amlcases as src
on src.caseid=trt.caseid
when matched then 
	update set 
		customerid=src.customerid,
		casetype=src.casetype,
		status=src.status,
		investigatorid=src.investigatorid
when not matched then 
	insert (caseid,customerid,casetype,status,investigatorid)
	values (src.caseid,src.customerid,src.casetype,src.status,src.investigatorid);

merge compliance.regulatoryreports as trt
using #regulatoryreports as src 
on trt.reportid=src.reportid
when matched then 
	update set 
		reporttype=src.reporttype,
		submissiondate=src.submissiondate
when not matched then 
	insert (reportid,reporttype,submissiondate)
	values (src.reportid,src.reporttype,src.submissiondate);


-- ================= HUMAN RESOURCES =================



merge human_resources.departments as trt
using #departments as src
on src.departmentid=trt.departmentid
when matched then 
	update set 
		departmentname=src.departmentname,
		managerid=src.managerid
when not matched then 
	insert (departmentid,departmentname,managerid)
	values (src.departmentid,src.departmentname,src.managerid);

merge human_resources.salaries as trt 
using #salaries as src
on src.salaryid=trt.salaryid
when matched then 
	update set 
		employeeid=src.employeeid,
		basesalary=src.basesalary,
		bonus=src.bonus,
		deductions=src.deductions,
		paymentdate=src.paymentdate
when not matched then 
	insert (salaryid,employeeid,basesalary,bonus,deductions,paymentdate)
	values (src.salaryid,src.employeeid,src.basesalary,src.bonus,src.deductions,src.paymentdate);

merge human_resources.employeeattendance as trt 
using #employeeattendance as src
on src.attendanceid=trt.attendanceid
when matched then 
	update set 
		employeeid=src.employeeid,
		checkintime=src.checkintime,
		checkouttime=src.checkouttime,
		totalhours=src.totalhours
when not matched then 
	insert (attendanceid,employeeid,checkintime,checkouttime,totalhours)
	values (src.attendanceid,src.employeeid,src.checkintime,src.checkouttime,src.totalhours);


-- =================   INVESTMENTS   =================



merge investments.investments as trt
using #investments as src
on src.investmentid=trt.investmentid
when matched then 
	update set 
		customerid=src.customerid,
		investmenttype=src.investmenttype,
		amount=src.amount,
		roi=src.roi,
		maturitydate=src.maturitydate
when not matched then 
	insert (investmentid,customerid,investmenttype,amount,roi,maturitydate)
	values (src.investmentid,src.customerid,src.investmenttype,src.amount,src.roi,src.maturitydate);


merge investments.stocktradingaccounts trt
using #stocktradingaccounts as src 
on src.accountid=trt.accountid
when matched then 
	update set 
		customerid=src.customerid,
		brokeragefirm=src.brokeragefirm,
		totalinvested=src.totalinvested,
		currentvalue=src.currentvalue
when not matched then 
	insert (accountid,customerid,brokeragefirm,totalinvested,currentvalue)
	values (src.accountid,src.customerid,src.brokeragefirm,src.totalinvested,src.currentvalue);

merge investments.foreignexchange as trt
using #foreignexchange as src 
on src.fxid=trt.fxid
when matched then 
	update set 
		customerid=src.customerid,
		currencypair=src.currencypair,
		exchangerate=src.exchangerate,
		amountexchanged=src.amountexchanged
when not matched then 
	insert (fxid,customerid,currencypair,exchangerate,amountexchanged)
	values (src.fxid,src.customerid,src.currencypair,src.exchangerate,src.amountexchanged);


-- ================= INSURANCE & SECURITY =================


merge insurance_security.insurancepolicies as trt
using #insurancepolicies as src
on src.policyid=trt.policyid
when matched then 
	update set 
		customerid=src.customerid,
		insurancetype=src.insurancetype,
		premiumamount=src.premiumamount,
		coverageamount=src.coverageamount
when not matched then 
	insert (policyid,customerid,insurancetype,premiumamount,coverageamount)
	values (src.policyid,src.customerid,src.insurancetype,src.premiumamount,src.coverageamount);

merge insurance_security.claims as trt
using #claims as src
on src.claimid = trt.claimid
when matched then
    update set
        policyid = src.policyid,
        claimamount = src.claimamount,
        status = src.status,
        fileddate = src.fileddate
when not matched then
    insert (claimid, policyid, claimamount, status, fileddate)
    values (src.claimid, src.policyid, src.claimamount, src.status, src.fileddate);

merge insurance_security.useraccesslogs as trt
using #useraccesslogs as src
on src.logid = trt.logid
when matched then
    update set
        userid = src.userid,
        actiontype = src.actiontype,
        timestamp = cast(src.timestamp as date)
when not matched then
    insert (logid, userid, actiontype, timestamp)
    values (src.logid, src.userid, src.actiontype, cast(src.timestamp as date));

merge insurance_security.cybersecurityincidents as trt
using #cybersecurityincidents as src
on src.incidentid = trt.incidentid
when matched then
    update set
        affectedsystem = src.affectedsystem,
        reporteddate = src.reporteddate,
        resolutionstatus = src.resolutionstatus
when not matched then
    insert (incidentid, affectedsystem, reporteddate, resolutionstatus)
    values (src.incidentid, src.affectedsystem, src.reporteddate, src.resolutionstatus);


------------------MERCHANT SERVICE ------------------


merge merchant_service.merchants as trt
using #merchants as src
on src.merchantid = trt.merchantid
when matched then
    update set
        merchantname = src.merchantname,
        industry = src.industry,
        location = src.location,
        customerid = src.customerid
when not matched then
    insert (merchantid, merchantname, industry, location, customerid)
    values (src.merchantid, src.merchantname, src.industry, src.location, src.customerid);

merge merchant_service.merchanttransactions as trt
using #merchanttransactions as src
on src.transactionid = trt.transactionid
when matched then
    update set
        merchantid = src.merchantid,
        amount = src.amount,
        paymentmethod = src.paymentmethod,
        date = cast(src.date as date)
when not matched then
    insert (transactionid, merchantid, amount, paymentmethod, date)
    values (src.transactionid, src.merchantid, src.amount, src.paymentmethod, cast(src.date as date));





/*====================================================
					KPI larni topish
====================================================*/
/*
 Top 3 Customers with the Highest Total Balance Across All Accounts 
*/

create view vw_top3_customer_balance_usd
as
with cte as (
    select 'USD' as currency, cast(1 as decimal(18,6)) as rate_to_usd
    union all
    select 'EUR', 1.08
    union all
    select 'UZS', 0.000079
),
cte2 as (
    select
        c.customerid,
        c.fullname,
        c.email,
        c.phonenumber,
        c.address,
        a.balance * x.rate_to_usd as balance_usd
    from core_banking.customers c
    join core_banking.accounts a
        on c.customerid = a.customerid
    join cte x
        on x.currency = a.currency
)
select top 3
    customerid,
    fullname,
    phonenumber,
    email,
    sum(balance_usd) as total_balance_usd
from cte2
group by
    customerid,
    fullname,
    phonenumber,
    email
order by total_balance_usd desc;


select*from vw_top3_customer_balance_usd

/*
•	Customers Who Have More Than One Active Loan
*/

create or alter view vw_num_loans 
as
select 
	c.customerid,
	fullname,
	count(loanid) num_loan
from core_banking.customers c
join loans_credit.loans l on c.customerid=l.customerid
group by c.customerid,
	fullname
having count(loanid)>1

select*from vw_num_loans

/*
•Transactions That Were Flagged as Fraudulent                                                                                                 
*/

select*from compliance.frauddetection f
join core_banking.transactions t on t.transactionid=f.transactionid

/*
•Total Loan Amount Issued Per Branch
*/

create or alter view vw_total_loan 
as
select
    b.branchid,
    b.branchname,
    sum(l.amount) as total_loan_amount
from loans_credit.loans l
join core_banking.customers c
    on l.customerid = c.customerid
join core_banking.accounts a
    on c.customerid = a.customerid
join core_banking.branches b
    on a.branchid = b.branchid
group by
    b.branchid,
    b.branchname

select*from vw_total_loan

/*
 • Customers who made multiple large transactions (above $10,000) within a short time frame (less than 1 hour apart)
*/

create or alter view vw_transacing_in_1_hour as
select distinct
    c.customerid,
    c.fullname
from core_banking.transactions t1
join core_banking.transactions t2
    on t1.accountid = t2.accountid
    and t1.transactionid <> t2.transactionid
    and abs(datediff(minute, t1.date, t2.date)) <= 60
join core_banking.accounts a
    on t1.accountid = a.accountid
join core_banking.customers c
    on a.customerid = c.customerid
where
    t1.amount > 10000
    and t2.amount > 10000;

select*from vw_transacing_in_1_hour

/*
•Customers who have made transactions from different countries within 10 minutes, a common red flag for fraud.
*/
create or alter view vw_transaction_in_different_countries as
select distinct
    c.customerid,
    c.fullname
from core_banking.transactions t1
join core_banking.transactions t2
    on t1.accountid = t2.accountid
    and t1.transactionid <> t2.transactionid
    and abs(datediff(minute, t1.date, t2.date)) <= 10
join core_banking.accounts a
    on t1.accountid = a.accountid
join core_banking.branches b1
    on a.branchid = b1.branchid
join core_banking.branches b2
    on a.branchid = b2.branchid
join core_banking.customers c
    on a.customerid = c.customerid
where
    b1.country <> b2.country;

select*from vw_transaction_in_different_countries



