Return-Path: <linux-kernel+bounces-272545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783F945DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAD21F23235
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9BE1E2887;
	Fri,  2 Aug 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lKhtLH4A";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M3fdjfKt"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65AF1E212B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600720; cv=fail; b=JRJP8Gw/Vw9MvcWGHh5fvixbS4FWwhpiEdvXV3VE0ULlWfkmiIIdzTEwphQQXQTqZAvGDPNyKOBUU04s1B+gpPyoDi7tJFTVRbwWTFxB3okXuvH9/kYXHaDjpuVEaZx7UBaZXB4qwAJAziPav6Ro1F+rkPdkCh1sTdOSqo/i7Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600720; c=relaxed/simple;
	bh=tZjxWDZjaUglj4EPw7GIKAg/WUglKdJQ3+HZ8BYmZEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PWksC0QhAEiSwDaY/fiMuPwsKJAXy8gL6FQ3XMIOLiTBtoRCWheegzcn8Bt/cv5Ry1v2g9ZfBNe1zkmt5Twns1yQ0SVur+OXzlS+Cu24m0PhfYm0AYzHpBHEs7xETSdHwFP99xtpI1Bg2QNRXDPYk1RhglYfXEx/L0P+Zk2zN5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lKhtLH4A; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M3fdjfKt; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722600717; x=1754136717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tZjxWDZjaUglj4EPw7GIKAg/WUglKdJQ3+HZ8BYmZEI=;
  b=lKhtLH4ACM7OzakYdRd1ATFu/+T16SLP0uLdOQSrlh8z45j6p51aNVqN
   PjY5IOpkQUvtWmnlfzPL/CeIj52576BFjZn03wZPCCUfE5dOJOEZy6X5W
   Fe3JpEW5dwEYjgsWCeCGZCQUA9QQ7RPalattRI32/ienSlGp3svflP3s/
   MXtwe+5o5Whi+WYAMptpiLixZhYXCCVK5xCZ9Y+0fS977g3sh2bXTRp7U
   atxg93HuvJugRqNpzKmxXZlNk5ePImjnA9lGnCIPgQUhfz92U0gWKx1iR
   +jFPTLxoM8FsQnjZAgYI02B2axyvrbOKR7XBrxFBG0DK2Cw7RkqG0xTqK
   g==;
X-CSE-ConnectionGUID: hV5QtWMmQdSCqRQmE1e1Dw==
X-CSE-MsgGUID: AvDGZN6yTcmMDqdpp3o/yw==
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="32870254"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2024 05:11:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Aug 2024 05:11:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Aug 2024 05:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3SiPLb53XBfge5SVWPTi7NunbPaQvam+Ysdy/0uuuZ3ya+sjAuAwKckKXeIRfCpIwTfysifs6uQx7LpwMnDlfidAD0n+W4TcV6BxjT1DoPxQDsHBcSoNlRZ7HG6ouhy/KRuL3COEczv0mXbgxgvoVHbN4X1u4MHRs6j3IV0LEtOrURcNovWgpIxBIIp6vceOPjaikQS69bICFIoj7bXp0GhrquMTXbKBO74fVHbC4vFsVocTpfhfu79pootbaGb3ZeyKlKguyxmoRbkPYBRNvUKk5CugC4CM4lrySZgnB++83ws+PUu29LLG2F2C/ZsD3YbJ7M/KIG9yLthsX3C9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZjxWDZjaUglj4EPw7GIKAg/WUglKdJQ3+HZ8BYmZEI=;
 b=ysIzc3S5xf/TDvrjXzq/iAzREm9EfXOBjS7aGTrrccbEOj3xQDhEZs6op8dxdGuF51/nyMa1Xzc3vDmZPCrIdbQC2NiUizuZQlpLdsqgD41N0l6FBODz4F5O89jMl7clrKcSkT8b5mh0/O1IXHQFD5sQxIglMexbkboIr90za1XqLTTH/A/b7PifeC0/88wwl/UFy1ep66XIFigQkxYt/+P5NmSqjHI6YJaJR8KCxru11IKtmcLNZCLHR+2QjuTLJy7RFXdht1LrTIfnOQRH6y2JQLLqFOR7Tkt7BQsHNWPOLeGq3L2eUOZyNd4DpRv9ntSKOA3nd4ypnOE9yyfbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZjxWDZjaUglj4EPw7GIKAg/WUglKdJQ3+HZ8BYmZEI=;
 b=M3fdjfKt5gbN+IhQ7AxG2v8vr1xUVaePtq+shcDOFatoAsapbMkabisk/NhUecvDZkVxyLUJVKTKoxnAXW4GPWUh4JoAphPzmVaA3YQXnYw6IMuLiZHqKFSSEM0t/J8izH2sabF7AQtKwUwpbnMUWGqgJr9gAuvsvn154XnM8ZIYYGunkMsEi+L3vSHbwEXfcsX9lnAHORAa40/fNAid+qrxOj+mXbQ9cB1q1NDE+Pwr0DGHOOnuW0X5JaKVEVZr2vJD5csH98AzKUPxndhK7glt135AU7GzEPXWdET6N6wJLVkhzggse3KMPPSj1IKK/oPeYgUexMZj/19Ux9x5iw==
