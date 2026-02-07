
CREATE TABLE [AccountType]
( 
	[ID]                 smallint  NOT NULL  IDENTITY ,
	[Name]               varchar(30)  NOT NULL ,
	[DailyAnswerLimit]   smallint  NULL 
)
go

ALTER TABLE [AccountType]
	ADD CONSTRAINT [XPKAccountType] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [AgeGroup]
( 
	[ID]                 smallint  NOT NULL  IDENTITY ,
	[Name]               varchar(20)  NOT NULL ,
	[LowAge]             smallint  NOT NULL ,
	[HighAge]            integer  NOT NULL 
)
go

ALTER TABLE [AgeGroup]
	ADD CONSTRAINT [XPKAgeGroup] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [AppUser]
( 
	[IncomeRangeID]      integer  NULL ,
	[Age]                smallint  NULL ,
	[Gender]             char(1)  NULL ,
	[ID]                 bigint  NOT NULL  IDENTITY ,
	[StatusID]           integer  NULL ,
	[LocationCodeIDOne]  integer  NOT NULL 
	CONSTRAINT [ZeroValue_593816919]
		 DEFAULT  0,
	[UserRating]         integer  NOT NULL 
	CONSTRAINT [ZeroValue_2058693179]
		 DEFAULT  0,
	[AccountTypeID]      smallint  NOT NULL 
	CONSTRAINT [OneValue_1477588347]
		 DEFAULT  1,
	[AccountTypeEffectiveDate] Datetime2  NOT NULL 
	CONSTRAINT [RightNow_1809857017]
		 DEFAULT  getdate(),
	[AccountTypeEndDate] Datetime2  NOT NULL 
	CONSTRAINT [TheFuture_709065094]
		 DEFAULT  1/1/2090,
	[LastActionDatetime] Datetime2  NULL ,
	[QuestionsAnswered]  integer  NULL ,
	[QuestionsDeclined]  integer  NULL ,
	[QuestionsAsked]     integer  NULL ,
	[LightningAddress]   varchar(255)  NULL ,
	[NPubKey]            varchar(64)  NOT NULL ,
	[IsBotFlagged]       bit  NOT NULL 
	CONSTRAINT [ZeroValue_1664549744]
		 DEFAULT  0,
	[WalletProvider]     varchar(50)  NULL 
)
go

ALTER TABLE [AppUser]
	ADD CONSTRAINT [XPKAppUser] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [AppUserDetail]
( 
	[ID]                 bigint  NOT NULL  IDENTITY ,
	[AppUserID]          bigint  NOT NULL ,
	[DetailTypeID]       integer  NOT NULL ,
	[ValueDate]          Datetime2  NULL ,
	[ValueString]        varchar(100)  NULL ,
	[ValueInteger]       integer  NULL 
)
go

ALTER TABLE [AppUserDetail]
	ADD CONSTRAINT [XPKAppUserDetail] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [AppUserSubscribedTag]
( 
	[ID]                 bigint  NOT NULL  IDENTITY ,
	[AppUserID]          bigint  NOT NULL ,
	[TagID]              integer  NOT NULL 
)
go

ALTER TABLE [AppUserSubscribedTag]
	ADD CONSTRAINT [XPKAppUserSubscribedTag] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [CountryCode]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[Name]               varchar(20)  NOT NULL ,
	[LocationCodeName]   varchar(20)  NULL ,
	[LocationCodeLength] varchar(20)  NULL ,
	[DefaultLanguageID]  integer  NULL 
)
go

ALTER TABLE [CountryCode]
	ADD CONSTRAINT [XPKCountryCode] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [DataType]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[Name]               varchar(20)  NULL ,
	[IsString]           bit  NOT NULL 
	CONSTRAINT [ZeroValue_2122680170]
		 DEFAULT  0
)
go

ALTER TABLE [DataType]
	ADD CONSTRAINT [XPKDataType] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [DetailType]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[Name]               varchar(30)  NOT NULL ,
	[DataTypeID]         integer  NOT NULL 
)
go

ALTER TABLE [DetailType]
	ADD CONSTRAINT [XPKDetailType] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [DimGroup]
