Return-Path: <linux-kernel+bounces-240388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A5926D22
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCDFEB21D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E4D8F6E;
	Thu,  4 Jul 2024 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XRzQfqBG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rEy5xnjd"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFEE14285
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720056941; cv=fail; b=V7jIZGVpxF6iq48AHGYJzvuFLRjqBF2El2Phd0e4TJtxT68S+9ekjGX4cUfPaGYiEi61PIAvqYI62Pe9L1wT2TWi5oYDa6Q1mMy8YxN9JN4/mCermNlQYs39gZR63l9qUv3KTTzkbg0toI07nd8gbNE25ep2FhsTX8Y6M8mg6Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720056941; c=relaxed/simple;
	bh=VL21A/jhpJmn9YKsTb6SnxLLg0iYO/2bw8ERiaujkKc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FvcPw6xgOgZ+WM5AVRrFNPQPGLYFOhmtdFxVOJPWJ8zDCfvdQR2hzJG6JpXdCrXhug+R5kacmR8gBGGlI3hqnlRDuRUK4IKV8GSAhgDe5MN2803w3UXl8QFZBOopVO3kJzq43tm6QXknuHkjuXPJu6hNZOS8KNfCU/2MQx7F4vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XRzQfqBG; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rEy5xnjd; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b5d8dd5a39a511ef99dc3f8fac2c3230-20240704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VL21A/jhpJmn9YKsTb6SnxLLg0iYO/2bw8ERiaujkKc=;
	b=XRzQfqBG3L8rdhRmRlKfYu99PCR7nqLTeNoF1bZgYdbfl1Y0D3nQTZXOfL0AWFTSkC7eH65my2WPbrfDqD4VL1vNGE8GmwPDMA3Pz+Xuf9m3QsNOsrX2AZl1N1TbY70rLAE2rbcxFtQhNwbq6G7MZHegskLH/Xf+lXnRtVrMwu4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:dd41fe6f-6874-4cd5-92e4-d76a2a39cdb1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:946c10d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b5d8dd5a39a511ef99dc3f8fac2c3230-20240704
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1405965569; Thu, 04 Jul 2024 09:35:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jul 2024 09:35:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jul 2024 09:35:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJnF4QQDDydXelUq7J1vDjxgoGMh5ABT/jAlhNRhAwll3ycjD/L3xGGCi7/IoUsmGrXJGRLnD3mCys19bHH+DSuJj+kmNgKJzqXimEovVnyHXy8b9U4WJfruPEf/Q8LMGD0+Ck43UOChXt5gbuDaomvWaTxkkeX5N/EI+Vsai6JvtmBIkm8L5NmIqmJI6AsY6txKBv2vMyNU3yqDxIzPobh/fwSs1suPuQGhRaAOWout55amqOhjlrtzoKJWeybGPXFUtTsVC2BFUf8riO6509aovhN66UvQJXWvb/KhjogayvGT+lxpVVpy0c9dJ5B0zC7k4/SU/EAxfmKe2+iVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL21A/jhpJmn9YKsTb6SnxLLg0iYO/2bw8ERiaujkKc=;
 b=j0TpWJ41A3o0Th53g3UIVx3KxeaCawU9fJOwJLUGYmS3zBAf1F/ghmxz4U/NZRa2pbchwu47/JEXF4hZ/HHlejhXQxHjYmW0eHe3pHh3LcJDP8K8T0sazpVTaATcjXNcOWwsYmmK4Cq7sW4IlrwOjw7+4zS6FY8dNMVKFt0Z5a2s6zL9GQ0R9pNXjsOcwAaNvGxYwHus5W9wC5i4jUMWY30NGcs/qesgfm4UJahQCwZL04syBk3G+TeEbH/DcqQsz7CuarklAKdGtBepSjY3GkjwkH+4m8xwH42w6Hv9I3fGP8cUSY0rA0tsBA1BkTU7R/KRdjJlT7MxUrYL23FsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL21A/jhpJmn9YKsTb6SnxLLg0iYO/2bw8ERiaujkKc=;
 b=rEy5xnjdxHpYcfyEr7Wuez08uFY0sNqfDYPXYGYwXvFeTnW3wyjsMbnxSU7TztO8vnbKPiivH9z0GTeRUx3Qz887JQIUHdGRGEiegblzHkOue8GyDZzVxFRHGTT0yx/j5rvEmA+BehRyLhVnE7gPdzkTWAk19040mliWxuORSVI=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SEYPR03MB7414.apcprd03.prod.outlook.com (2603:1096:101:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 01:35:31 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a%7]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 01:35:31 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "airlied@gmail.com"
	<airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/5] drm/mediatek: Support "None" blending in Mixer
