Return-Path: <linux-kernel+bounces-533122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DED3A455DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289AC17A8DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A97269B13;
	Wed, 26 Feb 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m4r28pv1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="voMKrQhw"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32E26773B;
	Wed, 26 Feb 2025 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552114; cv=fail; b=JASEEbyJMsH9VCTDTxhEpUsEucHMm6Bqr7GS5FD27jzwaBtwfvCX+FMtjIIf7/asdT0jU9G7ipNcR9EdzkiRLLukPl2yR9P6kGCKs9bNf2uJSnb8Rz4ghkZ8GdUx0zC+LaPi0VTT073LbpK3TiJ4z9BEIcWwotKEAA6vPozmsac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552114; c=relaxed/simple;
	bh=0VhyffzYhr6OVhdIlN/aWipS7dkK6/9l+FVrnpCT9sY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i7lp8fJLqT8nj32BrGxjeAFuQKpcG75NqQaUs4hGwUdjSqQSWpU78YkDHnmMW/XTnfhBBh4V3d+qThMYExz1J6AqUpjmu1FtDOqo7uNspeKJp/Iz4rusTyWqvsmeX7I1zBH4BMthL75EaVlbfbDLmr2OfHAx/REIXCDeRSkyNXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=m4r28pv1; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=voMKrQhw; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bfbb8972f40c11efaae1fd9735fae912-20250226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0VhyffzYhr6OVhdIlN/aWipS7dkK6/9l+FVrnpCT9sY=;
	b=m4r28pv1Ww8URITpdtDIeYgGweWGsVdrW5pw/ctREMt9SHA5NNTxnAbQP0dzF/CtsIJWFVviKcLvpulRwzoLZRHXwQdZkxEuExQsJ66BFX5NVEMbH6nvkwfAk0woj03/7KeX/YdcLEfiIz2OWhNynd3dXFuuLIpxpGxUq5EoKEk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:dc3ad469-fae1-405a-bd76-4c22a8996a49,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:7515f0d9-654e-41f2-8a8e-a96c1e834c64,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bfbb8972f40c11efaae1fd9735fae912-20250226
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 405078371; Wed, 26 Feb 2025 14:41:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 26 Feb 2025 14:41:45 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 26 Feb 2025 14:41:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpT5Fkd6ZWENHBrLDV2jW9UgB7C1cWFF3mxQd8NXxHvsbv+PCnQhB4i00it/LhfsU2W/DUa57nW+pAwPFoRxhzbBsTLCJGwSUbe4GQRRqJn2HBnTtTHnDGe3xMvt9AoEYcBbagIAQB9Uy0nbso0a1FZ73ZQo0TXnm4XuQr0ewI2wDfUdFYTdmknlmOdd1xcLuXuJb93lqQikk4Ic7ZW4TP1bsvDGQDkTSf9Kb1BY3qKsK3yZb9aY3aKehWnMg/YtKGdiPbl3qHYUnK8OXTp6HzR8kADqe3sob0QSufkxJ7Jju14nVL5GjQAD7gFvfQJwgwRkVhYUakAPZFszsWptVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VhyffzYhr6OVhdIlN/aWipS7dkK6/9l+FVrnpCT9sY=;
 b=CsnxcmzhsKapgEFM+af9eisz8M4hXq5sQO5RMWo511wwXBDVzWgv9ACvMyqogl4OdghDqEvLfDL83j+AlUimynx7N9FhHd/HN9VIVpOFPMgXLqc2QIkUrK1st61CBwBVtVn7tUDSrWPVzkeGIeOoqvbqzxpLCzRJKM8y3rvHLFWcjHyhcV6rMqI2zVceZWyvze81YYN34B7MhzjK3dIFat7un0cuFqKQda7DItrJs/SsReRiz3zj+7DN3y053KSGmi3TGk7k/Ux55xp+gukKv5B9zl5e26VDYQjhUqYwu85zGVfTobeqpjuFSxMBkDxWAsQezw2rRJV201dIgASS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VhyffzYhr6OVhdIlN/aWipS7dkK6/9l+FVrnpCT9sY=;
 b=voMKrQhwCEv2Uc66TPpgZMakQm9sTtA58T0dbnwI1gxzk3PY1W1u8Wv7iEwO0qu/gXPLDlf/PotNLNoEZWPeUDUZtsGbZteeKBdOqbl9oK8kfk767XnrCFzZ+FJ4+EXO9Z+M8AkwKkNQvIZzlDr/7GAHemI5toGibzFiURHkRC0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6670.apcprd03.prod.outlook.com (2603:1096:400:1f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Wed, 26 Feb
 2025 06:41:42 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 06:41:42 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?=
	<yongqiang.niu@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"hsinyi@chromium.org" <hsinyi@chromium.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/7] drm/mediatek: fix CCORR mtk_ctm_s31_32_to_s1_n
 function issue
