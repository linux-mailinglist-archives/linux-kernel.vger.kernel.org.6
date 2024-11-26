Return-Path: <linux-kernel+bounces-421969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729019D92B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C02E163F01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385E3195FE5;
	Tue, 26 Nov 2024 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W/56BSKy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="COsPLyjy"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD813BAD7;
	Tue, 26 Nov 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606978; cv=fail; b=j6xxLwP8dI5w/BCrWd1GqDujizKY2MmPayR5MCbiWt7R9hcSeDnCnSsWCXs1V9wwKcsxS91AfcbN6sXVScagPjdWhKS0jxfxPak0h2WgL6r6NOzWQYDIXzbaa+pk8z/sE3jSfLy/S9UEZ/GZTyH0Ftq+zwnAiWnngbunz6yTtYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606978; c=relaxed/simple;
	bh=hrGyXdx5Uyq9w0wV0QqOzxkk/Z1o/KpkFIjJk0RXTkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mRm0zVbIUTd3zWKes0sRsewVVLsDwm2oJdPF1KJDffR5qkb7KTDCZuWL8Bfc2ULE5FXrjtvD7ixKPlRAnJN2QZ7aHvVaar2thBxnt84m5NH4ymbwt8XE/YZ6PRgqclt0QyB6brMiOLI4QUz/kReFW9QhgwzZdxhkgA3RmtuwgP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=W/56BSKy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=COsPLyjy; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 06917568abca11ef99858b75a2457dd9-20241126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hrGyXdx5Uyq9w0wV0QqOzxkk/Z1o/KpkFIjJk0RXTkY=;
	b=W/56BSKySmyJ2RHmd/dxNXnKPFX5+PUx9U0NeUaDd2GKv+Z711NpEmtNTtfXXKKKdO5sB6xuZzMEFrAYUggvaLZPZS2rxe8opgQf+tjKz1RPmzXBP/wmSbsvWkF2Apb6qLxle4R/Be3xkPpfHOP0yzDZ2nCrnBFFS7auBDPo55Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:8872a0ae-c09c-43bb-8a42-9bd13dc39aad,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:c0168423-634f-4016-85ba-2d63e55c9400,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 06917568abca11ef99858b75a2457dd9-20241126
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 128498404; Tue, 26 Nov 2024 15:42:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Nov 2024 15:42:44 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Nov 2024 15:42:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saYaV/6PUyu4FHp/YNotJJDLnos2JklWKc+u9lcl2OBkTua5Rvl6zqKsaP+2WEGaQr11IgpJBiFtYbWen//CWKrRs0PvvBShIO1d+Kgvd96YH3dOAUkTFzgFhLwlZTT1PSSiL1/OeN76vI9mExB2gF/Vi1rU+MVDrkAnS89W2iL0+PhosY5BBBQj+3UiVZkAD3sYncaCRL6pL0T7KI49OhdUYGRS7s0H6bNzV4Tqij089TBRQTSI8vaqY4A0A0XiHo4LrcA6kXo9sNaz0Ia6Rtk8fBvPUtdRi5tUeuNP1NXoLHD20kLlhzNM3wcFOk4M5rRqk5PAf7VlQPhXy1puJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrGyXdx5Uyq9w0wV0QqOzxkk/Z1o/KpkFIjJk0RXTkY=;
 b=uGMOLfr/I3GXJ39wVIJv6CyKp+ZPA1LUNHCZRBV7sShT9JVD/re6gS41/HJO/8gKhxXqvrAZ4NCAUdwiMM6fQm8DHpSg6yYR38pqEUEKwXzL447Kh/V6jigtQNa6/zQQKbjRuxssPbG0wjhVZMow+K1SgVqUxBE6mtTmQSWVMuDxNdxRMS9406h1CDr5jQtlqUEXvwObAA+OV4/zTsMrLrf9DdpUNluimcpJAHjwAk/c8e+UaOQi9a4N4jQR23zty1E+aRtIE25wRt+/eKEzw5fxPPCtP4JqeNX4FaAVsW+AXv8Ir3Ws4vBRmOPuDAzB9dVTEsisVPPCNAy3FdWGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrGyXdx5Uyq9w0wV0QqOzxkk/Z1o/KpkFIjJk0RXTkY=;
 b=COsPLyjyKgpNovplyUfqlLi2IHV74/uQ+NdknD0VKV+q9Yu3JnNPRxTSAiHor57cFeFoJcO99NUk/GWOy6+WRPI+Lunm2PVeJ6JdZRV1Ymm3y8qcASoM9kMYZcNQRZ8tOlE1g0KTwpSbEozsvU4pV1/Fi8ehxmHfDBz5vSUaQ1U=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7005.apcprd03.prod.outlook.com (2603:1096:101:ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 07:42:41 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 07:42:40 +0000
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
Thread-Index: AQHbO0pF3Zp6UXdpSEmkHbI6wNkmT7LJNvSA
Date: Tue, 26 Nov 2024 07:42:40 +0000
Message-ID: <133167aa2a3fab40547f5dc6602adf2c3d9e01e5.camel@mediatek.com>
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
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7005:EE_
x-ms-office365-filtering-correlation-id: 62510e81-edac-4ed8-e4bd-08dd0dede7c1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZlpQbFJvUHlGYi94OVpXQW4xMWtFNkw0ZVF2ekhSRHI0T2s2bVdsNHJmalNT?=
 =?utf-8?B?VDl0Q1RNZUgwanRWaHZ1ZzFEQjgxcU9BWjlldCtzUGN2bVMvcXdpandtVC9s?=
 =?utf-8?B?QWpMNHp4ZDl0bStzak0wQzM3aFBYRUhleEVnL0dPUGM5dExVTTg5eTRRaWhK?=
 =?utf-8?B?V1dHSGs0ZUpVbDN2WllmRUpySmcrN2tRL1hVWmI3RngreSticGsyNjhwOWdl?=
 =?utf-8?B?VVB2UlVWRVFIaGtxVFBzTS92MEFWMFpVcEdzWTFPbGpsdjgzb2NCTG1KS1RN?=
 =?utf-8?B?bjhWR2k0UzA4TzVITnpBdVVkZWdJTTA5eENXR3lUZ0s2RmVvaXlOT1FNRTJz?=
 =?utf-8?B?NWh3WnVHOXZYdHBqUnF5eXBmUy9VZytJaUFxQkl3TDZhTjhXb2ViWWRqaXRD?=
 =?utf-8?B?c2FOSFB1NGJxUUVpbXZuck0wUDZHdEtvZ1FPcml6VWRuaC9Hd3ZmTitiNlR1?=
 =?utf-8?B?UzJ1NjJjNmU1YzZzMVArUmtVMFViZ2FRdFMvN3ZKNkRGY3BzdDgvUFUyS2p6?=
 =?utf-8?B?bWtzcFRwRDJOVTN1QlM4NVVONHNRR1dQVlVSd1NUZDFlNHJWaFZ2ZElONk03?=
 =?utf-8?B?a3NabEdmMklqWGlKMVNNQUthSk4ra1hobWh4M0JLU3g2UzNxVTdlOURXc1pU?=
 =?utf-8?B?dlhXY0tDbjhONmg2Z3ZKaVlLdmpYTFd0U1B0NEdIKzdXUFpCQy9sYm9JTW1L?=
 =?utf-8?B?NUFVNC9MaHlwRFphKzFkd3JlS296TEUySk1KamhjMjIvS3lWbzRwbzFoMmV5?=
 =?utf-8?B?eXU4RWF5ZVZhY1EyZzJjYU01QlpSQlRkaTR3Wnk2UDcvcTJFYTgzYm4wUGdY?=
 =?utf-8?B?QzBlSGdFcXRnSExldGIzaTZEUU1IRHlQOC9GUW8vZFJkQVRQTjZDYm93bVFy?=
 =?utf-8?B?Y2krVTVmQmFNdkluVldPVVNTTEdzamdDK1ZDbG55eDU2aTFXN0p6N0ROVSs0?=
 =?utf-8?B?aVFINkVTS2FBQS9CUGtQUTZ0bGlhMXVMOGxNRnlkRDhIS3pMNnpOMlBYWE0v?=
 =?utf-8?B?YWIwNG1zb0dpSUluWWZmQWlzUmVjTElaU0hNeHF0Q0VzaHVQN1JRdlF0anhL?=
 =?utf-8?B?ZlE2SkdhcDFNeFA1TGdIcGZSWTNjMlFiNk0yRHJTV0hvaHJ5MVl1eWVzR0JD?=
 =?utf-8?B?MSttVUVXTmV4aHJrMGJrUlNYOGtTMmo5eC9QMWxCaExQeFpBY0ZZS2pneDJE?=
 =?utf-8?B?ejMrZnRVRS9rRkZzbk1xV2NaMk5wMFNKVWNyV01vWXFmY29zQ040cG1CdFJO?=
 =?utf-8?B?Q3pYcHUyWXRqYW9pNi83d003SXVFQmErbDNmdzl6TkNnS0JMbFYzTC9YdmFN?=
 =?utf-8?B?MGdFRnF1NVRGYWNvTE5USGVxcUhTb2thNVlJUmlTVjdNTjVReDcxSllrczdh?=
 =?utf-8?B?ZHk3MW5YcHVUc3ZqV3lONjNiL0JnOGxya2R4WWdNYUE5dGcvdVdHRGFqS08y?=
 =?utf-8?B?dE1pUWsvR1pvaTNVT2ZlaW9ULzI1MTJVTkJ6SEJMRTkzYUpkc3IrNWZWbUxo?=
 =?utf-8?B?TWVIeE1GOHp5NEhkcmRTWFEwWkgrNmR2OFJlZ0hKK2loMWliNnVXZnRhWGtx?=
 =?utf-8?B?L2dOQnhJWU44U0xDY01QeGJIc0N5a1pFMFJ2eDQwMHVIUmJkTmE3SUd2dXNh?=
 =?utf-8?B?V3lFeTYzRS9PQkNpMkJpaFg3bEpuSlNLOFp3SS9tN2RreHhRcTl0V3JEcDNh?=
 =?utf-8?B?dTJjdFVDQ0ZZVlo5T0U3eDVvd1BSSVJJUTgzb2ZJd01Ramg1bFZId2JkRUM5?=
 =?utf-8?B?bTJ6VzM1Z0R3VGpnMnVMNnFLbFVudnN2d3VlaEFTMUFOQnl6WVFWMEZNNVdv?=
 =?utf-8?B?clNSalhCb25LWXlNRTI4ME0wZzlmN2hDU0JXeHp2N2hoR0VXeXlOdElQc1Yy?=
 =?utf-8?B?WjZQMWJ3akdVUlJGdTVkVGU2Z3MzV2UwTytOQWkzalA4L3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFpnbTNvV2pJUTUxVzRjRnJvRWt0ME5iblJreFlFYWo4Y09xRHk4RnZXQmJa?=
 =?utf-8?B?VGI2NHJFSCtUQXBQaEQ2UFFvbktDbmVqbWUxZ1VIM3JqV0J1NDJ2Q1JzVm9Z?=
 =?utf-8?B?T2lXS2YyOVhSVE5nS084Mm9xRGlDUzBON0tXazgwVUhXd1JLbk9WVFMyMW56?=
 =?utf-8?B?MUt6emgzS292U1Rkd3VNaG5oQWt4U05MRkREZElSWEtiZG45azF3VEVWMzNq?=
 =?utf-8?B?UU1GWk56cStwVktEUWoxa0RmUER5OWJORFdqRWlJT2kyVzltLzdvWkVwcVM3?=
 =?utf-8?B?aHBrd2ZzbjZ0QVhGV3o1b1RINzNOdGJRd3U0T1pCNTJvejlBN3Rrb1FCY2lN?=
 =?utf-8?B?ajZ5QzYxRVNKSEd2bDU5U1FKa24xUGdiSUpKVGhKL2pqbm5VQ0phd3R0Ukdx?=
 =?utf-8?B?ZGhsa2w2bnRJTm4rc1c5andnWGNUMitUWGNEa2tyV0JzM0dncWlSOGtuT0hW?=
 =?utf-8?B?RzMrNnhaTGdMK0c5ay9WeW80eVZlbkNUUnZReCtBR2pzb2M3Qkd0UzI0YTlE?=
 =?utf-8?B?L09Ib093MHNPT2NGb1VyRmZUSmZTS0hvR3JMenJ2dTVtN3VrQmtrOWlPQkx1?=
 =?utf-8?B?azVXeFZLVEI0U1h2dXdUTjBaeGVUWUVQeW51S2N1NFB5aHY0a1ROdmNuSVJI?=
 =?utf-8?B?ZGw4OUkwNjdjRmxneDBFUXNpZVJFKzh6NXZoQ1hhZm03WDhjSUFHdkQwM1BC?=
 =?utf-8?B?L0FlQ3NRNitidEZvRXZGU09GQjVVK1ZYRjY3THc3eEJiUzZCUk1BMlNPY1RJ?=
 =?utf-8?B?Tnk5YUo2aERDNUx2aWRaVGlHSGgxN1dTVzVwSzYyNDVyMENoSnNVMjlaZ1F6?=
 =?utf-8?B?U1J6eCtpQzJ6amo3ejd3S2xpbG9rd2E2OG13OEJWRVErUWc4d0JicElKbFRC?=
 =?utf-8?B?eWRjNlRReWtSL1lzaXR4VTM4bTZJMUsyNzlMUWxNNXFZVDViN2J4L1RqRE1H?=
 =?utf-8?B?OU0zeGFUNVZWWTg1QmMrdkV0OWFwSUNYSWdXbytEUzdZQ2EvbEpoVUQydm8y?=
 =?utf-8?B?S2d3QmxyY0wrZ3k3SDQvRG9QZUF4cGhad1NhNE9lM0JzbTYyQ0RYRTY0emx6?=
 =?utf-8?B?TGJuL2VycTk1UWlYMzgzVWVEck9rL2h5aHVzL1AvWmd5eUVoYVNkWW1XU3Mr?=
 =?utf-8?B?dW9ZKzh6VlVTYlNkeGYwNWZFWVF2R09wb0JhOUtPL1FiNnhNQ0FSdlZkQzcy?=
 =?utf-8?B?VnkzRXdoSzdNR0YrdFB0aWZrcmRtL1FQWGd6VWtDelJMdVF3ekpUc2V4aWZl?=
 =?utf-8?B?VnhmeHdpWklSWTdsclZTK0h3MkFTQ0dRcjZXNFNwVjA1NHhKKzJUc29RNWky?=
 =?utf-8?B?M3lzdlBTUDZycUZrdFVwMGVXZUhaQy9pSFhOczdaNWdvS2FacS9oYVdhWHFC?=
 =?utf-8?B?eTlZL1hqeU9xaVJnZ0VkN21BaXlVbktHTnVZNngzT0wvZVNUZmZuK2E3KzJC?=
 =?utf-8?B?cEN0UnI3ajZ5eVQ3cFhKNkxVb0hvcXREMUwyT0pmVzZ6anplM0FWR3lJV3l0?=
 =?utf-8?B?SG1PVmF5dm4zS2xCeGdLNm02V0NXNUJPcWxvQTF3cHMwQkJ2d2RPSm9uUEdB?=
 =?utf-8?B?QWxLK0M4SDdTSmJpY3BWRGJTT1NmbGpTOGcyZzZTQnN1emc2MmxMVFRFd1V1?=
 =?utf-8?B?dU5wd1poeDkxUHpnZU5qSG5HOXZjN3AzNWZUWjAyTWdCNXh3N0hITE5XSVow?=
 =?utf-8?B?T0JxRncyNm5kSll0TGg5VDdTdURrQm43b1ZrZGFMeFYxT21mc0IxYnZBVGc3?=
 =?utf-8?B?SjVjblUxd1J0Zldtc3NLaE9ob3YxLzhiR3o0ZGJVd2VMTmZocVJHeWQxQ2xq?=
 =?utf-8?B?aVRJa3dicE1Ib0pKbXQ4RUpoVmk4WlJKYXhubUpsSS9FT2ovVnFFdFJFcFFj?=
 =?utf-8?B?emFuTTduS1MzOGw5ZDRUVXp4TmJwQTFuR2lrazVDeHFNVlNHU3dhT0hHNFNJ?=
 =?utf-8?B?KzdKaUJRcHJFd0lnYVhnTXBFRVUzaVFKZWpwMFZSWEswK2pSa3E2UnJlcDEx?=
 =?utf-8?B?eG5oQ2VlcllaTUZkSzJHb05lRWVieU05cnlSbTMzaGZvNmFQdHJyVzJ2cm0x?=
 =?utf-8?B?ZUFqUVJycWtJQXUyZVNYZk5Xa2dsRHY5Q3ZtN0N3emhzVTJxU1dwVENBcHB3?=
 =?utf-8?Q?9vu3YxeTitqRwYAWOb3tTgFmJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24750D12E0EB7E4190F6ABE637BB3DD2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62510e81-edac-4ed8-e4bd-08dd0dede7c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 07:42:40.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GONIA2cyO2kLoX1l0ZaEeifDsVj6y3rxybKrymJe+qvTIV4uFdq1q2sd4qCeiLzIY1bOFHDjVmRP0VjXjENRVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7005

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTExLTIwIGF0IDEzOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Ig
dGhlIG5ld2VyIEhETUktVFggKEVuY29kZXIpIHYyIGFuZCBEREMgdjIgSVBzDQo+IGZvdW5kIGlu
IE1lZGlhVGVrJ3MgTVQ4MTk1LCBNVDgxODggU29DIGFuZCB0aGVpciB2YXJpYW50cywgYW5kDQo+
IGluY2x1ZGluZyBzdXBwb3J0IGZvciBkaXNwbGF5IG1vZGVzIHVwIHRvIDRrNjAgYW5kIGZvciBI
RE1JDQo+IEF1ZGlvLCBhcyBwZXIgdGhlIEhETUkgMi4wIHNwZWMuDQo+IA0KPiBIRENQIGFuZCBD
RUMgZnVuY3Rpb25hbGl0aWVzIGFyZSBhbHNvIHN1cHBvcnRlZCBieSB0aGlzIGhhcmR3YXJlLA0K
PiBidXQgYXJlIG5vdCBpbmNsdWRlZCBpbiB0aGlzIGNvbW1pdC4NCg0KQm90aCBNVDgxNzMgSERN
SSBhbmQgTVQ4MTczIENFQyBoYXMgaG90IHBsdWcgZGV0ZWN0aW9uIGludGVycnVwdC4NCkkgZG9u
J3Qga25vdyB3aHkgYnV0IE1UODE3MyBjaG9vc2UgQ0VDIHRvIGRldGVjdCBob3QgcGx1Zy4NCg0K
RG9lcyBNVDgxOTUgQ0VDIGhhcyBob3QgcGx1ZyBkZXRlY3Rpb24gaW50ZXJydXB0Pw0KSWYgaXQg
aGFzLCBtYXkgd2UgYWxpZ24gdGhlIGhvdCBwbHVnIGRldGVjdGlvbiBmbG93IHdpdGggTVQ4MTcz
Pw0KDQpUaGlzIGlzIG5vdCBhIHN0cm9uZyBzdWdnZXN0aW9uIGJlY2F1c2UgSSBkb24ndCBrbm93
IHdoeSBNVDgxNzMgY2hvb3NlIENFQyB0byBkZXRlY3QuDQpJIGp1c3Qgd2FudCBtb3JlIGZ1bmN0
aW9uIHRvIGJlIGNvbW1vbi4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNv
bGxhYm9yYS5jb20+DQo+IC0tLQ0KDQo+IA0K

