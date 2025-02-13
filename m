Return-Path: <linux-kernel+bounces-512458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD20A3398D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C693A4067
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8020B815;
	Thu, 13 Feb 2025 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uUL3+H5L";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="thZIlWB0"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4920AF88;
	Thu, 13 Feb 2025 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433814; cv=fail; b=FkIfzlyLjQx+I8dpTKWU27hxKSnpGtXimweLQWlp3j9QjM1E5NwzO/MLTdz1BuCeywVaZ1fjny9fE2HCsJYRy8Q9TmbVpx1NR+7Qj0D1cdwjLWpCa+OomrZ+rrGoNt+4CF7WKdxJwXDBiD+uYUcuKH4q+/qX7xlRO3AiAQbKyo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433814; c=relaxed/simple;
	bh=HohqtNTRfZ+WqBfBdVIL/rTIkkVH/JVTJwYK4iULh74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=usZEmCuF/o6WfHt3w2kDdJwyDsAPurP9HsCTKXJG1ygUEHVHeWp4cvRo1+R7dFiUueEUm/CxN/hStNkRHAv4FD8eTzApBfz5uSYZyGpXM22emabNlVQOZ2aUdnk5q1WmlcC47ktRZZBbXv62Vqx8trZcPIZ8n4wE02JkeJu4kGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uUL3+H5L; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=thZIlWB0; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ff247726e9e011efbd192953cf12861f-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HohqtNTRfZ+WqBfBdVIL/rTIkkVH/JVTJwYK4iULh74=;
	b=uUL3+H5LipvPIPq4/7W/2n/GJlwf+c12Q/WELFhx0x4poUB8j2Pw7Hk2GjSJtIiGYyYijr1PrvhK/YBGhnSSnALsqIe4Lieli6agzK1yeU3jj5utiFOI7KiSM9guU7cfIagB5xYYrnZOHwelJERZS0xpYOlZPBbktZcYp4hoFSQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:7e9fd25b-5116-4edd-a3be-f1e9feb388a9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:700b68a1-97df-4c26-9c83-d31de0c9db26,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ff247726e9e011efbd192953cf12861f-20250213
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 387558478; Thu, 13 Feb 2025 16:03:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 16:03:22 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 16:03:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWnCeLqVSDiqdqZwa8AgoPCesoM2JbYPc8XEfyUlYrzis01wWnpAfVUam9/9dE8ooDbQZdPJWmBvH98uDYBOZgdo73vjF/0dc5dpSG3mVLRgo9TxlIamEI3NLom/unlvM5h5fQQQNefIWMHYT3iK8xmaaKH2K0DenUwI4PVz1CAD1l5NsgHscqKFZvhlX/8siVeYjw/NEzKuH4PuzhKZYX1Bg8RSraBCuGZl/WZukVbVP88Ffy+63nT/vVmD23gc/CjLXk4lsbclm7Rjbzya0R6j+7qRNc5Focvvuc3bmKZ9Hlcqx19aR/HB497BiZlZQhF82LmcjylbhzPEmwCDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HohqtNTRfZ+WqBfBdVIL/rTIkkVH/JVTJwYK4iULh74=;
 b=SnRL2j+OtCgnkK4imfUws5I5GZtNVO0c2Y1qCjRkdSMHZV31q7hyrgdIpTJvLoHpQLgM9Az0LnuJAPmBbaJL/KWq/jqpOvfuflwxxo3PWPVFNp7S18A6npNQh5Sno9n0wR5r/4RjEy4bRjQh+Tda1RZbWs+P35xEDbn6FjlmRRz+N5GjvkLp3BQXb0oyFTNjMVdV3VNwLPjE617i5gHuiflvtQCiPoNC7AUnsiTS/7yyOsd72cUN/3QbBGvpmq2xlqqcF1V/YGnZTeUPeGVg8vsUJ8Neat1vxWW8kNQFGh+OoaIlcptWMVVP8XDHwWp4l8sFygl3yA3GSkxjuQuhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HohqtNTRfZ+WqBfBdVIL/rTIkkVH/JVTJwYK4iULh74=;
 b=thZIlWB0oNhTIecfcbs3MmE8+jm8h1yCw+Nsyvd6we8AhI76YEt3DImPDcSpfGWz8BGB+lTpi/Tl7FwE94FCfqgcBBfqX8yGYha++majcVj5VLdol7AL1Dgl3lXUvasTS+us8ZmOZXAUncWuDepeTPspwk592JigT+4HTfFzwas=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7819.apcprd03.prod.outlook.com (2603:1096:400:464::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Thu, 13 Feb
 2025 08:03:19 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 08:03:19 +0000
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
Subject: Re: [PATCH v6 34/42] drm/mediatek: mtk_hdmi: Add HDMI IP version
 configuration to pdata
Thread-Topic: [PATCH v6 34/42] drm/mediatek: mtk_hdmi: Add HDMI IP version
 configuration to pdata
Thread-Index: AQHbfHkwRYc7x0Y//UKZMMOTAkZ4lrNE4oqA
Date: Thu, 13 Feb 2025 08:03:19 +0000
Message-ID: <7b320c063bc5ddeadb2d8672516a382874c4b1be.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-35-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-35-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7819:EE_
x-ms-office365-filtering-correlation-id: 0c025d13-8dd1-415c-ab02-08dd4c04e11b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mjl1NEVjdUZUNzBHbW1ZMmk2eXBMQ3NCV2daeDNGbm9LaGxHaU1UZEtjTUJT?=
 =?utf-8?B?T25BY3V0bGhwSmh0ZXJ4Z1A4WmpVZ21pRzQrTHVjcWdIcUkyWFRMbk1xUUJG?=
 =?utf-8?B?emRWNDJXVnZZem4xNlNLaVVuTkxiVlNBdFViN09Eb1JIeGR0S1lXZGxMYm1I?=
 =?utf-8?B?bGVoS284dlhCMmRiMDFBNnVwOUZZYTAwOEZNTEJYWEtFUmpuRlFUd0JOTUNY?=
 =?utf-8?B?QzNGUFRTdzZmc3hYRFZIY0o2bkZhTkE3K2JUTVJ0ZFVKV20vMWE2ZWpvNnlV?=
 =?utf-8?B?YldZYVh1akt6TlU1VzErR3RwS2NhNHdsWXlZVjVVTkNrM3M3a2ZTbmw2STF2?=
 =?utf-8?B?SlVzWHBlK0x6TEpxdzQrTXZzUnpGbVVoSVErcXdwZFhQcXFVb2pia3BVTjdB?=
 =?utf-8?B?MHFIb0Z5eDNMQjNNd1dKUjlnQ1dJbnl3cVlQblpMTzZjYlEwRE43Y1pPTzFL?=
 =?utf-8?B?bExVUkpIOUxSaGtrVHlnU3MvYjQyRHc0RFBMRTFpQ2FYT3BleXhJMklmZnRG?=
 =?utf-8?B?WUNhL0l1Y0lReHY4c1Q4YkZqTHcvTFR1ZWZtNG0wbXFmU2NNb2ZyNUFacjNy?=
 =?utf-8?B?aThOTlBQMGhIYXUrRmFaWnU4V09ETFRqNmZtdUhBZGpFaUJnNU9UTzk1SUYy?=
 =?utf-8?B?SFg3OXpWRWlTUzBBaUxDekg0eitmQnJxS2JOMlQ2U2g3SWtjMVdBYVdiaUVz?=
 =?utf-8?B?cHBPRGNiMndCMzJGN1pDRDFINWhlVnBuNEE1d3pmR3pNV09xMmZmWXQ1bEVR?=
 =?utf-8?B?Mk92bnJYam9wekVPbURlMG02eXdTaVdOV2FRM2EzeTkzM2RtVGhZZ3lVbEpn?=
 =?utf-8?B?V0VYMkNTOFBvd21hNXF3Rm9DOWtBRXVvNCsxSGFlQ0ZQZHlCa21aNjkxczJ4?=
 =?utf-8?B?SnQ1NG9UQ2xFd1JkVzU3UkVJSXRweFArUjhSdklJMVF4dktFMkVCNzhmbHVN?=
 =?utf-8?B?SDExR0RyaVFpUDBsV25ITHN0ODVpWlFMVmV6dVlSbnVZTGFaMGJTMEp2NDNt?=
 =?utf-8?B?a1NwdHhKT1pVR2plOThGdlBUTGo3RXZ3eStHNUdtRjZnRWYrbjNvOWl3MWpT?=
 =?utf-8?B?d0Rqa0tJQStuNXFLcVBqeFlyL0oyRnJXNUpaUUFGNHUzcFE5NlB6MmYrM3Zp?=
 =?utf-8?B?aTBVVUIvV0VSb0p4QUdiOC8zdU16QkNTbkZaSVcrdm5FUHVrOUZoWlZLdUtt?=
 =?utf-8?B?YWV6TUlHcURtNElKbzFqOWFoSUtpdDI2Nkd4bFI5a3JKaXYvRVhxUXBBV2FO?=
 =?utf-8?B?dm5MTEtKdzk1NDZsanJEVTZJeWk1d0MwQ3lyYXBWQk50U3k0VWxZR3BpQnJz?=
 =?utf-8?B?YWpXVllIdEIyZTVielhuT2trbXd4cHJ4WEhxNk1RRU41bGJhcWtYRUhmUmVZ?=
 =?utf-8?B?bUVSY0EvWjluNGFtdktRM2NvWTYwSzJYdFUxUGk3dDJHeDBIMWxEOTM3cWw0?=
 =?utf-8?B?NU92NW1BVnVUaTlmZm4yd251V0hUdkxhVk5MeHRzU0haekxhbmZNSS9NZnVQ?=
 =?utf-8?B?ZXQwbEZsNEFKSGhXL0ZsVXVWZnR0NFBqVVUwV3g5RXNUdG45bVN4Q2tyMmtq?=
 =?utf-8?B?US9YL1EwdE5VZGlueVFxTTltbFZuQ2kvRGhxTFp2cEJ3Zm03aSsxdVN2Wk9n?=
 =?utf-8?B?WVRZRnBna2tTbTA1MndXZ3B6Z01IZUdXY2U5UW1Obkc3MFdBQ1hDS3lDUUVV?=
 =?utf-8?B?QUNyUTJJUllPdHE1SmNXYnpyL016aUpEOHFkcnVsbXpRUEo2dUExSTJpbWwx?=
 =?utf-8?B?WGErbGgzc0FRMlgyNDhvOWlrUDlmZDdUZ2xkZlgwZHVaR3cySW16NUd6U3Bl?=
 =?utf-8?B?WFMxbFdETHFBaDBkYjZpYW9vdVNtcGVGZjB2RXc1UDJpZkFJa2ppRHR3RVdX?=
 =?utf-8?B?MWpiV09xRjZsSG5XdHZjL1JMbUJ6cHRpMWhMbzMvckZrSWZRanlydzZKblFV?=
 =?utf-8?Q?pic8qScC710Ak+hd3zur+y9CoCeuNCoo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1lNNVNNRGQwUlFNNnprdDZ2THFQMkdKZ1pkanZwSDJIZjdvVWVwVDBORmR0?=
 =?utf-8?B?MUd3bDZJd3lvRGdhNDJQb0pNNlNWcFdMWVhJamR3TWtyb1ZzeUdqRUIvWSs5?=
 =?utf-8?B?NkcyeFVvdURyYjhOSGx5UkQ0aEoyeU5iQk9GQVdxZk96L1l3V1NsRGd2czda?=
 =?utf-8?B?NEtSb0NocHprcS9yVUIxTVlDZUlHSWh5akp3eTI0emNrNms4eFMvbzFJRmc5?=
 =?utf-8?B?U1dqTHY2Yk1rUFhvakxNeDV4QmVQSkdVc1FMd1RnRS8ySk15Rlh2S083RGxz?=
 =?utf-8?B?RVJCNWtOeDFhaUIvT0NmcEFsWjJmWTEvUTVUZUd0RVMvWTZCYUMxVDF5ckRJ?=
 =?utf-8?B?OUIrSHUrN0x5M2FJY09yTjNWMHNaVmVZYldKcWtNeGhFalE4UDJGTkI1MEcr?=
 =?utf-8?B?TTlic25XT0djOUxCUm1DNjJDQkJ2N1BweUU1THNZUVVuQng5QWZNUHZRT24z?=
 =?utf-8?B?ay9YREtpVTNYMHFvVDNmMUtYbW1rTzZlSTNSWkdNdEdkbDhVUlhseERUYXps?=
 =?utf-8?B?cnh3OUhKeXlJVEk5VUNOTFN6MDM1cjZrS01IUS9RV09QdjlrWXA5Wjlnd2Vi?=
 =?utf-8?B?cXRUbkROM1QxZ1lqaWJ2SVJ0NE13QUNUb3BIVW9ENWpXb3hyYS8wVTFjbnJC?=
 =?utf-8?B?ZVVyK09hcWwrRDIrRVVWSXUzeE9mNXRYSGh2a1o3Z2wxQ1hnS2JaeUNZWlZV?=
 =?utf-8?B?VWdyelF1TVZBYzc5cTBsd3JJdCtBU0wrS0EvSEc2cDM5Q3F0b1V2VzdodUlZ?=
 =?utf-8?B?NGJSVHlTTEFoMDl3amJ1OGpSNlc1dlREQW9BMUNCTHQ0cGFNejZNOVdkMjg4?=
 =?utf-8?B?bkl0TVY5OGZORzRKc3RmcEh0bXRsQzVWUi9SaE54Y0oxVzdiSk1CT09DQTI2?=
 =?utf-8?B?VytDamxOeWhxUStmU0t0Qkd2MzRiSDVDODFLbVZTUXlFNmw5cEhTOHI0aDU1?=
 =?utf-8?B?dkNCZzlwYmJmTzd4Q3IyTkpsN2x0TkxoNWVrcCttZytnd29aNFpXVnhmL2lP?=
 =?utf-8?B?czloT1RUZzRYNXpzY29zaDdyN1N6dTZrblJuQ1lBaEZNRXFnRVNYSHBhVVJH?=
 =?utf-8?B?bkVGMGd2NUZBWFdCNk1RRUNmUVc1eXB0bkJVOXV1N09SZGxzWXlMczdYTm1a?=
 =?utf-8?B?ZlRLWFQ0TzVLdGtKemljR25pZHJKRGNTY0hyQld3a000ZW52Y21ueGFTK0Z5?=
 =?utf-8?B?MWRqR2tZcEtNRmRIM1pIdnBwcHpkZVZ5YW90aUZIdHdxVVNqY1RVWU5waE5D?=
 =?utf-8?B?K1djRDNOLzI3NUNaL2FNQVRKNWUxL3dyMG03M2cyUmpqeVlMaXRjS1ZlWGZ3?=
 =?utf-8?B?MlF2M2tHRER1N0poMlhGWVRtcWh2NU1QenJ3VjFqbG5Pa0hFRld5a2MxRjVF?=
 =?utf-8?B?YVk4N2YxSms2ZUpDOEFENU5nY2ptL0pOVjdUVTg0OHd6bDdyaWhPd0FLNHUr?=
 =?utf-8?B?VitNZzd6Q3FWZGVKUCtqQUZRTWFrbktVbXNTWjNGMHlCeHRObW53NTVTUENS?=
 =?utf-8?B?Q0NVSm53ZnlyOTVmSm1ObW5jT2FVSEU2YWJlMHlXaXpzT3JWSDRxT3RlTGRE?=
 =?utf-8?B?YUJlUXU4S2dYcmIvRC9YOHpKZldIVHkvNWlpQUpXc3BMYkhRUlJTb3RBMFVX?=
 =?utf-8?B?TVhXOHdBc0Mrb1JTZGtDVjFLWlZSNWVRSUJ1SU81K3JlWnZsQW5zOWNRQW01?=
 =?utf-8?B?a0s3WmFBZURVRitMZG1iOCtUOGJHVkZrbHdNazlEL1BvdjdOK3lkenE4cVcv?=
 =?utf-8?B?OFdicEx2aGhmZjlpVGYwQ01tSlJ6V09Zb08zK25UYThqd3NDMXhCdFJIVGk2?=
 =?utf-8?B?VVVCaWR4VU8wVXY3S0lnTzFZNVVHb2lJMzVwREFPRUt4RWhkMTJESTB2blV0?=
 =?utf-8?B?dkJpSU5TSHpGa0U2WWNlTnpmQkY0RkhReUs2aFNvc2lJSHZweTR4dldMOVF1?=
 =?utf-8?B?YWF3R2Z5S0tmSVB5VkljRUo5Q0FrYXMwN3N2S0gwcG5jOHdCRUNhczRmZzJI?=
 =?utf-8?B?cVFCVnhLQUtpbmR6VkxzaUh1UCtJd2w3OWxBZk9HTHVlMlJqbUxaRVdRZ250?=
 =?utf-8?B?UzVodzB6dmRxZEJ5Zzd0UE5KQjhGSTRpNitOb2JqMG5KdWQrRUo2eWJjREVC?=
 =?utf-8?Q?quWDoMjEcTbTd6CxLeaYaQFoa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC4A732A7DF9D640820CF218769F6244@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c025d13-8dd1-415c-ab02-08dd4c04e11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 08:03:19.6405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rw/Rs+iVUkOT9I4o8BfXENToqZxaVEkMg6r5tG009XXgbk+0lVD6FCjodSWcOAbX0fZptN6bpDbSfAbJ7e4fyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7819

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjM0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBmb3IgYWRkaW5nIGEgZHJp
dmVyIGZvciB0aGUgSERNSXYyIElQIGFuZCBiZWZvcmUNCj4gbW92aW5nIHRoZSBjb21tb24gYml0
cyBvdXQgb2YgdGhpcyBkcml2ZXIsIGFkZCBhIG5ldyBzdHJ1Y3R1cmUNCj4gYG10a19oZG1pX3Zl
cl9jb25mYCwgaG9sZGluZyBwb2ludGVycyB0byBIRE1JIElQIHZlcnNpb24gc3BlY2lmaWMNCj4g
ZHJtX2JyaWRnZV9mdW5jcywgaGRtaV9jb2RlY19vcHMgYW5kIGNsb2NrIGFycmF5IHVzZWQgZm9y
IHByb2JlLA0KPiBhbmQgbmVzdCBpdCBpbnRvIHRoZSBtdGtfaGRtaV9jb25mIHBsYXRmb3JtIGRh
dGEgc3RydWN0dXJlLg0KPiANCj4gV2hpbGUgYXQgaXQsIGFsc28gY29udmVydCBhbGwgb2YgdGhl
IGRpcmVjdCB1c2VycyBvZg0KPiBtdGtfaGRtaV9icmlkZ2VfZnVuY3MsIG10a19oZG1pX2F1ZGlv
X2NvZGVjX29wcywgbXRrX2hkbWlfY2xrX25hbWVzDQo+IHRvIHVzZSBwb2ludGVycyBmcm9tIHRo
ZSB2ZXJfY29uZiBwbGF0Zm9ybSBkYXRhLg0KPiANCj4gSW4gb3JkZXIgdG8gZG8gc28sIGl0IHdh
cyBhbHNvIG5lY2Vzc2FyeSB0byBmaWxsIGEgbmV3IHZlcnNpb24gMQ0KPiBzcGVjaWZpYyBjb25z
dCBgbXRrX2hkbWlfdjFfdmVyX2NvbmZgIGFuZCBhc3NpZ24gaXQgdG8gYWxsIG9mIHRoZQ0KPiBj
dXJyZW50bHkgc3VwcG9ydGVkIGNvbXBhdGlibGVzIGZvciB0aGlzIGRyaXZlci4NCj4gDQo+IFRo
aXMgY29tbWl0IGJyaW5ncyBubyBmdW5jdGlvbmFsIGNoYW5nZS4NCg0KUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMgfCAzNiAr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19oZG1pLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hk
bWkuYw0KPiBpbmRleCBkM2JmYWUyZjE4NDIuLjMzMjU2N2YxOGM5YSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4gQEAgLTE0NCw3ICsxNDQsMTUgQEAgc3RydWN0IGhk
bWlfYXVkaW9fcGFyYW0gew0KPiAgICAgICAgIHN0cnVjdCBoZG1pX2NvZGVjX3BhcmFtcyBjb2Rl
Y19wYXJhbXM7DQo+ICB9Ow0KPiANCj4gK3N0cnVjdCBtdGtfaGRtaV92ZXJfY29uZiB7DQo+ICsg
ICAgICAgY29uc3Qgc3RydWN0IGRybV9icmlkZ2VfZnVuY3MgKmJyaWRnZV9mdW5jczsNCj4gKyAg
ICAgICBjb25zdCBzdHJ1Y3QgaGRtaV9jb2RlY19vcHMgKmNvZGVjX29wczsNCj4gKyAgICAgICBj
b25zdCBjaGFyICogY29uc3QgKm10a19oZG1pX2Nsb2NrX25hbWVzOw0KPiArICAgICAgIGludCBu
dW1fY2xvY2tzOw0KPiArfTsNCj4gKw0KPiAgc3RydWN0IG10a19oZG1pX2NvbmYgew0KPiArICAg
ICAgIGNvbnN0IHN0cnVjdCBtdGtfaGRtaV92ZXJfY29uZiAqdmVyX2NvbmY7DQo+ICAgICAgICAg
Ym9vbCB0el9kaXNhYmxlZDsNCj4gICAgICAgICBib29sIGNlYV9tb2Rlc19vbmx5Ow0KPiAgICAg
ICAgIHVuc2lnbmVkIGxvbmcgbWF4X21vZGVfY2xvY2s7DQo+IEBAIC0xNjA1LDcgKzE2MTMsNyBA
QCBzdGF0aWMgaW50IG10a19oZG1pX3JlZ2lzdGVyX2F1ZGlvX2RyaXZlcihzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ICAgICAgICAgc3RydWN0IG10a19oZG1pICpoZG1pID0gZGV2X2dldF9kcnZkYXRh
KGRldik7DQo+ICAgICAgICAgc3RydWN0IGhkbWlfYXVkaW9fcGFyYW0gKmF1ZF9wYXJhbSA9ICZo
ZG1pLT5hdWRfcGFyYW07DQo+ICAgICAgICAgc3RydWN0IGhkbWlfY29kZWNfcGRhdGEgY29kZWNf
ZGF0YSA9IHsNCj4gLSAgICAgICAgICAgICAgIC5vcHMgPSAmbXRrX2hkbWlfYXVkaW9fY29kZWNf
b3BzLA0KPiArICAgICAgICAgICAgICAgLm9wcyA9IGhkbWktPmNvbmYtPnZlcl9jb25mLT5jb2Rl
Y19vcHMsDQo+ICAgICAgICAgICAgICAgICAubWF4X2kyc19jaGFubmVscyA9IDIsDQo+ICAgICAg
ICAgICAgICAgICAuaTJzID0gMSwNCj4gICAgICAgICAgICAgICAgIC5kYXRhID0gaGRtaSwNCj4g
QEAgLTE2MzgsNiArMTY0Niw3IEBAIHN0YXRpYyBpbnQgbXRrX2hkbWlfcmVnaXN0ZXJfYXVkaW9f
ZHJpdmVyKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gDQo+ICBzdGF0aWMgaW50IG10a19oZG1pX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICsgICAgICAgY29uc3Qg
c3RydWN0IG10a19oZG1pX3Zlcl9jb25mICp2ZXJfY29uZjsNCj4gICAgICAgICBzdHJ1Y3QgbXRr
X2hkbWkgKmhkbWk7DQo+ICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsN
Cj4gICAgICAgICBjb25zdCBpbnQgbnVtX2Nsb2NrcyA9IE1US19IRE1JX0NMS19DT1VOVDsNCj4g
QEAgLTE2NDksMTIgKzE2NTgsMTQgQEAgc3RhdGljIGludCBtdGtfaGRtaV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiANCj4gICAgICAgICBoZG1pLT5kZXYgPSBkZXY7DQo+
ICAgICAgICAgaGRtaS0+Y29uZiA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiAr
ICAgICAgIHZlcl9jb25mID0gaGRtaS0+Y29uZi0+dmVyX2NvbmY7DQo+IA0KPiAtICAgICAgIGhk
bWktPmNsayA9IGRldm1fa2NhbGxvYyhkZXYsIG51bV9jbG9ja3MsIHNpemVvZigqaGRtaS0+Y2xr
KSwgR0ZQX0tFUk5FTCk7DQo+ICsgICAgICAgaGRtaS0+Y2xrID0gZGV2bV9rY2FsbG9jKGRldiwg
dmVyX2NvbmYtPm51bV9jbG9ja3MsIHNpemVvZigqaGRtaS0+Y2xrKSwgR0ZQX0tFUk5FTCk7DQo+
ICAgICAgICAgaWYgKCFoZG1pLT5jbGspDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01F
TTsNCj4gDQo+IC0gICAgICAgcmV0ID0gbXRrX2hkbWlfZHRfcGFyc2VfcGRhdGEoaGRtaSwgcGRl
diwgbXRrX2hkbWlfY2xrX25hbWVzLCBudW1fY2xvY2tzKTsNCj4gKyAgICAgICByZXQgPSBtdGtf
aGRtaV9kdF9wYXJzZV9wZGF0YShoZG1pLCBwZGV2LCB2ZXJfY29uZi0+bXRrX2hkbWlfY2xvY2tf
bmFtZXMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmVyX2NvbmYt
Pm51bV9jbG9ja3MpOw0KPiAgICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPiANCj4gQEAgLTE2NzEsNyArMTY4Miw3IEBAIHN0YXRpYyBpbnQgbXRrX2hkbWlf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICAgICAgICAgIHJl
dHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIkZhaWxlZCB0byByZWdpc3RlciBhdWRpbyBkcml2ZXJcbiIpOw0KPiANCj4g
LSAgICAgICBoZG1pLT5icmlkZ2UuZnVuY3MgPSAmbXRrX2hkbWlfYnJpZGdlX2Z1bmNzOw0KPiAr
ICAgICAgIGhkbWktPmJyaWRnZS5mdW5jcyA9IHZlcl9jb25mLT5icmlkZ2VfZnVuY3M7DQo+ICAg
ICAgICAgaGRtaS0+YnJpZGdlLm9mX25vZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gICAgICAg
ICBoZG1pLT5icmlkZ2Uub3BzID0gRFJNX0JSSURHRV9PUF9ERVRFQ1QgfCBEUk1fQlJJREdFX09Q
X0VESUQNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHwgRFJNX0JSSURHRV9PUF9IUEQ7DQo+
IEBAIC0xNzE2LDE5ICsxNzI3LDMyIEBAIHN0YXRpYyBfX21heWJlX3VudXNlZCBpbnQgbXRrX2hk
bWlfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gDQo+ICBzdGF0aWMgU0lNUExFX0RFVl9Q
TV9PUFMobXRrX2hkbWlfcG1fb3BzLCBtdGtfaGRtaV9zdXNwZW5kLCBtdGtfaGRtaV9yZXN1bWUp
Ow0KPiANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2hkbWlfdmVyX2NvbmYgbXRrX2hkbWlf
djFfdmVyX2NvbmYgPSB7DQo+ICsgICAgICAgLmJyaWRnZV9mdW5jcyA9ICZtdGtfaGRtaV9icmlk
Z2VfZnVuY3MsDQo+ICsgICAgICAgLmNvZGVjX29wcyA9ICZtdGtfaGRtaV9hdWRpb19jb2RlY19v
cHMsDQo+ICsgICAgICAgLm10a19oZG1pX2Nsb2NrX25hbWVzID0gbXRrX2hkbWlfY2xrX25hbWVz
LA0KPiArICAgICAgIC5udW1fY2xvY2tzID0gQVJSQVlfU0laRShtdGtfaGRtaV9jbGtfbmFtZXMp
DQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19oZG1pX2NvbmYgbXRrX2hk
bWlfY29uZl9tdDI3MDEgPSB7DQo+ICAgICAgICAgLnR6X2Rpc2FibGVkID0gdHJ1ZSwNCj4gKyAg
ICAgICAudmVyX2NvbmYgPSAmbXRrX2hkbWlfdjFfdmVyX2NvbmYNCj4gIH07DQo+IA0KPiAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfaGRtaV9jb25mIG10a19oZG1pX2NvbmZfbXQ4MTY3ID0gew0K
PiAtICAgICAgIC5tYXhfbW9kZV9jbG9jayA9IDE0ODUwMCwNCj4gICAgICAgICAuY2VhX21vZGVz
X29ubHkgPSB0cnVlLA0KPiArICAgICAgIC5tYXhfbW9kZV9jbG9jayA9IDE0ODUwMCwNCj4gKyAg
ICAgICAudmVyX2NvbmYgPSAmbXRrX2hkbWlfdjFfdmVyX2NvbmYNCj4gK307DQo+ICsNCj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2hkbWlfY29uZiBtdGtfaGRtaV9jb25mX210ODE3MyA9IHsN
Cj4gKyAgICAgICAudmVyX2NvbmYgPSAmbXRrX2hkbWlfdjFfdmVyX2NvbmYNCj4gIH07DQo+IA0K
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2hkbWlfb2ZfaWRzW10gPSB7
DQo+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtaGRtaSIsIC5kYXRh
ID0gJm10a19oZG1pX2NvbmZfbXQyNzAxIH0sDQo+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxNjctaGRtaSIsIC5kYXRhID0gJm10a19oZG1pX2NvbmZfbXQ4MTY3IH0sDQo+
IC0gICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtaGRtaSIgfSwNCj4gKyAg
ICAgICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1oZG1pIiwgLmRhdGEgPSAmbXRr
X2hkbWlfY29uZl9tdDgxNzMgfSwNCj4gICAgICAgICB7IC8qIHNlbnRpbmVsICovIH0NCj4gIH07
DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdGtfaGRtaV9vZl9pZHMpOw0KPiAtLQ0KPiAy
LjQ4LjENCj4gDQoNCg==

