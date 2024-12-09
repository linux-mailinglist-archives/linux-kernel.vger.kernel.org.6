Return-Path: <linux-kernel+bounces-436696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0099D9E8984
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B038F282CAF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C740D148855;
	Mon,  9 Dec 2024 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TC3SeEsD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="c9Ks47to"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D297813C9B3;
	Mon,  9 Dec 2024 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733714813; cv=fail; b=NEXANMWwlOEcQJgu7MLPDhLwsPAqhNhKF292WUZi8kiYiiVU7SOi7e4jPyure4oP7VGMwqf6bfEsxQkLGOuL2x8gY0lTbecueOquSBZkVgJFqzyl0lDzqy5G+doX2q5qSVg6c9PvkiSxxDh7rrndPaoOAGCBwYVZPOt/LLEdQEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733714813; c=relaxed/simple;
	bh=6mxyqgNm3hcb/lcj35ZWfzEEfOqxYpZ0D6Q9RplUdhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bO1xbwzt52hAUopi10FfXuNSo/ENe9Pc5YVQfqYXKoi/dl79K2LqERldsXQoO8bW5TfiVI+ljR1zw8SvfkPKWWrou/7q5I/wr1tr4x3JmKA7gU/2bKAEuVkHjM6ErgzdbEuAzPJJV+1o8uTa0hWC/Pcp2yC8kfJf+j7Cs8VALcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TC3SeEsD; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=c9Ks47to; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6a7e0e7ab5dd11efbd192953cf12861f-20241209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6mxyqgNm3hcb/lcj35ZWfzEEfOqxYpZ0D6Q9RplUdhk=;
	b=TC3SeEsDvNgZv9m9NZE3cCCRN+DpxzLnFA2jXz6iOUokgkArXHUD7y2t1HI7gYcqwyQH9LXD3VAbD+2oQFL+tBdEvlZdbcj5XDfW4dOUdpfwNhw6UZKS1rlvOjZ6MJBYMjPlICLv0WJL3++VZeeWizs6AqVIkAZMo0eQJgwGOEw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e4807aad-cf89-4c4e-97b0-159679acb257,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:e5c8a43b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6a7e0e7ab5dd11efbd192953cf12861f-20241209
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2061057071; Mon, 09 Dec 2024 11:26:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 9 Dec 2024 11:26:43 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 9 Dec 2024 11:26:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHRmoNmS+53+oq2Trt6E7wbcOIzj+j7a45h/aFSxKiXCnMezqvY4Pbw+r1qUS7nRFI/5Uy+RjP8ZQtCq1kNYlcV7IKeq8xKNTATy9P8l+tqwaApn3y+7NMhv3pLzJINjj+ulGEjlKB/9xYoYiS+Tx1upxL9dCeqnDLNj3Fl8FcqNQqO2LDiOnKQqr37bJkF0Y/jSFW+GObSPckRCQA5svMOcYN4yIUHA7dojLhJNz+xUtbKl7NyOGwzLaRNLqqSYW7qq2215KTZAiZtwWSEZ4Ls+he6Fbdx9Un2ItWAvy6pKC44Pkv09s3nXu9L798FtLP7pJivjZt0fpbDOsZN+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mxyqgNm3hcb/lcj35ZWfzEEfOqxYpZ0D6Q9RplUdhk=;
 b=ErGSgcix6fMxzZZ+9tRGly5htm1kZNgfJwf3kFs2tg8lKzBA4coGwG39obBJY5h3YybVvItyYqP56wnutcmvzjbbXr8m29HHRQvIF1N1HyqDR+SCOQ3yxZfZLA6zJx7bTxKtrVbNZWh1o3UnJRS2XOX3BQMB67dM4FDC1a7x2HSFCAwnOLP1igDXYKhhcT3xYxYkjFPxV3XT+175XtwDnVnnDxDWmOeJXG2FJtGEi5C/5WUm9KcLKtCBEmUdu4MFXZoOIoKG//PdEYUwZrTa5LlUEqGBhTmK9A6DLSYQKM7CeJneXXughE5iRRxwX//km2ZYxMd/mdtenalQI2quzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mxyqgNm3hcb/lcj35ZWfzEEfOqxYpZ0D6Q9RplUdhk=;
 b=c9Ks47toWTRHryrwNk6tjPwOIBqA+D393fj+2v9yyn2CnAwwM4dL4NAlADeWGbIQW7Q7b4aW0N0U9iyjxi9oVOBGZty95uw9dM6+M7T0vWAKxxEBH0L6K6VFB9y/9ioHy6sWcqRpviwxjpb23l07hfAAKQZ6ta+6ND45GzI93Ls=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8395.apcprd03.prod.outlook.com (2603:1096:405:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 03:26:39 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Mon, 9 Dec 2024
 03:26:37 +0000
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
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v2 07/15] dt-bindings: display: mediatek: Add binding for
 MT8195 HDMI-TX v2
