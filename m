Return-Path: <linux-kernel+bounces-535628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7754A47550
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35933AFC52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B120E31D;
	Thu, 27 Feb 2025 05:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ehhK9PzM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JVjsb4cV"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379951E5210;
	Thu, 27 Feb 2025 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634948; cv=fail; b=FaZt7WNQ6K6aO8Xe/vd7jjX/OJC+a76ynDrDHBRvyBorPgw5vCzXwQaGoT5tq7DhOn/RTBMXYDMcSnJK1er4Bk4WvZjqHWT3G36AGbXlrGa1gaDFcFDkji2go90HHkEkcmrOY/uYGrO7/TagqreF2EleGKgvwyZFfjZXbGleYd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634948; c=relaxed/simple;
	bh=gfSoNOv9v3lLhlg1GUm6CRS75fmR7crwdj9l84rE4ZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P59+/ivf173et2SQbJqHjIuEfK5KTf5W+INfDCb3f8BHWgPxTka1kH/J8JkuTjmHPvaHy1kadSszWe5KIyNpl6QuqE5fbjD9MgTfr7H3EUcYttjpndd0fuX3wX6C1j1MMRh5eOVAvONlch3IgC9gRcKM3LQ1H+YAHAVh7qtIIDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ehhK9PzM; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JVjsb4cV; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9cda681cf4cd11efaae1fd9735fae912-20250227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gfSoNOv9v3lLhlg1GUm6CRS75fmR7crwdj9l84rE4ZY=;
	b=ehhK9PzMYgF4ci8vm4T6GMB4TX27iKR+s78w9fuF1cUz7oC0R/6uUJTldd1hXoodS/ZTNvwYCm+kaHpHu1tf7iA17OLxPQR4lJ1XZD9fLqAMYZf5YlAlaxc2Pda8ak4DjxOuIUlgCFxKcUzGKlE1ltjBxWQXT3y+oCf6OAjGl/U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:62c3bbde-27bd-40a8-b32e-f8a25899e5bd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:7849a3b5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9cda681cf4cd11efaae1fd9735fae912-20250227
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1788056914; Thu, 27 Feb 2025 13:42:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 27 Feb 2025 13:42:19 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 27 Feb 2025 13:42:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2T4APlkhObPdRl96Uy2tjlhdyvkzJj9eRZQZm5QXwsi9oa1SIts6uJOs7WH5aYQ96zx0/Nb0BstUsuRAsxZd7Vy+U1G808X6Dq//tHf3dT7bDuv0eCQsBrCbTuCpU80bI71BBo62IKzVVLYohCtBLL1J8nZl6NOl9XfYQ+BbiAyoYW8fTBma5HBLN6E7V690rWpLdhmQ0NJe37RO0elv4kefSpBrP7ojcX7899+Zzv3YEHGt3MbIh4OZbF0cT1pfKE6Hf7Tn1yc1vSv1RTMkIL0t7qkb5491c4Wlw1nYNCUWPYG56STZtR81Bzqd+gfYv2VwaT/kc5yliqK1b6Y/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfSoNOv9v3lLhlg1GUm6CRS75fmR7crwdj9l84rE4ZY=;
 b=XdBLWePWmrzCbhCHnXE1icMLfgEBssqVrb9ORUqIgEXWauNPjcXN3H9cgL58fxU+MtA1r2ReYpGzuTDHtJYNNCuT8SMAHXg8toDZpcxM7+0WCU13nOukb+eZ3GbGNOlycosN3SpBk78MP05CXxBURVmuk/D94ulg+sGKT+4eC5vD9L1zGHtPWn+OSmll7uoHdDkTbgoDsAgXsH7FpjUSt9dDFgnE8ZW6AYgHbUAnsg3AA5l5zQPhCksioleKG5KV9oSKu9JuBxxF/+bNZ9CLAD1VnpZT0TK8MA42ORpXbJRnY+1XEowyPMl5cka1w4GgVYVHUree4fLNPnJzWCpNwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfSoNOv9v3lLhlg1GUm6CRS75fmR7crwdj9l84rE4ZY=;
 b=JVjsb4cV+eVKdxYY3yFp2TeEyHGmmiTjzJSEwEXOmx1IAq8BhOuPsnRqg7SpWe802jwGZsdGhEW44/u2ETB03FZxbqzUbbjttQjXHuJRnzQ9ECptHCDbRrpGUeWjsr6Uhb/kq0mDGqlmHqpT6CrjPT/e6j4LscyckLv3Vj1A9os=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7310.apcprd03.prod.outlook.com (2603:1096:820:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Thu, 27 Feb
 2025 05:42:14 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 05:42:14 +0000
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
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, =?utf-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?=
	<TommyYL.Chen@mediatek.com>, =?utf-8?B?SXZlcyBDaGVuamggKOmZs+S/iuW8mCk=?=
	<Ives.Chenjh@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
	<Jason-JH.Lin@mediatek.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v7 25/43] drm/mediatek: mtk_hdmi: Use dev_err_probe() in
 mtk_hdmi_dt_parse_pdata()
