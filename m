Return-Path: <linux-kernel+bounces-527026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7030A40665
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8AE705F36
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACDD2066DE;
	Sat, 22 Feb 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BRWuew22";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="A6fniXwi"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA82AF04;
	Sat, 22 Feb 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213367; cv=fail; b=jcDY3/qDwU1Y7GyPi0MK9DEgk1d3G+tYfEh+kqx8mWQ35stb6NDUaHKObN4Pexh3xUNZSb/sV4VCeNXUeHivGGgWu4AA2+R5lwoKd1J7i8SwJ7DWX4WSvw/IUqcCpUfdFpVSf9vi5vAM3B7AF8Fumvnh+3Gkf2hQjB1cpOCO+JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213367; c=relaxed/simple;
	bh=D/ji+GaAgry1BsD6mb26fJHb/Tol8Lr6vobwZDECqr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BZWRTSK44QoIrumuq8kEA2bTJRcWx2Sk1jrTzzc0MneTxru4B/LFtr0nzGNEKIvfLoseO3EMaCaH5PUIMJhKqakuFCZk9q+Q87V1VnLY/8KfRTSxjMLOPlhBVoEiRewsUUs3O8SIcv4az8a25V/QnQivsEzI01lJY5LZYFMIAZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BRWuew22; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=A6fniXwi; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0a941be8f0f811ef8eb9c36241bbb6fb-20250222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=D/ji+GaAgry1BsD6mb26fJHb/Tol8Lr6vobwZDECqr0=;
	b=BRWuew22VyPkWGr3mxKJDdu8B7zi6lktM+6U+0opzTJGxAbiwgiOQwNy0EWd8ykA3duYoVWYvA1NM9nGWql68e3TG+/zyLcgo+RXlZltLfW3i2vrxhev2Pe93a3kvC/qgU/zArOjlmvqNbLcggY51/zh8ukG/O09rz63apUgdZE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:2660351a-b2e8-4d80-ad38-faf3357cb85d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:54651e29-e0f8-414e-b8c3-b75c08217be8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0a941be8f0f811ef8eb9c36241bbb6fb-20250222
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 875626093; Sat, 22 Feb 2025 16:35:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 22 Feb 2025 16:35:57 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sat, 22 Feb 2025 16:35:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jovUHro09CDypSw/6KAdKzsDrUKGGOy6me49uSgtw8lSPIajc6WJOvWKqqVrJihbOSUc4qiiJp8uLmKu/GyYU+6OPvyWO4BmMagEZpW3l3VSXfUvKxjoCf0tX6FnH9OO/kVLTwBSirj/1newbPeU9dVUmPbTQIKSVwPZwq+ds1Bod3YwCy+VaTtZGgBpxJB3Z/ypKBB5BfZE4dr2AkfNtbg5yzJn+0+1dajzpqrW6UfygjO8J8Hr/pbMqeF3/Vkjjqm3P63eBVYbAHf5C7pthL3h7GmgJkquvyZm3UIitJBkhVov6/GKvAKRWWScqZmGQ52DwsRqn9rBvb5GkvZFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/ji+GaAgry1BsD6mb26fJHb/Tol8Lr6vobwZDECqr0=;
 b=zHIzm87V+s57BE+LS9426EdJU9gzN9p9HyA7bWatTEWb6PDhzcSf5YFyYSyN8ed/9SRvtq+PaL2fe37VLbBWYskIjuiTCzqPg49wnT7JJtzqmmsLwmTulh1UHf223O0jOxuGfCs0+C+NBiuxQRMEbeRbc3Y8ZfunzcHxKcn3zdup8mG57BC5dpb8vHQKakJfxSZ04A5IFKk+M9dUiSO8aFOousWNavt+4ECCLiFdUlA/RYNBJlDVmiSK1JlU4nD7vZ02+F42bp2I9q+USUKAQsTDAapjYf26auvj6N3+NNZmIBMfSGO1Z8No27K/AT7r4pG3GQlTPtrOUEkteIeppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/ji+GaAgry1BsD6mb26fJHb/Tol8Lr6vobwZDECqr0=;
 b=A6fniXwiCp4/EUGlORpK8ocMFwCgEu7ATCGXs6FWdjCL2ybhcCkxCobqyUMDqTVGYw/J9pv58sjm7WGud4Edleyv2UUbXAAg3m3SFRln1pBgEflQWM7OGGk5PgcRp46s4HrLR/M9K+TsLOtQAoX1pHr0hhvBOJT9fgGrTtVNFAY=
