Return-Path: <linux-kernel+bounces-338182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05D898546D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6063A1F21577
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1F157A72;
	Wed, 25 Sep 2024 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cq/QIP2e";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FjDPU/qX"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5A148FF5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250371; cv=fail; b=MFbaXRFy8nHQsN7Dhh+ocfrI4nvFiX0LOUFKJgjNcANPeVnglN++szKneKZcSsJlRdNbFrr3DmZ0cgSiZnKJJAgaQRxt0sWQl2fyj2z0uc4Ia+mbPAQ3JcDEFtMlqAvLYJpBXAEQWh+HU6nCZM/QVS2HwxCp7WWN2+B3HVIQ9fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250371; c=relaxed/simple;
	bh=vWDesisJ06HBZknIaxTCxCsmi1+mtLu0v3LIqpAEnS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G7+ipB/n4owR1vzQtP8NoGdf5eyibzgZXVvjEyCgdsm8M2YpUW/TrakEF16IWoKpNR5vCoRmo7ttARE+FtHmP+ntlZMtlSvOP3Rz6Jar/QKO3XZ/XrNWf9plqj5zvIAY3One5s2wEe3FiLXfdyKD7SYaJR3Z708ejzrXUaXF1RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cq/QIP2e; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=FjDPU/qX; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3770fb9c7b1211efb66947d174671e26-20240925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vWDesisJ06HBZknIaxTCxCsmi1+mtLu0v3LIqpAEnS8=;
	b=cq/QIP2eJIu8YyzXsd6BgKPEcEGz0t7lrcdJsYYjNu0JHilFZyh6aPuuCqk92UuJkkMztYQW2aG0Xn1qy1ltQotTZdJlLTuacKHZIIha5ephn0lzeFW6BAV8aNVy3/6n1iLoNg+v6WNx7BXVyrBsfNSO7gLY9ncy8t+oWfT+gis=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:5b966414-a569-40de-a4fd-0a03ff2a54f5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:23413918-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 3770fb9c7b1211efb66947d174671e26-20240925
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1560282644; Wed, 25 Sep 2024 15:46:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Sep 2024 15:46:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Sep 2024 15:46:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4jkk7h37B/NJKQ+vQKLJr9lGqI0Osd/jpPkARwKaPNEG7zMcCyKA0tyGYeeHGF88T2y3UUWUcO8dG/AsqtmY9rrmVoynkiLHeoFKlJOlXnYMYpmG6RMr8jHmwKPNmbLD/dxU+xqtxdUKoYdZWaVKaTvl9f6eCJt1ayhYL+ld3Rj+yX16hcVRy6XS9NVlmJl6waRYhDHlBTjhDCUdBuU/WOr4UnP43bkXziO5SXAI7a5FELUtABy9HNQlaFiaD9o3mCGwJkrCCwwLWHOAW0u9IrQb8GhJi091AogVKgt1GMaRSE+wPzKaXmjlQBCw1cJHYHNpPk9uLPDVysxNlv/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWDesisJ06HBZknIaxTCxCsmi1+mtLu0v3LIqpAEnS8=;
 b=q+/dqysuJN8jWeqVC8IHhZV1a7SLjQyfwMRfNrBxvQsYHBeQl3h+uB7oTrPmzUzPvhIi2ixAqOH5j9hhqTiaAgSMJF/WKGw30xpWLeNiJ4d1uKPVEe48jZyqxySaIBuNRq+enGD6vIb/LGEfyZgVcdGj1afIGT7jBqeQbP9+1P2yw41P1em5XiTr4+7oP9ie3kKuiIicE2ICMt3v9wKUVqqKm6pHDiU9mJ7X5tc221iAeOcaHLQ85CUVA0AuHotNZaHkbzX7XV36npS7zWOUgjwR71U/qFuLD9FtBEWvBy4BwtdxzKoY8XnP+YEansQ4lA2r5CTjpYD6DtrOjJ1osA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWDesisJ06HBZknIaxTCxCsmi1+mtLu0v3LIqpAEnS8=;
 b=FjDPU/qXJx0ZjRDI0qlAudFMnOLheqIYwQqRRltZWbt6gvzEtloB9QwY3aanHgDKq0uzmWNuorq1JoiQURxwW38HHEblBjE8bATTfX4QE+kHgZkgt+uBFRS1pyrPdvkaGZTlq00Lqy8z4pc1z9x2hCXut/n9RpatjaJl5rJpGKY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7055.apcprd03.prod.outlook.com (2603:1096:820:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 07:45:57 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 07:45:57 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4] drm/mediatek: ovl: Add fmt_convert function pointer to
 driver data
Thread-Topic: [PATCH v4] drm/mediatek: ovl: Add fmt_convert function pointer
 to driver data
