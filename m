Return-Path: <linux-kernel+bounces-295091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D7E95969D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB56B1F23D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8122E1A4AAE;
	Wed, 21 Aug 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IxOViR4L";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="C40cexcf"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FAB1A4AA4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227281; cv=fail; b=NBdUhhOEm5U/t+ES5+l8vhJABVrvJRj53eUNsaZmya4RS7SBSYmYIhbOXYaXiKovUTH0n7vNsE+Szs7ycRXC/YBbkK8atwKi6Qun6zTuCoQziSvGKtMd6wF3KWiCanmQJ20e9Q9muCwt3S1wnKRNzWkuqL3sgLWsLp6F01GiSs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227281; c=relaxed/simple;
	bh=NItw2eMC3aWZv1M7N/19mK2GlT7j9M7IzYxZsH7SFKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UN6rrUi7Rj+CtrVtELZ5bp5rciPBHOgUErXrmuR1iDd79kVN+0vjYBnX6ytsrMBIUPs/na5NDVQmsTHua9YoPXz1Ar0T9my8H9h/STqns6bdV30qA//AnnGIEo2A4rSaSg/ht3aoxyRTbQ/TdQ2/CmrPkUKGuBHUYw0KDOP3fcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IxOViR4L; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=C40cexcf; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 832c73b25f9311ef8593d301e5c8a9c0-20240821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NItw2eMC3aWZv1M7N/19mK2GlT7j9M7IzYxZsH7SFKw=;
	b=IxOViR4LQ0j6XPRfVZk8MW8GR8GCI+E4ufsyUAcnYpW12iOe9SBsHyk7zQE+u1O/PPfDEcofnIijOkHAlLWY12Cm+576lfpQJMz0Tj8CWBJmta7gDMBqofZT5En7e5hni9UkYEAwrsCkH7oo7Lq4t5jZhCRGxc5v4rjQrySgshY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f6c3abd3-9ff5-463e-b06d-6716e648fe6f,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:6266ca5b-248b-45cb-bde8-d789f49f4e1e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 832c73b25f9311ef8593d301e5c8a9c0-20240821
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 793251015; Wed, 21 Aug 2024 16:01:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Aug 2024 16:01:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 21 Aug 2024 16:01:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAUvohFopi1t6zF4qO4Ie3ReTht/P3w/il0i/oOt0aGwR5jqAPgByDGzSUT6IZVP7gsIuzJp4XdT4RbeXUoVJvMzBCkSeJV1dVuMXESK9cW0gC5VkN/AcawQfOCiesCsoIC0tdjWKNRzxM2zzV9mTblwGyqU3rXOAQJYzlsAi2lIZ3Gq9hgbvvZYCjnt0r6e+VCY16uodxeH7sTvXnnCIaodOyuEa7aqzG26R0GMsKtUUTwNXQiXeqm7DBqsxEDQGw3opwi2v8m3IrAp3vDTDAsti8d99aR7JW0gsjcMpaaZsVXpKTrte3OmuORDI5pAqeF9mzD7wiwl/gRWpBHWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NItw2eMC3aWZv1M7N/19mK2GlT7j9M7IzYxZsH7SFKw=;
 b=lD1p/UDhO38pgttz3J8lvQ0xKMZtqy8o5Yfxx8GdjFsPqX/RX42Hn6ALguikmpqdG60izWGwLTURfcafMc7kwBnthgMqnN1C3EjONqTe0nCzIPxptfAufdTjT9I5Vaivh6LyPknPlv23W66rUDsXnz5v9eL9Tq8DcBEE3T2TbK396yze+8aI32CCQ//zTRxdSnOKGWWo1R4BAggpw4jYE82cAW9LcINDWUpJQWng0MeYsEIvH+PsY8uqv2QlHarevrqRoqMMtiDTwvJVTMXlm1JEuxFa1tTRcEP0pfOPmw5bXn9DwTYEJWkkHtOXDAeDnIrjXNEfDWb8dsPosW2Ryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NItw2eMC3aWZv1M7N/19mK2GlT7j9M7IzYxZsH7SFKw=;
 b=C40cexcfe2A0HT3M5b5jQTqlb9UjSCI0pDlV6skPux5NBxJ/he/+qsTEIjBfUR/7eVBwf0z3BRWxGR8dbnTyTm47yhjadWOWZ4R3l8UFdZrOmv7fXRocUtQRLDppeX1cobZ7xn7ae5eU7LErCF6sUv7JtILLsed4GF7y6R/Kq/c=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEZPR03MB8709.apcprd03.prod.outlook.com (2603:1096:101:231::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.25; Wed, 21 Aug 2024 08:01:01 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 08:01:00 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>, "honghui.zhang@mediatek.com"
	<honghui.zhang@mediatek.com>, "jroedel@suse.de" <jroedel@suse.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "rongqianfeng@vivo.com"
	<rongqianfeng@vivo.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] memory: mtk-smi: Use devm_clk_get_enabled()
