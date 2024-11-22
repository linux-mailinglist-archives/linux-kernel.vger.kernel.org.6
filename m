Return-Path: <linux-kernel+bounces-417747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DC09D58B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2D2B229EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FA3156F3F;
	Fri, 22 Nov 2024 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="g/hxpAdb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qO25N0hg"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5CF2582;
	Fri, 22 Nov 2024 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732247681; cv=fail; b=hOXqIuJvXnjrGA04TkrW/9wZl000D/XRAvEb6SY6KwFokyheigt+e53tbPkCxYwwUvcAI5Y7U/+apHjutvJemM5RdWfemS++td0keAOvL4ymJ56K34Sb8PWmDYT7DAvx18Wd7NacROoB1osEVtHHzVNRHmUl1KTJ+M5ghAukwPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732247681; c=relaxed/simple;
	bh=4vnEGlT+DiQsH86nefUcLwmLVhLlEsXOxnddmNOHfv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CAhJxudAs6YIv+AvBbPdma+8GTettUqAlLDRHnFCPYXP+GsIN80AJt4oyG/UDELD273tezEG8Aadq0uoo2huSCaK5bkqDTHdQFhlkPtS9XwOjONjkoGwoYErRBMH+AENqAk4GhVclNPKjhYI2oDdyukLDq6PXUIx4G2wPCY0h+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=g/hxpAdb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qO25N0hg; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7b1e2784a88511ef99858b75a2457dd9-20241122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4vnEGlT+DiQsH86nefUcLwmLVhLlEsXOxnddmNOHfv0=;
	b=g/hxpAdbI98gG3ElaGS4uYvAS/Jnv/kfz/JtHjxrhYZLpn8Hhy2ds6Sg+X8Hmg7hqij+7wLN5eYVINHa17fiDyh2s+sEzHgebuSJ1po1Jb3Zq6KCQ4yZ/SD2gwjvHjzYZ05MNXqy6wmS91osgSN8wXlN86WrXp6POhTA7iSyBs8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:262992a9-c535-4045-83e3-bdd97537734b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:bb869ea0-f395-4dfc-8188-ce2682df7fd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7b1e2784a88511ef99858b75a2457dd9-20241122
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 243504993; Fri, 22 Nov 2024 11:54:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Nov 2024 11:54:29 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Nov 2024 11:54:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzoJJeayoci32IWpNkYpjUBHwD4S/hZ2rHLFQk4FNfn+TMwvsC7bCV7BIPbrPSEOW61ghaHwUrcoBqT3Z5+wXRSYB1eI72fzRDGiseh7+wBALGmonFr6AL7CDpfx11GR8ivsj2/J2uRptXvelDeV8q97ybQzo372W6SevI1+p+IydTQtSn4o1MqrSeV2JE717jX0JC5SQwwnBDRlgZHs0j944CxJNTIjV27zVn4q3FFdpsQRaI7SKrBmQiDIgcL3lxXTq/djIvA981ZIKdxX8Qi+mRvlA/FfXOMk776cyjjCvQRy46itszhSMHGIXyP9eeo9AGxpAb8w16SY0uCcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vnEGlT+DiQsH86nefUcLwmLVhLlEsXOxnddmNOHfv0=;
 b=hYL95nGLzhu6ovLmIXJl+fgCeVgxCHqNRLiHEnDlCcCEYEBXOXkfvbfbIAORyBnKQzI3R7C6wPIv/UkvmUOgl9ANflhxdSyY6jnDII+BQzFul7JMkRB4BEIdsd0zYlBDOBR0hsT07tNUmfBnoWZ5tf5woD1au8WNVTNT2AxYHtbztTdeccM18Os5YN2J5cGighWQkm02qXtyzhmXyWSGWwajnVSB97zztEuDGsYKG0szMc66clFX+W2WMlhFCCUhCYOiOncQOQbLVHjTlNk/ml6GJkVPWQwPzBbENBt/Yrnq9ROZ5ACHH6oNC9wUA6FAv8cCi+l6dFypBUIZrA70Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vnEGlT+DiQsH86nefUcLwmLVhLlEsXOxnddmNOHfv0=;
 b=qO25N0hgyZkIM24gu8qOVQWaVqMacfGOgbxlwt0opPrawYQx1LBt4aMFnza63hsvL0AeSsK+fDqzMuYz4T0VjWomTFoNtiMcxk7eoyfOZOJE6dTDnZEMzYhQAkvSOx87/xm3MkQvI1VthachJWIcZC/frSgWyyVMPYeyzYBizhs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB7185.apcprd03.prod.outlook.com (2603:1096:301:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Fri, 22 Nov
 2024 03:54:25 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8158.017; Fri, 22 Nov 2024
 03:54:25 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"kernel@collabora.com" <kernel@collabora.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 3/6] drm/mediatek: mtk_dpi: Use an array for pixclk
 factor calculation
Thread-Topic: [PATCH v1 3/6] drm/mediatek: mtk_dpi: Use an array for pixclk
 factor calculation
Thread-Index: AQHbO0ovL6/Z3MShYU+XiLxJngQ4cbLCrdsA
Date: Fri, 22 Nov 2024 03:54:24 +0000
Message-ID: <6e07043e70111920848cc3d22e5c60371c0fb65d.camel@mediatek.com>
References: <20241120124420.133914-1-angelogioacchino.delregno@collabora.com>
	 <20241120124420.133914-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241120124420.133914-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB7185:EE_
