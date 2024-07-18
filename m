Return-Path: <linux-kernel+bounces-256117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98629934932
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAB51F21B46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE50274058;
	Thu, 18 Jul 2024 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TyZ8+f/7";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tD/lU4eT"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041201C36
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288937; cv=fail; b=nvT206ZA9r+T9uLZMOmsUjtiT6n4wArJBrGrfdeLyITj1m2q2hNeRoHHSYhAEJhpHmrGoBGk+v30NKZHhGJckENnCAdVXTOmQHYy3slPEn8VaQG0wsVrSiJeHwWkbbpOjyyXpSskquWcUdIptxa/2NLa5P60vxHK68uwuFBNqMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288937; c=relaxed/simple;
	bh=ZrEB/aZFNNGHkyiKpOmzlY5trMl2bzxehrV2VqreOyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jSBr9V61a9XvDDgFmRZ0ZfCpS6ufFZhIVbyJEli5EskVFfqAfgrHLVEtWWciwajrQhDubD7eqH6h6TSReGRmS/psdFbPZc0ZMybomsdH7AR/wAJjecLyS7p9IGYWIUqXy9GfOOm8/BCRqAbpYBoKLoJtKDYUxVjPO2YTvvbiZHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TyZ8+f/7; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tD/lU4eT; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 290450a444da11efb5b96b43b535fdb4-20240718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZrEB/aZFNNGHkyiKpOmzlY5trMl2bzxehrV2VqreOyc=;
	b=TyZ8+f/7xoeT2d4sPL52O+8pViDtmLPKK0UAFw96w1wmveB3kHkRn2Ha4obXEo8NsCKKPyorRijyJZIdh4t7M5Bp/uMEn4pFYl9xhrTWS2nbC9BNMf9Mh72Yh1aRfsvDADV1Ld14ahXK++7QMkB1/0F0Qw9OO+DRsBcndEET4lA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:1dc6c9f7-6685-4d95-bdb3-66c655d23baf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:07d87145-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 290450a444da11efb5b96b43b535fdb4-20240718
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2105698161; Thu, 18 Jul 2024 15:48:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 Jul 2024 15:48:44 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 Jul 2024 15:48:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVCzUU1o7Fk8Mco61iMWyiYYg9q8tm+yKWBSefbPsinF57BkIkwTHcpa4izFU68uwql5iUD2lE+jOh9zerFepMBP9FfxvrMZoAS8xFiAX1zgL3eCJTxwQw1noFoDGJLIbGZ91XCXABVbH9OY6cQz2GHPWNcpk7WM5lZpwwe201OBYrOaodZc/BS7h+Vpa4aUvfZjY4Dx58y0cGIhXdLwyf+6w2Eevjgp6ov6e19f80tsFWJEYtEk5AVonNsiMW4UGU7Pb/Vfc4VIPWS2K4kQ9w+fY31zkbbc0dp7gZeLpBg0W1BRO6BYSVzqwmEbDWxN5F4Jq0sMp655N8mRw5XOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrEB/aZFNNGHkyiKpOmzlY5trMl2bzxehrV2VqreOyc=;
 b=aKaHx8Pp15bmIO76s6fwObijrcnRkq9ZZHBQp4DDrILC/CExWmGDXSQP8a+ByOi6tj/e5cgiiaJPk3PYzqND+Gti6Vz3lXCewLTOMYvxaL0dSO0dJBgxqvSQqCaWY09WWkRGfqixYtNuIoUmV7UnDrdXyZaN5GnI+ARt2Vijc2mkNw8ztx2GGSEcq8eIlxAREoazAgDXrnqJazfy3wQRfDVjX6mYv365ap6Krs7zdSbXkAhtj7QkB47VBmVx2GSACTpC4jRBblXbCWudkSO1qkY0BbfXuPBN/xhwZEPY5pOPC7x4Bk6ufquR75A6BCArdX8BjugVLJthuUPvIxGIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrEB/aZFNNGHkyiKpOmzlY5trMl2bzxehrV2VqreOyc=;
 b=tD/lU4eToXLUPgSiMVDqXJ9oJnEblOcq0BUCyFnQML/2gxMisoUU8hvKvRQuJe8N7DMQOgG4kqTHZTr+eR8uuVL7/4Xn+6TBnrmrbHhyHV2tMRaB2FUcAR6b9w/2m4WF/yGPfS/OWIBpYra6NM0MG4bIt+Lk5fmvXgZfV9UvOic=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6722.apcprd03.prod.outlook.com (2603:1096:101:6a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 07:48:42 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 07:48:42 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
Subject: Re: [PATCH v3 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Topic: [PATCH v3 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Index: AQHauZvjSsoBOfJjC0GAI+NtmELueLH8WpiA
Date: Thu, 18 Jul 2024 07:48:42 +0000
Message-ID: <fb8d6df3d966b9132726fbde84322701cc4659b9.camel@mediatek.com>
References: <20240608120219.21817-1-mac.shen@mediatek.com>
	 <20240608120219.21817-3-mac.shen@mediatek.com>
In-Reply-To: <20240608120219.21817-3-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6722:EE_
x-ms-office365-filtering-correlation-id: 07245625-5667-4da7-5657-08dca6fe0b5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEU4VGZUZnIrNjJZRWhqWEtRb25IdWxzK1ZYejRXRnh2WTlraW5Qcy9YQkpx?=
 =?utf-8?B?Q1dmbGhnZTFQT2lQQWNSeDlYcmhDTlg0bisxbS95ZDlycmFiVGZqS0NQbXdV?=
 =?utf-8?B?UUFmL0JBK005UXEvMUxEejVrZVdYc3NQSU1MbnJQOUVDL1JmSjlDZkRocjUv?=
 =?utf-8?B?clhVdzNoYzM5OUtIQk44LytzU3FDWlZoVDhzckVidC9mVEltaHlrS2VDeUZQ?=
 =?utf-8?B?NElaK0dKTHVKZ0dkUUoybmFGd3hNZDF1QzJ0dHF4b1FSc1dONEJwbzVHZnd5?=
 =?utf-8?B?d0lISkdZR2tPdGMrMU5HWlBvbkdzNW9xaUQvZDlGYlJ5T2FaTGFLUitkWUla?=
 =?utf-8?B?ZFJOcnkzUzdnaHRRdE1YRGpUTG9KR0ZqMHBodHRGaXBXb2JuempsZ3Y1ODhO?=
 =?utf-8?B?Q2o4b2hKVW9Tb0plb1BiMHFRTUNpMjd5U3I1UXUrM3ZwcWpoTkpsS2hOdm9B?=
 =?utf-8?B?djJJZmlsVTRxbGRtN0ZCM21raGR5KzRveE1xUDd0K3BlTUFUbEprdFRKKzVh?=
 =?utf-8?B?VlBlZ25KRXNwRG1nWVArbWJDQVUxZXdWVSs1ZElvREh6OFZORVJPK1Jzcmxa?=
 =?utf-8?B?Rm9ETTFCQVFMVkNiajhZOWlzL3FzV2tuU051RGh2YUZFUE15Ny9IUjkxRW1n?=
 =?utf-8?B?Q201OWlXbldzelZlMlY0QVFKTTV0QWRUbSs4L0pKS0t1cFZuWXVUWVhkTmNN?=
 =?utf-8?B?QTloUlFiOWtFSnREMk9kM2lkaS9UbXVBTDVobUY1ODdPQUFkeWlZQUtleWht?=
 =?utf-8?B?V3NUSFV5NTBxNHZDQVg0djdzVWdDRmpSVCthTlFxUEhOMTRzMHVmWm43VTYw?=
 =?utf-8?B?RThYNzJ2MHYwSnBIdzM4VXVRcXpaYkhDYm9hRTRKUjFwRFBTWXJKYlVMcmMv?=
 =?utf-8?B?Uy9sUWw3SFViR2JoWDVRMUV4ODF0WTFQdktZWU5VV1N0NU8wdjZycUZBNUlQ?=
 =?utf-8?B?cVdMM2xwODNIajFqbzVtVzVYSGx2UFpZVTN2bndMMm1VaXNlUGpGRXZtcWhE?=
 =?utf-8?B?ZDVFSlZVbmoyNWY4K1J6U0hOVHpmeWV0M1JoK0ZjdzE2VXREaEpONnc3bTkr?=
 =?utf-8?B?U0FZWFZPYWxhTlB3bDRSSTlkVVp5SDdjMWt6L0FyYTBHQTJuT0FPZVpNWnp1?=
 =?utf-8?B?QmN2dXIvb3BpZjBOd0o0czRVSG5SM1A1c2crUDJPUkZCcHd4SWtYNFVHckNm?=
 =?utf-8?B?U00xUCtiWjdDVllrUkxOQkErRUFCaXQ5VGg4N1pEaGl1MGRrS1NMbUZNNTVE?=
 =?utf-8?B?ejI0U1JEU3BYMHRvRHFGcjBjenpDSmoyUGdUamFLanZlMTdRRjZIOWNXYlZ1?=
 =?utf-8?B?a3NlNlI2WWdBaVorSThleEVTOUZBNDRiOHY2bW9VbCtHT2k3WGl0MnhyTVZF?=
 =?utf-8?B?bzhGbnh0NXZjTVRRWWxRRUZxZXpXYlcxK3RYZDhlU2hGYXFEaEVPTUgwY1dm?=
 =?utf-8?B?MnVCanBLMVd6QVFmWGF3SThHVEpnZUZHUHNSRTIzaEk5SVRrU05xa2FPYnpy?=
 =?utf-8?B?NWtNSklFQVZ5WElGeStIaXdZVTcranJlb1k2THRoRXNIYkovU0h4cThEbXB5?=
 =?utf-8?B?WFN3SzdDeDAzQUFJRWVSdFBxekxuNDQ3TENiSTFvWklodVI0c3M2Y3FkZ3dX?=
 =?utf-8?B?M0hQeml2eHRVakFHMDBGOHVDR0dSUDZtK3R0MHRMUFUxQWFMZmxmZkhmT2pw?=
 =?utf-8?B?cXYxbUhpcVEwcXhHYzhPNnFTOTk2MzZqRmVxQ2pyT0lSTUN1SXFOK2pZcFNl?=
 =?utf-8?B?cTZmcDliY1ZRcUNzcWF4dzlKaW42ZW5FZUJkYlpjNTJoNlJBcTlqVjZvS21s?=
 =?utf-8?Q?8jMFeRWvPlG6kFxt1Sb39ywWiXEUfabWL3UVo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGFpOW5IaUNqM295V0lFWDd4eEQ3VVFPL1dVcjQ4STVqZUdsMlpUNDIrbUN0?=
 =?utf-8?B?aDZhMlFacTJwNU1RaGdkRUo0V01IeWMxTFg2N2dNL2NScjY2WU1VOWJySExs?=
 =?utf-8?B?a1BacUluVEw0bTlhMlg4R2E2azRNN05lUWYzTlJSRll3MllkanoyclpzcEd5?=
 =?utf-8?B?Q1MwQ0l6dFlkeFdvanZoNUFkN3RXTER5a3d1L29lNldYMitJemxrWFp5SXM5?=
 =?utf-8?B?Zmsrc29PQUlxSHF0ZC9zNzR5SXBIOHZwWTZzTWFYSUxFTWxCR3FUM2puYisr?=
 =?utf-8?B?U3RlTUpQTnU1TVRuRDNFZlNmeWpPaUVUZUNnVVdMVzVaeE45T2V1aGsyTmlB?=
 =?utf-8?B?SFJUeFhiUVVhQW9QUHlzM0FNMlJXOStMbWdJbWJYTzlNb3F5ZFNzQlhJUkZ2?=
 =?utf-8?B?OTBaajJCRTJ4cms0OU90SjdqZGVmSm5ZQmlXT0lqclJRQXRvR1NNMFdnMTJW?=
 =?utf-8?B?TkpCdUxaSzVtT2lCaGpkck84aVBJM0R3alZzUmFIZGpSczFiQlJmK2tvTHVi?=
 =?utf-8?B?eGxFQjh0Rll4enNYRTlyK1k5RnJyeTdqRm9JdnhhTkROeGVJREZjZThzSDNT?=
 =?utf-8?B?SXYyTFpQNmh5SEdSY3ZtM1VJc3drQU5QN09KK29nSWlPUHV6SjhmWEdzTjF3?=
 =?utf-8?B?SlFuZDN5cTNpZFF6emVPSHhSY3A4TkU2L0hiQytFUVBlcmJ2c09rQWl3WEgw?=
 =?utf-8?B?cmY4ODVlT04vc1U1THRaeUFtdzkwSVkxK0hlREZwbmY1UmExd2V5aHB3V3dY?=
 =?utf-8?B?MXBTZlJjd3JSQTIzN01vV0dmSHhsYiswR1hYL0lBM2xodVFneG1XRXNyd3Ar?=
 =?utf-8?B?Ymh2SkJ3aGdOOWIxU2RSc0sxRFBLUytlSFNqNzI2MDQyUzVXNmZWclhRL0hK?=
 =?utf-8?B?Y0dRSXdKTUZLeVh5V3Y1dTNHSWFwdHY2RHBvWmFROUdRb21yZ3F3OWxqelpl?=
 =?utf-8?B?cVc2SkMxUVloR0tzdmloTWk1SGl5UDlZN2pHZTJKZ3NHL0FoOUhwRjFVOVFO?=
 =?utf-8?B?K0I4N2VZeElOYUsyUkp2RW1lN3NnYkhsaStRYzFqVVJ5dHNiV2QwQnRjN1Z2?=
 =?utf-8?B?V0JxSkFHbjZ2Q2hTbkNDZmt1UjZDNkMzbHdaYVducEF4TGdZbmxVR3RQUjZt?=
 =?utf-8?B?d2FteFJwSGJvMkJWYitwNHkwTXlYRGZnc1lkaUdQdjlrdHRqcjRMalJjUzBn?=
 =?utf-8?B?WW91SWlrRklFZW0vdHVKZTU2VkxIcGtTNll3Q3lmcGlVb0RROGk3R1d3YXhO?=
 =?utf-8?B?UXpqcWhZK0pYRS9naWpXY1lQMHhkMlFFQkw0S2p2Uncva2JMOEdYcjFacWtL?=
 =?utf-8?B?SjR2UDN1UkxxYUxtNkdUK2pnQTBJMGk2S05aWVRWRitrWHYzdXAxOWd0RGty?=
 =?utf-8?B?c3NieFY3dW1nRnRKcGd3bVhmWHBDRmkzYWJjeWV4T1ExZVFORnJmcnN6N1kx?=
 =?utf-8?B?SW8xVHcwRmtjZWEweXNvSGV3d0RpV3ZlK3BLdENCOXNxc3RkNUhtSWhDY2VH?=
 =?utf-8?B?eTkzQzNiTTlXNis5dEREMlQ3Ynl1MVhxdi9EcGNMbVQrWjFhNTQxdmFyRHBP?=
 =?utf-8?B?V29QZ3hQdDlKYUtydDJwYXlBY0JZMk14UHA2aW1nbFRIWlJXR0IvMUVvS1RS?=
 =?utf-8?B?Z21wSDZsR3pCLzBBWHdUUDUzd2QwdVRHM05nMmhheFdCNTNBTFJOWHRqSm43?=
 =?utf-8?B?MFdKbndVR0ZzT3RUaGZnTEVRdkorNWp5VzZIeVYvemljWEh3c1Q4eUVBNWFu?=
 =?utf-8?B?V2pyaTZBby8veGZTYzRTVGNZTEUwOWQ1ZkdxelZTbnBGUFBwTnE1RHNyKzV2?=
 =?utf-8?B?WHhxaDNNdy9IY0wraHMvVjhpMHF6WFZ3d1VZRnllai9MYitDK3EwL09hQ0ww?=
 =?utf-8?B?WlZCVmNDUWxJbnA3NWpxL3V3Qk0yVnBJeGMxVk5FREd0V1Z0aEh3Q2U2bURU?=
 =?utf-8?B?d0tkK1RhRTlYbDhjdThZQ3NSaWh6WXh3MTBJREtzQ0ZuOXJVTXRjWGVnSE0x?=
 =?utf-8?B?ZG8ySmlob2tmMEI1YytlWFNQZXJORU1mRDNWSnFqaTRwZGF4cGcvanFnZmw5?=
 =?utf-8?B?a3g5dHJiNWtxTjU5a3VDQVEvY0xiSGJuUmVnN1UyZ3VTUEsxNVZCbXhzQWxn?=
 =?utf-8?Q?2Mg5FKhWiubZgxp5M0WgOt7ux?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C1DFC537E8C9D4D8A2AEACC6F027321@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07245625-5667-4da7-5657-08dca6fe0b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 07:48:42.1622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpeiWf+tXTbkCa5xT72z+avxa972jyNzCh2dlGiYTG4sPB6PCRuAuyuod/ZHsCIR8AecsJpMVbLclDnDflXvBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6722

SGksIE1hYzoNCg0KT24gU2F0LCAyMDI0LTA2LTA4IGF0IDIwOjAxICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSByZWZpbmUgdGhlIGZ1bmN0aW9uIHRvIGdldCBz
eXN0ZW0gdGltZQ0KPiAtIHJlZmluZSB0aGUgZmxvdyB0byBkbyBIRENQIHdpdGggY29udGVudCB0
eXBlIGFuZA0KPiAgIHByb3RlY3Rpb24gdmFsdWUgd2hpY2ggc2V0IGJ5IHVzZXIgc3BhY2UNCj4g
LSByZWZpbmUgdGhlIGZsb3cgdG8gdXBkYXRlIGNvbnRlbnQgcHJvdGVjdGlvbg0KPiAtIHJlZmlu
ZSB0aGUgZmxvdyB0byBkbyBIRENQMi54IGF1dGhlbnRpY2F0aW9uDQo+IHBlciBzdWdnZXN0aW9u
IGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRla19fOyEh
Q1RSTktBOXdNZzBBUmJ3IW1kNnhVaVlOODhEMlltRVRzOEZRZ2FFeE0yekg4UzFTbUFFVTlHUmNo
d3BOc1hPeURGdWwzemlWS2hScENKYWo4UmNuLWd2TS04MDFydW5qd0EkIA0KPiAvcGF0Y2gvMjAy
NDAyMDUwNTUwNTUuMjUzNDAtMy1tYWMuc2hlbkBtZWRpYXRlay5jb20vDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBtYWMuc2hlbiA8bWFjLnNoZW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCg0KW3NuaXBd
DQoNCj4gKw0KPiArc3RhdGljIGludCBkcF90eF9oZGNwMnhfd3JpdGVfYWtlX25vX3N0b3JlZF9r
bShzdHJ1Y3QgbXRrX2hkY3BfaW5mbyAqaGRjcF9pbmZvKQ0KPiArew0KPiArCXN0cnVjdCBtdGtf
ZHAgKm10a19kcCA9IGNvbnRhaW5lcl9vZihoZGNwX2luZm8sIHN0cnVjdCBtdGtfZHAsIGhkY3Bf
aW5mbyk7DQo+ICsJc3NpemVfdCByZXQ7DQo+ICsNCj4gKwlkZXZfZGJnKG10a19kcC0+ZGV2LCAi
W0hEQ1AyLlhdIEhEQ1BfMl8yX0FLRV9OT19TVE9SRURfS01cbiIpOw0KPiArDQo+ICsJcmV0ID0g
ZHJtX2RwX2RwY2Rfd3JpdGUoJm10a19kcC0+YXV4LCBEUF9IRENQXzJfMl9BS0VfTk9fU1RPUkVE
X0tNX09GRlNFVCwNCj4gKwkJCQloZGNwX2luZm8tPmhkY3AyX2luZm8uaGRjcF90eC5ub19zdG9y
ZWRfa20uZV9rcHViX2ttLA0KPiArCQlIRENQXzJfMl9FX0tQVUJfS01fTEVOKTsNCj4gKwlpZiAo
cmV0IDwgMCkNCg0KRGlyZWN0bHkgcmV0dXJuIHJldCBoZXJlLg0KDQo+ICsJCXJldHVybiByZXQ7
DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBkcF90eF9oZGNw
Mnhfd3JpdGVfYWtlX3N0b3JlZF9rbShzdHJ1Y3QgbXRrX2hkY3BfaW5mbyAqaGRjcF9pbmZvKQ0K
PiArew0KPiArCXN0cnVjdCBtdGtfZHAgKm10a19kcCA9IGNvbnRhaW5lcl9vZihoZGNwX2luZm8s
IHN0cnVjdCBtdGtfZHAsIGhkY3BfaW5mbyk7DQo+ICsJc3NpemVfdCByZXQ7DQo+ICsNCj4gKwlk
ZXZfZGJnKG10a19kcC0+ZGV2LCAiW0hEQ1AyLlhdIEhEQ1BfMl8yX0FLRV9TVE9SRURfS01cbiIp
Ow0KPiArDQo+ICsJcmV0ID0gZHJtX2RwX2RwY2Rfd3JpdGUoJm10a19kcC0+YXV4LCBEUF9IRENQ
XzJfMl9BS0VfU1RPUkVEX0tNX09GRlNFVCwNCj4gKwkJCQloZGNwX2luZm8tPmhkY3AyX2luZm8u
YWtlX3N0b3JlZF9rbS5lX2toX2ttX20sDQo+ICsJCUhEQ1BfMl8yX0VfS0hfS01fTEVOKTsNCj4g
KwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldCA9IGRybV9kcF9k
cGNkX3dyaXRlKCZtdGtfZHAtPmF1eCwgRFBfSERDUF8yXzJfUkVHX01fT0ZGU0VULA0KPiArCQkJ
CWhkY3BfaW5mby0+aGRjcDJfaW5mby5ha2Vfc3RvcmVkX2ttLmVfa2hfa21fbSArDQo+ICsJCUhE
Q1BfMl8yX0VfS0hfS01fTEVOLA0KPiArCQlIRENQXzJfMl9FX0tIX0tNX01fTEVOIC0gSERDUF8y
XzJfRV9LSF9LTV9MRU4pOw0KPiArCWlmIChyZXQgPCAwKQ0KDQpEaXR0by4NCg0KUmVnYXJkcywN
CkNLDQoNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo=

