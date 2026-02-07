
CREATE TABLE AccountType
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(30)  NOT NULL ,
	DailyAnswerLimit     smallint  NULL 
);

ALTER TABLE AccountType
	ADD CONSTRAINT "XPKAccountType" PRIMARY KEY (ID);

CREATE TABLE AgeGroup
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(20)  NOT NULL ,
	LowAge               smallint  NOT NULL ,
	HighAge              integer  NOT NULL 
);

ALTER TABLE AgeGroup
	ADD CONSTRAINT "XPKAgeGroup" PRIMARY KEY (ID);

CREATE TABLE AppUser
( 
	IncomeRangeID        integer  NULL ,
	Age                  smallint  NULL ,
	Gender               char(1)  NULL ,
	ID                   bigserial  NOT NULL ,
	StatusID             serial  NULL ,
	LocationCodeIDOne    serial  NOT NULL   DEFAULT  0,
	UserRating           integer  NOT NULL   DEFAULT  0,
	AccountTypeID        serial  NOT NULL   DEFAULT  1,
	AccountTypeEffectiveDate timestamp  NOT NULL   DEFAULT  getdate(),
	AccountTypeEndDate   timestamp  NOT NULL   DEFAULT  1/1/2090,
	LastActionDatetime   timestamp  NULL ,
	QuestionsAnswered    integer  NULL ,
	QuestionsDeclined    integer  NULL ,
	QuestionsAsked       integer  NULL ,
	LightningAddress     varchar(255)  NULL ,
	NPubKey              varchar(64)  NOT NULL ,
	IsBotFlagged         bit  NOT NULL   DEFAULT  0,
	WalletProvider       varchar(50)  NULL 
);

ALTER TABLE AppUser
	ADD CONSTRAINT "XPKAppUser" PRIMARY KEY (ID);

CREATE TABLE AppUserDetail
( 
	ID                   bigserial  NOT NULL ,
	AppUserID            bigserial  NOT NULL ,
	DetailTypeID         serial  NOT NULL ,
	ValueDate            timestamp  NULL ,
	ValueString          varchar(100)  NULL ,
	ValueInteger         integer  NULL 
);

ALTER TABLE AppUserDetail
	ADD CONSTRAINT "XPKAppUserDetail" PRIMARY KEY (ID);

CREATE TABLE AppUserSubscribedTag
( 
	ID                   bigserial  NOT NULL ,
	AppUserID            bigserial  NOT NULL ,
	TagID                bigserial  NOT NULL 
);

ALTER TABLE AppUserSubscribedTag
	ADD CONSTRAINT "XPKAppUserSubscribedTag" PRIMARY KEY (ID);

CREATE TABLE CountryCode
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(20)  NOT NULL ,
	LocationCodeName     varchar(20)  NULL ,
	LocationCodeLength   varchar(20)  NULL ,
	DefaultLanguageID    serial  NULL 
);

ALTER TABLE CountryCode
	ADD CONSTRAINT "XPKCountryCode" PRIMARY KEY (ID);

CREATE TABLE DataType
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(20)  NULL ,
	IsString             bit  NOT NULL   DEFAULT  0
);

ALTER TABLE DataType
	ADD CONSTRAINT "XPKDataType" PRIMARY KEY (ID);

CREATE TABLE DetailType
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(30)  NOT NULL ,
	DataTypeID           serial  NOT NULL 
);

ALTER TABLE DetailType
	ADD CONSTRAINT "XPKDetailType" PRIMARY KEY (ID);

CREATE TABLE DimGroup
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(30)  NULL 
);

ALTER TABLE DimGroup
	ADD CONSTRAINT "XPKDimGroup" PRIMARY KEY (ID);

CREATE TABLE DimType
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(50)  NULL ,
	DimGroupID           serial  NULL 
);

ALTER TABLE DimType
	ADD CONSTRAINT "XPKDimType" PRIMARY KEY (ID);

CREATE TABLE IncomeRange
( 
	ID                   integer  NOT NULL ,
	Name                 varchar(20)  NOT NULL ,
	LowValue             integer  NOT NULL ,
	HighValue            integer  NOT NULL 
);

ALTER TABLE IncomeRange
	ADD CONSTRAINT "XPKIncomeRange" PRIMARY KEY (ID);

CREATE TABLE Language
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(20)  NOT NULL 
);

ALTER TABLE Language
	ADD CONSTRAINT "XPKLanguage" PRIMARY KEY (ID);

CREATE TABLE LocationCode
( 
	ID                   serial  NOT NULL ,
	Value                varchar(20)  NOT NULL ,
	LocationCodeTypeID   serial  NOT NULL 
);

ALTER TABLE LocationCode
	ADD CONSTRAINT "XPKLocationCode" PRIMARY KEY (ID);

CREATE TABLE LocationCodeType
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(20)  NOT NULL ,
	DataTypeID           serial  NOT NULL 
);

ALTER TABLE LocationCodeType
	ADD CONSTRAINT "XPKLocationCodeType" PRIMARY KEY (ID);

CREATE TABLE MultiDim
( 
	ID                   serial  NOT NULL ,
	DimTypeID            serial  NULL ,
	DetailID             smallint  NULL ,
	Name                 varchar(50)  NULL 
);

ALTER TABLE MultiDim
	ADD CONSTRAINT "XPKMultiDim" PRIMARY KEY (ID);

