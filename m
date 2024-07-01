Return-Path: <linux-kernel+bounces-235526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6896991D634
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0610B2811B5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71603BA20;
	Mon,  1 Jul 2024 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RYrROkUU";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="npuQTIy+"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E0F9CF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719801353; cv=fail; b=NLvq3LrnIsFGwzNgzUkL5nkDunokbDbGbabrNNV4hGYt5g2PWGrk896j7rw8EIpRj3dxBzLsqjjFsINcP90ANjkLoLq6/sxFZEvGloVY60+F9AuyCTH6GAXDZGPSvYn4Rm78vJcJaB1MSIbEbrWIysUkutqmCWRRG1lbpxYG04A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719801353; c=relaxed/simple;
	bh=hy3kZEbNVe3S5Wr4FpSxPy59PenYRG7h5P1UiYxrktA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QWywFnP3qkTet6dEXKGMjMHGXnuMRfCb93htviUutJEy5B6WZ1Fr7jCpQiSEzWhvs/MGmDnUUdanvVGMnNk62Mcc0f/c0beskyXljFoTLo5tAv3tQ4Yg3z6OXpv0MMhIl5Xqhl7GwKu0Tr3c3abE7XxZnlGXxxjcOuTuJQEWXE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RYrROkUU; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=npuQTIy+; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9c714c30375211ef99dc3f8fac2c3230-20240701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hy3kZEbNVe3S5Wr4FpSxPy59PenYRG7h5P1UiYxrktA=;
	b=RYrROkUUUJZQWuvJyOrs4FKKYVPJGH7eATe2ffDv0dsgNSx5g/3uUPR+bZOxFBabP5ra26vO+5s8RgopJoJEv39Zot/eP2wGrBmTJSGQunx5sxX8a5fobBxMmyMcmlFpP5LXIJ8zwN+MXLn6sduNs4vyPyJxjRofaFSaZMqVu/A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:edabc188-c259-42c5-8f39-3981f0275a21,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:debbedd0-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9c714c30375211ef99dc3f8fac2c3230-20240701
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 194613772; Mon, 01 Jul 2024 10:35:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 1 Jul 2024 10:35:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 1 Jul 2024 10:35:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNLBve++5A2kUG6eC2MyMOiqus5fB2Lukz6qW3NN9qzSQRb3wvuMEqeKaRHDBsFybtX7xyd7cv2Vp1WTfdpUn2dG7INEruGZqUTM7a++tux7n8clCRYEbf8O5gh0gzF9wHWV/nAy5WgTFMdNKxX/pS5lGdujSSDfdUiHd4GVVWOuZUw/Sffo1Z2D+ktOfaspVBxtSC4YWBjam8Dmfc1zJLZVTysnAiLRmWGt8zhzcbfkr5QsC3zIIsp7b9K80LApwwBuN9TW4FRRpl3Qc8dUpJK8qwCYMNwqIc6dU8UGEFjNKSxBBV9kxOEUfwiB6l6JnbD6Kh+uYu9qn6qPll++fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy3kZEbNVe3S5Wr4FpSxPy59PenYRG7h5P1UiYxrktA=;
 b=iBcRBlGT8eyf2zbIQ01fwDIFajywgyL5ciX2KGEVdNMENqbp6IIFd51oSqYqvobaxwOO9GjKlveC9Y3L22xNVWWHTfmEfreUx7CjmXuEq5MSwoMudMe3r4qN+duSCE+n19wFqPlsas/BDV996Q1/VKTGuq0vtXwm2ZRFnY3XOpOzc4a0TzjwDXUEdUHKFg61r/ZUvrvH4EsNGIhRITGtTDko2KhLTiVsqt9IJz+1l4O8ruuW4hieO/VI2N5DnzGoY+b0pSWUTuHN3jrwBGOFZgGfHqGg3pYlKus9zmcxDF+yomKif4RtAnWGdWLO9UzK3mmNj96roIjOZB7VWqjaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy3kZEbNVe3S5Wr4FpSxPy59PenYRG7h5P1UiYxrktA=;
 b=npuQTIy+boBrlv8KQgsc/4rIRYgedi6OSv5Jy46XhfRrW01L4R1qx99EwbOtw6JXlodc/uPqH0nb2aaOEzQii3SYnE6L4wb5+MGWtaG7UInz0n0+4fKksaKMnURIuoTqlQ1bk1HsC5IveJQ5A3gMfO+VZ2atvYoNwWbvjUlw5qk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7036.apcprd03.prod.outlook.com (2603:1096:101:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 02:35:38 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 02:35:38 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] drm/mediatek: Support "Pre-multiplied" blending in
 OVL
