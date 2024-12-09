Return-Path: <linux-kernel+bounces-436814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599399E8B46
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BCF2810AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1871C1C245C;
	Mon,  9 Dec 2024 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mAvjvqzq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Xdext3FP"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2F213E86;
	Mon,  9 Dec 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724051; cv=fail; b=S5GtNitTpliqmE05hyjb2UfzirCOSALQesKr25QU5yskqrDRSJtCPdZHDe7FCJ2Ft+LSLZbFJOl99SrtEIeSu0Jh14kuyamZj/6Oarpz1XxE2EocJmmv8u6iYwfqGYKaJ6uGU9tsNGvbfIfCqYESfWhbhXyCCRheUqkeCip123Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724051; c=relaxed/simple;
	bh=rgVjXEasOcHemDzfI3yM/kj/0I0yttGH84Zu1HzfXaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VFhj27YxQJtHEgDpsjVicWEOCj6P5ucNMm4DiKTMPYMPkKyD/yGQhuS1dUVLvn2wwVNYILO83PTtyA0Mxcoky058pknpVX9Ge8gZfl3R0xLGhMdQ1sE0kYWwTT8vPIlv1LrOspuXA8sVnLH+tN0E1olVf/ZxuA7H4V4YRMpir68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mAvjvqzq; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Xdext3FP; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ec915fd8b5f211ef99858b75a2457dd9-20241209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rgVjXEasOcHemDzfI3yM/kj/0I0yttGH84Zu1HzfXaU=;
	b=mAvjvqzqi/0vdmo7CTEctae9vQBP9fGvu17APpi6TT4JlNXJtx3InZUMm45gm9pDOPXvJhbK8EPcImQkJ8ClpCVAxcWzMJeM0winH9cwP9qMfELv+sn1JCnq2z6PovAD+oBQJx0tSHgTyTjaNKpKXaCTJEGl2pUB3MOw9ebvu1c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6f2e4c52-057d-4687-913e-ca330d5ecd4a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b63391a4-c699-437d-b877-50282f19c2c6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ec915fd8b5f211ef99858b75a2457dd9-20241209
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1163266142; Mon, 09 Dec 2024 14:00:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 9 Dec 2024 14:00:41 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 9 Dec 2024 14:00:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5K8nnl8DJAW8yAb/vllmWoxifkTD/gpt5L8j1zjLkWWI5vi43bfUzGn4AvaZekm86NVeN2woYWDEFfOhtLld47898A+fLmLSs7+z29lqeZ2kw5/PPyuuQs5EGuJmGArQ0OdFPyMvKqCJfJl5G91NnWkBkqtTuiTtvhjW8lujgolGKxtdfC48Jpe+VzI26Z/fnKrGjYfI/V7ZhKG0OKKO3qbXYG0zDJ/YnefT4DRVObLVGTKChxWnVwjux/aKv2g1s3vzi0x/pQ9Je0vb0i+Ty4xDUx/Id4TClPSdfZsuoHHvPEeOeWk80974MvyVQ8JJ4n+QjhnxMGnQaawK4fL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgVjXEasOcHemDzfI3yM/kj/0I0yttGH84Zu1HzfXaU=;
 b=Q54F30AZWlRJGozxd0nfvfXmMnlQ+Wmu/WLgsslci46rDJ5eI87vsnnyGWa+7h/zDxeZYWc/4ytjRFwZSDZV+kZplqQg2gFzx5CQ5ZPdoIcjdsskdXHCNq9JP5jFIxOeRssSNcBkGinJ068Je56buZGZrhkouO2a3fSmNI9G3dp0aMFMbVHurPAMRPy2dDM2jjccwmCEvEHk/ueEsblkMV7q8rUq53g2CybFrB2Er+M6HnB+OOo/SWfqLamKGQV5+GIewU12s11UwW/8Bn8/nilzh70Vfa++GqjAiub2jH+ege6DMzbtrgTUqi+N03qIgiSwr6KizeD7pOlDHOF2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgVjXEasOcHemDzfI3yM/kj/0I0yttGH84Zu1HzfXaU=;
 b=Xdext3FPVPeofI7U0Y/6k3XoJcBjmr+dEyx9AhpXPXNaxV5ytFQGJgJxPIyEhqJUBYc992z/TA9q4W1sUa05E7vZ4lqiFL+vjrAqDTeAFirmlPWTA/mFw5XcmMSDEH3yKKxan2f+D1st9EN7DJk5nCMeT91qcE9fuUihKMOtXk4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8317.apcprd03.prod.outlook.com (2603:1096:820:10b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 06:00:39 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Mon, 9 Dec 2024
 06:00:39 +0000
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
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v2 11/15] drm/mediatek: mtk_hdmi: Fix typo for
 aud_sampe_size member
