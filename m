Return-Path: <linux-kernel+bounces-514377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAE5A3561E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AD116D76D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D023518732B;
	Fri, 14 Feb 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gezkonSO";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AlzJEy5G"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C09210E3;
	Fri, 14 Feb 2025 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739510192; cv=fail; b=BfwEQBb0rQxQursSyU/OiDmuEPuQnYl80qa6dHl2RQwXnz9wTcM5Y6aiS93UMQu9ajGzb92LTatzOTa5so3z1K5PYXw4WWaDLtV/P87nqkXcWqswhCLDrNX9MpDl8i0fRkB6eyKvY0mhHCvb+tL37My46BYE5K4uk3f50vp8Kw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739510192; c=relaxed/simple;
	bh=q8LfJkXWTjfPHQnmR9BefMkw0mZNiAm7494xopEYy/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNuRNQHKs2yvp2SsfypR52othUwCVsbowRpY7q2fI7Xv6WBYRARzlEvel6SXHGjgCIvi1/EBBHFoUYeW/C4DnfYrXcWU4xVKo5pEgw2tMX2FmIJbZLi6hBjNgCQ32Yq3MCjbwjE+viUA5hLEcWlcpFs0W+SJyOtdTuGNeHd2gy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gezkonSO; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AlzJEy5G; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d63238dcea9211efb8f9918b5fc74e19-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=q8LfJkXWTjfPHQnmR9BefMkw0mZNiAm7494xopEYy/I=;
	b=gezkonSOoEgKOh50jLxpki3hKWhrWUdW0GVAhdJcc/w2CuXo1ssNUcn3edU00fPvVq+y95+e8pvQUn9RbNXj91UwTxpLwlSp7i5O9MU/R8xeNDLQntMOLFqHGXM9FoG+kMXZK0bijK5poqNgU6+8a8VSmHcS5VAJ+nE6q2UKHpY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:abac99e4-f256-4204-b17c-9d228b9378d5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:71965b8f-637d-4112-88e4-c7792fee6ae2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d63238dcea9211efb8f9918b5fc74e19-20250214
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1078065804; Fri, 14 Feb 2025 13:16:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 13:16:23 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 13:16:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYTDC46xIL9jpUoULekaz//BXqdbxV6/dmmnJcY89lGuH3a4zQmjF33ns7pQrqGcpperXia/Dl6B+E4kCGGEegaYBFGB7GlpZpEtWdbHNS+CKtSjhGQ5J+pUJN8TgHEI/2OtV75O7gMiBzAFaOEsiPwL4VSQliDt5Xa9NbQrRxCosr5ZFSHdZXRWTLgW1xFqn8zrBdme2LqAdCOpfWFE64RiMoRnSAebzR6PdIxXt+2bQGDrrrD7H8JZBiW9/ZoVVEbbjfVcE+H58HpsxE3uUOkrXDLHjI6LVr7usD45BhF+4e+CbOvC0am+xxzYzZ5pEyU5yG+9Wy84kdreRCXiSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8LfJkXWTjfPHQnmR9BefMkw0mZNiAm7494xopEYy/I=;
 b=VYTDnTVXCyUeiHM2tNCic+Xji7s33SI3/3BCO8XLO9Ks8NkXMrjzuenYt+ECTbyq2Ju6OKTGEZKhIv7oFIFwmeOF8Ljlr4bl0DZp8ipuecezbQiAtxriRERsityTpwoxfa0P3gUDwxOzl7VX6BFfH/YyAUBd11xve9pyB0qrJZ4NxTPWyN6xhKcKtRNU7wMzr8p3u9S6E3MEtWtDv0rkFhWMYLKVeObzjKVAAY9dmd0fVugd1SPEnrPiFzZM14Sfhptvg/sD1xCbDam6/84c+tXNRzROh8NZDLCM0zHZ7GoalO+BEQ/A2G826Hp36n46LOdpV73Db79BLKTlOW2riw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8LfJkXWTjfPHQnmR9BefMkw0mZNiAm7494xopEYy/I=;
 b=AlzJEy5GDtmZ4cuehP/cttZdie97qbYEkYu4462f6poEj2OKMC5GZjkKkZ4SulRy3Wid+YfK+glGAdNcL8ud5yO//Yd4cwRO9fDnlspcmC2NSp94b/VAWsqDDnVUNuFPqKX4WTLJnXf0lE8tQVSA5BChIdzgMgAgf1McFrENDf4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7901.apcprd03.prod.outlook.com (2603:1096:820:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 05:16:20 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 05:16:20 +0000
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
Subject: Re: [PATCH v6 40/42] drm/mediatek: mtk_hdmi_common: Add var to enable
 interlaced modes
