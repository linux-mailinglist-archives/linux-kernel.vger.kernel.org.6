Return-Path: <linux-kernel+bounces-177698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F58C4343
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3EE1C216C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82725153BF8;
	Mon, 13 May 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QpJ9Qs5s";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="m+Y9z8aI"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8414F9F7;
	Mon, 13 May 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715610387; cv=fail; b=TQqlGVbPttj0T/diZY995SIfFE/iF91+WLvlPLo1YDReIgI+ReNb8Mhvf/5QbxxRTPtGySR0ZRVS24aFBVi8rSKqoXFczUY5SHgDEJCMScZrtvzvP/TwTst4bSD3gm2GBapKNBMmplzcztZWn/tQ3x6jnX8KSxRjasQpdfoaWIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715610387; c=relaxed/simple;
	bh=zoPNrDnEMUJy92wYjpg2AHGTirvYcUaa9qQzc+RrRow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CdzXafj6eEz1lxBh6hegqn1CKc8+3aCikG66/yTwQB6zwRpuHiw52h+LWIY3kSWlmT7treuabWqah0PKFqHJLwz4Bbfq0WesxyD2sgSTllVpcuDxuTNJgqSrcsfMiJQ8geNfnuzBLG6C1P00hGzz90+lLeyjCUUkaEuOms7mND8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QpJ9Qs5s; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=m+Y9z8aI; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c2b50312113411ef8065b7b53f7091ad-20240513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zoPNrDnEMUJy92wYjpg2AHGTirvYcUaa9qQzc+RrRow=;
	b=QpJ9Qs5sm28JSPYKR9GmLqjFJM8bBoFQ5KAEY8GdT0z9hhCMUCuglYdk+bK6tJv2rQZWoCwokrpkXv8IYTZJouwCDaMPVaNyZdS8kGUCyOBo6YOjVkJaj7FI1OtWGm3Gqe7ulJr+eQ/vfiOHeMFKUsM25/mVUtksDycWBmCF7z0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ebc7158a-dc7b-4604-98be-2cb00544229c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:c86708fc-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: c2b50312113411ef8065b7b53f7091ad-20240513
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 785229889; Mon, 13 May 2024 22:26:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 May 2024 22:26:15 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 May 2024 22:26:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrD3gOIM6JxsAtqwBSyQSKQEnI21UeY3ePnPiLCa6rI1KvJZ1RA95egWFdC7PcMInezlB5gW5UERpb/xia2YCp5LFiNgbb4YGHOYShWYMUDaUtGYu2dFz16J/73+bMOxjPlXqi+do74arJte7EeQ3tJqlCPYj3prcVt3hvW/gyyI88miixGDnuIVZzNJ7O5A+6m1hEmlk5aNXxmAVU70ZC7GBqHyBH67XVkaPS0ZrQTxjIisPTmbi+Ij3Mp7Lvpk6PGJlK0UdBvEtZuTG68DnKypCeOUwsVnu1ZIpZmvIq9oMJElqfomX7sWyQXA7hDghwH4VAw6brOqvwtO08JYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoPNrDnEMUJy92wYjpg2AHGTirvYcUaa9qQzc+RrRow=;
 b=Qzh9wIUjIRQaFjb5drKBwMLtg/8RSeV9qbHfTyp4LNtej9XR0nWmN/Uky6w41x657RwaKyC/Nz6PkArUVb1wrGqS6pyHy1msVKjEoqJ66y/zUfYUAvY1kgHEtMT6zUW04PaHVCw979LRzp1uel8sLCbhLOb7lqzlvmYYI4ITuagN+n17tJhCLvhEc38fBP4jNW05n4d7mmX5ZkOXe/RXnBgqz4WJM7jGeetSKwE9lo79oZV2Nq+JRO9IyarBjKvRfkGqGJ9gdLTyNy9tYPnWWJ2WK41qx9TuawWhF3Cm1Zzg9FZ01GiBytULPolYNoRF5E5YVHUgLYxCYHsY4SH6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoPNrDnEMUJy92wYjpg2AHGTirvYcUaa9qQzc+RrRow=;
 b=m+Y9z8aISDIL/pzAz4bCIMOil4QjIXWL8wDZANVNY7nlXTzJyPV1kREkALY9O1KmoITeohjTDZJusYhUhgRU3SXY6ECYcRGoYl9LOlp3q0UitwJeKfaQCx+zw5zsYo/OJKxoyxieiTsOlZLgBpyvgwlWPFL3PKl1evNxHFNVn1o=
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com (2603:1096:400:70::13)
 by TYZPR03MB7409.apcprd03.prod.outlook.com (2603:1096:400:41e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Mon, 13 May
 2024 14:26:13 +0000
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3]) by TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3%5]) with mapi id 15.20.7587.021; Mon, 13 May 2024
 14:26:13 +0000
