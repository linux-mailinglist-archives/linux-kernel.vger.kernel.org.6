Return-Path: <linux-kernel+bounces-517118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86CEA37C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094043A8266
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1EF199921;
	Mon, 17 Feb 2025 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="moX+j6m5";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OVReIblw"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9B8F5C;
	Mon, 17 Feb 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777781; cv=fail; b=gPwP7KOxOlEeVDgkY5Yirllh8ReZzKVblqNL+x2jBukCXB3c0jekYGqM89W03Ki6an94vU+ckqqcHKUqP6rVHYDZcCjhLqPXCLxZtB5et3J4MxVM6R8BhZRFe9faVtBlQWAnBBy4zRiYIkbYTR8Iw8JVchzrwt+eXpNcwff9qGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777781; c=relaxed/simple;
	bh=K06GE1PcQuDqhUpU3gJvuiDp4BKcJeMTbzWzdDR/lrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AyZ5DjdCrqAKo3aQ8fcPHsyEXnlKJ9cQYg+DwOnrTDiJ9BbT9XB0zEHK2Q0QIv9nW7xVBkJ9R4Bx/302kW5mb7UAAU97AvTp3HrLJiTQeUpdDdv92JszcJ2dceI+jP8ksgKiKcu1lhxF2qWNfp5hKocnQxJnmkc0uPKc8CBjyuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=moX+j6m5; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=OVReIblw; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dd95485aed0111ef8eb9c36241bbb6fb-20250217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=K06GE1PcQuDqhUpU3gJvuiDp4BKcJeMTbzWzdDR/lrI=;
	b=moX+j6m5Bb0ACmEOd/5iOnbQakVEXvqpWo2ErVOlW551na6Bml2//a+eIp05CXrc8+Rc9Ar7PIRuYr10rHL2En5exFfSWjI7Pw5Y5PqF9rgo7vT6YgsrorJnBLQZJYEm411ygAhDw9Laf1TWBHIpehSW6K7QOaWenDTiy0FSv4E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:4d803342-6ccb-469f-ac60-3ae84fa29054,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:554d77fc-7800-43c5-b97b-ddbe32561a5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dd95485aed0111ef8eb9c36241bbb6fb-20250217
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 12043771; Mon, 17 Feb 2025 15:36:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 17 Feb 2025 15:36:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 17 Feb 2025 15:36:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYA1v7ld439ZUTVu+vQDOgrbsgM2U9SDl+epII2Nf5eWf6jKXB5DcjlVxoqp2n+ov8Wt4B9NiDG24XAgpAWMywy9x0B1NTcg05JSnpWLgMr+hBBmOwnGrbLco4Y42LCNxuxEx6SOR80HsuZUeu5oz608eRME7Wn+uBJtwgdwRqGqVfqF/Kk2IrE/Le9slWe//pgGgQNQdXKJnA3dX0CkfDkpMoB0B9YH/tTTgVS5P7mTyYBVURzes1zQg5kTCW9Y4E9xO/MjvxUezwh9UIY+JlWIGqRE+K/Cbg7njVRz3EjDTX1vfgZshu3yH/BV5SCAjrJzS396F/nvKIQh71OSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K06GE1PcQuDqhUpU3gJvuiDp4BKcJeMTbzWzdDR/lrI=;
 b=L48lAmQYVZU8T1cSaiHNnSVy3i4dx2QcYbdHgpZyYWzczXehyf1TzNOH3zDCWF92xjTTaU9f60Q9IWcky8nPJ7oJE9G+UAQqdvGiWW+BHJ9R0BF0IhQwQEV89NdzM8DXkR/yDcyqtFKrYNELlEwrbIrQ4LfWGidAscqinjH/vcTvdH/soSweOBRLwVI9RQIQ+knW3J1NFg/NCndKmUOf4VOj5npAcaxaKaBGWgQ/VRQ1YvZFO6tg75D8Fvbwzvil9bT7vLGt3bvyxuK7Qtf2etpDifSlpbLX3oO+KBYRlvaux8toFHTXEZVECiEUon7JXfJYJQv0rLRTUD5silHyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K06GE1PcQuDqhUpU3gJvuiDp4BKcJeMTbzWzdDR/lrI=;
 b=OVReIblw0XG1Fpysg5TZIReJrF7jqSGWOWmmyQMfyvlamKS6XqupKiJd2gMOrJsYz6HGpFUArUcTcYUKJrPmsi26jmE8kZthRoP/foV3F+TuwGQt6hmpdy7od82sjg/mGqL7yzwoJajfiV5NwdnzvXnAVElLw3zaBLnpWdfDBaY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB8379.apcprd03.prod.outlook.com (2603:1096:101:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 07:36:11 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 07:36:10 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, Alexandre Mergnat
	<amergnat@baylibre.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "mripard@kernel.org"
	<mripard@kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "simona.vetter@ffwll.ch" <simona.vetter@ffwll.ch>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"fparent@baylibre.com" <fparent@baylibre.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 3/6] drm/mediatek: add MT8365 SoC support
