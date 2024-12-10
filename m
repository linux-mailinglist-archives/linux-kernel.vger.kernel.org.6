Return-Path: <linux-kernel+bounces-438675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2AA9EA43B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BA3288E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DFC5674D;
	Tue, 10 Dec 2024 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DW6hwZl+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IQcrzmqI"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA721282ED;
	Tue, 10 Dec 2024 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793792; cv=fail; b=DZ4jWFEFUdVtZoYCQ12D8GxheKpd4m9+fjknxSkZhlsQNZP5G7o+gyXHhOwRT3JMBRsJg/f2FgGBKxdN//3y/f2mE0wf2PRAypnF3ijBRNdML29iYpM76HVUyp6NmVmcrpeKFcu79bZAo0OhRNysoWR4wk1SIaD2ERU0stQ77Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793792; c=relaxed/simple;
	bh=AJ9bNSSJUIHbcaSWODxcxbFF1JtYSVQNsN68PUgAWGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=do2stAI8COlBGmvs5C1rUu3OMVyqMUFc71uKHtCGP/oIM5ElVNO2lzHXJJ6z18yHJ9pm/oeMqMyWYJPlqIbMzwgRaFrV9saXLhFRz/kawPDWl/Enp1i+fnFCQ9ioTgTVZR7tp+JBT4EDF8H+i3bdhpu7/P7+H9myQKqvDuhttzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DW6hwZl+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=IQcrzmqI; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 484935c4b69511ef99858b75a2457dd9-20241210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AJ9bNSSJUIHbcaSWODxcxbFF1JtYSVQNsN68PUgAWGw=;
	b=DW6hwZl+wbryNBq9NbYktjrKyWseoLPMeeXDmz5u8XEFNy7/emK23vKtsMMl1C5OQB28EFS+AfzHbaJuf6uR//RDoWpxDz74/Gsgun0UvX/FpRPaPqAARVtufMejpt6pjDVp00zYXwmCL3/oN30NBn4urZ+vBGc5Mf7Wihpfo0s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3bf4bc85-a4fc-418d-9a45-f8881834c41e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d9afb23b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 484935c4b69511ef99858b75a2457dd9-20241210
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1293934827; Tue, 10 Dec 2024 09:22:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 10 Dec 2024 09:22:53 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 10 Dec 2024 09:22:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O40NO50bdxHRQ4da4yUwBKmZYXlv2RXjF0gcyCXSOkxuFqGBcVJRV75Qy4pWW26GOXbaCpaoRU+9yGNOnGkJXNOKRmWKZ7kVL2X3oaosxD80Ix9mISSIg6nbieQYZI0kfNLfx5NfHidPPJ3HIt9WxKYU2dBOIhub2P+t8pa/3MDBMUCUwInARzzx+PAlRM3CScQrBlrzTeCHXqIXVLlr3b68bCGmP0hwK0yu1dHUap1b+Yb20eBnt30+vdygqCQCw1VfFbor6ap43MK+i9R+Eb7EmVhfNYI827QV1Ta07ihI9d71psCQmyWTzJabnAfRZIVdmMDL6uMb/hw8AyQuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ9bNSSJUIHbcaSWODxcxbFF1JtYSVQNsN68PUgAWGw=;
 b=lWgkJwQ4IR8Gc5MIxWmeOCLxu1oKZMO7IB9sN6iVFwbTKKdAIoRPIdfH5e/AtrTJYuYFriNJcNIWFiQeA0xsRaKZVJnztViv6CKA1Ew+MYhEmpu6JIK6IZxUo7mm+wapkioeH8sIqwWozOlLdwxSaLHO2Wqqck5cI/vujUjxuMG51PygB+Go5N1GYOHQtsLS8W6hbWay9mDmhjBGtNO6Hk6wfNCE+PzOxFahW0kBeptmm4cvV0uI46lQR8g2uujagYTGLxZweakcsQhDHLSCR+iiaEgh8G6Srham0UJWcWfaLuluAxhUZU71PzBqu1q0tJ6hb+WUFPTLu4dCNQ3Dmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ9bNSSJUIHbcaSWODxcxbFF1JtYSVQNsN68PUgAWGw=;
 b=IQcrzmqINBwvga9jf9gt1DDMZCzHDhDN7MCsSi8kIIaJSfttQXYLpv33E3gcqUrhzUjZYqLnM7rkklUcFpjTTg5qGN5MlYLg0qmwayAPdkqLygZQJRF/JgAvOJo6VtFu9KJkd+g2/Tq85veS42c5fIyN9VupdlSz3yG7eUOnAnI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7746.apcprd03.prod.outlook.com (2603:1096:400:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 01:22:50 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Tue, 10 Dec 2024
 01:22:49 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "jie.qiu@mediatek.com"
	<jie.qiu@mediatek.com>, "kernel@collabora.com" <kernel@collabora.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v2 14/15] drm/mediatek: mtk_hdmi_common: Add OP_HDMI,
 vendor and product strings
