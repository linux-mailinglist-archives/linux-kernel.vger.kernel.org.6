Return-Path: <linux-kernel+bounces-345662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE83E98B8F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D19283936
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5F11A0734;
	Tue,  1 Oct 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V357RL72";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oxPGmN5T"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833419DFB5;
	Tue,  1 Oct 2024 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777277; cv=fail; b=SuWnyzuT4RWg8Vyk3GBo6DMw4hjODpsmE6oZACzNKsFqge1ijBkDRMGa7JARwbPcdOerqxf1z1UD1S+4OYtwb8MnGNHs6weaMRD/5mHqTqM6bd0HZC/c/UQ3jRhDiRCamgUsNP5l73DCUZY62XrUZMwT0DS7xFTEgw2jY+YiSIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777277; c=relaxed/simple;
	bh=OU+LK5fE2EvmefkeC5lWP5xP/nMWtnJhitmnMA3Ybaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M/Fus/58fUXEIpSLokmfAGLW+SXS3JepXL0yAT/6DR/BTq4gndAwMD2YNtMxQJQ4iexxgqYjiGDDIMytD0FvdfQrrKX8INFDT61rLPnOb0YlVwgQTPC0WQinO23o6sYO7VP0hV+2jXbC2asqbOS0O5kXjWM07MXJEh4v14aSws8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=V357RL72; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=oxPGmN5T; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 02baadf67fdd11ef8b96093e013ec31c-20241001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OU+LK5fE2EvmefkeC5lWP5xP/nMWtnJhitmnMA3Ybaw=;
	b=V357RL72Bk7zLMipL94M2gPxji1CEHYIMmUvXiKJ1aPgfUPq3Rmv19QtJFJ9jxHoegue9NYseXYBj2iGBGsEzJcMxb8XZn+fhFvjfW85cIXCp17EYjDShf8CVzL6LOGoC+pwhBZXR/3McMW94qXgGt8mvM+WHofyf7j5lvcql/E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:0941706b-894f-4f44-8ebf-b848bbf7218c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:00100dd1-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 02baadf67fdd11ef8b96093e013ec31c-20241001
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2028894731; Tue, 01 Oct 2024 18:07:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Oct 2024 18:07:46 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Oct 2024 18:07:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByNpC+q4YE18PrHt+oMBNME4OU1oeXsjQfuqyPqpx5C7hPBX4lkwBaDk3y8Qm+LL6nYoJQjvdygHf6WF+s0q8E8Z/ccXXlaE5QJPPaxJwbXBMoNxMK71wDhrnieTPQYu3mS0mK6FQdIJPKERzRZXeZCOLzGlIfCcYXOQ2+n9QQ41B6ufb5aCFR7qhCi81yLUCZjxVkzaJ/rZpmni7T21va4d8khsT5G+bRMjCC5ymwW/Ggavv7LpOsqxiGvjYZgK2/RIUuAfyHNAu9ZsnrlwH9mvHN+CZqySqGuh/zIStlrAbpxy8L88+KUoFbUT6l0BETXF0EnnC+Eakk7w9E2r4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU+LK5fE2EvmefkeC5lWP5xP/nMWtnJhitmnMA3Ybaw=;
 b=mVoiNbi7m9AKmcoYAeQ9ecfKst0pktyZr0Y3WfCYu4SK7XtJNf8RafklGui0gyxT1aB4CyM/kRVA1f/reSFuqQ3I3mqHoyDldjcyWfxiLexU0OIGufUIN7d3k4N4Kd9wwqpSQlYGAFCKMMbQif4D3ekGURvDlWmiLj1PYO/DRxptbMsvKgPKjTkVItaJjBZLiCYYR2IILmLf1sFRFGyKA68ExLIEXsLDdkV7ZhEf0IxryOONYzGv37N8yo1g6dht1Qp0QNLGoyRwZFATMkYaemSPeVv7Ex6ARfj0vsHQHPdgRG59L060y7tlViZgHwn8k//Pg6FoGR09AsSev2v36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU+LK5fE2EvmefkeC5lWP5xP/nMWtnJhitmnMA3Ybaw=;
 b=oxPGmN5TGglv3PKS6dBNHaslsEk25zSCh4N4+eQx0wMa3kRI96d8LUSPtnswfcLc607KUEPnQGKevWKNTTwV3HGxpQpJGPjnxiAKA41Ajxiq0wMhdyX4SB0fTd24xc/qKjCIJMI3HPuBpaOVeUquaoumONRfEp6uV5BLY4kP2G4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7385.apcprd03.prod.outlook.com (2603:1096:400:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Tue, 1 Oct
 2024 10:07:43 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 10:07:42 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"sui.jingfeng@linux.dev" <sui.jingfeng@linux.dev>, "wenst@chromium.org"
	<wenst@chromium.org>, Sjoerd Simons <sjoerd@collabora.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"michael@walle.cc" <michael@walle.cc>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
	"mwalle@kernel.org" <mwalle@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
Subject: Re: [PATCH v10 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Topic: [PATCH v10 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Index: AQHbA292H5spe39bB06Ujog96ornebJxzKIA
Date: Tue, 1 Oct 2024 10:07:42 +0000
Message-ID: <e3953947f5cf05e8e6a2ec3448cf0c08a8c39c1c.camel@mediatek.com>
References: <20240910105054.125005-1-angelogioacchino.delregno@collabora.com>
	 <01020191db8f22cd-0f5d733b-420e-453c-8607-a3e9f70f32d6-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020191db8f22cd-0f5d733b-420e-453c-8607-a3e9f70f32d6-000000@eu-west-1.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7385:EE_
x-ms-office365-filtering-correlation-id: 719778a4-15ca-4895-0e5e-08dce200e3aa
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0s3NUNiY3dVUXcvUDNsZFFQYUJXeldIMmVvUS9lSGtZcWJSWWhKRnJZb0pC?=
 =?utf-8?B?Q0l3YndJdW92a0kxR3dhdi9hQVFpUDFiS2pkWVJrRk1nNzdubTIyRU16QnI1?=
 =?utf-8?B?Zkw5eklFSGI2QitpUS8yS1p5UjJYckRGdGl6cnRHODV4eElobjhVT2s4Y2VU?=
 =?utf-8?B?bmVsVmJHZVNXcWJZSDNiVXhlM3R2Y25SUU1reTRreDM2dXkxZEpUTzQwNUFw?=
 =?utf-8?B?ZjZQRURJZnpoVHFHa0xwUmhDSXRGVXpCZW1HRDhjNTlGOC9BaW01bVlHbGRG?=
 =?utf-8?B?UmZqRmRjdm82WWFoODJlT2h2T2ZOcWwvcEpFdGo1aTNFVFA4RDJ0ZkF3eDdL?=
 =?utf-8?B?MElXSnEvaHg5NnRtR21YeFl2YzhMQ1RyMit4SGZLN1RxR3FiVzQxMkg4V1pS?=
 =?utf-8?B?MnlENm9hVHFNWVNiSzhiYlZQS3NxWHBHTFMrT1JSa2dncVpEd0w1R0Fsc2lB?=
 =?utf-8?B?VHcxTXNZN1B1UEoxR0hwNG1USCs0OFRNQzNvTW9pWkFFRVQ3WjhlbFMrQVlI?=
 =?utf-8?B?LzF5akVyb2QxMlBiTXMyUFRXUzRCVitCd3IzWDhzQzNRU2FQYVRCTjRmcDdE?=
 =?utf-8?B?M0VjMjAxSGRLOGMvT3dTYUl5WXRnYnBsN2Zidjdtb3ZqTE9qeWVCcEl5Qk5w?=
 =?utf-8?B?cy90WnhoVDJLN1ZYd240TTFlbTZBMkZWT1dCUmhJam1YNjRoZzdhaVBzcElr?=
 =?utf-8?B?SDFaN0VkR2ovSlFGMm1uMmY0QVJmMVJmelc3a3lQUWk1bzJ5dGZ3azZ5dU05?=
 =?utf-8?B?OUJvZ3dJWnMwZU1VdjRCOHNKeG5ZZjFGbHBsTTBzMlkrL1I0eU0rK3NGTHdp?=
 =?utf-8?B?TlZ4Z28zaFBHekwvWHZ5NnFIQmlsKzFNbk4xSHFPb2xSc25sQTNIMW1Ialhk?=
 =?utf-8?B?a1l1YmNmcXU2d1MrNENTOG1OUTNGa3QwYmxvRXVLQ1ArVHNYS2ZKNWhJZGE0?=
 =?utf-8?B?NDhQd0lGOFlsYWVGU2YvcUxEZnp2Wm9RQ0JDOS9YQkZvNi9Ud25QalVCRXR6?=
 =?utf-8?B?MXNFQldld2hwRUpRaS9CQW8xc3hIV3Z2RXJucEZ0UkV5aWhra0QzUFlzZ0hk?=
 =?utf-8?B?N2pFeGpTbnYyYkc4bCtmcnY1a0thc1VwTFpndFVwcGhrMmtQcVFwRXBSY3JY?=
 =?utf-8?B?MUEraW1GZExRZ1Q4Ry9SM2xzbWc5RUhZNDNiWHdOTkdtQjhyT3FsQlNVdDl6?=
 =?utf-8?B?UTNlNC9kSmdYNGNSRUxFdjc4Tm92a1R6SHZIV3Zja1JFVzJhNkpFTU5IUWN0?=
 =?utf-8?B?TjNzd1ZBM2FHMGJkdHRhMTFpMFgzMnhGNjBmNktleGloVm51ZlI2QVV6V0xk?=
 =?utf-8?B?MEJxMGNBenJMRUErYlhXWklPTVV2Q3hMMXNBWmhMZWU1MHA4MnZMWkU1NkVa?=
 =?utf-8?B?OEpSYmp5K2pGYkFZTFNYZUhHQU1rYWtqYTdWOU9lV0wwcjZ4OS93Q2VrMVlT?=
 =?utf-8?B?KzNNMjlkcVdpUnRSaExMYmhhM1JjYTczUFNncXdNZGlyaEl1bXY4Sm1MR09W?=
 =?utf-8?B?OXRsVUpMM1pWcy9hcFliNzh1VXRSWVduR05tT0NIRVFaeUl5S0lnZzRXL0JD?=
 =?utf-8?B?N21yTnI0UmU5MkFrZnlWWVhycm1hcDkrRldSVk9qN2MzSHVGRlQ0bG56Z3Va?=
 =?utf-8?B?NDlrR05vcGVqZmx0ZTdwNm1CNUJQakVRWDJsZ2xHR1dJS0g3UUdaQXlDRkVk?=
 =?utf-8?B?Q1lLV2Q2QWlPZ3JVeW9wVng1T2xnNktCamVoZFFZRmpwYXJpSEZuYVNmNTB6?=
 =?utf-8?B?L2hhQnJWbkxQck5zRjIyZzZadFRLekg2U3lhQ3ZYTmFNTU9UZnFVVE5JT2Ew?=
 =?utf-8?B?SkNlTHZTelhIdVVOOTE2UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWZib2RVOW0yUXdIWG9qVDc5dHpPZE41NFFLZ1lhNy96ZGV0MmI0WVZET25T?=
 =?utf-8?B?VHRwVnUzOXBsQlFlN0JSZWZVdVllVE1PWHZKSmlDZ1dZYUZtODkra2FMMTBE?=
 =?utf-8?B?OVFISEVPak9XQWMrdVJVZTI4bHhRNFhNQmV5d01xVEVkUERIWEFYM3dVSjcr?=
 =?utf-8?B?eWtqVXYxSHJlMDNuYlUxZER6eG54M3FVcUNjZSt5eG1NSHY0bHBXSVdGQTRR?=
 =?utf-8?B?bjh3TUdmdzFHRml3b3ZqeE1pRC9tTG56UlZqWWFkbXZ2aGFGT0J2RWRVRE9o?=
 =?utf-8?B?RXZ5L0hkQVNmYm5ZckE3TXNOaTVZVEU0V3N3VXZ2K0tnNGZiWUVhTzFzdEV2?=
 =?utf-8?B?K21VcitMUUhzMzE3NTUzM0NiYU5zdjJ5a1E5WVJ3aHc3Y21wcWQxUXZkdlpt?=
 =?utf-8?B?elQ4WUt2d05XUkhOYzFTL2JMazNvYzBWMGFEcHVLQW83cUZXT2k5NkhNZUxn?=
 =?utf-8?B?VFhUdHQ5WFM3VWlQbW9wZG1STG1SUitRa3cxN3dLL0RTQnZjbGpxVTFPSkU5?=
 =?utf-8?B?dVVaL0sxUE5ESkpvc2I0M1JMNnA2cjlGUWFtMk51QkZoeXNDTUFadEc5WDVU?=
 =?utf-8?B?cFBPWXp1dTFTTEdUSDc3Njg1SHI3M3lUV2xRWGFuMUU5MTRzSHl6TUhUalc0?=
 =?utf-8?B?YzlJVnNuYXE4OTdPV3g2Tk9JRGs0Y0NrTjF5b2IwWVBLUTNlNFhjNWxWcVdK?=
 =?utf-8?B?Vm1EdTRTTWlMalNmeGYwaHNTK2pDNUtuWWdnbXlCK0daV1p5eUkwVzZUMUVO?=
 =?utf-8?B?dFcrcWdKS3FLTG43eGwwLytaRHNXaUpXRGJXZjJqaDFjbEVIRDRXa0ViZjZM?=
 =?utf-8?B?NWFxYklQV1JyZmVtcC8vT1hSMUFBeXpXNVV0THpYQjJnLytkQUZJbDNJc1E3?=
 =?utf-8?B?OUNKZ3BYUlIyVjdCNU41WVBHREdVOVlWMjI0UldVb1NZN3ZTaWxqYndmY1hy?=
 =?utf-8?B?b05sMnppU2NtVFNHa1IyNzBnQUI3T2lkc1BpOXptckdDcHV3VVk0OUlvdVJz?=
 =?utf-8?B?SXJKcytBZWgvWHZ4UlZPd2Ryc2NMNFhmZU5scSt5RWRURU5vZTVaZ3RXdXIw?=
 =?utf-8?B?TkUxZ0YwN2tVOW1zMnBmN0c5eWxpdDh2NzlYTW1tMDU1YkN5ZmZ0cjlUVmVo?=
 =?utf-8?B?RFQ2eXlFQjlROENtQlVxd21LUVVpallXNThEeTh2dzZQREJPYVVRZzNuZ05N?=
 =?utf-8?B?U21CakROakdsRmxCM3N2NU9yRk44VmhkN0hIT1Q5RXEzQmQ5bHEwZXdTWkda?=
 =?utf-8?B?RlE4RHc0TlBRSzBGbTRnWkRZRElrajlBNE9hcWxlRWJXeWVacmx0MWNKTGd3?=
 =?utf-8?B?MnliendqTmhNN0lrWnF5WU5jT3RnLys3dkVwNjF6d0txdzFqSWhNS3Aremxa?=
 =?utf-8?B?L1hLTmhNc3JRd25tVTFLL04yL1dwTzh0M2UrNldOWDN0TzlGU05zbmpRYzdB?=
 =?utf-8?B?RWxqUW1NaTVWdU82dzY2NmMvN1VxdXRRalhPb3dHbVFnMVZWY0JOK1p0WHB3?=
 =?utf-8?B?M3p6SmZOZzM5VUJJcE45Q2hXR0Y3MlR1TFAwMkFJWFZjTlRQTTNuQ0xyUDFs?=
 =?utf-8?B?a1A4RXBack8rNDRhZlpPWlRTd055NXFnN3NuVVlRbDdWMm9PWUJnWlZlM3N4?=
 =?utf-8?B?dnk4WTE4QU5sVmhoU29LOXBoa2tlU05WTnQzQWRnUW1BeXVaSGJsUWwyVFdz?=
 =?utf-8?B?TU5ncFVMWDlHRHlxTlVZMTNVcUttQkljb1Q2YzZPcFhaZXJIVXlDbzgyaW4z?=
 =?utf-8?B?WEdTY0ltcWFIKzJkY3UyOVJhaE5ocTVKZndjK2gxK1IwTjRrMnJoQnNheVR0?=
 =?utf-8?B?a3ZxdmtpY1BVNTRjdFEzQVNGOFoyd2tUWmVMSWFBZEJUTnV2UG1WcDNNUWVY?=
 =?utf-8?B?SnZGdjRCNmU2bHpia283OTIvRjdveGd0L0VvUE9CRFduQmg3QUlXMk5nQ3d1?=
 =?utf-8?B?NWlBNGhzTlhKOTVJbTZZUXFxVUdCWjNwZWpndDR4SDMxSDBHbGVSaE4wcWJF?=
 =?utf-8?B?Yi9YWmMxazhtYlpLRU42R0xKMmlUdkZOTnIycEhHbzJUUVF1UlBkMkZSRW9I?=
 =?utf-8?B?U2hhcGtFTXJveHIzTkFlWmExUlZsZ09vSWc1UVRvTVVPOW9aSzdqaFphSUhj?=
 =?utf-8?Q?ZYhdyFzAFFn2IFBLNNGBxek+T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2260F6CC96AD8641B80F90AA17A6EBD1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719778a4-15ca-4895-0e5e-08dce200e3aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 10:07:42.6856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6v8DNkl2JGbXripkbsTkcDmSFf5k74qBh6gj5ORpZHTGyZcwV7HNXRTccEjtrmLKGA+LjVMgvJfSGvXnyFeHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7385

SGksIEFuZ2VsbzoNCg0KT24gVHVlLCAyMDI0LTA5LTEwIGF0IDEwOjUxICswMDAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSXQgaXMgaW1wb3NzaWJsZSB0byBhZGQgZWFj
aCBhbmQgZXZlcnkgcG9zc2libGUgRERQIHBhdGggY29tYmluYXRpb24NCj4gZm9yIGVhY2ggYW5k
IGV2ZXJ5IHBvc3NpYmxlIGNvbWJpbmF0aW9uIG9mIFNvQyBhbmQgYm9hcmQ6IHJpZ2h0IG5vdywN
Cj4gdGhpcyBkcml2ZXIgaGFyZGNvZGVzIGNvbmZpZ3VyYXRpb24gZm9yIDEwIFNvQ3MgYW5kIHRo
aXMgaXMgZ29pbmcgdG8NCj4gZ3JvdyBsYXJnZXIgYW5kIGxhcmdlciwgYW5kIHdpdGggbmV3IGhh
Y2tzIGxpa2UgdGhlIGludHJvZHVjdGlvbiBvZg0KPiBtdGtfZHJtX3JvdXRlIHdoaWNoIGlzIGFu
eXdheSBub3QgZW5vdWdoIGZvciBhbGwgZmluYWwgcm91dGVzIGFzIHRoZQ0KPiBEU0kgY2Fubm90
IGJlIGNvbm5lY3RlZCB0byBNRVJHRSBpZiBpdCdzIG5vdCBhIGR1YWwtRFNJLCBvciBlbmFibGlu
Zw0KPiBEU0MgcHJldmVudGl2ZWx5IGRvZXNuJ3Qgd29yayBpZiB0aGUgZGlzcGxheSBkb2Vzbid0
IHN1cHBvcnQgaXQsIG9yDQo+IG90aGVycy4NCj4gDQo+IFNpbmNlIHByYWN0aWNhbGx5IGFsbCBk
aXNwbGF5IElQcyBpbiBNZWRpYVRlayBTb0NzIHN1cHBvcnQgYmVpbmcNCj4gaW50ZXJjb25uZWN0
ZWQgd2l0aCBkaWZmZXJlbnQgaW5zdGFuY2VzIG9mIG90aGVyLCBvciB0aGUgc2FtZSwgSVBzDQo+
IG9yIHdpdGggZGlmZmVyZW50IElQcyBhbmQgaW4gZGlmZmVyZW50IGNvbWJpbmF0aW9ucywgdGhl
IGZpbmFsIEREUA0KPiBwaXBlbGluZSBpcyBlZmZlY3RpdmVseSBhIGJvYXJkIHNwZWNpZmljIGNv
bmZpZ3VyYXRpb24uDQo+IA0KPiBJbXBsZW1lbnQgT0YgZ3JhcGhzIHN1cHBvcnQgdG8gdGhlIG1l
ZGlhdGVrLWRybSBkcml2ZXJzLCBhbGxvd2luZyB0bw0KPiBzdG9wIGhhcmRjb2RpbmcgdGhlIHBh
dGhzLCBhbmQgcHJldmVudGluZyB0aGlzIGRyaXZlciB0byBnZXQgYSBodWdlDQo+IGFtb3VudCBv
ZiBhcnJheXMgZm9yIGVhY2ggYm9hcmQgYW5kIFNvQyBjb21iaW5hdGlvbiwgYWxzbyBwYXZpbmcg
dGhlDQo+IHdheSB0byBzaGFyZSB0aGUgc2FtZSBtdGtfbW1zeXNfZHJpdmVyX2RhdGEgYmV0d2Vl
biBtdWx0aXBsZSBTb0NzLA0KPiBtYWtpbmcgaXQgbW9yZSBzdHJhaWdodGZvcndhcmQgdG8gYWRk
IHN1cHBvcnQgZm9yIG5ldyBjaGlwcy4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4YW5kcmUgTWVy
Z25hdCA8YW1lcmduYXRAYmF5bGlicmUuY29tPg0KPiBUZXN0ZWQtYnk6IEFsZXhhbmRyZSBNZXJn
bmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+IEFja2VkLWJ5OiBTdWkgSmluZ2ZlbmcgPHN1
aS5qaW5nZmVuZ0BsaW51eC5kZXY+DQo+IFRlc3RlZC1ieTogTWljaGFlbCBXYWxsZSA8bXdhbGxl
QGtlcm5lbC5vcmc+ICMgb24ga29udHJvbi1zYmMtaTEyMDANCj4gU2lnbmVkLW9mZi1ieTogQW5n
ZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFi
b3JhLmNvbT4NCj4gLS0tDQoNCltzbmlwXQ0KDQo+ICsNCj4gK2Jvb2wgbXRrX292bF9hZGFwdG9y
X2lzX2NvbXBfcHJlc2VudChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUpDQo+ICt7DQo+ICsJZW51
bSBtdGtfb3ZsX2FkYXB0b3JfY29tcF90eXBlIHR5cGU7DQo+ICsJaW50IHJldDsNCj4gKw0KPiAr
CXJldCA9IG92bF9hZGFwdG9yX29mX2dldF9kZHBfY29tcF90eXBlKG5vZGUsICZ0eXBlKTsNCj4g
KwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwlpZiAodHlwZSA+PSBPVkxf
QURBUFRPUl9UWVBFX05VTSkNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJLyoNCj4gKwkg
KiBFVEhEUiBhbmQgUGFkZGluZyBhcmUgdXNlZCBleGNsdXNpdmVseSBpbiBPVkwgQWRhcHRvcjog
aWYgdGhpcw0KPiArCSAqIGNvbXBvbmVudCBpcyBub3Qgb25lIG9mIHRob3NlLCBpdCdzIGxpa2Vs
eSBub3QgYW4gT1ZMIEFkYXB0b3IgcGF0aC4NCj4gKwkgKi8NCg0KSSBkb24ndCBrbm93IHlvdXIg
bG9naWMgaGVyZS4NClRoZSBPVkwgQWRhcHRvciBwaXBlbGluZSBpczoNCg0KbWRwX3JkbWEgLT4g
cGFkZGluZyAtLS0rICAgICAgKy0tLS0tLS0rDQogICAgICAgICAgICAgICAgICAgICBNZXJnZSAt
PiB8ICAgICAgIHwNCm1kcF9yZG1hIC0+IHBhZGRpbmcgLS0tKyAgICAgIHwgICAgICAgfA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICB8DQptZHBfcmRtYSAtPiBwYWRkaW5n
IC0tLSsgICAgICB8ICAgICAgIHwNCiAgICAgICAgICAgICAgICAgICAgIE1lcmdlIC0+IHwgICAg
ICAgfA0KbWRwX3JkbWEgLT4gcGFkZGluZyAtLS0rICAgICAgfCAgICAgICB8DQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IEVUSERSIHwNCm1kcF9yZG1hIC0+IHBhZGRpbmcgLS0tKyAg
ICAgIHwgICAgICAgfA0KICAgICAgICAgICAgICAgICAgICAgTWVyZ2UgLT4gfCAgICAgICB8DQpt
ZHBfcmRtYSAtPiBwYWRkaW5nIC0tLSsgICAgICB8ICAgICAgIHwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgICAgfA0KbWRwX3JkbWEgLT4gcGFkZGluZyAtLS0rICAgICAgfCAg
ICAgICB8DQogICAgICAgICAgICAgICAgICAgICBNZXJnZSAtPiB8ICAgICAgIHwNCm1kcF9yZG1h
IC0+IHBhZGRpbmcgLS0tKyAgICAgICstLS0tLS0tKw0KDQpTbyBtZHBfcmRtYSBhbmQgbWVyZ2Ug
aXMgbm90IE9WTCBBZGFwdG9yPw0KDQoNCj4gKwlyZXR1cm4gdHlwZSA9PSBPVkxfQURBUFRPUl9U
WVBFX0VUSERSIHx8IHR5cGUgPT0gT1ZMX0FEQVBUT1JfVFlQRV9QQURESU5HOw0KPiArfQ0KPiAr
DQo+ICANCg0KW3NuaXBdDQoNCj4gKw0KPiArLyoqDQo+ICsgKiBtdGtfZHJtX29mX2RkcF9wYXRo
X2J1aWxkX29uZSAtIEJ1aWxkIGEgRGlzcGxheSBIVyBQaXBlbGluZSBmb3IgYSBDUlRDIFBhdGgN
Cj4gKyAqIEBkZXY6ICAgICAgICAgIFRoZSBtZWRpYXRlay1kcm0gZGV2aWNlDQo+ICsgKiBAY3Bh
dGg6ICAgICAgICBDUlRDIFBhdGggcmVsYXRpdmUgdG8gYSBWRE8gb3IgTU1TWVMNCj4gKyAqIEBv
dXRfcGF0aDogICAgIFBvaW50ZXIgdG8gYW4gYXJyYXkgdGhhdCB3aWxsIGNvbnRhaW4gdGhlIG5l
dyBwaXBlbGluZQ0KPiArICogQG91dF9wYXRoX2xlbjogTnVtYmVyIG9mIGVudHJpZXMgaW4gdGhl
IHBpcGVsaW5lIGFycmF5DQo+ICsgKg0KPiArICogTWVkaWFUZWsgU29DcyBjYW4gdXNlIGRpZmZl
cmVudCBERFAgaGFyZHdhcmUgcGlwZWxpbmVzIChvciBwYXRocykgZGVwZW5kaW5nDQo+ICsgKiBv
biB0aGUgYm9hcmQtc3BlY2lmaWMgZGVzaXJlZCBkaXNwbGF5IGNvbmZpZ3VyYXRpb247IHRoaXMg
ZnVuY3Rpb24gd2Fsa3MNCj4gKyAqIHRocm91Z2ggYWxsIG9mIHRoZSBvdXRwdXQgZW5kcG9pbnRz
IHN0YXJ0aW5nIGZyb20gYSBWRE8gb3IgTU1TWVMgaGFyZHdhcmUNCj4gKyAqIGluc3RhbmNlIGFu
ZCBidWlsZHMgdGhlIHJpZ2h0IHBpcGVsaW5lIGFzIHNwZWNpZmllZCBpbiBkZXZpY2UgdHJlZXMu
DQo+ICsgKg0KPiArICogUmV0dXJuOg0KPiArICogKiAlMCAgICAgICAtIERpc3BsYXkgSFcgUGlw
ZWxpbmUgc3VjY2Vzc2Z1bGx5IGJ1aWx0IGFuZCB2YWxpZGF0ZWQNCj4gKyAqICogJS1FTk9FTlQg
LSBEaXNwbGF5IHBpcGVsaW5lIHdhcyBub3Qgc3BlY2lmaWVkIGluIGRldmljZSB0cmVlDQo+ICsg
KiAqICUtRUlOVkFMIC0gRGlzcGxheSBwaXBlbGluZSBidWlsdCBidXQgdmFsaWRhdGlvbiBmYWls
ZWQNCj4gKyAqICogJS1FTk9NRU0gLSBGYWlsdXJlIHRvIGFsbG9jYXRlIHBpcGVsaW5lIGFycmF5
IHRvIHBhc3MgdG8gdGhlIGNhbGxlcg0KPiArICovDQo+ICtzdGF0aWMgaW50IG10a19kcm1fb2Zf
ZGRwX3BhdGhfYnVpbGRfb25lKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBtdGtfY3J0Y19wYXRo
IGNwYXRoLA0KPiArCQkJCQkgY29uc3QgdW5zaWduZWQgaW50ICoqb3V0X3BhdGgsDQo+ICsJCQkJ
CSB1bnNpZ25lZCBpbnQgKm91dF9wYXRoX2xlbikNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5leHQsICpwcmV2LCAqdmRvID0gZGV2LT5wYXJlbnQtPm9mX25vZGU7DQo+ICsJdW5zaWdu
ZWQgaW50IHRlbXBfcGF0aFtERFBfQ09NUE9ORU5UX0RSTV9JRF9NQVhdID0geyAwIH07DQo+ICsJ
dW5zaWduZWQgaW50ICpmaW5hbF9kZHBfcGF0aDsNCj4gKwl1bnNpZ25lZCBzaG9ydCBpbnQgaWR4
ID0gMDsNCj4gKwlib29sIG92bF9hZGFwdG9yX2NvbXBfYWRkZWQgPSBmYWxzZTsNCj4gKwlpbnQg
cmV0Ow0KPiArDQo+ICsJLyogR2V0IHRoZSBmaXJzdCBlbnRyeSBmb3IgdGhlIHRlbXBfcGF0aCBh
cnJheSAqLw0KPiArCXJldCA9IG10a19kcm1fb2ZfZ2V0X2RkcF9lcF9jaWQodmRvLCAwLCBjcGF0
aCwgJm5leHQsICZ0ZW1wX3BhdGhbaWR4XSk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlpZiAobmV4
dCAmJiB0ZW1wX3BhdGhbaWR4XSA9PSBERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUikgew0K
DQptZHBfcmRtYSB3b3VsZCBub3QgYmUgRERQX0NPTVBPTkVOVF9EUk1fT1ZMX0FEQVBUT1IuDQoN
Cj4gKwkJCWRldl9kYmcoZGV2LCAiQWRkaW5nIE9WTCBBZGFwdG9yIGZvciAlcE9GXG4iLCBuZXh0
KTsNCj4gKwkJCW92bF9hZGFwdG9yX2NvbXBfYWRkZWQgPSB0cnVlOw0KPiArCQl9IGVsc2Ugew0K
PiArCQkJaWYgKG5leHQpDQo+ICsJCQkJZGV2X2VycihkZXYsICJJbnZhbGlkIGNvbXBvbmVudCAl
cE9GXG4iLCBuZXh0KTsNCj4gKwkJCWVsc2UNCj4gKwkJCQlkZXZfZXJyKGRldiwgIkNhbm5vdCBm
aW5kIGZpcnN0IGVuZHBvaW50IGZvciBwYXRoICVkXG4iLCBjcGF0aCk7DQo+ICsNCj4gKwkJCXJl
dHVybiByZXQ7DQo+ICsJCX0NCj4gKwl9DQo+ICsJaWR4Kys7DQo+ICsNCj4gKwkvKg0KPiArCSAq
IFdhbGsgdGhyb3VnaCBwb3J0IG91dHB1dHMgdW50aWwgd2UgcmVhY2ggdGhlIGxhc3QgdmFsaWQg
bWVkaWF0ZWstZHJtIGNvbXBvbmVudC4NCj4gKwkgKiBUbyBiZSB2YWxpZCwgdGhpcyBtdXN0IGVu
ZCB3aXRoIGFuICJpbnZhbGlkIiBjb21wb25lbnQgdGhhdCBpcyBhIGRpc3BsYXkgbm9kZS4NCj4g
KwkgKi8NCj4gKwlkbyB7DQo+ICsJCXByZXYgPSBuZXh0Ow0KPiArCQlyZXQgPSBtdGtfZHJtX29m
X2dldF9kZHBfZXBfY2lkKG5leHQsIDEsIGNwYXRoLCAmbmV4dCwgJnRlbXBfcGF0aFtpZHhdKTsN
Cj4gKwkJb2Zfbm9kZV9wdXQocHJldik7DQo+ICsJCWlmIChyZXQpIHsNCj4gKwkJCW9mX25vZGVf
cHV0KG5leHQpOw0KPiArCQkJYnJlYWs7DQo+ICsJCX0NCj4gKw0KPiArCQkvKg0KPiArCQkgKiBJ
ZiB0aGlzIGlzIGFuIE9WTCBhZGFwdG9yIGV4Y2x1c2l2ZSBjb21wb25lbnQgYW5kIG9uZSBvZiB0
aG9zZQ0KPiArCQkgKiB3YXMgYWxyZWFkeSBhZGRlZCwgZG9uJ3QgYWRkIGFub3RoZXIgaW5zdGFu
Y2Ugb2YgdGhlIGdlbmVyaWMNCj4gKwkJICogRERQX0NPTVBPTkVOVF9PVkxfQURBUFRPUiwgYXMg
dGhpcyBpcyB1c2VkIG9ubHkgdG8gZGVjaWRlIHdoZXRoZXINCj4gKwkJICogdG8gcHJvYmUgdGhh
dCBjb21wb25lbnQgbWFzdGVyIGRyaXZlciBvZiB3aGljaCBvbmx5IG9uZSBpbnN0YW5jZQ0KPiAr
CQkgKiBpcyBuZWVkZWQgYW5kIHBvc3NpYmxlLg0KPiArCQkgKi8NCj4gKwkJaWYgKHRlbXBfcGF0
aFtpZHhdID09IEREUF9DT01QT05FTlRfRFJNX09WTF9BREFQVE9SKSB7DQoNCm1lcmdlIHdvdWxk
IG5vdCBiZSBERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUi4NCkZpbmFsbHksIHRoZSBwYXRo
IHdvdWxkIGJlOg0KDQptZHBfcmRtYSAtPiBvdmwgYWRhcHRvciAocGFkZGluZykgLT4gbWVyZ2Ug
LT4gKGV0aGRyIGlzIHNraXBwZWQgaGVyZSkgLi4uDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJCQlp
ZiAoIW92bF9hZGFwdG9yX2NvbXBfYWRkZWQpDQo+ICsJCQkJb3ZsX2FkYXB0b3JfY29tcF9hZGRl
ZCA9IHRydWU7DQo+ICsJCQllbHNlDQo+ICsJCQkJaWR4LS07DQo+ICsJCX0NCj4gKwl9IHdoaWxl
ICgrK2lkeCA8IEREUF9DT01QT05FTlRfRFJNX0lEX01BWCk7DQo+ICsNCj4gKwkvKg0KPiArCSAq
IFRoZSBkZXZpY2UgY29tcG9uZW50IG1pZ2h0IG5vdCBiZSBlbmFibGVkOiBpbiB0aGF0IGNhc2Us
IGRvbid0DQo+ICsJICogY2hlY2sgdGhlIGxhc3QgZW50cnkgYW5kIGp1c3QgcmVwb3J0IHRoYXQg
dGhlIGRldmljZSBpcyBtaXNzaW5nLg0KPiArCSAqLw0KPiArCWlmIChyZXQgPT0gLUVOT0RFVikN
Cj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCS8qIElmIHRoZSBsYXN0IGVudHJ5IGlzIG5vdCBh
IGZpbmFsIGRpc3BsYXkgb3V0cHV0LCB0aGUgY29uZmlndXJhdGlvbiBpcyB3cm9uZyAqLw0KPiAr
CXN3aXRjaCAodGVtcF9wYXRoW2lkeCAtIDFdKSB7DQo+ICsJY2FzZSBERFBfQ09NUE9ORU5UX0RQ
X0lOVEYwOg0KPiArCWNhc2UgRERQX0NPTVBPTkVOVF9EUF9JTlRGMToNCj4gKwljYXNlIEREUF9D
T01QT05FTlRfRFBJMDoNCj4gKwljYXNlIEREUF9DT01QT05FTlRfRFBJMToNCj4gKwljYXNlIERE
UF9DT01QT05FTlRfRFNJMDoNCj4gKwljYXNlIEREUF9DT01QT05FTlRfRFNJMToNCj4gKwljYXNl
IEREUF9DT01QT05FTlRfRFNJMjoNCj4gKwljYXNlIEREUF9DT01QT05FTlRfRFNJMzoNCj4gKwkJ
YnJlYWs7DQo+ICsJZGVmYXVsdDoNCj4gKwkJZGV2X2VycihkZXYsICJJbnZhbGlkIGRpc3BsYXkg
aHcgcGlwZWxpbmUuIExhc3QgY29tcG9uZW50OiAlZCAocmV0PSVkKVxuIiwNCj4gKwkJCXRlbXBf
cGF0aFtpZHggLSAxXSwgcmV0KTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+
ICsJZmluYWxfZGRwX3BhdGggPSBkZXZtX2ttZW1kdXAoZGV2LCB0ZW1wX3BhdGgsIGlkeCAqIHNp
emVvZih0ZW1wX3BhdGhbMF0pLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWZpbmFsX2RkcF9wYXRo
KQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCWRldl9kYmcoZGV2LCAiRGlzcGxheSBI
VyBQaXBlbGluZSBidWlsdCB3aXRoICVkIGNvbXBvbmVudHMuXG4iLCBpZHgpOw0KPiArDQo+ICsJ
LyogUGlwZWxpbmUgYnVpbHQhICovDQo+ICsJKm91dF9wYXRoID0gZmluYWxfZGRwX3BhdGg7DQo+
ICsJKm91dF9wYXRoX2xlbiA9IGlkeDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo=

