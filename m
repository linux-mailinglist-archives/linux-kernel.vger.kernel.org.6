Return-Path: <linux-kernel+bounces-514255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0540CA354AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9CD3AD506
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CB0139D1B;
	Fri, 14 Feb 2025 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r0W5H8Dn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="h40ZvDW4"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F67603F;
	Fri, 14 Feb 2025 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499853; cv=fail; b=coqnVaTb1mKuS/wSLy4W8QxADGeEwg13lz4qLU20I9T8wU25dR89gt3M7fedlkYXeX0LVkrvclp1t4tqq4UsiotsrEkw4kzkw6X67dxBLYf+r8GjjL1+xpbPxZXGgxJDQUODIYN35/zQPopnbza+8zeB1jmMueIIBY7E1kymmbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499853; c=relaxed/simple;
	bh=sT5nOgw7tZVICworoQ9yJcde/xN5GKa8RRL0uVB+RMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s9+nYsidwIE1mIPaGe+EeG/GtApeJ/zjVOlX72IgDzxIP4U0EiwEMJItGKn3e0/Q7aV4ZTK3MGVUNNziZVJY0lUvrKxRQE5zxgmA1cayViv6BjFcW7tBa4Qu+EJO48Bw1BrmaVhvpMt4PPl6S8tDBoe36kynv4lchIpS/dvlR/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=r0W5H8Dn; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=h40ZvDW4; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c4071122ea7a11efb8f9918b5fc74e19-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sT5nOgw7tZVICworoQ9yJcde/xN5GKa8RRL0uVB+RMw=;
	b=r0W5H8DnsGE1CphUiUz9i/QVGhTI9Ve68uWqCxLEjXxwIZ8bttk/DR/YUbgJCwQ5+l45yrFhlCUo18fDnEpLjJWcwBh2u39gaOFd2KR2HrULlnHmLKCl6Ifp127fgmcoHxXcWewsfbf9avVPh51WZjlErgSb5z9sHKUM9B4i9vw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:0346fbe7-31b2-4214-ba60-760228317b6c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:6b1d598f-637d-4112-88e4-c7792fee6ae2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c4071122ea7a11efb8f9918b5fc74e19-20250214
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 35994100; Fri, 14 Feb 2025 10:24:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 10:24:05 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 10:24:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1g3GRaTCJ+7o8MQb9xsgccIUlfcUGMaYf9cwKUAi5h3UGeN+q4+OQL1+5RZ/wF4GNZ8RTCq94CkjgnPmWScJUk9Z1EB3MpLKquYbjl0iyT1zR8N2usEs/L1hdheOH2O2DWinPW22bGguZsTFgzdpflKRYg185TXIqoQX4Zzh56cxnzpPTjhlH0woKr+UUVWQFN2MgOyVc9nJU6AYRD8xenPra1nGkS5o2O5mgJQxAwnWQBgmt3Lv4crMaW6J8HeLJnamRxG7JuzCVHBB4yk7XBwZp7y8FbeSk5aJt6D0oKiwaJmE7Y5+iFI8tggM+SfUPBcBUPCvF4ViU9IskV5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sT5nOgw7tZVICworoQ9yJcde/xN5GKa8RRL0uVB+RMw=;
 b=vAWDeGt6b9eI75aVwDERBAuu3b+uCGppY97BhyTuEaQCbjz16xVPPVyz6bAcT2Gpvub3+Yu7DfqLYFY3aRVnqn+akQAFzT4I2d+B3npcRFKHTN6fAmkJg9IW+xdvhOCqAJZE8OxKx/u+lf3vp5towBXn4NQmJ8YISW2vNe/XVMsSWLxWayCDbFblmLcZAk/P00oSX6qvmoGDfPbmxfmv4ZEFqO+uwaHxYV3R99ENKmdheM1usdj8LiOvhoEd3NlhaowMXcAqDY3AXlLzl1C60jJtM1OExejHKvPNMTRDkpvZtTlzEQj36vGRHmLZ7+p4COOrjh6mqtSAfYOsi2ErZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT5nOgw7tZVICworoQ9yJcde/xN5GKa8RRL0uVB+RMw=;
 b=h40ZvDW4WwloaMb5PXdyT4mMWqJFrdQMovAL458tQrUpYP+3D6Qq66sdZvzCFeYb4lBBgJlnJ6MIEwlS4ZoV4eaxrd6xyTJtZYinZo88IIOrrTAxW+P7L+dW7S9ecN2clXClhSOHhZ3+xHlmj8NSluSuYQaQ2JIvCy02V0D8lO4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7250.apcprd03.prod.outlook.com (2603:1096:101:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 02:22:59 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 02:22:58 +0000
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
Subject: Re: [PATCH v6 06/42] drm/mediatek: mtk_dpi: Move the input_2p_en bit
 to platform data
Thread-Topic: [PATCH v6 06/42] drm/mediatek: mtk_dpi: Move the input_2p_en bit
 to platform data
Thread-Index: AQHbfHkl7tBMrlcvMEm3Lv3HaFbUuLNGFccA
Date: Fri, 14 Feb 2025 02:22:58 +0000
Message-ID: <c0f2d8c5d7d7559620343e24d185eae3fe472075.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-7-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7250:EE_
x-ms-office365-filtering-correlation-id: 90d55115-b343-4067-df0b-08dd4c9e7fc7
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cm92NkdFbjByOTh3OVZiZ29oM25RdGl3eDkvci8raFUvNGZPdVhLazFrVjR3?=
 =?utf-8?B?eG9hVW1ic1J2alVzbllyT0JiUllYR3NWMVZKQlBxSXJVeVhyamNzSjJtYi9K?=
 =?utf-8?B?enBGMS8yVlg4V3lqejNmNm1FY245cWkrVHdHU3puazNJMHp4THVueStIMXRI?=
 =?utf-8?B?S2ttUllPTitqZFZRZTVHUDZJWTRCeGtLb3o3aGVOaWxmL0xaMUtIZ2J1TzVL?=
 =?utf-8?B?VEk5Um5LanMrTHVXMk82cTdSaDJTOWNZeHk5dFVhb0EybHZIUWlOdXdOaCti?=
 =?utf-8?B?TUV0azNKVzErR3o4bW9lc05Dbk5CVTJ6dnduNVhWVGxtZnIrMndDTXpGdzhz?=
 =?utf-8?B?QTg1L0diYWZ4UENaTnprUkR1aVRpTmtZOUJZZEUzSEI3ZGNITG5KVGJ0Z3E2?=
 =?utf-8?B?Zml0VUhDZHRGUnlzcFpReThPVVJpaEMrdTVmby93SDJpWXdEQWhjOGZvanFj?=
 =?utf-8?B?NFdlSGhBdXVZWlhwQTJ6MWFkaFM1T01zMUswS2I2L2JqQUw3bEgvVDkyaVZx?=
 =?utf-8?B?RjROSytta3VmeFB2UFRNa3JDTmZ2K3VuQXBxUWRselpaTTQzK084Qm1EZzNx?=
 =?utf-8?B?S2VzOUo3bEJzZStqS1VQM0J3NGxkcVRyVVY3ZjVTbmVZZTl5MGcreUxCcGd2?=
 =?utf-8?B?SFRieGxNOEgyMk1tdy8wZ2dKOFAvYVduOGdWQmJnd2V6bENBbGdLZG81cVBU?=
 =?utf-8?B?UGxPcElNcDI5NldoZW1ic2EyVzU0ckd3MkwrZkZESUxxYThPUHF5cFpLUi9B?=
 =?utf-8?B?UE5oOVFIM1duckdyVDlRSWVjcHRBOHBCaGZOUzFzZ2NVMUJ4eXBneU13RTlU?=
 =?utf-8?B?T2lIRjVIaHlFWXdIa2d3Qkx5Qkx6aDV4RWd5bk5EQVU1VTlQUkU2eHpwUytn?=
 =?utf-8?B?OWhuRW5EZUlnenV3UzRaTkFSaUhCNVZDUkNQK3UvVzhDcWpScVZGMDdLOWFz?=
 =?utf-8?B?bzRYWHBPbTNYdUllU3pvdTJsN2FCWmZjaXdTRlRLM2pRZEFjenI4MXc4QXZK?=
 =?utf-8?B?MU5qR1NNQ29XYXFJVVpieS9XcVViRjI2N3JpSFZYc2pQbmdNZW00WlR0S2Jy?=
 =?utf-8?B?blU4NFV5NWN2NkFraUdwTGFJS05SV05Nc0FMVncrYXVvNlR4RUhyWkhLSDlX?=
 =?utf-8?B?V1daRGhZUVZyYWRsMmV4OFo3elNkMURzd1dwR1VUY3Iwemt5R3h5VThCMGxw?=
 =?utf-8?B?bEw3U3diRHJ4WitFcVBMVzhlVWNYcUt5UDZsUmdwcXoyelovOFVEdEFoMkR3?=
 =?utf-8?B?N1UwcTlWNVhwUXM0VUtqdFY4TTE2NmRaQUNwd083SGxmL2tjdXA1TjFyWElJ?=
 =?utf-8?B?Q2YzT3hGcVV1VlJjTVQ0cGU2QjZQM1kza0dsbEhYeXEvYjVxNXFNMmgrckZ0?=
 =?utf-8?B?aGFjOHVzWGxoc2dDUmlJR1YxTXM2S2dkK3BEV040eVRINkNGTWluR2F3RW9J?=
 =?utf-8?B?U3BsejVZd1ZJcWJNNXd3TjBQaGVsQTJxTXdpYnBIZ3BoOVZITmIzT2IvcGI2?=
 =?utf-8?B?NmtoSVQrTVJXTmRjZG9aUEVKaVVsVDAvaFk4bW00N2pKdk1UV1l0UGVIZUZl?=
 =?utf-8?B?UDc4R2x4Y2UxWElQOW0wYkRJdTNwYjE5bXcxUWlEc3FHNlhNTjVTV2VQcE51?=
 =?utf-8?B?TkZyWGJ6U1R2cHBsYVNKZDdsZXh6dVdVKzVZMGdyWlF5R2xLMkdyT3Vud0tV?=
 =?utf-8?B?anN2R2RpNXd1ZHJ6M0oybTVNZFlBbk56ZC9qaER3NjI5ckRmNjBUbEd4ZXgv?=
 =?utf-8?B?VkY0dFB3SnpTMEU3ejMrL2RvdGswUWIyV0tvQVJZWXp0SjhDVEZMWkRvZEc0?=
 =?utf-8?B?OVlIQlV3SzBGNmFpUS9vR3dxUGJVR2FOdnAyUjlDMDdhdmFqdC9QNU1tUHJy?=
 =?utf-8?B?THk2dk9QUEFKNkVML1RkRTVFaGhOaDB2bjRKbHE1dHJFSUdKVkkvWlVyRVE2?=
 =?utf-8?Q?16Kx3HANhrDm9h5Zgi9PQxlSDMCrawO8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkZNTUdhdmNvVkdzcXo0ZHJXTzJtZm9jOU9BTWxJZ040eDZvZGd1eHoyMmtQ?=
 =?utf-8?B?Y2VtbGxKM2UydFJkZVNnSUIxSDcrZ1VQQnpJWnUvR1lzYzZDejBydUhiYUwv?=
 =?utf-8?B?NW93dFpKVU5vb09aZDZyMGowdXV5VHlqRHJwdVJFZ2NTaTQrdkdyV1lqRG41?=
 =?utf-8?B?M0w2cmZ5VktIWGJjUUlydWRKTGZ6cGRVWWh0R2lNYm5NUitLQk5VL2Zoci9n?=
 =?utf-8?B?NC9qQjFPdlliWWI0S0xueXdtcHVsa2NmRjYyNkRXZll0M1d2NXg3RmVRaHlK?=
 =?utf-8?B?NjhSSiszem9HUlZJaXdHRWJuclVzVHNkTDJzSUp1ZkRsTzNaS1puZDZYdVNw?=
 =?utf-8?B?clBsaWVtK0plc1hEWWVXZ1h5anJCQ3paVXZwTmtFc2xJTXlkQXk2cjNUSXVs?=
 =?utf-8?B?MmJHSU5VRjlYN0UwN0FIUWxoSXVvR0FldmViMGZOcVpjVjI2c0sxTWZQaEJJ?=
 =?utf-8?B?b1JBUURvZTRpV0xMT2F0UXVjRDkzTlFna3J1VS9LMXkxdnBYbzJaeGcyNVJ2?=
 =?utf-8?B?VzEzWS8wdzR1eEFVK1hPVngyanlXTHhCNGhTZGwrMlhTVGkvVVRzZDlkR1k4?=
 =?utf-8?B?aFpNck40VkY2V0RrWXNsdFp1dTBmVkk0YWQ3alFwWHp3b0J1YVhKTWRWU0ty?=
 =?utf-8?B?c2ovaXQzbFdnWDFXeUczbVRycWxYa0FNVGIzK0tMMkZOUnZIMkgzRkZrWjM3?=
 =?utf-8?B?NzQwVFNrZUJBdE9Sc1pEemhzRjNuc2dVemlqNEhuckd5QUdIS2dsTGIwQzRi?=
 =?utf-8?B?Rm54YVF2WWEwZlF4b0owNEw0VW9Jc2VPejY5U3FWL0svVW9xRml2Ti91ZWsx?=
 =?utf-8?B?UzZrVlU2cWo3d0hpdC9nMmhZY3dUVmdLMDYxTGREVUt4Z3ZiUStYejNmOXJh?=
 =?utf-8?B?bzVwbEtkM3FQWDlGL1FwNCtxL1BCQksyS2p2OHR3VHpXV1ZVcHcveUhReDVF?=
 =?utf-8?B?aUFUaTQ5SmZOQ2lvR21BUzJvZzV5RlVoTGpET1A5TGVoOW15T0lNVXVVUjNa?=
 =?utf-8?B?aHY3TkQzV1VvYlZhWHlPeDFjcjJDSVVYVFRuL053K3cxRWFhSWVrNGdjSGx2?=
 =?utf-8?B?dFRxNmZFdzlsS2I0eWhrVVdsMDk2ZlU1bWpWcHZ0UGRoUlN1RVZpblRSNFZZ?=
 =?utf-8?B?UW9MTVJaTUptN2RlNmRucDdqMTl6am5nUEJQOU0xcTVaNGkrODZNYm94Sk1i?=
 =?utf-8?B?ZU8ybGdFMG5sVWJSQ0hwdFhkYnhnSGpuY3UrbEV1ZzhGeTl2VGkxbC9UVlVl?=
 =?utf-8?B?dFlDWlIxRXppOWp1b1FRb1ZiRnFrcEc2eis4MWZ3cU0wTVRRK0w0b2xmWFVD?=
 =?utf-8?B?MFZvWS9QUFdOdk9qRE9zS21ydUZlNUxjcE1kSEZpaXZtUWdoRGlkRDZPMW1z?=
 =?utf-8?B?SDRpQWJkTU1pdlg4VjM5TW52NDVZYTVTRWFMZlpBeGVtNElONHV2RC9FcTg3?=
 =?utf-8?B?UDZrRUZmMTduSkVjZ3NDdVNMSnFFTzFQMXd1ZjRjb1dKQXdsSTJZRHlRRDlm?=
 =?utf-8?B?emx3L1gyRDNOYkxzZUVMZGtEYklGRjJGeUkvSVVUemhYMHhvL29TS3UwdkZM?=
 =?utf-8?B?bDRhakdTTzJOVnFjeW1SdGNLSVRhUDg5dWFwcURETEdqTzcyZ2xkbWZNazVI?=
 =?utf-8?B?NnVXWUxxM2xIZXMvZUtJcXBnQmtyWXhTMXdiZmovaXd2Qy91c3draXE1Yi9q?=
 =?utf-8?B?U293MFVsekI4S1RlTWRZYzNHZ0U1dXdzTENuT3ArT3FTMzczUzRiSURQMCtV?=
 =?utf-8?B?N0FqaXA0MVMyN0JXTGE1S0E4Y056UWJlc0RVYko1dWwwWHlCZDRjVE5VSUVD?=
 =?utf-8?B?em41d3l3RVFKRDd1YTF6cENFSDd5WHR4b1dRRzNMOUZGZTRwU1BlQlF0WU5m?=
 =?utf-8?B?M2JKRitrb0Z1VU9MVVQ2TFdTL3ZVYlJaMmNSZ016ZDdkd1F6NDdBWUVHaTlJ?=
 =?utf-8?B?aURmYWRsVWU5blljeFRjTy9SeVFwSURSWnFadFRKSy96b1JhYzZsZzVRVXdR?=
 =?utf-8?B?WS9WK052TlQyM2VhNklXU3FSSUdEdlg3ZzVEMnVCblVPQ0J5R2Z2Z0hWVHdp?=
 =?utf-8?B?aUlWNTZxeDZkRlNFUzd0MGJnUVhqSHllWmtMbmlPL0Q5cEtBM1FVeERHa1l1?=
 =?utf-8?Q?8pgQJNCoxrDsweQZjdvjbEtM8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F0A00ED9A0AE946879B9DA6C656B762@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d55115-b343-4067-df0b-08dd4c9e7fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 02:22:58.8447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FDyJBxK/iWRqZL7iMMtWQdyfg0aOzAdDz8kdjqgGUFjFPkXbKR20RanHSoUslT7CJIB7+Q7UdRrQYMW5jVA59A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7250

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjMzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBmb3IgYWRkaW5nIHN1cHBv
cnQgZm9yIE1UODE5NSdzIEhETUkgcmVzZXJ2ZWQgRFBJDQo+IGluc3RhbmNlLCBtb3ZlIHRoZSBp
bnB1dF8ycF9lbiBiaXQgZm9yIERQX0lOVEYgdG8gcGxhdGZvcm0gZGF0YS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRl
bHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcGkuYyB8IDkgKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+
IGluZGV4IGJiMWExN2YxMzg0Yi4uYWQwNzAwNWFkNTZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHBpLmMNCj4gQEAgLTE0Myw2ICsxNDMsNyBAQCBzdHJ1Y3QgbXRrX2RwaV9mYWN0
b3Igew0KPiAgICogQGNoYW5uZWxfc3dhcF9zaGlmdDogU2hpZnQgdmFsdWUgb2YgY2hhbm5lbCBz
d2FwLg0KPiAgICogQHl1djQyMl9lbl9iaXQ6IEVuYWJsZSBiaXQgb2YgeXV2NDIyLg0KPiAgICog
QGNzY19lbmFibGVfYml0OiBFbmFibGUgYml0IG9mIENTQy4NCj4gKyAqIEBpbnB1dF8ycF9lbl9i
aXQ6IEVuYWJsZSBiaXQgb2YgdHdvIHBpeGVsIHBlciByb3VuZCBmZWF0dXJlDQo+ICAgKiBAcGl4
ZWxzX3Blcl9pdGVyOiBRdWFudGl0eSBvZiB0cmFuc2ZlcnJlZCBwaXhlbHMgcGVyIGl0ZXJhdGlv
bi4NCj4gICAqIEBlZGdlX2NmZ19pbl9tbXN5czogSWYgdGhlIGVkZ2UgY29uZmlndXJhdGlvbiBm
b3IgRFBJJ3Mgb3V0cHV0IG5lZWRzIHRvIGJlIHNldCBpbiBNTVNZUy4NCj4gICAqLw0KPiBAQCAt
MTYzLDYgKzE2NCw3IEBAIHN0cnVjdCBtdGtfZHBpX2NvbmYgew0KPiAgICAgICAgIHUzMiBjaGFu
bmVsX3N3YXBfc2hpZnQ7DQo+ICAgICAgICAgdTMyIHl1djQyMl9lbl9iaXQ7DQo+ICAgICAgICAg
dTMyIGNzY19lbmFibGVfYml0Ow0KPiArICAgICAgIHUzMiBpbnB1dF8ycF9lbl9iaXQ7DQo+ICAg
ICAgICAgdTMyIHBpeGVsc19wZXJfaXRlcjsNCj4gICAgICAgICBib29sIGVkZ2VfY2ZnX2luX21t
c3lzOw0KPiAgfTsNCj4gQEAgLTY1MSw5ICs2NTMsOSBAQCBzdGF0aWMgaW50IG10a19kcGlfc2V0
X2Rpc3BsYXlfbW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KPiAgICAgICAgICAgICAgICAgbXRr
X2RwaV9kdWFsX2VkZ2UoZHBpKTsNCj4gICAgICAgICAgICAgICAgIG10a19kcGlfY29uZmlnX2Rp
c2FibGVfZWRnZShkcGkpOw0KPiAgICAgICAgIH0NCj4gLSAgICAgICBpZiAoZHBpLT5jb25mLT5p
bnB1dF8ycGl4ZWwpIHsNCj4gLSAgICAgICAgICAgICAgIG10a19kcGlfbWFzayhkcGksIERQSV9D
T04sIERQSU5URl9JTlBVVF8yUF9FTiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBE
UElOVEZfSU5QVVRfMlBfRU4pOw0KPiArICAgICAgIGlmIChkcGktPmNvbmYtPmlucHV0XzJwX2Vu
X2JpdCAmJiBkcGktPmNvbmYtPmlucHV0XzJwaXhlbCkgew0KDQpXaGVuIGlucHV0XzJwX2VuX2Jp
dCA+IDAsIGl0IGltcGx5IHRoYXQgaW5wdXRfMnBpeGVsIGlzIHRydWUuDQpTbyBpbnB1dF8ycGl4
ZWwgaXMgcmVkdW5kYW50LiBEcm9wIGlucHV0XzJwaXhlbCBpbiB0aGlzIHBhdGNoLg0KQWZ0ZXIg
dGhpcywNCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gKyAg
ICAgICAgICAgICAgIG10a19kcGlfbWFzayhkcGksIERQSV9DT04sIGRwaS0+Y29uZi0+aW5wdXRf
MnBfZW5fYml0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRwaS0+Y29uZi0+aW5w
dXRfMnBfZW5fYml0KTsNCj4gICAgICAgICB9DQo+ICAgICAgICAgbXRrX2RwaV9zd19yZXNldChk
cGksIGZhbHNlKTsNCj4gDQo+IEBAIC0xMTI3LDYgKzExMjksNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG10a19kcGlfY29uZiBtdDgxOTVfZHBpbnRmX2NvbmYgPSB7DQo+ICAgICAgICAgLmNoYW5u
ZWxfc3dhcF9zaGlmdCA9IERQSU5URl9DSF9TV0FQLA0KPiAgICAgICAgIC55dXY0MjJfZW5fYml0
ID0gRFBJTlRGX1lVVjQyMl9FTiwNCj4gICAgICAgICAuY3NjX2VuYWJsZV9iaXQgPSBEUElOVEZf
Q1NDX0VOQUJMRSwNCj4gKyAgICAgICAuaW5wdXRfMnBfZW5fYml0ID0gRFBJTlRGX0lOUFVUXzJQ
X0VOLA0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgaW50IG10a19kcGlfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gLS0NCj4gMi40OC4xDQo+IA0KDQo=

