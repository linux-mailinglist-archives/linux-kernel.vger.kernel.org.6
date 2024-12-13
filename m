Return-Path: <linux-kernel+bounces-444220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 521819F0307
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B99A163F12
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095C4152E12;
	Fri, 13 Dec 2024 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PUHXvoC4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pde0oFrX"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6C143722;
	Fri, 13 Dec 2024 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060090; cv=fail; b=WS+K5j0IvHns9jOVebLrDH973FeSjai4qxFvWimaZOyOPld2WdjMpaqDDiIo7+trVeKJIfGm6RlRPT54mGBWUAboB/rhO8EP6QyADSDjEJAyhoKCygu2yOSJSl5mDyYNq15PyHEz9qiFSm3S2QirwsNeO2XMPG/yU9TADB9sXn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060090; c=relaxed/simple;
	bh=Z53vEnByz+dkF4/iwse2onn8/LLoUJ5umQ09ZJbu/vM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ssmuj2nappRGv4DF95e/ZWrbfvSuCvlSe6VMLBr0jA2I5GQ3Zw4af6UQYPh5m2nvkqZGbdoJjeQgus4wqc5Sk6O0kYiYp1MbWzor7hQSE4MrUpxz15AotRyjXSawQiucOAT0/pFXW/cE/EmyfbHcjNyDNPVTwBGJVpEgNVrJgyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PUHXvoC4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pde0oFrX; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5318e1cab90111ef99858b75a2457dd9-20241213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Z53vEnByz+dkF4/iwse2onn8/LLoUJ5umQ09ZJbu/vM=;
	b=PUHXvoC4jldbEZv39/N1bXZzbjn9O+Bs8W0/uI/DAmhptK6gt576y10N+uWmmB4DzXHXZ4NVOqm61rAZhh99Cl7RToa5GEeH0JdtnmIZxX2gkcmluTCbr3L8mOGPLqhPEOkeSkcU55N/cm332g+kh7CazqSOZz2b/Q+n0r1YDtk=;