Thread-Topic: [PATCH v2 07/15] dt-bindings: display: mediatek: Add binding for
 MT8195 HDMI-TX v2
Thread-Index: AQHbRwt+Y5gpExW2DEagVVsCKlgdUbLdRjYA
Date: Mon, 9 Dec 2024 03:26:37 +0000
Message-ID: <ad2a805fb52caface837d4ce60461adb3ac7cfd7.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-8-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8395:EE_
x-ms-office365-filtering-correlation-id: 1faf089b-6d61-48bb-a70e-08dd18014a14
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?djE5YVM5akVxVkV2b3h1ZUNmd096YXdEZWhaQVU0MWtPM0Nia1ZLeVA3WFJi?=
 =?utf-8?B?bFVXdU5GYS94UktSWUx3bDFjN0ExQ3ZXVGlYVXN1anBmdXJieEpobU9haUVy?=
 =?utf-8?B?NHlRZ29vYWt2WGRFcmhvMFhoTHl4d1NBVmw2dS90c2dqeFdIazJMTXkrcS9J?=
 =?utf-8?B?ckIxZ2JjMTFhQmNvcDFtK2d2aks1aG8wNUtYYzl6RDAwQmViZk5EN1hBalRy?=
 =?utf-8?B?NkRESXlZajBjSlFrYlMyMjY2VS84RlRZYXpFNzJ1Q2Q0aUFqeE05VjRwM0lR?=
 =?utf-8?B?NXh6TmdMeWdJeU9EQTlKL3haRWRQQzhRblZWYXcybDlOQ1F0US9HVG9aMWJM?=
 =?utf-8?B?RWVIV1dnd3dOTHRlbExxNUZJdHBVRGpxSHZSMGtFQjRkRnV6SXRtWUpacjNJ?=
 =?utf-8?B?cjF0Z09UUklkeG1TOElIQkN1dEsxSWZkUU5WeE1LRFpzdlBqSzJ3THEyREpi?=
 =?utf-8?B?NVIwVTdRbjNhR1RBc1B1T2xERUJ1eXZTamJwUThLam9PUE9POEI4TERNVWR6?=
 =?utf-8?B?MjVwNEVhV0VSVFJqQTd4czBQaTdIMHVuaTY3UmVjdkhmSTFEclFaR0RKdWhH?=
 =?utf-8?B?emlnZER5WTBrUXZ0ay9vbzdwdmRrUmZpSlcxQU5YOXdwZVMwQ2UwdEMzVjZw?=
 =?utf-8?B?b0tkY0hKcUpUSVpCNlI5dWdCdlB4amRlWFEvV0xKWXB2RUVjNEpHL1hVZ2M2?=
 =?utf-8?B?cHhibWdSMkFXYW5mZGlzT1p5THR1YldGdkkxcURXclZweDBHNW92ZnUyQ0J2?=
 =?utf-8?B?TE9WaVppTDUwM1l4RjhHWVdlTU01czFWdkNBcmhBSkVKdmp2UTU4N3QyLzQw?=
 =?utf-8?B?Z0xpRXdLK2xTKzlOM3p4Rk04TDRCSU1reXNRTXlxb0xvbFdoTS9tSDJZbGox?=
 =?utf-8?B?ZEQ3ZFVKNHRnWGh0R1RIL0VnNFI1a3RGbVAxVEdWelJNMm1qcHVoLzJBNVFI?=
 =?utf-8?B?dVEzT2pES2VBYU15RjM4Qm00WnU1UFhTUU1KTGFZVkJ5OG1QaCsxT0VvL3V1?=
 =?utf-8?B?M1dPL2xtTjIyaURIZjB2OUhaWk1wMEZUcCtzK1dmMldRaHZDaXREVTYwUC9G?=
 =?utf-8?B?R3dMNm9WOC9wUXpPTGc1SUZXL0RlYzFJc0ltdXhoV0VqMlRvZndNbXc5VHBY?=
 =?utf-8?B?NGc0TFNnQ2JkS3diZ1cwVTIxY041di9WVDFodlh6L1U1TWkrOUg4SWlQYUtW?=
 =?utf-8?B?OW52NFg4UTIwNjJBZGs3cnVIV2xEUEdNVy9lVGNHQ3ZGVWlRVkNaaGxQUXVw?=
 =?utf-8?B?UlJQdnlFRjU4OTczWTNhMFR1bXVOZEJhSWJlUm80MzBDeGxObXZveEdiTjkz?=
 =?utf-8?B?MDNUQWhzTHVwS3REWFlBZnVQcXRGVDhpK1BadXZkQ2VEbDVWakl1ZkxXWlRu?=
 =?utf-8?B?VUJHMnJEUmNlTWlTSkRaVGI4VUhEdHRtOEY5a1JsOGt4T054NWxLWFdmY3Ja?=
 =?utf-8?B?NjNSU016d3d6ZXVIV2pPTW1RWmdNdFNFQjR5eE1iUC9YVGx5UXE0VmZDSlhs?=
 =?utf-8?B?YXdLTUNkU2I0ZWhkcVJ2K1dvdWx4UkRlWXcvQUJsM2dDeHlRMjFCK0hzMith?=
 =?utf-8?B?d01DOFRoRUFHYUYxeEE1b29tODlMM2hscG91bFBEZlpGZm1ZK211a1JpZzAr?=
 =?utf-8?B?VE5sL090Zmpwa3FFUHorKy9odU9DenFYVWlIU0lNbnJ3UUcrc0g1Unh0Yk55?=
 =?utf-8?B?ZktTMFgrWStZYkg0L3ZFa3BxdFpxY3Uvb1hrdU95N05XY1BwT01iRS9nSkVx?=
 =?utf-8?B?Wjg0U29zdm8wQ1o2QXZFV0VBOTVSalVNb2ZiU2U2Qlh2RlZjYU05ei9QWms2?=
 =?utf-8?Q?8yd3zIUDawmhq+I72ZugpZTgczlBnSo8Wremk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?empSME5GL0h0aFNRSnpYNmpWaDZaSnluWXRrTFM0QUkxWHFGMm5RM2xCTzFt?=
 =?utf-8?B?UVN4MlU4ZjZYcG80bTlJZW4xR1pxaWVyalBTZmsweTlsb200b09YVVpQKzg1?=
 =?utf-8?B?dTVsV3pvbmw0OVhLdG4wU3laOTlrakNLRllUTTFpSzNEVzk3bE1ucG9qUU5K?=
 =?utf-8?B?S2FlZitKMmYrK1VLMzBxK0hSNWhBT1NTdXUrSms3T1JJcmg5TkJmeWsrT2wx?=
 =?utf-8?B?UVdWdmN6Y3Boc3FWZWxZMkhwTDdVbmFyU0o1eEpvOTVkM3h6azk3L3NQc0N6?=
 =?utf-8?B?d0xOcVFIWHBZUTJIWXY2L1M0NzdhcjJBRjdmVkNjWitlNDU0QVZVUXJ1aTVH?=
 =?utf-8?B?U01JL3ROK3JrazA4KzZtVTluZmRNRFpaZURXQW03UXRxaHZwb3hJeWp2R2VN?=
 =?utf-8?B?Yjg2N1RtUUExN2JBcGFyS3pYbGZwWXp1MjZqZGNRMXVuSTVsWmZJbGtwT2Na?=
 =?utf-8?B?S2ZLZGtSc1FFd2Z6bitIUVJERjB4OHNhTFJvZENzUHpZQmRMTWs3TGwvdkRi?=
 =?utf-8?B?ekh1T0hYa3hmVWtLaXA1WGJSQ2xmNjI1VWd1SWRPQTRKUkMxekdKWmw2c3RB?=
 =?utf-8?B?WFdCdU01TDl5Z2dnOW5rdm80L213ZWQvZFFoWld0MnJZbGhqS2srUkFwU3Bo?=
 =?utf-8?B?OUtKMkZid0VhSHExdGlMRXBKUVpkeXhSQlpnUkN0K1FrMnlPYXNkaU51WlI3?=
 =?utf-8?B?akhnajNobUpUWkdNaFFYM3NjRCtCOWVpWTJXN2p6NTh5RU5MaTEwV0FpZFRo?=
 =?utf-8?B?aVJtL1k4RE8xZTJmeUllb1RkTnYvWXRuemJRVWliRjVtUFpFRTFXM1J6RDR0?=
 =?utf-8?B?aThxOCtIQ1hSZzhKZHF5bk5BVVBKTjlGTDFLR3NCVGF4Wm5XdTFCamdrUERY?=
 =?utf-8?B?VHZSQXhaM2VkK0IyY2NoZDNJWFFMbW9nb01lM2VKNG8vZGcvU1JBSkRUdWVw?=
 =?utf-8?B?RksrVTVWOVpGSG56SHF0OEdSSk5tZE5WSHRLamFhT0Y3b2FtUGtadVdnVStB?=
 =?utf-8?B?REhwZ2JTcEYrZlVvV0I1aUh3VktKWk1INzlqRmpxZGtBQytkNjIwMjFnM3Nv?=
 =?utf-8?B?ZzNCWkZlL0wzcTI4d2NzbE9OU001b0dydXVQSFBHOHUwR0ViZExSQXBMOTg4?=
 =?utf-8?B?U2ZXR1V2aHJQNW45dUVZTFp4eGdWRHZlS3JQT3A4Tk1iUkNWK3ZJNTNCcU9W?=
 =?utf-8?B?MWJ3V01MdDFRYldYcjdkSWQxcU1reHo4SGh1Y3F0ZkJmQU9OdHVvM1k5cHNF?=
 =?utf-8?B?bHlOSmdrcGgwUllsS1ZiV1AzTjlBalV0Y2phbytMenZVWU1udXRMa3BpMGJF?=
 =?utf-8?B?U2dLT3poaFlESjEya1NHWkc3NzM1eUJOU0NUWXo2c3QvV0drb3BZbENmNE1y?=
 =?utf-8?B?d3ZBc1FaMEZGY1REL3NlNndEdWxEbUxUUFUxVEZhWGZQSDMwdmR5c2RWY1lD?=
 =?utf-8?B?SWxIQ0trSTVFdm44TUcybU93VmIzVHk2NDgwdm9NZjBEWFlIRU5uWmsyVWpV?=
 =?utf-8?B?Vktrd21DV1l6VEh3MklvaXZ6czI2WTdZQldnZng0ekwwVzFDSjZudmhzeHRu?=
 =?utf-8?B?cklFUE91Smo2NWg5cTV6QzFLUGxLMENXeW5TVlFCRUJ0YmkvZEFiN3VXR1RM?=
 =?utf-8?B?czdlN2UrSFdCd2NLd3AzaVdEN1pHYkx6SHJSZkVURUhGODZ6MU95VW9XWWxu?=
 =?utf-8?B?NTBCVTFBQ0JVUVBzV2M4Ymg4ZWVqNWxudEh3a0oraldKd0tHdE5raTdjM3BH?=
 =?utf-8?B?TDJ1ay9ieHVVdHBSTWlyYVZvMGM5VkhVUyt1UTZwM1JRTCtPSE5keVBjekNT?=
 =?utf-8?B?N1dmT2Mva2VPbFF5V3UrMTJlU2xtUEZPaG5EQWJuMm52SXlBZnR2ZjNLY201?=
 =?utf-8?B?dWlSdTBleU5UOHVPODRmNVJNa1IvVlA5QjQyZkxDMnk2QnJ2SEJQdTVTaW85?=
 =?utf-8?B?Zml2ZjZGd1pCN29zeHp6aCs2QlpPM0VVenFML0ZhZW5xTkNYcEErbUNkb2d5?=
 =?utf-8?B?YkFRRWJXRmltVmZ3OXhzY0wrNHEvaUxwS21QQmtSUit4K1ZJVHVOSnpNOFVZ?=
 =?utf-8?B?MThEVDBqM0ZvM05pdnhtRGl5ZmsxWVowZk5mSncyRUJzRXVDSFg4Ujl6WE1r?=
 =?utf-8?Q?tW31Rtar6XPbDN8bS0dM8DTkc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FDDBE05A122F745A238783E94B90ED6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faf089b-6d61-48bb-a70e-08dd18014a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 03:26:37.2856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s6uLyphUtVC1WiBNhxNT9WXWd6fMRKxChiz34Oyu7NbCNxhRx6xPPcc1YLPq84W/T9GXmc1ejFSCqPtW1TvuOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8395

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTEyLTA1IGF0IDEyOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgYSBiaW5kaW5nIGZv
ciB0aGUgSERNSSBUWCB2MiBFbmNvZGVyIGZvdW5kIGluIE1lZGlhVGVrIE1UODE5NQ0KPiBhbmQg
TVQ4MTg4IFNvQ3MuDQo+IA0KPiBUaGlzIGZ1bGx5IHN1cHBvcnRzIHRoZSBIRE1JIFNwZWNpZmlj
YXRpb24gMi4wYiwgaGVuY2UgaXQgcHJvdmlkZXMNCj4gc3VwcG9ydCBmb3IgM0QtSERNSSwgUG9s
YXJpdHkgaW52ZXJzaW9uLCB1cCB0byAxNiBiaXRzIERlZXAgQ29sb3IsDQo+IGNvbG9yIHNwYWNl
cyBpbmNsdWRpbmcgUkdCNDQ0LCBZQ0JDUjQyMC80MjIvNDQ0IChJVFU2MDEvSVRVNzA5KSBhbmQN
Cj4geHZZQ0MsIHdpdGggb3V0cHV0IHJlc29sdXRpb25zIHVwIHRvIDM4NDB4MjE2MHBANjBIei4N
Cj4gDQo+IE1vcmVvdmVyLCBpdCBhbHNvIHN1cHBvcnRzIEhEQ1AgMS40IGFuZCAyLjMsIFZhcmlh
YmxlIFJlZnJlc2ggUmF0ZQ0KPiAoVlJSKSBhbmQgQ29uc3VtZXIgRWxlY3Ryb25pY3MgQ29udHJv
bCAoQ0VDKS4NCj4gDQo+IFRoaXMgSVAgYWxzbyBpbmNsdWRlcyBzdXBwb3J0IGZvciBIRE1JIEF1
ZGlvLCBpbmNsdWRpbmcgSUVDNjA5NTgNCj4gYW5kIElFQzYxOTM3IFNQRElGLCA4LWNoYW5uZWwg
UENNLCBEU0QsIGFuZCBvdGhlciBsb3NzbGVzcyBhdWRpbw0KPiBhY2NvcmRpbmcgdG8gSERNSSAy
LjAuDQoNCk5PVEU6IFRoZXJlIGlzIGRpc2N1c3Npb24gaW4gWzFdLg0KDQpbMV0gaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjQxMjA1
MTE0NTE4LjUzNTI3LTgtYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tLw0K
DQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0t
DQo+ICAuLi4vbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTk1LWhkbWkueWFtbCAgICAgICAgfCAxNTQg
KysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTU0IGluc2VydGlvbnMoKykN
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTUtaGRtaS55YW1sDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsv
bWVkaWF0ZWssbXQ4MTk1LWhkbWkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLG10ODE5NS1oZG1pLnlhbWwNCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi43M2IxZGZhYTFhZGINCj4gLS0t
IC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTUtaGRtaS55YW1sDQo+IEBAIC0wLDAgKzEsMTU0
IEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0y
LUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9kaXNwbGF5L21lZGlhdGVr
L21lZGlhdGVrLG10ODE5NS1oZG1pLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFrQjhmNjMw
Q1VvbHFrcFgzaXB2eTFfSEVHTWN3UVdYc2ZwdjJKV0RuVzhDWmNrVUx2dG9ILVZzV0Z4TVhlVDAz
NXg0RVRNY3N3VjgxeU1yQ0gzY1JzWGlwclNwRiQNCj4gKyRzY2hlbWE6IGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFt
bCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IWtCOGY2MzBDVW9scWtwWDNpcHZ5MV9IRUdNY3dRV1hz
ZnB2MkpXRG5XOENaY2tVTHZ0b0gtVnNXRnhNWGVUMDM1eDRFVE1jc3dWODF5TXJDSDNjUnNmQzk2
TnNHJA0KPiArDQo+ICt0aXRsZTogTWVkaWFUZWsgSERNSS1UWCB2MiBFbmNvZGVyDQo+ICsNCj4g
K21haW50YWluZXJzOg0KPiArICAtIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9n
aW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ICsgIC0gQ0sgSHUgPGNrLmh1QG1l
ZGlhdGVrLmNvbT4NCj4gKw0KPiArZGVzY3JpcHRpb246DQo+ICsgIFRoZSBNZWRpYVRlayBIRE1J
LVRYIHYyIGVuY29kZXIgY2FuIGdlbmVyYXRlIEhETUkgZm9ybWF0IGRhdGEgYmFzZWQgb24NCj4g
KyAgdGhlIEhETUkgU3BlY2lmaWNhdGlvbiAyLjBiLg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiAr
ICBjb21wYXRpYmxlOg0KPiArICAgIGVudW06DQo+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC1o
ZG1pLXR4DQo+ICsgICAgICAtIG1lZGlhdGVrLG10ODE5NS1oZG1pLXR4DQo+ICsNCj4gKyAgcmVn
Og0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgaW50ZXJydXB0czoNCj4gKyAgICBtYXhJ
dGVtczogMQ0KPiArDQo+ICsgIGNsb2NrczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IEhETUkgUGVyaXBoZXJhbCBCdXMgKEFQQikgY2xvY2sNCj4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IEhEQ1AgYW5kIEhETUlfVE9QIGNsb2NrDQo+ICsgICAgICAtIGRlc2NyaXB0aW9u
OiBIRENQIGFuZCBIRE1JX1RPUCByZWZlcmVuY2UgY2xvY2sNCj4gKyAgICAgIC0gZGVzY3JpcHRp
b246IFZQUCBIRE1JIFNwbGl0IGNsb2NrDQo+ICsNCj4gKyAgY2xvY2stbmFtZXM6DQo+ICsgICAg
aXRlbXM6DQo+ICsgICAgICAtIGNvbnN0OiBidXMNCj4gKyAgICAgIC0gY29uc3Q6IGhkY3ANCj4g
KyAgICAgIC0gY29uc3Q6IGhkY3AyNG0NCj4gKyAgICAgIC0gY29uc3Q6IGhkbWktc3BsaXQNCj4g
Kw0KPiArICBpMmM6DQo+ICsgICAgdHlwZTogb2JqZWN0DQo+ICsgICAgJHJlZjogL3NjaGVtYXMv
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTUtaGRtaS1kZGMueWFtbA0KPiArICAgIHVu
ZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gKyAgICBkZXNjcmlwdGlvbjogSERNSSBEREMg
STJDIGNvbnRyb2xsZXINCj4gKw0KPiArICBwaHlzOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsg
ICAgZGVzY3JpcHRpb246IFBIWSBwcm92aWRpbmcgY2xvY2tpbmcgVE1EUyBhbmQgcGl4ZWwgdG8g
Y29udHJvbGxlcg0KPiArDQo+ICsgIHBoeS1uYW1lczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAg
IC0gY29uc3Q6IGhkbWkNCj4gKw0KPiArICBwaW5jdHJsLTA6IHRydWUNCj4gKw0KPiArICBwaW5j
dHJsLW5hbWVzOg0KPiArICAgIGl0ZW1zOg0KPiArICAgICAgLSBjb25zdDogZGVmYXVsdA0KPiAr
DQo+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICAnI3Nv
dW5kLWRhaS1jZWxscyc6DQo+ICsgICAgY29uc3Q6IDENCj4gKw0KPiArICBwb3J0czoNCj4gKyAg
ICAkcmVmOiAvc2NoZW1hcy9ncmFwaC55YW1sIy9wcm9wZXJ0aWVzL3BvcnRzDQo+ICsNCj4gKyAg
ICBwcm9wZXJ0aWVzOg0KPiArICAgICAgcG9ydEAwOg0KPiArICAgICAgICAkcmVmOiAvc2NoZW1h
cy9ncmFwaC55YW1sIy9wcm9wZXJ0aWVzL3BvcnQNCj4gKyAgICAgICAgZGVzY3JpcHRpb246DQo+
ICsgICAgICAgICAgSW5wdXQgcG9ydCwgdXN1YWxseSBjb25uZWN0ZWQgdG8gdGhlIG91dHB1dCBw
b3J0IG9mIGEgRFBJDQo+ICsNCj4gKyAgICAgIHBvcnRAMToNCj4gKyAgICAgICAgJHJlZjogL3Nj
aGVtYXMvZ3JhcGgueWFtbCMvcHJvcGVydGllcy9wb3J0DQo+ICsgICAgICAgIGRlc2NyaXB0aW9u
Og0KPiArICAgICAgICAgIE91dHB1dCBwb3J0IHRoYXQgbXVzdCBiZSBjb25uZWN0ZWQgZWl0aGVy
IHRvIHRoZSBpbnB1dCBwb3J0IG9mDQo+ICsgICAgICAgICAgYSBIRE1JIGNvbm5lY3RvciBub2Rl
IGNvbnRhaW5pbmcgYSBkZGMtaTJjLWJ1cywgb3IgdG8gdGhlIGlucHV0DQo+ICsgICAgICAgICAg
cG9ydCBvZiBhbiBhdHRhY2hlZCBicmlkZ2UgY2hpcCwgc3VjaCBhcyBhIFNsaW1Qb3J0IHRyYW5z
bWl0dGVyLg0KPiArDQo+ICsgICAgcmVxdWlyZWQ6DQo+ICsgICAgICAtIHBvcnRAMA0KPiArICAg
ICAgLSBwb3J0QDENCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAt
IHJlZw0KPiArICAtIGNsb2Nrcw0KPiArICAtIGNsb2NrLW5hbWVzDQo+ICsgIC0gaW50ZXJydXB0
cw0KPiArICAtIHBvd2VyLWRvbWFpbnMNCj4gKyAgLSBwaHlzDQo+ICsgIC0gcGh5LW5hbWVzDQo+
ICsgIC0gcG9ydHMNCj4gKw0KPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ICsNCj4g
K2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2sv
bXQ4MTk1LWNsay5oPg0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9hcm0tZ2ljLmg+DQo+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL210
ODE5NS1wb3dlci5oPg0KPiArDQo+ICsgICAgc29jIHsNCj4gKyAgICAgICAgI2FkZHJlc3MtY2Vs
bHMgPSA8Mj47DQo+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiArDQo+ICsgICAgICAg
IGhkbWktdHhAMWMzMDAwMDAgew0KPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxOTUtaGRtaS10eCI7DQo+ICsgICAgICAgICAgICByZWcgPSA8MCAweDFjMzAwMDAwIDAg
MHgxMDAwPjsNCj4gKyAgICAgICAgICAgIGNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9IRE1J
X0FQQj4sDQo+ICsgICAgICAgICAgICAgICAgICAgICA8JnRvcGNrZ2VuIENMS19UT1BfSERDUD4s
DQo+ICsgICAgICAgICAgICAgICAgICAgICA8JnRvcGNrZ2VuIENMS19UT1BfSERDUF8yNE0+LA0K
PiArICAgICAgICAgICAgICAgICAgICAgPCZ2cHBzeXMxIENMS19WUFAxX1ZQUF9TUExJVF9IRE1J
PjsNCj4gKyAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gImJ1cyIsICJoZGNwIiwgImhkY3AyNG0i
LCAiaGRtaS1zcGxpdCI7DQo+ICsgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNjc3
IElSUV9UWVBFX0xFVkVMX0hJR0ggMD47DQo+ICsgICAgICAgICAgICBwaHlzID0gPCZoZG1pX3Bo
eT47DQo+ICsgICAgICAgICAgICBwaHktbmFtZXMgPSAiaGRtaSI7DQo+ICsgICAgICAgICAgICBw
b3dlci1kb21haW5zID0gPCZzcG0gTVQ4MTk1X1BPV0VSX0RPTUFJTl9IRE1JX1RYPjsNCj4gKyAg
ICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsgICAgICAgICAgICBwaW5j
dHJsLTAgPSA8JmhkbWlfcGlucz47DQo+ICsgICAgICAgICAgICAjc291bmQtZGFpLWNlbGxzID0g
PDE+Ow0KPiArDQo+ICsgICAgICAgICAgICBoZG1pdHhfZGRjOiBpMmMgew0KPiArICAgICAgICAg
ICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWhkbWktZGRjIjsNCj4gKyAgICAg
ICAgICAgICAgICBjbG9ja3MgPSA8JmNsazI2bT47DQo+ICsgICAgICAgICAgICB9Ow0KPiArDQo+
ICsgICAgICAgICAgICBwb3J0cyB7DQo+ICsgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+ICsgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ICsNCj4gKyAg
ICAgICAgICAgICAgICBwb3J0QDAgew0KPiArICAgICAgICAgICAgICAgICAgICByZWcgPSA8MD47
DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgaGRtaV9pbjogZW5kcG9pbnQgew0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZkcGkxX291dD47DQo+ICsg
ICAgICAgICAgICAgICAgICAgIH07DQo+ICsgICAgICAgICAgICAgICAgfTsNCj4gKw0KPiArICAg
ICAgICAgICAgICAgIHBvcnRAMSB7DQo+ICsgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwxPjsN
Cj4gKw0KPiArICAgICAgICAgICAgICAgICAgICBoZG1pX291dDogZW5kcG9pbnQgew0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZoZG1pX2Nvbm5lY3Rvcl9p
bj47DQo+ICsgICAgICAgICAgICAgICAgICAgIH07DQo+ICsgICAgICAgICAgICAgICAgfTsNCj4g
KyAgICAgICAgICAgIH07DQo+ICsgICAgICAgIH07DQo+ICsgICAgfTsNCj4gLS0NCj4gMi40Ny4w
DQo+IA0KDQo=