Thread-Topic: [PATCH v7 3/6] drm/mediatek: add MT8365 SoC support
Thread-Index: AQHbY2QU9vOuEs5BC0yehlyRevRljLNLVnEA
Date: Mon, 17 Feb 2025 07:36:10 +0000
Message-ID: <716394284d57715652f1f31c4b48b49d3a25262d.camel@mediatek.com>
References: <20231023-display-support-v7-0-6703f3e26831@baylibre.com>
	 <20231023-display-support-v7-3-6703f3e26831@baylibre.com>
In-Reply-To: <20231023-display-support-v7-3-6703f3e26831@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB8379:EE_
x-ms-office365-filtering-correlation-id: 39900fab-dbc2-4403-79b3-08dd4f25bfeb
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cCtMN096WHo3aGdKUWJWSHE5N29vMkJraGppNzJHN0lEN2tiekVtaGM3M2Jy?=
 =?utf-8?B?alpLa1d6RVB2OXo4dE82M24zdU1TL1NkRkRmOXNTa0VTd2ptOEpDSy9mM2JD?=
 =?utf-8?B?VExvWU9UTEpxRnVUTTVwYlpzQmFoOGdWMUR5N3JEUkFodGFiRDdRdFRwcW1v?=
 =?utf-8?B?c2Z5MzJVT1d4OEpzajh2eHN0VFJ6TVlaSWRvcnJZN3Zqa2FLSmRiNFA2U1RZ?=
 =?utf-8?B?YXQzSWUrSTcxWUVpSHptRklhSTkrMnVrUE5mKzN1SGsrRENOQWR1eHcxMzBv?=
 =?utf-8?B?WVVRd2JtSGQzemJOTjRkbW1aVTlqaXdXc2RrelFldHByMnBYbXpuTVI1UlM2?=
 =?utf-8?B?cy9PZDBUTkFCM3ViMzhXdWVGMFpVdEhpRGQrUTdYbmtJTmw3RUMzaEV5RTFC?=
 =?utf-8?B?cnlMeWRTdENuWHZJSmZPZDcyMVlRamJIeU1YZDl1ZlJPZHg0ZVhyRWdkbVRS?=
 =?utf-8?B?dG1aU004RmlINjY2QmFLb0Z6bkRZVVRYanlFS2labk00WHRGQmxNdzJJS01S?=
 =?utf-8?B?TGEzYmVSQnB2Z2xjVjVRcVMzeS9ZbmpxcGZEbFY2U25Oa2IyTWRLOHFuemRL?=
 =?utf-8?B?UnpjR0szcFRSMUJCSmhvM1gweC9kQVFIZmt3bDFVOVdBdDNJbGc4U2ROcVAz?=
 =?utf-8?B?YnhLbkFZTVZubTduc3gxd3pUQ2FsVlhGRWVTcnRYZTRjUDJocTNTcDA3anhH?=
 =?utf-8?B?ZWJhNlFKaFU2Q3dkeFU3aCtERFZyRGRqQkJqK3RKRC9YS1NrOEF0ZFVrYU9s?=
 =?utf-8?B?b0lUYlJyNTFpSmN1M0lZWTEyS3g0aFNKTEdBODVHMERPRTVkZjl4dTdBUnp0?=
 =?utf-8?B?aEZPR0I0N2FLbmFnYWJFVXMvcmk0dzF5a3pmVUZkQXdpcWhmbE5LbXVPNE90?=
 =?utf-8?B?MkozdFZRdFBkcDAvK2R5UURYR2Nvcy9pMnM0QU03eDVGT053cFI4dE5qVUl1?=
 =?utf-8?B?ZHgxQzl5cUVlL2xPWG4vT1lUMHVLaUtTeEZxNXE0dlpGR0dhMjNvMitRd3pT?=
 =?utf-8?B?czVIeWZSa1VkQzczSXpHOXNWeXhDZTlkODBHZ29rNjVITGVad3AwRDNvcGtm?=
 =?utf-8?B?OGVVTWE4TDFRK1dOUTRjR0JSVWRORzJESHJNSm92Y1NERU9tbHR3azJGc1ZI?=
 =?utf-8?B?UTMrUmM4Y3FFT2dxTk11TUpDT3kzWHYvMXVDd1lBWHFhQ080V3NBSjNQZzJ1?=
 =?utf-8?B?OXRwQThGbWRVUjQvWVF6cUlwaUxIODNpY2Q2cVVUTzNPZFVsQnlvdENUaUtJ?=
 =?utf-8?B?MDlhOGM3MCswVE9jODR4dXFVTnVhVHF2ZHA1VWhtK1czS1FuL0xzVk9GZndq?=
 =?utf-8?B?M0J0ZVZidmZmTHlMSTB1ZzBBa0RZSG9Hc2JzQXY2MjF4c05Obm1VMnBvZGhz?=
 =?utf-8?B?R1BIa3dZaFp5TjNvZGlUaXY5WjlkcDVhWnprNTZBeVJTeGp3ZEVldVhoRy81?=
 =?utf-8?B?SFExeU9ZTURJc0l2dkVxZXJWUG52Y2dtUlJRTVZOZVZwM1NSMG1FbVlTejBy?=
 =?utf-8?B?STZSSVNRNVoxVEVvdi9KOERFVkw4c1l0dHlsSlBXZWlUVC9IWE5adDNMZGNu?=
 =?utf-8?B?YnJqcUpacGJZNEgxN0k4N3dqcDMrWGFoODdNWGJJNCtkZ1ludHh2VHpucFM1?=
 =?utf-8?B?VU9FS2tlWEdwV01qcGFWb1ZDek5vTm8rZnc5NUVlZENlYVRCMXZKcVVxMnBH?=
 =?utf-8?B?YXpuMG1GNWkwYkQ1OXFEQ2I3RlJzc3p5UmxGUFdtZU5xNWZiaGZWcUdRSUda?=
 =?utf-8?B?ZkNOb1dZR2JGQ0FaOUVPT2xnS0psMFF3c3Vpd0t3R0JHYnVRTkR0aFBQdGZ6?=
 =?utf-8?B?K08yQzNJcE1OVG43dGpjMVN1ZnBvTkJOaFJlRm9oVmg4UHZBWTZ0anZ4MTlS?=
 =?utf-8?B?d3dqVHBtdnFzWk8vZ2QyS2VXeFFKWVZ6SFpYR3Z1TlArWTF5ZDhRN2l4TG5S?=
 =?utf-8?B?VmtzSTRVaHQwOERhZFVobW9nMk1JSVd2aURsejJiR0lVZzlXQy9HaGxSeHNj?=
 =?utf-8?B?RjN6bklKalNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU9BRk80UHRCVFBwa1JNczFvYW5naFJvUzFMemtJdUJ3M21iTGRaUlk3Y1lp?=
 =?utf-8?B?OWtlcGJKQUxyUTlXaTlrRTFoeXZTM2Njdkc2VGtYeVRuTE1TRmhiQmxhUmw2?=
 =?utf-8?B?L1lDSUEvMVpxcjZYcDBtdkN3SGc4ZzI0R3JKbEo0VVU3Sk9IeGk0V1l3a1Jh?=
 =?utf-8?B?clZLOE9hM3JXMnY5bVA4M0RWT0R4MGk2UmpnTmRVQmpaZkNaMXNxSE00bVBz?=
 =?utf-8?B?djZIdHNJNkZLTXJQbFVld0RZUE0zK0tqN0xpV0N6dXgxd09KYmhGYW11ZTcw?=
 =?utf-8?B?NitQcUh6cm9LUWhpcHlWdEd4ck4yZXMrUjAzY2tvSHliU3M2ckUvQUtjZ3Fw?=
 =?utf-8?B?MEhveVRnVFBCQjRsL3NNWFVZRUJjMElNbytoTTdrem5QTVRlRytsUEFNZGtr?=
 =?utf-8?B?QWtlMndMZ2xPdE1HVkNnL1NrT3FlNWtGdTcybHNDOUpFbG5RSC9MS2JKTHl1?=
 =?utf-8?B?dkxXZEVGYXZTSytuaDFPUHJQMkh5ZGZoQ0o2N1FDOXFBTTdTbGpKeTdXY1l1?=
 =?utf-8?B?Y3lqNnExZGZuS3p1RXRHSy81UlRxaUROZEJxQkVXN2pDS1dLWjFXcmZhNC8z?=
 =?utf-8?B?N20zUnJoTjJ5LzVTVDUrVFh3bTJHcXIyLzZiOW1oYXVSYzlkZktUV0d5WlF4?=
 =?utf-8?B?clRYQ1ZjcUpDbG1aZFlndmhDcDYwNk41ZUVmd1pycnFlYWV3K2krejIvd3NG?=
 =?utf-8?B?ZFVkTkdxTWhsQUR0ZUc5MnQ4UjFCR1JqQ1o2c0VKR0ZDaGQ0Y1I3RTdvT1VQ?=
 =?utf-8?B?TW5CelVsbm5iQyt6MWNQUldjMTM3bjVTNUt2SGRLUHg4T0ZUYU04bTRzS0FT?=
 =?utf-8?B?ZjdoY1NqL1FkR3BYVGNrenltMk1HWGhIZG51MStESU1HRm9sV09OMVFPK1pW?=
 =?utf-8?B?d01wd1AwV3VPQzhUYnkvc2R6M3lKRDdqejBwRjUwRDBUT2NJUEwrTE9nR3VC?=
 =?utf-8?B?dnFMdUE4VnN0YlJSZjBjSkgrTENpSFp6YTBrRDhIYzFHZ1Urb3g4cVdPanpZ?=
 =?utf-8?B?YmF3WWIyMGU3WVo4ell3STFhMWcxYnA1UU9NOWFkR3FnV3hOK0srVGFqVDVK?=
 =?utf-8?B?NWRybEFJNURpQmVTNWFKSXl5djNBWHlERnF0N0NvaThoZnhpeVhkNVdyTzVN?=
 =?utf-8?B?ck1LenlJQmFYU2F3ZnMyaXhMRzdNWVdmTUljeDhMVWxnYUttNU5SUnVJN1Zn?=
 =?utf-8?B?RGNDSkR0bVJNb2kxNDVxTG42bVJjVFl1WXg2TWhPNWpSUzZzOFdnSThiRFBO?=
 =?utf-8?B?cUcxZThaa0VVTVYvcGk0dDgwR21WRnB1WnNtaWNrdFpJRlNwV2d4U3oxdFB1?=
 =?utf-8?B?SGhNRjc2dysrQk5VTmtnNDV4dHB0S1JKeXNUQWtoWGZGbEtmSk5MdldVN25z?=
 =?utf-8?B?c0dhUlcvbExocWVhYWwvb3lGd2tscjd5cVJKby9DZVYvVy8zL0w5WlRtYzM5?=
 =?utf-8?B?K0g0VE5PMmlySGRpQkR5M2pReXU2ekdROVZsV3N6bEFwQ1pxR0Vib0xjNEFy?=
 =?utf-8?B?dlJvb2lXZlNUSm5BUnkxL3FsR29IR0FqL2dlaGViQ2I4KzNYRjVMb28xSGha?=
 =?utf-8?B?TEd3eHF0ZGN2UGpxaHpDZDRoVllNdlRyQndXS1Rpby9KRWMzd3ZqUzVPT1hq?=
 =?utf-8?B?c0czWnZNazJ0Nmo4ekc5REZjRTZsVlExc29acEdZdCs5TTU5a2U4b1hoTE9W?=
 =?utf-8?B?UzZkL1BmSm9CS0YzM05xSXUyKzErYjlacVB3VkRvc2gwaHlkUUJtcDlNdkUy?=
 =?utf-8?B?Q3Z6b3VhVDV3MlVFUGplb3AzcDNCdndGYXFSdytrV1NmVzMzRE8zcUkwTGE3?=
 =?utf-8?B?WGxPOE5HVWM2QzRBQjk0akEzWm1LYmh1NnRqb25rNEJBakVvR1hrY1NyVUta?=
 =?utf-8?B?elkyeVhWenhQbHRXYTR2cTBpS2VQb0Z4RTZZR3RjL084QXBvVkc5WGgyTjI3?=
 =?utf-8?B?WlpSYlZoNXZaeThkelNXZEF4S2UzaWFyeUdnZkU1NUlqcTVML1AvZWVhVjF1?=
 =?utf-8?B?S2J5WVJyWkNQUWp6VTYzQ0M2NHAwWnBCSzZrZnQ1cHFERmNRZ1NiTDFTTTRt?=
 =?utf-8?B?WS9mS3VyL2p2eWpxR0N1S2xzWEwvTk1LZVp5dHNRWXNzWlhFTW9tNDBWWkFS?=
 =?utf-8?Q?r2DBi7Nq2u+vq42QWBCkqy5aW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38081F64BC91EF448F1D08F4F19F89A9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39900fab-dbc2-4403-79b3-08dd4f25bfeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 07:36:10.8549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lI5zE5bS5B4M9gngL36XPsNv0oDRGBqp4hmLPt2PqjSloL2Zxi1xkghH8n4bItcsOwzeYhhsuZBg1k5Ho88cTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8379

