Return-Path: <linux-kernel+bounces-192668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AB48D2070
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C132859C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9FC17108E;
	Tue, 28 May 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EN/FLZd6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FNAiw5qZ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727C13AD3E;
	Tue, 28 May 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910394; cv=fail; b=cGVrm9HjqL523JQXKPvH15TXRZ1ypd0h+3GJgnM+9Llwv9Df20LlgDn3AfBAR5gYLswU7Nk5dSLgOgf5JBibaWEbG/vSsE1pA9SYLQbgR0sbiosc/oFrfPMp5UqqANxqHWfkj6LoOvTRmBz2aDobg4dwVelDXEwUdna+tGqHwfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910394; c=relaxed/simple;
	bh=gHXf3Zcz60lBQnGXOTTtLTRRouNWnln2T81TAqf+OG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V8rseDB7u59JT3AC4HtVIfFmz+Cvg5qWPqHCZ534VQhiYkRin8hyBa0s3kZXonrSEwKRyg7cbPfq39RBJj9JyyvSOg1HgbfxZc9X2C8yalldcoLDWRg4Rinlt06I0Rlh/jqi/ONMqvYTJV7pXdHWWW4ZeZp4FEdl0V4A7yX9CBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EN/FLZd6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=FNAiw5qZ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 92f4d4d41d0711efbfff99f2466cf0b4-20240528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gHXf3Zcz60lBQnGXOTTtLTRRouNWnln2T81TAqf+OG8=;
	b=EN/FLZd6JqvB4tEidhRqZwKY3rQzTkEXUUjIKWzOIUWQ3ndLzx7rARd6/UQAZB4JAe3FLO4s6iuIvwXh8BXOo5Wt6qAvdOfZtDy3erJnaidLg8AwgQcCj43Kv/qEnZOezSo0MevK69C2QHvYssa1bp/xjzpL3oZXL7BxM7ksjjI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:851f5e2c-6643-4bab-b420-7fb3fb8fd925,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:fd6ee943-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 92f4d4d41d0711efbfff99f2466cf0b4-20240528
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1546653835; Tue, 28 May 2024 23:33:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 28 May 2024 23:33:02 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 28 May 2024 23:33:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEfCBJkfk9YpNbASyPePDeTNSZYxwMmHiLUDK02dK3R+lfOtpGmfIqshARZbCytakSEj4dZlobckmfXC8JEK6FxO+EN0pBxggXKk5ZrfLgTDWzB5EoqERcEAf69pMTfhxl1G/1CEg/FM22oapUmE7KFGGhh6skD3oPXSf6z8Jb61ul0Sw46eROD2UL6NM//T15WHqyW+o54uSlxy1D04sARlpnpRV1btgxnZnY59udZfkUFBpwZIonoJbrhqbmJvYoe3xg/xyfHdeczqZl1bb4bFTngfEdxDxi0H5sE5/S77je1N2z4FlJHp41lDded9E6gzIA5niQvne/VgOGnJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHXf3Zcz60lBQnGXOTTtLTRRouNWnln2T81TAqf+OG8=;
 b=dPby2n0AHAukyf6K3423fFnKS3eq6cQEkcn5HZ5Pz/aseoAV8CbAHEzznhx6ZlEfINhx55qw5mBtm36Gfw98jy7YDA6oKSxf8JnixlQ2cuOxIgg+hyCqIimN9u/THTZ60CGgJsxtO0wjq4tGyW3eQW45zqjYjEEiWBn+ALjntSJxx4Xj/RxTYvMrG5G1hKDnsELE13YFodMJDonwYGtjKabajs4uW/T/pNAXer+J78JnlP/8SmwMvh8Ad7e18ix1tx5mCf6WZ6TbvRE8XpIDbc3shPBcMWtwDslKmDnjJ9k6ht5dPKJdHIdk97aQcAGOAAixwoMz5pLFsnqYzXcFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHXf3Zcz60lBQnGXOTTtLTRRouNWnln2T81TAqf+OG8=;
 b=FNAiw5qZP3jx/i7XN9BPNb5Hguo1Tz0jqve9KLkO5fRwsmoydne60YO+9nYMmuCTliWsSqd6M/D/P0dwQjgqXE3KYSxyLhhihcWnA6LvoGkBxE6X43CS5aIc+SHWTd18w36wo+nhUD/jN9cL4xEdSoDsyN9M1SkPiQVwACU8Wnc=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SG2PR03MB6455.apcprd03.prod.outlook.com (2603:1096:4:1c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 28 May
 2024 15:33:00 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%7]) with mapi id 15.20.7633.001; Tue, 28 May 2024
 15:33:00 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND,v6 8/8] soc: mediatek: mtk-cmdq: Add secure
 cmdq_pkt APIs
