Return-Path: <linux-kernel+bounces-282464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A14694E467
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C541F21144
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1161F11723;
	Mon, 12 Aug 2024 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AkNYXNTm";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NrxKP07e"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF35C99
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424506; cv=fail; b=gQsCiJrz0smkvWdLgInifMtz+MHLzIZUANocUgN2j1YGmab6IwQh5oYlPDl5M5x/2Amcy4tY/pzSxebYg8sakEFN5UTN0p8NfHZfWCd0e98bFcszQBR/oaq5fytxEmBWKzxNqLR24yzSMqO3Wa274sxbKLJiKZ5PXLtYNuMOptU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424506; c=relaxed/simple;
	bh=VYvp2rKlbON2fKQFbDs1tAYsfYumsbAK7TmPpgj0AxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbxhRxJyxTZuDJ4oP3tdaELe77Y8UWpKq11vAK6YPLHHJwAqmYtp4papPCdfOU/3E8wMM64xwuVh/EB9wf8SOjkuGTwAx+jWdvxwm82gmMqL2laVwoIXnPUZx41iTWoCUvVdrK9jYIq3t4Tvf8ByF6WRa4HD/kvXb0qWuvTq4kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AkNYXNTm; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NrxKP07e; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6953e5e6584611ef9a4e6796c666300c-20240812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VYvp2rKlbON2fKQFbDs1tAYsfYumsbAK7TmPpgj0AxA=;
	b=AkNYXNTm3B9pak0Mb/nl14iASa/frLjA3Ii04OmAy7PiY+bLw/YpVOTva87zVyl5oNKdIoYLv2qc4RRC1pm95hcq7+qud2HHF/9V1Jo4UaMqWlGtSpUYwOWWr2/6iXohpoQAB6lrG/D7H1FhLAcio8EFN1pu/4G+EQ11E+Ok+8E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:39fe564c-6332-4b58-a640-808e3e007f95,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:38e475c1-acff-4a0f-9582-14bcdf4ed7e0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6953e5e6584611ef9a4e6796c666300c-20240812
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 917472719; Mon, 12 Aug 2024 09:01:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 11 Aug 2024 18:01:31 -0700
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Aug 2024 09:01:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaLE4hKAMaPjUYbnvO/wVwl+Erx5sOHVjzPmnqP6gg6PfofSIAalUp9Kt2POqQcc/dtJNyOiMxnljmAW5Q+V4tCwMKkFLcB8YkVvWnIHpe0evonQ5shaLoO3EwP7nIGdP/EhlmovmwBUEtz1/9UzVFOamPzMu+fmRqaSJlDF5wkp46IXKrNpkQCeA3QKdJX8FfwxHZgeLyHcGg9YRos3YssD5MZ2lIJ1GUCNRXftF8Gdnw8oYTMDlD5MnDjAsb+I0QhiSKCzOFoRaDMrevp2X0+1wsxxIqdnh896613JrKm5CYOLWBnGlLo36fQs8rqOBj9PdGFNiQVXMrT6Pd8yIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYvp2rKlbON2fKQFbDs1tAYsfYumsbAK7TmPpgj0AxA=;
 b=igBQA3RLEKUyBZ6JBQe0YZjgR//A44w4052boE6qkIbOhBXmT5VqP3QcUpt9JfQcoU3/YBMXMV5y4PoQyp2B9L73J0IFsp4Ib1cVSWLti1QoYLNh3OKItDaRhGqEtnPm0sJJ/uyUIzjZSoBlDcfNoScSj+QTTM9NfcDobJeSU6uJZH1/7XDHN6pq4A35Ra44nLSpvlYeWkr3gJFQJgwd4mfZqSRQWAi1VCHDKkFJ3S2djopspixTzMDXHnjltGyBKpo1MZgwF6qrJytqGsyLSQZF7Pq7P+hz1siii/CEkXpgBKtChBynBGetMuy75+yMc9O3lGlz99xDJe7kCYiaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYvp2rKlbON2fKQFbDs1tAYsfYumsbAK7TmPpgj0AxA=;
 b=NrxKP07e1JrQ/qW8uy7n05g4g7NnWqKrfYoh3trhjRbN+hl2Je3693+2xXWp0C/kVmDlEVNGN4ZQ679ukM9NJieUjZT8kKcEX4U1bji2CMUqNJF7TeeNs65hVAZkBScB0AEwZUPeLJLSTX7SO0w0vT1o9We9xDDfAJK+kLqO4ug=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8829.apcprd03.prod.outlook.com (2603:1096:101:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 12 Aug
 2024 01:01:29 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 01:01:28 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4] drm/mediatek: dsi: Add dsi per-frame lp code for
 mt8188
