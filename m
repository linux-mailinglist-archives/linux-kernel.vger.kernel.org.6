Return-Path: <linux-kernel+bounces-177668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA21A8C42D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA471C20429
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33100153816;
	Mon, 13 May 2024 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QBV9msgX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hvkp/JPr"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ECB50279;
	Mon, 13 May 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609179; cv=fail; b=LtpGIdlAcfYqeRW6+yi1kWx2LzOtLblnFzi7BuOQVBUfKbc9FzFrjAruG/kr902jD6HQ8HPG7hnOx/bA59O68P5iwOvnxyUtDhazRRYNnTCv5DawRG4k/kjGGf7Ezli2R38fh6bpQg/IJKX6cvOujQfFgM5XgcZaXKE5uU+6eRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609179; c=relaxed/simple;
	bh=0zTrgiiCG7VhW5r+U3wsbU6+YhZjcRGtkugWq9cQArc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1viCYArZHMQMRhxGhyz4cRNOk0OzXQkk3ubOesj3tNvQyDXhVype/Kwgt4R1h2dTFqZ1Z0qLq5NeIt9j/PsME/E737zLx0Jehhu42Fek9vB/GMZd9IOKjkm/ZC2AR+qohfoieAd3xcWYYvqptY48P6mnUEw12gPp3fb5hntdyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QBV9msgX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hvkp/JPr; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f5352220113111efb92737409a0e9459-20240513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0zTrgiiCG7VhW5r+U3wsbU6+YhZjcRGtkugWq9cQArc=;
	b=QBV9msgXBnfXDH929h/D5O8JpVuAvgoK3Wa4xwhoDltudWVO/aKGqFMix0Hkme7n4eKwMdf+KTmUTQ9/mGQD20mJzN385qvMFJXuAu/coHgyX5fp2HKXs6/FblY8xaMQyg9RP7SsG9bapMw488T5vmXVOeWCMU8bQfJ+E9p6ZkU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:6b1369f9-beed-4659-b46c-d8edaa8f50f3,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:b5a4cb83-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f5352220113111efb92737409a0e9459-20240513
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 215950650; Mon, 13 May 2024 22:06:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 May 2024 22:06:12 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 May 2024 22:06:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz9sKs5s0cHU6hYM/laESH/z0YB5zusC7bvfozYTI1GpQstRuubr8fCWWWeZn+AVkKq0iQjDZldWauYyc3Vh/XsoQb53zpFf6FD9W/IE2rkYh12GWgcC6sYOhNF0Koz7XRQnu13etqfI/CGKF/nIzRh3pLkYcv3XBv1Dt0oJHPg0JPGhoQK1lieD05ORr9irm4Rm6av9tcdX7yaQGpNqxYXyl74rcPQU05CI5V7m5qo0xIk5jbNWzwM/33dr4gKM2LA0elIMD1b0FImqNX+9dKV2CIE/ZHj3o9qhSm0uMX8uiZWVj9/qb0EgVVuR1PQg7hnGA6MobKZbyOlDorPbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zTrgiiCG7VhW5r+U3wsbU6+YhZjcRGtkugWq9cQArc=;
 b=mT7lhfGhZXgWQEEdgYKBSOjfB0oajmEePhQrDP28HOBlJOLqDGVlyYeG9GO9M/41uSBlvLUfGQB6ldiBeTxOpInQujyK+5KryU0DTNmAa00kZFYzBOCJwuYWckvrfoqYr8W6O2kgak8MH4Zm+pTtL5+zoZ0Mh5iWu5Ks54J1bU2qs3VxyKIaTMVAyD2/ILVZ+ThAc5UWQ78lPxoHk0KDNXF4ZBh9+arUWSnFYNma9CUpqJUixZJ4Jty7Z1r2QsaQ8mVB11J6brdKXi2YqDn5/+H5Y/ccrBmR6rt5LYzJX0VxaYlX9idD9uAOImPndadqmF4qI8DKEjql5khgxktgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zTrgiiCG7VhW5r+U3wsbU6+YhZjcRGtkugWq9cQArc=;
 b=hvkp/JPrOiJd2Wif0d+e9DZrByp1VmU7Pj4zariLaDQMtijIQ2+5ecP9iQMmgmJOzYwCJQcUaJUf9xVeHGMZi9+98/rpooulFM7Nctir1YHFk0W6cG0H12665uE7jlQnBGTvbn5WOb1HAs529YBjMVCfX7Nlm6pvoO/YhN7UvG4=
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com (2603:1096:400:70::13)
 by KL1PR03MB8009.apcprd03.prod.outlook.com (2603:1096:820:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22; Mon, 13 May
 2024 14:06:09 +0000
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3]) by TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3%5]) with mapi id 15.20.7587.021; Mon, 13 May 2024
 14:06:09 +0000
