Return-Path: <linux-kernel+bounces-448452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67209F4047
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED87516CD83
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4612F375;
	Tue, 17 Dec 2024 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z2WxT3Ke";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dFwwgtVq"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9532595;
	Tue, 17 Dec 2024 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400534; cv=fail; b=NiataIfrk/RlBmq1KV0yibcbC5YMR7YjbRL5/QPVtNlH4mlj/zaTJ5g6lHueIjEhx2TuX/Gf8hGxtI4GxdfvsptOS0QoXiLsm7TGZ1rZT2IIphPi74gmae5FfzIaRaJ5TkK7Duj8SMnSOlt0yVzTuYbw/dGJbuyHJXoW7BF99Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400534; c=relaxed/simple;
	bh=wmSA2ZlHkxpTQEcvxWJJy7GVa6PnfvjUFLQfze+TJfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZSyyOZfkLl+MUgy3shA+lalbHlWvHhS/zVePs5ZjqHmEE5VlVkzrnX9ys6cvPit5j/WvWpwbvAjd85w3DAuoh/wBNAFxlV3ssWTF34Lcx1iAXYpG+ff7lcL1iye4rUQdzCL/p8vqgJOeFC9qDY3FUUsWdtiXhJDRZiQhGX9aGCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Z2WxT3Ke; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dFwwgtVq; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fb6091d2bc1911efbd192953cf12861f-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wmSA2ZlHkxpTQEcvxWJJy7GVa6PnfvjUFLQfze+TJfw=;
	b=Z2WxT3KeomwnPmPPOncXPQ5t9Vcn0/wzY5gAHlRvarhTX4DEe39cXMEU1Eg121/L1FzophsLaqPM9fK1QemP1wZDKZ0a47dekZ3Q5VHMe6X4f6iRnFJjOdh9sKOFDIZLW8hionxigh5LC7XTeRTJsYnWy//ugLcf6ELsu9oTTuM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e95426b0-a5fa-49d2-ab14-9bb5c03eb485,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:cf213d13-8f5d-4ac6-9276-7b9691c7b8d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fb6091d2bc1911efbd192953cf12861f-20241217
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1080421280; Tue, 17 Dec 2024 09:55:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 09:55:21 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 09:55:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ew8wEnUa4pKS4Xy9k4+Yk1c4TwCtp6KMvWI64t2yFmy3AmxPcAgXNdxtThxDzJsGDXzrQw3zH5o/dJPcSi6nuuWGpupBKu9CR9es1Smb1n4Czm8DoozyCRGfVjYLrKOGPaduXFlQn9itd7R65ULA+QYpMUFv6oIkXW9sWB7pM+Lnm8ZN4nsxIT+8y6WpQBE20KeddT08tv5apJ3hCYhsn74KyXbPTL4vTOzpYLR3xT25bjfDzbTpoy01KRQbKfECuwnlaZTO4tsENxYp1hwiMEX0c7ZxXmTp4JDdInLCFVNGXf0ulhgRRyneWJyvEhZ5q6sFWqv+nsBT30a8Q/6hdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmSA2ZlHkxpTQEcvxWJJy7GVa6PnfvjUFLQfze+TJfw=;
 b=RFgWAjGPfMs94oEK7ORLPyJb8lLJOtyQ1wsJYi4/+4CZMRhJhRZZ3TkbdYbNT5aPra6AXrJAH9+U7Pen7KMhf6lXYCcLHuB0L1xInzHxHa8ZSOoms+zXFzzZyZ4+Smrh5G6Urz5NXXmbWfQMuWUZT9MLTjL2eM27yp3Ezri90DXIsHUlSJhHVYOUNLXNvHVo4Tn+s3TJJJ0c8dZZ4g/1XZKi84McwvOE1hiGls0UTxANsyTVxcCkhehMUuiHmk6RWJlf9dMD0P68e2/wVZu7glMVDnPKcUuxIEm2PQURQkxdrbWmEvcNuhPunsN7FCh3R+FBAczRvTtMfsXjFsYlAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmSA2ZlHkxpTQEcvxWJJy7GVa6PnfvjUFLQfze+TJfw=;
 b=dFwwgtVq20g5IIiwaBLGG2+IvTgjD4smrIsuAeGMBHegNxxFxz9sOPwqyX/f3r9z2m/X/ODdpKBoqay3z5ZKfc+QZWvPBL3JbrvRX6pg8ycPKKBhqvPD3Ut6tVubArCt+PZfYrdf78X0UyDWMK0x5y+XQDpUk6cVCoIfoiyLqP8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8355.apcprd03.prod.outlook.com (2603:1096:820:10e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 01:55:19 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 01:55:18 +0000
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
Thread-Index: AQHbRwuDKzLMLP8gmEqSnf1CFqiN77Lpv1mA
Date: Tue, 17 Dec 2024 01:55:18 +0000
Message-ID: <deb042d486fcccee6fb669d0dafd3da930f4c179.camel@mediatek.com>
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
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8355:EE_
x-ms-office365-filtering-correlation-id: c890c524-8c7a-4033-16e7-08dd1e3ddbff
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?THZKVzBLaEhwMkc4UTBvUEwvd0FsUWhxYWxSbEs5eGFxZ3YvRFBOZXplRThE?=
 =?utf-8?B?anJmQmtPcGdTenJQbzRYK1h5cHZOL2xCaEF0dVg2R3lQdUQxYitJYlFNME0w?=
 =?utf-8?B?R2owT3RHcXg4cytQbXJxdW0rUTFOcGh6SWlsdjFPSWk2TnhEK0c2eVdoVEpG?=
 =?utf-8?B?am1vbmlzdjRXdlcweThYdzVDV3d2NVZFdm9hU0NDSG9IdmY2ZXRGYnowUmRN?=
 =?utf-8?B?V1ZvcHRDc1FTTjVUNVhLZ2pKbWlPejIzU2RzY291RXp6MGtybGEveHYwSzZq?=
 =?utf-8?B?bm9IN0lKM1VsWnNkYzhvcVNGWENrZis1c2NHNXZ2WjFYeUkyYWxkQ1ZVSnlO?=
 =?utf-8?B?ejhlanl2Um1jdWFOU1dEZWJBQ3ZCVU5oZGw1TTJRSzFyZ2VnUjVzbEVpQTMw?=
 =?utf-8?B?MnVtQ3hTUC96Q1U2Rzk4VFRUa1p6MldJMDBhQXJnSXNwc2NHYXowWHJjN3p1?=
 =?utf-8?B?QUNML3NSdlpmSHRldk9iYm1MMDFWMjRPZ2xsaWcxelhER2NOczUwb0lRNUFK?=
 =?utf-8?B?RmQwQTNpWUpFTEN5UmNLL3c1L0QvTHhoeXFYcnB3a2dMenY0NmhIbjFzbkZ0?=
 =?utf-8?B?cXlycWlheWY3VldsYkFCcTRCWEdHYklYWWdkdzUyRzVmT2RnQVpkQXpXc0ZQ?=
 =?utf-8?B?QklCL1lvbkZNeUF6ZHJwd21JK0hOWHBVRVJOZXZFTmhsWU04MW9Wc085cTZi?=
 =?utf-8?B?dWVONUVSQ0UzK1NUemRHQ2liMlJvSzlsbzE3ZUtJQzFra25nWnVKTkdWamFC?=
 =?utf-8?B?TkdsZ21nbm5pRTJlV1JXZFQ0OVdheFpVdEZFMUFTelNpRzdjWDZPeEExb3NM?=
 =?utf-8?B?ZGhKOU1UeDRQalVoQ0l0NEc2bnkxMjNHeHpSaFhyc2haVVNFdTd3U1pFRWdS?=
 =?utf-8?B?SXNCdWlwR25tMGJNUUZGVHZXUTQ4aHlHREZMSmJaOWptcHFnTlBFOG9SNXUy?=
 =?utf-8?B?RTBuWGlmR1NSK1A2d3MwVzFmcEZiV3pmdXNNcGNyYjIwVGdzU01NVHJrak8x?=
 =?utf-8?B?OUNVZFRxamtJRmJsSHNSWjA3Y2Vhc0svSFB0UjF2Y0V5VFVEVlVQb2ZyL3Bq?=
 =?utf-8?B?KzhiVms5cEFORk5ONlFvVm5VUjlwdktkQlppRmFRRHBtRGVUU05qMWd0K3Vx?=
 =?utf-8?B?WkVMaEo1SzZVWjFMaU5VejMwWHhlTjJoSGJOdmZwMFliZ3E2UlYzQlBJZUov?=
 =?utf-8?B?cHBFVk5DU3QxSlh4Rnh3K2ZFTkY4TXQ5OCtKVk5sRnhua0c1bkFudDh2enNh?=
 =?utf-8?B?VTk0K2RrOUcyNlI2alllQWY4Mk1sWUtaWjZray95SkhLenZhYUJPVm5SeVVT?=
 =?utf-8?B?WFQwOWJsVWpxVktzNTRQbWFkNUxSMTZXQm44Ri9qQ05zbjJ2THZ6UE0zbGY2?=
 =?utf-8?B?MHRFSHMzaXZaYXloNGd6MXViTUUxUFl0SGlUNzdGUkMrbktHYzkwbEJkRk85?=
 =?utf-8?B?M00xbmRPUk9PSFEwR3lIQjYydEdzdHZZWW0vcmh4UnlJVlpvbWpaNmorL3VP?=
 =?utf-8?B?MWVEQ2NEU3kvamxlSVpsSjdBUXNLdUhXeXdpUU1RVjNFWXBpTVZUMXZwb0dv?=
 =?utf-8?B?SU1VV24vdXRyUFJmUVdQa2IvbzNRa3dTMHhZR0drS3Y5akFHSVFBY2hVMmhy?=
 =?utf-8?B?ZTI2N2NDOGRXQy96dHNMMWRVVVU2WnNSaHFOQnNFcGk2TGd3Q0FJUkNRd3Zr?=
 =?utf-8?B?OXlaWDBqZ3JwclV2NXlydTc4Qzk4MHd3S1UwalVxK0EwL2VLNWUrZC8yVm1Y?=
 =?utf-8?B?S013dlhBcEtycTNpbHlzTWNVL212bno4NitNMjVFL0k1OUF2c0lNUDN2ZzEx?=
 =?utf-8?B?WGZWMkN5NS82bDZsSXgrWjVNOHdrSDBOclFiQmpMcmtEYXllNmlNS0dHbHh1?=
 =?utf-8?B?SnVVeWpxbktZVkxSSm5lek5QVjFGZllsb0ZKcytOcjkvczBXcFhNUHlyY2Vl?=
 =?utf-8?Q?p+Wr6ZZ2+9oVbuf6B767nUYFEBlt2Dda?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0RRUXRodWFnVzNxQTMrT243R09CbE84eEtjWUoyNDF6bjhoMmlRdktRWmFi?=
 =?utf-8?B?QklvMFBtNEFIMTVSMFRHa0VJOUFWSHpiaFhnQTV0aW81d0NobXYyWHZtMHAv?=
 =?utf-8?B?SW1zNldDakdKa01XTTlrL0doenprZGZoS3ZXMUVpYXRpbnBmZ29PZU9zWW15?=
 =?utf-8?B?YzZGblR4OGgvV3YxRUdvL0czS2cxMWFQOG40ZzgvUkRGTW9RSEgvYTNadklM?=
 =?utf-8?B?QTQ4MG5KcmxYL0tjWHRDUEEzTUpSVlZ5U2JWMlZXckJsTW9MamJpYXVxZzJw?=
 =?utf-8?B?Vm00c1NyNWttbmErKzQvbWZ0Rk9zeENCSGhLZmQ2czdMdHZpbGo1Z1ExRlZj?=
 =?utf-8?B?N1hSVHhzMFZralFsWnVVbDBSMDVPa1F3MTlYOWdaRk5CblZDblE3MFlwOHN3?=
 =?utf-8?B?Z3dHaU1pc1FXR1FsTUFOVFQ4K25rWlpUNHhDdGhjNE5ka1FhczlhTllSbE9K?=
 =?utf-8?B?KzhqMVA1Ty9TbENvQ0lwQ2hUNU1zUTlaMjZGWW1iUU9zYnl5THBOZ1RKTGRn?=
 =?utf-8?B?OEE3VFZ5TTI5bkhLenh6Y0wrcTR2REg1bXU4QVduZDdTOERNMkxPVEgxeUJO?=
 =?utf-8?B?ZHk2SXU5RE5BemNpOXovVk81YmllOHd3ZlJxTDZnNk1paUNrRlhmQUFqb1Va?=
 =?utf-8?B?RmcySFNlZXllU2tGWW9uVHZrZHlZTlNwUWlGckF3TDE4d3BaQU0yQkNmOFQw?=
 =?utf-8?B?Y3owSUNYVjd6cmZOeWdPdVk5QmR2T3I2QmR5ekYzbW5GZFZvWm5jbkUxbWpE?=
 =?utf-8?B?T2x0TnNoMlVqN2NHQS9PUFVxNlFVbE5xN3VtUUZONHNYMjU0MWkzTWs1bjRq?=
 =?utf-8?B?L042ck9PLzExY1NGSi96VVVNVEFneUNYaVpwblRsQkx6QXpsQWFSZGU4UmJ5?=
 =?utf-8?B?M0FDeEdibXRkMEVIUE5UNEpzM0MrMm4xMjExL2NUMVR4K01yZlpnTW9SSllk?=
 =?utf-8?B?a3NaeUJCcmNmYjlkY1hJbGhmNHJER2FyZmZ0MXdVWWdDVTBmTWl2dUpLMnJX?=
 =?utf-8?B?UFNVbEdJQ3hYcjI0YzNUdDNPay8xWUhCdDdRY21sbC9kT3Y3QmtuQUpBcTVz?=
 =?utf-8?B?Ymk5alF5MjAxcFhIQTBTcHkrS0dIQ2J0OFN2U0p6bjJZS3RudXA3TW9vSTlq?=
 =?utf-8?B?OGEyeE5IYnJFY2Q1cXlaNXJYMDcxZUdpRUtDN2dWTi92VWZ5bTZ2VVkwZGo0?=
 =?utf-8?B?eHA4T0R6M0JnT3g2NnBoOUdQMWhhSmtGbGY0a1IwR2hqaitSNis0d3dCRDN0?=
 =?utf-8?B?bWJwUmZzeHY1WlNDelBZaFhSbzZjVWo4TDJIcTVaLzdVQ1ZpR1Bhc25YM2RQ?=
 =?utf-8?B?TkxRbVpwa2I2RVBwcHArTThjL3Y5WXN1Wm14dUJHSWhUaUE5S2VJNDByaTBw?=
 =?utf-8?B?Uys2N1FGVGJVVGY0Mldzbkk0VGxmeDRPVk1zMERzZjdTSk1zNm03TkgrWmFC?=
 =?utf-8?B?OWJJaUJHbGorZERNQjUxVnhHdWNpT1IrbjlEL2JYRjhmd0U1c3NVYTNWaGNG?=
 =?utf-8?B?SjZoYUxyRDFKVHlsM3IxbTBDTVdBQ2JYWTZvNFVUdVZjOWpoelNRUnNWQVlj?=
 =?utf-8?B?L3B2U1U0ZUY4cUlFV0VVcHRNWnNPUUZzcnRFZ0NKRGw3SDVWZVY4bVg1NUNw?=
 =?utf-8?B?bm9GQ0JaYkQ0ZkJmUDVMd05rYWNPb01kSStKbmFFNEl2Zk1EWnBnYUxWNGhR?=
 =?utf-8?B?WU45WWhuSDhTN1Eza1V5UnlFWDc3UUwvakQ5WXNoaU5IbjQvNXFNWW95YXFo?=
 =?utf-8?B?TTB3SjJoeTFodTlhUXVxcXhQbmF0TWNrWFZSN2tXeXU5cTRabWh2Mmt3aGky?=
 =?utf-8?B?eEhnS2I1KzhjNUVUN2JkZi9CWUJEdGN0Y2QzSnJjMVVqN3BLS3pUNW1SUG9R?=
 =?utf-8?B?MzV1RFhvWUtGTkYxUEtPZTd3bmdIWW1vQ3U5bGdEajhHM0FEUjhYclV0QzdD?=
 =?utf-8?B?akFlS3BBeTFHZDd2SVZsZjZPZzFvMEN6NUE2YytQREwxQk9OaGFENDF5YVly?=
 =?utf-8?B?NEVzQWxiWnc2d3I3WVNMVTV0bTAxeUlXdGMrS3dLaFQ1N0hzdmxyQ0k0T3Yy?=
 =?utf-8?B?VWRqdDVRZVBFWjF4Vnl3MUdwb1VGUllJY0ZrN2EwVDRKSERJTlBTMUUzaTUx?=
 =?utf-8?Q?nxKnPtFCFhhIUDZBDGXTj2hWy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <475BC36732152C46BBC7124FB3F010EF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c890c524-8c7a-4033-16e7-08dd1e3ddbff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 01:55:18.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xhJtP7Cx5uAR0qppIKDD4rakbVRlWZM2/gjtFUpfaTCsbCPvsby6D4gXLMiPFNas8ojUvIzmUJOHmGv3oERdUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8355

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
XQ0KDQo+ICBzdGF0aWMgdm9pZCBtdGtfaGRtaV9jbGtfZGlzYWJsZV9hdWRpbyhzdHJ1Y3QgbXRr
X2hkbWkgKmhkbWkpDQo+IEBAIC0xMTQzLDEwICs4ODYsMTEgQEAgc3RhdGljIHZvaWQgbXRrX2hk
bWlfY2xrX2Rpc2FibGVfYXVkaW8oc3RydWN0IG10a19oZG1pICpoZG1pKQ0KPiAgc3RhdGljIGVu
dW0gZHJtX2Nvbm5lY3Rvcl9zdGF0dXMNCj4gIG10a19oZG1pX3VwZGF0ZV9wbHVnZ2VkX3N0YXR1
cyhzdHJ1Y3QgbXRrX2hkbWkgKmhkbWkpDQo+ICB7DQo+IC0gICAgICAgYm9vbCBjb25uZWN0ZWQ7
DQo+ICsgICAgICAgYm9vbCBjb25uZWN0ZWQgPSB0cnVlOw0KPiANCj4gICAgICAgICBtdXRleF9s
b2NrKCZoZG1pLT51cGRhdGVfcGx1Z2dlZF9zdGF0dXNfbG9jayk7DQo+IC0gICAgICAgY29ubmVj
dGVkID0gbXRrX2NlY19ocGRfaGlnaChoZG1pLT5jZWNfZGV2KTsNCj4gKyAgICAgICBpZiAoaGRt
aS0+Y2VjX2RldikNCg0KT25seSB2MSB3b3VsZCBjYWxsIG10a19oZG1pX3VwZGF0ZV9wbHVnZ2Vk
X3N0YXR1cygpIGFuZCB2MSBzaG91bGQgaGFzIGhkbWktPmNlY19kZXYsDQpzbyB0aGlzIGNoZWNr
aW5nIGlzIHJlZHVuZGFudC4NCg0KPiArICAgICAgICAgICAgICAgY29ubmVjdGVkID0gbXRrX2Nl
Y19ocGRfaGlnaChoZG1pLT5jZWNfZGV2KTsNCj4gICAgICAgICBpZiAoaGRtaS0+cGx1Z2dlZF9j
YiAmJiBoZG1pLT5jb2RlY19kZXYpDQo+ICAgICAgICAgICAgICAgICBoZG1pLT5wbHVnZ2VkX2Ni
KGhkbWktPmNvZGVjX2RldiwgY29ubmVjdGVkKTsNCj4gICAgICAgICBtdXRleF91bmxvY2soJmhk
bWktPnVwZGF0ZV9wbHVnZ2VkX3N0YXR1c19sb2NrKTsNCj4gQEAgLTEyNTQsMTggKzk5OCwxMiBA
QCBzdGF0aWMgaW50IG10a19oZG1pX2JyaWRnZV9hdHRhY2goc3RydWN0IGRybV9icmlkZ2UgKmJy
aWRnZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgICB9
DQo+IA0KPiAtICAgICAgIG10a19jZWNfc2V0X2hwZF9ldmVudChoZG1pLT5jZWNfZGV2LCBtdGtf
aGRtaV9ocGRfZXZlbnQsIGhkbWktPmRldik7DQo+ICsgICAgICAgaWYgKGhkbWktPmNlY19kZXYp
DQoNCkRpdHRvLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArICAgICAgICAgICAgICAgbXRrX2NlY19z
ZXRfaHBkX2V2ZW50KGhkbWktPmNlY19kZXYsIG10a19oZG1pX2hwZF9ldmVudCwgaGRtaS0+ZGV2
KTsNCj4gDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+IA0KDQo=

