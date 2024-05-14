Return-Path: <linux-kernel+bounces-178307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D068C4BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0DB2869F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FC412E78;
	Tue, 14 May 2024 04:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="alAldEhP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Audo8z+y"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF111725;
	Tue, 14 May 2024 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715661801; cv=fail; b=qjlNxe3GdOH1u8K0C13iHTpVIxP3tOuCAKUiujd7rIi9r/35E6+RAeSFzd0LhjoqxlNHgClo7XoLiopxuUrzd/WOgmDGC/oNtjQjNoo4E9CsSDjovoDX5Ft9i0H41o/Vl3kWfUmg/APmpf+MILd5KJCWmBhBY9hpLj03AQp+iw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715661801; c=relaxed/simple;
	bh=KutM97jFlBFwOEYnFz4NTppCZOuUp2X+ifxzIWO5wQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cNq3AW8doC1mxNXYI7shOuvV6yfVN3F35ltcI8bdzSTuRpvKXyeB5p56dWfjZUBJO/azC09agGSaOMujfiT2oqPu5NJ/OfiOMYtn7BaeCMR5suSAT/2U5C4koM6mHOT2H1mXkLQaQyw8Lv51WBTya82tL+pCjxQ5bqE3Ma9jQm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=alAldEhP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Audo8z+y; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7553be4c11ac11ef8065b7b53f7091ad-20240514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KutM97jFlBFwOEYnFz4NTppCZOuUp2X+ifxzIWO5wQM=;
	b=alAldEhP8ujzNkolnHJe1ZK+gpewMyCEZV3piMWhjFg6oHl/A4zoY2PzxqYF1Pv0UjodrmyRl+kCnFy+u/lmOhx/er2qv/X0PyIOUGFxpMZ0a9I5MuZgs2HoC2JbgQ4N9DPSWBLPbMVOS6mcI/Tb0OiRtdau9r+r9vZQtClgvjM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:428d7e00-4213-41a6-95db-65a67a30b71b,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:3bc10efc-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7553be4c11ac11ef8065b7b53f7091ad-20240514
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1780174390; Tue, 14 May 2024 12:43:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 14 May 2024 12:43:05 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 14 May 2024 12:43:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5a+zPpW//HJDyRCaAxdbo4FXvGvWKv2dDBlruQVC6U4hlNFL0goLaFFSBFP1CunPjxacHDkw5PqzYeT3dX+GHG6wSHEAAqrtzof43ktD21hdblxiF3lbgSj+FqmEVcgOrKTcNIf9q7eY2hIQ7UTDewokm4n1KM8qKt+8qobM9Pk6L9vCEoyRV4ujj2aGniIkkP7Y9tYpaOnu9vZzCeDW8ebiHk8vUIlq1hpfgFBj9D17daK0GMhCgbC5Yj+VX6we4I4MshF2qc0xXHNPGSog4kadIN+6yiVeDzgR5WeBV9Z47fl+yCMFGkF5/9ZNWYasF5SGH6rYrOBhucjuamALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KutM97jFlBFwOEYnFz4NTppCZOuUp2X+ifxzIWO5wQM=;
 b=apaBf1YMPQf32a+NhJXz2i4/DpJr4a9EyU8my4jfa3MPDB9r3RKy8wkKiInl+LadVwuLcFVqq7c15cPj3QqEmas1dq5rkhHEVm0XA1TKgpgiIhC4vDQrjpE+OS70HmykHxCvZTh76aQrz4OvdEJqVafdsmp1Ff+/bGb1CQO8YaNg9KUn4iAPhoHLP4zlxDyj0W6K7yCPR5PNT/mEzhvzJr5RpML0yRaHjBCzcY9h9GBpVHrEBH41A1ydMcofpyfotMhkfA+IVvwASV9WiKvIGgZHmRm9NhV8Nu9fm8Tz4RE9b89obSz3tg5BphJkvT3GAvP17M2YZ97/+Hky33I5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KutM97jFlBFwOEYnFz4NTppCZOuUp2X+ifxzIWO5wQM=;
 b=Audo8z+yHVKaJzPhdKwQQMTcUkVZQerpmxO0lQnmnMsMQC8ZhUEIjTMn4/4Q0dgVPSp6oN3JTrHKgRZX4Fjs2sInKGCaXyENYZbpZC+/A8RRw/6kmKtqVSpG1P+Xdi0PmRdtHAtJQOttpnKzUQ7nZrHWoopAUtsVRHN+Mi7wNII=
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com (2603:1096:400:70::13)
 by SEZPR03MB6594.apcprd03.prod.outlook.com (2603:1096:101:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Tue, 14 May
 2024 04:43:03 +0000
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3]) by TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3%5]) with mapi id 15.20.7587.021; Tue, 14 May 2024
 04:43:03 +0000