Thread-Topic: [PATCH v2] memory: mtk-smi: Use devm_clk_get_enabled()
Thread-Index: AQHa83nqfI80p6o0Uki/MUXTgur3arIxWZCA
Date: Wed, 21 Aug 2024 08:01:00 +0000
Message-ID: <20bf47ec857e02a61477dd9eefc19a7a1bc963ed.camel@mediatek.com>
References: <20240821032558.43052-1-rongqianfeng@vivo.com>
In-Reply-To: <20240821032558.43052-1-rongqianfeng@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEZPR03MB8709:EE_
x-ms-office365-filtering-correlation-id: ab6020d6-a808-4ccf-a057-08dcc1b765b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VW83WjRxbGxYT0VYbjBWQ2NEb2FkbXM4cVhFSkYvUUFPeUhXYmtHKzNPeER3?=
 =?utf-8?B?VlNCV3lEUXpHUzVzRlZmRitNdnRIUXVPS0pUNERXaTZ2Skt4UERCQldodU1Q?=
 =?utf-8?B?Mi8zemtvQVhLZldVaEwrcUdsaWY5YnZ4ZkQ2ZVhVQTd6Vk51WVBtcDZQWXVi?=
 =?utf-8?B?Wm9ObUxWUytvQzJtK0hiZm5PM3c2MXJkVTRiVUVWd21tNUtjVVRWS0poM2Er?=
 =?utf-8?B?L3FUNG5PUm42WWdjMFIyclU1dTNXMzZ6dW9xbTJRVkE2ZW54Wjdma3FkWkJ5?=
 =?utf-8?B?L05QeW9tNWNTR2M4a0x0SFZnQXcvS3o0eThBckI4eHFkTWVydkdwOFh2TWpG?=
 =?utf-8?B?bG9FRENYV3UySGJkRWwvUkl4amlVdWdaUHhEd3hHYWdxaHp6SEJFZDhNbEpO?=
 =?utf-8?B?enhtN1VKOVBzZG5kVU5vNjJlWEVaZ0w5UzcwTXdtNU5FckRISHRvT0MwVVF1?=
 =?utf-8?B?M2JBN0xJVldjYUhTUjF4RWZjZWlkRHBvUHlGLzVGRERNNW5MR1VlVXVGVkM5?=
 =?utf-8?B?b0MxQWlkQ08yOTM1Lzl5YS9YRlRaQVZXUEdWb1FibFRML3cybjhjQ000WFFN?=
 =?utf-8?B?L1NwN2dWVW4ybEZuNWp1Mm5OQUZYT1dWc0pHd0txWmM2bVZxUU0zVDd1aGRM?=
 =?utf-8?B?VVZWNDRxMnhHVzY1VTBmWWNZZlROdCtocW9WQUc4djAxVmFJU2hKMzdJcDdp?=
 =?utf-8?B?enQvaHpuWG45OXFDYy9XOWlSWjBkdThXWXpoY0xGbnhJaUh2MnRlLzk5NkEv?=
 =?utf-8?B?d0FBaXhVOE5tbVlmK3ZDQ2hhS0YrbmJMZktqdTRZcDVnUldrUmpkU0RhbURx?=
 =?utf-8?B?Y0tYRlVJUHlBVmlkN2RCRHlXYkQzcWhReEluNDNjbkkrYThKaVNvZUNJY2Vi?=
 =?utf-8?B?dmE0SFhOMmxQTmZvbXFMMENqV1FiRHQ0VEljV0lNNGxOZkRTT3M1Yll6N2tz?=
 =?utf-8?B?R0RSeHpKMlBUbnJyWnQwZEVEWm1NZzhZU3FvMHJ3YldOcFV0dWJnSSs1MkEy?=
 =?utf-8?B?blVkVmtrWXVCaHBQZkN1aXM5bTgrd0lYV1NPSEJaV0dpdU9JUTNhR1ZQSStV?=
 =?utf-8?B?clhNcXF0SGNnU0ZFS2pXR3FVeFMwMzhjeW9scXA1OFVFc2xpUGE1Q2RjWXJ6?=
 =?utf-8?B?MVhBOG1GaWhCUFEybGlyc2xvR2p3ZXllc0s2RzVmRUFRZ1RVV2ZoQlVJMExl?=
 =?utf-8?B?NG1QdDRZeGtWaUhzbUhSaTZpakwwRjU5RGZIQ21iNThoeE42N2Z1b0N0dzRZ?=
 =?utf-8?B?WXoza3VXMmU0TndCZm1IN3l3dFN5VDhMUEQvUGYrQWJSUXZwYzBDWlNwQkJD?=
 =?utf-8?B?UFRrNm5jSjk2U2VDY0FJanFzNDZ2cVB4cFNTTDVJM0UxaVN2NERpbmFHbHdx?=
 =?utf-8?B?RWlNQ1pIa3RNY0J3WHFhUG5qcjg2a1grQklLK3p0SzJobE5pMjFjcjlEQVFK?=
 =?utf-8?B?ZHozWEdFU1lRcmNabEdLWTFYaGg2bSsxUk8xeHczdzB0KzRHMXJ1RHN2UzVD?=
 =?utf-8?B?L0lxM3E1R0FIUG93djhreFUwTFdKQTZSUFd0RzVHdnNFVzJ5OVRKVkJBTE1p?=
 =?utf-8?B?SGVjN0pEelo2amJ2My9tdDIwcnFqZXR0Uitibzhna0IyV2g5TjgwR0IzNWdy?=
 =?utf-8?B?bEtCTTF6MDFKT1RYNERBRG41OWMwSEoxd0kvUm1HZDlicHZGbkRCWTB6MSty?=
 =?utf-8?B?b2VHQ2RxQXJ2eTZxa3JaT0JSRVg5c0JaaHg1RlFsb1FvRXhodFdnYU1mUjFY?=
 =?utf-8?B?SVIwZjdtaE93dHl2QXBOd2huZEJWcTZwNHNDYnlqam0waWV0RWIvN3RFZTBC?=
 =?utf-8?B?ZEJpZzFBSnAzSGloK2wzUzF1QW9tWXN2Wm9kdDRSTXM4clVRMTIwUkliK3l3?=
 =?utf-8?B?T0dERWdBR2Y5QnAwdTBZL3d6WTNCWVErenphRElKYmczWlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2RPNUlveENlUU83aEdnRmpTM1JkTHNIaWFEV2I3aEhwamlkSlM4KzU3LzU3?=
 =?utf-8?B?OTBvdi9vYml0K0ZTa1JZQmNsYUplY3FPK3ZTUllxSEdteGhRayt1dThMd1M2?=
 =?utf-8?B?Q1RxR0dGRUVKL2twOGdhT2c0YytUcUpWTGpja1pNRTFUY0ppdTdKQmpMejR4?=
 =?utf-8?B?MXR5TXFLdEtuSm41OTh2czdSd1Q2U00rdTdDQ0F6YzJCNW50SGtaMERvUngy?=
 =?utf-8?B?b3gzeXRyNEtPZzFsVkc2UkgyNjlBN0ZxLzNWTzdHQUk0YkhHaTBpVFN3eGtB?=
 =?utf-8?B?dmNlRE5RYXZsUWU4eTNDZnlPZGRyWTk5RCtFMHMzNndtN01sMnF6dnpDWTM5?=
 =?utf-8?B?MmhzaEZCN2R1VW1vWlFZQXRLV0VyUm9PRWFJMXd4dTI2aDVLR3dyOEZnWkpi?=
 =?utf-8?B?OVRoRXJxc2J5bWlkdGhhTmtwTFBTS3h0VVJOWkdFRHRRdE5EMU9PS01STXA4?=
 =?utf-8?B?L3YyRHlTaTZLT1NhUHNQeFVBYzV3M1hXVlZQQVR2bC9BSS9XcjU2K2FJZlFk?=
 =?utf-8?B?WGN6c3ZJdWkxMUF6MTRSS1U2SmtneWhYMUhDU3Z5OFI1dnJjVFZEaHZJMStJ?=
 =?utf-8?B?TmMzRU9Rd0RyQ2Y5YUdzYjY0NU9qRW5zRlJPdVdEbTd1clpRcGJKU1RhTnlH?=
 =?utf-8?B?YUErc012ZlFZcmJwcmdGd1BtZnpzL2M3R3hsT1RiTnFncVJqaVMvWDBCWVZ2?=
 =?utf-8?B?Y09hczU0dDFKRXdIeFovd2x2dGpqWU5md1dBSUVHTFhwbjN4UVRBNHdZam9l?=
 =?utf-8?B?dE02VUhNWVU1aGFMMnBiQXVDcVpseDdWa2RIZGJueG15N0VRWlVPWWNhemFP?=
 =?utf-8?B?bUx5QmFWVlBKcSsvQmNlMVN4V1lML3lOZXhlNE9GcEdQcmJuZFhpWkVJa05L?=
 =?utf-8?B?WjB5eTJBMXUrcjA3bi9SanU3dFh3UmZNY2N6WS9vUWVEN2FNUXI0SzNkVWZ3?=
 =?utf-8?B?MnVuRmo4RkxWdWxNaDJVa3VIVTQ1Y0diVE8yQ096QnlIQlh2L1FiWTBGSGZp?=
 =?utf-8?B?WFhEcFcwMG0xMHlkQ094QVd4VzlHbGI3NDVnNXI2TjY1K2hCTW54ZDVQdWZr?=
 =?utf-8?B?b1J1Qm9KNHFkVytzZ1hjWGg5WEg0OGM3cFFUOE1sdG1CNGNBTDNGd3RJZUxj?=
 =?utf-8?B?U3A1cWdJNlhyMjh0eUxKQ1ZHMXVVSWdobXdBendiWDJJVmxJRzQrYTF4cnRG?=
 =?utf-8?B?NGZiWHlKZmlubXJvTG1xdEV5M293UDl0R3Q1T3VTVzNJbFRsMENsYnZGV09R?=
 =?utf-8?B?aFJPaUNGMEJua2s1cnBSR2p2WWtkZTZiTmgzZ0tuNE9Xd3NheUZIeHRiYWkv?=
 =?utf-8?B?L1VGeXpCVDR4WlVURDBySjl3bm54LzlXVG5VOVlvV0x4RjNGMTAvT2pOVktM?=
 =?utf-8?B?UE5IQVhzSVhMV1JncSttamR3M2xudVNQSEN4WXFHaThuL2hqbm5qV1ovamFH?=
 =?utf-8?B?c3Rua0Q0Znk1bmdwN0NkNi9OUHZpcW1mM0ZjWnlIcDBVRDRPUGZOYnpRS1Rv?=
 =?utf-8?B?OU5HRXJxNEdaM2dtMnp2Q0M2YkpPSU5wOUlMUXAxQ1I2dkJReGNOblc5QlNH?=
 =?utf-8?B?UTJyUUpQN3NhNWhkZFFPZXZ2MmNJTWRYclpTb3lqNlVlaUtaeUZSVVhvV3dq?=
 =?utf-8?B?OHA1SXRYN1kxZ0x2OGJ0WGhvU2NGQTlpd3NZU1JUYU5KckM5S2VWNVlhbEJ1?=
 =?utf-8?B?OEN1Uko0eVNPbHR3WmFzZnlVaW5yUUxIbnBrU2w0SUQ0M3Nad3BIeVRxRHBU?=
 =?utf-8?B?NmtydTVkN3l3M2JRbUpYem1kYytRQWdaWDhBT21HMHlIeDhFbUVyRFN2MlJh?=
 =?utf-8?B?SUdYK1N2Qmc0WENQTVJiZXArZ3VGSWpiSy9OY3lSODZnMEZWOEcyVEFNdlVu?=
 =?utf-8?B?M1MzaUdDOElqcTdwMWcra0RGMmFRWmpIanJONUNWUFZ0YWtKYmExcVFjWWFt?=
 =?utf-8?B?dXNjTlA2L2MzeDdkcGx2aW1ralVkSFduMlFzb0U0WGJaTnhwbHZWYnBYc3di?=
 =?utf-8?B?VThsUENmVlNTTGVZWWJFKy9heVZZKzFkcnY4eFNuUUEyVm85NC91bjVtTUZT?=
 =?utf-8?B?SW9VdmhYa29UT09uN1YyZXJhejRlQjMwZnd6eWNtT3F3SFpicEVQTE1aUlAw?=
 =?utf-8?Q?R3JgL9as8rfVCmzA4RFNhfQGv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AC114557D68D644ACA7965683CD161F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6020d6-a808-4ccf-a057-08dcc1b765b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 08:01:00.8545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjAiqo9seoCtlBtJMer92EykJ7LkLSQAb5yYKiWRn65/cSUeFHp+ejVZX/kgZxLtseEhjd1lpSmUABPLCTwT4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8709
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.379300-8.000000
X-TMASE-MatchedRID: F7tLedRt7ifUL3YCMmnG4nbspjK6JP6qjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2h2VzUlo4HVO+1Vx7rDn4ryI9JQsGBsNvBTO
	P6CqFK1EozOVpO7/lKSFyczyoJ0RqschOZSpU29JjVtAwIy+aflObpRiWjuVr31GU/N5W5BCSaL
	fMTsci+fdy7GMadCXAkZOl7WKIImrS77Co4bNJXVZ0V5tYhzdWxEHRux+uk8hfNjF5BHUO+82Ud
	AXc6f7XIli1UUnvavPJWjTq6ygCAVxF0c8Bgqje+A/94mQULxs=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.379300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3EDF152D60B4E9475D43D1529AB99B9BC36A5B2DF03BAFB93F1651D5918504672000:8