Thread-Index: AQHbDiZADu+h/1RhSEWOygs8W4BgkLJoIZwA
Date: Wed, 25 Sep 2024 07:45:57 +0000
Message-ID: <dbb2722698d3b36100f0ed2bfeec92441cd4ef45.camel@mediatek.com>
References: <20240924014935.23677-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20240924014935.23677-1-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7055:EE_
x-ms-office365-filtering-correlation-id: 2c93c875-e60c-4d83-2439-08dcdd36177d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SDBTSWRwaE9uWUdLM2dsTi9tUHNOZys5azFIcEpQK0ptdE5KVVlreWZaRmpv?=
 =?utf-8?B?SWhYY0xXb3BJbU4zdkJPRDNoM3lzc1pYcHRRRWFyaTQ4bDNCSFdBMkVZb2t4?=
 =?utf-8?B?RHJ0ODNwYjB5VFpzMml5UTBHR0xDZG1WaWtYNmgxNDRlakQzcDZBZUxZeEkr?=
 =?utf-8?B?alFwTXAvZW9XWGoza3d4NWlId0NmYXRGeUZSVHZ1VTBxdysxbVFpNG9hQjhX?=
 =?utf-8?B?M2VYc09GTVhmWU5pQ0hXdXpSd0NtcW85R3Z0RVRVU1RxRkUvTFJVMmdrT05G?=
 =?utf-8?B?QjhjYkczV2x4Q0pxaU9GQ1ZwVWlWY2ViMWEzWUMyWWlUdVdaaUpGU1BkQzZK?=
 =?utf-8?B?UzFkTHhsWUgwWlBNM3JGWFZpL2ZFK2hCZVd0WXdvLytkOEI0SFJDSWhsc3px?=
 =?utf-8?B?dUJUQTU3NEZaTks2L0UxSmdNMGk4QndzeTF1cEZyK1dGTElSbmZHd1hJNnZn?=
 =?utf-8?B?Qml4ZlVBTEtPclJxVXR4VDhJcGZ1bHdYczNKMEUvNStJcVJ4U2hJUGVydWE1?=
 =?utf-8?B?ejd2b1JvckpkMGxVYks0Q1V1dWFUL2kvNEtpR1JoalRlbGJmbU1QVUs0K3dQ?=
 =?utf-8?B?MDR0Q3IvTzF1eWJlcXZpcjVyamN5bXI4bzF5RlBzM3RHN0Y5NmpFZFMrL21k?=
 =?utf-8?B?SmhJZFZqaHV5Rk51eS9OUk00eDlZZzQrb0UrRTRsV3p5anVSWFF4K0xmQVgv?=
 =?utf-8?B?Y0U0akl3YjVvRmFqVDM5ZllkYzduR3V1bGgyLzEzeWFUSWsrNmJYWFRmWk1F?=
 =?utf-8?B?TExvWEFrdndsdDF0NzNtWmg5N0RvSWNVMzBpN3FuUmZ2Q3djRmVUbStkMXp6?=
 =?utf-8?B?ZjkrRUEzTWw1MUY2TkIrUitZUVFaSjJmNFR6WmlTYnNZZnNEay9wTHREQnhs?=
 =?utf-8?B?eXAxODF4U1NKOVE5TFJjNnRCNTlSd0hiY3RPOWtqSHZSZHQvUTIwNVNHQzVD?=
 =?utf-8?B?NHlXbGtqMWpTejVYaUdFNlhjNStqWVlHVW9ld2hDSkt0MFcrRlBSajBERTFD?=
 =?utf-8?B?TVdSYWRwU0pwcmcyTzZWS3JJMm9ObkYxN3pGRUh0S1RLd0VIZE5GdFRHQ2U3?=
 =?utf-8?B?cnA2S1BObWtYVzFZaXY2QVFwVXd2NlVFWWRHUUhva01CamZPR2g1Q0ltYnA4?=
 =?utf-8?B?VXlYdWRObGFBRDBTVUZyV2dHeUlMdnpuZzdnSHBYeHp3bFJnUjBGSzNaZ0Vx?=
 =?utf-8?B?SENXUG1DbzJxQmZYWlcxWVVrb1hya1kyMUVVcXVMd1UrZ1hZQ0toWWZpV0Vo?=
 =?utf-8?B?NDM2VnV3dFFYQ2Q4SjlqeG9rTVdlTzAxOXJPd1EzaHY0NDRHQ3NJN0FNOGZs?=
 =?utf-8?B?L1YxajNxNE90aGVMRUJnYm9TdUp5N0ZBQ0xNVTNsbXNHM2t3elAvcHlueUpE?=
 =?utf-8?B?WVMwam1mVFU4S3NSQm1FMGxyR21iU1VESXkrMHRENTgyMUk0TlBCdTk0c1VJ?=
 =?utf-8?B?NEpWb29RU0toRDBWZngrMlJzaDVrd0tsbUpremZYcjZIb1Y3V3gxd1lEUzdi?=
 =?utf-8?B?R3FIdmVqSnRTYnN6U01USFFDekU1MGZGSXI1a0ZRYUhQQmdTQUpGS1lzaFF5?=
 =?utf-8?B?eC9JUlRoUDJZSEwzMEsvRjVycHAweStLb2F3QlFweTRQNFc5OHZzZGF1SzJK?=
 =?utf-8?B?SllsTkFoWGRLTkpDem1VZVozTWVTWk5hTHZJajVBWjIrbmVLYU84VWdDSFcw?=
 =?utf-8?B?aHF3MTJETmVqYWxuYzMvSDBkTUVhMHRKTVJ6SVZOcnVYREJMUldFVlkxRk9G?=
 =?utf-8?B?a1VZYmFWNTlXMmRpc3JHOGFVdjZOUVdPNGFYcG5hK2dSL3JYNkhFYVFpR1hQ?=
 =?utf-8?B?SU5TMWlWR2wzSXdVSGRDZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjZ2WnhjQ05nWE1qREEvV29Hd0xhM0ZtemJ2YVhYUVBKMWJ4cXlwdWVlaEdv?=
 =?utf-8?B?a01UVFRGMjlCSHRReGJuQWpMczB3R3Fwdi9HaDQ5Y2w2SGM5endTMStrRjYx?=
 =?utf-8?B?MHdNZ21yQXNQUXdTeGhsWDAzU0syUzIzVXhNaFFIZ2NxcHZVU2t2QlRXQ2Rn?=
 =?utf-8?B?ZUVVejcwTlRqN2QrUWZEMmZCTDdvUE1WalYyOVViVzFMY01sRnVweHVPWmNj?=
 =?utf-8?B?TmVTMXB1TnE2U3MxUEtMKzFDTW1uS1lmekhYTUNvejVwR0JnVGg3OW1jKzZ5?=
 =?utf-8?B?aC96MFJvNlV2MkxLTWcvMTNHcklWTFZCdUVEeUNLMzZVRTVhSW50OGlsQXlk?=
 =?utf-8?B?eGdDZ3ZHUkFQMmNMMTdtbXh1SWM1Ui9YM2VveHBNQTV4RWxXK2NPeVNWUk1V?=
 =?utf-8?B?bzZpREtuODF0ZVplYXdsS3E3VVNRMUs3YSttREZpZnRwc0NDOGhmbTE5b0do?=
 =?utf-8?B?enRVNm9FVlFzczFpRFFrOHJDeWdCdUEwYlhMSTNlbkRhM1RmYmVzTnczUm1M?=
 =?utf-8?B?MEt5ZW9EZEJBekR5aTF1V2dIcjQreXNNOUd6OTZpSG1JWHUra2pVeUZ0TE1t?=
 =?utf-8?B?ZSt3dlZBSDl3M2Z2V3RQNlBSUjdpTDhoZW9zVGl1THNyYWUzZkpvSVdzVXNL?=
 =?utf-8?B?QTd5UmhnVjlZREpjVHc3a1pWWE1pbVdaSmRGcFBzeCtHamRzQ0VoL0greFBy?=
 =?utf-8?B?Q2VwYVZtYlhHZzVLdko2d1ROMTlISkRxYm5CdU9ITTdNVW5BTlFpTlhNRENV?=
 =?utf-8?B?SnRUTnV6N0VrRll1ZzViWkx5MjhIVm5aRWpjTDV6SWRGWXlra1JPOSswNVAv?=
 =?utf-8?B?ZE9Vd215OXJRclRlQVo5RDRPaEIrc1ZYM0t1VVVOUko4TW8yUDlsa3BuQVdv?=
 =?utf-8?B?N0RvQmI5a1d5V2Z2bHVCaW92NGM0amFrV1hFc1p3SzVyR3VUQkhwdllqQW50?=
 =?utf-8?B?VE9mNmRJd3RCSTlaeXcvclcyd0cwUlNCNlRKLzZZcUE0Zzdpay8rZTQrdmRa?=
 =?utf-8?B?Ym1qL1JhNGNocEhIZkpEbDdwMUZJRklOMG13cGVlUlRiNGpPd2RrcTN0b002?=
 =?utf-8?B?c2RoSXFKWU9JUXl2K0hMaUlZcHdsaWI0MGZlTUVsOHpTVDBTdnVPQXlJbUJH?=
 =?utf-8?B?ZHVWbmNzWk1id29PNzlJUExGcDRlcUltdmZtcmU4dFcrRFFKV21EdjNFbXU1?=
 =?utf-8?B?QUZZYXIyT0VEaTNSVGNPbWN1WUY1dVVkNUxIMk5GcmNMTkxlMGhIYVdRbU53?=
 =?utf-8?B?Wmp6SmtHNVJtSTg4Z1hZMGNhdzY1NFZFdGZKS1hQNG9NTnROeklFSnBUOWdn?=
 =?utf-8?B?MXduZ2hhSzJLY0lWeVpieFNaS0ErOXlsSW94YUNGMHJaNTcyd2FUWHcvcjNH?=
 =?utf-8?B?dTdWMzdlUnhVWU5EVEdhNnJFKzVRUmMzMmFxVDN0T1RoUk9WamRCUDhuZ1Az?=
 =?utf-8?B?ekIzV21UdHFCNzcvU2F0THB5S0RtaE00Y3YyQjI4WHdONlVkcEVsK3hzL3Rs?=
 =?utf-8?B?cFZrUUxnaStwSm54Yk45MTd6MXFER0lRVHFNa1lpTnVnb2hMclVvQzRXRExL?=
 =?utf-8?B?U2xFR3N6SWx0VjdBcFRMTEpuOEFtakVKOUZEcTNVenhWdmtpVWVTM0ZEc3Vs?=
 =?utf-8?B?Y0Y0SmlDRFY1UTJpNTFjc3VXOHM1ampmSDJ6N3pXTzFjUVY4WUExQVIwT2J3?=
 =?utf-8?B?RlFxNkFTUUMvMFdER2JtWGFiZDBtNDFJbTNQN3lVZllwTjBic1JPSTlLQTJE?=
 =?utf-8?B?MTVpODM4MVlGNkU0a29oT1hKaE95WWJMNzYvb3YvV1B0aXhxdVJsRi80aits?=
 =?utf-8?B?UG44L3hYTU9lUzhIVzNDMUNxRnhEREpYdkhqRG9Od3YwK1M3NFZxNXBzcmpm?=
 =?utf-8?B?VVh2MFZYajZrM3Vyc0E1ejhBdk1iSGJ5bXZzWEFsNXloY0w3VnFRbkFlcEZM?=
 =?utf-8?B?L1lyaEowMlZFSDVaRURFM0R6VmtZZFk4YlQwaXY3bmFOcXFWQmpnNVMxem16?=
 =?utf-8?B?YndqVkhmakxvU29vLzVDSWcrc1dsV2ZsTXQvNE5ScVU2RlAwZ3pSUFB1RnB2?=
 =?utf-8?B?RllQaWJhNTRDbityYmRVYkdaSi8vT1VKa1AyeERYWnREQzN6WTJyc05MUmh2?=
 =?utf-8?Q?nD5dtieMuvQW8P9dPS40Iwi7V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5738D4B7BB24241AC6FFCE8E012B4FC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c93c875-e60c-4d83-2439-08dcdd36177d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 07:45:57.1687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fwo9w668ExRIIZkeqhsb9LDQ157Zrcc1NGucjYxzae4Ueh9H7litr0RR+xIAzNcwQzwwinpX1ZV0Vt4BTOqhUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7055
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.791300-8.000000
X-TMASE-MatchedRID: UuaOI1zLN1gOwH4pD14DsPHkpkyUphL91KoSW5Ji1XuPaLJ/Ca3STwA0
	TKIn6AX5uyk/HuTVlgpGKo6edwW+zDW+K/PcvqBrydRN/Yyg4pi4vBuE2X0HlRae5J4l8aLzFMG
	Ir5XP/ILi7e+xoz/MyNwoW4czCXsPZB7FaQ6KQ98ZXJLztZviXABrY6dyM/UbjlFfNjQx+ALXx4
	pOugOe3PrGeN8vaK/886y/Y5TghwEYBLhRVmu+Nu7KTDtx8CggtjHGWON8yePANHjiWWI+7QyFB
	aXNUMBVUWPX+4dl8pItZ0CLG0Vuhkibx2WCCMTIRnmgWPGIUuPmELBDcs0dnQTozVi1xfq83k1H
	MnSDPkfW423XW2hpe2zlLAWyLHZTQv21zJNl0CyDGx/OQ1GV8rHlqZYrZqdI+gtHj7OwNO3DW0x
	VTs41PAcYdj2jHcJMZbQODmLa4YCm0vAoSrjGFJN0aHfhY/dw
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.791300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4650C2CD08691A953FF62B5C7ABA5C034F6773A03A9C47CAEAE9D9D8C00DE8882000:8

