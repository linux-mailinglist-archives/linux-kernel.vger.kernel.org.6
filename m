Return-Path: <linux-kernel+bounces-209607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD1903859
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936221F22CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C381791EB;
	Tue, 11 Jun 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M2bMmylQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pp0tclNy"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65417107E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100321; cv=fail; b=RlbWnBEs34TpdxK0InA3lv7NooI9guI5F6w791gH2a9QE5UNZCPiOc/BSdFjUWu5GMciMecbDDn+71ri/LRhc2vlkru4c+JNRQV3Vt88s0uL+9Jz8NfyV+mTp2/XjC3gih3Q/kYO+oU9BtwMKWF6tbiKqsnqFBrsnXfC5yBOdIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100321; c=relaxed/simple;
	bh=fS1Lwuv6XNK7O0btFEMsdSE9Pw7qeqyM0HzCetBeysM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A5QoGKUwt8fJtoHXQJPiFFa/2uWKno95ITR8RquaQ/ONDZMmMrIna+dbHojsfUA7+uRB8cWJjhp5WsgxHzVtYwnfk6gqn9W6P52tdEndVHtJnIHedfckzY8e4hvG2XhrUlfSpUot6rQtJiZiGSauSMGHq8XI+QlXiXMKyZ6quZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=M2bMmylQ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pp0tclNy; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 19228dee27da11efa54bbfbb386b949c-20240611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fS1Lwuv6XNK7O0btFEMsdSE9Pw7qeqyM0HzCetBeysM=;
	b=M2bMmylQKXH8+TSIjjlF1hYCuXAB1H546Wvf7/kepykfItCsSMzVyvArOLhTJfGV2VW8N6edIO1u/I9j18zvCC/N1Mr0G3dTRAC9YIolfcpcJ/GUzMdq7VbNU5RZQVGjj4ZZffDSaNDQnBWKLVmf4LYQzfFAzSGxb6XIyzZiwBo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:c58384a5-f087-4b04-a3ec-07172da6cb09,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:1c9b7388-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 19228dee27da11efa54bbfbb386b949c-20240611
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1042071976; Tue, 11 Jun 2024 18:05:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 11 Jun 2024 18:05:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Jun 2024 18:05:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYKrcvAobjkIk/N+KOoO/f6auc4t0bDKgsDePGO2H8LZ5rq8QKyeoyRVHdtIp95tCYczx6L0PiPxkJ9PDIyuRK5AXbV3SFVmqN14wb47vTSIoRvXzL2C4ktJjyvDcZ4OTGtaaBnBD07guoKxeYvp6HFgYsKZEM2IgUkCryf1A/nlwB/7ASfkWpyFUL2N3zPeQEISI4lxTYpcdS5S4O+MANsS786pDU1EDST4SIhvIv5H56CjnkrnYTSls8iQ+loybgx9xNfjcds/nHjmb51f4FeWUV2lzPvkkZ5nrFV3D83e+fnv2mCcksF05LJy4JLk2pirOYPLS59IetEvu8H7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS1Lwuv6XNK7O0btFEMsdSE9Pw7qeqyM0HzCetBeysM=;
 b=ePe/3zcMlHNbyfwPUaluQxV/YrjmsC3fbpKffXyBiAZ7whqJ4Vzr1FdnPnLlBQD46MiPHEz0sKvG/yxgWFtHx8LW5eD71qbM7RipIbmU0gYgdk098UVIMOZemIVY7vn8erZxJe/p33EODJp2/aitG9ueZRlSx1ByMotHBBgYyGs1ssa6JgGDtY2D/sZgCZWipHh0SlX0hpRw1EJYHlU7G5MkGDdbeByiw9S4U2/zpR+478xiVoQPd7mUznHWoH8qHGzytHyf3xJ7tbqTd+PPtdOOJxbBNcc+d9s9dC6c0s8tJQga9BHMU9P003ujNr1+H/QUYsimtTT78CVuYeeOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS1Lwuv6XNK7O0btFEMsdSE9Pw7qeqyM0HzCetBeysM=;
 b=pp0tclNysvEzNgBVB4xtSCJobgQvs/j/vDvhc9zKEDgsoGv29Xhi7DSVcyNOmE1zImVICEAqas5yhPYdDUTAnjC5BJmamf4b/TjYyVJILRcJ8yyC7FniHw66VVQYQsH3hA3vwnYab64oE9d29ZuCDZCWe9DJOuBqiXxOi9e35u0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Tue, 11 Jun
 2024 10:05:07 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7677.014; Tue, 11 Jun 2024
 10:05:11 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 12/16] drm/mediatek: Support "Pre-multiplied" blending
 in Mixer