CREATE TABLE Question
( 
	ID                   bigserial  NOT NULL ,
	ParentQuestionID     bigserial  NULL ,
	QuestionText         varchar(255)  NOT NULL ,
	ResponseCount        integer  NOT NULL   DEFAULT  0,
	TotalAnswers         integer  NOT NULL   DEFAULT  0,
	DesiredAnswers       integer  NULL ,
	AppUserID            bigserial  NULL ,
	DateCreated          timestamp  NOT NULL   DEFAULT  getdate(),
	QuestionTypeID       serial  NULL ,
	TotalDeclines        integer  NOT NULL   DEFAULT  0,
	IsPublic             bit  NOT NULL   DEFAULT  1,
	IsSeedQuestion       bit  NOT NULL   DEFAULT  0
);

ALTER TABLE Question
	ADD CONSTRAINT "XPKQuestion" PRIMARY KEY (ID);

CREATE TABLE QuestionPayment
( 
	ID                   bigserial  NOT NULL ,
	QuestionID           bigserial  NOT NULL ,
	TotalSatsOffered     bigint  NOT NULL ,
	SatsPerResponse      integer  NULL ,
	InvoiceHash          varchar(255)  NULL ,
	InvoiceSettled       bit  NOT NULL   DEFAULT  0,
	PaymentReceivedDate  timestamp  NULL ,
	QuestionStateID      serial  NULL   DEFAULT  1
);

ALTER TABLE QuestionPayment
	ADD CONSTRAINT "XPKQuestionPayment" PRIMARY KEY (ID);

CREATE TABLE QuestionState
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(20)  NOT NULL 
);

ALTER TABLE QuestionState
	ADD CONSTRAINT "XPKQuestionState" PRIMARY KEY (ID);

CREATE TABLE QuestionTag
( 
	ID                   serial  NOT NULL ,
	QuestionID           bigserial  NOT NULL ,
	TagID                bigserial  NOT NULL 
);

ALTER TABLE QuestionTag
	ADD CONSTRAINT "XPKQuestionTag" PRIMARY KEY (ID);

CREATE TABLE QuestionType
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(20)  NOT NULL 
);

ALTER TABLE QuestionType
	ADD CONSTRAINT "XPKQuestionType" PRIMARY KEY (ID);

CREATE TABLE Response
( 
	AnswerText           varchar(100)  NOT NULL ,
	TotalChosen          integer  NOT NULL   DEFAULT  0,
	ID                   bigserial  NOT NULL ,
	QuestionID           bigserial  NOT NULL 
);

ALTER TABLE Response
	ADD CONSTRAINT "XPKResponse" PRIMARY KEY (ID);

CREATE TABLE ResponsePayout
( 
	ID                   bigserial  NOT NULL ,
	UserResponseID       bigserial  NOT NULL ,
	AppUserID            bigserial  NULL ,
	SatsAmount           integer  NULL ,
	PayoutInvoice        varchar(255)  NULL ,
	PayoutHash           varchar(255)  NULL ,
	PayoutSettled        bit  NOT NULL   DEFAULT  0,
	PayoutDate           timestamp  NULL ,
	EligibleForPayout    integer  NULL   DEFAULT  0,
	PayoutAttempts       smallint  NULL   DEFAULT  0
);

ALTER TABLE ResponsePayout
	ADD CONSTRAINT "XPKResponsePayout" PRIMARY KEY (ID);

CREATE TABLE Status
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(20)  NOT NULL ,
	StatusTypeID         serial  NOT NULL 
);

ALTER TABLE Status
	ADD CONSTRAINT "XPKStatus" PRIMARY KEY (ID);

CREATE TABLE StatusType
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(20)  NOT NULL 
);

ALTER TABLE StatusType
	ADD CONSTRAINT "XPKStatusType" PRIMARY KEY (ID);

CREATE TABLE Tag
( 
	ID                   bigserial  NOT NULL ,
	Tag                  varchar(25)  NOT NULL ,
	UseCounter           integer  NOT NULL   DEFAULT  0
);

ALTER TABLE Tag
	ADD CONSTRAINT "XPKTag" PRIMARY KEY (ID);

CREATE TABLE TransactionType
( 
	ID                   serial  NOT NULL ,
	Name                 varchar(50)  NOT NULL 
);

ALTER TABLE TransactionType
	ADD CONSTRAINT "XPKTransactionType" PRIMARY KEY (ID);

CREATE TABLE UserResponse
( 
	ID                   bigserial  NOT NULL ,
	QuestionID           bigserial  NOT NULL ,
	ResponseID           bigserial  NULL ,
	AppUserID            bigserial  NOT NULL ,
	DateCreated          timestamp  NOT NULL   DEFAULT  getdate(),
	DeclineAnswer        bit  NOT NULL   DEFAULT  0
);

ALTER TABLE UserResponse
	ADD CONSTRAINT "XPKUserResponse" PRIMARY KEY (ID);

CREATE TABLE WalletTransaction
( 
	ID                   bigserial  NOT NULL ,
	AppUserID            bigserial  NULL ,
	QuestionPaymentID    bigserial  NULL ,
	ResponsePayoutID     bigserial  NULL ,
	TransactionTypeID    serial  NOT NULL ,
	SatsAmount           bigint  NULL ,
	InvoiceHash          varchar(255)  NOT NULL ,
	SettledDate          timestamp  NULL 
);

ALTER TABLE WalletTransaction
	ADD CONSTRAINT "XPKWalletTransaction" PRIMARY KEY (ID);