SGksIEphc29uOg0KDQpPbiBUdWUsIDIwMjQtMDktMjQgYXQgMDk6NDkgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gT1ZMX0NPTl9DTFJGTVRfTUFOIGlzIGEgY29uZmlndXJhdGlvbiBmb3Ig
ZXh0ZW5kaW5nIGNvbG9yIGZvcm1hdA0KPiBzZXR0aW5ncyBvZiBESVNQX1JFR19PVkxfQ09OKG4p
Lg0KPiBJdCB3aWxsIGNoYW5nZSBzb21lIG9mIHRoZSBvcmlnaW5hbCBjb2xvciBmb3JtYXQgc2V0
dGluZ3MuDQo+IA0KPiBUYWtlIHRoZSBzZXR0aW5ncyBvZiAoMyA8PCAxMikgZm9yIGV4YW1wbGUu
DQo+IC0gSWYgT1ZMX0NPTl9DTFJGTVRfTUFOID0gMCBtZWFucyBPVkxfQ09OX0NMUkZNVF9SR0JB
ODg4OC4NCj4gLSBJZiBPVkxfQ09OX0NMUkZNVF9NQU4gPSAxIG1lYW5zIE9WTF9DT05fQ0xSRk1U
X1BBUkdCODg4OC4NCj4gDQo+IFNpbmNlIE9WTF9DT05fQ0xSRk1UX01BTiBpcyBub3Qgc3VwcG9y
dGVkIG9uIHByZXZpb3VzIFNvQ3MsDQo+IEl0IGJyZWFrcyB0aGUgT1ZMIGNvbG9yIGZvcm1hdCBz
ZXR0aW5nIG9mIE1UODE3My4NCj4gDQo+IFRoZXJlZm9yZSwgdGhlIGZtdF9jb252ZXJ0IGZ1bmN0
aW9uIHBvaW50ZXIgaXMgYWRkZWQgdG8gdGhlIGRyaXZlciBkYXRhDQo+IGFuZCBtdGtfb3ZsX2Zt
dF9jb252ZXJ0X3dpdGhfYmxlbmQgaXMgaW1wbGVtZW50ZWQgZm9yIE1UODE5MiBhbmQgTVQ4MTk1
DQo+IHRoYXQgc3VwcG9ydCBPVkxfQ09OX0NMUkZNVF9NQU4sIGFuZCBtdGtfb3ZsX2ZtdF9jb252
ZXJ0IGlzIGltcGxlbWVudGVkDQo+IGZvciBvdGhlciBTb0NzIHRoYXQgZG8gbm90IHN1cHBvcnQg
aXQgdG8gc29sdmUgdGhlIGRlZ3JhZGF0aW9uIHByb2JsZW0uDQoNClRoaXMgcGF0Y2ggbG9va3Mg
Z29vZCB0byBtZSwgc28NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+
DQoNCkJ5IHRoaXMgcGF0Y2gsIG9ubHkgc29tZSBTb0Mgc3VwcG9ydCBwcmUtbXVsdGlwbGllZCBw
aXhlbCBmb3JtYXQuDQpJbiBbMV0sIGl0IGRlY2xhcmUgdGhhdCBhbGwgU29DIHN1cHBvcnQgcHJl
LW11bHRpcGxpZWQgcGl4ZWwgZm9ybWF0LCBzbyBJIHRoaW5rIG5lZWQgYW5vdGhlciBwYXRjaCB0
byBsZXQgb25seSBzb21lIFNvQyBzdXBwb3J0IHByZS1tdWx0aXBsaWVkLg0KDQpbMV0gaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0
LmdpdC9jb21taXQvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrP2g9bmV4dC0yMDI0MDkyNSZpZD00
MjI1ZDVkNWU3NzliODU5YTY2NjExMzBhMzQ0NGViNGM1ZGI3N2U1DQoNCj4gDQo+IEZpeGVzOiBh
M2Y3ZjdlZjRiZmUgKCJkcm0vbWVkaWF0ZWs6IFN1cHBvcnQgIlByZS1tdWx0aXBsaWVkIiBibGVu
ZGluZyBpbiBPVkwiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxp
bkBtZWRpYXRlay5jb20+DQo+IFRlc3RlZC1ieTogQWxwZXIgTmViaSBZYXNhayA8YWxwZXJuZWJp
eWFzYWtAZ21haWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgfCA2OCArKysrKysrKysrKysr
KysrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4g
aW5kZXggODliNDM5ZGNmM2E2Li44ZjdiN2UwN2FlYjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gQEAgLTE0Myw2ICsxNDMsNyBAQCBzdHJ1Y3QgbXRr
X2Rpc3Bfb3ZsX2RhdGEgew0KPiAgCXVuc2lnbmVkIGludCBhZGRyOw0KPiAgCXVuc2lnbmVkIGlu
dCBnbWNfYml0czsNCj4gIAl1bnNpZ25lZCBpbnQgbGF5ZXJfbnI7DQo+ICsJdW5zaWduZWQgaW50
ICgqZm10X2NvbnZlcnQpKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG10a19wbGFuZV9zdGF0
ZSAqc3RhdGUpOw0KPiAgCWJvb2wgZm10X3JnYjU2NV9pc18wOw0KPiAgCWJvb2wgc21pX2lkX2Vu
Ow0KPiAgCWJvb2wgc3VwcG9ydHNfYWZiYzsNCj4gQEAgLTM4NiwxMyArMzg3LDU5IEBAIHZvaWQg
bXRrX292bF9sYXllcl9vZmYoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0K
PiAgCQkgICAgICBESVNQX1JFR19PVkxfUkRNQV9DVFJMKGlkeCkpOw0KPiAgfQ0KPiAgDQo+IC1z
dGF0aWMgdW5zaWduZWQgaW50IG92bF9mbXRfY29udmVydChzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpv
dmwsIHVuc2lnbmVkIGludCBmbXQsDQo+IC0JCQkJICAgIHVuc2lnbmVkIGludCBibGVuZF9tb2Rl
KQ0KPiArc3RhdGljIHVuc2lnbmVkIGludCBtdGtfb3ZsX2ZtdF9jb252ZXJ0KHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IG10a19wbGFuZV9zdGF0ZSAqc3RhdGUpDQo+ICB7DQo+IC0JLyogVGhl
IHJldHVybiB2YWx1ZSBpbiBzd2l0Y2ggIk1FTV9NT0RFX0lOUFVUX0ZPUk1BVF9YWFgiDQo+IC0J
ICogaXMgZGVmaW5lZCBpbiBtZWRpYXRlayBIVyBkYXRhIHNoZWV0Lg0KPiAtCSAqIFRoZSBhbHBo
YWJldCBvcmRlciBpbiBYWFggaXMgbm8gcmVsYXRpb24gdG8gZGF0YQ0KPiAtCSAqIGFycmFuZ2Vt
ZW50IGluIG1lbW9yeS4NCj4gKwlzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4gKwl1bnNpZ25lZCBpbnQgZm10ID0gc3RhdGUtPnBlbmRpbmcuZm9ybWF0
Ow0KPiArDQo+ICsJc3dpdGNoIChmbXQpIHsNCj4gKwlkZWZhdWx0Og0KPiArCWNhc2UgRFJNX0ZP
Uk1BVF9SR0I1NjU6DQo+ICsJCXJldHVybiBPVkxfQ09OX0NMUkZNVF9SR0I1NjUob3ZsKTsNCj4g
KwljYXNlIERSTV9GT1JNQVRfQkdSNTY1Og0KPiArCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfUkdC
NTY1KG92bCkgfCBPVkxfQ09OX0JZVEVfU1dBUDsNCj4gKwljYXNlIERSTV9GT1JNQVRfUkdCODg4
Og0KPiArCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfUkdCODg4KG92bCk7DQo+ICsJY2FzZSBEUk1f
Rk9STUFUX0JHUjg4ODoNCj4gKwkJcmV0dXJuIE9WTF9DT05fQ0xSRk1UX1JHQjg4OChvdmwpIHwg
T1ZMX0NPTl9CWVRFX1NXQVA7DQo+ICsJY2FzZSBEUk1fRk9STUFUX1JHQlg4ODg4Og0KPiArCWNh
c2UgRFJNX0ZPUk1BVF9SR0JBODg4ODoNCj4gKwljYXNlIERSTV9GT1JNQVRfUkdCWDEwMTAxMDI6
DQo+ICsJY2FzZSBEUk1fRk9STUFUX1JHQkExMDEwMTAyOg0KPiArCQlyZXR1cm4gT1ZMX0NPTl9D
TFJGTVRfUkdCQTg4ODg7DQo+ICsJY2FzZSBEUk1fRk9STUFUX0JHUlg4ODg4Og0KPiArCWNhc2Ug
RFJNX0ZPUk1BVF9CR1JBODg4ODoNCj4gKwljYXNlIERSTV9GT1JNQVRfQkdSWDEwMTAxMDI6DQo+
ICsJY2FzZSBEUk1fRk9STUFUX0JHUkExMDEwMTAyOg0KPiArCQlyZXR1cm4gT1ZMX0NPTl9DTFJG
TVRfQkdSQTg4ODg7DQo+ICsJY2FzZSBEUk1fRk9STUFUX1hSR0I4ODg4Og0KPiArCWNhc2UgRFJN
X0ZPUk1BVF9BUkdCODg4ODoNCj4gKwljYXNlIERSTV9GT1JNQVRfWFJHQjIxMDEwMTA6DQo+ICsJ
Y2FzZSBEUk1fRk9STUFUX0FSR0IyMTAxMDEwOg0KPiArCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRf
QVJHQjg4ODg7DQo+ICsJY2FzZSBEUk1fRk9STUFUX1hCR1I4ODg4Og0KPiArCWNhc2UgRFJNX0ZP
Uk1BVF9BQkdSODg4ODoNCj4gKwljYXNlIERSTV9GT1JNQVRfWEJHUjIxMDEwMTA6DQo+ICsJY2Fz
ZSBEUk1fRk9STUFUX0FCR1IyMTAxMDEwOg0KPiArCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfQUJH
Ujg4ODg7DQo+ICsJY2FzZSBEUk1fRk9STUFUX1VZVlk6DQo+ICsJCXJldHVybiBPVkxfQ09OX0NM
UkZNVF9VWVZZIHwgT1ZMX0NPTl9NVFhfWVVWX1RPX1JHQjsNCj4gKwljYXNlIERSTV9GT1JNQVRf
WVVZVjoNCj4gKwkJcmV0dXJuIE9WTF9DT05fQ0xSRk1UX1lVWVYgfCBPVkxfQ09OX01UWF9ZVVZf
VE9fUkdCOw0KPiArCX0NCj4gK30NCj4gKw0KPiArc3RhdGljIHVuc2lnbmVkIGludCBtdGtfb3Zs
X2ZtdF9jb252ZXJ0X3dpdGhfYmxlbmQoc3RydWN0IGRldmljZSAqZGV2LA0KPiArCQkJCQkJICAg
c3RydWN0IG10a19wbGFuZV9zdGF0ZSAqc3RhdGUpDQo+ICt7DQo+ICsJc3RydWN0IG10a19kaXNw
X292bCAqb3ZsID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsJdW5zaWduZWQgaW50IGZtdCA9
IHN0YXRlLT5wZW5kaW5nLmZvcm1hdDsNCj4gKwl1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSA9IHN0
YXRlLT5iYXNlLnBpeGVsX2JsZW5kX21vZGU7DQo+ICsNCj4gKwkvKg0KPiArCSAqIEZvciB0aGUg
cGxhdGZvcm1zIHdoZXJlIE9WTF9DT05fQ0xSRk1UX01BTiBpcyBkZWZpbmVkIGluIHRoZQ0KPiAr
CSAqIGhhcmR3YXJlIGRhdGEgc2hlZXQgYW5kIHN1cHBvcnRzIHByZW11bHRpcGxpZWQgY29sb3Ig
Zm9ybWF0cw0KPiArCSAqIHN1Y2ggYXMgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4Lg0KPiAgCSAq
Lw0KPiAgCXN3aXRjaCAoZm10KSB7DQo+ICAJZGVmYXVsdDoNCj4gQEAgLTQ3MSw3ICs1MTgsNyBA
QCB2b2lkIG10a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQg
aW50IGlkeCwNCj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gIA0KPiAtCWNvbiA9IG92bF9mbXRfY29u
dmVydChvdmwsIGZtdCwgYmxlbmRfbW9kZSk7DQo+ICsJY29uID0gb3ZsLT5kYXRhLT5mbXRfY29u
dmVydChkZXYsIHN0YXRlKTsNCj4gIAlpZiAoc3RhdGUtPmJhc2UuZmIpIHsNCj4gIAkJY29uIHw9
IE9WTF9DT05fQUVOOw0KPiAgCQljb24gfD0gc3RhdGUtPmJhc2UuYWxwaGEgJiBPVkxfQ09OX0FM
UEhBOw0KPiBAQCAtNjI1LDYgKzY3Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bf
b3ZsX2RhdGEgbXQyNzAxX292bF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuYWRkciA9IERJU1BfUkVH
X09WTF9BRERSX01UMjcwMSwNCj4gIAkuZ21jX2JpdHMgPSA4LA0KPiAgCS5sYXllcl9uciA9IDQs
DQo+ICsJLmZtdF9jb252ZXJ0ID0gbXRrX292bF9mbXRfY29udmVydCwNCj4gIAkuZm10X3JnYjU2
NV9pc18wID0gZmFsc2UsDQo+ICAJLmZvcm1hdHMgPSBtdDgxNzNfZm9ybWF0cywNCj4gIAkubnVt
X2Zvcm1hdHMgPSBBUlJBWV9TSVpFKG10ODE3M19mb3JtYXRzKSwNCj4gQEAgLTYzNCw2ICs2ODIs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX292bF9kYXRhIG10ODE3M19vdmxfZHJp
dmVyX2RhdGEgPSB7DQo+ICAJLmFkZHIgPSBESVNQX1JFR19PVkxfQUREUl9NVDgxNzMsDQo+ICAJ
LmdtY19iaXRzID0gOCwNCj4gIAkubGF5ZXJfbnIgPSA0LA0KPiArCS5mbXRfY29udmVydCA9IG10
a19vdmxfZm10X2NvbnZlcnQsDQo+ICAJLmZtdF9yZ2I1NjVfaXNfMCA9IHRydWUsDQo+ICAJLmZv
cm1hdHMgPSBtdDgxNzNfZm9ybWF0cywNCj4gIAkubnVtX2Zvcm1hdHMgPSBBUlJBWV9TSVpFKG10
ODE3M19mb3JtYXRzKSwNCj4gQEAgLTY0Myw2ICs2OTIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19kaXNwX292bF9kYXRhIG10ODE4M19vdmxfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmFkZHIg
PSBESVNQX1JFR19PVkxfQUREUl9NVDgxNzMsDQo+ICAJLmdtY19iaXRzID0gMTAsDQo+ICAJLmxh
eWVyX25yID0gNCwNCj4gKwkuZm10X2NvbnZlcnQgPSBtdGtfb3ZsX2ZtdF9jb252ZXJ0LA0KPiAg
CS5mbXRfcmdiNTY1X2lzXzAgPSB0cnVlLA0KPiAgCS5mb3JtYXRzID0gbXQ4MTczX2Zvcm1hdHMs
DQo+ICAJLm51bV9mb3JtYXRzID0gQVJSQVlfU0laRShtdDgxNzNfZm9ybWF0cyksDQo+IEBAIC02
NTIsNiArNzAyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YSBtdDgx
ODNfb3ZsXzJsX2RyaXZlcl9kYXRhID0gew0KPiAgCS5hZGRyID0gRElTUF9SRUdfT1ZMX0FERFJf
TVQ4MTczLA0KPiAgCS5nbWNfYml0cyA9IDEwLA0KPiAgCS5sYXllcl9uciA9IDIsDQo+ICsJLmZt
dF9jb252ZXJ0ID0gbXRrX292bF9mbXRfY29udmVydCwNCj4gIAkuZm10X3JnYjU2NV9pc18wID0g
dHJ1ZSwNCj4gIAkuZm9ybWF0cyA9IG10ODE3M19mb3JtYXRzLA0KPiAgCS5udW1fZm9ybWF0cyA9
IEFSUkFZX1NJWkUobXQ4MTczX2Zvcm1hdHMpLA0KPiBAQCAtNjYxLDYgKzcxMiw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4MTkyX292bF9kcml2ZXJfZGF0YSA9
IHsNCj4gIAkuYWRkciA9IERJU1BfUkVHX09WTF9BRERSX01UODE3MywNCj4gIAkuZ21jX2JpdHMg
PSAxMCwNCj4gIAkubGF5ZXJfbnIgPSA0LA0KPiArCS5mbXRfY29udmVydCA9IG10a19vdmxfZm10
X2NvbnZlcnRfd2l0aF9ibGVuZCwNCj4gIAkuZm10X3JnYjU2NV9pc18wID0gdHJ1ZSwNCj4gIAku
c21pX2lkX2VuID0gdHJ1ZSwNCj4gIAkuZm9ybWF0cyA9IG10ODE3M19mb3JtYXRzLA0KPiBAQCAt
NjcxLDYgKzcyMyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4
MTkyX292bF8ybF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuYWRkciA9IERJU1BfUkVHX09WTF9BRERS
X01UODE3MywNCj4gIAkuZ21jX2JpdHMgPSAxMCwNCj4gIAkubGF5ZXJfbnIgPSAyLA0KPiArCS5m
bXRfY29udmVydCA9IG10a19vdmxfZm10X2NvbnZlcnRfd2l0aF9ibGVuZCwNCj4gIAkuZm10X3Jn
YjU2NV9pc18wID0gdHJ1ZSwNCj4gIAkuc21pX2lkX2VuID0gdHJ1ZSwNCj4gIAkuZm9ybWF0cyA9
IG10ODE3M19mb3JtYXRzLA0KPiBAQCAtNjgxLDYgKzczNCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4MTk1X292bF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuYWRk
ciA9IERJU1BfUkVHX09WTF9BRERSX01UODE3MywNCj4gIAkuZ21jX2JpdHMgPSAxMCwNCj4gIAku
bGF5ZXJfbnIgPSA0LA0KPiArCS5mbXRfY29udmVydCA9IG10a19vdmxfZm10X2NvbnZlcnRfd2l0
aF9ibGVuZCwNCj4gIAkuZm10X3JnYjU2NV9pc18wID0gdHJ1ZSwNCj4gIAkuc21pX2lkX2VuID0g
dHJ1ZSwNCj4gIAkuc3VwcG9ydHNfYWZiYyA9IHRydWUsDQo=