T24gRnJpLCAyMDI1LTAxLTEwIGF0IDE0OjMxICswMTAwLCBhbWVyZ25hdEBiYXlsaWJyZS5jb20g
d3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gRnJvbTogRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJy
ZS5jb20+DQo+IA0KPiBBZGQgRFJNIHN1cHBvcnQgZm9yIE1UODM2NSBTb0MuDQoNClJldmlld2Vk
LWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBG
YWJpZW4gUGFyZW50IDxmcGFyZW50QGJheWxpYnJlLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9y
YS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXls
aWJyZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2
LmMgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBpbmRleCAwODI5Y2ViOTk2
N2MuLjU0NzFlZjc0NGNjMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZHJ2LmMNCj4gQEAgLTMyOCw2ICszMjgsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfbW1z
eXNfZHJpdmVyX2RhdGEgbXQ4MTk1X3Zkb3N5czFfZHJpdmVyX2RhdGEgPSB7DQo+ICAgICAgICAg
Lm1pbl9oZWlnaHQgPSAxLA0KPiAgfTsNCj4gDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19t
bXN5c19kcml2ZXJfZGF0YSBtdDgzNjVfbW1zeXNfZHJpdmVyX2RhdGEgPSB7DQo+ICsgICAgICAg
Lm1tc3lzX2Rldl9udW0gPSAxLA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgbXRrX2RybV9vZl9pZHNbXSA9IHsNCj4gICAgICAgICB7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10MjcwMS1tbXN5cyIsDQo+ICAgICAgICAgICAuZGF0YSA9ICZtdDI3MDFf
bW1zeXNfZHJpdmVyX2RhdGF9LA0KPiBAQCAtMzU1LDYgKzM1OSw4IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kcm1fb2ZfaWRzW10gPSB7DQo+ICAgICAgICAgICAuZGF0
YSA9ICZtdDgxOTVfdmRvc3lzMF9kcml2ZXJfZGF0YX0sDQo+ICAgICAgICAgeyAuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxOTUtdmRvc3lzMSIsDQo+ICAgICAgICAgICAuZGF0YSA9ICZtdDgx
OTVfdmRvc3lzMV9kcml2ZXJfZGF0YX0sDQo+ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgzNjUtbW1zeXMiLA0KPiArICAgICAgICAgLmRhdGEgPSAmbXQ4MzY1X21tc3lzX2Ry
aXZlcl9kYXRhfSwNCj4gICAgICAgICB7IH0NCj4gIH07DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxF
KG9mLCBtdGtfZHJtX29mX2lkcyk7DQo+IEBAIC03NTEsNiArNzU3LDggQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2RkcF9jb21wX2R0X2lkc1tdID0gew0KPiAgICAgICAg
ICAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX01VVEVYIH0sDQo+ICAgICAgICAgeyAuY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtZGlzcC1tdXRleCIsDQo+ICAgICAgICAgICAuZGF0YSA9
ICh2b2lkICopTVRLX0RJU1BfTVVURVggfSwNCj4gKyAgICAgICB7IC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODM2NS1kaXNwLW11dGV4IiwNCj4gKyAgICAgICAgIC5kYXRhID0gKHZvaWQgKilN
VEtfRElTUF9NVVRFWCB9LA0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTczLWRpc3Atb2QiLA0KPiAgICAgICAgICAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX09EIH0s
DQo+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtZGlzcC1vdmwiLA0K
PiANCj4gLS0NCj4gMi4yNS4xDQo+IA0KDQo=

