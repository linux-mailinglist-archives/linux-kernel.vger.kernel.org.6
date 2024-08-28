Return-Path: <linux-kernel+bounces-304610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FA8962279
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DDA285630
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3833015CD54;
	Wed, 28 Aug 2024 08:47:18 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17D15749A;
	Wed, 28 Aug 2024 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834837; cv=fail; b=tFboT+rSzyQ1BPcSpHp48BXnfYXHaWmuTJ9rJktbuv3QTWmYGBX5GaDzwg3WUfqh0Ao56990sLJCg1N2k9Xo9Q9szLWO/7CuT+UhaoZLFsz8YH3QP6bWcG7lzAKIIN4i4SljvORWZM0A3BMZHf4h0B/JQB2uIIH8La6ri8lDbuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834837; c=relaxed/simple;
	bh=KW5MeIG/M5nvcsKi414Zrtbcsoco1mY3Ri3vJRZ5wRk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VSTQsDfzNlKlMitrh6LP3DuSp7DiAjkZGih6dlv+ALlUaBsCfXZff2VOL8Vj4mRoA2b8UOoeTkAwthWvBneiBxNE5OorjfHAT32oTk+Ja+3JuSCcBrnBqG10zrmVU1McwmzZcbkw1E387dTzPvk7ILh79frGkbj7NXcPuainUcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hnvf9E8FSj5OulG2rh63SX0+oFqBcsg0v2lirgW0bw0xUHho2PhxAehOuhm6xB0Q7mSnXRPOko4BhSfN3gxXSN55GWeDD5+S/BtoPViSiW6pCJM/kc+tLrJc8gvVd7n29l6Da4vpmI6Zmi+a0qql/s1oB3P4ZrcAvtu+G9Cww5kQdcGRBWvLA3ISdWH1jKKyUYLED4ITHzDaAQejbxcHnPt6Ift27HFUGgHm981cDD4dGMCas0SVMahj+jE/lpXc0OQ6WA3gwuvMMVdwv9lTyQoY8oV2ttMZS7mYD2/Wi7M1rAvDGqfwD2mhAs2lh+37785mTVWFf6CZCd5kTlE8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ehvlQURtyKhPbgpC86U5gspzkOdWuy/BF52NJA+Rqs=;
 b=OjCIK9djc2bhEqQJJfvizjiAvn9U9NAqsw6Wxe3NTACqlTp9xp79fqycwFf0dVFWgTLVlMmhTTZMivfPfCXHrSoG4jb88OyVJyFFS0BxGZDZSsJrTx6PD3fRxKkv+SLvqClrjZWvzYO7d3mNxP1ZX1iu5tqDok+hklGlukeVzmB4BegE7xc19McSgK0kugiuhW7KGNzhtM7AM6tVU1ZQpnopMFTK/h5/IMXrPaF5g2tdGEB781U3K8Q04QtBMknoD8pTURKiZ3UXGq3uVuH+7t7B7tEsIbyEluSZEZVPGcMJo1pZISHBuJzuhsg+vpWsTjutfAXwYWrFpn9QxA+pOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYZPR03MB8412.apcprd03.prod.outlook.com (2603:1096:405:73::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 08:47:12 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 08:47:12 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 16:45:40 +0800
Subject: [PATCH v13 1/2] arm64: dts: rockchip: Add AP6275P wireless support
 to Khadas Edge 2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-dts-v13-1-6bff9896d649@wesion.com>
References: <20240828-dts-v13-0-6bff9896d649@wesion.com>
In-Reply-To: <20240828-dts-v13-0-6bff9896d649@wesion.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Jacobe Zang <jacobe.zang@wesion.com>, 
 Muhammed Efe Cetin <efectn@protonmail.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724834828; l=1327;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=KW5MeIG/M5nvcsKi414Zrtbcsoco1mY3Ri3vJRZ5wRk=;
 b=5cKI0jkgM8p62ugK1DjSPjoVgLw3VVR6SDLGlXT46J1YvK+TUxodA4JI8sPthYjQ87GGDHu33
 KuPIkCZNwYRCO1xNJjBhikn2G/Ii0Y3pXHBqkfN237wrnb4cfR9DGzS
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: TYCPR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:405:3::22) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYZPR03MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d8bcd3-084b-4781-2272-08dcc73e029c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmxkMFMyT21QVUpnMDBBTjlDYWx2eFpGekVJVmZEQy84YVJDTCt0QVM1a1lX?=
 =?utf-8?B?MHhaSURLelVMcXJSTDZQU3M2c2FxTC9uT2doNmhzL0twQnljQnVvV21ibVYr?=
 =?utf-8?B?eWMrZzJPWlhMOWQ0UXFlV0RYSzJMajZhWTRxdmhDOFBydmUzckZxZWkvT3Za?=
 =?utf-8?B?MGJjZjFqdHlSazYxTjBEdW5rOFNVZ1FXamZxNDNWMzR5NERuWkxYYUszOWJB?=
 =?utf-8?B?VEZqYlRuempaQ3BOL1FJZWRoTlA0ckFGN0w4Z2dCTnBBb0Vib2Z3dXdwVDNy?=
 =?utf-8?B?NEFidXNQa0hzYkgzT3BNcWhYWkpqa1UzU093RmpGdUhnK1g5SVA3bGR1NFFJ?=
 =?utf-8?B?ZG9KcVNJeXBxbm13TEw3MUdBSno1U3hoTzRvV2lreVBMRDBtNlVOK25LOTUr?=
 =?utf-8?B?ajZWVG9IUHk2bjJRVkhzRENCR3ZtSTI3SFpxbHBQVG5xSXE2WlFsQzNvSkhC?=
 =?utf-8?B?YmVhNUtoSXNPcmtnSG9zaFZZVFZyQmQ5MnFXRER0TTZMZThaRFlEcnp5N0tY?=
 =?utf-8?B?WDh1NUlCR3BKNEVjOUFXVm9aSUlYRUxSZmQ2K1V3YkFKcWZTSnZmZ0szTmFo?=
 =?utf-8?B?NTd2dm9OMGFVajNWdms2Z0hIbUlGclBaenF4L0JYbkQ1RGd1Z2U4UkFuOE1u?=
 =?utf-8?B?VTY5T1Z2am9Qc3g4OU1PTmlMNnBmekU2cGM0akJXeDdLN2grcUpyQzBhdThn?=
 =?utf-8?B?U2VTcjQwNEFNOVIyQlU2VnJCOFdma3V4ZE4vYlJUUndtZGc4enBOcm5Ib0o1?=
 =?utf-8?B?eTRlT1JKSTlpS0hOZk1BRWgwNzRGUUlYK2l1V2dxRklNcFFJZXEwV0NDRzlv?=
 =?utf-8?B?eTllVEE4QU9PWmV6ckFyZTdybEtxcTltZWZ3UHJKU0tXVTdNU2MyeGpMcFQw?=
 =?utf-8?B?WE9pZ2JSUHJBT3oweUNTa3pabWxRdmprZ2tOZFlTWm51Q2tuVmJSdWhOVTJ4?=
 =?utf-8?B?Q2VYaGR4ZmJVcEMwbDVJMU9QOEtwTWFIUkl0Mkx5TjNHRXJub2s3SSs1dDFW?=
 =?utf-8?B?UGdOU1MzeE0rZjVFTTdNUE94ZW1EQ2dpVWp6Z29wbm1wRk1vS2YzUnJvTjlh?=
 =?utf-8?B?L0h6bUJhNkwwRzdPbUpITTY3aHNCNCtIRzFOa3Exa3BoYThpYVN3WTk2T3ZG?=
 =?utf-8?B?TGppelFIdXdoRk5uTVU3bFh6L20yU1lTQXdUenVoUzZ2YkZobXZkWStiaUxO?=
 =?utf-8?B?R0hVbzVUMmNYUitid21VNWl3d1VMejdmbzBwaWM5bFNDbUl2UzBGZHdzOEN4?=
 =?utf-8?B?L0NEdzBKTmh6NEE5dkwwcEcvd01tRjU5SFVFcXdoekFielVYajJycS9nNEw5?=
 =?utf-8?B?VGI5aDBIaTFjME1HNEc2N2FzSzFZQmErVnZKQWx6WWNscjc4L0JpcDNxQTF1?=
 =?utf-8?B?ZTBCVDRhUGtXQzY1WFRyejZnR3p4b0UwZ3FwZWdxeG9mV2x1QithVWx5eGtM?=
 =?utf-8?B?eUdVd2pIam5iejA2VklHdFZmSXNyVnB0N1lXNjdqc0FGeFB6azVQd2orM0g5?=
 =?utf-8?B?Z00vZGNlc0l1eU4rNjMwOWxOSDBEZGhaeFFBYzlTMDFvZzNmdU8vN1NWWlg3?=
 =?utf-8?B?ZGNzWjFaRUhiVm1NZnYyMFA5VUJudzRmWDB2R2svbWhKS2hFZC9ndDk5Nzdo?=
 =?utf-8?B?K2FCcGxNbVZ3RDhMRWtpUk5xeHR6akQ5SmxIMUtxakVJVVdtQXN0ampHSDJy?=
 =?utf-8?B?TnhIY0E0cFJZalFnOS9YNnlOcldpTHdpdVBCKzV2RkVwSmVLbjJ2TzErbVdl?=
 =?utf-8?B?anYvS3RtdDRtU2ZhV0xsM1N3c1pTREpwUnU3U0VvVWtFbzFjSXVoZDRSR1Ba?=
 =?utf-8?B?N1BUUVFhWE1TRzBOUzdNbkhLK21OUjFDaFU0M2QwVG9nc2xyVXowWkRLaEpl?=
 =?utf-8?B?M1NxTkx0YXp6WStKMkNJK2N0clpwT25ocWdmbS9aUVlwREE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE9iV0RnVytFR21UdTlCUEZhOU14RmNBcEFYVlZ2ZkVuNnUrUHg4bEpVVWow?=
 =?utf-8?B?akVabGVFWWczMWZScHdRYUh2S25LUVJNVHkyc3ltQk1UdkVabzF1K2RxN3lx?=
 =?utf-8?B?YjZSVU45Tit0bStjZXppWDkrem9SV2swb25DdGZ2YjJBQi9nbnR0ZmJxWVpv?=
 =?utf-8?B?Y29iYTFsS0o0SHV4a3FOOStoS2JXc2xSMWlvakR2aHFmcXAzd1h6N1E3Mk9B?=
 =?utf-8?B?aHlGK1RqL3FzdkExbVg1WFN6cXE4L2lXTW00cWlObDEwRloySTZzdE9yWlVO?=
 =?utf-8?B?RDI1SytxZlZDUTUzeS9vbWt0NDdKeklENnZIZm5qSCtBZzQzZThRN2tBNER0?=
 =?utf-8?B?cTZyUzdWS01FV0xzMjVkNGpJM3NBcFJyR1ladElqR2RpY3lqU2MxT1h2V2Zn?=
 =?utf-8?B?QUhxYkE3c2ZBZlVnNXVGSTZFUjVRcEkrSjZEK3R0dnFZT1p5Q2Q2QWhCL1gy?=
 =?utf-8?B?V0w4eGw1MlgwTnFWaCt3Yyt1VUNWZmVHY3N6Zkh1KytFMnA3cTFUNkdsbWx5?=
 =?utf-8?B?anN6L0U1YTk0cnczRzhleVlWWmJIYmtUL3dtUUpIWkwxSUh4dGR0QmM2WDVZ?=
 =?utf-8?B?aWdTczY1ZkZLWEtWa3doSnBVV0ZHb2hTV3ZBdmxlM0s4ZnVMbXNzb0dvSW1L?=
 =?utf-8?B?SlI0RW5wRFhPcHlVZzlQcXBGK1g4d050MjVuWFh2b1ZSbFFpVkwwa2FTT2hp?=
 =?utf-8?B?RGNxcC9oM2hvZ0ZMZi9oNkU4ZDVGb2o1RkNoaXpmRHREemNLQ1AvMDF4b21P?=
 =?utf-8?B?K2pwdTVYQmFrenVwTmw1Rmp5T3lFdTdUc3Ira01lU1pNdkxqRWVCR2sxZllU?=
 =?utf-8?B?ODBkZXJmVndSTFRnZ3ZXaTR6WkZXNWhpTzJqdTJFZ09MdWVubTJ1TytLRDNj?=
 =?utf-8?B?cmRScEg3ME56UjdXOVBUYStaZ25XT012QzJ4WnZpaWZMQWJhM2Qrek5vL2ZO?=
 =?utf-8?B?eUpYbVVmQ2YxZzNpL0RtKzFDV2xLdHVCM0lxUllaWlZyQU9sbUlFNlNqVVdy?=
 =?utf-8?B?R3N1enN1YVUxVU1qT2s2QmIrWXJxU3c2SEIxS05uTWZZSGJmcDhqalBGK2Iv?=
 =?utf-8?B?MmxXZUk0c3ViNU8rNzBUSW1RV2pVYkkzT2NaTy9LVGx4a3NqVTF3MUJCUTU3?=
 =?utf-8?B?QlZnTkQ5Y3l4Z3JXUUN0VFprK2laMStsYVBEbVFVemhlYkhGUTRyaDRibEdO?=
 =?utf-8?B?YU9sNUVYK0VoWU5uZ2k1bTVtQkd0cFRUQTJEQUtsU25NdkZrQlY2eCt3ZWZT?=
 =?utf-8?B?cWZvRmZobzZsSUU0TXlDZXMxak5xSVZoVzhxWkFVN1gySHp0UExleUwxREpK?=
 =?utf-8?B?bXJ6dFZOa3l4bE9nOURGaW8vRU9CYng2UkxhSnd0aEVjRzJ3M1F1Nnc5S1BB?=
 =?utf-8?B?R2d0NEJVSnpnb2krK1lGUk1MQnV3NWdKd3NhdFRQOVdrK3dNVVhGVDk1ZTQ1?=
 =?utf-8?B?VFk3S1MwZVN3aGdTMHFwdG53WkxFbDBXMUZlQ214ZG1jclJzK2dSQ2paU3l0?=
 =?utf-8?B?ODU4djdjdUxLaE8wMGVLL0ljVGIzTHVHQmQ4U1gxZGdUdkhPWWtTNFd2OVlW?=
 =?utf-8?B?eVZlYlQ4Uk1MMElJVXIrc2N1NTRSVlM4UFlDUWtQcTVHK0ZrbExSTkVITjZ2?=
 =?utf-8?B?ZDRpQjB3MDBuKytQYVVQQ0pWc2FJNm1FNnYvYWRpNjNQS1k2MDVKNzUrbGx5?=
 =?utf-8?B?V3RQd3hINmVsWUJmdUgzSG9YSzZGNEZXNUJHTHp2MUpNS3oyZXVYVmFCL0N3?=
 =?utf-8?B?NzJtc3g2eFhZdWdFVjBQTkhQUkNNUHd4TCtRaDJVamNwRElQS1FJWG1JcVBC?=
 =?utf-8?B?aWNneGtEYUxYc0FEUWNwUUZsUnN4RVBHUERpcWJIeVE2ZzRNNHpxb04rTlFz?=
 =?utf-8?B?Y3REZGNmbHNucE9PKy9qNVRSNkdnRFdiZ3lBZG1acUxqME1KSFhpSm9yL2hm?=
 =?utf-8?B?RkwxRm5ISWJNa1F1YzNtRS92RmZPQ0VhTnd4UUJqUURlRTVkTGhGM1VJdmVS?=
 =?utf-8?B?NDZFQW5GTGR6QWpWaWdqVGxNWE52K082QmJDMjVxZGkvVkZnSUgzUWM4eVJu?=
 =?utf-8?B?V0dKYnliQUl3V0tocWJOZjNTQWhKdmRPVW8wUlZGSkY1S292QUlwOEo2R1NX?=
 =?utf-8?Q?0Aqm9uDugYE+vTc31/ulm5B4O?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d8bcd3-084b-4781-2272-08dcc73e029c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:47:12.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EqiRIKv+Rqhw3mg1qdAyBaeMzM3MJnkbQzz6BGIXMA/hIniChJz92Fv6OWtwZiN/6VxWCVtPtdgVt1FCKfn1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8412

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
device under the Bridge1.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..3d0f55c123d92 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -283,6 +283,22 @@ &pcie2x1l2 {
 	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie_wl>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x400000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x40 0x4f>;
+
+		wifi: wifi@0,0 {
+			compatible = "pci14e4,449d", "brcm,bcm4329-fmac";
+			reg = <0x410000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "lpo";
+		};
+	};
 };
 
 &pwm11 {

-- 
2.34.1