Thread-Topic: [PATCH v2 11/15] drm/mediatek: mtk_hdmi: Fix typo for
 aud_sampe_size member
Thread-Index: AQHbRwuImHL2YuMBdkqlp0ZnsPbvtbLdcT8A
Date: Mon, 9 Dec 2024 06:00:39 +0000
Message-ID: <477f5d7fecc856dec73e0ec4b513db29c9a9a36e.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-12-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-12-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8317:EE_
x-ms-office365-filtering-correlation-id: e1a784f1-c476-4a22-983f-08dd1816ce8f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y2QxZkxBbFJVZUdBTU5SNzYwdmNXWG9pZlBGUU01TElQaCtxR25vc1VjSCs3?=
 =?utf-8?B?eFpGRC9VcjUyRWRtN2Y1bW5XNkZhdklQN0ZWWnBOT2k1dWViMXRwTWZTeEdB?=
 =?utf-8?B?LzJpSmNKcGNMYWx0Y2t2YURUekhMZ1Y3dkdDQ1hFb2ZzdngyaVgxL0F1a0Nv?=
 =?utf-8?B?R08xZ1BSLysxT3RiRUptOG5leTA1ZTVKcXZiLzdUUGxWaVZKcC9XVFBoeE41?=
 =?utf-8?B?bHBGMHFuWk1nQlB3aHhZUFd6L1FMNGNjbnFERjJ5ZTRHRDlKVHBiVXI2d2I4?=
 =?utf-8?B?U0tZRWU4N1RpWFIxKzl0d096SEJEcTNBdE9TeklIZUFYbHJUMW9NVjNWL2RV?=
 =?utf-8?B?bVYvZVVkdHYwTFUzcVdrSnE1TVhISHJqMjYzSHI4Z1UwdGRWSGpDdEI5NVE0?=
 =?utf-8?B?L1hUa2tUelhveGIxVXc4RnV6Slh2T2JYWmQvUmVIOXJFZDdhSmhhYUthOFB5?=
 =?utf-8?B?d1BLR0FOeDNGbFR1djVaR0xPUXcyUjFTNkNkcUNKa2pvaHdldFFIVFVYNGoy?=
 =?utf-8?B?ZlYvMm1uS1BSRTV3SlRUTE0xTG9vK3BZVSthMUJmQUpWWFozTEZPVDFuOU50?=
 =?utf-8?B?YzlLYUFOMzYzSGlkUUdQdTVBQUhYNUpJRW45VlViSDRRblVFeFhqb3hOQjh5?=
 =?utf-8?B?Y2dtRU96SzdsdXJmMlVsaHdEdG1jME5WMXhTL3FkQlNJdGs5YjJOTDdGK0lX?=
 =?utf-8?B?MWswQVVQaCsreWtIakhmZ3N1aFRRQ2g2a2Fhd1g1VWFSR21EdHlDcDRPeWQy?=
 =?utf-8?B?RTJ5bS9zekNINmZmRzdJbzk2d09scnJxT2RTWDdITkFIYlRScTFBTTZrcVZv?=
 =?utf-8?B?OTBVRTlGaW9uV0tDZHVwM01nNE01RDVGbTFZOS8rQ003Z0J5Sy9DcGc5K0Vp?=
 =?utf-8?B?Qis3azVZUWpCQUlXUEhvaUNCV2RWYmNDVk5UcmtGMXJ6SFJSdk9ZV3RsNjhm?=
 =?utf-8?B?VXdWbUgzcHRqRGltRDBzQWxjNDFERTNzeUx3VmE5bk4zZnVyakMydHk5V0Zq?=
 =?utf-8?B?UXMxdWROLzZEK3QzNmVMaUFhY0swVElWZ04vMUpTN2tSWUxRTmlLaHByRkNL?=
 =?utf-8?B?bHJ5TTVtSVFoT0FvTXVVcHJYZkl6a28yVTloNWUxK1piTExSa1VRUnhFVWVx?=
 =?utf-8?B?OEFyZXB5RS82N2NlRzVWQXZSSWh6eXplR1JnMjFSck9VQXkwTzJmZFpVSll0?=
 =?utf-8?B?VkJTekZyd1djOVhKTG5EaWlreHl6ZTN5TzNacHlSa2xNUXFtSEUvSkliRGVk?=
 =?utf-8?B?cUZXVXVYaEJvckxtZTE5NkE2Q3hIZStybWNiT1hVSzNpZ0tKcnpIa1VFUmtY?=
 =?utf-8?B?cURXNXViQzd3RXh2bVZSaEZsNHJLZnM0em1sMURPQUFmYXZqSDQrN0VsMElz?=
 =?utf-8?B?RUpBMWtKbmh1MHZjSFgyM0JMU2svdVVjM2UvMmZiZGNBZHhoMGM3bmZTT1M1?=
 =?utf-8?B?QmFMQXl0ZHpMR055QjVWZmIyQkRCUFo3NG5yTU5OMWRKcXVWbFQxTzI2L3NR?=
 =?utf-8?B?SjQ4WlM3blhKVUFlaGp3M2UyWUkzSHN1RGRmYit1OERScFZ3L1F6L0VHSUgv?=
 =?utf-8?B?YUJwODBTbkMrMnBKSGR6aUdKTEtqVDBxYjFUc3g4SzA5alFKMGVHenhLd2Ja?=
 =?utf-8?B?TVJpUkxxa01ob2l6WlJqLzJXU0Vsa3dLRUVlVHJweWNpRnNQR2ptZ1ovWmlr?=
 =?utf-8?B?TlZWWnZPb1FuQjcrMVJqaXFLS1VqN3B6Q3RiWEdOTi9uN1hyTUZ4WnJtR3FY?=
 =?utf-8?B?Y3B3N3JIWG9QREhYRm02WHQzK25yRG5UQzREVEpxNXliVmFhT3N0Sm1yWWJw?=
 =?utf-8?B?REx0ZnRNcTB6T01EYTl4eU1ZSVNIQ1RSdldYWloyWWozeTVQV0NBV0lyUGRK?=
 =?utf-8?B?OGtHdDhsZjZaQnVldDlHRU5tYmhxVmM4Wkk1SDZUUmd0S1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzFVZmVFdSsyUFkvTnFMTlIxRXpiY3pmUXM5WitXUWJ1aEltRHlDNEZSZWFw?=
 =?utf-8?B?bHFwbmdQbmZWUTFHU0dPUXhJS3lOdUdTeVppb1YyKzEyQ0hjdC9LQm1xRXN1?=
 =?utf-8?B?N3hUTjVnMk9JWGdieFZscXBqQlN5eEdlYmpWTFZFZEFQWFBxOFA1Slo0TXJC?=
 =?utf-8?B?NHh4MUxGdzdXVUdyY29PY3NMdXp6VnJDNGllclRWWnlYVUJHSFZhTWRSVU5E?=
 =?utf-8?B?dUlzeWU1aE4yLzNmWDhLbjdCSWNhU0xUUDNPek04a2VKSk5PNzZ1WHk2Mlht?=
 =?utf-8?B?SnMwWXpqdy8vbWlMWlMwTnk5K21pN2IzVnhHb0taVW94VmU5S3NycDJQbkYz?=
 =?utf-8?B?MWNLSHRiOEZ6ODhYb1RPYXVXb2x5WXpqQXlMYTZGZXJJNFdmRU5BWUg2blhC?=
 =?utf-8?B?TDRuWFZtZ0NLQ1pSL2ZXeGJuTGJNNXE1TTdJcnZ2Q2l2OCtaQVVyVTgwcGg2?=
 =?utf-8?B?ZzVSeDg1WGh3dHZOWVFIbEJ6R0UxZGI5VkJXaXVNQ2pxQUtuY0x2QjVNSFRp?=
 =?utf-8?B?NTVuVVZHS0xlQml1dEZPc2VGM1JOSzg3emVyU3NmM0NSZCtoU3pHMUVUNVFy?=
 =?utf-8?B?cXpwVEhtV1MzRXpSL05yUThnSnhQSnE4VkJKNXhSbnFUTzVudFk1YjgyZE9O?=
 =?utf-8?B?SStUZlRKNUdPeDNLME00dmh5VkFrUFFzWUhtdkdpVGw4dWFjM0o0WGZxcmhI?=
 =?utf-8?B?a2VNQ0RERS9NZDlkUEo0bnU4VWN1VUxrSjhRYUJTUXYrRkhJdWhWa0d5RjVu?=
 =?utf-8?B?ZVFYdlhsQzF6VWtTTzBwY3JpK3ZLb01oV0xUNkNXK01zeS80SFVhalRMMTF4?=
 =?utf-8?B?VzI1L2IyTE9MOW1xRmdmZW1reFk3MTZaYTRIWVU4Yjc0ZVVGQ3k2YXlYMy9V?=
 =?utf-8?B?WlNRYmo2eXNySGpjYTZYb3ljY3lnSTVxQ1RRNjVDaHdxcnRHSnBleXBTYVVi?=
 =?utf-8?B?cjRINUc1YzRhYW1CUHlvdVE5eUxCN1k0Mm1zcDlsVkFiMW96WGZOQkwyOGZl?=
 =?utf-8?B?K2orb3ByWVp1YUdaYk1BdklFL2RJMUxIcnBVeU5PNzJQN3FWTVJNQ1ROTnBu?=
 =?utf-8?B?YjJwY0JheTRGRjZoMTFZczNwRlpHN2V5SDk2b1BpV2JRSkZlaGJ1cGl5TUVI?=
 =?utf-8?B?TUc1b2p5c2oyNG8wNS9wN29jaWwrVEU4V1NldDA5ZWJGbGorWFF1Qlg2ZytO?=
 =?utf-8?B?bFp4SlYvQUVObU9pY2xOU3AwOG9NRk1DWXhEYWhTQ3RNMnhWeGpwdGFFNDJL?=
 =?utf-8?B?L2F1WFhUbEJzTzZ0aUFvcE93cHQwM1pHSkZ3T3lCV3EwaitMUnJpRkdSNWRr?=
 =?utf-8?B?UGhVa00yZWU1U1lPR0Q2MWU1dnRwenBXTHJQLzRxd1RQTW91eitHK0dIU21B?=
 =?utf-8?B?VWtHRkNHeUJ4clh1OUMvZCttcTN6OFFiWkNLNTRzS1ppdlNYOHljK3ZuckE1?=
 =?utf-8?B?WkJJS0pGZmtOZlNtTTFtZmcrSjRKS1FmbDNOTVBFMnI5cDlpUjQ2N002MkxW?=
 =?utf-8?B?MGN5VklMZUxEZnlFc3lxUUR4QkREQ1pST1hDeWRCaEtIRzBKM3M0WHd1Y2tK?=
 =?utf-8?B?S2U5UXRScnJYZ2FxbWdiUDlyalA5NXkzbmYrSzJwc1BNTHFDSnpnZU5VQUxI?=
 =?utf-8?B?VWhSNHRCQUNCZ2xJcGhzMXdrbHA2d1JZNzduWUFqZ0FWY1lNY2doSjVVQVJr?=
 =?utf-8?B?TVluQmRxQWk1d3g3eENkT1FwZ2tzd1VieUFBTW8wU0I0elVxR1BDWW9WSVE2?=
 =?utf-8?B?YlhMK2ptMGZ1NWJ4Nm92WUVvL3Rva2RiNlVqdWJDak9DWjIrUHRpNjJ3enNo?=
 =?utf-8?B?LzA2UjI5bnhlL2g5VnFEVGVXalVRWTVyaUc3MkhLZHF2TXlxUmVXYkNoT0Yw?=
 =?utf-8?B?cmhlejl0RGpkSmE0UjFMRXhXc25PaWZBM0t1aHh2SXpZYVZYMnFJdGs1Q0pU?=
 =?utf-8?B?azZRTjNyY0ZUdVlXY3poRXhVM3IzZk4vdDI2bWUwQ2JEeHFtOHZnRnZPMGdX?=
 =?utf-8?B?czFkOWdTcklrbm1yZi9vYVk4Q2t4RC9keW1XNkhHUDduNWkyY0hwc2ExMFNy?=
 =?utf-8?B?eFBXTzFjcHdic2tpVGNlMzRQZDdiWFNpcktSbTVWY3ZMSzE4MXdQMklDY2Jk?=
 =?utf-8?Q?Te5cLy6SHaeRHSJqYKpVeH9d5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46EDE8BDB69DAC4E9F0F6234E5F33236@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a784f1-c476-4a22-983f-08dd1816ce8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 06:00:39.0149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGTT3ErMw4ANiz5aLld7m2ZJlL8uPwV01KP1Z/59/K2sIRVLpQLJ6m1dww+/OqYfUxmVjFFcf+KHB+CjcEnmyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8317

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTEyLTA1IGF0IDEyOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBSZW5hbWUgbWVtYmVyIGF1
ZF9zYW1wZV9zaXplIG9mIHN0cnVjdCBoZG1pX2F1ZGlvX3BhcmFtIHRvDQo+IGF1ZF9zYW1wbGVf
c2l6ZSB0byBmaXggYSB0eXBvIGFuZCBlbmhhbmNlIHJlYWRhYmlsaXR5Lg0KPiANCj4gVGhpcyBj
b21taXQgYnJpbmdzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1
IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IEZpeGVzOiA4ZjgzZjI2ODkxZTEgKCJkcm0v
bWVkaWF0ZWs6IEFkZCBIRE1JIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jIHwgOCArKysr
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jDQo+IGluZGV4IDllOGQ5MTQ0Y2Y4
Ni4uNzgwODE0MTUyNmZhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2hkbWkuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYw0K
PiBAQCAtMTM2LDcgKzEzNiw3IEBAIGVudW0gaGRtaV9hdWRfY2hhbm5lbF9zd2FwX3R5cGUgew0K
PiANCj4gIHN0cnVjdCBoZG1pX2F1ZGlvX3BhcmFtIHsNCj4gICAgICAgICBlbnVtIGhkbWlfYXVk
aW9fY29kaW5nX3R5cGUgYXVkX2NvZGVjOw0KPiAtICAgICAgIGVudW0gaGRtaV9hdWRpb19zYW1w
bGVfc2l6ZSBhdWRfc2FtcGVfc2l6ZTsNCj4gKyAgICAgICBlbnVtIGhkbWlfYXVkaW9fc2FtcGxl
X3NpemUgYXVkX3NhbXBsZV9zaXplOw0KPiAgICAgICAgIGVudW0gaGRtaV9hdWRfaW5wdXRfdHlw
ZSBhdWRfaW5wdXRfdHlwZTsNCj4gICAgICAgICBlbnVtIGhkbWlfYXVkX2kyc19mbXQgYXVkX2ky
c19mbXQ7DQo+ICAgICAgICAgZW51bSBoZG1pX2F1ZF9tY2xrIGF1ZF9tY2xrOw0KPiBAQCAtMTAz
Miw3ICsxMDMyLDcgQEAgc3RhdGljIGludCBtdGtfaGRtaV9vdXRwdXRfaW5pdChzdHJ1Y3QgbXRr
X2hkbWkgKmhkbWkpDQo+IA0KPiAgICAgICAgIGhkbWktPmNzcCA9IEhETUlfQ09MT1JTUEFDRV9S
R0I7DQo+ICAgICAgICAgYXVkX3BhcmFtLT5hdWRfY29kZWMgPSBIRE1JX0FVRElPX0NPRElOR19U
WVBFX1BDTTsNCj4gLSAgICAgICBhdWRfcGFyYW0tPmF1ZF9zYW1wZV9zaXplID0gSERNSV9BVURJ
T19TQU1QTEVfU0laRV8xNjsNCj4gKyAgICAgICBhdWRfcGFyYW0tPmF1ZF9zYW1wbGVfc2l6ZSA9
IEhETUlfQVVESU9fU0FNUExFX1NJWkVfMTY7DQo+ICAgICAgICAgYXVkX3BhcmFtLT5hdWRfaW5w
dXRfdHlwZSA9IEhETUlfQVVEX0lOUFVUX0kyUzsNCj4gICAgICAgICBhdWRfcGFyYW0tPmF1ZF9p
MnNfZm10ID0gSERNSV9JMlNfTU9ERV9JMlNfMjRCSVQ7DQo+ICAgICAgICAgYXVkX3BhcmFtLT5h
dWRfbWNsayA9IEhETUlfQVVEX01DTEtfMTI4RlM7DQo+IEBAIC0xNTI4LDE0ICsxNTI4LDE0IEBA
IHN0YXRpYyBpbnQgbXRrX2hkbWlfYXVkaW9faHdfcGFyYW1zKHN0cnVjdCBkZXZpY2UgKmRldiwg
dm9pZCAqZGF0YSwNCj4gICAgICAgICBzd2l0Y2ggKGRhaWZtdC0+Zm10KSB7DQo+ICAgICAgICAg
Y2FzZSBIRE1JX0kyUzoNCj4gICAgICAgICAgICAgICAgIGhkbWlfcGFyYW1zLmF1ZF9jb2RlYyA9
IEhETUlfQVVESU9fQ09ESU5HX1RZUEVfUENNOw0KPiAtICAgICAgICAgICAgICAgaGRtaV9wYXJh
bXMuYXVkX3NhbXBlX3NpemUgPSBIRE1JX0FVRElPX1NBTVBMRV9TSVpFXzE2Ow0KPiArICAgICAg
ICAgICAgICAgaGRtaV9wYXJhbXMuYXVkX3NhbXBsZV9zaXplID0gSERNSV9BVURJT19TQU1QTEVf
U0laRV8xNjsNCj4gICAgICAgICAgICAgICAgIGhkbWlfcGFyYW1zLmF1ZF9pbnB1dF90eXBlID0g
SERNSV9BVURfSU5QVVRfSTJTOw0KPiAgICAgICAgICAgICAgICAgaGRtaV9wYXJhbXMuYXVkX2ky
c19mbXQgPSBIRE1JX0kyU19NT0RFX0kyU18yNEJJVDsNCj4gICAgICAgICAgICAgICAgIGhkbWlf
cGFyYW1zLmF1ZF9tY2xrID0gSERNSV9BVURfTUNMS18xMjhGUzsNCj4gICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiAgICAgICAgIGNhc2UgSERNSV9TUERJRjoNCj4gICAgICAgICAgICAgICAgIGhk
bWlfcGFyYW1zLmF1ZF9jb2RlYyA9IEhETUlfQVVESU9fQ09ESU5HX1RZUEVfUENNOw0KPiAtICAg
ICAgICAgICAgICAgaGRtaV9wYXJhbXMuYXVkX3NhbXBlX3NpemUgPSBIRE1JX0FVRElPX1NBTVBM
RV9TSVpFXzE2Ow0KPiArICAgICAgICAgICAgICAgaGRtaV9wYXJhbXMuYXVkX3NhbXBsZV9zaXpl
ID0gSERNSV9BVURJT19TQU1QTEVfU0laRV8xNjsNCj4gICAgICAgICAgICAgICAgIGhkbWlfcGFy
YW1zLmF1ZF9pbnB1dF90eXBlID0gSERNSV9BVURfSU5QVVRfU1BESUY7DQo+ICAgICAgICAgICAg
ICAgICBicmVhazsNCj4gICAgICAgICBkZWZhdWx0Og0KPiAtLQ0KPiAyLjQ3LjANCj4gDQoNCg==

