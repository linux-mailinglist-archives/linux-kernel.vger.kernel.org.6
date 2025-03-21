Return-Path: <linux-kernel+bounces-570781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3EA6B460
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185D01897777
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0731EA7C1;
	Fri, 21 Mar 2025 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YGXdiOn6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YSUGM4Qm"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED8A1C174A;
	Fri, 21 Mar 2025 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742538368; cv=fail; b=N+8odpezEKbhatt6QlR30NbKzlEHUpeRCpK8QrADcctyql6OZJSNcOCooyvG1tbjzKGkcyXGm851/kVd4d7J1iIHSpCggV4UL2t8+Y9qIQNWl/1ZPEU+iHXAnYExAvy8tygoNs4aEDTKD3ymk/G4+kY3+jD2to4B8/HOq0KDIDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742538368; c=relaxed/simple;
	bh=Po7kAW6QYeYsotoHwJRHA2W3GG1/SSt+ZNgRyk4pyTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NyR3yL9tiozDcKULkpn8vQukM2BZWFayC3dZ01+VhG9T4vMfLGMoxEZkHB5Ecs1BqpWxEoF6u01bWfQSWETr2ZpPWkCe0jL8HJGT8hcJaP9vjV5KALytCdkEKA/2Ntmcijf+B1RC8q6B+NTV28zdfdTi72f7tvvlKnIeSa2Z/s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YGXdiOn6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=YSUGM4Qm; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5aa770e6061d11f0aae1fd9735fae912-20250321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Po7kAW6QYeYsotoHwJRHA2W3GG1/SSt+ZNgRyk4pyTQ=;
	b=YGXdiOn6Ty0JnjCyiCHeUuRSu11LveUcORU1nIB+D1LZfdheJqQETLhXOWdhGbM5qoDJ760b2+qUrO6Okp7+nNEX6hbNDdFFMKZJlIls2GqDgigWNC61ZGRJ+O83e2IBf95MXHU9BgttIcFeTAAlvjg0AMBTB8iqFz/6HJNVyn0=;
X-CID-CACHE: Type:Local,Time:202503211351+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:bb7e0238-3964-4139-b19c-1bb6c9feddf4,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:8352634a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5aa770e6061d11f0aae1fd9735fae912-20250321
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1336998061; Fri, 21 Mar 2025 14:25:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 21 Mar 2025 14:25:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 21 Mar 2025 14:25:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKb3dwg3u9k6OhnmFJe313hGyBLdT39p/vSbaGBfSeTj4hf+PCENn087tJMwGuWTwDJGd8kjWQhU5ZcwfPbVcaMf2M1NG6OSisyyL9b+EFk+jMZ0XaQjM2e0VOQYBxp5jCRsMuY1fkY5IUWAj3akC+euzezzXodVRkdloKNRElpRjhxt7jGKE4DjY8dKV1mnSVZVFpuVNfSxMocnbhITT+VwsKE7N7PgmjNEfFv9FQ2cITJiqy0wCYuqOjwzusEJbY/jdmn1vOSufN6ncgKSFIJLzWar5FRQDfQ3CKX/UEOX2/5Fu+Rktl8YR6jJQ2stK7r0PPsOV6FxSt/1LmX8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po7kAW6QYeYsotoHwJRHA2W3GG1/SSt+ZNgRyk4pyTQ=;
 b=ex0QIkdeoRxZ7OXmZnBfFyJOEYOicOkLq0WKGLmwUKWR99DXdqUlZ/TdZRS4OQJxqA+e/aX9/QNrm2N+SHv1WvmAZ4LwNE3fvQ78/OHV0tqHdTfhJcPACnl6SXMRR01eqsIAnZwYIIVGArMfRdKngu0PwxXoGwIDxz/uiG4oX/jbM+Rl6H27OoGWrXyJVA/3rs0bPKZ3RgMXK57YoB3JwpIyp8zmTb/SctN1kEoPM+DZQli2pNlcjhPJ1mmnTbKyt36ixcII2C5p7NSOmcIQLIoTyHQnwADZhN5QmN7ZflmSoaBzhT1cA3nnNY3fezNXEszHTmYLZhOiu8svgLdY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po7kAW6QYeYsotoHwJRHA2W3GG1/SSt+ZNgRyk4pyTQ=;
 b=YSUGM4QmVkEIoStJi7YIhmFgW1UM4uhmv8aZo3oIvOI107mIOA7W6V2NX3Q34OZhHs1Er4odSlqzj6nX2bcoEdXsK+GW3GjMHO2nGAx2PBZ0rurUtUpXnoesbpVXaevN6heE1vsulpvg31iop3dwldtGwT0ZFDFlFDx7+Y0QDFI=
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com (2603:1096:820:8f::5)
 by SEZPR03MB6788.apcprd03.prod.outlook.com (2603:1096:101:71::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 06:25:53 +0000
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d]) by KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 06:25:53 +0000
From: =?utf-8?B?SGFpbG9uZyBGYW4gKOiMg+a1t+m+mSk=?= <Hailong.Fan@mediatek.com>
To: "perex@perex.cz" <perex@perex.cz>, "pierre-louis.bossart@linux.dev"
	<pierre-louis.bossart@linux.dev>, "kai.vehmanen@linux.intel.com"
	<kai.vehmanen@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "tiwai@suse.com"
	<tiwai@suse.com>, "robh@kernel.org" <robh@kernel.org>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "peter.ujfalusi@linux.intel.com"
	<peter.ujfalusi@linux.intel.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"daniel.baluta@nxp.com" <daniel.baluta@nxp.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?WGlhbmd6aGkgVGFuZyAo5ZSQ55u45b+XKQ==?=
	<Xiangzhi.Tang@mediatek.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>,
	"sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>
