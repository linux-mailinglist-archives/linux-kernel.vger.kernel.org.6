Return-Path: <linux-kernel+bounces-446842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C99C29F29D7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4991667EC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131F1C7B62;
	Mon, 16 Dec 2024 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AUVpPAA1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LhsuFkZ/"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D9192B70;
	Mon, 16 Dec 2024 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734329146; cv=fail; b=poESgF9GZSDJI9VoHOzOd6BDjkm+WKtsrZoCXpTx9wTAR5AiwFvy1OMBY+WvnZoCvvLllffxKm6ckHjFoI8R6SRtgwtIA4sKBnqy5rl8yWU6UYifoFHDM+9hQouyaJ5NTvdQpmLWiyEPOaHhZuE7h4F2EyDrvjULvfbyLEFuS0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734329146; c=relaxed/simple;
	bh=wVpM7lXJOZ1tG0RO/cyJMht944EIIkBI2DQvcPP2ZRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UP1rhTTnOP4MFHb0hb7skXFH3G9A4lTxnZgJtn8AH4AueVYCfNioFUdtf54sVDLC4mJRV+Q+/jl1lRBM6NSBdXs6zfzecZg4Bg4PXVrNtDYaNMS3fyq4NhLahx+mPEsQc6DprTWSG49sLO7HNISBBQ7hzvGK1w9r8S93l7DABqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AUVpPAA1; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LhsuFkZ/; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c50cbb02bb7311ef99858b75a2457dd9-20241216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wVpM7lXJOZ1tG0RO/cyJMht944EIIkBI2DQvcPP2ZRQ=;
	b=AUVpPAA1zGOWhydQmarJhXvcJFxfHLLvEtue+h9wBtNOHWmcxgF51ndg8WEPeWu3cc+dwkxXy70DC2qRnfCQqAEtmj/d5vv7s70n6YL/dm+PGF67apTOSSs7X0rLF5A0uKtN97W+5c+5xMjVxY7TNVj+QlkGS8h8Dw8EcWcIK3k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:cd3e8d36-eadd-4de1-92e9-6b28a18d8a90,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:483e073c-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c50cbb02bb7311ef99858b75a2457dd9-20241216
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 720018711; Mon, 16 Dec 2024 14:05:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Dec 2024 14:05:36 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Dec 2024 14:05:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edJJZyai3NkflPRbwNr/CjuAfGyA9hLOOQM1LuFdaBfHtv0X9xXtko06t6BTkOzjSf4ajIWWkLM6IyU0uRFpKzGOLXrkBk9tC3g3ZIX0i9lsK15yyM8sXX/FBFZNVpq+TQ5nWcpLcEkdLONeBxQJlsvUPyl8OGcGYJWOcJ6OTMopQvXMxx87STD7HoRCWzL6O6dCPem3MRBQVdjKJ9iuKiHFhNHOW1i3xZQVB2VwiWapIv/pEPYLjnmc8lKWrniJeyL2ilCvgpde0Z5oQ+JW0ijx07EcbANjaMnNj+9KpKKAlDZo1LfZ7+CoEiu6WZ/xGUWLJ0+HpVvztlePipt/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVpM7lXJOZ1tG0RO/cyJMht944EIIkBI2DQvcPP2ZRQ=;
 b=gIJ98iIEz7mUuKB+3scOdzWwAb47DWK5KeCsgxhbMMfHsotSgaFZLbFn0WNtg5pYfQVsVNVEUz+20TG8f6s6KV+AyUwvZw1Ouf0Nutl70+ZA+oY7Q0oq68osq5QGA7HjiuFG7xkpik3YDxhiNDmty+2FSM09rkO8bTaNK+VOWrTiy2YxWIftDPcb789sEggw4M4LiyH+zeLRtp9eaL/3x5F7jLTfBJIzzu90ZLDEGS4Mr4MiCh1PYxqzfpRMWGOoYukgutC3Q0eal5opWubJW3HSW19RVfBa3PuxLzGEoeKBBfB0DQVMuiSFou9yJJCXhU6d8+36AkBssICn2kWuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVpM7lXJOZ1tG0RO/cyJMht944EIIkBI2DQvcPP2ZRQ=;
 b=LhsuFkZ/bWgkKLcNK6fo/HmISo0gq6vnv6nRyrru/HxYAUiZM1qPVXwi4mTxcJA5A5EyxZMM+mpQt5wZ6IveUU8wqLBnyKy1mBZsidNibfJ6tNsxJSRlpOnOvgU72r3UtRuF7zA/UXV73v+xTEN0Euie59jIW2zyOyaunAqjmeM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8725.apcprd03.prod.outlook.com (2603:1096:405:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 06:05:33 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 06:05:33 +0000
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
Subject: Re: [PATCH v2 12/15] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Topic: [PATCH v2 12/15] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Index: AQHbRwuDKzLMLP8gmEqSnf1CFqiN77LocvAA
Date: Mon, 16 Dec 2024 06:05:33 +0000
Message-ID: <4e18327e7ab92fd987d379110cfa36f33666e015.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-13-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8725:EE_
x-ms-office365-filtering-correlation-id: 2deed56a-9863-42b9-a48d-08dd1d97a6f7
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ckJReWpqdUVLdmZuWnVjcmZablZQMVQzdlZBaElTM2VHdnhBMUxuVjk1dmFp?=
 =?utf-8?B?S3lueHZEdGZ2MG9FNVRwK1BicS9weEZjNUZGblRZWkxoRENDd3hMcjN5MTFV?=
 =?utf-8?B?V1VabytyYUVjZHJDTnNNL2JFRGxzdmFlNThYOEpZVVFRcWUvYjU2ZE5yZlNX?=
 =?utf-8?B?ajBKYkl0TS9DcmdPWUFHYkdwY25zeDVTREZZRDJZa21GUEVtQ3VVNXRLM1Zi?=
 =?utf-8?B?Y0lZc0I3ME85OFhJK1FjSm94ejU4Y0RwUXJIcEFTbCtOUzI1WGZtOVNwS3BX?=
 =?utf-8?B?cmx3UEU2S1poRG9sYkpDSzloSlBrNjUvUFIyaUFpVmZmMzFNbmF6NWNrSWl3?=
 =?utf-8?B?ZEpzb0xiTVliaTZVbmxoUEVGc2VEKzhFVHAxczYvWjV1ejRhdzQ0MncxbXlG?=
 =?utf-8?B?VEtVNmJPZDlJQURZcVVpaEdXaEE2VE9KWnpWbHVEdmRDR2ZSSVcyTGpUWU1o?=
 =?utf-8?B?TzVvaTJ2MEFsOUVzbXBQTk1WU1ZLeHhVOXNUUS9sdFllbE1MOWlTUG96RXNw?=
 =?utf-8?B?ZXZjMDB2R3paTWpFekpRWUtnMXowYWRYTzJDeitsNU9BVWJWaDMwTjhjZEpq?=
 =?utf-8?B?NDd0YUczNStJNStiSFNPNXRnMmJJdEF6UlRTWFVVODl0eGloMHJVQk5nUmpK?=
 =?utf-8?B?Z09OOHhrMlhiQjZRclpYcTZ1YnFRK2JkNHFYSFhLd0l6MGdGcHRienZ1RmtZ?=
 =?utf-8?B?d2RaMEx3V2VxUkpFREQvMDZZNjJGZ0VhamRNb1l4aGNUZlhvZUdlRlNUcUVW?=
 =?utf-8?B?T01oKzgwZHhqR1Z3N005RmYzcnpoR0ZNQ1hDSzJMbjZXdWEzN1BHVjFCVWRr?=
 =?utf-8?B?VGZRSktSZXZJYWIwSks2TUhBa3N3VXZUUTRwRDZpRy9ZeElmaGU3SUxYcjJJ?=
 =?utf-8?B?bWlFbjkvRGVaT3A4Y1FlbTllZmJ0eXF3aUlMay90K08yS012TzFVQmlnVnkz?=
 =?utf-8?B?SSsyWUh4d2FXT2NQUjBBdEJNUTV2bjBXUVRKUTdpdXM2OHp3WjZpZVdqeXFj?=
 =?utf-8?B?a3E1bUxHYis1ZWdMaWNWTWZ4STVjVGRHQVFldHhoRW01L2QvMVZpbDdCWWQ0?=
 =?utf-8?B?dXFOOFpoT3ZzUnljaGZXUFhrUVlmb0c4UE9obm1yMUVYUElubGovQmliUi81?=
 =?utf-8?B?VVV6dER0YS8rZFFnY3ExdDlpYndDdWdZREJuekJYcm5zdjE3UGdGWlVDOTNn?=
 =?utf-8?B?U1J2NHVXWTE0TWtSMmVsZ1dZS2p6dHdNZGhlM0JQOXVocjR0WFg3MjA0V3JC?=
 =?utf-8?B?RThFZVljNFFXTkZrQjhNL1FSN2oyTE1VdTI5elUzcGxYSEh0RWZZY1RTSE5t?=
 =?utf-8?B?M1dSRE9Vczl2Qm9mTVNOTWJ6cHBoeTFsejFOekFMY2RKM29reWRlTUFHYVFO?=
 =?utf-8?B?dENFaURNeVBReGs5Y1I0T21aak9zM1gzQWdLeGVtZ21lOGFpTFE2QVk2M3d0?=
 =?utf-8?B?QzR1R240RXB1S2prVnowZVFPeEpQY3VoQ0RmVndKa0MwSGRiOVVhaVVodnFo?=
 =?utf-8?B?MkZMc1pyVTQ4Qkg0dUlQc1RvN3NObW5GZHBoOS9sSTR2Y3ZhWTVLVWd5aVBQ?=
 =?utf-8?B?MGkxWllESVh5RHZwbFJTS05hMVUxRjBFYzZaTll0aHRlQWswNWgyNXJCVjI5?=
 =?utf-8?B?MFlSSjBST2hUdHBhN3c1RzQvS0RlNHZEampTaERpUjVSWTFSbW5nWk9BcjI4?=
 =?utf-8?B?RjdVT3dIbFIxWlZRVjY2bjYzazVCRmRxTHRYejRNS3FFM2czaWVkcWxFRU5I?=
 =?utf-8?B?cFZqaHNWOExIMkIxcEZmWXBmWjBra2trb1o1WjJsWUowbThoekJYbWF6ZEdJ?=
 =?utf-8?B?REhrUHFUMzk4NGl1dTdZNDltMjBFVEdHQlBsMWYyL0xMYXltNGhhV0IyMUpN?=
 =?utf-8?B?a0FMQ2syVjBIQ3R0SWdvVU5WbGR6UTFyT2ZYNDJiTDhWaHNjaXc4VUdvZW9N?=
 =?utf-8?Q?SQ5mq78xNoJT2LUyZ2MyD/jwmtISRwfl?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXBxREtoVGxOb1JCVGdjTzZxcVJ3cGw4bk85N0I0RXFJWWJzSHkyMmtSdEl2?=
 =?utf-8?B?eDBpK0NicmFIREJjVVJlVEpBZi9FY3AzbXdhc1pIL1pNVE1MdmMwK1p5dEdx?=
 =?utf-8?B?NllrUS9uVTlqaEQvRUsyNExUaFFyMFFteFhMNVJaWWl3WE5Kckt3K0ZxZWZC?=
 =?utf-8?B?L3VwT21ZWFRyN1d2T3ZZcVQyWVNVTEUvTmdCWVNvQll0cC92TzBBb0V6a2VN?=
 =?utf-8?B?ZmM5VHRQWExWbXdOWXJ0SEM4UFBRU0QxTW83dERNekFGOTJtU05OMUR4R05W?=
 =?utf-8?B?Y3dhbnJNVURoOXZWcUVyT3o0WW5JYWs3emxwRFVTUXpRbkYwd0lvaERXTzFv?=
 =?utf-8?B?bXRUU0ppT0xDNUhWaTA4Z3U3TjJlT2xON1pIbXJtNVVIeEZYcFBKQ2NoYnVV?=
 =?utf-8?B?ejM3R28xMFlCSVdnNnZvOFMxbEE1c01iUEFZdnZlWTFPdVVXdWh3bUxMRGlz?=
 =?utf-8?B?M2JTc3RUYS9tanFhV2xYbUYzSXY0ZmJJd1BvdmVRLzc3dVlNbG93MGM5Y3oy?=
 =?utf-8?B?cUN2VXV3bWZOV1FROVc3TGlZejhoV2pzYTAvUEhDN3pMZGxkaEZQREVXc1li?=
 =?utf-8?B?SnNKWGFlZkhxWGVuMVZFREtiMzc2NDhWc1VtUFVCTUFkcjBNSE10Qk1jUjVG?=
 =?utf-8?B?UExoNmNmcVVCVGpFSFlsV2NzWkxWRitxZUpDeE9wYVkrZG9HUnc2TXZoL21y?=
 =?utf-8?B?QmQzSVowcFNuTXdRcmlkTmRaYTlxRE0zWk9UL3UrdnluTW9EbU9vRDBZZmpW?=
 =?utf-8?B?SXU3UWpic05IQkMwMmNuVjZBTzlvVkpsKzUwY3hqSGpkd2RuWDNzZWlINFlR?=
 =?utf-8?B?ckxXbmQxTFF4YU9HLzdSQVRxK0xlRFJoZCtMaFh4LzNLOTBWVUdGa0FieVFt?=
 =?utf-8?B?T0dpWE8rNTNCMlF6em9CNXdwTUZnbHJpczVBazJNcGhKN09Wa2RHQ2VWbkMw?=
 =?utf-8?B?VTByWnVsL0lXQi9mZS8zeTh6TzhvMDliRkx6ZDN4Z210N3dRTDY5T0pjOS9W?=
 =?utf-8?B?RUlvL3hHenpNeFFZdDQyM2JMa0h4MVlWdVNUd3cvYks4RFViQ2I3MWtjd1Vx?=
 =?utf-8?B?UEZ5OHpQRU8xdGJhYzZZV3QrU0xpOGVtazAvRFUvM0g2RUVXQVkrSi9OOWJ2?=
 =?utf-8?B?TmtxUXlOVlBtclNlWGlhN1ZRSUlScFp1V0p3N09DNHUxUEU5bjc4Y1RXSXlp?=
 =?utf-8?B?bUlIRmRxYlhJYVhpeDViU3plRWM5NzU1dE5TdW4zQ3ZocTRiQnVIYXc3d1Zt?=
 =?utf-8?B?TVU2Y1lteWprajdvcVc1MUJsRjJqQkRxVzhvV2RtSEFjZ21IUk04OUhIZENY?=
 =?utf-8?B?bFFROHFyeUNZTTlsSEo3ZWIvb1AwR2IyR0RrTERyNGZ1WDhFbmZOcDk2NVNL?=
 =?utf-8?B?NFdENFd4OUo1Q0lXZGFTeWg1Q2szVkh3aXRnOFFIZ2M3V2g5MklhT3MxSzBB?=
 =?utf-8?B?MUVLVHB5UFRxSlgraForUUFXQ3RTV0lmamhRMk9sakFpNkpKRDJjZjVBMElW?=
 =?utf-8?B?SzA3MVA1MnhudUt3M1JZeVdkdC9UcDZPMWtsU2crTkRSdGFBRXlDb1NFS29q?=
 =?utf-8?B?TUNYMlJ5VlFUVHF5YVowV1lnakxJdW93Y0RRMXl1ekdkalBicTc0YzUvclM5?=
 =?utf-8?B?TWROL3I0TW8wYlRNaURLOVJGMVFwUnQ0dVo5V3hBTDZYOFdwV3kxME1JUXVq?=
 =?utf-8?B?WXFhb1RlaytIaFdzWG04ckJFRmJReU5VWkxReXNRUmNEaUhnU2RUektlSWly?=
 =?utf-8?B?M3JwR0R6Q2J5UnRYSHJpYTI2QmNrb2x5WmZZUG5rdUEvK3NjR0VRejNIcnlP?=
 =?utf-8?B?WmJEQ3Z3VndGR3h4U2RQZjAyblJIWU1VS1E4aWpEY3FrMG9ITkp5Y09vV29D?=
 =?utf-8?B?RnRtZDF5K29sM2FaVW9yc1BQdE1VN05uMU8rTU5LWjRPdUd3bVBjUWZMU1dR?=
 =?utf-8?B?dzdlbStuYXVlK3RUOEQ4V0ZweE13U1BoTFJVNXFjM1V5Q0I1UWIralRCOTli?=
 =?utf-8?B?cVorcGVZOWVPNXVHMEpMUm9XWW5sRndWQThrUTBTbGt1czhuVnZxaEIzOFZp?=
 =?utf-8?B?cVBETWpNaXg3ampiU3oxd1o0TTV2cDFQUzl0T1RObU1GRWh2eUFWZXVKbVFF?=
 =?utf-8?B?bmF0cmtsVktHVm5WTFBNb21SQllqNWxIYkovd1NFL1VVMWZEejFzQ01LQzJr?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24D7ADD0C160844A8BAEB7DD9A5E02A0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deed56a-9863-42b9-a48d-08dd1d97a6f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 06:05:33.4638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/+0lbMEwNm5bGqt923weUExgU/tz9sG22hlWOYLdLbcxfFtf3OvpdXtNe+xnCQHvHdMhB5Ik0uSCUDRcwcdhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8725

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTEyLTA1IGF0IDEyOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBm
b3IgYWRkaW5nIGEgbmV3IGRyaXZlciBmb3IgdGhlIEhETUkgVFggdjIgSVAsDQo+IHNwbGl0IG91
dCB0aGUgZnVuY3Rpb25zIHRoYXQgd2lsbCBiZSBjb21tb24gYmV0d2VlbiB0aGUgYWxyZWFkeQ0K
PiBwcmVzZW50IG10a19oZG1pICh2MSkgZHJpdmVyIGFuZCB0aGUgbmV3IG9uZS4NCj4gDQo+IFNp
bmNlIHRoZSBwcm9iZSBmbG93IGZvciBib3RoIGRyaXZlcnMgaXMgOTAlIHNpbWlsYXIsIGFkZCBh
IGNvbW1vbg0KPiBwcm9iZSBmdW5jdGlvbiB0aGF0IHdpbGwgYmUgY2FsbGVkIGZyb20gZWFjaCBk
cml2ZXIncyAucHJvYmUoKQ0KPiBjYWxsYmFjaywgYXZvaWRpbmcgbG90cyBvZiBjb2RlIGR1cGxp
Y2F0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8g
PGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQoNCltzbmlw
XQ0KDQo+ICtzdGF0aWMgdm9pZCBtdGtfaGRtaV91bnJlZ2lzdGVyX2F1ZGlvX2RyaXZlcih2b2lk
ICpkYXRhKQ0KPiArew0KPiArICAgICAgIHBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKGRhdGEp
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IG10a19oZG1pX3JlZ2lzdGVyX2F1ZGlvX2RyaXZl
cihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IG10a19oZG1pICpo
ZG1pID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsgICAgICAgc3RydWN0IGhkbWlfYXVkaW9f
cGFyYW0gKmF1ZF9wYXJhbSA9ICZoZG1pLT5hdWRfcGFyYW07DQo+ICsgICAgICAgc3RydWN0IGhk
bWlfY29kZWNfcGRhdGEgY29kZWNfZGF0YSA9IHsNCj4gKyAgICAgICAgICAgICAgIC5pMnMgPSAx
LA0KPiArICAgICAgICAgICAgICAgLm1heF9pMnNfY2hhbm5lbHMgPSAyLA0KPiArICAgICAgICAg
ICAgICAgLmRhdGEgPSBoZG1pLA0KPiArICAgICAgICAgICAgICAgLm9wcyA9IGhkbWktPmNvbmYt
PnZlcl9jb25mLT5jb2RlY19vcHMNCj4gKyAgICAgICB9Ow0KPiArICAgICAgIGludCByZXQ7DQo+
ICsNCj4gKyAgICAgICBhdWRfcGFyYW0tPmF1ZF9jb2RlYyA9IEhETUlfQVVESU9fQ09ESU5HX1RZ
UEVfUENNOw0KPiArICAgICAgIGF1ZF9wYXJhbS0+YXVkX3NhbXBsZV9zaXplID0gSERNSV9BVURJ
T19TQU1QTEVfU0laRV8xNjsNCj4gKyAgICAgICBhdWRfcGFyYW0tPmF1ZF9pbnB1dF90eXBlID0g
SERNSV9BVURfSU5QVVRfSTJTOw0KPiArICAgICAgIGF1ZF9wYXJhbS0+YXVkX2kyc19mbXQgPSBI
RE1JX0kyU19NT0RFX0kyU18yNEJJVDsNCj4gKyAgICAgICBhdWRfcGFyYW0tPmF1ZF9tY2xrID0g
SERNSV9BVURfTUNMS18xMjhGUzsNCj4gKyAgICAgICBhdWRfcGFyYW0tPmF1ZF9pbnB1dF9jaGFu
X3R5cGUgPSBIRE1JX0FVRF9DSEFOX1RZUEVfMl8wOw0KDQpZb3Ugc3F1YXNoIG10a19oZG1pX291
dG91dF9pbml0KCkgaW50byB0aGlzIGZ1bmN0aW9uLg0KSSdtIG5vdCBzdXJlIHRoaXMgaXMgbmVj
ZXNzYXJ5IG9yIG5vdC4NCklmIGl0J3MgbmVjZXNzYXJ5LCBJIHdvdWxkIGxpa2UgdGhpcyBtb2Rp
ZmljYXRpb24gdG8gYmUgYSBzZXBhcmF0ZSBwYXRjaCBhbmQgaXQncyBlYXNpZXIgdG8gcmV2aWV3
Lg0KSSB3YW50IHRoaXMgcGF0Y2ggaXMgc2ltcGx5IG1vdmluZyBjb21tb24gY29kZS4NCg0KQW5k
IHRoaXMgcGF0Y2ggcmVtb3ZlIGhkbWktPmNzcCBhbmQgaXQgaXMgcmVhbGx5IG5vdCBuZWNlc3Nh
cnkuDQpMZXQgcmVtb3ZpbmcgaGRtaS0+Y3NwIGJlIGEgY2xlYW4gdXAgcGF0Y2guDQoNCj4gKw0K
PiArICAgICAgIGhkbWktPmF1ZGlvX3BkZXYgPSBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfZGF0
YShkZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEhETUlfQ09ERUNfRFJWX05BTUUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBMQVRGT1JNX0RFVklEX0FVVE8sDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZjb2RlY19kYXRhLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzaXplb2YoY29kZWNfZGF0YSkpOw0KPiArICAgICAgIGlmIChJU19F
UlIoaGRtaS0+YXVkaW9fcGRldikpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUiho
ZG1pLT5hdWRpb19wZGV2KTsNCj4gKw0KPiArICAgICAgIHJldCA9IGRldm1fYWRkX2FjdGlvbl9v
cl9yZXNldChkZXYsIG10a19oZG1pX3VucmVnaXN0ZXJfYXVkaW9fZHJpdmVyLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZG1pLT5hdWRpb19wZGV2KTsNCg0KVGhp
cyBhZGRpbmcgYWN0aW9uIG9yIHJlc2V0IGlzIG90aGVyIHRoYW4gbW92aW5nIGNvbW1vbiBmdW5j
dGlvbi4NClNvIHNlcGFyYXRlIHRoaXMgdG8gYSByZWZpbmVtZW50IHBhdGNoLg0KDQpSZWdhcmRz
LA0KQ0sNCg0KPiArICAgICAgIGlmIChyZXQpIHsNCj4gKyAgICAgICAgICAgICAgIHBsYXRmb3Jt
X2RldmljZV91bnJlZ2lzdGVyKGhkbWktPmF1ZGlvX3BkZXYpOw0KPiArICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gK30N
Cj4gKw0KDQoNCg==