Thread-Topic: [PATCH v7 25/43] drm/mediatek: mtk_hdmi: Use dev_err_probe() in
 mtk_hdmi_dt_parse_pdata()
Thread-Index: AQHbgVPOXiv2svMP/0SgUtscOiygJrNasg0A
Date: Thu, 27 Feb 2025 05:42:14 +0000
Message-ID: <e849a7141b051e29389abf6dac5af22b8a0aab4b.camel@mediatek.com>
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
	 <20250217154836.108895-26-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-26-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7310:EE_
x-ms-office365-filtering-correlation-id: a7c0241a-9e61-4fa5-f722-08dd56f17d60
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UEFRSFdYcGpIK21nc3VjYTJOMXRMR1cveDZWZ3dYaU5nN2FTUi9hUU9MTnRk?=
 =?utf-8?B?aDhaZmRIbjdUbkFFQXJva1NsdENoR2UzK0tUaGovWVplUGppR3RYejJYZFdJ?=
 =?utf-8?B?dG5QTWJ6QkJrZlp1OEtiY2JndVI4WTk5dnF2cU44MkdpbmpNOTVOS0xjS24r?=
 =?utf-8?B?cWdLOGZseWpJZjE5UHY2bmNrTWlJdnNaN29JbDlTaXFUL2ZGeUV5aGxQWVk4?=
 =?utf-8?B?bkdKZjFQZ3NEMXh3V1lDMGYxd2Frb1JHdnhQcHdZZkdqRFdPaGhMeVJlUS9D?=
 =?utf-8?B?dExwZmp2cytRRFQzcEgwMDhqYXZESzNPaDNUYlNnOElBeXpoZHUzcndqV3dX?=
 =?utf-8?B?OXVtaEplZ2pXQTU1eEc0cHVTUlZGNEQ2RzRSVnR6QjVlM0hFdmR6c3BLQkl1?=
 =?utf-8?B?QllPQTdCbzlMSFpJcndVcTZaUWdsaG91YUxsR3lVbUFDU2U5V1FoMmIzMmZk?=
 =?utf-8?B?MXlBYi9seElEdWxHNE9FRUE1L0FycVdqcExNQ3JybHdFOFFQL0ovVHRzNWUx?=
 =?utf-8?B?ZXVVdmt4bWZMV2VhY3JjTGpCNzBXQlQzNWJYYjlodEdsdUVjYUhUdlBFV3FZ?=
 =?utf-8?B?SDZIR3VaNFZyTWpwMkx2Zm9mWVdtNUwzd0VoWWpzMVQ2bkoyOGtwTGtFZFow?=
 =?utf-8?B?N3h4bTJWWFh3OGZoQ0lqUTZJcU56QjFzR1pnb0NrSjV3eWdoTys3R2ptR1pn?=
 =?utf-8?B?MEphWVNmT1pNNEpBUFEvNXpTQjdVWVJ0WHFkdE1TT3Q3cG91d2hwRkszV3cv?=
 =?utf-8?B?Y2R2WkhyUVY4RTlzY0NrejZFYThLQzZlMnpaUi9IUGNYYy9FcmR4QldVYldr?=
 =?utf-8?B?YVJiKzJhUGZGRlJHVFdmdnJsR1daSTBkUmxya0p1TGJjNk9uUFJSWkIzbmty?=
 =?utf-8?B?Nkw3anhleTA3NkZ5cXRQcGNudDlvTDZjaE44azZKSnB2VnhXVTN3T1JzWGlB?=
 =?utf-8?B?NkQ2eFJrdkxrSDEwRGxFL0J4V2hiYkpUdDJvN2EwZTJ5eE9HczFBSWdoUy96?=
 =?utf-8?B?dFIxOUxUT3QvZ01jUnNZK2hZaWc0Nkl1Vmc2QS83Nlo1ZXNCSzB6SFd0Qkow?=
 =?utf-8?B?M3NHOThkaUtndmVpVzdGc3o4Tkx2YTVabG1wOFhYcGxDZTRLUzQyM1Z4TU1B?=
 =?utf-8?B?bk45L01MKzgxRVBVelZNOEQ2TWlrOUMwSE5jYzBnY0tSa3dtQTNlcVlrOTBL?=
 =?utf-8?B?UndnbnBBUkUyamJLNmxFcS9qYlFJSHUvMTZBbWhkc1dXQll6ZFJ6WXA0VFFW?=
 =?utf-8?B?VU9rUEk3SDVxUGhrSVlaY2hGa0t5M21yZTJZVVFsV2drMVdTUklIc0xtRnpD?=
 =?utf-8?B?cG5kSlhBRm5raU5sYjFtd3dMbjJ0OFI2L0lFUThySU81cG9JNzJBbStvSWd3?=
 =?utf-8?B?NStVTmtBSkNlc3dhVzVCeWU1eGo0cUY4cWNxUENJcGh1alp4b3FCZnB0RVVm?=
 =?utf-8?B?RGpKQ2lPRDhncVVmcmE2dk9wa050ZnFkTThxYmtkelV5VmgxanpHdGtUMys3?=
 =?utf-8?B?cUpvc0pWOXZlZFBTR0JNWE5Fdis3bk5id0RTVUNaZmVlejFMME5paC82OUFW?=
 =?utf-8?B?WERxQTE5aXdFWVQyZGVwWEtGdXMwWXpLbDZxNVRJenhUbTJhYkJrSWY2c0lB?=
 =?utf-8?B?UWNuTW5jblB2MDFtRjJJT3RiYlVYTUpLMDhtdmZ1dk8zTHZid3dzajlWelNL?=
 =?utf-8?B?M3c1bTBIZHZuQzJYRmdaZWF3cU10OWxzeGhtUGhuK3MwVlJDVElmU0x5alJK?=
 =?utf-8?B?RUdpTFhsSk5xUlZCQ3E2bGdJbjhMVmg2SGN3Q0tZTWhJZ1NwaExmWkxleDFQ?=
 =?utf-8?B?QWNSVk13ajhZckZjRC9nWHQ3VGpKakNabWZJT3Z1OTh5Q3c2dEkzRko4TjNs?=
 =?utf-8?B?ZWgzOXArVDJNdlMvSFVvOEtsK2gzTzdWVlJqQ0JmWWVaNWFZWmVMYnp3M1JM?=
 =?utf-8?Q?tSIijSUXwlH7pPXqH0vKGK3Mxir+6Vj2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejQzOFNBOW5PODJSejU2V003YWwvOVJYS2lGbWRmMGM1YjlRTGpXVFlZclhD?=
 =?utf-8?B?VWg2QWdsbUt5ZkkwT2hjYlpYMVhNKytub1dFWkNpcU5WSTU3aVJGMjFmMEd3?=
 =?utf-8?B?OWljVyszL3JuVHp0L243dHFNNytIK2dvU00wcGVwMzkzcjRJSjlxU0dtcFJG?=
 =?utf-8?B?NWJBditiQkdGU2VkRWNIbStmRGkwN2orUEs2QitJMFJMTHBVR1ZNbnlhTHJN?=
 =?utf-8?B?OGhyRi9vbU1ab0lmUTJ0VCsvbi9NdTM0TllUNThwTlRmekhRMkVUaEZOS1Br?=
 =?utf-8?B?UUxSa2dFR0NyMCtscWZ5K3daYTRaRjAyMnkzRm1kc3JFR2dyUEVNeTIyUytS?=
 =?utf-8?B?L0Fucit6MHNpb2I4bUROK3ZDbWhxeVc4aXVyWFNBSnUreGMyVHMwd0R2TnpN?=
 =?utf-8?B?T1NsWVhtcXFMaTZ1VzQ0NGVoZGl0R0krdUdRQjVCOHN5cHJhZjRtVzlwQzNQ?=
 =?utf-8?B?Tm1UcjNqOTM1ZFVlRlBuWjhVbmVvNGhtMEp0ODZVV0RUdEVYTFpITjUyMVU1?=
 =?utf-8?B?Q0tyRFgwK2N6MDd6TEJSdEhSYWt0Q2g4VVJiZTY5d0tMdVhoOVI3QjRrb0tO?=
 =?utf-8?B?RldwT3Z1WkJ4eUFJWGoxOXRzaWJFUTdVZi9ReS85eVlpZkdLMlBiTGt3Mzdj?=
 =?utf-8?B?RUdmRDBxVkVZTWpsOGliYVMyZ3BZQ282NmYxdWJrUU5jdXUwc3locEkzdGVs?=
 =?utf-8?B?d0Z2WnJ2d21jSXJKWHZqZ2JLUUFkZ3M0Q3JGWEVCVmdpdnVvZXBzYVp2a0t6?=
 =?utf-8?B?L3FPS0RKM0htOWdYc0VTcFFVU1lPT01WYSsvL1IxaDAyMjJNSGVRVko3cEJj?=
 =?utf-8?B?WitxVXowdXNrSTN2SmY2T0NHd29JUjN1WHVyRFA1Vzc2b0RJdkNoejRlV3JV?=
 =?utf-8?B?NHo1Ym54UjNWT0FyRmF6bXRhRm5OZGtpVHh6dzJmWDVsY0kraXBwTW1reG12?=
 =?utf-8?B?ZStFcmpyU1lsN1FtN1oxZHpFbGJnc1pRVWhsNVM1NTQ4YTQ3bVRxOGs1NUtU?=
 =?utf-8?B?NTdFRDBob2R4RmFZa3E1RWdrZHFOTXB3enkwcUJNc1BrZHFNL2x3am5LRml2?=
 =?utf-8?B?am5mczM3UjVuZEhISmRaWEhnMkE4K1ArNXpjbUJuK2I1V3NRa1F6UExhaFVv?=
 =?utf-8?B?THNkRWhUUHJoZDNReExaTlhFbDRyVUpuV3NlY3JkOEVGK3VxSzJUakg5TWVm?=
 =?utf-8?B?aWZDTjFYa3RFeVpZOEJjcldvS29BdnlHMU5YZ0FyRW5KRXFKcDVNODFpUW44?=
 =?utf-8?B?Y2wwVzNSVzFDU0pzZGRYR1REOGV3UGhZVFZBY3dvQk1TSndGQk53bTBZSVVG?=
 =?utf-8?B?TzdoVnNEOFBaQXE2QVZCTWJHai9EQXEzcHlYZzVDZmVZS0JMUmt3M3d5ZE9a?=
 =?utf-8?B?RnBHclFha0MvSkpCUENJejdZcmNUK1pYVmRyOEQ5dVExeTM5TGMyczNGdWNS?=
 =?utf-8?B?NWJ0TTJ6aDBMa1ZYZnVtRk5pUE15bEU5N3hoQ3pxRENCdXdVNXBwSmtZRFB6?=
 =?utf-8?B?b2FmcXRiY3FBRFFVbWUydzVkQ005SStRRE9ISytiNDhYSndETC9KdzVNVjhV?=
 =?utf-8?B?amV4cEl5UkRIbVd2cnYwUEdRNzdESHhjK04rNXFXSGpDTU53WTZZbTJRQ2NU?=
 =?utf-8?B?cjd2TFpTMWZmT1c0OVE5VC9DRjFWNXdHbVN6Q1NVaHdtZHUyQTZqRHFPWnRN?=
 =?utf-8?B?MWZwYUI4R21zNWE0Mkxlc205QTVyNCtycXdUN1ptUGR5emV3TE5wUmc0RC95?=
 =?utf-8?B?YnB2T2RFdGhLcmhUdnR2YTlBQk8vd2srcE5YUCt6RU0reEI1MU53Z0ZtOUtL?=
 =?utf-8?B?YzNUOW1ZVGFNR1dmQm41UFNvbWF4VXdpdFkyQWtJaHpTMGdUODcrUmxlVFBR?=
 =?utf-8?B?NHNvMGVPT20rWlVEVkhkQ2gwWnJ2bHRtL21lN2U5QitSOGVpVmw4WGduVkFC?=
 =?utf-8?B?MlIzZHhoWE45NFYvUUtjUzRTbGJiY01MUThCV2FBUkRnWUdub3dKMmM2UEtK?=
 =?utf-8?B?VklJdE40VStaSzdEWVl3KzRHVGhTRENWSTg3OTFQa2xjbEVERlczNXdMSlRz?=
 =?utf-8?B?bG9TWUhCQXArTEgycUIzaWZOL2xFNy9BWlFQZERxUGpvL2xoUUJrT2l4aXg1?=
 =?utf-8?Q?jrh6hBhCO6glELiWcr8NCGXxb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B50571179FBC8644BDBA542077078BE9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c0241a-9e61-4fa5-f722-08dd56f17d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 05:42:14.7046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gw5YsLWjhQ6p38HgtUkmCqG4w55Iryjt5/xgH8qp3HPyjxiD+ttEYsyxVv0dyoZqxtPzx3Uj4X1+mmAooQHeHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7310

