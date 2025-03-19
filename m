Return-Path: <linux-kernel+bounces-567221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BACA6836D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7DF3BC77F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C896624E4A1;
	Wed, 19 Mar 2025 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JECd8Sc5";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="E/vd6bZ8"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99610524F;
	Wed, 19 Mar 2025 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742353631; cv=fail; b=Z4/tzlHq3894Fdlk6zQ3QOf1ElCg3C3P3+b1Bhr2Xg9ZGVzXaPTh3Ssbep6WsU0ckfOg62f8jTgyhYGcUXKf9Cdvj7Sjt12fL6Nl+I4KeJtj4f2LI9fhdFRLdyOcihOHV4bZuCoU7CJYCLoPHHaJLjGoowre4Y/liZDz8848SkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742353631; c=relaxed/simple;
	bh=gbi9n+5HDkuJL2Pnf8IfFA5DMPkwiWBvB8DazOMgRBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VqnCOm55BAOK5NOHK05fWDs0F0ymkysXk8Xhc/pcZ3rFc/hzd7R/pNST/zfKVH2HLalPVWFQMK/Z5wZ0KTyvG68Gu4uGDcpe5hSINIFMb7cxLao1DougamIz2cn/0LUb0bL0GMGP647YXt2eFx8hwPykPBObJ3ep/eT6kL2YON8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JECd8Sc5; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=E/vd6bZ8; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3662a430046f11f0aae1fd9735fae912-20250319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gbi9n+5HDkuJL2Pnf8IfFA5DMPkwiWBvB8DazOMgRBI=;
	b=JECd8Sc5YBzogAegyA7sBWCHC5qf7qBSZUuZdn/9ZOtWB51gRRRGfbtqI3qyd+eu5TRqJfFUIjaOnRy42SZ0SQ+hFuqitCb+iJJv/pHXjAxmAc4zzZ3BQkCwN+6Zp/t4rT2Dyah/JNUNaJwPQ5uOhNLcGOeyPY8RrQdTh/3lcTY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:800c8bd0-3ec9-49d6-880f-9b2fb2f20393,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:b77556e1-3561-4519-9a12-e2c881788b70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3662a430046f11f0aae1fd9735fae912-20250319
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1037212798; Wed, 19 Mar 2025 11:06:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 19 Mar 2025 11:06:53 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 19 Mar 2025 11:06:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiJ8HfzGFM4TJLjduXVX8OqwF9D1te4Uwaw6v9dpxYc4eo24SVHirAPgButCbAxI53OKN6SZFasZbvk5ea+rO+ucGqkSBBq2/APmzE3zp4VO3xlEAtlI7yxhtGcRJ1OyuYFrvCmv0Wm6LRdQg2bC5UQBPWh6NUWq9odyfJgmGTGtly/B+hkuN/o/+LJcBGDOwhJiAuLWyqMhXZA5a0zLtehC+J832Cw+NXLcN77zUUO/ooo39o/4efcV3CRtQCZlMVgpufsSrmxxRNoe0AcGZvK50N0F+HnHX4oc47M3smPTdU+20WmZpTp4WrZNWYNFjMca6Hxj7vzCAoIp2pK0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbi9n+5HDkuJL2Pnf8IfFA5DMPkwiWBvB8DazOMgRBI=;
 b=xH0dWM9+CGzP8DA85tiZEgLWrTHQbM/4AFLS+nDfOMru7IUsE4YAh/m/mLbHorbzNxHpDJAnGRKhF0tuuvLoJ9/yfMDBM7D+NokYgCkDM3DkrBqIT1FEb1EWFUFCgllKlJua4y7DfEOjzi026vsZzd9K0QW7gWsQ5La2JvMFYTC/wwXIaZJFeJ7U8s71xKj8bnFBar4D2gnQBmuEp+pXPsBn+1JiVEdxzRcvj9FqCqToidPv3+MJaj7J+G/ZAMwks0+UjMoLeYtOgXyjvbqa9bdIEanFJaPAtQyO0jLscToF5saHzUYqwEDo2PxAfLLk8P219cl8l1g2WzTOOLXDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbi9n+5HDkuJL2Pnf8IfFA5DMPkwiWBvB8DazOMgRBI=;
 b=E/vd6bZ8t5yF3y/ZK7oIxnxck6f2Zon+2FLW+t0eK/fQaA6fSi4T/P3acxENuiweaYTwSgKaztYsp7rCUOcvZ7/B/MfmnBRyQtm+adRiLmBKJvlgyWXF2WyMmO29oeoUluBY+5d7Ie8BLbAatqggfu6iVmafOZkpYBwE+fe9RD4=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by KL1PR03MB8754.apcprd03.prod.outlook.com (2603:1096:820:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.30; Wed, 19 Mar
 2025 03:06:51 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 03:06:50 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v5 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Topic: [PATCH v5 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Index: AQHbkoB9qrdi2CY3DU+VjqXlAYr4/bNvaCOAgApqxAA=
Date: Wed, 19 Mar 2025 03:06:50 +0000
Message-ID: <18146544c3563868e84621708d53825f31849079.camel@mediatek.com>
References: <20250311122327.20685-1-friday.yang@mediatek.com>
	 <20250311122327.20685-3-friday.yang@mediatek.com>
	 <6008832c-e175-4b02-90a6-f790dacd1d09@kernel.org>
In-Reply-To: <6008832c-e175-4b02-90a6-f790dacd1d09@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|KL1PR03MB8754:EE_
x-ms-office365-filtering-correlation-id: c09d8502-3cab-479c-edba-08dd669317da
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QnJrYUVtL05CMFUxQm9XSy8wSFppSWtDenNWV2hhQmEvTGJiTGNsWWhjemZJ?=
 =?utf-8?B?OTdJcEhzaVVOdEZ2NWtwd3J3Mi8ycnhDT2VqdlBaQ0hsKzB6UjhWVCs5OUNT?=
 =?utf-8?B?SVF1WW5ZMEhEN3UvRlNxWjJTN3Z1dHF0NGRLYjE5dFlTOXU2RXJhUnEvZFNq?=
 =?utf-8?B?V1VnbitrSkZqSk9CL0dBei9wRzhhT1hBcVJKRGYrcHVSUEVCODV2cDJHbzJO?=
 =?utf-8?B?VWVhU1JKdXZVMFlqSlNvVThrRE1BeDVmbDk3dm1ONm5KaWNUWU9ZRUVGOVdM?=
 =?utf-8?B?eENDeFQvZURZR2tnZGxYUk00ek9QcE9YWXpRRG1RUnBTMlRSOXlJWW9ncytm?=
 =?utf-8?B?bFBXeXZwdFVIaVc2SStCdWJXUkI2ZjdGWUV4Q2JVam5xaWI0R21acjBjdm52?=
 =?utf-8?B?MklFUFNrSE1telRwQW0raTVWNTdFektzd0pjb1NidFYrTENIdzlMUTRTZE9q?=
 =?utf-8?B?RWt1QURUVFFWUC9vVHZDUnhMUU1YMWE2RWgxck5aRVBwWHI5MExUcTJOTWNt?=
 =?utf-8?B?V2xBNDNhelpEYjF4UDltZzltejFrbnZBem05blczT0ZXZ0Y2eUdiTEgxTk85?=
 =?utf-8?B?c2V3NitGSkp1Q0FCSENQYU9iaGhIVmVmc2RRbXR6L0dSS1Y1alhkbW11RFdQ?=
 =?utf-8?B?KzZZNVhDWFVZa2hYeGphYjdYSDRlaHdwQlJGTWlYRmpBWHBhNEg4cVdEQ3Rm?=
 =?utf-8?B?Sk5mMDBPSVNUTk9MNnBhamt2YjRxbkFwUnpaUUVPNU5aTDM0RHd4WmVDVnFV?=
 =?utf-8?B?cU9RbWFZdWFoT0NXbGJ6dldYanVONm41dkFqUlZlaW5ZRW1xYVY5cEhtWldp?=
 =?utf-8?B?NGJzSUVjVzc2SDJsUitoOFVsRlBIdWRFOVJybGZhWUpzVkhMZ3k1RTY0SFkr?=
 =?utf-8?B?WVlBY29wS0dUa3pqN2tQdWZtYmpFV0xQQmg0clRvb0tObjVBVDhnc1E0NTEv?=
 =?utf-8?B?VjlrRmNLVEJNd1MzY2tMdHJxc1NIbTVSOUtMcXljaFdsb2JBQmVyM2ZuM2VG?=
 =?utf-8?B?Q1ZoZmx2VG1iSmlEWVByL3V3bEUwUXl4aGErbUFJRkswUHJiUVhHeUJaY2JG?=
 =?utf-8?B?VC9ieXYyTHIrUHNCVmYzOGJncWxjUzdFVk51eVlEZ2ttME1xY0IydjREUjZJ?=
 =?utf-8?B?b25YS0RYSzV2SXF2U2R5MkxGSm1nQktzZ3NRSXpkczRaZzFNaTJFT3VCVWRh?=
 =?utf-8?B?Q1dYK25yWTlVZGRGMEM0czc3UTZxU3Nrc0N1amFVd3UxSmFWMjFWaTJWRmhk?=
 =?utf-8?B?Sng3ZHlnQjh4ckdKTk5XQ2JJWFpmbmdEWFczWU1DRmRvMmJOZE9HQkZTV0FH?=
 =?utf-8?B?QUVjUlFrbzI3c2tFNENaMmJmblNicHlJSEpWSTJEYWFCb0dUaFRoYXM4dmxW?=
 =?utf-8?B?MFRISkVRYXFYNHNZeGxFcW9oZnkyWEEzanRLUUp2d2hXV0xvMVJYRFlpVTQ2?=
 =?utf-8?B?TTgydWdTVk5xRFYxNi91NGhRbE5BeTNhTU0rc29GTzRjSzVPZGc0VENTK2Yv?=
 =?utf-8?B?SDRqdUE5b0kwVmFYbk5mM3FiaGlGenl1M3RCUmlHYktISEdmenQwSnI4bW96?=
 =?utf-8?B?b3NzS2xuNXZTMHJ6M0lpbTllUnlrNzgzN2Y5VURvZ0ZYQmdpZ0FWa080Y3V1?=
 =?utf-8?B?NVFxci9uaDMwN09lUC8xbmxpdlFRRUFTZWtROUd2cCtOaFR1M1A3RUl2QlFv?=
 =?utf-8?B?eUNUdzZEdWtNOWFDZHpXSGZTaTQzck5uQXZWR2VsM0o0RDFIUklBS1RpUExq?=
 =?utf-8?B?amo1VFVmeTlnV2JlL1FuMGxCTWpIeEw5Y3dLVmNvWUlNWXBRR3U5OTBzQzJq?=
 =?utf-8?B?MG5BNWtpMjF0TmtOSGlmVEppNVNWUDJHdlgzK3Y1ZGEvaE1oTjhqK3RYVjM1?=
 =?utf-8?B?M1Rva1FZNnVMUUZUa1lSaFpvZkZ1ZkkrL1JZZGVPaUpzNm8zVTM5aTBtOGFG?=
 =?utf-8?Q?zJerRXBZsFUjYZGYC2Zr0ojxjCedOCCe?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzhEZUNqQjlRQTZXOElpSEVBMGRUcS9TZk9DQTFHbmtpUWwrQ1V5Y0hzWTRN?=
 =?utf-8?B?RHVBU1kvbUprVU9vSDJxTDgzRVU1K0MrcHBsSDJ2UWMyUC9rdVhZeVc1UTMr?=
 =?utf-8?B?bHNFK04zMlhnUlFOa2h1a0Z3UnpJeExjeWo0TTE2T1hNVHBRVkFjUy9nUFVn?=
 =?utf-8?B?eXdXb0tiazBVMXpjQUpsTDljS1pJY1dlWFlhUWFkSzh5WUdJRDExM2RYS3VG?=
 =?utf-8?B?U1JVQ01Tb1lIUUl4OEdtNk5NWDM2RWJGZEFOdkJiQ3daOFhBV0gxVjRFbzBR?=
 =?utf-8?B?c2s0Ym1UaTNqUVR3ZHBKanhqVk93akppQkxxYXNnTlRTNXN3alc4YVMvUGZp?=
 =?utf-8?B?SWhlZlFBeU5CQjcwL2grNmxtRUVoU2VpbUpqTDl0WU1WUE9lQ3lkTFhvc2dE?=
 =?utf-8?B?WUZxQ3c4aEZGSjVEbFQzaHpuWXI0TExWZ0ZHbzlvVnFqNGxKRFl6WS9ocTgy?=
 =?utf-8?B?TnVoUlNsN3FGN3ZyZmZhNGhPNU10VE9EeHp4MCtHNDJyUlNTWGZKdmpSYW1V?=
 =?utf-8?B?M2s5WjNRSDRyNzFkd2tPMnpKR1JQRDdsZ0xybzRZSlMvbDFKL1MybTZ5WVBW?=
 =?utf-8?B?RzU4NSs5SGlaSEcwUlBBbDk3QktodDgvUEc2TFBrS05ycjNvcFFjWks1aWEr?=
 =?utf-8?B?TStNS1ljNXNHbmV0U0d2dDJvd0NYOEl4YVFRMlJIRHpzVmFFZTNFY0VNSjNm?=
 =?utf-8?B?SFNSMG1oWkJqSWtLeHI5YVdnYTJad3hTQVVrMkw0c0NNMHRCZVo2VG95Vzht?=
 =?utf-8?B?dXRIcWl1OTZOVUpsSWx3dU5mUFhsMGZycGV1TkdEbW9pem16TXFITDdnOUdu?=
 =?utf-8?B?ODBaVGFiRUZueSttZkRFSVM2SW93UVd6L2FtWlQ0ejc5ODAvcU9nbGJJdjBW?=
 =?utf-8?B?UjlZcWZxNFJVdHpGWHFTaE9yaFFINGFvOTdzeWxTN0VUL2ZHczBLTjB6a0d1?=
 =?utf-8?B?TFE4RFViSFdtTEFCRFdLQlFhOXJiT0tOT2VOOFRaM0VhTjl1dVVlL1lVaXBZ?=
 =?utf-8?B?aW84TFBjbiszZmZjMnhobVZEeVNlRlB5U0hmd3llckJhSk9Tbnl3MmhNSENH?=
 =?utf-8?B?TUNpVENMUFlTWkR5TVQvTnRReWFKTGNrNjN5OEJ3SVozS28rRzdXVkNCQkI5?=
 =?utf-8?B?OWlsVVpFcVlKaTVXVnl4eDdETy95VXY2aTBKcmJET2NFcDRnck84RkJ0QVRH?=
 =?utf-8?B?VUZEVzUrQjRyVWhmZ2NUbUgzWExjSmw2b2hCNGVZeGRnM0h6THZRZll3M01X?=
 =?utf-8?B?NjcyRkQzZEpvR0pPVXNEV0dSaXJGMEdBeUM2OWMyTUNTR3laYW01L0xNVVJC?=
 =?utf-8?B?YU1pdVRRckxMNDFTeElwQ2dkTVlqWU9NV3BPYUlrMnpZVk9xeFY2Y1hWWnlz?=
 =?utf-8?B?RHNlNWN3TUlWVGg2K0lTUjNWYWRMVkV6S21DVVAySUNPTHE5U0RQMWZyM2F1?=
 =?utf-8?B?MnNBT1dZTlhSZ1JQNi9SVHJyZlZISElpUTJuVzhZd09qU3ZzQktLVWdvNU9p?=
 =?utf-8?B?YWRhYTBuY0V2bWdBSlhCd2NuaWtPcmQyRS96RFBoemlUek5xUTVVSzNJZjI3?=
 =?utf-8?B?NXZFenBtdVlpSEwyN043Qlp5TjhYZFRlZWRoVE9hc3cwYm1Ma3g4UzlnTEhu?=
 =?utf-8?B?eGh1K0Z3bXVlZ1RwSzhWNGpDR0xIay9OWGVyQ0FnYklDZi9VMS9lczdEcVpV?=
 =?utf-8?B?NXFBSUlyWDAyNEJiZ1R5eWZNY3FYOHIzRmVNRGYwaGRoTmswVWd4bEZ5V0Vo?=
 =?utf-8?B?NlgwK09uVmhVV1V2SUxXUnY5VmRzVmFzSFc4K2R0M25wMVRtVUYrODkrQmFL?=
 =?utf-8?B?UEx3THlqM1RWRTZlU3ZCM0hPdXo3RVhyY3Rid3UrcXprV2pIZ1cvRVFuaGl1?=
 =?utf-8?B?K3g1WnFhRENaRzlydkJuaHBobWhXYnB0QzE1RlVRazBFbElKUmw2SXhPcHdk?=
 =?utf-8?B?aWk2WXBmS08raHFkS3c5NDlBQWtvRFQ3Ny9UMXJOcmdBb3UxbzliQmsyVTQ4?=
 =?utf-8?B?Nnl5cFJVdnMybFZsLzB0Y0tRMDZaN1diNWpWL2xEZ1JvTjNHN0ZYOFBZcHZj?=
 =?utf-8?B?cG90TVJOY1o5SWlqNlM0dStBakxzTnhXdTU0VlpZNE5zU0FicGxnaE56emdX?=
 =?utf-8?B?SnE4VExyRktqMFFSRnR4Q3lRbXZrSVVRaUlKVkxOTktVdWJsdjQvZFJ3aGlZ?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F1CC8D52002BB4ABA7CD29165D3021D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09d8502-3cab-479c-edba-08dd669317da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 03:06:50.2807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e9TAOewyRO2PYGS3zLweWqKIGKvjWSGqTp1Nd+USF8BVG3mVELyidAqfWhTkHlBXQSmU20KaFqMxlPxfEKt0Xs7zvu1f0Zi1IOdsVE5lY1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8754

T24gV2VkLCAyMDI1LTAzLTEyIGF0IDEzOjAyICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDExLzAzLzIwMjUgMTM6MjMsIEZyaWRheSBZYW5nIHdy
b3RlOg0KPiA+ICBzdGF0aWMgaW50IG10a19zbWlfZGV2aWNlX2xpbmtfY29tbW9uKHN0cnVjdCBk
ZXZpY2UgKmRldiwgc3RydWN0DQo+ID4gZGV2aWNlICoqY29tX2RldikNCj4gPiAgew0KPiA+ICAg
ICAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnNtaV9jb21fcGRldjsNCj4gPiBAQCAtNTI4LDYg
KzU5OCw1MyBAQCBzdGF0aWMgaW50IG10a19zbWlfZHRzX2Nsa19pbml0KHN0cnVjdCBkZXZpY2UN
Cj4gPiAqZGV2LCBzdHJ1Y3QgbXRrX3NtaSAqc21pLA0KPiA+ICAgICAgIHJldHVybiByZXQ7DQo+
ID4gIH0NCj4gPiANCj4gPiArc3RhdGljIGludCBtdGtfc21pX2xhcmJfcGFyc2VfY2xhbXBfb3B0
aW9uYWwoc3RydWN0IG10a19zbWlfbGFyYg0KPiA+ICpsYXJiKQ0KPiA+ICt7DQo+ID4gKyAgICAg
c3RydWN0IGRldmljZSAqZGV2ID0gbGFyYi0+ZGV2Ow0KPiA+ICsgICAgIGNvbnN0IHN0cnVjdCBt
dGtfc21pX2xhcmJfZ2VuICpsYXJiX2dlbiA9IGxhcmItPmxhcmJfZ2VuOw0KPiA+ICsgICAgIHUz
MiBsYXJiX2lkOw0KPiA+ICsgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgIC8qKg0KPiAN
Cj4gTm90IGEga2VybmVsZG9jDQo+IA0KDQpPSywgSSB3aWxsIGZpeCBpdCBsaWtlIHRoaXM6DQov
Kg0KICogT25seSBTTUkgTEFSQnMgLi4uDQogKi8NCg0KPiA+ICsgICAgICAqIE9ubHkgU01JIExB
UkJzIGluIGNhbWVyYSwgaW1hZ2UgYW5kIElQRSBzdWJzeXMgbmVlZCB0bw0KPiA+ICsgICAgICAq
IGFwcGx5IGNsYW1wIGFuZCByZXNldCBvcGVyYXRpb25zLCBvdGhlcnMgY2FuIGJlIHNraXBwZWQu
DQo+ID4gKyAgICAgICovDQo+ID4gKyAgICAgcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIoZGV2
LT5vZl9ub2RlLCAibWVkaWF0ZWssbGFyYi1pZCIsDQo+ID4gJmxhcmJfaWQpOw0KPiANCj4gDQo+
IC4uLg0KPiANCj4gDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3NtaV9jb21tb25fcGxh
dCBtdGtfc21pX2NvbW1vbl9tdDgxOTIgPSB7DQo+ID4gICAgICAgLnR5cGUgICAgID0gTVRLX1NN
SV9HRU4yLA0KPiA+ICAgICAgIC5oYXNfZ2FscyA9IHRydWUsDQo+ID4gQEAgLTcyOSw2ICs4NjIs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiA+IG10a19zbWlfY29tbW9u
X29mX2lkc1tdID0gew0KPiA+ICAgICAgIHsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODYt
c21pLWNvbW1vbiIsIC5kYXRhID0NCj4gPiAmbXRrX3NtaV9jb21tb25fbXQ4MTg2fSwNCj4gPiAg
ICAgICB7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNtaS1jb21tb24tdmRvIiwgLmRh
dGEgPQ0KPiA+ICZtdGtfc21pX2NvbW1vbl9tdDgxODhfdmRvfSwNCj4gPiAgICAgICB7LmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNtaS1jb21tb24tdnBwIiwgLmRhdGEgPQ0KPiA+ICZt
dGtfc21pX2NvbW1vbl9tdDgxODhfdnBwfSwNCj4gPiArICAgICB7LmNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTg4LXNtaS1zdWItY29tbW9uIiwgLmRhdGEgPQ0KPiA+ICZtdGtfc21pX3N1Yl9j
b21tb25fbXQ4MTg4fSwNCj4gPiAgICAgICB7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTky
LXNtaS1jb21tb24iLCAuZGF0YSA9DQo+ID4gJm10a19zbWlfY29tbW9uX210ODE5Mn0sDQo+ID4g
ICAgICAgey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1zbWktY29tbW9uLXZkbyIsIC5k
YXRhID0NCj4gPiAmbXRrX3NtaV9jb21tb25fbXQ4MTk1X3Zkb30sDQo+ID4gICAgICAgey5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1zbWktY29tbW9uLXZwcCIsIC5kYXRhID0NCj4gPiAm
bXRrX3NtaV9jb21tb25fbXQ4MTk1X3ZwcH0sDQo+ID4gQEAgLTc4Nyw3ICs5MjEsMTAgQEAgc3Rh
dGljIGludCBtdGtfc21pX2NvbW1vbl9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gICAgICAg
fQ0KPiA+IA0KPiA+IC0gICAgIHBtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ID4gKyAgICAgcmV0
ID0gZGV2bV9wbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiA+ICsgICAgIGlmIChyZXQpDQo+ID4g
KyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiAgICAgICBwbGF0Zm9ybV9zZXRf
ZHJ2ZGF0YShwZGV2LCBjb21tb24pOw0KPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4g
QEAgLTc5OCw3ICs5MzUsNiBAQCBzdGF0aWMgdm9pZCBtdGtfc21pX2NvbW1vbl9yZW1vdmUoc3Ry
dWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+IA0KPiA+ICAgICAgIGlmIChjb21t
b24tPnBsYXQtPnR5cGUgPT0gTVRLX1NNSV9HRU4yX1NVQl9DT01NKQ0KPiA+ICAgICAgICAgICAg
ICAgZGV2aWNlX2xpbmtfcmVtb3ZlKCZwZGV2LT5kZXYsIGNvbW1vbi0NCj4gPiA+c21pX2NvbW1v
bl9kZXYpOw0KPiA+IC0gICAgIHBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2KTsNCj4gDQo+
IERvZXMgbm90IGxvb2sgcmVsYXRlZCB0byB0aGlzIHBhdGNoLiBJcyBpdCBzb21lIHNvcnQgb2Yg
Y2xlYW51cCB0bw0KPiBkZXZtPw0KDQpUaGlzICdkZXZtJyBtb2RpZmljYXRpb24gYWltcyB0byBy
ZW1vdmUgJ3BtX3J1bnRpbWVfZGlzYWJsZScgYW5kDQonZXJyX3BtX2Rpc2FibGUnLCB3aGljaCB3
b3VsZCBtYWtlIHRoZSBjb2RlIG1vcmUgZWZmaWNpZW50LiANCklmIEkgaW5zaXN0IG9uIHVzaW5n
ICdwbV9ydW50aW1lX2VuYWJsZScsIEkgd291bGQgbmVlZCB0byBhZGQgYW5vdGhlcg0KJ2dvdG8g
ZXJyX3BtX2Rpc2FibGUnLCB3aGljaCBpcyBub3QgYW4gaWRlYWwgc29sdXRpb24uIEp1c3QgYXMg
YmVsb3csDQoNCglyZXQgPSBtdGtfc21pX2xhcmJfcGFyc2VfY2xhbXBfb3B0aW9uYWwobGFyYik7
DQoJaWYgKHJldCkNCgkJZ290byBlcnJfbGlua19yZW1vdmU7DQoNCglyZXQgPSBtdGtfc21pX2xh
cmJfcGFyc2VfcmVzZXRfb3B0aW9uYWwobGFyYik7DQoJaWYgKHJldCkNCgkJZ290byBlcnJfbGlu
a19yZW1vdmU7DQoNCglwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KCXBsYXRmb3JtX3NldF9kcnZk
YXRhKHBkZXYsIGxhcmIpOw0KCXJldCA9IGNvbXBvbmVudF9hZGQoZGV2LCAmbXRrX3NtaV9sYXJi
X2NvbXBvbmVudF9vcHMpOw0KCWlmIChyZXQpDQoJCWdvdG8gZXJyX3BtX2Rpc2FibGU7DQoNCgly
ZXR1cm4gMDsNCg0KZXJyX3BtX2Rpc2FibGU6DQoJcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQpl
cnJfbGlua19yZW1vdmU6DQoJZGV2aWNlX2xpbmtfcmVtb3ZlKGRldiwgbGFyYi0+c21pX2NvbW1v
bl9kZXYpOw0KCXJldHVybiByZXQ7DQoNClRoZXJlZm9yZSwgSSBwcmVmZXIgdG8gdXNlICdkZXZt
X3BtX3J1bnRpbWVfZW5hYmxlJyBoZXJlLiBQbGVhc2UgbGV0IG1lDQprbm93IGlmIHlvdSBoYXZl
IGFueSBjb25jZXJucywgdGhhbmtzIQ0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0K

