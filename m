Return-Path: <linux-kernel+bounces-525708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD488A3F380
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 879027AD5EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A9C209F33;
	Fri, 21 Feb 2025 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FFgrSjDG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hM/aszxv"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5781202F65;
	Fri, 21 Feb 2025 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138856; cv=fail; b=iG/oZNpSS/xfRopOaRZx7cR6ZiVZkqi1Hnrclbx2cQwkNZq6zhIulYM8Xo7pjCBQH1c37Wo310xmOEzkKr3eoSDJOrysG1vU9VpQcg68KHn684Wqac5zZC50W8y9rAydEpwma0ADr5Qsu+dYZnW+POYSvFmOmv6AmFtIovcEoXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138856; c=relaxed/simple;
	bh=N3oLoudb689L/aPJG1229QMuePG+dJyNSuCNc07dLi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W+l+YdjQ1TzA22Ppahv4EfN2wn/LVVO+At7HNQjYbV5C0uWqY1UERjl06qIn2Mv1q8+RSxbwyz5iXym8OgKi8hG/urZWgMLfrfYcKhl8UbCkALkjadKTllHpX302tkvPE81TyeMvTzJ+6LesLUDYHZWhWQArraxY6HfLRrZo08c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FFgrSjDG; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hM/aszxv; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8f49d750f04a11efaae1fd9735fae912-20250221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=N3oLoudb689L/aPJG1229QMuePG+dJyNSuCNc07dLi8=;
	b=FFgrSjDGXpXXfFdjAFsL9LNqaqr+cJYsgbQSh7jq1gRO/fF76k3tIbxAEZzOt4fcGLptQMP1ia96BXkp7OpSpEkp3YDsU8dieXPvB3apCS4pJwVwIWQvt8qNbcFjwD16qww+S99WivWnUXjMSoRVPOz8WrP2hMHnshuLekuDXmA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:9e1adb3b-301a-43ad-bf6a-943c58af6ea9,IP:0,U
	RL:0,TC:0,Content:10,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-META: VersionHash:60aa074,CLOUDID:8fb56ab5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|51,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8f49d750f04a11efaae1fd9735fae912-20250221
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <paul-pl.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1048788214; Fri, 21 Feb 2025 19:54:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 21 Feb 2025 19:54:08 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 21 Feb 2025 19:54:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRVW38zw7jF4JJf84+P9nm/zsJ/BmRDWESU9IRb71SqgpLsWDQRDtI+ylU/YM1sm2aYwRJ/23piWHrH9AB5FKjY3JPUI41nVQnGlgZm/jG5JsVHSWBk/9arhFe9+BDeitay+GHCsZqltiga5BFDY6QWjrd0MYCNSrJyjfxxFjvLL2uVkUOD3JuHv7l0+V8+w5dA28L7tT5meVx4HaWpJ4/5OtwcoqcleMB4wCudULmKHz8WxHd9sD2mfFR8CNxHeQt71GRwiLnPkEolzKIONgxatqlRismODMveUffKjKH+U4z2Ew+ER0l9AV/C5R/Fud2I/TItA6voVnI+NHK3fBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3oLoudb689L/aPJG1229QMuePG+dJyNSuCNc07dLi8=;
 b=pg1+734HtCFwiWA8QrQn8GWBQQwsPbXfYOYgD6699r4cSRlehtno7Jr0gLRZUJ2+fqlWfB9X6q3xJ5LB7w8VzLL2B+OpmHRZ2BtJaEVYFM8pbh0ynFnlA4cb2PTNT/gB/SlC0bt6v83O7tcvmYqW6TEJfSrbv5Ptl7sMl5HALNo9YuTH61QBOGdE4Gr1Cu37Rx3NoYRY+2YtOoM8W1OF6e1IdHM/DIlIYBtNXkJJC2g00XB3t6T5PMYUlnfDleLgpR8qEjnF2/jHEjVkoiE+cwkr41Tce60wR2Kdcg61jBiXmhmeq4I8TE82atEROqV9iWhvq84nR0SxLS5fU81b6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3oLoudb689L/aPJG1229QMuePG+dJyNSuCNc07dLi8=;
 b=hM/aszxvclo96T5isPlxhfsBEPNi0Ch1dWB/DMTX7pPS+FRM+bqIc47A9y4Ung3KY7JBRpHQzHPSi6dj2PbqQZnVA42/z+Ushb/GTNs1gDz08XRsyAQkHQ5jNuE7cxLvdpF7jYYeRdiArnZsgTJ5QNS/+RyWwCzlF43iWQM8p28=