From: =?utf-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?= <Liankun.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?=
	<Mac.Shen@mediatek.com>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
	<Chunfeng.Yun@mediatek.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/2] Add dp PHY dt-bindings
Thread-Topic: [PATCH v2 2/2] Add dp PHY dt-bindings
Thread-Index: AQHaosoq14tjS/hF8kyh32TtEXWXzLGQay0AgATMpQA=
Date: Mon, 13 May 2024 14:06:09 +0000
Message-ID: <b40f079823286b55e29c244a061f4afac17b9237.camel@mediatek.com>
References: <20240510110523.12524-1-liankun.yang@mediatek.com>
	 <20240510110523.12524-3-liankun.yang@mediatek.com>
	 <20240510124838.GA3916816-robh@kernel.org>
In-Reply-To: <20240510124838.GA3916816-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5760:EE_|KL1PR03MB8009:EE_
x-ms-office365-filtering-correlation-id: fdea6918-6cba-4579-c20c-08dc7355d6d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eGhpczdnSkxCdm1qbkxrRmxxTUdvUEM0U3ZqMExlUmN4bGc2c1pzeUl1c3I2?=
 =?utf-8?B?N0Q4RHdQUXAwTm00akNNTXg2cHZvVHV4YXB0eC9haWZkeVdSaXdKaXJnVk5h?=
 =?utf-8?B?bWxIRU5FQ3h6WThOc0R0T3BQL25mczZKdGV5T1BFeHFtS2ZoMDFJQThuVkJV?=
 =?utf-8?B?MFQ0aGlpVnYxQ2F0MUxlODE3ejhMQmwvR3UrSWROYzRRblhHU0JUdGtEWFR1?=
 =?utf-8?B?S243Q0ZRRzAxeDlmTEtaTzV3QTdJVFFJcWQ2MDg1SDEwdm4vYTVqOTNNNU4x?=
 =?utf-8?B?ekh4TUp2VFY1K1NGZTFjMVFrTEFwcGdRY0ZxTTR1U2ZmMUlDWnd1UXRkQUN5?=
 =?utf-8?B?THVkN0d1eFE1ZXJkd0FIZ25Na3d1ZFROQVIxb2JtWE50ZVBOV1hxcisrRkRt?=
 =?utf-8?B?MGVhbGw0dEFDKzRBRnFYZ1VZdE9YM3NoeWIrMmM5YXBXTEhYM3BQaFg4eXls?=
 =?utf-8?B?QjdXTG9tb1VGaWFadDJqL1VwZjhIVlVQSGJNL2RPeE42czV2WmFwUjRXVWFI?=
 =?utf-8?B?Q2M1VXRVSXBpUmgrcHdzbmpndnk5OGtwQTZOem83YW5BenhHSUNaRzJZWEpq?=
 =?utf-8?B?UjlITFBxTmFKWWJMK0ltL1IwaUZYMWd4S1A4NGxGTXdxUlY5WXVxQ21IbjBz?=
 =?utf-8?B?WUlJcWJiWDBIQ2I2bVJIcE9pWExtNTdCMnRsWWZKMmRLamZJcmx4VEw5Njlu?=
 =?utf-8?B?Q2o1UkF1eXJIUzNEMG5tbnFxTDVaazFUdEs5QVd0aExtZmR6dHFWbTEyRFNn?=
 =?utf-8?B?N0tTNHlwSnBIempMOHJqeWlNNHphZ0QzdElHa3JzV2NkdkpRUXhyaXZWR1Bo?=
 =?utf-8?B?L0FtMXpvZjZIazFjWXd6eVhFMHNkcVBzcGY4dkd4MUFhWkRNbjdtejNaUmVD?=
 =?utf-8?B?M1EwelNUa2Z0TUtSbDJTL2VwRzhEQ3piTjZ0cE5lUFVrM3lpVDN0dUcvbG1L?=
 =?utf-8?B?ejBlWnJHamFJOURraFBVb3pkSlByTGQxUFQ4M2pVZDVldjkzdm9Oc3NnR1Vn?=
 =?utf-8?B?K0N1djZHeXY0bjVvNUw2ODRKWElFaTBYZk8wNWNTMFcyNlFiS1J0YzBqbEFR?=
 =?utf-8?B?a3ljcXNWSlJEN29mVGRzRnJjVUpoQ2hlK3ZDSFJCekYyZXNkY2YxQW94LzlP?=
 =?utf-8?B?U2ZYa21kUHNoS0d3UFdlOS9kUjZaYlVLRXQ3bzFvdzFRUU0vVkpyVG1ZMTBN?=
 =?utf-8?B?bENaa3huZTNNSjFmYUxqQjVMTUVuNW80K3lxZWhNVEI4cTVlL0lqczBibzhj?=
 =?utf-8?B?eFgzY21RWFE4NEFuRE1XYU4rUlBpNnVyYzRFUlY0L0djeGNuV3dBakxIbjdS?=
 =?utf-8?B?S054T2tocTVTak5HN2FySWk3K1dEQ0h0MWJJL1lxY1N6R2J4QVgvU3dldGxR?=
 =?utf-8?B?NWd6NXNpUGVYb1FkQXRyQ3AyM3BtT2VWNkhKVnVSeGJMKzFWWndNem9YKzVZ?=
 =?utf-8?B?NXFScm8vS2tETXord0NxS3RTdlZRSnk5RWk2MGloS2llQVhCM1grVlJDd3pF?=
 =?utf-8?B?Z2dGR2FsT3VUQjAxbDJNOGJFc2dCN3luc0JRNDNHVFd2L0FSK3RHYTF3S0RB?=
 =?utf-8?B?WVVPZzlMRVlpTE03a1hsWHZXYy9keDNVdjBoQmxMNlZXYWNnc3hRWGZWQStX?=
 =?utf-8?B?UHIzdkt6dm1yVmY0R0w2WTJ6MW9xd0N0S1Vla3RnNGtUeFNPdFhNd29GU2tS?=
 =?utf-8?B?WDVvOUVCcTViSmk4ZklsVDlydW05VmdDTVR1eFVjNWErdWcrcXdFYzFCbG5p?=
 =?utf-8?Q?V5ZzI+xrqp5WEdpKh8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5760.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXZTeStQcDhpc083eHlTN1B6aEhBTXJzeU0zNlozTk9kSDJ2aStUNmp5OUph?=
 =?utf-8?B?N21SREkzMTZTS2Yzc1AreDNPeG1EQ1hFOU5veWFjTzR5WXF6RG1ObEJBenVD?=
 =?utf-8?B?WEhEQ3dwQjlyNC9qc0hBYnA5Znh3UEE4T2NuM0FWcE9XcEJWVjhMNXNRWVdY?=
 =?utf-8?B?aGZKdWVxU3F5L2czSGYvS28vaVo1WFdGZ01ERmplcE0rTzh1Z09zVCt2cmRn?=
 =?utf-8?B?bUVzT2VlbnRHSnhCSWR3UG12SXY2T2lENGhZdjhLSVFGYk1oWjZvN0lLRDh5?=
 =?utf-8?B?eERpdDYwT1ZLaWdKTjVBbVBNKzlwUWsrdUVweFpHeXAvT05XcEMrSHJBcXNC?=
 =?utf-8?B?c2s1eEFUYmZtalE0RXNSNDQ2bE9wZUErTVI1b0lUYXQzc3pMUXh0dFAvbDVV?=
 =?utf-8?B?M1RsVldkK1BmSTY0UXk5citzUUszZnhac1hwT3JRelpqaXUvd2Fvcy9QMnFN?=
 =?utf-8?B?YjUrM09aY2dmTEhZUEpwNkpidzlFMVdvWmxZNzBjK2pZYjJCMnNoalBvWEpm?=
 =?utf-8?B?YVVXY0t2bFlzTVZJV0hPSWJtQ0R0UGtvVVN5UitQSGt5YzN4ajhRdlFEUHFr?=
 =?utf-8?B?UFFkYWtCdlZYUHl3NHozc0FGenBKVm1oY00wUGpDa3pXMThaWnFqaHhseEtH?=
 =?utf-8?B?MXVFY0hXN3lmNlppZENkVmlXK2QrRFFUanRrZUJMQkU4a3JZOFBRd010VDVu?=
 =?utf-8?B?WlczTWtTanZqNjBlUGJLVkhSOUU1VVhLMEtBWjV0elEzQlE3VEkvak43dytX?=
 =?utf-8?B?a2ljUDFzK1hndG5ZL3A1NUUvODlrUkwxSlRVMjgveFBvTWtLYjFyYmUrVGxi?=
 =?utf-8?B?dER0MG4xcWdUb2s5c3hBNnJmQkpQVVZYWWxUNHU1czY0Sm4rdldOV09vamZ1?=
 =?utf-8?B?MlF3b2ZZTGlnWDJnS2dQVU5URmwvR0xUUTFVaGNLakVIRDhsMnJOTVhLWkQ3?=
 =?utf-8?B?QnpQSTVzWWRpL1NUNUZjSG5yeDBwREtVcGJ6aW5ibzZnMzN6UWJIZGFzaEpC?=
 =?utf-8?B?WE84MGlQaUtCRWpWK3ZXTjBOZFJ2NnExSzBaOTlTTmtraURlcitkMTBIRmp4?=
 =?utf-8?B?WVRVcGZPQmlXdXpzUHBKTklpS0daRnBwQ3ZNdTRvdS90amxsQW5HSGRvUDZn?=
 =?utf-8?B?eDU1UGsraGRkTkYzV0dyVmVvTFhtbmxRb2ZzelBlZ2FEUW82eUJ2VmpFa1lv?=
 =?utf-8?B?UHBQMExkeVhsU1JvU1lsYU9zU0YzbEFwSHlZeWhvYkFpTFBwOThVc1NRSjF2?=
 =?utf-8?B?cnFjZnU1bHk5R0tpNkViNEVBY0t1Nk5RK0tUdnA5bTVhRE5YRWlVZmx2cGk4?=
 =?utf-8?B?VGpaMThhS1JWbmFZeDR2amZiUnFGL0FUWmZua0UzRGhIT3IxT2NhKzJJZFZh?=
 =?utf-8?B?QmRqUUlpbHBBeWlKVnIzK2VDdFF5UjkrWU5LTUlOSXM3OStWamI1djJXcTNN?=
 =?utf-8?B?aWhNK2tXaituQlBYcng5d2xpb2EzZEx1ak9pU1VZMTJyTVBZM2NieCthSVZX?=
 =?utf-8?B?YTRvcVEzeHN3WVNtWTF2NGhsQnB2RlNWVWtxOHRyaWsyODhWUDRVc3pFUnlO?=
 =?utf-8?B?ZXlhQmhVT285VlZZdllETmlCUVhrNFVWYjdPMjFBQ2F2bEVXTS9SZ2NqV2E4?=
 =?utf-8?B?K2FRcytsbUJ3bVhzMVdhS1ZEYk15UEp0QzJFdCtNWjVhM0VqSjBQT2o3TWlT?=
 =?utf-8?B?RGRZZXJVem1YTXVST0tUeUNmSWt3UWc4aHRVZjBmM2hDd2pvTWVRQ0lIb0dU?=
 =?utf-8?B?akR3c3FrZzRVRUlTQmgzWVlJZHJYd0VlOTZQOUdpZjc1NXRUWUs3cnl2ZXE1?=
 =?utf-8?B?SE5SYVQwd1ZTemc4QXhQa1hQZ1krcHV6VFRGMHRSQlJyN0FURUpaRTk5ZXc5?=
 =?utf-8?B?ZzRuNFhaeDYyWGFON1RyN0dvUjJNcWZZS3k2WVhWbzVXelpVbGtBMjIxRVJl?=
 =?utf-8?B?Q21JVnNaa1ZVazhVRkhsSGJpTWczZHAxQ21zR2p2VWFGUmF4OE8rUlVjb0Y4?=
 =?utf-8?B?bmF0eHRGOVhpbXhFMkV2ZTZ3SmxyTHBGNlNBSm1xZ3VGUGV5K1BsVjJmZUN2?=
 =?utf-8?B?aXI2M0NNSDEvdFgrUjFwOEU3a280Rzk1aGpoWG93bGpGMEJjU2JYYWI5VVFC?=
 =?utf-8?B?MHROSTZBU1RzQlV1ZUs5VkV6dUhETWgrcDlmY1NEU2VUaHAxY2orOVpaWU9h?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAE1CAC78B36844F9A4174E28A015493@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5760.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdea6918-6cba-4579-c20c-08dc7355d6d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 14:06:09.2746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LiBhI2eBBFT0HUpcxkOPkvHDu+c26L9QXf5nkBS35BRuVOrVIGTp4w5k1jawpxM7U3gG8JuZUuK4xZXxOMZmLIkC53Ik9L2LcevC2JHD72g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8009

