Return-Path: <linux-kernel+bounces-340265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE8C9870A8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEB61F22DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2546B1ABECE;
	Thu, 26 Sep 2024 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n9Vcy+Eu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VmggfJmr"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB451A76D7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344156; cv=fail; b=O9juoem6onxr5YBlqfawwAmuDJQFJw/8uAjGTZDXiMkOOqRygMMq5XlIx3n+rvdXnBpp1CEgdR16rvBI7GPt3RY0qon9/KJP482lT5+TqlvMhTGv+w1SnJPFxabqa18ikNkKBbsaZ9ypY5MuTpX3L7EyJd6gy154G/yRbRujcUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344156; c=relaxed/simple;
	bh=KPboXhe3A4zmMhRQ6QPoi3wXa5Gm71LZiWeIB8s6vqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UzMZJb62Pz9+wp7V7jQqZ+xKNYdT8M8ZdlS/nUzmD8/mH9BP8Ro8ZFcMduxpRZizI462L1o+jTSrl7KDpYUJ6XVKzq1FLEsDcF7Rd8qCSvvshd2401/TXB7JzHj9gu6izZo5D0O59eMgcD3Ldf+FbNFAlrEXnArjawSdrqfQb3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=n9Vcy+Eu; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VmggfJmr; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9281961a7bec11ef8b96093e013ec31c-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KPboXhe3A4zmMhRQ6QPoi3wXa5Gm71LZiWeIB8s6vqM=;
	b=n9Vcy+EuAQN96rudZ61nxxBk40JEvhBj6md9YhaNCFkabkdEpR7GtQ5lFCWkXPQvXOb0K5bRNauYeaeCO4DbYm6eLWjyieqjqgwHiI1vcURAtQsUbrilSK2OH3WEH4EzV7Ot8gVkZQnPnG9G66pCh5/RmqTZU0QO31hYdyVSY+I=;
X-CID-CACHE: Type:Local,Time:202409261730+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:831b55f7-d754-4d9a-8700-3294da06c49c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:dfb8cdd0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9281961a7bec11ef8b96093e013ec31c-20240926
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1099014916; Thu, 26 Sep 2024 17:49:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 17:49:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 17:49:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYangXzlT1exvwRNYC0KonbzIepmSpEEUyZrwHBw6sY75iMUAgKX5/dJx0qDV0nRXfMvkbge4xkgtdw1XWv/02qCt9cQbE44prarRURT0wCXhJJc1SkQl3fTi4kn7505pBpvKFEkzQwesARiF8MX4tljiRZCE4ya2/U5NXbrj3gGwbVam5h48Tlct/aDIPpP+IHXjrc2VRf/OsQwv0bnwf5Xtu7v4VRROeHZxUCqGuBsMBaiNZH2S7be5Txvw2AK5qhTICLwFhKFiHT/0EvKj8QlbAWECmPp9A4za889FPsnmPbAebmkrBWH6K0zNV/oxlXAI3wMAjKJ+UqP2Yl5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPboXhe3A4zmMhRQ6QPoi3wXa5Gm71LZiWeIB8s6vqM=;
 b=tmwx30kUEuyt6SjA5zy9uv/y4ny5GhiDw53AePErm3bLvkaqQSABp9ZEtLr8jmQl730tgE3goPQIuaYxSoY19yQ1KinSHc+TuOUWcwF8LV9SJG7PThn/j5UqZ8+a4CS5NsZdRgUILxkoGTHXRzjh6vVSyOwMDFTRtEGgGzWwem8v6FXkZfs0CIZBAiVbcILndvLzr8FkUTGTbzEHbeIGxVNvemewFm4G6wMMgwAsuAgZehJTHkisJVFdAf8zCsxvGzcnQyZLPIRWb/ARBw69OFfyiOxDt2pG/1vJzo+A9Dh1JPwXF5UmjbbwJAmxnjqF2xpIqUWFJFWGOF+GpQzgWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPboXhe3A4zmMhRQ6QPoi3wXa5Gm71LZiWeIB8s6vqM=;
 b=VmggfJmrbaF0jqyypNISJDZYJLkNhIvLixhoi6G7wWrJdf9DTZyKr0PJL2RKetgVLn2Wcxbjn+/2F0YwKO5P0pq0qL2nrB/svSTFWzAoaKfa32rACOlxTmColcV1ejhPN/9c/kQk0C1PqEGcLyXoCkZ39yb+giqwqMgKfyGhc68=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB7829.apcprd03.prod.outlook.com (2603:1096:101:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 09:49:03 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7939.022; Thu, 26 Sep 2024
 09:49:03 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/2] drm/mediatek: ovl: Add blend_modes to driver data
