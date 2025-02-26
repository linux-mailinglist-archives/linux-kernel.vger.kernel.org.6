Return-Path: <linux-kernel+bounces-533655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739C1A45D49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B177A420C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F02153D3;
	Wed, 26 Feb 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i82Oeb3W";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hGAXfgOO"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FD322A;
	Wed, 26 Feb 2025 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569787; cv=fail; b=BaDiKJqHl9YS4ormybEcikxVyWHge/ttAqgF7sFTBQLEq9OkbIbkCml9yCP4MPCpqzHtVcvnJmAQnj/bHJ85PpO96HpFxosAprukB06HXNNeMRBo8D6uAMsrEFDkPcJORjtsUDFxnHDiVI96kgkrbSgnG3eAf7DvtO8lOzJ3cho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569787; c=relaxed/simple;
	bh=yRMUi8OXj+sOzeVpgftQtnjhWswKZlgils8Xjm/P50s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TTJkd4qzbAWw3XqaCo+VqNbqBjdtNd48RHRNn9l18Hn9r1uY1HtndT3NjKVSl74Pg8fyqo866IoB2Aumg3k7jjINB3k8WJR0ryjaTT8PWRWZ6KA9YjduARRx/DtXiMQ2UqsVSF3OM7sInM9OedMeSrjc7mtwCyX0dxOt1mERSpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=i82Oeb3W; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hGAXfgOO; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e26da846f43511efaae1fd9735fae912-20250226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yRMUi8OXj+sOzeVpgftQtnjhWswKZlgils8Xjm/P50s=;
	b=i82Oeb3WngswTBEZOzM3VC+pZOb/8PWGR2437SuufrHNXyF1mimWcUtGjgVk/jMnS5pT8tpskR/6W1HPoEJaHhIrHn1URzi18GJyhiegtnPc1INDyk4+u8o0Rcxw2VvQ2jMzbS6rmUpzu6JFS99UWFyasUGStV9Y37k76Ab7Q8Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:4e6a9a69-70f0-4643-b86f-28bb5395a958,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:fc64f3d9-654e-41f2-8a8e-a96c1e834c64,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e26da846f43511efaae1fd9735fae912-20250226
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2090647419; Wed, 26 Feb 2025 19:36:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 26 Feb 2025 19:36:12 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 26 Feb 2025 19:36:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jt4RpBZQHXyYEEZbuG0kwIMukZjVPKC9774eqqqLXa4PA3nP20voZz6AIppWJ5uLj8iVxfbBqZ93IMI42MOjruF1iS0usIj1JwhKBzVolo/wOAGypSaNbFAx2TwAIxiiFm/uLu0upGziNvhX2O7t2/lyxwL+MmkfqK8GCbZIQeywDh0gQVrNXZmpohyIUKsLYGOPwXKb3pLd1xW9oZ2jGR5ZwtxAeeC3eyKZU+rUtSvhjY47VSVaaBUD6fiH/tzHP8SdEOZDuFQbSZo3a+l1RwkPL5WQWKgwocgOFRxUmmCgb6ZaD6zeHY7LZYMpgq56B2IJ6X31vDLe9shNm75Byg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRMUi8OXj+sOzeVpgftQtnjhWswKZlgils8Xjm/P50s=;
 b=JQl1JDAeyvlKZgKnQDWzUTb4vtr1yChrGrraNgX1vst+tK/aq9tw0Ea7x7G79lQpRmgKApFJrBzsE9CZIUVwQvBZdyAie7H9X5TfRuEtGutT8DSxR8mF51uN/bJ6hoXdQfOgfBD+ZvNPorXpZbsrCVbTounIrBp0MuccmoMbM7e4gahoNg12K7KWt87MYp1FdcJU3VsF/F8NG1aIDBXPh/QSqU9u09YKNoayO5wGWX8HjX1avLTjjuj4MP1/T+mEjKhJMSLDIuUQBryJHI/tBjDjIv7kYlkFHl1+auoluuDVU+nHowQduWT/ExABt/Z050VSm7NbbZfItvPy9PE4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRMUi8OXj+sOzeVpgftQtnjhWswKZlgils8Xjm/P50s=;
 b=hGAXfgOOXNk2vQoWgSKk4/K5ZUr5zWzMYlDnCVLlUILfZIelR8/OXDueRTDoTCNY5lX8KJYTTP5rMbbltlshjpkAYpU9QfTj2eTWYjT9I8E/hhygtuJnIUCUc3rZlNNUaj+gu2YUSC1ubP2xLbdQRsJLPvJMIymLTOYxIXt29rs=
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com (2603:1096:400:459::6)
 by KL1PR03MB8260.apcprd03.prod.outlook.com (2603:1096:820:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 11:36:09 +0000
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::c1dc:a4af:10cc:b939]) by TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::c1dc:a4af:10cc:b939%6]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 11:36:09 +0000
From: =?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>
To: =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?=
	<yongqiang.niu@mediatek.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "mripard@kernel.org"
	<mripard@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "hsinyi@chromium.org" <hsinyi@chromium.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 1/7] drm/mediatek: Add CCORR component support for MT8196
