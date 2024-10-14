Return-Path: <linux-kernel+bounces-363473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3288999C2EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E096B23B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8DE14B07A;
	Mon, 14 Oct 2024 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RWFUYRAX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="UjBESCN9"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD52414EC47;
	Mon, 14 Oct 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894008; cv=fail; b=V6O48EpjvIai+oexhOOKp1iQTBcpbIN84k0eFIh7FcPLrr+Aj1Fq3KKa0QiVRiNtQoZiFZdYKCOGjda0Q4dIz7AwqJMgaGTWZ0sKFKYTklAGf4ImaVwiphs9VQGsucBmpvliAvXa8TIJZwKVA7Go6Ro0O9x5smlMALABe5yDfAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894008; c=relaxed/simple;
	bh=HaLqmPETtkPJmAZicyz4c1bnhIyW+z3Hkdp4Yp2tJCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ieJtwCyG7vJkinEE6ByOW9syAqlnsj/kpPvCIgf6+Bht8/B4D1DuujLZI2Y5pypz0UFmgHsSGOwOyJ4JaENEz1+mKOkba5Ba9PvEtJ3uK1decr19qjobmt459rveG668F3wXqHUhZeCAHGQLme1djuRmHEJ2dxGgEnVjESZrtEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RWFUYRAX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=UjBESCN9; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1b2541808a0511ef8b96093e013ec31c-20241014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HaLqmPETtkPJmAZicyz4c1bnhIyW+z3Hkdp4Yp2tJCo=;
	b=RWFUYRAXzzFbHPqZgdpOliRof29cDykMVm7Aie8ELBftK6FnY9SoT9QHbi/3JwMthy7Jg5N3EzRnm6ocndayuLLe2Y8V5ueOyXSqaPD0yxEXDYtEOF7rcIhEk+bcmaVJND8PdXAX/66zkgX1amnoHq4tEXkaG3aRoQhuhtn720E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:30a06cc6-555a-4859-a37b-edb549d150ea,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:6b133565-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1b2541808a0511ef8b96093e013ec31c-20241014
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1770804417; Mon, 14 Oct 2024 16:20:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 14 Oct 2024 16:19:58 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 14 Oct 2024 16:19:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rO3u33rkvzhKooj/RwoDu+7gAEgG2TtFx46Zd1Yktvn91h8TUJFCfTtA64idVXU+N1P2UthdPnz9r0+GM4HRuKrERYS6ZbLD4/K7R3FAOZxfdb+BvM4fL8rEVay/ql7451YYZgs6CAMe6Swe+chvnxpkhPbkIFh4KXSPpyoHYfGFqiTJ1SJUFf3QL0nywsdSCVnxhiyLUYjytGUQMZvMrh4Ckb40/6MxTOmldspfEjOQullmXCjIawV7cgFx2Hq5TuaDuHh6hz5vEfjNlTPyWj6qHSAv9nTCxn7Sk5b4ndVZZ0bMY6AaQlS+cPW2rerNFQnlZU8jYnvpoyRWGj/2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaLqmPETtkPJmAZicyz4c1bnhIyW+z3Hkdp4Yp2tJCo=;
 b=gdVRHtOfz8VepwtqQOXnekmYnM9vr8jSN/0r/dA7l5ap2tvewDeUbdXI7FN6BuIKzvQe9seJ3kMYqaSiXtzNMN4e39o1cgsPVoaWicKC0E8wdgidc9G60VrwbBLwoCDaW8dTSlMLqFhCpiwaPsHuS3ffCi7EG6S3FQqaygIl9XrGndFH4r+X5K3XbDthWS3fYdeWIpOynt3B/hGMARC0n4Or7mCZkz96XCsQi81HvhhY3U5t2g5RvwqBlBoU3JSid3psl5W/lw3cAwJAEtVCYhR8jv0S7cLEAp9HvdXjtRtRnZBkelwmCq3WVwWYskrUmr45liwDaG6ZxjdDq4aRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaLqmPETtkPJmAZicyz4c1bnhIyW+z3Hkdp4Yp2tJCo=;
 b=UjBESCN9h/RdRT4Ljg/0y41Zr21hRClPLgCKX/N4M9wVqXTLhht6w4lQi0X6YR8xhZWnz8e974QuwlqhNwgMmIcGL09mDg5ujerX9Cz+D56FFvLpWmzBA2FA6nd1RgR3nyaSE9wF4KVtANU9IFqWcO7ROsFxGK2iM3ePW2KsKXs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7684.apcprd03.prod.outlook.com (2603:1096:101:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Mon, 14 Oct
 2024 08:19:52 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 08:19:51 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"sui.jingfeng@linux.dev" <sui.jingfeng@linux.dev>, "wenst@chromium.org"
	<wenst@chromium.org>, Sjoerd Simons <sjoerd@collabora.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"michael@walle.cc" <michael@walle.cc>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
	"mwalle@kernel.org" <mwalle@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
Subject: Re: [PATCH v11 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Topic: [PATCH v11 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Index: AQHbGJvj29sreDXMGEakTX36fvej8LJ8ebCAgAAGIACAAZ2xAIAAGDAAgAe8xAA=
Date: Mon, 14 Oct 2024 08:19:51 +0000
Message-ID: <39090cb8ea0468252e53712553d483b696d83754.camel@mediatek.com>
References: <20241007093114.35332-1-angelogioacchino.delregno@collabora.com>
	 <20241007093114.35332-4-angelogioacchino.delregno@collabora.com>
	 <a7fd78a9fb858552e48339bc4bf3d3423d428f3b.camel@mediatek.com>
	 <6415a3a1-f00d-428e-b607-ae27ac63c11a@collabora.com>
	 <13aad68b2473b5848fd9172e75501d51dc8c8d91.camel@mediatek.com>
	 <0dca529a-85f2-4ed3-b3f4-132e6b233f5c@collabora.com>
In-Reply-To: <0dca529a-85f2-4ed3-b3f4-132e6b233f5c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7684:EE_
x-ms-office365-filtering-correlation-id: 6256cd8a-4e63-4bbf-08e1-08dcec28fa1e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WHF1MEdjdTRzNHlJZy8zMEtHVWdLRHJtdEhPOC8xcTMxTTRXK2hMRVphcmQy?=
 =?utf-8?B?RHR0QVNMWDZPa0J6N0RTS25qMUFDQ21BekNVLzZoaHd1M2gzU3FEbUcxZWQx?=
 =?utf-8?B?WlI5QW5LWStuNkVzeXJsT2dzN0h2clp5QzMycTZrTmNMbDFqcHBsZWdmU1JN?=
 =?utf-8?B?MmdoaFhDSENFcWk1Qng2Qm5ERTg5ZmVham1FNGUyQ1RyV01rc1lUNkpNb2wy?=
 =?utf-8?B?bm1xSTdZQ3BVaDBxZ2hoSnl6cjZmK001ZlVhV3M2L00yQUdmSFlGbVI4dWFW?=
 =?utf-8?B?OTdHcFB5Nm9MNnVibkMydHdqZGNobk5rcFh3RTVaNXFJQjl6b1QvR0hBcXVK?=
 =?utf-8?B?ZVoraTdTUGtEbkJoK0diaEdFdXV6ZkUwb3pMRDBlUHN0YUVuTzVEZmYyVERG?=
 =?utf-8?B?a2doM2VhT1RwRHpSN3kzSU83M09pSVhJY28rYWp3LzMyaW0zMVRvVTFIQ3gy?=
 =?utf-8?B?NkhGNDMxWDJhSkFKTkl3MTJIcjdCeStRaEtEY25pL2VhTUN5cnFHV3YrSlVK?=
 =?utf-8?B?K3Npa3I3OXo4Tlh3U3htNUtTTWF2K1YzSVhydWF6SThLSnh1NXVDT3gxek4w?=
 =?utf-8?B?dkNwVk5ITHdWRmJEbHkwSHZsYUdCUS8zTnhFd3RYQkxqNU5RSnYzdngyTm5y?=
 =?utf-8?B?NHF6emNKNjFlL2NUcml2TU91NUVseFl4RnpGM3RydUlzUXV1ZnlNckpNL0w0?=
 =?utf-8?B?aHFpOFB3STIrbnZQYU56N3VtWStuMllaZ01ibUF6LzhocXR1UHNJS3RYL2ZN?=
 =?utf-8?B?OEZWdkFGUGczUjlDc2ZLTFN6RjJBWnh0Nk5mZmdzQXFZaXVJRE5FNkpUVm05?=
 =?utf-8?B?MC9mcEk0SFh3R1JEYnpSbFRrYzdBbUlpNlcwUTRxVk1XN2RJMVkwMnRESG5D?=
 =?utf-8?B?WmQyYmQxUmIxVUM4TFRHMWVqVTc2T0V3L3oyejliNFRxczdWWEhkc2JuaE1j?=
 =?utf-8?B?dTkvelhFdmExTUtOd1ZvMUlram5mZU84TGNpRW8ycDFMTklZL1NrK2J6M3hW?=
 =?utf-8?B?ZUEzMWRzSktXMS9XQVhZaW5hYTNDamVIY2ZjNHVEU1AvZGdoMGRFa0lsaXlC?=
 =?utf-8?B?QlhaU3R0NXRpbzJuaWdQaGZvU1kyL1lJdlhKU3hqbXNIandSOTk2NGdsRWhM?=
 =?utf-8?B?djcwc3QxbmlCNDI4SGh5UFhBOHRRby80QWtFcTVVemxYSjlpaURndEFXZjNr?=
 =?utf-8?B?dlh4L1doeERndFJrTDgrVjRFNlhaMFZ0RG5Mc1B5RmNWaVl4elRXTk1jSUlN?=
 =?utf-8?B?S2pCQTNWNjhUbTlucmV5RVd3ZTJMZE8ydmwyRHo4TXY5Q29qczRMNU82dk1q?=
 =?utf-8?B?cWRnWWFrZWtHVDYyWGRnTkhSWWFmcjJucTE0VDdzcTdhVHJ1NVZkTEhZbnA5?=
 =?utf-8?B?dVUvV1VMYkxoZDZYeVMyU2xMNUJvSWl6blFvNm9BeHJkM3ZMWjJrdytGR0dX?=
 =?utf-8?B?YXhkbW9BRFZycXBMY0pxY3ZvcElmRlQ1Z3F6dndxZnY1eWNYNGlVNTd6L3g0?=
 =?utf-8?B?czA0VXJRZVYxQk5scEFGa2tNaFM1NURjTmRQR3RiSXRsaEtFWW5zOHJ4cFBN?=
 =?utf-8?B?aVUzYU5MaS9Yc3VXUTVxQTcyOGoyYnhLazlHelZrM1BGTG1oalk1cUtvNEZk?=
 =?utf-8?B?dXZ4SklhcThQOEwraHBESXE4WXovK0xSelJDZWxxTzdieWgxd09HNGxuME9x?=
 =?utf-8?B?NjY1QWlFRGV0bXJwV1U2QlBMV1RTandUVXlmSVA1WXg1bElKMlRBSnhSN1RS?=
 =?utf-8?B?akhKbStDck5CWUZmSG0yNU9ybTAvSXdjbEVTbk4wa2lISzhkYjRlSzVEdmEv?=
 =?utf-8?B?a1ZWUGw1U3QxMHY5ZlR0Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnhOYXhBUlpIVEd0MzZHUmswcmF1S0FkRWZsTEhLRTc3RjJydnlvVE1mWVhm?=
 =?utf-8?B?N1Eva2lrYVh4S0wrVE9oM3Y2dEtLRExvNTRtL1FSZDZtcmNRMG5wcDRNR3NR?=
 =?utf-8?B?TGtkR2NLeVJmbWdjMU5GZGZybTg5L25DRTNQRUU3S2NvNEt5QUp1dVJheWZU?=
 =?utf-8?B?NUpBa3NRN1p6OHZrT1VaTDVzcFRuM3lVZ3N4M25FMTNOSE84emMwRGV0UVUw?=
 =?utf-8?B?U0JES0lGV3VaT01SZFFjakVRRmtKMUJQeDFCbUdHVmthQjI4Z2ZHUFY0ZTd4?=
 =?utf-8?B?akJtMWF5MU8xTWxvR0ZDaDVkOWpBS1h1OFM0TmhGTE5uNDRGdzJhN09INTFm?=
 =?utf-8?B?SmtCcWFtN2JUcHZTK09zcVdlS2JzU3RwdUFOQ2JENGIrOTE0ZlowVFNFZEN6?=
 =?utf-8?B?MVg3QnpodFpnTGVLNGJVamFnTHRTbjUwV28vUEdacUhJZHhCbWxmbzZ6U3RW?=
 =?utf-8?B?WW01MUkvOVVkTUxJZGVvZzRxR0lROWliZmFJY1dibXBSUW5nS0ZnZEtaRStz?=
 =?utf-8?B?dzYyQzhqVzRhcDhsZXVmTUcwSm5BL0lpVjMvUTcxRUNtZDcrOXFTK1VIWkgx?=
 =?utf-8?B?Q2pyVlE3WFB5Z2VsWjJDRnFkVHEwRHNESFZhc2RLV1ZCcFB1eGdRNkpRRlN4?=
 =?utf-8?B?RFhaUFZoQkg3bGo5a0IwZGVnNk5kZFZYY3RqMkJwZmdPNzhGOEl1b2hPZTZw?=
 =?utf-8?B?NEFWUWdVcVI0UFZoc2l4ZnArUm11d3dWdTR3K1UwNVBQSG9VNzJ3RThSRHhO?=
 =?utf-8?B?eEZLYzAvSS9jdHA4RFJhZmltV1FxUDEzYm11Y0pyQ1RtU002Sm5FbTE5VG5Q?=
 =?utf-8?B?UE4xNEVMa1B4Z254bkdmQk80dzllM0t3T29KWGpFelBHMVZsQmpNWkZVRGpi?=
 =?utf-8?B?RUI2UTJZQnE3aThtYkV4SDVhT2Z4amhGc3Z5Z1JJOVBHV3FxdEhWcE9iSjIx?=
 =?utf-8?B?VGtGRHRPY016dW9QK3NmNW5EVW9yd1p0a2lpQ2swNHhUUkhHd2VqVFN1V2JQ?=
 =?utf-8?B?TXhsc3VFLzBYQ3F1S0xpd2tUY3pGVXVnbTF6VDV4cDdZZTVaVnM4NGN4T05F?=
 =?utf-8?B?SnAwUVNGdHF4dkowQ2dpTnVMS1dYVDJGSTV5dDhrU3YwYjFCei9xbVhXbSs1?=
 =?utf-8?B?b1M5WHArWHdKQlJXRTZTNkpRem40YUE1TXQ5TmpPSGpYaW51d1NKVFBVNS9B?=
 =?utf-8?B?UFFwVkJXbWFyZXg2Z2M4ZkVDek5WZytGV0lyUWlvOVhzSndZZ2s3bENyVjdE?=
 =?utf-8?B?QmEwS1g0SkJXcXpvcWVsMHhialVsaU9icU8vSjYzZEZUUVEvME1leVlROVJP?=
 =?utf-8?B?R3pUQU1NOUhFMnQvRWZDVm1LaER5anJ2c2V6MkY4dXp3WGJIK2dUMUQ0VUww?=
 =?utf-8?B?aCtoeHFueEVPdGo0Rm9hVk5uSXRLWXJ0ZGg5RG8yUG90ZXFjcGQrZmZWT0NW?=
 =?utf-8?B?NXhkSnlWNFR0VXNGS21zeWdjNG1STWk2YmE5V2lRZTNURm9WRVk2NkdFSzM1?=
 =?utf-8?B?U29NM3NJVTlKTGs2anoxd1daTER4R0g0enpid2I2b3dTWjdFNlJkRjNzaUhC?=
 =?utf-8?B?V0ZBRStIZit5aWJrNjJIczZndGxnek8vSFBPbWRRanBOMjgxdVFIM1ZsaTV6?=
 =?utf-8?B?emZCMHEyRFQ5eWthZlNwSXZKZjVKaTUvbzJ1aDllcFFrcVJydkV0VktqajVl?=
 =?utf-8?B?QkRBTFZUSE9KTGtSQVYzazBLYi9tSzcwdmFZS1ZsOE1nZkdwL1BPVTU1M3JD?=
 =?utf-8?B?OW5XQ3Y4SWpoWkhSQ2tQTkZicXNMRnN6bUdpVWpRanhnRGdVYmJpNTQ4OG03?=
 =?utf-8?B?TVFQcnZvUWxqd3VvZ2hrRGZvMU1jVmdJYUdMaHRMa1VjSVJKUFJIdXQ4Zi8y?=
 =?utf-8?B?aGg4N2Z2QUJMVVpBd3l2NGFHc0JDL2dONlJadzZGZ21wUjFCbW1TdW1tQkdU?=
 =?utf-8?B?WlBLQk43eXdvdjl1WHc1Slg3aThVVzQ4VWNmNmwyVkV5ZXVxOEFqV1ZDTUZJ?=
 =?utf-8?B?VHd1TjFwdVlsUy9KVmFzV2s2a20vUVBsN0UwNDNtbXIrcktsb3U2RWU4K0xX?=
 =?utf-8?B?b0lHZTU1d1ZONWVUb0JoM3NBbFprWkZvMktPQzhtZVJqem00TTlKWnhRVHhq?=
 =?utf-8?Q?U+g6kC0VIlRWgWdjArmsppuGh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D43CCA0C0453DD4B9427989E0A269BB2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6256cd8a-4e63-4bbf-08e1-08dcec28fa1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 08:19:51.8438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQydbqgMnfZAO0Bw0USapmpcPHeHJj3T0G5i5qc5HvgdHJ4n793WS9hj7IzoqZB1GtcWT+Sm2GMCLR+gBkVHqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7684
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.654500-8.000000
X-TMASE-MatchedRID: Ync95tbzDRkNtKv7cnNXnSa1MaKuob8PofZV/2Xa0cJauByPtDzndbmn
	rGB/kwGMzY3Y/giFSEhzLfo8HEyixurVjATjwK5b9AByWqqZEHy4vBuE2X0Hla2PbheqHTJcOC/
	PbYXMnkWXn5FR/KDZhEiFEF49yPe+UJc+88wC0T5buDP8ZuCmXkjfc88gQK69np9KgXcu34yhZj
	Z3gwZP2YhkTUgX4kDJhRAr0eCrd7RQswgj0HOv3BWCVBr+Ay98/5QRvrl2CZDzYcyIF7RSVY90G
	xaR8c3tpl4ZpnvNIMWcJCzlszm60WX3SpdG0+lWvbFZsqMF9Y9D7Oy96V3XMkYx760ONDcWRciZ
	Dbsw1hiouuMe/GtjsA+N8uSu8kiwgKRa5Ak0hD8xAWfYwRIg0bPgPvvwZyARlBd6Z8DODY2kycB
	ajwOeDJjuQoRYC02/aTOLkCfnhQZgCZqWXv77lIWs+rMQjb4fN/BTU5ZfZRIWL2JgVVTQGJPNm1
	WpvTlalTrfppylHpCv66rm5oAbkN1ZJprSJcww9Ib/6w+1lWRMkOX0UoduuR/BDn6vj4g3RiX6f
	zbAQPXdJqQNSoXNjFxXPCDgqHlYRU0fOqXtP86VOwZbcOalSzoSfZud5+GgGNAPebYwJ/u9egFd
	rKvPpvomN8TbthWiRDRlsOgKDDeVjYUmxG+kGYbBPrt55wnwkKhujpdC6JdEPdNmmPe2oMJ0c5s
	cl5pNoL7B1DuqAqhatvUzMDckKuVvZ9VZp3eEsyw+ZJnFumR9LQinZ4QefKU8D0b0qFy9suf7RW
	bvUtwa5rUAhyFDUAtuKBGekqUpPjKoPgsq7cA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.654500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C768F4B3E6942C61DE0BF3ADEA0832F75791447196627FD1A97D08F3F762F0EE2000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTEwLTA5IGF0IDEyOjEwICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMDkvMTAvMjQgMTA6NDMsIENLIEh1ICjo
g6Hkv4rlhYkpIGhhIHNjcml0dG86DQo+ID4gSGksIEFuZ2VsbzoNCj4gPiANCj4gPiBPbiBUdWUs
IDIwMjQtMTAtMDggYXQgMTA6MDMgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdy
b3RlOg0KPiA+ID4gSWwgMDgvMTAvMjQgMDk6NDEsIENLIEh1ICjog6Hkv4rlhYkpIGhhIHNjcml0
dG86DQo+ID4gPiA+IEhpLCBBbmdlbG86DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBNb24sIDIwMjQt
MTAtMDcgYXQgMTE6MzEgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0K
PiA+ID4gPiA+IEl0IGlzIGltcG9zc2libGUgdG8gYWRkIGVhY2ggYW5kIGV2ZXJ5IHBvc3NpYmxl
IEREUCBwYXRoIGNvbWJpbmF0aW9uDQo+ID4gPiA+ID4gZm9yIGVhY2ggYW5kIGV2ZXJ5IHBvc3Np
YmxlIGNvbWJpbmF0aW9uIG9mIFNvQyBhbmQgYm9hcmQ6IHJpZ2h0IG5vdywNCj4gPiA+ID4gPiB0
aGlzIGRyaXZlciBoYXJkY29kZXMgY29uZmlndXJhdGlvbiBmb3IgMTAgU29DcyBhbmQgdGhpcyBp
cyBnb2luZyB0bw0KPiA+ID4gPiA+IGdyb3cgbGFyZ2VyIGFuZCBsYXJnZXIsIGFuZCB3aXRoIG5l
dyBoYWNrcyBsaWtlIHRoZSBpbnRyb2R1Y3Rpb24gb2YNCj4gPiA+ID4gPiBtdGtfZHJtX3JvdXRl
IHdoaWNoIGlzIGFueXdheSBub3QgZW5vdWdoIGZvciBhbGwgZmluYWwgcm91dGVzIGFzIHRoZQ0K
PiA+ID4gPiA+IERTSSBjYW5ub3QgYmUgY29ubmVjdGVkIHRvIE1FUkdFIGlmIGl0J3Mgbm90IGEg
ZHVhbC1EU0ksIG9yIGVuYWJsaW5nDQo+ID4gPiA+ID4gRFNDIHByZXZlbnRpdmVseSBkb2Vzbid0
IHdvcmsgaWYgdGhlIGRpc3BsYXkgZG9lc24ndCBzdXBwb3J0IGl0LCBvcg0KPiA+ID4gPiA+IG90
aGVycy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaW5jZSBwcmFjdGljYWxseSBhbGwgZGlzcGxh
eSBJUHMgaW4gTWVkaWFUZWsgU29DcyBzdXBwb3J0IGJlaW5nDQo+ID4gPiA+ID4gaW50ZXJjb25u
ZWN0ZWQgd2l0aCBkaWZmZXJlbnQgaW5zdGFuY2VzIG9mIG90aGVyLCBvciB0aGUgc2FtZSwgSVBz
DQo+ID4gPiA+ID4gb3Igd2l0aCBkaWZmZXJlbnQgSVBzIGFuZCBpbiBkaWZmZXJlbnQgY29tYmlu
YXRpb25zLCB0aGUgZmluYWwgRERQDQo+ID4gPiA+ID4gcGlwZWxpbmUgaXMgZWZmZWN0aXZlbHkg
YSBib2FyZCBzcGVjaWZpYyBjb25maWd1cmF0aW9uLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IElt
cGxlbWVudCBPRiBncmFwaHMgc3VwcG9ydCB0byB0aGUgbWVkaWF0ZWstZHJtIGRyaXZlcnMsIGFs
bG93aW5nIHRvDQo+ID4gPiA+ID4gc3RvcCBoYXJkY29kaW5nIHRoZSBwYXRocywgYW5kIHByZXZl
bnRpbmcgdGhpcyBkcml2ZXIgdG8gZ2V0IGEgaHVnZQ0KPiA+ID4gPiA+IGFtb3VudCBvZiBhcnJh
eXMgZm9yIGVhY2ggYm9hcmQgYW5kIFNvQyBjb21iaW5hdGlvbiwgYWxzbyBwYXZpbmcgdGhlDQo+
ID4gPiA+ID4gd2F5IHRvIHNoYXJlIHRoZSBzYW1lIG10a19tbXN5c19kcml2ZXJfZGF0YSBiZXR3
ZWVuIG11bHRpcGxlIFNvQ3MsDQo+ID4gPiA+ID4gbWFraW5nIGl0IG1vcmUgc3RyYWlnaHRmb3J3
YXJkIHRvIGFkZCBzdXBwb3J0IGZvciBuZXcgY2hpcHMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
UmV2aWV3ZWQtYnk6IEFsZXhhbmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+
ID4gPiA+ID4gVGVzdGVkLWJ5OiBBbGV4YW5kcmUgTWVyZ25hdCA8YW1lcmduYXRAYmF5bGlicmUu
Y29tPg0KPiA+ID4gPiA+IEFja2VkLWJ5OiBTdWkgSmluZ2ZlbmcgPHN1aS5qaW5nZmVuZ0BsaW51
eC5kZXY+DQo+ID4gPiA+ID4gVGVzdGVkLWJ5OiBNaWNoYWVsIFdhbGxlIDxtd2FsbGVAa2VybmVs
Lm9yZz4gIyBvbiBrb250cm9uLXNiYy1pMTIwMA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFu
Z2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxh
Ym9yYS5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+IA0KPiA+ID4gPiBbc25pcF0NCj4gPiA+
ID4gDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtib29sIG10a19vdmxfYWRhcHRvcl9pc19jb21w
X3ByZXNlbnQoc3RydWN0IGRldmljZV9ub2RlICpub2RlKQ0KPiA+ID4gPiA+ICt7DQo+ID4gPiA+
ID4gKwllbnVtIG10a19vdmxfYWRhcHRvcl9jb21wX3R5cGUgdHlwZTsNCj4gPiA+ID4gPiArCWlu
dCByZXQ7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJcmV0ID0gb3ZsX2FkYXB0b3Jfb2ZfZ2V0
X2RkcF9jb21wX3R5cGUobm9kZSwgJnR5cGUpOw0KPiA+ID4gPiA+ICsJaWYgKHJldCkNCj4gPiA+
ID4gPiArCQlyZXR1cm4gZmFsc2U7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJaWYgKHR5cGUg
Pj0gT1ZMX0FEQVBUT1JfVFlQRV9OVU0pDQo+ID4gPiA+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiArCS8qDQo+ID4gPiA+ID4gKwkgKiBJbiB0aGUgY29udGV4dCBv
ZiBtZWRpYXRlay1kcm0sIEVUSERSLCBNRFBfUkRNQSBhbmQgUGFkZGluZyBhcmUNCj4gPiA+ID4g
PiArCSAqIHVzZWQgZXhjbHVzaXZlbHkgYnkgT1ZMIEFkYXB0b3I6IGlmIHRoaXMgY29tcG9uZW50
IGlzIG5vdCBvbmUgb2YNCj4gPiA+ID4gPiArCSAqIHRob3NlLCBpdCdzIGxpa2VseSBub3QgYW4g
T1ZMIEFkYXB0b3IgcGF0aC4NCj4gPiA+ID4gPiArCSAqLw0KPiA+ID4gPiA+ICsJcmV0dXJuIHR5
cGUgPT0gT1ZMX0FEQVBUT1JfVFlQRV9FVEhEUiB8fA0KPiA+ID4gPiA+ICsJICAgICAgIHR5cGUg
PT0gT1ZMX0FEQVBUT1JfVFlQRV9NRFBfUkRNQSB8fA0KPiA+ID4gPiA+ICsJICAgICAgIHR5cGUg
PT0gT1ZMX0FEQVBUT1JfVFlQRV9QQURESU5HOw0KPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4gKw0K
PiA+ID4gPiANCj4gPiA+ID4gW3NuaXBdDQo+ID4gPiA+IA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiArc3RhdGljIGludCBtdGtfZHJtX29mX2dldF9kZHBfZXBfY2lkKHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbm9kZSwNCj4gPiA+ID4gPiArCQkJCSAgICAgaW50IG91dHB1dF9wb3J0LCBlbnVtIG10a19j
cnRjX3BhdGggY3J0Y19wYXRoLA0KPiA+ID4gPiA+ICsJCQkJICAgICBzdHJ1Y3QgZGV2aWNlX25v
ZGUgKipuZXh0LCB1bnNpZ25lZCBpbnQgKmNpZCkNCj4gPiA+ID4gPiArew0KPiA+ID4gPiA+ICsJ
c3RydWN0IGRldmljZV9ub2RlICplcF9kZXZfbm9kZSwgKmVwX291dDsNCj4gPiA+ID4gPiArCWVu
dW0gbXRrX2RkcF9jb21wX3R5cGUgY29tcF90eXBlOw0KPiA+ID4gPiA+ICsJaW50IHJldDsNCj4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gKwllcF9vdXQgPSBvZl9ncmFwaF9nZXRfZW5kcG9pbnRfYnlf
cmVncyhub2RlLCBvdXRwdXRfcG9ydCwgY3J0Y19wYXRoKTsNCj4gPiA+ID4gPiArCWlmICghZXBf
b3V0KQ0KPiA+ID4gPiA+ICsJCXJldHVybiAtRU5PRU5UOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiArCWVwX2Rldl9ub2RlID0gb2ZfZ3JhcGhfZ2V0X3JlbW90ZV9wb3J0X3BhcmVudChlcF9vdXQp
Ow0KPiA+ID4gPiA+ICsJb2Zfbm9kZV9wdXQoZXBfb3V0KTsNCj4gPiA+ID4gPiArCWlmICghZXBf
ZGV2X25vZGUpDQo+ID4gPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ID4gKw0KPiA+
ID4gPiA+ICsJLyoNCj4gPiA+ID4gPiArCSAqIFBhc3MgdGhlIG5leHQgbm9kZSBwb2ludGVyIHJl
Z2FyZGxlc3Mgb2YgZmFpbHVyZXMgaW4gdGhlIGxhdGVyIGNvZGUNCj4gPiA+ID4gPiArCSAqIHNv
IHRoYXQgaWYgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgaW4gYSBsb29wIGl0IHdpbGwgd2FsayB0
aHJvdWdoIGFsbA0KPiA+ID4gPiA+ICsJICogb2YgdGhlIHN1YnNlcXVlbnQgZW5kcG9pbnRzIGFu
eXdheS4NCj4gPiA+ID4gPiArCSAqLw0KPiA+ID4gPiA+ICsJKm5leHQgPSBlcF9kZXZfbm9kZTsN
Cj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlpZiAoIW9mX2RldmljZV9pc19hdmFpbGFibGUoZXBf
ZGV2X25vZGUpKQ0KPiA+ID4gPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiArCXJldCA9IG10a19kcm1fb2ZfZ2V0X2RkcF9jb21wX3R5cGUoZXBfZGV2X25vZGUs
ICZjb21wX3R5cGUpOw0KPiA+ID4gPiA+ICsJaWYgKHJldCkgew0KPiA+ID4gPiA+ICsJCWlmICht
dGtfb3ZsX2FkYXB0b3JfaXNfY29tcF9wcmVzZW50KGVwX2Rldl9ub2RlKSkgew0KPiA+ID4gPiA+
ICsJCQkqY2lkID0gKHVuc2lnbmVkIGludClERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUjsN
Cj4gPiA+ID4gPiArCQkJcmV0dXJuIDA7DQo+ID4gPiA+ID4gKwkJfQ0KPiA+ID4gPiA+ICsJCXJl
dHVybiByZXQ7DQo+ID4gPiA+ID4gKwl9DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJcmV0ID0g
bXRrX2RkcF9jb21wX2dldF9pZChlcF9kZXZfbm9kZSwgY29tcF90eXBlKTsNCj4gPiA+ID4gPiAr
CWlmIChyZXQgPCAwKQ0KPiA+ID4gPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gPiA+ID4gKw0KPiA+
ID4gPiA+ICsJLyogQWxsIG9rISBQYXNzIHRoZSBDb21wb25lbnQgSUQgdG8gdGhlIGNhbGxlci4g
Ki8NCj4gPiA+ID4gPiArCSpjaWQgPSAodW5zaWduZWQgaW50KXJldDsNCj4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiArLyoqDQo+ID4gPiA+ID4gKyAqIG10a19kcm1fb2ZfZGRwX3BhdGhfYnVpbGRfb25lIC0gQnVp
bGQgYSBEaXNwbGF5IEhXIFBpcGVsaW5lIGZvciBhIENSVEMgUGF0aA0KPiA+ID4gPiA+ICsgKiBA
ZGV2OiAgICAgICAgICBUaGUgbWVkaWF0ZWstZHJtIGRldmljZQ0KPiA+ID4gPiA+ICsgKiBAY3Bh
dGg6ICAgICAgICBDUlRDIFBhdGggcmVsYXRpdmUgdG8gYSBWRE8gb3IgTU1TWVMNCj4gPiA+ID4g
PiArICogQG91dF9wYXRoOiAgICAgUG9pbnRlciB0byBhbiBhcnJheSB0aGF0IHdpbGwgY29udGFp
biB0aGUgbmV3IHBpcGVsaW5lDQo+ID4gPiA+ID4gKyAqIEBvdXRfcGF0aF9sZW46IE51bWJlciBv
ZiBlbnRyaWVzIGluIHRoZSBwaXBlbGluZSBhcnJheQ0KPiA+ID4gPiA+ICsgKg0KPiA+ID4gPiA+
ICsgKiBNZWRpYVRlayBTb0NzIGNhbiB1c2UgZGlmZmVyZW50IEREUCBoYXJkd2FyZSBwaXBlbGlu
ZXMgKG9yIHBhdGhzKSBkZXBlbmRpbmcNCj4gPiA+ID4gPiArICogb24gdGhlIGJvYXJkLXNwZWNp
ZmljIGRlc2lyZWQgZGlzcGxheSBjb25maWd1cmF0aW9uOyB0aGlzIGZ1bmN0aW9uIHdhbGtzDQo+
ID4gPiA+ID4gKyAqIHRocm91Z2ggYWxsIG9mIHRoZSBvdXRwdXQgZW5kcG9pbnRzIHN0YXJ0aW5n
IGZyb20gYSBWRE8gb3IgTU1TWVMgaGFyZHdhcmUNCj4gPiA+ID4gPiArICogaW5zdGFuY2UgYW5k
IGJ1aWxkcyB0aGUgcmlnaHQgcGlwZWxpbmUgYXMgc3BlY2lmaWVkIGluIGRldmljZSB0cmVlcy4N
Cj4gPiA+ID4gPiArICoNCj4gPiA+ID4gPiArICogUmV0dXJuOg0KPiA+ID4gPiA+ICsgKiAqICUw
ICAgICAgIC0gRGlzcGxheSBIVyBQaXBlbGluZSBzdWNjZXNzZnVsbHkgYnVpbHQgYW5kIHZhbGlk
YXRlZA0KPiA+ID4gPiA+ICsgKiAqICUtRU5PRU5UIC0gRGlzcGxheSBwaXBlbGluZSB3YXMgbm90
IHNwZWNpZmllZCBpbiBkZXZpY2UgdHJlZQ0KPiA+ID4gPiA+ICsgKiAqICUtRUlOVkFMIC0gRGlz
cGxheSBwaXBlbGluZSBidWlsdCBidXQgdmFsaWRhdGlvbiBmYWlsZWQNCj4gPiA+ID4gPiArICog
KiAlLUVOT01FTSAtIEZhaWx1cmUgdG8gYWxsb2NhdGUgcGlwZWxpbmUgYXJyYXkgdG8gcGFzcyB0
byB0aGUgY2FsbGVyDQo+ID4gPiA+ID4gKyAqLw0KPiA+ID4gPiA+ICtzdGF0aWMgaW50IG10a19k
cm1fb2ZfZGRwX3BhdGhfYnVpbGRfb25lKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBtdGtfY3J0
Y19wYXRoIGNwYXRoLA0KPiA+ID4gPiA+ICsJCQkJCSBjb25zdCB1bnNpZ25lZCBpbnQgKipvdXRf
cGF0aCwNCj4gPiA+ID4gPiArCQkJCQkgdW5zaWduZWQgaW50ICpvdXRfcGF0aF9sZW4pDQo+ID4g
PiA+ID4gK3sNCj4gPiA+ID4gPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbmV4dCwgKnByZXYsICp2
ZG8gPSBkZXYtPnBhcmVudC0+b2Zfbm9kZTsNCj4gPiA+ID4gPiArCXVuc2lnbmVkIGludCB0ZW1w
X3BhdGhbRERQX0NPTVBPTkVOVF9EUk1fSURfTUFYXSA9IHsgMCB9Ow0KPiA+ID4gPiA+ICsJdW5z
aWduZWQgaW50ICpmaW5hbF9kZHBfcGF0aDsNCj4gPiA+ID4gPiArCXVuc2lnbmVkIHNob3J0IGlu
dCBpZHggPSAwOw0KPiA+ID4gPiA+ICsJYm9vbCBvdmxfYWRhcHRvcl9jb21wX2FkZGVkID0gZmFs
c2U7DQo+ID4gPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCS8qIEdl
dCB0aGUgZmlyc3QgZW50cnkgZm9yIHRoZSB0ZW1wX3BhdGggYXJyYXkgKi8NCj4gPiA+ID4gPiAr
CXJldCA9IG10a19kcm1fb2ZfZ2V0X2RkcF9lcF9jaWQodmRvLCAwLCBjcGF0aCwgJm5leHQsICZ0
ZW1wX3BhdGhbaWR4XSk7DQo+ID4gPiA+ID4gKwlpZiAocmV0KSB7DQo+ID4gPiA+ID4gKwkJaWYg
KG5leHQgJiYgdGVtcF9wYXRoW2lkeF0gPT0gRERQX0NPTVBPTkVOVF9EUk1fT1ZMX0FEQVBUT1Ip
IHsNCj4gPiA+ID4gPiArCQkJZGV2X2RiZyhkZXYsICJBZGRpbmcgT1ZMIEFkYXB0b3IgZm9yICVw
T0ZcbiIsIG5leHQpOw0KPiA+ID4gPiA+ICsJCQlvdmxfYWRhcHRvcl9jb21wX2FkZGVkID0gdHJ1
ZTsNCj4gPiA+ID4gPiArCQl9IGVsc2Ugew0KPiA+ID4gPiA+ICsJCQlpZiAobmV4dCkNCj4gPiA+
ID4gPiArCQkJCWRldl9lcnIoZGV2LCAiSW52YWxpZCBjb21wb25lbnQgJXBPRlxuIiwgbmV4dCk7
DQo+ID4gPiA+ID4gKwkJCWVsc2UNCj4gPiA+ID4gPiArCQkJCWRldl9lcnIoZGV2LCAiQ2Fubm90
IGZpbmQgZmlyc3QgZW5kcG9pbnQgZm9yIHBhdGggJWRcbiIsIGNwYXRoKTsNCj4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gPiA+ID4gKwkJfQ0KPiA+ID4gPiA+ICsJ
fQ0KPiA+ID4gPiA+ICsJaWR4Kys7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJLyoNCj4gPiA+
ID4gPiArCSAqIFdhbGsgdGhyb3VnaCBwb3J0IG91dHB1dHMgdW50aWwgd2UgcmVhY2ggdGhlIGxh
c3QgdmFsaWQgbWVkaWF0ZWstZHJtIGNvbXBvbmVudC4NCj4gPiA+ID4gPiArCSAqIFRvIGJlIHZh
bGlkLCB0aGlzIG11c3QgZW5kIHdpdGggYW4gImludmFsaWQiIGNvbXBvbmVudCB0aGF0IGlzIGEg
ZGlzcGxheSBub2RlLg0KPiA+ID4gPiA+ICsJICovDQo+ID4gPiA+ID4gKwlkbyB7DQo+ID4gPiA+
ID4gKwkJcHJldiA9IG5leHQ7DQo+ID4gPiA+ID4gKwkJcmV0ID0gbXRrX2RybV9vZl9nZXRfZGRw
X2VwX2NpZChuZXh0LCAxLCBjcGF0aCwgJm5leHQsICZ0ZW1wX3BhdGhbaWR4XSk7DQo+ID4gPiA+
ID4gKwkJb2Zfbm9kZV9wdXQocHJldik7DQo+ID4gPiA+ID4gKwkJaWYgKHJldCkgew0KPiA+ID4g
PiA+ICsJCQlvZl9ub2RlX3B1dChuZXh0KTsNCj4gPiA+ID4gPiArCQkJYnJlYWs7DQo+ID4gPiA+
ID4gKwkJfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCQkvKg0KPiA+ID4gPiA+ICsJCSAqIElm
IHRoaXMgaXMgYW4gT1ZMIGFkYXB0b3IgZXhjbHVzaXZlIGNvbXBvbmVudCBhbmQgb25lIG9mIHRo
b3NlDQo+ID4gPiA+ID4gKwkJICogd2FzIGFscmVhZHkgYWRkZWQsIGRvbid0IGFkZCBhbm90aGVy
IGluc3RhbmNlIG9mIHRoZSBnZW5lcmljDQo+ID4gPiA+ID4gKwkJICogRERQX0NPTVBPTkVOVF9P
VkxfQURBUFRPUiwgYXMgdGhpcyBpcyB1c2VkIG9ubHkgdG8gZGVjaWRlIHdoZXRoZXINCj4gPiA+
ID4gPiArCQkgKiB0byBwcm9iZSB0aGF0IGNvbXBvbmVudCBtYXN0ZXIgZHJpdmVyIG9mIHdoaWNo
IG9ubHkgb25lIGluc3RhbmNlDQo+ID4gPiA+ID4gKwkJICogaXMgbmVlZGVkIGFuZCBwb3NzaWJs
ZS4NCj4gPiA+ID4gPiArCQkgKi8NCj4gPiA+ID4gPiArCQlpZiAodGVtcF9wYXRoW2lkeF0gPT0g
RERQX0NPTVBPTkVOVF9EUk1fT1ZMX0FEQVBUT1IpIHsNCj4gPiA+ID4gPiArCQkJaWYgKCFvdmxf
YWRhcHRvcl9jb21wX2FkZGVkKQ0KPiA+ID4gPiA+ICsJCQkJb3ZsX2FkYXB0b3JfY29tcF9hZGRl
ZCA9IHRydWU7DQo+ID4gPiA+ID4gKwkJCWVsc2UNCj4gPiA+ID4gPiArCQkJCWlkeC0tOw0KPiA+
ID4gPiA+ICsJCX0NCj4gPiA+ID4gPiArCX0gd2hpbGUgKCsraWR4IDwgRERQX0NPTVBPTkVOVF9E
Uk1fSURfTUFYKTsNCj4gPiA+ID4gDQo+ID4gPiA+IEZvciB0aGUgbXQ4MTk1IGV4dGVybmFsIGRp
c3BsYXkgcGF0aCwgdGhlIE9GIGdyYXBoIGlzDQo+ID4gPiA+IA0KPiA+ID4gPiBtZHBfcmRtYSAo
MCB+IDcpIC0+IHBhZGRpbmcgKDAgfiA3KSAtPiBtZXJnZSAoMSB+IDQpIC0+IGV0aGRyIC0+IG1l
cmdlNQ0KPiA+ID4gPiANCj4gPiA+ID4gYW5kIHRoaXMgZnVuY3Rpb24gd291bGQgZ2VuZXJhdGUg
dGhlIHBhdGggYXMNCj4gPiA+ID4gDQo+ID4gPiA+IG92bF9hZGFwdG9yIC0+IG1lcmdlICgxIH4g
NCkgLT4gbWVyZ2UgNQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBpcyBub3Qgd2hhdCBJIGV4cGVj
dC4NCj4gPiA+ID4gSXMgYW55IHRoaW5nIHdyb25nIHdpdGggbWU/DQo+ID4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBJIG1lYW4gbm8gb2ZmZW5zZSwgcmVhbGx5LCBidXQgeW91ciByZXBseSBoZXJlIGlz
IGEgY29udHJhZGljdGlvbi4uLg0KPiA+ID4gDQo+ID4gPiBJbiBbMV0sIHlvdSBleHBsYWluZWQg
d2hhdCB0aGUgcGF0aCBmb3IgdGhlIGV4dGVybmFsIGRpc3BsYXkgc2hvdWxkIGxvb2sgbGlrZQ0K
PiA+ID4gYW5kIHNhaWQgdGhhdCB0aGUgZ3JhcGggaW4gRFQgc2hvdWxkIGdlbmVyYXRlIGEgcGF0
aCB3aGljaCwgaW4gdGhlIGRyaXZlciwgc2hhbGwNCj4gPiA+IGxvb2sgbGlrZSB0aGUgY3VycmVu
dCBtdDgxOTVfbXRrX2RkcF9leHRbXSBoYXJkY29kZWQgYXJyYXkuDQo+ID4gPiANCj4gPiA+IElu
IFsyXSwgeW91IHJlcGVhdGVkIHRoYXQgeW91ICJqdXN0IHdhbnQgdGhlIHBhdGggdG8gYmUgbGlr
ZSBtdDgxOTVfbXRrX2RkcF9leHRbXSIuDQo+ID4gPiANCj4gPiA+IE5vdyB5b3UncmUgc2F5aW5n
IHRoYXQgdGhpcyBpcyBub3Qgd2hhdCB5b3UgZXhwZWN0Lg0KPiA+ID4gSSBkb24ndCB1bmRlcnN0
YW5kIHlvdXIgaW50ZW50aW9uLg0KPiA+IA0KPiA+IEluIFsxXSAmIFsyXSwgSSB3YW50IHRoZSBw
YXRoIHRvIGJlIGxpa2UgbXQ4MTk1X210a19kZHBfZXh0W10uIEkgZG9uJ3Qga25vdyB3aGVyZSBp
cyB0aGUgY29udHJhZGljdGlvbj8NCj4gPiBtdDgxOTVfbXRrX2RkcF9leHRbXSBpczoNCj4gPiAN
Cj4gPiBvdmxfYWRhcHRvciAtPiBtZXJnZTUNCj4gPiANCj4gPiBidXQgdGhpcyBwYXRjaCBnZW5l
cmF0ZSB0aGUgcGF0aCBhcw0KPiA+IA0KPiA+IG92bF9hZGFwdG9yIC0+IG1lcmdlICgxIH4gNCkg
LT4gbWVyZ2U1DQo+ID4gDQo+ID4gaXQncyBub3QgdGhlIHNhbWUgYW5kIHRoaXMgbWF5IGNhdXNl
IHNvbWV0aGluZyB3cm9uZy4NCj4gPiBJJ20gc29ycnkgbXkgZXhwcmVzc2lvbiBtYWtlIHlvdSBj
b25mdXNlZC4NCj4gPiBTbyB3aGF0IEkgd2FudCBpcyB0byBnZW5lcmF0ZSB0aGUgcGF0aCBhcw0K
PiA+IA0KPiA+IG92bF9hZGFwdG9yIC0+IG1lcmdlNQ0KPiANCj4gQWgsIG9rYXksIG5vIC0geW91
J3JlIG1pc3VuZGVyc3RhbmRpbmcgaG93IHRoZSBPVkxfQURBUFRPUiBpcyB0cmVhdGVkIGhlcmUs
IGhlbmNlDQo+IHdlIG1pc3VuZGVyc3Rvb2QgZWFjaCBvdGhlciBpbiB0aGUgZW5kIQ0KPiANCj4g
VGhlIHJlc3VsdGluZyBwYXRoIGluIG10ODE5NV9tdGtfZGRwX2V4dFtdIHdpbGwgYmUgb3ZsX2Fk
YXB0b3ItPm1lcmdlNSwgYmVjYXVzZQ0KPiB0aGUgbWVyZ2UxLTQgYXJlIGFscmVhZHkgdGFrZW4g
ZHluYW1pY2FsbHkgYnkgdGhlIG92bF9hZGFwdG9yIGRyaXZlciBzbyB0aGVzZQ0KPiB3aWxsIGJl
ICp0ZW1wb3JhcmlseSBvbWl0dGVkKiBpbiB0aGUgZ3JhcGggZm9yIE1UODE5NS4NCg0KRm9yICIq
dGVtcG9yYXJpbHkgb21pdHRlZCogaW4gdGhlIGdyYXBoIGZvciBNVDgxOTUiLCBkbyB5b3UgbWVh
biB0aGUgT0YgZ3JhcGggaXMNCg0KbWRwX3JkbWEgKDAgfiA3KSAtPiBwYWRkaW5nICgwIH4gNykg
LT4gZXRoZHIgLT4gbWVyZ2U1DQoNClNvIHRoZSBwYXRoIHdvdWxkIGJlDQoNCm92bF9hZGFwdG9y
IC0+IG1lcmdlNS4NCg0KU28gdGhpcyBwYXRjaCB3b3JrIGZpbmUgZGVwZW5kaW5nIG9uIHRoZSB0
cmlja3kgd2F5IG9mIE9GIGdyYXBoLg0KQWRkIGNvbW1lbnQgdG8gZGVzY3JpYmUgdGhlIHRyaWNr
eSB3YXkgb2YgT0YgZ3JhcGguIEFmdGVyIHRoaXMsDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2su
aHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBNeSBpbnRlbnRpb24gaXMgdG8gYWRkIGhhbmRsaW5n
IGZvciB0aGUgYWRkaXRpb25hbCBtZXJnZTEtNCAoYW5kIHNpbWlsYXIpIHNlbGVjdGlvbg0KPiB3
aXRoIE9GIEdyYXBoIHN1cHBvcnQgKmxhdGVyKiwgbm90IGluIHRoaXMgc2VyaWVzIChwbGVhc2Ug
YmUgYXdhcmUgdGhhdCBpdCB3aWxsDQo+ICpub3QgYmUgbmVlZGVkKiB0byBjaGFuZ2UgYW55IGJp
bmRpbmdzLCBhbmQgY29tcGF0aWJpbGl0eSB3aWxsIGJlIGd1YXJhbnRlZWQgd2l0aA0KPiBubyBh
ZGRpdGlvbmFsIGVmZm9ydCkuDQo+IA0KPiBUaGlzIGlzIGJlY2F1c2UgSSBiZWxpZXZlIHRoYXQg
dGhlIG92bF9hZGFwdG9yIGRyaXZlciBuZWVkcyBtb3JlIGNoYW5nZXMgdGhhbiBqdXN0DQo+IGEg
YmFzaWMgT0YgR3JhcGggaW1wbGVtZW50YXRpb246IGFzIG9mIG5vdywgdGhhdCBkcml2ZXIgaXMg
cHJhY3RpY2FsbHkgc3BlY2lmaWMgdG8NCj4ganVzdCBNVDgxOTUgYW5kIE1UODE4OCwgYXMgdGhl
IE9WTF9BREFQVE9SIHNwZWNpZmljIE1FUkdFIHBhdGhzIGFyZSBoYXJkY29kZWQuDQo+IA0KPiBT
bywgSSBhbSBwbGFubmluZyB0byBpbXByb3ZlIHRoZSBvdmxfYWRhcHRvciBkcml2ZXIsIGJ1dCB0
aGF0IHdpbGwgYmUgYSBzZXBhcmF0ZWQNCj4gc2VyaWVzIGFzIGl0J3MgcHJvYmFibHkgZ29pbmcg
dG8gYmUgYSByZWxhdGl2ZWx5IChpbiByZWxhdGlvbiB0byB0aGUgc2l6ZSBvZiB0aGUNCj4gb3Zs
X2FkYXB0b3IgZHJpdmVyKSBiaWcgc2V0IG9mIGNoYW5nZXMuDQo+IA0KPiBSZWdhcmRzLA0KPiBB
bmdlbG8NCj4gDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBDSw0KPiA+IA0KPiA+ID4gDQo+ID4g
PiBbMV06DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNThlZTA5YWViNWEyMjRk
YmM4ZmFlZTIzNmVkMWE3N2NlM2ZiZDAxMS5jYW1lbEBtZWRpYXRlay5jb20vDQo+ID4gPiANCj4g
PiA+IFsyXToNCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8wNGYxNTA2YjIzYjQx
Yzc3NWUwNzM1YjViMzE4OWI0MTE4NTAwNzE1LmNhbWVsQG1lZGlhdGVrLmNvbS8NCj4gPiA+IA0K
PiA+ID4gUmVnYXJkcywNCj4gPiA+IEFuZ2Vsbw0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiArCS8qDQo+ID4gPiA+ID4gKwkgKiBUaGUgZGV2aWNlIGNvbXBvbmVudCBt
aWdodCBub3QgYmUgZW5hYmxlZDogaW4gdGhhdCBjYXNlLCBkb24ndA0KPiA+ID4gPiA+ICsJICog
Y2hlY2sgdGhlIGxhc3QgZW50cnkgYW5kIGp1c3QgcmVwb3J0IHRoYXQgdGhlIGRldmljZSBpcyBt
aXNzaW5nLg0KPiA+ID4gPiA+ICsJICovDQo+ID4gPiA+ID4gKwlpZiAocmV0ID09IC1FTk9ERVYp
DQo+ID4gPiA+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwkvKiBJ
ZiB0aGUgbGFzdCBlbnRyeSBpcyBub3QgYSBmaW5hbCBkaXNwbGF5IG91dHB1dCwgdGhlIGNvbmZp
Z3VyYXRpb24gaXMgd3JvbmcgKi8NCj4gPiA+ID4gPiArCXN3aXRjaCAodGVtcF9wYXRoW2lkeCAt
IDFdKSB7DQo+ID4gPiA+ID4gKwljYXNlIEREUF9DT01QT05FTlRfRFBfSU5URjA6DQo+ID4gPiA+
ID4gKwljYXNlIEREUF9DT01QT05FTlRfRFBfSU5URjE6DQo+ID4gPiA+ID4gKwljYXNlIEREUF9D
T01QT05FTlRfRFBJMDoNCj4gPiA+ID4gPiArCWNhc2UgRERQX0NPTVBPTkVOVF9EUEkxOg0KPiA+
ID4gPiA+ICsJY2FzZSBERFBfQ09NUE9ORU5UX0RTSTA6DQo+ID4gPiA+ID4gKwljYXNlIEREUF9D
T01QT05FTlRfRFNJMToNCj4gPiA+ID4gPiArCWNhc2UgRERQX0NPTVBPTkVOVF9EU0kyOg0KPiA+
ID4gPiA+ICsJY2FzZSBERFBfQ09NUE9ORU5UX0RTSTM6DQo+ID4gPiA+ID4gKwkJYnJlYWs7DQo+
ID4gPiA+ID4gKwlkZWZhdWx0Og0KPiA+ID4gPiA+ICsJCWRldl9lcnIoZGV2LCAiSW52YWxpZCBk
aXNwbGF5IGh3IHBpcGVsaW5lLiBMYXN0IGNvbXBvbmVudDogJWQgKHJldD0lZClcbiIsDQo+ID4g
PiA+ID4gKwkJCXRlbXBfcGF0aFtpZHggLSAxXSwgcmV0KTsNCj4gPiA+ID4gPiArCQlyZXR1cm4g
LUVJTlZBTDsNCj4gPiA+ID4gPiArCX0NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlmaW5hbF9k
ZHBfcGF0aCA9IGRldm1fa21lbWR1cChkZXYsIHRlbXBfcGF0aCwgaWR4ICogc2l6ZW9mKHRlbXBf
cGF0aFswXSksIEdGUF9LRVJORUwpOw0KPiA+ID4gPiA+ICsJaWYgKCFmaW5hbF9kZHBfcGF0aCkN
Cj4gPiA+ID4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlk
ZXZfZGJnKGRldiwgIkRpc3BsYXkgSFcgUGlwZWxpbmUgYnVpbHQgd2l0aCAlZCBjb21wb25lbnRz
LlxuIiwgaWR4KTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwkvKiBQaXBlbGluZSBidWlsdCEg
Ki8NCj4gPiA+ID4gPiArCSpvdXRfcGF0aCA9IGZpbmFsX2RkcF9wYXRoOw0KPiA+ID4gPiA+ICsJ
Km91dF9wYXRoX2xlbiA9IGlkeDsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlyZXR1cm4gMDsN
Cj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICsNCj4gPiA+IA0KPiA+ID4gDQo+IA0KPiANCg==

