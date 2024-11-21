Return-Path: <linux-kernel+bounces-416522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C04D09D465C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C2B1F20FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18F04D8CB;
	Thu, 21 Nov 2024 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kXaeOL8s";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MoJjw9hx"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589A3B796
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732161017; cv=fail; b=l2mzEiuRlmGW3wrSLLtEKQNUjQgRmilsnwnb0wUhJqxnJGQWbG4kp2T1xmGv3LG1bVCTtCEH7YVFlXce4Pg/xQzlVlnhJfxrRIt9wG+MQr3kobLS+woaQypHuZ1geX2AezjiKri39Osj/CnIxKqIKlYs5KXErMCGTokJoDzyWUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732161017; c=relaxed/simple;
	bh=RCSSuZVJbE3S9PS+bbvM7/8aYoR9WAcLbD+n2iNp+eM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mmp9eSoh8t3a4MuowBkcAPF3JRTWgkcDSXM7wUdQU1D2dLupILOQzTqHWrZpfWfYZfJdhoZg8Bb4yVx9zow1oJq8vlZnWXyiwG6Ul6Ar86HzGXw+bcL8/2SUv2577us96ekkNTbR9MRVVVM54VCCbFlBEU6POpuDo5udFdC01b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kXaeOL8s; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MoJjw9hx; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b255f1b6a7bb11ef99858b75a2457dd9-20241121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RCSSuZVJbE3S9PS+bbvM7/8aYoR9WAcLbD+n2iNp+eM=;
	b=kXaeOL8scK4yMycl3dLHKeKgnJnDHqG4YltoNNUSfoevsb76IztJ2Xpzzhf7nWZHUdta2CC4bGn0IR7+p+SzeNeO8M3UQdz8UmkJDgdRRUZUyi4qQ14tv3dzshVpsitjx5HqEdaYobqmCeP7zuvcocXMQO2V2fYT0UpnHdfoiaY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:3f98d429-7aa8-4f84-b366-ca7b91e497cb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:f1968ea0-f395-4dfc-8188-ce2682df7fd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b255f1b6a7bb11ef99858b75a2457dd9-20241121
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 144681667; Thu, 21 Nov 2024 11:50:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Nov 2024 11:50:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Nov 2024 11:50:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFPQs30Ia9OFpQm/a70KyAGYPXXGh1ytQcRzEnwMBFmnEMDRlrhz20ObbPxsexC3FWNnMVonGS7lpVrnlkDgCFt9HxhR+bG7khj5Rn9xINCWpDGtH0xJLjbJSW1adShtp96PxLHa4ulksUAagqpewyjs4tSY/VeGHDlE8MPyA3pIsb17c/lPgjKJIp4SPxoU5NN3PEkmpOjjAziRnZ/Ygp77XEQ2HE7zP47ZH7ZPXg73uuP0KPjn8owsK4MY2QXQubMOLKbyta5rGHvY+b6YXR8Cm14yeF6l6jSVCqhpu1VSzdtfyIy+fukIcTBD9XFIhe/RqE7FzquIbl/GHs9PBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCSSuZVJbE3S9PS+bbvM7/8aYoR9WAcLbD+n2iNp+eM=;
 b=MULry+w/9KNWd3tw5E/mSkttcskscXKD+GAX9Z5HXwWO28PGKSMdR+MV4vlZSVp53BnB53Ri/MywCHhzWc52/sv1aa30iG8ZFYJGU8J+s4GJPep8yvfnbIGezEcgNz1gVr+nbqsfjkIPSDwFJsE4+y3sur21G8cxU1UfkHSA5cZ2eQeJioClWueZiu0MRZBEZNoacD8GJ4ZXaxmb9C21bqyN3r1mYDgF0aG03tZB7sMOBuFLxbAKffV/2OPGYgOarAooOLwD1Vlk+HT6CmTdlFDJAj97KfKd/KAm3V0HxSgt9FavVRxYk+T25xHPIynUgMEnwJtkOCwhQ1evf62Z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCSSuZVJbE3S9PS+bbvM7/8aYoR9WAcLbD+n2iNp+eM=;
 b=MoJjw9hx2p3Ifx1ho+PCQDI14W9ugyssrsqHUUk3U7WXKOH7QRsSTZq6KMzwezH2ujwSJ20z5cW33F24iQOSjBtzpGvfvzVX9G+iIrwrO4MqSU/bLyUSkrUfJxUnOKeQ0ZN7kC6Dg4gCadKEeUwoCCx8bV1CWE04X+wG6oftxyE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI6PR03MB8653.apcprd03.prod.outlook.com (2603:1096:4:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Thu, 21 Nov
 2024 03:50:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8158.017; Thu, 21 Nov 2024
 03:50:03 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "zillerbaer@gmx.de" <zillerbaer@gmx.de>,
	=?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] mediatek: dsi: Correct calculation formula of PHY
 Timing
