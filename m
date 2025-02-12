Return-Path: <linux-kernel+bounces-510454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534FFA31D18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59659188A357
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AAB1DD9AB;
	Wed, 12 Feb 2025 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y/S9IyJ0";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PSTiJAm6"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A170C271838;
	Wed, 12 Feb 2025 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739332268; cv=fail; b=LkZE/OEsBqNrXZFsSnGjd4AKDJLzbxcYx9TJgsG5svuW04zMTFHxlcJw+1Q7wY0c5yezf9Jn/g2gHW+pqtNxB7qndrinuQhmGMlugKd+XORV8PKNTYiTRfEhjvuD51CCRXVXuYSo0IG3Kmk0VTyDP9CJJsAoAMMp+sABbEn/do8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739332268; c=relaxed/simple;
	bh=ZWshwACJ9nyOF3gZI7SOiYun3jy0ijwSDeegJK6K8T4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0hiCU5+K1Bm9NP8ROZvpLGuzZJykdFJVQe/+DSYHy2sTzIXbRvDMcRyxNcATm07nW2ofqpyY0OccnQXBE/6KShL5Ebbk4CKEKtC7rdGbRt3n6wcjQlp75WXY+d1K7r2MhBHmehzRf4MnbRO94rGtZHEIGl1UyXIfhv5kYQjsPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Y/S9IyJ0; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=PSTiJAm6; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 92418136e8f411efb8f9918b5fc74e19-20250212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZWshwACJ9nyOF3gZI7SOiYun3jy0ijwSDeegJK6K8T4=;
	b=Y/S9IyJ0le/1R2L6ZgDWsxnDb1xyozFHgfZLqgMzugQIoCmASt+aKDWx6SNUwO1/k+HQrAROUYzuW0bc7fnp6JOOmLfE728o2/P0uXlcYhZXw9BLEm42sF3ASXD2S7qiANyhldvyfDiYd0/PyQwYHjVCUv63m2P9a+XhX/iCVyI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:fe321628-0a3d-450e-a68e-e65a0745ad2a,IP:0,U
	RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:3
X-CID-META: VersionHash:60aa074,CLOUDID:531e3c8f-637d-4112-88e4-c7792fee6ae2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,
	EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 92418136e8f411efb8f9918b5fc74e19-20250212
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <crystal.guo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1361727446; Wed, 12 Feb 2025 11:50:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 12 Feb 2025 11:50:58 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 12 Feb 2025 11:50:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdvfqkzJBscar71/oR29JQj0wUPQGz9KzdJ2fnST7vzM4jK5CKGIB+5YPrzWm3LuygjpRNY13PLm1y6/+rpyVyuffGhkPFFoeYzdNj88WTjxjw4OU4hbv0JMYDrCMad4guJk+mXRDDMQycQ0QiaCVJ9aNfw5Hq/9c4V7gblNgQ0bji+lcif5mgFXCV/UCB6EHEcV7XONltl/QMXV/0h3mSrXMvolGAUwqnBD/31+ywrhOJxhGAqzoS5DTGZEktRKDcT2MFcg38QVzzmk3/0sp+8yE/x4xBNPHPiSoyS0ybDRp0lcQYYB4ZT4ToEwdICqSJ9O/zupL6yEwSn+7P248A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWshwACJ9nyOF3gZI7SOiYun3jy0ijwSDeegJK6K8T4=;
 b=mBT74Pq4eJtNpMSUTPvCPWZBweIiHQ855BNFNUWyh9r1sai8Ahlj3jo1K+4UJMucaPkxpjrTqfdPpwFzG0CRTgG8H+l3QuSn1iHDI6tOHktTyG8kkPEjxyW35WGBXL/pKSrFFVQhMZlyjbboi4NtW0gm8LCAnXq5ZropZ+LY6XQqpDxBFPzuF7Wnx0GULO+0+TrLgyq1gaZJA7alm+xgXZ/LrDfvIGOrG9qIO5hur8vwE2X32npvqBP9J3IQKp4xkfPZazp4OWUGOW+jW7I+2nbVENYWhvmwcvtGYOlVHhxgrn7WdX5PgnNoKop+mn9R315/2SU2Uydol5R3sjuEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWshwACJ9nyOF3gZI7SOiYun3jy0ijwSDeegJK6K8T4=;
 b=PSTiJAm6jhTiL9uURNXub9aA3vc7j+wb2tPEAvyM8FddB3ASzgRPc57VBnZIzdsWnmFUDRmMOfOFyn+pQGuo13z/FuAypJMvlmTUJWXWEfdlBz+lS28pLN5Pu1lLDtq1XexY9PhM4u3AIGYX78Q/KmRyb7ri4q+qLOKN7S990cE=