From: =?utf-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?= <Liankun.Yang@mediatek.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	=?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Add dp PHY dt-bindings
Thread-Topic: [PATCH v2 2/2] Add dp PHY dt-bindings
Thread-Index: AQHaosoq14tjS/hF8kyh32TtEXWXzLGUuniAgACAFwCAAABygIAAAPeAgADw2wA=
Date: Tue, 14 May 2024 04:43:03 +0000
Message-ID: <1eb69265ae15323f3304f1c4b4fb0be5b13f1d42.camel@mediatek.com>
References: <20240510110523.12524-1-liankun.yang@mediatek.com>
	 <20240510110523.12524-3-liankun.yang@mediatek.com>
	 <e02c2f42-b5e4-4200-8131-3881b7034625@kernel.org>
	 <3f387c9e8ac34ca25ec7b6bfb02536cd4ebbc508.camel@mediatek.com>
	 <f4f85f0b-49eb-4fba-ac76-2df845571b12@kernel.org>
	 <4a147f2d-71c8-4acf-aab4-9d761b81bc73@kernel.org>
In-Reply-To: <4a147f2d-71c8-4acf-aab4-9d761b81bc73@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5760:EE_|SEZPR03MB6594:EE_
x-ms-office365-filtering-correlation-id: f5e7c809-dd57-44cf-2035-08dc73d05717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NU4ydGNTbE5PNU0rR0JYelpYMHZhYjBWT29JVmFzeEYvaUxkNFNFdUVNZmVp?=
 =?utf-8?B?ZmpFeWxJOXhVbmZRdGJiYnBkSUwxWm9DQTZyaDl3RW5KNkNOTmU4OTg4dnhm?=
 =?utf-8?B?MFVrTk1SRzIvZ1B0eGFjMXJFcFB0ZTFvbWgyUUQ1WGNHdGh5d09haHhSUFl1?=
 =?utf-8?B?eVJLMGJwVFNFcWhCbHE5RFRYL0xIN2pzaFpxUXdEUDB6c2oyOHV1NlNGMFhZ?=
 =?utf-8?B?R0o1M2VMZ3dXdi91ZmhROFZEU3lGcGE1c0VUcDZ4N3ordXJBRkFRTzJvVXIw?=
 =?utf-8?B?Q2lVaWZkbExrNlNHM3JjNFJJZjdvaXltY3BVYUFVRWNRbkRiSEYvRUtPTlVy?=
 =?utf-8?B?ZUJjR3M2Nkd2MnlBaGp6QmtTcVpTd1drdXc1aGF0KzVUVHBadVF5aUFZMEs1?=
 =?utf-8?B?bGhJUTlEdk1RRmlNMWRkZ2pvMjkvOWVCRjkvYzYxVmcyN0pzV2NEMVp4Umpo?=
 =?utf-8?B?NlpLWnd5bjRxTU9HZy92dGFpVTAxNnMxNy9BSkNHNXJRTSs1UjR1TXFxQkQ0?=
 =?utf-8?B?SjFHby9tcHhIQkJXOUtFczVTSzQ0REwrdTluRmZFeUFLdXQ0ekxMWTFFVjZh?=
 =?utf-8?B?ZXplUXMydEgzU1BMek0wUzR0Qm41WFZRWnBSdDR2UkZJTkZ1YUUwUTdPSDVJ?=
 =?utf-8?B?WG1lRnB0MWhPMnowMDlPNC9CVE1lemUyYlp4a2xEVnlxVkJERklORFgwdFRS?=
 =?utf-8?B?d0ZTdkRSc2ZUTG9hZWNZVFlLRWkydDRsV2tBOGJxVHZJOWRQNmgwQUZ5bmpJ?=
 =?utf-8?B?SjNnQjlhT0hJcFNhOVBBN2lHZ0VGYkpGZ0gyZDhBYmxuMEtOenV1azA4Mm5G?=
 =?utf-8?B?VnBJOU9JbUxaOFgwUVR0TjErTXJlbXg5QzA4dEdSazRjTFZWRG1MdWVDaENS?=
 =?utf-8?B?NERRalJBYmY1bUVYYk4zRyt0WDk4bnJndUtweFVKUmZvendWaUtSc1VaTXBz?=
 =?utf-8?B?TXRFSmxRTTJLcFRVQ0ZuNXZKLzRzd0gvWTgyT1Z4dERXVUV6MWdCWjV1Z290?=
 =?utf-8?B?djFRbkxnRVhBZW1hL3dCZFhISlA3LzVXbWVFdzBlQklQaDlLbVl3UlZhOVRl?=
 =?utf-8?B?UGQ0djBkQ1VNcGx5VlZHV2tCd1JXenlhK0ZJYkJJRlhhL3RKRmhUTzFTYUxJ?=
 =?utf-8?B?T1VZS2tXQndYZ2dGckV2NjBsUVhkYzV1UWJQWENKeUlVZkpLekxBUGdRc3JG?=
 =?utf-8?B?OGE5WVhLM0lDS3l5QVM2ZGE1UDRkWDNISlJTSzQveEcrRndvWFVpY0tIKzlX?=
 =?utf-8?B?NHBncnlkM2JEdldheG1XMW40Z0NybkxSNVlyY2J2MTBsaTU3WVJTc2ZtRndz?=
 =?utf-8?B?SnJwK0dvd3NGVEtUM25BdU4zTmQvN3ZZWVBhSTN4YmowcjEzbXhCbUxtT3hv?=
 =?utf-8?B?dDk0WGVoNE53YkdYY3JsRmpxWmJuVEhCbjQ3VWVaWm1ZWjN3RHBsSlZJVnVV?=
 =?utf-8?B?MzVDRVVkc3hzMU41NUFjYkVWSTBCd0xyck1IdTM0aFlrbjYvdnZ5M3FPWk5a?=
 =?utf-8?B?Mkpnd0NDdlRwSjlMaEZpaEZYR2JxbzBnSHBEeEExTEVGKy9XellEOGhCOGUr?=
 =?utf-8?B?MHJoN25zSUk4Q2dzRGg2blhMVjB6RFpOTU8xVDlGTlE0SURkMjNjQ2hMSHlk?=
 =?utf-8?B?UEwwbzMzTTdKZDlhNjU1YllHQ2xUbS9ReU1LTXJIamVobkt5M3h1SUlCdjhm?=
 =?utf-8?B?NXN4UEFXcXBmbmpRYTc4dXg1UEdwUGRhRnFINE1uWEsrN3NxT3NoUnNJTEY0?=
 =?utf-8?Q?icwOOTRyRyinHbUn/HH3Z234+ivxSNBlr3j4l/U?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5760.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bERRbXJvVzBYN1g2Y012TDhueE15SVljclhaSkkxUVFpR2d4bk9vSzRqejNU?=
 =?utf-8?B?djBidnh1TUE2SkpCRkdsS3g1aG9iTUVjb0lqUnE3UENtWGNNQjlRVWxLaGQ1?=
 =?utf-8?B?U1RuSW96SXlxRXBNdS9hZWV0M2NuN05xemRTeW9NNGRWTGczMXpaNU5sNjRm?=
 =?utf-8?B?MjBIVHY2MzZsd3lDSk83azRyMEVGSzJCQzZnSktaMkE1bE9CTTZnVEd1QnZY?=
 =?utf-8?B?aTNlWHJldWxKWkhScEc5eXpLeDEvakpqYlA1MGlzSmJEVnVDTnZtY1J2TkpD?=
 =?utf-8?B?ckRpRFZzVmNYU0FhUjdWb1l0WUdCSnlBRG5EZUcvSTM5UjNncmUrT090UmNB?=
 =?utf-8?B?SThyRGRKZi81M2pHckJ4Z2krZnEyNGF0OVJ1eVY5WGFZcE5pZkVnM00vMUZq?=
 =?utf-8?B?aDBsL0p5eWswNjdoRVdTdlE1NHR4aVFQTmxXYkVyL0VtZ0pwZ2lidnhnVkpi?=
 =?utf-8?B?dHp6NE9hVzdkQnR4aURUVXR2Sit0ZGxPcXhBZHFCbWhQSjhrR29FZlVtMHdh?=
 =?utf-8?B?ck5hUFJqMVZ4blV2UFdDZHplQVF1cjNEMzFiU1hMTGpnd3Q5Q1pEd2tYc09V?=
 =?utf-8?B?UWo0eGNwcXVraDhNSUZaMk5PR1c5OGg1OVQ3M3hWd0V3Znk3S1NoeTZGYVly?=
 =?utf-8?B?MFVUek1JbW1ZbXNjckYxSVJ0cExNNitMRzFqbk1GbFBMRHVCTGc2TlVQb0xF?=
 =?utf-8?B?V0VQSG83TUFoTVM5Wk9Gd3YrdU51MUJmb2NTV1VEaEpkWWgxVmlOcmJ6VTFR?=
 =?utf-8?B?UFRCV1ZBUHRpTDRSL3g3UUFSa01vMW9ob0VCeC8wVDV2OTM2ZCtJcjFkRDgw?=
 =?utf-8?B?aDlPeFQ3KzBtYUlQY3NNY3BaYjE3K2RjVU5YRlhVdGtPaERWNnJYc2l4ZnFx?=
 =?utf-8?B?bDNEUzUxY21QS2FEWDFBZHZzdHZWMHJ1RVZXSmxzRkd6Nzd4dkdNNnFyT3ZH?=
 =?utf-8?B?aTNJMG5CNWxaU3RRZWppTTkrdGN0d2ZZS1dXYnNSYjNqVExhUVo5ZzlJSFpQ?=
 =?utf-8?B?TEdBWi9MdlhxajM0OWJzL0wxeHlwbk81Z3U4WlhIUjg1MHlKazd3TmJVNE8x?=
 =?utf-8?B?YW1HMEJuRjhMUExEQU4yS0F1MkhDalVqN1d0RVRLNUwveEl3cXNnbjZGMnMz?=
 =?utf-8?B?a3BwYmYveGFJLys1bXoxaFB6Z1l2YUlMVXRlUUpzemdldWhCQ2VRTlRBMHpJ?=
 =?utf-8?B?bzVYeE9rQmphVHdldGk4a3RQYXB0VlE0M2xMR3Z4SkdaWlZnb01vQUZBYlZS?=
 =?utf-8?B?RXB5TzRjMUFkSFFtbEdvRjNabjI5ZUwyVThUaVBZYlVMNWF6UW5DVllZaC9N?=
 =?utf-8?B?YlFjVk9nMGI4M3paRXBMbmRETkp2NlFxMmpyWERLRlkxR25wNVNpUWdNYmpp?=
 =?utf-8?B?T2pkRndoWmRCeFVmT1VoamhxdnpxTGEvTjZLamFuaWwyQURnVFRsNW9DanhR?=
 =?utf-8?B?QXhqOVhsR2dIa1ppN0FMaEk5a2V0M3pSNVkreDNCRC92UVpucmJaQ1FWRE9H?=
 =?utf-8?B?d2tPWXlxOEI4eGFYY29haTlOUHpic3ZtczluZ1A1R1lEa0pkeTI1RERXOUZ4?=
 =?utf-8?B?Z21mOUYrekZZUTZrQXR4KytVSmJBVTUvNUF6OC85YklHbFVNWWl0VGZiM1BR?=
 =?utf-8?B?M2lZdDVNQVZjRXdCT3V3bGM0eHJRQ1Qxb3ZveVZnaC9hT1NscGVhTHFueDlL?=
 =?utf-8?B?UkRBOVRVSEs4T3dmNFVxUzlCOWJDL2VKLzFKM2xIbHBxcXQ3UjhoS01kL0wy?=
 =?utf-8?B?NjVlc0tJbSthVkNibzU1Zi90bUJDMndqWmtpNnJvb0JMMC9Wak1LZ0JHNkdt?=
 =?utf-8?B?ZTBiS2taZXArdlUxQlplY1BHZ2dHZkJkTnFhem1ZbkJoTkw1cS9LcGd2UW55?=
 =?utf-8?B?b2RnU2s1ZDViZTVyeWU1U3FoWWRhWVRNZ21kMUExRFFmTHJFYVlWMGc5eDV4?=
 =?utf-8?B?YzMzd2lXZC9XV25TSnZiVldkSWRRdExRZzlZVTdVM0lLYXBPdGloTjZYZVd4?=
 =?utf-8?B?VEFzSDAxakNCN3pJQnlIcHNHNUtSRXJNcmhuZDZXSitrZndRckdIOVdLdGZj?=
 =?utf-8?B?MjFRbjBPdnNlMDNYYkY1RGV0UHRTd0JPTWthVHBoaUZWMWpOaW81RGd1RTM1?=
 =?utf-8?B?SnQ1clJGYUdJSklXbUVHTDZ4SU1iWDRvRlN5Z1EvS216TWt0L2REKzM5eXdK?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A653F7B1398324E8004D5E03635661F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5760.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e7c809-dd57-44cf-2035-08dc73d05717
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 04:43:03.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vvrA2gWe42SBfNR74Qkvaedlc8DFRZQOCadBoW7K2cHuRcVmMCoHNZqgHIAjcN/wgLwSXJc/wo4suNXwqFO1AUPpLQY/n1fzp7IF3SOyl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6594

