Return-Path: <linux-kernel+bounces-573407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E28A6D6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08FE3B20C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EA625D8F1;
	Mon, 24 Mar 2025 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T/w6USql";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="agmH2Jsh"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C825D8ED;
	Mon, 24 Mar 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806815; cv=fail; b=qenQ/ejsiT8qXVzEE3wbHjmXm2wwpwJ9ahD6zyBjAjCthK5oQ1WwlCeK11hjFICIHDypld8+hlldMyIXu9jKYHqdXa3hZyK//pAUgoPd+M3PPJ9+3GCDzjWwA0Jlrj76A0pnhhJQbtZEzC5zxLfr8I0b1204dBznm1UAVSesPSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806815; c=relaxed/simple;
	bh=6U4qP+xdATYnlbpo4pQ+Vu2xa7Oq1T+ZPIXIiseZoT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vqm5pznus4HNKjc+gtgfiO60x8CxKEFyaebGPbA2G6X2HUBbr8uXjcxzFGY5kXClltXeQzxGFkarGT1D5V+ghhnOhwQoticRE18CT011T5CZ05CI7yB8IuG0PZGmdMCXhiSXbksU2xnKrWss7uChVwOqF9CP2aUK8e1OETf1NS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=T/w6USql; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=agmH2Jsh; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 62dbf35e088e11f0aae1fd9735fae912-20250324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6U4qP+xdATYnlbpo4pQ+Vu2xa7Oq1T+ZPIXIiseZoT8=;
	b=T/w6USqlZaGGlhMDaUWnayYVUeEmmLCdZXUxFGGdv2je9fjzgvg2e9hBmaQkJNyJYeUYRY9f2TGeSC874RP//AIk6THZt//3G6BtT+E5zOwLY1h2wxR4mB+0U6gncxdNxlWpTnpKY9bMk5bV/k/2hZn7wIY4HxfE0YZ5PCm40r4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:d80a3ae8-7d51-4eba-b33f-e7417fc7763c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:d4a57d4a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 62dbf35e088e11f0aae1fd9735fae912-20250324
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 760332443; Mon, 24 Mar 2025 17:00:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 24 Mar 2025 17:00:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 24 Mar 2025 17:00:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQfhUeRQ7iiNqkEVFKTBYaB8FSloQPujntx5F+GFi1VLwO8u3syUTjstTjDyEWwbp5W6SdeS2s53wje2J9p61tJ0K9dwhRxlThekMYi//txIR20wUYjfBAqCTqqKZxJ5unkAxNTaHRs+UeIJD6cNG8fb1HYklyURV+3YZ8Y5szN6AD+AQ1IqNbuNPArZIYNQRTXNcuPvv9J/uyPwqLGAJYYnRMhFVJZ4FbnXD3Z7DJqbqBoDiFkWAOqJevQlVfA71ogfgvlOVcy3IxEyWkZOGUCHfdDcHOudhKyn1lN1smEV4MXx3u4/mko63Y0Q6XdhJe+a4gOQp/y0C3xBYdl/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6U4qP+xdATYnlbpo4pQ+Vu2xa7Oq1T+ZPIXIiseZoT8=;
 b=LgqhF9PZz8o5urKi9cslvSGTGtM8it/KHZjx3WBqf95jkj10Cp2Qt5DXEpywpv5/w3k/EKrg3HS/O1hcbPHuCk2WNGlUMZ6h52qnX1yTQa/tF9Op6l0Se9R4Ydm5eP5iCn1Edea2xiAX/WM0AzwFsFUMUp95mlKntp74EecNaAVLYUlU4Q3Zx4TtP/dCtUXYlLT9Fi81FdPeDqENca+m8kv+VVnRHC3rlrZkM0wpwIfiGRLmEBxvfDaXBQOeU3bDDr7nC06iz+9/sLtoBncHxL35LBsWYvb4lHZIz+WAhdbZvIyrtbFP1l7zV/sDIYqQUbfXYgD+Tu2Kn2NR8DLBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U4qP+xdATYnlbpo4pQ+Vu2xa7Oq1T+ZPIXIiseZoT8=;
 b=agmH2JshsKMJu836tyZgoUxiZ8MzZoSFsdGlUwclWH4CJyEJ43rnh2yjvukHwAEgM+iTOKbfnnCqXuv6TEONQ3J0b6GPQCi6dD/SDchAedhxmOQf/usY7rgdtWk7Jdcf5AVJ+fe+9AJyPZJUq90AbX/RwfdugGeURLwdpA2WytI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7477.apcprd03.prod.outlook.com (2603:1096:101:147::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:00:01 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%2]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:00:01 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?=
	<Paul-pl.Chen@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: =?utf-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?WGlhbmRvbmcgV2FuZyAo546L5YWI5YasKQ==?=
	<Xiandong.Wang@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"fshao@chromium.org" <fshao@chromium.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "treapking@chromium.org" <treapking@chromium.org>
