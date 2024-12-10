Return-Path: <linux-kernel+bounces-439061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6ED9EAA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E4E16A885
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7C122CBF4;
	Tue, 10 Dec 2024 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f64P9xvZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="shZRf/cH"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14599172BD5;
	Tue, 10 Dec 2024 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818172; cv=fail; b=a4ds/Pnnro3uTlz6EmBZ7yNRcpf76RfWEXh628HLtpAHPSLrZV+P4NZ3bNrsaVG3SxNcM7q/ewHYGEKhAJIJ7GW/e+u3NS3DtdYm7ewB9unSZlWKTIIq7A9H2cwT+YE1usq7Z6wio+A62PqfqYMuHLhC5Fhar0td31wJNpReP1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818172; c=relaxed/simple;
	bh=xMOExD/YyDJcJj2S5oaTg8saARv53vAb0D+cjkK3GMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pPVuH4ts2tG2yUpvGya8Qm71wHKszbQUu6fn9Sc9MInTydr9W8eD7EP8BTf27lB/J/kvcVnWT/JzbaNe+5HdeA+zlEt1szeO1A3uvLx7P7wnMQrCO5RNqQ53GNRClCxXVK1zolxRML6zqgm2X9CshyMANt34rQQnL0texVUClpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f64P9xvZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=shZRf/cH; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0f8ff676b6ce11ef99858b75a2457dd9-20241210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xMOExD/YyDJcJj2S5oaTg8saARv53vAb0D+cjkK3GMw=;
	b=f64P9xvZPOhOiTeQ763sO59SC9TI6htf5zcgzBPWsdLB7exP+NIzil66Ka3ADBvZrFgxF/o/70XIWaY3giiD5UhAlAofy4VZoWqbpOoFzOyu8luoper3vDc/2DR6VoNBn+ueShlTFu1JeMa31IkjJYdPV2bddwUqF6srEdb/dvw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0318d0b3-3495-4bb2-ae94-7e73d3bd1e75,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:6381a3a4-c699-437d-b877-50282f19c2c6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0f8ff676b6ce11ef99858b75a2457dd9-20241210
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1490302107; Tue, 10 Dec 2024 16:09:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 10 Dec 2024 16:09:19 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 10 Dec 2024 16:09:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uom7XVffwRx4NgY/GciwcHraQKifHNOoV7pL2TEHQKxgJ96wqFQYtXgF4X/B9WN8+TATiSKdCXYs7pcZudYXPkbcQ2+ES3WBXvauEvsw47BJ4JPyBUbHHr0PiG4louoFiuCdkJDqoc7ISzubtODUh52jI6BrKR7hFaasJ8avhLAUYBQgIWTc5kdsomarXJU+jVh7Hck/iohI/ugmzma5HpBX2BtIWJup/yixZ+4ItM9wpxg9bzDz/Ux0z4NIJqhg2N6cMkvnLXGxBDLQpPhnyQCM5kmvgDepwIedR2zTCBd0eszmowA0335DhAILSpeZRJfQiW95FQcXVKKHHcpBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMOExD/YyDJcJj2S5oaTg8saARv53vAb0D+cjkK3GMw=;
 b=GovAZpm5T+EmbTs68WI+cdrcAKiY5twRhHOIfPnskf+IJm5pfrVVy+qxmB/oZHlpiK2AqPNP1EAFG8tHpxprBSqTfjqmmlCNKsr+PkYDJ1hbLx73pujrn+KBxiGiI6z/LSMyvKIAEevVLnCdvaTbbNooUjQuRwHAGiKHTyrISvLJx0FbHyta273NWoI2gXUvsHJ2jXsu29Y2bB67U+QI6ODjqDG1KVCIPVniZlUemHjguXiehg6jU7iNR2bpKfF2RMTr75QvzMHFNyNP4G0mBTZa1rfP19RUWRrCqut58t8yNAj7roe1vitY6sJM4m0q7f3S9Y8lt9Dl6UbzqfADcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMOExD/YyDJcJj2S5oaTg8saARv53vAb0D+cjkK3GMw=;
 b=shZRf/cHElsKmH2nKVee6tx7xzj3YuKImVlzUd2dltY8sQBVOnBGp2+YGK0qxVdFU7Yiyrs5RYVDotBWRYmieWzxoKhb728hQF1GlGUDtofKMfmU/bcZLPleaeCqCB3qbt2z4USEOUOcchSJxOA9dBX21GsaCs1XrI7PJuqKTfw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7154.apcprd03.prod.outlook.com (2603:1096:400:342::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 08:09:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Tue, 10 Dec 2024
 08:09:16 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "jie.qiu@mediatek.com"
	<jie.qiu@mediatek.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v2 15/15] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Topic: [PATCH v2 15/15] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Index: AQHbRwuJJIpw1RNG4k2Br44bBPRYWbLfJ4SA
