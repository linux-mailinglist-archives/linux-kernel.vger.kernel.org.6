Return-Path: <linux-kernel+bounces-512588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C977A33B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D0118877CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8C20D4FD;
	Thu, 13 Feb 2025 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R5FUQaeV";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="j+0SN71C"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADC202C27;
	Thu, 13 Feb 2025 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438754; cv=fail; b=RrKrK6fhwYKVSPjTqhHS17dRuIdvZaQvoNpj1t49nYGQxYWfXMOs3uk7CGXEsrV7bnKZKSlydebfIAzCebmAV4AxNc9rE3hJJw0CZIfy1AqpFLHgHqNRq85XJ/g4vIWqJjTmabisz7vQTdhKutAkLozjEs2c2po9jy3b2eGHCl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438754; c=relaxed/simple;
	bh=f3fj7EfxRnnz7voMTBbYSPdXnORezxQeK7ahFb0wkec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JIMJiAEpXzxW6ApZaJRFBUo/VYeOAEfOLEp7mPXtKS2D798qEmy832W1B4/8HOEG2J3IAuYPQp6LEV8CUpf34wDwmTqTN5uZoXl6k2wdMQCxozU6gJPb/C40PG1EI6o+BXiarMI4lTBiKh1wvCzVC/K5Wu++IfxN/XaG1uRjLcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R5FUQaeV; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=j+0SN71C; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8142a074e9ec11efbd192953cf12861f-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=f3fj7EfxRnnz7voMTBbYSPdXnORezxQeK7ahFb0wkec=;
	b=R5FUQaeV4mDXczrL1FQY6XsV1ArWAW/yagEe3qxLqCmfTVel1JzFkPAVS53hECIid0ssACj/OGcK8VXAcSxuLV3xKwuWNPVA+J4Y2HvxJdLS9+jWOxgH9KzV1xMQlWuMS30VjWRSXVEhz0jMyFIQCTnXQvNo+GvIWozpL3Tcu60=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:5414b982-acc4-4121-b898-288981860ccb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:516369a1-97df-4c26-9c83-d31de0c9db26,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8142a074e9ec11efbd192953cf12861f-20250213
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1934783508; Thu, 13 Feb 2025 17:25:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 17:25:44 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 17:25:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seZSii/2d/uS/T3n4yBUbBXac32S0ZasrVKBu2Qnr8AQvGEGzCQiUd+Ol4Pr4dliA37FwwNUMR7iUOX3vaVGKtYlrW9hK4dRcPRDnHdbQ6o9GHduESNCz+uXZjuhQm0RV+HqVyHkF3Aym+1iBHPqgdRtE1ue7y0dFmCTwsZ9K6hev9jEAgLPnInMOVWa3QUDseRBMEh0Xdbhi/yrq4+nbDt9UNybsbxh8KgedQKW8Rf6EAE551ecFPmUYprmK8ptbrTo4D9r6BGcSZ2s1sCDfzLtWFzp/i/wbuIEC8jaGeyC8y8mb3uKsSKlahSFgsbe36XjnGdpMbZfEQQra2aBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3fj7EfxRnnz7voMTBbYSPdXnORezxQeK7ahFb0wkec=;
 b=ZGx93KaGbmk6EOSSgq58oxLaEQu3iyFvagHnF0njiITMEDhmfOgn8CXzPOnf13EOvnFzYJz9QVqsaDcZa1UOXeDdPJ9JiIB4RWFfeHqV6fqvc9HAzSs7a7A0Bm0YcgN46H7K5kr9X36kC+Ikt8MINsrrcWmSP2F9zNg2EQv7OUY6HBdUEd8MMaZGOpZXiwfXQ16Qg01b3x+vyjDmDJGLhlmqVIWvCdHg2+CfretdyxVSsA+Jd/OVODAP3tYigN6ugcKx3yRa5Nr42IAt2TUL9kkkjSSJJmM38RKosvopNiwZJATYmI3TmdWDA6Cjsx/oBk3yjG9CqsPe95N4G1ie7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3fj7EfxRnnz7voMTBbYSPdXnORezxQeK7ahFb0wkec=;
 b=j+0SN71C0asa7wGNlM6o4bkpQ9TrpMFWGxl0f9m6zRSnUQaN12T93T5JQP2kuwpl6p8CHcwqMI6JeV0N61rGN6q+o41wLcR6wtRQ5JSzaeqzQW+ULRtY1/vKgY53GDz5mcCkFwEUaiyabMSXdns2j9WcHkWUPio3khJKqyhVOeY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6596.apcprd03.prod.outlook.com (2603:1096:101:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 09:25:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 09:25:16 +0000
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
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, =?utf-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?=
	<TommyYL.Chen@mediatek.com>, =?utf-8?B?SXZlcyBDaGVuamggKOmZs+S/iuW8mCk=?=
	<Ives.Chenjh@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
	<Jason-JH.Lin@mediatek.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v6 42/42] drm/mediatek/hdmi: Use
 syscon_regmap_lookup_by_phandle_args