Thread-Topic: [PATCH v8 12/16] drm/mediatek: Support "Pre-multiplied" blending
 in Mixer
Thread-Index: AQHat/O/N6hy0vqi7EaJ9ib9UZe5QLHCXcmA
Date: Tue, 11 Jun 2024 10:05:11 +0000
Message-ID: <4303f6f9c805fa41e7632b72b99abc72b3f80740.camel@mediatek.com>
References: <20240606092635.27981-1-shawn.sung@mediatek.com>
	 <20240606092635.27981-13-shawn.sung@mediatek.com>
In-Reply-To: <20240606092635.27981-13-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7468:EE_
x-ms-office365-filtering-correlation-id: 13a65d2d-fdd1-46c7-ce62-08dc89fdfb5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?T1IrSFlyRnNrZWMwK1hLYUFXaUhORVRlZkwwaTZGYnJ3VitNb01RNmZISXhO?=
 =?utf-8?B?QklpS1Q5ZXgwZ0xTd2FLbHR4N3NYVWRUcGQ3YVNxVXo0T2M0SFh2c3I4UkR1?=
 =?utf-8?B?RTJGOGJKOTRTRldCTkVPclpuT1gwVzcrcnNNcENiU3Y2RU1qQjY2WSswdyty?=
 =?utf-8?B?MG5TM25vcm5zZHg3dkpPTHUxT0oxdXNDMlhYZmtRNUYrOGUveGxUbDd0cTFs?=
 =?utf-8?B?K1k3OFAwUUcrOEtIUFBJejhWbXpKODJNbXJnRFVlSUdvQ01qOGhkZEVoUFZv?=
 =?utf-8?B?QmtsYmh0WiszTmVpdnlnN01IcmFRMy8rQXFscDZIbngzZG9LbEdzWVBldFF4?=
 =?utf-8?B?Z2RBZVZUSkRzM3pMbGdJNkV0WFhlbmFtWmhwRUtSdDk1dGdwOFQzcms5bFNt?=
 =?utf-8?B?SFRnMEdTcUgvVmtTdlJoRjJPVm1RMGJWRWJIYTd1VDd4Z1FEU3EwUUNpRWxq?=
 =?utf-8?B?YlVsc01rOEYzRzl5NkRHczlNOCtVdGpTdUZsSjFIZDRtSHJmbXlIZkdBeUpr?=
 =?utf-8?B?emszRnE2Um5yNlB0YWFDbVNRR1NMWCtBTFhKZjVVS0NHNll2MFZDMlJhUm4v?=
 =?utf-8?B?b0N2Z3hTR0ZZeGRvSExFMFJ4bWtwVWlRNkhLWEFzMTB2ZUMzdzRrdGRPb3pn?=
 =?utf-8?B?ekd4ZENpUjl0VytlQ0E5alIxVm0xWEJvU3EvN0tXVU5kRVlqU0FwRlI4eDVU?=
 =?utf-8?B?ejlzakIycmV2KzZRUHJWVy9pTnIvRG9HRUFCRkk1WkkwaTN3WlowMHFyaFN3?=
 =?utf-8?B?cHZBY01EUTZveXZLTEphTG14cXV0VnNoWDdkSXRlUmtDVExZNFB5L2dnTUlz?=
 =?utf-8?B?ZEpjRzJKdlRwQjl6Q3NBSFljSEFrSFlETncxUXdQWmNMRXJoM01XWFdWTmVt?=
 =?utf-8?B?MEQxRk54djI5d1Y4M0xFVUdBNFR4cFlWZlR1bWIwd3ExckJhamgvS2Y1VEpi?=
 =?utf-8?B?UkRsbHNJQm9ERldjOHFUNktXMnpYK0VEclRDMnp4WTNtNDg0anlOdCt5ci9Q?=
 =?utf-8?B?OVJsRnJvK05BZ2IwMFh2YVg3MWQ0M2dCV1UzNEhnZG1UYldhTHNuZy9welFF?=
 =?utf-8?B?YWdkOW5iRC9NZTlnemF4VEFacnMwc0hXclNZaVlnaXEySmhESGRSemZKaE8w?=
 =?utf-8?B?L2tOQ2dacnRLZXdjNlkxVTFMck81UU4yM2tpazBSMGlvWk53dk9OVk9NMWJY?=
 =?utf-8?B?SEwvM2N3TWtHVE9HejZzMFU1UzJIQWsvdzlPUlpDV2xjcU8ySy9WVGZhcFB3?=
 =?utf-8?B?UGRLQW1yT3l4b0hOVkZyQ1lSRmZ2c1llYnZ6dWpRYUtienRMRW10NzM5YUdp?=
 =?utf-8?B?eE54N0FIQUw3VTh0Q2ZGanluY0QyL0F2VGZLWDdnNTNTa0IxOXF0Y0N4Q0FN?=
 =?utf-8?B?VkEvaGZmWmxjTTI3enI0Y1dFTDR4NXdvSFVUSVJCREgyNVVRVGNnb09IRVhX?=
 =?utf-8?B?NDMrdnlqVzE5N0NCUUxmb0laM1ZyZ05pYlFUR2FTd1VtMGp0R0pTNW1UTkp0?=
 =?utf-8?B?bUFUQjBuTkVEcXlmcUZ0Y1VmZk9KRVBjOHh3R3FwTzRodEhoT2NJN25zSkQz?=
 =?utf-8?B?dkdCODdRbHhUOUhDc0RqQ2ppbVNldzJDNStYWjZJcEZlZzg4N2FjaHBRSWR0?=
 =?utf-8?B?N3liMFN2cEM4djRzTXBTOG5YL2hTV2hrZDNpVjZBcGF6T1JTL3FVTytIRjZ5?=
 =?utf-8?B?K1pVZ05QczZvdFQwb0ROZnd5SUpuVm5waGJmeXVsSTI2UjdqVWtocTlNZkh4?=
 =?utf-8?B?WXdlSW5GdGovSE1yMjJIb3NyWGcwazJxRUJwUXQyTHlUU0o2cnJiY1liZ3JQ?=
 =?utf-8?Q?MBg3KTsSCg64SV20EzsURkiPw3BMgYmR24jTI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzdKZjZ3ZFF0UCtLVEsvU3UvWUg0QkVJUEZENnhqS1FEZVpxQ3hyT0pVQ0Fs?=
 =?utf-8?B?ZXhBc2UwcjhSdHJxdFBhUjJ5aXI3S2JBNVpodk1lN05UUDZnT2ZuTFVsRno4?=
 =?utf-8?B?ZHFwMGkyclFRbG5ud2ZIbGMxOGt1dXBPbWNzY3VxLzB3QlBrRmRuZi9uMUNF?=
 =?utf-8?B?ZnRHOGJRdFljZzBjQnBnQkl5cGk2Y3E3TjV3QzNBSmdXbTljRXZnODJXVm41?=
 =?utf-8?B?Vm92b3hsQnoxVlJzR3VzRlZzRU5SdGxRbnM0RE8rc2QyMDE3Mk9FdG5uZEl3?=
 =?utf-8?B?L05HcGlIMDFXNVFDc0VQdDZCOGNwNFpmTFRIWXJzdk14ZjZlU1R6djRDNUJJ?=
 =?utf-8?B?cUpHQTFCOFAwNjBvaitNeWF0K2R5Y05WZVlld3M1bTcrcmlCalZob1FlLzlh?=
 =?utf-8?B?OCs4aWQ0Y3JBdDdaS1dHazBHbndQUmV5RHRhSzJYMStkRDRQL1ByNjhMWlJv?=
 =?utf-8?B?aVl3a25OYTlPVngwWE9hN1FaYk93ZzFYY1ZLbXNOY29JbjhtcGpHN0o5Mytj?=
 =?utf-8?B?QnFlQ0kwM1lyemw3d2tNR0JvUG5ib0lNY0JLekRnRG1VcFMvM1V4ak5Fenda?=
 =?utf-8?B?c3UvTzRSQXVyb1lXdllVYmRxWlo3K0l5cVlmbVgyRmttN0hZRXE0MlRXeVFw?=
 =?utf-8?B?dkFTYzJEeFJXSDQ0RnM5U2NZL1k2WkEwSmZJTG1GaENTYkRYaGZMUFhXSjNR?=
 =?utf-8?B?eGhrSWowdlhaeFJCa1UvR2lncnJYNDJqM0lUMEEwNHBqOERKNlV4UlFiK1po?=
 =?utf-8?B?WlZtVG1KaVJWUGE4cVF6d3ZheVM0OUxsVlpiSS9GSnFkNzRQMGhEa2t5ODht?=
 =?utf-8?B?cU5iOGlHYzlLMThVS2ExN01LejR5MDRWUkphNXdYcnpPZnRrcGtWLzRzYmFj?=
 =?utf-8?B?Q1dvcVdqQmpraGt4SlBtanUwdTJRQ2krL29aVDVWenV5VkdMcnAzMDM1Z0kv?=
 =?utf-8?B?NmRHejViN0tpYnRnQjI0ZFpPcHZDUzVEMEtPb0ZyY1lWb1hBMncwTmFzZzE1?=
 =?utf-8?B?UXRtRWdBNS9KVUdOUTZBdWwrdkFINHV6cmM5dSt3UmlnR1hUVVdpSlBOS0Uy?=
 =?utf-8?B?TTFRMWtBOXJIMGRVMThhd2gzY2Q1QkQ1OUp6QnVab21wRFlyWmMrUkNMVnNy?=
 =?utf-8?B?VmJHYm9zSEwvVEk2WHpQdURmczhQbmFHa3lhVzFYMlFUKzlPVjB5WlVGanFT?=
 =?utf-8?B?RmVNY25aSDZKR1dnNlRVbEZVbHZ5NENXTzNEV1RGUHJrYnJvaitRenB5ZTBv?=
 =?utf-8?B?UmFwMUhwenY2QWtPL3VWUTRqSlpURjZDWWZZYzZVc3hsZWFFK3F3SG5GbjlV?=
 =?utf-8?B?b3JhcG94ZVhUMkhabHlTbGF3SDBodUxweDFlODduMkdmSDNJR3c0OUpBOU9U?=
 =?utf-8?B?QVJLMVlJU3RXNDlVUGd4cytXeU9FVzFsK1VEMXBEa1hEUXgvWDRkaE1aajls?=
 =?utf-8?B?amM5L0paeGw2YS9iOSt0SHNkNE8rZ2xqYnlYU0diMzBvY0kyUkxlY2hpaVZ1?=
 =?utf-8?B?TXplK21Na2cwMWxrOFdiSXh1ZWtRQXU4UUF2YzJEN0tjbW9CWDVxemdicGV6?=
 =?utf-8?B?ck9xK1p1N2oxRW01eWlKZWt0dG5rZ0lJVFgreVhMZFV5eGN5eStwR3ZQVGF5?=
 =?utf-8?B?Qk4xMUliTmlwaUZxRUE5VEpKcy9md01VOHJaY2hEanYyVEt2cUQ1a3lGR1dS?=
 =?utf-8?B?NVBSclNlNDlDN1l1K004ZXdTbTJwME1IK3N1VGg2OXJvdUptZXhweTAzVUNv?=
 =?utf-8?B?aWJsNmpHbXV2a1dhL3pZbzlVT0t2NXV3eXFOd0Ewd3c0OTBjWlVtWGgxWUdm?=
 =?utf-8?B?MzdUWVE3ZERwY1ovSkF6KzZLc21WV1ZSeTRMandXTHJpRCtJWEUzN3RFd08x?=
 =?utf-8?B?bmMrOXFncndxYVRoYzBpbGZ3d0VlYVdCK1FjUmgvRHdJb1NXcWsya1BwcnVn?=
 =?utf-8?B?MGhWcXV5cWpBMlhTeVhGQzF3S2JlQjZGdXdtcnY2MnZvdDRYRWIxQ1pscUVK?=
 =?utf-8?B?VG8rNk9rU1diSDRKNDhHb09PZEh4bUFQRFV0ZXNzMEljbXZhOFZsY1BZWlN0?=
 =?utf-8?B?TWlxc3lYKzE2OUdmQVpZcjU4eFo3b201aG53NHFXMEhESjM1MUF5eUVGdmNY?=
 =?utf-8?Q?SVSmgz8j5ixjux0+R763ffUxv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF3D1611C71C424795F5363539CC7B76@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a65d2d-fdd1-46c7-ce62-08dc89fdfb5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 10:05:11.6837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zv2MZmvKnp5mtg/7dZ1sf0jShD0CE63ja/Z2S8k5iHXtsD8ZRC6wdoA0Y6dymONaEXtHj2G+/fUZpOrJ0yDL6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7468

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDYtMDYgYXQgMTc6MjYgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiUHJlLW11bHRpcGxpZWQiIGFscGhhIGJsZW5kaW5nIG1vZGUg
aW4gTWl4ZXIuDQo+IEJlZm9yZSB0aGlzIHBhdGNoLCBvbmx5IHRoZSBjb3ZlcmFnZSBtb2RlIGlz
IHN1cHBvcnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXdu
LnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZXRoZHIuYyB8IDEzICsrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19ldGhkci5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19l
dGhkci5jDQo+IGluZGV4IGJjY2VkNjJlNDU1ZC4uZDAxZjY1ODE5ODE2IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+IEBAIC02LDYgKzYsNyBAQA0KPiAgI2luY2x1
ZGUgPGRybS9kcm1fYmxlbmQuaD4NCj4gICNpbmNsdWRlIDxkcm0vZHJtX2ZvdXJjYy5oPg0KPiAg
I2luY2x1ZGUgPGRybS9kcm1fZnJhbWVidWZmZXIuaD4NCj4gKyNpbmNsdWRlIDxkcm0vZHJtX2Js
ZW5kLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvY29t
cG9uZW50Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gQEAgLTM2LDYgKzM3LDcgQEAN
Cj4gICNkZWZpbmUgTUlYX1NSQ19MMF9FTgkJCQlCSVQoMCkNCj4gICNkZWZpbmUgTUlYX0xfU1JD
X0NPTihuKQkJKDB4MjggKyAweDE4ICogKG4pKQ0KPiAgI2RlZmluZSBOT05fUFJFTVVMVElfU09V
UkNFCQkJKDIgPDwgMTIpDQo+ICsjZGVmaW5lIFBSRU1VTFRJX1NPVVJDRQkJCQkoMyA8PCAxMikN
Cj4gICNkZWZpbmUgTUlYX0xfU1JDX1NJWkUobikJCSgweDMwICsgMHgxOCAqIChuKSkNCj4gICNk
ZWZpbmUgTUlYX0xfU1JDX09GRlNFVChuKQkJKDB4MzQgKyAweDE4ICogKG4pKQ0KPiAgI2RlZmlu
ZSBNSVhfRlVOQ19EQ00wCQkJMHgxMjANCj4gQEAgLTE3Miw4ICsxNzQsMTIgQEAgdm9pZCBtdGtf
ZXRoZHJfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwN
Cj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gIA0KPiAtCWlmIChzdGF0ZS0+YmFzZS5mYiAmJiBzdGF0
ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpDQo+IC0JCWFscGhhX2NvbiA9IE1JWEVSX0FM
UEhBX0FFTiB8IE1JWEVSX0FMUEhBOw0KPiArCWFscGhhX2NvbiB8PSBNSVhFUl9BTFBIQV9BRU4g
fCAoc3RhdGUtPmJhc2UuYWxwaGEgJiBNSVhFUl9BTFBIQSk7DQoNClRoaXMgaXMgY29uc3RhbnQg
YWxwaGEsIG5vdCByZWxhdGVkIHRvIHByZS1tdWx0aXBsaWVkIGFscGhhLCBzbyBzZXBhcmF0ZSBp
dCB0byBhbm90aGVyIHBhdGNoLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICsJaWYgKHN0YXRl
LT5iYXNlLnBpeGVsX2JsZW5kX21vZGUgIT0gRFJNX01PREVfQkxFTkRfQ09WRVJBR0UpDQo+ICsJ
CWFscGhhX2NvbiB8PSBQUkVNVUxUSV9TT1VSQ0U7DQo+ICsJZWxzZQ0KPiArCQlhbHBoYV9jb24g
fD0gTk9OX1BSRU1VTFRJX1NPVVJDRTsNCj4gIA0KPiAgCWlmIChzdGF0ZS0+YmFzZS5waXhlbF9i
bGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUgfHwNCj4gIAkgICAgKHN0YXRl
LT5iYXNlLmZiICYmICFzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpKSB7DQo+IEBA
IC0xOTEsOCArMTk3LDcgQEAgdm9pZCBtdGtfZXRoZHJfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZp
Y2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gIAltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBw
ZW5kaW5nLT5oZWlnaHQgPDwgMTYgfCBhbGlnbl93aWR0aCwgJm1peGVyLT5jbWRxX2Jhc2UsDQo+
ICAJCSAgICAgIG1peGVyLT5yZWdzLCBNSVhfTF9TUkNfU0laRShpZHgpKTsNCj4gIAltdGtfZGRw
X3dyaXRlKGNtZHFfcGt0LCBvZmZzZXQsICZtaXhlci0+Y21kcV9iYXNlLCBtaXhlci0+cmVncywg
TUlYX0xfU1JDX09GRlNFVChpZHgpKTsNCj4gLQltdGtfZGRwX3dyaXRlX21hc2soY21kcV9wa3Qs
IGFscGhhX2NvbiwgJm1peGVyLT5jbWRxX2Jhc2UsIG1peGVyLT5yZWdzLCBNSVhfTF9TUkNfQ09O
KGlkeCksDQo+IC0JCQkgICAweDFmZik7DQo+ICsJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgYWxw
aGFfY29uLCAmbWl4ZXItPmNtZHFfYmFzZSwgbWl4ZXItPnJlZ3MsIE1JWF9MX1NSQ19DT04oaWR4
KSk7DQo+ICAJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBCSVQoaWR4KSwgJm1peGVyLT5j
bWRxX2Jhc2UsIG1peGVyLT5yZWdzLCBNSVhfU1JDX0NPTiwNCj4gIAkJCSAgIEJJVChpZHgpKTsN
Cj4gIH0NCg==