Thread-Topic: [PATCH v2 14/15] drm/mediatek: mtk_hdmi_common: Add OP_HDMI,
 vendor and product strings
Thread-Index: AQHbRwt4xV/d1hvrLUKjHjxK6fEG0rLdpeeAgAANMQCAAQLcAA==
Date: Tue, 10 Dec 2024 01:22:49 +0000
Message-ID: <bbbfd8df7673b170ceb24a22238230dc2b35b0f2.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-15-angelogioacchino.delregno@collabora.com>
	 <6697eef88677950d36fbfbd6676f82f291621159.camel@mediatek.com>
	 <7a4f8b11-e840-4e33-a6e7-4f58601ed31c@collabora.com>
In-Reply-To: <7a4f8b11-e840-4e33-a6e7-4f58601ed31c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7746:EE_
x-ms-office365-filtering-correlation-id: 602622fb-efd2-4c24-1ef2-08dd18b92945
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SWJiVE5HOVJaMkpCT2ZqUGIrTEJCc1BERWxEMW02YmpUL2JPMVVTTGhvRjd3?=
 =?utf-8?B?cEorYXdUOTRQOE0rVWJGMTBzWEdzS0grTXJUS291d0t5NE1kNGFncDFqOFRh?=
 =?utf-8?B?TVAxVGZKTzdMMXlYSUtiUGRJdDR1OTMxMkFscEdtc09UZGpRVmNTck9MRUYz?=
 =?utf-8?B?U0M4WUl5WVczRTFlYjhCTDRtbW9LKzhzb0R4WXFaRHNjdEpta2lqbWVlVERt?=
 =?utf-8?B?cnA5VHN4eGdWRnJhc04zbVJtZGplYWsyVFI4M1NtWXdhcTdrR3lNUWR5bys0?=
 =?utf-8?B?TnBMZ3VnRFdoZDNjN2VHZlBZWnVOSGlMOFYvcTZBbnZWOVlmcGFtcFRCUEhE?=
 =?utf-8?B?VXR4b1VzMXdlVzZpZFMzLzJDNkJZeEFaOGFEVEdQYXlpNVQ2RWdTay8xbDBl?=
 =?utf-8?B?b2hHVWoweHQvZ0xuakphcnRjQ0luMkJRcDJ0cnBaTTlvNTBrcGFDU2Y3ODlk?=
 =?utf-8?B?WXJudEtHOHUrY3ArTW05dzNDQVhYZU1Rd3JCZ2h2ckVveUluQ0NLcFBtTXls?=
 =?utf-8?B?RFRQaVpNTDE4Q1p3Sm5XOGYrNlAreEVsd1lobThVZWExRzdWYmYxVEVQcWpW?=
 =?utf-8?B?NTRpZzFVaWM3ZmJseUJnaGV2WHV4UUViSWw3dWVkcmNRN1YrbUtqUnNuaU5T?=
 =?utf-8?B?UmQ2Ujk0d0NoUys3QjcyTDgvbzNhUFRteHJ0SEsyUThqdjdsRG1DL29zUS9h?=
 =?utf-8?B?dmpYeld3YzdkZkppbUozVmRjaWJjZ3JDSDFTdE9ZSXVGK3h0bDcvVG1ZRWNX?=
 =?utf-8?B?Ymc0ek9oZlZNL3Z5S05XMGZqeDRFNldsM28rcTBTWTJneU9keis1bTd4ZjNG?=
 =?utf-8?B?U2VBZWgxSW9PTUZ5enpYelFoM3p1WVhab0VXb3BsT3p6SnJ2VmZFZldFM2xy?=
 =?utf-8?B?US92WEdkNjFpWm5CVit1VU90bGJEdHVieFdXN2RxWm12OUdkY0tXYVlFSHVt?=
 =?utf-8?B?U2Qxb1NNVHJ1blF4enFKczNUTW9kcVE5Y05zejNhNEJLQ0hpRFBHZGNwQmVr?=
 =?utf-8?B?VDkxb3JtblE1aW11NEsvQkwvRWtxUlRacXJHWDNEeDZHcDRJUCthUHRYeS9B?=
 =?utf-8?B?REdmcW1tcWYzK015TjFQdndtdzBJdVFVaU5idHVnWE9EL3JZMUQwelV1eFNp?=
 =?utf-8?B?RjJlNkRLTHVuS2VlOXpHS2tDdXRyaWZYVEVnN2pOMUVQbWdoRkIwVXBlSURm?=
 =?utf-8?B?QmdseGVBU0ZJbWlJb1JXQ0dUbHg2WDZPTWE5Mk01aUpxNVdJem5KWUNid0t3?=
 =?utf-8?B?TysxcTExZ2JoekRXbG9yamtXbFJCVUdQSW1NRDBSeTl1SVMzbFhtWElTY3dx?=
 =?utf-8?B?d0t0cVBQZWtBWjhNa1V4OVB5SDhlYXlFNGQyaHN1bmZHRithMVhXbHRwMk5Q?=
 =?utf-8?B?TWYrL3U5elpzMlFiNHZ5VU9UVWtqTDd1TlNIMWRJV2phMGlFMjdRVk5PRHRr?=
 =?utf-8?B?N1JrVVFqUDJVVmpySTk5aWQ3OWlaYXo5TzM2T3F5TDQ1SXVHTjU2VmhDMFNJ?=
 =?utf-8?B?ajFqTzM4eWN3dTljU3RmalRnTWRFZ1MxUVJuSkVIWFdST25vUTk2VVNmMTYz?=
 =?utf-8?B?eG00OERhQUViRmZhTFc3dHRCcnJHVkwvRHVybTB5NXFoOGdjcTRzZEFwZ0Ns?=
 =?utf-8?B?dGIyYUY5RGZVelRqVFh1Vlh0YjlkVVlYM3NGRFFLZGM3WFU2aGNUOVJ2N1Vk?=
 =?utf-8?B?WFZmRGJ0TjFFaE9ZWnBtRnhON24vWC96VXd0cWhqUVVtMXg1N2dFWE1nTnBT?=
 =?utf-8?B?eUZ4N1QyeE4xSktsSERNbTI4UUJRWHlLNTRLRWI1QkF5RVpzaGRYSy9nK0tu?=
 =?utf-8?B?amh0Y1JTTkFkRHZuMVE3bEZ2bERIOS9Xd0dlMHk4d1VDSlhjUUZKK3VBNDdj?=
 =?utf-8?B?Wm8zTHpwOGV2ZjdvM1NZNFJNZ3ZGUnFESzlxSXBoWTk3dGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2tkUmgxVE1Va0dXUXBGK1pXeDNYRVBZVDNFZjJhMlVjZG9wMGVZK29ERk1a?=
 =?utf-8?B?czFTRmxvdUhFR01QczZ1YWFPNWFubFlVWE80ZjZtME12TlN2dlQybGt1OEFK?=
 =?utf-8?B?S1R4a3hocElGSndETmFIWHdNTnNJUDdrdzVsVkMxNFF3SVNNZEdZSmV3bXlv?=
 =?utf-8?B?Wkc2dlBJOTRZdStHYnppRkRsdGR6eGwxdFN5QkRyTDZYcVpoa1E4dTJXQjBM?=
 =?utf-8?B?NlVLMEs0bWJLMFZQeFFBNUxDREltMWxlYmk5NTl2NzNWVGFUY052cUhadjU1?=
 =?utf-8?B?MmgzODZlc1gzWnB3M1F2Q3hCTDk5dllFQ0xBdC9vY2pxMzJkUmhoeHFGUDJu?=
 =?utf-8?B?WFVzaDZCb0k2Y3h2V2FLbDFSbEowajNGck4xdCtScm5PYk9iVml5ZHRZUXgr?=
 =?utf-8?B?WlRJd2RYUmhWc20zZVRtUWV1UVJwUllVSVNSWkQxYWxTTDQ0c0xLbnpPTHVn?=
 =?utf-8?B?cDQ4cDRmNzBVaURLWlRzQ2g3WkJQNFhEVDlWTkVnV1l4OFRWNUEvbWJZS25F?=
 =?utf-8?B?ZVpJdkpLcThmVEdEb3YvTjVuc1ZIdmpTbWJkOFE4ZjlsbGF6dS8zVFdNaFVC?=
 =?utf-8?B?QmhNUWthblZEVGdlaEtkMDh0YXNDLzFDdEo2RFIvbUhadUlqUnorR2VmamNl?=
 =?utf-8?B?djlja3Nkc3M2VUx5ZlN2elRLbjNVb3JQOWxxSXpFcGwzRUNlOUV0eXlvVVZk?=
 =?utf-8?B?amVMMU11SlRwVmd6alBSdU5SSFNKSTNnM1l3YnUwTWI0bnRBRmttYTUyRDFC?=
 =?utf-8?B?a0pPM1FZVUJnRTl3V0VEUXFQNXVwSlF4akVUUnRWeW5lQk9CSEVsRUNsRWFK?=
 =?utf-8?B?VWpab2gwTEVQNFJ5QWFueEw3V3BVaGtYTURSZkFBN0VJTSs4a05LUVVBVVFB?=
 =?utf-8?B?cTEwNEhndDQ0V3pORVJ3ajB3WjZVZjZSSHJNS2FkNW54Rk9Kcy9hVHM2UWtN?=
 =?utf-8?B?dVdOVnUrNnVYd0RIYmJTcXFJZlVmYnBFNlV2dHlUdU4ybDZidXFGZkRHMGsy?=
 =?utf-8?B?TWViSmhiMUxnaEQyS2V2eTFVV29QZjBGbmJjTDhxUkJ0Yks3YWVIelRLUDZZ?=
 =?utf-8?B?STZuVVBtU2ZmdVRTclNzVlNFTXZ0MVBXM3pOd1BZUHRGSHpCRDhBNmRjc0hH?=
 =?utf-8?B?SWxkWkpTYWdrMGxPWC84VTJ4YUhidUc2cjREdW9Kaktlam9OYmpWSnB0VEFr?=
 =?utf-8?B?Qzc1clNoNkVhamVmVUVzZlRTK3dHUGozM2RBNkFCaFlzOEVWbXFONURacElx?=
 =?utf-8?B?MWpSaVpNTWFaenYrY0d2aEhvWkxQK3FyQXdPMEppMG40L0piQ3lOREtmK1Nk?=
 =?utf-8?B?akdRRENaR3JGWm9JcUpJaUE0Nk9JSWpycmtWLzVqZ1ZjQ3QvUGRrbHJlZFYx?=
 =?utf-8?B?cGJ6a1I3cW1wUitBbFRwWllxQnBhRHVhZHU3eGVocmpwcGU5ZlpuMjB0RUxH?=
 =?utf-8?B?NkFsY1J6TUxTT0xyU0htdlo5dkRKc3pKdHNwTzVvRjE5cUZ1ajdMYXdWaytn?=
 =?utf-8?B?T0hZZms0OFRQSDJ5K1ZNNExCTEpOVlNML3RSTElRWjJQYytqSDlTWjlYS2dF?=
 =?utf-8?B?OXVvL0IvMXNmODNZQ2x1VzhQc2RHY2JmT2ZQUlJxdndVOEYxM1pxVTBzV1Rx?=
 =?utf-8?B?QWZZZXUyYUplMUZJRDRQVmtiU012RTc5L3UzK1grNU16ZGR4YkJQSmh2Z0xi?=
 =?utf-8?B?Q1VrL0toYzFsSmdsMUxoTE1vdnRSenhjY01DNW1HNXgwUTArbHZHdy9NTkZz?=
 =?utf-8?B?aXFWRG9OMWM1eHBpMG02aTB4d1BkQnBQeXVyOEEzZFd1eVJTTitCTm5DejN6?=
 =?utf-8?B?KzFOZlg1MnFVdkwyT1pxVm1QM2dSdEQ4ZUdYc0RQMy8zc09jZkRrNzNTY3Rp?=
 =?utf-8?B?RkMxeGdqeThPK3BScWp4SlQvZFpuWmRGWnR4VmNwWVhOdzVqZWIyc2hhK1V4?=
 =?utf-8?B?UkRPMXdlUFJKblVBZ08vZ0N4L3RaTFFwUTZsSzUwS0VEWmZvMWVKQWhaYU9r?=
 =?utf-8?B?MVpNZlVsaXdPd3loekdRM3FXQSttTklmQmF5R0hHWjNOelpGZFFqcnlWam1i?=
 =?utf-8?B?Vys2NDgzaUM1bnFTK1laTFZYczBOUWpMczZTM1pMbS9wd2FHTC9Ib3RHQzNN?=
 =?utf-8?Q?5qz8UxAzLrRaI/yPX2pHLTfCJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E6FEC27DCC01A4B8D70B0B884EB3648@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602622fb-efd2-4c24-1ef2-08dd18b92945
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 01:22:49.6697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xum9ZifQp+p7UREDVBMpI/4lgS97fnAFJISMcpeS3T3Kc+TDrYptue0bZZG8Ad9IQ1sEJ0VIyPQQDd7T1degDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7746

