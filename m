Return-Path: <linux-kernel+bounces-327527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33773977727
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAC1282894
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACE01D27BC;
	Fri, 13 Sep 2024 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SJznhN0C";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DIb9OdNR"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494D40C03
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726196174; cv=fail; b=YHwBhCNyO6TRHNCS1fv0lyxuhN/6uYYC0vMb7D/awDJBbltVsypj5XKQ4OhO/55rFJQp8qqS4KdOjI3lghZfDvHzU+ApYWauckaJSgSPOT8VsFhp6T6RtvIoy4H+I09oqaMtX3DdaNsZ/Z7GVnszmq65x/dOC9S5P1efslPd4iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726196174; c=relaxed/simple;
	bh=UfFzg+6YXCiVjUQ5DbNUIL4X6mM7PnAIW3qLXsaZ5gU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CnHATWUzfLeDxp7zb01KRkiFDi1Ne77Kj8gqrWqdg3WDXEiqFoIXZbUVLdeZYmvMsqU6lETD0TbOOJXSr1uFQIWlpNEus8asfoqGgoRWYHXOUnvbDXfNyedIs6Ze2Mfvm2VUuotLejPBdB3ZR4/xoPBsL8nmpidyqQIfq9qfqwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SJznhN0C; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DIb9OdNR; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b84cb65c717b11ef8b96093e013ec31c-20240913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UfFzg+6YXCiVjUQ5DbNUIL4X6mM7PnAIW3qLXsaZ5gU=;
	b=SJznhN0Cl8dU9VQLIFzBeLyyG/mF7fiCt4GweEmIIfUB1ZlEOEBKlFdk0I+OdOME11qlgl7eE2/TsgJF5yx6DOvs02kxR40SAAMuStIpYS8denHDiXb/91Hj0cqQMb5pdDh2XkwZf5JDb76zpu8lFg6gsApQkhi8Fz1C5MeKyX0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:27883abc-2c8e-4033-b825-7bcdaf445f86,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:031df1b6-8c4d-4743-b649-83c6f3b849d4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: b84cb65c717b11ef8b96093e013ec31c-20240913
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2082790834; Fri, 13 Sep 2024 10:56:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Sep 2024 19:56:04 -0700
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Sep 2024 10:56:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWJHhXIclI45BQ8T2/ZQ8X9b77vaPp1EL2VUXoc2irgzY/0b645+80iqW96knBQqc6jjqKyEmOrdcNSAO6X5xNHY9abNqLk5W3gsAurgeACqgoWG6qVocWFwqjLCRA+RE8tRmsTchpHgYDzHRGUvlShExVjPIKTnMIfBh/FyRxfOy2d/jJAjItNDRcZ9C5ZVlUv4NBuglFIhSdcQxy1c2yyVUrmw8Cm1wc95KDjDj3z1C9huOU57gYcSpJ6JANDEKju1llYrU309Lq02yvX/Y4mGfsmmtVXORGBhv35uX28yhoEqYPeGg2WSqoGKi/c7Q6lIltzfhlPTG4OPCct3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfFzg+6YXCiVjUQ5DbNUIL4X6mM7PnAIW3qLXsaZ5gU=;
 b=QrYHzLXnzV7AHea9CHxBaKPXGg1HbrnZkAicTd/YfY1XZ18iBn8N67T+Ia9dq+NGTudVv8dIuu/OXWxxkdxctZpDUf5IQk8KajFh8uBvImFxm2yJe6DrdHv7GbBk9Wi+1cd9ioyVgGZSdpAwuRXUoIScWD1VeUAJ4eRCW88GGj9p9VqycASBxu+Z5HAZTLVATVX85faWv8SbaX0kWln/KQ24DAK1UN7IQovygBYhjTtI7HrcmaTgplDef21K+8Kyii7F8jHoxauo5s/G2fXKgsmN1oAY43uKUKLAEbRn5XevIWzNlk2ZlqfRS80v6ZhFWMFDrCzftWpdbrTfST1CKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfFzg+6YXCiVjUQ5DbNUIL4X6mM7PnAIW3qLXsaZ5gU=;
 b=DIb9OdNRSyxXMrDVdYxPAbKY4tgPyXi0J/zK6XKWuAGA0I49Q7cJf/CBll7wmUtMeTciBp0SYQQ2SwCkOXqgtXshk/PU+TtNuctzUfcHl+uij58T+M3BZIvg5nOuzxebUGNSrHyukB2GkpwD3B5KQGCAm4gWsOhEqrMJ921DtUs=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by JH0PR03MB7378.apcprd03.prod.outlook.com (2603:1096:990:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Fri, 13 Sep
 2024 02:56:02 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a%3]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 02:56:01 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"shawn.sung@mediatek.corp-partner.google.com"
	<shawn.sung@mediatek.corp-partner.google.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 0/5] Support alpha blending in MTK display driver
