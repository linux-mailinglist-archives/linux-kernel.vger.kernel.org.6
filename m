Return-Path: <linux-kernel+bounces-512529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A70CA33A87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958731884B30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C64320C03E;
	Thu, 13 Feb 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BZqHyYdQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ERyQI/HB"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826E35944;
	Thu, 13 Feb 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437316; cv=fail; b=PE7YhhCmGskLiPZUbP2oNrp/ASkwE5Ip8S7uqh8w6UPNu4qfy8wok3n+ePokO4OYj/y7OUV4WARATki3RiisODUnXZUBGdROX8iY/AQD1GOA6dLtq2v0stjwvTOcvw27IOfDqjCA7dZVYubez5dg7sYW+n3105EetZ/v+HP4MWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437316; c=relaxed/simple;
	bh=oHg1FsUiKWghqfdyCzWqK1+FBf2NWcLBUvxQ3PTQJwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NBOYUORYjxCOwMW/WTKY3wpP3ZkRQ4MW3XlxpyX+v59TfSY1HSAsNSP1e3ywHzaDmJeq6iWQLX+85z3rfKNg7ZUOxFtUm85tTqfn/oa2azcdmssMzHOmuc9vKowcKrZTE8H9ZWox3us9g9lL29a2u8EvamliTOYbvbTlYW/OfMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BZqHyYdQ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ERyQI/HB; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 281377f6e9e911efbd192953cf12861f-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=oHg1FsUiKWghqfdyCzWqK1+FBf2NWcLBUvxQ3PTQJwg=;
	b=BZqHyYdQh3+8netevAqNvBTSEBUnEKa6sbP+TJIhTdCCj8DSjltAW3TtqO+IJE9pyMn9Os/kIJqB76w+nPr3C2zSkK6LRknPTykUuUgjDOvVsc8GFlibAaKAOcZ/GAv5T2YGMKvJBirzLQ1UsXwTjL2lNLKaohX8kqm3hmjziH8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:29e75733-0836-4acc-a50c-83a33ccb25cf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:d3ed4f8f-637d-4112-88e4-c7792fee6ae2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 281377f6e9e911efbd192953cf12861f-20250213
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1019070026; Thu, 13 Feb 2025 17:01:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 17:01:46 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 17:01:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ST/NliQ3yLzkEzdQBNIQIzs9JkQXk8jeiqxNf/amJAOtoFdu4D4QKLIttWLJ5j/pCI9elOXL0YmUGHbtmZe1VkiKu9QsWv0cushSyuiqo2lhkVFIRPoT1ponciUnNJMAYp1XkrE8ODz6p3J/hzhjAiKDXlfP3UgtzO1u4nkmXHN5RwPgUvn40IENIHaK9vg5nHMA0EBg08U/G7HyXWUHSlaWxuRlIEwbdWkEs5h9jYGoYPcCefW2fZLJeg2m1Ydbf1uK9K0aC+d+6pFmf2MI/YUxjCALgiPy66ivVke1U61WTwXMucWzYZdkrcKAdaq6kQsVy1tGkzre3dpfa4lvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHg1FsUiKWghqfdyCzWqK1+FBf2NWcLBUvxQ3PTQJwg=;
 b=ZD+MsQ0MzYzkz/7alg3Sq8hr3B6+coK5LhDUa9aC00MtJrocLzT/HQwhMyBTtT/8LC33w86+cgtg1XJw9LjcUaXDMxwVCI/S/NeUrNXIBLizc82YL5rVlV5Id82ljsmZ6j+rdzA7t029b/e2CZUwGdHCFoB4XP0KSJdUsuv05QMeLILtLVun2Y+SXMQpzVNDC4GyBpSNT3IerWc4yuu2u6X1kijhynsQJ6sB8q+TGaiMccpKWnMFL9ARt7z2hCtgRlhfJxXkb6IiLf9j0ms42QaWGKfSaeDgI/ny4LYJuloATW25FdSEoA0ISPcDeUocnW6m3zh9Gnn4IUDcc0c5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHg1FsUiKWghqfdyCzWqK1+FBf2NWcLBUvxQ3PTQJwg=;
 b=ERyQI/HB99VujA9wZQ8onrGKfDjgI0VtfDcnoNdieitkf2bu7nbiUN5x3QJQtzsjiRsZzvLi6DFuja52QD+aiFtnfMlbHu8Bs2yh1D53RcLJrE5WMrGX9Z2sKdXJtS3kTU05Nu36M4IgJwhj/t3nMEYWMhvpypluYU8ADy03ojA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7989.apcprd03.prod.outlook.com (2603:1096:400:47f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 09:01:44 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 09:01:44 +0000
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
Subject: Re: [PATCH v6 36/42] drm/mediatek: mtk_hdmi_common: Make CEC support
 optional
Thread-Topic: [PATCH v6 36/42] drm/mediatek: mtk_hdmi_common: Make CEC support
 optional
Thread-Index: AQHbfHkw6spL3YAuNkakmk01mySi3rNE8tuA
Date: Thu, 13 Feb 2025 09:01:44 +0000
Message-ID: <e94e5f788baf00cde94c8c3fd9065804de6d4d1e.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-37-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-37-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7989:EE_
x-ms-office365-filtering-correlation-id: 0006796a-de7c-4e2a-1745-08dd4c0d09fd
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TGFzWmFtREhQR0xBcjVGTUVSRkNoeWVPTXYvUnI1NjVlMmluU3pSUDQ1RVFp?=
 =?utf-8?B?VWNjVnpPWHpEQzdubTVod0VURjVWZkRUOU02dnk0MzZwNmtCQ2R5MUxydCsx?=
 =?utf-8?B?ZjVjb0pnRHNOMmZjSnZXOEkyRGYrSDIrUTJzdU5wc0pERTRBaGxCVDVKeXZ6?=
 =?utf-8?B?T29Eb0ZEbGhGUkpybklFT28yK1cvUTVMQlNybk9mWHlWdWFQYXlEa1N2OFZN?=
 =?utf-8?B?dUNSTGRZbXVIVXpLb215K21sdEp6eVlLWDNSeldRZGxlckNSRlBVdDNGWUlP?=
 =?utf-8?B?blVpRU4ybUJBQlpLaEo5YnMrM3RVK3JPa1d0ekJjYkFxOWxjd0Z2aEpWSTR4?=
 =?utf-8?B?QUNieU5ESUZYbndSaDZwRWVlR3pZZFJSN1VEQXRKZURqS2JTOVpGd3h3Z2pV?=
 =?utf-8?B?YkV0ME9teE0rTmd5amdZdnRoVkxldlN5YUdEa3p6Nk53cUZTdDRhb1VKNWVi?=
 =?utf-8?B?Y3Z3ZzUxOU94MjJKTmxXbERoTFRmaEhJekMxZm5Ga3NkNWhyRjZ4SUZxVzRE?=
 =?utf-8?B?MzlvcnJVRXFSMis2bVFHWU5HeXBqNVlaQVBNelRnMG95N09vdTY3RGhHalRy?=
 =?utf-8?B?Q1VPTXFCcmc0alFzV0V6VGRyb0Ywek9LN1BPNVVHcCtQU0hvSXVZQlNhQm9z?=
 =?utf-8?B?cUE1b1RJamJiZXpTNC8vWnZiQ2I5ZnJLZTNsMHhybHJ3U25MMGV4QlY3NUJk?=
 =?utf-8?B?R0ovZDlXWVkxWUg3SmJnQ2JJU0RvVFhLSis3OFMvVnNEMkl4enYyMXp3aFhL?=
 =?utf-8?B?Z3BZTWN0djNzUUw0NGFYZTZvZFg1TGdYZ1ErN0cwM0RTbWlGZnZ3bnJYZkc1?=
 =?utf-8?B?REdob3MwQXpaRG96M1FOREpOTGRyRUFoTHBOSEJFN2NSbWQrUzRkNytDQzhr?=
 =?utf-8?B?cVFRcXpoVTZKbTNpSHQzVzcyK1NWWXdRditheVlaeTgzMEFLRm1IRnpsejVq?=
 =?utf-8?B?dXZtRktQOGwrNkRQUXUrRG1oR05XMDZFTWFueTN1VVQyL1BlWTg1cEhwZzhK?=
 =?utf-8?B?c0VwejlycEMwUWJMRXEvSENGcktlMmt5VmUwSkJmeXIzbWpzWGExOVdYWC9w?=
 =?utf-8?B?ZXUxTU5pbTNWODA2M0pMMEJaQ3BhRTBpZ2ZVdldlaFBWRDNKd2x1NjZuQSt2?=
 =?utf-8?B?UjdZdDByRnhuV21Wb3JUK3UvdHhPZTVhR1NwZDgrUSszTGRWc2haTjJjZDZu?=
 =?utf-8?B?WkRFSVhZQVQ5TXA4cjQzUW5ka1poV05NMXlNM1QzMU0xMGxRZ1RINndrR3gx?=
 =?utf-8?B?RHR0UXNjUVVyU042UDgyL09iMnlzVFNjWHVCSlFTSlh4V3VYMDBSNmdWalUv?=
 =?utf-8?B?WnpqUTdrQnEwZnE0eTZoUUVMSDl1N2RvdzZrTGhWRkh6b0Y3R2dZZXVHS2Qy?=
 =?utf-8?B?YTFTOWh6WURQZldTeHZvZjFncmJUU2M0N2FrcC9McjRIcis4NHNnck9qeWpp?=
 =?utf-8?B?QnQ5ZkVOaGg3WWw2RzZKK3o0MG9sdmVUeFlHRFdkMzByRFpOOFkrSFpQNEQx?=
 =?utf-8?B?WG1LOTNTRzZ1eWZPWXI3Vjk3eVRxeHpRVUxBbE00UENIbFkwZzU2WFM3Wkdn?=
 =?utf-8?B?REw1M2RnN2lIK0FXR3NkWExqd0pMckJIZTFwdTl1aG1lSi9JdVI2TFlUbVhk?=
 =?utf-8?B?YmQ4cExhS2VYL0d0KzJuaHoyaUZOS3lKMzErWmdDYmx0anJLZ0RQaSs2VS9o?=
 =?utf-8?B?TkdYL0J1Sm01VG1XRllUUWR6VGlURzN0OUMyQ0ZKeVN5UHlzakxTbEpjYURu?=
 =?utf-8?B?bUtmbE0rN1NyRG02ZE9STmtpUFZOa3JZK0YzaWp0ZllmZjJUYm1mU0pnazZ3?=
 =?utf-8?B?ZW42L1ozZUV2aDlIMDNYWEJkU3FHb09XZFVzWHhuSmhYem5VWlhBWG1XNzMy?=
 =?utf-8?B?UTZoanI3NEJXOHdnNWFtQTZoOHpKTEpydHE0enE3eWg1OUN3Y1dpZVVOQ2s0?=
 =?utf-8?Q?t21QBxY4hicjqHph4XWPKFAlPwEayiS+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ai9xVmwxN1VyMEs5bG0xcjVrS2ZvWWI2RzZZU3hsaWtHbzYyNllrUXlHd2l6?=
 =?utf-8?B?emRSMzc4WExpUG50SnU2cElqQnloaFg1Nk81R212aFE1OGRxSmVzQjE0aWlz?=
 =?utf-8?B?VkJSYzBzOUQ2Rk9OczRrbit4SVdPd1JBUWNZVmdVYnczUlZmMHBOUzVNUWxt?=
 =?utf-8?B?Rk5zQXhDWFNNUWJtNHdkZHg0VmE0WGpkSmh0ZEM1YjBOZlM2RjNNZGtnTjhk?=
 =?utf-8?B?aCtIVW9wdmtMeUZ4TldHd2xLVHZmYmpYV21mQlN1VjRtRkRmb21taXNGVFNm?=
 =?utf-8?B?VGVFSWxnSXpiUXFZWmdSNWgzOUVMMHlqMEN2djVLbEhaWVUvdzBlb0k1WTBI?=
 =?utf-8?B?MnpHS1NhOUF2c2xPQy9HYjJEVDZ6azdTQ2pwaC8zeURXcTZJNzFuR0ppUlRp?=
 =?utf-8?B?QTQvK1hJb3JFWi84bHp4SitTcFdoQy8xNTdKQ0I2Sm1EdUJrbmxDZWFtamVr?=
 =?utf-8?B?Umxhd1J0b0VrTW5hWWliTi8vODFRQkxXdWdPSDNGTlF3eEp6SGpMa3UxeGMx?=
 =?utf-8?B?WFRmeVZzU3RTWTFmQm1kejQrSWd3ZVYxU21hWVlzd2FHUERIanQ3dUMvUWJ2?=
 =?utf-8?B?bFhscVJ1bmQrQVBHUjNtSzlmaUo5SjM1VE5hTk44MC9ROVJkR0pScXJ0NjhV?=
 =?utf-8?B?NFZ1Ykw0OERXUDhwY0NyUkFtcFpERWV0R0ZkaVFUZTdVLzVzR0hLN3plZlpt?=
 =?utf-8?B?RUNkdERnYjhqMzlCaHZPNUZLUUc2Yld6TGU3UllSZzY1VkVmeVFvTmhvUmRj?=
 =?utf-8?B?MGU2bWFpQ0N0amlLNnVLZ3BDZEtJcVByWEkwazZRNWpQcitRVFBxNWlQQytG?=
 =?utf-8?B?RVFHYkNhOVdKcVdQZmFKYUp1YVVyUmh3VVJNeWp4cWVZQ3JEb1NTc3k2cWxC?=
 =?utf-8?B?WFh2L2drVEZRM0RRc2F6bU8yMERtbUR4dWx1bStWeGVobFhhOFp3MzZCc1BX?=
 =?utf-8?B?ZjMxa29VSkhPbWoxVWNWODk0N2l4WEJHMStaY0JqRS9Rc2xlWFFSYW9GdVd0?=
 =?utf-8?B?Q2dZQWxpWUVKVmJLZzVpRFVSWXR3bUNOQ0E1VGpHeERzdjdYUSs4SU9iL1pj?=
 =?utf-8?B?RVBhYktWTlBubDA3UElIc3Qwc2hhMFIzekllOHR3NTdJVDBWb3hlbHpoZytC?=
 =?utf-8?B?cmk5TWgvS25mbm9ha1FJUmJBWVdMTk90Nnl1SnU0NFpQWnZ6TU5LNitsem1H?=
 =?utf-8?B?WU5kOXozTGQ2eVM1eU0xZ1BwSk1QUG1mUDdsdXhVZ1Zadkh5N2owYUQ3V3Jx?=
 =?utf-8?B?alQ2WnZCdjBUYWliY0ZSSGhDVjhLWTgvZFRSNDAxdmtsWjBKbGpEYUlINHc0?=
 =?utf-8?B?eDZrMGtSTDJvQ1AzVjBUcjZ1Q3d5N1Awb0w1YXpsdFFwOGdHcnRIZlFuSFBv?=
 =?utf-8?B?YU51ZjZYcUlLelF1dVNHaHl5dmwxdjNjMlVQeVFZL0lGeklic3hCUEdlWXcr?=
 =?utf-8?B?UUlCZEkxTDhkZXV1eTRjZDNqZlduVm1MWmRyNVNCMHl2K0NoeVUrQ2pLZWZZ?=
 =?utf-8?B?RVFEWGg2UjFOamg5RGpWaTlRQUk2d0JMOTljdmtXNGwvV2N0VU5FRllEL3dK?=
 =?utf-8?B?OFlFRE5JUXFITTI1azFKQWRHb2Q2b0dsN3EzdVlUQmVYRFB3TEs5dEtmSmVR?=
 =?utf-8?B?V0Z3TWVlbGhRNnBKcTNpajFndHpqaGs5VytPRFg5cC9XZ0FUN2ovWXUxMWth?=
 =?utf-8?B?NVV0SU45dnprTGZPZU0zT3JNV2hGZmN6Q3dDdlBobHNzV3ROM3VOUHFDbnk1?=
 =?utf-8?B?YkJ0WmEyMG5oaUF6b3BPU3NMc2pGaGljazAvMTIyelNmUFpJU2UzUC9mZGt2?=
 =?utf-8?B?Q3JiaUx1UXNsUlMzZVA3QWZlVW1UTUlzaExUaUU1WHZNWEdsUGVLQ1NCaC9F?=
 =?utf-8?B?ditVVER4VCtBZHArSndoODRXS3pMS281SHA3WWtLRStHcGlTQkorRUg3a2xr?=
 =?utf-8?B?TnVhK0N0MWl0Rm9BdFZjK3VxUHRtNDVrTkhoM0FFOVRzYW5MUWtGakZIK2J5?=
 =?utf-8?B?NExhcVJLOGFPSVAyMzFhUWxub3Q2ektQVnRJelJBeHJ3V29UMkt1VDRVRFlM?=
 =?utf-8?B?UTduejZQa0Z2c1NENm5KRzZNVGgzemhjenBFaWNwMVZXTURnWEd4UWZjMGk4?=
 =?utf-8?Q?/4vkWp5BGB4cjnVu5MhV3P+U5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6BC8FB7648E234E91AA6BAAA1D9B47C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0006796a-de7c-4e2a-1745-08dd4c0d09fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 09:01:44.2118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1JcJ3Nh3LdhNtcJWhiWYTHg8F5Th01dSRhdE9QUvwECZyz0mz15B2fq7wvzs+QR/VuVmCaspwpk5auoojvW9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7989

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjM0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBmb3IgYWRkaW5nIGEgbmV3
IGRyaXZlciBmb3IgSERNSXYyLCBmb3Igd2hpY2ggQ0VDDQo+IGlzIG5vdCBzdHJpY3RseSByZXF1
aXJlZCwgY2hhbmdlIHRoZSBvZl9nZXRfY29tcGF0aWJsZV9jaGlsZCgpDQo+IGZhaWx1cmUgZXJy
b3IgdG8gLUVOT1RTVVBQIHRvIGJlIGFibGUgdG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuDQo+IGVy
cm9yIGNvbmRpdGlvbnMgaW4gbXRrX2hkbWlfZHRfcGFyc2VfcGRhdGEoKS4NCj4gDQo+IEluIHRo
YXQgY2FzZSwgaWYgLUVOT1RTVVBQIGlzIHJldHVybmVkLCB0aGlzIGRyaXZlciB3aWxsIHByaW50
DQo+IGFuIGluZm9ybWF0aXZlIG1lc3NhZ2Ugc2F5aW5nIHRoYXQgQ0VDIHN1cHBvcnQgaXMgdW5h
dmFpbGFibGUsDQo+IGFzIHRoZSBkZXZpY2V0cmVlIG5vZGUgZm9yIHRoYXQgd2FzIG5vdCBmb3Vu
ZCwgYnV0IGFmdGVyIHRoYXQsDQo+IGZ1bmN0aW9uIG10a19oZG1pX2R0X3BhcnNlX3BkYXRhKCkg
d2lsbCBub3QgcmV0dXJuIGVycm9yIHRvDQo+IHRoZSBjYWxsZXIuDQo+IA0KPiBUaGlzIHdpbGwg
bm90IGNoYW5nZSBmdW5jdGlvbmFsaXR5IG9mIHRoZSBtdGtfaGRtaSAodjEpIGRyaXZlcg0KPiBh
cyB0aGF0IGlzIHN0aWxsIGNoZWNraW5nIHdoZXRoZXIgQ0VDIGlzIHByZXNlbnQgYW5kLCBpZiBu
b3QsDQo+IHdpbGwgZmFpbCBwcm9iaW5nIHdpdGggYW4gZXJyb3Igc2F5aW5nIHRoYXQgQ0VDIGlz
IHJlcXVpcmVkDQo+IGJ5IEhETUl2MS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX2NvbW1vbi5jIHwg
OSArKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19o
ZG1pX2NvbW1vbi5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX2NvbW1vbi5j
DQo+IGluZGV4IDNkZmRlNjMxOThlNS4uNWVhNDU2MDg5MjFjIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfY29tbW9uLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19oZG1pX2NvbW1vbi5jDQo+IEBAIC0yNTQsMTIgKzI1NCwxMSBA
QCBzdGF0aWMgaW50IG10a19oZG1pX2dldF9jZWNfZGV2KHN0cnVjdCBtdGtfaGRtaSAqaGRtaSwg
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Yw0KPiAgICAgICAgIC8qIFRoZSBDRUMgbW9kdWxlIGhh
bmRsZXMgSERNSSBob3RwbHVnIGRldGVjdGlvbiAqLw0KPiAgICAgICAgIGNlY19ucCA9IG9mX2dl
dF9jb21wYXRpYmxlX2NoaWxkKG5wLT5wYXJlbnQsICJtZWRpYXRlayxtdDgxNzMtY2VjIik7DQo+
ICAgICAgICAgaWYgKCFjZWNfbnApDQo+IC0gICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9w
cm9iZShkZXYsIC1FSU5WQUwsICJGYWlsZWQgdG8gZmluZCBDRUMgbm9kZVxuIik7DQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIC1FTk9UU1VQUCwgIkZhaWxlZCB0
byBmaW5kIENFQyBub2RlXG4iKTsNCj4gDQo+ICAgICAgICAgY2VjX3BkZXYgPSBvZl9maW5kX2Rl
dmljZV9ieV9ub2RlKGNlY19ucCk7DQo+ICAgICAgICAgaWYgKCFjZWNfcGRldikgew0KPiAtICAg
ICAgICAgICAgICAgZGV2X2VycihoZG1pLT5kZXYsICJXYWl0aW5nIGZvciBDRUMgZGV2aWNlICVw
T0ZcbiIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGNlY19ucCk7DQo+ICsgICAgICAgICAg
ICAgICBkZXZfZXJyKGhkbWktPmRldiwgIldhaXRpbmcgZm9yIENFQyBkZXZpY2UgJXBPRlxuIiwg
Y2VjX25wKTsNCj4gICAgICAgICAgICAgICAgIG9mX25vZGVfcHV0KGNlY19ucCk7DQo+ICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVQUk9CRV9ERUZFUjsNCj4gICAgICAgICB9DQo+IEBAIC0zMjMs
NyArMzIyLDkgQEAgc3RhdGljIGludCBtdGtfaGRtaV9kdF9wYXJzZV9wZGF0YShzdHJ1Y3QgbXRr
X2hkbWkgKmhkbWksIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gICAgICAgICAgICAgICAgIHJl
dHVybiBkZXZfZXJyX3Byb2JlKGRldiwgLUVJTlZBTCwgIkZhaWxlZCB0byBnZXQgZGRjIGkyYyBh
ZGFwdGVyIGJ5IG5vZGVcbiIpOw0KPiANCj4gICAgICAgICByZXQgPSBtdGtfaGRtaV9nZXRfY2Vj
X2RldihoZG1pLCBkZXYsIG5wKTsNCj4gLSAgICAgICBpZiAocmV0KQ0KPiArICAgICAgIGlmIChy
ZXQgPT0gLUVOT1RTVVBQKQ0KPiArICAgICAgICAgICAgICAgZGV2X2luZm8oZGV2LCAiQ0VDIHN1
cHBvcnQgdW5hdmFpbGFibGU6IG5vZGUgbm90IGZvdW5kXG4iKTsNCg0KWW91IGNoYW5nZSB2MSBi
ZWhhdmlvciBoZXJlLg0KV2hlbiB0aGVyZSBpcyBubyBDRUMgaW4gZGV2aWNlIHRyZWUsIG9yaWdp
bmFsIHYxIHdvdWxkIHJldHVybiAtRUlOVkFMLg0KQnV0IG5vdywgdjEgcmV0dXJuIDAuDQoNCklu
IG10a19oZG1pX3Byb2JlKCkgb2YgcHJldmlvdXMgcGF0Y2gsIHlvdSBhZGQgY2hlY2tpbmcgb2Yg
aGRtaS0+Y2VjX2Rldi4NCkkgdGhpbmsgdGhhdCBjaGVja2luZyBpcyByZWxhdGVkIHRvIHRoaXMs
IHNvIEkgd291bGQgbGlrZSB0aGF0IGNoZWNraW5nIHRvIGJlIGluIHRoaXMgcGF0Y2ggYmVjYXVz
ZSB0aGF0IGNoZWNraW5nIGlzIHN0cm9uZ2x5IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaC4NCg0KQWZ0
ZXIgdGhpcyBtb2RpZmljYXRpb24sDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0
ZWsuY29tPg0KDQo+ICsgICAgICAgZWxzZSBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4gDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+IC0tDQo+IDIuNDguMQ0KPiANCg0K