T24gTW9uLCAyMDI0LTA1LTEzIGF0IDE2OjIwICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDEzLzA1LzIwMjQgMTY6MTcsIEtyenlzenRvZiBLb3ps
b3dza2kgd3JvdGU6DQo+ID4+PiBkcC55YW1sDQo+ID4+Pj4gQEAgLTAsMCArMSw0NSBAQA0KPiA+
Pj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNs
YXVzZSkNCj4gPj4+PiArJVlBTUwgMS4yDQo+ID4+Pj4gKy0tLQ0KPiA+Pj4+ICskaWQ6IA0KPiA+
Pj4gDQo+IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVk
aWF0ZWsscGh5LWRwLnlhbWwjDQo+ID4+Pj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+Pj4+ICsNCj4gPj4+PiArdGl0bGU6IE1lZGlh
VGVrIERpc3BsYXkgUG9ydCBDb250cm9sbGVyDQo+ID4+Pj4gKw0KPiA+Pj4+ICttYWludGFpbmVy
czoNCj4gPj4+PiArICAtIE1hYyBzaGVuIDxtYWMuc2hlbkBtZWRpYXRlay5jb20+DQo+ID4+Pj4g
KyAgLSBMaWFua3VuIHlhbmcgPExpYW5rdW4ueWFuZ0BtZWRpYXRlay5jb20+DQo+ID4+Pj4gKw0K
PiA+Pj4+ICtkZXNjcmlwdGlvbjogfA0KPiA+Pj4+ICsgIFNwZWNpYWwgc2V0dGluZ3MgbmVlZCB0
byBiZSBjb25maWd1cmVkIGJ5IE1lZGlhVGVrIERQIGJhc2VkDQo+IG9uDQo+ID4+PiB0aGUgYWN0
dWFsDQo+ID4+Pj4gKyAgaGFyZHdhcmUgc2l0dWF0aW9uLiBGb3IgZXhhbXBsZSwgd2hlbiB1c2lu
ZyBhIGNlcnRhaW4gYnJhbmQncw0KPiA+Pj4gZG9ja2luZw0KPiA+Pj4+ICsgIHN0YXRpb24gZm9y
IGRpc3BsYXkgcHJvamVjdGlvbiwgZ2FyYmFnZSBtYXkgYXBwZWFyLiBBZGp1c3RpbmcNCj4gPj4+
IHRoZSBzcGVjaWZpYw0KPiA+Pj4+ICsgIHNzYyB2YWx1ZSBjYW4gcmVzb2x2ZSB0aGlzIGlzc3Vl
Lg0KPiA+Pj4+ICsNCj4gPj4+PiArcHJvcGVydGllczoNCj4gPj4+PiArICBzdGF0dXM6IGRpc2Fi
bGVkDQo+ID4+Pg0KPiA+Pj4gSSB0aGluayB5b3UgbmljZWx5IHNob2NrZWQgUm9iIGFscmVhZHku
DQo+ID4+Pg0KPiA+Pj4gUGxlYXNlIHJlYWNoIGludGVybmFsbHkgdG8gTWVkaWF0ZWsgb3IgY29s
bGFib3JhdGluZyBjb21wYW5pZXMgdG8NCj4gZ2V0DQo+ID4+PiBiYXNpYyB0cmFpbmluZyBhbmQg
aW5zdHJ1Y3Rpb25zIGhvdyB0byB3cml0ZSBwYXRjaGVzIGFuZA0KPiBiaW5kaW5ncy4NCj4gPj4+
DQo+ID4+PiBPdGhlcndpc2UgaXQgaXMgd2FzdGUgb2Ygb3VyIHRpbWUuIE1lZGlhdGVrIGlzIG5v
dCBhIHNtYWxsDQo+IGNvbXBhbnkgc28NCj4gPj4+IHRoZXJlIGlzIG5vIGV4Y3VzZSBpbiBzZW5k
aW5nIHN1Y2ggcG9vciBxdWFsaXR5IHBhdGNoZXMsIHdoaWNoDQo+IHdvdWxkDQo+ID4+PiBiZQ0K
PiA+Pj4gRUFTSUxZIHNwb3R0ZWQgYnkgdGhlIE1PU1QgQkFTSUMgcmV2aWV3Lg0KPiA+Pj4NCj4g
Pj4+IEJlc3QgcmVnYXJkcywNCj4gPj4+IEtyenlzenRvZg0KPiA+Pj4NCj4gPj4NCj4gPj4gSSB1
c2VkIHNjcmlwdHMvY2hlY2twYXRjaC5wbCBhbmQgZml4IHJlcG9ydGVkIGVycm9yIGFuZCB3YXJu
aW5ncy4NCj4gPj4gSSBhbSByZXN1bWJtaXR0aW5nIGJpbmRpbmdzIGJ5IHRoZSBNT1NUIEJBU0lD
IHJldmlldy4NCj4gPiANCj4gPiBObywgcGxlYXNlIHdhaXQuIFdobyBkaWQgdGhlIGJhc2ljIHJl
dmlldyBvZiB5b3VyIHBhdGNoPyBXaG8gZnJvbQ0KPiA+IE1lZGlhdGVrPyBVcHN0cmVhbSBpcyBu
b3QgYSB3b3JraG9yc2UgdG8gdXNlIGluc3RlYWQgb2YgeW91cg0KPiByZXNvdXJjZXMNCj4gPiBm
b3IgdGhlIGFic29sdXRlIGJhc2ljIHN0dWZmLi4uIFRoaXMgZmVlbHMgc3VjaCBleHBsb2l0aW5n
Lg0KPiA+IA0KPiANCj4gQWZ0ZXIgcmVhZGluZyBBbmdlbG9HaW9hY2NoaW5vJ3MgcmVzcG9uc2Us
IGl0IGxvb2tzIGV2ZW4gd29yc2UuLi4NCj4gVGhpcw0KPiB3YXMgbmV2ZXIgdGVzdGVkLi4uDQo+
IA0KPiBTbyBub3Qgb25seSBleHBsb2l0aW5nIGJ1dCBhbHNvIGZlZWxzIGxpa2Ugd2FzdGluZyBv
dXIgdGltZS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQoNClNvcnJ5
LEkgZ3Vlc3MgSSBkaWRuJ3QgbWFrZSBteXNlbGYgY2xlYXIuDQpJIGFtIHJlc3VtYm1pdHRpbmcg
YmluZGluZ3MgYWZ0ZXIgdGhlIE1PU1QgQkFTSUMgaW50ZXJuYWwgcmV2aWV3Lg0KVGhhbmsgeW91
IGZvciB5b3VyIGNvbW1lbnQuDQoNCkJlc3QgUmVnYXJkcywNCkxpYW5rdW4gWWFuZw0KDQoNCg0K

