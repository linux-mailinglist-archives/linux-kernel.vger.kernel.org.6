Return-Path: <linux-kernel+bounces-413892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E39D2041
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394E0281BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D03B14F9ED;
	Tue, 19 Nov 2024 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RhqDDfuZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gGGmEKw4"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88283211C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731997998; cv=fail; b=Myg+mUfdw8+axBIphe1wUpyqbM+pXpT7EU3xKfVt8btfhbPu+MMIXK0Zz9UwC1d/ziDBdTV+1oin3cC4hJtivlV8GySbWxrx14djb6NxRTHFBDZ2FT5T4KJWGzYwqP0TzTiDlbGXMxZk3GBHafaLoEeDVqa5fYxEzD+J0qGe768=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731997998; c=relaxed/simple;
	bh=0QPExhO9ExBgcy0as7i5oUrTPDVhwa9i1eiw2V+610Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rvMM67jN/Tn/vm4+ecZNE09Urtzj+Uf4oTyDiIYQ0SCCT1/Io61F3YU+mbRS55ndt+ocGQ67GMzy2tjWJ/JjCjrckvcZ9+zPafWwIp32OIcKm7l8e/jz8E1d76IXMydQAG/uMbZphXRjlkin4r92TtLrWP2SDihkB+bniAbaRL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RhqDDfuZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gGGmEKw4; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 227873d8a64011ef99858b75a2457dd9-20241119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0QPExhO9ExBgcy0as7i5oUrTPDVhwa9i1eiw2V+610Q=;
	b=RhqDDfuZImzPu68mUrEZeoXcVRYxuDGxsV6nYmUaXgqezzBBxyZFBhDblgkYRN5hwIpvbEJoDJ+Nwu4sr4F55DsZaHOTqQFZetYmU5FgymU3Rv6FzBpOB72uQzugJ5X8WBWQXchhrABB+ZeMHREWG15yJfFDXqovYhV+dNc30r4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:85564ed9-c769-47f0-8903-47aad031bc04,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:4338484f-a2ae-4b53-acd4-c3dc8f449198,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 227873d8a64011ef99858b75a2457dd9-20241119
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1306004279; Tue, 19 Nov 2024 14:33:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Nov 2024 22:33:04 -0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Nov 2024 14:33:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URFIkpfExlK4J8w0iupx5l++ZgpE6NU7Ei42KxONHEWM7o9mfdedNbWQG244IQAwt4v5WANf1gcOlVfqSJBc2azXVWlnTYUDFhnAVKgDYL7Wduj1exSA6GPCYc1P1nO3G9dqFHQMOU3dac+8RPfwJdi98VPh6Ua+lKhntCCJ3L1etgGNQml2U81l1x/Ee8MAA0IAX7Yoet3U2SwnGsColvefeN+Q6eGdVnnG5r8JdqLrl2ixFq3NxOM0JyqJS35Z2kAO//KcDxfUlqHkyAYClaxTaGBCcYA9HJcHa/8J0ACpJ1ni+sfeiKV6yrjIvpWVT+GFWA4Y+lEO+BAmqBt4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QPExhO9ExBgcy0as7i5oUrTPDVhwa9i1eiw2V+610Q=;
 b=dRCpdS5im0Yh5BQYrje6KIJtFKbbNi+LJiOWSKrAtEHnWkxBjCn6G84JH0DSDbC0foXvJl6v/0gfLK9GSgkAUTMkC4YGCu7p63eyw9qIYwrT/UvnGYWC0REiCWsaJ56TNCAxhDl7bbDuS+3g5gA9Qi7WoXFYYocIwhDL+rJu5F089chGUS3j6XXEEX1SDTp6PrgUvlnT8NFFO+vBB4hquGa8x0Gx8NCanzFh3W46cd6M+g2Jd9HUrg+RkmP0KSV72v3FAlRDYUX+NruQtfMG2MbyOwio5EsNNjSh9uy5qt3A8LERZ8cpso0xQbOwhpV4RVT0kECn/enVV2WARYLa9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QPExhO9ExBgcy0as7i5oUrTPDVhwa9i1eiw2V+610Q=;
 b=gGGmEKw4GAF/K3MMp2zI4hjHhBGlybAKZbmjj8089Sa8Znwxtc/RTU1iMO87j7XEQ9bckByvaBQ8YlWT8qFxab44apY9vU68gK4z/zixiyEGCSguqJpXnf/JDzFhSQlsYPfMiqpf14H2ptqhHGZB5Ugrvuj9onG0xvd4jgfk+X8=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PUZPR03MB7044.apcprd03.prod.outlook.com (2603:1096:301:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:33:02 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 06:33:00 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "fshao@chromium.org"
	<fshao@chromium.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/mediatek: Add no pending_planes flag checking for
 mtk_crtc_finish_page_flip()
Thread-Topic: [PATCH] drm/mediatek: Add no pending_planes flag checking for
 mtk_crtc_finish_page_flip()
Thread-Index: AQHbOWscNtWmixb/8EyoshdcHaMvILK8souAgAF0X4A=
Date: Tue, 19 Nov 2024 06:33:00 +0000
Message-ID: <a92217eb88afae8ce947be8f064e9c96ca568497.camel@mediatek.com>
References: <20241118033646.31633-1-jason-jh.lin@mediatek.com>
	 <96b3576243f5c6880dd16d36020d2083a8508b44.camel@mediatek.com>
In-Reply-To: <96b3576243f5c6880dd16d36020d2083a8508b44.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PUZPR03MB7044:EE_
x-ms-office365-filtering-correlation-id: 6bd0ac0c-b0c1-4891-e49e-08dd0864038d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VVBJejZjemljWVpZWnk4OS9FQlF6TXByWVQxTGhjOXo4VEtKcE1UMmhRVUF0?=
 =?utf-8?B?eXh5R25qSWRJSDNzTTM4TXl3QnZuMmdubExjVWtnN0VsWnBFU0xnOHlqRCtr?=
 =?utf-8?B?Qkd5NDlza01tK2RnRElDUEVPeGtYdGdhQmNmMkRFSWNVWDYyTVQ5dUNLT2ZO?=
 =?utf-8?B?V2dqYU5qSDNWSlRqazhzVW42U0J6bFFBTEw3ajBOVVBzRm5yYzFhZlFCVXhU?=
 =?utf-8?B?Ui9EUENtSDdSMUUzWXpEcy9Ha2Q4aVhnNStoanNXaU9YK3locEtiRWNlMStH?=
 =?utf-8?B?dUo4MmtFL0RZT0Q5c291WTRsUXozWE14VzJvSjBiUldVdkp4YkxrWEh3NVpm?=
 =?utf-8?B?VVlLRzArQUxpTXRaSHRod2JzWUcwNFB0S21QaWltbkJiRFlJcnQ2Nk1kS2Va?=
 =?utf-8?B?bjUrd2JUNzlpb0ZZVzNVT0JqOGVTR1RMVG5VTU1lblVhNXJHcDlteERZL3VJ?=
 =?utf-8?B?UXFlczE0WkxYbUhHS3F1NURpUkFUM3NEREV5dWRYY2x4WitzN0VJeWlVK255?=
 =?utf-8?B?cTlsRDhwcmlnSjBTYVQ2djVsZkIwK0drZ29NYmsrVmpqY2JONG9xTGRLeFo4?=
 =?utf-8?B?VnZ3b0w5bms2cG5UNW5jeUxnQXp5VmlacXJmaWNNcnNaMzhaenFYbnduV3hk?=
 =?utf-8?B?S2FabUNoWFRxRmJ0M29Mb1BmY3dtVDN1bGtNRnpKRUtRd2NNOEpsSjl1UlJZ?=
 =?utf-8?B?TFJxaERDcUxmMm10R2dzaGdua3J1Z1Z5ekMvbW5Nakd5VW1oRVFjSUR6dDJW?=
 =?utf-8?B?MVFvdGQybmIvdFRRbW9BOXVqSEdyL1N4ZWwyWitsVThhT2FFUjR1MHIvUE0y?=
 =?utf-8?B?QU1aWmI0b3F2WTR4amhhSk5iNVhyaXRoejU4aFlLM0VWVzN4MU5hektKR1ZQ?=
 =?utf-8?B?ekt5M2dQZ0ZYUGVRTjV2OGtWNE9ZTVV0UkFHZmc0TGF5UmZXVERhZW9xOGUw?=
 =?utf-8?B?TUt5eVNuWlNla2JacGRNVUlOejhzanVGQmVvWi9FRitvL2hENm1DblJwZmEv?=
 =?utf-8?B?M0tiMjdwbjJlSlZ4OHVRRHdEcVBDUlVlbnNCK04xSnB3QW9IaEQ3VFNRZmZm?=
 =?utf-8?B?dlYrL1k4cnRFbWVHNXBOcHVPdGM1UjgwcUFoMmZQUkVOVVZyT2lQVFhOQWhp?=
 =?utf-8?B?UWdEU3ZERTBiRkp1RXozK3FuWVpoS2NWYzVYc3I4K3Q4R2JmNUJBNWZTTjkx?=
 =?utf-8?B?MVRxajMyQzhzU2xzSmhIeVdXYUhVbGR4MEVyWXNRM2FISUtzeHVWZjBCUWx2?=
 =?utf-8?B?VGdBOFFkZktYNEh6SVhmc2JhUjUrM2lUTHlrcWpMbXJEQ1NCRitKdDJZd2E0?=
 =?utf-8?B?SWp3ajFkVjEwL1Q4UFJDNW81U2FsakNkUkJLb1I5TFFzRkE5S3BIRm8vcm1k?=
 =?utf-8?B?cXExTnhqY0hBOTF2ZnluaDhHcU4reGgrUk9yaUxFT1hGejNYdVdnNVpkc2M1?=
 =?utf-8?B?ZnVuaFBMc0xubFNqYms0Tm9JamdmOXZtT0J3QUxYMjkvaXo0bTYvN0JNNHB6?=
 =?utf-8?B?VEVNMW9yUktWbjRFOE1zdjhJRXg4U3hiQW9FL3h0M1FXNi93Nzk3YkVnN1RS?=
 =?utf-8?B?TnpKcXp1UFVBem5kU0xtK1hvcjNLTW9Day83aDF4K3JhS3dQdzNnVkUzdkNi?=
 =?utf-8?B?NFNYcUszSkFyTDI0T1I0OVBWTnA1Q05YWnJSNDMrbVB4ekR0bGo4MTh3MW9E?=
 =?utf-8?B?SFMyUXZzekRPV2U1Q241dHA3VGlnODZYS1U0c0l2ekh3dGxrN3FJTW5MdHhz?=
 =?utf-8?B?eG1EUnBBMmRIMWtNam1sVnBKbktOQURtNEJvYk1EWUkzQkVFTWhzS0FPTG5t?=
 =?utf-8?Q?ScfiIa1Y6H5nuMFy91MM9tU9f0dhCRVwqAH9U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFQwaVJzKzFrRHhmMFlVZkFPc3cyb2dtaW10WDBxQm4yRVhpM3RFaDVuVFMz?=
 =?utf-8?B?NFNGSnJhK0R5MHdlOUdBUTZEME9RczJsNWY3aXBjQSs4Unh2czZuQVJaZDJr?=
 =?utf-8?B?dmJhdEZLbVlFWU5FVkRpeUlPcGs2SXNhYzQxbzRBYWRYRFdsK1I0bkVtZHQ2?=
 =?utf-8?B?YUlNVi9wM21UUFNqc09yU2pjTnlqbGd1bldvSW9xVFFDMzd6Y3hZS3A1MkVK?=
 =?utf-8?B?cEdsRWs3RUtSVGE3bTV3VFM3ejJhN081NUFMdThFaTdZSzZzbzBpaThmdnZa?=
 =?utf-8?B?VzVLM3NDcjl3RjZFNHd3OUdPbWQ4eFVwenRsa08zbms4RzgzMXJ4aEduclVs?=
 =?utf-8?B?U3B0TzFJNjE0OEkrMFlMTEw5NFg3SGRwOGwxdnpEdG4zUFNFTmRSN21TWmh6?=
 =?utf-8?B?MjYwMzF4b25DV0xFN3RjeDRuVjF5VzVXVXo3aHJWUTZMWlBIVksxanVpdE1l?=
 =?utf-8?B?dHZXMFNoNnMzUGhHeCt3dnorMml1YnA5Z1Z1cFU2UXJOc0tMclVQQVFTOXBU?=
 =?utf-8?B?SUt6TGVOU1lrNDRWZEs2dGRsaFJDVW9MVlU4K0l0YWlFdDgwU3BpRDJYMjdq?=
 =?utf-8?B?MnQzQzd3V1FNbkJGMzU2UVdrUTByM2Z5WlNmb25aWkRFcFFZOWdvcndMNnBP?=
 =?utf-8?B?SGFlelBNOVR0U1o4NVg4MEV2WURVczlBNDFjVnUvdVRlRWhqdGhLR1Flb1lG?=
 =?utf-8?B?cFlubHFuZVh6MDYrQzdGOGtKVHRsM1NScjFyZWhkK0FGSktvWm43N2RqV2Rr?=
 =?utf-8?B?Y1lLNDk1bXBsL2UwaWxjME1EdFlxWWtzaVpDSUZHVHlhTlNRRzQyR3l6TVMx?=
 =?utf-8?B?VzhkVUNzUUo5SzNyWG04dVgyYlBHRHBHQTVoVy9ud1dNTmU5cmMrNGsvcnhW?=
 =?utf-8?B?WTh4b2paVDVReWFEWHptandsd1VVYlB6NDlUcGRMN3BCTTN2L0dDWVVWdXFi?=
 =?utf-8?B?SUdOeVBVYmROWXVwQUdLYzVPKzY4QkNraGZWVyttV2pWOWNFZDRlbWVjQ3lu?=
 =?utf-8?B?V0V2WStzYTYyc1JzZWtpZW9JRE5LTTl6WGsxRnB0YkNuakVwcE9IVm1JajlP?=
 =?utf-8?B?YVFyVk51S0R0ZDhMc3VMWDdteEdZdmpJSk0rQW43RFdxS3JqeVNtUkJNRFJY?=
 =?utf-8?B?Nyt5QTdKUWRLSWxKcjJzdENsZkV2RDN1NUozY3R4VHlDemI1VkxUT1QrWklS?=
 =?utf-8?B?U3diMytGaW5aVXhBaElBMS82THo2WjNIcTNObVREclE4bGdMTW9aNUUvRUtR?=
 =?utf-8?B?SlFNVVNwZ0ZlaWNnZEQvZGgvY1FwMWthUWY5bnhodFZQeTVPMFU0UTlGRnll?=
 =?utf-8?B?NlVUT2dxa0FpVGRId2hBNjdZOE5icUNLZkdYMnZObXRGcE04V0ZsUVlJNWg1?=
 =?utf-8?B?UjM0bnZhWk1vcG1MUGRtdUtRNXNKNUMzVHp6MWxKMEZ5UEhqUS8vOFYyL3o4?=
 =?utf-8?B?WWFIRkFadG1ielBxYXJSblJIT1VBRlVENEY0cUl5ZVdrVUFYZDE3UldjY0Fj?=
 =?utf-8?B?Mkt4RktaRGhFV0pOQzI3ZDlMWDQwTitIQ21BTFBYbE1LZGg0VmJDWXF2bXVr?=
 =?utf-8?B?a3VrWDFuN2JBaDF3cmE1MUF5UklaMzg3dFoyVURCekV4eERzTEdNdC9QR24w?=
 =?utf-8?B?ay83VDkrd0NEMy9kYlhQZ2pjUjA3L2FyV1hvOG5kclNUb2p1eWp6OGl5SFFR?=
 =?utf-8?B?QkdMODAzbUlSbUQ2ZDlidWZLYTB1VGRadFl1Y0lUOElLa1M2d2VxMnJBelRi?=
 =?utf-8?B?WkZKRVJoZUhPY2lCSytJRDFLaE9WdVBwc1k3bGVUR1M5M2ZBNHN5VENNWmpH?=
 =?utf-8?B?T2xJamozSTVrbEI0aVZVeDhnRlg0VGtDVGZHemtYRzVwUms5WHlMdG8vRGpB?=
 =?utf-8?B?d0FQT2t3cUM3WWRyemxsbGZCZk9NMDVaQXByYXlaWWdjK2RGNUhnbEdWRlFE?=
 =?utf-8?B?aVhNWTRSYUNqMlBKU3J5RUluOFdFWVhBU0NRNGJnSnErOHN1ellRQmd0OVNq?=
 =?utf-8?B?aThvL1NDYzBSdDNKU0VtdFdUNXU3aXh0TEoxa004YWh0QkN5TmlzZ1MxbGFJ?=
 =?utf-8?B?R2JPZmc1Y0ZRWUJrVEZoYlFCZFk2NDVJdDhRdVpxVUpLWklrSC9ta1FhNXZz?=
 =?utf-8?B?TVdwWG9LUTJmOE9YQjNpdUFTOTNGZHhwQzEyTVhTQnFpS3UzSlZQcjZSM2xM?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF11385B3C1D7D4399B42FBEB7EE6F0C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd0ac0c-b0c1-4891-e49e-08dd0864038d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 06:33:00.5661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pc8RRMF9mEsqhSp6Iz3bKZr//nD0RUFCGx2g5n13dfKSE121v2eOHhWcudXDzZHygcniAh8AJivIatEbk+qpf2+cADpTs4qAe+KM8T8KEI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7044

T24gTW9uLCAyMDI0LTExLTE4IGF0IDA4OjIwICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gTW9uLCAyMDI0LTExLTE4IGF0IDExOjM2ICswODAw
LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gbXRrX2NydGNfZmluaXNoX3BhZ2VfZmxpcCgpIGlz
IHVzZWQgdG8gbm90aWZ5IHRoZSBwYWdlIGZsaXAgdGhhdA0KPiA+IGhhcw0KPiA+IGJlZW4gY29t
cGxldGVkIHRvIHRoZSB1c2Vyc3BhY2UsIHNvIHVzZXJzcGFjZSBjYW4gZnJlZSB0aGUgZnJhbWUN
Cj4gPiBidWZmZXINCj4gPiBvZiB0aGUgbGFzdCBmcmFtZSBhbmQgY29tbWl0IHRoZSBuZXh0IGZy
YW1lLg0KPiA+IA0KPiA+IEhvd2V2ZXIsIG10a19jcnRjX2ZpbmlzaF9wYWdlX2ZsaXAoKSBjYW5u
b3QgZ3VhcmFudGVlIHRoZSBHQ0UgaGFzDQo+ID4gY29uZmlndXJlZCBhbGwgdGhlIGRpc3BsYXkg
aGFyZHdhcmUgc2V0dGluZ3Mgb2YgdGhlIGxhc3QgZnJhbWUuDQo+ID4gVGhpcyBtYXkgY2F1c2Ug
dGhlIGRpc3BsYXkgaGFyZHdhcmUgdG8gc3RpbGwgYWNjZXNzIHRoZSBsYXN0IGZyYW1lDQo+ID4g
YnVmZmVyIHJlbGVhc2VkIGJ5IHRoZSB1c2Vyc3BhY2UuDQo+ID4gDQo+ID4gU28gYWRkIHRoZSBj
aGVja2luZyBjb25kaXRpb24gb2Ygbm8gcGVuZGluZ19wbGVucyBmbGFncyB0byBtYWtlDQo+ID4g
c3VyZQ0KPiA+IEdDRSBoYXMgZXhlY3V0ZWQgYWxsIHRoZSBwZW5kaW5nIHBsYW5lcyBjb25maWd1
cmF0aW9uLg0KPiANCj4gV2hhdCdzIHRoZSBwcm9iYWJpbGl0eT8NCj4gSWYgaXQncyBsb3cgcHJv
YmFiaWxpdHksIHdlIGNvdWxkIGRyb3AgY2FsbGluZw0KPiBtdGtfY3J0Y19maW5pc2hfcGFnZV9m
bGlwKCkuDQo+IElmIGl0J3Mgbm90IGxvdyBwcm9iYWJpbGl0eSwgSSB0aGluayBkcm9wIGNhbGxp
bmcNCj4gbXRrX2NydGNfZmluaXNoX3BhZ2VfZmxpcCgpIHdvdWxkIHJlZHVjZSB0aGUgZnBzIGFu
ZCB3ZSBzaG91bGQgZmluZA0KPiBhbm90aGVyIHdheS4NCg0KSXQgd29uJ3QgaGFwcGVuIGluIGRp
c3BsYXkgbm9ybWFsIGZsb3csIHdoaWNoIHVzZXMgdGhlDQptYm94X3NlbmRfbWVzc2FnZSgpIGlu
IElSUSBjb250ZXh0Lg0KQnV0IGl0J3MgZWFzeSB0byByZXByb2R1Y2UgaW4gZGlzcGxheSBTVlAg
Zmxvdywgd2hpY2ggdXNlcyB0aGUNCm1ib3hfc2VuZF9tZXNzYWdlKCkgdG8gcXVldWUgYSB3b3Jr
IHRvIHRoZSB3b3JrcXVldWUgb3V0IG9mIHRoZSBJUlENCmNvbnRleHQgZm9yIGNvbW11bmljYXRp
bmcgd2l0aCBURUUgd29ybGQuDQoNCkluIG1lZGlhVGVrIGhhcmR3YXJlIGRlc2lnbiBvZiBjb25m
aWd1cmluZyBkaXNwbGF5IGhhcmR3YXJlIGJ5IEdDRSwgSQ0KdGhpbmsgd2Ugc2hvdWxkIHVzZSBt
dGtfY3J0Y19maW5pc2hfcGFnZV9mbGlwKCkgdG8gbm90aWZ5IA0KYERSTV9FVkVOVF9GTElQX0NP
TVBMRVRFRGAgdG8gdXNlcnNwYWNlIHdoZW4gR0NFIGZpbmlzaGVkIGNvbmZpZ3VyaW5nDQphbGwg
ZGlzcGxheSBoYXJkd2FyZSBzZXR0aW5ncyBmb3IgZWFjaCBhdG9taWNfY29tbWl0KCkuDQoNCkFs
dGhvdWdoIGl0J3Mgc3RpbGwgbm8gcHJvYmxlbSBpbiBkaXNwbGF5IG5vcm1hbCBmbG93IHdpdGhv
dXQgdGhpcw0KbW9kaWZpY2F0aW9uLg0KQnV0IEkgYmVsaWV2ZSB3ZSBjYW4gaW5jcmVhc2UgdGhl
IGFjY3VyYWN5IG9mIHRoZSB0aW1pbmcgdG8gbm90aWZ5DQpgRFJNX0VWRU5UX0ZMSVBfQ09NUExF
VEVEYCB0byB1c2Vyc3BhY2UsIGlmIHdlIGNhbGxlZA0KbXRrX2NydGNfZmluaXNoZWRfcGFnZV9m
bGlwKCkgd2hlbiB0aGUgYWxsIHRoZSBkaXNwbGF5IGhhcmR3YXJlDQpzZXR0aW5ncyBpcyBjb25m
aWd1cmVkLg0KDQpNYXliZSB0aGlzIHBhdGNoIGlzIG5vdCBxdWl0ZSBzdHJhaWdodGZvcndhcmQg
dG8gZXhwcmVzcyB0aGUgbWVhbmluZyBvZg0KY2FsbGluZyBtdGtfY3J0Y19maW5pc2hfcGFnZV9m
bGlwKCkgYWZ0ZXIgR0NFIGNvbXBsZXRpbmcgYWxsIHRoZQ0KZGlzcGxheSBjb25maWd1cmF0aW9u
Lg0KU28gYWZ0ZXIgSSB2ZXJpZnlpbmcgaXQgaW4gbXkgbG9jYWwgZW52aXJvbm1lbnQgd2l0aCBT
VlAgZmxvdywgSSdsbA0KbW92ZSBtdGtfY3J0Y19maW5pc2hfcGFnZV9mbGlwKCkgdG8gdGhlIGRk
cF9jbWRxX2NiKCkgZGlyZWN0bHkgYW5kIHNlbmQNCnRoZSB2Mi4NCg0KUmVnYXJkcywNCkphc29u
LUpILkxpbg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCg==