Date: Tue, 10 Dec 2024 08:09:16 +0000
Message-ID: <ae0a17c93131c22c18f0722c43d4770a652e2923.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-16-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-16-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7154:EE_
x-ms-office365-filtering-correlation-id: d92e66e8-3c14-43d7-b2b1-08dd18f1f0b4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?emIxbUJyalB3TU9rSnd3NVZ0RnFkR3FHMExkWk85alB6TUZWcHFyQzM1Y25P?=
 =?utf-8?B?RnNxVG1yQnFTQkFrYkV0Z21LWlNtTWFldzdFR2ZQQ3VqRHR3MTRZNzNtaDlG?=
 =?utf-8?B?azhqazY4aWIvR3VSTUlxUGtZSk4vWUV5ZDZNM0FZeS9PbnNsNE04bnJqb2Rq?=
 =?utf-8?B?eUVEUGFQd3habFdxQUtKc1pwVDMxa0xLTHdGWG9mTkFZd21MUlFtb3JBS29W?=
 =?utf-8?B?bE1BUWx3RjZmOHEwVUZqODk5WHUrT2tVZXROeitxOFR4UWwweFRqTmpHMVdh?=
 =?utf-8?B?QVlwbDB1ZU85VnI2YStoQXNMYkJEb2xSWlJXL0MycURUekxIUWNnWktwUEhM?=
 =?utf-8?B?ckt2enNoRjNla25Ibys3STdjNXhxaHZQbStVdWxBVWJZN0hicnVKR3Fvd3Zo?=
 =?utf-8?B?K2J6a2RnQ3hKY280U1VoU3ZibTZzclVHeHF5SnpyMFJiUGh5VFVodERQQkRU?=
 =?utf-8?B?SUZBdHFqQUFTaVBvTE1LZm81SVZ1WUoxTkdXcFNmOFQxS0J4R2JHRVhsdEFH?=
 =?utf-8?B?WWd6ZSt2K0NFdzFCNnZhUzVjMG1lMGx3dkZDcEl6cnQvRjJ0VGEzcDZyTVJu?=
 =?utf-8?B?M2k2cmVuZURyM3lXY1lIN3M4cThGWS83c0RneFFlWWpWV2YzWEFHdVgwdU9s?=
 =?utf-8?B?SGdJR1dqajBQOVdBS09MR3czeWdrVHFqL01oWGRWV3ZXVnRSVjR6ZkJYTHZU?=
 =?utf-8?B?bU8vQUIxT1d5SFpZaGFMWkRTS2RNTmRxMFFhb2QyUGZuZnJ1MTRpVVBVdm9N?=
 =?utf-8?B?MkYzaGs4ZEVSdSs1amdzVWpjbDFQQWNtM05CcU4yRVBXcDlhTE5wQ2hZS0xo?=
 =?utf-8?B?WXFJeTRVNms1bFhKUUZJb2xjZmJsNVdnMStCY0tNY0NWMzRTM3VCL1NyTTUz?=
 =?utf-8?B?N3B3YTFUVHJUMUc2TlRNb21jUHBDUGV6ZDlWYnV1c3BORDJkNEVTU0FaeVVS?=
 =?utf-8?B?OEVQbVVJRXpWWEdJd0Z4b25qek9HT3FkNWx6b0lKakxHOTdQWUJ2WmpSb01l?=
 =?utf-8?B?ZU5Ic0NBK2Vxbm5FSUlvSEpjUWRUVUFtTkVweUJZdlJibjgwNVkwTE9UUkpS?=
 =?utf-8?B?QWI4MlpGeWhpRmpiSWFTZms5NjJVRHh1ZDhkUmRqMFk5VEZsbERhL04rMGJm?=
 =?utf-8?B?ZVl5U3ZIVkZjUXg3dkVVQjQwODhpSENJL2NaZFBTRmJpV2s1b3FsQXBZVjZ6?=
 =?utf-8?B?MHk1RmhhREdnSkFJTnhzWHJrTXEwT3hyRWJTcm5IUnZHMHhlVlBhbGhTcTlx?=
 =?utf-8?B?YzhBZzF5S1hEVEJYc0svakcwWDVJUDJnbEZ0YWZGRW9IYzBnMjJxTnNDTFNJ?=
 =?utf-8?B?MnRrTEtUMk10QUZtRUFvVTkyQ2Y4aUhGS0ZzYThEWGthenNHM0htV1JSUzZK?=
 =?utf-8?B?ZGJDck1lYmZXMzhkYmpSTWtWdXNUWEJLQjUrNmN5dFN3TVJBb0lYRVNmYks4?=
 =?utf-8?B?S00zNUlCTW5ZaXRSSDduL1RMOXgyUlYreVlCV0NlR3lrQVV3U2dPWUZNbkJF?=
 =?utf-8?B?V2t0ME53ckZRMTVrem1XaTcydXduczlFblE1QmFnb1JubC85RE5VVHBvN3Nn?=
 =?utf-8?B?aHFUejBsaEFJTlNHZXZMR1JMRGhIN2lYM281dmx5d3NvQ1hweThCQnd6TURn?=
 =?utf-8?B?cGdOYTBBaGNMdlF2eVN0RENhdnBGdjFNQ3pCYmJwTGgxdmMvakRiZlRzWkZT?=
 =?utf-8?B?cGkrWHNXWkN3WVFBTXdTTFJCNExiQjdSTUg5eUdEVm9ENysvU0RxM1ZoZEVR?=
 =?utf-8?B?Y2IyRVlrOTYyUUNCTnBKVWtLalhQeTY1dEZZWktXbUwzVEU0Y2s3Z1BNS2Zk?=
 =?utf-8?B?NFIyUXRCZDlEeDBGbGNCd0l6WE9LTmVCTVJIT0Z1SU5MVXBDS2xyYnpSTEZ4?=
 =?utf-8?B?aFFVdXRpM0Z4c3UvU3lGT2sydlNGQVlmbUt0dnVLbnBteXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1FlcTBiTG9DcTNqejR2V2daR1U2RlFsekMrWmM4cFZCN1RNNTZBRHVMejU2?=
 =?utf-8?B?QndpeVNPaFc0bCszaHFsSlptbjVvWmpWZ1BFd2RyTEJpVlI2cDdOb3RjQWQ2?=
 =?utf-8?B?c3RwNVNueFZkQ2Rick5RV3BqMzFYM2EzL3FsS3U3cnFwN0tBWTRRN1U5b05G?=
 =?utf-8?B?Q2lwazdOdlJkdDdUYkNEdkJJbjkyUkVJSTMzMUdHUlphWjMvN0VsU0FGTDJ4?=
 =?utf-8?B?OWdVMEIyZkhiemhqSGVBMDJrUmhJSDhKS2ZWT29YWVNuL3dJVzAyU21uTHh2?=
 =?utf-8?B?Z0pQdjliVTJaTnBiUmZWWEtSRllWNGw3YmpXVUxYclV1dGtGaEZudGxjNU9k?=
 =?utf-8?B?cFRuSDdsUkFyRndVWS9NUEdwSjRmY0ZDcGtDNllwM2t2bjVJODNDSFBYaitJ?=
 =?utf-8?B?NXBlWnRXME1WaDg1cDN1Vmw5U3FYVGdQUm5EaHM4YTJScGVvMnVBYzFUbm9B?=
 =?utf-8?B?eFI2bm1rbVpSdEI2WmNuUEJaWUIveCtQZWlqOEFSVGZhdUZidlhYMFV4NjRm?=
 =?utf-8?B?TXE5SXJuOGdXWFhmR0pmdG96NjB5RWRwZmZRdG9ISGRXNHR2bVIyc2hKV0Rt?=
 =?utf-8?B?UjdvWFplYUF5dGJtc0V3eWROYjdUTnUyR0Y5dGNHeXdkQ1psQkNJQ1BYYnls?=
 =?utf-8?B?Ukc4Z1k2QlVjT2hLYzZXSnMveHIweElxbmV6UGJJcm1EaXpUUVBMSnVtZUV5?=
 =?utf-8?B?MUw0WFpEYzljcHNhRzZkTUNIMkphNGg1VzN2K01aZWVvblhQWENqbzBrTkpZ?=
 =?utf-8?B?R0MzU0pMaHpRc0psWW45UGpGTktPcHVRRkxadFY5NUJ5TGc0V2ZDY2dkVk9E?=
 =?utf-8?B?OUlXZ1M2ejIvTzdiOXUwZ1Z0elh5cVU1RElaTDMrcmU4aDNJYlVkeHVzS2VR?=
 =?utf-8?B?d3FJWUxjS0VBbmFrNUNoOVlrTTg5MVlzVEM3cTJwNVFNblRQdmt2dDM2TzhH?=
 =?utf-8?B?NS9HM3RuM01QOFhWVFZxdCtaU2VWYVpFRDU2a2c5V0k1bWJZTVF1Mm1UNDJX?=
 =?utf-8?B?TDcrTXUyNVdXb1owSjE3TnpBT0ZxNUJCRFNweGxUQ3h0QVl4UUtDaFJYQnYw?=
 =?utf-8?B?dDdYbWhkMWp3ZFhwWTRzTGZWMzFhamEwakQ0c1ZsUk5leHNqUXBLbjBsZEdO?=
 =?utf-8?B?R0RSOHFQd21wY21xSEpXNm53NGpPcTZDUWtOOW5iWXFUZE0zdE1WTFN6ejJm?=
 =?utf-8?B?RW01ZzQzZFNtd0E2WWpNbFh2THZKTlpaZ3ZSZUdMYnNxS3ZDeWRIVWNod3pJ?=
 =?utf-8?B?a0VERGpxYXNDaWZhazJKNVVrUUl3Y0pOdHE2U2ZRRnhuVkZvOWpmdFJJN3BJ?=
 =?utf-8?B?azZ5SU95cUoyUjRwRWtyclF4Skd2NWRRb1VCNWVSaFhhRjhRNjljalFrNTFp?=
 =?utf-8?B?R2ZuOWhGTHdrSDRHTmREUVlrTWtPdlc4OHlLZjBSSjBSV1BEZTdNT3hMcTFD?=
 =?utf-8?B?bUlmR0EvcjVSNzJOazdxekc4Qmk5MTVFZGZwUXpaTUZnazNmYmU0bXh6WEx1?=
 =?utf-8?B?NnNLU2g0ZWRTYWprbWJlNEdNR1Q0aG1GQ0x6QkNDbVVyMWVDTmxocDVZSmVJ?=
 =?utf-8?B?VHNpOGdGZXhtck5kT05XVjgrV20xdnFMckFsbG1WZXZmMGZISWVzTGdZYjJy?=
 =?utf-8?B?elJlbUtYbWdSU3FGL2xjc1ZHMXh6UzdXbEt4SEJOZnk0Mms2c1dudURMNUVN?=
 =?utf-8?B?TGk5MzY1b0hqRzVidWxvaVZFLzg1RzAySDNvbXBGZFA3dVFZRFFyQmw5aHh0?=
 =?utf-8?B?TElQQVMwYWI1OS9rUWh4ZU9iZ1l0WlN4WEhoRU9mQW5vUVV3WnJ3Tzd6eXBx?=
 =?utf-8?B?aEl1dE8xVDFFQkNJTlVCUlYzbTF0bnlYeVlYQzMwdUMvaUJ1a2NzbXV1TktD?=
 =?utf-8?B?Q1RiZUxsT2NHN0poQmM3dU9WaFU2VHBaZGFBWWp1bk5RYytvblBSR09VdElW?=
 =?utf-8?B?U0xibkRoTDhlRUJ4V2cxTVBHUDJ4aVI3RGNDRXd3ZDBKV3ZGdXVxNjNGOWxv?=
 =?utf-8?B?aVJrUXd2L1RkL3g2YVRDWktOcUVWc01iemt3SjBQdjNPS3pIQXI4QWdJUXJY?=
 =?utf-8?B?cW9nRlM5azhjT3NxcHlQLzUya0xnTmU2YXhLS1J0SlFVSUpQbllWaXFCUVg4?=
 =?utf-8?Q?aYlFVBtWnIvPPoYODtd1hH/n4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6B3A1165866C74EB411EB7B51BA631C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92e66e8-3c14-43d7-b2b1-08dd18f1f0b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 08:09:16.0485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRLTFpt4o0IoGcE2VxBYZdKM3jQlajEV6uuH4704eHpe3seVmGLYeRdDb7+ok4l6KJkLExZ1gl36FqsZoFY+Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7154
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.190600-8.000000
X-TMASE-MatchedRID: L8tZF6zWW2oNtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCsME2BsoiKJMBfVY7O+c8KYiActr2yXJYt9zZd3pUn7KEAi
	HpwMlPnM2GwJiqvFBX9qspQ7EuDzT0//3OV6Cj+ZH+PTjR9EWkiEdaywSZvzO+Cckfm+bb6AcaY
	+iIPlpkgHXJ8eVIgKFtauPEYeMK/Xlb2fVWad3hB3EEAbn+GRbvJ9Xvh5CmT6bKItl61J/yfmS+
	aPr0Ve8oTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/st+0OLrJ65qzItxL1o9AfcgM0jJwy7YaaFtBd
	4rTyjt9gT2HdxMWcrg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.190600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A6A88503F9CF8B6D487CB1DC8C4420BB0AAFA4A7F0E25B248B52A2B5B3AF54092000:8

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTEyLTA1IGF0IDEyOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Ig
dGhlIG5ld2VyIEhETUktVFggKEVuY29kZXIpIHYyIGFuZCBEREMgdjIgSVBzDQo+IGZvdW5kIGlu
IE1lZGlhVGVrJ3MgTVQ4MTk1LCBNVDgxODggU29DIGFuZCB0aGVpciB2YXJpYW50cywgYW5kDQo+
IGluY2x1ZGluZyBzdXBwb3J0IGZvciBkaXNwbGF5IG1vZGVzIHVwIHRvIDRrNjAgYW5kIGZvciBI
RE1JDQo+IEF1ZGlvLCBhcyBwZXIgdGhlIEhETUkgMi4wIHNwZWMuDQo+IA0KPiBIRENQIGFuZCBD
RUMgZnVuY3Rpb25hbGl0aWVzIGFyZSBhbHNvIHN1cHBvcnRlZCBieSB0aGlzIGhhcmR3YXJlLA0K
PiBidXQgYXJlIG5vdCBpbmNsdWRlZCBpbiB0aGlzIGNvbW1pdCBhbmQgdGhhdCBhbHNvIHBvc2Vz
IGEgc2xpZ2h0DQo+IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgVjIgYW5kIFYxIGNvbnRyb2xsZXJz
IGluIGhvdyB0aGV5IGhhbmRsZQ0KPiBIb3RwbHVnIERldGVjdGlvbiAoSFBEKS4NCj4gDQo+IFdo
aWxlIHRoZSB2MSBjb250cm9sbGVyIHdhcyB1c2luZyB0aGUgQ0VDIGNvbnRyb2xsZXIgdG8gY2hl
Y2sNCj4gSERNSSBjYWJsZSBjb25uZWN0aW9uIGFuZCBkaXNjb25uZWN0aW9uLCBpbiB0aGlzIGRy
aXZlciB0aGUgdjINCj4gb25lIGRvZXMgbm90Lg0KPiANCj4gVGhpcyBpcyBkdWUgdG8gdGhlIGZh
Y3QgdGhhdCBvbiBwYXJ0cyB3aXRoIHYyIGRlc2lnbnMsIGxpa2UgdGhlDQo+IE1UODE5NSBTb0Ms
IHRoZXJlIGlzIG9uZSBDRUMgY29udHJvbGxlciBzaGFyZWQgYmV0d2VlbiB0aGUgSERNSQ0KPiBU
cmFuc21pdHRlciAoSERNSS1UWCkgYW5kIFJlY2VpdmVyIChIRE1JLVJYKTogYmVmb3JlIGV2ZW50
dWFsbHkNCj4gYWRkaW5nIHN1cHBvcnQgdG8gdXNlIHRoZSBDRUMgSFcgdG8gd2FrZSB1cCB0aGUg
SERNSSBjb250cm9sbGVycw0KPiBpdCBpcyBuZWNlc3NhcnkgdG8gaGF2ZSBzdXBwb3J0IGZvciBv
bmUgVFgsIG9uZSBSWCAqYW5kKiBmb3IgYm90aA0KPiBhdCB0aGUgc2FtZSB0aW1lLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQoNCltzbmlwXQ0KDQo+ICtzdGF0aWMg
dTggbXRrX2hkbWlfdjJfZ2V0X2kyc19jaF9tYXBwaW5nKHN0cnVjdCBtdGtfaGRtaSAqaGRtaSwg
dTggY2hhbm5lbF90eXBlKQ0KDQpwYXJhbWV0ZXIgaGRtaSBpcyByZWR1bmRhbnQsIHNvIGRyb3Ag
aXQuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICt7DQo+ICsgICAgICAgc3dpdGNoIChjaGFubmVsX3R5
cGUpIHsNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV8xXzE6DQo+ICsgICAgICAg
Y2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfMl8xOg0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDB4
MDE7DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfM18wOg0KPiArICAgICAgICAg
ICAgICAgcmV0dXJuIDB4MDI7DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfM18x
Og0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDB4MDM7DQo+ICsgICAgICAgY2FzZSBIRE1JX0FV
RF9DSEFOX1RZUEVfM18wX0xSUzoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV80
XzA6DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMHgwODsNCj4gKyAgICAgICBjYXNlIEhETUlf
QVVEX0NIQU5fVFlQRV81XzE6DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMHgwYjsNCj4gKyAg
ICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV80XzFfQ0xSUzoNCj4gKyAgICAgICBjYXNlIEhE
TUlfQVVEX0NIQU5fVFlQRV82XzA6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVf
Nl8wX0NTOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzZfMF9DSDoNCj4gKyAg
ICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV82XzBfT0g6DQo+ICsgICAgICAgY2FzZSBIRE1J
X0FVRF9DSEFOX1RZUEVfNl8wX0NIUjoNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAweDBlOw0K
PiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzFfMDoNCj4gKyAgICAgICBjYXNlIEhE
TUlfQVVEX0NIQU5fVFlQRV8yXzA6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVf
M18xX0xSUzoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV80XzE6DQo+ICsgICAg
ICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfNV8wOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURf
Q0hBTl9UWVBFXzRfMF9DTFJTOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzZf
MToNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV82XzFfQ1M6DQo+ICsgICAgICAg
Y2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfNl8xX0NIOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURf
Q0hBTl9UWVBFXzZfMV9PSDoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV82XzFf
Q0hSOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMDoNCj4gKyAgICAgICBj
YXNlIEhETUlfQVVEX0NIQU5fVFlQRV83XzBfTEhfUkg6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FV
RF9DSEFOX1RZUEVfN18wX0xTUl9SU1I6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZ
UEVfN18wX0xDX1JDOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMF9MV19S
VzoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV83XzBfTFNEX1JTRDoNCj4gKyAg
ICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV83XzBfTFNTX1JTUzoNCj4gKyAgICAgICBjYXNl
IEhETUlfQVVEX0NIQU5fVFlQRV83XzBfTEhTX1JIUzoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVE
X0NIQU5fVFlQRV83XzBfQ1NfQ0g6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVf
N18wX0NTX09IOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMF9DU19DSFI6
DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18wX0NIX09IOg0KPiArICAgICAg
IGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMF9DSF9DSFI6DQo+ICsgICAgICAgY2FzZSBIRE1J
X0FVRF9DSEFOX1RZUEVfN18wX09IX0NIUjoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5f
VFlQRV83XzBfTFNTX1JTU19MU1JfUlNSOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9U
WVBFXzhfMF9MSF9SSF9DUzoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV83XzE6
DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18xX0xIX1JIOg0KPiArICAgICAg
IGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMV9MU1JfUlNSOg0KPiArICAgICAgIGNhc2UgSERN
SV9BVURfQ0hBTl9UWVBFXzdfMV9MQ19SQzoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5f
VFlQRV83XzFfTFdfUlc6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18xX0xT
RF9SU0Q6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18xX0xTU19SU1M6DQo+
ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18xX0xIU19SSFM6DQo+ICsgICAgICAg
Y2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18xX0NTX0NIOg0KPiArICAgICAgIGNhc2UgSERNSV9B
VURfQ0hBTl9UWVBFXzdfMV9DU19PSDoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQ
RV83XzFfQ1NfQ0hSOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMV9DSF9P
SDoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV83XzFfQ0hfQ0hSOg0KPiArICAg
ICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMV9PSF9DSFI6DQo+ICsgICAgICAgY2FzZSBI
RE1JX0FVRF9DSEFOX1RZUEVfN18xX0xTU19SU1NfTFNSX1JTUjoNCj4gKyAgICAgICBkZWZhdWx0
Og0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAg
ICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCg0KDQo=