Received: from SI2PR03MB5468.apcprd03.prod.outlook.com (2603:1096:4:104::5) by
 TY0PR03MB8278.apcprd03.prod.outlook.com (2603:1096:405:15::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.12; Wed, 12 Feb 2025 03:50:55 +0000
Received: from SI2PR03MB5468.apcprd03.prod.outlook.com
 ([fe80::28b5:41ba:aefd:a96f]) by SI2PR03MB5468.apcprd03.prod.outlook.com
 ([fe80::28b5:41ba:aefd:a96f%7]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 03:50:54 +0000
From: =?utf-8?B?Q3J5c3RhbCBHdW8gKOmDreaZtik=?= <Crystal.Guo@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [v2,2/2] dt-bindings: memory-controllers: Add MediaTek DRAM
 controller interface
Thread-Topic: [v2,2/2] dt-bindings: memory-controllers: Add MediaTek DRAM
 controller interface
Thread-Index: AQHbeQHh852dOXgO/k6/Tc8X/FZWJ7M+zx+AgARBfAA=
Date: Wed, 12 Feb 2025 03:50:54 +0000
Message-ID: <eb63bd2c9e5e31ff189d2c957bfcb4bd222ec778.camel@mediatek.com>
References: <20250207014437.17920-1-crystal.guo@mediatek.com>
	 <20250207014437.17920-3-crystal.guo@mediatek.com>
	 <2942fbc2-55c5-4789-89d4-e4bf3158a34b@kernel.org>
In-Reply-To: <2942fbc2-55c5-4789-89d4-e4bf3158a34b@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5468:EE_|TY0PR03MB8278:EE_
x-ms-office365-filtering-correlation-id: 606fbfaa-a1eb-4088-cc45-08dd4b187366
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|13003099007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RFNPeU4xUFk3V21FaWNLZHMxajBiTGd3dzNXNTVFUSt4VmphZFJKNXNTZU9v?=
 =?utf-8?B?NFJLVEJMeVVKZGRYWVAwUFVrYUszbzZIa1IzNzV1S0FBclZRNGRBTzRTcEsr?=
 =?utf-8?B?ajZBRDM4S3N3QThJOHZEZ0NydUZ1Zy9JTDJ6aXhhTVBJVU5zVHhHUzVYd3Az?=
 =?utf-8?B?NlRrTnprNmZhUTArRy9KL3JqV2ltd2ZGYWJ6d3NDZXZlSFNianA3S2xwUmZr?=
 =?utf-8?B?YWQrVm1tMkFoQStXOWdXKzI4OFl3emN0VzlPLzlzQVhkWFJSa2RhdWI1T081?=
 =?utf-8?B?TmhQOVJ5cDFPYVpja0xoLzlYOFlFMURJUTU1aWgvMXRDMHA4WmtlNTRwa2hF?=
 =?utf-8?B?SjkxalBMUWkzUXdJeUYxeC9ZcWtQY1pGdTFwdlRiaVQwdHFNbTFoY095QzAv?=
 =?utf-8?B?YkxXb3l4dmFnTXhZM1NET1JacjR4SnZyeVp2cWtKQ01Uam9DM2lURnZhREhj?=
 =?utf-8?B?cHYvZ2crUElYTHZDNW9zZmh1UytqSE5uNUlDYXdsOFRqb0xHSXBCWlQzcjZE?=
 =?utf-8?B?dHIyQnhmd0JXVmhmSzVkMVVCaHVodXB4VGhQZGpWbHorSkJ4eW9NVWF2eGp1?=
 =?utf-8?B?M0ZmU1I2K0wrOGhQVnpIYjAyeTNnOWJnRjk5WEI5VDdpaytqOGt5SE8xMjZv?=
 =?utf-8?B?aktHU1U5UHdtKy9FaHpsSWN3c2h4ZU9BeUdqL0V6eS9mY09zZVFTZGRhNk5H?=
 =?utf-8?B?cjduYzBRT3BGU1ZUbEprMUZlQmErNVgyQjcxZENIVTllOFR6ZU40M2Y1dFNu?=
 =?utf-8?B?dzdYOTk4ZXRieDN0VkY1TDFUTEFWRUIrZ1NSNmtnZjFaM0VtRXhGRUdwZFNv?=
 =?utf-8?B?VDJVRFFhR05vdEsrWkFQRFVzR0l2RVBUUW8yQ3h1KytaVkZnWWNkYWdacE1n?=
 =?utf-8?B?UDZPNHdlN1V1VDdCR0t6U1VzMnFMaGhtUHFEM3FHL1hyR2J1OGh3Vk13YVlG?=
 =?utf-8?B?aXVKSWZuQVBwSmM0SzN4NTRaazJid1ZjR3Q3cHd2SlRNejdDWng5c25EcVNF?=
 =?utf-8?B?ZHJCYnRUQ3YySzFLdk1PNDlYbUZvZk5nMzhuS2JYY0NSOFdwTjIwMFcrVUpR?=
 =?utf-8?B?dXY4VldYSlNvb1hSYTdXbmNwZTJlbmxvanJhTy90Z0F6UzJNK0tKdWRKQUVW?=
 =?utf-8?B?UUp0SEI0cTFONGRwbEdKWkw5YW9vS3ZvbDIrN1pUbHgwTG85Nys2UW1yU2xL?=
 =?utf-8?B?dTIxemNmNUI1QmVBZ1grVHNqdm1HUGU2cHVNZWQrL2ZQeGhGVWdBZFdTU1Vp?=
 =?utf-8?B?M2RGdG5YcUJacERUbkZ4VFpsNlJPMWRUWXNVNU93enY3ZnEraG1nRk9CcjRo?=
 =?utf-8?B?RTRoZDB1T05TZ213ZHJYUmdZRmZoeDUydkFEWkI2MXRieFRYT3BxZVZYbFgv?=
 =?utf-8?B?cmorU0diVVVVeHM1ZlROZ1lGa3QzcWVIYU16RmZCanBFMGQxZjdMdThlcDll?=
 =?utf-8?B?dGNFVjZXVTlVYzJ5ZzdTcTZYYVR5UEExYlR0cVd6bzhoeFpHZFRsNnZqZGF1?=
 =?utf-8?B?NVlTYWEremg4SWE1em1BL2IxOHA0QUUxcS9UKzlxeStQNzhJcFhVenRSWlpq?=
 =?utf-8?B?dXdjU0xnVHZSRmhaV0xNSnZQQzFKMEVHOTlVcExhOElLTktqMlBRNFcxSmYr?=
 =?utf-8?B?US9yQTJKRkdwR1R2MDdhODQyNG05WlNGNG5sTFhQZk1UelYreDBqSStjVkd6?=
 =?utf-8?B?cjRkc0s3VXVrY3U4UVV0R3N2R3prYXE0Ynl3V3k3c3FxVnZBMlQrcVJvV0Fl?=
 =?utf-8?B?bmF5SkRGaTZIZmN0ZU9QYitQT0ppQUQ1QkRobFhtNkY5WC93cjZnT2ZsWWYz?=
 =?utf-8?B?bmY5d005VzZ3aUVTZ2NrcHlQc1hOMVhrb242d0w2OEhXT2hjM2Jpb2c0MXZO?=
 =?utf-8?B?MkdLWVVSMUZ6T0N3ZjNFZGxuRE5GV0tzd2RHbWcwQm9rQUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVNMM1dCMXFBZThQeDJobzJ6YnRvbFNxRVQ1T0xPS3NkTFA5YTh3YzNMdHNl?=
 =?utf-8?B?cERUY3FVQk5JaVlFbU1sUUhpVzJrelVvcDdYbUYyWlpNbkdQUGozQmRaRWxI?=
 =?utf-8?B?QXlaTFI0TVk4UFhoSXhMWHI5eFRWV0w3K3VXaUQ1cjVyRnlZWGxrM1BKVlJz?=
 =?utf-8?B?QVhTVjN0UW9DMHpNQXFwTS9JYnJTYnJ6OC9nMmlaL1hlaW5ieU9UL1Z1STFV?=
 =?utf-8?B?V1VmbUVTWkxmQlFvVjNkeHdSWlV2M3RyLytQSnlpc3hIYTNycHR0NVVvbk1P?=
 =?utf-8?B?Ni93QnJnbEQ1eEpuc2xJMm9CVGN6ckdLUEZRR3FBRGxYYkpOSzlRMjJUUnkr?=
 =?utf-8?B?OTFreHdzVnFFM0NqM1Z2TnVUTEtjbWZUeS8xdXpzcTdJUlk4VFo1TWhXcHNB?=
 =?utf-8?B?SjZzekNQMVJuTGo5WGp0SVIyM0xraHcwaFpjRzBiZ3VvNG5mMy9yeG84SnhU?=
 =?utf-8?B?aWJ4YWFnYm85aVF2VjJCZkNOd2Zyb1E4NjF1MzczOHBSelZzNTRkZlU4WGJY?=
 =?utf-8?B?MWVKRXZPQ2ZyeFFWa3Q4NlpOakZuVmdrUjFEUG1naURUU0oyUHVKM1ZuaGVX?=
 =?utf-8?B?S0ROdWM5dzlBZXpvZFgwbVRaK1cxb044UExEM29iL3MxdTJNRHkwTXQwZFo5?=
 =?utf-8?B?Sk9uSWFXazI0cnVPeC90cG1NcHo4K3RhK0tkOVRtV0VIT0xRM2FBRHhSWmhB?=
 =?utf-8?B?dkpONEw2THIzWGFyd2dDMmRaQnlCQmluWWlMYmhVcGROUEtJMlN5dGo1dnE0?=
 =?utf-8?B?WGNvdlAvMEppSkV4WW1Ddk52aFRKSENDVUV1QitkdERYckJtRkg1YjVNV2hV?=
 =?utf-8?B?SllvZmJPN2JvWjAzWHVjS0E1ZWR5bTFkdWx6c3dQbTI2b2xwN0RyTHlsVWFP?=
 =?utf-8?B?NThnMmUzdnJEalFHUXlCczZ5Q1U2MWVyWnRWeGcyYUVITnM3NDlrTVpSM0hU?=
 =?utf-8?B?bk9zWDI0MEJpbWw4VDhBNjd4YTZ5ZmU2ckJ5a3lQWUtkNFdGMVB3WUx5bHE0?=
 =?utf-8?B?T1loOXpGZjlpV3dKUmVSckRScFprMWUzRVdORlBaUXRUaWYvRWJ5THYvd2Nk?=
 =?utf-8?B?MUx5cElTckpJMU1KK1Q5em5hZGF5ZlU2VXVSMVZYVEJ0TUdhMEUxUlRQSmxq?=
 =?utf-8?B?Yko1cDlicHBSMjR6elBpU1dPUzZMd2kzdWZrYlM1d25hdWVBNVdKVzhMaytn?=
 =?utf-8?B?TC80QkZScktpU08yc1YxeDdXaEZ1ZFYrQTltTlhEUEtNZFMzcko3VElCMjZq?=
 =?utf-8?B?SGU0OURZLzViSndCU3Z3Z2lMTUNTOUl1S3Z2WGhjRGpYSytMaXBzRFdSZVlh?=
 =?utf-8?B?K3JXMVhRN2FEbDlDNFNsRU1qSm1PeENRd0VWZ3huaGJQbWdXU09sM1UyMlpi?=
 =?utf-8?B?ZHdQV2k0ZXE5TVlSanV4cTlCNzJKc09SUEtTajZMK1VqRnZiVVgzcUh4WnZ6?=
 =?utf-8?B?bzhBenJIRkpHM0FqL243MURibzFrb3k1ODZtWUxEV3VuRFhiazZMbkVNSS9F?=
 =?utf-8?B?dng4NkI0VFN1ODBHTWxZdFJ0UklLVmV2bG83UTV3bElkN2diaUFKZGF1aVk4?=
 =?utf-8?B?c241ZEFPaGJZbEtWYnVIelZRMUtsZ1ovOWNSeVJhT2daZlExUW5DNGpKK1g0?=
 =?utf-8?B?ODFxck5DZFRuSUFkdU14aTFQS3VLajV5OVR3RGxmT1V2Y3FUNm9qbmtNQnV6?=
 =?utf-8?B?aEZNOHR0RWh6NkJhU1ppVU00UHhaNkRnZHNkcWFxc3NqdnAwQmVneURmQmxs?=
 =?utf-8?B?NGJrM05sZldBeGxEVnBOSXJSaWJNY0xhdGhoV1E0cEVsWk1oRUdUZUlieVpv?=
 =?utf-8?B?Witwc2Q2ZjA0WHdlcFRsVjV4ZmFmQ2NjUkRoZStCSFY5cVRMb215TGhLMTRh?=
 =?utf-8?B?Mkc3WnE2bVFlV0RTTXRNcUg5QmFka1VhaXFmRitYMisyamQzTThPRlJ1alMx?=
 =?utf-8?B?ZUJsVjZXMXMzRUIwYUFMR00zYk1kRHZCdUVmdWJwQ3NEVzExOFIxeU5nQzE4?=
 =?utf-8?B?RGFhR2hmV3J4alhHMC9PT3RrMm1VK1NwREJjMm5LZ2hvSk10WWdaeUZXMHdP?=
 =?utf-8?B?Z1MxYmI3VTcxbDI0UnJRU3pscVpqc2pCcHpRVjZjbDJ1VTUxNkVDWnhqQjk3?=
 =?utf-8?B?VU0rMVN5S215bVRiWkJVbVZTUFRTK0QwczJqS3MzSzVmenQwdlFmQkNjcUJj?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3FEE948EB0541478A2ACF2728D4A1C6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606fbfaa-a1eb-4088-cc45-08dd4b187366
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 03:50:54.3596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WeemI0R17eyh9g5Utyw2pcjKdMUCNZ6Msash+xgjwggUIvwIo7+xJMPp92CpATJrOh0hUsEkFtGhbzhM6AAal3YPba5oPzOAAiLroUtyvAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8278

T24gU3VuLCAyMDI1LTAyLTA5IGF0IDExOjUxICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDA3LzAyLzIwMjUgMDI6NDIsIENyeXN0YWwgR3VvIHdy
b3RlOg0KPiA+IEEgTWVkaWFUZWsgRFJBTSBjb250cm9sbGVyIGludGVyZmFjZSB0byBwcm92aWRl
IHRoZSBjdXJyZW50IEREUg0KPiA+IGRhdGEgcmF0ZS4NCg0KSGkgS3J6eXN6dG9mLA0KDQpSZWdh
cmRpbmcgdGhpcyBjb21taXQgbWVzc2FnZSwgeW91IHByZXZpb3VzbHkgY29tbWVudGVkIGFzIGZv
bGxvd3M6IA0KIlBsZWFzZSB3cmFwIGNvbW1pdCBtZXNzYWdlIGFjY29yZGluZyB0byBMaW51eCBj
b2Rpbmcgc3R5bGUgLyAgICAgDQpzdWJtaXNzaW9uIHByb2Nlc3MgKG5laXRoZXIgdG9vIGVhcmx5
IG5vciBvdmVyIHRoZSBsaW1pdCk6IA0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgv
djYuNC1yYzEvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMu
cnN0I0w1DQoiDQoNCk1heSBJIGFzayBpZiB0aGlzIG1lYW5zIHRoYXQgdGhlIGRlc2NyaXB0aW9u
ICJBIE1lZGlhVGVrIERSQU0NCmNvbnRyb2xsZXIgaW50ZXJmYWNlIHRvIHByb3ZpZGUgdGhlIGN1
cnJlbnQgRERSIGRhdGEgcmF0ZS4iIG5lZWRzIHRvIGJlDQpzcGxpdCBpbnRvIHR3byBsaW5lcz8g
VGhlIHRvdGFsIG51bWJlciBvZiBjaGFyYWN0ZXJzIGluIHRoaXMNCmRlc2NyaXB0aW9uIGlzIDc0
Lg0KDQpUaGFua3MNCkNyeXN0YWwNCg0KPiA+IA0KPiANCj4gRHVwbGljYXRlZCBwYXRjaC4NCj4g
DQo+IFlvdSBhbHNvIGlnbm9yZWQgc2V2ZXJhbCBjb21tZW50cyBzbyB0aGF0J3MgYSBOQUsuDQoN
CkFwb2xvZ2llcyBmb3IgYW55IGNvbmZ1c2lvbi4NCg0KVGhpcyBsYXRlc3QgcGF0Y2ggYW5kIA0K
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3Qv
P3Nlcmllcz05MzExODYNCiBkbyBpbmRlZWQgb3ZlcmxhcC4gDQpEdWUgdG8gdGhlIGZhY3QgdGhh
dCANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9s
aXN0Lz9zZXJpZXM9OTMxMTg2DQogd2FzIHB1c2hlZCBiYXNlZCBvbiBhbiBpbmNvcnJlY3QgYmFz
ZSwgcGxlYXNlIGlnbm9yZSB0aGUgcGF0Y2ggc2VyaWVzDQo5MzExODYuIA0KDQpUaGlzIGxhdGVz
dCBwYXRjaCBpcyBpbnRlbmRlZCB0byBhZGRyZXNzIHRoZSBjb21tZW50cyBwcm92aWRlZCBmb3Ig
dGhlDQpmaXJzdCB2ZXJzaW9uIGluIA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz05MTcwOTkNCi4gSXQgaXMgYmFzZWQgb24g
YSBjbGVhbiBrZXJuZWwsIHNvIGNvdWxkIHlvdSBoZWxwIHJldmlldyB0aGlzIHZlcnNpb24/DQpU
aGFua3MuDQoNCkJlc3QgcmVnYXJkcw0KQ3J5c3RhbA0KDQoNCj4gDQo+IDxmb3JtIGxldHRlcj4N
Cj4gVGhpcyBpcyBhIGZyaWVuZGx5IHJlbWluZGVyIGR1cmluZyB0aGUgcmV2aWV3IHByb2Nlc3Mu
DQo+IA0KPiBJdCBzZWVtcyBteSBvciBvdGhlciByZXZpZXdlcidzIHByZXZpb3VzIGNvbW1lbnRz
IHdlcmUgbm90IGZ1bGx5DQo+IGFkZHJlc3NlZC4gTWF5YmUgdGhlIGZlZWRiYWNrIGdvdCBsb3N0
IGJldHdlZW4gdGhlIHF1b3RlcywgbWF5YmUgeW91DQo+IGp1c3QgZm9yZ290IHRvIGFwcGx5IGl0
LiBQbGVhc2UgZ28gYmFjayB0byB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbg0KPiBhbmQNCj4gZWl0
aGVyIGltcGxlbWVudCBhbGwgcmVxdWVzdGVkIGNoYW5nZXMgb3Iga2VlcCBkaXNjdXNzaW5nIHRo
ZW0uDQo+IA0KPiBUaGFuayB5b3UuDQo+IDwvZm9ybSBsZXR0ZXI+DQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEtyenlzenRvZg0K