T24gTW9uLCAyMDI0LTEyLTA5IGF0IDEwOjU2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwOS8xMi8yNCAxMDowOSwgQ0sgSHUgKOiDoeS/
iuWFiSkgaGEgc2NyaXR0bzoNCj4gPiBIaSwgQW5nZWxvOg0KPiA+IA0KPiA+IE9uIFRodSwgMjAy
NC0xMi0wNSBhdCAxMjo0NSArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6
DQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IEluIHByZXBhcmF0aW9uIGZvciBhZGRpbmcg
dGhlIEhETUkgVFggdjIgZHJpdmVyLCBhbmQgdG8gYWxsb3cNCj4gPiA+IGEgZnV0dXJlIG1vZGVy
bml6YXRpb24gb2YgdGhlIEhETUkgdjEgb25lLCBwZXJmb3JtIGNoYW5nZXMNCj4gPiA+IHRoYXQg
ZW5hYmxlIHRoZSB1c2FnZSBvZiB0aGUgSERNSSBIZWxwZXJzIHByb3ZpZGVkIGJ5IERSTS4NCj4g
PiA+IA0KPiA+ID4gQ2hlY2sgaWYgdGhlIEhETUkgZHJpdmVyIHByb3ZpZGVzIHRoZSBmdW5jdGlv
biBwb2ludGVycyB0bw0KPiA+ID4gaGRtaV97Y2xlYXIsd3JpdGV9X2luZm9mcmFtZSB1c2VkIGJ5
IHRoZSBIRE1JIEhlbHBlciBBUEkgYW5kLA0KPiA+ID4gaWYgcHJlc2VudCwgYWRkIERSTV9CUklE
R0VfT1BfSERNSSB0byB0aGUgZHJtX2JyaWRnZSBvcHMsDQo+ID4gPiBlbmFibGluZyB0aGUgZHJt
IEFQSSB0byByZWdpc3RlciB0aGUgYnJpZGdlIGFzIEhETUkgYW5kIHRvIHVzZQ0KPiA+ID4gdGhl
IEhETUkgSGVscGVyIGZ1bmN0aW9ucy4NCj4gPiA+IA0KPiA+ID4gTW9yZW92ZXIsIGFzIHBhcnQg
b2YgZGF0YSBleGNsdXNpdmVseSB1c2VkIChpbiB0aGUgY29udGV4dCBvZg0KPiA+ID4gSERNSSBi
cmlkZ2VzKSBieSB0aGUgaGVscGVycywgYXNzaWduIHRoZSB2ZW5kb3IgIk1lZGlhVGVrIiBhbmQN
Cj4gPiA+IHByb2R1Y3QgIk9uLUNoaXAgSERNSSIgc3RyaW5ncyB0byB0aGUgZHJtX2JyaWRnZSBz
dHJ1Y3QuDQo+ID4gPiANCj4gPiA+IElmIHRoZSBoZG1pX3t3cml0ZSxjbGVhcn1faW5mb2ZyYW1l
IHBvaW50ZXJzIGFyZSBub3QgYXNzaWduZWQsDQo+ID4gPiB2ZW5kb3IgYW5kIHByb2R1Y3Qgc3Ry
aW5ncyBhbmQgSERNSSBoZWxwZXJzIHdpbGwgbm90IGJlIHVzZWQsDQo+ID4gPiBoZW5jZSB0aGlz
IGNvbW1pdCBicmluZ3Mgbm8gZnVuY3Rpb25hbCBjaGFuZ2VzIHRvIGRyaXZlcnMgdGhhdA0KPiA+
ID4gaGF2ZSBub3QgYmVlbiByZWZhY3RvcmVkIHRvIHVzZSB0aGUgbmV3IGhlbHBlcnMuDQo+ID4g
PiANCj4gPiA+IFRoaXMgYWxzbyBtZWFucyB0aGF0LCBpbiB0aGUgY3VycmVudCBzdGF0ZSwgdGhl
cmUgaXMgZWZmZWN0aXZlbHkNCj4gPiA+IG5vIGZ1bmN0aW9uYWwgY2hhbmdlIHRvIG10a19oZG1p
IGFuZCBpdHMgb3RoZXIgY29tcG9uZW50cy4NCj4gPiANCj4gPiBPUF9IRE1JIGlzIGZvciB2Mi4N
Cj4gPiB2ZW5kb3IgYW5kIHByb2R1Y3Qgc3RyaW5ncyBpcyBmb3IgYm90aCB2MSBhbmQgdjIuDQo+
ID4gU28gc2VwYXJhdGUgdGhpcyBwYXRjaCB0byB0d28gcGF0Y2hlcy4NCj4gPiANCj4gDQo+IFRo
ZXkncmUgYm90aCBmb3IgdjIsIGJlY2F1c2Ugb25seSB2MiB1c2VzIHRoZSBIRE1JIGhlbHBlcnMs
IHdoaWxlIHYxIGRvZXMgbm90Lg0KDQpTb3JyeSwgdGhlc2UgdHdvIGlzIHJlcXVpcmVkIGJ5IERS
TV9CUklER0VfT1BfSERNSS4NCg0KICAvKioNCiAgICAgICAgICogQHZlbmRvcjogVmVuZG9yIG9m
IHRoZSBwcm9kdWN0IHRvIGJlIHVzZWQgZm9yIHRoZSBTUEQgSW5mb0ZyYW1lDQogICAgICAgICAq
IGdlbmVyYXRpb24uIFRoaXMgaXMgcmVxdWlyZWQgaWYgQERSTV9CUklER0VfT1BfSERNSSBpcyBz
ZXQuDQogICAgICAgICAqLw0KICAgICAgICBjb25zdCBjaGFyICp2ZW5kb3I7DQogDQogICAgICAg
IC8qKg0KICAgICAgICAgKiBAcHJvZHVjdDogTmFtZSBvZiB0aGUgcHJvZHVjdCB0byBiZSB1c2Vk
IGZvciB0aGUgU1BEIEluZm9GcmFtZQ0KICAgICAgICAgKiBnZW5lcmF0aW9uLiBUaGlzIGlzIHJl
cXVpcmVkIGlmIEBEUk1fQlJJREdFX09QX0hETUkgaXMgc2V0Lg0KICAgICAgICAgKi8NCiAgICAg
ICAgY29uc3QgY2hhciAqcHJvZHVjdDsNCg0KU28sDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2su
aHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KPiANCj4gPiBSZWdh
cmRzLA0KPiA+IENLDQo+ID4gDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5j
b20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1p
X2NvbW1vbi5jIHwgNyArKysrKysrDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfaGRtaV9jb21tb24uYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9j
b21tb24uYw0KPiA+ID4gaW5kZXggNGY3MDhiMDRmNWU4Li4wZjYwODQyNDYyYjAgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfY29tbW9uLmMNCj4g
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9jb21tb24uYw0KPiA+
ID4gQEAgLTQwOCw5ICs0MDgsMTYgQEAgc3RydWN0IG10a19oZG1pICptdGtfaGRtaV9jb21tb25f
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+IA0KPiA+ID4gICAgICAg
ICAgaGRtaS0+YnJpZGdlLmZ1bmNzID0gdmVyX2NvbmYtPmJyaWRnZV9mdW5jczsNCj4gPiA+ICAg
ICAgICAgIGhkbWktPmJyaWRnZS5vcHMgPSBEUk1fQlJJREdFX09QX0RFVEVDVCB8IERSTV9CUklE
R0VfT1BfRURJRCB8IERSTV9CUklER0VfT1BfSFBEOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICBp
ZiAodmVyX2NvbmYtPmJyaWRnZV9mdW5jcy0+aGRtaV93cml0ZV9pbmZvZnJhbWUgJiYNCj4gPiA+
ICsgICAgICAgICAgIHZlcl9jb25mLT5icmlkZ2VfZnVuY3MtPmhkbWlfY2xlYXJfaW5mb2ZyYW1l
KQ0KPiA+ID4gKyAgICAgICAgICAgICAgIGhkbWktPmJyaWRnZS5vcHMgfD0gRFJNX0JSSURHRV9P
UF9IRE1JOw0KPiA+ID4gKw0KPiA+ID4gICAgICAgICAgaGRtaS0+YnJpZGdlLnR5cGUgPSBEUk1f
TU9ERV9DT05ORUNUT1JfSERNSUE7DQo+ID4gPiAgICAgICAgICBoZG1pLT5icmlkZ2Uub2Zfbm9k
ZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+ID4gICAgICAgICAgaGRtaS0+YnJpZGdlLmRkYyA9
IGhkbWktPmRkY19hZHB0Ow0KPiA+ID4gKyAgICAgICBoZG1pLT5icmlkZ2UudmVuZG9yID0gIk1l
ZGlhVGVrIjsNCj4gPiA+ICsgICAgICAgaGRtaS0+YnJpZGdlLnByb2R1Y3QgPSAiT24tQ2hpcCBI
RE1JIjsNCj4gPiA+IA0KPiA+ID4gICAgICAgICAgcmV0ID0gZGV2bV9kcm1fYnJpZGdlX2FkZChk
ZXYsICZoZG1pLT5icmlkZ2UpOw0KPiA+ID4gICAgICAgICAgaWYgKHJldCkNCj4gPiA+IC0tDQo+
ID4gPiAyLjQ3LjANCj4gPiA+IA0KPiA+IA0KPiANCj4gDQoNCg==