Thread-Topic: [PATCH v2] mediatek: dsi: Correct calculation formula of PHY
 Timing
Thread-Index: AQHajIdSbZjcHXFFMUWKfmXDcbZSALKb0DuAgCanmQA=
Date: Thu, 21 Nov 2024 03:50:02 +0000
Message-ID: <4b9e27b50417d60eb32cd0ec782778f652656909.camel@mediatek.com>
References: <20240412031208.30688-1-shuijing.li@mediatek.com>
	 <20241027143219.56e7b4d0@schleppi.lan>
In-Reply-To: <20241027143219.56e7b4d0@schleppi.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI6PR03MB8653:EE_
x-ms-office365-filtering-correlation-id: f76dcce7-2a3a-427a-7ae0-08dd09df9482
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?akd6MzBhOTdQekNmblJ5bWwxN1NxWkpvVm5oRWZyUXM1c2NMekVRTnlwNDNk?=
 =?utf-8?B?TDZnamsvTGFFeXoxaWtJclFnd0p4amxCM1NXS041SkM2cDU3UWtXRGNkR3ND?=
 =?utf-8?B?WllLTE5lNk9LSmpFbXRsSGQ0UHFnb09RNWViMWt3RnlLVTJtYmo3L1N1TkZL?=
 =?utf-8?B?WGsvSENaaDNGd3RheXFKaUY3Q2dQV1RITm5CUnpwMW5UcXdoWTI1TlpwUEFs?=
 =?utf-8?B?ZlVRQXljVjZrYmJTT0JLcldndVpxd05GblNVbEprNERYVzZjeFFVNmhRcTZC?=
 =?utf-8?B?MGRuZ01XU01aMlVpUUgyNjArUWo2REZXSWY3SXNQNm5EUTFwYjJyaVNQbVpY?=
 =?utf-8?B?VFJwQ1lWS1dTS2ZhbmhqVUxYZU8wSk9Fc1MxeHowcEFxUU53T1pCMEtZa3Z5?=
 =?utf-8?B?WFhtdW9qYjRMWE8ycEFuaW54ZDBOUEdEcmVwaGpkcnRvTjNJN0VTZnpPeXJV?=
 =?utf-8?B?YStjZUFIR0s3RUFCSjdDRktiUkxhV0gzWVpoMEFlVEJZbEJJZk1zVnNHSUdv?=
 =?utf-8?B?ZVlqYjZCcTUrMjZVSGVYQXB1b3JHU0RoVWxydEpFQTBUejBFZG1WZ1BKUFpv?=
 =?utf-8?B?R3ZSa3ViSmVhRlQyNEtuSGxPVkZ5cllja2VGZndCVWxNbnRWMUI0OXo1ZTls?=
 =?utf-8?B?d1U1bFRZMzNPeDByN05JRzViRC9nV0xxbmxJNDFHd0FxSDZSQWNTYkRNSHNs?=
 =?utf-8?B?akNPMDNDQ0JXTXQ5ZjcwZWpEbWhWdnJnUUhCenoreTVZTGF5VFRTRUYxZ2VK?=
 =?utf-8?B?aXFjWjNwUy9DdGFVMFBycjRPS0NBZGVKQWx1KzdyTm9WNFk0T1lHaUpZcHEx?=
 =?utf-8?B?NHhoYlRnYy9vemxUWGhmejJmWGFoRXI2ZVJXa1dNZS9zVitzd081aUJmK3VB?=
 =?utf-8?B?N0FLM003U1ROUXZLUzlhbEZKaTJKRlZjMjFtdGxHakFidjNVR09WWU91TXlT?=
 =?utf-8?B?c2g0bnFQcktQKzNSWkF4VHNFUGlEdEtXRG9kVWFaRXI1UVdzWnRJUW9pcTdq?=
 =?utf-8?B?STc0RXlwamZzeGluYXQzY3ZOcGd5MTlodWVjT3BlMUlnc0t0eUdrSWdzcG56?=
 =?utf-8?B?QjNGTitFZGxiT1p3eFYxenFLNHk4Z2k2SzkwUXNjczNKUGljY0xYMFhRK3JO?=
 =?utf-8?B?Q0plbWoyekJFc2JwTVp3Ky80dVlLSmxOZGpEbVNDRnlwMFJ3VnFzU3BvbVBR?=
 =?utf-8?B?Q0dsYlJjRmpUbnNNODFGd0hjQXd0OGtkeVU3MDhlUUZZYXFnUGJvdWM3dm42?=
 =?utf-8?B?a0ZyQzIvVWJCcG4wWWpkTGJkZk9RMGo5V2xPSXp2cy9MV1I1RVRmTStKcjJL?=
 =?utf-8?B?NmNEaEVsMjVGOFVqQW9nUEVBSWZNQ1FMUmRsVFBCbWViY3FSdGRiU2ZsN0Uz?=
 =?utf-8?B?dFBLNHhXMTVLRGlOTWtDNTVkU1JnVGNWMmRtU29JMXNrU2ZabWZ6UnU5WFpy?=
 =?utf-8?B?SG5aV0N1U0tkK2VGWVJhSGh3c1hxR3ZQU1NXTG8wTUNJcWFuQS9BNER6MXBU?=
 =?utf-8?B?TThScXBQelQ2R25DYVBiTjRLcTkrQngyMUtjN0ZZZ0w0czZVODkxWFpyT1Fp?=
 =?utf-8?B?UVRsOEdMcUhOeTI3TFU4Zm8rRnFRQjdxQ0tUeVNpSzRNOW9lSWhnRWtXRVUy?=
 =?utf-8?B?NmtidkFlN2lDTFZoS2x6ZWZNWEVDTDE3OVUvSzhpTWhzN0hMOUdsUnBpUnJI?=
 =?utf-8?B?cmtIS3Q0U0YwTlF0aGJkTk5yMDRWcC9jb0FUdFhNaWRmS2R3OFFTQzVKL0FV?=
 =?utf-8?B?eW1pWHZwUjhqU0gwY2R4Q095ZEdoYkJBQWhOZDB6OGtJQjhodU94ZGRoaDRV?=
 =?utf-8?B?QktKa1lqMUI1bWZlN2ZwSDlZMmhpbjdiWWZSdkw1SE5QZ2RjbkdkQnV3MXM4?=
 =?utf-8?Q?gVUWgwgO/H73b?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDBWY3lyT2lDclZIRHJDSEJYOE5XaHp1emxPVllzb045ZnR1T2xoMEZRYy9l?=
 =?utf-8?B?a1BsVlNTekNDcFgyaTkrakdQS2cvNWdHNktpdnZPSFlnN0E4OFA5SmxlbzJ1?=
 =?utf-8?B?LzhBMVhjYWR2eHU1RXgva2QreVIrTmlIa3h2L0lpMmV1TnZUZ1dvT2JUT2M5?=
 =?utf-8?B?WWgwcVdjSmt6c3RXU0Jnb3Z1bU5QZFdvam5zK1oxR1B3UEIrNUhuSjNTclhh?=
 =?utf-8?B?ODV3SFlWcDRvSjFraWJweTVVckxZN3FlSnVqQlVoV1diTVB6RjU3WmlqNGRo?=
 =?utf-8?B?L2lsNEJsYWI5ZTNrbzZjUWxPamxUTUdidEpDQWlFd1hZZnFzMTlyNklxWDVa?=
 =?utf-8?B?RlFkRTZJNCs2MGxIK1cvcjAwYmtNUjRUYnpWbHdKeFoyMk1VcWNIRjVyM3lR?=
 =?utf-8?B?U0hJMGJtTHltRHljT2h6MUk2ZGJ3eDBuQ2dZTFlIcnhlUTM3R0cyekt1UDE1?=
 =?utf-8?B?VUR5dTRuTktOZGdJVGcrZm5vTXYvNUo1Yy9nSUEybVlZY3ZwRVdBRUNROWlE?=
 =?utf-8?B?OGszNDVSL2IySnJhclZaMGJhVDU3eHIrZnRGSmF2T3p5U295UWVTZWJuWk9F?=
 =?utf-8?B?WVNLTjlhb3VZOWw3WGwxYlhra1NMbk56cm1YRXpVdnlGamwybS9KTThYQVZI?=
 =?utf-8?B?SGF4T0Y1ZlpFTFRTbHFjdElsanhINVR2R0NaenA4emVKQUZzNTZVU1lrVWVy?=
 =?utf-8?B?K2RSaThTUjJyOFQ5SVZOdG10NWdtVis2bzE4T2J3T1l3bVNmSGwveHE2a3R0?=
 =?utf-8?B?cTVWSWE3WTMrT2RPOHBzRXZOYnBTNnY3cEhTTWVCMjNaVXBvamNHQU14TGFX?=
 =?utf-8?B?TWlBcHBqdlFYQXVDdkNjeXh4S0F6cURnYlIwMFE1Z2pxZG1JOU5RbVRkYlVI?=
 =?utf-8?B?ZXJwdmx5c3dCRHNzUmh0ZS9uU09paHU4bnoxbzhhc1lFNDVVUXl5VElpVlRL?=
 =?utf-8?B?aDZndmhuQ0ZUYkhzeDZaYWhFR3ZOZTVJWUlSQ0IyaTVuTkRqa0Z2bWJvOW4r?=
 =?utf-8?B?Z2xSL1RsaFdxa2VDdUo4SWJEaDBJSElQYW1XRyt5SFJaWXlBYWZQTUwzdnpE?=
 =?utf-8?B?Sk1NUHdmS1JBSjFCaitXcnNrbEw2M0d0MnBrVmpBaDY5dG5EQUcxRnlNVGhz?=
 =?utf-8?B?SERkVmljV0EwWnAwclRWL01KN3htdGxwWC9wbmdjNHEvajZyaHlYT3B2L3Bi?=
 =?utf-8?B?dEtEMjhmSzBOK1NJUmZ5aWM4UTNjODBiVzBHdWxmNFpIY1NYZzF3VDFPcXRt?=
 =?utf-8?B?WEpjNXc1OGVkakwwSk1xd1NDSWlKSStseXREcS9MVTd2aVFndEE4a0RaOURS?=
 =?utf-8?B?cUZZVnJzS3ZpTzNYRm1uMmZ4RElOMHU0QlpGSTlsZ1dwTVJLTFpxaXVrbzNn?=
 =?utf-8?B?QWZXYlVHKzdZTzYxWVh4Y1Q2RGNNbzNPY0ZZOE9kUGZkRnpvTCtSVUhUd1JQ?=
 =?utf-8?B?Ui9rUFlJeEVpbG8xcUZFakZqS0xZYmRuaktoMGpLMElYbGtGekNGeXROYjBF?=
 =?utf-8?B?RHJpbHgzU2dKTHE3cVBRZXQ4ektYRkEwalJ6WEQxNzNsVGlhV3R4dkxRYUQy?=
 =?utf-8?B?NnF0VVk0MXgvd0ZNcWsyTnRWSmJOeGcvRHZkS1lyY3paMHRHeklrYytSeXUy?=
 =?utf-8?B?S0J3azMyU05UV1I4ZSttS2k3cDFVcGVUb3o5Z0g1Z2VXdE9McTdXNXY4UGdI?=
 =?utf-8?B?bFBiUlM0Zk5RSUdDZHJhOEZyaXh2R0xZdzRnTFVNRGdNekNpQlBEOTVGSFVh?=
 =?utf-8?B?L2hFbXM5WTV6ZFM0MDZveEFmMUhaL0U0VEZyUVN3VzRvVDRkdktJZzFhSGdy?=
 =?utf-8?B?SW9PbUp1aG52blE0TW10YzRFN0U1dGhEb0VHazNyVzRiMEFXL0lSaFdSV1lQ?=
 =?utf-8?B?WEJSQkJHK09OUEpYckk0NER3cUhSbkdxeDFGOWR6OUNRd09tN3NVZ3FZemUx?=
 =?utf-8?B?OWtKbzZybFBoczRoeVhHWEdCM2ZWc3N3TjlCdExIUXZxSDQxYWFLM2RtQnA2?=
 =?utf-8?B?SjByc1BFeU4yaVczZTNuQnJIMk54WkhMTzkzS3VBVzRGQ1pNbjEvYkNYWWpj?=
 =?utf-8?B?N0QvL0llNWZSUk13aUVGNXB2SStZTE1EYW5CRDdqZGZuallNVnMwY2h0Q2xy?=
 =?utf-8?Q?6kZNrVrTlpyp58uvr4H8Qpkwj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A40E729B22DC449995333BF05F73C8A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76dcce7-2a3a-427a-7ae0-08dd09df9482
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 03:50:02.9901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Im8UvRccTQqCtUCK5T784xczUOm0oHivtAmtIcL67hmP83gqo+oo7jpMenbyajf5TuJJpE4P/MzNhkah2GCGhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8653

