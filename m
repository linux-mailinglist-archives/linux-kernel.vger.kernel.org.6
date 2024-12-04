Return-Path: <linux-kernel+bounces-430633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3316D9E33D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE522846B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714D918B492;
	Wed,  4 Dec 2024 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iPoL6kfM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tL8W0Ovs"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6991E522;
	Wed,  4 Dec 2024 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296145; cv=fail; b=r4pClCCcfWNQZs44sBgtPG3G/QcZv60HUWje1nSJmdMSDSN8OGevWMQHhDcqd+WTgyGkp/ajiY5FETAFea3yRSSXLRndl/Hg4jqRSAV5p9c9947Nt3NaqN6kaQazgv/hpLs9NZIjy7c4zApeLO8YbLfjbVGO77cNDgv1Pa02eMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296145; c=relaxed/simple;
	bh=pzZ4FcPGZT4PrVHdwz91k4rYcKsx5qJNFL5/aUFW96w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eIdfRuIRne++2gofBa3snc5UT81h3vq3qAFSdvS64vNfDRJqbw4kO5ikgknw9ZAD1a8591RkTb9cPDbkg5uQ/l+GwaGuvZ26VE5W8a2EIPrQM2Bv7/LPhrodPdmGJmF2MWCxLCRfcVDTAVnXMTORTlfx4SasGswhYPOSpKMIei4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iPoL6kfM; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tL8W0Ovs; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a0b401deb20e11ef99858b75a2457dd9-20241204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pzZ4FcPGZT4PrVHdwz91k4rYcKsx5qJNFL5/aUFW96w=;
	b=iPoL6kfMpVaeoZhFnG5W1AOKO6kkkBWTGJwHVjbjNbqvK6LADUTrb1vma9ypdR9YA3DWcgFx3xerZYy4vbbRbhCETHHDDxCFq+VMTB0gf6CxQlL2gbJGWpnp2V98/uKiqgG1zG1605XK4YEgwy1R72XIDPmsb58J/wwIsNoj7hQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:85b21891-f66f-4250-8453-089cf5083aa0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:cd45d6b9-596a-4e31-81f2-cae532fa1b81,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a0b401deb20e11ef99858b75a2457dd9-20241204
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 918985645; Wed, 04 Dec 2024 15:08:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 4 Dec 2024 15:08:54 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 4 Dec 2024 15:08:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6gmxs38HSPnjPLrAanz9F0ukpf8BUkUiPF0k/xgRmgThZRdcEKgnWtnmehKh8bz0HosgIOCrAz55lM77N/o1/baFJRvX//ctoyMaHyr4kuc+9+u87w0dglzUAjEDLTJnNoBifwH32TQjYN95TYzuvQU7eML3Vn+BL4pfCyBMYIyZf640ubdM7Pv5ppBMoT0wkf/6mVtgj0JTYgMCHtozd1IjYZth4Q7qwFP5ma6vA1palLxSOPsEx4/bsE2PSh40B4/uBBYMBvPp+bG5m7nXvnr6ONkY34L2TX9mOhy6MGpynDJoqvMNMIkrErwJ698G3DBZqrd3Tpncce9MYG92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzZ4FcPGZT4PrVHdwz91k4rYcKsx5qJNFL5/aUFW96w=;
 b=BVKtBHk6RqDp/OBLYBoBdnLs2bByn4Dp+KxiL4nKoKk3dbzNg2llJDjw1VFIDfwvXFXu1WtwY3FCfnOQTE1OTtesW3tUrgLCTHTdSlqY5WFFV6y8RuvbWEaZ0WiAXptCm8C2eCh/ubOCkN0T2hVshKX7rjRGH4Xz7lm/kblyh4jUthQTc4KDJprCcIqC9VZQTJMSv1qxF+3yb+SVX67tZcvFOQ+htrDakw1ok22wWALAlhH4RBtdwfTOaBzxsyjht3m72h+cDyR0K49MrCCbjyAqMURLr4VAGgxejwSsXgxN4uCyRq21voAxzn34zHc3z+sovvNbR6PiCa+P0Rtg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzZ4FcPGZT4PrVHdwz91k4rYcKsx5qJNFL5/aUFW96w=;
 b=tL8W0OvsBlUzNULNF2V+6+E2XQIHIlwSE2MvfS2wM4z7RQkd8z6JV4ba1P4eBgJV2Lo1n75Za0vuMMqN67DrOoVFdr62HkFtwSvkN1aOfnB8VQ7StiYkXXkfKImHid6E2HRlLt//8Bu+uKxyPn4qMXBgrrHYT/Qr2kKhdudvxZ4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7147.apcprd03.prod.outlook.com (2603:1096:101:e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 4 Dec
 2024 07:08:51 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Wed, 4 Dec 2024
 07:08:51 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "mripard@kernel.org" <mripard@kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Topic: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Index: AQHbO0pF3Zp6UXdpSEmkHbI6wNkmT7LVwCgA