X-CID-CACHE: Type:Local,Time:202412131121+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:10710110-0d76-4d82-a360-9ee2c83ffbb8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:19900f13-8f5d-4ac6-9276-7b9691c7b8d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5318e1cab90111ef99858b75a2457dd9-20241213
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1913316423; Fri, 13 Dec 2024 11:21:21 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Dec 2024 11:21:18 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Dec 2024 11:21:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnxn8Qb1u6OY+COdQtJXHagjun0hR/hWcfEjw03MJJSKkQo+JKE6ncHm7ATwUSs556kIKDx4AghIOtuEzWGPs8B0rSwQbytGofj6cjJUy2SPnPqoTfSr7Epa2rECBzUbTGIhqRFQ4PxU7usq7hhIfneywy01Q8LpOaTyL9xErV4tt/otzZZ6Fo4DElQ/MoQdbCCLjIA7hCvX/icZ9n0r2Idka7NNqXTDA/VbaHndAKcbDghalOSTvowVQ/y0EebwffB4G3sAgkDUSbS6iSRo8oamBGlz5ADEj5uOkPCrcYJuqwp7oPCEHehi7Ls4Dp/iV4f7rkGP7LSjspCTp6W36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z53vEnByz+dkF4/iwse2onn8/LLoUJ5umQ09ZJbu/vM=;
 b=uToCX+a5DSaDO21ggMNWCW201MRn011hgf6SWh2GiMxEpsOGPFeKAFwNWmCIao5SqhrFsQzEJPpUwaU5NepXBdEUDQCGQtirodA0Ea5pygHesran6aqpkhU8hxvo777uR5bP3V6T79FAOVq2OvVaLsCZcphdfjgqP2wBVQh+TOauLxc4je4BM6JO9s3soQx9hR0sgbQso9/dmVf96fxqsolMgjrVpKNjEtOBtyQMrrq1bihMBommOoTeXVBOynVkouDYOWR3CFCCzVU+vQ8g/iG+u332fFANV3fgYzPBC5VnKzXvqfmKB16UKkaiqca9ML2Fza/yGyRNFU1nYmE9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z53vEnByz+dkF4/iwse2onn8/LLoUJ5umQ09ZJbu/vM=;
 b=pde0oFrXqrO1jRFtZzL5POnLeumu+/3g4YBv6h0sVXDEmdCZv/YToPpBBWW+V5Jv2klhMtL8d53Q7V1no7mj44ObZ8kAZG9L7fpBzWxBC8nkuj4YeYjiGp7fkQ/VVRPKpVFHgcrOTjXTXiqBqAWCeYPjGnwU9bJ+XziLCxoF1a4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6785.apcprd03.prod.outlook.com (2603:1096:101:65::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Fri, 13 Dec
 2024 03:21:15 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 03:21:15 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "fshao@chromium.org"
	<fshao@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: mediatek: ovl: Modify rules for
 MT8195/MT8188
Thread-Topic: [PATCH 1/2] dt-bindings: display: mediatek: ovl: Modify rules
 for MT8195/MT8188
Thread-Index: AQHbTKt0cdE74VjOD0q6JLT/osJMFbLjgsoA
Date: Fri, 13 Dec 2024 03:21:15 +0000
Message-ID: <4cadf749736b39872f122096512eff033c9b50c7.camel@mediatek.com>
References: <20241212153344.27408-1-jason-jh.lin@mediatek.com>
	 <20241212153344.27408-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20241212153344.27408-2-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6785:EE_
x-ms-office365-filtering-correlation-id: 6e317e18-8064-418c-11c1-08dd1b2533d6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VE5iV3kwZEVKWnZ2RHU1cXVEYWJVaEpNNFBFd2hjQW1XVVYxeWJpczZHQWlr?=
 =?utf-8?B?OEtFYkR6cHZrTi83aWdpTUEzL1duWHdjakV1MmxJdEhtQ3g1WHowT3NwT3hV?=
 =?utf-8?B?ZVlxY1FhQzNWVkJDdGk2b1hUL3UzQnBJZm55a3hkaVdXdSt2Z0xNSnFsUm5t?=
 =?utf-8?B?WjRNVzE3aEVOR2NCeGdneDFNMkYvUHFrNWh1MUJob1RpQ2Z2SjFJS3h3bDBP?=
 =?utf-8?B?MWZVUEIzWmZpTHQrOFg3NkN5ZEpFVUhYanR5SkJIbWNGdjNWOTNvUUpuNDlM?=
 =?utf-8?B?MUlOeDY3dnUxd0VUZVVNaEpHcDJVNTgvNjFqMTg0V3pZVVQwMlNZWkloem9r?=
 =?utf-8?B?TjBHNHNWRVU4aEZyVTZ6ajUzY051Nk53TSt0MmdOczZCc1V3R2xxZXRYb2pt?=
 =?utf-8?B?cUdCOXlBcXdsWlZzcmlxZHVCamo2bkNPTkNyM2l5eXZFSVYvN3YrSGx4MGF2?=
 =?utf-8?B?eVd2UVVTOGwyOW13K1Zsc0x2Tmt3eHhPcFFxamRyYjVWb01sS0NJakVuZ3V2?=
 =?utf-8?B?RWxMQkIvb3VFZkcrU3J1V2U3QWxudENISmdtL1NOMVBGcTBwWVUwd2Y4bFha?=
 =?utf-8?B?bVhPMENISEwrbSthN2JWNU1SM3VaUmVXYWRLaTNLRDkvNVA5ODh5cW5GUkNP?=
 =?utf-8?B?cmlkRWsyWDRVYnVxYzRyUFZiMFZQR05jVEhFbzFHMFRtYnZsc251K1dHc1l6?=
 =?utf-8?B?QzUrYWZhL2hkOFArYmk1NENueXFDUHZSQUcwOWg0cGV2eGpyVmFFaFMwMG5D?=
 =?utf-8?B?eGtSZzBGUFN3RlFWdXV4Q0wzNnQ1REpqT2tDdFJZV1FmSnlVM2dwZCtkYyts?=
 =?utf-8?B?UStib0F4UGMwRDY5SHM5S003eWlZcmdjRFQwQVZFdjZVNkZQcTVMRS85Snkw?=
 =?utf-8?B?Q3NwR2FXQW5wTnkzbkN1eEExU0dCOFgwM2lZcEJCa0VQRkVDOC92VG5RQzhs?=
 =?utf-8?B?ZGF4dWc5cGljSHU3a1N1bjUwUnNaU0VpMWwzQWZCWFJxQTRtWXA4NkV4cFcv?=
 =?utf-8?B?WlB4MktKWHM1NS9oak8zeHJQNW1MdHB2WTVDcm1Ia0VWTFRYRENZN2FjbzUz?=
 =?utf-8?B?QjJZSnNtVjBXK2xhWmlSRUd2Y2haQ2xjODdtQWNGVTVxK2VYejdtSXR1dTdh?=
 =?utf-8?B?VXV0OXpIWG0wRTFmOGNVSGVON1dmaEt2UGZOQk1xc2pQejlxN1BSWFJjVWw2?=
 =?utf-8?B?L1JoTHIrMDZlSUhZMFp2MXUzOHcrMVhUMnY5OGxIQ2xuK1p3Ymt2dFJzenNm?=
 =?utf-8?B?SVVDZEV1ZWVCcFVBcVhTcjRLSXBhMUlOSzNBNnkwbEhWRDlBVy9YMFNTYVpv?=
 =?utf-8?B?Y3E5R1l1S0tSZGVXMGRRYW8yWE00a25tUmJkZitleU4ydGw0Rjh6d0w4Wndt?=
 =?utf-8?B?UTRpOEFKMGhGeXRnOEcxNHF6WlJCdkFxbXNSclpJNnE4NjdjVkRkaXFjc2ly?=
 =?utf-8?B?K2t2NnA5cnF6ajNLR0RJT0VzR1VoKytBSVY0dGFXRWdqNGtpazZWaGRQczhU?=
 =?utf-8?B?MTlpS0o0eVJ6UU82WXF4ZlQyZjJ6ZXY5WmVSMURQVnl4a1FlNEVKLzN0b0pE?=
 =?utf-8?B?YVNCTDBHV0VxZ2VZRGwzMGN0anhvK3A2eFBhelhsR09WenFFQURvNEtIdzVW?=
 =?utf-8?B?T1p5Sit1WjVvSDRTSExjWnFmTjhrN3ZnbFhTVzRSQ1BDbmZvbXRCeFFlOUU5?=
 =?utf-8?B?UUd2eWxidFVxb2M0SFIwRGo3RlptWXNoNElUQmx4YlduSW1Yb0dMWkFWMGph?=
 =?utf-8?B?WC9EbXFLdmJHakttZHl2MGxXaDdGQmdvelFXWHcwSUZVWDJNcDlGT3RKbjNO?=
 =?utf-8?B?Ymdsay9hUDZwazY5d0Q5Y0RiWWp0bVlPeFR3MzUzTlUrNHVaS3J3NGVoei8r?=
 =?utf-8?B?OEJCaUFvQy9hdzhydUd0T0hnN3AyTExtTThxN09zaDRsbE16aW82ckttNGJP?=
 =?utf-8?Q?x77wcQc0Yt3AzTsmxGuuT7KsJMkd1sGV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUU0MUVtZE84ZnVzQmplMkkzRnI5anBhMGttQnBVTGtSSDcvSHg5aDFXTTRY?=
 =?utf-8?B?L1RkV1F2YytPRTRmc21wakpsQW9NT1dVWE9NVzU3ZFJUQm8zQk1vbkFvMnFE?=
 =?utf-8?B?ZkhOcTBPQUV5ZHVrM3BRcGY1WlFtOHFDakZGTGlzcFpobXdHM2U3b2V2bmxZ?=
 =?utf-8?B?Q0NnUWxqWGhyME5UWk45VXcycGdzWEU1d1J0OFQyancyVkIwTEluWXBPbGw5?=
 =?utf-8?B?dW1MZ1BPQzNVZStrczFsTU9wcjROcWxGY21zNEZTMlA5bnNlQnFiQmd0ZS8y?=
 =?utf-8?B?dUVROWdvdzdNUzQ4ZjBneTNsMXhpTXVNZlhpZTRJdlJyaWp1QWxlaTdzUGha?=
 =?utf-8?B?dUcxTjZTNENkY0FMYkF4UVB2NHVDd0RtK0I5UnNEYStycWhYb2l6ZGhyeGFM?=
 =?utf-8?B?QWZZQjNUYWptSDZhM0x5SkRQL0xXUXlNUmZ4ZGpTekI3ZVB4VnAwV0FXSGZr?=
 =?utf-8?B?YnQyVWY4bzExVWwxOGxyK1lPNWIrZDBmdkNFTlhkWUZDMGEwaHNsYko5VUJL?=
 =?utf-8?B?THU5S1FZcEtua2NQc1lGK3NIaGIvZnIrVWlFUGVOUnN1ODE4K25MRC83T3RT?=
 =?utf-8?B?MTBVZ1dhc1gwdVYwL3E3VFFCeEtSODduV050QUdLdUR4RVF5WnZqMHJ1ckl0?=
 =?utf-8?B?WTFWTUJFZUU3elcxWk8vS3JydlNBd0w2TnBIUi9FaklxOUxtSXlEcitGOUlU?=
 =?utf-8?B?OTUyN3YrbVU0UzlxbEtHWXJtRnBnNll3OE1sZFpuVjZnZWxxOHpmUHJPaXJv?=
 =?utf-8?B?N3NVOUg5Q2ZnTVJ1aE1SMkVYY3dWT2orNHZ5ODRZako3Y2pVRXUzZ3ZpaE5i?=
 =?utf-8?B?RjRvaDErZG1UOXV2YUFES0NmRG94dDArK3pKUGhseU9mT3R4QVdNSC9BWUZP?=
 =?utf-8?B?Q0h0SXc1N0xzTVdZSHNMbXFyTlZ3NlZ1SjMyTnZSeEo2VFZzWFg2TzV5OG4v?=
 =?utf-8?B?cWJaUHBhQndxQUlzMk5laEl3cEEzK1BQaVNEV1JrQzM5L25QNjdIQkt1YVBx?=
 =?utf-8?B?MkVRQmdxanowVGJzL1ppV3YyNGN2ODVqTW4xOEJKWUdPR0MwOWxySDNUWSs5?=
 =?utf-8?B?bFdHN1VzYk40U2l0R0tvbVZLdGpWQkRvMGl1c0QzK0dLUlVMQVJtM1QvK1Jm?=
 =?utf-8?B?QzAway9rVmdyejhaZFpSb0w0MTQ0T3RDMGVCRjVDR0dZQVZ4TlY2eTljUVdK?=
 =?utf-8?B?eTFqN2VRL0tDSi9WYXZ0L0R5K05ndlV5TUl0bEhPWTBncTk5VjBEbDJyNDV1?=
 =?utf-8?B?b3NCZjlXWmg2QzUxTUpRODdEWUZ4ZXkzMW1rcXVJYUF0cDhLMDRPTVJXc3I5?=
 =?utf-8?B?ME1hVUoxcnQ1UC9KM2pVNVZlQ0wzclhxVE9tU0I5MGhVSW9iMnBBTXNxR3Vk?=
 =?utf-8?B?cTdCMW5Vd1E3aTFxdjh2N1lTTkFHWUl3Z1FuUVJxRFkzK1VWTG5mUnhScFdx?=
 =?utf-8?B?NHFGVkdEcW1xYzRFYWhJUkg3WUI1Nk5idWhpWHo1WGZZQ29YSWFjcnJKUGFC?=
 =?utf-8?B?Y3J3WnJ2SDIxK3o3RkRMRXFMRDFLc3VCempYeGZrSHBQenFGcmR0R0xNT1Z6?=
 =?utf-8?B?SlZZR2hPRlJyUjNrTHcrRUEyR1dVSTVTUXRycXRzY1J2R1NxeXVWUmk5MlVo?=
 =?utf-8?B?dFY4Z1F6dVhqOTRPUVJEYjZUY3hVdHpIZkNJcjdZU0loZmRqaVBvZWp0bEZ0?=
 =?utf-8?B?N2xnL0dYcG5vQi8wTDd1Vlh3eEFzdnZqUzJGOTJJQzVua2NtaEhIYVIvS2Vn?=
 =?utf-8?B?SDhjMzlFRnpqa1BqYUY3UHRJcDdPQks4VGZjbkZVbmVoUEtGUFZ6L05DczNt?=
 =?utf-8?B?cno4RDFxV1o0Tk0vaGJWeXFXMWpTSGFucGo4U3g5UytZbVVFYUtMWHRySXJs?=
 =?utf-8?B?cmQ5WGVnS0dPbU10QkZHRHh3dWZJOWxMTVQyanZTbk80N1JDVGUxdkp5by9N?=
 =?utf-8?B?V1ViRCtMa29qVkdkWUkxWHczQUFWa2dIeG10T1BhNUNMSzZOZ2s2RE1RLzR1?=
 =?utf-8?B?c0NMTkd4OHdIekxNSGpwOW40QXNkV3dXRlV5Q1NJNnFvakJjRE9CQ0tqRGtH?=
 =?utf-8?B?YzBMMXpyUloraXhWNXkxUk15SFk4dVMxQjNNVHYxa2xtaFczclVRVFY1WDBN?=
 =?utf-8?Q?Nj7QMgzM2xnkWAK6eMckcHuKM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8652530FAE62741BD63F84BDD9EAF82@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e317e18-8064-418c-11c1-08dd1b2533d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 03:21:15.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32dH92zUOzlfYE5cybSYHJaQchXttJWfFzMZn3pYOwRmevWRBD12Fk003sJTjoWX8folgG5YHKQAdLxPaZ2w1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6785
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.435300-8.000000
X-TMASE-MatchedRID: fgYTp5XatxYOwH4pD14DsPHkpkyUphL9X4GSJGyYc36PaLJ/Ca3ST4Oo
	YivINRFdt6QHGjMsZdyx1lMnr76Jlc9c9ErzVpH7A9lly13c/gEqE2lNy9t1Qpsoi2XrUn/J+ZL
	5o+vRV7yhMIDkR/KfwI2j49Ftap9ExlblqLlYqXJpdghNIExyvvWLnP5Jp2BTwnoHTVHkkd/poo
	MMGohshpmNT35giPOQtLRiMJFL5suq1syGVIpPeYKdGT0pgscb1hLdr3LDU8LTlUpZZC7qXExEO
	bzAmjLxmmah2h5btcyR4kJbI48TpMNasI8WHmuk
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.435300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7B562BD1E6259E1B0D4C8C4B69457A3F26BC73FAFDF52D3FECD43F8B67D42FB42000:8

SGksIEphc29uOg0KDQpPbiBUaHUsIDIwMjQtMTItMTIgYXQgMjM6MzMgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gRnJvbTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRl
ay5jb20+DQo+IA0KPiBNb2RpZnkgcnVsZXMgZm9yIGJvdGggTVQ4MTk1IGFuZCBNVDgxODguDQo+
IEhhcmR3YXJlIGNhcGFiaWxpdGllcyBpbmNsdWRlIGNvbG9yIGZvcm1hdHMgYW5kIEFGQkMgYXJl
DQo+IGNoYW5nZWQgc2luY2UgTVQ4MTk1LCBzdG9wIHVzaW5nIHRoZSBzZXR0aW5ncyBvZiBNVDgx
ODMuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBB
Y2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEFu
Z2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxh
Ym9yYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdA
bWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxp
bkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgLi4uL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsv
bWVkaWF0ZWssb3ZsLnlhbWwgICAgICAgICAgIHwgOCArKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRl
ayxvdmwueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21l
ZGlhdGVrL21lZGlhdGVrLG92bC55YW1sDQo+IGluZGV4IDllYTc5NmEwMzNiMi4uMGFjZTEyYmJi
NjIzIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9tZWRpYXRlay9tZWRpYXRlayxvdmwueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxvdmwueWFtbA0KPiBA
QCAtMzYsMTYgKzM2LDE0IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAgICAgLSBlbnVtOg0KPiAg
ICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10Njc5NS1kaXNwLW92bA0KPiAgICAgICAgICAgIC0g
Y29uc3Q6IG1lZGlhdGVrLG10ODE3My1kaXNwLW92bA0KPiAtICAgICAgLSBpdGVtczoNCj4gLSAg
ICAgICAgICAtIGVudW06DQo+IC0gICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LWRpc3At
b3ZsDQo+IC0gICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LWRpc3Atb3ZsDQo+IC0gICAg
ICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTgzLWRpc3Atb3ZsDQo+ICAgICAgICAtIGl0ZW1z
Og0KPiAgICAgICAgICAgIC0gZW51bToNCj4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgx
ODYtZGlzcC1vdmwNCj4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgzNjUtZGlzcC1vdmwN
Cj4gICAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxOTItZGlzcC1vdmwNCj4gKyAgICAg
IC0gaXRlbXM6DQo+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTg4LWRpc3Atb3Zs
DQo+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTk1LWRpc3Atb3ZsDQo+ICANCj4g
ICAgcmVnOg0KPiAgICAgIG1heEl0ZW1zOiAxDQoNCg==

