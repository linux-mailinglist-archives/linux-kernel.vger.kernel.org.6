Return-Path: <linux-kernel+bounces-340122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509F5986EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F903282381
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3F1A4E6D;
	Thu, 26 Sep 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ieEaAi5c";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LlgIdW5F"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982AC1A4B71
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339314; cv=fail; b=OfXUC1xPQVvwSG66MzM5XBRE502mP1OWww27QQwRL9OVg/oxCjyHgvhRitTv9o1rihnGbBMM08oGh/AtfP0EmqzIxQQe63ZCXAsVGO+dJ3qm2s1cnmxccC/biuopWHYLdvFJEs0uKiBKmJhD2m8AyTPggHkPvocI+tG7gOeigrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339314; c=relaxed/simple;
	bh=a8+5CXZmtqyOQ3cQ424TtX1+YdOnMRRuDIMlbNJUUX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XY5GtSRVoxu1CgfcgoADNU9MTAOVfh0IDwOOvmx2QyB3p9rmwfaS0ojf3k/wrjR/ClimEFSs+UAVgu12MpJ9HxZkkDU2xGYBofX/MrVNWrw2v3ZUO7yDjcqcQEbCijqGiNYl9spAAZOBzpFl/SGEtG3v3rgzyMm+pyTJqv0VOaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ieEaAi5c; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LlgIdW5F; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4c5700187be111efb66947d174671e26-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=a8+5CXZmtqyOQ3cQ424TtX1+YdOnMRRuDIMlbNJUUX0=;
	b=ieEaAi5cUud0iZ+5uRvG9korpetyl7mlXa4en/WKUmP5MwD+gFsRHROS7yK54k0Zn2ucFan9QoBGqw4P6EyzVQm93HY3vNrjH7p6WM+NAwPDiLA8R6JXJUNYLhb8Xf8G+uK97OakY0hD2kHzkH7wSQA1qgW6SM15gAKplvqDq2M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2427c2cd-c607-46be-8116-64ddf9477e2f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:a3bf989e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4c5700187be111efb66947d174671e26-20240926
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1841401277; Thu, 26 Sep 2024 16:28:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 01:28:23 -0700
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 16:28:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyH5BR+iewECFyVsVud6pPtiEnX0DpDpf7sm97yrsM3+/VaK8h+/Tx3SYc5UReqcsaK+K+agQ+nBeJ8shUquWtBjqMWwRjVJLELlPfVmCNFpv0GI20yd7inLdMLDPlXwjTdYLq20w1k/x9UEEbQPXjrEAca8nMX3lu9n6DLOyaEdbCM9x2Ng5cHkn5GBVwRzVsGRS19BrDdC1OjcxN6p+jhF7gm5ewOR1G6FizDCTXchQAc2RHgkADgs/eDX7LsnU71DFXNW78dQk2J+G/8FpADRhZnpAW7PgbxVCSFcQcok+zsb+LRFJoAsQVDBKiJYEtSp0bbyXwSi+wGUAvQneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8+5CXZmtqyOQ3cQ424TtX1+YdOnMRRuDIMlbNJUUX0=;
 b=w4Hpzv4ltU/57ilhSOd3rx1bEDAmg42ZeYbxitqGyDMJwS/sHmGm5zEoI3ndMq3p3zh9Iu66dpnPRSI+LNZ700/f1vckqx4w3XWzwt0pxeE8AsPHaEV6j2E0div3zI1Slclk/MKz/kcprCY75P9WsMHznvdwcYF3bc0HeFHsNxdLuSlHy/hi8mYaYixrbESGqaffoLdwmdel7zLu7cJTePpCtuAxdSnfV/XcMfi1Told0uWmh1MM/8YZ36UZSLAzIUjgG1g4gKveQSc/z493Y3IZOuEUNJ8dXkzYJlURv/1J77fWIBLM1RH6XR7xWxvqOXaBK0XJYPP4vcbWGlb1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8+5CXZmtqyOQ3cQ424TtX1+YdOnMRRuDIMlbNJUUX0=;
 b=LlgIdW5FAyXHcEO2cby8DhtV7ab72Ubh6XL0LYa/EmX0hZtT8A0kt8NOvYB0CcaecNzpTvoInbrK+VP/3KjjiR3ImN631aqlsP1byaLDR7cOIqNZ1SVzihzCwjv+0dNrbVtVI7szNaQJ961RWvZqYaiVYJ987oM60aXkHMV16uQ=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB8431.apcprd03.prod.outlook.com (2603:1096:101:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 08:28:20 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7939.022; Thu, 26 Sep 2024
 08:28:19 +0000
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
Subject: Re: [PATCH v5 2/2] drm/mediatek: Add blend_modes to mtk_plane_init()
 for different SoCs
Thread-Topic: [PATCH v5 2/2] drm/mediatek: Add blend_modes to mtk_plane_init()
 for different SoCs
Thread-Index: AQHbDzSM3Xaxo+lrgUeyI7cbZNI16LJpWtwAgABizgA=
Date: Thu, 26 Sep 2024 08:28:19 +0000
Message-ID: <33b11e373bec29ea37e094fa131843e2a163de76.camel@mediatek.com>
References: <20240925101927.17042-1-jason-jh.lin@mediatek.com>
	 <20240925101927.17042-3-jason-jh.lin@mediatek.com>
	 <bcdabb15b002c47512358cfabdfb49bc12f42596.camel@mediatek.com>
In-Reply-To: <bcdabb15b002c47512358cfabdfb49bc12f42596.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB8431:EE_
x-ms-office365-filtering-correlation-id: 873681cc-1fc6-48bb-1ea3-08dcde052d28
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VGpZS05aUEJtcHpnMzR5aGRnSXhWRzFuZE1xZ2NORkMzUWNCamFZUVlPalN1?=
 =?utf-8?B?TWVpRW5JcVFZQTJZdnVjcDRSbGJ2T0Q5ZSthQ1M3dk1iZzA2Z21Pd2N4YlIx?=
 =?utf-8?B?bWZQM2QxYXhmYjU4U1c0dTd1bUtYU1NZNjVkUTdkVURZRThjMlFCUU9oYVVV?=
 =?utf-8?B?RTZXWFU5VWo2bk81c1M5S2VUbVhGbXZlL29lOUxRUXJDQUNaVkxCUnhzeEZs?=
 =?utf-8?B?YkNXdW02Tytoais5NmpqTTgyUitBVldtMyttQlloWXBQN1pkMFJEOGRKZ3hO?=
 =?utf-8?B?ckZua2FGaTF0bnNsRkhWV3JmVmJaVlUrMHluM2dYTzJ2cmlpWjh1dVdzdisy?=
 =?utf-8?B?QTMwQ3dvYjlWRnprbmJ4UEpib0dVd1FYMDhSSjJKaEM1K3ZCUkJFSUtuTzNL?=
 =?utf-8?B?enAxTEloVWRnMmc1M0o1NEpkU0lTbjhiZFNZZHkrVDFrMnJsWWFJRm5obkpq?=
 =?utf-8?B?MmJmYU1RdUVITEtmTE02ZE9jOFhaTG5uYThaSFAzeG4ydDhqK3pZVVZ6emJx?=
 =?utf-8?B?TVZtdXRhalRJVXNUZEkrU0VpWGMxVmhFVVpuTHBmSndNVGsvNzBZcDR3SGNv?=
 =?utf-8?B?MUJTVTJ2bnJCVFdtODNYNzVJNzlhNkhpOXBIdmNHTEJFOWMvanBkcGlYZHBo?=
 =?utf-8?B?ckY4Mjc5Z0krY0FOamZncXF4Q0habEYxMUE3c3V0MzcyV2szR0taODUzQnEy?=
 =?utf-8?B?aVBqLzM1dzVkUVA4VWJEU0ZzRVZqN3hiaVU5bnBJQVNDR0Y2U0cwMGVUdDhi?=
 =?utf-8?B?OFlIcG5BRzQ5ZmxYZDVSQmkzcFU5WElhUXFsdDZmRVozd0w1YXBxakxtMVR1?=
 =?utf-8?B?U0N6dGtTSm1KWUtGc0owTStpd2JDNmk0ZHVzaHd4eityZmkybDZ3ZEFtUUtP?=
 =?utf-8?B?d3VsbFdvOUd0OVhjQmR4bHMyZDU1OUdSNXlGYnJ1RWcrQTkwTnNUK3oxL0k4?=
 =?utf-8?B?enJCVXZYWDZTd1FaTk9tVHBTNks0ZjVIT2hlQjNJakI0aWRhckVQby9BNWc4?=
 =?utf-8?B?UjJzWmJobXBGVFhybVJNMys1ZHlPNVlkaWIzamVJWStvZklXOEdVNWNhVkFN?=
 =?utf-8?B?VnNJMTZVMXhpZC9OSzgzMVlxeGMxV09YTGI4T3ZxQUxPRGExRnJxUzFqa0Nw?=
 =?utf-8?B?cDFzRHNMK0RENTJ2am5zVTJGMXNQWG1LMFdidlJESlpMRnBncXdPamxYcytE?=
 =?utf-8?B?ZDRlQU40MFBRTlgyY0ZUQkxMaEJXSVB1SW9TTUc5cG15VkxjYlVqQWJVa2Nw?=
 =?utf-8?B?bEpLcGd3R2Nia0MwaW9WS2dXVzZxVHpBOHdXSXR5dmUra09SYzhwSUtacU1r?=
 =?utf-8?B?SG51R2tKQkxMbE56Lzl6am9LeitwMzh3UWs4M01VY3Q4VkNIMmJJNk5xYmVT?=
 =?utf-8?B?NEoxWW0rdkdxSVIyTmhDSnM1aitaUWRVbEM5K3FTOGV6ZEtSWW9BS0dkZVVQ?=
 =?utf-8?B?bVQ2RS9Fc3FJSElSZThocjl3Qk90RmlUTG9BMTdwVjE4K3ovcGNmVVZyV3Ew?=
 =?utf-8?B?V2YzYVVXZnFCekoweWR5RndzbWljTTYzbDFLN0p1SWR4UlZnS3hEY3BjeDlP?=
 =?utf-8?B?Qk5JNFJSQlJSNnpXa0I5ZVUyV1gzL0N1WmR3UWNVVEgvY3VEYkhDOEVSMWhz?=
 =?utf-8?B?eFhDVUlNRUFZNTl1bEpKeWpSRTAvaWhCUERoWVdNdEo0ZnJrTmJBcVdwVTlT?=
 =?utf-8?B?NHJuY2tUNHFtcjJpbDZBZUhUVUpwUWlTbU93eGloRzN0OHM3UDFDeEgwbjk5?=
 =?utf-8?B?MHFnT0x3eFFiV1IvcUovMkdiUnNlRDBOSlFJMWlWOFR4ZVpIUEt1L0xXSStQ?=
 =?utf-8?B?WStlc3JSZWhuQnVHTFZvdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGxNdDVhNGM5TksyVWU1YnpXU1hKcFIzbHMxaFdWYkdUc3FCaUxXM2JjWkNQ?=
 =?utf-8?B?Y3BRcnh3QmZha2gwK0pVM0YwZFBDWXRuWTlmVEhMNVFocUhHREZXOU9tcWZ6?=
 =?utf-8?B?TG42RUx5cG9jSHlwakcxTkpqR3NOSHFzWGJZN2RPdTRJcEJqZnJ3ZGg1VGdj?=
 =?utf-8?B?T1J4RXA1WXRqWmR1OW9qTGgxeFJEdFI5MGlqSWNnMlFmQnd5SmJBMkEwY2N1?=
 =?utf-8?B?akNJMXl3dCttbEk3dEcxMnc1NFN4SzVXS29kSU5OWnFEV1dzZ1FUdFBBR1Vv?=
 =?utf-8?B?bTJCS2tEcklMb1NYVmhjc3VKQWVXZnVRakt5N0MvNC80dkhzVmgxV3k4SXlv?=
 =?utf-8?B?WjI1STYvVkVMQVNqcjBDclEwVndMSHI3RHhyZWMrYkQ3Ni85N0tHYWZtc3dm?=
 =?utf-8?B?bjA4bDJUQzNESENOaUJBcFBUTmppTjBuc1o2TWZEQlFCdlFtZkovcTQ4YWxO?=
 =?utf-8?B?bE01RC82T3YyUDJiU3pZWHBjUGFJWEg2dnBseWMvVWhXelBaYUx5K0dOWGxT?=
 =?utf-8?B?aE1XWDdabmhXMzBzNW5uMHE0ZkpGWmE4ai9yS01uaXoyejRpNUNMdVNXcTho?=
 =?utf-8?B?dE8rYnAzakhQSGhGdFJhM1FhTDdEeXBKWjhIdklUdEFVb1FLUlpGQWxrUjY1?=
 =?utf-8?B?NCtvb1JzbXV4emNGeFVDdGVBcitFOFRHK1gvN0dzdXBKdmVyUlRBR2p4dmxH?=
 =?utf-8?B?ZWxtZXVUaFZBaWFXM3ZZbEQ3aHdwN3p5cDllSHhiTjh3S1dOamxZY1ZqL1By?=
 =?utf-8?B?MWJUUjV0ZndLZGNPeGVHTThUU0xxRnd3VjVlanJxWFJBZnVmUkhMVkEyVktQ?=
 =?utf-8?B?UE9CaHZFVFA4MVA2cUtVRXFQWURxNzRMcmhVRHJiTnlkY2xIWVQ4N2REaHFK?=
 =?utf-8?B?ai92cGs5anRxbHNTenEyK3NjRWRVeG1hN09xWVVJL1lQZWYrYk1vcCtIdk00?=
 =?utf-8?B?ZktpYkZHK3F5OStuNUF4cXB4VlYvREVPc1F0d2NBN1AyRTd1S040NkR6NWpW?=
 =?utf-8?B?SXlVMTVGdEh5bzVHZUo3ZkF6dEx5QzJLQzFDdnBPS1NzQkRMc0t0N3VyY0Y2?=
 =?utf-8?B?Tjd1Qi9EWFZwdUFWZnhPSzhYdDV5am9qa0xTOERaM3RhQ1ZuSzlzZGRtQWpF?=
 =?utf-8?B?cklEUGYyd3Q4N0xCZ1J6eFVadkZPK0JIMnZjckU1SUZYRWh2eStUa1JwdUJ1?=
 =?utf-8?B?MnJqTlhhM2R4MW1PRkNiRXI3Ykp1SjBvbkFnU3BXNVdDM0M0S2lkOUdqcVlX?=
 =?utf-8?B?aVdOdGh4ZlhtUkpLRldjUWRucm80T2RVYzYycU9kOUNtWHpUWWN5S2laZVlV?=
 =?utf-8?B?eUtnSHUxRnZzMzE1aExaQkluV3hRNjhNV04vcjVDK1kxbzd0T3V2MEd6Nkwx?=
 =?utf-8?B?NFM5ejA3YmhteWpNNGpxSDJRVWEzNCtiUU4rZTFEUk05QWpYa2NqSGVpb1Bv?=
 =?utf-8?B?TmVGTmZzWG1mN3U2Zmg0UFovcXlHS1lOenVkdkFZRkZNTGxSTEhhY2VhSUdV?=
 =?utf-8?B?RXR5bFZzdGlXMDZpQVowVW9XTEIvQXc1MllwUWVSazdYQlo1NDV3NlFLRzdq?=
 =?utf-8?B?bHd5RUprOU9wMGRuc3lnSGtDZGNIeCt3TUswZG92RC9KYTdhVkN1RWt4SzZl?=
 =?utf-8?B?M1NGaXZGYldUN0h3VnQ3MDBRRThyY1htNFNxdXFHdTd2MGRXN0dXZmxCZ1Nn?=
 =?utf-8?B?RlRnb0xiamRqOWxSL2t4ampXNnRGM0JrS1pEcWxQTnJwNHVuVmRvWkxXcTY5?=
 =?utf-8?B?dGRLbEJ4VGpJQTdXbWJZOXZaZ3ZzTnFVVlkyZXZIQjFsRWlBRit6TnRqdGVj?=
 =?utf-8?B?aHBsT0ZYcyt0R2VBUmZmRlovemZya0N5MVV4MFR1UG8xRk5WOE1XdGd0YVBB?=
 =?utf-8?B?ZW94cDhod3BjSEVubW45WUNicUVoNVhVdEtDdUFoMVJpaFlnWDlHdTR1bzZK?=
 =?utf-8?B?RXA0RTBVWlFsUFh5QkdTVjErTTlTaklxdWVDcU9xTm1NRGdRcUdGUU1jNDc1?=
 =?utf-8?B?UkZpRjN1Kzl2dHh2SHVkcHVlRmpyYWI0WmJlSmtFUFJYc1AySWx6SThBR0R2?=
 =?utf-8?B?SWRCNjJBcHlLMmdjbG5Zd3ZEcnorMXY0WWhjeEQ1cDJWT3lkZnV6S3IyUVhK?=
 =?utf-8?B?cVhzV3FvQThmcGlvN3NGODRvSUNLVUlmNkNBN3ZIMjBGV3pDaFJvOGw4Wk5w?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3101F48045E4C4BA887916D747BC8A6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873681cc-1fc6-48bb-1ea3-08dcde052d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 08:28:19.3454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p79zhJAiP3GvYHxJzFyYA4MQ80ungoCBQ5G8CxzqOvxUvzLLwJO7YIyUSyG0I2Xi1Qx7APUwRHtKNOPkDK32B/3VquNie0vT8dKgXnr9gbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8431

T24gVGh1LCAyMDI0LTA5LTI2IGF0IDAyOjM0ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gV2VkLCAyMDI0LTA5LTI1IGF0IDE4OjE5ICswODAw
LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gU2luY2Ugc29tZSBTb0NzIHN1cHBvcnQgcHJlbXVs
dGlwbGllZCBwaXhlbCBmb3JtYXRzIGJ1dCBzb21lIGRvDQo+ID4gbm90LA0KPiA+IHRoZSBibGVu
ZF9tb2RlcyBwYXJhbWV0ZXIgaXMgYWRkZWQgdG8gbXRrX3BsYW5lX2luaXQoKSwgd2hpY2ggaXMN
Cj4gPiBvYnRhaW5lZCBmcm9tIHRoZSBtdGtfZGRwX2NvbXBfZ2V0X2JsZW5kX21vZGVzIGZ1bmN0
aW9uIGltcGxlbWVudGVkDQo+ID4gaW4gZGlmZmVyZW50IE9WTCBjb21wb25lbnRzLg0KPiA+IA0K
PiA+IFRoZSBPVkwgY29tcG9uZW50IGNhbiB1c2UgZHJpdmVyIGRhdGEgdG8gc2V0IHRoZSBibGVu
ZCBtb2RlDQo+ID4gY2FwYWJpbGl0aWVzIGZvciBkaWZmZXJlbnQgU29Dcy4NCj4gPiANCj4gPiBG
aXhlczogNDIyNWQ1ZDVlNzc5ICgiZHJtL21lZGlhdGVrOiBTdXBwb3J0IGFscGhhIGJsZW5kaW5n
IGluDQo+ID4gZGlzcGxheSBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxp
biA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFtzbmlwXQ0KPiAN
Cj4gPiArDQo+ID4gIGNvbnN0IHUzMiAqbXRrX292bF9nZXRfZm9ybWF0cyhzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBtdGtfZGlzcF9vdmwgKm92bCA9IGRldl9nZXRf
ZHJ2ZGF0YShkZXYpOw0KPiA+IEBAIC02NzQsNiArNjgyLDggQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBtdGtfZGlzcF9vdmxfZGF0YQ0KPiA+IG10MjcwMV9vdmxfZHJpdmVyX2RhdGEgPSB7DQo+ID4g
IAkubGF5ZXJfbnIgPSA0LA0KPiA+ICAJLmZtdF9jb252ZXJ0ID0gbXRrX292bF9mbXRfY29udmVy
dCwNCj4gPiAgCS5mbXRfcmdiNTY1X2lzXzAgPSBmYWxzZSwNCj4gPiArCS5ibGVuZF9tb2RlcyA9
IEJJVChEUk1fTU9ERV9CTEVORF9DT1ZFUkFHRSkgfA0KPiA+ICsJCSAgICAgICBCSVQoRFJNX01P
REVfQkxFTkRfUElYRUxfTk9ORSksDQo+IA0KPiBXaGVuIGJsZW5kX21vZGVzIGhhcyBubyBwcmUt
bXVsdGlwbGllZCwgZm10X2NvbnZlcnQgaXMNCj4gbXRrX292bF9mbXRfY29udmVydCgpLg0KPiBX
aGVuIGJsZW5kX21vZGVzIHByZS1tdWx0aXBsaWVkLCBmbXRfY29udmVydCBpcw0KPiBtdGtfb3Zs
X2ZtdF9jb252ZXJ0X3dpdGhfYmxlbmQoKS4NCj4gDQo+IEkgdGhpbmsgd2UgY291bGQga2VlcCBi
bGVuZF9tb2RlcyBhbmQgZHJvcCBmbXRfY29udmVydC4NCj4gDQo+IGlmIChkYXRhLT5ibGVuZF9t
b2RlcyAmIEJJVChEUk1fTU9ERV9CTEVORF9QUkVNVUxUSSkpDQo+IAltdGtfb3ZsX2ZtdF9jb252
ZXJ0X3dpdGhfYmxlbmQoZm10LCBibGVuZF9tb2Rlcyk7DQo+IGVsc2UNCj4gCW10a19vdmxfZm10
X2NvbnZlcnQoZm10KTsNCj4gDQo+IEluIGN1cnJlbnQgcGF0Y2gsIHdoZW4gU29DIGRvZXMgbm90
IHN1cHBvcnQgcHJlLW11bHRpcGxpZWQgYnV0IHVzZXINCj4gc3BhY2Ugc2V0IHByZS1tdWx0aXBs
aWVkIGJ1ZmZlciwNCj4gZHJpdmVyIHdvdWxkIGtlZXAgZ29pbmcgYW5kIHRyZWF0IGl0IGFzIGNv
dmVyYWdlIGJ1ZmZlci4NCj4gDQo+IEkgdGhpbmsgdGhlIHJlc3VsdCBpcyB3cm9uZyBidXQgaXQn
cyBlcnJvciBoYW5kbGluZy4NCg0KWWVzLCBPVkwgaW4gcHJldmlvdXMgU29DcyBvbmx5IHN1cHBv
cnQgdGhlIGNvbG9yIGZvcm1hdCB3aXRoIGNvdmVyYWdlDQptb2RlLCBldmVuIGlmIHVzZXIgc3Bh
Y2Ugc2V0IHByZS1tdWx0aXBsaWVkIGJ1ZmZlci4NCkknbGwgd3JpdGUgdGhlIGNvbW1lbnQgaW4g
dGhpcyBwYXJ0IG9mIGNvZGUuDQoNCj4gSWYgd2UgYWNjZXB0IHRoaXMgZXJyb3IsIHdoeSBub3Qg
a2VlcCBvbmx5DQo+IG10a19vdmxfZm10X2NvbnZlcnRfd2l0aF9ibGVuZCgpIGFuZCBkcm9wIG10
a19vdmxfZm10X2NvbnZlcnQoKS4NCj4gDQo+IGlmIChkYXRhLT5ibGVuZF9tb2RlcyAmIEJJVChE
Uk1fTU9ERV9CTEVORF9QUkVNVUxUSSkpDQo+IAltdGtfb3ZsX2ZtdF9jb252ZXJ0X3dpdGhfYmxl
bmQoZm10LCBibGVuZF9tb2Rlcyk7DQo+IGVsc2UNCj4gCW10a19vdmxfZm10X2NvbnZlcnRfd2l0
aF9ibGVuZChmbXQsIGJsZW5kX21vZGVzKTsNCj4gDQo+IGFuZCB0aGlzIHdvdWxkIHJlc3VsdCBp
bjoNCj4gDQo+IG10a19vdmxfZm10X2NvbnZlcnRfd2l0aF9ibGVuZChmbXQsIGJsZW5kX21vZGVz
KTsNCg0KT0sgSSdsbCBkcm9wIHRoZSBmdW5jdGlvbiBwb2ludGVyIGFuZCB1c2UgYmxlbmRfbW9k
ZXMgdG8gY29wZSB3aXRoDQp0aGlzLg0KDQo+IFtzbmlwXQ0KPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+ID4gaW5kZXgg
YzY3NjgyMTBiMDhiLi4yZDQ3YjZlYjRjMTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiA+IEBAIC00MDAsNiArNDAw
LDEzIEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX2Rpc2FibGVfdmJsYW5rKHN0cnVjdA0KPiA+IGRl
dmljZSAqZGV2KQ0KPiA+ICAJbXRrX2V0aGRyX2Rpc2FibGVfdmJsYW5rKG92bF9hZGFwdG9yLQ0K
PiA+ID5vdmxfYWRhcHRvcl9jb21wW09WTF9BREFQVE9SX0VUSERSMF0pOw0KPiA+ICB9DQo+ID4g
IA0KPiA+ICtjb25zdCB1MzIgbXRrX292bF9hZGFwdG9yX2dldF9ibGVuZF9tb2RlcyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBtdGtfZGlzcF9vdmxfYWRhcHRvciAq
b3ZsX2FkYXB0b3IgPQ0KPiA+IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsNCj4gPiArCXJl
dHVybiBtdGtfbWRwX3JkbWFfZ2V0X2JsZW5kX21vZGVzKG92bF9hZGFwdG9yLQ0KPiA+ID5vdmxf
YWRhcHRvcl9jb21wW09WTF9BREFQVE9SX01EUF9SRE1BMF0pOw0KPiANCj4gUkRNQSBoYXMgbm8g
YWxwaGEgYmxlbmRpbmcgZnVuY3Rpb24uDQo+IEdldCBibGVuZCBtb2RlIGZyb20gZXRoZHIuDQoN
Ck9LLCBJJ2xsIGNoYW5nZSBpdCB0byBldGhkci4NCg0KPiANCj4gPiArfQ0KPiA+ICsNCj4gPiAg
DQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gIA0KPiA+IEBAIC0zNjYsMTAgKzM2Niw3IEBAIGludCBt
dGtfcGxhbmVfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiA+IHN0cnVjdCBkcm1fcGxh
bmUgKnBsYW5lLA0KPiA+ICAJaWYgKGVycikNCj4gPiAgCQlEUk1fRVJST1IoImZhaWxlZCB0byBj
cmVhdGUgcHJvcGVydHk6IGFscGhhXG4iKTsNCj4gPiAgDQo+ID4gLQllcnIgPSBkcm1fcGxhbmVf
Y3JlYXRlX2JsZW5kX21vZGVfcHJvcGVydHkocGxhbmUsDQo+ID4gLQkJCQkJCSAgIEJJVChEUk1f
TU9ERV9CTEVORF9QDQo+ID4gUkVNVUxUSSkgfA0KPiA+IC0JCQkJCQkgICBCSVQoRFJNX01PREVf
QkxFTkRfQw0KPiA+IE9WRVJBR0UpIHwNCj4gPiAtCQkJCQkJICAgQklUKERSTV9NT0RFX0JMRU5E
X1ANCj4gPiBJWEVMX05PTkUpKTsNCj4gPiArCWVyciA9IGRybV9wbGFuZV9jcmVhdGVfYmxlbmRf
bW9kZV9wcm9wZXJ0eShwbGFuZSwgYmxlbmRfbW9kZXMpOw0KPiANCj4gRm9yIGRpc3BfcmRtYSwg
YmxlbmRfbW9kZXMgaXMgMCwgSSB0aGlzIGlzIG5vdCBuZWNlc3NhcnkgdG8gY3JlYXRlDQo+IGJs
ZW5kIG1vZGUgcHJvcGVydHkuDQoNCk9LLCBJJ2xsIGFkZCB0aGUgMCBjaGVja2luZyBmb3IgdGhp
cy4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0K

