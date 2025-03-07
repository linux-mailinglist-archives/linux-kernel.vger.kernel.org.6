Return-Path: <linux-kernel+bounces-550646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E0A56267
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18F37A1858
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1DE1A83FB;
	Fri,  7 Mar 2025 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DxfD3Ixl";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="lnxC8Q5P"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41801B0F23;
	Fri,  7 Mar 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335304; cv=fail; b=EjwJYIbKXI8bIppC/a6Eq0hHJPtpl3ye+JppC85XTf7jrV4vd2NDtuL1Ad8mdRFY25uf7kN6Rgnibz4qGxfcrZle501rzA+XUXN5s/fV1BZlqXFmQsdsxFjuagfdewsk6pz/1DwPygLiFGjEGdKTVQ7BbtJk5Xs+WqlwIPhgyLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335304; c=relaxed/simple;
	bh=9ADsXjPMdvXBDuN8+EZpArWqxmdLxg01Cr9Ayp2ILlc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gL5MbMO0JxKls4sCifW5zKQyZbAk73loS8fLUuw7nde3BLoSdGr34Gjf6rQMlyV0+CHI0GwZOjFoB51YVGeP02VbWsSaM3K3wZZuEk/H9BOskPuac+DHcV2hY/BtHjrcycpgdqFThNztwflRoSHg93124rkZbjjARjMPLtLKYZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DxfD3Ixl; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=lnxC8Q5P; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4179ae64fb2c11efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9ADsXjPMdvXBDuN8+EZpArWqxmdLxg01Cr9Ayp2ILlc=;
	b=DxfD3IxlncpR4D7jrAS5NEnZdZXQZM8iFNSzXSv/fBTlk029Kpy0zyknrUF3YcCVQa10DoAKKBwRGw9EZux/2A/DY/wyk7ccX7nTZYbV8YMII1Y4KycGojx9KVRUNfx4d1I/rWa/p0R/lF6hph44kK7NxuX/VLXCxA+OB3Sj1Zk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:04ea01f6-42ba-4a84-bfd6-1c004f3df89e,IP:0,UR
	L:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:12