Thread-Topic: [PATCH v6 42/42] drm/mediatek/hdmi: Use
 syscon_regmap_lookup_by_phandle_args
Thread-Index: AQHbfHk3jSCh8aiAEU6sSDMN20nTYbNE+W6A
Date: Thu, 13 Feb 2025 09:25:16 +0000
Message-ID: <2443b8a50c1d1134b045d8724f204cb81acf2978.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-43-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-43-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6596:EE_
x-ms-office365-filtering-correlation-id: 731abd41-0d53-4dc7-5136-08dd4c1053c2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QTE1S09nSlg0RGlVdDZqQXpRMTNCK3JrNGZwRHBLTGg1ejdPUllBZW15SXFJ?=
 =?utf-8?B?MFB3Zk5DdFJCUmtMTXMxNkZrcW9ISTBvVkhjRFN4MnJqUlgvT3ZieHNFSEdP?=
 =?utf-8?B?VEQrRTZRR1o4S0w2RXE0cWpnVmdneGFCKzJrb0U3SEx0TVJpOVhGODdKa0xq?=
 =?utf-8?B?QkFlYjMwZjVYSGN2WlRqN1htQUJaVEpJQ1RreDJldExTWlZtam9Na1VZWFJa?=
 =?utf-8?B?ZUp2RkZyeHQ0SnVPOG9JUnh2bnIzeVNrZzVqaG9LWFczZXZhOGxLWk1wTFpT?=
 =?utf-8?B?RjJvc2pjMGZBOUFKdkxDMEwraHVuaDhtcTVrM1VjeFhCbmpKSHQyb2JnT2tv?=
 =?utf-8?B?bndzaC9pYzdaR2NQUzhkbXUyYnVaZ3M0cjdXS2VCbDdneURvTktJa0tkRXFI?=
 =?utf-8?B?Y2l5ZkltL2RpYW1CZHJReHJvaElqSFVmcGhsU2VYd0xRc0krSzFGaDdsQVpw?=
 =?utf-8?B?bVhraUk3c1FPZm9vM3NaOFRESnNoUlp3aUxaZjJYL3RmbUJIbEVkMGl4MmF3?=
 =?utf-8?B?N2Q2YndLTHF6T0FRcHFIUENPQ3Y0eGlKSlN2WWtXMmZOSjZaeUR5Mm9CbHdQ?=
 =?utf-8?B?aW02SXJxa0h6eTBIUW1OKzExeGU4MC8yOVpaWVd1UmtHekNuOXg0eHo5TDA4?=
 =?utf-8?B?TVpBbUU3VU1pSDVvb1hxb09mSCt1NisvK2Z0bkJkVytjUjNHZUJqdmtQdkRq?=
 =?utf-8?B?WU5iMzZ0TUNaT2pvZFFHeEh1bHlvZXRnd3hwR1dDK0RGMk9GZ3FDNlllYm1H?=
 =?utf-8?B?bXZPcE5RV2sva011d0FZMVU0ZUhzVkZLdXEvdW1FZHRVMVMxeDhITUhKVzhK?=
 =?utf-8?B?QldIV092d05MSFVBRTAvSmI4UElUYm5Vc2R4QURGNS9oazJnOVlHd1Uvc0Vt?=
 =?utf-8?B?WTM0T0NYdWxBaUJqYjQvK2NNOXFQZ1pZanBxb2kxQ1cybEVEMkpadll2b2RQ?=
 =?utf-8?B?UmJMSUJQZlFJMDBUNnFiS2MwREMwQklablV1UUNGZ0RWTmRCV0VUcGE0enFK?=
 =?utf-8?B?YVpzRHRmdkJFUzVPei9ObTI2TXBFNlR0QWNUV3pTbVBEWWM5YmExcTRLaXZD?=
 =?utf-8?B?M28wS0xISDdNYlpqYThsYVNlWFc4UHFQZG5CaEVtNmJvRTkyMmw5WG9uYUxw?=
 =?utf-8?B?NzJJZ21PNVBkOUQ5NFRNMjFTVUZGRFlzMHdIV0w2NXp0YW9XenZ5T0RkYlBh?=
 =?utf-8?B?M2pHWllHZ0xtc1Yva3BPTXpCSmgwRWdxdi9EQXhkeUd4MG0xak1ReDRSWU01?=
 =?utf-8?B?NDBENlEraVU2Y3owdFN5V3JML1BEUXRyTTlIK2N2LzRsVUd5dU9nT25oejBy?=
 =?utf-8?B?NlBZSjltZjdlUjI2SUgvWlZldDkyVk1PRzVPZlhIVndNamxNMGxrcWplSWNI?=
 =?utf-8?B?TDZnVU96cDhUbituY1IwV2JaK2w3Z0FiRi9SUWdHYVEwN3M0czAzekh2Nzdi?=
 =?utf-8?B?ZUZDNWk5YTlCQ0JFenY5ODBLK3hScWRudkJjQWdTcWNjTWxCNnN5TDg4ZmtE?=
 =?utf-8?B?cmxXWm9GUFk1T0RSV1grNUpmZW40N2ZvZzgxYlcrMnFaMnVDcDNXek42UWtN?=
 =?utf-8?B?NEhDTWJ3a3UyTFN0TVczcDZQMkhEVlNKWFBSN1piQ3dQMzQwa0VvQmVOUmFy?=
 =?utf-8?B?TWF3RjI5TUMxZ2FWaHhFQnl6TjR0dWx3bllKdG9TRDdvdWNDNmgycjVuMDI5?=
 =?utf-8?B?S05JQTFBeEc5bHVsdVRQWFZVRlIzSlhyUFBDWXdNTUNTd3YwUmNITTJaUCtR?=
 =?utf-8?B?ZGRTbHMzd3BDQis0SVNob2RveFdPcHF1cGlsNnpUK1l1NFdxY3F4Ny9Icm5k?=
 =?utf-8?B?VUQ0Rkgyd3RHMnR5bWpTcEpuL0FZUmdzOXpneUMzZXJNWk12aU41YWF1WnVz?=
 =?utf-8?B?clpFVU5hMG9MaGJoU282QkVjNE8wbm5Ed3g2a1AvVnpxSmtHdDVIS3RsSzI2?=
 =?utf-8?Q?FVq0c3ThoFAVKOy/fl5Sb48J/qNFpAqw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTNYZW0rL3MwZStaa1pRdENieTRJSU90M2dTeWJ5Zno3bzczUllWYXJ3V2Rh?=
 =?utf-8?B?TS9KTk1MM0RWL25PalF5b2tNZllWTHN5a2ovZWdXUFN1VzJCWEMzMDc2TEhR?=
 =?utf-8?B?eHp0bTlINzNSSmFsTEt0MzFsY3NCRkViUEUrZVBmZitlVlZPQitVZzNxYVlR?=
 =?utf-8?B?dDhhNUQ5ZzhVd3EybktPMkFEYzd1TGxlcVJkWjl6ZitNNlJ6T0xYZDdLOU1w?=
 =?utf-8?B?c2hDTHpzN0VsTFhRbEE3Q2ZZVFJLR1JOdnBnYnNIRE1vblkwMENLRUV5Uks0?=
 =?utf-8?B?dzRHdEZHRnRDVDhRQ0E4d0VFeE1TcHJoU2RodWJpK1drODJ1WmJUa05HQnBU?=
 =?utf-8?B?dkI5QUsreXNrdzlxTlhMcE9LTStYWWlTY0xqdm5RRzc1Qm9WUkp1WXpORnFu?=
 =?utf-8?B?RXVEOUg3L3BlaFVtajgxWnBQWkxlek5TRDRDZUhXcnNJZ2grN2NVbXR2b1ZL?=
 =?utf-8?B?bGdHWjlJM0lwQVFzUU5VdnN0cG5iREF1bWJHNFdGN0xIWjNoaklzMENQbkJa?=
 =?utf-8?B?YWV3cXlTdkhuanZMSmxBRjVmc3UraTFnQ0YwOXNDS1QzRVVibW94K2xHdjUw?=
 =?utf-8?B?L0cvbXpWbXh1VkRNOHhsZUQwUEVWTElla0dwZDk3ck02RDE5K2g4QUNCcEF1?=
 =?utf-8?B?RXNmaFdjWTB4ekpadDNHZ2MwVHc3cXRUYXdicENUdzZ2NzlvdHJkVE0za3pQ?=
 =?utf-8?B?d25yR0h0NmRxN0FjYkVvSUJrUUNUbFNLSU0rc1dBYmtJQ2wydWk3alZwRzF2?=
 =?utf-8?B?dW1yUnUrb2pZRzZaemMvYXNKa0NuNkhzb2dNQlZHdmg5a0dncTgxRzFaRGJu?=
 =?utf-8?B?ZkpqcmZJNzZ3L0QzclptZ3JhcW54WUM0THJVYW9ESmJsNDY3VmNMZG5sYlpO?=
 =?utf-8?B?Rm44bDgvT21vcjJDd3lTSStDNjJqU1Q4Y0hUVXRzenAwbEJGWE02aVlKNTlQ?=
 =?utf-8?B?QkJ5VENmZTdGVHBPQVpCdnFhS2tkQndoVHBkMFM0NVNTVmJaODZIeThSWW8x?=
 =?utf-8?B?Ykc1c2ZVNHN2K1NsV1lQU0hBditsRlhKOUwvbjAzSlU1RWVUaUdBRzJ1UUN5?=
 =?utf-8?B?ZG04YkhZbnFDRTYwWTc0T3BrMm9lMjFWL0RKZUxrdmcwUUF6ZWJOVkw1VVZo?=
 =?utf-8?B?cVFaRWRkcXJMd2dmbkc1R2xaR3NSRU1oMmRrazlXOUxqSHF3VVJzenpQeXZB?=
 =?utf-8?B?VVU0TzFob0kyaWMwbXhkS1I1anNCR0RzWjVsUjM1Mml4cWdsT3YzNjFNWFFR?=
 =?utf-8?B?TWloY0V6akVNRXUrZ1dOOWd1R29IR2hzSm1UNW9HUGR3SUhTalpYd21hZjBs?=
 =?utf-8?B?VUttT1ZMSDRaRUptVDBqaEhuaGs5UCtONDhMWGJ4aGZRZ3M2bSt1czYvTXpl?=
 =?utf-8?B?MHZRMnd5a3N6SHlSYTFodEtBYzlIZmw4UFFERGU4QVViZ1kzSCtweUlpMHo1?=
 =?utf-8?B?bitvODczZVRPV2pENDIrZFFQdXQvRGxpSFJUUlZaZnk0NC9nZGxOdVVxN21q?=
 =?utf-8?B?MnRSeW9ZOW9EVGp6WEdUU0x2RFRCTjNVQ1dYdFVpYzE1cXdWbDZ2czFDUzZa?=
 =?utf-8?B?cTYvc0NuWlk3WHVMZWJLWEhaQU9pTWpXb0RMVi91Uy95Y0dzV1VWWjhxK0gv?=
 =?utf-8?B?N1BYOVU2UFIyeEdlQUZ6NlpUZlBhSnF2Y0lKWDl3R2JOUGZON0NXZXFuN1RG?=
 =?utf-8?B?dEYwb0ZEUW5IRncvWStiSWhCWEtJUjJKSTRFSmljdXRhQkFzUmdkS2IvVkcz?=
 =?utf-8?B?clRvZjhBdDRoRG9OK0RRd0x5dnRXWUg2citNcTZMKzBEL0cwdlQ5cEVQY082?=
 =?utf-8?B?MVlYRzhQdjg1VUEvQ21yZk9TS2JZRFJwaWtuclczV0FBK3hySGhod1NLUWJu?=
 =?utf-8?B?bThMc1dRVnd0T29ERld1Ukp4M1NsY1FCeEtvOG1JWG82NWs5ekN2SVIybkpv?=
 =?utf-8?B?cjB6emNkbEtNNkMwZFk3VXllM01HL2czL2RKOFRCYjdUNVlOeTlqOXUyYms2?=
 =?utf-8?B?NjE0N25pUVFmVzdXV3dNVjhUTXdVUTY5SkxvZENTWTM4WFVHQWlKTHJnQTFw?=
 =?utf-8?B?VXp3VVplR3EwNVJXTDV6TCs5OW53bUVmWmlwY3FlVTRLMmFoV0ZhMUVkOW0x?=
 =?utf-8?Q?AlI4SHl8FcIm9N0HG/Fb6TdaE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D29D0CA655DC3D43A676DB16338CF218@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731abd41-0d53-4dc7-5136-08dd4c1053c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 09:25:16.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11i2JzLFwTLMN89U8+rKagEETVRZ3qk8blVgSeJGUU6iVg4ZebQ3oM3QjI+dAHMR1PWfreTodBasOHjw2NqOtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6596

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjM0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5
c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IA0KPiBVc2Ugc3lzY29uX3JlZ21hcF9sb29r
dXBfYnlfcGhhbmRsZV9hcmdzKCkgd2hpY2ggaXMgYSB3cmFwcGVyIG92ZXINCj4gc3lzY29uX3Jl
Z21hcF9sb29rdXBfYnlfcGhhbmRsZSgpIGNvbWJpbmVkIHdpdGggZ2V0dGluZyB0aGUgc3lzY29u
DQo+IGFyZ3VtZW50LiAgRXhjZXB0IHNpbXBsZXIgY29kZSB0aGlzIGFubm90YXRlcyB3aXRoaW4g
b25lIGxpbmUgdGhhdCBnaXZlbg0KPiBwaGFuZGxlIGhhcyBhcmd1bWVudHMsIHNvIGdyZXBwaW5n
IGZvciBjb2RlIHdvdWxkIGJlIGVhc2llci4NCj4gDQo+IFRoZXJlIGlzIGFsc28gbm8gcmVhbCBi
ZW5lZml0IGluIHByaW50aW5nIGVycm9ycyBvbiBtaXNzaW5nIHN5c2Nvbg0KPiBhcmd1bWVudCwg
YmVjYXVzZSB0aGlzIGlzIGRvbmUganVzdCB0b28gbGF0ZTogcnVudGltZSBjaGVjayBvbg0KPiBz
dGF0aWMvYnVpbGQtdGltZSBkYXRhLiAgRHRzY2hlbWEgYW5kIERldmljZXRyZWUgYmluZGluZ3Mg
b2ZmZXIgdGhlDQo+IHN0YXRpYy9idWlsZC10aW1lIGNoZWNrIGZvciB0aGlzIGFscmVhZHkuDQoN
ClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQpNYXliZSBJIHNob3Vs
ZCBhcHBseSB0aGlzIHZlcnNpb24gdG8gcHJldmVudCBmaXhpbmcgY29uZmxpY3QuDQoNClJlZ2Fy
ZHMsDQpDSw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5
c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFtBbmdlbG86IFJlYmFzZWQgb3ZlciBIRE1J
djIvRERDdjIgc2VyaWVzIGNsZWFudXBzXQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9jb21tb24uYyB8IDcg
KystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlf
Y29tbW9uLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfY29tbW9uLmMNCj4g
aW5kZXggNzUwYmNiNDVjMzNkLi5jOWJmNzA4NTMyOGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9jb21tb24uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2hkbWlfY29tbW9uLmMNCj4gQEAgLTI2OSwxMiArMjY5LDkgQEAgc3Rh
dGljIGludCBtdGtfaGRtaV9nZXRfY2VjX2RldihzdHJ1Y3QgbXRrX2hkbWkgKmhkbWksIHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWMNCj4gICAgICAgICAgKiBNTVNZU19DT05GSUcgZGV2aWNlIGFu
ZCB0aGUgcmVnaXN0ZXIgb2Zmc2V0IG9mIHRoZSBIRE1JX1NZU19DRkcNCj4gICAgICAgICAgKiBy
ZWdpc3RlcnMgaXQgY29udGFpbnMuDQo+ICAgICAgICAgICovDQo+IC0gICAgICAgaGRtaS0+c3lz
X3JlZ21hcCA9IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGUobnAsICJtZWRpYXRlayxz
eXNjb24taGRtaSIpOw0KPiArICAgICAgIGhkbWktPnN5c19yZWdtYXAgPSBzeXNjb25fcmVnbWFw
X2xvb2t1cF9ieV9waGFuZGxlX2FyZ3MobnAsICJtZWRpYXRlayxzeXNjb24taGRtaSIsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAxLCAmaGRtaS0+c3lzX29mZnNldCk7DQo+ICAgICAgICAgaWYgKElTX0VSUihoZG1pLT5z
eXNfcmVnbWFwKSkNCj4gLSAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGhkbWktPnN5c19y
ZWdtYXApOw0KPiAtDQo+IC0gICAgICAgcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzJfaW5kZXgo
bnAsICJtZWRpYXRlayxzeXNjb24taGRtaSIsIDEsICZoZG1pLT5zeXNfb2Zmc2V0KTsNCj4gLSAg
ICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2
LCByZXQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHRv
IGdldCBzeXN0ZW0gY29uZmlndXJhdGlvbiByZWdpc3RlcnNcbiIpOw0KPiANCj4gLS0NCj4gMi40
OC4xDQo+IA0KDQo=