x-ms-office365-filtering-correlation-id: a543e769-6a40-46ee-9eba-08dd0aa95b0a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q2RCUnVLT3NwdWU0OUVYSTloRGhKVmdUdExuRGh1aG0yaWtIOU9oZGxXL0JQ?=
 =?utf-8?B?cnl3Rko3Y2NHb2lIbU5TcHJiMmdtRTNtK0djNExWYUlKOU0vTlordXBOWm9k?=
 =?utf-8?B?d0dwSVQrSHE0YTYrdHdtNHRJRS9LQTZkQzVVQ24yL1Zhdk53eVl3NVFPSHln?=
 =?utf-8?B?em11cHpNK3NrUTQzaEJnYUhYMm9SM1NOT2lOcFZZeS8xQS9FYWZWUi9nUGFs?=
 =?utf-8?B?WXR2Z25BMjNEQWZDYnFLRTNKZSt3K2srNTRkRkM3UzBpalk3M1ZSNnp5cTdJ?=
 =?utf-8?B?UEh0ZXFMWURQcEl4dzVFNWp3bzYwdmt1N2hXUksvZG1GWnRvOStGaWZ5cENJ?=
 =?utf-8?B?Wm1FYUh3YVIwTWhhUyt5OE1KZTNaRWhraVluYzRPUkU1Sk15d0g4bUs4ZHVu?=
 =?utf-8?B?R0ppRTI2Y2pTYTdzZDJaNnZTbjQ3Qk4wcXFhTkZjQzFQcnBLS0RobTM0ckNq?=
 =?utf-8?B?SDRjNmwydGNJZCtudmVnRWFTTXdLeUdpVWhsV1BzWE4rY0tUR3Frd1NDWGFy?=
 =?utf-8?B?REd2a01pc2xtQ0tUdmxsLzl6b00zcGU2Nmo3TmRwL1lxRnhaMWpNWWpEMjNp?=
 =?utf-8?B?UTIvR0NSYnVMMkQrcmptNWVJSDhCRS8rR3ZBaFRheFFrNkQ0ZWtUTnFoRkRE?=
 =?utf-8?B?Ujd6RGVITC9uVnNyVllaQXVFZ3QzNExYN1pGNVZLUHFmWFcvOVpaeFhqRE1X?=
 =?utf-8?B?YVZlL2I2T01wcStaYWhaL2IyMGorTFBBSUpxV2VwZlFVTDRpaEtsRkVJTEQ1?=
 =?utf-8?B?ZGpsdDdmU3VFTWJ3S0NtZ01OQWNEZFBsVk1NbkJSUWlqQUhTeEQzQmQyNlRD?=
 =?utf-8?B?c1AzMFYzQVdCdUZsWVQ2WFdVUlJoeUl0TTN3Y0R3SVdyZUErdnM3UmpkZzNa?=
 =?utf-8?B?OEpnYlR4dFhta2tBTFZnNGFKRlJncU9oQ0NMNTJlOXluTWVQdHZCcHZxK0F3?=
 =?utf-8?B?d1FKaUZVSkZ1UG13T0sxSUxjMnZUMzhBbXlpZzBRczZ1M3JkN2hHM1R2NXEv?=
 =?utf-8?B?ekltNnVCL0Jxa1Vaamo3bzFsTUZ3VkxoLzFHZU1jZ2srZzdJc0dRUXRFWDRt?=
 =?utf-8?B?ZHZzRlJ1cGNWS0dDejJJUmQ0WHBGOHZpaEJaNzVxUy9WNmcxMWIwM3FvWFly?=
 =?utf-8?B?dEgrOHRMdjJnenlYR1ZwMysrWjE3b1NrMUVHdFdheTlEZ3VIb09LV0FpN2ta?=
 =?utf-8?B?NHVkY0t1SHdRWTg4WTFmcTNaUUYzdVJzMjB0b2ZrQnhWVCs2aHl0S1gyVzBF?=
 =?utf-8?B?a0lTY0V2Z2tBYjhoeFcrYnJxL2U1a2hZSTB5V2o5bU0zSm05S25XYUxKN0dL?=
 =?utf-8?B?bVhEdUpHczBDcHJJbUlaZmRic1o1MmczSHpMWmdqbnFPazVla0hIQk90Njcy?=
 =?utf-8?B?bHVnZG1tbjYxRU52dTMxYzNhd1NmTHh6bTJCd1BtVHB6OGpUeDBzWjhQYm1K?=
 =?utf-8?B?WmJtdTJPVGwyV3pLc3lhSUpXdEpmZzNBem5PT0owN0habTRZVGo3SzhHWVFl?=
 =?utf-8?B?QnNZeXZxYzBrQWh3L0UxQXRLTXhWUUllTUE0ZUVVR3FUTHo4c1lBL3NIU1Qv?=
 =?utf-8?B?ZjBSRXQrQ1RkSHMzdk45KzlPYXlBVkk1b0p0aWFDQkN1UHNmWm4zdUd1NlJq?=
 =?utf-8?B?YzFOV3g0dnhXRGlpNjZJczlaZ0MvV2czMzl5Q2NGMXJYZi9UTmpaNHBZY2NK?=
 =?utf-8?B?NUdQTjl0LzVTTG14VnBlM1dsWGFrM2N5QU9xcjJKbzRoSUd6a2o3RldMMXhh?=
 =?utf-8?B?WDY3WWcwbXRDSTdxQ1JnSDgvbk5ad2JMWHdUQW1oNHhTNnc5cWhNd1hMMCtY?=
 =?utf-8?B?aFJIVndwajhqZW9QR1A2UkFqN3hSZmFwOVNMOVY3S1Y0RVlGd0VoWllmM09a?=
 =?utf-8?B?OFA2citQdE12dG12Zmp4VkxQMEtvb1AyRHJWcS9hdmQ0V1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHV5c055ODhkaXZ2bWdleVE1VzNIVXBkN09YbEh3R3RscDVUTUpoVTgwTUFq?=
 =?utf-8?B?eWdJVmYzV28yUXl0eXlqVldnOFZDbmZRN3BGdWtuc0tNSzAzRzdSYUR5Qk8z?=
 =?utf-8?B?dFAyOHlhNDdGd3pxZXhHdnVKcURBMTcrSDF2TjE0Y2xYM2lBUEJjS3hrWWF6?=
 =?utf-8?B?Tk1MRE81TWVYMm9rSDNRVDU1Njk0UEhCNThtbFpTaWVNZktCcWp0aHFkUUVN?=
 =?utf-8?B?cUdtem0zdFpGV3BBeFUwK0NuclIwQTFlWExPYS9lWG1LT0I0NzdETE11eGhh?=
 =?utf-8?B?TFRTTm43UEhBM3E2VjhGYlpnVGVPNjhBdmRrOUxzdnNERjcxZUxxUyt2TEZ3?=
 =?utf-8?B?QzFSbnhRVEtGZWMxZUlqZWo1MmI2QjZIMDk3aldWZHhsdnMrRG14SVliQVo2?=
 =?utf-8?B?L0pYb3ZtZTZWcDFlYUdLNW80UUV0RUYwaHJwdmJIQWVkV05nMHkzRUljZjNI?=
 =?utf-8?B?RHcvUHJpNkJkMXI1SDVjWXgyT2l1bEpNRVlzYXk1WUEzeGJSTHB0RnRIbnlR?=
 =?utf-8?B?eEpPcXR4WUtaRk53ZVExZTlSZnB5S1UwTG1rQzFhdzkxQk9hVURzVzcvZUZN?=
 =?utf-8?B?UkFKQStiejk0M3F4NFcxWmlnM05HMlBiRUhGQklvTytCZXM4bmFCOHBnOWlF?=
 =?utf-8?B?TjR1YmRrS2xXUlhEdzNHNCsrWlRyVVY5ZDkwS1ZIQTRxU1RRWnhxa21IYkc3?=
 =?utf-8?B?RnVpMkdpOFF0S0VtVDZxeEYrSU1KazloUzI4RUZpVWRRWDBjZW9xcXZHTlhG?=
 =?utf-8?B?OFNJQ0VsR2I4TU9XUXY3d2tmeG5BajZzYXN5enAyWTMxL1g3OWthSzJuMlNJ?=
 =?utf-8?B?dmVCR0Q5QlBvSjRRNWd3aWh3SXlyQ1dubmVkbXNpQnI1MUl0Q1RqZjQza3V1?=
 =?utf-8?B?U0FLMnRrdERyMERiYU83bTFUcTY5dHFUOG9FZ1hiQ3h3MStQcmFoL1hMYkNn?=
 =?utf-8?B?VHNUMU9zd2NwNmF4allPZFllVnhBS2kwTXV3S0ZyUUcwU21tdlZkOCtQaVU0?=
 =?utf-8?B?YUZNa1hsejBxeFVpK3B3dERiTlhLV1dhaTl4Nm1WeW02b054dW41WFRvZmJJ?=
 =?utf-8?B?Rk5NK0p3MVV3VmMyam4weW0vRVZFNDIyTlZpdno3OEttR2tVZGxtRmZaRDF5?=
 =?utf-8?B?eXlWanF1ZVFxejdNMWRJNzluNm1nYlJjNmNQdlRWTUdGaDZwMVRacGNyd0xE?=
 =?utf-8?B?dnZJTlZQaW5POUZERGRkSzFRYzhxOHVFQjdENXA2QVcySXNEYmYvbSswSlAy?=
 =?utf-8?B?dWVqdDZGTEszZWc0S1pGV1o0NitSQThzTnROL0l2ZGdldjlBczJYUWxXTE0x?=
 =?utf-8?B?ZnZZSXFtbTBpNTRkTUEvSmJ5clJTeHRicU8xMjJHdlNVRzNNUWpHc3hHZlVE?=
 =?utf-8?B?c0hmdy9EM0hVZk96dDc3UFNZWGRtV3dvdEFZcldZVXJhVk1sS0VMak13eml2?=
 =?utf-8?B?cG5BQ0l2UWtKMmM1TGg1SG0zajBrMmJjNUkzUTh6OGpaVFVsVHVxUHpmd3Vs?=
 =?utf-8?B?cG9XSVVFdCsvTVFnWlovbTE3ZlRxR0FiL1R4ZmVwT1cxL1hPU0Y1aXFSbVZw?=
 =?utf-8?B?WjFCakVIRDk4QXJOVmVQdkRFdlVMTHF0QjZIREVlcEdUNk5QZ05KcStXQXVW?=
 =?utf-8?B?ZmJqQ0hleXRXOWllTUNxTUVuWFlRa1JhOVZLNmFXeUhXWG1MQWZ0RlZUM01x?=
 =?utf-8?B?cG0zV1k4TEtTTUJJRkJlYllIWElJaFhlaUU4UkF1aE5ZWnlBOGlheW1OZ2ky?=
 =?utf-8?B?RmM4Yy9kajBaUzgxOVV4V2RLMmJhYVc2RE5sZDBPRGhSL1EycGpac3N2c2dB?=
 =?utf-8?B?eXdKZndnZVZWZ1dNS3UveGNLRSs2aGZET0Y2U1psL0FjNzZieXhrcU13dktF?=
 =?utf-8?B?TG1oaWtEc256bDFxVXhqMm14SnRhMFpUWmplN0gxWXpZa3QvRm9palRNUEVi?=
 =?utf-8?B?MzlFN05aeHU2a1RCWjhNTWJBZTJFNEorc3hOaTJYUDFTRmRKNUNscVRzb0lE?=
 =?utf-8?B?UEpRUG5XOGR4VDhPSXZCU05ldTlabWRrM0srU3Azd2NCYWZ0T29acEFmRTgv?=
 =?utf-8?B?UHJmMkE1V29UUEU0N3ZBNDJ3dXQwekViVHA0WE5aRFBuZmR1ejhpWTl2NzNQ?=
 =?utf-8?Q?aQ8ZAwgn4ZgwnOmqsc2KLrROn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25919C98A8B72945A2114D5C10B56093@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a543e769-6a40-46ee-9eba-08dd0aa95b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 03:54:24.9300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TChOabgDpDTJVGL6En9C2fMUkXLc7sWT6DxTc/qs6x5N+7TyMnnVPMXz3q1HM2+MC/7+gsuB1E55BPNlIZ3tkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7185
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.753900-8.000000
X-TMASE-MatchedRID: vbSD0OnL8/INtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCiPSm+pLk6Vmt1AhvyEKdj6yeEt6/0zzyRER5MrEGoh5wyk
	hkAJj9sG438rGDHBskeQA6fzNPLy8d9REFpW2aJFor4yxPAz7WYv8pidhVYOUVI7KaIl9NheYAj
	JavrGfnyzoA/vD4jBbAwjoOZIxsaK0mJ4/iuO92eKXavbHY/C1WjWsWQUWzVolxKvMBIWkS1dKM
	2MemW5vGvX6HjFuUydxec6bnKstogDNPxu11HXjFyqkfsPWu1DuHZGuwo6K7fNhzIgXtFJV0RAs
	k+VhCoQ2wRZMiNYfROK3zUQrVX3+YwDOL7t3RyGcgbKevk5shvTcf8Av+QSA2j+PhxJ/bFujxYy
	RBa/qJRVHsNBZf9aRAYt5KiTiutkLbigRnpKlKSPzRlrdFGDwdDb9rE5XnlPQBJnKei7z+JMNC0
	m/pcd0WFF8JXXvcHZEMi8SG5dDPQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.753900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	962067317C7D2FA6E85E9996842B8042CAFA6330E57827053307C679FBC0F2982000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTExLTIwIGF0IDEzOjQ0ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBTZXR0aW5nIHRoZSBUVkQg
