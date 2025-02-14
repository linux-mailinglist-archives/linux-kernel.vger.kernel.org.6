Return-Path: <linux-kernel+bounces-514291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28FFA3552B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C29957A4589
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8D15198C;
	Fri, 14 Feb 2025 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EjfGCvWz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bkxEWtmU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787EC2753FD;
	Fri, 14 Feb 2025 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739502245; cv=fail; b=tcGBQuv7ltJQ2uejSwdNoMxnZgIlY7kYlnsMHn0vwT6cEsd0blqYvZCJwOlVmqeKdA8nb6+gSdXVqfoR1XPNnLCXnbp/YZ3UNaGfj1swsqNfuq1qB1JS2Dkb51e+RrEqPuppFCL+1XxqLudSz9P8kq1ixiWaT4HkjtK9+CgbYsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739502245; c=relaxed/simple;
	bh=3NefPelYWMOZIMXl8NTpvJGLlU95R/fh9sN2SSGAKtY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YNknOmSF+QCR5CNsRa+G5r7S/cIMH5uA+mBUACDbREFV4ETuUDF0a/OIURJFRrGLHGY5zmSNBRRxa6OnBXofFoa+PhCUyS7BX7BTPGTBp4ZU8irNDEZ5sRda95j0xhc/XPYd6169OhyE9OH+8PLc31oAYXbCwb3sU2AnuVX1j0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EjfGCvWz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bkxEWtmU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 548d3da2ea8011efb8f9918b5fc74e19-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3NefPelYWMOZIMXl8NTpvJGLlU95R/fh9sN2SSGAKtY=;
	b=EjfGCvWzE4QzgCWeVp88E6QZNt0mc4tOmQoAeXk5Z1SELr6U5bdNlOpl1A4Vmw3KPFwI4tmpuC4/3hWc9HJ1nVmcIv/qeCtA9AXCJW8/fP002xbS3CqL24bJSUlH2TN+IqNRuR9khjhPanzmfejmD0J5a7XXbRwUXAxJlMMC7Fc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:f4422839-de96-4958-bcf9-ddf9349a4829,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:07f68c27-6332-4494-ac76-ecdca2a41930,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 548d3da2ea8011efb8f9918b5fc74e19-20250214
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1172601473; Fri, 14 Feb 2025 11:03:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 11:03:55 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 11:03:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVIamS+gdgxjqJI6u6SRmRzUmKpuoB76pDOxai6ytDfc42f19A/Or9qzMsk2jnwUDsHvCyaaPf62WKcMll6j/JWIOD75zOU4Qirp0G9j04LopsZ9wYr9LrTx+9GJs1OBc1HVEKuZyuDwWuwzEm9ZVIkB14Xq2ZJotdyHke8uJXvh2kkQ4XnpLVvVuHiXETL2YNinoHmftlPjdmw5kPq44ICe0+2EycRz0mTfNgsHmnB8SgvR1aalEU5CYi2ce/o2CThQ6e2Orn4k/bHwdaGUwOohL7r4fXicuhHbpAWGOnlKbQhlQUY+oG2HDTr/9HkDc0pe0yBneYOLaG9/kq/qAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NefPelYWMOZIMXl8NTpvJGLlU95R/fh9sN2SSGAKtY=;
 b=vbik0cmrorrpkl3/w2IveDgNqVjIpvud0NLFER4+WhheuBQCeKubYPyQhFLNziC7JDWaPgwzv9PD2I7RozIzsCyKQbo9lV+xCpO2u5kb9b4BbLdfxYuQVwkq4p7zSjR+9vnbccNwXOy1qEmrP0si3WpCpQJWB9yRSwvfKEmkl/j74E02KgkcxgaJvJOWh3egFrMTRXCr/oKp1wDQqgjg9ZQp8T3Mgp6qy+Kj8d/4HnENiDBbRLWiXpYgaX8Qi3vId2Ujso0/dupwnathhwo0js2+THS8aILTA6Z6mUcXBqtos4nzwcpL6/rh/4TIcXyMcDoGTb+wH/8NUfR65zHRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NefPelYWMOZIMXl8NTpvJGLlU95R/fh9sN2SSGAKtY=;
 b=bkxEWtmU1QrAgJNnkdwH9V6YpLGf5XKNDotU7vcqi3iZlmu/XRAFLtfM2aEhP9sEeOU/xkgPm4SQm1jZWyjgGVMcqsvpWS3quwow/9RgGZFG9Qv2SEtEtCtSbh1zvIHdNvay7Q23ZrmjLwqJu5LEmXX0PhxIxn/ETrifHwlqCy8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7668.apcprd03.prod.outlook.com (2603:1096:400:41a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 03:03:51 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 03:03:51 +0000
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
	<junzhi.zhao@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v6 15/42] drm/mediatek: mtk_hdmi: Convert to
 module_platform_driver macro