Subject: Re: [PATCH 1/2] ASoC: SOF: MediaTek: Add mt8196 hardware support
Thread-Topic: [PATCH 1/2] ASoC: SOF: MediaTek: Add mt8196 hardware support
Thread-Index: AQHbmUbnZKLzS9bHIU6bGASslhev2rN77BQAgAE1jgA=
Date: Fri, 21 Mar 2025 06:25:53 +0000
Message-ID: <4453bb45cdb0553639846e8be2c51c57565ea90f.camel@mediatek.com>
References: <20250320031753.13669-1-hailong.fan@mediatek.com>
	 <20250320031753.13669-2-hailong.fan@mediatek.com>
	 <816dd6ea-0e5f-4d8f-a5eb-99d0670e0d43@collabora.com>
In-Reply-To: <816dd6ea-0e5f-4d8f-a5eb-99d0670e0d43@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6002:EE_|SEZPR03MB6788:EE_
x-ms-office365-filtering-correlation-id: 2a1d0995-769a-4c70-1508-08dd68413b24
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cHRWNHJDdnZ2ei9CMzRZTnpPTUtWQlFkRDROcHQzTFRYc0J5VmRXUC8xL0xj?=
 =?utf-8?B?VlkxZW1wdTV4ekVRNWUwdlpETXI0RmZqekd1ckhEaVJXSllWaEZYZWZENTRY?=
 =?utf-8?B?ejB1VkZYcStoVnA4K0RYM09YdCs5cDloREsxSmU2WnN6cHdVYXlSVmh4a3dk?=
 =?utf-8?B?cUtsdVl0eFVYN1VyM3dXQjZqL0grWjhSVi90MHpuRzhJZm1NYmREdURGNzdt?=
 =?utf-8?B?NmtZZjJnZVlSSUE4UXdIWDlQYzl0c093U0huUjI5dUhqY1E2YmdzcllYS2xY?=
 =?utf-8?B?V1Rtc3FGZmJBY2xVcHJsQU1OWUM1aVpiTW1xaC9SZUx4S0U5eWZ1SEVUL1Vq?=
 =?utf-8?B?TWY2dTNoQXhWVnAxc1lRQUpIeFVTK1U4VVhkdG0vNC9RU0dVQ0N1SDdvWFlH?=
 =?utf-8?B?aldlaTJLYjFEeDJHSlA3U0Z5NVkzdWpWdGMyNnhRcDFDdERjci9YSm9KbHQr?=
 =?utf-8?B?Zy9DNHYwRWp4blRCOUdqOUoyb2UzZnlFRStaaStrd3FraHFPejlBWUY3RzRi?=
 =?utf-8?B?K1pqMG9lRFlHd25nZldERG5peVhSZDBoanRkdm9QZVcvMU9XMzVTY25DcWtY?=
 =?utf-8?B?c29iakNkVWl6MU41SVRPa285YlFyemV0bml6ZUFzcVJxSzFHcFQ0eG9weDVu?=
 =?utf-8?B?a2ozNDBGUWVOZjlvRHJFNlcveTZDaS8rY0tWbzMyQy96SERIdjU4WE5PejJH?=
 =?utf-8?B?aFZyemlPRHg1Z2RZVkMyTlFNaDJtZlRrOVZJQXVlcEdPbS8yb2dVblY5cWtC?=
 =?utf-8?B?ZGVaRVZqWHJ6b0JrQXYzMndqUi9SUjhacFk0RGE0MzdubHVqRmVPeS9Qdm5X?=
 =?utf-8?B?SzZ6L3E2cGtjMC83c0Q0VlhiUktWL083OHdLRERaZlQvaWFUdEUwb3JvNGdB?=
 =?utf-8?B?UjZxcmt6WXlSeUV3QUM3dW0veUI0SEhGdndtV2ZMNGhtbjZyV3NKRkVCc1c0?=
 =?utf-8?B?U2o2azdGVTZyOHZpcms4Qi9VTXkrZ0t2Z2pCdzJ0Zm1ZK0ZrUkU1WTRORHVk?=
 =?utf-8?B?TnZ0SnFFenBqUGZWVDArWkFBaEpaWDU5V3hkZ3AzQjJDK1N0cFN1WjZiWldj?=
 =?utf-8?B?TFl0MmVacW1aNDA5cHlQRGF3c0dPVnpFS3JqZzZ1RW5OZ0k1VmcxWTRkWHJI?=
 =?utf-8?B?aitJN3hDVTZxVXBsR29uQkVia3o5Nkd4N3ZLdjZmbTJDNkhaeWQ5MEJhWkFT?=
 =?utf-8?B?d2ZPQVh4ODUzZTd5S0hXb3F6YTk2TGJseS93alBqcktaZlE5YjdMMFpId3U2?=
 =?utf-8?B?Lzc4MklJd3lIRmxodG4vam9jU1h2cDExdFdPUDdHUEZMbDlGaDhTTnBRMDl0?=
 =?utf-8?B?TFlKZjRKdXZFVkVHRkllWVlNdm5KQ1BHQjAyZ3V2cWRqa0VMVnl6em80bWJZ?=
 =?utf-8?B?c1hieGZ5MlVtcjdZQXpHMXFiQWxaOWZEYnNQdThsd1pCWWRtOHBYZDMvZmxk?=
 =?utf-8?B?enZkQ3A2SldDNzY4VlBlY1h1d0hybytSVEtxVkppbEt1QnZkZzRWTHFMVjJj?=
 =?utf-8?B?TmRmM0kyWDlnYk5ZRGFBS1dxUHMzOXhLT2Mra1UzUUtRcTZ3Yzdodm83SDdC?=
 =?utf-8?B?azF0azBzOFZmYVFJRUlkbDJNRmx1WE0veEplbUJNUHhnVTZZS09jZUpDQTM4?=
 =?utf-8?B?eEhPTGtqSVpYbFlnWDVHV2c1N0RhQUNIRzZZN1UybXBoWGJ6THhvTlV5M3Nm?=
 =?utf-8?B?MzFyd2Y2OVVEem1lSEsyb2x2cGlpcWM0emtBWFpjT1ZSb25lV0dHUmhQTWdK?=
 =?utf-8?B?YjczU25zZkcvR1Joc3Z5bGhhVjZDVUtXRE8wZ3pQWGFTRkluWVd0WndLNjI3?=
 =?utf-8?B?dmFVd0VNNjd3Tnc2cVRkdm9CeDBhQ0NpRHE2aEtIVzJMQmpnZUVxekZqb1lF?=
 =?utf-8?B?ZUNQUU5XRjlVcE1FSjZoQWZEckdLdmxXeUVNcU5SUzBrYUJrdkFmbDBCdGhq?=
 =?utf-8?B?ZHdrR1k5RXVyVjFHSXdEbkhjUXc3K3c2OVAxK1RyV2hCQVlzRHpRSkpaaDly?=
 =?utf-8?B?Q0ZLV0oyeS8wTHN6MGpVUFdzMkNKLzh5bzB2allBTlBzSlVpbkJRMUpueFNP?=
 =?utf-8?Q?Y1+OoY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6002.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmE4TlUweng4Sm1PZFc1M0ZycGJkWXB6RlFhRDB4L0YyT0lyUGVyR2dVVFVj?=
 =?utf-8?B?N2U0UXRjN2VQOG9NUDJkYUNySW1kWXlJWndLNG4xYTRFVGJjOWFsZG1QRzY0?=
 =?utf-8?B?OWV4VGRTYXltK2ZhOVVZQWYzU1ZRWnRacllOT3pXRXdSbmh5ZnAxb2lwVXBU?=
 =?utf-8?B?eWc2aEVReUJ4ZjkwVlI3cUxrRllnVmp4MmNSNWFIMDdQMjBpd29CSmJMZVBS?=
 =?utf-8?B?ajZWeVdqUGZ4V0RDUllld0w3SDB3NWNQVklWMGlnRHJYRTNYdVVWc3gxOFNx?=
 =?utf-8?B?QXF3dlBtbzF6Wk1Ta1FOVTVOWVFBckN6SDhGZU5CTmpOUTUrcjRyQkVhcjR0?=
 =?utf-8?B?QXgzTFFocTUvbm5GUDgvcFlId29JRzAvUlNlM0l1UWZzV2NyWEpKZnhWSzFs?=
 =?utf-8?B?OGNoeUkxUVBKaVJwVEpXYjV1Q3JGeVc3QVpucFU4RHFvZjlRam9vaUhDMldM?=
 =?utf-8?B?SG9tajlTZXpzT1UxbmFrRmFrYWpDYmJlMkNWQktteG96T1pNajlmOUVJRmZR?=
 =?utf-8?B?eCsrSGc3SFBNQ2lzVUJVQnJUYlgxS1V4akxwdEx0YzBhRTcwTXgyRUJUWVZh?=
 =?utf-8?B?RktRb0toN0E4VUtSdUVvS3JzaDBkMXpHbkd0MHcrcWxlVGY4NVM3bFJkZ1Vv?=
 =?utf-8?B?YTVaUXI5bUtBTWVLTkRhU293OTJNNm5vNmR4VUZvVTdjWXZsZnVlTXFuQ2ZJ?=
 =?utf-8?B?d1U2bFJwZFNYRmFyNyt5ZkxNZjRWVTdSYXZWYXpielBacmJremRISkc5VG5t?=
 =?utf-8?B?cE9pVTNueWRKZ20vbEhDME1KUldNYjg1RUpFRTlEVFM3dVhpNTdBeVRrT0ZY?=
 =?utf-8?B?cjBDcU9qRE5sd2U0NEJkcG52OXR4d1ZYVFhOd1VpdmdvTEhOQXQ5dUQrVWcw?=
 =?utf-8?B?eDVpajMwTHZZdEdUL3RMVEl0MCtHZWU3dWdiNHorQUtQeGNqTURicWRiZzRG?=
 =?utf-8?B?bE1wTlVqcG41Qm5BR1RPeEVPTlQ4SXdMRVBIWFR2VnFMd3pLc3VOY2I5NE85?=
 =?utf-8?B?UXlDOXRGRWFzK0hIY2pxcFh2QjJWcUY0enB6ZnBTTHFQRVBRWU5BU1FFNm1O?=
 =?utf-8?B?V1ZJTStvcHpZajBzYW1SMUNPTk1ndk9EMEo5elFHZzhRTjhSY2plbHdBSjZn?=
 =?utf-8?B?bVVsekhqSEhSUEptVmFpWjNHdDdyV1gycWh3V2daRGVPWU5HbWxDSk1EY3hy?=
 =?utf-8?B?ZFRpVDlUNjJ5NnQ0RXBseGlIK1ZMaTZBcTc5R05oNkJ5czFPRjI2WUNwMmdB?=
 =?utf-8?B?L3RMZCt3cjNJMHc3NWFtZVF4RnZxSmdnSXp3ZWMvWlQ3bEg1NTJJZS81ZWov?=
 =?utf-8?B?UWpCeVY4NThRTUJrS2NtTW1Td1pPRFBmMTd3S0VIbDluemp2K1g5dnhiUzNB?=
 =?utf-8?B?OUJVaHVmcmJHZWxuMFQzdm1BeittQjdETVdrbFBBTUh2UkZzTEdkNUZzVWNB?=
 =?utf-8?B?WndmOXlFdmZOcjRWS2ZxRlViNm93dE5XWVFNekEyUTJBUVN4SThudDlQRjRI?=
 =?utf-8?B?cnJHU1BGbFlONE03UnhiT0hsc3lTaHg3TGl0ekZVck5Pd1NJMG1JVTlrSWZ2?=
 =?utf-8?B?Rks0WGcrWUdXdklZcURZWFRERGl1WFRtMk9aYW1OajRNNkdscHViMVdnWnVr?=
 =?utf-8?B?L1Q1VWFyZ2c4RTJsSk0ydEtrVllVVHIvSmVHZG9weWJCUzR2TmdIVTluUG11?=
 =?utf-8?B?NlY4ZkZIMm50Z2F4d3NmdWlLSUkwTVZVVUJNRm5qWkQrYXJKU1BKQ0VEbUt5?=
 =?utf-8?B?eHMvM2hCdkRZQ1d2RWd0SHM2M1N1WjYydlVNeWJHSFF1dm45aFp6WVBQM2pI?=
 =?utf-8?B?amRwNHY3bUJKL1oyZTJTTzFmRW53YWR0ZU9MM3JoME9GZklVdzV3bVNqVEp0?=
 =?utf-8?B?MVM0T0NpTnZFSGc4NDVHaDViUDMvSEdFcWJzaE5PUEgwVVJxaEpXVjJLeWs0?=
 =?utf-8?B?WEFxZzJXRHdIMm1VS2RNdEhIU2QvUnRuRzFMZmI5bkV3VVFWanhYWUpkNjRU?=
 =?utf-8?B?WjdnZGllRXl0N0dmYVQ5c09TVzZqUFlSK3ZhUlZzdVdDV1ZISjVHdEFLVE9j?=
 =?utf-8?B?ZlAxLzZhUzFPNlhhWFhkalNLbW1RL0FibUhTTmtNUU9XaFBncTJVTWxGYzBq?=
 =?utf-8?B?bWlyZk1nNGtmaVh3SzJaZEE4bzZ2RWc3MDhMQlQvQ3M0anZiYjAweTdzQWhJ?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB0EDFA63EF8C14EAB31E9334830B891@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6002.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1d0995-769a-4c70-1508-08dd68413b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 06:25:53.0817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCdTL4Jn2LyxcIiiCRgjW0eyqBCblw/M/yrQLRPapbkJ0QTXWn2wm38Sim9fpBpAWy+49bMGtxM4jxNzCwhY/0l432LncpYXT66/GF85NGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6788