Thread-Topic: [PATCH v4] drm/mediatek: dsi: Add dsi per-frame lp code for
 mt8188
Thread-Index: AQHa4+qWvSJl5Up3QEu6RU2Prg/rNbIi3nyA
Date: Mon, 12 Aug 2024 01:01:28 +0000
Message-ID: <e55e77293cd86ec0734916895aed5ea747b9913f.camel@mediatek.com>
References: <20240801081144.22372-1-shuijing.li@mediatek.com>
In-Reply-To: <20240801081144.22372-1-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8829:EE_
x-ms-office365-filtering-correlation-id: b296e572-9296-477d-08fc-08dcba6a4c14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cmN5RmpDam1uOUpxemhEMDdSKzMvY21HS2N6eTNuSkxVUUxObU10bEdOUGpi?=
 =?utf-8?B?U1dkUmRJRGZjS2NPclZBUzkzbWpMSEplOTNhTVphNzFmSzczelFwMURRR1Vz?=
 =?utf-8?B?S2FDTXVubzNaeUU3U1VhLzBlU0JrTXJBTjl2dmFOOVBodjhtQWtYTjRMVTZG?=
 =?utf-8?B?QU5WUmVwMUJYams4YTJoUXhsc3Nid0xxRVUxNVdHcUVJQ1VkaHlhRjdZQzdn?=
 =?utf-8?B?YXBBOTQ1LzJQOFpOWmV3cVcvcnNmRjVPdEREMVpqUGVlM01RRkdyM3FyRW55?=
 =?utf-8?B?cnBSekJoazlQLy9oOGF2Qkc0VEM4WE1QeHRORytoQytNdnF3ZnhibzhHZVkz?=
 =?utf-8?B?dUM2TXVkZFBlUUpsZkgwN1Uwbkg1UG1JRzhVQkUvemN5SEI1VjBZYXFQek05?=
 =?utf-8?B?ZThWZDBYWXZxbnJqU1NQRlhIekwzVENsN3cwblhkUTl0QjNMQ1RaV2hjMjAx?=
 =?utf-8?B?Q0gvaDc5OG5XNStZdWQ4bVBRMlAyZlRpQVZCdkltTytYVEJyOEJhRnAvbnpJ?=
 =?utf-8?B?bDNINFA4bnZLZjNzWkFkOGgraVc2RVRlM0MyVC9wdGszV3R3ZXB5NXh0UDU4?=
 =?utf-8?B?Nkx4K3F2TDlxS093WE9WTElhTEczV01abEV3eVdwblNKek9jTndEYlllcFJu?=
 =?utf-8?B?ZTdwQ2hrR2hJWFdXNythK1J0VStZK1VmQ041UVNKWDlaTzBZVHNZTCsybElW?=
 =?utf-8?B?elU0QkxlYWt2d0ZvQjI3S2g5SXM0VFMwVWVoMUQ3N3EvSVZ4VVhuMisvaFBz?=
 =?utf-8?B?dTBkTFZGTVI5NWgzelNoUFFkNjkrZ3daL1NRZUgrbWxPVll4NDdPR3JUU0dx?=
 =?utf-8?B?dytOTzJOOFpPQVZHRUFyUGpmY2dSemdPR1h0Ymo0dmdCY2pOZE0wQjBKL0RG?=
 =?utf-8?B?Z1ByeXNZVUd3Q05LUFFRZSt6ZC9DVUpCOHA4WHVxRHZsUFNka2E5MkdBMlZ4?=
 =?utf-8?B?MWN1czhCcXgyOEpiUDJwL1hWdzJlVjk3WEZSK3ZVZXc4U251bjVBaU9rem1M?=
 =?utf-8?B?RHJXVlRtYUU1Ti9heStvOC9YY0NWZnlIVytEUFFpMGxWMVlkSnlJc2FmTW1u?=
 =?utf-8?B?bHJvWVFVRVVzZjJSNUpkYjJjVlVadFJVVGE2azhtbGZnWHZZQmI2eTY4UGpz?=
 =?utf-8?B?SEE4VWNZZVllbmJuZnFMaHBBdXJtRGhycmI4RHU2dGxXZ1NUWlZyVnQrQTVp?=
 =?utf-8?B?QU1acDJIcUgxTSsycTRsMGtyQzlOam1wMkRlMWd2NUZhQkdabkpzTDh5b1RV?=
 =?utf-8?B?UGV2U2VpNm1hZGVHYWZ1dkNaMEZnbUdsOW0rNE1QbUZFblJPajlVQS91amZy?=
 =?utf-8?B?b0ZwV2ZPS1RtblhHNmduRzY0ZGxJd3lERjNTdmYyZnd2SUxFL1dQeVo0a2xG?=
 =?utf-8?B?S2FKY1hKOWtiWk9YVG05RVIzd3JLRDIyV3RCWGJTQ0tJV2JtdnR6ajljUkZV?=
 =?utf-8?B?b1RDUzMrbWFaVUMrMjRYSnNwbTgrbnhJRDUvakE4K2dTeGhBQ254Um9pbm4w?=
 =?utf-8?B?bFlCMTlQeHpNUDVNSEx1c0hYQzFhQkYrZlViZ1U3MXUxRXVqVHhMVGJJSkVU?=
 =?utf-8?B?VUxPa3ZTTEJ6UG43bmd3RzBYcWJXNWpDSkpTd3Z2T3BlZVduSFRhWWRoR1lP?=
 =?utf-8?B?cU04T1REQi9ZdEV0M2xUdVYvbTZtbFJ5a1VycGdCY1cybFk0RHdFNGdVVXJQ?=
 =?utf-8?B?VXpsWWFBcDU2dlp2V05hc2xWWmJ6VXp5SG15V2RjcE4zU2NOMDBodm5hZjFR?=
 =?utf-8?B?QnY2NmF5UHMxd25xZUFRbTNUQnZaMkQzMVE5anFzQ0I5NTAzQVNiQkdLeDhn?=
 =?utf-8?B?OUZhWWFpQVJCY3VxbzZvOSt2UURRMnpqRGgzcWl3cFlUODY5OE9aUWZKcmZ2?=
 =?utf-8?B?UldmR0h4c3JQeG00L09aankxc0RIaTF6czdLM2RpczVRM3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkxickV2bzI4VDZNWkU2dTJmQ2RaelNERVBxNFhKdHBTcFphdTVmdjZTNVVF?=
 =?utf-8?B?NVVTbitmMXJYc3hlRlZQcHRaNVZPRHdYWDNsckk4NVNrNDJDanJET1BBa1pl?=
 =?utf-8?B?Uk1RSGVUT1pSdS9CY1dUNHpMZDdnRjR0a1FiQ0ZCVHoxRUJacnQ5Yzg5a2g4?=
 =?utf-8?B?TFFrOEpqN0MydFpOdnY4V0lWSU5rL2N3aGJBbUl2OG9VNDBxU000U3UyclQx?=
 =?utf-8?B?c0UwcjNiQUFEM1Z4ZkUyUnhjT2g4bmdJVFhhS1FZYTE3NTkxdkoyNVBsS3oz?=
 =?utf-8?B?Zk5NV0V2VzI0VlVOcFRLK0hnSmd3R3lBZnNhNEJFZm5OSWRFM2tWZGdHdC8r?=
 =?utf-8?B?aDRSRlltV3BXRmZXbnZ2d3laSzFEOC81WFNTaGFKMExlWXo5UTl4dUpzRjVQ?=
 =?utf-8?B?a2V5RUxPWVlBMzcrWUEvTk5VUTNwYTZjR3k5L2RMUU1vTG5DUEdDZ2tKOVEy?=
 =?utf-8?B?N0Q3UUhMdnhpdkNpb3EyZGFEZFhKN2t2dkE1ZEMySUViN3V6TTF2bnNzUEZT?=
 =?utf-8?B?bTZPTWpTc3hmeUlHS0J2cHdHNlBuYTN2ZkJNbk1INjhmZE4wNWxQRGRHNVF6?=
 =?utf-8?B?L0pHYVpnSXNhYnNXNkh0cTh5blVHdTRwSGlGVjdhOHJuMmcrdVpsV0ljMDNo?=
 =?utf-8?B?ZkxpQ0ttTS9sSjFWTGdXZ3F6OTJ2L2E2L1VXVWVheUV5UFFYekJKanNVZW9P?=
 =?utf-8?B?YzllRm5kRmFFLzlSR05pcHZxVWtkcE12dHprSFBEWVl3Z3VlNnZ5aGpKSXNF?=
 =?utf-8?B?RXlZQmJTSnFZMlhYMTNKcStORnBqc2tzTFMwVGx0YzZvNmlDaEtkS3owZHNa?=
 =?utf-8?B?My9TWWRxMFlzMlh4ajc5UVFYOG1IRnp2YWFlRUhrdyt6MG94NTFTa3VzUWpO?=
 =?utf-8?B?NFNRTnlqU0Q2MGVzTjducUtlQkNwc2I2V3pwNTR1ZjZvNjFwcnpnMFVsTXdL?=
 =?utf-8?B?V3VZVSthbkpoLzVMcDRQWjd1QmNBeXR0a2x3Z3hqQUpJRjRDUmtORysxOG16?=
 =?utf-8?B?MCs0aG1FQzVxVVBKaVZpbloxTzlMWnhycjlYa21tVjdTNkI3MWtyYitIZU9P?=
 =?utf-8?B?OXRneVV5R0NIZldoc2M0MlZQYi9qRVdZcVp4R0YxeFgyc1pHNTFlWnorWUpn?=
 =?utf-8?B?d3pnUkFxd21mYnNBMjdGRGFhS1E4eUNzbVZRNSsrN0U2aTNoc3MyblFuQ2Vw?=
 =?utf-8?B?ME9zakJHeXJZNHhpV0FxVDUwaGx3QllNYXd6amx4dzN5R003WGliZlA4M1Vs?=
 =?utf-8?B?bmhLbEVlMktIZkNrUUZBL3FUbmZnVjR6SWtMcktwbmJrRndXVXArZzNublBt?=
 =?utf-8?B?Wjlxa3VBZUc1U0ZWdXpUMngwSkxsOEdoL3JPbkJwMGZiVlJYSEk4eHNLaDBq?=
 =?utf-8?B?ZzM3alUxRUFYVW4vTFg1ZjgxVURlbE94cDJYQ0RKREhFL1J6SjRDNmQyWUt4?=
 =?utf-8?B?WFFZcFV4dUg2MUlNS2RvTEl0UkpnWlAvOXczQ0d1cTRpOUsySzVEUjd1ZDNl?=
 =?utf-8?B?TUlja3VIVnFycDBLUWdBODZkMjBjMitlbnNGWGdBZlRGYVc5VHQxcS8wUGU1?=
 =?utf-8?B?SjlsRWNsYzlzTWlhb2t0VDFiVDV2eVdpSTZ2VFdLT3RjQXpsZThmd2Z1Tmxm?=
 =?utf-8?B?MDBuVjhwWkxsK3FpR2lpMmppSCtvdGxWc3dKMkFRSWd6RFNKcWpIbGQ2U01R?=
 =?utf-8?B?K2Z6SmxtcE1ibDlCZ1U2WFY4T0w0NFlHN0Rib2NNL1Z1Zk91c0xkaGI3eURW?=
 =?utf-8?B?eWxoV2dubUd3ZjhZaVVEamc1MHhVRUFKS1I3UFRkdFRWeXhMODJEUHRmSUl3?=
 =?utf-8?B?dkdUNGhwM0tNYkdoV3F1UmRra09ySnpjWlRKVnllSWhLMERiSzgvZlZ5RkVr?=
 =?utf-8?B?NzNDRzZPRWFZZm9yMmh0VUY3eDBUVnNFS21ZMnVVRzZLT1NNZS9SazVaSVlu?=
 =?utf-8?B?QSsvU3NEblg2Z05TenczcWVsTFUrVlZTRTlXVGtjQjlnWlg3NVVrbnR2RTYx?=
 =?utf-8?B?K1VzQ21reVF2NFRocTJNWGFxVmt5K2JiUWdJbDgxTjRXRVlZYjlEakFDVXNi?=
 =?utf-8?B?WHVMU29kVXU0aUFmRWU1R1lWZXN5ZFVFT2VraFFYeXp0dUwvcUhUb1NHbldz?=
 =?utf-8?Q?PILF6zcUDrBSRw1nYJepn/XgG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10264F1018C2FA4197D3111B175FEF02@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b296e572-9296-477d-08fc-08dcba6a4c14
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 01:01:28.5309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7yi7l7C2yrwuH5ILgzJIg02e5ihcDde/AAktQiBEiagyuMKzyB1fOjvq+nRJzC7Q5pk6hK0Xspz9y55ELgLIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8829