Thread-Topic: [PATCH v6 40/42] drm/mediatek: mtk_hdmi_common: Add var to
 enable interlaced modes
Thread-Index: AQHbfHk0osMQ8A2mmkmQ4apvyYRlqbNGRjcA
Date: Fri, 14 Feb 2025 05:16:20 +0000
Message-ID: <591e2ca666dbb382679ecf7c91b2a3d0981af221.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-41-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-41-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7901:EE_
x-ms-office365-filtering-correlation-id: dd849a2c-409b-4c28-dc34-08dd4cb6b7b5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RW15dWZMWjQ1VXl2OGxOamFiUW50VXFDREVQZ1BEMzJYUGZ2NHJDTjBzcVE2?=
 =?utf-8?B?amxoNStMVTJlUzFaa05wRlJrWWk4NWEzWkRrVjI1WXRLenBETlhjRG1EblBE?=
 =?utf-8?B?ZnR0Ris5NU1EM1hCQkRoVUJXQXFRRThRdFdlRU5oT1BGRXNYV3IyZitCaVpr?=
 =?utf-8?B?WDIrbnZCdUErTk5pVGpQQXZFQWl3VkdpY0RBWVE3TEUzSXcydG5qZCthMnZn?=
 =?utf-8?B?N3cwVkl3MGJjVytRRUhjTkdTcjVGTmVaRS8wYkNqQTRDSEhTTVRZS0VERXVF?=
 =?utf-8?B?MTJBeVAvbHJETlVna0pLbXh4SDAwakpCU25zS3BHWTd6SDV4WVExamNSM3FS?=
 =?utf-8?B?emFmS2o1Z25GZURWb2xRUmw3azFKT0Z3MGJEWUdWSzkyRWlRcFprOUhpbElO?=
 =?utf-8?B?dGlJcG1QK3JIS1N6VHlrVm9XWHc5c1FESzVrM2piOGV2bVkzanlibHFpd1Vk?=
 =?utf-8?B?TjZtM2p6Qkkwck4yZ2k0MFNySTZsMXJ4aCtRRzhqdzc0amUvQ3dVdFZTdGF1?=
 =?utf-8?B?MUorMWdSWnprK1hFb3ovU25UZGlMUndXTVdXUzQyTklDamFyWm9YbXRXWi92?=
 =?utf-8?B?SmdPdElUK3YxTGlVWm43ZDVNVFNXMSt4MTlFZ2E5RVJxYlFEUXAzaCtlV3F5?=
 =?utf-8?B?cHUrZlliMUJpTDlkV2p2N2pYODNQWk1rTkRLNnV6VmcxaFdaQlRVNTB4RXNa?=
 =?utf-8?B?NWtNN1ZPcHpDSkZqTElKRlpUMFFLc0tJS2p0VERqZklNaFdldXloT25jNVVm?=
 =?utf-8?B?WTBBTHhwRzltajdURHo2YzV2c3dxTjdxOXpBTFJPZWpubmRDMXBuTElBcVhw?=
 =?utf-8?B?RDdMRW1BNnBWSmpJYzdIVWo2Nk0wcklGZVNHTXYwQVQwTG1VTWNmQWZyMDVU?=
 =?utf-8?B?bEUrbkg0a0NJYlRYV2h6MHBLbGlPcDJMakhQMUs4bmlKNGpHcDZ3VVNMcjFv?=
 =?utf-8?B?YjF6bEhYdWVzRjlwWGdqWjd4NlM3YTBVTGFHa3NrV2tuZTUxUjZmcndmRzN6?=
 =?utf-8?B?VkRETlNUcVROZW5QTjk4akU1eVBNYklCcU1GZFY1WExucFMwRHEzdWdzL1A4?=
 =?utf-8?B?eERKaCtlNDJJekdnWEpqMUtzUGxta0dwWFQwai84MGJiWEtXTEZSVFBQV0x1?=
 =?utf-8?B?cW1mRWNGWVd4eStaanZGTHgzRmtQNDI5aXFjaVBBZE41T2RhN2YwdSs4aGhB?=
 =?utf-8?B?OUVtTnhvd0VWbWtNeExxbEYyQU13ZHJXYmpVZS9JUEJ2SXpaM1cvMWlxMm1G?=
 =?utf-8?B?QjdqVDFjb0RFM0VQZ3FRb2Y0YndiWTNGdlRqQlMwaExMSVVsUHFzcWMzaWZB?=
 =?utf-8?B?OVVUWVBkVzVUcnZkaDNIM2E0WVVScVk1MHYwZHA0RHUwZWFCemxzeVBCUi9y?=
 =?utf-8?B?L2hzc1JmR0tsZHJqMkhlYkxBQmptWUhsTnlmS2dFQTFXUjZiZTExTHhTcDEz?=
 =?utf-8?B?WFZPU0MvcXJlaFMySTJra3cyMUpKcy9JYnNLOEZvOVl1NWVGeTI3eTRwU3JG?=
 =?utf-8?B?Mk54R0x5dS9tbHJFMDJZcjRCbXJ6bSs0U01qQ0J1TllLUUdDQ1JiV3dyRm40?=
 =?utf-8?B?cVRyVlJJbi9PR2s0R3BFcmpRaTNWQ2J4enVoWDh6ZkFHS2dNQWdJbHpJZk1s?=
 =?utf-8?B?WmVUSkZzOUQ0eTFFaTBsaFBBcUNHQ2kvZ0Zxc1Y0bTFXN3ZZMWxJaVVnbXZU?=
 =?utf-8?B?QkJiN2lJcGlnd1czaTNJV3c0Z0hNQlJsUGMrR0c1VDd0RHF1T1V1aU1ZejNa?=
 =?utf-8?B?YUFmVGl2ODZJdnEwRXB2RS9jb2hXdEtlaktFWXU2ZzhTMWFZSFBSYUVIMHA1?=
 =?utf-8?B?SDBwRHl4RHNzVllGMVM1eHhqZVNCSzBVUVdTd05wcUZpek5aeDRHR2tmRi9k?=
 =?utf-8?B?UlhaK2o0VXMxdlg3a2Q4d1JucnNDTysySXJVYU0zVHVGOFRjTjZhUG9UYXlw?=
 =?utf-8?Q?z0v4cvBapeVj52Z+RzSdrTEknS1QxjvX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDF0V1B5ZW5tYmdSY1QrRjRvbWNQbmg5dHlDaGdNZHo0YkJ2bGtSZjdGRjdT?=
 =?utf-8?B?cmdQNXhRTXJqbkFVQ1hidGJtZDh1bUVMR0pWM1VFK2lHUG9iVk13VTlhRFBs?=
 =?utf-8?B?SG9ZbStNbENzYjB1SDNIMGZnaGpNTkVzVnlSL21CQVR0QjBSMUc3N0Rod0Z0?=
 =?utf-8?B?engyMXRFNm5welVuZ25yTFFKRFRuajc5UlVyelNJd28zT3dHMTB1RUVWcW5a?=
 =?utf-8?B?ei9GTGg1N01UTzczM3V2ZlBSbzZHMEdKUEcwTnlJc2R3dnNKK0VsNURpUDZq?=
 =?utf-8?B?emNZVnRFU3FFYW5SOFZ5MEMwVHMwUWIxUXR2MnFwZ3RMMFR4Vnl3UkUyVDEw?=
 =?utf-8?B?c09NeFN6TFJMRGl0aElpWXNaN2F2ODlHZU5GN1dTWVdSUngvUkRZQ3pvdjdR?=
 =?utf-8?B?UUZ4RWVDbXdITHZrMmc3RFlrWERlanM4Q3lYdlB3Z0pRUU5QbXlBWllRaVZv?=
 =?utf-8?B?STNQZldxTERQTE4ycVVqdzE0ZndUSW91TStsL3BmSTRqL1A1NnN1M1NFdDQ2?=
 =?utf-8?B?MUliY1dBdDR0RVNZcGoybEpHTE9YWmpzZ0xLanErQVRhN0kzOXA4OTN0UjRO?=
 =?utf-8?B?bzZGL1haQVhxLytTZzVSR1RvR1hqeG9FV0t3K0MrZkhjQkUwTXV0dEtPNUNm?=
 =?utf-8?B?ck85cE54a1hrN2tqYWtSakIxL3drdVYzOUgydkpUZGpNQmo4OWFPdmlSaWFQ?=
 =?utf-8?B?TjVQV0xUTndvNlFFZWxPdlJOVmVBVTRKVEdrajhrNHBZRmxXWjMrMmE3SnVJ?=
 =?utf-8?B?bXFzUkZ6UWQ2Z0F4b01tZTZzNkN2ckgzcHVNaUVtVVN5Slcwcml5WjY3azY3?=
 =?utf-8?B?eS9tRDBvM0xGSytLaVZGaDk5OXpkRFYwWFJ0MjdqaksxcGhraGFDbEsyUTkv?=
 =?utf-8?B?cjVib3ZESUVIVEdrTDBKbnZvTncyTHU2cHZjRmMxYUp3bk1McWM1ZUd3eTVK?=
 =?utf-8?B?RUxYbVZPMzBUZ1FTNTRhYzI0bi9hTGNOQVNCanN6MXJvaWNyRWZ0VTdzQ3Ev?=
 =?utf-8?B?MjQ1WEMzQjRSTFJDVHF0OHJxblBjYjY0RHg3MTdMamdXS1VRQTNGemJuSFdn?=
 =?utf-8?B?a0o5SVQ2dTlCTjV3UHJIWE5RZE5vSjQzNE04TDZtb25SQ0IwZm1VUE5la3gw?=
 =?utf-8?B?OHBTUGVRWFdEenNycFRqS1FKdDhUU3l5TjQ5Y3NSWnJuZW5HMzllc1RkTit4?=
 =?utf-8?B?M3lUakJSbkpCdnpveFc2MVRNQ2xZa0tjSXk1MkFGNW1HMkhlV3VXSHh0L2Fi?=
 =?utf-8?B?aFd5cW9xOFpLVVFGT1hJUTJnbWI5b0JXS0wrQm5kWXE3cUZRQmJwMVdtUEtW?=
 =?utf-8?B?ZHVkNVBPTERDTTF2cVFwaHo2MzNXSllzc0J4NWhDL0VxdFJGV2ZOQzNVazZv?=
 =?utf-8?B?TUJiU1h4bmZRSlYwc3VCazRuY0xHL3ZjU3dqNGtOTEpad214OHlMYWlJNzQw?=
 =?utf-8?B?ZEo0Wk5aL0JQL21lUE1CaU51NEV5SzU4cjRFZ3VFWGFUMDZGbVU2ZzMxMHRt?=
 =?utf-8?B?MDB2dk9zNWRLMHhJRTBhSkQ2V1lINEhzNjhvYkQrZ09nWHRXVkFnSXhZSWFJ?=
 =?utf-8?B?K2k2VkVmMXJoZnJPdHV5VjF2NjgwRFZIVmx5a0F4eW4zZXZlb0g2SEhiUWRx?=
 =?utf-8?B?SHdmd0syM25RK0lhUHFSbllaSC85akZ3YUVTMnpzcjU1aWROWThiVGZucGlP?=
 =?utf-8?B?cy9nNHF6SlBQbzJKQ0QvVHhuTS9wanFmb2tjY1Yxd2lCNS9WV3FPTFZnZU03?=
 =?utf-8?B?dWJ6bkxXcW1iZGI5NGtTbVNSZlhuS1Rzck8va2R2c2dIYmR1WDBQTmx6Q0F5?=
 =?utf-8?B?VEhFN1E1ZUIvcDNNZm9pR04vOC9nY0psMGtXVmlQTm1sZ21Pc0t5S3dCV1Y1?=
 =?utf-8?B?akw5Y0l4Q1hyMDhhN3dTNHp6dnMxVUpEK05STE5Hdi8rV0R4bktrRmRHb2lz?=
 =?utf-8?B?QnVzUW13dTVGQzBETFNaU25EYUpDYjRzLzVqWFhyYkFISkk0bnp0T1RGMkNQ?=
 =?utf-8?B?ckJ3UlNST0JTYTdKUjhhRHQ0OUpINzUyYXFrd201SFJaZjNjUmhFOTdqMHB5?=
 =?utf-8?B?ck1MdnRqWFY3YVQwSkRzdTFjemNmMjBuOEpVNmF6TE85czFEZWdZOWdvY1JQ?=
 =?utf-8?Q?9yqqZu6+V/iOo6Zol3G12s9Yv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD294B57DB037D439F1D19DE364FBE9E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd849a2c-409b-4c28-dc34-08dd4cb6b7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 05:16:20.6183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YT9T1dpaypQ6hWrfkclbHXhtVePN4P/CLlNxAvBzldWm0dT9OHuuJg4z1L9NUPWNdB0mAKhEB0GlFhB2qciZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7901

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjM0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgYW4gaW50ZXJsYWNlX2FsbG93ZWQgYm9vbCBt
ZW1iZXIgdG8gc3RydWN0IG10a19oZG1pX3Zlcl9jb25mDQo+IHdoaWNoIHdpbGwgYmUgdXNlZCB0
byBzaWduYWwgd2hldGhlciBpbnRlcmxhY2VkIG1vZGVzIGFyZSBzdXBwb3J0ZWQNCj4gYnkgdGhl
IGJyaWRnZSAoaW4gb3VyIGNhc2UsIHRoZSBIRE1JIElQKSwgYW5kIGVuYWJsZSBpdCBmb3IgSERN
SXYyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFu
Z2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfY29tbW9uLmMgfCAxICsNCj4gIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfaGRtaV9jb21tb24uaCB8IDEgKw0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19oZG1pX3YyLmMgICAgIHwgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfaGRtaV9jb21tb24uYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9j
b21tb24uYw0KPiBpbmRleCAyZjJlNzdiNjY0YTIuLjc1MGJjYjQ1YzMzZCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX2NvbW1vbi5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9jb21tb24uYw0KPiBAQCAtNDI5LDYgKzQy
OSw3IEBAIHN0cnVjdCBtdGtfaGRtaSAqbXRrX2hkbWlfY29tbW9uX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgaGRtaS0+YnJpZGdlLmRkYyA9IGhkbWktPmRk
Y19hZHB0Ow0KPiAgICAgICAgIGhkbWktPmJyaWRnZS52ZW5kb3IgPSAiTWVkaWFUZWsiOw0KPiAg
ICAgICAgIGhkbWktPmJyaWRnZS5wcm9kdWN0ID0gIk9uLUNoaXAgSERNSSI7DQo+ICsgICAgICAg
aGRtaS0+YnJpZGdlLmludGVybGFjZV9hbGxvd2VkID0gdmVyX2NvbmYtPmludGVybGFjZV9hbGxv
d2VkOw0KPiANCj4gICAgICAgICByZXQgPSBkZXZtX2RybV9icmlkZ2VfYWRkKGRldiwgJmhkbWkt
PmJyaWRnZSk7DQo+ICAgICAgICAgaWYgKHJldCkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfaGRtaV9jb21tb24uaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfaGRtaV9jb21tb24uaA0KPiBpbmRleCBlNzRmZTEzNzEzMjQuLmRlNWUwNjQ1ODVmOCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX2NvbW1vbi5o
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9jb21tb24uaA0KPiBA
QCAtMTM3LDYgKzEzNyw3IEBAIHN0cnVjdCBtdGtfaGRtaV92ZXJfY29uZiB7DQo+ICAgICAgICAg
Y29uc3Qgc3RydWN0IGhkbWlfY29kZWNfb3BzICpjb2RlY19vcHM7DQo+ICAgICAgICAgY29uc3Qg
Y2hhciAqIGNvbnN0ICptdGtfaGRtaV9jbG9ja19uYW1lczsNCj4gICAgICAgICBpbnQgbnVtX2Ns
b2NrczsNCj4gKyAgICAgICBib29sIGludGVybGFjZV9hbGxvd2VkOw0KPiAgfTsNCj4gDQo+ICBz
dHJ1Y3QgbXRrX2hkbWlfY29uZiB7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2hkbWlfdjIuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV92
Mi5jDQo+IGluZGV4IDMzOGE2ZGRhMmZkMi4uMzZiN2Y4ZDhkMjE4IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfdjIuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfdjIuYw0KPiBAQCAtMTI5Miw2ICsxMjkyLDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfaGRtaV92ZXJfY29uZiBtdGtfaGRtaV9jb25mX3YyID0gew0K
PiAgICAgICAgIC5jb2RlY19vcHMgPSAmbXRrX2hkbWlfdjJfYXVkaW9fY29kZWNfb3BzLA0KPiAg
ICAgICAgIC5tdGtfaGRtaV9jbG9ja19uYW1lcyA9IG10a19oZG1pX3YyX2Nsa19uYW1lcywNCj4g
ICAgICAgICAubnVtX2Nsb2NrcyA9IE1US19IRE1JX1YyX0NMS19DT1VOVCwNCj4gKyAgICAgICAu
aW50ZXJsYWNlX2FsbG93ZWQgPSB0cnVlLA0KDQpNb3ZlIHRoaXMgcGF0Y2ggYmVmb3JlIEhETUkg
djIgcGF0Y2guDQpBbmQgbGV0IHRoaXMgbGluZSB0byBiZSBpbiBIRE1JIHYyIHBhdGNoLg0KQWZ0
ZXIgdGhpcywNCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4g
IH07DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaGRtaV9jb25mIG10a19oZG1pX2Nv
bmZfbXQ4MTg4ID0gew0KPiAtLQ0KPiAyLjQ4LjENCj4gDQoNCg==