Received: from PSAPR03MB6236.apcprd03.prod.outlook.com (2603:1096:301:9d::13)
 by OSQPR03MB8598.apcprd03.prod.outlook.com (2603:1096:604:296::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 08:35:54 +0000
Received: from PSAPR03MB6236.apcprd03.prod.outlook.com
 ([fe80::2b28:30c4:61a8:20f6]) by PSAPR03MB6236.apcprd03.prod.outlook.com
 ([fe80::2b28:30c4:61a8:20f6%7]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 08:35:53 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "macpaul@gmail.com" <macpaul@gmail.com>,
	=?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	=?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
	<Chris-qj.Chen@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
	<pablo.sun@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] dt-bindings: usb: mtu3: Add ports property
Thread-Topic: [PATCH] dt-bindings: usb: mtu3: Add ports property
Thread-Index: AQHbg6L21nkH2IZm4kWLHrX44ZXGfbNTAkiA
Date: Sat, 22 Feb 2025 08:35:53 +0000
Message-ID: <0e58bfb8f2f7b7e83e3da6075986ddbcc84531fc.camel@mediatek.com>
References: <20250220142230.2530583-1-macpaul.lin@mediatek.com>
In-Reply-To: <20250220142230.2530583-1-macpaul.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6236:EE_|OSQPR03MB8598:EE_
x-ms-office365-filtering-correlation-id: 5af5def7-a8fe-4ba0-3ab1-08dd531beb9a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?TC9FaGgydDY0YXlZTWNSb0Y5dG4rWjZaK0tEZDJESjFEN1RXSFBBVGlWSHlZ?=
 =?utf-8?B?SlpNZkpEdDRyWnJDZjR2eThmQlFSSjU3eit3QXcybTNKRWhVWXd4MUtvcTFN?=
 =?utf-8?B?VVdWbVhpMlU2aEs4WnhkRjl4WUwwYlBQNXRIL1huWlEwR1lNNVlqWDdwZ2Qx?=
 =?utf-8?B?d1E2SHh3eXVWbDVucTVyblRBQWRsTmcvTFpJWHFZMFl0MmZJSTEwaWJFUGND?=
 =?utf-8?B?bWNTc3JMamZkRTdpQk8zbWRLYzNIa2V2WE1KSjlRT1dXWG1sZGlVdXdFS3VT?=
 =?utf-8?B?TWFuUkZrV2hnT0hEK2lXSVZIVGI3bWhyYU5SNUcwRUcrTTJnZ1RhTXpEUXAr?=
 =?utf-8?B?WEV0eHdpZzF1M2pIT0lyVC80d1pPcW83T3V3QUQ0VElVbkpBMm1zWWEzZU1s?=
 =?utf-8?B?RmdTMnNqR2dnYlowN2JIZm9QMFoxQjJZMUhjWUNmU3hOWFFVWm1Fb3hvV2Ns?=
 =?utf-8?B?Q29JSUROVGdTQ3N6dWFYSkxzRS9PaWxVNlRPZHBtUTd6SVJyeFJiTzRFMDU4?=
 =?utf-8?B?MDJCSWxmVmE5aDhtTEtzS0ZKTjBNQ2dOK05Dck8zSVZ5aVpmYjh0cE1PMFds?=
 =?utf-8?B?Y0oxU2V6dWdwRC9jR1RKSS9CUWlWS0M2Nk15REllY3NOV01NNTJMUmlDZXFG?=
 =?utf-8?B?d2x5OUtGc1cvdFZxOE40TGlGMldoRmJ1Q3ZoTGVXdkhHV1RDSkd0dGVVOG5B?=
 =?utf-8?B?dDJTVEUrU2FDUTU2NkhaRE92d2JrTXRJdDdmelFHYWx0amF5YXRXdFp6UHgy?=
 =?utf-8?B?WUt6SFZaVHhVcEliSHZQSTMrNktYdFpxUVpWZ0Y2QVpsdFdEMjBrR0FlQk5E?=
 =?utf-8?B?cmhqMmpKRndQQ251OGtmVmlRUUhqWDRib2lJTVZhV1ZFdkprVUdlY1B0ZzZX?=
 =?utf-8?B?cFdFRmoyZmNKZEtYUTRKVEswS1RoNXo4aEFQdTVKV21WYlJxaUMzZkVEQmQ5?=
 =?utf-8?B?Z2FCaXJJeTRncWJhL0NxYiswMFVnaHhmM2RGNWlMQjAvaDlQbXo1MktOWWNB?=
 =?utf-8?B?MnZaM2pwL0RkWEFIRmxiVE9FdDJJbFJqY0pScmdEcXVmV3RuWGYvdzNpNWJj?=
 =?utf-8?B?M3JsNEwrWlNCcjY0VVE1Tmh0SW9CRlZCSFlyeUV5VmZMVVhoNW5WNWQxbUpr?=
 =?utf-8?B?WTJmVDB4WU9NMHZ6R085dUVTWGYra3pwS1ZJMUlhamVONXZScFNtcFRUdXNR?=
 =?utf-8?B?dkI0STdwY1J6azVZL2dmVTJUaTRFTGU4VzlZTEM5ZjVnUVV1aXQ3WktUQVRj?=
 =?utf-8?B?NU9LSlRXMUhvbHA3dXpWMXQ1cEhINjA5M2dBQVZkOHU5TjlPa1dRVm9zTGdM?=
 =?utf-8?B?bk1yak1teE42RFovUWpvMzlzMjFxV2I1Y2xmWkg5WUt2TXI0ME1JZ1FrVXlH?=
 =?utf-8?B?V3dlSEg5VGd6OXVVS2JWbDdLTWZlR3piMVljOW1POW9zZnR0c3dhdHZncDRm?=
 =?utf-8?B?V3AzZEt2bzh4NVVVQ1VCSDkvU0VGYTVEaWcxNFByUGt3a3dTc0dGWHViVmU1?=
 =?utf-8?B?T1BNbzFreXZyNGRPU1FWZjVzOS9VbVIrQlg4a1IzSDF6NzVjSEp6bDBFOWJV?=
 =?utf-8?B?TVJUSmUrbm9LYWlkT01ReVZ1dkl2M1ZaU2tEaEp6VkJZMWNFcXRrYVBDY0hJ?=
 =?utf-8?B?T1lobkQzdFl0MHZ1TVJiUDJEWkxYYlhwRlVsd2hvMmZkYnpkWFZ0bS9HWWFa?=
 =?utf-8?B?cEVvNVhwWE9sU3JxbFYzWjhtWDNkaTdnUEl5SUZtMnhYRk1Qc2tMVVZKZ0c1?=
 =?utf-8?B?VEtDamp6SlNYL1laTmFTc25xSWdCN2FJbGJZNXRPUzJXNVlQNkVPWGJLcjdE?=
 =?utf-8?B?U0Y1ZWVZdUFzSnRCNXo1ZlRiK0pQV040NzFYb2RRQ0hFb1F3WG93U2tmNkto?=
 =?utf-8?B?T1NNSjIzSmRSM0lpQ3JKcHZSU1NMZnJsYytkLy82cmZmdVZhUFNwTmNaaGpK?=
 =?utf-8?B?UzNaWFdsRG16d2x3Vm1ockpvL1g1bkI1aHExOU9PZ1c3M1ZZbDRGcjJvWFcv?=
 =?utf-8?B?aVBWVlN1b2lRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6236.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0NMbjdFR2RlRW9aZmhJY21ZKzg1dEN6VUtTK2UwelpwWjF5Q0xkQUdtZmhT?=
 =?utf-8?B?NlNGSGRSalNmYk9sdzFaMEV6RVY0Nm15b1cweHlabk96aVVsbXFuWWJSR1Ur?=
 =?utf-8?B?ODFSRWVmWU1Sb29lRGtYWlBkRER2OWMvZi9Rc1pMaTUwRXFSZTdsTEQraHdS?=
 =?utf-8?B?VWVTeE0yTDhrQjhaTS9WTjcvTXhPOWJNcXpoV2N4MjdIT2x4eFVIbVZ0MnVJ?=
 =?utf-8?B?dER3VHFNT3VPN2pnM0hoU0Q5UW11Y3ozK1B1bkVQMVJnNGZxWnN1SHpaeFNV?=
 =?utf-8?B?bUFsbUJXRW1CQk9UdmsvdXNtVHRFeGxwa2Y4K1p2WlVOYTB5V0RvTUVVcHk0?=
 =?utf-8?B?Q3N2Z2V5b1RFcjlCRTVubG9jM0FNOS96SFR6cXhEZG1qbW95MHBXTjJaTnQw?=
 =?utf-8?B?T2tqVUhLanlCb1Z6cUtxSklySUJyNFJCOVJiKytGL2xjMkhRYnh1aHV3dy8v?=
 =?utf-8?B?SXA5ZDB3QXpuLzk0TnJBZXJsOWZjSDRQbzBrekJ6OTE3bEVGZHBtaUZyQ0dm?=
 =?utf-8?B?QUFLTFR6eXhYQitHTjJoU2s0eFNqelR2ZFJ1Q2FROUdSS09RQThrR3BCYkRJ?=
 =?utf-8?B?ZWhVUkx3YVNPOE5oam5BclovSExxNG03cFAwcFNGZGhsaFIvKzhWUUxoaUIz?=
 =?utf-8?B?VVFEQnI0VUQ4emtEa1hMdEZpZmkvTEFPVkRkL2FJN3N3M1RFQlQrcmIwN1BY?=
 =?utf-8?B?L243bUlKdTdGTXZSb1l1Y2lSaFNpcTFGeHc0UmY4YzQ1TzVrOXFNOGtialI0?=
 =?utf-8?B?WnNoM05sbDdZNTYyYWdXTzBDbkRYbm1NM3lWUTd1Ti9SWWpMUnduV3lJMGgw?=
 =?utf-8?B?b0xKS1MyS2RIY2h4SG1Caml2SWF3aS9Kemk3aHllNVU1VG1ORTFvYkdjZ09r?=
 =?utf-8?B?QXZLemxEOVRZUDNJc1BYM2JHOUhObVNNOVZld2pOSlB6R0lYRDMvcHRCeWVz?=
 =?utf-8?B?ZjhMaUhvdWVlZmhnL1RkVEZSNEM4UFVaRERnQVhQd3JPMzdLcXRsVmlpclQ5?=
 =?utf-8?B?L0JTK0hRRzNGQ2NETjhHNjNVU1dTM1JQSWxzVXpRd21jc0hTeHNUbEEwQ2xi?=
 =?utf-8?B?V2tDdmZtYXg5VlNhUTFQRmE4cGJqODJudnJ0TmtLNWVzMTM5WXdueEk1eVk1?=
 =?utf-8?B?VVhVcU9nVnVCeGQ2ZFBnU2Q4SzBRTVJlcUlyczg1MCtxSHovOWIwNkdubEN0?=
 =?utf-8?B?bnFJQnVRWUsrNVV3VzZJNGVXbXFJSlpOckFJUDlXNm94MldtSG8rOE9yUmtz?=
 =?utf-8?B?cHFZb3ZlblNJbGpEVGxEQjErN0VoYTNVSG1XUS9jZ0piVHdxOTlvNkVsYmdm?=
 =?utf-8?B?SHpsTEpMY1oxbVpIdGp4dngraGFyUWprb3ZPbTVpSlUxUnJIbCs1WGg5NTdX?=
 =?utf-8?B?SG1yTldxTWNSWHhTUFd0bkZRdTg5eEJZWm1tanFnRWVOYVBmRmhFNlBkMUp2?=
 =?utf-8?B?NmlZcmh4NFV3VGRtSUtWNFVGNnU0YlFSbmh4bmFCMWFvcFQrYjUxQ3dFQnNO?=
 =?utf-8?B?OHQweTVSMGFacXVFWWlrZDFLc2JsU0kvTzl0Sm9tdWdjYnFzV1QwcFcxU0Rs?=
 =?utf-8?B?RTY3cHFvSkxSYVBIbWNoS3grbmRxc2NQR0t3ZnZMbWZ3STZBWG94Z0RWSkR6?=
 =?utf-8?B?WUhYMG1zZHQwR29VemRvZDBlUWp5MmhDM2hKRmZsMVd5a0FLOFoxOE9Mb25P?=
 =?utf-8?B?aFlSbGprNUJVc052WFVLR050QWc4eEFIdnpJTkc2eGNoMUxrRlhIOXp6N1RT?=
 =?utf-8?B?RHdLRU1nejlEVVpMSExMNmlSSWE4M1R0bVpqbjZJUGdMSjVySWQ4SWpHdG5i?=
 =?utf-8?B?NTBsLzF5eEd5R01KdUhXdHZoUEU4dGlMd0VBbGhvRXpBUXlDNG85TTIvVTNu?=
 =?utf-8?B?VFBFcnh6bk04SEx5czJudDVJVGRXTFVsaXc5WWZZUmpLRm0vaXZmVEpzWjdm?=
 =?utf-8?B?ZzhVSlM1dnBNa21KSk1EK0hlMGErWFBYV3JtZUJRcEFiUGxwbnVBK1hPeU5X?=
 =?utf-8?B?dkJvWWx1bGlQTDdOL1ZNdncvOUhBaGMvZTRWMC9sNTRHdmdGb0JoNTAzMVJi?=
 =?utf-8?B?WGRnem1lK1VmbElkeXdzbzhGWmpBVSt5MGg2MGE5ZzlyR3ZvckNZanhXVzBO?=
 =?utf-8?B?bmsrSmZNRmREQWthdGJURS9CRlRtdFdqeTRwcVhHWGtoaEJ0SERycjFrdk5V?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1DEF47644D495469E1F225CE7F152D3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6236.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af5def7-a8fe-4ba0-3ab1-08dd531beb9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 08:35:53.7558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXLciSfD3KPRx3zSBCGncPJD1uoGyBzaqOJxfte96VeUJm6cXLE1EToDPg3gvczdO99hdqoUBFSkkdc1gcMCXZWo35RLOxGmnui/SBblpR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8598
X-MTK: N

T24gVGh1LCAyMDI1LTAyLTIwIGF0IDIyOjIyICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4g
RGVmaW5lIHRoZSBwb3J0cyBwcm9wZXJ0eSBpbiB0aGUgbWVkaWF0ZWssbXR1MyBkZXZpY2UgdHJl
ZSBiaW5kaW5nDQo+IHNjaGVtYS4NCj4gSW5jbHVkZSBkZWZpbml0aW9ucyBmb3IgcG9ydEAwIGFu
ZCBwb3J0QDEsIHNwZWNpZnlpbmcgdGhlaXIgcm9sZXMgYXMNCj4gSGlnaCBTcGVlZCAoSFMpIGFu
ZCBTdXBlciBTcGVlZCAoU1MpIGRhdGEgYnVzZXMsIHJlc3BlY3RpdmVseS4NCj4gDQo+IFN1Z2dl
c3RlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5v
LmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxt
YWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvdXNiL21lZGlhdGVrLG10dTMueWFtbCAgICAgICB8IDEyDQo+ICsrKysrKysrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbA0KPiBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXR1My55YW1s
DQo+IGluZGV4IGQ0ZTE4N2M3OGEwYi4uMjFmYzZiYmU5NTRmIDEwMDY0NA0KPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbA0KPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMu
eWFtbA0KPiBAQCAtMTU1LDYgKzE1NSwxOCBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgcHJvcGVy
dHkgaXMgdXNlZC4gU2VlIGdyYXBoLnR4dA0KPiAgICAgICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlh
bWwjL3Byb3BlcnRpZXMvcG9ydA0KPiAgDQo+ICsgIHBvcnRzOg0KPiArICAgICRyZWY6IC9zY2hl
bWFzL2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMvcG9ydHMNCj4gKw0KPiArICAgIHByb3BlcnRpZXM6
DQo+ICsgICAgICBwb3J0QDA6DQo+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlhbWwj
L3Byb3BlcnRpZXMvcG9ydA0KPiArICAgICAgICBkZXNjcmlwdGlvbjogSGlnaCBTcGVlZCAoSFMp
IGRhdGEgYnVzLg0KPiArDQo+ICsgICAgICBwb3J0QDE6DQo+ICsgICAgICAgICRyZWY6IC9zY2hl
bWFzL2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMvcG9ydA0KPiArICAgICAgICBkZXNjcmlwdGlvbjog
U3VwZXIgU3BlZWQgKFNTKSBkYXRhIGJ1cy4NCj4gKw0KPiAgICBlbmFibGUtbWFudWFsLWRyZDoN
Cj4gICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9mbGFnDQo+ICAg
ICAgZGVzY3JpcHRpb246DQpSZXZpZXdlZC1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5A
bWVkaWF0ZWsuY29tPg0KDQpUaGFuayB5b3UNCg0K

