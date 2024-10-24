Return-Path: <linux-kernel+bounces-379071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BF19AD941
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100091C210ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B325138DD1;
	Thu, 24 Oct 2024 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="h7ES7ASI";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PKEiDHDU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BD39AD6;
	Thu, 24 Oct 2024 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733365; cv=fail; b=PvaZ70a1Ov01CFM+0cr7i4N7f+yWElGHHWWmoyPaHglZifzqhdEo328ByUZGJHnDQCQEwKjqsAW0nvgQw9B2W+kxyQAxklo1Kapxxd9sxvYEOZk/Qh6WYlB1/a7CoZ8Uraa6CWcKYFqvWL+CxqE1l63Pepy7GSTLwChVHXXXPow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733365; c=relaxed/simple;
	bh=pUAI9FGyefxC72STvvyZg7fncmXCV3RrahHdZYFZP7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kAHScUJeRcu2CQmkjqGcsPVLgpFBqaNHX/pdaaI6SHS88quGYlK7mETC/rQ/NNR8ZS02AYvEVmKSPVWa1VZH69Qwl2aLKPcYMiFVDtxfPoRSACXeFWgtTP+N7oCZRDqQxs1XS2X8UGPaJRTZ2kEw1mbOUr5xTy8t1up29mT8rq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=h7ES7ASI; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=PKEiDHDU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 636feae091a711efb88477ffae1fc7a5-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pUAI9FGyefxC72STvvyZg7fncmXCV3RrahHdZYFZP7I=;
	b=h7ES7ASIja4NPtoSlcefGxGNIgYjGnN2Ki0BMlVmqeyPlT+xz2gy0iYOF/Ug9s0SAZhv6qeUmipzJIpgs5J0We6rAcsxr4JaGSaPrK5vz2oE2gh5KRQx5fdw77GccG+Ka3AA3TbxmZD3guGBGa5aLee7n70xddXv8BR3yG3w9wM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:3cfee6c3-1313-449c-84fd-ac3c8f79ddba,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:b0fcdc3,CLOUDID:56f3032e-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 636feae091a711efb88477ffae1fc7a5-20241024
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2068924048; Thu, 24 Oct 2024 09:29:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 24 Oct 2024 09:29:17 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 24 Oct 2024 09:29:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYzXN7Bvd7fXzdoEeYcAy8Uj8HJICOBoCNQxp2jyJ+rU2GfQWaVWxzDLOacfXEjgXe3cKV90mZIkfbmFGUve3cnszH4P5Gac/IuJ/jx6dekIgTXQxvNh01+xeplRjJlEno08ElzghjrQy/zV2pT3WgoSrGSMo2tgUwsUcPBnQLZptWC65mu+/1XdAHaNC5Fy0N4cfRLmI4gIyGk6d52DAfaS3bj44+oiWZavWAktewjomcGPji34lTq6rTsVh2Umsr1qYPKpff1IaFg1w7Kdh4thVfYiFEGgcn8//RIg0Yn3240M5XLWNXrZaLifoQTuzTVbxkcOBIdJjbLH7sbqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUAI9FGyefxC72STvvyZg7fncmXCV3RrahHdZYFZP7I=;
 b=VZ74sZ8imvoJglOhY/XumRHghFpqVy/k/mnG7MxOoUauaYdPOUq3uiiLQctqk4Gl50VeNKjCjTMGehtudpbltq0BjjXILeByypnNvI7+U6AzCpqO3IqJHeHrBvr0IVAPdoEMy/fD/5V7j85WY+SdKSoaL2Rrjv4frevDl0IOu4EA+/+lAwzlIy+nnsNH2uDCYcAvkjDWK9GnAxaTpKxHAJdRA8X65dPyKNwVnJtlPlcgezw8YNF+Fw0TxxMBisHM7nBTCCY1VK65+1wk7ecAzodg+EgjUl+EEfrlpNmG3hhH3e1Urc/P3OQ6n5zeQVOWvzPlXnmUO/7AnOqs+bGH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUAI9FGyefxC72STvvyZg7fncmXCV3RrahHdZYFZP7I=;
 b=PKEiDHDUbd/I8hVW+aCCTEzcvsGkufFgEsjKf6tCxBs95CK9uQmP6en1vlh/0Ci+xtNhG+sbO56yfyAHB+aiA5SgsvQJ5FKAahyCQEkifVP3upLZnWcRXHrCqK0/yMPZlQ6Vdb1ORNRVKdjLWC3/MFuS809CbdgzeoaMHgQFZVk=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by JH0PR03MB7655.apcprd03.prod.outlook.com (2603:1096:990:d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 01:29:13 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 01:29:13 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/4] memory: mtk-smi: mt8188: Add SMI clamp function