Date: Wed, 4 Dec 2024 07:08:51 +0000
Message-ID: <d9fa43f9c9b49e26160cad506bfd06c37def064c.camel@mediatek.com>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
	 <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7147:EE_
x-ms-office365-filtering-correlation-id: 73b23dc4-3a66-44ca-aa57-08dd143281c7
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Uk93RTRkOTE2OTFoV29veTJrVkQzOWtNMVR5YTBoa3l6R1JEVmFiSDl3T2pE?=
 =?utf-8?B?TzNZMlMwby9FN1ZDR01mdWNEYTc0MVQvb1Rwa1hiMG5lUUlMSXp1T1pDMkZ5?=
 =?utf-8?B?S0g5WWRuVm8zOEZtQTNUcFpDN0E0WGxOOGh6ckhveVA0bnlPRm5EOThLTjdT?=
 =?utf-8?B?WmJZODhxV3hVZzFDeGZrZTdOUXk4VEFMSGJGZWtYOHljWDVpNFNvNmplY09s?=
 =?utf-8?B?RVI2dC9wOG5VUGF0azBxV3NMb2dhUVlZcmhjU1hCSFo3V1NNdENsbTA4Q3ho?=
 =?utf-8?B?N2laVUhrV00wV3V2eWtya282Y3l1TVE3QWNpRmVTOWxvdnE2Y0lmbDNsUDl5?=
 =?utf-8?B?ZnQyTnFNajR4RWZOL0czNitraVgzZWFuaU8vUm1QUjlLZUNTamNpRnpiR1Zj?=
 =?utf-8?B?bG90bXUyTnJJNklURTVVaFhhd09BR1Y1cGRtWjdTLzY0S0F6TlIwZVdMa25v?=
 =?utf-8?B?QWJKYzh2eGRibUFGcEFsVWtJalloall4SWJHV2V1Mjh0NGkvT1h4OS8yTTJ5?=
 =?utf-8?B?elowc3RrZ0trdnRhSUpLZHpBM2RMNU02TEQwZ3JPcTY0blpub1lKNlpSOG5P?=
 =?utf-8?B?ekhOeldROVRNU1A3VUpPeVRCQjBvZW9MTi9oTENBZ09SRk91QUxuYUxNZlpK?=
 =?utf-8?B?c3FraGVJQnRFeUhWL3U2SG5kNVJnUnZYNFNEODJCTDlQWU1oOU41R3N0NENN?=
 =?utf-8?B?TG1rRWxiSmg2SkRCWnZlNnRTRFRKaHU2R3cvcjBvVjhsQWN1cGQyV3BlOHFQ?=
 =?utf-8?B?TCtab09Fc04xNCs3eExlYnQrM1BWaWxBR0NtMkdjS0lUekZQYWU0dGQ1R2Q4?=
 =?utf-8?B?MDc2ZTJCbzljN3NwdWZScVZiRDFJMUZFOUpJM0NXYmEvTjN6ZjFqU1VPYWdx?=
 =?utf-8?B?Y2VXRGxPN3huV2ZRTWUydFNxRXBEd1Z1cnphOXI1Q2U1RThoRU0zaGxKSVVl?=
 =?utf-8?B?TFQ1Y1ZzMi9rTFo5akQrcXNOTzlzU2lIcU56TUk1R25iLzh1cFNsU2VaOCs4?=
 =?utf-8?B?aWdBcUNkbDMyT09LUktYTTZ5OEJLMm9Tb01abmE2eENJaG50VVpvcUFGS0lm?=
 =?utf-8?B?K2NNMGErODhLRlVCTEJhVlBoWDM1UHhIbHVIYm8ydmUzTXp2bFdPb3FVc3N5?=
 =?utf-8?B?aHBQK0xublV6YTNSaUJyanZvZ056UHBmNGQ3TDRraUo1SXJZSHZhQTBQdU1r?=
 =?utf-8?B?SXNnS2t3NHlId3dnZkVtK0hDSVk4MUJPYVBYckRmNWI3QlZtdFR6c0tvMHNy?=
 =?utf-8?B?ZnF3c01QemxXWUZzUVgvRGtZQ1plZ1N3Q2UvTldPeXZHdnFuN0JZYnFxcmEx?=
 =?utf-8?B?T1ZWcFNYbGRaOHhENFZVUlRHZnc4dkRySG90cFpFQmZ6Q2tKYmtBUmUveTlK?=
 =?utf-8?B?Q0grRE9pbDdmbGdFMUJtazR2aXF0YWltT0lnWCtxYWdLT3lKNEhHdHhwYytx?=
 =?utf-8?B?eHE5R0JKUGxDVlpmekJBY1dESzdsRFJWOVBaWjZ5KzVuYXNZMHgrYis4VFVQ?=
 =?utf-8?B?aFN1Y0JkWXNxTzMreDZLeDU0QTVZOHkxZVJMYzBjQmdBL0NCV1lwYnFmSG50?=
 =?utf-8?B?NEozcHY4Zmx0aUxtRllmZW9rSzJLY1daTXN4ZXpYdVV4RWNtUDVLVnBCUXBI?=
 =?utf-8?B?Qk9CQnNab2pSaUprS29uZ2x6WC85Uy9nWWlIcUcwTjY0cVhNbGFsL2xEWS81?=
 =?utf-8?B?TFNKc3gza0lkTEFFdFloVHJrWjFMWjJtRkEyYlNJM1hycGdpbkhaTHVRa1pu?=
 =?utf-8?B?eGxwWWRaTVFuQUY4b0Z4Uk1Rb0tnd292Z0thcTQvS3VGV2k3anVNbUpqemI3?=
 =?utf-8?B?THU4TTFOZUJhaWg1dDA4akI5cVhnbFhmOHNWNzJ2UnRGbkxMNTlWc0ZJRS8z?=
 =?utf-8?B?YlkzWGZaR3FBYzY3eUpxZDE0bCtVNTZ6SXNrY0xwMGVES1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b04vYzg1R29OK2V5UTJmaWp2MzBxTUJhaGdtcDc0UlZoMWNQaldabDFsNkty?=
 =?utf-8?B?Nkp6TTliOXRrNEw0L0ZnbmNSRUcrOHhGYzR3VldDd3lFODVGTkkzbFkwcDdC?=
 =?utf-8?B?MlFGVUZ6TEs4TTdoWmNUMm1DbGxrMjNmUmVidnRZTjg4aFBpMjVrWFdTTTN3?=
 =?utf-8?B?amo3eTRFZlExODl1QjF6MHB1eEtJaDYzcXUrUFl6ZmVqeEFQOXNVTThQa1Iw?=
 =?utf-8?B?NUcrMHJWcm5hbVNTclp5ZVYrR0hpT1dMTkpRdlV4Q0thckdPSkx2dXZucVBt?=
 =?utf-8?B?RDNBWTEzUGJlaTc0b1FxWHJnbUJ5RllXYnUybmVxZTVNVXZzUzRBQlZJdlp6?=
 =?utf-8?B?TVgydEEzM0JLOFc4bCt5Z0Z1N2FIMnBYR3ptcmREOVdSdFY0OWdzMElJYjZF?=
 =?utf-8?B?bzYwWlBOcU9uREM5VWlodXF6YjdzMGxWVEhHYVU1d0RxZWdXdTJwV1JVRkE1?=
 =?utf-8?B?NXRNUGU0eFFUYmg2R1dTRWdvTGZKOGtCR3VhT2R5RXBXT0JuWnlObkF1Nmx5?=
 =?utf-8?B?KzBRM0hicndnYmI2TkxCeEZncW5wdlZSenV3alNIdXRSMHlpWGFiY0tiZlZB?=
 =?utf-8?B?WlVaWGRSMm9yZG83dU41NUtraGtPbUFHOHlWb3RHdW5ZcFpaaHZaR1M4S0R3?=
 =?utf-8?B?U1Fkb2pZY0FHSkZvcCtoeHdVM3dnU05YZkhwekVEUzhRQk8vMTRiVU1HV095?=
 =?utf-8?B?VWJUY3FVMGM4OFc4OWdPdEJkdnR3a0JwWjBnam9OZStscUlVOUd2aEZTOERR?=
 =?utf-8?B?NG84cW5USGM1Y1NLczJJaXR1TEMzUzY1enA5d3RMUG9wOHB6TUdsNjVjTU5n?=
 =?utf-8?B?M1AyejF6RDZoTitCaTJrZk5aL0xvblBKYkYrczZtYmROWFBDeFo0UERRc3VE?=
 =?utf-8?B?VHR5bk1zZkV4VmNZejdybHpLZFB1RWphci9LQ3JDSWsxS21aRFRKVE9DdG1S?=
 =?utf-8?B?RHBWZHdmWnJhTm5PM1l2OVNxY0taVUM0aDlmNEhkUi9MT04vSTRnSGF5bHFt?=
 =?utf-8?B?N2xzQXFncFR2QXZsS2s2cjIrRm5CWDVJY1FFc2hLTjNCbGRMZE4rd0s3Nmoz?=
 =?utf-8?B?c2xLb2doMm5CZTZpTjB5QkFQNWpJTmpuMWhSbDd1MVlQWllHK3RrWml5VXNK?=
 =?utf-8?B?UVdkNXFxY0VvaXBUcktyTXlWNGFxZjZqallWRENMd0VqWE0vY2dSRm9KL0hK?=
 =?utf-8?B?cGh3UUQrR0xDa3BoK1R3S3pZWFhhZlpwQUFOWGF0cmcrdjV1SlRFWTVDL2Vy?=
 =?utf-8?B?dVRBZStiOG1DQ0FkcVB4dTJlUzJocVlUWHNkbVNsMHhDR05uMU0zSFFibElu?=
 =?utf-8?B?K01BTkswZE9WTzkzMGw0aTdJb3RDaHJWQXdWQmxKZVRXaEI2WUl2blpEamU0?=
 =?utf-8?B?MU5Rcm11WEtLemRwdndPaEw0MndMaEQvMlE4blVHMmM0aE1jQmpxcFZPK0VW?=
 =?utf-8?B?NHRYK3p3cURGak5QYWFobU1WTGMrZ0ZOam9SWVRkSnRhRGtKaENFd0dEWVJ3?=
 =?utf-8?B?YkQxYWwxNnRQVjIrbVhBc3V5MmpHdXIxd0pJdjdRdkIrbk5WYXFnMEZ0T0Ft?=
 =?utf-8?B?T3lmMTJUQm9qZmYvMjVuQURRUExicGNXd2h5TVJJWk9Fb3dSVU95cnpsSkxz?=
 =?utf-8?B?a2toU1V2cHU2WkEyVURrVFJucEhaYkN0Q0h2V3hLM0NRb0ZIeDJzcnUvQmNU?=
 =?utf-8?B?eVhoRU1VYlJlb1EzS09ZdFpXblRTM1RESUJkendzSFg0MFZodXF4dE1UcUZs?=
 =?utf-8?B?cXZBYnhqY1FrZG5lOU44SDZrc2NsV0FRNmQ1NkI0T3JabWlGaDNSTUk4TkJC?=
 =?utf-8?B?UE93UlR6OW5GRDZtRFJqTnhjSDBLbk1iVjh3Z1dNOXc1NzhwdWhTcWNLRndq?=
 =?utf-8?B?ZmlsUElpSWo1ZUpTMVlYUlJpblBjMFpvVkVYYlZuUmp4c2FpRUZRWXB3Q1FW?=
 =?utf-8?B?VjI2WnlqQkkzWEw3OFhQL1lwakVFUnlsZC81RXpCYmtKVDdqaDRHT0JROXlE?=
 =?utf-8?B?aldic0RpWWJQRlkvMGF0dTJUVkkwZjVzc3paaEFyWXpDWm51eHZEVVdxRkkr?=
 =?utf-8?B?UUxMMWRzR0cxVkkxd3BiUFV3VDhMaytyRlROaGtna2hIT3lOZ003YXcwTVpP?=
 =?utf-8?Q?MTRlDIrK7PyUyIT/5SEMPxsAH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68B124FE8BC08E4285F4283E74F75E68@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b23dc4-3a66-44ca-aa57-08dd143281c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 07:08:51.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcWvXlezdGeS4tvRWCZhZ4JRjV8ZXZMv53u4XNQJNRthMoNooKbUcNj6oGtV9CjVYGlvybMTKnmPiUJfDhy7+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7147
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.361800-8.000000
X-TMASE-MatchedRID: QfHZjzml1E8NtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCsME2BsoiKJMBfVY7O+c8KbAuWcdTSiQDXvsbfoZixUTS0e
	iOsrXcTh1oS0fHAaa1CQUfW6C4J4ILPE30Kn3xIqcgbKevk5shlo1rFkFFs1aZ5yuplze9puE37
	5fW5/ZwjyNSupKyw8nBONIf64v+UoqMCklq1W08jXKFtsDtZ7TELbqrOgWzyc4tBBjqHS7gqPFj
	JEFr+olFUew0Fl/1pEBi3kqJOK62QtuKBGekqUpI/NGWt0UYPDRsCBPv2BpagRwlhyfg3VP2LSg
	foq96oarhUGZ0jy+/XzvDlMXZnfD
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.361800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BF57C0EE0B4140BC04E7CCEBA87C9644DF388C869DC1FF8D3C71D48B86C0EDF42000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTExLTIwIGF0IDEzOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Ig
dGhlIG5ld2VyIEhETUktVFggKEVuY29kZXIpIHYyIGFuZCBEREMgdjIgSVBzDQo+IGZvdW5kIGlu
IE1lZGlhVGVrJ3MgTVQ4MTk1LCBNVDgxODggU29DIGFuZCB0aGVpciB2YXJpYW50cywgYW5kDQo+
IGluY2x1ZGluZyBzdXBwb3J0IGZvciBkaXNwbGF5IG1vZGVzIHVwIHRvIDRrNjAgYW5kIGZvciBI
RE1JDQo+IEF1ZGlvLCBhcyBwZXIgdGhlIEhETUkgMi4wIHNwZWMuDQo+IA0KPiBIRENQIGFuZCBD
RUMgZnVuY3Rpb25hbGl0aWVzIGFyZSBhbHNvIHN1cHBvcnRlZCBieSB0aGlzIGhhcmR3YXJlLA0K
PiBidXQgYXJlIG5vdCBpbmNsdWRlZCBpbiB0aGlzIGNvbW1pdC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25v
QGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArc3RhdGljIHZvaWQgbXRrX2hk
bWlfdjJfYnJpZGdlX3ByZV9lbmFibGUoc3RydWN0IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9icmlkZ2Vf
c3RhdGUgKm9sZF9zdGF0ZSkNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgbXRrX2hkbWkgKmhkbWkg
PSBoZG1pX2N0eF9mcm9tX2JyaWRnZShicmlkZ2UpOw0KPiArICAgICAgIHN0cnVjdCBkcm1fYXRv
bWljX3N0YXRlICpzdGF0ZSA9IG9sZF9zdGF0ZS0+YmFzZS5zdGF0ZTsNCj4gKyAgICAgICB1bmlv
biBwaHlfY29uZmlndXJlX29wdHMgb3B0cyA9IHsNCj4gKyAgICAgICAgICAgICAgIC5kcCA9IHsg
LmxpbmtfcmF0ZSA9IGhkbWktPm1vZGUuY2xvY2sgKiBLSUxPIH0NCj4gKyAgICAgICB9Ow0KPiAr
DQo+ICsgICAgICAgLyogUmV0cmlldmUgdGhlIGNvbm5lY3RvciB0aHJvdWdoIHRoZSBhdG9taWMg
c3RhdGUgKi8NCj4gKyAgICAgICBoZG1pLT5jdXJyX2Nvbm4gPSBkcm1fYXRvbWljX2dldF9uZXdf
Y29ubmVjdG9yX2Zvcl9lbmNvZGVyKHN0YXRlLCBicmlkZ2UtPmVuY29kZXIpOw0KDQpJIHdvdWxk
IGxpa2UgdjEgYW5kIHYyIGhhcyB0aGUgc2FtZSBiZWhhdmlvci4gSW4gdjEsIHRoaXMgaXMgZG9u
ZSBpbiBicmlkZ2UgZW5hYmxlIGZ1bmN0aW9uLg0KSWYgaXQgc2hvdWxkIGJlIGhlcmUgaW4gdjIs
IGFkZCBjb21tZW50IHRvIGRlc2NyaWJlIHRoZSByZWFzb24uDQoNCj4gKyAgICAgICBtdGtfaGRt
aV9vdXRwdXRfc2V0X2Rpc3BsYXlfbW9kZShoZG1pLCAmaGRtaS0+bW9kZSk7DQoNCkRpdHRvLg0K
DQo+ICsNCj4gKyAgICAgICAvKiBSZWNvbmZpZ3VyZSBwaHkgY2xvY2sgbGluayB3aXRoIGFwcHJv
cHJpYXRlIHJhdGUgKi8NCj4gKyAgICAgICBwaHlfY29uZmlndXJlKGhkbWktPnBoeSwgJm9wdHMp
Ow0KPiArDQo+ICsgICAgICAgLyogUG93ZXIgb24gdGhlIFBIWSBoZXJlIHRvIG1ha2Ugc3VyZSB0
aGF0IERQSV9IRE1JIGlzIGNsb2NrZWQgKi8NCj4gKyAgICAgICBwaHlfcG93ZXJfb24oaGRtaS0+
cGh5KTsNCg0KRGl0dG8uDQoNCj4gKw0KPiArICAgICAgIC8qIEVuYWJsZSBWU3luYyBpbnRlcnJ1
cHQgKi8NCj4gKyAgICAgICByZWdtYXBfc2V0X2JpdHMoaGRtaS0+cmVncywgVE9QX0lOVF9FTkFC
TEUwMCwgSERNSV9WU1lOQ19JTlQpOw0KDQpJIGRvIG5vdCBzZWUgc29mdHdhcmUgZG8gYW55dGhp
bmcgaW4gdnN5bmMuDQpJIHRoaW5rIHRoaXMgaXMgbm90IG5lY2Vzc2FyeSwgc28gZHJvcCBpdC4N
Cg0KUmVnYXJkcywNCkNLDQoNCj4gKw0KPiArICAgICAgIGhkbWktPnBvd2VyZWQgPSB0cnVlOw0K
PiArfQ0KPiArDQo=