Thread-Topic: [PATCH 2/5] drm/mediatek: Support "None" blending in Mixer
Thread-Index: AQHawm4CehGZ7j4H80uVSodFizERF7HhQ4EAgASciwA=
Date: Thu, 4 Jul 2024 01:35:31 +0000
Message-ID: <5cee68d3bee73e034781c8ee8b5ff2c2c045791f.camel@mediatek.com>
References: <20240620-blend-v1-0-72670072ca20@mediatek.com>
	 <20240620-blend-v1-2-72670072ca20@mediatek.com>
	 <2bcb715c19c8445746a00bcd4b633ceb42c286a1.camel@mediatek.com>
In-Reply-To: <2bcb715c19c8445746a00bcd4b633ceb42c286a1.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SEYPR03MB7414:EE_
x-ms-office365-filtering-correlation-id: 798d6b23-c142-48bc-9d5f-08dc9bc99770
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZFQ0aCthVkVhMjFlVnFXWWFQMjFyR2hoQ2pPSk45ZjQyVlBQbEZOcCtWOTMv?=
 =?utf-8?B?Z3ZKYU40TVlyZDBucEdieHcya0FUSkt3R1BRNnlydnV5U01maHFkOWQ1ZUN4?=
 =?utf-8?B?WEthWWJtdGRJRWE5eHlkKzN2WnNhcFUzSTNUclZPY3BSdXg1WXAzcW9GRS83?=
 =?utf-8?B?Rkd3dG9VNTczUDAvcXBualpMcGJoQXFZT3FwakdLdnFaRXE1SXprb1NZbExh?=
 =?utf-8?B?Vzh5TDRZQlFMKzBkN3gxL29oUnllM3ZYb1orekl3SjAvVFJJUXIxWXVMSGFB?=
 =?utf-8?B?TU5Da2g1cWZNZm40TjNnZkVQSCtQZ0FuU3BRSzNITnUrdmliV3VZWEhXR3F4?=
 =?utf-8?B?VE15L3NmOTBlQk1leFpVVmE1OTNPSTc1d1NDQWZNSnFtSGZBTGVRS1k5STNY?=
 =?utf-8?B?R3lqRGdGWGZJVDErWjlZQ1ZvNFJrVjEyRFdlbXhaaDhOd202NlYrbm54RnEw?=
 =?utf-8?B?WXVpdzVjcmhEOHBVVUdoUkJJSzBsRVBtYW9FV1EydjdEbkxoV3d4aldZSUw4?=
 =?utf-8?B?QUNwSnJuV3BIbGhNK1prbmdYL1lwamxLc3hZeVU3aXZIeFVNWklndEFIZ3NO?=
 =?utf-8?B?ZXlmZnNmRGpBLzJRRGxwVURuTkJKR2Rpd0JiVlhmbmtkc0l0Z01TKzJ3M3JJ?=
 =?utf-8?B?cXJHeHgvK0FEY3cxQ0lHZnFuSXR1TGQwYkdadTZKbVpEdG04bGRUdzJ6bVJK?=
 =?utf-8?B?dmRzMG1SdEE0L05tb2dDSWRDMG80bzJ0eVBCTFIvSVlyVkxqWVZFcnJPWTVN?=
 =?utf-8?B?UVBhbkdRZ1NPTzViVTF4eGY3UDk2OHlOdlhSM1FvSWdnSVM0WER1NFM5MUJB?=
 =?utf-8?B?NGFRWmhnRkM3VkNDNHJaWjU3Nm1uWlhsK3lqZ1dvZ1N1R1ZwUGhuazdIemZv?=
 =?utf-8?B?eWQ4dm4yZWdQYUpKR0lRekNzZE02V3NlZ1IzQVgwcnFuakw3b1plai9iMG1Z?=
 =?utf-8?B?SmMyKzM3bmxZTzBwZDI2U2k4OWM3T2xjaDVYQmhDTmVrOVRhUC9EU21uem9s?=
 =?utf-8?B?TGExNlY1eGM1QnlFMWpsTTdwMzBmU0NLbWhOM285OWVqMWxnVS91OXdyQ3Uw?=
 =?utf-8?B?RlRDWUV3RHJobGdCZ3VpS2ZPVE9IY05tL3lTaEhQd1k0WFlLTTRJSGgyVWUx?=
 =?utf-8?B?dkRqL1FvVm5CeDZ3anFmNzNxaWd0MFRnamo0MVh2aENMWklzbDhsNllxeHRw?=
 =?utf-8?B?T0FzNlZTZFdNYzBLd0NSVE5wZjZzZ25QQlNVYmtrWHBxWC9sVVB6ZEkrY1hp?=
 =?utf-8?B?MlI3ZHJBT25sc2xBUlJrMHRhV2RTb2RGazZSZGkzU0JjbWxpT3JXckxObllp?=
 =?utf-8?B?VjlGZExQVll2dmJmOGJmZVNwRVpjU2xGakR0aFg3bXhRcC9KV2FQT2tsZDlC?=
 =?utf-8?B?TDFhalNlQm54S1dVb2NNdjdTQ2RtNUNkZ290eSt3NVovWDFLU2lwWEIxdmJX?=
 =?utf-8?B?MzhuWW8zZlJsRW9QYjYxNkRxUngzaTZsNDNoc0ZuVXV1bjVGczdmZWJxemht?=
 =?utf-8?B?eEg5VzJUV05zbTAvbGpieXJnaFdFK1dJMHdjbE5heDU0N3lMUzJGTUplRWV4?=
 =?utf-8?B?K0kvSUVLR0pWbmVla0tKQXIvb2pxNk9kR20wRFhrTG9Gck91TWdhNFl4Lzg3?=
 =?utf-8?B?VGtUWE42dWdMQjQ0amVUOGhGQVo2QmZJZ3Z0SnhCelNtZXNwZDlKNU5IL21Z?=
 =?utf-8?B?UUtoZ25iYTBOTDdLOXdmdHZQVlQ0MHR1VVQyRWZWR1lIUWxnS21VRGxIYksr?=
 =?utf-8?B?VS9PZ0pxOHVYSjU5U21NU0M2UkJmWTNwZktnN1FvaDZvaWNzcXZaN04xQUNo?=
 =?utf-8?B?U1VtcnVDelJRaFhSbFljeXlTaHgrdDZyRjhXWmEyOXdDSithU24xV0kvbXVR?=
 =?utf-8?B?b1ZFNCtiKzM1ckJDU3BKZFJXeEtHTW9UbmlDSEVNbVRyN0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qmg3ejAwOWFIZ1NUOXZsVEw2WVhMcGRrOHpTTjI4eE5MVTlDdFQyVllQcmRS?=
 =?utf-8?B?WTJDQStPbUYrVmJwQVZXREdWYlNLY0swc0VpR0VVZXVFNUQ2b1VTNDdDUVBk?=
 =?utf-8?B?UFpvbnpKaGRYaExZb2JYMkNuMHR6YlBJZ042U1lBT0xKUmtEQy84MUhlN0Vy?=
 =?utf-8?B?V0FISDlFbEROVDNpY1A0Z0ZIWjVJWGlJSFd6MzlzbmFYK2hBTDA3bHNHNzl0?=
 =?utf-8?B?azBpRmVqdGxYMWRWMFhZamYxVXl1cVNnRmd1ZFhER1NacS9oYllEaFQ3ZVRh?=
 =?utf-8?B?R3V1SXhqOVJWRU5UUEdtUUJMNHQ3YWJzTTM4V1VHR2RVL21sUEFCNXVQUjJU?=
 =?utf-8?B?SG5kYW55ZEUwTnUvNTFEald4RFJSM2tid1NJT0JOMSs3WU53alpaSm5lUksr?=
 =?utf-8?B?Mm0wU1VMVVg5cWtUaUpPNDhkUnh5NDYvbFBJbTJwUk5UdFgrWkE0ajNVb2s0?=
 =?utf-8?B?ZzhtODhUdi9kc25Hek5HWVB4ekJUVUJ6Y2RNYTA5Y0kzU2prSDVYNCtTeFhW?=
 =?utf-8?B?all6Qlc1SE11R2JmNHdBSUhrU0xibmxwazlIaGNiWUkyTk5lSmk5c1V6bXc3?=
 =?utf-8?B?M0wzV2ZtejV1NGR2UnhxMDBWa2JIU2JDUEQxKy9GWnA1TWhON1pLZXR4bmw4?=
 =?utf-8?B?Q0Y1bnJyZDNBdENucUZuWTZGdThGWXlxcnBGV0dXMnhqU0ExQXE5ZVQ5cURm?=
 =?utf-8?B?NEJqbks0akdPSzhtdmpoM0xxMVJHNHQ5ZGpvbzZ2N2NISi9TNGRYRkw0OWI2?=
 =?utf-8?B?ZUg2UXJObzMyR1pqL0lNZlVtdzJ3N3A3S3VielUxejBKZVdzVjdwRWxLSmhE?=
 =?utf-8?B?ZzV4SHhqZFg5YkIxM01VVU45U1EyVDRPdkY2T3pxSHN6Y3F6dWFBY0kxRVZk?=
 =?utf-8?B?MUNrdWNmTFpjeGkxT2t3TVN3d2Z5UnJ3ZkFKcDZYRGZxeEVLTm5iVGV4MzBI?=
 =?utf-8?B?TTlENFAvL3NXd2Jmanljb2dhV0FYTnJiZ2tDdEVuNVczYUpETDc3a3lCNkF6?=
 =?utf-8?B?emUvSmp6dWI5ZEUwM3VhZXpuTUVoa2w5R2JQYUgvNDYzZU5XTXNaWFN3eGpG?=
 =?utf-8?B?cklnOTFaMmhPREc1Y3V2d3pZYWNoSitHT29HWlpHUWxYVFNmblVUZUhxUVFZ?=
 =?utf-8?B?VE9kUTA3MStJTXRSYVZHZjVuWllyTnhlTFRlT2NKSitzRHFjUW5HYXArd1JN?=
 =?utf-8?B?cTZUaldndU5GQVZUNXJJUkZwTEJuUmMrWW5WNEk1K1VXMHRpOStUcitveUow?=
 =?utf-8?B?SFZNZE9iSmpneldVS0tHRk0xenk5cjJ5bmkveWVBTkRmYy9wTTNpbXM3T1o3?=
 =?utf-8?B?SHVQMHBPbllTcHBhYkhvc0l3SzREZ1Azdk9MREdtUlphQkpCY2RpenRxcHpZ?=
 =?utf-8?B?L3VWaEJ3dmorRWRvN29icm1NaTR4QTR2UVY3WmRzalhka016UjlUQXBmM0hq?=
 =?utf-8?B?SS9DZ2orcnMvM052N1BhRW9wUjZtNVdPMXRyYm8xOFg4VEoyTTZrT2ZoY2l5?=
 =?utf-8?B?SlJyWXcyOW4vNTdEN0ZEOUFDSFlweXU1eUxyRlpvRzBWQ0ZneVJwOUFBQlZ2?=
 =?utf-8?B?YXExam5BZTdqdWUvaGw1YUprcFZyUS9OZzN4WGJKKytqNUZ4dys0RWpRQmt4?=
 =?utf-8?B?NGhveGErb0xaaSs4Uk9mWjNwcUhZU3lRQkVsdUYxQ2JBVWREbU0wdWdPcDM2?=
 =?utf-8?B?YUI2SEx4UEJsSUd0ZzhWc3ZCUkRDdkU1QlJOYTBsWU4yQ1ZBaGJiWk55MjNy?=
 =?utf-8?B?ajN0MEErV1JGZTl0WHhzOVhhOWZhcTlIOWRmSlFBZ3dvNmtRRGdvM3VJdVE2?=
 =?utf-8?B?b1RHbGQwTUxjYUp5MkJXU28ydnZYemkyR3Vya0swTEtabnNML2Nodk9YRTBL?=
 =?utf-8?B?OTBoclJCb3JmU25paVdFYkUwOXBCN0VmcFpLYnBxUGJMTVp6THlqSTluZFgv?=
 =?utf-8?B?a056Sk8xTGVEQUJpRm5WVWFheHZkN1JYcHVkQ2t2YTlWb05SYlpkYTdVVjV2?=
 =?utf-8?B?b0NieE8weFhvai81a0drUDhpTHdvaHp4U0lIcGgvK25JN1lyWmpVZGpXNjN3?=
 =?utf-8?B?bEo3QUpUOTgrZlZIdXFidUt0WlhEOGlnTVI0R050SkpYSWNwZXl2WG8xenFH?=
 =?utf-8?B?OUNzVHo4OC9PL3ZqTDAvRE55ZmxlQzNOak9ROXlRNWhhTnZYSk1zNW82YWFX?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F42F7D0EACCE1E4EBECB9FC3793ECA8B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798d6b23-c142-48bc-9d5f-08dc9bc99770
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 01:35:31.0684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TV62wWl5NwYw2A8ekVXbA9+e46gsN+B5cqJxqP291vqJEOlU68LoQy/52PVldkG+6pAF9OrdRfUvWmk0oedfYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7414

