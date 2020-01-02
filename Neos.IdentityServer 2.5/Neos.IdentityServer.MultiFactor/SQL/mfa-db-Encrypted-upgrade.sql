USE [%DATABASENAME%];

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

CREATE TABLE [dbo].[KEYDESCS](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UPN] [varchar](256) NOT NULL,
	[CREDENTIALID] [varchar](256) NOT NULL,
	[PUBLICKEY] [varchar](8000) COLLATE Latin1_General_BIN2 ENCRYPTED WITH (COLUMN_ENCRYPTION_KEY = [%SQLKEY%], ENCRYPTION_TYPE = Deterministic, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NULL,
 CONSTRAINT [PK_KEYDESC] PRIMARY KEY CLUSTERED ([ID] ASC));

 CREATE NONCLUSTERED INDEX [IX_KEYDESC_UPN] ON [dbo].[KEYDESCS] ([UPN] ASC);
 CREATE UNIQUE NONCLUSTERED INDEX [IX_KEYDESC_CRED] ON [dbo].[KEYDESCS] ([CREDENTAILID], [UPN] ASC);

CREATE TABLE [dbo].[KEYS](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UPN] [varchar](256) NOT NULL,
	[SECRETKEY] [varchar](8000) COLLATE Latin1_General_BIN2 ENCRYPTED WITH (COLUMN_ENCRYPTION_KEY = [%SQLKEY%], ENCRYPTION_TYPE = Randomized, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NULL,
	[CERTIFICATE] [varchar](8000) COLLATE Latin1_General_BIN2 ENCRYPTED WITH (COLUMN_ENCRYPTION_KEY = [%SQLKEY%], ENCRYPTION_TYPE = Deterministic, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NULL,
 CONSTRAINT [PK_KEYS] PRIMARY KEY CLUSTERED ([ID] ASC),
 CONSTRAINT [IX_KEYS_UPN] UNIQUE NONCLUSTERED ([UPN] ASC)); 

USE [master];

ALTER DATABASE [%DATABASENAME%] SET READ_WRITE;