From: =?utf-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?= <Liankun.Yang@mediatek.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	=?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	Project_Global_Chrome_Upstream_Group
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
Subject: Re: [PATCH v2 1/2] Add write DP phyd register from parse dts
Thread-Topic: [PATCH v2 1/2] Add write DP phyd register from parse dts
Thread-Index: AQHaosoq7X5Ma7JxMUq62e1u26odj7GVKHAAgAAU/4A=
Date: Mon, 13 May 2024 14:26:13 +0000
Message-ID: <c198feeebe88f1c4e2f4473a8e97a2d7f891911b.camel@mediatek.com>
References: <20240510110523.12524-1-liankun.yang@mediatek.com>
	 <20240510110523.12524-2-liankun.yang@mediatek.com>
	 <ffa57617-3c87-47d7-8882-becfe40abc17@collabora.com>
In-Reply-To: <ffa57617-3c87-47d7-8882-becfe40abc17@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5760:EE_|TYZPR03MB7409:EE_
x-ms-office365-filtering-correlation-id: 569288e8-4c1f-4bea-7755-08dc7358a4b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?QnloRm5Wbll5RXVnSmQ5ZGUwTEI4M1hXQ2xxcnVDQUpRdG0wTi94eHFVcFpD?=
 =?utf-8?B?ejFtRTJEL0NpalVKMGxWdllJV3U0TVNYSzhjTFVPb1piTFl2amtpcVlTTHhF?=
 =?utf-8?B?NDFuZVIyY0hMK1VtQVp0RzRVbmZjMFV6bGFPUUw3UDQ3bUdvRVJLT3kzbVFU?=
 =?utf-8?B?RUp6TlFxM1Y0V1JkTkRVclUrN0xBMlVoN3p1ekw4UkllOXVtR3RkZW5TeEtN?=
 =?utf-8?B?aklJeml3K0xwREk0aU44QzdOQkUyNnF6a0h6ZlIrc3hCSkxZWmttYnhQMW1q?=
 =?utf-8?B?Y0Z6UU5aaENIdlM4azNZYm4rTlZrNXZTRjNxNlZOTGYxdTNIZFl6Z0owd09Z?=
 =?utf-8?B?Ti8xNURnM1ViamNLU2RsRjZvOWplcFFLaTkzTjhKZG1oZXRuQWVVbk1mRUY3?=
 =?utf-8?B?Z0dxOEV3Nk1SMlFVcXplUDZpajR1eThFbFh1UW42ZzZ6dmc1TExoTGg2amtC?=
 =?utf-8?B?VTR1MVlxV1E0Yk83TE1BNjNiS3FwR25vY2w4MDhITDNOVjBjZkllUUovZHJY?=
 =?utf-8?B?UndVWnhoWlAwb3JxTnh4Qlh1Y1c0dFFvUDcxNjJRamppSERiSTh5MnRzd2ls?=
 =?utf-8?B?eE9kUExEczBvcWx0NUFmblpwNTNPY1BOL2hKb0IrMHdwSzVRZy92VzJWUkVT?=
 =?utf-8?B?QXQxNDZsOTQ0K3hDQ0d4RDhSaDNMTTU1SkRsUUZMV2Zic0ZBWGFla0UydDh5?=
 =?utf-8?B?UERPL3hpT2tFZkR1TXlIc0ZNb1daNXB0SXlzU284VVRCcDRKUmZUOUgwOUUx?=
 =?utf-8?B?S1d1cU5tSGxkNjZRdUZtdWpuRXh6OHNQUjl5T21IYm9mbU5iQUpxbFlqRWFh?=
 =?utf-8?B?NlRZZDNWbTRsdkdvTjBwZGNRa1BBZjd3blBWUjFsMWo5dlh1OUVtbmpYMmd0?=
 =?utf-8?B?ZjRrTkh6NDNBZmljSmNocUJGSWxpaXM0WVBhdnp1TXRLOGsrTzV6Ly8wQ0JT?=
 =?utf-8?B?empYd3liVHA4bW5YWjF4Qlk4ekk5bVJENjJoT0pkbGJReDFveUlTTmtaelhS?=
 =?utf-8?B?aVA0elFscGxVcHRTZXloeHF2bWJVdE8zUGdodzdvT2hMZTlmeGlXdzkrRDJ5?=
 =?utf-8?B?UVplUjQxTldVMkxrQTg5R01hNXNjSlFCYm9NckdFM3BIVWQwaW5sK2RKS2dJ?=
 =?utf-8?B?T2VUbHd0bXVLSG5oNzRETFJuaXRaeHp5RDFSc2FmSmNUdVVCWkRTbzVmWmtw?=
 =?utf-8?B?T2E1VWFHNFVRTEdYYVNrTVdXZlM0cVhBckV0Q0kyQ2gvSmxkZnpxMjN2TnZ0?=
 =?utf-8?B?TGppSjF6bGpSdE9QMlI5dTU1aXpTQzJXY0hwYUpBUlQxdUZLRzlNcTh1MGE5?=
 =?utf-8?B?NnpPVDJqMXFxZEFaY0dDMEpLTFJGbFc4VzNjdng4TDhHdklHVmsrVlgreDlx?=
 =?utf-8?B?dnFxbldMT3RmOWQvL2E2a3pzOE9YUGEvL1R6eWhYcSs1MVVRdzhKbTdVZ1ZF?=
 =?utf-8?B?cllpejhZNXRLNThQeUM2UEs1Yjc3bnUwczE0ampoeTNybXdZTHE3cGRzVzJZ?=
 =?utf-8?B?OHZVaXFVckVPSWlCUGxVYkdiMnBYY1lqcVBpK2JVM1NqLzdTLzRncGVhUHBQ?=
 =?utf-8?B?YmhOMlY4aUxCenozWUU2MEpRNlI1L3FsR1dQSC9RaXdocFVpZ09yRVhRTmll?=
 =?utf-8?B?bG9TQ25QYWdOK2F1S0czMEhMb0pSbXFTN1c2ekFWem1ud3FjVWZCVXZ0a2Z6?=
 =?utf-8?B?UEgrMnN5MHdvWnZOU2Foc1l6YXFPZDR2aGxVVDZoc0NiR0MvdHNvU2RnQi85?=
 =?utf-8?Q?UXv9iCgdY8ipR3leBo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5760.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3RxQm5MZG1zaEp6NEFmNnRac1kyY1IyZ0JiWWphczB1ZllSNURmVnYzV3BP?=
 =?utf-8?B?K1dlOTVQclNPYXlQSE5rVWM5R0dMZVpEK0IxT2treU1QR2FrNHVDbXNNb1p6?=
 =?utf-8?B?bWxUbm1DOHN4emEyaWgrTCtxbUJVUC9LaHE4M1MzZzRGZHhaZFc2TnpzM0hE?=
 =?utf-8?B?QSsvM2I5aG9Dd0FGMWUyZjgrNWxOUFpHajBBSVc2OTRWOEQ5RmExbWlwYWdz?=
 =?utf-8?B?TWtoalpNa25rRGh1UVhXOWM3N1NJbEx4emYyMk1kMkN0QlVYOTRVZXV0WlRB?=
 =?utf-8?B?bzJXVHV4THJKRkRZZGFqdVUzaFhxRUVpVG95dDVub1JRNnNPNDc5QnBiRytr?=
 =?utf-8?B?cFdmSkRpZVhZeHZ4Nkw4a2h4Rm1RS1VKZDh4Z0tha1dDbWpQbkVGWjIrUGd6?=
 =?utf-8?B?Q01PWFhlNXE5ZE4rdUY1OGhzUkYrNGxMNlJtRm55TjBDOHJoQlV4aDB4U0Vh?=
 =?utf-8?B?NjZ3dW0zYzJnN1pXbCt5emRiUDZ5VEtQcjNlaFJ2aWxVVG0ybGVDK3ozS1J4?=
 =?utf-8?B?UDVlek52MCt3cjVrOXcrSkRWbkk2Njl4NmNvbm90Z3QxQTdqdnE4dlY2QVhH?=
 =?utf-8?B?M0oydUJ0d2pidVlxaHk1NExaY1BzU25Lamp3bXBWaS9FMXp3cWRZQkR6MUR0?=
 =?utf-8?B?S3pxQ3UrbEVwa251OS8vYzNBQzNpaGVJZW5RVko4K1ZPcTZyZGd4QnlDaFJ5?=
 =?utf-8?B?MEswMlVEaXZiSHUxSnB6L1hRYTdRTitxSnNITThwK2hIdVRDWi9kNldVNHRJ?=
 =?utf-8?B?QTJqTmFqaGhKWWpBMnltd0MrSW94aG9mMmcvSDRFbTg3YnNLY3hVemMxSGVO?=
 =?utf-8?B?M3VpVE1GbFc3NUwxV2JVcUphNXRldnptYW55OGNSdHVEakdDVTFoREJNbGlV?=
 =?utf-8?B?RXFJLzliVU1FcmhKaUtQelVlNStKQkxYZDRZTXNZNnNBRmt4c2JrY01GOEZV?=
 =?utf-8?B?ZUhGeTlRdGZTZGROSm40cFVmTWdTNWtVWG9GK1kwNC9CV2ZBdmtTaFpaWUVH?=
 =?utf-8?B?ZFhVMzUyZlBhTDI1SFhxZ3c5TXdtQ0VmYVZXcDhqRWFxVEptQ3JCSVFScHBJ?=
 =?utf-8?B?SzBvcDJDdEp3aVBsdEdQdHFaNnJ6S2MyeEc1ZUZydUtzYzJ0c1AzZmpwejZ1?=
 =?utf-8?B?V3B4TUgvZmhTVzczNDlvUzBOcXhOUFF2MmRCSi9PZGdrSjl5akZXb2pTZUxs?=
 =?utf-8?B?YUYvWXAwVWpPVWU5a0Z2SlFNUDVBUjlGeC83NU0wVEY2bUhZZlg5cnVUNWNT?=
 =?utf-8?B?TWhFamM5NGF1bVV1c05udlZYM0QzK2p5akRqWm5uSGtvd3FuZzdtQ0ZPeG1u?=
 =?utf-8?B?ZnF0MWRLeVpOWjdnN3RNNTFTQlgwQ2dLcTZhTVg5NkhTZ2NQTDdyVHRxUXBx?=
 =?utf-8?B?Z0JhbVNyd1FQM2FWVG9BNlQvWHllblV0OGppZzVMT1hkcVluUDJEeXpobkt6?=
 =?utf-8?B?ZjdHWG9jV1ZHRFJRdnd4YlJrSUFPQ1JNZ245N3dsdmp6U1Bob1BkamJjUTIx?=
 =?utf-8?B?bHNNblU5M2FNMHlJY3E0ZUxTVkljNVBzOWFNRXA5S1pSZWZ4Vms4b0xaT28r?=
 =?utf-8?B?VFU3TW1mUVZTRXJDSnVSOU9NWkhKaFBLOG8xdkdRSklRN09WMUk1Z1VxVm9l?=
 =?utf-8?B?K2I5dlBiYXZ1b0lxdGhOL2hVY0VMbUMvRVhkbWlYVVBVMzVnM0Q1cHZnaGoz?=
 =?utf-8?B?Q1E1eHN1aEloSytGTEJQTHZ6VjZpYnNuL3p6MEo0RTJvbjR4UnZvd2ljamx6?=
 =?utf-8?B?OFZpd2k2cEx1NVR3alh5Q1F0VHplLzMxNXYyem1INGVSczIyMzJ0S21KRXZW?=
 =?utf-8?B?bHRpakN3MTlzZGNOWnpPZS9qRDJWUlpEZFZOTU9CcWVPaU43MGhvMGVudUJX?=
 =?utf-8?B?MWs0SHI0TnZ0RndkN2RQUVM5SXlMYUJoSHA5VVRZZHdITHNpdmkwczE5aHZh?=
 =?utf-8?B?TUtpelpqaGVZTWwrTDhZSHcxb2JKNGswYmZ4Q2pKN1F1U2Y4bHVjalJibGFD?=
 =?utf-8?B?Ty9JRVJROUZOWEhFTFJYaUhIb0V4VTB6ejFQUzBxbUhxS01FY3RkNmFHMmNh?=
 =?utf-8?B?TVhKUURXMEZ0OERnL1FVaHUvLzZQbDFyZ1o4dmN3azZlWmZyNURmajJYcEFL?=
 =?utf-8?B?NzdTNHUyMFNTL2FNTWR3SVlNeXd6bmpTc1JyZGw1UlFmbHp5aFhaMDVGL3k1?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DCD34CD4F0B8E4F9C62C1E54A85EEB4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5760.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569288e8-4c1f-4bea-7755-08dc7358a4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 14:26:13.7306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQfnc8ALNt0/mcwFwvB2LhiH3KZZi+TgHMAiPSgx4sD9Lo7AAyAGKzEfA8yAyt8z2zGrXrCrck/kzuQZnYXxntuCAkqj1lM+lm01xAGkZXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7409
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.548600-8.000000
X-TMASE-MatchedRID: GagEC7nsA0TUL3YCMmnG4vGG8F2k2BBVI4bJHZSdxcuyrCkM9r1bWskU
	hKWc+gwPp2+PpVTz2PH89WDKQGB2LvZomtZBUIXQydRP56yRRA8F15s6prCIu+soDDE6CvPdRBg
	jLK9tEupWz2luKD1NMvk6rne15aFQ717yJ8IcCtudVNZaI2n6/yhRWQHuJ8meWSw/UjSfbBJMN4
	VTgBt0+glFXYRYQBWym6hKKWWaX32ubeZytpejQ7xygpRxo469XcpmQXLhhkTagsZM0qVv1wfwZ
	jeYy4p53BlBvFCka9uwx5tV1a1qfpCoy9iDotiwyeVujmXuYYVhBfGxmdHCgi13PNammaAGQcct
	7CmEoT7i8zVgXoAltj2Xsf5MVCB1jaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.548600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5ABCA8F49DDC5FB3964009325D724F556DFFA328DCE6C578A16A53BC5180AE102000:8