Thread-Topic: [PATCH 1/7] drm/mediatek: Add CCORR component support for MT8196
Thread-Index: AQHbgq+qLKI/DkYu8ESkQ59zNHyvBLNOlASAgArr3QA=
Date: Wed, 26 Feb 2025 11:36:09 +0000
Message-ID: <18ea04bde26b9cbc22609d621eea1cd65a0f1109.camel@mediatek.com>
References: <20250219092040.11227-1-jay.liu@mediatek.com>
	 <20250219092040.11227-2-jay.liu@mediatek.com>
	 <779b0915-f0fa-46b6-8c5b-57745114252f@collabora.com>
In-Reply-To: <779b0915-f0fa-46b6-8c5b-57745114252f@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB8136:EE_|KL1PR03MB8260:EE_
x-ms-office365-filtering-correlation-id: 76d2285f-4b49-402e-1469-08dd5659c3de
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?aU9waXB3U3lUR05OdTRaQ2YreE5EL2psTW9RNnEyUks2M0pCYmdZYVloVGhW?=
 =?utf-8?B?K0d2UjBBeTlYczlkWXorYXFqUTdXeWtsUU5vQXlRNHRlN1dkZjlhM1lPYWlo?=
 =?utf-8?B?SW1GbGJDZTJlTjkvZE5xM2FwbllnazdpSjQ3azZsaVcyaXZmdSszTlg0OXJL?=
 =?utf-8?B?YWFVazIvRncrbklmMGM1Q1B2ZEZCbThDdXJFVmdTMHlHNU80K0c1ZmhLU2l4?=
 =?utf-8?B?NmVKc0tqYlJhTTF0RU94L2x6bjJtYzgzRHY5dkNtdklNZTdNV3hOUVkvejB1?=
 =?utf-8?B?Ny8zNDhqalFZNnZUMnUxK0MrU3JEa1VPbDRmdzZBMzhoV0JqWkt3bVVqTmoz?=
 =?utf-8?B?Qk1uQTRlSTFpTFMrRWpTRCsyY2RqVWFqWDhFUVpYR0hmb0VrS3FhbWswZ2Rh?=
 =?utf-8?B?WmNLWlVveTVwaThXTzB4MDB0bm9jYkx2MXRrWnBZUWVydlE4WjFuQmhPSVcz?=
 =?utf-8?B?M2V0cXcyU0M5Wng0ajZrNXhGWXpKcmZpelV2NEljN1BNbEZtUHYxNjRuTnlC?=
 =?utf-8?B?aG56LzJ3R3B6eEIxRXBaSW9lZnRkTjI5ODRIS2JrdjhrUmNPdk04SDlIZDAz?=
 =?utf-8?B?cjhBSkVlRmRmUmthVjJiaXFKNC9LL1YwOVhOeW1LaWV2dE0wT2trSVJidGQ3?=
 =?utf-8?B?bHpMTm8yNWY3WndsQ0pWNFdZVzJZZld2S0VhVm03KytSMjJ2ODRaS1N5VnpM?=
 =?utf-8?B?bGwxWlJWWE1tZVREdmU4UTJOV1pJQVdVblBXaVk2UWZ4NzdRZ1hHYkRobTVz?=
 =?utf-8?B?Vk5SeWFERWlmSjUvZzdxWFlDa3NpL3Q1Z1p3R3lFM2kyS3dPaGdzOXR5bVVq?=
 =?utf-8?B?VVVyNHoxREhaNld2SGtJZ0xBSnN2K0RBSWxjcktsVy9TU1F6b2Nid045elkr?=
 =?utf-8?B?ampZeDJaL2tUUzY1UGlZZW5TaVRtWTVFU05XdzhDdTdXTzBGRnFCNFRZd0tv?=
 =?utf-8?B?TEZjSWFyVU0yZ2crRHdvV2FwNVVzdVJjSG1JTGl6SzJsOGxXcFR1Zzk1cUdL?=
 =?utf-8?B?QTlDVExzNitnY2pFSE5BaDRaR3VycW9NSVhOL3lVNWhaSnh6dDF5Y3k3bVkz?=
 =?utf-8?B?WExXai9CcVhlNDg2N2EycC96TkVFUlJLR3lsREQrQ3RHU2hDV1BBU0FYeGtx?=
 =?utf-8?B?KzMydTdpaFBGR2FaR0xHbk16TUV4WUVoWGQwQUhDTzRRbFBwUDlxTVBjd1dp?=
 =?utf-8?B?VDNTcGVJVjhMajFXU3VwUFNtVGdTNzVwZzdBWXNjU0l0c0N1WVBJeUcvbHZF?=
 =?utf-8?B?aXRZbXRTRzJFS3d3OStDTDRFOGhCRkt4TUkyYWZLc3c3VXR4TURYWmc0eHFp?=
 =?utf-8?B?VitESlloMkZHUndWSXBSanVveXpycm1KMVNtcEZlWnM3bDh4R3hNR25GU1dF?=
 =?utf-8?B?SGZkeWpNMDJXREhkN1JXWC8rMmxIL0dvaFZXVThzbkpQWGNnRDhHYjRpVC9I?=
 =?utf-8?B?TlJ3MXpwUmZZbzNPMlJ6NjNpY1BRV1RPdGh5R3ZsR1BlTVVpb0E0aCtsWWVG?=
 =?utf-8?B?NHE2azN0RGRGb1JqN3VHcDVZOHlsOHRYZlhIbEVZSzU3TE9xVGJyaVREL2lq?=
 =?utf-8?B?WnhrM3hIUjdycGYwOW1rSXhKUkZBUVFpNmVkenFqRTdsVWpJMm1TTFJyRWpQ?=
 =?utf-8?B?cndMR05MVHM4eUdUWU1Hbm0wbkFlRDc1S0MvMDBvVUFlalZSOVEvaWQ0eDlw?=
 =?utf-8?B?WGdvcUlGU1VCbDBYNHF3RHV4Zmo2Y2drYUtPR3ZQa0kzc3dxQkQxK083Q1F1?=
 =?utf-8?B?R01KYlpPdi9iZTZPNTM4REtDVEsxdURYVVVsLzlEeHZtRFgwdThBWlRBN1hN?=
 =?utf-8?B?cDFaeWtCaGRaam5UOHI4cWdvUUlSdDR4NTVBVjB4enpuVXpWVzJqaVk3STI5?=
 =?utf-8?B?ZUVSeHRSZUxUU2ZzRDFrTXBSMWlJSG5Sc0lJWHBKRDhrcUtoNnlYODhvbWZo?=
 =?utf-8?B?M24vS1czcWoxdGFzVlF4OTc0ZFQzZW1ZdXRLb3Y1cDArdXFHRWlvMlFQNlpp?=
 =?utf-8?B?bGRPdGxEcytBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB8136.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVRDM2hPWDBIeTNEcHBDckViOWttVWtFRmVYNnl2NTQ0QjRHZ0xBSG1DSXVL?=
 =?utf-8?B?d3hhbVI3MGJQdE9tbndWNkdjUE1aeWRkRy8zUTkxWlBkYTFvOFV0OUFpKytO?=
 =?utf-8?B?K3JGVWVqZ1dsUkxkeklCWDZIbGY3S2YxSWMrMmxWSkdrVzk3K0VZWlh0N1h5?=
 =?utf-8?B?T05yWXVHYmRXQkx0TnhOMjNIYll5ZjU2V2RnK3Z3ZVI0ZUJUeSt6TXlObXNG?=
 =?utf-8?B?Vyt3ZnliRmpwK0VyUEV2NC9UMzN1cmtDWVc1NjN0dlVjcmpDckN4Z0ViVEVQ?=
 =?utf-8?B?TXhOdE10SXRWQUxnWlU2VFVyWDFWQTczMnA2ajRveXBnYjBwaWZ4UEdTa3Yv?=
 =?utf-8?B?N21rcVdlVUdRZE9mT1o4TWRwTkM0Um0zYjBZSi9ZQzRpM3g4Yllva3RTOUdE?=
 =?utf-8?B?MVlsbkozNWg1dHZTQVZtdnk3Q0dVN1FTK0pTMmg2ZlM4amJrMmtQSGNiSGZ2?=
 =?utf-8?B?YkdTdXdkWkQzQlpmanB1eVVoc0cyZFNLOERDSlJaNlgybThEaER3VTNJQ0hl?=
 =?utf-8?B?VFN1amxaM3ZCaFo2cHRHSTBrOWt0Sk5DZFNTVTZXZ2NUVmNXZ1JFRS9SOWdZ?=
 =?utf-8?B?TFRhZ0FuamRGWVlJU3doMVdMenVpWUR1b3RUSUxNaXduZ0lJd1BsTEtDRkYv?=
 =?utf-8?B?YUhlL2MxdjAvQVJkYWcrVzhySjRtOXBnNG9nQ2kvazJITmo5clliaktFeExW?=
 =?utf-8?B?QkZFaUJ6RFpkWEdLbTZvbDFEVVpyWXBKWktpVkNwa09lN3JvQmlxRjNHWERD?=
 =?utf-8?B?dEk1WUFmVkVVOVVSZGdnK3ZOQXZJQVJ3OTl6bndCbEFlMWpuc0dhT0Z5NVpQ?=
 =?utf-8?B?UUVmaFVaamNsdnovN2RMNmNMcWFqRE03WnJVUkJpSXpHYWNNc1NndnlGYjFx?=
 =?utf-8?B?MWVIdjhIVnFHUk1YbHczd3RoTi83VHY5N3BjbFRqL2tnVEJtb3Q1cXhkTG5k?=
 =?utf-8?B?M0FzeDVDMkhkRm5zOFZpLzAwUVI2Tmh0WXFuci9Cd1BwUk5DQ3RNd0djNktu?=
 =?utf-8?B?dzNnSjc5MG9CQ3NQMEpsUE40WHNpaDhhVjRpamN0Q2NUbkk2OFVmR0R6bm1P?=
 =?utf-8?B?MWJTd0x3TXJRZUZCdVMvSkRsc3NpZW1HQkZsL1J5bEtsZW5GdlF3bkxza1NJ?=
 =?utf-8?B?QlZYRTl5Ukc3SjdoSXAwUFBZZDdzLzBxL1h1YlZmeDJaQzFmeUI1ZjVxSGx3?=
 =?utf-8?B?RnEreUprYkcxRWs1enFpS3lZSytGYW0vMWZhR2p4SjdHbEFkWllkTStkd2ky?=
 =?utf-8?B?OWdNRklKUWZ4Q3lrY0VSbGY0RVJLRTIvZ0xwaktFMWlWSGVJRitsMlgvV0oy?=
 =?utf-8?B?bVRiRFFXbHlZbnB1TW1MRUVqU09QVVN5SW5IR1FsdXU3MTY4K3NMa25DUzY2?=
 =?utf-8?B?ZUpGbjVtb1Z1YlRKZUFhZWpjNDhUNU1XbDBVUDhRNlNGYUg2bUoyemd5N3pL?=
 =?utf-8?B?QUZqSGJNbHhMSzJaSFE5K1lRd1dPRHovSzVHWTJ0SHhEekh1TGcwaDZZVTJV?=
 =?utf-8?B?WGkrTTVNQ0J4OUcwUzBQNmRGUmJUbEJ4aWVvVGNVZFZkZzd6VlZ4aHdIY0I0?=
 =?utf-8?B?K3RuR3U0Y2xUZE1XQ1dBSTlkMmZUUnd4RUIvNHZhOEhmVENLYjlJWjhWdm5k?=
 =?utf-8?B?RUkzRXpCaDI3dUxUWGRYSG5ORGorRjY2NGpwczBpZnQ3alV4Um5pYTVRRnhI?=
 =?utf-8?B?NVhtckgrdzNxY1gwNWxESEpLampSL3RveSsyMTBWdUJ3ZUdLN09MOEVHUWdL?=
 =?utf-8?B?dUNuRmJ3R2JiczBWTTg0ZHRwQ2RqVE5TWEFJeHluSkhwa2J2K09jaE1ZR1pr?=
 =?utf-8?B?Rll1VTJSUEwrTVgvWnUwWFZEN2JQMWN2NS9SaDg2aUZuZHYwdkRmbUFRaVJo?=
 =?utf-8?B?TTZhK2dUMng0UlNrQy92S3FvYTN1dHh1VkpOYmtuOEZ0M0t2bXFUK0RDM3ls?=
 =?utf-8?B?MTFJODZlQ1Y3bUEvSUlwazF0SG9tTzAzWnRNazFKSjBEa0h1WldYazVDZWxJ?=
 =?utf-8?B?SitMc1R4RjRQN3hYY3pwTDNDMkFXemtoa0JEWU9HWWx5UXhJV1dNaW5hYjMz?=
 =?utf-8?B?U1lMZlIybEdWdmx0bkZ3ODFWM0lpMldwS0lScmhIZHFOSko4TlVKTTdWRlN5?=
 =?utf-8?Q?Ln+ZAqezX4xVfI+e3tOj6IG1V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38897708F17DC544AB5C0D9EC83592F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8136.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d2285f-4b49-402e-1469-08dd5659c3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 11:36:09.4446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBRkm8IoVQ+pIJoMssJQNfk0sWS5KjMTnWidQxJQmAl7PxGn+09mUR5qyFVOpUJKI0+jYt2iEneQT0SaM5uv9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8260

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDEzOjQ5ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxOS8wMi8yNSAxMDoyMCwgSmF5IExpdSBo
YSBzY3JpdHRvOg0KPiA+IEFkZCBDQ09SUiBjb21wb25lbnQgc3VwcG9ydCBmb3IgTVQ4MTk2Lg0K
PiA+IA0KPiA+IENDT1JSIGlzIGEgaGFyZHdhcmUgbW9kdWxlIHRoYXQgb3B0aW1pemVzIHRoZSB2
aXN1YWwgZWZmZWN0cyBvZg0KPiA+IGltYWdlcyBieSBhZGp1c3RpbmcgdGhlIGNvbG9yIG1hdHJp
eCwgZW5hYmxpbmcgZmVhdHVyZXMgc3VjaCBhcw0KPiA+IG5pZ2h0IGxpZ2h0Lg0KPiA+IA0KPiA+
IFRoZSA4MTk2IGhhcmR3YXJlIHBsYXRmb3JtIGluY2x1ZGVzIHR3byBDQ09SUiAoQ29sb3IgQ29y
cmVjdGlvbikNCj4gPiB1bml0cy4NCj4gPiBIb3dldmVyLCB0aGUgYG10a19jY29ycl9jdG1fc2V0
YCBBUEkgb25seSB1dGlsaXplcyBvbmUgb2YgdGhlc2UNCj4gPiB1bml0cy4NCj4gPiBUbyBwcmV2
ZW50IHRoZSB1bnVzZWQgQ0NPUlIgdW5pdCBmcm9tIGluYWR2ZXJ0ZW50bHkgdGFraW5nIGVmZmVj
dCwNCj4gPiB3ZSBuZWVkIHRvIGJsb2NrIGl0IGJ5IGFkZGluZyBtYW5kYXRvcnlfY2NvcnIgZmxh
ZyBpbiB0aGUNCj4gPiBkcml2ZXJfZGF0YS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXkg
TGl1IDxqYXkubGl1QG1lZGlhdGVrLmNvbT4NCj4gDQo+IFRoaXMgaXMgeWV0IGFub3RoZXIgdGhp
bmcgdGhhdCBjYW4gYmUgcmVzb2x2ZWQgYnkgdXNpbmcgT0YgR3JhcGggZm9yDQo+IGRlZmluaW5n
IHRoZQ0KPiBkaXNwbGF5IHBpcGVsaW5lOiBieSB1c2luZyB0aGF0LCBJIGRvbid0IHNlZSBob3cg
Y2FuIENDT1JSMSBiZSB1c2VkDQo+IGluc3RlYWQgb2YNCj4gQ0NPUlIwLCBpZiB0aGUgbGF0dGVy
IGlzIGluIHRoZSBwaXBlbGluZSwgYnV0IG5vdCB0aGUgZm9ybWVyLg0KPiANCj4gTkFDSy4NCj4g
DQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCmhpIEFuZ2VsbywgdGhhbmsgeW91IGZvciB5b3Vy
IHJldmlldywNCg0KVGhlIDgxOTYgSUMgaGFzIHR3byBDQ09SUnMsIGFuZCB0aGV5IG11c3QgYmUg
Y2hhaW5lZCB0b2dldGhlciBpbiBhDQpmaXhlZCBvcmRlciwgZm9yIGV4YW1wbGU6IE1EUF9SU1ow
LT5ESVNQX1REU0hQMC0+RElTUF9DQ09SUjAtDQo+RElTUF9DQzBSUjEtPkRJU1BfR0FNTUEwLT5E
SVNQX1BPU1RNQVNLMC0+RElTUF9ESVRIRVIwLiBBbW9uZyB0aGVtLA0KRElTUF9DQ09SUjAgaXMg
dXNlZCBmb3IgY3RtX3NldCwgYW5kIERJU1BfQ0NPUlIxIHdhcyBvcmlnaW5hbGx5IGZvciBQUQ0K
ZnVuY3Rpb25zLCBidXQgdGhlIGN1cnJlbnQgcHJvamVjdCBkb2VzIG5vdCBoYXZlIFBRIGZ1bmN0
aW9ucywgc28gcmVsYXkNCmNhbiBiZSB1c2VkLiBNb3Jlb3ZlciwgY3RtX3NldCBvbmx5IG5lZWRz
IHRvIGNvbmZpZ3VyZSBvbmUgQ0NPUlIsIHNvDQpjdXJyZW50bHksIG1hbmRhdG9yeV9jY29yciBp
cyBzZXQuIENvbnNpZGVyaW5nIHRoYXQgcHJldmlvdXMgSUNzLCBzdWNoDQphcyA4MTk1LCBvbmx5
IGhhdmUgb25lIENDT1JSLCBzbyBtYW5kYXRvcnlfY2NvcnIgaXMgc2V0IHRvIERJU1BfQ0NPUlIw
Lg0KVGhpcyBpcyB0aGUgY3VycmVudCBwcmFjdGljZS4gRG8geW91IGhhdmUgYW55IG90aGVyIHN1
Z2dlc3Rpb25zIHRvDQphY2hpZXZlIHNpbWlsYXIgdGhpbmdzPyBGb3IgZXhhbXBsZSwgYWRkaW5n
IGEgcHJvcGVydHkgaW4gdGhlIGR0cyB0bw0Kc2V0IG1hbmRhdG9yeV9jY29yciwgYnV0IHRoaXMg
d2lsbCBpbmV2aXRhYmx5IGNoYW5nZSB0aGUgZHRzIG9mIHBhc3QNCklDcywgYW5kIHdlIGFyZSB3
b3JyaWVkIHRoYXQgc3VjaCBjaGFuZ2VzIHdpbGwgYmUgc2lnbmlmaWNhbnQuDQoNClRoYW5rcyBh
IGxvdA0KSkFZDQoNCg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kZHBfY29tcC5jICAgfCAgMyArKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9jY29yci5jIHwgMTYgKysrKysrKysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuYw0KPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jDQo+ID4gaW5kZXggZWRjNjQxNzYzOWU2
Li5kN2UyMzBiYWM1M2UgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kZHBfY29tcC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
ZHBfY29tcC5jDQo+ID4gQEAgLTQ1Nyw3ICs0NTcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19kZHBfY29tcF9tYXRjaA0KPiA+IG10a19kZHBfbWF0Y2hlc1tERFBfQ09NUE9ORU5UX0RSTV9J
RF9NQVhdDQo+ID4gICAgICAgW0REUF9DT01QT05FTlRfQUFMMF0gICAgICAgICAgICA9IHsNCj4g
PiBNVEtfRElTUF9BQUwsICAgICAgICAgICAgICAgMCwgJmRkcF9hYWwgfSwNCj4gPiAgICAgICBb
RERQX0NPTVBPTkVOVF9BQUwxXSAgICAgICAgICAgID0gew0KPiA+IE1US19ESVNQX0FBTCwgICAg
ICAgICAgICAgICAxLCAmZGRwX2FhbCB9LA0KPiA+ICAgICAgIFtERFBfQ09NUE9ORU5UX0JMU10g
ICAgICAgICAgICAgPSB7DQo+ID4gTVRLX0RJU1BfQkxTLCAgICAgICAgICAgICAgIDAsIE5VTEwg
fSwNCj4gPiAtICAgICBbRERQX0NPTVBPTkVOVF9DQ09SUl0gICAgICAgICAgID0gew0KPiA+IE1U
S19ESVNQX0NDT1JSLCAgICAgICAgICAgICAwLCAmZGRwX2Njb3JyIH0sDQo+ID4gKyAgICAgW0RE
UF9DT01QT05FTlRfQ0NPUlIwXSAgICAgICAgICA9IHsNCj4gPiBNVEtfRElTUF9DQ09SUiwgICAg
ICAgICAgICAgMCwgJmRkcF9jY29yciB9LA0KPiA+ICsgICAgIFtERFBfQ09NUE9ORU5UX0NDT1JS
MV0gICAgICAgICAgPSB7DQo+ID4gTVRLX0RJU1BfQ0NPUlIsICAgICAgICAgICAgIDEsICZkZHBf
Y2NvcnIgfSwNCj4gPiAgICAgICBbRERQX0NPTVBPTkVOVF9DT0xPUjBdICAgICAgICAgID0gew0K
PiA+IE1US19ESVNQX0NPTE9SLCAgICAgICAgICAgICAwLCAmZGRwX2NvbG9yIH0sDQo+ID4gICAg
ICAgW0REUF9DT01QT05FTlRfQ09MT1IxXSAgICAgICAgICA9IHsNCj4gPiBNVEtfRElTUF9DT0xP
UiwgICAgICAgICAgICAgMSwgJmRkcF9jb2xvciB9LA0KPiA+ICAgICAgIFtERFBfQ09NUE9ORU5U
X0RJVEhFUjBdICAgICAgICAgPSB7DQo+ID4gTVRLX0RJU1BfRElUSEVSLCAgICAgICAgICAgIDAs
ICZkZHBfZGl0aGVyIH0sDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9jY29yci5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfY2NvcnIuYw0KPiA+IGluZGV4IDEwZDYwZDJjMmE1Ni4uOTRlODJiM2ZhMmQ4IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Njb3JyLmMNCj4gPiBAQCAt
MzEsMTEgKzMxLDEzIEBADQo+ID4gDQo+ID4gICBzdHJ1Y3QgbXRrX2Rpc3BfY2NvcnJfZGF0YSB7
DQo+ID4gICAgICAgdTMyIG1hdHJpeF9iaXRzOw0KPiA+ICsgICAgIGVudW0gbXRrX2RkcF9jb21w
X2lkIG1hbmRhdG9yeV9jY29ycjsNCj4gPiAgIH07DQo+ID4gDQo+ID4gICBzdHJ1Y3QgbXRrX2Rp
c3BfY2NvcnIgew0KPiA+ICAgICAgIHN0cnVjdCBjbGsgKmNsazsNCj4gPiAgICAgICB2b2lkIF9f
aW9tZW0gKnJlZ3M7DQo+ID4gKyAgICAgZW51bSBtdGtfZGRwX2NvbXBfaWQgY29tcF9pZDsNCj4g
PiAgICAgICBzdHJ1Y3QgY21kcV9jbGllbnRfcmVnIGNtZHFfcmVnOw0KPiA+ICAgICAgIGNvbnN0
IHN0cnVjdCBtdGtfZGlzcF9jY29ycl9kYXRhICAgICAgICAqZGF0YTsNCj4gPiAgIH07DQo+ID4g
QEAgLTExNSw2ICsxMTcsOSBAQCB2b2lkIG10a19jY29ycl9jdG1fc2V0KHN0cnVjdCBkZXZpY2Ug
KmRldiwNCj4gPiBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiA+ICAgICAgIGlmICgh
YmxvYikNCj4gPiAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiANCj4gPiArICAgICBpZiAoY2Nv
cnItPmNvbXBfaWQgIT0gY2NvcnItPmRhdGEtPm1hbmRhdG9yeV9jY29ycikNCj4gPiArICAgICAg
ICAgICAgIHJldHVybjsNCj4gPiArDQo+ID4gICAgICAgY3RtID0gKHN0cnVjdCBkcm1fY29sb3Jf
Y3RtICopYmxvYi0+ZGF0YTsNCj4gPiAgICAgICBpbnB1dCA9IGN0bS0+bWF0cml4Ow0KPiA+IA0K
PiA+IEBAIC0xNTQsNiArMTU5LDcgQEAgc3RhdGljIGludCBtdGtfZGlzcF9jY29ycl9wcm9iZShz
dHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgICAgc3RydWN0IGRldmlj
ZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiAgICAgICBzdHJ1Y3QgbXRrX2Rpc3BfY2NvcnIgKnBy
aXY7DQo+ID4gICAgICAgaW50IHJldDsNCj4gPiArICAgICBlbnVtIG10a19kZHBfY29tcF9pZCBj
b21wX2lkOw0KPiA+IA0KPiA+ICAgICAgIHByaXYgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2Yo
KnByaXYpLCBHRlBfS0VSTkVMKTsNCj4gPiAgICAgICBpZiAoIXByaXYpDQo+ID4gQEAgLTE2OSw2
ICsxNzUsMTQgQEAgc3RhdGljIGludCBtdGtfZGlzcF9jY29ycl9wcm9iZShzdHJ1Y3QNCj4gPiBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9w
cm9iZShkZXYsIFBUUl9FUlIocHJpdi0+cmVncyksDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiZmFpbGVkIHRvIGlvcmVtYXAgY2NvcnJcbiIpOw0KPiA+IA0KPiA+ICsg
ICAgIGNvbXBfaWQgPSBtdGtfZGRwX2NvbXBfZ2V0X2lkKGRldi0+b2Zfbm9kZSwgTVRLX0RJU1Bf
Q0NPUlIpOw0KPiA+ICsgICAgIGlmIChjb21wX2lkIDwgMCkgew0KPiA+ICsgICAgICAgICAgICAg
ZGV2X2VycihkZXYsICJGYWlsZWQgdG8gaWRlbnRpZnkgYnkgYWxpYXM6ICVkXG4iLA0KPiA+IGNv
bXBfaWQpOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIGNvbXBfaWQ7DQo+ID4gKyAgICAgfQ0K
PiA+ICsNCj4gPiArICAgICBwcml2LT5jb21wX2lkID0gY29tcF9pZDsNCj4gPiArDQo+ID4gICAj
aWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4gPiAgICAgICByZXQgPSBjbWRxX2Rl
dl9nZXRfY2xpZW50X3JlZyhkZXYsICZwcml2LT5jbWRxX3JlZywgMCk7DQo+ID4gICAgICAgaWYg
KHJldCkNCj4gPiBAQCAtMTkyLDEwICsyMDYsMTIgQEAgc3RhdGljIHZvaWQgbXRrX2Rpc3BfY2Nv
cnJfcmVtb3ZlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiANCj4gPiAg
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3BfY2NvcnJfZGF0YSBtdDgxODNfY2NvcnJfZHJp
dmVyX2RhdGENCj4gPiA9IHsNCj4gPiAgICAgICAubWF0cml4X2JpdHMgPSAxMCwNCj4gPiArICAg
ICAubWFuZGF0b3J5X2Njb3JyID0gRERQX0NPTVBPTkVOVF9DQ09SUjAsDQo+ID4gICB9Ow0KPiA+
IA0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9jY29ycl9kYXRhIG10ODE5Ml9j
Y29ycl9kcml2ZXJfZGF0YQ0KPiA+ID0gew0KPiA+ICAgICAgIC5tYXRyaXhfYml0cyA9IDExLA0K
PiA+ICsgICAgIC5tYW5kYXRvcnlfY2NvcnIgPSBERFBfQ09NUE9ORU5UX0NDT1JSMCwNCj4gPiAg
IH07DQo+ID4gDQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZGlz
cF9jY29ycl9kcml2ZXJfZHRfbWF0Y2hbXQ0KPiA+ID0gew0KPiANCj4gDQo=

