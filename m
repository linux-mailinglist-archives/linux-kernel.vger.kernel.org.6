Return-Path: <linux-kernel+bounces-418030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E789D5C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445BCB21DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE551D0143;
	Fri, 22 Nov 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dNxNFpOK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eUd2solY"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158815AAD9;
	Fri, 22 Nov 2024 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268287; cv=fail; b=a1cfm7M+1C2DZD4TKoUTaGCQwoL6mgaJuvcv83NC8k8faKKA93bUvj0zI8SNcXdwaSFuzQd2tu9+mGv6jgyeQziL8RU/12mml3sjFfZzzo9r74u2wk2ibup1SNtUbjcjNK3Nb04ghSyuxRt9ayh8H0hGut/NPkSLvtW4W9PK1ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268287; c=relaxed/simple;
	bh=ug2ZYfCTq2ikjw1FZ32MckJI1aAhWe1+hgH4A/T4334=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYFVMOrYdjsoeptJ+EIdF610DPSZ/H1mIMFHqz4Aa1kd9zoANBTH0vMhK3H5lCk4Pvda8xNwMxNKcLEDuB6+Kb4NRV5OK/3W7FCIaBOtVNZTenWH2e3AoLvr4VZDW4caG+4hNV9c0vR7f8jkJTauN4rZPZcrUEaKwatkhk5DgwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dNxNFpOK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eUd2solY; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 76f7e84aa8b511ef99858b75a2457dd9-20241122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ug2ZYfCTq2ikjw1FZ32MckJI1aAhWe1+hgH4A/T4334=;
	b=dNxNFpOK4RKjfWeBJdJmZ/DoPrJ5HTUSxW+LrTGZObmGSt2juc7QhWG2YhNDkYfQQd8jQ8dWR8KjQJyzJb+duzqA5FFe4O2lmdRVqltQgOGcAIxfS/vLRY6T0wGamB8UBaS6eeKR8ex0Avrjl1LFbdn1Gk7W7y+Ee6zEGjm2BAk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:322e65b4-f2c8-413e-877e-899d55b40dc8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:73a0a3a0-f395-4dfc-8188-ce2682df7fd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 76f7e84aa8b511ef99858b75a2457dd9-20241122
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1629089263; Fri, 22 Nov 2024 17:38:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Nov 2024 17:37:59 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Nov 2024 17:37:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR9V7t4FjWkEPXZw/lkNExxAf4YrGUcm75UM3ySTliR3EiDeu0R2uo++ku/j9ag1yXPcg4qGrEGzgfkhXFuyI+PA7VvMhjlvBC/THVmPN7miZVwQYlP6ytUOGk7si+fKMOp/vytAlyb8QQtwvd0AVASViT6hGzClEkuF5LW1tmOfKBtl53K1y2+qy/hCWfHxgxzCqQPHmOAAhZDg4s4THjGEYX5CZqTFtoSBpZkLiJv6FsM8Get5qATWIxgM2Wa4vazmoZwpvmubKyXizuXuK9fjoJb/ADyVt6OvpTpVboVPC0tGzXQLR6wbPPwjE9HwPoe3wlv1YQ/8dpFTUbA6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug2ZYfCTq2ikjw1FZ32MckJI1aAhWe1+hgH4A/T4334=;
 b=taC6Xy/TamOIKvZZO8tBlEEr4E8w8g9LnGgtHtYbKWPlLTilsJhmtPVqe5DdxXWoZik8ha7jiWjAzjrWyNzzpte/Bt6rvt1k4rDntNVInQOPw/oKxOyfXHEpIa1IKH3dql3tf2Oa9luAVf84VlVlvhK4OZpuYMgWyjVIVvbdOnfdVuaPpiRnXEI17UuBBU6KQ6AjAWS1CuwU5vPxCb1Sf6kgVtCVI7/RoeV1mVhZExsdznutjrWRab+7yWogpgtjPjwi/XsUtNcpRrEeNaZE80OvKKn6NgrLiMyKylQnJMuxMyjB32YQZq46neSraoD1MVCR1n++C5W+ErvqzNunLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug2ZYfCTq2ikjw1FZ32MckJI1aAhWe1+hgH4A/T4334=;
 b=eUd2solY1emYjIar279Qgn5kV07v/PnnQGWKMNrq1dPRuk74BRBbI3O2DQIvGqtYcE3rgd2bXflN+GazBoiTg1gp3CS6Ml4O15AnBsk4FSBDmDJwop6MiYuJWjy8dEyt6yjj9eS0RaCoAsZ6/e4He+qqifGfXIFMUnUXAvweWY4=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by KL1PR03MB8144.apcprd03.prod.outlook.com (2603:1096:820:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Fri, 22 Nov
 2024 09:37:57 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 09:37:56 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"krzk@kernel.org" <krzk@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp related property
Thread-Topic: [PATCH v2 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp related property
Thread-Index: AQHbOxafW9Nl29fMRkmElAappRl4rrK/yY0AgANEr4A=
Date: Fri, 22 Nov 2024 09:37:56 +0000
Message-ID: <e0d4f218de665dcc86866649981fe748ba708a3e.camel@mediatek.com>
References: <20241120063701.8194-1-friday.yang@mediatek.com>
	 <20241120063701.8194-2-friday.yang@mediatek.com>
	 <173208859835.3697069.14880651940019418279.robh@kernel.org>
In-Reply-To: <173208859835.3697069.14880651940019418279.robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|KL1PR03MB8144:EE_
x-ms-office365-filtering-correlation-id: 6a11a5aa-8e03-444b-285f-08dd0ad9588f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RlJNZWJweXFXWFRaNTVGeCszWmZvam9pQTErWkgycUZyRTZjN2ZrTGI0dThU?=
 =?utf-8?B?aW14RTRENUo4ZjlxeEV5VWo0YS9qTW4yenhQQkNYREtBN0RHZ1VMRzFjTXNT?=
 =?utf-8?B?RUc2bngwS1ZsRkxXSmtlK3VWMTMrMHdYeG1VNWFvTVBFV3hVc05jSDdOZTBR?=
 =?utf-8?B?b1lsSTZQRVd2a1NHK2RQRTdSaFVtMTljMXZPNGZGQ1BrNU92M1BWWmJNN1hq?=
 =?utf-8?B?bWd0amRxNWNFZGQwQVl0YlFRdndVT0xtNUZ6N1B6WFFzTUkrOVVrblRyZUc3?=
 =?utf-8?B?cGo2cjVXdWc4alB5ayswK0k1K0RRYkQ2aUdzU05pS2NSdnRUc3V4MXhCL3NW?=
 =?utf-8?B?Ritwcy9wQmVQaGZsQU8zMFcyU0VwNEhJTGdxcEFhbmRVdkhHMGxYZVVzcTIz?=
 =?utf-8?B?L29MOWU1L3RCd2MwcGFpWHRkdG5zcHpIWmVQQTZWMFJ5Q1BxRDBncDhFTjZa?=
 =?utf-8?B?cGVaMUhsVE5mVmlCaVRmQ2VveFN5TURpMitMU2J6Y0pBMXZXYmM3TE8rek54?=
 =?utf-8?B?dGhUQ2JIOVRHdkQ5dzVkcmpPZWVpZmJvQUxXV0MyTE5IMlRuTWcwcGJHbEdj?=
 =?utf-8?B?SmlteG8xbVBCcFdtWEdkTW9kQXJxenErZDJHUEowNmZqNmV3NWs3YXhLNEFs?=
 =?utf-8?B?d0NmRllxMk51aGduUy9lczBsTzd6T3RoRGpNak5NY1lLSU56SE11UlQwalo2?=
 =?utf-8?B?NjBQNjAxQUtlTjVlRnRBWFVzRTJRMEcyUngrSm51eE5iekhPSFJscGZoN3lr?=
 =?utf-8?B?cXRiUDdrU3N0NW9na0xFdnEzS0lRejV2bHBhakdmQ1JMcERBV0NQUnpRTTVZ?=
 =?utf-8?B?bTl2SlNpeFlIM2d5amVpK0FEMC81TDlwajJZZ29XOFoxODI5WUFwWGtFbGpZ?=
 =?utf-8?B?Zzl3d0pzNUlvSEEzb0pybTZXZlVIWkRBSWZmNEs4MzZ5RUhWcjBhNTQ5YllS?=
 =?utf-8?B?RnJpSmg4QitGZ29IN0M4MzAyVTE5aFhCZkRFSlc2aEVSOHhPN1F5eDhiY05i?=
 =?utf-8?B?Y2trQ3FiSlhuWFNSY0lLUmF1M01iM3IzRFpDT0pYRDY5ZHRQOWVpZVB5Tkxk?=
 =?utf-8?B?aCtmWEd2Vk4zc3EyWG1SaDNxRURGUVNmTnZFaTd0U2kxRmFLclZYNDJNa3NL?=
 =?utf-8?B?L1FVOXgzZ09BL2QzQitYdW5yYmkwaFdyRi9DUUtuRWdoZG5rRFBkM1FjWDIx?=
 =?utf-8?B?aUdXNitUWTh2elp3cVVjNWFaeW1yaGczUGhLaE9SZFRlM0RocDBkMWJhYzdQ?=
 =?utf-8?B?SGVtdmxacG81LzVjYy9aZ0JaMWRCY1dzeGlRZDRPSklPaGRzbEMxMExoL2ht?=
 =?utf-8?B?MGhnTkhNcmx6UWp3WEQ1RjRwZlZLNkx1WmEzWUxVenBIZ3h4aGpGb2prK0Q3?=
 =?utf-8?B?NUZ4WkhndURML2c3QW9hM1luTmpWUFVVZEFtSUh6ZlRPaE9TNmh4alV0aDFX?=
 =?utf-8?B?cGtQbklMams3RXlaK0NYOVlQWU43U21nclpBaUlFVEJlL2hLNjRmRlNKcEQ2?=
 =?utf-8?B?K3FFNWJLS2tYdDE5ZDBLc1l1V3RibXJtcVpFeXhRUkt1M29BMlUvb0ZmRElB?=
 =?utf-8?B?T01kZHl0U0RxM1hqd1JJWDNoOVMxWUNJNkZpbW0ydDUwQndKWEJjc3ZOUGZ2?=
 =?utf-8?B?QzBVR3pqeGdOZ3hObzZ5T1M4RC9RRjY1U0pjQ3c3SFdBcllWMWU4cFBON3ZK?=
 =?utf-8?B?VFN6TisyUENYNU95dURYOFBEbk8ycXVqQmZPc04xOC85bWQ5dVNjSSs5Z2w2?=
 =?utf-8?B?YUVHUE0wb2x4TTB0emkwZURjZ2VQS0R4UWYvczU3K2ZCNG8rRHFpTzJaKzhD?=
 =?utf-8?Q?47xC/qUD98Khw1uaXYa6KfQJZguQpEj6NI1W0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1RmdFJHekFJUkgzR0dEdkdWVXNvdUhkamJKelBnK2JpS3RST3hQWW5OeVov?=
 =?utf-8?B?T1phVkpaanYzV0Mzb3c2SEQ0K2duRW9LY1VnZnZjTEJBY3FRVGtkSzNxakFM?=
 =?utf-8?B?Skw1NFdNYlVZcG1VdTZZVEEzeHBoYmdlMzluZU9rVHB3RG9oYzR1VWdrRExt?=
 =?utf-8?B?NExyUWx6SGYvQnFLbkZKTlhROUZsWW1Wc21sSnhXbStPaDRRd0VWQ1gwM28r?=
 =?utf-8?B?WTVFMTFaKzFteEFYTDcxK1lBM3p5ejVoQ0pranFEVHFMQXY4enRGejlySWtU?=
 =?utf-8?B?My9nYXhqSzVFWGJBWDg1ZEtCeGphL0RSdnV5WHQ3ZEEvNWJDS3E4MzNVeGVS?=
 =?utf-8?B?MUpNZkNSbk9SR0RWZUs1Y0lBK0hwdVoyeFhndG90QzRQR3VacHdIMkNtQVQz?=
 =?utf-8?B?NkFpY1I0TktkQXp3eUNXZEVOTzNFam04VDBMSStHajFrbUY4SmFPdUZpNlg1?=
 =?utf-8?B?UkU1c2FSZUc4elJ0TkRwQ2ErWE05NDhoMFp4YXlCTXFoZmc5MGN1THg2cXF5?=
 =?utf-8?B?ZVp4T3BoZUNBMHQvTkRvbDVCaE9qdGh0a0N4Y09FOWJ4VktlWVB0SEFZRTBG?=
 =?utf-8?B?b25MRFFCMXl1V1c3SmVMMEVDMVdKdTg2K09rNjNQZmdFOUdQT2pBRnZmQWpz?=
 =?utf-8?B?RWRpRmF6cEZwRzZoTy81UVhIaDVPUHVkeVBmUU9YZldDS1BwRWxieDE2U2Jn?=
 =?utf-8?B?VlEyeitPMzdZRzBCcXFXSWlDQW1aMHlUd3ZSWjFzaW9NZVVnaEJuQXNiaWJy?=
 =?utf-8?B?UUVMdlpxV09tRmJQOEo4Tkt5aDhDMmtFSmd5ak96YU9uRHo4UVRud2FDdGZS?=
 =?utf-8?B?UWNFb0xtVXY4eUhCSnFWNHZlT0RNdDJxZVVsckYySlVxY1cwYllRUkMrM1FV?=
 =?utf-8?B?U3dFeU9EM1d2NktVYlg2S0xuK2JiMWxkUmNSZExuZW5IV0xFS0RnclVqYXMz?=
 =?utf-8?B?TndzM1FrZm13eTJ2N3FZZEJQUW8ySEQ5ZWZRUzFHV0hPZEk3b2pzaXJiZmk2?=
 =?utf-8?B?eklTODd0bkVQNXlHbjYvNjJkQXFiWHE3MXBNM2xiVXVjWEl3U3gvcDAzVk5l?=
 =?utf-8?B?MDVoVUgrTTVNQ25Ec29yVTdlL2M0SEwyK002OHd5Ym1odmxTQTVabVBUc3dI?=
 =?utf-8?B?Q2p5MkF5ZmFvZ3dPWnZubDdkajN1M1FXM3R0ZWgrME5iZ3lodml5ODhYay9m?=
 =?utf-8?B?MmJjenVnNEpFRVpjVUpIcFA3MUYzaWpxbHZWb0ZqUDFtR25HUktNeTlGWEUw?=
 =?utf-8?B?RjhKU3FLaFU4VXF3dkM3UEh3SE9wdTJKTGVlRU9nYnRyS0lGWWkvMWYxZTdl?=
 =?utf-8?B?amt5MGtsUnM2bUx0b0NBYjVYUzdOZUYrY3ZEaWJvQlRSb1JQUVJkRHB2YW5P?=
 =?utf-8?B?dzV2ZStIc2I0a2NVZFcrUkcvb05WMFF1YTFtOEViSzhqZmY5RmRmaGdKcGNV?=
 =?utf-8?B?bkdYMDk0cDhYL29GZWRrZ0VxV1h4TWszdElNNlZjSzRQaGM3S3ZPQXM5Rmc0?=
 =?utf-8?B?VkUwSDZEUHhhRkpzVU11RHREZTlkVTQ5SFJGZXg1TjBtTEF4bCtJY0gzS3No?=
 =?utf-8?B?UjlZeC9ITnNGemVWWjNKVkVxaEVZNlM0SlpuRy9RbHA0RmtDU055cTRYYVll?=
 =?utf-8?B?Y1N3Z1hVUFpTTzVJbVdyN1hOMVFDdU9DRXo4b0ExNEZocTVoVGpOSGRTTnAw?=
 =?utf-8?B?WkJESzRKR0JpQUxpaUM3VmsxQjVibnc0VDFrdmU5SUc1SCsvWTBwVGRCY3Uw?=
 =?utf-8?B?SytWM21ucUtsbHNkYWZtNGFySE1IUjVIRjgreWR5WkluYXZsSzMvN0tzVmVO?=
 =?utf-8?B?MHd5LzdQdXp0bStkcnRLQk9jVTJiWm1JUDNUYXp2WFBpdVZQZENDTFVwSzV2?=
 =?utf-8?B?M3RnZEljZTFqK0ZqOGhKeFZNWWdoblM1VmhzU2lHYmNsVXZsRVBydXA0b2ls?=
 =?utf-8?B?K28wdmlCcGpuTUMwcHBSdCtBYTVxZUxadUpjcEMzMW04c2pLSndiZUxmdWdi?=
 =?utf-8?B?b3hHbHcxcjkzcENqTUVjLzRJWUNaYUlEa0NZMjRhTVU2K3FPYkE1UmJPV1o2?=
 =?utf-8?B?ODRrZm9OZlFhR3ZBcjZYUlV2bHBNdE53Zzd0MllSNnl1N3FVaHgxZzVkWHc2?=
 =?utf-8?B?bHlWdHJoc0NBdEs0UDIwUEMvMnBqQWJOcjNpbExGWDIrRE5pZXVST1YzeG0z?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <740C0B80FE8591448B8DDBEA0885BC50@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a11a5aa-8e03-444b-285f-08dd0ad9588f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 09:37:56.6004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCpe9oKFmqfi5sKZ///XUUy4XeoDjTEW8iq2e1dJAosy7+qdno7DSW+4dfjcApet5YF6/c5Pz6c7sC6Ba3KqBWgs8MjkuOlv4FiLxY+kKkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8144

T24gV2VkLCAyMDI0LTExLTIwIGF0IDAxOjQzIC0wNjAwLCBSb2IgSGVycmluZyAoQXJtKSB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiBXZWQsIDIwIE5vdiAyMDI0IDE0OjM2OjM4ICswODAwLCBG
cmlkYXkgWWFuZyB3cm90ZToNCj4gPiBPbiB0aGUgTWVkaWFUZWsgcGxhdGZvcm0sIHNvbWUgU01J
IExBUkJzIGFyZSBkaXJlY3RseSBsaW5rZWQgdG8gU01JDQo+ID4gQ29tbW9uLiBXaGlsZSBzb21l
IFNNSSBMQVJCcyBhcmUgbGlua2VkIHRvIFNNSSBTdWIgQ29tbW9uLCB0aGVuIFNNSQ0KPiA+IFN1
YiBDb21tb24gaXMgbGlua2VkIHRvIFNNSSBDb21tb24uIFRoZSBoYXJkd2FyZSBibG9jayBkaWFn
cmFtDQo+ID4gY291bGQNCj4gPiBiZSBkZXNjcmliZWQgYXMgYmVsb3cuDQo+ID4gQWRkICdyZXNl
dHMnIGFuZCAncmVzZXQtbmFtZXMnIGZvciBTTUkgTEFSQnMgdG8gc3VwcG9ydCBTTUkgcmVzZXQN
Cj4gPiBhbmQgY2xhbXAgb3BlcmF0aW9uLiBUaGUgU01JIHJlc2V0IGRyaXZlciBjb3VsZCBnZXQg
dGhlIHJlc2V0DQo+ID4gc2lnbmFsDQo+ID4gdGhyb3VnaCB0aGUgdHdvIHByb3BlcnRpZXMuDQo+
ID4gDQo+ID4gICAgICAgICAgICAgIFNNSS1Db21tb24oU21hcnQgTXVsdGltZWRpYSBJbnRlcmZh
Y2UgQ29tbW9uKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAg
ICstLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiAgICAgICAgICB8ICAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgfCAgICAgICAg
ICAgICAgICB8ICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgIHwgICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICB8ICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgfCAgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgfA0KPiA+ICAgICAgICBsYXJiMCAgICAgICBTTUktU3ViLUNvbW1vbjAgICAg
IFNNSS1TdWItQ29tbW9uMQ0KPiA+ICAgICAgICAgICAgICAgICAgICB8ICAgICAgfCAgICAgfCAg
ICAgIHwgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgICAgICAgICAgIGxhcmIxICBsYXJiMiBs
YXJiMyAgbGFyYjcgICAgICAgbGFyYjkNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBGcmlkYXkg
WWFuZyA8ZnJpZGF5LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IEFsdGhv
dWdoIHRoaXMgY2FuIHBhc3MgdGhlIGR0YnNfY2hlY2ssIG1heWJlIHRoZXJlIGlzIGEgYmV0dGVy
IHdheQ0KPiA+IHRvIGRlc2NyaWJlIHRoZSByZXF1aXJlbWVudHMgZm9yICdyZXNldHMnIGFuZCAn
cmVzZXQtbmFtZXMnIGluDQo+ID4gYmluZGluZ3MuDQo+ID4gQnV0IEkgZG9uJ3QgZmluZCBhIGJl
dHRlciB3YXkgdG8gZGVzY3JpYmUgaXQgdGhhdCBvbmx5IFNNSSBsYXJicw0KPiA+IGxvY2F0ZWQN
Cj4gPiBpbiBjYW1lcmEgYW5kIGltYWdlIHN1YnN5cyByZXF1aXJlcyB0aGUgJ3Jlc2V0cycgYW5k
ICdyZXNldC1uYW1lcycuDQo+ID4gSSB3b3VsZCBhcHByZWNpYXRlIGl0IGlmIHlvdSBjb3VsZCBn
aXZlIHNvbWUgc3VnZ2VzdGlvbnMuDQo+ID4gDQo+ID4gLi4uL21lZGlhdGVrLHNtaS1jb21tb24u
eWFtbCAgICAgICAgICAgICAgICAgIHwgIDIgKw0KPiA+ICAuLi4vbWVtb3J5LWNvbnRyb2xsZXJz
L21lZGlhdGVrLHNtaS1sYXJiLnlhbWwgfCA1Mw0KPiA+ICsrKysrKysrKysrKysrKy0tLS0NCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4g
PiANCj4gDQo+IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVubmluZyAnbWFrZSBkdF9iaW5kaW5nX2No
ZWNrJyBvbiB5b3VyIHBhdGNoOg0KPiANCj4geWFtbGxpbnQgd2FybmluZ3MvZXJyb3JzOg0KPiAu
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVk
aWF0ZWssc21pLQ0KPiBsYXJiLnlhbWw6MTQzOjEzOiBbd2FybmluZ10gd3JvbmcgaW5kZW50YXRp
b246IGV4cGVjdGVkIDEwIGJ1dCBmb3VuZA0KPiAxMiAoaW5kZW50YXRpb24pDQo+IA0KPiBkdHNj
aGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOg0KPiBFcnJvcjogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21lbW9yeS0NCj4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIuZXhh
bXBsZS5kdHM6MjkuNDMtNDQgc3ludGF4IGVycm9yDQo+IEZBVEFMIEVSUk9SOiBVbmFibGUgdG8g
cGFyc2UgaW5wdXQgdHJlZQ0KPiBtYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuZHRiczox
Mjk6DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxl
cnMvbWVkaWF0ZWssc21pLQ0KPiBsYXJiLmV4YW1wbGUuZHRiXSBFcnJvciAxDQo+IG1ha2VbMl06
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uDQo+IG1ha2VbMV06ICoqKiBbL2J1
aWxkcy9yb2JoZXJyaW5nL2R0LXJldmlldy1jaS9saW51eC9NYWtlZmlsZToxNDQyOg0KPiBkdF9i
aW5kaW5nX2NoZWNrXSBFcnJvciAyDQo+IG1ha2U6ICoqKiBbTWFrZWZpbGU6MjI0OiBfX3N1Yi1t
YWtlXSBFcnJvciAyDQo+IA0KPiBkb2MgcmVmZXJlbmNlIGVycm9ycyAobWFrZSByZWZjaGVja2Rv
Y3MpOg0KPiANCj4gU2VlIA0KPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3Qv
ZGV2aWNldHJlZS1iaW5kaW5ncy9wYXRjaC8yMDI0MTEyMDA2MzcwMS44MTk0LTItZnJpZGF5Lnlh
bmdAbWVkaWF0ZWsuY29tDQo+IA0KPiBUaGUgYmFzZSBmb3IgdGhlIHNlcmllcyBpcyBnZW5lcmFs
bHkgdGhlIGxhdGVzdCByYzEuIEEgZGlmZmVyZW50DQo+IGRlcGVuZGVuY3kNCj4gc2hvdWxkIGJl
IG5vdGVkIGluICp0aGlzKiBwYXRjaC4NCj4gDQo+IElmIHlvdSBhbHJlYWR5IHJhbiAnbWFrZSBk
dF9iaW5kaW5nX2NoZWNrJyBhbmQgZGlkbid0IHNlZSB0aGUgYWJvdmUNCj4gZXJyb3IocyksIHRo
ZW4gbWFrZSBzdXJlICd5YW1sbGludCcgaXMgaW5zdGFsbGVkIGFuZCBkdC1zY2hlbWEgaXMgdXAN
Cj4gdG8NCj4gZGF0ZToNCj4gDQo+IHBpcDMgaW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUNCj4g
DQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0IGFmdGVyIHJ1bm5pbmcgdGhlIGFib3ZlIGNv
bW1hbmQgeW91cnNlbGYuDQo+IE5vdGUNCj4gdGhhdCBEVF9TQ0hFTUFfRklMRVMgY2FuIGJlIHNl
dCB0byB5b3VyIHNjaGVtYSBmaWxlIHRvIHNwZWVkIHVwDQo+IGNoZWNraW5nDQo+IHlvdXIgc2No
ZW1hLiBIb3dldmVyLCBpdCBtdXN0IGJlIHVuc2V0IHRvIHRlc3QgYWxsIGV4YW1wbGVzIHdpdGgg
eW91cg0KPiBzY2hlbWEuDQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIEkgdXNlZCB0
byB1c2UgdGhpcyBjbWQ6DQoNCm1ha2UgRFRfQ0hFQ0tFUl9GTEFHUz0tbSBkdF9iaW5kaW5nX2No
ZWNrDQpEVF9TQ0hFTUFfRklMRVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21l
bW9yeS0NCmNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwNCg0KQW5kIEkgd2lsbCB1
cGdyYWRlIGR0c2NoZW1hIGFuZCBjaGFuZ2UgdG8gdXNlICdtYWtlIGR0X2JpbmRpbmdfY2hlY2sn
DQphZ2Fpbi4NCg==

