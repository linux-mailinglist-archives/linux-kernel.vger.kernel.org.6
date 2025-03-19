Return-Path: <linux-kernel+bounces-567209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0E6A68349
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353EA189719B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075324E007;
	Wed, 19 Mar 2025 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k2fctZCY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="K8CZD1N9"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A7AD2F;
	Wed, 19 Mar 2025 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352357; cv=fail; b=HGLaIJ0TH2PakQ3iDXkDZCr/HKSAlq7qSqP0dovALDHDekz9VtOB9m7H5WNqLPoFUIqFVvBZq6HKrK5lNl9RCY1ApZ+7ZX/lwfyEnT129FCzlpvzxJKlagDkDiPSt+jDvKlC8dZHkQKkFNbYGOjkKleb/OP1Nqi+3fvgjvWRT7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352357; c=relaxed/simple;
	bh=vj65VF9opO1IfTI5fQ5YewVF62dNA+V3DMdndUlsE5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UdE4ga4JWgttblYVwRQs+eHSoju+28B5PW5oQ/3gCQ95HCjJWxDU7cXn8ONXGuPdiao8uQer0SIbmYUuR7oMGpJKYgAh3POj4axTvhhZnAkdDBUf0tEhRZtrOhgpfX/CXuPRKfpPQNZINNiK18HHMvnwQOWdnYBlKq9OQtTgkjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k2fctZCY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=K8CZD1N9; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 41b2d592046c11f08eb9c36241bbb6fb-20250319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vj65VF9opO1IfTI5fQ5YewVF62dNA+V3DMdndUlsE5g=;
	b=k2fctZCYFAdJOSvzyruaqNvgbtonUAZFQbGe8BvPu1ufklPOPTaOhwCLnTJJSGlI30XK4LfgUKoS/lSbLR8Ns5pG4f1XYBYAtEghNJ0woS0ejpeJkcK2wm6uqGE00Lmzip+Ui94kUCNm2ROQnnkj1uuSTgjE5CxiudoRekYDZmE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:49db46f1-5594-47ff-bdf8-fcaa2d82adca,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:f09a84c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 41b2d592046c11f08eb9c36241bbb6fb-20250319
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1752603885; Wed, 19 Mar 2025 10:45:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 19 Mar 2025 10:45:44 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 19 Mar 2025 10:45:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHOJDv7bLjuhf/QPQjzsbobp1M9+4gzE33/xsRk0nYSOCNb7hPAwD8Aal4WfDuJp2L1b4BHtvxtu9L1p3rHOP6lqv6rk4skF/8h9ls2rv4RCaXWpK4urbcM8hUZHtivjtndqr3rE3ArlHZa6aUZ9oHepEemYJbKYTU2LWMSGdru+vZ5A776orwGx4qZzI5lnXMknUssVs9l50XCdYLPAr56zyTqx4qhdnut+HOHvZK0s8MuqGY4PG8DLqpwPnVC01hcs/q+A0ljW4jaj3dl6BRpFRBKhqBM5SADNWClMikjXJs6rWcVnKP0a3B1kreuU9y+2VtRnx9DKAQlGsMvdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj65VF9opO1IfTI5fQ5YewVF62dNA+V3DMdndUlsE5g=;
 b=FtdnsP59LZaeypcvdbcy24ZS2QI7pIr3BYX0dkk75Yw4nUgs2RU9F2sLhMOMxfEW6ogB8B3ybOsvS+Zz+OK6FGcIY4QxL3ntIp7IieuHw966iIhocPGZlTwfAo/YozjTQTX9fEnWn5yg/xydllVoaPPFtQSKlJCfOHb/l0HpL0fiaQZXVnNhSqEd5JcScJtwEtjDeY6NyzsWWVizy1zmOKUPumOU0210SCo9NJtHT4AozoWVI5lhik6ZJI5OPTfRENSimqXrQpmCgNN6e9QOAj9JQpb2fsdKiwDUcpm6MJU46AyZ30lAOtyWsxcEWVOFTBS5NAyd9r7bvrdxHDBCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj65VF9opO1IfTI5fQ5YewVF62dNA+V3DMdndUlsE5g=;
 b=K8CZD1N9lC/KYtWr0cYRQVAa6mAU4M+CJoTCrzCLrwFQb8Wrk1+JYVCaR7F5U+qqZ5o0p+RTTxnm0Y428NfrWdLYl/YI8WAcOSdNEUyTdJR9PLzjca6AObuC34ISbVBKU9Rqdfn2VHtLMm+3kxNJVuY1EJ8DDeIV4LLon4iAV6g=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by SEYPR03MB7626.apcprd03.prod.outlook.com (2603:1096:101:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 02:45:40 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 02:45:40 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>, "AngeloGioacchino
 Del Regno" <angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "wenst@chromium.org"
	<wenst@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH RFC v3 2/3] firmware: mediatek: Add vcp ipc protocol
 interface