Thread-Topic: [PATCH 3/5] drm/mediatek: Support "Pre-multiplied" blending in
 OVL
Thread-Index: AQHawm4YC1q8YURcu02KYhRdvO+ITrHhOdsA
Date: Mon, 1 Jul 2024 02:35:38 +0000
Message-ID: <8df86f0a1ba3d44a6be3c5a5291eaf9cec4a7638.camel@mediatek.com>
References: <20240620-blend-v1-0-72670072ca20@mediatek.com>
	 <20240620-blend-v1-3-72670072ca20@mediatek.com>
In-Reply-To: <20240620-blend-v1-3-72670072ca20@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7036:EE_
x-ms-office365-filtering-correlation-id: c5827b98-b9f4-4c82-e127-08dc99767e5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MnYwZXpjLzlIaWMzbFU2ZW5BMG1lM0xhbXoyajU4U3UyOWxGZ2J1SnpEWHhx?=
 =?utf-8?B?TlduRXdsZ1JyalR4VlFiWFFGVUF0cnVvWi9KMURZYUNCNkRWSENlTFlKcWs4?=
 =?utf-8?B?VXRFQkZIR1NEWVRkUmVQUm9CUDd2a20vMFNPWnRwMGNsdEowQTdhSXZndHV2?=
 =?utf-8?B?Y1FhaWZjVVB5SjY1SUlYMWhESDB0MUZsODZHQmJyRzdsUDVQVUlWZTgrT3dq?=
 =?utf-8?B?YVBkQ0FsT1p0QUVEQS9LT1NIS29EbFRBdmRRVFgyVS96Um96YUxSQzU5bGdI?=
 =?utf-8?B?cFhubE9PTG0rR2xNMlY4eGhnNE5aNUdGdmt1ZVNvTWFadGlvQjVvckwyZHJl?=
 =?utf-8?B?RmVHR2N2SDhkWUl1T0x1ZE5zWFgvUGR0WEVEL29tV2E0aWt4SHpDbkZ4WlVY?=
 =?utf-8?B?OElXT3RRWkptU0NwRTZMQjJHdmZqVGpiNFluUU9CcEhyb01kSDhxOGZBWnZx?=
 =?utf-8?B?bzNDblRQdVRIcFBZbFpmZzhWZktNY2crcXRlQ20zNlNwVWtEdks3OWtjRHp4?=
 =?utf-8?B?Nm9RSzZVQ3diK0RpZ1QrTFVqWEVLSTAxV1JVZzlqaEJSbTVwN0NyaUprTHVB?=
 =?utf-8?B?U1IzTjEvTncrei85U21XYnN1N2lNN0R1QkZ1REpuTTB5Qk14dzlVa1FlR0Fs?=
 =?utf-8?B?aHR1d2RvN1hVZUFqTWdmYjM0eDJyS2ZzZkNWc1ROS3UxZnBRTlgxbkFLcnJx?=
 =?utf-8?B?S09QOG5JREZUYmxkRngzV09qbkRkMXViNGNhNFgwRUIwVGpuaFB6VEEwVHlx?=
 =?utf-8?B?Snl2Y0RnSGdvUXluQmJEMTM4N1RUWTVXUVcwUVNLSjRQYVhCb0tnOFJuVkxL?=
 =?utf-8?B?cGdGeWk5Y1BkUzdpRTg2cUtRbUdyOVVCZ1FZZENvUGpyTGxhSXhtL0hCYWdI?=
 =?utf-8?B?MmwvSEFBNTM0NVlHdU9Jbk91bnF1YjFxTCtmTmU1Ky9xMWdhMW4xYUt0MmMw?=
 =?utf-8?B?ZU1tRkM5TXFyYjdFaWVDcnVFaVRMTHdZUTFFTUMvQjNJWGM3d3pNU09VdVZK?=
 =?utf-8?B?VFR3Q2FMUVVLaDg0QUsxYWh3NjdpQ1VQSU5WcUgvRURZdGkva0tzKzJsZmIv?=
 =?utf-8?B?dUxoVjlpUHowUW8vZUJDQTQxcytGV1BGSk9Wd3J1WDdTM0dycUpmbWZtWVlG?=
 =?utf-8?B?YnVyM1BldU9ETmRkWk5RZWFsTUhUS1dCUG81Nk1BY3lPWU1KVXBmZXR4SEc5?=
 =?utf-8?B?MXB5VnRCdEtkUmxEMkZjeDl6N0ZFSGZ1UmNkR2ZhVzQzd3ZqcWFqRm1BOXor?=
 =?utf-8?B?N1FWL1dtaGY5Y2QxWFhHREhhVWlsaEZkalRLakJwZlNXZmZLKzJZSzc3Q3Fm?=
 =?utf-8?B?SjZ5Q0hxYzljM0VGUkVVTGtSZVA2LzVtZkZZaElnM3ZqWG9KZkh4eW9Xay9v?=
 =?utf-8?B?UGtHbWVJQlNYSXcvNEJmTnhhbXFvS2FlNnBUSkVpT0NRZmh2RGRGaTVCZm0z?=
 =?utf-8?B?eitiY0V2aVV4aVBFcEFVZTVEcno0Z3lRZ1EyMXlUTnNjZnVnbklvUWM5NXFy?=
 =?utf-8?B?UzV5aGdJT1BPWnhRNUNWWmw4M2dlUlhqdjd5NVNHa3pRSlcxRXNDMjU3T1Zx?=
 =?utf-8?B?WVhoa251MVJnd1NpM0ZUeFd6RTVKOFZVQnREdnBqUlkvcXR6TXVLaDJ4WThw?=
 =?utf-8?B?dEdiTFd6ZUFyYmM1ZmlCQWloazhJMVR1eGlOcHlqcTkrMnJQTXp3VmlJYTF0?=
 =?utf-8?B?d0d6Zk5GYjJPYTR2RzQ5ODMyb2VzdDJLMWNrcDlpR2Rxd0JSUnV6Z2YxTmRi?=
 =?utf-8?B?ZS9SenNQVzNqZ25zYlBQeEY2VkJkM1hFNzF0MDNhRzdiM0M2RExxVjBIM2pG?=
 =?utf-8?B?bzlKVWk4Yi9iSHJuL005Wk5WT0R0dHFqTlp1R3BIckZJUlJuOER2Um01emsx?=
 =?utf-8?B?TU5oM0cwam9xRVBzNThwekVSNWlLNVRQemM5THRQam9CVWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFpwR20zNC81SEZEamFFV0hzYU42WUdBS1lrRWRkTi9PRHF5QWFPaFhRd1hV?=
 =?utf-8?B?WVV6TXBqaWVJUjJzSjRsYnFTcW9NVVljQ3ByQzlvSU9zL1l5Z3hrc2Zlblk1?=
 =?utf-8?B?SjZldVY2S2VDM3QzRFBHVVZVQ2RwcDdINVFkZExhV0JIUmwrcG5Za2VOZkF1?=
 =?utf-8?B?SWNhcU4rUGVDT2x6S1VwVWI4dU96VVNDcHRvY1h2ZlovVVUzR0ZnaXJzS2Zn?=
 =?utf-8?B?QU5yVnNiSjkvMm1NblJPdUxpb2NZbnZQMGFrbzZibHRwVmVuaGZmdUJoRVlD?=
 =?utf-8?B?d3hDQzBFWlBzcWFqUXhJbHlOYzdrdFFrQlVGaDlad1NKYlJDaUpkNjEyU1V6?=
 =?utf-8?B?Q0lxRXJvbVRFeVdRYkpVa0owTXc5NGM1dnFGQzYyZmNqbndyNHpvTk5UN1VK?=
 =?utf-8?B?cHlncGkrY0lTVjB2VGNwUE1zSmhQbXh1OVIzVTh6OFFyVmZQUGhDNlN5UUl6?=
 =?utf-8?B?UXhvNGFBaTU4SnFKOUh1MGd4L21MbWViR3lpQXUweG14UklMQ0RWeEd3bFIr?=
 =?utf-8?B?TmJubGdtcTJrOGc3aG5nWlBJZ0YrMVNNTUQvbGxOT2JhZXpURXkvVGF6WTdr?=
 =?utf-8?B?RWlPY21tOTJTN3N6VHdsK1AvZnIyY3NDdzhwTFJMRytLQWFYSjlERjk2b3Rn?=
 =?utf-8?B?V3FSZVB2dGdaSzlmbDBVbUNjMjVkNW92eUZNcXFpODkwK3JzZzZaZFhHS2Yw?=
 =?utf-8?B?Ri80Z2M1bUN4T0RaZ3BJZTg4NFVBK011YVNWQTNZQzdaazdtL2NvR0JJSGdJ?=
 =?utf-8?B?dnFTL2VvQUNZMkJJOXp2NWovS2hYZDc0eVhJVU5DVkhIY01uTThxWTBXdGcw?=
 =?utf-8?B?MFBseDZVSldFaS9RV1Y4ZUJFSldmQnNFWnRCR0xVRFkyLzdETE9PTzBBSWts?=
 =?utf-8?B?YnFhYkdVU2NSa0RhdHRrdXJZV3pUZlF1bmxCMnd0Z00wVGtET1ROSGExWVAy?=
 =?utf-8?B?UmdPTURzQ3p5NjQ3VnVKditDNlhIV21RazJrL1BsSTA4bGgyTjJMcU8xY1Fx?=
 =?utf-8?B?NmZ1b2pMYTl2L3Z3R0xUcTkzZ3M3Y3hYZE9FNlBiWnMrV1NnZzJINGpQdVVl?=
 =?utf-8?B?Q3J1OVd4eEtnZlI1NkFGZzF2WVRqSm1tdkU1MEdvdHZwQktmWW9XM0phSXFS?=
 =?utf-8?B?WitTUXpBY096TG5XZVdMVE9WVW1JVi92N3UvRXNqZFFlR1BXY29PRTIrZDRZ?=
 =?utf-8?B?V1JPckM4N2NhMi9nMjV2cTdGWWdIbTJBSzNOeGl1cmhKcFRxN2EyQ0cwL0w2?=
 =?utf-8?B?ZEhDbHpJKzEwazVGOXJYS05FbXVvSkZ3TGFJMnZDS3MrcUlabDlRNnpBZ3R3?=
 =?utf-8?B?MzlCRW1ONDdLMnJjNGdDeUIrL2pmaWVrZUtqOE1GWmN1MndUeWVBM3Vpa0ZQ?=
 =?utf-8?B?ZkR0Rm04TlNEWGlTUDRtRTVvU2REN2NBZVN4YjRuQWtSd0VEL2E4d0N5K09Q?=
 =?utf-8?B?UDNnMnJDeDhhOWZiODlsOUFTVjNCL2pIVFhuTWpxTWFUdkN2U0ZrYzgrNmV4?=
 =?utf-8?B?SzFsNU52cW5VakhYZkN4V3hYRXl3L1RrL3VRY05Ra2I1YkFyQlRuSXBNNS9U?=
 =?utf-8?B?U0ljRS84QkNzeWdSb0R0Mjl3Qy9MeWI3Y0pKZ1UrN3BSVnk5b3hLUDY5WXE2?=
 =?utf-8?B?SUZ4N2J3Wlc2L0lnYkpjU1A0RlNLN0FKSWJrbE9VTkR1Vk54RFN1a2l1WnNB?=
 =?utf-8?B?ZExreFB0SElwR3RTMVFIZFkwYnQ1a1g4ZmIwT0RMRThDUDQ3WG5meXBGNUJz?=
 =?utf-8?B?a05KTzVGTUxUSVEyR2dURDlTRGFYdStHdzZZZkEzdnhYb3R6SmtVaXIyWUlQ?=
 =?utf-8?B?YWNrRHlpcTdzcVMvYUM3akNHeWRONjZZNG9MSjU3OVcxL2h1Y0dFUzByL2kw?=
 =?utf-8?B?dzlKa01jVTRjUXkyck85eStiT0lCakFHNW4rVVZzL0JMamt0TER4aW5ZRjZu?=
 =?utf-8?B?MnpOOW1XbjVFR3dQMGhQMzdHWTQ2WW01eW9zU3ZoRHlyZHk5SWVFVTJ4M2pR?=
 =?utf-8?B?ZkZrMWdJLzFGWlpxN3FDYThIRUsvVTVId3dpVUZsbHAzVEZtbW9oNm0wckJT?=
 =?utf-8?B?dW5iVTdnclhzVStCNGExMWVQaERGWmc4SWc1TWJVdWtOekF0cW9VUHBuaGlK?=
 =?utf-8?Q?F/6WTqT//eR/y2oTVEJ1F66Wy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92FEA29BC2E50B44AB44F062AF2728C5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5827b98-b9f4-4c82-e127-08dc99767e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 02:35:38.4930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnU+UOCEVPNks3l/tggzNgDxMbnWWi8klRiOVOrBYjKkm5pEuF+hTZzSp+2a0Dg4Y+BBzsN4MhtJTTJll951iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7036

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDYtMjAgYXQgMDE6MjcgKzA4MDAsIEhzaWFvIENo
aWVuIFN1bmcgdmlhIEI0IFJlbGF5IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQ
bGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhh
dmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEZyb206IEhzaWFvIENo
aWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiANCj4gU3VwcG9ydCAiUHJlLW11
bHRpcGxpZWQiIGFscGhhIGJsZW5kaW5nIG1vZGUgb24gaW4gT1ZMLg0KPiBCZWZvcmUgdGhpcyBw
YXRjaCwgb25seSB0aGUgImNvdmVyYWdlIiBtb2RlIGlzIHN1cHBvcnRlZC4NCg0KUmV2aWV3ZWQt
Ynk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhz
aWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyB8IDMyICsrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3Bfb3ZsLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMN
Cj4gaW5kZXggYWQ5MjI4ZmM0ZGQ5Li44ZTlhYWUzNmEyODkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gQEAgLTUyLDggKzUyLDEyIEBADQo+ICAjZGVm
aW5lIEdNQ19USFJFU0hPTERfSElHSCgoMSA8PCBHTUNfVEhSRVNIT0xEX0JJVFMpIC8gNCkNCj4g
ICNkZWZpbmUgR01DX1RIUkVTSE9MRF9MT1coKDEgPDwgR01DX1RIUkVTSE9MRF9CSVRTKSAvIDgp
DQo+ICANCj4gKyNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfTUFOQklUKDIzKQ0KPiAgI2RlZmluZSBP
VkxfQ09OX0JZVEVfU1dBUEJJVCgyNCkNCj4gLSNkZWZpbmUgT1ZMX0NPTl9NVFhfWVVWX1RPX1JH
Qig2IDw8IDE2KQ0KPiArDQo+ICsvKiBPVkxfQ09OX1JHQl9TV0FQIHdvcmtzIG9ubHkgaWYgT1ZM
X0NPTl9DTFJGTVRfTUFOIGlzIGVuYWJsZWQgKi8NCj4gKyNkZWZpbmUgT1ZMX0NPTl9SR0JfU1dB
UEJJVCgyNSkNCj4gKw0KPiAgI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9SR0IoMSA8PCAxMikNCj4g
ICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODgoMiA8PCAxMikNCj4gICNkZWZpbmUgT1ZM
X0NPTl9DTFJGTVRfUkdCQTg4ODgoMyA8PCAxMikNCj4gQEAgLTYxLDYgKzY1LDExIEBADQo+ICAj
ZGVmaW5lIE9WTF9DT05fQ0xSRk1UX0JHUkE4ODg4KE9WTF9DT05fQ0xSRk1UX0FSR0I4ODg4IHwg
T1ZMX0NPTl9CWVRFX1NXQVApDQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1VZVlkoNCA8PCAx
MikNCj4gICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfWVVZVig1IDw8IDEyKQ0KPiArI2RlZmluZSBP
VkxfQ09OX01UWF9ZVVZfVE9fUkdCKDYgPDwgMTYpDQo+ICsjZGVmaW5lIE9WTF9DT05fQ0xSRk1U
X1BBUkdCODg4OCAoKDMgPDwgMTIpIHwgT1ZMX0NPTl9DTFJGTVRfTUFOKQ0KPiArI2RlZmluZSBP
VkxfQ09OX0NMUkZNVF9QQUJHUjg4ODggKE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OCB8IE9WTF9D
T05fUkdCX1NXQVApDQo+ICsjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1BCR1JBODg4OCAoT1ZMX0NP
Tl9DTFJGTVRfUEFSR0I4ODg4IHwgT1ZMX0NPTl9CWVRFX1NXQVApDQo+ICsjZGVmaW5lIE9WTF9D
T05fQ0xSRk1UX1BSR0JBODg4OCAoT1ZMX0NPTl9DTFJGTVRfUEFCR1I4ODg4IHwgT1ZMX0NPTl9C
WVRFX1NXQVApDQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JHQjU2NShvdmwpKChvdmwpLT5k
YXRhLT5mbXRfcmdiNTY1X2lzXzAgPyBcDQo+ICAwIDogT1ZMX0NPTl9DTFJGTVRfUkdCKQ0KPiAg
I2RlZmluZSBPVkxfQ09OX0NMUkZNVF9SR0I4ODgob3ZsKSgob3ZsKS0+ZGF0YS0+Zm10X3JnYjU2
NV9pc18wID8gXA0KPiBAQCAtMzgyLDcgKzM5MSw4IEBAIHZvaWQgbXRrX292bF9sYXllcl9vZmYo
c3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgICAgICAgRElTUF9SRUdf
T1ZMX1JETUFfQ1RSTChpZHgpKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHVuc2lnbmVkIGludCBv
dmxfZm10X2NvbnZlcnQoc3RydWN0IG10a19kaXNwX292bCAqb3ZsLCB1bnNpZ25lZCBpbnQgZm10
KQ0KPiArc3RhdGljIHVuc2lnbmVkIGludCBvdmxfZm10X2NvbnZlcnQoc3RydWN0IG10a19kaXNw
X292bCAqb3ZsLCB1bnNpZ25lZCBpbnQgZm10LA0KPiArICAgIHVuc2lnbmVkIGludCBibGVuZF9t
b2RlKQ0KPiAgew0KPiAgLyogVGhlIHJldHVybiB2YWx1ZSBpbiBzd2l0Y2ggIk1FTV9NT0RFX0lO
UFVUX0ZPUk1BVF9YWFgiDQo+ICAgKiBpcyBkZWZpbmVkIGluIG1lZGlhdGVrIEhXIGRhdGEgc2hl
ZXQuDQo+IEBAIC00MDMsMjIgKzQxMywzMCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG92bF9mbXRf
Y29udmVydChzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsIHVuc2lnbmVkIGludCBmbXQpDQo+ICBj
YXNlIERSTV9GT1JNQVRfUkdCQTg4ODg6DQo+ICBjYXNlIERSTV9GT1JNQVRfUkdCWDEwMTAxMDI6
DQo+ICBjYXNlIERSTV9GT1JNQVRfUkdCQTEwMTAxMDI6DQo+IC1yZXR1cm4gT1ZMX0NPTl9DTFJG
TVRfUkdCQTg4ODg7DQo+ICtyZXR1cm4gYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVORF9DT1ZF
UkFHRSA/DQo+ICsgICAgICAgT1ZMX0NPTl9DTFJGTVRfUkdCQTg4ODggOg0KPiArICAgICAgIE9W
TF9DT05fQ0xSRk1UX1BSR0JBODg4ODsNCj4gIGNhc2UgRFJNX0ZPUk1BVF9CR1JYODg4ODoNCj4g
IGNhc2UgRFJNX0ZPUk1BVF9CR1JBODg4ODoNCj4gIGNhc2UgRFJNX0ZPUk1BVF9CR1JYMTAxMDEw
MjoNCj4gIGNhc2UgRFJNX0ZPUk1BVF9CR1JBMTAxMDEwMjoNCj4gLXJldHVybiBPVkxfQ09OX0NM
UkZNVF9CR1JBODg4ODsNCj4gK3JldHVybiBibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX0NP
VkVSQUdFID8NCj4gKyAgICAgICBPVkxfQ09OX0NMUkZNVF9CR1JBODg4OCA6DQo+ICsgICAgICAg
T1ZMX0NPTl9DTFJGTVRfUEJHUkE4ODg4Ow0KPiAgY2FzZSBEUk1fRk9STUFUX1hSR0I4ODg4Og0K
PiAgY2FzZSBEUk1fRk9STUFUX0FSR0I4ODg4Og0KPiAgY2FzZSBEUk1fRk9STUFUX1hSR0IyMTAx
MDEwOg0KPiAgY2FzZSBEUk1fRk9STUFUX0FSR0IyMTAxMDEwOg0KPiAtcmV0dXJuIE9WTF9DT05f
Q0xSRk1UX0FSR0I4ODg4Ow0KPiArcmV0dXJuIGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRf
Q09WRVJBR0UgPw0KPiArICAgICAgIE9WTF9DT05fQ0xSRk1UX0FSR0I4ODg4IDoNCj4gKyAgICAg
ICBPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODg7DQo+ICBjYXNlIERSTV9GT1JNQVRfWEJHUjg4ODg6
DQo+ICBjYXNlIERSTV9GT1JNQVRfQUJHUjg4ODg6DQo+ICBjYXNlIERSTV9GT1JNQVRfWEJHUjIx
MDEwMTA6DQo+ICBjYXNlIERSTV9GT1JNQVRfQUJHUjIxMDEwMTA6DQo+IC1yZXR1cm4gT1ZMX0NP
Tl9DTFJGTVRfQUJHUjg4ODg7DQo+ICtyZXR1cm4gYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVO
RF9DT1ZFUkFHRSA/DQo+ICsgICAgICAgT1ZMX0NPTl9DTFJGTVRfQUJHUjg4ODggOg0KPiArICAg
ICAgIE9WTF9DT05fQ0xSRk1UX1BBQkdSODg4ODsNCj4gIGNhc2UgRFJNX0ZPUk1BVF9VWVZZOg0K
PiAgcmV0dXJuIE9WTF9DT05fQ0xSRk1UX1VZVlkgfCBPVkxfQ09OX01UWF9ZVVZfVE9fUkdCOw0K
PiAgY2FzZSBEUk1fRk9STUFUX1lVWVY6DQo+IEBAIC00NTgsNyArNDc2LDcgQEAgdm9pZCBtdGtf
b3ZsX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+
ICByZXR1cm47DQo+ICB9DQo+ICANCj4gLWNvbiA9IG92bF9mbXRfY29udmVydChvdmwsIGZtdCk7
DQo+ICtjb24gPSBvdmxfZm10X2NvbnZlcnQob3ZsLCBmbXQsIGJsZW5kX21vZGUpOw0KPiAgaWYg
KHN0YXRlLT5iYXNlLmZiKSB7DQo+ICBjb24gfD0gT1ZMX0NPTl9BRU47DQo+ICBjb24gfD0gc3Rh
dGUtPmJhc2UuYWxwaGEgJiBPVkxfQ09OX0FMUEhBOw0KPiANCj4gLS0gDQo+IEdpdC0xNDYpDQo+
IA0KPiANCj4gDQo=

