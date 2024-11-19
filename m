Return-Path: <linux-kernel+bounces-414137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB8B9D2399
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D83B2466B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A61C3021;
	Tue, 19 Nov 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VzFRWm+D";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="RIQ6ghhL"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CD1C2301
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012160; cv=fail; b=I/ZppzlHP9pJN5Ja5wp1Ft+IrTKwcXZuZe47EgZYYjtTSFUrX1xtz2/nQhMwIEqAQc0z9/IdZW3X7qnPtIAujfAkrQM073RIeomw6j5r5FrRy/AZelB7BrbAYbT807yIKylAIhyKpAZJlLAe7V3dVzs1QucVTf8icynt/WnA+H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012160; c=relaxed/simple;
	bh=VUOAr8sjpcIB7TxdVIqYOEBkRnAhlxN6/LaBSydRMRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SdQFYRLr5q5A7eIi3IcOmuoDwHc4ODqVrBUPyhoFe870i+9/+sJoGoL425QFY0QF9O0youmebWryFcb2JiqpupAMixuG4/E5HkwYNYOjCJKGQbAV4LubfbvgFcsuhrUF195dS+od5+wH74ROU4sDXPU5Vcr67fcafGZqCan5oD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VzFRWm+D; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=RIQ6ghhL; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1ebefd86a66111efbd192953cf12861f-20241119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VUOAr8sjpcIB7TxdVIqYOEBkRnAhlxN6/LaBSydRMRs=;
	b=VzFRWm+Dm62282Rjr7AUDsZBGGUTrPLRuO+0qRwvFnPLbEWhSPUovEp/xRnhrafKxb6lOFJjUy4yaL10MRvIHEARLMzOUV283NONAepcOMX/zpXEvWN4FWThPCdxMxrf7F9LRYu+MZh20AxPEyBBbPr2mJGLwxVVdOnmeZyT0Jg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:8da63220-2d79-49a3-bea4-bc08681968cd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:31265307-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1ebefd86a66111efbd192953cf12861f-20241119
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 155454102; Tue, 19 Nov 2024 18:29:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Nov 2024 02:29:11 -0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Nov 2024 18:29:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd3zvrRLW0YrkRCliGyW2Pmu3QikDDhYHq4JLvux+ML8XmzeMngZgbNXS+BVyiivgyLxJERu6T3F6hNXOup+C9RFz+w1Iw88m58IX46a5IuXshPvI9BvPtls2mKdqCtRcSDRXfEx9rXxO8wRL8yb8vuyyRekKuk9t532HrpyMcBpX+PYgp/W/3Pez8cBU+EfyUbEBhjjdVgimQ6QOvy0DD3hmvhUaOvv/VJOZC9RwBhGS7SYtlCsYBM9kiiUlaOU9e2KuLNaig0e8y3YfsRKkcH6gQ6nmIUp5Pd/7pNwm+aKlaxVxXwmKzjIBo1YJjRvLzp/4clApA5xG2gMjBbEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUOAr8sjpcIB7TxdVIqYOEBkRnAhlxN6/LaBSydRMRs=;
 b=yCIr0+osEMDCGV1vnZ7kJppr4OFnPZbuf8TUSeRqKpHkfcWa32K5AffzpE8x+WfzdYbO/fI4SDwYKnTudUsUiMSNIzNKzAV/4zrOZ7GjOZEojgr2oltelP/uH0aNy2AaLzL2qwftk0GyA77jH2BNReFYk2ghtBs3zWmIIgybPl4SuOm96hQtcK5q9JLkmceusNKkv18g99DwmHgQQWAj8oLrto8mGruWXkHxln0MN26mTXT9CO9rPduN2EwVuFZfKHrBscWLDovT3c8ZsNbHlC80QMGFNsS7HpA6203pDfGL17tp3SmwYYNh1R8zDLhscCc2lOGxFnKExLowsVGdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUOAr8sjpcIB7TxdVIqYOEBkRnAhlxN6/LaBSydRMRs=;
 b=RIQ6ghhLdjeejnn2qlz/dSMK5pagwxsj7nqFjtc/AkzuuhiTmDN2O4345103vJ+NAtHLV8Y78LqjmiKL5i83bdW7FsqaAkimKyc9vYELazAGyz8zHj3LU4r9RgvkfxAEzBpUdLxTOgZ0MPVfUgE7wJPX0cNVPGPusk40pN5NuKI=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYSPR03MB7370.apcprd03.prod.outlook.com (2603:1096:400:414::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 10:29:09 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 10:29:08 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "gch981213@gmail.com" <gch981213@gmail.com>, "miquel.raynal@bootlin.com"
	<miquel.raynal@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"mmkurbanov@salutedevices.com" <mmkurbanov@salutedevices.com>,
	"kernel@sberdevices.ru" <kernel@sberdevices.ru>, "d-gole@ti.com"
	<d-gole@ti.com>, "dev@kicherer.org" <dev@kicherer.org>, "vigneshr@ti.com"
	<vigneshr@ti.com>, "richard@nod.at" <richard@nod.at>
Subject: Re: [PATCH v2] mtd: spinand: add support for FORESEE F35SQA002G
Thread-Topic: [PATCH v2] mtd: spinand: add support for FORESEE F35SQA002G
Thread-Index: AQHbNOrToR8/CnEAIk6bN9gkcdT1vrKzd0YDgAAKBICAAWtZCIAAEgQAgAlzPAA=
Date: Tue, 19 Nov 2024 10:29:08 +0000
Message-ID: <9b87c51ec60df455911c0a4752407bb6e4af8569.camel@mediatek.com>
References: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
	 <20241108163455.885-4-SkyLake.Huang@mediatek.com>
	 <dbdb45ed1135e73b4eebd76e6f61b96d48aaedc6.camel@mediatek.com>
	 <87ikssu3qq.fsf@bootlin.com>
	 <12f4d28f3efb7fe319ec919df92145c4ad24da01.camel@mediatek.com>
	 <87h68bsdv6.fsf@bootlin.com>
	 <CAJsYDVLYE1=sAj5Pvni17xQ=4akFCA+UqtuB5RKq77HxL4ux9w@mail.gmail.com>
In-Reply-To: <CAJsYDVLYE1=sAj5Pvni17xQ=4akFCA+UqtuB5RKq77HxL4ux9w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYSPR03MB7370:EE_
x-ms-office365-filtering-correlation-id: ee147f49-410b-4e08-3b10-08dd08850020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YXVWSXpEOWVOdmEySUluUGw5ZUNKaTg5Y2hoTFVuNDZJUll0aFY4T0RwTWg5?=
 =?utf-8?B?bC9TSmozTEtDcFJldkUzZ2ZQUXNyKzVLUkRFZm9YWlppMG9Na0JTZjJPMUlu?=
 =?utf-8?B?ZjcwZlNOTzJxSDdUbitJRy90UkNlenRhU1RvWkt5NGE2dlVQcXg4SW80anlh?=
 =?utf-8?B?a1ZFSXN0cDJ5Tlhvb2VnTlFqU2J5eDVrTisxekdVUUlOVzR1QVhEaGJoanJm?=
 =?utf-8?B?YVRvUHFnN2lBS3F3Wi9vUjRoVERLY0haWjExZE9zb1VWOVJQSUh3ZU5NWlBM?=
 =?utf-8?B?NStQQTZNYUhiSzV6cThEeGFvYkYzUTR4akJQWUJkN1Vkdmx2L0VtdVBzMlJp?=
 =?utf-8?B?Tlh2dWlPelFBNGhKSk54QXFiN2ovZlRjRGNabHp0T2RyWFhXTDZXMHpsOUFK?=
 =?utf-8?B?TzNNcFExendKUjkrUTRkVUEyOVNpMzQ1NGpOa2psT00wNmdVMnkwQzdybHRB?=
 =?utf-8?B?SitoSDRBWWMrcGlFYUowcnV5WWxMU0ZyQ2JqdG1EemwxSEpyV09CeStuZTdo?=
 =?utf-8?B?bnhJQ2cvOXpjMEFwbHlRdUhaT3hwU1BUSFpWckpvdmFBWlJLSjVOMzVoN2Rn?=
 =?utf-8?B?UzYxeHVlWlJybzBUMURqOUVTT2VpK2ljdXkrWUNabzJVUEN4d1BMd0xTcU9q?=
 =?utf-8?B?VFgvUThVOXM1b2NJSVVLN1FRb3lEQW5TZEhtMm5MMzU0a05SNUxzeUwyUEdn?=
 =?utf-8?B?aVdOa2ZGdmVPbFRFQkx0Zm9KRVpWNG02ekFMbHBDbTEvNXhnSWdYYlNQYjRx?=
 =?utf-8?B?YjVwSzluQTAvWFBVMVRvVndqZGk1cE9OMzFQazJxSzBYY1JmVnlNa1htczdZ?=
 =?utf-8?B?dXdHL2JyQUp1M2lkMVlSakM0YklTcFVtcm1ZdHVMSW9ZZnpmbkpsQzFDSkt5?=
 =?utf-8?B?REVvc1p4bG1nNGp5SW9JT0xqS2JCVSt5Z2VFNWc0NVR2a1Vqd3Fzc1Z1Wkg4?=
 =?utf-8?B?WFNFVmdhM3BZckE5S3ZHUFRBbW8xcmRKSXFYbEdFNFFuUmVMc1ZOWmQ4Q2pa?=
 =?utf-8?B?SVZ2ZnYxdjIwamRqRm9QTTRSWEk2S3k1SURIUEovaFVBdHV1Z2RNbzdwSnhC?=
 =?utf-8?B?SDM2UEQ1QXZUQ2pacC9Cb2JEQ0ZEaVl1R3dJdTNsYnV5WGt0NkZGK1FzenhW?=
 =?utf-8?B?dWJWSXVtVjkzb2p1OUhLOHQvTUMzMlcrSGxESlZqNGhLWnNTR3N3VCs4MTNB?=
 =?utf-8?B?cHR2bkZjQXBJSWxYaFNqZmw0N0ovek9VUHhidnZTazFrWXRsMDhiQS90VUtK?=
 =?utf-8?B?YTZFL0NWTXkwdmNlT3pGUTBVcEVpU0xaQW1TRnpwMERDUmdBQ2xnUkN4R3FJ?=
 =?utf-8?B?TUN4d211MWVSZUQ1bUE5MDZzLzVJQ1VWUVFxK2pIVnlCTmg4ZUREUnZxUlBm?=
 =?utf-8?B?NElocjN3Vko2dE5BYVFNT3RoQmprTWt1QWtEZTRsUUw0N2x3My8vZ3RuT2Rj?=
 =?utf-8?B?SWhkU3hKcGU2dXdlMzc0bEZYQXN2WWVDcEdCZTRaUjlxeWhJT1R1OXArcllR?=
 =?utf-8?B?ZHhTeWNxWk9zRjFtWldWM3lUZ3pER0U0SzRKZ2l4VmEyZkhKVnB0aHBYVG0y?=
 =?utf-8?B?dHhjYUpWbnBtY3kzYmp5VEFrNHdySVdLLzF5cEtlZk8zRUJDemY2Z1ZoZE1w?=
 =?utf-8?B?Mzh5RTBLd200QmhZWWxKakE1b0x5TXk0ZTJBMnlCaXhzWXJqMW9wc3J5K0Qy?=
 =?utf-8?B?SWFwVUtkeUJLL0s2VWJrU0lUcUVSb00va1NjczdwOGw1cE1OVDNFRVh6eCs2?=
 =?utf-8?B?cHBCYlNKSEU1anowRjhkN3hybUFrQmRPWklJc2NvbHhBbUVia0YwdHY2MHRt?=
 =?utf-8?Q?wY4Ms5vbImIvWbKMaj/CpJK51fXZ9+/Dq3W5s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFJodmVtZnI0UGNFcHdxUFNqVWdIL1dKeVorMmltT2NQK1ZQN0U5cDlHYUxx?=
 =?utf-8?B?YVBueU9oSFgxTzN4aVNJNGxWTFBSZVJjSVVEZHFJcmFZdFV2MUE0N2liV1ZO?=
 =?utf-8?B?Q1ZSak10L0ZQa0dRZER1M2E3dHphZ1BtazdiaHRyMWVMWTZyYmF5Y0REYk0x?=
 =?utf-8?B?VE0raGF0dTFOZWdwUU95dVhsSm1JUXF2eE5Sdzdac2tBaEUrc1VMQlVmM2Ri?=
 =?utf-8?B?MWphSjdRT2JnR2U2NFpKdnJkSXRhNEFTRWo1MXFnZGs1aHozQjNRWS9iSkxk?=
 =?utf-8?B?V1hDeGRZbmtDZFJKZVBRb2N6ZFlMdVRtSzh0a0k1a1MwN2p4MFVaT1ozWkVr?=
 =?utf-8?B?R011bXdwZzVCK0IyL3JFSzdXK25HU2UvOVl5akoxZWVXNWZiaDg4eGpJb2FV?=
 =?utf-8?B?WmdiQ011Q1BoWEhmR0k4T1NINHkwVU56R2E1YUE2dExNSzlyUHJ5aHF1YUhJ?=
 =?utf-8?B?QnlaSkhZenRYZGRMdk4vT3dJTmtuU25IU2pzdzIrSTROZU15ZDAvdWRlaFh1?=
 =?utf-8?B?VjJPQjlIdGdKM00vZzZaSEszSEpmaVhvQk9qMmwvcHJjTmxzanVpcWRaNGRP?=
 =?utf-8?B?djFQM1VhV1l5aGFlU3Jjb0daQnIyMzlaTDhiZm9VTXhUWGE4YlZoT1NsOXhh?=
 =?utf-8?B?MWxJbnpwa084NUp4QjI3QXYxWHgrTkFRd3R2eFVIaTdQV3lhWEZKWXBWdVV0?=
 =?utf-8?B?eVB6YWV1cTJOWGMvdmpqTk5ZZ1B1Zm9JUjcyNEZCcWlmcFU1NnROdWJJT1lG?=
 =?utf-8?B?SHY5ZGx0a2w4WEVoalVpZTBiZlVzM0ZvQ0R6K3V6MVpwcUNHS1FUc1lKSHNw?=
 =?utf-8?B?OWNRSnhvSWh1cHV5bjl5cHJjL3R4bXRMMFR3WHoyRTYzc2E0bzNDWW9xSXhk?=
 =?utf-8?B?bGo3UWZWczJ6U013N1l4S2orTmRteVNEa0k2N1R6bUR2em1hMFFKdXJtaklh?=
 =?utf-8?B?VUgyNDNXWkp0b1lZZndrWVluZ0I0R0tGa0NqK2dIdW1sS24yTVkybVhJemFO?=
 =?utf-8?B?S092cENBWVVaa29lNVhMQU1DZjRqTXdmRklIZTVKSFhnSnN5VzZvRGVTdEYz?=
 =?utf-8?B?U011ZGhaMkphMXdDeTZ4ZzVpZVlvZ0VJR0FJR2dOVWRpSmRsckdzaGMzOWZN?=
 =?utf-8?B?S1AxOHF0TVNOa3VYQkt4U291N0xTWkZzdnJYeVVyTS9WWXI1TE1BeXowYVBL?=
 =?utf-8?B?WW9OOG90RndyWlNaS1l6Tm5WSE1TSXh6L1NkT2NRTnF5RGZqRWhoZlpnSTN1?=
 =?utf-8?B?bS9UZERDUFpBcHpyQ1kvakVzcE1LSHhHTFVwUlVpTGxqeHZhdlJHd0g0OUc4?=
 =?utf-8?B?N21YVWdsaUlvbTdUd2ljSUlFRUJ2OFlyNW5hK2NsRVRxbUV5c2xydUJpWERz?=
 =?utf-8?B?NkV2VkNmOE5ac2hINWJYWXVnbTF2TW1LaG04ZHdsWC9GSExzZkV0SU00U3Vo?=
 =?utf-8?B?MCtndkg4VXlSYjNCTFRLSk5xeCtmcW5Ud1BhZGtGcWhXbHlta1pkRVY2aFRo?=
 =?utf-8?B?emhGa2dhSWJJTXZqTkJFZHU3TGozSUJxbEp0QlFEbnpxQWpFRzdOTU9ORjRP?=
 =?utf-8?B?Nm1sNVlueTBxRjdudy9xMmloZ3p5MHBweHc3SzI0OUVtSjhndy9iMVR1RWhm?=
 =?utf-8?B?bEZRN04vRk42cEh0KzVjZlIrMmpLK1h5SWR0bXdsY0dsdmdtZ3h4U1lxalVr?=
 =?utf-8?B?dWJ3QW1za2JERTZHOWw2MExMTzRMT2VoSW1yd1FJa3hhZWxOQVFlSml0UXU1?=
 =?utf-8?B?RFJJZVhUbDB6RlJtYlhKWlJXSnlhMVJFN1NVMU05blF6Q2xtWXhObUtkWVlE?=
 =?utf-8?B?R0JPanhGZlhjL1BCOVRlb1c2NnNnb1RnTG5ZQlVkcVJtdWlQNDIvWHRDR0t4?=
 =?utf-8?B?Q3p2TTZyR014Q0Noa1ovM1RobW1zc0ZkRGszeDhOZkJ6QVh5eTE4TFhCbnhh?=
 =?utf-8?B?RTBCaHdPYUl0NmE2L0hxaTBXNDNJTzVqd1h5UEp2eDRZQ0JQeFVXMStzTUU1?=
 =?utf-8?B?N1RJa2xJSFIvK1Q1bW5SNWR4Skt1VWtUM2d2UUc0amN6VWdQS1VDeXN2RVpJ?=
 =?utf-8?B?UHRiWEt3S010b2hpUGFCTGJSWERpSEM5THM5TEkwREd6SkhUVTh3Q2NkRnpM?=
 =?utf-8?B?bHcwcEdZSXhuTjRkM3FpYzExYjl5d3NyS0pBSEVOUnF5UGowR0p6YmlqUnd1?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC798960DF349A4BB09D33110B258839@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee147f49-410b-4e08-3b10-08dd08850020
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 10:29:08.2141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrpfM9BrlHAoTgIQNDBrw3ZT6Ign03hv4RQa3N6bFHUn8ADfvO7zRSjlAlMmA0TBpbJ8NTUwaPm4ljnbToTpVa7IqTfzmM6gxvqMpiXPy4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7370

T24gV2VkLCAyMDI0LTExLTEzIGF0IDE4OjEwICswODAwLCBDaHVhbmhvbmcgR3VvIHdyb3RlOg0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IEhlbGxvIGFsbCENCj4gDQo+IE9uIFdlZCwgTm92IDEzLCAyMDI0IGF0
IDU6MDXigK9QTSBNaXF1ZWwgUmF5bmFsIDwNCj4gbWlxdWVsLnJheW5hbEBib290bGluLmNvbT4g
d3JvdGU6DQo+ID4gDQo+ID4gT24gMTIvMTEvMjAyNCBhdCAxMToyNToyNSBHTVQsIFNreUxha2Ug
SHVhbmcgKOm7g+WVn+a+pCkgPA0KPiA+IFNreUxha2UuSHVhbmdAbWVkaWF0ZWsuY29tPiB3cm90
ZToNCj4gPiANCj4gPiA+IE9uIFR1ZSwgMjAyNC0xMS0xMiBhdCAxMTo0OCArMDEwMCwgTWlxdWVs
IFJheW5hbCB3cm90ZToNCj4gPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gPiA+ID4gdW50aWwNCj4gPiA+ID4geW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gDQo+ID4g
PiA+IA0KPiA+ID4gPiBIaSBTa3ksDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiAxMi8xMS8yMDI0IGF0
IDEwOjA4OjMxIEdNVCwgU2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKSA8DQo+ID4gPiA+IFNreUxh
a2UuSHVhbmdAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+ID4gSGkgTWlx
dWVsL01hcnRpbiwNCj4gPiA+ID4gPiBBYm91dCB0aGlzIGRyaXZlciwgaW5jbHVkaW5nIEYzNVNR
QTAwMUcvRjM1U1FBMDAyRyBwYXJ0cywgSSdtDQo+ID4gPiA+ID4gY29uY2VybmVkDQo+ID4gPiA+
ID4gdGhhdCB0aGUgZHJpdmVyIHdpbGwgYWx3YXlzIHVzZSAzMkggZm9yIHVwZGF0ZV9jYWNoZQ0K
PiA+ID4gPiA+IG9wZXJhdGlvbnMsDQo+ID4gPiA+ID4gd2hpY2gNCj4gPiA+ID4gPiBtZWFucyBp
dCdzIG5vdCBjb21waXRhYmxlIHdpdGggdGhvc2UgU1BJIGNvbnRyb2xsZXIgd2hvIGNhbid0DQo+
ID4gPiA+ID4gdHJhbnNtaXQNCj4gPiA+ID4gPiAyMDQ4IGJ5dGVzIChtb3N0IHNtYWxsLWRlbnNp
dHkgU1BJLU5BTkQncyBwYWdlIHNpemUgbm93YWRheXMpDQo+ID4gPiA+ID4gYXQNCj4gPiA+ID4g
PiBvbmUNCj4gPiA+ID4gPiB0aW1lLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZSBmb2xsb3dp
bmcgY29udHJvbGxlcidzIGRyaXZlciBzZWVtcyB0aGF0IHRoZXkgY2FuJ3QNCj4gPiA+ID4gPiB0
cmFuc21pdA0KPiA+ID4gPiA+IDIwNDgNCj4gPiA+ID4gPiBieXRlcyBpbiBvbmUgdHJhbnNtaXNz
aW9uOg0KPiA+ID4gPiA+IC0gc3BpLWFtZC5jOiA2NCBieXRlcyAoQU1EX1NQSV9NQVhfREFUQSkN
Cj4gPiA+ID4gPiAtIHNwaS1hbWxvZ2ljLXNwaWZjLWExLmM6IDUxMiBieXRlcyAoU1BJRkNfQTFf
QlVGRkVSX1NJWkUpDQo+ID4gPiA+ID4gLSBzcGktZnNsLXFzcGkuYzogMUtCDQo+ID4gPiA+ID4g
LSBzcGktaGlzaS1zZmMtdjN4eC5jOiA2NCo2IGJ5dGVzDQo+ID4gPiA+ID4gLSBzcGktaW50ZWwu
YzogNjQgYnl0ZXMgKElOVEVMX1NQSV9GSUZPX1NaKQ0KPiA+ID4gPiA+IC0gc3BpLW1pY3JvY2hp
cC1jb3JlLXFzcGkuYzogMjU2IGJ5dGVzYyAoTUFYX0RBVEFfQ01EX0xFTikNCj4gPiA+ID4gPiAt
IHNwaS1ueHAtZnNwaS5jOiBUWDoxS0IsIFJYOiA1MTJCIGluIEZJRk8gbW9kZQ0KPiA+ID4gPiA+
IC0gc3BpLXdwY20tZml1LmM6IDRCDQo+ID4gPiA+IA0KPiA+ID4gPiBJIGJlbGlldmUgbW9zdCBv
ZiB0aGVzZSBkcml2ZXJzIGFyZSBzdGlsbCBhYmxlIHRvIHNlbmQgb25lIHBhZ2UNCj4gPiA+ID4g
b2YNCj4gPiA+ID4gZGF0YQ0KPiA+ID4gPiB3aXRob3V0IHRvZ2dsaW5nIHRoZSBDUyAod2hpY2gg
aXMgd2hhdCBhY3R1YWxseSBtYXR0ZXJzLCBJDQo+ID4gPiA+IGJlbGlldmUpLg0KPiA+ID4gPiBJ
Zg0KPiA+ID4gPiB0aGV5IHdlcmUgYnJva2VuLCB0aGV5IHdvdWxkIGJlIGJyb2tlbiB3aXRoIGFs
bCBzcGkgbWVtb3J5DQo+ID4gPiA+IGRldmljZXMsDQo+ID4gPiA+IG5vdA0KPiA+ID4gPiBvbmx5
IEZvcmVzZWUncy4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEhpIE1pcXVlbCwNCj4gPiA+IEkg
dGhpbmsgaXQncyBub3QgYWJvdXQgdG9nZ2xpbmcgdGhlIENTPw0KPiA+ID4gDQo+ID4gPiBJZiBh
IFNQSSBjb250cm9sbGVyIHRyaWVzIHRvIGV4ZWN1dGUgd3JpdGUgcGFnZSBhbmQgaXQncyBjYXBh
YmxlDQo+ID4gPiB0bw0KPiA+ID4gc2VuZCBvbmx5IDFLQiBpbiBvbmUgdHJhbnNtaXNzaW9uLCBp
dCBzaG91bGQgdHJhbnNtaXQgZGF0YSBpbiB0d28NCj4gPiA+IHN0ZXBzOiAxc3QgMzRIIChyYW5k
b20gcHJvZ3JhbSBsb2FkIHg0KSBhbmQgMm5kIDM0SC4gSG93ZXZlciwNCj4gPiA+IHdoZW4NCj4g
PiA+IEYzNVNRQTAwMkcgZXhlY3V0ZXMgMm5kIDM0SCBjb21tYW5kLCBpdCBuZWVkcyB0byBleGVj
dXRlIDMySA0KPiA+ID4gZmlyc3QsIGFuZA0KPiANCj4gSSBkb24ndCB0aGluayB0aGF0J3Mgd2hh
dCB0aGUgZGF0YXNoZWV0IG1lYW5zLiBJIHRoaW5rIGl0IG5lZWRzDQo+IDAyaC8zMmggYXMgdGhl
IGZpcnN0DQo+IGNvbW1hbmQgdG8gd3JpdGUgcGFnZSBjYWNoZSwgYW5kIHRoZSBzdWJzZXF1ZW50
IHBhZ2UgY2FjaGUgd3JpdGluZw0KPiBjYW4NCj4gYmUgZG9uZSB1c2luZyA4NGgvMzRoIGJlZm9y
ZSB0aGUgZmluYWwgcGFnZSBwcm9ncmFtIGhhcHBlbnMuDQo+IE90aGVyd2lzZSB0aGUNCj4gODRo
LzM0aCBjb21tYW5kIGlzIGp1c3QgY29tcGxldGVseSBicm9rZW4gYW5kIHVzZWxlc3MuDQo+IElm
IGl0IGFjdHVhbGx5IGlzIGJyb2tlbiwgd2UgZG8gbmVlZCBhZGRpdGlvbmFsIGd1YXJkcyBpbg0K
PiBzcGluYW5kX3dyaXRlX2NhY2hlX29wDQo+IHRvIGFib3J0IHdoZW4gc3BpX21lbV9kaXJtYXBf
d3JpdGUgZG9lc24ndCByZXR1cm4gZXhhY3RseSBuYnl0ZXMgYXMNCj4gcmVxdWVzdGVkLg0KPiAN
CkNvbmZpcm0gd2l0aCBGb3Jlc2VlIGFuZCB5ZXMgeW91J3JlIHJpZ2h0IFhEDQoNCj4gPiA+IGl0
IHdpbGwgY2xlYXIgZGF0YSB0cmFuc21pdHRlZCBieSAxc3QgMzRIIGluIE5BTkQgZmxhc2gncyBj
YWNoZS4NCj4gPiA+IFRoaXMNCj4gPiA+IHdpbGwgY2F1c2UgZGF0YSBjb3JydXB0aW9uLiBPdGhl
ciBTUEktTkFORHMgZG9lc24ndCBuZWVkIHRvDQo+ID4gPiBleGVjdXRlIDMySA0KPiA+ID4gYmVm
b3JlIDM0SC4NCj4gPiANCj4gPiBJcyBpdCByZWFsbHkgd2hhdCBoYXBwZW5zPyBJJ2QgaW5zdGVh
ZCBleHBlY3QgdGhlIHNwaSBjb250cm9sbGVyIHRvDQo+ID4gc2VuZDoNCj4gPiAtIDM0aA0KPiA+
IC0gMWsgZGF0YQ0KPiA+IC0gMWsgZGF0YQ0KPiA+IC4uLg0KPiA+IA0KPiA+IFdoeSBzaG91bGQg
d2UgcmVwZWF0IHRoZSBjb21tYW5kIHdoaWxlIHdlIGFyZSBpbiB0aGUgSS9PIHBoYXNlPw0KPiAN
Cj4gU2V2ZXJhbCBTUEktTUVNIGNvbnRyb2xsZXIgZG9uJ3QgYWxsb3cgc29mdHdhcmUgY29udHJv
bGxlZCBDUywgb3IgZm9yDQo+IHNvbWUNCj4gb3RoZXIgcmVhc29ucyBhcmUgdW5hYmxlIHRvIGV4
ZWN1dGUgYSBsb25nZXIgc3BpLW1lbSBvcC4NCj4gc3BpX21lbV9kaXJtYXBfd3JpdGUgcmV0dXJu
cyB0aGUgYWN0dWFsIHJlcXVlc3Qgc2l6ZSBpdCdzIGFibGUgdG8NCj4gbWFrZSwNCj4gYW5kIHNw
aW5hbmRfd3JpdGVfdG9fY2FjaGVfb3AgdXNlIGEgd2hpbGUgbG9vcCB0byBzcGxpdCBvbmUNCj4g
dXBkYXRlX2NhY2hlDQo+IHJlcXVlc3QgaW50byBtdWx0aXBsZSBvbmVzLg0KPiANCj4gVGhpcyBv
bmx5IHdvcmtzIHVzaW5nIHRoZSBSYW5kb20gUHJvZ3JhbSBMb2FkIGluc3RydWN0aW9uICg4NGgv
MzRoKQ0KPiB3aGljaCBwcmVzZXJ2ZXMgdGhlIHByZXZpb3VzIHdyaXR0ZW4gZGF0YSBpbiB0aGUg
Zmxhc2ggZGF0YSBjYWNoZS4NCj4gQWxsIGN1cnJlbnQgc3VwcG9ydGVkIGZsYXNoZXMgYXJlIGV4
Y2x1c2l2ZWx5IHVzaW5nIDg0aC8zNGggYXMgdGhlDQo+IGNvbW1hbmQNCj4gdG8gd3JpdGUgdGhl
IHBhZ2UgY2FjaGUuDQo+IA0KPiBMb2FkIFByb2dyYW0gRGF0YSgwMmgvMzJoKSB3aWxsIGNsZWFy
IHRoZSBlbnRpcmUgcGFnZSBjYWNoZS4gQXMgYQ0KPiByZXN1bHQsIHdoZW4gYSByZXF1ZXN0IGlz
IHNwbGl0IGFzIGRlc2NyaWJlZCBhYm92ZSwgdGhlIHByZXZpb3VzDQo+IHdyaXR0ZW4NCj4gZGF0
YSB3aWxsIGJlIGNsZWFyZWQsIGJyZWFraW5nIHRoZSBwYWdlIGNhY2hlIHdyaXRpbmcgcHJvY2Vk
dXJlLg0KPiANCj4gV2UgY2FuIGNoYW5nZSB3cml0ZV90b19jYWNoZV9vcCB0byB1c2UgTG9hZCBQ
cm9ncmFtIERhdGEgb24gdGhlDQo+IGZpcnN0IHJlcXVlc3QuIElmIHRoYXQgZG9lc24ndCBmaW5p
c2ggd3JpdGluZywgdXNlIFJhbmRvbSBQcm9ncmFtDQo+IExvYWQNCj4gb24gc3Vic2VxdWVudCBk
YXRhIGxvYWRpbmcuDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IENodWFuaG9uZyBHdW8NCg0KSSBvYnNl
cnZlIHRoYXQgZXhlY19vcCgpIGluIGRyaXZlcnMvc3BpL3NwaS1tdDY1eHguYyBvbiBvdXIgcGxh
dGZvcm0NCndpbGwgaXNzdWUgdGhlIGZvbGxvd2luZyBjb21tYW5kcyBvbmNlIEkgbGltaXQgaXRz
IGNhcGFiaWxpdHkgaW4NCjEwMjRCeXRlczogKHRyeSB0byB3cml0ZSAxIHBhZ2UpDQotIDM0SA0K
LSBhZGRyDQotIDEwMjBLQiAoMTAyNEtCIC0gMSBieXRlIG9wY29kZSAtIDMgYnl0ZXMgYWRkcikN
Ci0gMzRIDQotIGFkZHINCi0gMTAyMEtCICgxMDI0S0IgLSAxIGJ5dGUgb3Bjb2RlIC0gMyBieXRl
cyBhZGRyKQ0KLSAzNEgNCi0gYWRkcg0KLSA3MktCDQoNCklzIGl0IHBvc3NpYmxlIHRvIHNlbmQg
MzRILCAxSywgMUsgd2l0aCBjdXJyZW50IG5ieXRlcyBsb29wIGluDQpzcGluYW5kX3dyaXRlX3Rv
X2NhY2hlX29wKCk/IFdpdGggd2hpY2ggU1BJIGNvbnRyb2xsZXI/DQoNCkkgc3VibWl0IGEgcGF0
Y2ggYWNjb3JkaW5nIHRvIHRoaXMgZGlzY3Vzc2lvbiwgYW55d2F5Lg0KDQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1tdGQvMjAyNDExMTkwOTM5NDkuMzAxNC0xLVNreUxha2UuSHVhbmdA
bWVkaWF0ZWsuY29tLw0KDQpCUnMsDQpTa3kNCg==