SGkgQ0ssDQoNCk9uIE1vbiwgMjAyNC0wNy0wMSBhdCAwMzoxMCArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBTaGF3bjoNCj4gDQo+IE9uIFRodSwgMjAyNC0wNi0yMCBhdCAw
MToyNyArMDgwMCwgSHNpYW8gQ2hpZW4gU3VuZyB2aWEgQjQgUmVsYXkNCj4gd3JvdGU6DQo+ID4g
IAkgDQo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMNCj4gPiB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiA+ICBGcm9tOiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBTdXBwb3J0ICJOb25lIiBhbHBoYSBibGVuZGluZyBtb2Rl
IG9uIE1lZGlhVGVrJ3MgY2hpcHMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hp
ZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYyB8IDEzICsrKysrKysrKystLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+ID4gaW5kZXggMzYwMjFjYjhk
ZjYyLi40OGI3MTQ5OTQ0OTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19ldGhkci5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19l
dGhkci5jDQo+ID4gQEAgLTMsNiArMyw3IEBADQo+ID4gICAqIENvcHlyaWdodCAoYykgMjAyMSBN
ZWRpYVRlayBJbmMuDQo+ID4gICAqLw0KPiA+ICANCj4gPiArI2luY2x1ZGUgPGRybS9kcm1fYmxl
bmQuaD4NCj4gPiAgI2luY2x1ZGUgPGRybS9kcm1fZm91cmNjLmg+DQo+ID4gICNpbmNsdWRlIDxk
cm0vZHJtX2ZyYW1lYnVmZmVyLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiBA
QCAtMzUsNiArMzYsNyBAQA0KPiA+ICAjZGVmaW5lIE1JWF9TUkNfTDBfRU5CSVQoMCkNCj4gPiAg
I2RlZmluZSBNSVhfTF9TUkNfQ09OKG4pKDB4MjggKyAweDE4ICogKG4pKQ0KPiA+ICAjZGVmaW5l
IE5PTl9QUkVNVUxUSV9TT1VSQ0UoMiA8PCAxMikNCj4gPiArI2RlZmluZSBQUkVNVUxUSV9TT1VS
Q0UoMyA8PCAxMikNCj4gPiAgI2RlZmluZSBNSVhfTF9TUkNfU0laRShuKSgweDMwICsgMHgxOCAq
IChuKSkNCj4gPiAgI2RlZmluZSBNSVhfTF9TUkNfT0ZGU0VUKG4pKDB4MzQgKyAweDE4ICogKG4p
KQ0KPiA+ICAjZGVmaW5lIE1JWF9GVU5DX0RDTTAweDEyMA0KPiA+IEBAIC0xNzUsNyArMTc3LDEz
IEBAIHZvaWQgbXRrX2V0aGRyX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlDQo+ID4gKmRldiwg
dW5zaWduZWQgaW50IGlkeCwNCj4gPiAgYWxwaGFfY29uIHw9IHN0YXRlLT5iYXNlLmFscGhhICYg
TUlYRVJfQUxQSEE7DQo+ID4gIH0NCj4gPiAgDQo+ID4gLWlmIChzdGF0ZS0+YmFzZS5mYiAmJiAh
c3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKSB7DQo+ID4gK2lmIChzdGF0ZS0+YmFz
ZS5waXhlbF9ibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUpDQo+ID4gK2Fs
cGhhX2NvbiB8PSBQUkVNVUxUSV9TT1VSQ0U7DQo+IA0KPiBUbyBzdXBwb3J0IERSTV9NT0RFX0JM
RU5EX1BJWEVMX05PTkUsIEkgdGhpbmsgaWdub3JlIHBpeGVsIGFscGhhIGlzDQo+IGVub3VnaC4g
V2h5IG5lZWQgdGhpcyBzZXR0aW5nPw0KDQpZZXMsIGJ5IHNldHRpbmcgUFJFTVVMVElfU09VUkNF
IGJpdCwgRVRIRFIgd2lsbCBpZ25vcmUgdGhlIHBpeGVsIGFscGhhDQpvZiB0aGUgbGF5ZXIuDQoN
ClRoYW5rcywNClNoYXduDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KPiA+ICtlbHNlDQo+
ID4gK2FscGhhX2NvbiB8PSBOT05fUFJFTVVMVElfU09VUkNFOw0KPiA+ICsNCj4gPiAraWYgKChz
dGF0ZS0+YmFzZS5mYiAmJiAhc3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKSB8fA0K
PiA+ICsgICAgc3RhdGUtPmJhc2UucGl4ZWxfYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVORF9Q
SVhFTF9OT05FKSB7DQo+ID4gIC8qDQo+ID4gICAqIE1peGVyIGRvZXNuJ3Qgc3VwcG9ydCBDT05T
VF9CTEQgbW9kZSwNCj4gPiAgICogdXNlIGEgdHJpY2sgdG8gbWFrZSB0aGUgb3V0cHV0IGVxdWl2
YWxlbnQNCj4gPiBAQCAtMTkxLDggKzE5OSw3IEBAIHZvaWQgbXRrX2V0aGRyX2xheWVyX2NvbmZp
ZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gdW5zaWduZWQgaW50IGlkeCwNCj4gPiAgbXRrX2Rk
cF93cml0ZShjbWRxX3BrdCwgcGVuZGluZy0+aGVpZ2h0IDw8IDE2IHwgYWxpZ25fd2lkdGgsDQo+
ID4gJm1peGVyLT5jbWRxX2Jhc2UsDQo+ID4gICAgICAgIG1peGVyLT5yZWdzLCBNSVhfTF9TUkNf
U0laRShpZHgpKTsNCj4gPiAgbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgb2Zmc2V0LCAmbWl4ZXIt
PmNtZHFfYmFzZSwgbWl4ZXItPnJlZ3MsDQo+ID4gTUlYX0xfU1JDX09GRlNFVChpZHgpKTsNCj4g
PiAtbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBhbHBoYV9jb24sICZtaXhlci0+Y21kcV9i
YXNlLCBtaXhlci0NCj4gPiA+cmVncywgTUlYX0xfU1JDX0NPTihpZHgpLA0KPiA+IC0gICAweDFm
Zik7DQo+ID4gK210a19kZHBfd3JpdGUoY21kcV9wa3QsIGFscGhhX2NvbiwgJm1peGVyLT5jbWRx
X2Jhc2UsIG1peGVyLT5yZWdzLCANCj4gPiBNSVhfTF9TUkNfQ09OKGlkeCkpOw0KPiA+ICBtdGtf
ZGRwX3dyaXRlX21hc2soY21kcV9wa3QsIEJJVChpZHgpLCAmbWl4ZXItPmNtZHFfYmFzZSwgbWl4
ZXItDQo+ID4gPnJlZ3MsIE1JWF9TUkNfQ09OLA0KPiA+ICAgICBCSVQoaWR4KSk7DQo+ID4gIH0N
Cj4gPiANCj4gPiAtLSANCj4gPiBHaXQtMTQ2KQ0KPiA+IA0KPiA+IA0KPiA+IA0K