Thread-Topic: [PATCH v6 1/2] drm/mediatek: ovl: Add blend_modes to driver data
Thread-Index: AQHbD+9RG+Vx0l29/UiQ8Vdw30A7QrJpzZKAgAAFMQA=
Date: Thu, 26 Sep 2024 09:49:03 +0000
Message-ID: <a704c8ad4e9d6e1644baf338cbb98de4aa2ccf6e.camel@mediatek.com>
References: <20240926083526.24629-1-jason-jh.lin@mediatek.com>
	 <20240926083526.24629-2-jason-jh.lin@mediatek.com>
	 <a3da0d24e6749b054f8a65656ec40d4aa0b9f2dc.camel@mediatek.com>
In-Reply-To: <a3da0d24e6749b054f8a65656ec40d4aa0b9f2dc.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB7829:EE_
x-ms-office365-filtering-correlation-id: 94c0f54e-4d2f-44fd-b1f3-08dcde107444
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ckhtc1p0eE4zOHpqOENEdmRGZHVsR0IrMktEM0hBQndpYzV6UmhlWVBlYUN1?=
 =?utf-8?B?YjdkL1F3SkpYSk9UQU52QktCS0thZ2FGRXpzL3E3NXhmdndTYjVsWnRBVkVY?=
 =?utf-8?B?Y0NTbnFMU0hqbUdhek03WnkxalNOSHB5RHYvLzdlaDNHbWpCU1B5cUNtcXYx?=
 =?utf-8?B?eXRrTGFnWlJVTjkzekMyT0pNWE1wVE1PN0lndU5jNkRrRUdHeDcvT2lUMGpV?=
 =?utf-8?B?aldrVnR5ajkzb3Z4Rjk0TlZqSWJWTnVIZG13Q20ybzkzQmVEYnhDKzhOR3Jx?=
 =?utf-8?B?cGZTSmY1NjdKWnhPaTJoVDJqYWxqU1k5Q1JaajBRZFBMcExwUzNmOXhnQkhN?=
 =?utf-8?B?WVBITERIazBXN2ZLQTBjV3ZwNFU0R2U0MXRWL0U0Zk9wMDVVMlkrVFhqRHZY?=
 =?utf-8?B?UWxkU1M2SXcwaWFaekh6SXRVYzZ2Q3BwMUZHTy9TNi9xWGhvRGlQYmNVR05s?=
 =?utf-8?B?NHM1TVZiNUNDMU5FOUZ0eFA5ZUVaNlpMdk5XRXNlSnRIa1JkNHNKUjhwTGV0?=
 =?utf-8?B?OXNOV3JLVzkwZE1BSkpQWFJydzZFak5aemVWZFhPSVo1QTBpM1dQbmxydngz?=
 =?utf-8?B?QW0xNlExRko1bXV0UCtCS3dqek9nQWFzRWVQT3BIalptd1JkZjBGMWFwQllM?=
 =?utf-8?B?WUJKSkRSQzBRcEJQS3I3ZDB4QXpSYTFyLzJmeGhCSWNTeGZ3bTg2TXNxcWh0?=
 =?utf-8?B?amlXUkw0OXR2clZXenJxNTZNRXNiWlk0R0piRlY4bERKdmdvNy9HdjUzK1o1?=
 =?utf-8?B?Ty9yRTlFSGFnZ24yZGRPNTJTMjZEYWlQZ0RmSVI1U2NOb1ZZc2FGeXMxRXh6?=
 =?utf-8?B?R1cvckJ2SWJMWkJKVTJESVRDL0ZTMCtBZmRLeXc0ZjBacXVaN01hSHZoejdn?=
 =?utf-8?B?dXhER1Mwb3RoUVNuWFNneDhENjdhS2w4UzUvVitqRGxGQ1UzVGpMdklXdC9N?=
 =?utf-8?B?YjZYbE1CM2JqUU4rdVhDaEplTlhaVndZa0QvREt1R29qbXZPR1BsN0R0WVpK?=
 =?utf-8?B?eTVpTTg3UXY2Sm84ZHFRTk43ODc0OCttNklWRUY0VEdUYVVSTVpOUFJCREww?=
 =?utf-8?B?VXZDT0Z5dUJiU2dTYUNPRXpnRzBrdnZVenNsYlcrclk3c3ZzaDcvTFJxSHQ2?=
 =?utf-8?B?RW5iU3RPODA1bmdNR2lqNHB3ZDExMWVyOGFmdnIzQTZBUzJjcjdFMFpneVZH?=
 =?utf-8?B?WEkrbFIreFZLWCtQNUxuTkpoY3VqbVMwOS9rOTJVSE9WTk9ORjMwK0k4QTZt?=
 =?utf-8?B?Yi8xdFdRVFJITXpWNE9wNk1UWjNsajVjbWtqbzdTM0VwVmx6UFQ2UjJqZWtW?=
 =?utf-8?B?ZnJ1WXFkT1FWSEcxK2hjb0l5V0RaaTQ0V0w2d2hwL29pVGJxM3h3WE1VYXJX?=
 =?utf-8?B?ZWdBZXFGREZZekg4WTF4R1NtNU1KNmd5cWlVMUd0SzVUMTFMVXdVN0ZxZ1RS?=
 =?utf-8?B?RmxKQkJxTGJvZEcyMEgxQ0JRc0dGTVdGUnlnWFNsQUQ1QlZSWW1rRFZBNmlD?=
 =?utf-8?B?ZGVyK2ZHZWkwQlFwWGg4Wk9LNUo2WkVRYkFRMkxQMkRyN0V0RWFYcU9LbnBK?=
 =?utf-8?B?UUJLMnp6WDcrV0pFbHI1NkxhdHZtWE8yN2tBeHRIR2pudCtQZ2ROSDk4cGRq?=
 =?utf-8?B?ZUQwSFovL08xdUNmbEc1czlwQ05FbG91Yk9ZWGM1WVBwaElDL3MrRDAxMGdK?=
 =?utf-8?B?UFU2TkhabnpvYVRoTlhSdWJsOEtUa3dxOGpkaDdET3UwVmVJRXFmNWV4TFVi?=
 =?utf-8?B?R3hxSlhDUXZQM2g4dk9JbWtYbE8rMnVwbTJTK2ZvOWExK0RXNnJhKy80Szh4?=
 =?utf-8?B?ZHptSFN2WlRNWnFac01Jdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTd0THRrMURWN1lrSnFjZ3RZb1pyT0tCbFNLZWpkZ2d1QVp0V290VVc3cjdM?=
 =?utf-8?B?ckhHbDB4LzZMQ0s3TTR1c3hkdXJwYWhCSFk5VnZQcFAxZWVHNzFBMGtEMlk2?=
 =?utf-8?B?TGlrRTl3NGthdGxDTk9YWUR5S0dVREhNQXY1OVNnWWxIRG9aZVEvMEE3RmJr?=
 =?utf-8?B?c2N3WEtmRGlNdXBxNWd1cFNLSUx3K0s3MW9HL0t4aHVuQmwrSHFKSTlESDFV?=
 =?utf-8?B?V3orTWRNV1pGK2VyemhRSGRKRVN5VUlkVEp0YzRFdlRLcUFTV0JTR2hHUWhC?=
 =?utf-8?B?bVhOclFJVC9TTWVvSWZTaVg0UStxa2E3Nm5BSGl0QUZseWZKOURaVm1YSE8z?=
 =?utf-8?B?ejFaTFU0aHkyMWZlVzhZYU5sOGhrNm1jV3dtMndhOG1LT3FQVkdqVjBsaWNW?=
 =?utf-8?B?TmRRMTY0L2p5MWtJSlN0dzhSZjVsWG5CQTg1YktCUTJaQXJKWGxrVnFiZDJH?=
 =?utf-8?B?bEVWd2RNOUYxZzc5ejZ5eEFpeGgzdzk0bkhnT0QrTWxHOFdQUC9mVk52YjVU?=
 =?utf-8?B?M3lNZU0yd1pTcUo4RGVITTRCaWVKcTZkOVpKMThyaEdJK0FPYkpQcU0vUi9q?=
 =?utf-8?B?WllxbG5HdksySEluZEErZVRmNGFlZVZROEhZRmc2Zk81cDhReUg4Z0xieWFQ?=
 =?utf-8?B?enNISVFyanVlNFZXV1ZoQXpkYUZvR2x6ZG9ZZVdYOG5oZnhYWkl3dVJENklI?=
 =?utf-8?B?TThLaTdlbTRJZFAwUGhWc2c3S2I0djZGWUZGd3gwTHlxZ0IxM1JVenpzUEwx?=
 =?utf-8?B?ektGRXB5N2lPYzBIcXFSejlJSWJ3UGYySTFHT2JjeTdWODJIQXd2eTAxRE9m?=
 =?utf-8?B?bHFTa3hMRnI0MmRNUEpJejNLRENScmxrLzF0WUZ6N1FOa25aYzdvcjJraWxn?=
 =?utf-8?B?ZlVnc2l4LzJid2U2c1pCd3AzYUlhNmU3dzZsWkhhVjJXTHluS3V4dUFWekFP?=
 =?utf-8?B?dEFGZEQxQWMxYlNKYXlZcWFvUG5ZOVpUQktLU2R6VGRIN0RrdUtxdjhjSnQz?=
 =?utf-8?B?MWlpYjJhd0xlQTZ5TElWQ3kvS3FZOThRKzlCK2NNVk5IOWFEZUl3L2h4K2dW?=
 =?utf-8?B?L1Vhd1ZkR3RBUVVvdmlsSzZvSUFvS2N5Q3RUSGJXQkNpVFg3dk9jVU4waVRp?=
 =?utf-8?B?QmxoQkdnam9tcFc4U0RLL1F1ZEM2ZGpuTS9FNVd0Z0lwdjU4YzBtVEhqczNo?=
 =?utf-8?B?cys2ZU1MVE5pRkRpQnhZMFIxeEc0emhjeDF5NlRFQnVuQmdjZDc1R2w5T2F6?=
 =?utf-8?B?dGdsaE9rMmlPRjUxUjU4ajVDd2RIQ2Eza09uSzVyZTNiQkFsWkw2VjBEWFA4?=
 =?utf-8?B?Nis3aVFYK2liZm50NWloNDhPcGVjUm1taTNSN0pBc0lZdFRScWdFTkg2djVl?=
 =?utf-8?B?WmU4cVFRa0Q4SGc1UVhMYWVxTFQ1S3loT2wyR3lsVXJ4TWUrMHhXZlNFbm9w?=
 =?utf-8?B?Tlo1dmwvTzNvRktKZEs2dWVFNExPczlHZ3hKbUkwd3k3c0daK1JpZm1iSStV?=
 =?utf-8?B?bTN2d29DY0c5NUxybmJYM1UzYkxEbG1xNTQ1cUljdGFzdk82bml1MTVseXJi?=
 =?utf-8?B?bit4cTNmYkRLbzI4SzRHZXpaZDJsTUpZN0Jyb01qL0lUaU81NHB1U2c1VkFY?=
 =?utf-8?B?dWFCRmlsLy8zNGNEekR3M0lvRkZWS1ptREpJbWNFOWZ3eFZTdmNKbUdLaFpm?=
 =?utf-8?B?Si92MFQ4M083UUxZbXliUU5CY2R0OFhWVUYyVFlwMEdJYi9kNWQ2MlRkUkdR?=
 =?utf-8?B?VTYrV0Z5NVBoeFZDSzRDU3poblNxOEVJRFRZZlBnaDZKeTlWZ082VnFLaXA3?=
 =?utf-8?B?cW8xcERZcWNOaUcyTHBkSUFSUC9UMDhHakhNTEhMS2txMU1BYlFOR0p5UUln?=
 =?utf-8?B?YlVYMHlhN3Nld2lvdXFrU1pYM3NMYWdoeUtxWEJPSVh5dXlvVjFuZzFrRUFN?=
 =?utf-8?B?OVFtbFErOHp4MnI3VjRKSmtDemJTWUJZVGhkQ2grWHlaSXM1Wnc4UGNEaHdN?=
 =?utf-8?B?eldjK0Y0SmNmVDZzRG9QT2NIMmtFbkpsS0hjNitDQ0xvNzZrOUErUmw1RjJL?=
 =?utf-8?B?UmEyZDE3RGZVNE1tNVVWS3Y5UjRTbTdMV2FGSVlITm1PZ05ZL081V3pDT2Iv?=
 =?utf-8?B?ZTNUbXhha044K2o3MVJCV1RMbVAvWVV6Q21uK3BrR0xPaHg3THAyQ1JMVC9Y?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9B05B834B55C34C88C20AF1D9376977@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c0f54e-4d2f-44fd-b1f3-08dcde107444
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 09:49:03.0954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TgmbJ3CjG52tU8nsCSn80SDjoNwhZhpyrv0FZP2xdvSr3Dp+IwqU3xtWF1c0dDwiPTHzbxHNvXR+PSiq/zmCfW8xp/drA24OIzki1fSHkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7829