X-MTK: N

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDExOjI1ICswODAwLCBSb25nIFFpYW5mZW5nIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIFJlcGxhY2UgZGV2bV9jbGtfZ2V0KCkgYW5kIGNsa19wcmVwYXJlX2Vu
YWJsZSgpIHdpdGgNCj4gDQo+IGRldm1fY2xrX2dldF9lbmFibGVkKCkgaW4gLnByb2JlKCkuDQo+
IA0KPiANCj4gDQo+IEZpeCB0aGUgYnVnIG9mIG1pc3NpbmcgY2xrX2Rpc2FibGVfdW5wcmVwYXJl
KCkgaW4gLnJlbW92ZSgpIGJ5IA0KPiANCj4gdXNpbmcgZGV2bV9jbGtfZ2V0X2VuYWJsZWQoKSB0
aGF0IGNhbiBkaXNhYmxlcyBhbmQgdW5wcmVwYXJlcyANCj4gDQo+IGl0IGF1dG9tYXRpY2FsbHkg
b24gZHJpdmVyIGRldGFjaC4NCj4gDQo+IA0KPiBGaXhlczogM2M4ZjRhZDg1YzRiICgibWVtb3J5
L21lZGlhdGVrOiBhZGQgc3VwcG9ydCBmb3IgbXQyNzAxIikNCj4gDQo+IENjOiBob25naHVpLnpo
YW5nQG1lZGlhdGVrLmNvbQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9uZyBRaWFuZmVuZyA8cm9u
Z3FpYW5mZW5nQHZpdm8uY29tPg0KDQpSZXZpZXdlZC1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRp
YXRlay5jb20+DQoNCj4gLS0tDQo+IA0KPiBWZXJzaW9uIDIgY2hhbmdlczoNCj4gDQo+IDEuIE1v
ZGlmaWVkIHRoZSBwYXRjaCBkZXNjcmlwdGlvbiBhcyBzdWdnZXN0ZWQgYnkgS3J6eXN6dG9mLg0K
PiANCj4gDQo+ICBkcml2ZXJzL21lbW9yeS9tdGstc21pLmMgfCA2ICstLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0K
PiBpbmRleCBmYmU1MmVjYzBlY2EuLjJiYzAzNGRmZjY5MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9tZW1vcnkvbXRrLXNtaS5jDQo+ICsrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KPiBA
QCAtNzcxLDEzICs3NzEsOSBAQCBzdGF0aWMgaW50IG10a19zbWlfY29tbW9uX3Byb2JlKHN0cnVj
dA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCWlmIChJU19FUlIoY29tbW9uLT5zbWlf
YW9fYmFzZSkpDQo+ICAJCQlyZXR1cm4gUFRSX0VSUihjb21tb24tPnNtaV9hb19iYXNlKTsNCj4g
IA0KPiAtCQljb21tb24tPmNsa19hc3luYyA9IGRldm1fY2xrX2dldChkZXYsICJhc3luYyIpOw0K
PiArCQljb21tb24tPmNsa19hc3luYyA9IGRldm1fY2xrX2dldF9lbmFibGVkKGRldiwgImFzeW5j
Iik7DQo+ICAJCWlmIChJU19FUlIoY29tbW9uLT5jbGtfYXN5bmMpKQ0KPiAgCQkJcmV0dXJuIFBU
Ul9FUlIoY29tbW9uLT5jbGtfYXN5bmMpOw0KPiAtDQo+IC0JCXJldCA9IGNsa19wcmVwYXJlX2Vu
YWJsZShjb21tb24tPmNsa19hc3luYyk7DQo+IC0JCWlmIChyZXQpDQo+IC0JCQlyZXR1cm4gcmV0
Ow0KPiAgCX0gZWxzZSB7DQo+ICAJCWNvbW1vbi0+YmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1h
cF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gIAkJaWYgKElTX0VSUihjb21tb24tPmJhc2UpKQ0KPiAt
LSANCj4gMi4zOS4wDQo+IA0K