Subject: Re: [PATCH v2 12/15] drm/mediatek: add OUTPROC support for MT8196
Thread-Topic: [PATCH v2 12/15] drm/mediatek: add OUTPROC support for MT8196
Thread-Index: AQHbmkTVS4+Pf0PfkE6E/5ZPeX/AiLOCAbUA
Date: Mon, 24 Mar 2025 09:00:01 +0000
Message-ID: <297be0e3f2b5b9cb4d051cfae6e5f5868c3cb7b8.camel@mediatek.com>
References: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
	 <20250321093435.94835-13-paul-pl.chen@mediatek.com>
In-Reply-To: <20250321093435.94835-13-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7477:EE_
x-ms-office365-filtering-correlation-id: 1486b509-af7f-4828-b0e5-08dd6ab242bf
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TlJtVDV2Q0tPN1Awc20wbC92UmJyYjk2aFlXc2gzK0xxdWVpNy94K3lEL3dj?=
 =?utf-8?B?S1dWV0E2S1Q0RWxadkJRV3AycGp2MERka1JscElKa2FtYTBpSkNFZ2twUlV6?=
 =?utf-8?B?dEY3YWdFWVlXazgrdFRqUVBjL3hOa2ZITU54MGd3ejBXVG4vbUdyRmUra3l3?=
 =?utf-8?B?ell1QU5EWnRUQWNYWWxpRTFJRUZHTkNBd01FaUlpOFJMS1dVWHlyRXp1Uis2?=
 =?utf-8?B?QWtKWjEvQ3BONXhSUW9rbHF3YTF3cXM2bEo5QWcyWTQwZkNXTFlFeHVCc3h0?=
 =?utf-8?B?VFlOaGJqRGRNM0pKUlZMcFc0SVgrbFZ5UVIrTWpocjd6Y1h1Ym1VeFZIelJx?=
 =?utf-8?B?TXBscXEyMXAyV3YzYm1HUnhiNS9kWmttcTNtMStEVlljOGVTOTZZMElMems2?=
 =?utf-8?B?Sko5UFdmNE41TThHMDdmMWl3cDEzenh5VHd2ZnNUMFpiRVphRVNxNUhjRVR4?=
 =?utf-8?B?QXJPaUdqcC82YjBHRDJ5a09TK1Z6Y3MyVldleXczQ3ZJZHg5UXdNRkJ1YU5J?=
 =?utf-8?B?MUdwcis5TU8wU3J3R1dlSStJTW5pcXBFL0EwbVJZWVNpQzdFTjY1WE9FcGpX?=
 =?utf-8?B?dHdMSUlJenRVQ2pBUytvVjlPaG1QMVVINWlqamhKWkJIOGpQRU10MmxhYkdN?=
 =?utf-8?B?TWRPUmpzRG5QNTB2NFRHQ1oxYU5TQ0Z4Q3AycFJ4WUczeU03NDdmVHhxTjd0?=
 =?utf-8?B?TWxvaE5pZDVlaW5kaTBiOGJEQlE4WUk3MStYeWhUcHdQdm56WDFlcXZoeTZp?=
 =?utf-8?B?QlhwbmplbCswRk9NSGkzTEt1bWt2RjJWL1ViZk1qOFJSUVltVS92Qzl5cDJ6?=
 =?utf-8?B?OW03bjZIRnhTby9wT1lWODhkb0dtTkdjdTNib1JmTnRkZGNGYkhuRC9PRTVs?=
 =?utf-8?B?ZmdNekZzelRHaXkxM1JvUHRjUlVsWC92djE1UVZidkh1TG84MTFPa2JrbEI4?=
 =?utf-8?B?M1JGK2JOUnBneWdzQjIxVG9lWWppcUxaRi8xaUVFQ2o0RmF2bTgwNElYcUY4?=
 =?utf-8?B?MExvNkpqZ3BvNyt2alAzVXpRdjZHQXhENTBsRllIdjJBRjA2NnZYRDV3dGZQ?=
 =?utf-8?B?RGJhdVlqdmlGMVlkR1lnVzFuaVJNdHJqMFZxY0NRK0YvcmNoYnM1VWxOY2pX?=
 =?utf-8?B?TTVQNFhmR216N043cU4xVi9na0RTUEUwcCtTUUlHSFI2TGw3bUVSaTBsRTBp?=
 =?utf-8?B?NG9uR0xleXVPaU9DNWw1TkM4cll0WFNZZzJQVFpxemdGdnBUQnVQSnU4MVNV?=
 =?utf-8?B?SXNRd3pLSnNlSlR5ZWNadWl0cU5HZlB2VG9hUG4xaytWVHZkZ2RieEI3M1Zy?=
 =?utf-8?B?ZXF1Z3lheGQ4L0RMbXhLaTdoMXlQNlJzNjdYS2hjV2FqT2c5bWNXakJhQnVh?=
 =?utf-8?B?bFU2cEtmdVBBaldYWG0wZE9nTHd3OHY1QXJLU0VXaVBib1pMaEFKZ2VxWW1r?=
 =?utf-8?B?QnZxWlYwcEF3SjBhblB1MUlRSHNlRVZzZWlZKzVwR1ZBbjB4MzY5aGJLbXpI?=
 =?utf-8?B?Q1AvbG1md3EzVTVJVW1JZFNPTlBGMHdkMkhJRDZ3Tjh4M3ErZUZKVGNLWExX?=
 =?utf-8?B?dm5XQVF0d0QrbkpzNUZBTnRZRnFUaXYrUHErYWdvS0FVWjU5TWpFQnp3NkdL?=
 =?utf-8?B?SFBLendBQ1FXQVl0aGxnQWNSQ3g3TlNEelJCc1RFajNTbTJlNkRxYldwS0gr?=
 =?utf-8?B?UStJUStWNWFteXBTT2w0SjRDbmlEM0RVdWVqTDZBWGtBMEVxc29SRzhMZkp2?=
 =?utf-8?B?RWxhRE5mQlhXeFRUeE1tcDVJa2tJb0dqcXN1NUU0N0dTUXdCUXdOU2Rna1ho?=
 =?utf-8?B?WU0yb1NObkJoVFNXOHNjTERIQXc1MGZtcWNRUzVwUk5yOG0zbHpuN0FIdzg5?=
 =?utf-8?B?UmZBY01KYVBwNENmdXk1eUduRmx3cGJYckcyOTVGVllKbm9zRE42bjNmeUFv?=
 =?utf-8?B?eTh2T1JVd2x0NmdSKysvVVhrTzNnYXU1bWpZTm9FMDlwNTBmdDhZVmZGRHE5?=
 =?utf-8?B?aEx2ZlRneFd3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHBwbFdvQ3hUWStUNVhJQkluZ1pHUG9TQzltZGNpSlNTZzNVeUQ2R1BWZHRk?=
 =?utf-8?B?N2x5YS9UWnp0aE1FcWlmN3ZVdDhvWk0zdG5HQk56OTFvQWlUMS81bGxQNjRN?=
 =?utf-8?B?eG5TSDBOV3RzWHBqUEI5Rld5ZzZmSUlsRmJjbVpyaXRmQ2Zyb01hY3JyTCt4?=
 =?utf-8?B?eFF1L1M3U1NSQ2x6SnV6SUIzd1g1VTB0WUJQc3FGSm9HRHFhaTZSRUUxK1pK?=
 =?utf-8?B?VVRtbDJibyt2RHpUTmFaTXZUMW5lYTd4R2VkZ2RTYjhETytRWktTL09PQkU4?=
 =?utf-8?B?N3lMdy9oTUZWalR5Z0s2cXlqT3JrUnJTUVVVQWlLOGcxcGV1MDNXV1VYbGc4?=
 =?utf-8?B?QjRERERtTHdPVnZPOFVEZGFqeTdKaUZJaVV2S2ZPRE1KWTB0Z3JDZHN3SmVT?=
 =?utf-8?B?ZW11SmZCWWFYSGNFeGhJMk5zWFI4aXR3Vlp2QXM4MDVET3RQeFBYdEZhL0l1?=
 =?utf-8?B?aENaRXg2REpxemI2TXRCT0xZazZDay84TWZERmlZdHBTWkQ5YWtJaDhSVDV2?=
 =?utf-8?B?Z1VYOW0xMEVlMkFsb2V5dmdwN1h3QXFVMENPb0FqV3QyZG5xMlBhMFZuc3Fl?=
 =?utf-8?B?aTMvbjUvaVR6R1dWOEY2MGVnVUR1QlRqMnMxTmxYdm5MMU01a2FiV090dmxC?=
 =?utf-8?B?VEhxTGJEdjFpWjlJaVJwWlovdUZKTWlja3NUeUdpQjNrNjJNYzBRdkRzZVlv?=
 =?utf-8?B?UDNtSHVoc3hEWjRpMG0yRHFRS0NHMGZFVHc3NHExM2I3azhLQll6TEtiK0dC?=
 =?utf-8?B?SkdlYzdodHpEVGlQV2tZclNvYW9XUStRcWF2Ly9LOWN5WStMV0d2QVRjcGNG?=
 =?utf-8?B?YW9tdVBJNDBMaUNOdGVoWWFQZ09zc0NsRlJyUk9aTnpMMEhYeWRvTU5SMVFD?=
 =?utf-8?B?dDVJVDhSb3RrQkZ4d2RQdGRuMTdsWGtCWk5xZmVEc2hwNU00R1hoL2s0OEJR?=
 =?utf-8?B?eEx5WWRyZStBY3pWYjZFS0xnb3hvUVlwcWxoeFVDNk5NazhSNThTOWNTaUJH?=
 =?utf-8?B?NlJUYUNHVDV4N2t5bHcrMGh4bURnK3JRYlZybmJzQm1haGdpWUdyaE9zQ3k1?=
 =?utf-8?B?MkJLR2FzS2JmaEEwOTRIQlNJWWd6Q1NuNitZVXlPMTFIeVZkUnVqb2xUam1y?=
 =?utf-8?B?WU02RDIvTkhvVStBelI3UWlQTkV6am5VazAvenhqbTVJd0FBTGJVblYwYk5U?=
 =?utf-8?B?SDhoMWlFa3JqOUZWYjNUajZCWjFybWFSc1hJQUNoK05WL3V3cVRncXlBY3dE?=
 =?utf-8?B?aHNyZXhDak5ncDVEZVk0WStsVk43MTB1RitqK3dZSnorSXBOaVVvNFVIYyta?=
 =?utf-8?B?NFRIQmNaMk1MSUJiajN3cGFjM1JNS3pPdUt4MWE1MkFNLzlkWG1OMjQrc1Nr?=
 =?utf-8?B?V2FKVzdRaW02R3lSS3pINVpiVGZPYWNmVGJkcVRhYzVGVmJzN3R1ZWs4TTMz?=
 =?utf-8?B?bjlrakVMUFhyeWMrUytaSWNFTk9FbXU1TmgwbUJVS0ZlODROUXQ0eGlJRXh5?=
 =?utf-8?B?YnNuSENRZnhYQzZLRmhDYUpJNlgxaHJFSkIrTi9ZVWFiOUp2N1pEMlRBZVFG?=
 =?utf-8?B?STJTc3p0b3JyNG15dGJNWHRhWGdmYStZMktralNweUpiN2p0REd2Q1dWckNH?=
 =?utf-8?B?MXlZSHRSOG01V0tIWU9vckhlYUZ3cHQ1TG9JNTRnN0hvL3F4THhtVzV6OS9Y?=
 =?utf-8?B?UVIrNU5GMFdGZnFwWG4yTzYxc09SVDdzejd4dDlSTnBpbmtERFVwWTdJMVd2?=
 =?utf-8?B?R2FJblJnM1VoN014aFhyN0NEaUpzc1pDT2VOQW41RnlKc0NudVlMakltUWJV?=
 =?utf-8?B?eTNNUGVuak5tOUdvaStET1VTSUZEU1JrYWQ5RU1oZU85MFRBbENBQVd2d3Fz?=
 =?utf-8?B?L2RrcnJ0QWI4SWhSaHM3a1BuOVQxazliNnI2eFl6dTZDd2ZlYTRTZVpiWGJ1?=
 =?utf-8?B?UTNJQkNhZnVwbTBUdlZid3o4MlZ3WE9XRW02c0ZnNzhnd3VjYXNENm5RdHJE?=
 =?utf-8?B?bGtDOHhBdzFqa3RIVTYxbkJXNzVmQ013MFhGNXFwRWkyOWVDR014SVpjajlU?=
 =?utf-8?B?bUlpemdmajZ1NUFGdGFkb0daMEVnaFpBQ0draFlRZ3pmWjdMVzc2MHlHcWJC?=
 =?utf-8?Q?v3xrTnPlesh+RarpbQIcwrqW1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F79CC5A3A074ED438AB336287AADF85B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1486b509-af7f-4828-b0e5-08dd6ab242bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:00:01.2977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHhTbiZV4zf7NFyHRY6ns9gQpMIWRxKxJQ5fEfdmaMCA/rL8y+/IFuaSiMebkkT4G8gqh5j5m2lTB/95zKUWBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7477