T24gVGh1LCAyMDI1LTAzLTIwIGF0IDEyOjU3ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyMC8wMy8yNSAwNDoxNywgaGFpbG9uZy5m
YW4gaGEgc2NyaXR0bzoNCj4gPiBBZGQgc3VwcG9ydCBvZiBTT0Ygb24gTWVkaWFUZWsgbXQ4MTk2
IFNvQy4NCj4gPiBNVDgxOTYgaGFzIGEgQ2FkZW5jZSBIaUZpLTUgRFNQIGNvcmUgdGhhdCBpcyBy
ZXNwb25zaWJsZSBmb3INCj4gPiBydW5uaW5nIHRoZQ0KPiA+IG9wZXJhdGluZyBzeXN0ZW0gYW5k
IGFwcGxpY2F0aW9uIHByb2dyYW1zLiBUaGUgSVBDIGNvbW11bmljYXRpb24NCj4gPiBiZXR3ZWVu
DQo+ID4gdGhlIEFQIGFuZCBEU1AgaXMgYmFzZWQgb24gc2hhcmVkIERSQU0gYW5kIG1haWxib3gg
aW50ZXJydXB0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IGhhaWxvbmcuZmFuIDxoYWlsb25n
LmZhbkBtZWRpYXRlay5jb20+DQo+IA0KPiBIZWxsbyBIYWlsb25nLA0KPiANCj4gYWZ0ZXIgc2Vl
aW5nIHRoaXMgc2VyaWVzLCBJIGFja25vd2xlZGdlZCB0aGF0IHRoZSBmdW5jdGlvbnMgdGhhdCB3
ZXJlDQo+IGR1cGxpY2F0ZWQNCj4gYmV0d2VlbiBNVDgxODggYW5kIE1UODE5NSBhcmUsIGluIHJl
YWxpdHksIGNvbW1vbiBiZXR3ZWVuIG1vcmUgdGhhbg0KPiBqdXN0IHRob3NlLA0KPiBhcyB0aGV5
IGFyZSB0aGUgc2FtZSBpbiB5b3VyIHN1Ym1pc3Npb24gZm9yIE1UODE5Ni4NCj4gDQo+IFRoZXJl
Zm9yZSwgSSd2ZSBzZW5kIGEgY29tbWl0IHRoYXQgY29tbW9uaXplcyB0aG9zZSwgcmVkdWNpbmcg
dXNlbGVzcw0KPiBjb2RlDQo+IGR1cGxpY2F0aW9uLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgcmVi
YXNlIHlvdXIgc2VyaWVzIG9uIHRvcCBvZiBbMV0/DQo+IA0KPiBUaGFua3MsDQo+IEFuZ2Vsbw0K
PiANCj4gWzFdOg0KPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDMyMDExNTMw
MC4xMzc0MTAtMS1hbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20vDQpPSywg
SSB3aWxsIHJld3JpdGUsIHRlc3QgQVNBUCwgYW5kIHRoZW4gc3VibWl0IHRoZSB2MiB2ZXJzaW9u
LCB0aGFua3MgYQ0KbG90Lg0KPiANCg==