SGksIEFuZ2VsbzoNCg0KT24gTW9uLCAyMDI1LTAyLTE3IGF0IDE2OjQ4ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBDaGFuZ2UgZXJyb3IgcHJp
bnRzIHRvIHVzZSBkZXZfZXJyX3Byb2JlKCkgaW5zdGVhZCBvZiBkZXZfZXJyKCkNCj4gd2hlcmUg
cG9zc2libGUgaW4gZnVuY3Rpb24gbXRrX2hkbWlfZHRfcGFyc2VfcGRhdGEoKSwgdXNlZCBvbmx5
DQo+IGR1cmluZyBkZXZpY2UgcHJvYmUuDQo+IFdoaWxlIGF0IGl0LCBhbHNvIGJlYXV0aWZ5IHNv
bWUgcHJpbnRzLg0KDQpJIHdvdWxkIGFwcGx5IGJ1Zy1maXgsIGNsZWFudXAsIGFuZCByZWZpbmVt
ZW50IHBhdGNoZXMgZmlyc3QgYW5kIHRoZW4gYXBwbHkgdjIgcmVsYXRlZCBwYXRjaGVzLg0KU28g
YnVnLWZpeCwgY2xlYW51cCwgYW5kIHJlZmluZW1lbnQgcGF0Y2hlcyBjb3VsZCBiZSBiYWNrcG9y
dGVkIHRvIG9sZCB2ZXJzaW9uIGJyYW5jaCB3aXRob3V0IGFueSB2MiByZWxhdGVkIHBhdGNoZXMu
DQpXaGVuIEkgYXBwbHkgdGhpcyBwYXRjaCwgY29uZmxpY3RzIGhhcHBlbi4NClBsZWFzZSByZWJh
c2UgdGhpcyBzZXJpZXMgb250byBtZWRpYXRlay1kcm0tbmV4dCwgYW5kIGFwcGx5IHRoaXMgcGF0
Y2ggYmVmb3JlIHYyIHJlbGF0ZWQgcGF0Y2hlcy4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFJl
dmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBB
bmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xs
YWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5j
IHwgMzEgKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfaGRtaS5jDQo+IGluZGV4IDRiZjE5NTc0NDYzZC4uNjFlNTIxNDMwYjQ4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYw0KPiBAQCAtMTM3MiwyNSArMTM3MiwxOSBA
QCBzdGF0aWMgaW50IG10a19oZG1pX2R0X3BhcnNlX3BkYXRhKHN0cnVjdCBtdGtfaGRtaSAqaGRt
aSwNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAg
ICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7DQo+IC0gICAgICAg
c3RydWN0IGRldmljZV9ub2RlICpjZWNfbnAsICpyZW1vdGUsICppMmNfbnA7DQo+ICsgICAgICAg
c3RydWN0IGRldmljZV9ub2RlICpyZW1vdGUsICppMmNfbnA7DQo+ICAgICAgICAgc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqY2VjX3BkZXY7DQo+ICAgICAgICAgc3RydWN0IHJlZ21hcCAqcmVnbWFw
Ow0KPiAgICAgICAgIGludCByZXQ7DQo+IA0KPiAgICAgICAgIHJldCA9IG10a19oZG1pX2dldF9h
bGxfY2xrKGhkbWksIG5wKTsNCj4gLSAgICAgICBpZiAocmV0KSB7DQo+IC0gICAgICAgICAgICAg
ICBpZiAocmV0ICE9IC1FUFJPQkVfREVGRVIpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGRl
dl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBjbG9ja3M6ICVkXG4iLCByZXQpOw0KPiAtDQo+IC0g
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAtICAgICAgIH0NCj4gKyAgICAgICBpZiAocmV0
KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWls
ZWQgdG8gZ2V0IGNsb2Nrc1xuIik7DQo+IA0KPiAgICAgICAgIC8qIFRoZSBDRUMgbW9kdWxlIGhh
bmRsZXMgSERNSSBob3RwbHVnIGRldGVjdGlvbiAqLw0KPiAgICAgICAgIGNlY19ucCA9IG9mX2dl
dF9jb21wYXRpYmxlX2NoaWxkKG5wLT5wYXJlbnQsICJtZWRpYXRlayxtdDgxNzMtY2VjIik7DQo+
IC0gICAgICAgaWYgKCFjZWNfbnApIHsNCj4gLSAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAi
RmFpbGVkIHRvIGZpbmQgQ0VDIG5vZGVcbiIpOw0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQo+IC0gICAgICAgfQ0KPiArICAgICAgIGlmICghY2VjX25wKQ0KPiArICAgICAgICAg
ICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAtRUlOVkFMLCAiRmFpbGVkIHRvIGZpbmQg
Q0VDIG5vZGVcbiIpOw0KPiANCj4gICAgICAgICBjZWNfcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5
X25vZGUoY2VjX25wKTsNCj4gICAgICAgICBpZiAoIWNlY19wZGV2KSB7DQo+IEBAIC0xNDEzLDkg
KzE0MDcsOCBAQCBzdGF0aWMgaW50IG10a19oZG1pX2R0X3BhcnNlX3BkYXRhKHN0cnVjdCBtdGtf
aGRtaSAqaGRtaSwNCj4gICAgICAgICBpZiAoSVNfRVJSKHJlZ21hcCkpDQo+ICAgICAgICAgICAg
ICAgICByZXQgPSBQVFJfRVJSKHJlZ21hcCk7DQo+ICAgICAgICAgaWYgKHJldCkgew0KPiAtICAg
ICAgICAgICAgICAgZGV2X2VycihkZXYsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICJGYWls
ZWQgdG8gZ2V0IHN5c3RlbSBjb25maWd1cmF0aW9uIHJlZ2lzdGVyczogJWRcbiIsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHJldCk7DQo+ICsgICAgICAgICAgICAgICBkZXZfZXJyX3Byb2Jl
KGRldiwgcmV0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHRvIGdl
dCBzeXN0ZW0gY29uZmlndXJhdGlvbiByZWdpc3RlcnNcbiIpOw0KPiAgICAgICAgICAgICAgICAg
Z290byBwdXRfZGV2aWNlOw0KPiAgICAgICAgIH0NCj4gICAgICAgICBoZG1pLT5zeXNfcmVnbWFw
ID0gcmVnbWFwOw0KPiBAQCAtMTQ0MywyMCArMTQzNiwxNiBAQCBzdGF0aWMgaW50IG10a19oZG1p
X2R0X3BhcnNlX3BkYXRhKHN0cnVjdCBtdGtfaGRtaSAqaGRtaSwNCj4gICAgICAgICB9DQo+IA0K
PiAgICAgICAgIGkyY19ucCA9IG9mX3BhcnNlX3BoYW5kbGUocmVtb3RlLCAiZGRjLWkyYy1idXMi
LCAwKTsNCj4gKyAgICAgICBvZl9ub2RlX3B1dChyZW1vdGUpOw0KPiAgICAgICAgIGlmICghaTJj
X25wKSB7DQo+IC0gICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBmaW5kIGRk
Yy1pMmMtYnVzIG5vZGUgaW4gJXBPRlxuIiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmVt
b3RlKTsNCj4gLSAgICAgICAgICAgICAgIG9mX25vZGVfcHV0KHJlbW90ZSk7DQo+IC0gICAgICAg
ICAgICAgICByZXQgPSAtRUlOVkFMOw0KPiArICAgICAgICAgICAgICAgcmV0ID0gZGV2X2Vycl9w
cm9iZShkZXYsIC1FSU5WQUwsICJObyBkZGMtaTJjLWJ1cyBpbiBjb25uZWN0b3JcbiIpOw0KPiAg
ICAgICAgICAgICAgICAgZ290byBwdXRfZGV2aWNlOw0KPiAgICAgICAgIH0NCj4gLSAgICAgICBv
Zl9ub2RlX3B1dChyZW1vdGUpOw0KPiANCj4gICAgICAgICBoZG1pLT5kZGNfYWRwdCA9IG9mX2Zp
bmRfaTJjX2FkYXB0ZXJfYnlfbm9kZShpMmNfbnApOw0KPiAgICAgICAgIG9mX25vZGVfcHV0KGky
Y19ucCk7DQo+ICAgICAgICAgaWYgKCFoZG1pLT5kZGNfYWRwdCkgew0KPiAtICAgICAgICAgICAg
ICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IGRkYyBpMmMgYWRhcHRlciBieSBub2RlXG4i
KTsNCj4gLSAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+ICsgICAgICAgICAgICAgICBy
ZXQgPSBkZXZfZXJyX3Byb2JlKGRldiwgLUVJTlZBTCwgIkZhaWxlZCB0byBnZXQgZGRjIGkyYyBh
ZGFwdGVyIGJ5IG5vZGVcbiIpOw0KPiAgICAgICAgICAgICAgICAgZ290byBwdXRfZGV2aWNlOw0K
PiAgICAgICAgIH0NCj4gDQo+IC0tDQo+IDIuNDguMQ0KPiANCg0K