SGksIFNodWlqaW5nOg0KDQpPbiBUaHUsIDIwMjQtMDgtMDEgYXQgMTY6MTEgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBBZGRpbmcgdGhlIHBlci1mcmFtZSBscCBmdW5jdGlvbiBvZiBtdDgx
ODgsIHdoaWNoIGNhbiBrZWVwIEhGUCBpbiBIUyBhbmQNCj4gcmVkdWNlIHRoZSB0aW1lIHJlcXVp
cmVkIGZvciBlYWNoIGxpbmUgdG8gZW50ZXIgYW5kIGV4aXQgbG93IHBvd2VyLg0KPiBQZXIgRnJh
bWUgTFA6DQo+ICAgfDwtLS0tLS0tLS0tT25lIEFjdGl2ZSBGcmFtZS0tLS0tLS0tPnwNCj4gLS1f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXy0tLS1fX19fX19fX19fX19fX19f
X19fDQo+ICAgXkhTQStIQlBeXlJHQl5eSEZQXl5IU0ErSEJQXl5SR0JeXkhGUF4gICAgXkhTQStI
QlBeXlJHQl5eSEZQXg0KPiANCj4gUGVyIExpbmUgTFA6DQo+ICAgfDwtLS0tLS0tLS0tLS0tLS1P
bmUgQWN0aXZlIEZyYW1lLS0tLS0tLS0tLS0+fA0KPiAtLV9fX19fX19fX19fX19fLS1fX19fX19f
X19fX19fXy0tX19fX19fX19fX19fX18tLS0tX19fX19fX19fX19fX18NCj4gICBeSFNBK0hCUF5e
UkdCXiAgXkhTQStIQlBeXlJHQl4gIF5IU0ErSEJQXl5SR0JeICAgIF5IU0ErSEJQXl5SR0JeDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaHVpamluZyBMaSA8c2h1aWppbmcubGlAbWVkaWF0ZWsuY29t
Pg0KPiAtLS0NCg0KW3NuaXBdDQoNCj4gKw0KPiAgc3RhdGljIHZvaWQgbXRrX2RzaV9jb25maWdf
dmRvX3RpbWluZyhzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KPiAgew0KPiAgCXUzMiBob3Jpem9udGFs
X3N5bmNfYWN0aXZlX2J5dGU7DQo+IEBAIC00NDksNTcgKzU2MCw2MSBAQCBzdGF0aWMgdm9pZCBt
dGtfZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+ICAJd3JpdGVs
KHZtLT52ZnJvbnRfcG9yY2gsIGRzaS0+cmVncyArIERTSV9WRlBfTkwpOw0KPiAgCXdyaXRlbCh2
bS0+dmFjdGl2ZSwgZHNpLT5yZWdzICsgRFNJX1ZBQ1RfTkwpOw0KPiAgDQo+IC0JaWYgKGRzaS0+
ZHJpdmVyX2RhdGEtPmhhc19zaXplX2N0bCkNCj4gLQkJd3JpdGVsKEZJRUxEX1BSRVAoRFNJX0hF
SUdIVCwgdm0tPnZhY3RpdmUpIHwNCj4gLQkJICAgICAgIEZJRUxEX1BSRVAoRFNJX1dJRFRILCB2
bS0+aGFjdGl2ZSksDQo+IC0JCSAgICAgICBkc2ktPnJlZ3MgKyBEU0lfU0laRV9DT04pOw0KPiAt
DQo+IC0JaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRlID0gKHZtLT5oc3luY19sZW4gKiBkc2lf
dG1wX2J1Zl9icHAgLSAxMCk7DQo+IC0NCj4gLQlpZiAoZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9E
U0lfTU9ERV9WSURFT19TWU5DX1BVTFNFKQ0KPiAtCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRl
ID0gdm0tPmhiYWNrX3BvcmNoICogZHNpX3RtcF9idWZfYnBwIC0gMTA7DQo+IC0JZWxzZQ0KPiAt
CQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlID0gKHZtLT5oYmFja19wb3JjaCArIHZtLT5oc3lu
Y19sZW4pICoNCj4gLQkJCQkJICAgIGRzaV90bXBfYnVmX2JwcCAtIDEwOw0KPiAtDQo+IC0JZGF0
YV9waHlfY3ljbGVzID0gdGltaW5nLT5scHggKyB0aW1pbmctPmRhX2hzX3ByZXBhcmUgKw0KPiAt
CQkJICB0aW1pbmctPmRhX2hzX3plcm8gKyB0aW1pbmctPmRhX2hzX2V4aXQgKyAzOw0KPiAtDQo+
IC0JZGVsdGEgPSBkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX1ZJREVPX0JVUlNUID8g
MTggOiAxMjsNCj4gLQlkZWx0YSArPSBkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX05P
X0VPVF9QQUNLRVQgPyAwIDogMjsNCj4gKwlpZiAoZHNpLT5kcml2ZXJfZGF0YS0+c3VwcG9ydF9w
ZXJfZnJhbWVfbHApDQo+ICsJCW10a19kc2lfY29uZmlnX3Zkb190aW1pbmdfcGVyX2ZyYW1lX2xw
KGRzaSk7DQo+ICsJZWxzZSB7DQoNClRoZSAnaWYnIHBhcnQgaXMgYSBmdW5jdGlvbiwgc28gSSB0
aGluayB0aGUgJ2Vsc2UnIHNob3VsZCBhbHNvIGJlIGEgZnVuY3Rpb24gYmVjYXVzZSB0aGUgYm90
aCBwYXJ0IGRvIHRoZSBzaW1pbGFyIHRoaW5ncy4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwkJaWYg
KGRzaS0+ZHJpdmVyX2RhdGEtPmhhc19zaXplX2N0bCkNCj4gKwkJCXdyaXRlbChGSUVMRF9QUkVQ
KERTSV9IRUlHSFQsIHZtLT52YWN0aXZlKSB8DQo+ICsJCQkJRklFTERfUFJFUChEU0lfV0lEVEgs
IHZtLT5oYWN0aXZlKSwNCj4gKwkJCQlkc2ktPnJlZ3MgKyBEU0lfU0laRV9DT04pOw0KPiAgDQo+
IC0JaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUgPSB2bS0+aGZyb250X3BvcmNoICogZHNpX3Rt
cF9idWZfYnBwOw0KPiAtCWhvcml6b250YWxfZnJvbnRfYmFja19ieXRlID0gaG9yaXpvbnRhbF9m
cm9udHBvcmNoX2J5dGUgKyBob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlOw0KPiAtCWRhdGFfcGh5
X2N5Y2xlc19ieXRlID0gZGF0YV9waHlfY3ljbGVzICogZHNpLT5sYW5lcyArIGRlbHRhOw0KPiAr
CQlob3Jpem9udGFsX3N5bmNfYWN0aXZlX2J5dGUgPSAodm0tPmhzeW5jX2xlbiAqIGRzaV90bXBf
YnVmX2JwcCAtIDEwKTsNCj4gIA0KPiAtCWlmIChob3Jpem9udGFsX2Zyb250X2JhY2tfYnl0ZSA+
IGRhdGFfcGh5X2N5Y2xlc19ieXRlKSB7DQo+IC0JCWhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRl
IC09IGRhdGFfcGh5X2N5Y2xlc19ieXRlICoNCj4gLQkJCQkJICAgICAgaG9yaXpvbnRhbF9mcm9u
dHBvcmNoX2J5dGUgLw0KPiAtCQkJCQkgICAgICBob3Jpem9udGFsX2Zyb250X2JhY2tfYnl0ZTsN
Cj4gLQ0KPiAtCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlIC09IGRhdGFfcGh5X2N5Y2xlc19i
eXRlICoNCj4gLQkJCQkJICAgICBob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlIC8NCj4gLQkJCQkJ
ICAgICBob3Jpem9udGFsX2Zyb250X2JhY2tfYnl0ZTsNCj4gLQl9IGVsc2Ugew0KPiAtCQlEUk1f
V0FSTigiSEZQICsgSEJQIGxlc3MgdGhhbiBkLXBoeSwgRlBTIHdpbGwgdW5kZXIgNjBIelxuIik7
DQo+IC0JfQ0KPiAtDQo+IC0JaWYgKChkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9IU19QS1Rf
RU5EX0FMSUdORUQpICYmDQo+IC0JICAgIChkc2ktPmxhbmVzID09IDQpKSB7DQo+IC0JCWhvcml6
b250YWxfc3luY19hY3RpdmVfYnl0ZSA9DQo+IC0JCQlyb3VuZHVwKGhvcml6b250YWxfc3luY19h
Y3RpdmVfYnl0ZSwgZHNpLT5sYW5lcykgLSAyOw0KPiAtCQlob3Jpem9udGFsX2Zyb250cG9yY2hf
Ynl0ZSA9DQo+IC0JCQlyb3VuZHVwKGhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRlLCBkc2ktPmxh
bmVzKSAtIDI7DQo+IC0JCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgPQ0KPiAtCQkJcm91bmR1
cChob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlLCBkc2ktPmxhbmVzKSAtIDI7DQo+IC0JCWhvcml6
b250YWxfYmFja3BvcmNoX2J5dGUgLT0NCj4gLQkJCSh2bS0+aGFjdGl2ZSAqIGRzaV90bXBfYnVm
X2JwcCArIDIpICUgZHNpLT5sYW5lczsNCj4gKwkJaWYgKGRzaS0+bW9kZV9mbGFncyAmIE1JUElf
RFNJX01PREVfVklERU9fU1lOQ19QVUxTRSkNCj4gKwkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5
dGUgPSB2bS0+aGJhY2tfcG9yY2ggKiBkc2lfdG1wX2J1Zl9icHAgLSAxMDsNCj4gKwkJZWxzZQ0K
PiArCQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSA9ICh2bS0+aGJhY2tfcG9yY2ggKyB2bS0+
aHN5bmNfbGVuKSAqDQo+ICsJCQkJCQkJZHNpX3RtcF9idWZfYnBwIC0gMTA7DQo+ICsNCj4gKwkJ
ZGF0YV9waHlfY3ljbGVzID0gdGltaW5nLT5scHggKyB0aW1pbmctPmRhX2hzX3ByZXBhcmUgKw0K
PiArCQkJCXRpbWluZy0+ZGFfaHNfemVybyArIHRpbWluZy0+ZGFfaHNfZXhpdCArIDM7DQo+ICsN
Cj4gKwkJZGVsdGEgPSBkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX1ZJREVPX0JVUlNU
ID8gMTggOiAxMjsNCj4gKwkJZGVsdGEgKz0gZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfTU9E
RV9OT19FT1RfUEFDS0VUID8gMCA6IDI7DQo+ICsNCj4gKwkJaG9yaXpvbnRhbF9mcm9udHBvcmNo
X2J5dGUgPSB2bS0+aGZyb250X3BvcmNoICogZHNpX3RtcF9idWZfYnBwOw0KPiArCQlob3Jpem9u
dGFsX2Zyb250X2JhY2tfYnl0ZSA9IGhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRlICsgaG9yaXpv
bnRhbF9iYWNrcG9yY2hfYnl0ZTsNCj4gKwkJZGF0YV9waHlfY3ljbGVzX2J5dGUgPSBkYXRhX3Bo
eV9jeWNsZXMgKiBkc2ktPmxhbmVzICsgZGVsdGE7DQo+ICsNCj4gKwkJaWYgKGhvcml6b250YWxf
ZnJvbnRfYmFja19ieXRlID4gZGF0YV9waHlfY3ljbGVzX2J5dGUpIHsNCj4gKwkJCWhvcml6b250
YWxfZnJvbnRwb3JjaF9ieXRlIC09IGRhdGFfcGh5X2N5Y2xlc19ieXRlICoNCj4gKwkJCQkJCQlo
b3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSAvDQo+ICsJCQkJCQkJaG9yaXpvbnRhbF9mcm9udF9i
YWNrX2J5dGU7DQo+ICsNCj4gKwkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgLT0gZGF0YV9w
aHlfY3ljbGVzX2J5dGUgKg0KPiArCQkJCQkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgLw0K
PiArCQkJCQkJCWhvcml6b250YWxfZnJvbnRfYmFja19ieXRlOw0KPiArCQl9IGVsc2Ugew0KPiAr
CQkJRFJNX1dBUk4oIkhGUCArIEhCUCBsZXNzIHRoYW4gZC1waHksIEZQUyB3aWxsIHVuZGVyIDYw
SHpcbiIpOw0KPiArCQl9DQo+ICsNCj4gKwkJaWYgKChkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RT
SV9IU19QS1RfRU5EX0FMSUdORUQpICYmDQo+ICsJCQkoZHNpLT5sYW5lcyA9PSA0KSkgew0KPiAr
CQkJaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRlID0NCj4gKwkJCQlyb3VuZHVwKGhvcml6b250
YWxfc3luY19hY3RpdmVfYnl0ZSwgZHNpLT5sYW5lcykgLSAyOw0KPiArCQkJaG9yaXpvbnRhbF9m
cm9udHBvcmNoX2J5dGUgPQ0KPiArCQkJCXJvdW5kdXAoaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5
dGUsIGRzaS0+bGFuZXMpIC0gMjsNCj4gKwkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgPQ0K
PiArCQkJCXJvdW5kdXAoaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSwgZHNpLT5sYW5lcykgLSAy
Ow0KPiArCQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSAtPQ0KPiArCQkJCSh2bS0+aGFjdGl2
ZSAqIGRzaV90bXBfYnVmX2JwcCArIDIpICUgZHNpLT5sYW5lczsNCj4gKwkJfQ0KPiArDQo+ICsJ
CXdyaXRlbChob3Jpem9udGFsX3N5bmNfYWN0aXZlX2J5dGUsIGRzaS0+cmVncyArIERTSV9IU0Ff
V0MpOw0KPiArCQl3cml0ZWwoaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSwgZHNpLT5yZWdzICsg
RFNJX0hCUF9XQyk7DQo+ICsJCXdyaXRlbChob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSwgZHNp
LT5yZWdzICsgRFNJX0hGUF9XQyk7DQo+ICAJfQ0KPiAgDQo+IC0Jd3JpdGVsKGhvcml6b250YWxf
c3luY19hY3RpdmVfYnl0ZSwgZHNpLT5yZWdzICsgRFNJX0hTQV9XQyk7DQo+IC0Jd3JpdGVsKGhv
cml6b250YWxfYmFja3BvcmNoX2J5dGUsIGRzaS0+cmVncyArIERTSV9IQlBfV0MpOw0KPiAtCXdy
aXRlbChob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSwgZHNpLT5yZWdzICsgRFNJX0hGUF9XQyk7
DQo+IC0NCj4gIAltdGtfZHNpX3BzX2NvbnRyb2woZHNpLCBmYWxzZSk7DQo+ICB9DQo+ICANCg==