SGksIFNodWlqaW5nOg0KDQpPbiBTdW4sIDIwMjQtMTAtMjcgYXQgMTQ6MzIgKzAxMDAsIEplbnMg
WmlsbGVyIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IEFtIEZyaSwgMTIgQXByIDIwMjQgMTE6MTE6Mzkg
KzA4MDANCj4gc2NocmllYiBTaHVpamluZyBMaSA8c2h1aWppbmcubGlAbWVkaWF0ZWsuY29tPjoN
Cj4gDQo+ID4gVGhpcyBwYXRjaCBjb3JyZWN0IGNhbGN1bGF0aW9uIGZvcm11bGEgb2YgUEhZIHRp
bWluZy4NCj4gPiBUaGUgc3BlYyBkZWZpbmUgSFMtUFJFUEFSRSBzaG91bGQgYmUgZnJvbSA0MG5z
KzQqVUkoNDRucykgdG8NCj4gPiA4NW5zKzYqVUkoOTFucykuIEJ1dCBjdXJyZW50IGR1cmF0aW9u
IGlzIDg4bnMgYW5kIGlzIG5lYXIgdGhlDQo+ID4gYm91bmRhcnkuIFNvIHRoaXMgcGF0Y2ggbWFr
ZSB0aGUgZHVyYXRpb24gdG8gNjRucyBzbyBpdCBpcyBuZWFyIHRoZQ0KPiA+IHNhZmUgcmFuZ2Uu
DQo+IA0KPiBIaSBTaHVpamluZywNCj4gDQo+IHdpdGggdGhpcyBwYXRjaCB0aGUgcGFuZWwgaW4g
dGhlIFRlbnRhY3J1ZWwgQVNVUyBDaHJvbWVib29rIENNMTQNCj4gKENNMTQwMkYpIGZsaWNrZXJz
LiBUaGVyZSBhcmUgMSBvciAyIHRpbWVzIHBlciBzZWNvbmQgYSBibGFjayBwYW5lbC4NCj4gU3Rh
YmxlIEtlcm5lbCA2LjExLjUgYW5kIG1haW5saW5lIDYuMTItcmM0IHdvcmtzIG9ubHkgd2hlbiBJ
IHJldmVyc2UNCj4gdGhpcyBwYXRjaC4gVGhlcmUncyBhIGJ1ZyBpbnNpZGUuIENhbiB5b3UgcGxl
YXNlIGNoZWNrIHRoYXQ/DQoNClBsZWFzZSBoZWxwIEplbnMgdG8gZml4IHRoaXMgYnVnLg0KT3Ro
ZXJ3aXNlLCBJJ3ZlIHRvIHJldmVydCB0aGlzIHBhdGNoLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAN
Cj4gQmVzdCByZWdhcmRzDQo+IEplbnMNCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU2h1
aWppbmcgTGkgPHNodWlqaW5nLmxpQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2Vz
IGluIHYyOg0KPiA+IEFkZCBhIGNvbW1pdCB0byBkZXNjcmliZSB0aGUgaW1wcm92ZW1lbnRzIHRv
IHRoaXMgcGF0Y2ggaW4gZGV0YWlsLA0KPiA+IHBlciBzdWdnZXN0aW9uIGZyb21lIHByZXZpb3Vz
IHRocmVhZDoNCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjQwMzE1MDcyOTQ1
LjE5NTAyLTEtc2h1aWppbmcubGlAbWVkaWF0ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3IW5B
M0F1dXEyVzNxeWYzYThPdHpEdkxJQ05feGZxNXpVb3pwXy1XbzdRNGpSOWw2cUtseGlXTkM0VFpQ
WFFhOFcwOHZlV2hva0h5UnJ2Q29kY3BnJA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RzaS5jIHwgMzMNCj4gPiArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0gMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE2DQo+ID4gZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNp
LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgaW5kZXggYTJmZGZj
OGRkYjE1Li5kMWJkN2Q2NzE4ODANCj4gPiAxMDA2NDQgLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kc2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHNpLmMNCj4gPiBAQCAtMjM1LDIyICsyMzUsMjMgQEAgc3RhdGljIHZvaWQgbXRrX2RzaV9waHlf
dGltY29uZmlnKHN0cnVjdA0KPiA+IG10a19kc2kgKmRzaSkgdTMyIGRhdGFfcmF0ZV9taHogPSBE
SVZfUk9VTkRfVVAoZHNpLT5kYXRhX3JhdGUsDQo+ID4gMTAwMDAwMCk7IHN0cnVjdCBtdGtfcGh5
X3RpbWluZyAqdGltaW5nID0gJmRzaS0+cGh5X3RpbWluZzsNCj4gPiANCj4gPiAtICAgICB0aW1p
bmctPmxweCA9ICg2MCAqIGRhdGFfcmF0ZV9taHogLyAoOCAqIDEwMDApKSArIDE7DQo+ID4gLSAg
ICAgdGltaW5nLT5kYV9oc19wcmVwYXJlID0gKDgwICogZGF0YV9yYXRlX21oeiArIDQgKiAxMDAw
KSAvDQo+ID4gODAwMDsNCj4gPiAtICAgICB0aW1pbmctPmRhX2hzX3plcm8gPSAoMTcwICogZGF0
YV9yYXRlX21oeiArIDEwICogMTAwMCkgLw0KPiA+IDgwMDAgKyAxIC0NCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICB0aW1pbmctPmRhX2hzX3ByZXBhcmU7DQo+ID4gLSAgICAgdGltaW5n
LT5kYV9oc190cmFpbCA9IHRpbWluZy0+ZGFfaHNfcHJlcGFyZSArIDE7DQo+ID4gLQ0KPiA+IC0g
ICAgIHRpbWluZy0+dGFfZ28gPSA0ICogdGltaW5nLT5scHggLSAyOw0KPiA+IC0gICAgIHRpbWlu
Zy0+dGFfc3VyZSA9IHRpbWluZy0+bHB4ICsgMjsNCj4gPiAtICAgICB0aW1pbmctPnRhX2dldCA9
IDQgKiB0aW1pbmctPmxweDsNCj4gPiAtICAgICB0aW1pbmctPmRhX2hzX2V4aXQgPSAyICogdGlt
aW5nLT5scHggKyAxOw0KPiA+IC0NCj4gPiAtICAgICB0aW1pbmctPmNsa19oc19wcmVwYXJlID0g
NzAgKiBkYXRhX3JhdGVfbWh6IC8gKDggKiAxMDAwKTsNCj4gPiAtICAgICB0aW1pbmctPmNsa19o
c19wb3N0ID0gdGltaW5nLT5jbGtfaHNfcHJlcGFyZSArIDg7DQo+ID4gLSAgICAgdGltaW5nLT5j
bGtfaHNfdHJhaWwgPSB0aW1pbmctPmNsa19oc19wcmVwYXJlOw0KPiA+IC0gICAgIHRpbWluZy0+
Y2xrX2hzX3plcm8gPSB0aW1pbmctPmNsa19oc190cmFpbCAqIDQ7DQo+ID4gLSAgICAgdGltaW5n
LT5jbGtfaHNfZXhpdCA9IDIgKiB0aW1pbmctPmNsa19oc190cmFpbDsNCj4gPiArICAgICB0aW1p
bmctPmxweCA9ICg4MCAqIGRhdGFfcmF0ZV9taHogLyAoOCAqIDEwMDApKSArIDE7DQo+ID4gKyAg
ICAgdGltaW5nLT5kYV9oc19wcmVwYXJlID0gKDU5ICogZGF0YV9yYXRlX21oeiArIDQgKiAxMDAw
KSAvDQo+ID4gODAwMCArIDE7DQo+ID4gKyAgICAgdGltaW5nLT5kYV9oc196ZXJvID0gKDE2MyAq
IGRhdGFfcmF0ZV9taHogKyAxMSAqIDEwMDApIC8NCj4gPiA4MDAwICsgMSAtDQo+ID4gKyAgICAg
ICAgICAgICB0aW1pbmctPmRhX2hzX3ByZXBhcmU7DQo+ID4gKyAgICAgdGltaW5nLT5kYV9oc190
cmFpbCA9ICg3OCAqIGRhdGFfcmF0ZV9taHogKyA3ICogMTAwMCkgLyA4MDAwDQo+ID4gKyAxOyAr
DQo+ID4gKyAgICAgdGltaW5nLT50YV9nbyA9IDQgKiB0aW1pbmctPmxweDsNCj4gPiArICAgICB0
aW1pbmctPnRhX3N1cmUgPSAzICogdGltaW5nLT5scHggLyAyOw0KPiA+ICsgICAgIHRpbWluZy0+
dGFfZ2V0ID0gNSAqIHRpbWluZy0+bHB4Ow0KPiA+ICsgICAgIHRpbWluZy0+ZGFfaHNfZXhpdCA9
ICgxMTggKiBkYXRhX3JhdGVfbWh6IC8gKDggKiAxMDAwKSkgKyAxOw0KPiA+ICsNCj4gPiArICAg
ICB0aW1pbmctPmNsa19oc19wcmVwYXJlID0gKDU3ICogZGF0YV9yYXRlX21oeiAvICg4ICogMTAw
MCkpICsNCj4gPiAxOw0KPiA+ICsgICAgIHRpbWluZy0+Y2xrX2hzX3Bvc3QgPSAoNjUgKiBkYXRh
X3JhdGVfbWh6ICsgNTMgKiAxMDAwKSAvDQo+ID4gODAwMCArIDE7DQo+ID4gKyAgICAgdGltaW5n
LT5jbGtfaHNfdHJhaWwgPSAoNzggKiBkYXRhX3JhdGVfbWh6ICsgNyAqIDEwMDApIC8NCj4gPiA4
MDAwICsgMTsNCj4gPiArICAgICB0aW1pbmctPmNsa19oc196ZXJvID0gKDMzMCAqIGRhdGFfcmF0
ZV9taHogLyAoOCAqIDEwMDApKSArIDENCj4gPiAtDQo+ID4gKyAgICAgICAgICAgICB0aW1pbmct
PmNsa19oc19wcmVwYXJlOw0KPiA+ICsgICAgIHRpbWluZy0+Y2xrX2hzX2V4aXQgPSAoMTE4ICog
ZGF0YV9yYXRlX21oeiAvICg4ICogMTAwMCkpICsgMTsNCj4gPiANCj4gPiAgICAgICB0aW1jb24w
ID0gdGltaW5nLT5scHggfCB0aW1pbmctPmRhX2hzX3ByZXBhcmUgPDwgOCB8DQo+ID4gICAgICAg
ICAgICAgICAgIHRpbWluZy0+ZGFfaHNfemVybyA8PCAxNiB8IHRpbWluZy0+ZGFfaHNfdHJhaWwg
PDwNCj4gPiAyNDsNCj4gDQo+IA0K