Received: from SG2PR03MB6636.apcprd03.prod.outlook.com (2603:1096:4:1b8::6) by
 TYZPR03MB6955.apcprd03.prod.outlook.com (2603:1096:400:284::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Fri, 21 Feb 2025 11:54:05 +0000
Received: from SG2PR03MB6636.apcprd03.prod.outlook.com
 ([fe80::98e8:d61:f404:4052]) by SG2PR03MB6636.apcprd03.prod.outlook.com
 ([fe80::98e8:d61:f404:4052%3]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 11:54:05 +0000
From: =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"treapking@chromium.org" <treapking@chromium.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?WGlhbmRvbmcgV2FuZyAo546L5YWI5YasKQ==?=
	<Xiandong.Wang@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?=
	<Sirius.Wang@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 10/12] drm/mediatek: add OUTPROC support for MT8196
Thread-Topic: [PATCH 10/12] drm/mediatek: add OUTPROC support for MT8196
Thread-Index: AQHbY1yxYpS01duhJEKbBrPlMlwCjLNDQNIAgA6nEAA=
Date: Fri, 21 Feb 2025 11:54:05 +0000
Message-ID: <78f6d86ccad40442ff24946e2dabbbbb9862c535.camel@mediatek.com>
References: <20250110123835.2719824-1-paul-pl.chen@mediatek.com>
	 <20250110123835.2719824-12-paul-pl.chen@mediatek.com>
	 <1cc6bbb9559192e40aebc2eaa0e55e1b3219c6b7.camel@mediatek.com>
In-Reply-To: <1cc6bbb9559192e40aebc2eaa0e55e1b3219c6b7.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6636:EE_|TYZPR03MB6955:EE_
x-ms-office365-filtering-correlation-id: df798ddb-667a-4044-dcee-08dd526e70f4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?djB6bUNUTXF1RXYxUEJHRTIwSlNCSGVxUWxsZGtTaGF5REExR2FEUTRMeHht?=
 =?utf-8?B?VFNEMitINEhvTElrSHY3ckIvM2hQOXdXd0FLWk50eFJlUHVSSnhmVTFZdVcz?=
 =?utf-8?B?elRaRGpGb2tGMTVnaEsxcUJqRkluUTRLbWg2RlpyYndyMlZLbElsTzJYbVln?=
 =?utf-8?B?YmRUdWExeWpmZjJFbG16NklYV2tUcVVjeTFvMnorQnp3NEFPbFRYSTBXQVZZ?=
 =?utf-8?B?SUFMQktOTGVuNzlaYXF3YVBwKytEZ05ZbmN6TGN2OHJFTEl4TEpuQm1jbW9s?=
 =?utf-8?B?RFdNRXdGeTU4SXhqNjYxNmV2elpZbTdDUkhMb1pGMkJxUnFhT0JEMGtQd2lP?=
 =?utf-8?B?bjl1NkJVWWxHNS9hYmhvSGdSem1vbmtpeUZ4dTQyZllFYk1rMTNLamZYRnF5?=
 =?utf-8?B?dHdGenVPb0IvRG90dWlNMmU4cWhQc2NoTG14S2FGVlMzTHRUR09tbXh0dUNO?=
 =?utf-8?B?Q05sdjZZZDdlNnlVV0UvNjdlREtmL0ZVcnVEVHNOQU1Ld296WVkzZGg2UE5s?=
 =?utf-8?B?NklrOTNuWDdleDh0Y2l1SExRT1kvQlhwR3VHd2hsT1NRRUFLWUF3cjBWVk9R?=
 =?utf-8?B?V240cFdaTmphTWtIenpiT21EVW54VXE3eEZ1R1ErYkh2am1KckIvS0NzL2pq?=
 =?utf-8?B?SkFicm1TaFpsTDFaZk5yQnl6YlZ0TUhBMGE2WU5KNHFFbklEbElNTWtVdUtp?=
 =?utf-8?B?dVIxK1RoZUZHZDlpUTlKZ2J3YWdvejgranAvWE5nS3U4MVRmRkhPSzNaZWFq?=
 =?utf-8?B?dmYwSVdvRE96LzlUamFlYno2dWpWY1VNV2k3VEdFZ2pjUm1tR3N3a09JNzlT?=
 =?utf-8?B?dGQyaUdHZzNEaHp0RmZDNnkvWGs0RG5PVVowS1JRWUdXekZMcFNacGNIOTNP?=
 =?utf-8?B?dlhramZvTGlJTENRa2ZoQjA0Zkw3SU0xVDVHeERrZVZSQVU5TkdHSVBOWm8v?=
 =?utf-8?B?NmRhQmJnZFRqcUZBMSsrSkd2TmtmUVFGWGVmcGc1aXNrRlBHaFRlZERNTjJk?=
 =?utf-8?B?SjdING40R1BDS0I3U2JsdGxFdlJuWWk0WlhTUlpUNUJtV01hakIwQ3RHNE4y?=
 =?utf-8?B?bnFVbHcvc1FmOTBaMDlFeDNmUTBYT2pTRmlaUXliUFd3MXIzbkJCNVdjVDMz?=
 =?utf-8?B?QzZzRGZmWWE5dXlpa0xsekM5YTJOeHpSTDBmMmttb0lsUHUwcUhrOW1nVTQ5?=
 =?utf-8?B?WGhRRjN6RFg4NTdjU0phSWhLMFBEZjVWUnJqVFFsa0IvRWt2bGlzdE5qbm1W?=
 =?utf-8?B?UHkwcmhrZVZoM3pZQ3hDME90UVZ6aDR2aWREUzA0VThWR0IrRlNNay9lcTY2?=
 =?utf-8?B?d3JxcGdBRUdJS2RVeWdXcWZ5cGd0aG5BOE1iZTJUMGRpQU1Ca3lLWjk2WTVR?=
 =?utf-8?B?cXZGa0Q0Rjg1V3FvK3pRV3NnaW1zUTQzNEZQRFljdEFZdWVIeHRwOWhaaDE3?=
 =?utf-8?B?ekRGdmt3clFoRlJxVWprbXVHOTJDSUU3ZGI5U0tOVEFKUHdBcUZqcXpaYyth?=
 =?utf-8?B?RWZ2UmV0V0FsQ3ZFUnBNQmVBWjV3NUxoVGJyVTNodUw2UU9aOGRtZ0hEaTFK?=
 =?utf-8?B?cGUwT2hZcmk0WlN6TVhjL3pzenE5aWZGNU8zUmd5dGpyR2lTQzRTYWpnRWl2?=
 =?utf-8?B?QXVnTlF0ekVUdUMwQ0NXcmcrZkdNK1FMaE9XdkVLVlVWNkJZV243TGQ5amM5?=
 =?utf-8?B?WW5aTFhTNlJQL2tEdEl6SUx1dm54bGZVQkQwazhRcTFmOVJkVHU2cXh3ZmNR?=
 =?utf-8?B?ZkliRHZ5dTNmZW9SVU8wVWtRWlIvZ0l5NWJVdUxRMXlOempQRHFVTm9ORENN?=
 =?utf-8?B?WmJ5NjdzcnNiTE1mVlBWaWJyZXo4d2lMYkRjQjEyakhCRmJIc0k4QmtrN0Rm?=
 =?utf-8?B?d09uNllwS1dsRWQrc1Z2VHN4UkFEWHVwd2tLYjdXWDNBZUZjeG1FSFVOWm9M?=
 =?utf-8?Q?i9fHP75W/I/VOSlj9RxdQ0mfngSQ4fF6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6636.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWd2NTVkVVpkZE93eUtkRURMQjlKOW1QWWhBOWw5MklDZWFxTURyUllEQ0hU?=
 =?utf-8?B?bEYrVnRmblpvRU84ZDFDbVVXbitFVG5sMm8wSE5HNGdiRGw5MTRlUndTWGQw?=
 =?utf-8?B?eVlrSTUzVWM3WERDa25jc1FHSjlpTnNwQTZFcWdsZlFFRlNudXU5ZmlDR2Rz?=
 =?utf-8?B?V1J2eTVoSGFrVWk1OStReEtTQjdaekJUbWVFZitBOEdCNldRSDdqWENSUFBi?=
 =?utf-8?B?cmpWMTlIM0piK0VUeUhVMFpNMERCM21jWHlQbEJtWS82c3VjeU1wVEJ0ZGNW?=
 =?utf-8?B?Vi9tTTEzY0IremVNUkx2WXBPV2hNWkFscHFGUlVENHllR2plaldobUg0UlN3?=
 =?utf-8?B?SG5Fd1dsN1lneDRUSkEwb0tlT295ZlV1d2ZDdUlDMHFGYUtESEpaQ0VoM0ty?=
 =?utf-8?B?a1oxRWo5WEFPY2VrNDIwTWdaSGpkSFNGMkpORTlpdlFQTXZ3NVVGR1kvNFZD?=
 =?utf-8?B?V1dPNVZiQVhybUFIMkdEN3QyWERmcitLcHRXcHREMUpJNHBKSzJtZFhZalNk?=
 =?utf-8?B?TG85UDRtN0hHL1dFSEhlMXVOS2FHSFkrRUlHRjI0cUxZMlZLWVJMQkVIa1Bn?=
 =?utf-8?B?OFMycklERWF6ZWxCa2tLZUtYTVNvWm5DcklkRUFXQkNhTHlzcFQrTmt6Z3V6?=
 =?utf-8?B?VEJxOWJTczZDVHc0R0xnalZsOVlRRVlva2tlUW03dWZsOWFqVVhrQVVibHcx?=
 =?utf-8?B?dWEra05iL0tmVFo2MzJHUGF0eHI3K3lHZklQbm80QXRPT1ZzRUlLaVZyNjdt?=
 =?utf-8?B?RGsxUHJtWk1LaEFMUzVoQ2Vva0ppc08vWC9KUXBQeWM2Q0lzMGZZRTd0MDdz?=
 =?utf-8?B?dmUvL1V2bmtNN0gxcXBTdjhPNFI3V1IrNVcwUkJGam5kOHFEL25tckNXaStE?=
 =?utf-8?B?TlVSLzN5OWRvT3F3ZncrYVgyYWxwbElta1duQTRQMVAyTkhCejB6WVBwQ1Zq?=
 =?utf-8?B?VEhVWSsxSXplK3o5YUtzNmRIQnU0dVB5Sy9WVVZPeHZOM0wrQlBJaytXNURM?=
 =?utf-8?B?SzZrREJlY0hhbVVvOHBucVo0TS9Ddmk1QnI2ci84TnBvenpDT2FEZ1hxYXZm?=
 =?utf-8?B?aWJpVlREeUdBWmNzczlVOW5CMzUvbUZhRk5pYnRjSGdNaDdZekVjRXRKMWx6?=
 =?utf-8?B?KzU0K091bmdJYVZINEhEK0FMUDhtUmhTN0hybFd2c1NlcGQ4bnNCY0tRYWJn?=
 =?utf-8?B?OUZueHY2MjJXYkQ1NmgvUm9vWjhOMGZqMlNxZ09IZTNnaVlrVWZnc1N3N2hO?=
 =?utf-8?B?dmpKR3Fkem5DK3grdHpnQURsVlFETkZtU2hVME03Z3grOHFhTU1iRktkbjU1?=
 =?utf-8?B?OUM5WFh2dnBJdS9Lek5ZaFdkd1RZSm40emNUdEcyZFphazZnT1lrV1M2YnpT?=
 =?utf-8?B?Qy9NcE9hZDVhWmp6d3NKYmtMVnpNZHN3YXN1RDJVWlp2aXpqLzNjamtZZVBO?=
 =?utf-8?B?eDVnTXVqZGw0ckpWVzFHOHpldmpkUVpUMEpLOVk1cDBiWFNadC9Cd2ptUUxQ?=
 =?utf-8?B?TlQ3V29xaVR5YjFYUlptdER2TFJ4VE1lczlMa2s2YVZHNzlzTmRPNnZMZmow?=
 =?utf-8?B?RXBXd1F5TXJkbzk2b0prMExEV2crY2tkc2UvNnpKWjgwWlJrWVJKblE5N0I2?=
 =?utf-8?B?UjhaUGZLS3Q5eFJuNy9mUnZvRVdjWUhpYXo4aHpEc3pDU2p2TEhjM3hSMlFk?=
 =?utf-8?B?elFpampydnJSaXpyNGxXZGZZT0JQYVdNTnduS1NJYzh0T1JrMjRPd1o5V2c2?=
 =?utf-8?B?TXRqWkF0M0pSdWR3akczUHJ5dUdZcUJqTjVXYnUrd1BkS0puMmhyR29qRHdy?=
 =?utf-8?B?RmVBSkdTSHhuMFRuSDFteTRLMzR4TWxkZmZrTnVrd1NJSnRxV05kQTBEanBh?=
 =?utf-8?B?aU5vbGJ3T0JZTU5zcFlmOCtlR2l1WitUU1ROTXNselVGV1FzR0YyTWIwOU1n?=
 =?utf-8?B?VHpWYnZaeDFpZmRIT0VsWmVxRUlnZVY4cXBodlV0ZkdjejdnN1BpOG53RHg4?=
 =?utf-8?B?R2lzUUp6RVVzZmk2TnN2Mk93ZnBuR3ZOOFVaMmtVei9YRmJpZFlDQ3hLS2pj?=
 =?utf-8?B?WlMzQldnSWRIdDh5VnREZlRSUGlCeUNUM3g5dExIdVU2MGpMYWVZVER4R0NC?=
 =?utf-8?B?Y3ZIcnJ4ZVFmSWg3Yk5kL1BrNFg0M0pGSTgvRERrUTZ3dGtwSjJYNFdBNDZr?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91205F541D4D4A41820839BDDFAD610A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6636.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df798ddb-667a-4044-dcee-08dd526e70f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 11:54:05.0925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qIdAsi0sanZwdVN2uZY2DzSN+BapxsPLaelpNaUff4wXnEBOXzpHyF8lmuMNErR7qcoZ0liK7rluqgiWIBQWbJb3XGpAYGLopznUIRfdk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6955

T24gV2VkLCAyMDI1LTAyLTEyIGF0IDA0OjA4ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIFBhdWw6DQo+IA0KPiBPbiBGcmksIDIwMjUtMDEtMTAgYXQgMjA6MzQgKzA4MDAs
IHBhdWwtcGwuY2hlbiB3cm90ZToNCj4gPiBGcm9tOiAiTmFuY3kuTGluIiA8bmFuY3kubGluQG1l
ZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBPVVRQUk9DIGhhbmRsZXMgdGhlIHBvc3Qtc3RhZ2Ugb2Yg
cGl4ZWwgcHJvY2Vzc2luZyBpbg0KPiA+IHRoZSBvdmVybGFwcGluZyBwcm9jZWR1cmUuT1VUUFJP
QyBtYW5hZ2VzIHBpeGVscyBmb3INCj4gPiBnYW1tYSBjb3JyZWN0aW9uIGFuZCBlbnN1cmVzIHRo
YXQgcGl4ZWwgdmFsdWVzIGFyZQ0KPiA+IHdpdGhpbiB0aGUgY29ycmVjdCByYW5nZS4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW5jeS5MaW4gPG5hbmN5LmxpbkBtZWRpYXRlay5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUGF1bC1wbC5DaGVuIDxwYXVsLXBsLmNoZW5AbWVkaWF0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4gwqBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RkcF9jb21wLmPCoMKgwqDCoCB8wqDCoCAxICsNCj4gPiDCoGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGRwX2NvbXAuaMKgwqDCoMKgIHzCoMKgIDEgKw0KPiA+IMKgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5owqDCoMKgwqAgfMKgIDE0ICsrDQo+ID4gwqBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3V0cHJvYy5jIHwgMjQ0DQo+ID4gKysr
KysrKysrKysrKysrKysrKysNCj4gPiDCoGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9vdXRwcm9jLmggfMKgIDIyICsrDQo+ID4gwqBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9kcnYuY8KgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4gwqBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kcnYuaMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4gwqA4IGZpbGVzIGNo
YW5nZWQsIDI4NSBpbnNlcnRpb25zKCspDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX291dHByb2MuYw0KPiA+IMKgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdXRwcm9jLmgNCj4gPiAN
Cj4gPiANCi8vc25pcA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3Bfb3V0cHJvYy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3V0cHJvYy5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAw
MDAwMDAuLmFmNDczZWIyZmI3Nw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3V0cHJvYy5jDQo+ID4gQEAgLTAsMCArMSwyNDQg
QEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiA+ICsv
Kg0KPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjEgTWVkaWFUZWsgSW5jLg0KPiA+ICsgKi8NCj4g
PiArDQo+ID4gKyNpbmNsdWRlIDxkcm0vZHJtX2ZvdXJjYy5oPg0KPiA+ICsjaW5jbHVkZSA8ZHJt
L2RybV9mcmFtZWJ1ZmZlci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9jb21wb25lbnQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2Rldmlj
ZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0K
PiA+ICsjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmg+DQo+ID4gKyNpbmNs
dWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmg+DQo+ID4gKw0KPiA+ICsjaW5jbHVk
ZSAibXRrX2NydGMuaCINCj4gPiArI2luY2x1ZGUgIm10a19kZHBfY29tcC5oIg0KPiA+ICsjaW5j
bHVkZSA8bGludXgvb2YuaD4NCj4gPiArI2luY2x1ZGUgIm10a19kcm1fZHJ2LmgiDQo+ID4gKyNp
bmNsdWRlICJtdGtfZGlzcF9vdXRwcm9jLmgiDQo+ID4gKw0KPiA+ICsjZGVmaW5lDQo+ID4gRElT
UF9SRUdfT1ZMX09VVFBST0NfSU5URU4JCQkJMHgwMDQNCj4gPiArI2RlZmluZQ0KPiA+IE9WTF9P
VVRQUk9DX0ZNRV9DUExfSU5URU4JCQkJCUJJVCgxKQ0KPiA+ICsjZGVmaW5lDQo+ID4gRElTUF9S
RUdfT1ZMX09VVFBST0NfSU5UU1RBCQkJCTB4MDA4DQo+ID4gKyNkZWZpbmUNCj4gPiBESVNQX1JF
R19PVkxfT1VUUFJPQ19EQVRBUEFUSF9DT04JCQkweDAxMA0KPiA+ICsjZGVmaW5lDQo+ID4gREFU
QVBBVEhfQ09OX09VVFBVVF9DTEFNUAkJCQkJQklUKDI2KQ0KPiA+ICsNCj4gPiArI2RlZmluZQ0K
PiA+IERJU1BfUkVHX09WTF9PVVRQUk9DX0VOCQkJCQkweDAyMA0KPiA+ICsjZGVmaW5lDQo+ID4g
T1ZMX09VVFBST0NfT1ZMX0VOCQkJCQkJQklUKDApDQo+ID4gKyNkZWZpbmUNCj4gPiBESVNQX1JF
R19PVkxfT1VUUFJPQ19SU1QJCQkJMHgwMjQNCj4gPiArI2RlZmluZQ0KPiA+IE9WTF9PVVRQUk9D
X1JTVAkJCQkJCQlCSVQoMCkNCj4gPiArI2RlZmluZQ0KPiA+IERJU1BfUkVHX09WTF9PVVRQUk9D
X1NIQURPV19DVFJMCQkJMHgwMjgNCj4gPiArI2RlZmluZQ0KPiA+IE9WTF9PVVRQUk9DX0JZUEFT
U19TSEFET1cJCQkJCUJJVCgyKQ0KPiA+ICsjZGVmaW5lDQo+ID4gRElTUF9SRUdfT1ZMX09VVFBS
T0NfUk9JX1NJWkUJCQkJMHgwMzANCj4gPiArDQo+ID4gK3N0cnVjdCBtdGtfZGlzcF9vdXRwcm9j
IHsNCj4gPiArCXZvaWQgX19pb21lbQkJKnJlZ3M7DQo+ID4gKwlzdHJ1Y3QgY2xrCQkqY2xrOw0K
PiA+ICsJdm9pZAkJCSgqdmJsYW5rX2NiKSh2b2lkICpkYXRhKTsNCj4gPiArCXZvaWQJCQkqdmJs
YW5rX2NiX2RhdGE7DQo+ID4gKwlpbnQJCQlpcnE7DQo+ID4gKwlzdHJ1Y3QgY21kcV9jbGllbnRf
cmVnCWNtZHFfcmVnOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArdm9pZCBtdGtfZGlzcF9vdXRwcm9j
X3JlZ2lzdGVyX3ZibGFua19jYihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gKwkJCQkJIHZvaWQg
KCp2YmxhbmtfY2IpKHZvaWQNCj4gPiAqKSwNCj4gPiArCQkJCQkgdm9pZCAqdmJsYW5rX2NiX2Rh
dGEpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBtdGtfZGlzcF9vdXRwcm9jICpwcml2ID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7DQo+ID4gKw0KPiA+ICsJcHJpdi0+dmJsYW5rX2NiID0gdmJsYW5rX2Ni
Ow0KPiA+ICsJcHJpdi0+dmJsYW5rX2NiX2RhdGEgPSB2YmxhbmtfY2JfZGF0YTsNCj4gPiArfQ0K
PiA+ICsNCj4gPiArdm9pZCBtdGtfZGlzcF9vdXRwcm9jX3VucmVnaXN0ZXJfdmJsYW5rX2NiKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJc3RydWN0IG10a19kaXNwX291dHByb2Mg
KnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiArDQo+ID4gKwlwcml2LT52Ymxhbmtf
Y2IgPSBOVUxMOw0KPiA+ICsJcHJpdi0+dmJsYW5rX2NiX2RhdGEgPSBOVUxMOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICt2b2lkIG10a19kaXNwX291dHByb2NfZW5hYmxlX3ZibGFuayhzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBtdGtfZGlzcF9vdXRwcm9jICpwcml2ID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKw0KPiA+ICsJd3JpdGVsKE9WTF9PVVRQUk9DX0ZN
RV9DUExfSU5URU4sIHByaXYtPnJlZ3MgKw0KPiA+IERJU1BfUkVHX09WTF9PVVRQUk9DX0lOVEVO
KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArdm9pZCBtdGtfZGlzcF9vdXRwcm9jX2Rpc2FibGVfdmJs
YW5rKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJc3RydWN0IG10a19kaXNwX291
dHByb2MgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiArDQo+ID4gKwl3cml0ZWwo
MHgwLCBwcml2LT5yZWdzICsgRElTUF9SRUdfT1ZMX09VVFBST0NfSU5URU4pOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX2Rpc3Bfb3V0cHJvY19pcnFfaGFuZGxl
cihpbnQgaXJxLCB2b2lkDQo+ID4gKmRldl9pZCkNCj4gPiArew0KPiA+ICsJc3RydWN0IG10a19k
aXNwX291dHByb2MgKnByaXYgPSBkZXZfaWQ7DQo+ID4gKw0KPiA+ICsJd3JpdGVsKDB4MCwgcHJp
di0+cmVncyArIERJU1BfUkVHX09WTF9PVVRQUk9DX0lOVFNUQSk7DQo+ID4gKw0KPiA+ICsJaWYg
KCFwcml2LT52YmxhbmtfY2IpDQo+ID4gKwkJcmV0dXJuIElSUV9OT05FOw0KPiA+ICsNCj4gPiAr
CXByaXYtPnZibGFua19jYihwcml2LT52YmxhbmtfY2JfZGF0YSk7DQo+ID4gKw0KPiA+ICsJcmV0
dXJuIElSUV9IQU5ETEVEOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICt2b2lkIG10a19kaXNwX291dHBy
b2NfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ID4gKwkJCcKg
wqDCoMKgIHVuc2lnbmVkIGludCBoLCB1bnNpZ25lZCBpbnQNCj4gPiB2cmVmcmVzaCwNCj4gPiAr
CQkJwqDCoMKgwqAgdW5zaWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0DQo+ID4gKmNtZHFf
cGt0KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbXRrX2Rpc3Bfb3V0cHJvYyAqcHJpdiA9IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsJdW5zaWduZWQgaW50IHRtcDsNCj4gPiArDQo+ID4gKwlk
ZXZfZGJnKGRldiwgIiVzLXc6JWQsIGg6JWRcbiIsIF9fZnVuY19fLCB3LCBoKTsNCj4gPiArDQo+
ID4gKwl0bXAgPSByZWFkbChwcml2LT5yZWdzICsNCj4gPiBESVNQX1JFR19PVkxfT1VUUFJPQ19T
SEFET1dfQ1RSTCk7DQo+ID4gKwl0bXAgPSB0bXAgfCBPVkxfT1VUUFJPQ19CWVBBU1NfU0hBRE9X
Ow0KPiA+ICsJd3JpdGVsKHRtcCwgcHJpdi0+cmVncyArDQo+ID4gRElTUF9SRUdfT1ZMX09VVFBS
T0NfU0hBRE9XX0NUUkwpOw0KPiANCj4gTW92ZSBieXBhc3Mgc2hhZG93IHRvIG10a19kaXNwX291
dHByb2Nfc3RhcnQoKS4NCj4gDQoNClN1cmUsIHdlIHdpbGwgbW92ZSB0aGUgYnlwYXNzIHNoYWRv
dyB0byBtdGtfZGlzcF9vdXRwcm9jX3N0YXJ0KCkuDQo+ID4gKw0KPiA+ICsJbXRrX2RkcF93cml0
ZV9tYXNrKGNtZHFfcGt0LCBoIDw8IDE2IHwgdywgJnByaXYtPmNtZHFfcmVnLA0KPiA+IHByaXYt
PnJlZ3MsDQo+ID4gKwkJCcKgwqAgRElTUF9SRUdfT1ZMX09VVFBST0NfUk9JX1NJWkUsIH4wKTsN
Cj4gDQo+IG10a19kZHBfd3JpdGUoKTsNCj4gDQo+ID4gKwltdGtfZGRwX3dyaXRlX21hc2soY21k
cV9wa3QsIERBVEFQQVRIX0NPTl9PVVRQVVRfQ0xBTVAsDQo+ID4gJnByaXYtPmNtZHFfcmVnLCBw
cml2LT5yZWdzLA0KPiA+ICsJCQnCoMKgIERJU1BfUkVHX09WTF9PVVRQUk9DX0RBVEFQQVRIX0NP
TiwNCj4gPiBEQVRBUEFUSF9DT05fT1VUUFVUX0NMQU1QKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
dm9pZCBtdGtfZGlzcF9vdXRwcm9jX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiArew0K
PiA+ICsJc3RydWN0IG10a19kaXNwX291dHByb2MgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4gPiArDQo+ID4gKwltdGtfZGRwX3dyaXRlX21hc2soTlVMTCwgT1ZMX09VVFBST0NfUlNU
LCAmcHJpdi0+Y21kcV9yZWcsDQo+ID4gcHJpdi0+cmVncywNCj4gPiArCQkJwqDCoCBESVNQX1JF
R19PVkxfT1VUUFJPQ19SU1QsDQo+ID4gT1ZMX09VVFBST0NfUlNUKTsNCj4gDQo+IHdyaXRlbCgp
Ow0KPiANCg0KU3VyZSwgSSB3aWxsIHVzZSB0aGUgd3JpdGVsKCkgdG8gcmVwbGFjZSB0aGUgbXRr
X2RkcF93cml0ZV9tYXNrKCkuDQo+ID4gKwltdGtfZGRwX3dyaXRlX21hc2soTlVMTCwgMCwgJnBy
aXYtPmNtZHFfcmVnLCBwcml2LT5yZWdzLA0KPiA+ICsJCQnCoMKgIERJU1BfUkVHX09WTF9PVVRQ
Uk9DX1JTVCwNCj4gPiBPVkxfT1VUUFJPQ19SU1QpOw0KPiANCj4gU29tZSBoYXJkd2FyZSByZXNl
dCBiZWZvcmUgc3RhcnQuDQo+IFNvbWUgaGFyZHdhcmUgcmVzZXQgYWZ0ZXIgc3RvcC4NCj4gDQo+
IENvdWxkIGFsaWduIHRoaXM/DQo+IA0KU3VyZSwgd2Ugd2lsbCBhbGlnbiB0aGlzIHBhcnQuDQo+
ID4gKwltdGtfZGRwX3dyaXRlKE5VTEwsIDAsICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywN
Cj4gPiArCQnCoMKgwqDCoMKgIERJU1BfUkVHX09WTF9PVVRQUk9DX0lOVFNUQSk7DQo+ID4gKwlt
dGtfZGRwX3dyaXRlX21hc2soTlVMTCwgT1ZMX09VVFBST0NfT1ZMX0VOLCAmcHJpdi0NCj4gPiA+
Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+ID4gKwkJCcKgwqAgRElTUF9SRUdfT1ZMX09VVFBST0Nf
RU4sDQo+ID4gT1ZMX09VVFBST0NfT1ZMX0VOKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArdm9pZCBt
dGtfZGlzcF9vdXRwcm9jX3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3QgbXRrX2Rpc3Bfb3V0cHJvYyAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+
ICsNCj4gPiArCW10a19kZHBfd3JpdGUoTlVMTCwgMCwgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5y
ZWdzLA0KPiA+ICsJCcKgwqDCoMKgwqAgRElTUF9SRUdfT1ZMX09VVFBST0NfSU5URU4pOw0KPiAN
Cj4gT1ZMIGRyaXZlciBkb2VzIG5vdCBkaXNhYmxlIGludGVycnVwdCB3aGVuIHN0b3AuDQo+IEFs
aWduIHRoaXMgd2l0aCBPVkwgZHJpdmVyLg0KPiANClN1cmUgSSB3aWxsIGNoZWNrIHRoZSBkcml2
ZXIgYW5kIGFsaWduIHRoaXMgcGFydC4NCg0KPiANCi8vc25pcA0KPiA+ICsjaWYgSVNfUkVBQ0hB
QkxFKENPTkZJR19NVEtfQ01EUSkNCj4gPiArCXJldCA9IGNtZHFfZGV2X2dldF9jbGllbnRfcmVn
KGRldiwgJnByaXYtPmNtZHFfcmVnLCAwKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJZGV2X2Ri
ZyhkZXYsICJObyBtZWRpYXRlayxnY2UtY2xpZW50LXJlZ1xuIik7DQo+ID4gKyNlbmRpZg0KPiA+
ICsNCj4gPiArCWlmIChvZl9wcm9wZXJ0eV9yZWFkX3UzMl9pbmRleChkZXYtPm9mX25vZGUsICJp
bnRlcnJ1cHRzIiwNCj4gPiAwLCAmcmV0KSkgew0KPiA+ICsJCWRldl9kYmcoZGV2LCAiaW50ZXJy
dXB0cyBub3QgZGVmaW5lZFxuIik7DQo+IA0KPiBJbiBiaW5kaW5nIGRvY3VtZW50LCBpbnRlcnJ1
cHQgaXMgcmVxdWlyZWQuDQo+IFNvIHJldHVybiB3aXRoIGVycm9yIGNvZGUuDQo+IA0KVGhlIGlu
dGVycnVwdCBpcyBub3QgcmVxdWlyZWQsIEkgaGF2ZSByZXdyaXRlIHRoZSBiaW5kaW5nIGRvY3Vt
ZW50LiANCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJcHJpdi0+aXJxID0gcGxhdGZvcm1fZ2V0X2ly
cShwZGV2LCAwKTsNCj4gPiArCQlpZiAocHJpdi0+aXJxIDwgMCkNCj4gPiArCQkJcHJpdi0+aXJx
ID0gMDsNCj4gDQo+IEluIGJpbmRpbmcgZG9jdW1lbnQsIGludGVycnVwdCBpcyByZXF1aXJlZC4N
Cj4gU28gcmV0dXJuIHdpdGggZXJyb3IgY29kZS4NCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0K
VGhlIGludGVycnVwdCBpcyBub3QgcmVxdWlyZWQsIEkgaGF2ZSByZXdyaXRlIHRoZSBiaW5kaW5n
IGRvY3VtZW50LiANClRoZSBuZXh0IHVwc3RyZWFtIHZlcnNpb24gb2YgcGF0Y2ggd291bGQgZml4
IHRoaXMgcHJvYmxlbQ0KDQoNCkJlc3QsIA0KDQpQYXVsDQo+IA0K