Thread-Topic: [PATCH v6 15/42] drm/mediatek: mtk_hdmi: Convert to
 module_platform_driver macro
Thread-Index: AQHbfHksGGbCqeHsQESo3SUjLKkT4rNGITIA
Date: Fri, 14 Feb 2025 03:03:51 +0000
Message-ID: <cda5c16b444038de9bf2a5411d1a963e88a312ba.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-16-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-16-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7668:EE_
x-ms-office365-filtering-correlation-id: 06088990-17f0-4a8d-e8f3-08dd4ca43571
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S3Z4amFVYzFuNDJSV01PVDdEQ2tCSy9lWGZTbkIyMG9qV1pIUklYbS90Z0FX?=
 =?utf-8?B?RUFmb2dRTExrUlRWbU9PNVE2MC9LRE91ZkhhSVVVc25DMlgwNTJxUFRHcHJq?=
 =?utf-8?B?UVByM1diK2lTenFxRG5INXZaMllxUnJESzd3SVpzSE1jeENoL0xqaG1nc3U3?=
 =?utf-8?B?eDlkWkRrUm5WaUx4WVRXSWRsQmhvY29KNXJ6WXp2cm1Kc1MrRTR2MElsNTlV?=
 =?utf-8?B?WDVKZ1RhQXRsK3owL2UzSUJQa0lYZU10QXpVaVpMVkRWTEpGRFc2WmRNK0JW?=
 =?utf-8?B?cjZ4UFhxVUYzaWxWeFVQS0ZaWGVUajBkYXphanNRa3hoSEJBbXVtMCtKZ29R?=
 =?utf-8?B?anhTNnBSZUJDOTNGM3lvTGkrVnJJODRodUNaN1VzT1MxQUNUWkVPS2J3cEZh?=
 =?utf-8?B?eXphYU5ocEZ5OUlUMG1may9BTU1ZaUJ0SzUxckZuMDJjNEZ1eUk0U01lQnRF?=
 =?utf-8?B?NEZqWUpRTU9JZVdCcHJncGVDd0Y1MDF3QkVBaE5Wbzk1TWtFd2pNMmJVRFR2?=
 =?utf-8?B?OTNncm1ad21sNEc3NHFoWFNDQUpncUlBdDFDMzc1UFFqa1E5Y3l4Z2hVVlZu?=
 =?utf-8?B?aE1qM2tsQVYvOVZMRjErNDg3dDR0a3N1Vmk2OEVPTGF1Zzh1MTEwNklPSGhV?=
 =?utf-8?B?SUhZMy9oWFF4cDBaZGdnT2xkUy9NVVYyd09uWjFSWVRKR0xSRWxTS3drZ0Jx?=
 =?utf-8?B?dTN0OE5sN1BJNDZJUEdTMXp3Q0RNc2NqNXEvSlEraytYbjlkU3BCNW1kMXIy?=
 =?utf-8?B?T1Q4S2FqOU96NVVsWVNzWTFwQUYrUkFlTGpNeUljS3RvYklleVNleERENlJB?=
 =?utf-8?B?Slp1QnFoa09aQzFjTUduMU40Sm95blkwR0QvdW0zTThyRGpJRnl3K2Z1TlQ1?=
 =?utf-8?B?c2d1V04rYXRaS2ZLalVmVmZzajZTWGFXeWFjUk9LNncrN0dUV0x3c0ZwVzlh?=
 =?utf-8?B?ZUhKTE1nYU5vWXFEK0JKZ1h4TytQakdyTEtIc3VCQzJKM01jWStRTWFGMTM3?=
 =?utf-8?B?VFp3bDRwZTNZVmg3YnhYQUdlR1ZDTW9iMXNNeDREVWtOaCs4cHhVQU4xSFFq?=
 =?utf-8?B?ZWRVdDJvM1ViOWpIRzJkWi8wbUVqWjU4T0VzSEw5UEZlMlZJaGR2OEU0NXpC?=
 =?utf-8?B?SDFuWWRGQ3hjbWF3dXlCdVBTZWhtUklEU0E5aEZCLzJDMWY0bWtHcnFNT3ZB?=
 =?utf-8?B?bVA1YlV6S2FCMm1FVlZiYW55VUo2UHcybUNrZlhvOHhobHVJRUVpeFJhYndh?=
 =?utf-8?B?dFZwamNZSkxmbENtZDRFUHN4ZDllMnY0ZzNCUWtyVmtLUTNGRk0vZjR1T2VN?=
 =?utf-8?B?UExDdGtpMUpxb0lrb1NTNCtvZGxHcjJjZ2twL3ZuN1NVQjZpZXpuemRBS0RS?=
 =?utf-8?B?KzA2M0lZZUF5ZXY2L3R3YWxmbDNPZElzR3dFSXZ4TXRPZGNDZVFjclZWbVJI?=
 =?utf-8?B?TWtNZ0ZHenNkbTlUOXZaa2ZDZmlRMFo0aHJEZ1FwQzFoNmcreU9jMXlQdDFF?=
 =?utf-8?B?STRwN3hwdUJnSERaQkRSSUM4aW1xNk1KS2Y1ZDNPTGFmaUgrbzFuSjdHNXpp?=
 =?utf-8?B?ZzFKNzVTZk1COTl5UXdlV2xhYW1uYjhDL1hva1JQY2d2QXNMNElmWitUV1d1?=
 =?utf-8?B?NUJZRVg0UVM1MUNIeWw0ZEZEbzBUMTBST0llUTFzdUNiVk5lUTBZT3JaN25T?=
 =?utf-8?B?SnVzTmpoTm5HNUJsU1dZYkFHUmxZL2VLZDZoNFNjS1NzS2NzOHQrUnJuM2pw?=
 =?utf-8?B?TlQ1bnUyNGZWS3VISSs2OWttNHJtVGxPdHovR0dTRE14Q2JtWDJOTHZMU2lF?=
 =?utf-8?B?RE1kODlGUFdCMXJwcEFRdVNzZmFnV053TWVSS2taRGlFZzQ4YTFITXJRNjdx?=
 =?utf-8?B?SkJGbUJWUUtqM1dINW0ydUJNdkhYMnNQa3ZFUkk3ZjRIdUhxRHNiNEtKSmh6?=
 =?utf-8?Q?n27kDzr1mVqEoa1xGhGaATYq4uS9H0m0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emdTcDRUT2lLSkxJZXZMTi9FQXJFWU5LcFpJSmJTNndqMTBFeFRWVVlMTlpI?=
 =?utf-8?B?MWFieGEwMlRLaUJUNDB5cEwxZVQ0S3hVMzBkeEtqdk01NGFKL0kxcmpxM1pQ?=
 =?utf-8?B?cUdjaE5qOTNvc01hcFdsWUtUdUxpemVUNm5VRU5wM0ViTEl6M3JmbDRiWDlH?=
 =?utf-8?B?bEpJVFIza1pSM2E0ZE42REpIajB5N2VCblVaTXNWc1VSS0gwL2F0bURPWTBp?=
 =?utf-8?B?eS84TnpJT1dUMGsxeWtSaS91SDArSGZ3b0RhbVk3cVBJSDZ6eFpFTXdZaHFX?=
 =?utf-8?B?K2VwQlRqWHhmR2czV0llWDQzMHBGSnFnOThJYXphM3A5UzV6TmZCNDFVWml6?=
 =?utf-8?B?UitwclFxUWR0NUFmaEhTSElmdXJtT2VvdThmUFJJMzRlY3M4QnY5TXlGOFo5?=
 =?utf-8?B?RnBORGJ1ZlIxUGk0M3JOaXhlcTIyZmxOWFlpWE5od1lhZHB6U2Z4ZWRwTWJa?=
 =?utf-8?B?amFCYnlGYjZPVGtwbE5GTnV0eHUydHRiYjBpQitTWm5QclRJalN5RXBsY1dI?=
 =?utf-8?B?Z1Fqd1FVTU9RVCtkeFIrLzhtWDF5UWdmUDIvTk9yTHVBeFdYVTI1M1hzVFF0?=
 =?utf-8?B?NUpETlUrYjVOZ3hydmZQSm9sSzFsZ2x4RlRYZXlqREhNbHNwdDE3T2U5R29D?=
 =?utf-8?B?cDh1OHRWSDBsV2hIWHUyUTZuVHJSUSs2cG9RejlFQThZZzl3eW9lVjVEazVu?=
 =?utf-8?B?UXdveUNoYnU0WU1mRTNUWWV4UmI5akl5Rjh4dFhPL0ZlZE1KWEJZT2ZwckZY?=
 =?utf-8?B?MVRaREszc1BUQkE5aFFvQnpacUdJTk54Z1pUTk9GZWxZM2JiOFh5ZngwOHps?=
 =?utf-8?B?NU9sSlNEZlZTODh1UzZpd3JSM3ZINk5jS2dMV2RUSlZnYjEvRmFrUWFIMTN5?=
 =?utf-8?B?V2l1QjdCYVZKdHZJUGNyMGZUV0JaU2tqNTZyUEI4eU5rbGFQYnMrTnRiWTlP?=
 =?utf-8?B?RkxLQmRLSmMvaFNqdU5pRmpWZlpNa0llblZ5eERhK1JUbW9BUGtJUytUWVV1?=
 =?utf-8?B?REI4NGhtZlNSdmxXaldmNTVRTVBpa1lXbTJwMVcxKzRES0JFWlpPWVRubU1K?=
 =?utf-8?B?TkNjYWRTUll4MXFpMmZrYzZPZkhja1V3UHBBWlRKQTl2TVB1YWFENklFUXpJ?=
 =?utf-8?B?N1g2a3E2VXYybUpDbURpbTFZRDMwYndGanRnZDB6SHB0ZjVIZDZFWGZ4RjAv?=
 =?utf-8?B?SFJBRUl4QXlERTlVOGk5aFVNa2hDVHRjc2RKREZDUFFhcVRiSVc4U09UdzBP?=
 =?utf-8?B?VzVXbm1jd01MZDV6Qjc2TnpyY3RETVRuOWQ1SGNDSFUzS1Y0aDhHajR2NTJr?=
 =?utf-8?B?aTBQWmxBNkJjbXp0OWttcFl6d0xqN3psUndJclkxNy9DUmhqNzErcDQ1K1hC?=
 =?utf-8?B?c2FKZHNaVHlleVVYVFlUdXFVVDIwT0xSb0pHSjV6eHFFbGhJNGZtU3ZHbGYr?=
 =?utf-8?B?VjBSSG0yV0xvczNDR1F6Z0ROZzZtWU94YitwY00xZFEyam1XZ1dHNHlVK2d4?=
 =?utf-8?B?TTJKUHlEOWtYVS9iMWxvdTF4MGZkSkgwWDNiVDMrWkVTYWxFdEJnYnhjdXdD?=
 =?utf-8?B?WVVWTGJxcGp3dVVrcHB4Zm5xdlNtQjNNbzJhRkIyL0Y4ZVlOOVNSSitjM1Zq?=
 =?utf-8?B?ZmQ4WVpaMWUyUmg4ZDhFZFVBTnZJNlFoT2hZYjh4eGhiTXhzYzY1TXRjUjVo?=
 =?utf-8?B?SVJpendsN2RHY3VFcm5Odi84QlBGTUc0UFZHY2tWaExoR2d5YVVOUkkxdGd3?=
 =?utf-8?B?VEQ0c2JtMGM1L21iVFBqUi9KbmV6cERNNDl3cXZFYVNaQnFsbXlXZ3AvZ0V6?=
 =?utf-8?B?c29pdG83WXAwNHl0QTJwYzAzZGI1VzRrN1VpcFdYSWJVTXhNWTVFMHRZVlJS?=
 =?utf-8?B?blVtT2JMb1Y4Q1JmbjNJeTB3R0huM3d3RVRmSnVKL290dGRzVy9XTXp0T0FQ?=
 =?utf-8?B?c242QS9tU2ErSllianhiMldaNE5sUkZTQzRxMFk0WTkyeXZXMjRnTld5SW9E?=
 =?utf-8?B?Tk90NWU0MXVrMEo0eUhuR1dTcWxsUDhHWDNWT25KY2k5OEY5NlQ3OFo4Undm?=
 =?utf-8?B?c2pESHJJTDNRMnpjNmt3MUF3L0doUjhQV1QvWWdZMXcyekZaUmJEd3A3OXJ0?=
 =?utf-8?Q?byR0OXisqTOO98ts70dDgn9oj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <455D9D08F6D58A4AB81A6F26AF79D43E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06088990-17f0-4a8d-e8f3-08dd4ca43571
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 03:03:51.1120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riuyyjau4f71zkBFj2fkItIPrCj96FV8QwKz0M/n/D+104HN3uk1DSftLzwe/lu1A4EnkllWrOcz6QDrS2fiUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7668

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjMzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBOb3cgdGhhdCBhbGwgb2YgdGhlIG10a19oZG1pIHN1
YmRyaXZlcnMgYXJlIGEgcGxhdGZvcm0gZHJpdmVyIG9uDQo+IHRoZWlyIG93biBpdCBpcyBwb3Nz
aWJsZSB0byByZW1vdmUgdGhlIGN1c3RvbSBpbml0L2V4aXQgZnVuY3Rpb25zDQo+IGluIHRoaXMg
ZHJpdmVyIGFuZCBqdXN0IHVzZSB0aGUgbW9kdWxlX3BsYXRmb3JtX2RyaXZlcigpIG1hY3JvLg0K
PiANCj4gV2hpbGUgYXQgaXQsIGFsc28gY29tcHJlc3Mgc3RydWN0IG9mX2RldmljZV9pZCBlbnRy
aWVzIGFuZCByZW1vdmUNCj4gc3RyYXkgY29tbWFzIGluIG10a19oZG1pX2RyaXZlciBhc3NpZ25t
ZW50cy4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4YW5kcmUgTWVyZ25hdCA8YW1lcmduYXRAYmF5
bGlicmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8
YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jIHwgMzcgKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRt
aS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4gaW5kZXggZTY0OGZi
NTcxNGU3Li5hNTQ3MWFiZjE2ZGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfaGRtaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRt
aS5jDQo+IEBAIC0xNzgwLDE1ICsxNzgwLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2hk
bWlfY29uZiBtdGtfaGRtaV9jb25mX210ODE2NyA9IHsNCj4gIH07DQo+IA0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2hkbWlfb2ZfaWRzW10gPSB7DQo+IC0gICAgICAg
eyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtaGRtaSIsDQo+IC0gICAgICAgICAuZGF0
YSA9ICZtdGtfaGRtaV9jb25mX210MjcwMSwNCj4gLSAgICAgICB9LA0KPiAtICAgICAgIHsgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTY3LWhkbWkiLA0KPiAtICAgICAgICAgLmRhdGEgPSAm
bXRrX2hkbWlfY29uZl9tdDgxNjcsDQo+IC0gICAgICAgfSwNCj4gLSAgICAgICB7IC5jb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE3My1oZG1pIiwNCj4gLSAgICAgICB9LA0KPiAtICAgICAgIHt9
DQo+ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtaGRtaSIsIC5kYXRh
ID0gJm10a19oZG1pX2NvbmZfbXQyNzAxIH0sDQo+ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxNjctaGRtaSIsIC5kYXRhID0gJm10a19oZG1pX2NvbmZfbXQ4MTY3IH0sDQo+
ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtaGRtaSIgfSwNCj4gKyAg
ICAgICB7IC8qIHNlbnRpbmVsICovIH0NCg0KVGhpcyBpcyBub3QgcmVsYXRlZCB0byB0aGUgdGl0
bGUsIHNlcGFyYXRlIHRoaXMgdG8gYW5vdGhlciBwYXRjaC4NCg0KPiAgfTsNCj4gIE1PRFVMRV9E
RVZJQ0VfVEFCTEUob2YsIG10a19oZG1pX29mX2lkcyk7DQo+IA0KPiBAQCAtMTc5OCwyOCArMTc5
MywxMCBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfaGRtaV9kcml2ZXIgPSB7
DQo+ICAgICAgICAgLmRyaXZlciA9IHsNCj4gICAgICAgICAgICAgICAgIC5uYW1lID0gIm1lZGlh
dGVrLWRybS1oZG1pIiwNCj4gICAgICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IG10a19o
ZG1pX29mX2lkcywNCj4gLSAgICAgICAgICAgICAgIC5wbSA9ICZtdGtfaGRtaV9wbV9vcHMsDQo+
IC0gICAgICAgfSwNCj4gLX07DQo+IC0NCj4gLXN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVy
ICogY29uc3QgbXRrX2hkbWlfZHJpdmVyc1tdID0gew0KPiAtICAgICAgICZtdGtfaGRtaV9kcml2
ZXIsDQo+ICsgICAgICAgICAgICAgICAucG0gPSAmbXRrX2hkbWlfcG1fb3BzDQoNClRoaXMgaXMg
bm90IHJlbGF0ZWQgdG8gdGhlIHRpdGxlLCBzZXBhcmF0ZSB0aGlzIHRvIGFub3RoZXIgcGF0Y2gu
DQoNCkFmdGVyIGFib3ZlIG1vZGlmaWNhdGlvbiwNCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5o
dUBtZWRpYXRlay5jb20+DQoNCj4gKyAgICAgICB9DQo+ICB9Ow0KPiAtDQo+IC1zdGF0aWMgaW50
IF9faW5pdCBtdGtfaGRtaXR4X2luaXQodm9pZCkNCj4gLXsNCj4gLSAgICAgICByZXR1cm4gcGxh
dGZvcm1fcmVnaXN0ZXJfZHJpdmVycyhtdGtfaGRtaV9kcml2ZXJzLA0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFSUkFZX1NJWkUobXRrX2hkbWlfZHJpdmVycykp
Ow0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgdm9pZCBfX2V4aXQgbXRrX2hkbWl0eF9leGl0KHZvaWQp
DQo+IC17DQo+IC0gICAgICAgcGxhdGZvcm1fdW5yZWdpc3Rlcl9kcml2ZXJzKG10a19oZG1pX2Ry
aXZlcnMsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFSUkFZX1NJWkUo
bXRrX2hkbWlfZHJpdmVycykpOw0KPiAtfQ0KPiAtDQo+IC1tb2R1bGVfaW5pdChtdGtfaGRtaXR4
X2luaXQpOw0KPiAtbW9kdWxlX2V4aXQobXRrX2hkbWl0eF9leGl0KTsNCj4gK21vZHVsZV9wbGF0
Zm9ybV9kcml2ZXIobXRrX2hkbWlfZHJpdmVyKTsNCj4gDQo+ICBNT0RVTEVfQVVUSE9SKCJKaWUg
UWl1IDxqaWUucWl1QG1lZGlhdGVrLmNvbT4iKTsNCj4gIE1PRFVMRV9ERVNDUklQVElPTigiTWVk
aWFUZWsgSERNSSBEcml2ZXIiKTsNCj4gLS0NCj4gMi40OC4xDQo+IA0KDQo=