( 
	[ID]                 integer  NOT NULL ,
	[Name]               varchar(30)  NULL 
)
go

ALTER TABLE [DimGroup]
	ADD CONSTRAINT [XPKDimGroup] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [DimType]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[Name]               varchar(50)  NULL ,
	[DimGroupID]         integer  NULL 
)
go

ALTER TABLE [DimType]
	ADD CONSTRAINT [XPKDimType] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [IncomeRange]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[Name]               varchar(20)  NOT NULL ,
	[LowValue]           integer  NOT NULL ,
	[HighValue]          integer  NOT NULL 
)
go

ALTER TABLE [IncomeRange]
	ADD CONSTRAINT [XPKIncomeRange] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [Language]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[Name]               varchar(20)  NOT NULL 
)
go

ALTER TABLE [Language]
	ADD CONSTRAINT [XPKLanguage] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [LocationCode]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[Value]              varchar(20)  NOT NULL ,
	[LocationCodeTypeID] integer  NOT NULL 
)
go

ALTER TABLE [LocationCode]
	ADD CONSTRAINT [XPKLocationCode] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [LocationCodeType]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[Name]               varchar(20)  NOT NULL ,
	[DataTypeID]         integer  NOT NULL 
)
go

ALTER TABLE [LocationCodeType]
	ADD CONSTRAINT [XPKLocationCodeType] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [MultiDim]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[DimTypeID]          integer  NULL ,
	[DetailID]           smallint  NULL ,
	[Name]               varchar(50)  NULL 
)
go

ALTER TABLE [MultiDim]
	ADD CONSTRAINT [XPKMultiDim] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [Question]
( 
	[ID]                 bigint  NOT NULL  IDENTITY ,
	[ParentQuestionID]   bigint  NULL ,
	[QuestionText]       varchar(255)  NOT NULL ,
	[ResponseCount]      int  NOT NULL 
	CONSTRAINT [ZeroValue_133880777]
		 DEFAULT  0,
	[TotalAnswers]       integer  NOT NULL 
	CONSTRAINT [ZeroValue_1140257005]
		 DEFAULT  0,
	[DesiredAnswers]     integer  NULL ,
	[AppUserID]          bigint  NULL ,
	[DateCreated]        Datetime2  NOT NULL 
	CONSTRAINT [RightNow_1870262002]
		 DEFAULT  getdate(),
	[QuestionTypeID]     integer  NULL ,
	[TotalDeclines]      integer  NOT NULL 
	CONSTRAINT [ZeroValue_471119087]
		 DEFAULT  0,
	[IsPublic]           bit  NOT NULL 
	CONSTRAINT [OneValue_580479350]
		 DEFAULT  1,
	[IsSeedQuestion]     bit  NOT NULL 
	CONSTRAINT [ZeroValue_316113661]
		 DEFAULT  0
)
go

ALTER TABLE [Question]
	ADD CONSTRAINT [XPKQuestion] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [QuestionPayment]
( 
	[ID]                 bigint  NOT NULL  IDENTITY ,
	[QuestionID]         bigint  NOT NULL ,
	[TotalSatsOffered]   bigint  NOT NULL ,
	[SatsPerResponse]    integer  NULL ,
	[InvoiceHash]        varchar(255)  NULL ,
	[InvoiceSettled]     bit  NOT NULL 
	CONSTRAINT [ZeroValue_1196684524]
		 DEFAULT  0,
	[PaymentReceivedDate] Datetime2  NULL ,
	[QuestionStateID]    smallint  NULL 
	CONSTRAINT [OneValue_911674652]
		 DEFAULT  1
)
go

ALTER TABLE [QuestionPayment]
	ADD CONSTRAINT [XPKQuestionPayment] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [QuestionState]
( 
	[ID]                 smallint  NOT NULL  IDENTITY ,
	[Name]               varchar(20)  NOT NULL 
)
go

ALTER TABLE [QuestionState]
	ADD CONSTRAINT [XPKQuestionState] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [QuestionTag]
( 
	[ID]                 bigint  NOT NULL  IDENTITY ,
	[QuestionID]         bigint  NOT NULL ,
	[TagID]              integer  NOT NULL 
)
go

