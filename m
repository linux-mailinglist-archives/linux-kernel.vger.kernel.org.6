Return-Path: <linux-kernel+bounces-385262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7A89B34BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC3E282740
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8FD1DE3D0;
	Mon, 28 Oct 2024 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ppjQI54S";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ONOYQb2h"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310351DC07B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129171; cv=fail; b=h0USdhJDAUBBiMJPtijkf1WGU/yJCg2FEMNk2JAXX3gXQQRb543fLpO3bCcw5ADPZPhjGs3ZB2fW+aZXGfNx4C53LEcy1fbWv4Rl2vxQWlvRc999xeH8F+m3Vt1f5kznk80FvutMttvva2O2Kgb8OYyghz93cEKm2svGBVZYQdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129171; c=relaxed/simple;
	bh=slDlURqNAZgnWBhcHL7h13UMJpYsooCmrGxImD8Il20=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1a52BsKcDNsclJEPBIYMThjm/zdcmTQR2yqrvIsvICNJvXwdMABG6xyE0ia9LAx7yM3vA6Pt+mQfGin3H376YqB63fcaLdyHDFq/mGdD7l1XZ8wGy9R3We9aVLY0DJYmfAsdWdpJFwoGVOqghbeshUETgNiYzXk+S9UhuEMaeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ppjQI54S; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ONOYQb2h; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f164c7b6954011efb88477ffae1fc7a5-20241028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=slDlURqNAZgnWBhcHL7h13UMJpYsooCmrGxImD8Il20=;
	b=ppjQI54ScM+uxdtm36PcUolORPLKBdb78YJXuiDsxswrzih4PFygiwh1pUk77EzgYuFqxNdjtZ8xU8euiPnSrs+Jl8Ep3R0D8UlaM5DpqNZcYEhdXk1a6PTMUXTUe59X3TrF69nmHgZvGbBFDkXBdKbQgosEpsQFoeJiEIxKtzg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:e293235b-0da9-4b3f-9b3f-441daf8b485d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:94bcf441-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f164c7b6954011efb88477ffae1fc7a5-20241028
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 803974670; Mon, 28 Oct 2024 23:26:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 28 Oct 2024 08:26:02 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 28 Oct 2024 23:26:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynN49N0Sth/8xPqGtgKYUh8hHtjb76u1UcuA9DQBhbPuZMs4N2UnjY5rURaZwNfXRkvHLdPiu5qjjMRTrYb82MlIr4L3InCbLHKMBJbuDGKcwl4XXFel/aOFmNy6pF+XTdV62sUGVfWNu/Xpj5tbylb3MOlwMVJF/nmZJ2HTyy3n4IDZWQDVf4lti/aUOtapm4e8M9/TQizlSUS856G1rAl6iOpEGvsV76T/HhmylXQnncuHl9nHqQ4YVwHwEsy/F230j1y3JWhlYOjFBgEOP7GNTVK7qnPyxOH16XAYXlT2Y61CNlf1WeSddTiYyHq4fR+yX2ZzGtXGfJVLTpRMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slDlURqNAZgnWBhcHL7h13UMJpYsooCmrGxImD8Il20=;
 b=nUQsA01BOuC8z2fKHvc1n8zaWqDkZAWd0Gyp1Yw6KrpKerZhyKwsKfdabNVpnIDw9AZ+gm+z6oAx+hqlHDKTOeAqhksAk4UqyLQcHwtEm4/OHx8HmkpPjks9a9NxI38JTqQLuJYP96BklyHb1qWUPzmrWbzT+21v6hCLrVjQTP4wps8Hnd9Qt2jILON9YXA8kS8Uq1UzdO0PXdw8iXEuKsrB7Xc2Xd7XEDkDhtpjsP5PzX2oNem5+cu99StCBK6uLIxAaKVpSLU9FX5WPqqA0aOaJBrBQJITDmwKmzN2RHTcObqhCfVUe4hvvEZuY+QgamqdOpASX0KoU3xFeMquag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slDlURqNAZgnWBhcHL7h13UMJpYsooCmrGxImD8Il20=;
 b=ONOYQb2hxsCbxNiEv42v7RO5AZnrOohF4pJjeBxyJqW+AFHweBMQWjg4DocZpZP8BIzAmCoFoLBFA1W9okFlA4xxBdZuNQU81zJZdyqRCh33Q2aGTk9pxHlb2qT0nzNmAdyqW236Ba7/YQu9nFn+Zz0OQ72nItq/r5XmUrOnBIs=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TY0PR03MB8197.apcprd03.prod.outlook.com (2603:1096:405:1a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 15:25:59 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:25:59 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"acelan.kao@canonical.com" <acelan.kao@canonical.com>,
	"chengminglin@mxic.com.tw" <chengminglin@mxic.com.tw>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"vigneshr@ti.com" <vigneshr@ti.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "richard@nod.at" <richard@nod.at>
Subject: Re: [RFC PATCH nand/next 0/4] mtd: nand: spi: Add CASN page support
Thread-Topic: [RFC PATCH nand/next 0/4] mtd: nand: spi: Add CASN page support
Thread-Index: AQHbIvPeZSyVhSH6jEWOSv7DrSm/prKcVXeA
Date: Mon, 28 Oct 2024 15:25:59 +0000
Message-ID: <e8c1ea093943141b431d8eb3ed3831c50601dfb1.camel@mediatek.com>
References: <20241020132722.20565-1-SkyLake.Huang@mediatek.com>
In-Reply-To: <20241020132722.20565-1-SkyLake.Huang@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TY0PR03MB8197:EE_
x-ms-office365-filtering-correlation-id: 95e949be-9d66-4575-0fea-08dcf764d331
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?T0xYcDlGV0tsY1ozZGJJVG5BdnZPd1cvYmlWR1VDM09tSE95ekE0NDlxTy9H?=
 =?utf-8?B?WnZZY25JY0Y5RGMrV25LL1FIU0h2cG43dklVTHlMZU1FbE53MU5Va1dab21Z?=
 =?utf-8?B?QzROVFQrY0dmcFQxd1VWYVVLck9PZURNK2pPY1ArUmpCcEJnLzlaSldGT3lQ?=
 =?utf-8?B?MlhwMFpUb0FtSkMwaTN0VmJHVkdONytkd3hxdHE0MlFpNDdTTTVwZWduTHhK?=
 =?utf-8?B?WjRIOUxwVzJlb3FKVS9rejV3TTdPRkI1MXRVSnlCS0E4NlpnbzVraEJNeDB6?=
 =?utf-8?B?ZllhbkxjRGJCR3RzMlJGSHVPNldwcTJnY1RJVFdvNUMzNFh1UkNoa0dUNnJ1?=
 =?utf-8?B?dExtNEhjaXBneFBRaEJIT2R3dkdlckZjUjk3RUJmclRlcWZUZkwyMGFvaGtO?=
 =?utf-8?B?VUNvOXZCUERESkhiTDY2NmJoSVMvRHdyWTB3WDZxN0pRNkg0SVVDVXZYajlU?=
 =?utf-8?B?T3hnakVVcFVHTUZYQWFMd0dmVGJjbVZoNS9RbGlsaXRTM2hQNVlnRzdPZzkr?=
 =?utf-8?B?Uk4wN3VJNlprVFJjUHQ1ZXhvSDNaS0RIaDJiM0JtM3FYL1VsbCtxNEtOUHoz?=
 =?utf-8?B?Vy9pTHJiYmREZXhxRHRyalpaTnhqcGRFTUZQWEhRTENidFhSWFhHVTQ0SHl3?=
 =?utf-8?B?ZTRuTlhaVS9HRnJUNXVLTnhYS2daTi9JRFFaTEs4aHFBK2V1b2VrTy9wSEU0?=
 =?utf-8?B?Q2RWalVIWTdISTlUbjhVZi9uZHVuS3QxT3RGL3RkWCtxQ1ZRaXFGc0hqVjJY?=
 =?utf-8?B?NHIxTVIvdFlaWmdqeVlhUjhXazZmL3ZkcW0xT2ZKL0piMm5FZHJtOHRlWGlK?=
 =?utf-8?B?SURSTjZMbVRQczJKQVpzT08rMzNqNjQ1REIyWEV0TEM0blZXOFN3VlpJQUh1?=
 =?utf-8?B?V1VCaGk1Z1dyN0U4NkpXOXNzSVBKU2RiTDdYdHA2U0d2TU1ocnpJMVNCZXFD?=
 =?utf-8?B?dWJrRmpDdVQxeG9CY0c5RkhrZ2NMVTdHenJYZGNZMkk2emNKeFZzL3dHQ043?=
 =?utf-8?B?THh2dmV3ZXpuMDhpTzAwRjRZU3RYVnhuTFpySzZQQkVvbUVkZEhEb3VyVU1t?=
 =?utf-8?B?T0FibThyNms2aUp4dS80alR2bmtvOUlzQk8vWGNkekI0NG12b1IxNXp0a29M?=
 =?utf-8?B?U1RiTGtFaW4rT003MW16cmZKV29WeVEzK2tuUXhXMzVmOHlURmdGRlYreXdJ?=
 =?utf-8?B?RGs0aSszTzZrYUxXRFJycDQ0MlJRZ3R1aG82QVozV2l2N0hzMEV3bmhnR1cv?=
 =?utf-8?B?TGxES0lSendheE1QazJGUGhqQjRTQzVCc2QwK2RCL1dJd2VGeU1kSHNSNFhz?=
 =?utf-8?B?TSsydHowU1pKUzl6c2psb1d3TEc2cjNlSlZZRUtaOVFuYWVTVU1sQi96a0ZL?=
 =?utf-8?B?bThXUG9QY1FzRkNZSjlZOC9RdGhUSTF5dUFZM1l4UFRLbmdLaUw2Z2xpcTB0?=
 =?utf-8?B?NGcwM2g2d3ludFptT21peWdmZExSQU0rUS9SbDZmazdEV2FGOEVqTmVnS2gw?=
 =?utf-8?B?M0hSK05Cb1lKeGpRejBkaUdVN1RNdk82N1JiMUo0OFJST2xDWC80MXNjbTJU?=
 =?utf-8?B?emlYNFdJUTFTeDVGLzN2bGxHQXJHUFhsZ2RBSW9LMnMrbTRhL3FUaHNodDdK?=
 =?utf-8?B?YXhYckJqdEozMm5TREJtTlRjZUVSR0VJNUxibElUSzRpS2RBd3VJRTJnOTdr?=
 =?utf-8?B?RDZ4N1FFRlhEcnp3aUVsVXVJOGY5dUhYdUxJZDgzbmk1eVdtWUhPRVdjMWlu?=
 =?utf-8?B?Y3NUTjNDbXVrQkt1a3ErY3RhMHFkb1dCcE1ZYkwyRzRoYy8wZDBMQ01jNnlx?=
 =?utf-8?B?TFdRVlc2REhYWmQrd1FpTWY1ZzR5QzVzandHVHFieDRXY1hJVmtLN1R4cm50?=
 =?utf-8?Q?Htt/SQDq5wZ34?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V055d1NCVWYzcmNZQVUrYW81YnMxMkhEK2hPK0E1T1lMZ1ludnd0MXdzSDJl?=
 =?utf-8?B?OXpkMnc4ZVZiTXhkWTRRcGV1d1JWc3pHdW8ybXVtZkdzaEZCNk00eEtGRU56?=
 =?utf-8?B?bi9reUFtSjdkT2ZnalpkMUlldkRGZll3emxXSW5Fbms0dnhWWDU3d3ZHemVU?=
 =?utf-8?B?eW9kVldlTU1PUGpoTDdaWDJqZndDLzNlTld2cTFKZi8xWEszcm1aWHZNZmNN?=
 =?utf-8?B?S2dEeEhSZmlBTHhqaE5ISW9PRDhvckNOWGpTTjJLcktOL2VKcmxsdUNETFRp?=
 =?utf-8?B?b0NGMmpuanpsdTNRL3BHR3lXVnAxQkhGT1JSZjVQR2YrQjRpMTVXQnpQVXpZ?=
 =?utf-8?B?OHduRjNtT1pRMHVpeVBMdDR4M25lVGV4QVJON08wNE9aNG45Ymp1VXdaTENj?=
 =?utf-8?B?OHJoUlVORDQ2eGV4WitZdVltVWdRbTRmbVFsTnBtT0U4MjhMYzJLdm9nZ1p0?=
 =?utf-8?B?Y2NDMDZUclFtYi8rUXdtT2RsOFNLQXgrOEM0enNUVmgxSFdJSUFFWnNYbzZj?=
 =?utf-8?B?MTlTRS9JRkNFK0VDd0Rkc1lXQ2lSMjlYcnAxQURZV2hCUDVQY2RFMXlqMGxk?=
 =?utf-8?B?UnpoZWs4RWFiZ1RCaldxeXR0Q29NczNvNGxaVitVelhNdXVZWHZ5T2owKzBM?=
 =?utf-8?B?UVFMK3c1TTVkL0NHdXBDQk81akdzaVcwOFZMa2J3dTdXcytPYXF2N29VWUxC?=
 =?utf-8?B?aGpOMW9HYXNqR2J4RC8rOE5PZnprUmhqV1dCTTlzTU1YdWt5dkJBaHZ2UG53?=
 =?utf-8?B?MmlBbXhFYm94RWdFbTYzUU5WV3R0QjY1OXpnSVU1L1ZsTE9mOVk1ZFJ4QU1K?=
 =?utf-8?B?aDhkR3ZzbG1iNDcxdk15SndkYmdtTThOeHp3dFJiMTUvUUpVNWNhRjNETGlX?=
 =?utf-8?B?amJxaVl2WTZRMWFlUVBVK0lXZU50MVFucllLS0lUTTl1VHIvZWk1MmVlaDRS?=
 =?utf-8?B?Y3dUU1VrTjVienJIK3RqL3ZCbWRZbnVuZXRvVWd0WmFGc2Z0N21oRjB2ZUZq?=
 =?utf-8?B?eVpDN3lHYlNPWkNJYzh0TERkN3poNlNFbEUyNDN2L2VDS1kxQ1Q0S3FZOU9l?=
 =?utf-8?B?a2VwWEVnbmZpT1d2MTVqSnFJYU1NTlpLUWdSQTZTMFVpTStaTkpNVUJUUzli?=
 =?utf-8?B?eFN0UVpFSUphNkZybjl1S0xXOWdVUUJ1bm1SWDVyRXhtTXJiK1FhTmY5S2FG?=
 =?utf-8?B?YTMvYnFCSXNWdGo2aFBOVHMwV2pKTStOZlRxVjRaWEwwdGtCbDErNFRCZ1Ji?=
 =?utf-8?B?aTBmLzJ6cE1oQ0VWRExyV3F3QmQzMFIrTmtJSC9IZ0k0OGx1MnhpM25UblF2?=
 =?utf-8?B?WHJHckNKcmE4Q010OHdsb0NkQlVUMzduTHRsOWoybVRnUExmQkNEMTRieHR6?=
 =?utf-8?B?TzY1SVBGYkp1M1d3UlZBMzJ1cE9XNDFWQlhzY1V3MzlCdHh6ZXphaHJOV0xj?=
 =?utf-8?B?aGVFeFZaZURGOWZoQ2RhVnlta1RadmhRL3FsdWZjTFhKNHpmMTRFVklQMVYv?=
 =?utf-8?B?Q0dxKzUzanJQN01sQUJ5K1hYQUhyOVlZZGZ0M08vVFpKN21kR1NLSnNNREFT?=
 =?utf-8?B?UkVWYWRXWlZEQndOR3phemhxVW9LNndjK2JwemJUenE0Rnk0MVk1cTVNeE0y?=
 =?utf-8?B?SW83dkxrb3BjSmlnOThZUVo1L1BURklZTStDeVM2VHFQdGdOOG02alpGTmFX?=
 =?utf-8?B?T3JUUGVXeURrZGxCRXF5dUtCdDZLRnhBcUl6eDk1MTFuelBEV2dyMVVtVzZB?=
 =?utf-8?B?U25XUmEyeUdRdlhHSUZsWndhWDBkT0o3YVljeEkzTkpFeTV4U2d0MjZYUHZK?=
 =?utf-8?B?a0lObkNlUFFaTUlmd1Z4UWtUOGZxVThNbm5aN295OUtJRGVwN3J4SFQrNXBo?=
 =?utf-8?B?cFNLNENkaWl0dHVlZGhrVDBEb0Ezc2hoNnRnVzBlVHN2bzhmY3A0a0xmMVp4?=
 =?utf-8?B?dVI4V09tdmpvb1JRV1F3ZXNKY2NhWmZhL1FmNkJidG4yMWFPSFV4M2hjMytq?=
 =?utf-8?B?eVNkdDFiRlJMS3h3cHVRWnFqYVJaQ3RXdGtpR2tsZ2NoSU91aDR5eituaktK?=
 =?utf-8?B?R2hzRm5FVVo4MU13eWZsUjk4WFJhYkVmZ3B3cjQzd3VGQ255M1huTkdRS2VV?=
 =?utf-8?B?Vy9lVHBJdklQcjgyYnRaYVZoV3hYVW91QkZnVk4vQ2pGaUNTVkkvQ0tHbXhj?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B37B1BA5F46464AB5F771522F653BD9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e949be-9d66-4575-0fea-08dcf764d331
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 15:25:59.1626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9rS66EJ+/76mVrsSFUEQBLk2d4Uanqt0D40Z1q9GESJBmMwzAsLLUsRAvni6xZyCptX8Vd3d+lxInjtc+JA4ZZCvjPAgAw3Fy0NHenwXII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8197

T24gU3VuLCAyMDI0LTEwLTIwIGF0IDIxOjI3ICswODAwLCBTa3kgSHVhbmcgd3JvdGU6DQo+IEZy
b206ICJTa3kgSHVhbmciIDxza3lsYWtlLmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IEhpLCB0
aGlzIGlzIFFpLVplIEh1YW5nKFNreSBIdWFuZykgZnJvbSBNZWRpYVRlay4gT24gb3VyIHJvdXRl
cg0KPiBwbGF0Zm9ybXMNCj4gY2hpcHMsIHdlIGhhdmUgdG8gcXVhbGl0eSBsb3RzIG9mIFNQSS1O
QU5EIGRldmljZXMgYW5kIGFyZSBlYWdlciBmb3INCj4gYSBzdGFuZGFyZCBzbyB0aGF0IHdlIGRv
bid0IG5lZWQgdG8gbWFpbnRhaW4gdHJpdmlhbCBmbGFzaCBJRCB0YWJsZQ0KPiBhbnltb3JlLiBJ
IGFsc28gbm90aWNlZCBhIHRhbGsgaW4gMjAxOSBFbWJlZGRlZCBMaW51eCBDb25mZXJlbmNlLA0K
PiBNZW1vcnkgVGVjaG5vbG9neSBEZXZpY2VzOiB3aGF0J3MgbmV3LCB3aGljaCBtZW50aW9uZWQg
Ik9ORkkgZm9yDQo+IFNQSS1OQU5Ecz8gTWF5YmUsIG1heWJlIG5vdCIuDQo+IA0KPiBTbyBlYXJs
aWVyIHRoaXMgeWVhciwgSSBwcm9wb3NlZCBhIGJvbGQgaWRlYSwgQ0FTTiBwYWdlIChDb21tb24N
Cj4gQXR0cmlidXRlcw0KPiBmb3IgU1BJLU5BTkQpLiBJIHdvcmtlZCB0b2dldGhlciB3aXRoIHRv
cCAzIFNQSS1OQU5EIG1hcmtldCBzaGFyZQ0KPiBmbGFzaA0KPiB2ZW5kb3JzIGFuZCBvdGhlciB2
ZW5kb3JzIHRvIGludGVncmF0ZSBDQVNOIHBhZ2Ugb24gdGhlaXIgU1BJLU5BTkQNCj4gZGV2aWNl
cw0KPiBpbmNsdWRpbmcgYnV0IG5vdCBsaW1pdGVkIHRvOg0KPiANCmdlbnRsZSBwaW5nDQoNCkJS
cywNClNreQ0K

