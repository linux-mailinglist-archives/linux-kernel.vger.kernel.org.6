Return-Path: <linux-kernel+bounces-256211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8EE934AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769CC286D52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55D280638;
	Thu, 18 Jul 2024 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cOPBbmlN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KCX/R8zc"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49163399B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294323; cv=fail; b=ruSdAvNlpjQ7//aNKRK+WR/VyaQ6n22WbZQyykm5XvaQgwij0E7YDPN2a82SrvBJ0SmR2daJjIEJUa17gH7BRzh6B0SOSKtK7MqK6eXMyixek8v47BYP3TaCpIYecIUlkRFW7uZhwemoTEDSbT3uPsNPKBWY6bFIlO498uyfuq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294323; c=relaxed/simple;
	bh=Q2ucck1W4hUNKdHUBOJVX56yy9rLJM6+h7B8FTcgNfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VlodF/j+789rtzQK7EY3wyMLG6VAlbNtvVpdrwbmZLV2XZNL6t4C2DYJdfg+mQnjZ9kfKy8dWpMLC/8xjt4mEWc6gExegi1PV1jAntt1cJFpoAXN5XHiDy5J2S4SV0OFc+aPm+E+1ki2orJZTgzlCaiSJh5s7WkJPhCeq5P6JHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cOPBbmlN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KCX/R8zc; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b121b22c44e611efb5b96b43b535fdb4-20240718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Q2ucck1W4hUNKdHUBOJVX56yy9rLJM6+h7B8FTcgNfc=;
	b=cOPBbmlNbGHGz/w5rPz/t+HoxmhvKMZDOLBlfxS/W8AMQiDb9xwxTHPR6VB7JJu5eevTDI698BbDKm0Exzl1NO262c+TK8pYtsLhMmNNeLyd41pHOeMQeG93xafFlnBZ8oM9iLGSkQcVSB+9OpV77z/RYifVLwxPoIw7K/XiirU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:c999aae9-e1c5-4919-9a68-4cff80eb6340,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:58d1a1d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: b121b22c44e611efb5b96b43b535fdb4-20240718
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1792831783; Thu, 18 Jul 2024 17:18:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 Jul 2024 17:18:26 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 Jul 2024 17:18:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcYzBbXK3z/MF5sbMu7buIuBY5hb41jdlI54/DdEeLWK2jW2OTtzZvBlW3w86M7YKya5xoBE9XIgfLnqjwWFg/2HhLZ1uUYy5Hi2oR/yHJG8sdty/E+b3nUO/UFIQWjcD7HJeUl1QwIDc+KkyO7xb335/mQImDjWbpYMavsOhgTFZy698R09GxTkZfV7+cyq/++FUBsp4dVKqyJUE8eT8ndl0bOga7qdYbLpRfo+3gA+QUf27CvPB549GSpkr1309TG3ibrC7JCHMX5V7Fy22gWmaQ0k+eMICVnSphFtRvbkudgtvXV+G3ydcuTvCJbVIAh61tlgYcayy6m+vQASfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2ucck1W4hUNKdHUBOJVX56yy9rLJM6+h7B8FTcgNfc=;
 b=jk5udz6MwXRrPGTyp6x1OEYxXMxW+57jdQUduAYn6o2h5NUKVwRN4Z9lZrCY3vvEhVCeI6/U6BTNFRixFUKfDP6pBdGwwx0Ux/jXo4y4Qx9sUKN0aAVnlAX7icWXyYc440KXBRGckIuZqZmz1Yhk411Ik4IszikaXB4+CT5HF5lO24VrBKU//u0cMQGxI1cSMnY2GR2qfknZG9gZKZPNUhsONNlVbcwJn+6ysXerDPPf+kCowKR3Gq6g4ocruXk+OF63391QwOkkzxi8czagDP44IV1bsx7Avnk0nELv71252iGi+av/1NWrgJI3poTAFJF5K2yBp2vfunckRJZjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2ucck1W4hUNKdHUBOJVX56yy9rLJM6+h7B8FTcgNfc=;
 b=KCX/R8zcTIX7QJK8VfRtQXn9Ke804vJcG1evNXZQwb19tVZ+34zRmmKjagjtkPHoF9beOlRmQShUV4qevT6qH/a8YqQjgMp6o+c/qrNB2S/4KL95PdO0FWKxvFM/JcuEM8WL12m4PopH1nx2meQveTLrackqch54HBD02IsiX+Y=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by KL1PR03MB7055.apcprd03.prod.outlook.com (2603:1096:820:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 09:18:24 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a%7]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 09:18:23 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: "wenst@chromium.org" <wenst@chromium.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>