ALTER TABLE [QuestionTag]
	ADD CONSTRAINT [XPKQuestionTag] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [QuestionType]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[Name]               varchar(20)  NOT NULL 
)
go

ALTER TABLE [QuestionType]
	ADD CONSTRAINT [XPKQuestionType] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [Response]
( 
	[AnswerText]         varchar(100)  NOT NULL ,
	[TotalChosen]        integer  NOT NULL 
	CONSTRAINT [ZeroValue_1127541060]
		 DEFAULT  0,
	[ID]                 bigint  NOT NULL  IDENTITY ,
	[QuestionID]         bigint  NOT NULL 
)
go

ALTER TABLE [Response]
	ADD CONSTRAINT [XPKResponse] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [ResponsePayout]
( 
	[ID]                 bigint  NOT NULL  IDENTITY ,
	[UserResponseID]     bigint  NOT NULL ,
	[AppUserID]          bigint  NULL ,
	[SatsAmount]         integer  NULL ,
	[PayoutInvoice]      varchar(255)  NULL ,
	[PayoutHash]         varchar(255)  NULL ,
	[PayoutSettled]      bit  NOT NULL 
	CONSTRAINT [ZeroValue_2017270875]
		 DEFAULT  0,
	[PayoutDate]         datetime  NULL ,
	[EligibleForPayout]  integer  NULL 
	CONSTRAINT [ZeroValue_102436883]
		 DEFAULT  0,
	[PayoutAttempts]     smallint  NULL 
	CONSTRAINT [ZeroValue_991045435]
		 DEFAULT  0
)
go

ALTER TABLE [ResponsePayout]
	ADD CONSTRAINT [XPKResponsePayout] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [Status]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[Name]               varchar(20)  NOT NULL ,
	[StatusTypeID]       smallint  NOT NULL 
)
go

ALTER TABLE [Status]
	ADD CONSTRAINT [XPKStatus] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [StatusType]
( 
	[ID]                 smallint  NOT NULL  IDENTITY ,
	[Name]               varchar(20)  NOT NULL 
)
go

ALTER TABLE [StatusType]
	ADD CONSTRAINT [XPKStatusType] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [Tag]
( 
	[ID]                 integer  NOT NULL  IDENTITY ,
	[Tag]                varchar(25)  NOT NULL ,
	[UseCounter]         integer  NOT NULL 
	CONSTRAINT [ZeroValue_435579830]
		 DEFAULT  0
)
go

ALTER TABLE [Tag]
	ADD CONSTRAINT [XPKTag] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [TransactionType]
( 
	[ID]                 smallint  NOT NULL  IDENTITY ,
	[Name]               varchar(50)  NOT NULL 
)
go

ALTER TABLE [TransactionType]
	ADD CONSTRAINT [XPKTransactionType] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [UserResponse]
( 
	[ID]                 bigint  NOT NULL  IDENTITY ,
	[QuestionID]         bigint  NOT NULL ,
	[ResponseID]         bigint  NULL ,
	[AppUserID]          bigint  NOT NULL ,
	[DateCreated]        Datetime2  NOT NULL 
	CONSTRAINT [RightNow_708094103]
		 DEFAULT  getdate(),
	[DeclineAnswer]      bit  NOT NULL 
	CONSTRAINT [ZeroValue_1396345508]
		 DEFAULT  0
)
go

ALTER TABLE [UserResponse]
	ADD CONSTRAINT [XPKUserResponse] PRIMARY KEY  CLUSTERED ([ID] ASC)
go

CREATE TABLE [WalletTransaction]
( 
	[ID]                 bigint  NOT NULL  IDENTITY ,
	[AppUserID]          bigint  NULL ,
	[QuestionPaymentID]  bigint  NULL ,
	[ResponsePayoutID]   bigint  NULL ,
	[TransactionTypeID]  smallint  NOT NULL ,
	[SatsAmount]         bigint  NULL ,
	[InvoiceHash]        varchar(255)  NOT NULL ,
	[SettledDate]        Datetime2  NULL 
)
go

ALTER TABLE [WalletTransaction]
	ADD CONSTRAINT [XPKWalletTransaction] PRIMARY KEY  CLUSTERED ([ID] ASC)
go
