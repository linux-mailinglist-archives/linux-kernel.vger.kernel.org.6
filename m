Return-Path: <linux-kernel+bounces-514299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DDBA35543
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F281891919
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6FA1519AB;
	Fri, 14 Feb 2025 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tpp93AjN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jObcqNBo"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900D2F24;
	Fri, 14 Feb 2025 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739503260; cv=fail; b=Wc6JXtP0NOXR2lm3sfHdaudPGZNjXiKRV0zYNwiZcfWpr6FF1x3IaaQguSr7ogcUfLtvVhNAxc6+4OD8Ji+wNXvA8TvjG4GgmpvnekcjyFzb9jNy9BzBw4eSsqLmuig4mmN4auGrvJ6vlGjVXFhAiFCOcwIfzvQlQZ/jAPr2DE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739503260; c=relaxed/simple;
	bh=YX63LZVyHHCtct0+XqUVAE6qtnYyjwgvf4jYELWgPvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bZUHQ/cZsNrYwWGjcPBUQndKG03kPl1D8GPCiGtnViLmwC3n62TKfewpGVs/z0DKHupxnQpTXw9uilTnnuRD54Ru0hUKrdHTRpMrwd4qnzYcEcp0flQLzOa3DjQfU0JQwHfnZKHzqidYf2pU54OhxdPchDgPxa9RaO/50HNoYgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Tpp93AjN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jObcqNBo; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b05c05daea8211efbd192953cf12861f-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YX63LZVyHHCtct0+XqUVAE6qtnYyjwgvf4jYELWgPvk=;
	b=Tpp93AjNml/nRm34GMFHpDGEy58WWMyfCAshgwLoX0/qrtq2zNqFkuhornzNIFPa3x0LOfSpfxKKP3u3lZTdTyUbepthRYSUsRkdINtdPFTQW2Cy7xLutXm2T+zfmz4ex1rnkKhMBlaKs7n8IjRWCnV61wSrlDhrZkpC7mOnHss=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:dd60ec52-12f0-4e3d-9b79-be707dd42cb8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:8d155a8f-637d-4112-88e4-c7792fee6ae2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b05c05daea8211efbd192953cf12861f-20250214
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 469822968; Fri, 14 Feb 2025 11:20:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 11:20:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 11:20:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM6pBbsSQvYPVav4Pl6PRrhb9GTH8R877khW4m655XtW4MG2x2puATjLR37toSTsW5uq7cqtLTCOyziol3LRZhv+ScyQYlzVw0zw1C7H0X2lD/POTnyjVNS0GgweL4V8ATZ4m+Ex/Dj0hkj5OkEAFRiOXesThxNB9dkaX/DHt1XMK7Q5hARXrYoo9Jld2o3q5yqKCHyK+thSsxpl581pemodzfVCOl55XhOb24/xaclNaxf52Ddkk6ZRzLkp1Tjqg+dkaxcIKjNFbK033BP8OaVsD2FLS872DZ7YE+8zbYg/UOdRUytf+h9w6xm9cvG1rcKf/9qsN/u6gx1x9M2uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YX63LZVyHHCtct0+XqUVAE6qtnYyjwgvf4jYELWgPvk=;
 b=FT/p7BSMuRfuweCe63l0lTKhsIlOjs9qKACKoMSHYW6oRDGoGR3h/ttJ87q7WBHLUjoaYYqLGNQFGNFSd1BTeN9eH01D3Z3o5+Z/LS0N3i53N91MC2h513p3WwgCdpNB8uiwnHLZSKXdPj30P1tEJZwOP2CEupNkNGYgtblWRz12TFW7bkU0l3hxsHv/yUloue+XuAsHw0mfodzTGexbsHhsQoPKD4tdM35KyUsBqg6lS1zmSzj+f6f+7kkJIk4BFy7AyZNdGpL4h7aY4w4QuBuBRIs6iBmAsRcw0yE2uyuW8VTyKetj5ipw/rrvXif4GA4WiHVg08ggRjf+ofYwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX63LZVyHHCtct0+XqUVAE6qtnYyjwgvf4jYELWgPvk=;
 b=jObcqNBoZSmhgtS7RKyPRI1eahFb2QwzRsdR5nNwIz5Y/FueNEtSvlyd/WSV1ZZxbjL9wVSL4FNRbRtv2L5XWiPD4qnMDqulZeOWt3Pjql2TkeEjgEjJ3pCSDyfmy90V0C8YE1vOsGfVU9I5CM4CKk4r3+FRn7P19uA15pqIfxY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYUPR03MB7162.apcprd03.prod.outlook.com (2603:1096:400:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 03:20:43 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 03:20:43 +0000
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
Subject: Re: [PATCH v6 27/42] drm/mediatek: mtk_hdmi: Move output init to
 mtk_hdmi_register_audio_driver()
Thread-Topic: [PATCH v6 27/42] drm/mediatek: mtk_hdmi: Move output init to
 mtk_hdmi_register_audio_driver()
Thread-Index: AQHbfHkyUql8a8NPiUK6ZKSU3Hb6T7NGJemA
Date: Fri, 14 Feb 2025 03:20:43 +0000
Message-ID: <6378d714b5f5197b70aba1adaa6ca5d358aa2c41.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-28-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-28-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYUPR03MB7162:EE_
x-ms-office365-filtering-correlation-id: c1a09ded-4900-4f95-fdb7-08dd4ca6910a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dDNTQ1Z1QW5wWXRTUUxRODVoajhqMERreTJpWFIrTEtQV1NXa2FwcHpCWWo1?=
 =?utf-8?B?UGJwcFJVTzFValNNSmZhZGlEUXhTbDdXb1NxdThKRUZDK0xlL0VyS0lqMzZr?=
 =?utf-8?B?TzNTbkFqMnhDYW9nRnkzMUNWZGl4MlRObVlpVjZQQzQ0N3pZeHZZMDN0SXRa?=
 =?utf-8?B?UnRtQllwcnVBWjh3cjhYSFQ2ODhhU2pBeFpsWjRQUEdjM1ptYnVVbzJLT1Vm?=
 =?utf-8?B?cEF4NkMxd1UvUG9xblFnMnEza2FNSE1kdmxlTm5iTmlTYitjRXpSaG9ZU2Z1?=
 =?utf-8?B?K3JDMi82NGkxSE5aME4rUXpWQmk2emJpOGdxekVuZ1JhUVBlVmM4OFJwVG5D?=
 =?utf-8?B?bjNrZmtiazd0YmE5Ui9Hd0YrektXQVQ2N0dGQm11bUo1SkVHQ3NWTzIyVEFm?=
 =?utf-8?B?ampYZ2ZENEJzQ2RsTGh5NUlRWkMvQ25CbFZFTkNnMG1YakRzQjVQNmRoaTRT?=
 =?utf-8?B?cm5BOGZyd3NQMzdrZ09mWVBsQnA2eWg0UVc4U2h1RGJQVER0Vi9XSGRlQVBB?=
 =?utf-8?B?ZnlnQk40bjBRWGJSTlZXeUNRN3ZYb1MzU0FySk1VWEcxOHJMa3FRdy93alQ3?=
 =?utf-8?B?cW9TeXVqZHBiWkRkalNQM2ZydlorYkUrWCt0dU9KSTBUWGlORjZEeGk0VmRD?=
 =?utf-8?B?ZFJuSjFTa1BzWW1RbURsWXkvTXM3NEdmVlcydjNxNHhXUlIwcWREZ2lNYUF4?=
 =?utf-8?B?eFdpRGw1OEpMVWVGWGFtaDBObTU5ZWNUakpjUnVhM0tqRlJTdWMxSE0wc0xM?=
 =?utf-8?B?NkV3anFYTXdlMzhEdGN5VFd2czZ5Tlpab1loN3NPZ2Y2Tm5RYnFMbjVEUlRy?=
 =?utf-8?B?cGh5MzlMcVlwTURleVBsVTA5elJxSEdnQkQ0NUJNcVlIc3NDSXI0Y2pmU3d2?=
 =?utf-8?B?RzdCWFhQQi91cnpLblZXcWZEUHJ0aU1XZnJGeVhZZ1pINDJFY21SUWVrNDJ5?=
 =?utf-8?B?M0hxOGtZTzVKUmZ3dk5DQ0RRZlFFK0hVQ1VFZ0lyMEtFQ3BhODU3VTZKbVVr?=
 =?utf-8?B?Ulh2cGJmd3dqbWJ6SmR4MDlweXhJKzZwV28vSjZraFBmUXBZTjNlUmR1bEds?=
 =?utf-8?B?bEZkbXc1NDJxdHlKMnJobDRzK0RmTnB6aEJ6RzR4T1p4aWV2SE4rVDdwK2Mw?=
 =?utf-8?B?TURVZDV1bGFFYXJBL3lFVXllbkpYakgxSmdNNmxWYUU3NEZOek4wSWlKQWVP?=
 =?utf-8?B?Q2tEcU9QQnNLVDdQK1hIYTlRMVdFNi9reU5HOU5kcW1oU2dEUGRQTHpPbU5V?=
 =?utf-8?B?OE5ORTFxYlRHSUp1SnJTYXV6eGpYZUhOU2dOVFVBV1dXWm51ME1WcEVUNUY2?=
 =?utf-8?B?SUNtc1JOMHVYSXVtTitYcUloNWxLZ2REM1BlcytHWXJVNHJtZ0Y5VmkvL054?=
 =?utf-8?B?UFliMmNQUC8wWXYwVW9HT3VJZDM2ZFJTbjNQM2x0OUQ1VXpHOEFWaWZWcVRt?=
 =?utf-8?B?SmFscWlPYkJoUFRVZG94dkhySzZKOHAza0MxL1MxZUVtTlB5OU1UR1hnSHRx?=
 =?utf-8?B?Um1sdVljdHpRbTFHL3IxbkJaaFpPQ1BJV1lXYjZHbmhYamgwWlZsYVZIaFpR?=
 =?utf-8?B?dVlIeFRmbys5OWd1UC9LbFUwTytpZmF0VEx5TENHS1JSK2RkSmc5Nlk0Q2sw?=
 =?utf-8?B?WnpaSUpsUVRJYjI3M0NDWUVKcHJ6WTluNnY0ZFBUQ29UTkI1Nk1GaGgzMkdp?=
 =?utf-8?B?c0JvbXRnNTBGRjVxTUFMRVBuTVhoWGNnS01FSHZVZllBOXBEaXV0WVhxRWZC?=
 =?utf-8?B?MGxWWWVTWGpRbE53Z2tCN056NjVmZDhNM1V1bS9iMlFkVExvRjd4QkI3T2hj?=
 =?utf-8?B?azJmVHpNS0s0dDMwdkZacVlFbWY1eUZwQ3UyK1lVZ05ZcXAwYjEvTVFCN0xt?=
 =?utf-8?B?c3c1Kys5VkliSmd0Uk1QUkxWRzY2MGhYZDVqTElsdUo3b0NJOXNoMERHa2xk?=
 =?utf-8?Q?lIaQ9h8I0qNzDLoKGhYdPhyl6qZxoNAL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFN5cmFXTkZlcFZCUzVyN2lOais4N2lCRlduaEsvdWVpWjJEem5tMkhFNnIr?=
 =?utf-8?B?dkJNNDBzVU1HQjlaaDNLZ0JNbjVuSHNnY3BRZkQvR2RYME9UR2kzaExTMm9S?=
 =?utf-8?B?QndXeHVvTVU2VldTVWxQS2s3ZkRnOTNmbVNLaE1DZUVhVHYwYXBYb3ozNG9K?=
 =?utf-8?B?MHNNSElJb1VYeFVuVXRhVnBFOWl6WnIza3FoMW43OHEyMlcxRnU0TUx5VE9L?=
 =?utf-8?B?cUR1WXExanhGYXJIak9SMng3Q0JJMm00N2U4dFJtblZEaEhpVHgrdGxPM2Zq?=
 =?utf-8?B?NWg3REtNbzVRUDhialZ1dmt3NTg1UE9BdVNlL3Z1bTJFNmFDQkliTUZzRGx0?=
 =?utf-8?B?ZUJDTDkzZ1RaNGdwd2loLzdYUTZ3UUdqMHVIcUlMNnIrVWhkZjVwVzNWeTgx?=
 =?utf-8?B?MmZTTWtuMFg0VDNXUVY0Y0ZlNEF0clJCWWNBNkJtR09vOWFYVnRxcWpJdm9j?=
 =?utf-8?B?TDVUNktHTFFzd2gyVWFWK3JhajVZSitPeWxiU3h5UDJhYUFIaTZtY2twU016?=
 =?utf-8?B?NW5vcG1CbWVnUzNvZG1jU2ZjM0tsTW9NS1NwVDl3YnJ0d0xNamJqUUZVV1Vz?=
 =?utf-8?B?ZnJzWVpDUGE1UWJubnJxWEpkMThQT2lxL0Y5ZkhpVWpYc01ndURHZUkvKzRp?=
 =?utf-8?B?UldQY2dLci9aRjN3c25qdXErT2dYbHlZNGJzNXY5dmZBKzNJbWxDRzNpdUJa?=
 =?utf-8?B?VDJCYUhYMFVpekFkbXR5MXVXUE5Gbk0yQVM0OXdNc2VPUXllamh3NlF6ZDFt?=
 =?utf-8?B?Kys5UUdybmpuY1RuN2lMejcwdFBSeVBybWJheHFuZzFTTktidHR2ekJCQm0v?=
 =?utf-8?B?bzM4aHVVb2J0a3VpbkNNWk9HNHB6aEswS3pjcEJzdUMweVcwY2VMV25Ddm83?=
 =?utf-8?B?VmVkVk1EanF4T0hvMmczbWtyUjRoUVFiWFN3VW94T2VSbXdvZG5TY2JIUEF4?=
 =?utf-8?B?ZEVFZldUNWI5a1VNSGZmWWVjUmpBSDc1MXV5blFEcjVmQmdlakJTelVlZ0hN?=
 =?utf-8?B?VFBCQ0ZRMGQ1OEY0Qm9ZTE5tMTg4VlFTcnNWeXFvQ0FrcU1PVHBXbkdtK2NF?=
 =?utf-8?B?dEwyVW5ON2t0SmxDKyt1cXd6T044UjBQQWtHNlBwbUwyYS9HZFp5b1BPWU9Q?=
 =?utf-8?B?VUVrelV3WWI5aWlIK3RIWUVhakQ0OFRORjFwYnBNUUYxNGQ1dnYvT28ybSt6?=
 =?utf-8?B?WkZDNXBhVVNZclpaVkp0aWVtNDV0RWFmZmdMaWtFS0FSMytaYXlzTW5tenRL?=
 =?utf-8?B?ZmZheTZzWDVQajZyYXExUmxnM3B6SWpYSWVXa3ovcDJ3dTk2RjBzc3Q0V05o?=
 =?utf-8?B?NW1vaStJY3E0dG1XM2RmVDJaVVpLNFIwVG9hS1pYeVVxTVBjNHRtZTBneGN6?=
 =?utf-8?B?OGpmTSs5bERZSmhOTmZUMVpwZitwdWh2YkYzOU5vb3VnNEZVMXNJYlFUS003?=
 =?utf-8?B?a2dJNGF4NExRS2MyeWRCMUJYSE9xcStQVXN0Yzg5SVhrbDhxaFFaUjNxYWFF?=
 =?utf-8?B?UFVoRlpWQmZpRUxYNXpNRjZucVNFcDV0ck1BSWRPTDkxUU1xQUE1K092RHh2?=
 =?utf-8?B?MlNiMmVGSExKaDJJMVFZRk9pdVhicm1TTWhXQlA5RlEyR1RoUlVrNHRlUyt2?=
 =?utf-8?B?WU8yeStMd0UyOTNtUHhCdDBoUis3YVNCUmtkN1E3dWNuWHlpMEdXU3FDR2ZM?=
 =?utf-8?B?bG1MeHRxd3NFbmJtekt4SVdjVkxLNitsNzErUkR1U1lISDg3Z21nU05XNGVL?=
 =?utf-8?B?b3JBRll3V09hTWNvN0hkNGJrZmRLaGFMR25wRmFTZXUzZWhDamdqNTNsNlpM?=
 =?utf-8?B?UkNoQXVkVzdTTjlNU2ZWL0dWRVVEYVlOQzZid3lOWXVwVjNzSFI3MkVJYzlU?=
 =?utf-8?B?ZDU2OTlrWmJ6QUMvaUF1bkcrQ0pkdXI1cHh1OXBtWnNZVSsveWxCSmZHWTJB?=
 =?utf-8?B?MGNia29veWlvZVRkWW9nUlRzYVJwNTlReFFyS20rYWFNVFJESUhXSVBjbU1i?=
 =?utf-8?B?dzZRY3c1b3IyQUlEMFhQbGlYdGRjNC9JVzQ4b05JT0ZhQk1qUHZrbGNESnMz?=
 =?utf-8?B?WUhNZ1I5UHRFMlIwZ21idkVkeXBKK1Z0dzlnSXFZbk9FOUxEa29nQThMdzNx?=
 =?utf-8?Q?ZTG5oWZWv1I90pUmHuZAWUzbv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4EDE13F8A64304BBA88C02BECFBA160@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a09ded-4900-4f95-fdb7-08dd4ca6910a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 03:20:43.7557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wr7fgghr8gjdvUp0FMDatUVmur5Yp68RdbTImXSvY1MODCnqtNVLOiKRpdM+aO184ZoXG7PYxAmLW3klNsJAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7162

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjMzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBmb3IgbW92aW5nIHRoZSBj
b21tb24gYml0cyBvZiB0aGlzIGRyaXZlciwgbWVyZ2UgdGhlDQo+IGNvbnRlbnRzIG9mIG10a19o
ZG1pX291dHB1dF9pbml0IGluIG10a19oZG1pX3JlZ2lzdGVyX2F1ZGlvX2RyaXZlcg0KPiBmdW5j
dGlvbiB0byBhZ2dyZWdhdGUgYWxsIG9mIHRoZSBpbml0aWFsIGF1ZGlvIHNldHVwIHRvZ2V0aGVy
IGluDQo+IHRoZSBzYW1lIGZ1bmN0aW9uIGFuZCB0byBtYWtlIGl0IGNsZWFyIHRoYXQgYWxsIG9m
IHRoZSBzZXR1cCB0aGF0DQo+IGlzIHBlcmZvcm1lZCBpbiBtdGtfaGRtaV9vdXRwdXRfaW5pdCBp
cyBzcGVjaWZpY2FsbHkgcmVsYXRlZCBvbmx5DQo+IHRvIGF1ZGlvIGFuZCBub3QgdmlkZW8uDQo+
IA0KPiBXaGlsZSBhdCBpdCwgYWxzbyByZW1vdmUgdGhlICIlcyBkcml2ZXIgYm91bmQgdG8gSERN
SSIgZGVidWdnaW5nDQo+IHByaW50IGRpc2d1aXNlZCBhcyBpbmZvcm1hdGl2ZS4NCg0KUHJldmlv
dXMgcmVwbHkgb25seSB0byBBbmdlbG8sIHNvIHJlLXJlcGxheSB0byBhbGwgYWdpYW4uDQoNClRo
aXMgcGF0Y2ggZG9lcyBub3QgaW5jbHVkZSBwcmludCBtb2RpZmljYXRpb24sDQpBZnRlciByZW1v
dmUgdGhpcyBtZXNzYWdlLA0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNv
bT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFu
Z2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYyB8IDI3ICsrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYw0KPiBpbmRleCBlNDNkYmNjMGQw
NjguLjk4ZThjMTg2ZGZmNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19oZG1pLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMN
Cj4gQEAgLTEwMjUsMjAgKzEwMjUsNiBAQCBzdGF0aWMgaW50IG10a19oZG1pX3NldHVwX3ZlbmRv
cl9zcGVjaWZpY19pbmZvZnJhbWUoc3RydWN0IG10a19oZG1pICpoZG1pLA0KPiAgICAgICAgIHJl
dHVybiAwOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyBpbnQgbXRrX2hkbWlfb3V0cHV0X2luaXQoc3Ry
dWN0IG10a19oZG1pICpoZG1pKQ0KPiAtew0KPiAtICAgICAgIHN0cnVjdCBoZG1pX2F1ZGlvX3Bh
cmFtICphdWRfcGFyYW0gPSAmaGRtaS0+YXVkX3BhcmFtOw0KPiAtDQo+IC0gICAgICAgYXVkX3Bh
cmFtLT5hdWRfY29kZWMgPSBIRE1JX0FVRElPX0NPRElOR19UWVBFX1BDTTsNCj4gLSAgICAgICBh
dWRfcGFyYW0tPmF1ZF9zYW1wbGVfc2l6ZSA9IEhETUlfQVVESU9fU0FNUExFX1NJWkVfMTY7DQo+
IC0gICAgICAgYXVkX3BhcmFtLT5hdWRfaW5wdXRfdHlwZSA9IEhETUlfQVVEX0lOUFVUX0kyUzsN
Cj4gLSAgICAgICBhdWRfcGFyYW0tPmF1ZF9pMnNfZm10ID0gSERNSV9JMlNfTU9ERV9JMlNfMjRC
SVQ7DQo+IC0gICAgICAgYXVkX3BhcmFtLT5hdWRfbWNsayA9IEhETUlfQVVEX01DTEtfMTI4RlM7
DQo+IC0gICAgICAgYXVkX3BhcmFtLT5hdWRfaW5wdXRfY2hhbl90eXBlID0gSERNSV9BVURfQ0hB
Tl9UWVBFXzJfMDsNCj4gLQ0KPiAtICAgICAgIHJldHVybiAwOw0KPiAtfQ0KPiAtDQo+ICBzdGF0
aWMgdm9pZCBtdGtfaGRtaV9hdWRpb19lbmFibGUoc3RydWN0IG10a19oZG1pICpoZG1pKQ0KPiAg
ew0KPiAgICAgICAgIG10a19oZG1pX2h3X3NlbmRfYXVkX3BhY2tldChoZG1pLCB0cnVlKTsNCj4g
QEAgLTE2MTcsNiArMTYwMyw3IEBAIHN0YXRpYyB2b2lkIG10a19oZG1pX3VucmVnaXN0ZXJfYXVk
aW9fZHJpdmVyKHZvaWQgKmRhdGEpDQo+ICBzdGF0aWMgaW50IG10a19oZG1pX3JlZ2lzdGVyX2F1
ZGlvX2RyaXZlcihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IG10
a19oZG1pICpoZG1pID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsgICAgICAgc3RydWN0IGhk
bWlfYXVkaW9fcGFyYW0gKmF1ZF9wYXJhbSA9ICZoZG1pLT5hdWRfcGFyYW07DQo+ICAgICAgICAg
c3RydWN0IGhkbWlfY29kZWNfcGRhdGEgY29kZWNfZGF0YSA9IHsNCj4gICAgICAgICAgICAgICAg
IC5vcHMgPSAmbXRrX2hkbWlfYXVkaW9fY29kZWNfb3BzLA0KPiAgICAgICAgICAgICAgICAgLm1h
eF9pMnNfY2hhbm5lbHMgPSAyLA0KPiBAQCAtMTYyNiw2ICsxNjEzLDEzIEBAIHN0YXRpYyBpbnQg
bXRrX2hkbWlfcmVnaXN0ZXJfYXVkaW9fZHJpdmVyKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICAg
ICAgICB9Ow0KPiAgICAgICAgIGludCByZXQ7DQo+IA0KPiArICAgICAgIGF1ZF9wYXJhbS0+YXVk
X2NvZGVjID0gSERNSV9BVURJT19DT0RJTkdfVFlQRV9QQ007DQo+ICsgICAgICAgYXVkX3BhcmFt
LT5hdWRfc2FtcGxlX3NpemUgPSBIRE1JX0FVRElPX1NBTVBMRV9TSVpFXzE2Ow0KPiArICAgICAg
IGF1ZF9wYXJhbS0+YXVkX2lucHV0X3R5cGUgPSBIRE1JX0FVRF9JTlBVVF9JMlM7DQo+ICsgICAg
ICAgYXVkX3BhcmFtLT5hdWRfaTJzX2ZtdCA9IEhETUlfSTJTX01PREVfSTJTXzI0QklUOw0KPiAr
ICAgICAgIGF1ZF9wYXJhbS0+YXVkX21jbGsgPSBIRE1JX0FVRF9NQ0xLXzEyOEZTOw0KPiArICAg
ICAgIGF1ZF9wYXJhbS0+YXVkX2lucHV0X2NoYW5fdHlwZSA9IEhETUlfQVVEX0NIQU5fVFlQRV8y
XzA7DQo+ICsNCj4gICAgICAgICBoZG1pLT5hdWRpb19wZGV2ID0gcGxhdGZvcm1fZGV2aWNlX3Jl
Z2lzdGVyX2RhdGEoZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBIRE1JX0NPREVDX0RSVl9OQU1FLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQTEFURk9STV9ERVZJ
RF9BVVRPLA0KPiBAQCAtMTY2OCwxMSArMTY2Miw2IEBAIHN0YXRpYyBpbnQgbXRrX2hkbWlfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICBtdXRleF9pbml0KCZo
ZG1pLT51cGRhdGVfcGx1Z2dlZF9zdGF0dXNfbG9jayk7DQo+ICAgICAgICAgcGxhdGZvcm1fc2V0
X2RydmRhdGEocGRldiwgaGRtaSk7DQo+IA0KPiAtICAgICAgIHJldCA9IG10a19oZG1pX291dHB1
dF9pbml0KGhkbWkpOw0KPiAtICAgICAgIGlmIChyZXQpDQo+IC0gICAgICAgICAgICAgICByZXR1
cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJGYWlsZWQgdG8gaW5pdGlhbGl6ZSBoZG1pIG91dHB1dFxuIik7DQo+IC0NCj4g
ICAgICAgICByZXQgPSBtdGtfaGRtaV9yZWdpc3Rlcl9hdWRpb19kcml2ZXIoZGV2KTsNCj4gICAg
ICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2
LCByZXQsDQo+IC0tDQo+IDIuNDguMQ0KPiANCg0K