UExMIGNsb2NrIHJlcXVpcmVzIHRvIG11bHRpcGx5IHRoZSB0YXJnZXQgcGl4ZWwNCj4gY2xvY2sg
YnkgYSBzcGVjaWZpYyBjb25zdGFudCBmYWN0b3IgdG8gYWNoaWV2ZSB0aGUgdGFyZ2V0IFBMTA0K
PiBmcmVxdWVuY3ksIGFuZCB0aGlzIGlzIGRvbmUgdG8gcmVkdWNlIGppdHRlciB0byBhY2NlcHRh
YmxlIGxldmVscy4NCj4gDQo+IE9uIGFsbCBNZWRpYVRlayBTb0NzLCB0aGUgZmFjdG9yIGlzIG5v
dCByZXRyaWV2ZWQgYnkgYW55IHJlYWwga2luZA0KPiBvZiBjYWxjdWxhdGlvbiBidXQgcmF0aGVy
IGJ5IGNoZWNraW5nIGlmIHRoZSB0YXJnZXQgcGl4ZWwgY2xvY2sNCj4gaXMgbGVzcyB0aGFuIGEg
c3BlY2lmaWVkIGZyZXF1ZW5jeSwgaGVuY2UgYXNzaWduaW5nIGEgZnVuY3Rpb24NCj4gcG9pbnRl
ciBmb3IganVzdCBhIGJ1bmNoIG9mIGlmIGJyYW5jaGVzIGRvZXMgZW5sYXJnZSB0aGUgY29kZQ0K
PiBzaXplIGZvciBsaXR0bGUgcmVhc29uLg0KPiANCj4gUmVtb3ZlIGFsbCBTb0Mtc3BlY2lmaWMg
ZnVuY3Rpb25zLCBhZGQgYSBzdHJ1Y3R1cmUgYG10a19kcGlfZmFjdG9yYA0KPiB0aGF0IGhvbGRz
IGEgY2xvY2sgZnJlcXVlbmN5IGFuZCBjb3JyZXNwb25kaW5nIFBMTCBmYWN0b3IsIGFuZA0KPiBk
ZWNsYXJlIHRoZSBjb25zdHJhaW50cyBmb3IgZWFjaCBTb0MgaW4gZm9ybSBvZiBhbiBhcnJheSBv
ZiBzYWlkDQo+IHN0cnVjdHVyZS4NCj4gSW5zdGVhZCBvZiBmdW5jdGlvbiBwb2ludGVycywgdGhp
cyBzdHJ1Y3R1cmUgKGFuZCBpdHMgc2l6ZSkgaXMgdGhlbg0KPiBhc3NpZ25lZCB0byBlYWNoIFNv
QydzIHBsYXRmb3JtIGRhdGEuDQo+IA0KPiBUaGUgImNhbGN1bGF0aW9uIiBpcyB0aGVuIHBlcmZv
cm1lZCB3aXRoIGEgbmV3IHN0YXRpYyBmdW5jdGlvbg0KPiBtdGtfZHBpX2NhbGN1bGF0ZV9mYWN0
b3IoZHBpLCBtb2RlX2NsaykgdGhhdCBpdGVyYXRlcyB0aHJvdWdoIGFsbA0KPiBvZiB0aGUgZW50
cmllcyBvZiB0aGUgYWZvcmVtZW50aW9uZWQgYXJyYXkgYW5kIHJldHVybnMgdGhlIHJpZ2h0DQo+
IGZhY3Rvci4NCj4gDQo+IElmIG5vIGZhY3RvciBpcyBmb3VuZCwgdGhlIGxvd2VzdCBwb3NzaWJs
ZSBmYWN0b3IgaXMgcmV0dXJuZWQsDQo+IG1pbWlja2luZyB0aGUgc2FtZSBmbG93IGFzIGFsbCBv
ZiB0aGUgb2xkIHBlci1Tb0MgY2FsY3VsYXRpb24NCj4gZnVuY3Rpb25zLg0KPiANCj4gVGhpcyBj
b21taXQgYnJpbmdzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUg
PGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNj
aGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIHwgMTAzICsrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9u
cygrKSwgNTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcGkuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMN
Cj4gaW5kZXggYzcxNDMxODRlNWRlLi45ZjU5ZWU2NzljZTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcGkuYw0KPiBAQCAtMTE3LDkgKzExNywxNSBAQCBzdHJ1Y3QgbXRrX2RwaV95
Y19saW1pdCB7DQo+ICAgICAgICAgdTE2IGNfYm90dG9tOw0KPiAgfTsNCj4gDQo+ICtzdHJ1Y3Qg
bXRrX2RwaV9mYWN0b3Igew0KPiArICAgICAgIHUzMiBjbG9jazsNCj4gKyAgICAgICB1OCBmYWN0
b3I7DQo+ICt9Ow0KPiArDQo+ICAvKioNCj4gICAqIHN0cnVjdCBtdGtfZHBpX2NvbmYgLSBDb25m
aWd1cmF0aW9uIG9mIG1lZGlhdGVrIGRwaS4NCj4gLSAqIEBjYWxfZmFjdG9yOiBDYWxsYmFjayBm
dW5jdGlvbiB0byBjYWxjdWxhdGUgZmFjdG9yIHZhbHVlLg0KPiArICogQGRwaV9mYWN0b3I6IFNv
Qy1zcGVjaWZpYyBwaXhlbCBjbG9jayBQTEwgZmFjdG9yIHZhbHVlcy4NCj4gKyAqIEBudW1fZHBp
X2ZhY3RvcjogTnVtYmVyIG9mIHBpeGVsIGNsb2NrIFBMTCBmYWN0b3IgdmFsdWVzLg0KPiAgICog
QHJlZ19oX2ZyZV9jb246IFJlZ2lzdGVyIGFkZHJlc3Mgb2YgZnJlcXVlbmN5IGNvbnRyb2wuDQo+
ICAgKiBAbWF4X2Nsb2NrX2toejogTWF4IGNsb2NrIGZyZXF1ZW5jeSBzdXBwb3J0ZWQgZm9yIHRo
aXMgU29DcyBpbiBraHogdW5pdHMuDQo+ICAgKiBAZWRnZV9zZWxfZW46IEVuYWJsZSBvZiBlZGdl
IHNlbGVjdGlvbi4NCj4gQEAgLTE0MCw3ICsxNDYsOCBAQCBzdHJ1Y3QgbXRrX2RwaV95Y19saW1p
dCB7DQo+ICAgKiBAZWRnZV9jZmdfaW5fbW1zeXM6IElmIHRoZSBlZGdlIGNvbmZpZ3VyYXRpb24g
Zm9yIERQSSdzIG91dHB1dCBuZWVkcyB0byBiZSBzZXQgaW4gTU1TWVMuDQo+ICAgKi8NCj4gIHN0
cnVjdCBtdGtfZHBpX2NvbmYgew0KPiAtICAgICAgIHVuc2lnbmVkIGludCAoKmNhbF9mYWN0b3Ip
KGludCBjbG9jayk7DQo+ICsgICAgICAgY29uc3Qgc3RydWN0IG10a19kcGlfZmFjdG9yICpkcGlf
ZmFjdG9yOw0KPiArICAgICAgIGNvbnN0IHU4IG51bV9kcGlfZmFjdG9yOw0KPiAgICAgICAgIHUz
MiByZWdfaF9mcmVfY29uOw0KPiAgICAgICAgIHUzMiBtYXhfY2xvY2tfa2h6Ow0KPiAgICAgICAg
IGJvb2wgZWRnZV9zZWxfZW47DQo+IEBAIC01MTUsNiArNTIyLDIwIEBAIHN0YXRpYyBpbnQgbXRr
X2RwaV9wb3dlcl9vbihzdHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KPiAgICAgICAgIHJldHVybiByZXQ7
DQo+ICB9DQo+IA0KPiArc3RhdGljIHVuc2lnbmVkIGludCBtdGtfZHBpX2NhbGN1bGF0ZV9mYWN0
b3Ioc3RydWN0IG10a19kcGkgKmRwaSwgaW50IG1vZGVfY2xrKQ0KPiArew0KPiArICAgICAgIGNv
bnN0IHN0cnVjdCBtdGtfZHBpX2ZhY3RvciAqZHBpX2ZhY3RvciA9IGRwaS0+Y29uZi0+ZHBpX2Zh
Y3RvcjsNCj4gKyAgICAgICBpbnQgaTsNCj4gKw0KPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBk
cGktPmNvbmYtPm51bV9kcGlfZmFjdG9yOyBpKyspIHsNCj4gKyAgICAgICAgICAgICAgIGlmICht
b2RlX2NsayA8PSBkcGlfZmFjdG9yW2ldLmNsb2NrKQ0KPiArICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gZHBpX2ZhY3RvcltpXS5mYWN0b3I7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAg
ICAgLyogSWYgbm8gbWF0Y2ggdHJ5IHRoZSBsb3dlc3QgcG9zc2libGUgZmFjdG9yICovDQo+ICsg
ICAgICAgcmV0dXJuIGRwaV9mYWN0b3JbZHBpLT5jb25mLT5udW1fZHBpX2ZhY3RvciAtIDFdLmZh
Y3RvcjsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBtdGtfZHBpX3NldF9kaXNwbGF5X21vZGUo
c3RydWN0IG10a19kcGkgKmRwaSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgKm1vZGUpDQo+ICB7DQo+IEBAIC01MjksNyArNTUw
LDcgQEAgc3RhdGljIGludCBtdGtfZHBpX3NldF9kaXNwbGF5X21vZGUoc3RydWN0IG10a19kcGkg
KmRwaSwNCj4gICAgICAgICB1bnNpZ25lZCBpbnQgZmFjdG9yOw0KPiANCj4gICAgICAgICAvKiBs
ZXQgcGxsX3JhdGUgY2FuIGZpeCB0aGUgdmFsaWQgcmFuZ2Ugb2YgdHZkcGxsICgxR34yR0h6KSAq
Lw0KPiAtICAgICAgIGZhY3RvciA9IGRwaS0+Y29uZi0+Y2FsX2ZhY3Rvcihtb2RlLT5jbG9jayk7
DQo+ICsgICAgICAgZmFjdG9yID0gbXRrX2RwaV9jYWxjdWxhdGVfZmFjdG9yKGRwaSwgbW9kZV9j
bGspOw0KPiAgICAgICAgIGRybV9kaXNwbGF5X21vZGVfdG9fdmlkZW9tb2RlKG1vZGUsICZ2bSk7
DQo+ICAgICAgICAgcGxsX3JhdGUgPSB2bS5waXhlbGNsb2NrICogZmFjdG9yOw0KPiANCj4gQEAg
LTk2NCw0OCArOTg1LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjb21wb25lbnRfb3BzIG10a19k
cGlfY29tcG9uZW50X29wcyA9IHsNCj4gICAgICAgICAudW5iaW5kID0gbXRrX2RwaV91bmJpbmQs
DQo+ICB9Ow0KPiANCj4gLXN0YXRpYyB1bnNpZ25lZCBpbnQgbXQ4MTczX2NhbGN1bGF0ZV9mYWN0
b3IoaW50IGNsb2NrKQ0KPiAtew0KPiAtICAgICAgIGlmIChjbG9jayA8PSAyNzAwMCkNCj4gLSAg
ICAgICAgICAgICAgIHJldHVybiAzIDw8IDQ7DQo+IC0gICAgICAgZWxzZSBpZiAoY2xvY2sgPD0g
ODQwMDApDQo+IC0gICAgICAgICAgICAgICByZXR1cm4gMyA8PCAzOw0KPiAtICAgICAgIGVsc2Ug
aWYgKGNsb2NrIDw9IDE2NzAwMCkNCj4gLSAgICAgICAgICAgICAgIHJldHVybiAzIDw8IDI7DQo+
IC0gICAgICAgZWxzZQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIDMgPDwgMTsNCj4gLX0NCj4g
LQ0KPiAtc3RhdGljIHVuc2lnbmVkIGludCBtdDI3MDFfY2FsY3VsYXRlX2ZhY3RvcihpbnQgY2xv
Y2spDQo+IC17DQo+IC0gICAgICAgaWYgKGNsb2NrIDw9IDY0MDAwKQ0KPiAtICAgICAgICAgICAg
ICAgcmV0dXJuIDQ7DQo+IC0gICAgICAgZWxzZSBpZiAoY2xvY2sgPD0gMTI4MDAwKQ0KPiAtICAg
ICAgICAgICAgICAgcmV0dXJuIDI7DQo+IC0gICAgICAgZWxzZQ0KPiAtICAgICAgICAgICAgICAg
cmV0dXJuIDE7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyB1bnNpZ25lZCBpbnQgbXQ4MTgzX2NhbGN1
bGF0ZV9mYWN0b3IoaW50IGNsb2NrKQ0KPiAtew0KPiAtICAgICAgIGlmIChjbG9jayA8PSAyNzAw
MCkNCj4gLSAgICAgICAgICAgICAgIHJldHVybiA4Ow0KPiAtICAgICAgIGVsc2UgaWYgKGNsb2Nr
IDw9IDE2NzAwMCkNCj4gLSAgICAgICAgICAgICAgIHJldHVybiA0Ow0KPiAtICAgICAgIGVsc2UN
Cj4gLSAgICAgICAgICAgICAgIHJldHVybiAyOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgdW5zaWdu
ZWQgaW50IG10ODE5NV9kcGludGZfY2FsY3VsYXRlX2ZhY3RvcihpbnQgY2xvY2spDQo+IC17DQo+
IC0gICAgICAgaWYgKGNsb2NrIDwgNzAwMDApDQo+IC0gICAgICAgICAgICAgICByZXR1cm4gNDsN
Cj4gLSAgICAgICBlbHNlIGlmIChjbG9jayA8IDIwMDAwMCkNCj4gLSAgICAgICAgICAgICAgIHJl
dHVybiAyOw0KPiAtICAgICAgIGVsc2UNCj4gLSAgICAgICAgICAgICAgIHJldHVybiAxOw0KPiAt
fQ0KPiAtDQo+ICBzdGF0aWMgY29uc3QgdTMyIG10ODE3M19vdXRwdXRfZm10c1tdID0gew0KPiAg
ICAgICAgIE1FRElBX0JVU19GTVRfUkdCODg4XzFYMjQsDQo+ICB9Ow0KPiBAQCAtMTAyMCw4ICs5
OTksMjUgQEAgc3RhdGljIGNvbnN0IHUzMiBtdDgxOTVfb3V0cHV0X2ZtdHNbXSA9IHsNCj4gICAg
ICAgICBNRURJQV9CVVNfRk1UX1lVWVY4XzFYMTYsDQo+ICB9Ow0KPiANCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2RwaV9mYWN0b3IgZHBpX2ZhY3Rvcl9tdDI3MDFbXSA9IHsNCj4gKyAgICAg
ICB7IDY0MDAwLCA0IH0sIHsgMTI4MDAwLCAyIH0sIHsgVTMyX01BWCwgMSB9DQo+ICt9Ow0KPiAr
DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcGlfZmFjdG9yIGRwaV9mYWN0b3JfbXQ4MTcz
W10gPSB7DQo+ICsgICAgICAgeyAyNzAwMCwgNDggfSwgeyA4NDAwMCwgMjQgfSwgeyAxNjcwMDAs
IDEyIH0sIHsgVTMyX01BWCwgNiB9DQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19kcGlfZmFjdG9yIGRwaV9mYWN0b3JfbXQ4MTgzW10gPSB7DQo+ICsgICAgICAgeyAyNzAw
MCwgOCB9LCB7IDE2NzAwMCwgNCB9LCB7IFUzMl9NQVgsIDIgfQ0KPiArfTsNCj4gKw0KPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2ZhY3RvciBkcGlfZmFjdG9yX210ODE5NV9kcF9pbnRm
W10gPSB7DQo+ICsgICAgICAgeyA3MDAwMCAtIDEsIDQgfSwgeyAyMDAwMDAgLSAxLCAyIH0sIHsg
VTMyX01BWCwgMSB9DQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcGlf
Y29uZiBtdDgxNzNfY29uZiA9IHsNCj4gLSAgICAgICAuY2FsX2ZhY3RvciA9IG10ODE3M19jYWxj
dWxhdGVfZmFjdG9yLA0KPiArICAgICAgIC5kcGlfZmFjdG9yID0gZHBpX2ZhY3Rvcl9tdDgxNzMs
DQo+ICsgICAgICAgLm51bV9kcGlfZmFjdG9yID0gQVJSQVlfU0laRShkcGlfZmFjdG9yX210ODE3
MyksDQo+ICAgICAgICAgLnJlZ19oX2ZyZV9jb24gPSAweGUwLA0KPiAgICAgICAgIC5tYXhfY2xv
Y2tfa2h6ID0gMzAwMDAwLA0KPiAgICAgICAgIC5vdXRwdXRfZm10cyA9IG10ODE3M19vdXRwdXRf
Zm10cywNCj4gQEAgLTEwMzgsNyArMTAzNCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rw
aV9jb25mIG10ODE3M19jb25mID0gew0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19kcGlfY29uZiBtdDI3MDFfY29uZiA9IHsNCj4gLSAgICAgICAuY2FsX2ZhY3RvciA9IG10
MjcwMV9jYWxjdWxhdGVfZmFjdG9yLA0KPiArICAgICAgIC5kcGlfZmFjdG9yID0gZHBpX2ZhY3Rv
cl9tdDI3MDEsDQo+ICsgICAgICAgLm51bV9kcGlfZmFjdG9yID0gQVJSQVlfU0laRShkcGlfZmFj
dG9yX210MjcwMSksDQo+ICAgICAgICAgLnJlZ19oX2ZyZV9jb24gPSAweGIwLA0KPiAgICAgICAg
IC5lZGdlX3NlbF9lbiA9IHRydWUsDQo+ICAgICAgICAgLm1heF9jbG9ja19raHogPSAxNTAwMDAs
DQo+IEBAIC0xMDU2LDcgKzEwNTMsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcGlfY29u
ZiBtdDI3MDFfY29uZiA9IHsNCj4gIH07DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
ZHBpX2NvbmYgbXQ4MTgzX2NvbmYgPSB7DQo+IC0gICAgICAgLmNhbF9mYWN0b3IgPSBtdDgxODNf
Y2FsY3VsYXRlX2ZhY3RvciwNCj4gKyAgICAgICAuZHBpX2ZhY3RvciA9IGRwaV9mYWN0b3JfbXQ4
MTgzLA0KPiArICAgICAgIC5udW1fZHBpX2ZhY3RvciA9IEFSUkFZX1NJWkUoZHBpX2ZhY3Rvcl9t
dDgxODMpLA0KPiAgICAgICAgIC5yZWdfaF9mcmVfY29uID0gMHhlMCwNCj4gICAgICAgICAubWF4
X2Nsb2NrX2toeiA9IDEwMDAwMCwNCj4gICAgICAgICAub3V0cHV0X2ZtdHMgPSBtdDgxODNfb3V0
cHV0X2ZtdHMsDQo+IEBAIC0xMDczLDcgKzEwNzEsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19kcGlfY29uZiBtdDgxODNfY29uZiA9IHsNCj4gIH07DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0
cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTg2X2NvbmYgPSB7DQo+IC0gICAgICAgLmNhbF9mYWN0b3Ig
PSBtdDgxODNfY2FsY3VsYXRlX2ZhY3RvciwNCj4gKyAgICAgICAuZHBpX2ZhY3RvciA9IGRwaV9m
YWN0b3JfbXQ4MTgzLA0KPiArICAgICAgIC5udW1fZHBpX2ZhY3RvciA9IEFSUkFZX1NJWkUoZHBp
X2ZhY3Rvcl9tdDgxODMpLA0KPiAgICAgICAgIC5yZWdfaF9mcmVfY29uID0gMHhlMCwNCj4gICAg
ICAgICAubWF4X2Nsb2NrX2toeiA9IDE1MDAwMCwNCj4gICAgICAgICAub3V0cHV0X2ZtdHMgPSBt
dDgxODNfb3V0cHV0X2ZtdHMsDQo+IEBAIC0xMDkxLDcgKzEwOTAsOCBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19kcGlfY29uZiBtdDgxODZfY29uZiA9IHsNCj4gIH07DQo+IA0KPiAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTkyX2NvbmYgPSB7DQo+IC0gICAgICAgLmNh
bF9mYWN0b3IgPSBtdDgxODNfY2FsY3VsYXRlX2ZhY3RvciwNCj4gKyAgICAgICAuZHBpX2ZhY3Rv
ciA9IGRwaV9mYWN0b3JfbXQ4MTgzLA0KPiArICAgICAgIC5udW1fZHBpX2ZhY3RvciA9IEFSUkFZ
X1NJWkUoZHBpX2ZhY3Rvcl9tdDgxODMpLA0KPiAgICAgICAgIC5yZWdfaF9mcmVfY29uID0gMHhl
MCwNCj4gICAgICAgICAubWF4X2Nsb2NrX2toeiA9IDE1MDAwMCwNCj4gICAgICAgICAub3V0cHV0
X2ZtdHMgPSBtdDgxODNfb3V0cHV0X2ZtdHMsDQo+IEBAIC0xMTA4LDcgKzExMDgsOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDgxOTJfY29uZiA9IHsNCj4gIH07DQo+IA0K
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTk1X2RwaW50Zl9jb25mID0g
ew0KPiAtICAgICAgIC5jYWxfZmFjdG9yID0gbXQ4MTk1X2RwaW50Zl9jYWxjdWxhdGVfZmFjdG9y
LA0KPiArICAgICAgIC5kcGlfZmFjdG9yID0gZHBpX2ZhY3Rvcl9tdDgxOTVfZHBfaW50ZiwNCj4g
KyAgICAgICAubnVtX2RwaV9mYWN0b3IgPSBBUlJBWV9TSVpFKGRwaV9mYWN0b3JfbXQ4MTk1X2Rw
X2ludGYpLA0KPiAgICAgICAgIC5tYXhfY2xvY2tfa2h6ID0gNjAwMDAwLA0KPiAgICAgICAgIC5v
dXRwdXRfZm10cyA9IG10ODE5NV9vdXRwdXRfZm10cywNCj4gICAgICAgICAubnVtX291dHB1dF9m
bXRzID0gQVJSQVlfU0laRShtdDgxOTVfb3V0cHV0X2ZtdHMpLA0KPiAtLQ0KPiAyLjQ3LjANCj4g
DQo=