Thread-Topic: [PATCH v4 0/5] Support alpha blending in MTK display driver
Thread-Index: AQHbBYh3NpcoLhj9zECkgtfWkFIbjA==
Date: Fri, 13 Sep 2024 02:56:01 +0000
Message-ID: <26504ee033e506db17fc130d08b2f85a187af2e7.camel@mediatek.com>
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
	 <CAAOTY_8ThuusfHk9Gd5pFP8VhJkG2seuJmkFiruK1rPQFZGBzg@mail.gmail.com>
	 <6c9b7f85-f92d-44ed-ae9d-00f6d55ea614@gmail.com>
In-Reply-To: <6c9b7f85-f92d-44ed-ae9d-00f6d55ea614@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|JH0PR03MB7378:EE_
x-ms-office365-filtering-correlation-id: b55f3e7b-c96f-4e1b-7088-08dcd39f99e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a1FHMENkcVltUzdjODJ3NDVMNjh2aklUakpsWTdHNit2SmZzdmdZaUZrbUdK?=
 =?utf-8?B?dm04TXFaQkhLelFwZmhNemR5aSt1c1NEYnlqMm5zNDVuY3FZdUhjeGMwVHd3?=
 =?utf-8?B?OXNLYUhWU1VBeTQyMENlejdQbmJpOXAxRDRNTGFwS1ZuRWw4THJPa1JySHlR?=
 =?utf-8?B?Z1VDb2UzOVpZQ0NFd3dEUVU2UGRDRmQrVUNqbTg5SFZZa0xPRUhKMlBaZHEz?=
 =?utf-8?B?SkZET0VMbXVlaFdudzBMU0xpSWREWUpwMWRuampSWEdNT3AzQklqR3A2QzZh?=
 =?utf-8?B?WnhSRzlqdUFDYm1XREduelFrTUZzY2c5OUIwVTVzdFJPajFjOWRaZ0o0QkFQ?=
 =?utf-8?B?Rnk3TGs3U0NiZDFpT2d4UVB4Y1d2cUp1NGxpZWFOU0xkRTZub25zSnZzeWJ1?=
 =?utf-8?B?T0NSL1p3TEp6RnZQTjFCRHBHZjZJZ2hQdmljSjJwWloxQzFIZ21OWmc4MUJj?=
 =?utf-8?B?amthQ0VpWVJ3Z1gwN1dFWi9XWFdBWlNQak9Cd3FQZWV4TzZYMWFkcENKbE9u?=
 =?utf-8?B?U2ZHZkdlTm1yeUZQYUh1SlhIUzFPRHNUU0tFUExOMFo5NGN6WVc4NUpXVVly?=
 =?utf-8?B?TXJocVVRSzN1czZoeDdBN1ptUExCNksyVHNwaDNEL3BDM3NwKzBndWxqTG5O?=
 =?utf-8?B?SWV6M05EeXNpeGNPamp2dC9MRnhQM1lpbURKL1p1OSs3aU1IdFMvN2s3R0dq?=
 =?utf-8?B?d08vTWozbU9zWXRnTTBOaThaZkFXN3VjclVQM1BUbDZmaHZiVDBxSm9FVmNp?=
 =?utf-8?B?ZnM1TGQ5R2MveUlHWE9QeDQ1TEo3SWlrZ0ZsUXNuVElPWjkzM3dDMW52bGpN?=
 =?utf-8?B?a0Q5Z0FaUWJIeldJT3IvQWFOZXJrY3J5TmljN2lDZ1RWY1NXTUFOcmwrS3BY?=
 =?utf-8?B?SjBxTk5hNmpqS21EcU03R0dBWUoremh1by9RTW9OTXpDSDgwT21scWdrekpP?=
 =?utf-8?B?aG14WHpPS0NTRW9KNmc2ZTB4OHBpWkladndzY25ZTTdheXZpbTUzcXNscFRu?=
 =?utf-8?B?ZkZoaVpNODg3cHg5UVU3b3k0enppQkg2dTdXQXVtMVVXR0pWM0w5Z2hrUWxr?=
 =?utf-8?B?WVdIQXVTMnV2cDgrY280czF5cEZnNGNtRm5XV0Vhdkc3WG10ZXZhZVZUaHhQ?=
 =?utf-8?B?MldQZHN0SDhwYUgxb09tTlB6T2tzdUc1UzNiSG1iVERidHJKNENXSk9najFH?=
 =?utf-8?B?Y2VBcjNxV3hJUmlPZW1Sd2VUWVN1ellHWU1LZ0hZVGsxNVY0dkFyZDAxSGRK?=
 =?utf-8?B?c0xPZGRMdSs4V1JuaXB4YUJQYzMrK2lhMzNkb2V3SnVHVE1zS0Y3dVM3WmJX?=
 =?utf-8?B?ek9zMmtUUFhVbER2MzlZd3lCeDBwQmdoNU5HUG1SWDBGVFA2Wmg3K2szTzZZ?=
 =?utf-8?B?a0ZQUXlBQkp4czh6bGdTQ2NESTR1cnhuUlZXak92Wnl2cHBEdXBTZXZPMEsv?=
 =?utf-8?B?YTI3VDRGRmNGN0lMWjBvZ2NtSktvVkFUZmJheGk2VmVzMHAzM1RzQ1Q2b3Vl?=
 =?utf-8?B?Z0dBWG05ZmdHNmdUOUpUaVpuckNaMm8xbEFBbm81bWdXZVdGSzBmQnBmemlE?=
 =?utf-8?B?a2d2b0NCeVFEV0VIc0dKSjFHRUNZS1B2bnBKQ1laV3lEZFVWR0p1c2FETkxT?=
 =?utf-8?B?MGV6OTluV1Y4ZFljUzgxdWdiSGxNTlE2UUFDT25ISHBKYkZMU0NtZTVGQnJr?=
 =?utf-8?B?ODliNVJOVFZIRGhSNnkvN1NlY1BhRUZ0WWptajl5NW9SanNDNHVZRTROaXUr?=
 =?utf-8?B?aEFlQktDcjdXOVdCS0FJUzZ6d3E3REdITWhNeEZSRHR2bVRHQnlOc0NSblFh?=
 =?utf-8?Q?fg1CYabffskYXitcVEr8h1hpJiQLmeSto8Uuo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHJqUS9YU3o0MlVrM3FtNWFLNmJIUHZva1ZiRlRsMG9HUjFFYzlqSExveGlR?=
 =?utf-8?B?ZkxFOGxNQTdSeC85Qnl5QTBicVU3WklOdm9ETzd2aGNhVmZCRDJVdjMydFFU?=
 =?utf-8?B?ejVXV0dZOVpRWE94RWsxU2NjZmNpZk1wVGhQMnhuQVVmY0ZkdHRUN3FoUkcv?=
 =?utf-8?B?Y1p2eFVmTWJMUDFSUmora29DNWorbFdFdTFTU1MrREx2VmNrUVA1WHJqYVhq?=
 =?utf-8?B?Sy9ISkJ5NS9WdzJJV2F1ODh5c3lMTjNTWDJRdlJtZ1JNKy9qWXNVd1ViQU1K?=
 =?utf-8?B?Rld4cm5WMHBTbXRlOUpTQ3NQNnRhMzFjYkVZUGJRd3R1Z2o2OTJ0TTNaVExI?=
 =?utf-8?B?MHpwZ2Rhb1c3Y2ZoWkVWbVpJaDdHL3FDcTM2SWlvbDNsQ3VTNWczdng0VVRC?=
 =?utf-8?B?czlMVE9VQzkydEFFQkJBM1NEclVNTDk4cWdkdTV3VUdwSU90OExOUHdrYmw2?=
 =?utf-8?B?Mzk3M3hqQlAxR0pvemlBcVlYVndGQ1FFclE1L0xIZTdGc0VqeFMxanRqT2Yr?=
 =?utf-8?B?ajJFU3pJZVd5SkhRcmF3a244bGdpQk1RNUgvZE0vNmVERkRmbW1qd3NQNE4z?=
 =?utf-8?B?OW9HaHVQVXc3Y01LN0ViQ1Mvb2hGQkRCT3FINDNXbWhpYXBGYzdsU2pXZGV6?=
 =?utf-8?B?Z0psZERtb2JxWUFQQnpmRDdhTlgrNk85aGI1ZXkzaDZVVXViTHVOWnBaMFhp?=
 =?utf-8?B?ZW8vYzRBL2V0a3RkeXFCT09TSGNwRFYyVXNiTmc3QjdieXEvZUtyQXJEOGNI?=
 =?utf-8?B?SVJ4c0laWGhiemtacW1udEdIc0Zza1VEeDY3a2IrYmhBamZEL1JXQkk4RHdW?=
 =?utf-8?B?ODdXS3hKVzBCdlY5dnhIYVFpeDBJeGg1RWhsb0ZjQjVDV3hZRmNSeUVNWTA0?=
 =?utf-8?B?MkJhSG1ENHJHRkNNaFBicEl4TVVsaU5iL3NiUDJCb0JHVG9pellVOFZBZUNO?=
 =?utf-8?B?NGVoMWh0VEVvTnNuVVpEU1BLZTBRR2s2U21xMEhpVkZoaFhVdWFvcXRyQVJD?=
 =?utf-8?B?RmpqWm1QbnhwN1JVUE5zSFZrSWVHY1JVRUZ0MTNseHcxTDd3MGtHaE83Q0Vj?=
 =?utf-8?B?OTdzbjVQS1RLT0FtVjRMd1B5VzRmSHhNN3dEeG82S1NjbXN2R0lhSXBFbDBl?=
 =?utf-8?B?MjdrNGxXZVNhMmFYdEVFS3hCVE00b3h1VjNnYXlta0JKWGdlSlpQMW1qYS9s?=
 =?utf-8?B?MTFrVk9FMzlIYW15SVNQc01oT0Z0dHVWbFZxck1WV1p2YkVCcEV4VmhKa05G?=
 =?utf-8?B?LzMrYW1QSmk1YXVGU1hxRE9ILzF2cndsN3c1VDFWTXFEVy9HZUs0bGJKRUJa?=
 =?utf-8?B?dThyOXB5Y0hWMWhqazcyeHVTUGE1a3BlUnVKYVFuNnNtamJGWmcvb3hjaVJW?=
 =?utf-8?B?Qlg4RmFHOWtNUlRYT2hYY3ZrZXVFVlRsNFJua1BCbk43bkw5aWNjQ1F2cGQ3?=
 =?utf-8?B?ZTdXWm56eGpDanFwNHNMK3E2aCtJU0NyZFVhWSt0U25PaG5Gc3I1NnNrcXlh?=
 =?utf-8?B?UFN2YTVmQzE2cmZ1dThNcWx4ZDFLYlNYWjZOUzEyV1FvL2JEVmpuNm14MHRM?=
 =?utf-8?B?aTJaSHZRL2ZIS2tWTFdhczgvSUdQdU9Sa2RLU3hhdWwwTUE1NUZZaGZpZXdU?=
 =?utf-8?B?eEpKelZBcEM4RlpKRHErQUZ3RGVFUVNYdzRzQUFpRTVUMEhqRkFsWHI3U2pY?=
 =?utf-8?B?ZEd3MTVXK1N0NTlROHN3cU12Qkk0RDFqZkMvb3lNK2dlZTYwSDU0TDRSSjJM?=
 =?utf-8?B?aWxickpkUkp1NThXYUxQMnJCRFpvQ2huanQ0UjdKanFrNVZ4UEM5QmJqbDA0?=
 =?utf-8?B?VWRqbTE1SnNUZ1diLzBWVXJIYnRWNVYrMGZTMFZGaVZzd3pseE9BSFhrc1BI?=
 =?utf-8?B?dXRkVHFuY3VuL08zUkFTWVlXOStORXZ0NTNQcVNEUEV5NW95N1BvdnJXUlZN?=
 =?utf-8?B?anpqRi84WVBoZHVTWGRKdDl3STRUcFl2UGppSGNVTmtHMEMzUnN1YWoyL3ZT?=
 =?utf-8?B?R3NSWlgydzNULzl5alBkREtrYXVmWGdrTjRXenhRL2lqTDFoeGlSZlNRWms1?=
 =?utf-8?B?TlA1cjk4Mjh2cGJVS1RBZC84bVNpd0tLamJyQXppR3ZnUHVYODNjQUFYaTBD?=
 =?utf-8?B?a1ZkMDU5alBMYXplc3hPR2RJSDNJbFN2bFpnVHNtL1g1cVRrQS84R0JRTW56?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <888F74A8BA18B94083F3342A46A8DD84@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55f3e7b-c96f-4e1b-7088-08dcd39f99e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 02:56:01.4049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vbSOxOFUSkcbKs8p0XRayNBzj9qCnn8kN1hX23uEuM3l5FdjUq09CLvxf0Jeb1KQURGTezTzeSCdeouBP7rRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7378