Thread-Topic: [PATCH RFC v3 2/3] firmware: mediatek: Add vcp ipc protocol
 interface
Thread-Index: AQHblyxAEVtsdUlTP0eaDYYXkv3a07N3kjSAgAD/8wCAAAfKgIABKbWA
Date: Wed, 19 Mar 2025 02:45:40 +0000
Message-ID: <d55bcde48451f403172833ecf48fbc9066915e57.camel@mediatek.com>
References: <20250317110331.2776-1-jjian.zhou@mediatek.com>
	 <20250317110331.2776-3-jjian.zhou@mediatek.com>
	 <d3f8fbe3-c061-4d34-a5a3-09cbf676bc4c@kernel.org>
	 <f3b6a690f73e8f5a5370a587d0b1671e96e8b5b2.camel@mediatek.com>
	 <12f5049d-02e1-4c80-9289-b2dfb1e136a8@kernel.org>
In-Reply-To: <12f5049d-02e1-4c80-9289-b2dfb1e136a8@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|SEYPR03MB7626:EE_
x-ms-office365-filtering-correlation-id: e4f9b8c7-5c87-4f59-b217-08dd669022e5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eVZRU0ZuRjVQOExMaWJpMUdvMTN2WVluaVdhNXJTWlFkMEE1NVB4N29uVHdM?=
 =?utf-8?B?NWtOYndWazhSb01JUHlXYldETUt5OGk4NGdwYWZHK0NpUGQyYnFYQ3JqdkdZ?=
 =?utf-8?B?QnRyYlE4b1hTN29qWmp2eFNMNmVyaDV1bzNieUJCeG96Qk5qQ01YYjRBemk5?=
 =?utf-8?B?WHVkemZyRUxSVGU5S0psQitHNWpLNHVKVEEvUUpvNUh2Q2xES1hUdS9CamRG?=
 =?utf-8?B?QnRuN0wzL0NaZDRKSHVkTnNHNHNsbEsxcUZER2FuTFhsZExtZnRsVHZJeXI4?=
 =?utf-8?B?VVVwNzBvTlBsOHZiY0Q4aFZpQVdKRzRUMkpSN3pDamZkUGhrSDg5eEkvc1hO?=
 =?utf-8?B?aHJKZHFyTGExZlNkbXJNcnNNZTdaMDN5WFZVbCsxVUJnd2hKU3dyUFNCZXRu?=
 =?utf-8?B?QThtSkxmR0xYR2xIc3hPSEJUNVFWWlhhZWh1NFZHQzVLVlI1WVAxS04rekRL?=
 =?utf-8?B?S2lpT2tSdHBYL2ZUQTllWWwzOTBKU3pMQjRzK3RsOWluYnNBNm5mdE5WUnM3?=
 =?utf-8?B?MG1vS2RudGc0QkVPSFdHSElyMXBqYkQrUEcrcjhMUTF4VUVzdzVjZjMrdVdq?=
 =?utf-8?B?OTF0eEwra3BxZ24rK0tzcnlHY2VuT0RnYkN4YUJxd1FFQ2EyZXlIc1ZCMEhp?=
 =?utf-8?B?TGovK0J0VnZMbmlxcDRYOHVtdFBQN3pnbllycWxSeE1lUEdtZWU2Z2dhMXRk?=
 =?utf-8?B?aHpDQTZKNzdVeEJTMkt6U0RQa1NCRWdpSXNzQzgrVitzc05NTTRISmdSVUR6?=
 =?utf-8?B?dGtCMWt3V3U1eDRGc3hPa2Z5bzU1dzRYZnNjL29XbmFDSkl2ZCt5aHJzcUFa?=
 =?utf-8?B?MzBiT1Vxcm81RGxwK3pKaGxEOXhZcTE3VTZ4L1A5c1JMSDNHanRVMThqbDBY?=
 =?utf-8?B?THVwUDBmKzdEZk80VDZxcTRVNWZhNURoTWdvQlVtckYzK09PMGVwa3pQVUF1?=
 =?utf-8?B?TFhCbytuMm9GYkRZV1FxRVJORUNEL2dXMm5lZnBTMjdhQ0ppM1MwcXFBRHBM?=
 =?utf-8?B?MmVpYUlHYm11MldwSktXb2ptdmdmWDlLVlJNMTM3UVk2VmhicEd5TVdXQnll?=
 =?utf-8?B?SlFtVkRUZFgyMzdvaG51a3Rlc3JvZUNrVTNRYU44QlVrWHpKRlk3Q2UxTkFS?=
 =?utf-8?B?aUl6Yzk5R0tPeUFucXYwdUlycUhHZGRtcXdhS3pBNmVIVjh5UWg1YXVjQUpD?=
 =?utf-8?B?Z3ZZV1pOMkxmK0M4MWFQZ3IrOElXbVBNbHZ4QVU1d3h6N2hha2JlNlZnZ2lH?=
 =?utf-8?B?cWFROEE1bFYyRjN1L2RqeW1ZNm40WUkvVHZZNVVPNGtlbndqK2V6azQ1TWFS?=
 =?utf-8?B?UXZybFJ5OURVRUJHc01BUmpZZzcwd3N3OTB2U1ZSS3ZoTk5PK1BJaG5ad3Bw?=
 =?utf-8?B?aStOR25GTUVjSVRvekZnQndiZ002a25pdHZvUGhRMGdZalZoQzlrQUZqT0dh?=
 =?utf-8?B?YUlVWHJCd09qa1BwY0xYZ1hickNmalJUbk1ab3hVVVRHMFZ6ZlRKY3V3cS9h?=
 =?utf-8?B?WE9UYmpZdm04MVdIbmYwSUhxR2JYa1VBbUNNUTBkTXMrV0xRRVBIaW4xM1Mw?=
 =?utf-8?B?WnJYV244OUJ4SUgxSHdleHlIbGRTZDFSZlJPSmhWS1ZGT3BMTlU0Z3VrSkRP?=
 =?utf-8?B?RkpaeUs5NGtxWTdTYm5mUW1HVEtnWXUxdENjanRla1BXVitHcjBJOXI2REQz?=
 =?utf-8?B?YkZjamxPclkwdk5YTHRqT2Rud0o1bHdlRzJ3SnBHKzl4aEQwaXYvQUVza3RH?=
 =?utf-8?B?TzRzeTlzYk56UlB1YjRyelJoRTlGRUwxNE5FYlBCUTBoSk1sTElwZ0tLSGp3?=
 =?utf-8?B?dnJBSWJtSkxCS2NETzN0SHRDRWx0WVlXTWRpYU94dU1YUHMzaFlhS2lId1J0?=
 =?utf-8?B?d0Zka0hjUjF1OFJDbzU2V2svaXZzKzNpY0YxYjNHcWQyemdsSU93SlpQazlq?=
 =?utf-8?Q?gsm+EjXmH+Lfq3J2VxCaMikPUeFhVI7d?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHZvdVVpME03d2VxZi9OZHFyd0hiem9ZdnV5WmFVMkcwdHl5ZU1uMzF6dW9p?=
 =?utf-8?B?MDhEU2pOK0VlVkZESnhMUmdjV1RwK0RZSVZnUzdyNlplanRsYm8vNXVKZ1FI?=
 =?utf-8?B?cVVZeDVHa1BvRjk3b1VQYlAwTnU3RWVRM0lyWXMyblpsTWVxdCtGeUM3eHJT?=
 =?utf-8?B?YnFRRFRubmFYd3loRjdBdTNGRVBTMUN3WG1rczRYallCRkZ4SVdqbmxjSHYz?=
 =?utf-8?B?RXI1NEJBUDN3bENHbS9Sam42T2dhL3ZLWUlqb01pL1VZZUtEVEhXQVY3bnZp?=
 =?utf-8?B?THNNeWJTcGdjeHBZQ2p4aHB0b0N4a01WUHZVMHNpZmNEdUp0Mk5KUGlCaTRl?=
 =?utf-8?B?Y2x0K1Qzc0JqbGFxU202bE11STNNNzZIczk1ckg2QTgyVnZLVWo5VjRoOEdQ?=
 =?utf-8?B?Q2ZxTVpIV1NaVlBaTlVqS1NMZGpGRmFTc2cvY0pFM1A3K0sxT2laK21oeDFH?=
 =?utf-8?B?bTJMbnpMMFIyNytSZ2FtZjFiU3l3RjZwY25UMnVNT3VzNUJEc25WdWMvN3Vu?=
 =?utf-8?B?Z3lJZUdjTnFGdEFiTGpEcjJPemNENjhydFZZekp6LzJKNm9LUDhHTUZZcDdT?=
 =?utf-8?B?WmdEdzNRVElxTWw3VEFCNE1mMUllUEZhaDdIeGtoeEZYVVZqdDlqRjhHcTEw?=
 =?utf-8?B?cXQ3WHZYM0c0ZUtBNm84NU9OQzBXMEtpSzVaNmxLeTlsSHZPRGJrRWNjcW9s?=
 =?utf-8?B?bzA3V2tZdlVOS3oyZE9sY0cvYU1GcFF3SUd5cnc2d3FmSFhnSmZZOGczVDVG?=
 =?utf-8?B?dGJJbmxiUzQreXpkQUNGd3dIandRM0JiOEgwOFREL09hMS9KeDNiTXZMeXQ2?=
 =?utf-8?B?Si9lcVJzSEtyQU9UdDFmQ2xXOHJrM0tWYUFuSmlsdTdIU2R1L3M3WFEyQzB4?=
 =?utf-8?B?OGtyTzl4TEtkU3VzWDFtQlpONXYrLzBBcEd5R0ZVbU1HL3c5Ry9uTHdSSzc3?=
 =?utf-8?B?SFdBd29LMzNubEE2TnFhcWdncG9nMnNMNGVZckM3endpcE1Vb25SUmt1ald3?=
 =?utf-8?B?ZEpZaWxCWGxLbnBOUno3dXpTbUNNSFJWdVhvUlJTTTk4Tk9NaXVYMDhCVjZi?=
 =?utf-8?B?VzNGckRPRTF0Y0l3NTdkd0lsVzdTKy9SNmxhTXBkdFJjZ2Jzd21TZ2NVQzEw?=
 =?utf-8?B?SERGSXBRdWZtR3IzVm9RLy82Z1k2Ni9YMG9aME1BbnJHZG03UnNFTXlxQVhu?=
 =?utf-8?B?QnI1citMUUQrZ1lwNmt5UW5oNDhCTkR3T0JSTkFIdGtiNjNsMjUyTVNHN2VS?=
 =?utf-8?B?WSt6V2VHa003NU9XNnNuSFJ5L001ZDJIMldEb0pZSDdTUFpWR1UxYnZLQkZa?=
 =?utf-8?B?ZVd0MlJocVhlYnJqWTRzWWFEN2pYMFhuZ1UyaTNVTWhheThyN0JSMVB5b1VJ?=
 =?utf-8?B?d3NzT2p4b0lWVkhqYWk2S2ZpckhyL1NteFBsa2tlbjVxWnhESzJXZGRjbVJq?=
 =?utf-8?B?YmtqKzlWSnRhNXFocUdObGUrUnB3QTYrYWNWc3RYZm9ySHBuSEl5dHZyUERO?=
 =?utf-8?B?RWN1RmYyNDdtSzl4Nk5wcWtNYnF3VTM4M0lOc08wUUVsTXRHd2pPRXJ3QkZj?=
 =?utf-8?B?bHNCTlp4UVZ3V0MxNlM3bC9oWWRsSzBXOU5URGl6dlU4ZlhHYzlhUm0ySlRx?=
 =?utf-8?B?bWJrVlJMZzVyU1ZFQ2paN2NyU2IwMVFKQ29UZDA3eEhxZEVZa01LVG1TKy9a?=
 =?utf-8?B?TndEeGxGS0lUZjJ3cWNJN1l3ZWxkT1lNL05RUFVFVnNFWFR2c3Jwa1FOSHI4?=
 =?utf-8?B?RG40UHFFcUNINC9CYkxqRzNnL1VPN3h6d2NNUTR6WEV5YUNlL0hZYmgxZ2RH?=
 =?utf-8?B?TTZSMFFMa24xbnpEV2pnTDY4NkthWnlUNm51Y0hjZU9oSmNaczRqUGg0MmRx?=
 =?utf-8?B?ZlB1VklGRTlLMlNyZkZnbFc2WWRiK0gxanJxWE9ZaDJYLzJzeTBLcERNRUgr?=
 =?utf-8?B?Q090YXpEOWpLWTNYMWx0djJKaGpBa2NHV1QwTXdja0M4dnV2NHZtNjlpaS8z?=
 =?utf-8?B?VTFvamdKQmZVUWh1TTd5bEVWTW9iZWFYQUdOellhUTVlTlU0aS9CdVVFNDE4?=
 =?utf-8?B?bm4vWklQNnU2b2p4Zys3UjRPUlVORVJxellPb0hzUlVuMmZLaXBuRzJsNktL?=
 =?utf-8?B?ZytTTFF5RFBsaVhlS0xwb2ZEZkxUdTNhSndqci95cENXUjF1WEFkNURqTzBD?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAA37362933D7E40982A7632DC7CCE94@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f9b8c7-5c87-4f59-b217-08dd669022e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 02:45:40.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENaxFEaNUDDgD/2cRMMKGoM8Qshmytr+IZuZrvMAEculSwvqq5zgy9aWvsSw6Yq/1zYAoDxhzHvrVcYZFVEC8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7626