Thread-Topic: [PATCH RESEND,v6 8/8] soc: mediatek: mtk-cmdq: Add secure
 cmdq_pkt APIs
Thread-Index: AQHar3tfI4StAhxEi0CN3KPsYLIClbGr95IAgADSGoA=
Date: Tue, 28 May 2024 15:33:00 +0000
Message-ID: <6141715c6f17ff5bb39460d87b88f93785a613a8.camel@mediatek.com>
References: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
	 <20240526144443.14345-9-jason-jh.lin@mediatek.com>
	 <98b5d60e0ca29e6ac126035c1594c8b0d0210aba.camel@mediatek.com>
In-Reply-To: <98b5d60e0ca29e6ac126035c1594c8b0d0210aba.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SG2PR03MB6455:EE_
x-ms-office365-filtering-correlation-id: 7cd06006-bdf0-4bd6-6ca0-08dc7f2b7515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dmFzQWg3L1NTSkJ3NWhsWnI1Y3FJaFE2UVl6a2NLMDl5UWFIVmpoR1VHU2tz?=
 =?utf-8?B?MEQ4TUlYQ1dkdlN3RTlaNjdPL1pRWVErQkh3TzFzSHNxTndDOTlack4ybTR6?=
 =?utf-8?B?dEMwdGs4aXhLMjUvL1hyaDAvNXFBSFBnWTY1eHZhUGhPSmQ2QWRaRFZCUWJ4?=
 =?utf-8?B?a0k4aURaUW9aUDJJU01CWm4vVTkyUkNBTlZKeHo5REJDMDY5dTNYblFJQnlN?=
 =?utf-8?B?N2ZJL005MnAyc05mQ3pXK3h1N2drTGNOVWxFa2EyMFN3OWVMeWRiT1Zqa3ls?=
 =?utf-8?B?cnVBS2ZRMmRUTys1a21DQWhTRkpPYlNMRWRaUi9EdDJpSzVwSDNScFJFWE1h?=
 =?utf-8?B?dEdRaXpMWGxmTXdacno5MHRUeWhNaVJlbStkeFpqWmVzb3puT3kzVittQ25M?=
 =?utf-8?B?ek53WENmam9mbE5qdE0zZVQxRU9kN2MzRWNJTkVaSHphRUJkRHZiSEh6UGtH?=
 =?utf-8?B?RVNPNmx1MjJrVyttYTJOTDVyWE40dTZuNkx5RTN5Zy9FNjRsNlpEUlVQOWVn?=
 =?utf-8?B?elErSWo4YUx3MFh1cGZUQTRzOER0SlNrbXNUbWpjTFVRUndFbXBkWWl4a1hG?=
 =?utf-8?B?KzNBRXdGNDl3cHh4ZGUxKzByNDVMajZpRlkwNXRteHA3SjJhUWg1NDYxQmlF?=
 =?utf-8?B?K09sSjh0RWkrRk81Q2JEYnpLRTZBR2NoVjYzZVN0cnZoazlOaGowTi9Pb1pa?=
 =?utf-8?B?T1NneFhWMHdTMDBKUmFZdHhmajBnWC9tWW1GcUUwZVUwdFp1N3A0RlgvL0xU?=
 =?utf-8?B?WWRsc2R3NktIRlZTNG9Lc1VFR2JXaHRVMDV5dk91akVtaGpLRVlDcFJxT2Vp?=
 =?utf-8?B?MWFPZ1p1Y2ZiZmJjdFZHbjExUUxyYzBtYTdMQ3pKUFBwRGw3NHd1N2tLekdH?=
 =?utf-8?B?akMzS0hlOEpQNHI2NU5SaDRFeDU3QnZaTXUyaGMrTnU2ejNTV3dqRHRuV1F0?=
 =?utf-8?B?dkNXdzVwRmVCNTRCL21YdFJhcFJCWXovUS9OdkVYenA5SDIwUFhJbXdpaDVm?=
 =?utf-8?B?RVBHbXV1aUxaV2lxOTROaFlhd0xOcmFxUXlsNVFOSVVmOURORy9uT3NxMmlG?=
 =?utf-8?B?TDhvRjc3d0tjNW9yM1c4cHVCSUN6VUYwTFVMc1RBWHhvZWNvamdyanA5R0RQ?=
 =?utf-8?B?U0ZiazJ0bkZ3M01GOE9sdXNLUEUvS1JUZldJS0Q1bTB2bmZTZ0dUdTdCa25o?=
 =?utf-8?B?aEwrRnc0ODFpSitUNUlyTlJYRFpYTm45QURwQjRkaHpvbk9KZDBzR1J4MHJX?=
 =?utf-8?B?eE5MY243TWVJTzdWY3JNRGZ3eHBrVWg3ZzBreXN2djRCd09wSnRwZFptRjli?=
 =?utf-8?B?dWQ3d2Z4RGVsODJ4MGl2UTI1TlZrK0F5YkFRY0ZqUkdhQW5IYlA3enJzL3FE?=
 =?utf-8?B?NnAwZlpkVktaT3FHOVFRQVRMY3hPRVpuZi8vd2FWSEJ4UkpvZjVvZlZkRXpv?=
 =?utf-8?B?R2J1RzhhTTZyUXlxcDEwbHhSOG1iMmxDUFFDRTZaOEdqalZsTmY0VEd2ZmNV?=
 =?utf-8?B?S2c5SEFRUXQ2aHU5ZUl6enVHY2xWUVVhV1MzYmxlQnFJUFcxQXFlY2h2UDlj?=
 =?utf-8?B?cG5MSGdjbXZRcXg0ZzUvVFRTTjZKbUJXUGw1cEhacCtzSXkwcFRJbG9KZHM4?=
 =?utf-8?B?d1BvSHZwQTF2VWMrLzBwdTI5VVdBZVJMaGlrMFE5WkI1OGYwSUljZEFqTXlW?=
 =?utf-8?B?bm0rMW1tZmFGT1JQUHM3QVJWd0lsTXFSenVtTGoxQ1dmNm0yN3dxS1c0ODcy?=
 =?utf-8?B?UW1KM1RTQmNpVUlyV0Ftbm5lWnRxc2lBM2lPa1I3anNmNisrTXVXc3ZSSG1h?=
 =?utf-8?B?VjJiYWdpZUp2VnByTWdWQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmlXTEFSMGVWMnFhdmVGV2kwMkFYUzhtQ2o2YzdUb09OU2JnT2ZIQUV4a2Q4?=
 =?utf-8?B?MGRROWU0djdkMFVqMmZJZE5SQVhzV09MOFg1MlNWclV5NENkdTZMbHBBLzdQ?=
 =?utf-8?B?alE2NjRpMlBEdGJVeW1IcktFTGpiSTJrc1diNlZWNXMzYmJIVkNrcGl3V3Ba?=
 =?utf-8?B?d0t5dG1ROTVKU0d6NGpLK3NxQ250c0ZkL3FCQjlySC84ak95dkJiN1NLbi9r?=
 =?utf-8?B?cHlrV2FIa2RxZmcrN25IcUFPanlqeEJzRjQ2eHNvNXB4ZUJncXJXVG5ndEs5?=
 =?utf-8?B?MWE1MGZOUk1NOU5RSTVGVUNxYk93Q3ZGdjR2djdwZUIxcGZmNjY1dHlrdDgx?=
 =?utf-8?B?ZFRtaHBINzlzb29wUXQ5Slk3dHJXSVdQNlkzSU1VMlc4QnJiUEJGbnloOFdp?=
 =?utf-8?B?L0dzMVN0dFpOamthbEozdG1nQzNsSWpRVURIMEtLS2YzZFF5V2ovQ0xBcFFq?=
 =?utf-8?B?bUowWExaU2NHSG53YllWN0NJM3A5V0R3YUgwd1hvMEhMOXZqd0xFNFN6T2Zs?=
 =?utf-8?B?M3FFMERaK0VzVHdPdThUQVg4R2xSeDlCQ2NUdDJEWUVJeUN4N0VFQ1VEOWNP?=
 =?utf-8?B?dVVMQm8yRlNWQ2hWSHhYenE2T0x4QWxIZUpPV1NiRkhzM0pOaXF3cnoxdVpS?=
 =?utf-8?B?MVdIUzRRZEZteEJRLzZyb2tqam1EeENrUnRDSDFCYjJyeHBsbWhhZytoRmZp?=
 =?utf-8?B?bmU3UGZjc0dycEFKRFR0cXUxREMzZ2lCNXlLcnpvMlFUdkVCeFM5Znp0WXlG?=
 =?utf-8?B?djNKUWhYRG5hRklBZ29QZitlYklWVlU4Q1FQazlkcm02WmQ3eWRLWHd3QTJM?=
 =?utf-8?B?M01mdGtYYU1Hblh6alZpYk9KU1k3dVovZHd0ZGlaak40VUViaGhDbzNrZ2pq?=
 =?utf-8?B?ZHN4ZDRTY0tQWUp3bHgwQjVnTTBqb3FMSkduWFU3emN5blFDQkN3dEd1emZ4?=
 =?utf-8?B?R1NDTHJMeis1bytla0VMTjd2VGhySGF2YXhCSFFPUHd3L3daRExsS3ZPK3Bq?=
 =?utf-8?B?dWRieGhsb2h2Y1VkUEZWSGtFNzVUTWd6WmhpS1B6YzlWbHB2Y3FrLzVvSzlZ?=
 =?utf-8?B?MnhoYXdmVDNHWDZuc21NKzV6b2hybzNwY0dzT0d3WCtVK0RQYUtQaGY3VzZ5?=
 =?utf-8?B?VEZWNHZqeklINkRsK0EvU200NUx6VUcvWHI5TStGSG9rZWg1WEc1VEdHUC91?=
 =?utf-8?B?NUNWcnVLYzZjeHRYT2tUU3VtY3h6YWlYdi82VkVFdU5ad0pEQmlXM0x4UXRK?=
 =?utf-8?B?QmRMMG5CTFNLdEZSTVQyNnFucTNiLzE5cFpWSjRkZURJUzBySFFoajNEcW5x?=
 =?utf-8?B?dmJQYTNiL0wzWmM4d2RBUWdQY3FYSC9uRGRjK2EzSktaOTNiR3BIMWxNVG9D?=
 =?utf-8?B?MFhkTlA1cFQvcUxJTnZtZnVrQTlRR1J3UU5Hd29yOFYyWDdPV2tIY2dNVUtM?=
 =?utf-8?B?OGpLNlJOeDhzTXZIMWdiUkhlTExSWWNkaFdWUUJqbUgzZ2N3K3RqZk5KRHF5?=
 =?utf-8?B?SmpwVTcrZFI4MkxkK2ptU2ROV1RFWTZzZGNKd1FBd1RDd1lqM3RvM2tjTDh1?=
 =?utf-8?B?LzJPdzdOWXpiNlJPRjFHQUtLSGwzTFVPZE9GcmFOclp6RGk3UmVvdTdPVGoy?=
 =?utf-8?B?aDFxbFg1WWtlWFZ4VitBZzIrVkZyWHhWRjFhVm50YU5QSU1td3pQWjBWQkdk?=
 =?utf-8?B?RU1XcldrQmp6VWVqVnd2RHdhOUE2eHFkTFF6VTh4aG54VURnamxqcXRXZlJ2?=
 =?utf-8?B?cWJkbDlnMnVuaFVHV3hvaE5lUzh6RVpVZ0VZWmlqL0FZNHNVREhpeiszVVh2?=
 =?utf-8?B?b1IwNmQ3ai80dTFFRzZiK3RIVDZqcnNja2V5VC85ZGVGeUJJTExtcjZGTkJu?=
 =?utf-8?B?emZvSVFKS3FUei9yN3ZsemloRnNwTUtHUE1ya29ZVFlNY1lGV3NveTY5Z0V0?=
 =?utf-8?B?alRJK2RGN1dLZFQwK0F3L1UrZUxQcTlQZUUzUjVaNWxKTUhVWlpuQS8wZjlN?=
 =?utf-8?B?VVV6bFFPTXhkeWZ5QzI3M1h0WGo5dTRFeVQ1ZkhFVGp3bVhvNEc3VHI3NzRa?=
 =?utf-8?B?NlNHVGVUeDdmL1JUUDhDajJBaXlqRXo0UHFkbjB1RGFpZEJlZnNYZDBjeGFs?=
 =?utf-8?B?ZG9xcnRJTXNQeE1ETk5IcEZXVnZyemJhcGFyMjRyZ0NDeEFCOTV0MnljdXp3?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C12C69A5952D4F4FB88C65F0634E57D5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd06006-bdf0-4bd6-6ca0-08dc7f2b7515
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 15:33:00.4314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xBpSD1cltK8YwqnmiHAab0PAZXWAVtfH734MLXF9LSYyPx8H5s4JdXosiAM4ssOxIoB7JY9QFv8GgZUQ09puD8xz0tUupVglo5kpUTCSp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6455

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAyNC0wNS0yOCBhdCAwMzowMSArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4gDQo+IE9uIFN1biwgMjAyNC0wNS0yNiBhdCAy
Mjo0NCArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IE9wZW4gc2VjdXJlIGNtZHFfcGt0
IEFQSXMgdG8gc3VwcG9ydCBleGVjdXRpbmcgY29tbWFuZHMgaW4gc2VjdXJlDQo+ID4gd29ybGQu
DQo+ID4gDQo+ID4gMS4gQWRkIGNtZHFfc2VjX3BrdF9hbGxvY19zZWNfZGF0YSgpLCBjbWRxX3Nl
Y19wa3RfZnJlZV9zZWNfZGF0YSgpDQo+ID4gYW5kDQo+ID4gICAgY21kcV9zZWNfcGt0X3NldF9k
YXRhKCkgdG8gcHJlcGFyZSB0aGUgc2VjX2RhdGEgaW4gY21kcV9wa3QgdGhhdA0KPiA+IHdpbGwN
Cj4gPiAgICBiZSByZWZlcmVuY2VkIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gDQo+ID4gMi4g
QWRkIGNtZHFfc2VjX2luc2VydF9iYWNrdXBfY29va2llKCkgYW5kIGNtZHFfc2VjX3BrdF93cml0
ZSgpIHRvDQo+ID4gICAgZ2VuZXJhdGUgY29tbWFuZHMgdGhhdCBuZWVkIHRvIGJlIGV4ZWN1dGVk
IGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gICAgSW4gY21kcV9zZWNfcGt0X3dyaXRlKCksIHdl
IG5lZWQgdG8gcHJlcGFyZSB0aGUgbWV0YWRhdGEgdG8NCj4gPiBzdG9yZQ0KPiA+ICAgIGJ1ZmZl
ciBvZmZzZXQgb2YgdGhlIHNlY3VyZSBidWZmZXIgaGFuZGxlIGJlY2F1c2Ugc2VjdXJlIHdvcmxk
DQo+ID4gY2FuDQo+ID4gICAgb25seSB0cmFuc2xhdGUgdGhlIHN0YXJ0IGFkZHJlc3Mgb2Ygc2Vj
dXJlIGJ1ZmZlciBieSBzZWN1cmUNCj4gPiBoYW5kbGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ICsNCj4gPiAraW50IGNtZHFfc2VjX3BrdF9zZXRfZGF0
YShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZW51bQ0KPiA+IGNtZHFfc2VjX3NjZW5hcmlvIHNjZW5h
cmlvKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgY21kcV9zZWNfZGF0YSAqc2VjX2RhdGE7DQo+ID4g
KwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWlmICghcGt0KSB7DQo+ID4gKwkJcHJfZXJyKCJpbnZh
bGlkIHBrdDolcCIsIHBrdCk7DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICsJcmV0ID0gY21kcV9zZWNfcGt0X2FsbG9jX3NlY19kYXRhKHBrdCk7DQo+ID4gKwlp
ZiAocmV0IDwgMCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXByX2RlYnVnKCJb
JXMgJWRdIHBrdDolcCBzZWNfZGF0YTolcCBzY2VuOiV1IiwNCj4gPiArCQkgX19mdW5jX18sIF9f
TElORV9fLCBwa3QsIHBrdC0+c2VjX2RhdGEsIHNjZW5hcmlvKTsNCj4gPiArDQo+ID4gKwlzZWNf
ZGF0YSA9IChzdHJ1Y3QgY21kcV9zZWNfZGF0YSAqKXBrdC0+c2VjX2RhdGE7DQo+ID4gKwlzZWNf
ZGF0YS0+c2NlbmFyaW8gPSBzY2VuYXJpbzsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiAr
fQ0KPiANCj4gV2hhdCBkb2VzIGNtZHFfc2VjX3BrdF9zZXRfZGF0YSgpIGV4YWN0bHkgZG8/IEl0
IHNlZW1zIHRvDQo+IGVuYWJsZS9kaXNhYmxlIHByb3RlY3Rpb24gb24gaGFyZHdhcmUgb2YgY2Vy
dGFpbiBwaXBlbGluZS4NCj4gSW4gZnV0dXJlLCB5b3Ugd291bGQgdXNlIHNlY3VyZSBHQ0UgZm9y
IG5vcm1hbCB2aWRlbyBhbmQgc2VjdXJlDQo+IHZpZGVvLg0KPiBXb3VsZCB5b3UgYWxzbyB1c2Ug
c2VjdXJlIGRpc3BsYXkgcGlwZWxpbmUgZm9yIGJvdGggbm9ybWFsIHZpZGVvIGFuZA0KPiBzZWN1
cmUgdmlkZW8/DQoNCkkgdGhpbmsgSSB3b24ndCBkbyB0aGF0Lg0KDQo+IElmIHNvLCBJIHRoaW5r
IHdlIGNvdWxkIGRyb3AgdGhpcyBmdW5jdGlvbiBiZWNhdXNlIHRoZSBoYXJkd2FyZSBpcw0KPiBh
bHdheXMgcHJvdGVjdGVkLg0KPiANCkJ1dCB3ZSB3aWxsIHVzZSBFTkFCTEUgYW5kIERJU0FCTEUg
c2NlbmFyaW8gdG8gbm90aWZ5IHNlY3VyZSB3b3JsZCB0bw0KZW5hYmxlL2Rpc2FibGUgdGhlIHBy
b3RlY3Rpb24gb2Ygc2VjdXJlIGJ1ZmZlciBhbmQgcmVnaXN0ZXIgYnkgc2V0dGluZw0KbGFyYiBw
b3J0IGFuZCBEQVBDLg0KDQpJZiB0aGVyZSBpcyBzZWN1cmUgbWVtb3J5IG91dHB1dCBzY2VuYXJp
byAoV2lGaSBEaXNwbGF5IHNjZW5hcmlvKSBpbg0KdGhlIHNhbWUgZGlzcGxheSBwaXBlbGluZSBh
cyBtYWluIGRpc3BsYXkgc2NlbmFyaW8sIHdlIHdpbGwgbmVlZCB0byB1c2UNCnRoaXMgc2NlbmFy
aW8gdG8gZGlmZmVyZW50aWF0ZSB0aGVtLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4g
UmVnYXJkcywNCj4gQ0sNCj4gDQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGNtZHFfc2VjX3BrdF9z
ZXRfZGF0YSk7DQo+ID4gKw0K