SGkgQWxwZXIsDQoNCk9uIFRodSwgMjAyNC0wOS0xMiBhdCAyMzoyOSArMDMwMCwgQWxwZXIgTmVi
aSBZYXNhayB3cm90ZToNCj4gSGksDQo+IA0KPiBPbiAyMDI0LTA3LTMxIDE2OjM0ICswMzowMCwg
Q2h1bi1LdWFuZyBIdSB3cm90ZToNCj4gPiBIaSwgU2hhd246DQo+ID4gDQo+ID4gSHNpYW8gQ2hp
ZW4gU3VuZyB2aWEgQjQgUmVsYXkNCj4gPiA8ZGV2bnVsbCtzaGF3bi5zdW5nLm1lZGlhdGVrLmNv
bUBrZXJuZWwub3JnPiDmlrwgMjAyNOW5tDfmnIgxN+aXpSDpgLHkuIkNCj4gPiDkuIvljYgxOjI0
5a+r6YGT77yaDQo+ID4gPiANCj4gPiA+IFN1cHBvcnQgIlByZS1tdWx0aXBsaWVkIiBhbmQgIk5v
bmUiIGJsZW5kIG1vZGUgb24gTWVkaWFUZWsncw0KPiA+ID4gY2hpcHMgYnkNCj4gPiA+IGFkZGlu
ZyBjb3JyZWN0IGJsZW5kIG1vZGUgcHJvcGVydHkgd2hlbiB0aGUgcGxhbmVzIGluaXQuDQo+ID4g
PiBCZWZvcmUgdGhpcyBwYXRjaCwgb25seSB0aGUgIkNvdmVyYWdlIiBtb2RlIChkZWZhdWx0KSBp
cw0KPiA+ID4gc3VwcG9ydGVkLg0KPiA+IA0KPiA+IEZvciB0aGUgd2hvbGUgc2VyaWVzLCBhcHBs
aWVkIHRvIG1lZGlhdGVrLWRybS1uZXh0IFsxXSwgdGhhbmtzLg0KPiA+IA0KPiA+IFsxXSANCj4g
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaHVua3Vh
bmcuaHUvbGludXguZ2l0L2xvZy8/aD1tZWRpYXRlay1kcm0tbmV4dA0KPiANCj4gSSBhbSBzZWVp
bmcgYnJva2VuIGNvbG9ycyBvbiBhbiBNVDgxNzMgQ2hyb21lYm9vayB3aXRoIG5leHQtMjAyNDA5
MTIsDQo+IHdoaWNoIGdvZXMgYXdheSBpZiBJIGdpdC1yZXZlcnQgdGhpcyBzZXJpZXMgKGNvbW1p
dHMgMWY2NmZlNjJjYzA5DQo+IGViMTdjNTkwOTQ4MSBhM2Y3ZjdlZjRiZmUgNTllOWQ5ZGUyNWYw
IDQyMjVkNWQ1ZTc3OSkuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4gSSBhcG9sb2dp
emUgZm9yIHRoZSBkZWxheSBpbiBteSByZXNwb25zZTsNCkkgd2FzIGp1c3Qgbm90aWZpZWQgb2Yg
eW91ciBlbWFpbCBieSBteSBjb2xsZWFndWUuDQoNCj4gDQo+IFRvIGlsbHVzdHJhdGUsIEkgdG9v
ayBhIHBpY3R1cmUgWzFdIG9mIHNvbWUgY29sb3IgbWl4aW5nIGRpYWdyYW1zDQo+IGZyb20NCj4g
V2lraXBlZGlhIFsyXS4gRG8geW91IGhhdmUgYW4gaWRlYSBvZiB3aGF0IGdvZXMgd3Jvbmc/DQoN
CkJhc2VkIG9uIHRoZSBwcm92aWRlZCBwaWN0dXJlcywgaXQgYXBwZWFycyB0aGF0IHRoaXMgaXNz
dWUgaXMgcmVsYXRlZA0KdG8gdGhlIHdheSB0aGUgTVQ4MTczIGNoaXAgaGFuZGxlcyBhbHBoYSBj
aGFubmVsIChBUkdCIC0+IFJHQkEpLCB3aGljaA0KZGlmZmVyZXMgZnJvbSB0aGUgYmVoYXZpb3Ig
b2YgbGF0ZXIgY2hpcHMuDQoNCj4gDQo+IChJJ20gYnVzeSB3aXRoIHRvbyBtYW55IHRoaW5ncyBz
byBJIGRvbid0IHdhbnQgdG8gZGVidWcgaXQgbm93Li4uKQ0KPiANCj4gWzFdIGh0dHBzOi8vaS5p
bWd1ci5jb20vdE5Gdm92Qi5qcGVnDQo+IFsyXSBodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lr
aS9Db2xvcl9zcGFjZSNHZW5lcmljDQoNCldlIHdpbGwgZWl0aGVyIHN1Ym1pdCBhIG5ldyBmaXgg
QVNBUCBvciByZXZlcnQgdGhpcyBzZXJpZXMgYXMgYSBmaXJzdA0Kc3RlcC4NCg0KQmVzdCByZWdh
cmRzLA0KU2hhd24NCg==

