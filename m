Return-Path: <linux-kernel+bounces-514240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0178DA3547D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54E11890EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632CD155327;
	Fri, 14 Feb 2025 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gBydg1Uy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="f4Dfz6H1"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806386324;
	Fri, 14 Feb 2025 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498960; cv=fail; b=kNGrAuS/u+XPXiNl0eYUic+2K9IZtebFGhlkxL8nz0ClZG3KfXApZN2mZ/7n1JdiPg+mo2V/VmX69lXNpxZVpNkmj1K8sDaoztWGqBdkVr8IKoTsFBMfhxgsg1IiT5QmBU9W5tq2dNvf3jOkiffnVj10DPuq1KqNd55ngw6fv4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498960; c=relaxed/simple;
	bh=h4UflJ+5lytUA6os/z/UB38c47Q83qItj7CxLvONRdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJw4F38DnFbARpQay5pTpQf3FaV9gjgGCZWoO30fALJ+RghAkMEBqRefcZn/tx9SSYk1yzGbHpja9tU9fB4cVYkU0x9LDrFvY6oQff0+Qq96e+iRvOs/2METZVOBXLD+5w3uAU5+hED76rCqT9NwKhVrOAnTBxRjPlnQiCzcCzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gBydg1Uy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=f4Dfz6H1; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: aebc089cea7811efb8f9918b5fc74e19-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=h4UflJ+5lytUA6os/z/UB38c47Q83qItj7CxLvONRdA=;
	b=gBydg1UyOgJPPfGCjcWa4zmquDOleHNUOEYxOViWQH9b4ScgfmYd0JTSmkBqCATZRWsY9SyPVGdz7axmN0ur3V796krO9OtOu0DmL3dIq8HVcfVN/N19tfts081sl2FrCjTKg6pGncIfHwDcytAtBQoDqCMeJ1miX0epAwAD0JM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:8da304f8-6201-4f93-88f3-7f93e7e58b2e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:c3048c27-6332-4494-ac76-ecdca2a41930,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aebc089cea7811efb8f9918b5fc74e19-20250214
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 168272094; Fri, 14 Feb 2025 10:09:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 10:09:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 10:09:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+NzEhnkzL1dlmdhdEJBIb/5gkXH415gO4Z/hNPfKtRzi8jwiwvKzYr+S8Gi5V0p3McBGUXvJPVNozr8C434K0liU3VGaYxsGmWr+GvJaZDR5k5LGbiWsVKEngWl9gMNp4SWSU7ZfHLxfeGFE/H+XvHaeQFqd3U9SicnAODZd9Bvy50y8lZ0nkQ6u9PaQusLD7ed4H1tp7QEAwWnnIgOrlGuiiCwTGKSbRNw/l7+o6zsDfwrUY8bds3JjaG6yLNglQlHwedJWcF3wFJnyqozj3VwrvkvvVxlfF9jkUbfTdLWir/paYZ7zJNGtbUURff706CX/0UGURSqv9Y5H6uK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4UflJ+5lytUA6os/z/UB38c47Q83qItj7CxLvONRdA=;
 b=EzkM/gg61lFy8KuNFKRGrwr5XcN1ofspn0633baZ7Fe4FzWmXVHRSsch7lIj76hd0LwjEoBwYO3IxZnUeu7lyWnuEe8vuYp24ywbMrfhDZbfj7m1AggUve681if1PoSpA4kxXbkq/J6B+pKTdGl2PfYvwdOHbX8Djc3dWRZEtJAN8F7Hi8i2J6iw+OeSkMtFJnSxHX2wL5j7rH+jcCVZDD0uKzpLsUaa2CaEQj3BCzPiG5enFohLQWfMfZzJ8OpMdthRnPTt3S28S1K9hFKPcbllRb4oUQeFkQxxM3Q09kmEh7N0YIVxKiuW9qvGGP2PDMOAXdiiK7Gzn/v84K34ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4UflJ+5lytUA6os/z/UB38c47Q83qItj7CxLvONRdA=;
 b=f4Dfz6H1ZerVRBvhs9jaXj22JaI8dzRPkj7xjh3nfGRSfhDd/7XeQh6cAenHwZZJCtWiuAiHo4Hr8xgWxSiE7Tw7eASbc7WM+xIamg8d/ZRR3TIj44YkSei7XZL4GiTNLkmEuaBQzUp7kYXKnm0aJJqgrWJzNTwqNHfNmpYosDs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8240.apcprd03.prod.outlook.com (2603:1096:820:10c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 02:09:07 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 02:09:07 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "jie.qiu@mediatek.com"
	<jie.qiu@mediatek.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	=?utf-8?B?TGV3aXMgTGlhbyAo5buW5p+P6YieKQ==?= <Lewis.Liao@mediatek.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, =?utf-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?=
	<TommyYL.Chen@mediatek.com>, =?utf-8?B?SXZlcyBDaGVuamggKOmZs+S/iuW8mCk=?=
	<Ives.Chenjh@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
	<Jason-JH.Lin@mediatek.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v6 07/42] drm/mediatek: mtk_dpi: Add support for DPI input
 clock from HDMI