X-CID-META: VersionHash:0ef645f,CLOUDID:e83f0bc6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4179ae64fb2c11efaae1fd9735fae912-20250307
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1339221992; Fri, 07 Mar 2025 16:14:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 16:14:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 16:14:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wh5991Lk8IsDyjOuFKIaY2XMasM2YS/SY5dCxYVS/pXwv4Jo9yy30qlQtvxAQ5ew/GQuGgOwU5O8FehUCVA4fkTXx7nhCuP/PQj7po4e8qVQOu+C1Fpsc4KnYseaVZoPFk0e4CyGES7b28lntyDw/Xl6YJPmbXdXZpJCL3zPXN3tlJ9fxyL1MwJ7T2VcpnqLPDg9k1QC1EGBeN6O2mXjLtkSgJgU/AAOCHOQGb6AybYBUbdtsPIlM2rc8Phqq9P8FtJ/GxZiQXSdzgSsWSDRywRdS+r/0NzKVCzKnCM9haz20xmMNS2Y23kvF0dc7h+VYD8Xy/XOI7UKtn2PBzlxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ADsXjPMdvXBDuN8+EZpArWqxmdLxg01Cr9Ayp2ILlc=;
 b=qCdnRoJN4vh5jOIzfz1w1NbeZvM8gO6uT90yXnoYj+tUaPd/8Yz/W+IviLGK5DgNfFzK2fArP6WFGpkOcHIpk7UAOWg4s3cwTNuyL6vdK69yRBVsjy7WU+Tr8c18amGd1F8hNOH269Q9qLQNeOWtmijBFuwwt/3zmZ3K9kkn/5qSUzNYN0Lbo4PA7qigHuoNCM4e7JAMlun6lKVuItTKZoUu2JostSSbAEIPds4SM3GeUVeVKaGvkhamJS/FH48toeks2oU0xnZlemOw05HheLCg6YW/eqczxaaawEqftErxu46o3Mexcim2mE1/TPA3vYs5+BamGw74/N9etr73RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ADsXjPMdvXBDuN8+EZpArWqxmdLxg01Cr9Ayp2ILlc=;
 b=lnxC8Q5PotOqxQ36eKliJ1cEVqxz3c7hTg82SD+mDBBv6B+fYVvIzVQCyuDj6VyPCFJO1pUpUcb3WiUYGlHzyV78fsBZwt86dkcpbfG5huDWiDEPYpT97BaqWmWWaQjvaZvyGRVgs6TtADd8RCMCvHgiNNuRjGtVZVy9abGTPjc=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by SEYPR03MB7397.apcprd03.prod.outlook.com (2603:1096:101:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 08:14:52 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 08:14:52 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"krzk@kernel.org" <krzk@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
Thread-Topic: [PATCH v4 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
Thread-Index: AQHbhDU04J68TaDqUUGrlWTkL0+oIbNWJ1CAgA/7o4CAAACugIABKuaAgAAHfYCAABORgA==
Date: Fri, 7 Mar 2025 08:14:52 +0000
Message-ID: <b57f3a308dde77b26474cda349f61315ded51930.camel@mediatek.com>
References: <20250221074846.14105-1-friday.yang@mediatek.com>
	 <20250221074846.14105-2-friday.yang@mediatek.com>
	 <0dcb2efd-6bbb-4701-960a-74930eb457e4@collabora.com>
	 <264f78c1067e363c69e146543ebb77dbedfbd181.camel@mediatek.com>
	 <463ca2df-a0ee-4b9e-a988-12f316ae7d1a@kernel.org>
	 <9305a4fd6829e5e2ae6c3247d11b9f47ed277f8b.camel@mediatek.com>
	 <8d90731b-4b5a-45a8-83d1-4351044f59c7@kernel.org>
In-Reply-To: <8d90731b-4b5a-45a8-83d1-4351044f59c7@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|SEYPR03MB7397:EE_
x-ms-office365-filtering-correlation-id: 0f1c4fe6-81b9-45a0-f252-08dd5d502315
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a2JKOUZHYm9rOXJTaXhzVXpIUDI4K3E3a1JXaDdjT3laeDZFRHltUFdDM0NS?=
 =?utf-8?B?elNzOTBrdERoSlE0RkNSWVVtQ2FIekxuNHlxMXo5OXZEdkhsb3hEN29ZRWll?=
 =?utf-8?B?UUtienFtelNYT3VDSHV1UTRmUmlLWnhGK2RIblpqbmpoMWYrd1NHbVB3SC9K?=
 =?utf-8?B?SXNMUHIvc1Bmb0Y1T3AvcjVBaVFMZmlpbG1xa0Q5OXUxTEVZMEt2TGJ2aldW?=
 =?utf-8?B?Z3ROTEs2NmlTT1pOWnpRNG9EOWJwOCs3azdzSitwQjdVY0I1cjcvT3A2UEJn?=
 =?utf-8?B?MS9XS29DRTlEeTlKaUJ2anQ3M1J6RjNSc3FTOG9UKzIvZzE1MWZpcHltQWtW?=
 =?utf-8?B?MjZFRDhVSFVTSlYrQ0hLaWtqTFRuSE1KeXYzQ2xhNDl3QzduYkRQeExEVWZV?=
 =?utf-8?B?T2tnY3E3bHhiOThCVmkwZ2pRTDMwcHVFby9TUytaYXl3WEtORXZxZ3BuS0kr?=
 =?utf-8?B?TDIwdjlRLytleG5hSHhCaEhwTEV0Z1hvdHdOY0VaQ0ptdzRSZGp4bktjb3J0?=
 =?utf-8?B?aTc1TjY0T21zZFRMTmZPb2NjenJUU3BqTkRKeXc2ZVovZXFsbmd3am9qaDhI?=
 =?utf-8?B?MVYvcGdzZE4za0dCeVZHdUNWWjRhMHNVWEdZOE5QWVJhaVUvSUhqeUUrOHRD?=
 =?utf-8?B?cjlIRE9sbUNjdUp4VU54UjlXOGpTei9VMFBEMGdRUjhtb1FQalBXTzQvdkV1?=
 =?utf-8?B?RWtRdU1RZVRtTWk1VWY0RHhhdnRhYzY1VFZFaWJrTDZFMHRLZ3VDd0wwK0hH?=
 =?utf-8?B?OE1pY0x5K0hDbWhhaHphdE1ndU8zZVI1MU1GU0toN2Y3eXQvUnliYllNYWxF?=
 =?utf-8?B?TklzOUorSmYwMFNDc29xT0gxV1V5Rm1yWU5YTk1FcWlpVnpMVGVIUHpjMnJu?=
 =?utf-8?B?NFhsTVNtZW9WZFVLZE1NVVJlRlBCSUdOYUpOak1TL1V1RGFZL0hKZjdBR1JI?=
 =?utf-8?B?U05UbmhBN3VaajErcHR3UGJ2VnhsSkNNNllWT09XRnpPaUNMTDRQZi8zR3JG?=
 =?utf-8?B?UVJxMDZHMFFEaHJsamNiclZtSWxQaTRkOWNuaHNMSDJxMDhLRWE1QzZzZXdG?=
 =?utf-8?B?ZnJWRzBQaXVDUkVxVEcvN0poMVBMUlk0L1loVUpPbzY4cHZOUjdxTVlPOWEv?=
 =?utf-8?B?aDBVMUVuSjFZcHNqaGFKbjliYmRGVVZXa3c5UkpCNGEydm1tUVFDSmxucDdB?=
 =?utf-8?B?VXpMS3J5dXlvWXJCRzRiYlZMeGtZQmdUR0NianNIVmJqbFVwZTFCNmk0RXJ0?=
 =?utf-8?B?Mnl2UThpMWJqdUdCVmxtNld1OTJ4dDVWeHRpbndqUWlFd1lBRjhrc1BlREl6?=
 =?utf-8?B?aDlkdGlGby81bFhGOUJ4Rm05b1A1K1I2dVBDcnRsb2pRS1ZsN1Rxakp4aWpJ?=
 =?utf-8?B?bVplSVFJNUdvOWF5UUJsZHZVc01XYkVEaG5oRExpeXp2NFRmbEFibjRVc1hp?=
 =?utf-8?B?eHFNNE5BMTEySzlqQUVEOWxyVzgzYUFEOUg1STQ5dzBPMlFpSUIzRWpPRE5F?=
 =?utf-8?B?NlI2d1BEMkdSM2ptWlJtVGMvR1N4cC9hNHFueElLaGlJeGdtN2ZlNTE0OFNw?=
 =?utf-8?B?NVZ4UDh6VHFtckp1R3FuVHJUYUdNYVRLNkUvTm9WcGgwTlMweGhVVHFaTnZz?=
 =?utf-8?B?dkNsWTJ6WFloRU1iNnplOVpUSkRnYUxmSkg0S3VvQkZXazN5QWgyNXNuNXow?=
 =?utf-8?B?T1hkdVBadHRqTXB0ZGpzMklyaHpYa05oM2h4OHI1bFNxbGJpRnZPSktPWWVB?=
 =?utf-8?B?MWg1bEQ3cWd5ZkNzRVg1NDRaMWRXdnhTb1pYNEpmTkp5S1VKaW1vRTZEeHZt?=
 =?utf-8?B?SXJFWWl3dTYyZWZzNGRTYmlrdVZJNkJaUDNyMmJFZlZMUUsxRWZuQ24zdDEy?=
 =?utf-8?B?M1M3SGFlVEovZS9HQ256TXpFb2h2d1ppZ3VzMFJYaVZrZXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVdvSTJhOEswb2hHTk1oQng2djNzMzFpVk5ZMjVRZDE5cko2bXRYWnJrcldi?=
 =?utf-8?B?QUxJVG1GWHVSdHdvcHlhNnpyek0vZEc4clZuQ3FkMmVnRWdOTjNrbVlIV09H?=
 =?utf-8?B?UWRoVlJxT2VXelQ3Z0RNbXMzOTVsZVpiK3FCeitmOS9UdHlrWXNQZFpmZWpr?=
 =?utf-8?B?eUtmaTlsc3VubENBTnlSM0VkV1huaXFUcW83cXhHOEs4Z3lsY0w0TUJLcE4r?=
 =?utf-8?B?Q2hPd2ZUZ1RXbHJRZmNwSk9SdEpwRWFaV0hBTS9mQUV3SmxreHBpT3MwNGM5?=
 =?utf-8?B?a00wbW1ja3l6ODJiaGw5SEhSSHpuZ0NpS3ZBTmNaRll0eElOZXJjMWE4ZVN5?=
 =?utf-8?B?Y0psUFAwcFQ3UXJYc1B1elo0cCtmQk9UVnFUODJGampBWFk3dyt2NVMrWWVa?=
 =?utf-8?B?cHViaXpubEVJM0NlOWxCcGJ0WlRaVDF0OHErWHpTZzFaK2xVbjBNaGN2MmVU?=
 =?utf-8?B?cW1LcUpldXUxeEp1V2tNMXhnZGFFNkpjZ3dWVnRyS3ZHNkcvdllUOVkzTEg2?=
 =?utf-8?B?L1NtSFB0ckJpY3pHNjFzOHVnSWxsaTQ0S0dMR1NSY2FpdFRkWk5ReUVOaFJa?=
 =?utf-8?B?dVVKcHdCWXcrZVNCdTVOa1JoTjBUOGs1ZXV4Q3ZhWWlBbzlpTGRORUozRXZz?=
 =?utf-8?B?UUcxN3VuNElneExVcy9iREw5ODhxYTY1WXFlRjhUY21TeVVTTDZjVGk0N1FI?=
 =?utf-8?B?T1h6TzRkOHhIditVdzFtLzkyTCtna0MrS1BQRi9Uc0ZyMFJxZHY0V2MxZGpj?=
 =?utf-8?B?OVU2NWNaRjY1eWRBM3BvdXAybllzdnA4bEN2MG1sTTVrNDN4cmpPL09maWJY?=
 =?utf-8?B?eGxKZC9DQzBINXlseXZvbTZyK2N1c24rYmQ0dFUvZldXU3pqNTR1T1M5THcy?=
 =?utf-8?B?dnVZN2RYQlV4dC9XaVlBWnBvdHc2L29JM2psYUxKTmUwb2N1RWdlUW9jN0xL?=
 =?utf-8?B?dGcrMDBzU1k3UG1GemdpWHdqeWhmdi94dStHaXVWSGdKTUtXWEoxQXh4WXR1?=
 =?utf-8?B?VnozeGc2YjJHRUR1d00wcXV0RVowMktUQ2tqTnRZL0dXNkVYWktQS01nVzJJ?=
 =?utf-8?B?ak5RZ3lYNVNKVjRmSkNzY3NLa3R1SnRzeEc5WlA4dUtONlBnKzRxbGRQSzdl?=
 =?utf-8?B?ZW5WYW95RWIyZjhxVlBFcFlGZjJqN3RTSGZnL3NGZUR0b1ZnL1o4ZUdBS2hG?=
 =?utf-8?B?dTdaUFNaRWtwWnhibDRteFdOMUpIRU9CSzdkVnB2K3MxbHE0cXE5SUREQW41?=
 =?utf-8?B?b0RuODhvTjBDejdnVU41Zy9CNlRKWEY1M0lVc0hCWFVKZExOblRpWVkvUDVJ?=
 =?utf-8?B?akM1aURwbGtTemgydzF6RzBtbWhoK0EzeG5tQWN1N0d2RnY1OGhrVGl4RWM0?=
 =?utf-8?B?TllhZmJxekhod00zQ1NqdGRZUjdjOU5rL0xGc0ErQStOcUJHckZLM0NkZzlw?=
 =?utf-8?B?a1pnY2U2WWpNeGVaTU1wcXNrbmRxcWR1MFdpSUJmSjAzSk9kS0lBY3JqR2th?=
 =?utf-8?B?UU41dHpBQXJuRjYyTTdiWTF4a2YyVmhZZlVJTTRwNlVoT0plR0w2cU9zRFdX?=
 =?utf-8?B?NWtjdWhYUGVkTUZZUFJPakk3R3pZanFwZndIOFZLNVBoSEp4UlhjOElNSExk?=
 =?utf-8?B?S0hXbmsxWjFBSUVnRXNWLzltd2VBTmd6V3FNV0ZTOWNJYldwSUYwOGVWZ2Nq?=
 =?utf-8?B?VHdremF4ZDh0WE5JemRlRWtIc3BxQ0U2MkcwYjI2em5SVVZhcHpPTk5mTi9y?=
 =?utf-8?B?ZFRCTFFRTi95NmhlYmlJSCsyTU4zNFBmSFA5TXRFUnJ4WXNQKzMwTDN3bDJa?=
 =?utf-8?B?ZGFTQ1JZZkFkTmJHVk5aRm9ZMmZRMEV6SVhqNkNVcWkwTGREeFUrYmh2TUcv?=
 =?utf-8?B?WUp6a3dnRmpyOFNmaWR1aGJuT01rVjNENzQ4MS95SVBzazFUdEEvY0g4d0Za?=
 =?utf-8?B?aHU3cUVobmRVaGlhOUlIUzFmSk5MWnhvek9nNG42WjdYMjFISll3RUR2aWhi?=
 =?utf-8?B?Z2lnejgzWSs5Ym5BR2habVRZd3I5bHAwUEJoRXFvVXA4eTh1Sm8xM1N2S3l1?=
 =?utf-8?B?YjVQZndZT1BrbGFEdGk4QkUyZFRNRmMvakUzcjk2UE9FSDBKUGltYyt4anZm?=
 =?utf-8?B?bzNzRzhKREFQcHhISGdpandKbUxoSFQwTUo5aUIzSWprUndKemN5ZFoyMmtI?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22515A4381F3DB4BA644D86A62BC33E2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1c4fe6-81b9-45a0-f252-08dd5d502315
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 08:14:52.3403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okHzBTSmxfANhHzYMO5aN/Va4MQmu18hbnreFFtMiqTEW32F6LHWnR4Q1fvaOzEvueIUX1i3DdN40UpcTuG0UJKo1KcMh+oLyNaZk/FCGqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7397

T24gRnJpLCAyMDI1LTAzLTA3IGF0IDA4OjA0ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDA3LzAzLzIwMjUgMDc6MzgsIEZyaWRheSBZYW5nICjm
najpmLMpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyNS0wMy0wNiBhdCAxMzo0OCArMDEwMCwgS3J6
eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiBPbiAwNi8wMy8yMDI1IDEzOjQ1LCBGcmlkYXkgWWFuZyAo5p2o6ZizKSB3cm90
ZToNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgY29uc3Q6IG1lZGlhdGVrLG10ODE4OC1zbWktbGFy
Yg0KPiA+ID4gPiA+ID4gKyAgICAgICAgbWVkaWF0ZWssbGFyYi1pZDoNCj4gPiA+ID4gPiA+ICsg
ICAgICAgICAgb25lT2Y6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQXJlIHlvdSByZWFsbHkgc3Vy
ZSB0aGF0IHlvdSBuZWVkICdvbmVPZicgaGVyZT8gOi0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
UmVnYXJkcywNCj4gPiA+ID4gPiBBbmdlbG8NCj4gPiA+ID4gDQo+ID4gPiA+IFllcywgSSBoYXZl
IHRlc3RlZCBpdC4gSWYgSSB0cnkgdG8gbW9kaWZ5IHRoZSAnZXhhbXBsZXMnDQo+ID4gPiA+IGxp
a2UgdGhpcy4gVGhhdCBpczoNCj4gPiA+ID4gICBjaGFuZ2UgdGhlIGNvbXBhdGlibGUgdG8gIm1l
ZGlhdGVrLG10ODE4OC1zbWktbGFyYiIsDQo+ID4gPiA+ICAgYWRkICdtZWRpYXRlayxsYXJiLWlk
ID0gPDEwPjsnDQo+ID4gPiA+IA0KPiA+ID4gPiBleGFtcGxlczoNCj4gPiA+ID4gICAtIHwrDQo+
ID4gPiA+ICAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTczLWNsay5oPg0KPiA+
ID4gPiAgICAgI2luY2x1ZA0KPiA+ID4gPiBlIDxkdC1iaW5kaW5ncy9wb3dlci9tdDgxNzMtcG93
ZXIuaD4NCj4gPiA+ID4gDQo+ID4gPiA+ICAgICBsYXJiMTogbGFyYkAxNjAxMDAwMCB7DQo+ID4g
PiA+ICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNtaS1sYXJiIjsNCj4gPiA+
ID4gICAgICAgcmVnID0gPDB4MTYwMTAwMDAgMHgxMDAwPjsNCj4gPiA+ID4gICAgICAgbWVkaWF0
ZWssc21pID0gPCZzbWlfY29tbW9uPjsNCj4gPiA+ID4gICAgICAgbWVkaWF0ZWssbGFyYi1pZCA9
IDwxMD47DQo+ID4gPiA+ICAgICAgIHBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODhfUE9X
RVJfRE9NQUlOX1ZERUM+Ow0KPiA+ID4gPiAgICAgICBjbG9ja3MgPSA8JnZkZWNzeXMgQ0xLX1ZE
RUNfQ0tFTj4sDQo+ID4gPiA+ICAgICAgICAgICAgICAgIDwmdmRlY3N5cyBDTEtfVkRFQ19MQVJC
X0NLRU4+Ow0KPiA+ID4gPiAgICAgICBjbG9jay1uYW1lcyA9ICJhcGIiLCAic21pIjsNCj4gPiA+
ID4gICAgIH07DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgJ2R0X2JpbmRpbmdfY2hlY2snIGNvdWxk
IGdpdmUgdGhlIGZvbGxvd2luZw0KPiA+ID4gPiBlcnJvcnM6DQo+ID4gPiA+IA0KPiA+ID4gPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LQ0KPiA+ID4gPiBjb250cm9s
bGVycy9tZWRpYXRlayxzbWktDQo+ID4gPiA+IGxhcmIuZXhhbXBsZS5kdGI6IGxhcmJAMTYwMTAw
MDA6ICdyZXNldHMnIGlzIGEgcmVxdWlyZWQNCj4gPiA+ID4gcHJvcGVydHkNCj4gPiA+ID4gZnJv
bSBzY2hlbWEgJGlkOg0KPiA+ID4gPiANCj4gPiANCj4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tZW1vcnktY29udHJvbGxlcnMv
bWVkaWF0ZWssc21pLWxhcmIueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IWtFd1doeHlmalZ0
dUhLQkhhelpHUmFGZGxtclUyYmNJc2lWRGNzVUR6RUlNYW5NdzJYSUc5UmdPenE3NzN2dG1xbFI5
X3NXWkRGaFUwOVNWJA0KPiA+ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWVtb3J5LQ0KPiA+ID4gPiBjb250cm9sbGVycy9tZWRpYXRlayxzbWktDQo+ID4gPiA+IGxhcmIu
ZXhhbXBsZS5kdGI6IGxhcmJAMTYwMTAwMDA6ICdyZXNldC1uYW1lcycgaXMgYSByZXF1aXJlZA0K
PiA+ID4gPiBwcm9wZXJ0eQ0KPiA+ID4gPiBmcm9tIHNjaGVtYSAkaWQ6DQo+ID4gPiA+IA0KPiA+
IA0KPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9zY2hlbWFzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55YW1sKl9fO0l3
ISFDVFJOS0E5d01nMEFSYncha0V3V2h4eWZqVnR1SEtCSGF6WkdSYUZkbG1yVTJiY0lzaVZEY3NV
RHpFSU1hbk13MlhJRzlSZ096cTc3M3Z0bXFsUjlfc1daREZoVTA5U1YkDQo+ID4gPiA+IA0KPiA+
ID4gPiBBbmQgdGhpcyBpcyB3aGF0IEkgd2FudCB0byBhY2hpZXZlLiBPbiB0aGUgTWVkaWFUZWsg
TVQ4MTg4IFNvQw0KPiA+ID4gPiBwbGF0Zm9ybSwgJ3Jlc2V0cycgYW5kICdyZXNldC1uYW1lcycg
YXJlIG9ubHkgcmVxdWlyZWQgZm9yIFNNSQ0KPiA+ID4gPiBMQVJCcw0KPiA+ID4gPiBsb2NhdGVk
IGluIGltYWdlLCBjYW1lcmEgYW5kIGlwZSBzdWJzeXMuIE90aGVycyBjYW4gYmUgaWdub3JlZC4N
Cj4gPiA+ID4gQW5kDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiAnbGFyYi1pZCcgb2YgdGhlc2UgU01J
IExBUkJzIGFyZSBzaG93biBpbiB0aGlzIGFycmF5OiBbIDksIDEwLA0KPiA+ID4gPiAxMSwNCj4g
PiA+ID4gMTIsDQo+ID4gPiA+IDEzLCAxNiwgMTcsIDE4LCAxOSwgMjAgXS4NCj4gPiA+ID4gDQo+
ID4gPiA+IFBsZWFzZSBmZWVsIGZyZWUgdG8gbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGRv
dWJ0cy4NCj4gPiA+IA0KPiA+ID4gWW91IGRpZCBub3QgcmVhbGx5IGFuc3dlciB0aGUgcXVlc3Rp
b24uIFdoZXJlIGlzIGFueXRoaW5nIGFib3V0DQo+ID4gPiBvbmVPZg0KPiA+ID4gaW4NCj4gPiA+
IHlvdXIgcmVwbHk/DQo+ID4gPiANCj4gPiA+IEkgYW0gZHJvcHBpbmcgdGhpcyBwYXRjaHNldCBm
cm9tIG15IHF1ZXVlLg0KPiA+ID4gDQo+ID4gDQo+ID4gSW4gdGhpcyBTb0MsIHdlIGVuY291bnRl
cmVkIHBvd2VyLW9mZiBmYWlsdXJlcyBhbmQgU01JIGJ1cyBoYW5nDQo+ID4gaXNzdWVzDQo+ID4g
ZHVyaW5nIGNhbWVyYSBzdHJlc3MgdGVzdHMuIFNNSSBMQVJCcyBsb2NhdGVkIGluIHRoZSBpbWFn
ZSwgSVBFLA0KPiA+IGFuZA0KPiA+IGNhbWVyYSBzdWJzeXN0ZW1zIG5lZWQgdG8gaW1wbGVtZW50
IGEgcmVzZXQsIHdoaWxlIG90aGVyIExBUkJzIGRvDQo+ID4gbm90DQo+ID4gcmVxdWlyZSBpdC4N
Cj4gPiANCj4gPiBUaGUgJ21lZGlhdGVrLGxhcmItaWQnIGZvciBTTUkgTEFSQnMgaW4gdGhlIGlt
YWdlLCBJUEUsIGFuZCBjYW1lcmENCj4gPiBzdWJzeXN0ZW1zIGFyZSBhcyBmb2xsb3dzOg0KPiA+
IC0gaW1hZ2Ugc3Vic3lzdGVtOiA5LCAxMCwgMTEsIDEyLCAxNg0KPiA+IC0gSVBFIHN1YnN5c3Rl
bTogMTMNCj4gPiAtIGNhbWVyYSBzdWJzeXN0ZW06IDE3LCAxOCwgMTksIDIwDQo+ID4gDQo+ID4g
VGhlcmVmb3JlLCB3ZSBiZWxpZXZlIHRoYXQgJ21lZGlhdGVrLGxhcmItaWQnIHNob3VsZCBiZSAn
b25lT2YnIHRoZQ0KPiANCj4gDQo+IFNvIGV4cGxhaW4gbWUgd2hlcmUgaXMgdGhlIHNlY29uZCBj
b25kaXRpb24/DQo+IA0KDQpTb3JyeSBmb3IgdGhlIG1pc3VuZGVyc3RhbmRpbmcuIEkgc2hvdWxk
IGZpeCBpdCBsaWtlIHRoaXM6DQpqdXN0IGRlbGV0ZSAnb25lT2YnIGFuZCB1c2UgJ2VudW0nDQoN
CiAgLSBpZjogICMgb25seSBmb3IgY2FtZXJhIGFuZCBpbWFnZSBzdWJzeXMNCiAgICAgIHByb3Bl
cnRpZXM6DQogICAgICAgIGNvbQ0KcGF0aWJsZToNCiAgICAgICAgICBjb25zdDogbWVkaWF0ZWss
bXQ4MTg4LXNtaS1sYXJiDQogICAgICAgIG1lZGlhdGVrLGxhcmItDQppZDoNCiAgICAgICAgICBl
bnVtOg0KICAgICAgICAgICAgWyA5LCAxMCwgMTEsIDEyLCAxMywgMTYsIDE3LCAxOCwgMTksIDIw
IF0NCg0KICAgIHRoZW46DQogICAgICByZXF1aXJlZDoNCiAgICAgICAgLSByZXNldHMNCiAgICAg
ICAgLSByZXNldC1uYW1lcw0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