T24gTW9uLCAyMDI0LTA1LTEzIGF0IDE1OjExICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTAvMDUvMjQgMTM6MDQsIExpYW5rdW4gWWFuZyBoYSBzY3JpdHRv
Og0KPiA+IER1cmluZyB0aGUgdGVzdGluZyBwaGFzZSwgc2NyZWVuIGZsaWNrZXJpbmcgaXMgb2Jz
ZXJ2ZWQgd2hlbg0KPiA+IHVzaW5nIGRpc3BsYXlwb3J0IGZvciBzY3JlZW4gY2FzdGluZy4gUmVs
ZXZhbnQgU1NDIHJlZ2lzdGVyDQo+ID4gcGFyYW1ldGVycw0KPiA+IGFyZSBzZXQgaW4gZHRzIHRv
IGFkZHJlc3MgdGhlIHNjcmVlbiBmbGlja2VyaW5nIGlzc3VlIGVmZmVjdGl2ZWx5DQo+ID4gYW5k
DQo+ID4gaW1wcm92ZSBjb21wYXRpYmlsaXR5IHdpdGggZGlmZmVyZW50IGRldmljZXMgYnkgYWRq
dXN0aW5nIHRoZSBTU0MNCj4gPiBnZWFyLg0KPiA+IA0KPiA+IE9idGFpbmluZyB0aGUgRFBUWCBu
b2RlLCBwYXJzaW5nIHRoZSBkdHMgdG8gb2J0YWluIFBIWSByZWdpc3Rlcg0KPiA+IGFkZHJlc3MN
Cj4gPiBhbmQgdmFsdWUgY2FuIGFkYXB0IHRvIHNldHRpbmdzIG9mIGRpZmZlcmVudCBtYW51ZmFj
dHVyZXJzDQo+ID4gcHJvamVjdHMuDQo+ID4gDQo+ID4gQ2hhbmdlZHMgaW4gdjI6DQo+ID4gLSBP
cHRpbWl6ZWQgbWV0aG9kIG9mIHdyaXRpbmcgdG8gRFAgUEhZIHJlZ2lzdGVyDQo+ID4gDQpodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoL19fOyEhQ1RSTktBOXdNZzBBUmJ3IWpZblVfdGw2WUdU
VWNGcGFyQU9jdXNTM3UtSDlHMjZ5c28yQnd1Z0JMb2VNT2FuWnVkeHRxUnBFWVYxWnk2cGhEakNR
SDJhbUcwS2RTYVIwczdFWkd5Y1l4emFCaEJ2dHV3JA0KPiA+ICANCj4gPiAyMDI0MDQwMzA0MDUx
Ny4zMjc5LTEtbGlhbmt1bi55YW5nQG1lZGlhdGVrLmNvbS8NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMaWFua3VuIFlhbmcgPGxpYW5rdW4ueWFuZ0BtZWRpYXRlay5jb20+DQo+IA0KPiBUaGVy
ZSdzIG5vIGRldmljZXRyZWUgc3VwcG9ydCBpbiB0aGlzIGRyaXZlciAtIGluZmFjdCwgaXQncyBi
ZWluZw0KPiBwcm9iZWQgYnkNCj4gbXRrLWRwIGFzIGEgcGxhdGZvcm0gZGV2aWNlLg0KPiANCj4g
WW91IGtlZXAgc2VuZGluZyB1bnRlc3RlZCBzdHVmZi4gRm91cnRoIHRpbWUgaW4gYSByb3cuDQo+
IA0KPiBQbGVhc2UsIFRFU1QgWU9VUiBDT01NSVRTIHVwc3RyZWFtIGJlZm9yZSBzZW5kaW5nIQ0K
PiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVu
dC4NCkl0J3MgYmVpbmcgcHJvYmVkIGJ5IG10ay1kcCBhcyBhIHBsYXRmb3JtIGRldmljZS4NCkJ1
dCB0aHJvdWdoIGR0cyBhbmFseXNpcyBpcyBhIGJldHRlciBzb2x1dGlvbi4NCkkgVEVTVCBDT01N
SVRTIHVwc3RyZWFtIGJlZm9yZSBzZW5kaW5nIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJlc3Qg
UmVnYXJkcywNCkxpYW5rdW4gWWFuZw0KDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3BoeS9tZWRp
YXRlay9waHktbXRrLWRwLmMgfCAzNw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstZHAuYw0KPiA+IGIvZHJpdmVy
cy9waHkvbWVkaWF0ZWsvcGh5LW10ay1kcC5jDQo+ID4gaW5kZXggZDcwMjRhMTQ0MzM1Li5jZTc4
MTEyZDU5MzggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1k
cC5jDQo+ID4gKysrIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1kcC5jDQo+ID4gQEAg
LTI4LDYgKzI4LDEwIEBADQo+ID4gICAjZGVmaW5lIE1US19EUF9QSFlfRElHX1NXX1JTVAkJKFBI
WV9PRkZTRVQgKyAweDM4KQ0KPiA+ICAgI2RlZmluZSBEUF9HTEJfU1dfUlNUX1BIWUQJCUJJVCgw
KQ0KPiA+ICAgDQo+ID4gKyNkZWZpbmUgTVRLX0RQX1BIWV9ESUdfR0xCX0RBX1JFR18xNAkoUEhZ
X09GRlNFVCArIDB4RDgpDQo+ID4gKyNkZWZpbmUgWFRQX0dMQl9UWFBMTF9TU0NfREVMVEFfUkJS
X0RFRkFVTFQJR0VOTUFTSygxNSwgMCkNCj4gPiArI2RlZmluZSBYVFBfR0xCX1RYUExMX1NTQ19E
RUxUQV9IQlJfREVGQVVMVAlHRU5NQVNLKDMxLCAxNikNCj4gPiArDQo+ID4gICAjZGVmaW5lIE1U
S19EUF9MQU5FMF9EUklWSU5HX1BBUkFNXzMJCShQSFlfT0ZGU0VUICsNCj4gPiAweDEzOCkNCj4g
PiAgICNkZWZpbmUgTVRLX0RQX0xBTkUxX0RSSVZJTkdfUEFSQU1fMwkJKFBIWV9PRkZTRVQgKw0K
PiA+IDB4MjM4KQ0KPiA+ICAgI2RlZmluZSBNVEtfRFBfTEFORTJfRFJJVklOR19QQVJBTV8zCQko
UEhZX09GRlNFVCArDQo+ID4gMHgzMzgpDQo+ID4gQEAgLTc4LDEwICs4MiwzOSBAQA0KPiA+ICAg
I2RlZmluZSBEUklWSU5HX1BBUkFNXzhfREVGQVVMVAkoWFRQX0xOX1RYX0xDVFhDUDFfU1cyX1BS
RTFfREVGDQo+ID4gQVVMVCB8IFwNCj4gPiAgIAkJCQkgWFRQX0xOX1RYX0xDVFhDUDFfU1czX1BS
RTBfREVGQVVMVCkNCj4gPiAgIA0KPiA+ICsjZGVmaW5lIFNTQ19TRVRUSU5HCSJkcC1zc2Mtc2V0
dGluZyINCj4gPiArI2RlZmluZSBSR19YVFBfR0xCX1RYUExMX1NTQ19ERUxUQV9IQlIJInNzYy1k
ZWx0YS1oYnIiDQo+ID4gKw0KPiA+ICAgc3RydWN0IG10a19kcF9waHkgew0KPiA+ICAgCXN0cnVj
dCByZWdtYXAgKnJlZ3M7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gICB9Ow0KPiA+
ICAgDQo+ID4gK3N0YXRpYyBpbnQgbXRrX2RwX3NldF9zc2NfY29uZmlnKHN0cnVjdCBwaHkgKnBo
eSwgc3RydWN0DQo+ID4gbXRrX2RwX3BoeSAqZHBfcGh5KQ0KPiA+ICt7DQo+ID4gKwlpbnQgcmV0
Ow0KPiA+ICsJdTMyIHJlYWRfdmFsdWUgPSAwLCByZWdfbWFzayA9IDA7DQo+ID4gKwlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKnNzY19ub2RlID0gTlVMTDsNCj4gPiArDQo+ID4gKwlzc2Nfbm9kZSA9IG9m
X2ZpbmRfbm9kZV9ieV9uYW1lKGRwX3BoeS0+ZGV2LT5vZl9ub2RlLA0KPiA+IFNTQ19TRVRUSU5H
KTsNCj4gPiArCWlmICghc3NjX25vZGUpIHsNCj4gPiArCQlkZXZfZXJyKCZwaHktPmRldiwgIlNT
QyBub2RlIGlzIE5VTExcbiIpOw0KPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKHNzY19ub2RlLA0KPiA+IFJHX1hU
UF9HTEJfVFhQTExfU1NDX0RFTFRBX0hCUiwgJnJlYWRfdmFsdWUpOw0KPiA+ICsJaWYgKHJldCA8
IDAgfHwgIXJlYWRfdmFsdWUpIHsNCj4gPiArCQlkZXZfZXJyKCZwaHktPmRldiwgIlJlYWQgU1ND
IHZsYXVlIGZhaWwhXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiAr
CXJlYWRfdmFsdWUgfD0gcmVhZF92YWx1ZSA8PCAxNjsNCj4gPiArCXJlZ19tYXNrIHw9IFhUUF9H
TEJfVFhQTExfU1NDX0RFTFRBX0hCUl9ERUZBVUxUOw0KPiA+ICsNCj4gPiArCXJlZ21hcF91cGRh
dGVfYml0cyhkcF9waHktPnJlZ3MsIE1US19EUF9QSFlfRElHX0dMQl9EQV9SRUdfMTQsDQo+ID4g
cmVnX21hc2ssIHJlYWRfdmFsdWUpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICAgc3RhdGljIGludCBtdGtfZHBfcGh5X2luaXQoc3RydWN0IHBoeSAqcGh5KQ0K
PiA+ICAgew0KPiA+ICAgCXN0cnVjdCBtdGtfZHBfcGh5ICpkcF9waHkgPSBwaHlfZ2V0X2RydmRh
dGEocGh5KTsNCj4gPiBAQCAtMTM3LDYgKzE3MCw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwX3BoeV9j
b25maWd1cmUoc3RydWN0IHBoeQ0KPiA+ICpwaHksIHVuaW9uIHBoeV9jb25maWd1cmVfb3B0cyAq
b3B0cykNCj4gPiAgIAlyZWdtYXBfdXBkYXRlX2JpdHMoZHBfcGh5LT5yZWdzLCBNVEtfRFBfUEhZ
X0RJR19QTExfQ1RMXzEsDQo+ID4gICAJCQkgICBUUExMX1NTQ19FTiwgb3B0cy0+ZHAuc3NjID8g
VFBMTF9TU0NfRU4gOg0KPiA+IDApOw0KPiA+ICAgDQo+ID4gKwltdGtfZHBfc2V0X3NzY19jb25m
aWcocGh5LCBkcF9waHkpOw0KPiA+ICsNCj4gPiAgIAlyZXR1cm4gMDsNCj4gPiAgIH0NCj4gPiAg
IA0KPiA+IEBAIC0xODYsNiArMjIxLDggQEAgc3RhdGljIGludCBtdGtfZHBfcGh5X3Byb2JlKHN0
cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgIAlpZiAoIWRldi0+b2Zfbm9k
ZSkNCj4gPiAgIAkJcGh5X2NyZWF0ZV9sb29rdXAocGh5LCAiZHAiLCBkZXZfbmFtZShkZXYpKTsN
Cj4gPiAgIA0KPiA+ICsJZHBfcGh5LT5kZXYgPSBkZXY7DQo+ID4gKw0KPiA+ICAgCXJldHVybiAw
Ow0KPiA+ICAgfQ0KPiA+ICAgDQo+IA0KPiANCg==