T24gRnJpLCAyMDI0LTA1LTEwIGF0IDA3OjQ4IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBGcmksIE1heSAxMCwgMjAyNCBhdCAwNzowNDoxNVBNICswODAwLCBM
aWFua3VuIFlhbmcgd3JvdGU6DQo+ID4gQWRkIGRwIFBIWSBkdC1iaW5kaW5ncy4NCj4gPiANCj4g
PiBDaGFuZ2VkcyBpbiB2MjoNCj4gPiAtIEFkZCBkcCBQSFkgZHQtYmluZGluZ3MuDQo+ID4gaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLw0K
PiA+IDIwMjQwNDAzMDQwNTE3LjMyNzktMS1saWFua3VuLnlhbmdAbWVkaWF0ZWsuY29tLw0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IExpYW5rdW4gWWFuZyA8bGlhbmt1bi55YW5nQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWsucGh5LWRw
LnlhbWwgICAgIHwgNDUNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNDUgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWsucGh5LQ0K
PiBkcC55YW1sDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLnBoeS0NCj4gZHAueWFtbA0K
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21l
ZGlhdGVrLnBoeS0NCj4gZHAueWFtbA0KPiANCj4gZ2l0IHJlZnVzZXMgdG8gYXBwbHkgeW91ciBw
YXRjaCBiZWNhdXNlICduZXcgZmlsZSBtb2RlIDEwMDY0NCcgaXMgDQo+IG1pc3NpbmcuIFlvdSBt
dXN0IGhhdmUgZWRpdGVkIHRoZSBwYXRjaCBvciBzb21ldGhpbmcuDQo+IA0KPiBJZiBpdCBkaWQg
YXBwbHksIHlvdSdkIG5vdGljZSBpdCBmYWlscyB0ZXN0aW5nLg0KPiANCg0KQWZ0ZXIgY2hlY2tp
bmcgcGF0Y2gsb25lIHdhcm5pbmcgaXMgbmV3IGZpbGUgaXMgJ25ldyBmaWxlIG1vZGUgMTAwNjQ0
Jy4NCkkgd2lsbCBwYXkgYXR0ZW50aW9uIHRvIHRoZSBwcm9ibGVtIGluIGEgbGF0ZXIgcGF0Y2gu
DQoNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjQ3NmJjMzI5MzYzZg0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxh
eS9tZWRpYXRlay9tZWRpYXRlay5waHktDQo+IGRwLnlhbWwNCj4gPiBAQCAtMCwwICsxLDQ1IEBA
DQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTIt
Q2xhdXNlKQ0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogDQo+IGh0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWsscGh5LWRwLnlh
bWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29y
ZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IE1lZGlhVGVrIERpc3BsYXkgUG9ydCBDb250cm9s
bGVyDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIE1hYyBzaGVuIDxtYWMuc2hl
bkBtZWRpYXRlay5jb20+DQo+ID4gKyAgLSBMaWFua3VuIHlhbmcgPExpYW5rdW4ueWFuZ0BtZWRp
YXRlay5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIFNwZWNpYWwgc2V0
dGluZ3MgbmVlZCB0byBiZSBjb25maWd1cmVkIGJ5IE1lZGlhVGVrIERQIGJhc2VkIG9uDQo+IHRo
ZSBhY3R1YWwNCj4gPiArICBoYXJkd2FyZSBzaXR1YXRpb24uIEZvciBleGFtcGxlLCB3aGVuIHVz
aW5nIGEgY2VydGFpbiBicmFuZCdzDQo+IGRvY2tpbmcNCj4gPiArICBzdGF0aW9uIGZvciBkaXNw
bGF5IHByb2plY3Rpb24sIGdhcmJhZ2UgbWF5IGFwcGVhci4gQWRqdXN0aW5nDQo+IHRoZSBzcGVj
aWZpYw0KPiA+ICsgIHNzYyB2YWx1ZSBjYW4gcmVzb2x2ZSB0aGlzIGlzc3VlLg0KPiA+ICsNCj4g
PiArcHJvcGVydGllczoNCj4gPiArICBzdGF0dXM6IGRpc2FibGVkDQo+ID4gKyAgICBkZXNjcmlw
dGlvbjogfA0KPiA+ICsgICAgICBTaW5jZSB0aGUgRFAgZHJpdmVyIGhhcyBhbHJlYWR5IHJlZ2lz
dGVyZWQgdGhlIERQIFBIWSBkZXZpY2UNCj4gPiArICAgICAgdGhyb3VnaCBtdGtfZHBfcmVnaXN0
ZXJfcGh5KCksIHNvIHRoZSBzdGF0dXMgaXMgZGlzYWJsZWQuDQo+IA0KPiBXaGF0IT8gUGxlYXNl
IHNob3cgbWUgYW55IG90aGVyIGJpbmRpbmcgdGhhdCBoYXMgJ3N0YXR1cycgaW4gaXQuIEdvDQo+
IHJlYWQgDQo+IHVwIG9uIGhvdyB0byB3cml0ZSBiaW5kaW5ncyBhbmQgd2hhdCBnb2VzIGluIHRo
ZW0uDQo+IA0KDQpTb3JyeSx0aGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMuDQpJIGltbWVkaWF0
ZWx5IGxlYXJuIGhvdyB0byB3cml0ZSBiaW5kaW5ncy4NCg0KPiA+ICsNCj4gPiArICBkcC1zc2Mt
c2V0dGluZzoNCj4gPiArICAgIC0gc3NjLWRlbHRhLWhicg0KPiA+ICsgICAgZGVzY3JpcHRpb246
IFNwZWNpZmljIHZhbHVlcyBhcmUgc2V0IGJhc2VkIG9uIHRoZSBhY3R1YWwgSFcNCj4gc2l0dWF0
aW9uLg0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBzdGF0dXMNCj4gPiArICAtIGRw
LXNzYy1zZXR0aW5nDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAg
IHNvYyB7DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAg
I3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKw0KPiA+ICsgICAgICAgIHBoeS1kcEAxYzYwMDAwMCB7
DQo+ID4gKyAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsgICAgICAgICAgZHAt
c3NjLXNldHRpbmcgew0KPiA+ICsgICAgICAgICAgICBzc2MtZGVsdGEtaGJyID0gPDB4MDFmZT47
DQo+ID4gKyAgICAgICAgICB9DQo+ID4gKyAgICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4gLS0g
DQo+ID4gMi4xOC4wDQo+ID4gDQoNCkJlc3QgcmVnYXJkcywNCkxpYW5rdW4geWFuZw0K