T24gVHVlLCAyMDI1LTAzLTE4IGF0IDEwOjAwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDE4LzAzLzIwMjUgMDk6MzIsIEpqaWFuIFpob3UgKOWR
qOW7uikgd3JvdGU6DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgcmV0dXJuIElQSV9BQ1RJT05f
RE9ORTsNCj4gPiA+ID4gK30NCj4gPiA+ID4gK0VYUE9SVF9TWU1CT0wobXRrX3ZjcF9pcGNfc2Vu
ZCk7DQo+ID4gPiANCj4gPiA+IERyb3AgZXhwb3J0IC0gbm8gdXNlcnMNCj4gPiA+IA0KPiA+ID4g
QW55d2F5LCBldmVyeSBleHBvcnQgbXVzdCBiZSBHUEwuDQo+ID4gDQo+ID4gVGhlIFZpZGVvIENv
bXBhbmlvbiBQcm9jZXNzb3IgKFZDUCkgZHJpdmVyIChjdXJyZW50bHkgYmVpbmcNCj4gPiBwcmVw
YXJlZA0KPiA+IGZvciBzdWJtaXNzaW9uIHRvIHRoZSBjb21tdW5pdHkpIHdpbGwgY2FsbCBpdC4N
Cj4gPiANCj4gDQo+IEl0IGRvZXMgbm90IHdvcmsgbGlrZSB0aGF0LiBZb3UgbXVzdCBwb3N0IHRo
ZSB1c2VycyBOT1cuDQo+IA0KPiBOQUsNCj4gDQoNCkxldCdzIHJldmlldyB0aGlzIHBhdGNoIHRv
Z2V0aGVyIGFmdGVyIHRoZSBWQ1AgZHJpdmVyIGlzIHJlYWR5LiBQYXRjaCAxDQphbmQgUGF0Y2gg
MyB3aWxsIGJlIGNvbWJpbmVkIGludG8gdjQgZm9yIHJldmlldy4gSG93IGRvIHlvdSB0aGluaz8N
Cg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gQ2hlY2sgZ29lcyBpbW1lZGlhdGVseSBhZnRlciBkZWNs
YXJhdGlvbi4gSSBkb3VidCBpdCBpcyB1c2VmdWwgaW4NCj4gPiA+IHRoZQ0KPiA+ID4gZmlyc3Qg
cGxhY2UgYXMgdGhpcyBjYW5ub3QgZXZlbiBoYXBwZW4uLi4NCj4gPiA+IA0KPiA+ID4gDQo+ID4g
PiA+ICsgICAgICAgICAgICAgZGV2X2VycihkZXYsICJObyBwbGF0Zm9ybSBkYXRhIGF2YWlsYWJs
ZVxuIik7DQo+ID4gPiANCj4gPiA+IE5vLCBkcm9wLiBDYW5ub3QgaGFwcGVuIG9yIGZpeCB5b3Vy
IGRyaXZlcnMuIFdobyBwcm92aWRlcyB0aGUNCj4gPiA+IHBsYXRkYXRhIGhlcmU/DQo+ID4gDQo+
ID4gVGhlIFZDUCBkcml2ZXIgd2lsbCBjYWxsIHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9kYXRh
IHRvIHJlZ2lzdGVyDQo+ID4gdGhlDQo+ID4gc3RydWN0dXJlIGRhdGEuIG10a192Y3BfaXBjX3By
b2JlIHdpbGwgYmUgdHJpZ2dlcmVkIGJ5IHZjcF9wcm9iZS4NCj4gPiBUaGlzDQo+ID4gc3RydWN0
dXJlIGRhdGEgaXMgdGhlIHN0cnVjdHVyZSB3ZSBkZXNjcmliZWQgaW4gdGhlIGNvdmVyIGxldHRl
ci4NCj4gDQo+IA0KPiBDb21tZW50IGlzIHN0aWxsIHZhbGlkLg0KDQpMZXQncyByZXZpZXcgdGhp
cyBwYXRjaCB0b2dldGhlciBhZnRlciB0aGUgVkNQIGRyaXZlciBpcyByZWFkeS4gUGF0Y2ggMQ0K
YW5kIFBhdGNoIDMgd2lsbCBiZSBjb21iaW5lZCBpbnRvIHY0IGZvciByZXZpZXcuIEhvdyBkbyB5
b3UgdGhpbms/DQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