Subject: Re: [PATCH] drm/mediatek: Set sensible cursor width/height values to
 fix crash
Thread-Topic: [PATCH] drm/mediatek: Set sensible cursor width/height values to
 fix crash
Thread-Index: AQHa2OwJ1jJ6J2c1PES4z1w7FrxgD7H8LPKAgAAIFoA=
Date: Thu, 18 Jul 2024 09:18:23 +0000
Message-ID: <d2d0e23fd3b6a3dcdb164cc68020817669f23aab.camel@mediatek.com>
References: <20240718082410.204459-1-angelogioacchino.delregno@collabora.com>
	 <CAGXv+5GBg73kWuiDt=9s7M4oJeHhWOF3bPY7Ju+qn1kJgNNaGw@mail.gmail.com>
In-Reply-To: <CAGXv+5GBg73kWuiDt=9s7M4oJeHhWOF3bPY7Ju+qn1kJgNNaGw@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|KL1PR03MB7055:EE_
x-ms-office365-filtering-correlation-id: a3416b1f-9308-4953-fd6c-08dca70a9314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OFlXWFV3VmM5a09FMkdjL0NOYXdkb1plRWFlem9UR0N6SU5vcFQ5UUh4MmJZ?=
 =?utf-8?B?cU5VV2dETFVuY3VpWSthc0ZtU3JMYUFCVVNpMmJkOFhyL1h1M0xXWnloOWd5?=
 =?utf-8?B?bEV3VUgzSzdPTGNYdWZ3SlhVZGlqbW5vVVduTDdrL1NyZm9YRXdFTnlaMUJD?=
 =?utf-8?B?RVhpbEZFN2hhSEtkUTQxNWRjRE9sU0N5UndpcXRWdS9HV2E1TFJlNnFoQjFp?=
 =?utf-8?B?RzFHdXFqUW1xQjJEdGNLMmxvRjZDM3EvWEh5UEpEK3p2M0s5ZVJQWjNEN3Bq?=
 =?utf-8?B?STJlWXg3SnBaRVJEMkhtU1VrTy91dXlUVTJ0Z3ZvVlFCMWM0MzhsbnEvR0Fh?=
 =?utf-8?B?WHdOTTFlMlFKZ3A4NXZqODhtb1NZaVlPUE10UGdRWWNNVHR2RVVtOWlqdW80?=
 =?utf-8?B?UnBNUVBQYTg2eDFYVUY0dTh2dDkvc0xQVVc3RExNMXVIeHNNY2dVSDYvWFcy?=
 =?utf-8?B?ai9wOW11MWdNbUoxZTdxb2YzSnByZ2d0dDN6emtOQm9jeDFOM0IwMlI4TWU5?=
 =?utf-8?B?R1cwMDZ3UklXcWhHSDhYSG5MODFxRDNpNHFuU3ZsZ3htSkI5ay9iZnVFNVlR?=
 =?utf-8?B?K2JKZW54WXcrM2s1anVhWkp3S29Od0xJdmYrTWpYS0NEQm5JSnBiam9ka0lm?=
 =?utf-8?B?OFp4VnJjSEVObmt2NmxEenNIa2Jua2NNWHdFVWVTMEw5Smh5TGQxSWlDSG5H?=
 =?utf-8?B?eTVhako4dzB5c1BVTkF1a2ZBV0dUNVl2aXVHU2NydTNrU0U5a01DKzk3YitD?=
 =?utf-8?B?eVI1aXZMNWEvU3NvSzZZaURjeUFMa1hoMEJ5QnNFaXIwTk1WY3FWNTlTUnN2?=
 =?utf-8?B?SVJTeTRyNlJETzAwdjRZRlZiWUw5QU15ZnhndHQwckdhNEJPazVpWkV1SjNY?=
 =?utf-8?B?bGdGcjN6OHFGYXRJazg1R3YrbHdmWllnejB4LzZMYWNGK3NKWFZKQ0l1bjI3?=
 =?utf-8?B?ZjU4WTNwQkxzb3hwMGFWOEp0eTNuZlN3a0xQaWNKa08xV2Y3aW9SN3hrQU1t?=
 =?utf-8?B?QjZWQ1RVZmxCN3ZMaE9CM3ZWU2dydzlDQnd1a0hZNjU3Ly9sMldEcnh4TVUz?=
 =?utf-8?B?MC92SGhtdG92dUppWGpINWU4TEVFZXM0ZWtlMnNTWElUdDBTVDdMSkxoSkpY?=
 =?utf-8?B?KytYUkRVM0djU29TSDhocDJGNzV6M0ljS2k4SlBZeWlOQm42dWRXVDQ4UWxY?=
 =?utf-8?B?Q3N1SVFGWm1JMWxHM05nTVphdjNUYVVUOWI4WEpYdDNIRTJPU0h5clVSWm9B?=
 =?utf-8?B?OHcxOHlGeVRCTTZpTDBlc1cxRm85V29FZHF3RGlpakxLV0FQdE8raTVmMVNr?=
 =?utf-8?B?ejZqWkdhRjFRRm4zRW14emtLdEdHUzZFOEVoZjlyZ00rdTRrWVE0aGNxenhr?=
 =?utf-8?B?M3EyUitnNklSdk9BbXhBamdwaFUxRVlmcklUNFhBRHFRZ2Ftb3B5QmFFVmJn?=
 =?utf-8?B?RHcreStJa3FUY3RLckMwV2cyd3FqSzVGVEtMYnFPc2xKRG9QZ3BlK29yVHFC?=
 =?utf-8?B?UWpKeUR1TnMwSHlEUThuQjVBODdoeEhLQjB1T2VGeXh0OVFWS3NXKzFka0Vq?=
 =?utf-8?B?blAvN3NWdmpxUnpvQUM4cFVqRzQ3VHlJeW5ua0RnOGY3enk3TENNSVEzT0hY?=
 =?utf-8?B?aWxXTkxybUZUaGp0eTVkNWFaT1pxdTZLbG9hWmJsa0NpaERYOThvT2ZLdU9G?=
 =?utf-8?B?RERlUUwzcHp4enRmc05pdlhNT3BDeEZpMjFJNGw1MzIwdEdlVWo0T2h1TDhW?=
 =?utf-8?B?citaK1BBNVlmSDNES29HczB1Mk5nOUFjbVJJOWJ5WHF3YzU1Q1ZVSUNjdld4?=
 =?utf-8?Q?1ll8SpVKV9uT/OIo/VDaiSNFW45tY04VMzMM4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVRCS1ZaK2I4MzJsbndWeUl6WGNhM3NyMkJkUjY1RC9MM3FsYkNhUkxEWFhl?=
 =?utf-8?B?SDFXakhGSHlicHBrQkYxQWlzWkIvV2VCSE1OS3VIcnVmWHpCb3l4YzAwNFBh?=
 =?utf-8?B?Q2xpeXNHRWFYTjZrcFlPUnYvQUwyOGRENUpyR3RvMHZOdllqY3VzSnlnaWhC?=
 =?utf-8?B?VEd2eFFVbmZWeXR6ME9VcWhXQXFkTUNLNTNuZFQramJoSTNBZDQvT2JKSi9u?=
 =?utf-8?B?M1d6K0NFbjJLN2RNWm9VSDJPU2pmazUva25XODg3SkRsNUVrMG5zVkRCQlBw?=
 =?utf-8?B?dW1JSE15QUhNWTY3YkUxUFpEeS9tbWFPN0VTV3dOV3B5aDFGRXRVU3Nma0RH?=
 =?utf-8?B?SzVpdkczdDZaOFZkODVxSERGa3g3blVYa2Q5ek11ZzhKWWFBazlLVDNLMUJ0?=
 =?utf-8?B?Q2FpRllFbjVCblJzdURLQmJHQUhjekR2UDBUQUcxK2JGeUVzZXBYQTNOQk4x?=
 =?utf-8?B?UW1XL0E0SjRIalpCMDNlNGRITmVlUE9xTVlxTG1wdWNqbDJCNnByZDdLN3dL?=
 =?utf-8?B?TDBqRmthV2wxSlNxSzFTRTZ4NTRSUWtURnJVTWxMZTI4L1NnamU5cUU5MFZ1?=
 =?utf-8?B?NXl6OE0zZDk0cW1yMU1VZE55alMvRFY4UWE4RmtrNWMvcm94akpHdElsSzQy?=
 =?utf-8?B?WmNOdlJVeVZMZ3Q1LytuditERjFacWtQZ21neUpRN3pvZWprQjE4Rmo3aDlL?=
 =?utf-8?B?UC9IS0J6dy9GM0U3bW9iMmVKeVlzNUFPdTJUUW1kcVNJYzdsL2crQTRkemw0?=
 =?utf-8?B?NzFDcXY0bXFTKytnSW9HZW9wd1BsSGUwSVNZMmhDTUd1R0tHRHNSOG94QVpt?=
 =?utf-8?B?cFdlenV1WFgwNUw3dWRXTHZraC85c2VTWlFWUzRyVitNOUpNSFZ4dFdXTlBB?=
 =?utf-8?B?Uk95RHBpZDJWeEk2TGlhVEUvTVpQQ3ltanFvYU91T2E0ZW9LWkc5bVBvRnNr?=
 =?utf-8?B?ejl5eiswdFZubHhMRVZQODE0WVhKMDQrVFBTN0RMZloxNk5lUXQ1R015RFA3?=
 =?utf-8?B?bTlxaWFGTXROOVMwM2VXa0RGUDB6MG92bGJtMWRTajZzOTMraHRWNlI3bE40?=
 =?utf-8?B?QUc2cGM0VnJwcTR2a0RPK290VUFwaG03RDdJUXI1bGhhWi9HMmhTaHYvdXdw?=
 =?utf-8?B?ZW9SSTdOLzBFVXVmUEJDUUlmZ2JhcWR6VjNqaXFHcGVsUkhobEtxYkZMNGpk?=
 =?utf-8?B?MnJycm5laytPcFBKY0dPd2UyNFFFN3U4L1c5aVllK2tQQW9LeVRLbFd2YjZP?=
 =?utf-8?B?SEJOdkNqQXE0czNCRFpwcVA4ZUVQQTVGN2h4aWdGWWVDcEphQ0xVSFBnc0hV?=
 =?utf-8?B?U1FWNitXc21xeFdkK2haZVJkRk9EY0xqSHNqd3l5U29uVCtuSWRpd2kwVDVU?=
 =?utf-8?B?WDlUblhsVE9kMXRBbWRuTWtmQ0FxdWZJb1o5QzZ6UHhxWHo3b3E2VWNiejhI?=
 =?utf-8?B?TStIUmhKSVpqSDNlTFcyQ0lrVTBETUpYT29LSVlnczlCTDhSR3RWdTBKWVJv?=
 =?utf-8?B?KzQ1N25kQ3RqcFpPaTAzYkdHMjBic0I4Yy9jL2NwZWoxcTJaTzdIdjUyb25w?=
 =?utf-8?B?bFk0WkEvd0ErcEIzZlc4b29xMi9LTGNBd1FLa0ZpbkRhcmlOcW9EalBPWTFJ?=
 =?utf-8?B?c0NkSHFCN0dSN2xEdGhqdnRqWnV1dGpTMTJDbUFodG9Yc0tSa3k3NDcxaW11?=
 =?utf-8?B?aVkvbFJtampTV0s0RnJpZTRGN3ZqcXR1Ujk1YXpwWm44bzY1ZVZ1TURTb2pu?=
 =?utf-8?B?eGJqL1UwWnpsbk1TN25YaHkwZVFqaXUzK2Vyek43bDBoYnIxYURFeFRHcDBV?=
 =?utf-8?B?ZUZGMU5oUEI4N2RRVktoMkhCenFZamJ4d3J4b1dtZVQ5QU5OcFNadTZ3Q1Bh?=
 =?utf-8?B?WFNVb2FnUm5uQVNsWk8wY1ByTnNCT2JydC91aVR6NThRdWw0RGdyR2JkR3cv?=
 =?utf-8?B?eC9RdGR1N0c5bUhVSVFHVGtBSGx1SmJLTC9mbVRheTBPdHk2SE1sbTRVOEk0?=
 =?utf-8?B?bW5obC9Hb1lYTDJTWnVMUjlnRXR5TURpOS9kU1l3STNLaEIyK0JHeTk4U0Rx?=
 =?utf-8?B?ZVpxY0hqQXlYOXRMaVZUMmZINnQ3RGJzOElBdDlkOGVKcWtEL2RuS2RJeHdm?=
 =?utf-8?B?VlE1NE5BMFhxNEM3VEdCUjZDUnlWTkwzdUJ3K1NKZTFUamNUOGxjdG9sYUVi?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4891D106A76B04D85825B03265BD91D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3416b1f-9308-4953-fd6c-08dca70a9314
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 09:18:23.8341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QHMqjmXsp/JkG+X+IjQ31Jzdv1HC8Ktynw03Lcr1KiQsJ8cYcAFPTcl0DOsIzy2Zq6a9oL1AzQiipW4ql+58g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7055
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--25.008300-8.000000
X-TMASE-MatchedRID: Q8pJWSpPf0PUL3YCMmnG4na57ruHAnHxT9kSL7SwB1gNcckEPxfz2DEU
	xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+Cz2SmpAaY8c5lPWpfvgNzrmtQT
	1ZMRQNu3MSfZ2vYbJ2KCX8ek9LY/nm+s0jtagLuSzI1v7J4hECsRAIWyy46arTiKNDvuWVeGwQl
	iWBbE2ab9dqbm35MViYSKmTHn75DHDmEfzPAj6OgPZZctd3P4B7f6JAS2hKPjgb8WBYTcHTPBUq
	5JsuvxSySv9brk5+uTa8FmcOc4lE46gtlcQ6W8JngIgpj8eDcDBa6VG2+9jFNQdB5NUNSsi1GcR
	AJRT6POOhzOa6g8KrZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.008300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C69C42967F08116801E6B5F005F4DE7C475CBD50C5455C5C9D05C6043427ABAF2000:8