Received: from SA1PR11MB7016.namprd11.prod.outlook.com (2603:10b6:806:2b6::8)
 by SJ2PR11MB8497.namprd11.prod.outlook.com (2603:10b6:a03:57b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 12:11:11 +0000
Received: from SA1PR11MB7016.namprd11.prod.outlook.com
 ([fe80::c9f5:4f13:ca81:f9d3]) by SA1PR11MB7016.namprd11.prod.outlook.com
 ([fe80::c9f5:4f13:ca81:f9d3%3]) with mapi id 15.20.7828.016; Fri, 2 Aug 2024
 12:11:11 +0000
From: <Cristian.Birsan@microchip.com>
To: <Andrei.Simion@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC: <linux-kernel@vger.kernel.org>, <conor@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update DTS path for ARM/Microchip (AT91) SoC
Thread-Topic: [PATCH] MAINTAINERS: Update DTS path for ARM/Microchip (AT91)
 SoC
Thread-Index: AQHa41evBRNA3X6Ie06mahHkFzMzErIT43qA
Date: Fri, 2 Aug 2024 12:11:11 +0000
Message-ID: <67dae338-31f9-4b5a-b870-769a914464bf@microchip.com>
References: <20240731144100.182221-1-andrei.simion@microchip.com>
In-Reply-To: <20240731144100.182221-1-andrei.simion@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7016:EE_|SJ2PR11MB8497:EE_
x-ms-office365-filtering-correlation-id: c68847af-36f1-4b70-9cbe-08dcb2ec32bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SzNKVHNPRytLOERrVXVDNXcvV0x4TFZIb2M0WGVndWVocklIVzdEYlN2SW5I?=
 =?utf-8?B?OFIrRnI4aHRCMEROaUR1MEloWHlpSzRYMmlpamVKNCtMLy93c1pZVmloYkUy?=
 =?utf-8?B?NW43bnFKMkFvT3pwZkVReHBZaVlVN1JnWnZJWTgrQzA0Yk5kVnNXSWVTdVgx?=
 =?utf-8?B?MlZseXgxaHBLR3RVUXoyS0YvK1NSK0hQQlRWSHlTcGRsandoc3VTYm5CeGhN?=
 =?utf-8?B?L0hNU0NHU2VrbDN0RGpnaGpxQmVyYTgrYnpiUTd1K1lVNzNDY3hrd1hFdEtu?=
 =?utf-8?B?SzhRZUZyaDhsQlFQazA1elI2TFQzMStKVjVxc0hhUHFlQ1F5a3VodVc4Mi90?=
 =?utf-8?B?VnppVEhUR1FKVmlRUkcyWWFIK1YwNEttdDlRcUN5ZmRFTXNscXNFeVN5clpw?=
 =?utf-8?B?cDFaWUV3LzQyeEkyWXp3NXZOMmxiV0JnaXRjVkg1UkFzTE82NzJsSGViaVZQ?=
 =?utf-8?B?bWs4WDEvMURxTWhZdjhTZ3hXWXNQMnFlVlpodi9MN0ZJM1hidkNWcWp1aE1J?=
 =?utf-8?B?M256R2dJaWxWN0svWE1XQVZKQVovTXNERTZ3VWdqRWljRXd4WEpabHJ3dTZs?=
 =?utf-8?B?N21DLzBPUmpnR2VWREFTSVpHWlZEejRiVnJGNlE0Mml0K0Q3Z0RlUHkyQzRl?=
 =?utf-8?B?b0JkTHBEVERoazhpcVVCcXZlSmoxZGJPZ1JYeFRXOWFxZXZSZk54RmRvV1kr?=
 =?utf-8?B?Y2Z1RFVhd1hmRnM0S3MzajdIYVY3a2VJL1pZVVdFRHB1WGtMSGZRQWo0OVJw?=
 =?utf-8?B?SThMaHA1L2VaMUlSRFhUcVMxaTBVeGdDUXovamcydmtRcFJiWG9wVXExWlBP?=
 =?utf-8?B?NFliZXhPWlZsVFlYYU0yK1hMbER4M3c1Sm9UejZudnh5Vy9Vc2k0SGxxNEhX?=
 =?utf-8?B?Z3Y4eWg4Z2hROVpHYlBXRnhQbGNkWWNSZExNcmp4aEFCV1dFQ0w3ay93YnhZ?=
 =?utf-8?B?TFE0SFpFV0VOMnpCcmlKZmY1bG15bUh6YnlUTHBHYXVvRVhSTWovZlJkRFo0?=
 =?utf-8?B?WGI1YzJ3TGxFb3ZlTW9HamxPaXEyQitRY2FIMHcyUzlKb1NDT1h5R1ZETERy?=
 =?utf-8?B?Rm04d0ZwTWhKSHBnT0M4MnMwdmVQNEQxbzk4RjJVc09aRDVUQXd1U3Jzejh3?=
 =?utf-8?B?NXpkOWEwMzN2eklyb3hDbUNsR1VhRjAyQkh6UnNoMlJBaENLOUxtNThxUTBv?=
 =?utf-8?B?Rys3MHVjY2Z4SlBYTGJabFdTaUNxclAzUmMwSnVScWh2NGxqc2puK05zMmgy?=
 =?utf-8?B?ZzRUKzFwUDNrY2NYMVVoWE9mczgvU2ZINkxJYi9LUUhoSlR0aWpOUXJnNjZm?=
 =?utf-8?B?cjVVc0hJOVpIVE5ua014NzN3U3dFMDNsNVhjb3dJeHBRTStycHp5cUJUL3lh?=
 =?utf-8?B?T2pKcFBjQlo1c29LSVNxQjFyR3JHUHZXYTBZaEVzU0pxZDYzTFVOcFFvUkUw?=
 =?utf-8?B?T0dlSWszWDYvdTZDYUp0TWR3dk1tZEpHSTY2dDUwby96czdIbXlQSzFFbys2?=
 =?utf-8?B?Z1BvNWpmN0hWZjErOVVUNDRFcDZhNS9memRYNmY5VFBnRFBVNEtkNmJ5MVJm?=
 =?utf-8?B?UXA3R29iUjk5U1p3NTdOcGNXQy9HdEFicTQ5ZTlXMzhwV2ZlUTc4cHJjeE1L?=
 =?utf-8?B?UlIrVDlUekZoYlFpRjF4aXVodlhaVXFZN2ZsZGNVZ3M5MU5RM3JWb0lNR3pz?=
 =?utf-8?B?Wm1aWUNkRlB6WEk3L04xeUJUZWhyMU00Zkt3QkJUMVVoSXVRbW5wTFgzYjl3?=
 =?utf-8?B?RHNpMWdCZzdicURSVnBEWEVZOXV5RFNxRVFET3BOd3BGd2w3a2xxNHoyZk9m?=
 =?utf-8?Q?V0s2lTAL2jZkFlKFRVAZUy8isNMvEQX4CrYck=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7016.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDNzUnJKcjJQSHgyK3VZRFJubFhEZVVHMDBSdERQUkVYQVN1UklsWm5mQzdO?=
 =?utf-8?B?cEVOTU13bG15L2ZIWVJGWDdIckFNMWMzcjZLL1VRa2gvK1FVd051REs5c090?=
 =?utf-8?B?U2kybDBlNnY4ZTAzbEh1cXFOMVZRUmNSanAvR0p1UG92WnpIU0hia3E4MEVw?=
 =?utf-8?B?cGo3Y2ZpUmlzblQzZjBGNHRPM0kyWmNlTUQrNUJUZld0WUlpY2pKczcybkRp?=
 =?utf-8?B?cTZndy9UZm9HZVp6Z0lnb1d3SWRDdXQ1N1JMLzhHdFluWm0zTU5IU1llcFhv?=
 =?utf-8?B?MFZ1a0k5dzR5V0hJSkdXdXVmb3lKRThka1A4UGFvblQ2cXRadkFqSEdjL0ZZ?=
 =?utf-8?B?V3JTWHozMnpFek1NRFVGd3lzSm1XaUt3T3VwakNPME44Y2NuUzFOT08xc1dK?=
 =?utf-8?B?WDBXN0VCS2lUS29TUm44M2UxZ1dBanZkWW1LUHV1VHBtaUNFZ0RnK0xTZ1Mx?=
 =?utf-8?B?dURxTlBIeVlOQUxIbFE0SWQzUzEzVHdlM1M2SHBCVlplTEdJM0x1R0kvQ3BY?=
 =?utf-8?B?eklRMDYrSEtpWGRBMHZMNm9zaGR5ajJXZHJQUG9xYVNiMURYcGN0L1BmdHhr?=
 =?utf-8?B?R1BiL1pGTlp0VnA0Z2twaWl6Y3ZxZ0tVN2VubFI4M3g2eWpjbEJLK1BnTVZi?=
 =?utf-8?B?cFNFU2d6S2xOUkhMTHdDMTNEOGpWNUpWY09GWXdnYnoveHNYN1hFbmN3Zjdl?=
 =?utf-8?B?UjgvQnR3NmNPYXA3Z0loUnE3Z2FpcHk3K0FBa0R6YTN3SEU2TXEvRkVDNUtl?=
 =?utf-8?B?YjlaNWFNSGlOOEV3cE5PakN2T2xac0N5Mm9iS2JVWGcrd01ZamdXb1NHa3Nl?=
 =?utf-8?B?L2NVeG1IWW16c245VTBPd2VvN0NOUWh5L25jSnY2Y2xhL0FDcklpeHZVVHNt?=
 =?utf-8?B?dTFoMjFqMVJDTFh3MW9xM1hZK3FwaHpUYWduZEgrVDBDY3ZBWUNwcDJTV20w?=
 =?utf-8?B?bERQaXBVNjVsQ2lzSEkwamM0a25sZ3lLYXRQTDlsL0pTVDFmSUd2c2dFb2xW?=
 =?utf-8?B?dUY4bEVFWHFsTkRSZ3hRTTNKcGFpYzVDK1lOaG41UXV6L29ETElHb0xRRnda?=
 =?utf-8?B?RXJBSmRITHp2L2MyTzRGamcrczl0UVJBUWlLN2FLbXJBM2YxdHl6TE02U2JX?=
 =?utf-8?B?dmI4MlFPMFpRMURCbVZFQktJcVluTmlZdEt2NGhhcUIxTnhOZGdERlFudzVn?=
 =?utf-8?B?RUFoSTZoNzRCZkdKbXNpaEZPY0JFK1VCMFdTN29rSGhITVpteGwxd1hoUldh?=
 =?utf-8?B?eEg2Q2Vhb2wwMWh4dUtWZUVTQ00rMnpOMzErYW1QZ2hVV1pjUk5kTkgvck1m?=
 =?utf-8?B?VVAxS2VvNXhYbmNnRWJna1Z1Z20xdHZ5WjVyWXFGOXpiR0R4ay9UM0FSNTI5?=
 =?utf-8?B?a3Y4UlJWc3E5bFNRRUhIUEt0bmRLdXZ2ek85NjloL2x5UXRId0dXSUlxQlgv?=
 =?utf-8?B?SWcxNHNiUWlZMUNnQ0VlakttcXFzS3lHdVRCWHRXc08yRzJjQ3RNNmplS3g0?=
 =?utf-8?B?TEJyQ0x6YkIxaXQ0RW9jYk1jRHNQOThRN245YVVrSElBd1Z1N2ZMdWpPdWY3?=
 =?utf-8?B?blI3cDlOdTdoUHQxNkN6cklBWm5zc1RKZXhTTysramNFZ1B6L09wbjdOVk5r?=
 =?utf-8?B?OHpRVWlCcjg5L3E0Z0hhdnJnYlVHamFLNlJ3VU9vRnl2ZkRsZm10TnNXNWVj?=
 =?utf-8?B?MEM2ZVMzRFZ0bnJFZVArbWJweXhhcDZQQk1wUFFUMmFVN1BsVmV1TUtTeUVB?=
 =?utf-8?B?emthZHRGTFRBT0s1YnMxemNudmpsVnhlaE8zVHFSWXRJQUhEVTlCc01FY3BN?=
 =?utf-8?B?SFVMaEtwUzk0Y1VzaXNWTHBMZnVlWEIzanpRd0xNTHJNTnFrVG5IaUFYMEds?=
 =?utf-8?B?bmpTOHMrc0E0cXB0S1VYU2pkMWdWekk0S3ZHYkJKMFdXNkl5MFJ6SlhXa0RF?=
 =?utf-8?B?TlhTenM1R09RSWNja3RYVWFqUkRjS0tQcjhTUk90ZjBwNXZQSTAvbnR6aHdR?=
 =?utf-8?B?aHZKMThReUY2Q3BaRUdTM2NzTHJvUnk3QWU2dnpxQktDWFdORmlRZHc0QWd1?=
 =?utf-8?B?YjlLV1N1YTNGOHErUXRuQlNJbVlJcXpTQ1U1VWhvQzRScndSM09hZUJuRmg0?=
 =?utf-8?Q?5vXpFPgWIIY6JexqRZ29KG9pY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <336830D9E34D73449AD394F63B47B714@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7016.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68847af-36f1-4b70-9cbe-08dcb2ec32bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 12:11:11.2561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKy5wVa1QBxEz1AjO9ll1pSOg7+adk7PO9rE8AOCl7QzxNAAfidlLycIwPBrp5M6d7XitNHWs61q/ShEiymYNGG+jn2JTkQF24jS2Dl/WYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8497

SGkgQW5kcmVpLA0KDQpPbiAzMS4wNy4yMDI0IDE3OjQxLCBBbmRyZWkgU2ltaW9uIHdyb3RlOg0K
PiBVcGRhdGUgdGhlIHBhdGggdG8gdGhlIHN1cHBvcnRlZCBEVFMgZmlsZXMgZm9yIEFSTS9NaWNy
b2NoaXAgKEFUOTEpDQo+IFNvQyB0byBlbnN1cmUgdGhhdCB0aGUgb3V0cHV0IG9mIHRoZSBnZXRf
bWFpbnRhaW5lci5wbCBzY3JpcHQgaW5jbHVkZXMNCj4gdGhlIGVtYWlsIGFkZHJlc3NlcyBvZiB0
aGUgbWFpbnRhaW5lcnMgZm9yIGFsbCBmaWxlcyBsb2NhdGVkIGluDQo+IGFyY2gvYXJtL2Jvb3Qv
ZHRzL21pY3JvY2hpcC4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vckBr
ZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWkgU2ltaW9uIDxhbmRyZWkuc2ltaW9u
QG1pY3JvY2hpcC5jb20+DQoNClRoaXMgaXMgaGVscGZ1bCBmb3IgU0FNOXg2MCBhbmQgU0FNOXg3
NSBib2FyZHMuIE9uIHRoZSBvdGhlciBoYW5kIGl0IA0Kd2lsbCBhZGQgb3RoZXIgYm9hcmRzIHRv
byBidXQgdGhlcmUgaXMgbm8gZXhwbGljaXQgbWFpbnRhaW5lciBmb3IgdGhlbSANCnNvIEkgaG9w
ZSBpcyBmaW5lLg0KDQpSZXZpZXdlZC1ieTogQ3Jpc3RpYW4gQmlyc2FuIDxjcmlzdGlhbi5iaXJz
YW5AbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gQmFzZWQgb24gZGlzY3Vzc2lvbjoNCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDcwOS1lZHVjYXRpb24tdW5mcmVlemUtYTcx
OWM2OTI3ZDczQHNwdWQvDQo+IC0tLQ0KPiAgIE1BSU5UQUlORVJTIHwgMyArLS0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCAzNmQ2NmIxNDEzNTIuLmM5
ZjMyMGJhOGJjOSAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5F
UlMNCj4gQEAgLTI1NDIsOCArMjU0Miw3IEBAIEw6CWxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZyAobW9kZXJhdGVkIGZvciBub24tc3Vic2NyaWJlcnMpDQo+ICAgUzoJU3VwcG9y
dGVkDQo+ICAgVzoJaHR0cDovL3d3dy5saW51eDRzYW0ub3JnDQo+ICAgVDoJZ2l0IGdpdDovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hdDkxL2xpbnV4LmdpdA0KPiAt
RjoJYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL2F0OTEqDQo+IC1GOglhcmNoL2FybS9ib290
L2R0cy9taWNyb2NoaXAvc2FtYSoNCj4gK0Y6CWFyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC8N
Cj4gICBGOglhcmNoL2FybS9pbmNsdWRlL2RlYnVnL2F0OTEuUw0KPiAgIEY6CWFyY2gvYXJtL21h
Y2gtYXQ5MS8NCj4gICBGOglkcml2ZXJzL21lbW9yeS9hdG1lbCoNCj4gDQo+IGJhc2UtY29tbWl0
OiBjZDE5YWMyZjkwMzI3NmI4MjBmNWQwZDg5ZGUwYzg5NmMyNzAzNmVkDQoNClJlZ2FyZHMsDQpD
cmlzdGkNCg==