T24gRnJpLCAyMDI1LTAzLTIxIGF0IDE3OjMzICswODAwLCBwYXVsLXBsLmNoZW4gd3JvdGU6DQo+
IEZyb206IE5hbmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gDQo+IE9VVFBST0Mg
aGFuZGxlcyB0aGUgcG9zdC1zdGFnZSBvZiBwaXhlbCBwcm9jZXNzaW5nIGluDQo+IHRoZSBvdmVy
bGFwcGluZyBwcm9jZWR1cmUuT1VUUFJPQyBtYW5hZ2VzIHBpeGVscyBmb3INCj4gZ2FtbWEgY29y
cmVjdGlvbiBhbmQgZW5zdXJlcyB0aGF0IHBpeGVsIHZhbHVlcyBhcmUNCj4gd2l0aGluIHRoZSBj
b3JyZWN0IHJhbmdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmFuY3kgTGluIDxuYW5jeS5saW5A
bWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYXVsLXBsIENoZW4gPHBhdWwtcGwuY2hl
bkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX291dHByb2MuYyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9vdXRwcm9jLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5hN2M2ZDE5ODJiY2ENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3V0cHJvYy5jDQo+IEBAIC0wLDAgKzEs
MjQyIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ICsv
Kg0KPiArICogQ29weXJpZ2h0IChjKSAyMDI1IE1lZGlhVGVrIEluYy4NCj4gKyAqLw0KPiArDQo+
ICsjaW5jbHVkZSA8ZHJtL2RybV9mb3VyY2MuaD4NCj4gKyNpbmNsdWRlIDxkcm0vZHJtX2ZyYW1l
YnVmZmVyLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ICsjaW5jbHVkZSA8bGludXgv
Y29tcG9uZW50Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gKyNpbmNsdWRlIDxsaW51
eC9vZl9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQu
aD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaD4NCj4gKyNpbmNs
dWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmg+DQo+ICsNCj4gKyNpbmNsdWRlICJt
dGtfY3J0Yy5oIg0KPiArI2luY2x1ZGUgIm10a19kZHBfY29tcC5oIg0KPiArI2luY2x1ZGUgIm10
a19kcm1fZHJ2LmgiDQoNCkFscGhhYmV0aWMgb3JkZXIuDQoNCj4gKyNpbmNsdWRlICJtdGtfZGlz
cF9vdXRwcm9jLmgiDQo+ICsNCj4gKyNkZWZpbmUgRElTUF9SRUdfT1ZMX09VVFBST0NfSU5URU4J
CQkJMHgwMDQNCj4gKyNkZWZpbmUgT1ZMX09VVFBST0NfRk1FX0NQTF9JTlRFTgkJCQkJQklUKDEp
DQo+ICsjZGVmaW5lIERJU1BfUkVHX09WTF9PVVRQUk9DX0lOVFNUQQkJCQkweDAwOA0KPiArI2Rl
ZmluZSBESVNQX1JFR19PVkxfT1VUUFJPQ19EQVRBUEFUSF9DT04JCQkweDAxMA0KPiArI2RlZmlu
ZSBPVkxfT1VUUFJPQ19EQVRBUEFUSF9DT05fT1VUUFVUX0NMQU1QCQkJCUJJVCgyNikNCj4gKw0K
PiArI2RlZmluZSBESVNQX1JFR19PVkxfT1VUUFJPQ19FTgkJCQkJMHgwMjANCj4gKyNkZWZpbmUg
T1ZMX09VVFBST0NfT1ZMX0VOCQkJCQkJQklUKDApDQo+ICsjZGVmaW5lIERJU1BfUkVHX09WTF9P
VVRQUk9DX1JTVAkJCQkweDAyNA0KPiArI2RlZmluZSBPVkxfT1VUUFJPQ19SU1QJCQkJCQkJQklU
KDApDQo+ICsjZGVmaW5lIERJU1BfUkVHX09WTF9PVVRQUk9DX1NIQURPV19DVFJMCQkJMHgwMjgN
Cj4gKyNkZWZpbmUgT1ZMX09VVFBST0NfQllQQVNTX1NIQURPVwkJCQkJQklUKDIpDQo+ICsjZGVm
aW5lIERJU1BfUkVHX09WTF9PVVRQUk9DX1JPSV9TSVpFCQkJCTB4MDMwDQo+ICsNCj4gK3N0cnVj
dCBtdGtfZGlzcF9vdXRwcm9jIHsNCj4gKwl2b2lkIF9faW9tZW0JCSpyZWdzOw0KPiArCXN0cnVj
dCBjbGsJCSpjbGs7DQo+ICsJdm9pZAkJCSgqdmJsYW5rX2NiKSh2b2lkICpkYXRhKTsNCj4gKwl2
b2lkCQkJKnZibGFua19jYl9kYXRhOw0KPiArCWludAkJCWlycTsNCj4gKwlzdHJ1Y3QgY21kcV9j
bGllbnRfcmVnCWNtZHFfcmVnOw0KPiArfTsNCj4gKw0KPiArdm9pZCBtdGtfZGlzcF9vdXRwcm9j
X3JlZ2lzdGVyX3ZibGFua19jYihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICsJCQkJCSB2b2lkICgq
dmJsYW5rX2NiKSh2b2lkICopLA0KPiArCQkJCQkgdm9pZCAqdmJsYW5rX2NiX2RhdGEpDQo+ICt7
DQo+ICsJc3RydWN0IG10a19kaXNwX291dHByb2MgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4gKw0KPiArCXByaXYtPnZibGFua19jYiA9IHZibGFua19jYjsNCj4gKwlwcml2LT52Ymxh
bmtfY2JfZGF0YSA9IHZibGFua19jYl9kYXRhOw0KPiArfQ0KPiArDQo+ICt2b2lkIG10a19kaXNw
X291dHByb2NfdW5yZWdpc3Rlcl92YmxhbmtfY2Ioc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0K
PiArCXN0cnVjdCBtdGtfZGlzcF9vdXRwcm9jICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+ICsNCj4gKwlwcml2LT52YmxhbmtfY2IgPSBOVUxMOw0KPiArCXByaXYtPnZibGFua19jYl9k
YXRhID0gTlVMTDsNCj4gK30NCj4gKw0KPiArdm9pZCBtdGtfZGlzcF9vdXRwcm9jX2VuYWJsZV92
Ymxhbmsoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZGlzcF9vdXRw
cm9jICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwl3cml0ZWwoT1ZMX09V
VFBST0NfRk1FX0NQTF9JTlRFTiwgcHJpdi0+cmVncyArIERJU1BfUkVHX09WTF9PVVRQUk9DX0lO
VEVOKTsNCj4gK30NCj4gKw0KPiArdm9pZCBtdGtfZGlzcF9vdXRwcm9jX2Rpc2FibGVfdmJsYW5r
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2Rpc3Bfb3V0cHJvYyAq
cHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJd3JpdGVsKDB4MCwgcHJpdi0+
cmVncyArIERJU1BfUkVHX09WTF9PVVRQUk9DX0lOVEVOKTsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IGlycXJldHVybl90IG10a19kaXNwX291dHByb2NfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAq
ZGV2X2lkKQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZGlzcF9vdXRwcm9jICpwcml2ID0gZGV2X2lk
Ow0KPiArCXUzMiB2YWw7DQo+ICsNCj4gKwl2YWwgPSByZWFkbChwcml2LT5yZWdzICsgRElTUF9S
RUdfT1ZMX09VVFBST0NfSU5UU1RBKTsNCj4gKwlpZiAoIXZhbCkNCj4gKwkJcmV0dXJuIElSUV9O
T05FOw0KPiArDQo+ICsJd3JpdGVsKDB4MCwgcHJpdi0+cmVncyArIERJU1BfUkVHX09WTF9PVVRQ
Uk9DX0lOVFNUQSk7DQo+ICsNCj4gKwlpZiAocHJpdi0+dmJsYW5rX2NiKQ0KPiArCQlwcml2LT52
YmxhbmtfY2IocHJpdi0+dmJsYW5rX2NiX2RhdGEpOw0KPiArDQo+ICsJcmV0dXJuIElSUV9IQU5E
TEVEOw0KPiArfQ0KPiArDQo+ICt2b2lkIG10a19kaXNwX291dHByb2NfY29uZmlnKHN0cnVjdCBk
ZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ICsJCQkgICAgIHVuc2lnbmVkIGludCBoLCB1
bnNpZ25lZCBpbnQgdnJlZnJlc2gsDQo+ICsJCQkgICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVj
dCBjbWRxX3BrdCAqY21kcV9wa3QpDQo+ICt7DQo+ICsJc3RydWN0IG10a19kaXNwX291dHByb2Mg
KnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArCWRldl9kYmcoZGV2LCAiJXMt
dzolZCwgaDolZFxuIiwgX19mdW5jX18sIHcsIGgpOw0KPiArDQo+ICsJLy9tb3ZlIG10a19kZHBf
d3JpdGVfbWFzayB0byBtdGtfZGRwX3dyaXRlDQoNCkkgdGhpbmsgdGhpcyBjb21tZW50IGlzIHJl
ZHVuZGFudC4NCg0KPiArCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIGggPDwgMTYgfCB3LCAmcHJp
di0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+ICsJCSAgICAgIERJU1BfUkVHX09WTF9PVVRQUk9D
X1JPSV9TSVpFKTsNCj4gKwltdGtfZGRwX3dyaXRlX21hc2soY21kcV9wa3QsIE9WTF9PVVRQUk9D
X0RBVEFQQVRIX0NPTl9PVVRQVVRfQ0xBTVAsDQo+ICsJCQkgICAmcHJpdi0+Y21kcV9yZWcsIHBy
aXYtPnJlZ3MsDQo+ICsJCQkgICBESVNQX1JFR19PVkxfT1VUUFJPQ19EQVRBUEFUSF9DT04sDQo+
ICsJCQkgICBPVkxfT1VUUFJPQ19EQVRBUEFUSF9DT05fT1VUUFVUX0NMQU1QKTsNCj4gK30NCj4g
Kw0KPiArdm9pZCBtdGtfZGlzcF9vdXRwcm9jX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
K3sNCj4gKwlzdHJ1Y3QgbXRrX2Rpc3Bfb3V0cHJvYyAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShk
ZXYpOw0KPiArCXVuc2lnbmVkIGludCB0bXA7DQo+ICsNCj4gKwl0bXAgPSByZWFkbChwcml2LT5y
ZWdzICsgRElTUF9SRUdfT1ZMX09VVFBST0NfU0hBRE9XX0NUUkwpOw0KPiArCXRtcCA9IHRtcCB8
IE9WTF9PVVRQUk9DX0JZUEFTU19TSEFET1c7DQo+ICsJd3JpdGVsKHRtcCwgcHJpdi0+cmVncyAr
IERJU1BfUkVHX09WTF9PVVRQUk9DX1NIQURPV19DVFJMKTsNCj4gKw0KPiArCW10a19kZHBfd3Jp
dGUoTlVMTCwgMCwgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5yZWdzLA0KPiArCQkgICAgICBESVNQ
X1JFR19PVkxfT1VUUFJPQ19JTlRTVEEpOw0KPiArCW10a19kZHBfd3JpdGVfbWFzayhOVUxMLCBP
VkxfT1VUUFJPQ19PVkxfRU4sICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywNCj4gKwkJCSAg
IERJU1BfUkVHX09WTF9PVVRQUk9DX0VOLCBPVkxfT1VUUFJPQ19PVkxfRU4pOw0KDQpVc2UgcmVh
ZGwoKSBhbmQgd3JpdGVsKCkuDQoNCj4gK30NCj4gKw0KPiArdm9pZCBtdGtfZGlzcF9vdXRwcm9j
X3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZGlzcF9vdXRw
cm9jICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwltdGtfZGRwX3dyaXRl
X21hc2soTlVMTCwgMCwgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5yZWdzLA0KPiArCQkJICAgRElT
UF9SRUdfT1ZMX09VVFBST0NfRU4sIE9WTF9PVVRQUk9DX09WTF9FTik7DQo+ICsJbXRrX2RkcF93
cml0ZV9tYXNrKE5VTEwsIE9WTF9PVVRQUk9DX1JTVCwgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5y
ZWdzLA0KPiArCQkJICAgRElTUF9SRUdfT1ZMX09VVFBST0NfUlNULCBPVkxfT1VUUFJPQ19SU1Qp
Ow0KPiArCW10a19kZHBfd3JpdGVfbWFzayhOVUxMLCAwLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYt
PnJlZ3MsDQo+ICsJCQkgICBESVNQX1JFR19PVkxfT1VUUFJPQ19SU1QsIE9WTF9PVVRQUk9DX1JT
VCk7DQoNClVzZSByZWFkbCgpIGFuZCB3cml0ZWwoKS4NCg0KPiArfQ0KPiArDQo+ICsNCg0KDQoN
Cg==