T24gVGh1LCAyMDI0LTA5LTI2IGF0IDA5OjMwICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gVGh1LCAyMDI0LTA5LTI2IGF0IDE2OjM1ICswODAw
LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gT1ZMX0NPTl9DTFJGTVRfTUFOIGlzIGEgY29uZmln
dXJhdGlvbiBmb3IgZXh0ZW5kaW5nIGNvbG9yIGZvcm1hdA0KPiA+IHNldHRpbmdzIG9mIERJU1Bf
UkVHX09WTF9DT04obikuDQo+ID4gSXQgd2lsbCBjaGFuZ2Ugc29tZSBvZiB0aGUgb3JpZ2luYWwg
Y29sb3IgZm9ybWF0IHNldHRpbmdzLg0KPiA+IA0KPiA+IFRha2UgdGhlIHNldHRpbmdzIG9mICgz
IDw8IDEyKSBmb3IgZXhhbXBsZS4NCj4gPiAtIElmIE9WTF9DT05fQ0xSRk1UX01BTiA9IDAgbWVh
bnMgT1ZMX0NPTl9DTFJGTVRfUkdCQTg4ODguDQo+ID4gLSBJZiBPVkxfQ09OX0NMUkZNVF9NQU4g
PSAxIG1lYW5zIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OC4NCj4gPiANCj4gPiBTaW5jZSBwcmV2
aW91cyBTb0NzIGRpZCBub3Qgc3VwcG9ydCBPVkxfQ09OX0NMUkZNVF9NQU4sIHRoaXMgbWVhbnMN
Cj4gPiB0aGF0IHRoZSBTb0MgZG9lcyBub3Qgc3VwcG9ydCB0aGUgcHJlbXVsdGlwbGllZCBjb2xv
ciBmb3JtYXQuDQo+ID4gSXQgd2lsbCBicmVhayB0aGUgb3JpZ2luYWwgY29sb3IgZm9ybWF0IHNl
dHRpbmcgb2YgTVQ4MTczLg0KPiA+IA0KPiA+IFRoZXJlZm9yZSwgdGhlIGJsZW5kX21vZGVzIGlz
IGFkZGVkIHRvIHRoZSBkcml2ZXIgZGF0YSBhbmQgdGhlbg0KPiA+IG10a19vdmxfZm10X2NvbnZl
cnQoKSB3aWxsIGNoZWNrIHRoZSBibGVuZF9tb2RlcyB0byBzZWUgaWYNCj4gPiBwcmVtdWx0aXBs
aWVkIHN1cHBvcnRlZCBpbiBjdXJyZW50IHBsYXRmb3JtLg0KPiA+IElmIGl0IGlzIG5vdCBzdXBw
b3J0ZWQsIHVzZSBjb3ZlcmFnZSBtb2RlIHRvIHNldCBpdCB0byB0aGUNCj4gPiBzdXBwb3J0ZWQN
Cj4gPiBjb2xvciBmb3JtYXRzIHRvIHNvbHZlIHRoZSBkZWdyYWRhdGlvbiBwcm9ibGVtLg0KPiA+
IA0KPiA+IEZpeGVzOiBhM2Y3ZjdlZjRiZmUgKCJkcm0vbWVkaWF0ZWs6IFN1cHBvcnQgIlByZS1t
dWx0aXBsaWVkIg0KPiA+IGJsZW5kaW5nIGluIE9WTCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFz
b24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IFRlc3RlZC1ieTogQWxw
ZXIgTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPg0KPiA+IFJldmlld2VkLWJ5
OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxy
ZWdub0Bjb2xsYWJvcmEuY29tPg0KPiANCj4gVGhpcyB2ZXJzaW9uIGhhcyBkaWZmZXJlbmNlIG92
ZXIgNTAlIHdpdGggcHJldmlvdXMgdmVyc2lvbi4NCj4gSXQncyBiZXR0ZXIgdG8gZHJvcCB0aGVz
ZSB0ZXN0ZWQtYnkgYW5kIHJldmlld2VkLWJ5IHRhZy4NCg0KT0ssIEknbGwgZHJvcCB0aGlzLg0K
DQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3Zs
LmMgfCA0MSArKysrKysrKysrKysrKysrKysrKy0NCj4gPiAtLS0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAzNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+IGluZGV4IDg5YjQzOWRjZjNh
Ni4uMGNmN2I4MGY2MTJlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9vdmwuYw0KPiA+IEBAIC0xNDYsNiArMTQ2LDcgQEAgc3RydWN0IG10a19kaXNwX292bF9k
YXRhIHsNCj4gPiAgCWJvb2wgZm10X3JnYjU2NV9pc18wOw0KPiA+ICAJYm9vbCBzbWlfaWRfZW47
DQo+ID4gIAlib29sIHN1cHBvcnRzX2FmYmM7DQo+ID4gKwljb25zdCB1MzIgYmxlbmRfbW9kZXM7
DQo+ID4gIAljb25zdCB1MzIgKmZvcm1hdHM7DQo+ID4gIAlzaXplX3QgbnVtX2Zvcm1hdHM7DQo+
ID4gIAlib29sIHN1cHBvcnRzX2NscmZtdF9leHQ7DQo+ID4gQEAgLTM4NiwxNCArMzg3LDIzIEBA
IHZvaWQgbXRrX292bF9sYXllcl9vZmYoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+IHVuc2lnbmVk
IGludCBpZHgsDQo+ID4gIAkJICAgICAgRElTUF9SRUdfT1ZMX1JETUFfQ1RSTChpZHgpKTsNCj4g
PiAgfQ0KPiA+ICANCj4gPiAtc3RhdGljIHVuc2lnbmVkIGludCBvdmxfZm10X2NvbnZlcnQoc3Ry
dWN0IG10a19kaXNwX292bCAqb3ZsLA0KPiA+IHVuc2lnbmVkIGludCBmbXQsDQo+ID4gLQkJCQkg
ICAgdW5zaWduZWQgaW50IGJsZW5kX21vZGUpDQo+ID4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgbXRr
X292bF9mbXRfY29udmVydChzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsDQo+ID4gKwkJCQkJc3Ry
dWN0IG10a19wbGFuZV9zdGF0ZSAqc3RhdGUpDQo+ID4gIHsNCj4gPiAtCS8qIFRoZSByZXR1cm4g
dmFsdWUgaW4gc3dpdGNoICJNRU1fTU9ERV9JTlBVVF9GT1JNQVRfWFhYIg0KPiA+IC0JICogaXMg
ZGVmaW5lZCBpbiBtZWRpYXRlayBIVyBkYXRhIHNoZWV0Lg0KPiA+IC0JICogVGhlIGFscGhhYmV0
IG9yZGVyIGluIFhYWCBpcyBubyByZWxhdGlvbiB0byBkYXRhDQo+ID4gLQkgKiBhcnJhbmdlbWVu
dCBpbiBtZW1vcnkuDQo+IA0KPiBJIGRvbid0IGtub3cgd2h5IHlvdSBkcm9wIHRoZXNlIGNvbW1l
bnQuDQo+IFdpdGhvdXQgdGhpcyBtb2RpZmljYXRpb24sDQoNClNpbmNlIHdlIGNoYW5nZSB0aGUg
TUFDUk8gdG8gYWxpZ24gdGhpcyB0byBEUk0gaW5wdXQgZm9ybWF0IG9yZGVyLCB0aGlzDQpjb21t
ZW50IGlzIG5vIGxvbmdlciBuZWVkZWQuDQoNCkknbGwgc2VuZCBhbm90aGVyIHBhdGNoIGZvciB0
aGlzLg0KVGhhbmtzIGZvciBzdWNoIGEgcXVpY2sgcmVwbHkhDQoNClJlZ2FyZHMsDQpKYXNvbi1K
SC5MaW4NCg0KPiANCj4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+
IA0K

