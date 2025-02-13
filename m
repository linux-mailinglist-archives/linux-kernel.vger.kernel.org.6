Return-Path: <linux-kernel+bounces-512419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8525A33912
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EB918897A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAF520AF6D;
	Thu, 13 Feb 2025 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O+uBYuv8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZGQnEqY/"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B820ADCF;
	Thu, 13 Feb 2025 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432536; cv=fail; b=BNmx7PG51HVcLARrzaXsSGuljKgeJz534Yqn9yIXOM4C2gDyVhUgAsaZOjIBJPFo/dM044oS1DlfTyXycZCWgi2JpDUdjVfzsbM4FHho5tXIBgpP3p03RnXpMDW/wQybGMaEE75j14yId88/9+KDvn379KhYwUjtyTV0Z22UA3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432536; c=relaxed/simple;
	bh=Xm8T8c2OxJdOn5WtfyZERWKZY+t7DZUiQMP/eEqYWCg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EnqypZSwf85ErQvKbSvw+PFH8yRRYYhaGRIu6cXDTwY27V2MEZvXCTdHfoBucuzUFO8Sz4yfENLl8GgxlVpjdI4t83x7p8EMpdijEXZoiDnT46RHwFrrK47rULZzTec14tZJXIyz77herPtIIxvSpzYH6SoK4+ASrorEZYOCssw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=O+uBYuv8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZGQnEqY/; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 063f1e2ee9de11efb8f9918b5fc74e19-20250213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Xm8T8c2OxJdOn5WtfyZERWKZY+t7DZUiQMP/eEqYWCg=;
	b=O+uBYuv8BR/bCSy7lPogj3K6XAAW5vTTVt6SnXBoKBLHATEsQe07GxDDoJunpWsskj6V6qwCCPtTGuaIScgSrRc+1K0oljpzGYOmDdO3ihI82TOf4kXeN4wlXY3fcjjrZWpuLoOKSlS5AluI/aPalRRn7aIJZ+v/lICIkWmeTy8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:59527a9b-4853-4571-b0c1-28f3b3db4901,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:02b267a1-97df-4c26-9c83-d31de0c9db26,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 063f1e2ee9de11efb8f9918b5fc74e19-20250213
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1529553320; Thu, 13 Feb 2025 15:42:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 13 Feb 2025 15:42:05 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 13 Feb 2025 15:42:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o14mvSMG8XL1xLTPyWTkllG9ohUKhh4sxBA+tr2XCXY56vf+itVOy6fX2NfkSfOkadEi1RmQxKliVS7B0r1TJu2M8j/YTl/3tBU7J91Yyc5RwKI0CMsLGIRGM1FHLwS7qdno28UeTPU6764ePu24PSMsE4cpNtVV2w88cTlxlurOysPyeGwnQbIGkUpk51It6QmbvnHmfxOCQ3SSw72s4x2bX7LMmnd9UeeUPCQBtzX2Gw3gNxfCWIvp51ZExGIQNRjnfDleEkx+omuJH2bCNbwG4ZDu3V+ryKbMIgAA+S42kccLvJofZdmsVQ220+BMY3Ezk1IRpfTesZPe1g0GTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm8T8c2OxJdOn5WtfyZERWKZY+t7DZUiQMP/eEqYWCg=;
 b=f3kTcBL2ofVMFF1DCjIvbcZrsisvutbMhUmAK7E4q8cV1Jyjo/JSvlyi/lZr7eXapUhgG14JhSk8aFE44u4wiqhcunh2IZ5bCVSg6MWEZR+B5LZAOLBtPfj5u6hZKHGS6mh07LpH4LxReKChCyOIdw+sy6/N4JPlQNmuVu7Ij7JegfxWfII82wsEmwbWxyQtPAVUW05nfhjd6/Ks3alcUl2mZwZGc0AuR108i90DF6afewbh1oH52Y6SDddavZuOm+Qw/12P3iPNf8HUOhaU4rzPA7/PCtdTTAjdQWGrqTvBp/i3xScV4cU8YworVQpLXlJ8fxYL1tq8Nb8IrLgbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm8T8c2OxJdOn5WtfyZERWKZY+t7DZUiQMP/eEqYWCg=;
 b=ZGQnEqY/GD3e3vB+CQOufCDp8q+6QLBcUQV9osITiDgR+5WCFJxUPqnIzkEohLnh0b2ODUPmmj9YWoj+roD7hZ+2Rj49fu9qRxV0ONR6F0CcWaVCUq6fcNQIiE+OuXV5dkf4S8p5h5K2aZEHWywaldLNqNsKxG8kfj6f3jQfWSk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8061.apcprd03.prod.outlook.com (2603:1096:101:17c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 07:42:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:42:02 +0000
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
Subject: Re: [PATCH v6 25/42] drm/mediatek: mtk_hdmi: Move CEC device parsing
 in new function
Thread-Topic: [PATCH v6 25/42] drm/mediatek: mtk_hdmi: Move CEC device parsing
 in new function
Thread-Index: AQHbfHpGTW2g3zxBEU2QXgoaf2WDibNE3JSA
Date: Thu, 13 Feb 2025 07:42:01 +0000
Message-ID: <0e164efeaa3cde827293bfed001d7a2c5fbb56fc.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-26-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-26-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8061:EE_
x-ms-office365-filtering-correlation-id: 05859a33-de38-4b5d-dbe6-08dd4c01e78b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RjIxU0Rna3MwYzBWQnZDVkxoUnhmMzRlV1VHUytkS0VDSHVlYWFpYjJ1Yjdn?=
 =?utf-8?B?UGVFSHovMEVpc1BYVDlzTlFSdGRJa295Rmhvd01oY3hIMzVQQkNDdFE5U1dh?=
 =?utf-8?B?QkRJbEMyOUV4Y0NDNEFsZEVIMDBUcEk4eUx4VjI4aEdwemdFVDRUcktKbyti?=
 =?utf-8?B?S0phaVJhSjducnVHZkRZT2pJOXJhOXlISzJ5M294dG15Qm1qMEIxcllITDNo?=
 =?utf-8?B?eENWanROTUZaWWhFckdOVW02WVJvNHBpWXRGeWhkWHEyWFVDT3NMeSs0V3V4?=
 =?utf-8?B?WU94V0pJbXZMS2hlUXpkczVZZ01TYUU3anl3TERveDVIYmpRMSt6MysybENE?=
 =?utf-8?B?UVJVbHdWcDZFeCtweFJDZ2tkR1Fqcyt5Wm0waGNGNHJTbHhZSG90dC9QNHhQ?=
 =?utf-8?B?OExlVVpCQTJGbHZUQ09wcElLRDAyWDZZOXNaQlB6eklBVm1PbllBREg4V21z?=
 =?utf-8?B?S1NFUnNBRFp5N1pleVFaMFpSWXp5c1ZHMHEvbUcvV1NkTnRHRFc4a2JvOGxl?=
 =?utf-8?B?clZvOUJpeWFxb1dvQ2VkcCtOclZNQStBUmVZamF5T3R4MGVEcGlHNndhcE12?=
 =?utf-8?B?TkNmZ3RMdXJVeDIyRjNSY1BCdXRkRUo3d01rcnpCQ3FTMUkxdUoxQlYzQk9C?=
 =?utf-8?B?Zk1yNDRzeFp0UjdaQm42bUpxZGY0ZWdGWGszV2tvMG1kUjNMOWh4cFAydXM4?=
 =?utf-8?B?RkhSK1E4QzV2Tm1vZEtVVkdRUWtjekZNcHBpRHJpT28wVk9EL3dHL24zZ0pn?=
 =?utf-8?B?eEZnZWRDVUROVHd2ZC9PK1RnekpmOWpEcFg1K3lGM0tuajhMUmNvQThYZzhR?=
 =?utf-8?B?cXdnZ3ZPSEtVTUpJamlNb25pWnFjMGJGRVJRblV4VkRTUC9Zdk5PL214NGxj?=
 =?utf-8?B?elpXVGhrVFN3NnRUcFRmMFhmRlhJbjdJckxDV3RWT0oyTWxhamxmUklKVTJJ?=
 =?utf-8?B?alNqWFlHbENEWnYwbzE1a1BTYnoxU0JUZFhNTDE2Z085UDJBQlFqOHhPcU1y?=
 =?utf-8?B?aWxzUmU4dm05ZjhVam9ZRmEvTHFGc2Nja08zNUVsUENXcTFvUkdQNkNwaXc4?=
 =?utf-8?B?ZEVoOW0rc1p2SGFsK0hPQ3JGaTRhQnhiVGpQc3pMemlSV1prM3g5dDJMc0Vv?=
 =?utf-8?B?bG1zWm8zeGw2VWtZZVB3d3dpMzNjMGh6V2xVNzd6YllhU2MrSk1QU21Ldk1j?=
 =?utf-8?B?Um4wSEl1Zjk2aEJyYnBpaTNRMmQ3MTkxeFd1WXZXNWZsQ0NmeEM0UytjNDZr?=
 =?utf-8?B?YnVGYnp2UUQzNzhNWmpsd3p4blhGTnZiNW85VXhIcUdSRmZoc0xzSmNQaDJo?=
 =?utf-8?B?bityQjN3KzZoT05FdEh5akVRdDBKVFVFK3BLNGN5S3FLN0YvMFdYQk5OaW5O?=
 =?utf-8?B?cU1UdERqWUsrSWlFUzh1ZUpUZm1jeU5qYlpodUxXMExyWkNPd1A3bFA2NnNk?=
 =?utf-8?B?S3VkNFFzTGVDL2lVWjZBUjdtWkIzSjhZclFZZHFZODBINHUvbGE2N09PdGM3?=
 =?utf-8?B?V3dCRUdyNXBrRW5lcXB5OXFybThPK3d1akhLcEIxeklEZ3R5OXVwVTZZSGpa?=
 =?utf-8?B?NjE4T1VyNmxGYXNFUEVLZ3l6RTJEaURsMXN6bmdDcG5nMUM1RE1NY2l3WklJ?=
 =?utf-8?B?Z0p4SGFrZEFweUxIQTZud24vZy83azNZdkNVR0lWMUJBR3l6bEZwRDJaSThy?=
 =?utf-8?B?b3hseXFicjVxbS9zUlBMcWNpYWNQSzBDY3RlTldYMlV2UUxCS3dpd3JQM1pa?=
 =?utf-8?B?eEVBWjZYSFlWeWMzSHlGMW83WHc0UkU2OU9WeXZGL3NmdTg4VEdvbzlPZ0Fp?=
 =?utf-8?B?RkZoNlRzbG1hOWFaL2gxOFFTOGtpUnZOSFh3QmFvTy9PYVVLYTc0bXR3cE1U?=
 =?utf-8?B?d1FLdGJxbXdVU2FYZi9PMWJFS0JIWm9rSUl3SW9UQ1h5cGxLS1hMOVZVaVMz?=
 =?utf-8?Q?RBXCivQG24vA8FzLPOg+fcmYFuqU47Vv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjF4cXNFSjUxY25uN0pRMEhxUWF2ZFhVamVvUlJCTnRaM2FvZzBOSDR6RTJm?=
 =?utf-8?B?cFRYUGg2VzhmQXpJeHEzOU1WR0dxYXNjUk93Z1lDdGZHaWltVkhrS0NPaytH?=
 =?utf-8?B?NW5qNEtpVVpKdGdUUGVuZ1FjelhKQVZQMjBPWmVOSTUwbm1qYTFaK1NYckZW?=
 =?utf-8?B?eFUycjFSaDR3WGFlMlp2TDM1b0ZSNFZCRmF1cHNZRHZIcEJPOVdZVE8wLzMv?=
 =?utf-8?B?VVFQbkNDTmxMaTBWYjJFWXp4UHRtUUVZTzZiWkJncEJTTW5Pd3lMeTBlUXVD?=
 =?utf-8?B?MmladENvY2ROdDRkUDZUV3pnc2dJYUxEN2tVSGZjTDhZbmFrd1hxK2l6dXQ4?=
 =?utf-8?B?Q21aN3pqaVpHcUJCMHJJVERkc3dxdlZlVUg3UktUNlZNV1dzK1pmOExmODNG?=
 =?utf-8?B?bUx2aktZZ21QY2hLU1MxLzl6N3paSm8ybkxRM2tESjc3SzB3SGJ0VlZOR01U?=
 =?utf-8?B?cytMV3Y4cG9oUzgyQVlpMWp1bVVxTWxzRnJIR2RwRVlEQ09HVlB3QzE4aW9p?=
 =?utf-8?B?dG1RNnQ3NzdFditvK1BSVG9yVlhLcDJCMWVRZ0Rtb2Z6aU9uMXFMTDJZWUtN?=
 =?utf-8?B?QWNwcGl5OXFJK2RGbVZtTXY0NGhWMDZ0WTREQUY0VEJ0ZDRwazcyR24wYVpX?=
 =?utf-8?B?YVdMNlBCeEFrcUhaWUhtb2VZazdvYUlpNFRvY2VYc1RyckJiYkZiK3dhRHlD?=
 =?utf-8?B?N3VVRzJ2MG5CcTFjK1FVbElwbWVnZlcxYjNZZ2ZOVWlqUnJWWVRrS1ZXei8y?=
 =?utf-8?B?TVYvdkpBYlMrdy9zUFIvcEkwWDhkY3l4cHhzbGpNL1R0UjhoeW1VY1F6VUgy?=
 =?utf-8?B?OUI5bDNjY1VYdmpCZDhBMXFwMER0bnRpV0pFM2RZRHkxSHgwMG9wNFUyTDU5?=
 =?utf-8?B?UFIwZmhFbmxXc1lZS3l0VFVzWExxOUoycllINk15RFBDRmZDYzh6T1c5SG5h?=
 =?utf-8?B?ODJMdUtqZVdpMjZiMHRzdG80Z0tCbU5ZRDFqZ1Z3QnZkbitaaVZNNUxNcjEr?=
 =?utf-8?B?cmllQTh4OWFzSXNUWTUvYTVVWnJjQ3Mvc3cwMDdnVlNzNG5SekQ1ODlEWGFE?=
 =?utf-8?B?S2NQUGxtRUQzbmZTakd4d2tjTnlqUE9yckh0WlkxZWczVXZKWWRHd0NHb3JP?=
 =?utf-8?B?bGZjMUlQWWNmTkhGZmVZTmZ0SEtoM2xEU3d0dkNFN1BXeUFSRVVQdHAzRlVI?=
 =?utf-8?B?MnhrWFBMQ2ZuR1ZMT3p6RzBBY1Y0SHZNRmc2ZXV5MFVOZjZlUGtQc2RHaTVr?=
 =?utf-8?B?dHVsVzJnNzRIZUhobmlDWEErWnEyeFY4c1ViQ3BBWllHbk1rdmdqTHY1NUZC?=
 =?utf-8?B?YlY3a2dJYWpaYlIzRXBNZFo3UVV4RTFpWjJIVFpkUE40bVFIYndpQ3lPY2FD?=
 =?utf-8?B?QncrRllxS0Z1dkFOTHA5anpzSVAzd1Z1TG9tQ2JHOUE3SFV2UjRYVzNBK2NN?=
 =?utf-8?B?Z2l3MmtBcGpxZzhZemRsN201ZnhNY0svYXg4S0c0enZmdmxaNHZ1L2xMWUNy?=
 =?utf-8?B?dkhFYnJOd3g1Q1B4MHBSS2hrNUEyR1JDZmF0VnBXZW9LcXEyYWliSDNNR2NG?=
 =?utf-8?B?OGNtOGM2Rm4rWW02c0tkRk9sTEVmZ0JWajZnRUdIeXB6WnlRa1A5eGhhQU5Q?=
 =?utf-8?B?N21pN3dkbjdYRmhxZ2pqOHFtMysrN0paQzhkV2c5b2NzSGQyV25PM09zN3Bu?=
 =?utf-8?B?ZUtLV2lMNFZlV3FNeWR1V3BEeWhBQjAvaUQxYTBia01udW1kdTE1OEVBRVlZ?=
 =?utf-8?B?NTdGcUR1YXN3b29XazVpY083UlRxZ3Z1OTdMem1BdXg1VTVCVkt1SmI4OEk2?=
 =?utf-8?B?MlEzaHVTNTNzODJxY2xPcmVTdkdiQ1VIU1NJMUxsNzd5RVhYVGtQcjdRSFVJ?=
 =?utf-8?B?WU9nZlRSSGQyZGhlbzNmbTlGR3RSckZnVkJ5MEZSdFFSR1VLOGRYNHlMVnJ3?=
 =?utf-8?B?SkRGNXZTQ21BQnA5dDBTNEUrYzA4RzhwR2UwSlQrd2E0MnphUUJQKzhIeS9v?=
 =?utf-8?B?NHd0ZjFEdkJDT0pJUHhlT0g4RlBFOTA2MUtVTXdhbXlCaWdGcklBUVRQdFNl?=
 =?utf-8?B?MVJDcHRlZWNtREM1VmVqcUp5YUNzSStMOWhFNlk5SDVPNFdJNkcyd0tVVC9X?=
 =?utf-8?Q?CII2WH+7G1uysoiIQBrzEPgwe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D240EB116F41954080277EB20E0DD5B6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05859a33-de38-4b5d-dbe6-08dd4c01e78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 07:42:01.9416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wOgXQmA+eHbQSteaonLLrLTj7hXRWzZx+VTVJDu3aeRv9o9ET9iCxsv48WPeK0IBOp8Ipgs0Px3rL+KF5B1//w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8061

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjMzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBNb3ZlIHRoZSBDRUMgZGV2aWNlIHBhcnNpbmcgbG9n
aWMgdG8gYSBuZXcgZnVuY3Rpb24gY2FsbGVkDQo+IG10a19oZG1pX2dldF9jZWNfZGV2KCksIGFu
ZCBtb3ZlIHRoZSBwYXJzaW5nIGFjdGlvbiB0byB0aGUgZW5kDQo+IG9mIG10a19oZG1pX2R0X3Bh
cnNlX3BkYXRhKCksIGFsbG93aW5nIHRvIHJlbW92ZSBnb3RvcyBpbiB0aGlzDQo+IGZ1bmN0aW9u
LCByZWR1Y2luZyBjb2RlIHNpemUgYW5kIGltcHJvdmluZyByZWFkYWJpbGl0eS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5v
LmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19oZG1pLmMgfCA4MiArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4gaW5kZXggNjE0MGI1NWMyODMwLi4wM2I1NjU4
OGZjN2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jDQo+IEBAIC0xMzY3
LDIwICsxMzY3LDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2JyaWRnZV9mdW5jcyBtdGtf
aGRtaV9icmlkZ2VfZnVuY3MgPSB7DQo+ICAgICAgICAgLmVkaWRfcmVhZCA9IG10a19oZG1pX2Jy
aWRnZV9lZGlkX3JlYWQsDQo+ICB9Ow0KPiANCj4gLXN0YXRpYyBpbnQgbXRrX2hkbWlfZHRfcGFy
c2VfcGRhdGEoc3RydWN0IG10a19oZG1pICpoZG1pLA0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICtzdGF0aWMgaW50
IG10a19oZG1pX2dldF9jZWNfZGV2KHN0cnVjdCBtdGtfaGRtaSAqaGRtaSwgc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiAgew0KPiAtICAgICAgIHN0cnVjdCBk
ZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+IC0gICAgICAgc3RydWN0IGRldmljZV9ub2RlICpu
cCA9IGRldi0+b2Zfbm9kZTsNCj4gLSAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKnJlbW90ZSwg
KmkyY19ucDsNCj4gICAgICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpjZWNfcGRldjsNCj4g
LSAgICAgICBzdHJ1Y3QgcmVnbWFwICpyZWdtYXA7DQo+ICsgICAgICAgc3RydWN0IGRldmljZV9u
b2RlICpjZWNfbnA7DQo+ICAgICAgICAgaW50IHJldDsNCj4gDQo+IC0gICAgICAgcmV0ID0gbXRr
X2hkbWlfZ2V0X2FsbF9jbGsoaGRtaSwgbnApOw0KPiAtICAgICAgIGlmIChyZXQpDQo+IC0gICAg
ICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBnZXQg
Y2xvY2tzXG4iKTsNCj4gLQ0KPiAgICAgICAgIC8qIFRoZSBDRUMgbW9kdWxlIGhhbmRsZXMgSERN
SSBob3RwbHVnIGRldGVjdGlvbiAqLw0KPiAgICAgICAgIGNlY19ucCA9IG9mX2dldF9jb21wYXRp
YmxlX2NoaWxkKG5wLT5wYXJlbnQsICJtZWRpYXRlayxtdDgxNzMtY2VjIik7DQo+ICAgICAgICAg
aWYgKCFjZWNfbnApDQo+IEBAIC0xMzk0LDY1ICsxMzg2LDY5IEBAIHN0YXRpYyBpbnQgbXRrX2hk
bWlfZHRfcGFyc2VfcGRhdGEoc3RydWN0IG10a19oZG1pICpoZG1pLA0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FUFJPQkVfREVGRVI7DQo+ICAgICAgICAgfQ0KPiAgICAgICAgIG9mX25vZGVf
cHV0KGNlY19ucCk7DQo+IC0gICAgICAgaGRtaS0+Y2VjX2RldiA9ICZjZWNfcGRldi0+ZGV2Ow0K
PiANCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIFRoZSBtZWRpYXRlayxzeXNjb24taGRtaSBw
cm9wZXJ0eSBjb250YWlucyBhIHBoYW5kbGUgbGluayB0byB0aGUNCj4gICAgICAgICAgKiBNTVNZ
U19DT05GSUcgZGV2aWNlIGFuZCB0aGUgcmVnaXN0ZXIgb2Zmc2V0IG9mIHRoZSBIRE1JX1NZU19D
RkcNCj4gICAgICAgICAgKiByZWdpc3RlcnMgaXQgY29udGFpbnMuDQo+ICAgICAgICAgICovDQo+
IC0gICAgICAgcmVnbWFwID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZShucCwgIm1l
ZGlhdGVrLHN5c2Nvbi1oZG1pIik7DQo+IC0gICAgICAgcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91
MzJfaW5kZXgobnAsICJtZWRpYXRlayxzeXNjb24taGRtaSIsIDEsDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJmhkbWktPnN5c19vZmZzZXQpOw0KPiAtICAgICAg
IGlmIChJU19FUlIocmVnbWFwKSkNCj4gLSAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIocmVn
bWFwKTsNCj4gLSAgICAgICBpZiAocmV0KSB7DQo+IC0gICAgICAgICAgICAgICBkZXZfZXJyX3By
b2JlKGRldiwgcmV0LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHRv
IGdldCBzeXN0ZW0gY29uZmlndXJhdGlvbiByZWdpc3RlcnNcbiIpOw0KPiAtICAgICAgICAgICAg
ICAgZ290byBwdXRfZGV2aWNlOw0KPiAtICAgICAgIH0NCj4gLSAgICAgICBoZG1pLT5zeXNfcmVn
bWFwID0gcmVnbWFwOw0KPiArICAgICAgIGhkbWktPnN5c19yZWdtYXAgPSBzeXNjb25fcmVnbWFw
X2xvb2t1cF9ieV9waGFuZGxlKG5wLCAibWVkaWF0ZWssc3lzY29uLWhkbWkiKTsNCj4gKyAgICAg
ICBpZiAoSVNfRVJSKGhkbWktPnN5c19yZWdtYXApKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJu
IFBUUl9FUlIoaGRtaS0+c3lzX3JlZ21hcCk7DQo+ICsNCj4gKyAgICAgICByZXQgPSBvZl9wcm9w
ZXJ0eV9yZWFkX3UzMl9pbmRleChucCwgIm1lZGlhdGVrLHN5c2Nvbi1oZG1pIiwgMSwgJmhkbWkt
PnN5c19vZmZzZXQpOw0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1
cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJGYWlsZWQgdG8gZ2V0IHN5c3RlbSBjb25maWd1cmF0aW9uIHJlZ2lzdGVyc1xu
Iik7DQo+ICsNCj4gKyAgICAgICBoZG1pLT5jZWNfZGV2ID0gJmNlY19wZGV2LT5kZXY7DQo+ICsg
ICAgICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgbXRrX2hkbWlfZHRfcGFy
c2VfcGRhdGEoc3RydWN0IG10a19oZG1pICpoZG1pLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICt7DQo+ICsgICAg
ICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gKyAgICAgICBzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0KPiArICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqcmVtb3RlLCAqaTJjX25wOw0KPiArICAgICAgIGludCByZXQ7DQo+ICsNCj4gKyAgICAgICBy
ZXQgPSBtdGtfaGRtaV9nZXRfYWxsX2NsayhoZG1pLCBucCk7DQo+ICsgICAgICAgaWYgKHJldCkN
Cj4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiRmFpbGVk
IHRvIGdldCBjbG9ja3NcbiIpOw0KPiANCj4gICAgICAgICBoZG1pLT5yZWdzID0gZGV2aWNlX25v
ZGVfdG9fcmVnbWFwKGRldi0+b2Zfbm9kZSk7DQo+IC0gICAgICAgaWYgKElTX0VSUihoZG1pLT5y
ZWdzKSkgew0KPiAtICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihoZG1pLT5yZWdzKTsNCj4g
LSAgICAgICAgICAgICAgIGdvdG8gcHV0X2RldmljZTsNCj4gLSAgICAgICB9DQo+ICsgICAgICAg
aWYgKElTX0VSUihoZG1pLT5yZWdzKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJS
KGhkbWktPnJlZ3MpOw0KPiANCj4gICAgICAgICByZW1vdGUgPSBvZl9ncmFwaF9nZXRfcmVtb3Rl
X25vZGUobnAsIDEsIDApOw0KPiAtICAgICAgIGlmICghcmVtb3RlKSB7DQo+IC0gICAgICAgICAg
ICAgICByZXQgPSAtRUlOVkFMOw0KPiAtICAgICAgICAgICAgICAgZ290byBwdXRfZGV2aWNlOw0K
PiAtICAgICAgIH0NCj4gKyAgICAgICBpZiAoIXJlbW90ZSkNCj4gKyAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiANCj4gICAgICAgICBpZiAoIW9mX2RldmljZV9pc19jb21wYXRpYmxl
KHJlbW90ZSwgImhkbWktY29ubmVjdG9yIikpIHsNCj4gICAgICAgICAgICAgICAgIGhkbWktPm5l
eHRfYnJpZGdlID0gb2ZfZHJtX2ZpbmRfYnJpZGdlKHJlbW90ZSk7DQo+ICAgICAgICAgICAgICAg
ICBpZiAoIWhkbWktPm5leHRfYnJpZGdlKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRl
dl9lcnIoZGV2LCAiV2FpdGluZyBmb3IgZXh0ZXJuYWwgYnJpZGdlXG4iKTsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQocmVtb3RlKTsNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgcmV0ID0gLUVQUk9CRV9ERUZFUjsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZ290
byBwdXRfZGV2aWNlOw0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVQUk9CRV9E
RUZFUjsNCj4gICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIGky
Y19ucCA9IG9mX3BhcnNlX3BoYW5kbGUocmVtb3RlLCAiZGRjLWkyYy1idXMiLCAwKTsNCj4gICAg
ICAgICBvZl9ub2RlX3B1dChyZW1vdGUpOw0KPiAtICAgICAgIGlmICghaTJjX25wKSB7DQo+IC0g
ICAgICAgICAgICAgICByZXQgPSBkZXZfZXJyX3Byb2JlKGRldiwgLUVJTlZBTCwgIk5vIGRkYy1p
MmMtYnVzIGluIGNvbm5lY3RvclxuIik7DQo+IC0gICAgICAgICAgICAgICBnb3RvIHB1dF9kZXZp
Y2U7DQo+IC0gICAgICAgfQ0KPiArICAgICAgIGlmICghaTJjX25wKQ0KPiArICAgICAgICAgICAg
ICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAtRUlOVkFMLCAiTm8gZGRjLWkyYy1idXMgaW4g
Y29ubmVjdG9yXG4iKTsNCj4gDQo+ICAgICAgICAgaGRtaS0+ZGRjX2FkcHQgPSBvZl9maW5kX2ky
Y19hZGFwdGVyX2J5X25vZGUoaTJjX25wKTsNCj4gICAgICAgICBvZl9ub2RlX3B1dChpMmNfbnAp
Ow0KPiAtICAgICAgIGlmICghaGRtaS0+ZGRjX2FkcHQpIHsNCj4gLSAgICAgICAgICAgICAgIHJl
dCA9IGRldl9lcnJfcHJvYmUoZGV2LCAtRUlOVkFMLCAiRmFpbGVkIHRvIGdldCBkZGMgaTJjIGFk
YXB0ZXIgYnkgbm9kZVxuIik7DQo+IC0gICAgICAgICAgICAgICBnb3RvIHB1dF9kZXZpY2U7DQo+
IC0gICAgICAgfQ0KPiArICAgICAgIGlmICghaGRtaS0+ZGRjX2FkcHQpDQo+ICsgICAgICAgICAg
ICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIC1FSU5WQUwsICJGYWlsZWQgdG8gZ2V0IGRk
YyBpMmMgYWRhcHRlciBieSBub2RlXG4iKTsNCj4gKw0KPiArICAgICAgIHJldCA9IG10a19oZG1p
X2dldF9jZWNfZGV2KGhkbWksIGRldiwgbnApOw0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiANCj4gICAgICAgICByZXR1cm4gMDsNCg0KcmV0dXJu
IG10a19oZG1pX2dldF9jZWNfZGV2KGhkbWksIGRldiwgbnApOw0KDQpvcg0KDQpyZXQgPSBtdGtf
aGRtaV9nZXRfY2VjX2RldihoZG1pLCBkZXYsIG5wKTsNCg0KcmV0dXJuIHJldDsNCg0KQWZ0ZXIg
dGhpcywNCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gLXB1
dF9kZXZpY2U6DQo+IC0gICAgICAgcHV0X2RldmljZShoZG1pLT5jZWNfZGV2KTsNCj4gLSAgICAg
ICByZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4gIC8qDQo+IC0tDQo+IDIuNDguMQ0KPiANCg0K