T24gVGh1LCAyMDI0LTA3LTE4IGF0IDE2OjQ5ICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
ICAgIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgKENDLWVkIEZlaSBTaGFvKQ0KPiANCj4gT24gVGh1LCBKdWwgMTgsIDIw
MjQgYXQgNDoyNOKAr1BNIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+IDxhbmdlbG9naW9h
Y2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQogd3JvdGU6DQo+ID4NCj4gPiBIYXJkd2Fy
ZS1zcGVha2luZywgdGhlcmUgaXMgbm8gZmVhdHVyZS1yZWR1Y2VkIGN1cnNvciBzcGVjaWZpYw0K
PiA+IHBsYW5lLCBzbyB0aGlzIGRyaXZlciByZXNlcnZlcyB0aGUgbGFzdCBhbGwgT3ZlcmxheSBw
bGFuZSBhcyBhDQo+ID4gQ3Vyc29yIHBsYW5lLCBidXQgc2V0cyB0aGUgbWF4aW11bSBjdXJzb3Ig
d2lkdGgvaGVpZ2h0IHRvIHRoZQ0KPiA+IG1heGltdW0gdmFsdWUgdGhhdCB0aGUgZnVsbCBvdmVy
bGF5IHBsYW5lIGNhbiB1c2UuDQo+ID4NCj4gPiBXaGlsZSB0aGlzIGNvdWxkIGJlIG9rLCBpdCBy
YWlzZXMgaXNzdWVzIHdpdGggY29tbW9uIHVzZXJzcGFjZQ0KPiA+IHVzaW5nIGxpYmRybSAoZXNw
ZWNpYWxseSBNdXR0ZXIsIGJ1dCBvdGhlciBjb21wb3NpdG9ycyB0b28pIHdoaWNoDQo+ID4gd2ls
bCBjcmFzaCB1cG9uIHBlcmZvcm1pbmcgYWxsb2NhdGlvbnMgYW5kL29yIHVzaW5nIHNhaWQgY3Vy
c29yDQo+ID4gcGxhbmUuDQo+ID4NCj4gPiBSZWR1Y2UgdGhlIG1heGltdW0gd2lkdGgvaGVpZ2h0
IGZvciB0aGUgY3Vyc29yIHRvIDUxMng1MTIgcGl4ZWxzLA0KPiA+IHZhbHVlIHRha2VuIGZyb20g
SUdUJ3MgbWF4aW11bSBjdXJzb3Igc2l6ZSB0ZXN0LCB3aGljaCBzdWNjZWVkcy4NCj4gPg0KPiA+
IEZpeGVzOiBhNGM5NDEwYjMxY2EgKCJkcm0vbWVkaWF0ZWs6IFNldCBEUk0gbW9kZSBjb25maWdz
DQo+IGFjY29yZGluZ2x5IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERl
bCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgfCA0ICsr
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
cnYuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ID4gaW5k
ZXggNmYwYjQxNWE5NzhkLi5iOTY3NjM2NjRjNGYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+IEBAIC01NDAsOCArNTQwLDggQEAgc3RhdGljIGlu
dCBtdGtfZHJtX2ttc19pbml0KHN0cnVjdCBkcm1fZGV2aWNlDQo+ICpkcm0pDQo+ID4gICAgICAg
ICB9DQo+ID4NCj4gPiAgICAgICAgIC8qIElHVCB3aWxsIGNoZWNrIGlmIHRoZSBjdXJzb3Igc2l6
ZSBpcyBjb25maWd1cmVkICovDQo+ID4gLSAgICAgICBkcm0tPm1vZGVfY29uZmlnLmN1cnNvcl93
aWR0aCA9IGRybS0+bW9kZV9jb25maWcubWF4X3dpZHRoOw0KPiA+IC0gICAgICAgZHJtLT5tb2Rl
X2NvbmZpZy5jdXJzb3JfaGVpZ2h0ID0gZHJtLQ0KPiA+bW9kZV9jb25maWcubWF4X2hlaWdodDsN
Cj4gPiArICAgICAgIGRybS0+bW9kZV9jb25maWcuY3Vyc29yX3dpZHRoID0gNTEyOw0KPiA+ICsg
ICAgICAgZHJtLT5tb2RlX2NvbmZpZy5jdXJzb3JfaGVpZ2h0ID0gNTEyOw0KPiANCj4gRmVpIGFs
cmVhZHkgZGlkIHRoZSBzYW1lICg/KSB3b3JrYXJvdW5kIGRvd25zdHJlYW0ganVzdCByZWNlbnRs
eS4NCj4gDQo+IE9PVEgsIEludGVsIHJlY2VudGx5IGFkZGVkIGEgZmVhdHVyZSBmb3IgZW51bWVy
YXRpbmcgInN1Z2dlc3RlZCINCj4gY3Vyc29yIHNpemVzLiBTZWUNCmh0dHBzOi8vcGF0Y2h3b3Jr
LmZyZWVkZXNrdG9wLm9yZy9wYXRjaC81ODMyOTkvDQo+IA0KPiBOb3Qgc3VyZSBpZiBvdGhlciBj
b21wb3NpdG9ycyB3aWxsIGVuZCB1cCB1c2luZyBpdCBvciBub3QuDQo+IA0KPiBDaGVuWXUNCj4g
DQo+ID4gICAgICAgICAvKiBVc2UgT1ZMIGRldmljZSBmb3IgYWxsIERNQSBtZW1vcnkgYWxsb2Nh
dGlvbnMgKi8NCj4gPiAgICAgICAgIGNydGMgPSBkcm1fY3J0Y19mcm9tX2luZGV4KGRybSwgMCk7
DQo+ID4gLS0NCj4gPiAyLjQ1LjINCj4gPg0KDQpKdXN0IGZvciBtb3JlIGluZm9ybWF0aW9uLCBh
cyB0aGUgZHJpdmVyIGlzIGRlc2NyaWJpbmcgdGhlIGhhcmR3YXJlIGxpbWl0YXRpb24sIGFuZCB0
aGUgY29tbWVudHMgZm9yIGN1cnNvcl93aWR0aC9jdXJzb3JfaGVpZ2h0IGluIHN0cnVjdA0KZHJt
X21vZGVfY29uZmlnIGluZGljYXRlcyAiaGludCB0byB1c2Vyc3BhY2UgZm9yICdtYXgnIGN1cnNv
ciB3aWR0aC9oZWlnaHQiLiBBZnRlciBmZXcgZGlzY3Vzc2lvbnMgd2l0aCB0aGUgcmV2aWV3ZXIs
IHdlIGV2ZW50dWFsbHkgc2V0IGl0IHRvIHRoZSBtYXhpbXVtIHNpemUgdGhlIE92ZXJsYXkgc3Vw
cG9ydHMgKGQ0NmY2NTJmYzlmZGU2MWQ3ZTg4YmZlYWNlNjJmMjc4NDdkNTVkNDAuY2FtZWxAbWVk
aWF0ZWsuY29tPikuDQoNCk5vdCBzdXJlIGlmIGl0IG1ha2VzIHNlbnNlIGZvciB0aGVzZSB1c2Vy
c3BhY2UgY29tcG9zaXRvcnMgdG8gYWx3YXlzDQp1c2UgdGhlIG1heGltdW0gc2l6ZSBvZiB0aGUg
Y3Vyc29yIHBsYW5lIGFzIHRoZSBjdXJzb3Igc2l6ZS4NCg0KUmVnYXJkcywNClNoYXduDQo=