Thread-Topic: [PATCH 3/4] memory: mtk-smi: mt8188: Add SMI clamp function
Thread-Index: AQHa86RVJj9SPFvyWUOGEGKoNBEA6rIxafsAgGQXEQA=
Date: Thu, 24 Oct 2024 01:29:13 +0000
Message-ID: <cdbac20d7a49ff2fbd3e6d4f24ae441ffbe87f05.camel@mediatek.com>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
	 <20240821082845.11792-4-friday.yang@mediatek.com>
	 <25b487b7-63e0-402d-a0a2-ed9d03e82630@kernel.org>
In-Reply-To: <25b487b7-63e0-402d-a0a2-ed9d03e82630@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|JH0PR03MB7655:EE_
x-ms-office365-filtering-correlation-id: e3a83539-36d4-45be-1994-08dcf3cb445d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S2lZRlEzd3JLeEdEcmJZVmVzUnFwcElXWi9xOWRid0tRRG1pM2F0WWZiRUFj?=
 =?utf-8?B?ejU5WHJJdVhjdXZ1WFBWby9hR2lUZjIyWW50YTJnVTMxbTdDa2QyTnFEVFJw?=
 =?utf-8?B?L2RLMUdLQVRXMWsvcTlsMlhqWWlkdzE0Y20zZGh0Mm12Z0RzRHNyQk0vU2NM?=
 =?utf-8?B?T1VSZkF3dURReEI0djd4cEFtK1ZEWGdqTmZIbnlhMEJidDdOZ2VxWUZHZDZo?=
 =?utf-8?B?Tkg1Z0RUM1l3M0RRa09MV1JnOWFCa3ZabzVpVDcxMXBrY3AyenpxdkFTZWdE?=
 =?utf-8?B?YldvM3NZdjJuc3k5UDBBeWZlME80bnFtVmpqVFpQUlZ6c2ZiRDNMdjRXZ2JH?=
 =?utf-8?B?YmZnS0IwYVk2WDA2SFltT1FnQkJyS0xBWERiSkdVUllRMUhxblJ2ZEoyeHAw?=
 =?utf-8?B?aER2WjA4SEhBSnlUVzlkV3RRczBsS2tHeU1tbDNtb2NTUEs3c3pKWU9CQ3Er?=
 =?utf-8?B?OHhaOU11akFtY2ZYd1oyZ0tJTlFiM0lES2VWMzNoMlQ3SGc5UlowVk45WEpC?=
 =?utf-8?B?a21veGVMdzlWZ1dVeWxZSCtXbk5MY1o4MENEczJLYnRjTCsyRnMwZ1RQc0dx?=
 =?utf-8?B?OVBZSTk2c2p4SXNMZHBLWXpSdjZqWTBwQ0RIT3l5L2NvWThLV0lFeDBLV0lh?=
 =?utf-8?B?L1BFd2wxR3FzSnQ0TmRtQzdrdDRDVDZZangwSURKYmVJWm5OTysvWEtWcW5P?=
 =?utf-8?B?NzN2SFIrWVdXY0JLMXZ4Qm1mUUdZUFN4eHl2dDdwRkJqOENLYUpDSUllMjVh?=
 =?utf-8?B?aE93aE53TE1nbldiUm9IV3NnSExscENYV3BjTmFrTEVyM3dtNEthYmJUU0RT?=
 =?utf-8?B?YnNGWEdRaU83aEJ2SDZlM09NNTRweGFsaEVLTzdFK1ROc282TGVIRE1yb0pk?=
 =?utf-8?B?b1hkOXBlMWVoaGJvMCtPYlNxY2VWNjRyaTUzV0piMTRKSWJxRFdLd0tlVDdT?=
 =?utf-8?B?UGZQOHU4Q3JlN25CUHY4ZXl3dlhtd3FXY1BsSlJFVmovMXVVY3F5bEpZbC8x?=
 =?utf-8?B?dkZmMVEzOExYek1tQm1zMmpOczcwQjRpUDh2M3RLdnNCVENDRGdqN2tKbE9Y?=
 =?utf-8?B?Y0FyVUs5SmxqcmplTmdkaFdlRFdYUmtMSkpRSW5jNTNaVlRrVGcrUjk5SDQw?=
 =?utf-8?B?WVhGdmptQUovNUtXY0o5bEZYSjF6anNCVC9KSmxmMk1JN1h1MlhsQ1dCT1Bk?=
 =?utf-8?B?Zlhodk5lZk9iN1I4dnFhNUtqVG5UcEpuTjk0WWorb1owSU02TmwwSUFzd3I1?=
 =?utf-8?B?QWY2QmZ4TFE5dzNIMzNML1daNHl1T3EwWlA4ZWpaWjZRMDB3ZzUwOGIwQzR3?=
 =?utf-8?B?bm5SWk1tSjY5eXowaDlwdTR2SUdGSDZoczJsdmp5aFpNUllSNitsenBWNERI?=
 =?utf-8?B?YzJKWDM2WHZiS3oyT202dUVXZkx5OEkybnI4dytNc0tWc0xPWHZmcm5udlVJ?=
 =?utf-8?B?eUlTemN1RG83amZXcXA3T1RiQ1RMcFNnUmN2OFVqdGlaYWEzMGoyMlJ3MW1l?=
 =?utf-8?B?MDJnTzRqMzdhNEZIOTZNQU1pUS9QS0RFUzArVFcreTV4aUcrTVpMd2RINnFq?=
 =?utf-8?B?TS9nalVSTVQvczZ6NHFybWVuUlZnYTVTd2RabGJtSTdTK2ZTVWlIYnZZUDFO?=
 =?utf-8?B?d1NYQytDa2RlNWEvTVlPV2hEb3MzaWVCcDFxZWh3Tm9vc3J0VDg4cHJZNTZJ?=
 =?utf-8?B?b1lMWHorKzNvRk5JSHpXd2NYK1dMUVZsSWgvNUtHeTQ5MlRwRTI3SEhrd0g2?=
 =?utf-8?B?cW5XUzhNcnRFMjRFelN1NkhyRGdFVHFEWGU5SVoycURCL01NbzlrWTl3RHF4?=
 =?utf-8?Q?E4LyadZpETyoCEhWsFmHfNauKOHsY+FFK2ils=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTdZUDNSN0NKMXkzYUxpY2dwWUdZTUI2T3hhL1FET0lVQmN2dHlGWWpnTHMy?=
 =?utf-8?B?N3JzMmp2b0svUWFZbUZiRkgxRXZlOGpSWUJMYVNHZWdMTTNlVUJwOWpHS21S?=
 =?utf-8?B?UlJiWlZmbk1CSlZRc1FtMW9EZU5SUHh5UEVoeWc4SDUzZm5nQURRZlRYVmlF?=
 =?utf-8?B?dUZVa2EydEtaeHRvZlJaV2RLN0psc2ViTGhOZ3JXVW9aZU5BNDFleW5SRk9r?=
 =?utf-8?B?QjZTVnNNSHpyOEdPTFZwUG8yMllKRnZuVldFa3oxVmdxZUNYTGg2TVRXK0lE?=
 =?utf-8?B?Y1prcUg0bGlxVkI1K0tOWUhsQzRuMENCMnFXeDlFRG15S0NlSUd3c1VDQjJ5?=
 =?utf-8?B?MHNJQVBEdkttUUFZblJmU28xNkhrSS9PTEhnU1hkQ1ZRekRNcGZwZ0c3RDlw?=
 =?utf-8?B?TmdMWVpFZmNHQjlDaWpjdnBMOUtoWmNQbTlyQlQ3OENlWDNQNVNGQjF2cDRE?=
 =?utf-8?B?UFRhcHFSK3pSKzl4WUxIZFNMWE9zYXZlUXpnWDAzdjNmSlZBSHRpQWIzYVNv?=
 =?utf-8?B?a0FaY2Y2WmdFcGtDUlh3V251Z1ErZStINFlNb1VpdXJmdkZGQW1qbFRNelVF?=
 =?utf-8?B?dEtSZ3BQL3lzeWthak8veW1IQ1VieXRTVldKdStLL2p2OFJlR2hSZW0zTTBm?=
 =?utf-8?B?L0dkNnlrK2FnQk9DRnlSOFNKWDZSU2dZMzMweURRMzNiVndRK2w5V2hNaE4y?=
 =?utf-8?B?cHlxUmFtSCtHMFpkVEJUTnZndTlFMmp4ejNoaGdJUkltU3l1RTVJU0t0S1Bx?=
 =?utf-8?B?MWF3YlF3Y094OWxNV3dndkVpcEJ2UmhhRWc5S3UyeVNCd0FySEo4MkJxMWV3?=
 =?utf-8?B?SWZocndKU2lzTXcyNHR0U0JnZ2hKTG94TGZ5NHZjcG9mbWxZRDI2Nm5pV2lP?=
 =?utf-8?B?WDMwL01WQk04Y1VRaTF4eXRBWHlYRGhjQmlrbHFLZ2gxNDNROHJ3STZuaU5J?=
 =?utf-8?B?YlVVbmZOa0g4YjI1cmRwNGErNXZ6Z1J6aEhlRUJKaUFSY2owQjRrZG1KT0hN?=
 =?utf-8?B?V0xFL1FyRktoMmprWWxTZGVRTGo2SzkzdWp6bVpnV21nSjZDRkl0U2g2T0Jk?=
 =?utf-8?B?MDluRUlUenZiY1dEbTJFSXhFZUJiM09mQ0FvdjhjWEtqaTVYbndzU1dLYlZI?=
 =?utf-8?B?V3FLakRDazJRV2U0Z3VyeTNZSmNSS2l3eFJlU2E1TTZPVXZ3d1hVcnU1MnFZ?=
 =?utf-8?B?V0dCaTQrS3pQSHQ5bGc5c3B6ME95UW1UQWp2eVNISTA1WktFQVBQSG94VWRN?=
 =?utf-8?B?bkJ2NzFpQXB5Qi9Wa01FZW1MRmlmOStnZUIyYUw3aklMekgyWnowMVlhTEpj?=
 =?utf-8?B?T3RXWTZiOTdTVTM5RmV1ZVdDU21jQnlOb2RyYzcxYmlRQ0VKd3czd0lBODBW?=
 =?utf-8?B?NEVUWmtKcUNaQ0hsYXdUVlJPekRMK0FVN3R1SkUxU3FJNUU5ZmZXY3BvaEVL?=
 =?utf-8?B?V01QQmJuUEh4Yk5pdm4zRkZSazNvcG56RUxiV3RBY3drckNHUWZadmcwVzBN?=
 =?utf-8?B?ZkdBeDhvUTUra09ydWZsYjI5L2xLeGRpeG1wMWRMZHl6QVl5elNjOFhjeERx?=
 =?utf-8?B?Q1Q3ZU9qcVlkNEFPSXRHSlVtNGIwOTZUcThWdUhTTlA2UFVJaTU0aDBEQ3Bm?=
 =?utf-8?B?dktlUVM3bzAyQ2ROVktiMnNjcTFGdWFwNGtCWmx2dHRFRUdSaFBQOHJycEtl?=
 =?utf-8?B?ZVhKMU9WSDNXbm9EUHRnU056QlhUSDMzdzlvT29QYVA2b1p3dFlVOWRIZFJO?=
 =?utf-8?B?UndTVkxQSTVmTDh4N0IvTlo3dXlqbUZOVnloQVgxTEdyVGNoRmxDME16MDVC?=
 =?utf-8?B?RTBkTmFQMVZhWGJ0STVqZEFMb0NwaUpadkloUGJmbGxjSHQrZVhvd3o3bU1W?=
 =?utf-8?B?L1l0bldPWndITFd3UFNtQ05DNTdsVlROaXQvYUp2UHpNbjAzS3c5OFRnQW56?=
 =?utf-8?B?eUhWaHQxcnRSQWJhMTV1TEd0WVQxQ0dTVm1HV2pVQmxYTm16OXdsS2ZGaHk3?=
 =?utf-8?B?ckcwYTVXVHVvZEYxM1N0TFgxd0d6UmNJcFdLMHNTdmRnRTIyc2ZqR0kvOExp?=
 =?utf-8?B?cisyUHV5MERGMm1BcnB5dE1XakxFTkJDSVRiOTJJSEQ2bms1RTNCdndFemFX?=
 =?utf-8?B?K0JmTTBMTmV1OVhxSVk1alBxVkdsOHkvc3RmbXpQT3FRYTFoMWhjeE9Ncndy?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98D30E432681F7429652047CF3BB59DF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a83539-36d4-45be-1994-08dcf3cb445d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 01:29:13.0499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6nn4QIkD2j08lpWDIJGbd+X91fWFULZ4JtkMb2vrX9awfmymDNawsryO4DSSYEocqG2EA2OEf9TIsJ0yTY77Qvhev0BTMhcxgiT6EcE9kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7655

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDExOjAwICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDIxLzA4LzIwMjQgMTA6MjYsIGZyaWRheS55YW5nIHdy
b3RlOg0KPiA+IEluIG9yZGVyIHRvIGF2b2lkIGhhbmRsaW5nIGdsaXRjaCBzaWduYWwgd2hlbiBN
VENNT1Mgb24vb2ZmLCBTTUkNCj4gbmVlZA0KPiA+IGNsYW1wIGFuZCByZXNldCBvcGVyYXRpb24u
IFBhcnNlIHBvd2VyIHJlc2V0IHNldHRpbmdzIGZvciBMQVJCcw0KPiB3aGljaA0KPiA+IG5lZWQg
dG8gcmVzZXQuIFJlZ2lzdGVyIGdlbnBkIGNhbGxiYWNrIGZvciBTTUkgTEFSQnMgYW5kIGFwcGx5
DQo+IHJlc2V0DQo+ID4gb3BlcmF0aW9ucyBpbiB0aGUgY2FsbGJhY2suDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogZnJpZGF5LnlhbmcgPGZyaWRheS55YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jIHwgMTQ4DQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQ2IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+IA0KPiAuLi4NCj4gDQo+ID4gKw0KPiA+
ICtzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wYXJzZV9yZXNldF9pbmZvKHN0cnVjdCBtdGtfc21p
X2xhcmINCj4gKmxhcmIpDQo+ID4gK3sNCj4gPiArc3RydWN0IGRldmljZV9ub2RlICpyZXNldF9u
b2RlOw0KPiA+ICtzdHJ1Y3QgZGV2aWNlICpkZXYgPSBsYXJiLT5kZXY7DQo+ID4gK2ludCByZXQ7
DQo+ID4gKw0KPiA+ICsvKiBvbmx5IGxhcmIgd2l0aCAicmVzZXRzIiBuZWVkIHRvIGdldCByZXNl
dCBzZXR0aW5nICovDQo+ID4gK3Jlc2V0X25vZGUgPSBvZl9wYXJzZV9waGFuZGxlKGRldi0+b2Zf
bm9kZSwgInJlc2V0cyIsIDApOw0KPiANCj4gTm9wZSwgeW91IGRvIG5vdCBwYXJzZSByYXNldHMu
DQoNCjEuSWYgSSBuZWVkIHRvIHVzZSB0aGUgTGludXggcmVzZXQgY29udHJvbCBmcmFtZXdvcmss
ICdyZXNldHMnIGlzIHRoZQ0KcmVxdWlyZWQgcHJvcGVydHkuDQoyLidyZXNldC1uYW1lcycgZ2l2
ZSB0aGUgbGlzdCBvZiByZXNldCBzaWduYWwgbmFtZSBzdHJpbmdzIHNvcnRlZCBpbg0KdGhlIHNh
bWUgb3JkZXIgYXMgdGhlICdyZXNldHMnIHByb3BlcnR5LiBTTUkgZHJpdmVyIHdpbGwgdXNlICdy
ZXNldC0NCm5hbWVzJyB0byBtYXRjaCByZXNldCBzaWduYWwgbmFtZXMgd2l0aCByZXNldCBzcGVj
aWZpZXJzLg0KMy5Ob3QgYWxsIFNNSSBsYXJicyBuZWVkIHRvIGFwcGx5IHJlc2V0IG9wZXJhdGlv
bnMsIG9ubHkgU01JIGxhcmJzDQp3aGljaCBtYXkgaGF2ZSBidXMgZ2xpdGNoIGlzc3VlcyBuZWVk
IHRoaXMuIEp1c3QgdG8gY29uZmlybSBpZiB0aGlzDQpsYXJiIHN1cHBvcnQgcmVzZXQgZnVuY3Rp
b24uDQoNCj4gDQo+ID4gK2lmICghcmVzZXRfbm9kZSkNCj4gPiArcmV0dXJuIDA7DQo+ID4gK29m
X25vZGVfcHV0KHJlc2V0X25vZGUpOw0KPiA+ICsNCj4gPiArbGFyYi0+cnN0X2NvbiA9IGRldm1f
cmVzZXRfY29udHJvbF9nZXQoZGV2LCAibGFyYl9yc3QiKTsNCj4gDQo+IFdoZXJlIGFyZSB0aGUg
YmluZGluZ3M/IFdoeSBkbyB5b3UgYWRkIHVuZG9jdW1lbnRlZCBwcm9wZXJ0aWVzPyBIb3cNCj4g
cG9zc2libGUgdGhpcyBwYXNzZXMgZHRic19jaGVjaz8/Pw0KPiANCg0KVGhpcyBpcyBub3QgdGhl
IG5ldyBhZGRlZCBwcm9wZXJ0eSBpbiBTTUkgbGFyYiBEVCBub2RlLg0KSXQgaXMgdGhlIHJlc2V0
IHNpZ25hbCBuYW1lIHdoaWNoIGlzIGluY2x1ZWQgaW4gJ3Jlc2V0LW5hbWVzJy4NCkp1c3QgbGlr
ZSB0aGlzOg0KDQpyZXNldHMgPSA8JmltZ3N5czFfZGlwX25yX3JzdCBNVDgxODhfU0lNX1JTVF9M
QVJCMTU+Ow0KcmVzZXQtbmFtZSA9ICdsYXJiX3JzdCc7DQoNCk1heWJlIEkgY2FuIGFkZCB0aGlz
IG5hbWUgdG8gdGhlICdyZXNldC1uYW1lJyBwcm9wZXJ0eSBiaW5kaW5nDQpkZXNjcmlwdGlvbiwg
bGlrZSB0aGlzLCBpcyB0aGlzIGNsZWFyIGZvciB5b3U/DQoNCnJlc2V0LW5hbWU6DQogICAgY29u
c3Q6IGxhcmJfcnN0DQogICAgZGVzY3JpcHRpb246IHRoZSBuYW1lIG9mIHJlc2V0IHNpZ25hbC4g
U01JIGRyaXZlciBuZWVkIHRvIG9idGFpbiAJCQ0KIHRoZSByZXNldCBjb250cm9sbGVyIGJhc2Vk
IG9uIHRoaXMuDQoNCj4gDQo+ID4gK2lmIChJU19FUlIobGFyYi0+cnN0X2NvbikpDQo+ID4gK3Jl
dHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihsYXJiLT5yc3RfY29uKSwNCj4gPiArICAg
ICAiY2Fubm90IGdldCBsYXJiIHJlc2V0IGNvbnRyb2xsZXJcbiIpOw0KPiA+ICsNCj4gPiArbGFy
Yi0+bmIubm90aWZpZXJfY2FsbCA9IG10a19zbWlfZ2VucGRfY2FsbGJhY2s7DQo+ID4gK3JldCA9
IGRldl9wbV9nZW5wZF9hZGRfbm90aWZpZXIoZGV2LCAmbGFyYi0+bmIpOw0KPiA+ICtpZiAocmV0
KSB7DQo+ID4gK2Rldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFkZCBnZW5wZCBjYWxsYmFjayAlZFxu
IiwgcmV0KTsNCj4gPiArcmV0dXJuIC1FSU5WQUw7DQo+ID4gK30NCj4gPiArDQo+ID4gK3JldHVy
biAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICB7DQo+ID4gIHN0cnVjdCBtdGtfc21p
X2xhcmIgKmxhcmI7DQo+ID4gQEAgLTUzOCw2ICs2NjIsNyBAQCBzdGF0aWMgaW50IG10a19zbWlf
bGFyYl9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICBpZiAoIWxh
cmIpDQo+ID4gIHJldHVybiAtRU5PTUVNOw0KPiA+ICANCj4gPiArbGFyYi0+ZGV2ID0gZGV2Ow0K
PiA+ICBsYXJiLT5sYXJiX2dlbiA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiA+
ICBsYXJiLT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0K
PiA+ICBpZiAoSVNfRVJSKGxhcmItPmJhc2UpKQ0KPiA+IEBAIC01NTQsMTUgKzY3OSwyOSBAQCBz
dGF0aWMgaW50IG10a19zbWlfbGFyYl9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ICBpZiAocmV0IDwgMCkNCj4gPiAgcmV0dXJuIHJldDsNCj4gPiAgDQo+ID4gLXBt
X3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ID4gKy8qIGZpbmQgc3ViIGNvbW1vbiB0byBjbGFtcCBs
YXJiIGZvciBJU1Agc29mdHdhcmUgcmVzZXQgKi8NCj4gPiArcmV0ID0gbXRrX3NtaV9sYXJiX3Bh
cnNlX2NsYW1wX2luZm8obGFyYik7DQo+ID4gK2lmIChyZXQpIHsNCj4gPiArZGV2X2VycihkZXYs
ICJGYWlsZWQgdG8gZ2V0IGNsYW1wIHNldHRpbmcgZm9yIGxhcmJcbiIpOw0KPiA+ICtnb3RvIGVy
cl9wbV9kaXNhYmxlOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtyZXQgPSBtdGtfc21pX2xhcmJfcGFy
c2VfcmVzZXRfaW5mbyhsYXJiKTsNCj4gPiAraWYgKHJldCkgew0KPiA+ICtkZXZfZXJyKGRldiwg
IkZhaWxlZCB0byBnZXQgcG93ZXIgc2V0dGluZyBmb3IgbGFyYlxuIik7DQo+ID4gK2dvdG8gZXJy
X3BtX2Rpc2FibGU7DQo+ID4gK30NCj4gPiArDQo+ID4gIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBk
ZXYsIGxhcmIpOw0KPiA+ICByZXQgPSBjb21wb25lbnRfYWRkKGRldiwgJm10a19zbWlfbGFyYl9j
b21wb25lbnRfb3BzKTsNCj4gPiAgaWYgKHJldCkNCj4gPiAgZ290byBlcnJfcG1fZGlzYWJsZTsN
Cj4gPiArDQo+ID4gK3BtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ID4gKw0KPiA+ICByZXR1cm4g
MDsNCj4gPiAgDQo+ID4gIGVycl9wbV9kaXNhYmxlOg0KPiA+IC1wbV9ydW50aW1lX2Rpc2FibGUo
ZGV2KTsNCj4gPiAgZGV2aWNlX2xpbmtfcmVtb3ZlKGRldiwgbGFyYi0+c21pX2NvbW1vbl9kZXYp
Ow0KPiANCj4gTGFiZWwgYXNscyBwbSBkaXNhYmxlLiBXaGVyZSBpcyB0aGUgcG0gZGlzYWJsZT8N
Cj4gDQoNClRoYW5rcywgSSB3aWxsIGZpeCBpdCB0byAnZXJyX2xpbmtfcmVtb3ZlJy4NCg0KPiA+
ICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gQEAgLTY4Niw2ICs4MjUsMTAgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfc21pX2NvbW1vbl9wbGF0DQo+IG10a19zbWlfY29tbW9uX210ODE4OF92
cHAgPSB7DQo+ID4gIC5pbml0ICAgICA9IG10a19zbWlfY29tbW9uX210ODE5NV9pbml0LA0KPiA+
ICB9Ow0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=