Thread-Topic: [PATCH v6 07/42] drm/mediatek: mtk_dpi: Add support for DPI
 input clock from HDMI
Thread-Index: AQHbfHkaFNF6vaQ60kaqYUwrqeW5wLNGEecA
Date: Fri, 14 Feb 2025 02:09:07 +0000
Message-ID: <500ce64dd1f4d0b18289418183011ea24938fe99.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-8-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8240:EE_
x-ms-office365-filtering-correlation-id: 2111ecbf-9ac5-4986-f681-08dd4c9c8ff4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aXVWcXVlNGQzamJ1RzliZGlTeGFWWFJJSWdWSitQdytEMEphSlRhNk9XMmp6?=
 =?utf-8?B?ZDFPUnc2Q1c1ekZ6Yml4K1ppWHRFUUdoZVQyR290c1VnM2JNZURTMVh5aHZO?=
 =?utf-8?B?dDJBdlVQQXo4bytVcHpRN1FpT1RDQVJkS0t2TUpYaUVVTEMySjZqa3F5bVIz?=
 =?utf-8?B?b2RjaFFLYXhpUGVzV3dONzg1N3psQzdVbDc0UDI0bjNjQU5aSlJVK1duQWJj?=
 =?utf-8?B?elhpR2I1VUc1eDRNdGtKWU5oYkIrUXpBaENnQm84Tm5Nb2pIWlZzZjN1cksz?=
 =?utf-8?B?MjNoU1Zva2dOdVdSb3RMbXpZb29uek9XeVk1cVlWaFdDMWJ4ZithTEFua2gv?=
 =?utf-8?B?TDZmdDlkQS9EVmVOTzVSWjdJMDI2cGVQTFpnR2pLS0s1NGhuUEVrRmdJM251?=
 =?utf-8?B?clBlcXRuZHNKMU1VczI0SkFsZk8wbDFRR1RRVGh0cjY3c2duNDBLQzFNdlRL?=
 =?utf-8?B?L1lITG83eklPWnBjNHpHcEFvOEV4R1pjYmVRbVZNeTFMRGRDV0dnMXEvcWl3?=
 =?utf-8?B?UkNOYWhnN3pRa2dIRE1GK0doNG5ENDluV3hSVklPRForU2tmdy91VlNUWjBn?=
 =?utf-8?B?VnpWVjZvSnZ5WmF0RmE0SjJTQlZoeS90OW1VT0loS3dUUjRBWlhxQnArakFq?=
 =?utf-8?B?L1JzTzFIY3VFU1JtdlpSYnl1S2xWTmFhbUNwSHRRWEJNMDlPOVA1WUVwTDhk?=
 =?utf-8?B?SkYyWkNIbGZQZlMzWnYvQTBHYUtrMVNsMjFhN0F6NnNLWGdCOUdrVjVJQzJh?=
 =?utf-8?B?VStlcUZWclp1WWU3bEdWZlhFWTBtUUg0Uk9leFA5MGQwSUNieVoyOGdPUUFM?=
 =?utf-8?B?Y3dkYmM2eTlYcVVIcG03dFhtQlJkRi9VVFppQWsyQ3ZKcko4Z25JY1BRRnln?=
 =?utf-8?B?L2Q3eVg5dlBhaGU0OWRQWk5MT0VhWVVpZTZaTFVZc0Z6N25PRStGMDRIWGJj?=
 =?utf-8?B?cjcxNzN5TzN4VE5XOTBwdTNma0FXNkZodDRudE5wbHNaYlRydzlTbDVqdCta?=
 =?utf-8?B?aXp6WnRhbkZxa2ZlQm9rNmpCSEt1TnU0WGVydlNxZjZocUlETGtHLzd0Q042?=
 =?utf-8?B?TkMwUnFsZGdNQkEvWXRqdEtZTXlJRFl6Qlk2U2JTeU1Oa0NXckcycVdxTUV4?=
 =?utf-8?B?a29kNXM0d3M2YVkyZldFU2hNU0JoZFk2bWVWSjZyMDRzalM0SFFUaDE5RUJi?=
 =?utf-8?B?Q1RZc2wwR2hIYThJdWwybU9DYnh1bU9FV2VZQU8reFNkZUphZHdxd2VFRExk?=
 =?utf-8?B?NUNCb2dEelZ3YTlUMmEvcUJGbEkxZk53VHFwZFF6blFvbmR6MVJyT1V4ai9w?=
 =?utf-8?B?c3kweFo1dGJ2cjN2aFc5WjhkdEFxSHJKbVhIQndKbVdSc1RvNFNEY1RMdHVj?=
 =?utf-8?B?MFAyT2paNG1yYTd1dnowSHV3TUt5a1Zhb1lvYVpHWGpibXNFOEdSYkhuTG1E?=
 =?utf-8?B?UXdWOUFSNEtDK3huTVhnVm9ma203SFN2Z05uaGVsd1p3cjZwTmpjaFVHVy9v?=
 =?utf-8?B?ZmIySnR0UmNQdDN5N2ZpNW1qd1d5QXhUOUV1cHVyMXlrZ3dSa29qbkJFOG5E?=
 =?utf-8?B?UkE2b21iM0pHSXlmcEoxMWJvUHRwK1o3LytmTDBHYmNPWDlNQTJ1SjFUWVpN?=
 =?utf-8?B?ZjBxaEloMm5FVXhwQk8xUDl4eTZjMlIyekkvV2ZLUlNYUEJCZDRWNUIzd2p0?=
 =?utf-8?B?elR5Nnp4SzlzT3ZNdzhlUldIaFpoN0RVTy9FV0RLVnd4MzluRngxQ0lOZGhD?=
 =?utf-8?B?Y0YzcUZJa2tkVmgxTjZhcFJlQkcxVFRRODRjaGZ1VlFCUlZmQUtvM1hHOXdQ?=
 =?utf-8?B?MVpJWnlRa3RURjZXTDB6OGRjcGtrd3Z1aVVrZWJLbzdYUUlVaGVaNndORGxt?=
 =?utf-8?B?a2prVDh6N0pOcWNETGVKRmlLTDFzTkRPYUZvbWhXY0kxeDRyYUp0VFhLVmRl?=
 =?utf-8?Q?7SY8ZldjIIYfdRyD1qi/EBN0FAzQtsGr?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTRQTm5zbFFSam5OMDJXcTNDdGtra0IwV0NqblJQRGcxQlR2a242SEY1Y251?=
 =?utf-8?B?M2hvY1dzWFpqVmpFUk1rN2NEOE1zY2pCSlZ3cG5QOHMxNjNlWkp1aXUxMjBK?=
 =?utf-8?B?SjBmaUMwdmw5K0ZMRWl1cXV6STVKb05uQ3h3bEZpSlBFTjA3ZFV5NHgvQ3g3?=
 =?utf-8?B?aUIxdm1CT1hJSVN5TlkxcWphN2kycE80RHBoSHZiNGhsRDNoM0xRNmJkenpC?=
 =?utf-8?B?czdOcU5sRjhHa0Y4WU5jblVnYnovOTBCQnIzMHU3eXJlZm5TeW13ZzhIRWZN?=
 =?utf-8?B?aU02ZzhTSWlWVEdiQStCQjFJNWhNd3o3SGQ0MUpqYnVKbDI0bm1MdlF4eDJC?=
 =?utf-8?B?SnJ3WkovUjYrRnZIUGtNSVh6aFdQREdSM1lKeFlYalZHSjFwQTdMNzdObnIv?=
 =?utf-8?B?YWZQWFpuU2FkZE43aVJ6ejJSdXQrSk5QQXordkRhQ2JndzRLU25ocE9jbUVh?=
 =?utf-8?B?ZlB1TjNlWnFvZzBRWFVxN2d0enlYb0tGSm5uaEdibmZjY1NnS2VYbmpSKzRH?=
 =?utf-8?B?Y3FSZ0swNUN5Z1hzendjTmtnZ213dG1GZ2toM1JVdE5PSFl5UmJ1YTJGSmlD?=
 =?utf-8?B?MDhGQWRndnRIOUFqTmtrMFVIR3pLcFRXWnMrN1d3d0FEOVJ3cWMrbW1vbVZG?=
 =?utf-8?B?ZVZzVVRWY2Z2cnRQamhwRyt6TXhFSDBiRTZWOWFobEVQeFd3SW01U0gxaWk1?=
 =?utf-8?B?TFJ0NStGSUluUytYeFV4M0doQUNrSjY5U2RHSWczNHZrZHJKandwc3dZYU9o?=
 =?utf-8?B?L1pxbDN4TDJnVVdyWE16bGI3SEwrNTFZV2ZGNVJyYmNuSDdIZGVVdVVDZ0pV?=
 =?utf-8?B?bXlKM3FTNjBIWnJPdVZiVGVPUGJsTm9sNUkwSDY3ZkNyRFB5NlZrNmtwWlVJ?=
 =?utf-8?B?dWJBNkorTjVTU1kyTGhUbmFmdG03UjBBSStJV050d1djTUZ5WnhRTWhjUGpT?=
 =?utf-8?B?SEY3NGZNWVVJMDVaLytmTWw5Uy9KSkdFYmh3dGIrNktwYVN3Rm9uMnU4KzA1?=
 =?utf-8?B?cEo2QzBDT1V0NW1rbnhmTW8yK003Z01UNWZha0R3dHlhNDM5U1o1ZnI1RUZm?=
 =?utf-8?B?SGt5SVdVVllyNjBwZXlUT2w1MUEvRFh1Um9La0w2a3V2bUtHb0lqcTBpMzJi?=
 =?utf-8?B?WlA4MTI5NXE1dU04eVV5UzdwL1hmSm9KdGhNdVZYTjFzejdMSXZPS2JrOGVp?=
 =?utf-8?B?WW4wTzM1Ri9VSkE5aW1WakoweGI0N09NY0xIN3JqMk10QklsMFFmTktqRXkr?=
 =?utf-8?B?aWcrSkZiaWl3aHRLbEpQZjRaNko5OStsV0xwSk12eTB6anZCeitZTXNRUDlH?=
 =?utf-8?B?KzNUNGp6Y3cvdjdJdDZMYjE0QzV3eVJvNzJCVHJrendZbzlmdzRIbkhBSTlR?=
 =?utf-8?B?QytmcXNhc0NWMTNVTmsvOUU0Q015NUEyVGQxNTltWk9PQlZvN2ZFTExEOHQr?=
 =?utf-8?B?d3kxR2kzU0JyR3U4R2Y4OU9VdXc4cXhzYXNkZDRwa0pZbE9DQy9pYy83WHFO?=
 =?utf-8?B?SHJLREZZSmNDZ2IwalR3eE41dXUwSmtLTFFXRDZCZnJFSU0yMmhBbXFzUUcw?=
 =?utf-8?B?aW9JWDVmUHk5UXJVZUNzbjlIWHIxT1FXd0FWZjhwVG11L25pZnFnbHg3UlNI?=
 =?utf-8?B?Rmd0cktPWUdheko5Uzc1VzV1cHdBWXdZQWlLNW1ReU5uWURudmZQV3Z5RHc0?=
 =?utf-8?B?ZEZrbEFKTUM5MFlXTXFtV2JhczY0c1VYL3BiTzlJR2xOYWphQW9OUFBiV01G?=
 =?utf-8?B?bEJhOG92RmQ2WTgyVnBQZE1XSzkwWDJ3d0dCcXpBUElTbTJBb2luYkVSREx1?=
 =?utf-8?B?NncvblJKMTVvQ29Oc3RMTVJkcXVaa0QySGRCSGF1dHVQQU1ocFRUUEJYYVUx?=
 =?utf-8?B?c1RpQ0h0SVNLVDBONFZ4M0k2SHNELzJUU01uR3h0RVdIdUpDOHlRZ1Z3U1Ns?=
 =?utf-8?B?dUVXaUdUWlBWVXJTd1g4UEJHRGdDMWZqZmFOVy9TMkJQOWhyL1JHNVQ5elEy?=
 =?utf-8?B?cXJKOVFDTnVwbU9aTS90V0ZTblpGN0YxbFYycjhqQjNySVVNSkZCWkZWTmxk?=
 =?utf-8?B?YlAraVhkNE1vWGM0UDdKdU93WHJYWmdTdFVXQU44cktGaCtEc3Zta2FCaU9y?=
 =?utf-8?Q?Hc4rCmZYKkTCuC45/gGGEp2Sx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72A60AAEBEEC9749B7197BC15E44E9F4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2111ecbf-9ac5-4986-f681-08dd4c9c8ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 02:09:07.0262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1FerPmpE8mkVXXYstP5pdegeEJqBn1rrhNkz+cw3XQP9ogW2SYqYdOOuTQ30v9qHMwBWZAyQzUrOw/a+ikpzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8240

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjMzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiBzb21lIFNvQ3MsIGxpa2UgTVQ4MTk1IGFuZCBN
VDgxODgsIHRoZSBEUEkgaW5zdGFuY2UgdGhhdCBpcw0KPiByZXNlcnZlZCB0byB0aGUgSERNSSBU
cmFuc21pdHRlciB1c2VzIGEgZGlmZmVyZW50IGNsb2NrIHRvcG9sb2d5Lg0KPiANCj4gSW4gdGhp
cyBjYXNlLCB0aGUgRFBJIGlzIGNsb2NrZWQgYnkgdGhlIEhETUkgSVAsIGFuZCB0aGlzIG91dHB1
dHMNCj4gaXRzIGNsb2NrIHRvIHRoZSBNTSBpbnB1dCBvZiBkcGlfcGl4ZWxfY2xrLCB3aGljaCBp
cyBlc3NlbnRpYWwgdG8NCj4gZW5hYmxlIHJlZ2lzdGVyIGFjY2VzcyB0byB0aGUgRFBJIElQLg0K
PiANCj4gQWRkIGEgYGNsb2NrZWRfYnlfaGRtaWAgbWVtYmVyIHRvIHN0cnVjdCBtdGtfZHBpX2Nv
bmYsIGFuZCBjaGVjaw0KPiBpdCB0byBhdm9pZCBlbmFibGluZyB0aGUgRFBJIGNsb2NrcyBpbiB0
aGUgbWVkaWF0ZWstZHJtIGludGVybmFsDQo+IC5zdGFydCgpIGNhbGxiYWNrIChhbmQgYXZvaWQg
ZGlzYWJpbmcgaW4gdGhlIC5zdG9wKCkgY29tcG9uZW50DQo+IGNhbGxiYWNrKTogdGhpcyB3aWxs
IG1ha2Ugc3VyZSB0aGF0IHRoZSBjbG9jayBjb25maWd1cmF0aW9uDQo+IHNlcXVlbmNlIGlzIHJl
c3BlY3RlZCBkdXJpbmcgZGlzcGxheSBwaXBlbGluZSBzZXR1cCBieSBmb2xsb3dpbmcNCj4gdGhl
IGJyaWRnZSBvcHMgYmV0d2VlbiBEUEkgYW5kIEhETUksIHdoZXJlIHRoZSBIRE1JIGRyaXZlciBp
cw0KPiBleHBlY3RlZCB0byBlbmFibGUgdGhlIGNsb2NrcyBpbiB0aGUgYnJpZGdlJ3MgcHJlX2Vu
YWJsZSgpLCBhbmQNCj4gRFBJIGluIHRoZSBlbmFibGUoKSBjYi4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25v
QGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cGkuYyB8IDEzICsrKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+
IGluZGV4IGFkMDcwMDVhZDU2ZS4uNjQ5M2M3ZTJmYWU0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHBpLmMNCj4gQEAgLTE0Niw2ICsxNDYsOCBAQCBzdHJ1Y3QgbXRrX2RwaV9mYWN0
b3Igew0KPiAgICogQGlucHV0XzJwX2VuX2JpdDogRW5hYmxlIGJpdCBvZiB0d28gcGl4ZWwgcGVy
IHJvdW5kIGZlYXR1cmUNCj4gICAqIEBwaXhlbHNfcGVyX2l0ZXI6IFF1YW50aXR5IG9mIHRyYW5z
ZmVycmVkIHBpeGVscyBwZXIgaXRlcmF0aW9uLg0KPiAgICogQGVkZ2VfY2ZnX2luX21tc3lzOiBJ
ZiB0aGUgZWRnZSBjb25maWd1cmF0aW9uIGZvciBEUEkncyBvdXRwdXQgbmVlZHMgdG8gYmUgc2V0
IGluIE1NU1lTLg0KPiArICogQGNsb2NrZWRfYnlfaGRtaTogSERNSSBJUCBvdXRwdXRzIGNsb2Nr
IHRvIGRwaV9waXhlbF9jbGsgaW5wdXQgY2xvY2ssIG5lZWRlZA0KPiArICogICAgICAgICAgICAg
ICAgICBmb3IgRFBJIHJlZ2lzdGVycyBhY2Nlc3MuDQo+ICAgKi8NCj4gIHN0cnVjdCBtdGtfZHBp
X2NvbmYgew0KPiAgICAgICAgIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2ZhY3RvciAqZHBpX2ZhY3Rv
cjsNCj4gQEAgLTE2Nyw2ICsxNjksNyBAQCBzdHJ1Y3QgbXRrX2RwaV9jb25mIHsNCj4gICAgICAg
ICB1MzIgaW5wdXRfMnBfZW5fYml0Ow0KPiAgICAgICAgIHUzMiBwaXhlbHNfcGVyX2l0ZXI7DQo+
ICAgICAgICAgYm9vbCBlZGdlX2NmZ19pbl9tbXN5czsNCj4gKyAgICAgICBib29sIGNsb2NrZWRf
YnlfaGRtaTsNCj4gIH07DQo+IA0KPiAgc3RhdGljIHZvaWQgbXRrX2RwaV9tYXNrKHN0cnVjdCBt
dGtfZHBpICpkcGksIHUzMiBvZmZzZXQsIHUzMiB2YWwsIHUzMiBtYXNrKQ0KPiBAQCAtNTg3LDcg
KzU5MCw5IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlzcGxheV9tb2RlKHN0cnVjdCBtdGtf
ZHBpICpkcGksDQo+ICAgICAgICAgc3RydWN0IHZpZGVvbW9kZSB2bSA9IHsgMCB9Ow0KPiANCj4g
ICAgICAgICBkcm1fZGlzcGxheV9tb2RlX3RvX3ZpZGVvbW9kZShtb2RlLCAmdm0pOw0KPiAtICAg
ICAgIG10a19kcGlfc2V0X3BpeGVsX2NsayhkcGksICZ2bSwgbW9kZS0+Y2xvY2spOw0KPiArDQo+
ICsgICAgICAgaWYgKCFkcGktPmNvbmYtPmNsb2NrZWRfYnlfaGRtaSkNCj4gKyAgICAgICAgICAg
ICAgIG10a19kcGlfc2V0X3BpeGVsX2NsayhkcGksICZ2bSwgbW9kZS0+Y2xvY2spOw0KPiANCj4g
ICAgICAgICBkcGlfcG9sLmNrX3BvbCA9IE1US19EUElfUE9MQVJJVFlfRkFMTElORzsNCj4gICAg
ICAgICBkcGlfcG9sLmRlX3BvbCA9IE1US19EUElfUE9MQVJJVFlfUklTSU5HOw0KPiBAQCAtOTIy
LDE0ICs5MjcsMTYgQEAgdm9pZCBtdGtfZHBpX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
IHsNCj4gICAgICAgICBzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+IA0KPiAtICAgICAgIG10a19kcGlfcG93ZXJfb24oZHBpKTsNCj4gKyAgICAgICBpZiAoIWRw
aS0+Y29uZi0+Y2xvY2tlZF9ieV9oZG1pKQ0KPiArICAgICAgICAgICAgICAgbXRrX2RwaV9wb3dl
cl9vbihkcGkpOw0KDQptdGtfZHBpX2JyaWRnZV9lbmFibGUoKSBhbHNvIGNhbGwgbXRrX2RwaV9w
b3dlcl9vbigpLg0KQWRkIHRoaXMgY2hlY2tpbmcgaW4gbXRrX2RwaV9icmlkZ2VfZW5hYmxlKCkg
YWxzby4NCg0KPiAgfQ0KPiANCj4gIHZvaWQgbXRrX2RwaV9zdG9wKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gZGV2X2dldF9kcnZkYXRh
KGRldik7DQo+IA0KPiAtICAgICAgIG10a19kcGlfcG93ZXJfb2ZmKGRwaSk7DQo+ICsgICAgICAg
aWYgKCFkcGktPmNvbmYtPmNsb2NrZWRfYnlfaGRtaSkNCj4gKyAgICAgICAgICAgICAgIG10a19k
cGlfcG93ZXJfb2ZmKGRwaSk7DQoNCm10a19kcGlfYnJpZGdlX2Rpc2FibGUoKSBhbHNvIGNhbGwg
bXRrX2RwaV9wb3dlcl9vZmYoKS4NCkFkZCB0aGlzIGNoZWNraW5nIGluIG10a19kcGlfYnJpZGdl
X2Rpc2FibGUoKSBhbHNvLg0KDQpCZWNhdXNlIHRoZSBjbG9jayBpcyBmcm9tIGhkbWksIEkgdGhp
bmsgdGhlIGNsb2NrIGRlZmluZSBpbiBEUEkgbm9kZSBpbiBkZXZpY2UgdHJlZSBzaG91bGQgYmUg
cmVtb3ZlZC4NCkFsc28gY2hhbmdlIHRoZSBiaW5kaW5nIGRvY3VtZW50IGFuZCBsZXQgdGhlIGNs
b2NrIG5vdCByZXF1aXJlZCBpbiBNVDgxOTUuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICB9DQo+IA0K
PiAgdW5zaWduZWQgaW50IG10a19kcGlfZW5jb2Rlcl9pbmRleChzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+IC0tDQo+IDIuNDguMQ0KPiANCg0K