Thread-Topic: [PATCH 2/7] drm/mediatek: fix CCORR mtk_ctm_s31_32_to_s1_n
 function issue
Thread-Index: AQHbgq+sSfzxbqk9wEiVbA0ThbbA0rNZLZ2A
Date: Wed, 26 Feb 2025 06:41:41 +0000
Message-ID: <6bca3cc4dc7c64e78c7ee6174544f0683b4f5fac.camel@mediatek.com>
References: <20250219092040.11227-1-jay.liu@mediatek.com>
	 <20250219092040.11227-3-jay.liu@mediatek.com>
In-Reply-To: <20250219092040.11227-3-jay.liu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6670:EE_
x-ms-office365-filtering-correlation-id: c1f3fd4b-ad63-4d4d-194b-08dd5630a0f2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?elJaaWFvN21FUHc5K1BwZGVsbmV3b09tVExGU01XRjNGeGNnY09MZVVPODBz?=
 =?utf-8?B?cVBDV2tJd2JkUS9tMTZTcGNNUFJtYWQ5bHBDZjRZcXEzMGI0SlVLTzJEck0x?=
 =?utf-8?B?YW14cm5uS1loYlR2SW9HRGl6UlpwRGFjdlZVcEFqcWRRbG55RlltRXd0aG1u?=
 =?utf-8?B?ZmMzQ1JHMlVJcExWMStNaVNOeHF4RE1TSldEUFlyaTJLRFRIeFlVWlliNVJ2?=
 =?utf-8?B?NDVWL3YrdTBJRW1TaTFQNXY0OWQ2SVVDMStqVG0wRTd0ZnM0V0VRbXUraW9N?=
 =?utf-8?B?dW9TdFVqNDQ5dytaRGU4R0h5ZXRFM1lLaEpiVUpDV1N4eHl6bmVFNGNpUDVH?=
 =?utf-8?B?aVpuVGxKZUpydGFYOHhSZEVUWVoyeTlEcFoyYWFZMy90MHRsY3VDYzI1YkV6?=
 =?utf-8?B?b1lZaWF0MWZkY01YTmJrQkVrRDc5bXZRVStrVER1aFozVVZDZEJmbnBRZm9o?=
 =?utf-8?B?UDhGV05nVDllV0ZnaVlRR0xBQktXVVAwMjRnOENXNnVnM2FEZ3lyZzhBeWVB?=
 =?utf-8?B?K0hwVUJzMWh2ZzJVUmpuTmhpVnVLYmpxeHVkK1BOZlBOTVF5aHVabmFqTVNq?=
 =?utf-8?B?aEV0K0psQ0RaQWdVN3Y1alprZlE3S3NWb05tSHN3OUpSZVYzcEs4UFUvTXNi?=
 =?utf-8?B?ak95T2UvcmlrMTB4ekZuNVJxeTJ6VlVQUFBCV1hTZmMzMWRzNjBVeEV3T2dV?=
 =?utf-8?B?T1BNTk9TaWwrQXB4VFdoNzVjeEFFcllaUklwUzBkSndmME1Zb2hxQzdBeXN4?=
 =?utf-8?B?TGdSbFYydHh5NlI4VVltck1qME1adGlScUgwWmJvdGxidGJQVklPV24rRVdl?=
 =?utf-8?B?Rkd1dzJxSVRxQ1NkUHVNY2NTYkx2MysvV2tBK2lXM3l1cnJHWG9VcnFucEZt?=
 =?utf-8?B?NmUxNEpaVjh0YUtXdFViWXNZTTZOS2NpTmFDZWpORU9WZjYzRko2UXlvY29N?=
 =?utf-8?B?V21ndDY3dzJNWDhrWlJtdUFvNndZbm9tVnRSWDR0UjM2T2hpM0pIaDE4bHFK?=
 =?utf-8?B?U2s0ZDQwVHhTU2hjK0dTVXVtTDh5QVJBZEFFeGI2YVJTbWt5R0krV09XS0Jn?=
 =?utf-8?B?ZVdOb2x0ejFVbUUxVmkyZmdaQXh1UHFpVW5nTzdKaFRDSTEzTlF3ZWcreitY?=
 =?utf-8?B?eGhLc0NIVlFlTTBrVUFDdVpUcG04Y3owZjB6dmY5bkNLVVdrYXhtUzNPVmVq?=
 =?utf-8?B?ZE42ZWFZa3pvVVpFWmVtYmcwLzZlME9BRTBoNjZYcWNjUG9udk5SaFFiMXQx?=
 =?utf-8?B?bVhpWmJFOEVLMEdudDJaSmFXY0liZ0VKMGk2SHB1M1BrMmFYbjQrK3E5R2t3?=
 =?utf-8?B?b2xYc1pJSHh3Y05xZml6R1hkSEhMcUI2Q2lqajhnbEdqMnBRN01zOHV6VldO?=
 =?utf-8?B?YVg3K2p5WW1KalV3WGlBcFpRUjJTeVJKTlRIQ1FQdHJxTzNIcm1FV0JFc3FF?=
 =?utf-8?B?NHBlV0tWZlc1QjBzV2hDSi8vZ0NxVk9KcWhxd29yWWRReDZEaU9NSjhYMmFu?=
 =?utf-8?B?bTBIekNZdHdvWTl4OFdyL2w5Vm4xKzdIMkp6RG9mcU5DMEx0MUtRc3Jma0x5?=
 =?utf-8?B?TjhRN2RoaXBtSnBKQnhuZFdZQkUrdDNKNDlpcm9iOTQrc2p2N254VGU3cWZP?=
 =?utf-8?B?KzliNmt3SkVLbnBuQXFlMUgyTFF4VWN6L0ttb1UwQmpkNDhwcllBR0RENmRX?=
 =?utf-8?B?NGZWblcvazhvdXVzaUpuRUFPS0YrWU5zNE8zY0VuMnhDWVBRamM2bktJVkpJ?=
 =?utf-8?B?VERYNUFxNmhCOTV2U1NOcUkxaGZyNHV3TFIzQnQ1Nmk0clJIMHE1M1lEV1Zn?=
 =?utf-8?B?d2RLQURYMzRjSEs3MmJZVE1UdExidzRwa0xnM0k2YndYckQ2WnZGQmRyVDB0?=
 =?utf-8?B?dVEwZjY1MUNpTXpWVDdsUENhd3d6Ly9vN1JpdkhaMVJ4NWplWlR1SXo4WWRB?=
 =?utf-8?Q?qNTaBU43cglI9DpjLfHH1yCB934I4sxq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDdzMUd3VHA5REYwV2NiM2lPRlA1VzVNcHNmalRJYVk5ZFF2bWNLQytjNS9P?=
 =?utf-8?B?TmRIeVFSaTEwaElHU2ZKRzk5ZExsYVQyR2E0M2F6SXNKSG5OQkRucFVmM2lP?=
 =?utf-8?B?VEJObWFpZTNRKy9WdFF6azQ4eGFLSjZwTHB1OTJGOWVrVGtvK3VzOVVVR21j?=
 =?utf-8?B?WmdyYTUrdm9JMms3OWR1T0JzSEJFYXFrYWxZQWZ5TlJJeXNCaEFYaXYwdGxi?=
 =?utf-8?B?RnVkMjRrbmkrLzVFTU5oU2svQ3dVT0ptNzJaZXk1cGp0UUYzWEdCdzU5c2du?=
 =?utf-8?B?djFQSGx2RG5oKzR3SkM2K0Z6ZklYcE5KMThjcmNMNENJeVY2N1RDTG5xZXFG?=
 =?utf-8?B?cFp4bElPSndMNG1yZTF2TURDQTBRSkRHc0NOZVdjM0Q2YWtyNzRvTlQxMElS?=
 =?utf-8?B?aEFaM2FlajUwbW8vRUsxNlNYWkt0UDN2ajZJZW1RZ01la2E3QjBBdjRNbk9z?=
 =?utf-8?B?dmI0RVVsVFcvRnBPd3dvelZGWXhaT0FZeHJLZmdMZFoxOXQ3d1FreE1XNUZV?=
 =?utf-8?B?eXpnNm1QYjBEUjBwTzREMlN5aTUrNVZOK0F5TERMTnVrL0dibElvSWJXMTc1?=
 =?utf-8?B?U3JMdkJvQndmSDEvRmlMall0VEVzdzZyUVhMZVV1SXYzRlhaa1ZuL2JNbFRC?=
 =?utf-8?B?YkJKcHhvZ1h4VXJwMld3VHBSV0JlOHhtUk5XOGlwQ0U5YjdhbVUvVEorUlRm?=
 =?utf-8?B?L2lUdlpWT1o5UnJOa0tNbHZHK00wVjJkcnVLYVI1dWUyQXhSb0lsdXVkaDJ5?=
 =?utf-8?B?Y0JRWUZyVTA1T1JNd0N0cElmRHpJNHp2cjJsakNMRlFmeU9McURjcmtPK0dY?=
 =?utf-8?B?SVZUNENGdlVick91U1YzWHJMUTUwWk1MZGxQNVdmQlJIdVNMVGtBb2VhSjFK?=
 =?utf-8?B?dER2Qmp2U1A3bkI2OTRvUU95Qkdyem5NbGcwNnlQcDVrREJPNFJyQk1zeUxY?=
 =?utf-8?B?WTQ1UlhXWWxQNlBrUWc4eDFoMkV4MExzaklLNjV0N0hRVU05NUJwdDBwek8x?=
 =?utf-8?B?SkQrOXRRQnNxRzI5dHo0Y2lmdUhqVzBOdHRCaXFIVTJTU2gyQTAyVFFDdFFj?=
 =?utf-8?B?bXAwMGgrb01URytyaFZJYisyZDhsTGdHdFZTc0dOb0g0Z25yTlBwZmxHY1A0?=
 =?utf-8?B?WWJiUU1xTGc1c0EwNHRBT0RxbWdHUzNjQXdWNkREYkMwb1ByL1pyUDVHbzZm?=
 =?utf-8?B?WEZyd2gweXVRdHdPU09tR3ZqUFJkNFBGc2ZveTlZYjZQbmJYMHN5eXF2ejU0?=
 =?utf-8?B?bzJMelA4bm42eFVSRHg3YWs5TlFNcjE5WG8xWlQ2VjhiM1Q5R2IrNllKNmdV?=
 =?utf-8?B?aXZ3bXdmbVcraEtEcjRyanhtaUNDblArTjBQUG9GYW54U3JwWkJWKzdCU0Rm?=
 =?utf-8?B?Vks0ZzRhMkFjNjNXK0dZRS9UTzFRSEs2QlpmdUxWRzh3ZmJySEtxaFhoUEl5?=
 =?utf-8?B?b1l3WDJwZVo4RlVRTDl6dnQ0cHhnOGZPekpmMmFxbWlRZGJlYk5XaVNuWURF?=
 =?utf-8?B?WVQzYXQ1dVhmbzFtVnRGRlVIZXJXNlFXOGdXZlJMSHFVRzljcGhSU1VJcmY3?=
 =?utf-8?B?MDdGalNobkM3VXJrbUNRQkNPL1hSMlU4dlNwNm9PQldIMjJRYVdyaytjZDNp?=
 =?utf-8?B?a3M3aklsUjA3VHYxYVpuaS9XRnlXTjRaZFVRUnBmRkl4ZHRuWEpOYzNvMmhP?=
 =?utf-8?B?ODAyZy8vYmxWVjRDY0IyWE5yRi9WZGVCdys0cVhqUzFoSGhCQnRFRmdaRGdX?=
 =?utf-8?B?SVFLRHJnby9zTEFYeStSMGc4bnBxYTZUbGFZeWZSQ3JrT1FDWHNUWGlmZjY3?=
 =?utf-8?B?TWY0M1NtQndNZWYzcVdBU0ZvSWtyLzZDN1dFYTAyQnNxV1hoUWlydTd4S1Bl?=
 =?utf-8?B?aWVEL21DaU00ZXFtUWs0MWpRaGlrN1ZlcmR2WkpscFg0ZzBSVkRpUXN5TlVp?=
 =?utf-8?B?T2IreC90OVZvNnhPazlqei8wZHZ4UXQrSDFaNElEVmVITDltQjlDM3htemxj?=
 =?utf-8?B?dmZLUEJuK3FQUjNRcmFRMWtVbXZpMzZyblhpVEdtT3RrVy9VRWNCYnR4ZStL?=
 =?utf-8?B?dnJHS05KWldDYkhDUlpwU1NybFRqWDVBWUM1alZSYVpVK1J6TTNCaWJ3aUVm?=
 =?utf-8?Q?vfd1S7UxY4Q3WGApOcnskfoeH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30961F50C32FCB419F4CAD8F4BAF3924@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f3fd4b-ad63-4d4d-194b-08dd5630a0f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 06:41:41.4838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LOUV/FpS6+pWO0bYrwCQkt+5J20BDbdFuRz8Xu7P/TPZQztsR2qTeDNb+pJQCp4qytpp/i3pzZctsDQJ0e8Gfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6670

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDE3OjIwICswODAwLCBKYXkgTGl1IHdyb3RlOg0KPiBpZiBt
YXRyaXhiaXQgaXMgMTEsDQo+IFRoZSByYW5nZSBvZiBjb2xvciBtYXRyaXggaXMgZnJvbSAwIHRv
IChCSVQoMTEpIC0gMSkuDQo+IFZhbHVlcyBmcm9tIDAgdG8gKEJJVCgxMSkgLSAxKSByZXByZXNl
bnQgcG9zaXRpdmUgbnVtYmVycywNCj4gdmFsdWVzIGZyb20gQklUKDExKSB0byAoQklUKDEyKSAt
IDEpIHJlcHJlc2VudCBuZWdhdGl2ZSBudW1iZXJzLg0KPiBGb3IgZXhhbXBsZSwgLTEgbmVlZCBj
b252ZXJ0ZWQgdG8gODE5MS4NCj4gDQo+IEZpeGVzOiA3MzhlZDQxNTZmYmEgKCJkcm0vbWVkaWF0
ZWs6IEFkZCBtYXRyaXhfYml0cyBwcml2YXRlIGRhdGEgZm9yIGNjb3JyIikNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEpheSBMaXUgPGpheS5saXVAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jIHwgOSArKysrKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9jY29yci5jDQo+IGluZGV4IDk0ZTgyYjNmYTJkOC4uYTlmOTFiNzE1MzRi
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYw0KPiBA
QCAtMTAwLDYgKzEwMCwxNSBAQCBzdGF0aWMgdTE2IG10a19jdG1fczMxXzMyX3RvX3MxX24odTY0
IGluLCB1MzIgbikNCj4gIAkJciB8PSAoaW4gPj4gKDMyIC0gbikpICYgR0VOTUFTSyhuLCAwKTsN
Cj4gIAl9DQo+ICANCj4gKwkvKg0KPiArCSAqVGhlIHJhbmdlIG9mIHIgaXMgZnJvbSAwIHRvIChC
SVQobiArIDEpIC0gMSksDQo+ICsJICp3aGVyZSB2YWx1ZXMgZnJvbSAwIHRvIChCSVQobikgLSAx
KSByZXByZXNlbnQgcG9zaXRpdmUgbnVtYmVycywNCj4gKwkgKmFuZCB2YWx1ZXMgZnJvbSBCSVQo
bikgdG8gKEJJVChuICsgMSkgLSAxKSByZXByZXNlbnQgbmVnYXRpdmUgbnVtYmVycy4NCj4gKwkg
KkZvciBleGFtcGxlLCBpZiBuIGlzIDExLCAtMSB3aWxsIGJlIGNvbnZlcnRlZCB0byA4MTkxLg0K
PiArCSAqLw0KPiArCWlmIChyICYgQklUKG4gKyAxKSkNCj4gKwkJciA9ICh+KHIgJiBHRU5NQVNL
KG4sIDApKSArIDEpICYgR0VOTUFTSyhuICsgMSwgMCk7DQo+ICsNCg0KVGhpcyBmdW5jdGlvbiBp
cyB0byBjaGFuZ2UgczMxLjMyIHRvIHMxLm4sIGJ1dCBpdCBzZWVtcyB5b3UgY2hhbmdlIHMzMS4z
MiB0byB0d28ncyBjb21wbGVtZW50Lg0KSWYgc28sIHVzZSBkcm1fY29sb3JfY3RtX3MzMV8zMl90
b19xbV9uKCkuDQpJbiBhZGRpdGlvbiwgYXJlIHlvdSBzdXJlIHRoYXQgTVQ4MTgzIGFuZCBNVDgx
OTIgaGFyZHdhcmUgdXNlIHR3bydzIGNvbXBsZW1lbnQ/DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAJ
cmV0dXJuIHI7DQo+ICB9DQo+ICANCg0K

