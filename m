Return-Path: <linux-kernel+bounces-405554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 122DF9C52CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950BD1F229B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5BA21265F;
	Tue, 12 Nov 2024 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YHJOUwua";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oUv1Izfc"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262102123ED
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406125; cv=fail; b=YzG2p0WXLCCqP0lN3MMkDpfTVKPZiAUWBiQoqXD0xzk3LkunVtvdSRpMoNQqIttHa5IbsAp0vumyLUnBV8JcdU8fs+pcyCu7q81ejCHiy0U9juZWxLTp3YNzX9jWOB4k/lLj3ImVOeNTH3Tn1eoUyHdolzAuc3nKu1ZHjSi7iZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406125; c=relaxed/simple;
	bh=/5hEp1Xai3QXS7MH8xaGtjmDnf4DVS+Y9+cNeUQTkMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FUO2AnjYecYNlJVmiQuEwN7mF+N5975+Pj6BxalD9ohrhARbJw7RX912QvUta/uif/7BYXV9FBmu3VHpsXs6nlNgzcBaKCwDyLYzwBaaaAw5HPTMwDSKAZ0SSyIQGLLHvhxPMTKjfZF+rvyQvgMnyk1vfIGaTrvFWw2HdnRQUog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YHJOUwua; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=oUv1Izfc; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 153c79f6a0de11ef99858b75a2457dd9-20241112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/5hEp1Xai3QXS7MH8xaGtjmDnf4DVS+Y9+cNeUQTkMw=;
	b=YHJOUwuayg42muWoeMRkmB5anpg60IV2nkeAieEz6jgmsdQgyoDRK0kvBj0PnF1RoqyxjSgbxiHmvatc4WmMWWUT2CY0xKDaQ8tCsenv0zIq7yWuU0BdQtGcFWk67atSlbrf476ABkLmCdODkXXd41qhlI9tbzB7HLXp255Fdw8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:608eae5e-00f4-4f0e-ac06-6d83814d354e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:b0fcdc3,CLOUDID:0e82ebca-91e6-4060-9516-6ba489b4e2dc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102,TC:nil,Content:0,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 153c79f6a0de11ef99858b75a2457dd9-20241112
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1023122157; Tue, 12 Nov 2024 18:08:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Nov 2024 18:08:33 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Nov 2024 18:08:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcP9ImcJ4AMNU7KkhUMEJ0WUg/pQPM9zY5C46BQr+7irXTLvINr4Qo8jznGl5dKuUfnuhyt00pOv6N7L0sseTokzdVhR9E9fRkx1DP02rIhj28tlM86pwsHyrnzkgSKUnMTHC2j8y4h3AoXRnA8SpqqwIWxoOlN5LkBflQI0pS+OrxiH+9y17tRlV1hNgGklQcFXGYTGPZNzgq1eZMF0OXD5c1Unpq+nczl2CuVfQQWS6aeKGVXMxc2BB0KLUUU7nhCBkOaJINCAow7ZUKFv35AIyllFEfNBTsYbNN6rAn04va0xCjZhs0XfC+HAMoBY+j7u2ZfgO+Os7wF0FqzCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5hEp1Xai3QXS7MH8xaGtjmDnf4DVS+Y9+cNeUQTkMw=;
 b=rCE2uVLuXtY6Nexb8k2UzAP3imvxZjP4ymvkmGjW23xMf9KhlWe08Wx1BpCvbBOiuotS+PObo8M8HzWoR9MxCPHZdFlrioOzvmxlvzeJW+9aJzJqaDMN1DSgSozAE8H6sIKPr1S5NsjJxMsJKdSYDppxegIv8AF2uK6zohiS6o63VH58FYFF6tUWVpfh/feVKvS5uwFbVvXhEI85U1+cCXRc06zW8zVT/MPwN//L12t45c93l4Ri111iGZerqRPcLJwYAk7Otr/RsuIvEEznby/+77KbEt91rJkYyC6upvaupazwQ8PGCiBN5pJ4o5mNkJUhlb0AnQc1qQ2IKqeuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5hEp1Xai3QXS7MH8xaGtjmDnf4DVS+Y9+cNeUQTkMw=;
 b=oUv1IzfcluZ8HLA3T2WSl/IeTplR9I4t1IMdMVU1DlG5IaqRjO8hgPDtp5KTPbTRcdoCS9zRxVTK7oDrfydvWEPnNnjaAqM7+XXUSBxQNT0RdGWqAfu12xkslrqkc9443vh0Pz8DcgN7YASu1HOD29moLhNBXnrvGxEGQvJakQc=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by KL1PR03MB7288.apcprd03.prod.outlook.com (2603:1096:820:e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Tue, 12 Nov
 2024 10:08:31 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.8137.022; Tue, 12 Nov 2024
 10:08:31 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "dev@kicherer.org" <dev@kicherer.org>, "d-gole@ti.com" <d-gole@ti.com>,
	"vigneshr@ti.com" <vigneshr@ti.com>, "miquel.raynal@bootlin.com"
	<miquel.raynal@bootlin.com>, "gch981213@gmail.com" <gch981213@gmail.com>,
	"mmkurbanov@salutedevices.com" <mmkurbanov@salutedevices.com>,
	"richard@nod.at" <richard@nod.at>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"kernel@sberdevices.ru" <kernel@sberdevices.ru>
Subject: Re: [PATCH v2] mtd: spinand: add support for FORESEE F35SQA002G
Thread-Topic: [PATCH v2] mtd: spinand: add support for FORESEE F35SQA002G
Thread-Index: AQHbNOrToR8/CnEAIk6bN9gkcdT1vg==
Date: Tue, 12 Nov 2024 10:08:31 +0000
Message-ID: <dbdb45ed1135e73b4eebd76e6f61b96d48aaedc6.camel@mediatek.com>
References: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
	 <20241108163455.885-4-SkyLake.Huang@mediatek.com>
In-Reply-To: <20241108163455.885-4-SkyLake.Huang@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|KL1PR03MB7288:EE_
x-ms-office365-filtering-correlation-id: 6eb6b6d9-898c-47e8-2df6-08dd0301f5f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?amZ2U25PSElRUDM2RlA0QTV2K1Mvc21JU0hmU1B6UjJqanRtaFZtbDQ3enk2?=
 =?utf-8?B?SDlXNVp2ZXhjbHowMG5ZNDhDSDA3S2VvYUR1VVVLRWhwVFZzcjdZN3YwR2dh?=
 =?utf-8?B?WlA2ZjlPVkFJdlZUQTBJMEJDd0hwYVY0a1c4Q0U3YldyaUJSQTV3aTN2UmhP?=
 =?utf-8?B?SXQzeGxTTTcrOUJNQ1p5cFY4M3lFOTA0UnlvUU9LUTNtVW04aEJLR0FGSURq?=
 =?utf-8?B?QkZyY2hFL2p5cURpNEhLV0tGa0VZRW1BOW10NElIMGNDbGlHckdpQ3lsdGdj?=
 =?utf-8?B?aFVycm1NSnZOWFVPb29TUzE1UVZ2K2tDaWRoak90MUR4S3REZytuQjRMejZp?=
 =?utf-8?B?YjVyQTFiWjFrSHd0ZG16ODdxSThGN1VieGVKd1VGWWJGMTJxcWJyWTRPcmE5?=
 =?utf-8?B?VWpoeE1LSjk3UHFYeWNlQTFtYnk5OEV6NkZWV1JtWmxxYXBSVU80dDA4RHZJ?=
 =?utf-8?B?amRtL3ZCaGFsUUkrVkc5cjViS01pUGRDTTJWd2l5NzF2K1ZFQU5kRmZ4TUUw?=
 =?utf-8?B?REJTcDFzRUVET1Qya0t4cnF0SlRWSFNBWkUyUnBKd0lyYkRQYWRKMVZmYlFT?=
 =?utf-8?B?YlhxbmVNTy8zMVc3YkZrd3Bic3Brc08wSmVHSjdXbWZTRGhwNzMrWEFiNGds?=
 =?utf-8?B?Tk9UeSt6SGZrQllrOEt1dURnOFRqblR2ZWYyd1cveUJnL0FzditTSnhGOGFO?=
 =?utf-8?B?MVNYNFNLYTBXTHU1Yy9QMFFJSExVU0NVdzRIN25MQWJOMFR1Yk9iQTVJSGFG?=
 =?utf-8?B?YWFhcG0rR3o0TVpNTUtXZmFQT0M4amRldUpVeTFEdjZqeERJU3pHRFlsVHNN?=
 =?utf-8?B?dlJudXE2L3ZkdG9GRDlYSEpQZWRKWi9MQTNSRFh0SXFCVmdkdzQ1SUZzTkZo?=
 =?utf-8?B?VGh4eEZwUFZnaFpzYk44S1BJQit5OGJ1ZUF0N3VKR0ZLcExXdmcrRFlVVzJh?=
 =?utf-8?B?U1VsaCtzcGF5eUVFQzVwaGtxbXZMWFVENldrbVFtQWFrY1EzT2o5ekcybStU?=
 =?utf-8?B?WGc3Y29sQWhVbzF0RmFpekY3WUcxbHdQemhmMzkxcFdEVFFwamladFc5ck12?=
 =?utf-8?B?cXB5RC91MVBoNFJiYTVkeVd0dG5QZ2p3SFY1VDM3MzhTbFUvaUs3SHNZNUdW?=
 =?utf-8?B?VnJpV1d3b0UveDZpNkN6MHpZbE1VZDBYWnNCdlFvRE9DMTZQVXRTeFE4UDlj?=
 =?utf-8?B?RGhQaDJYeUNzdlhLdHJCbGpFdnBZWVpVVEJYbHIwRlZZWUZZUFdvcDZMaXZE?=
 =?utf-8?B?ZXFBRHBnYldDMG95WkJ4Z2ZJSlJVMHU2N2I2Tk40MEV3bWN3czNNK1U2eXJh?=
 =?utf-8?B?cWt0aFE5VnFNWFBBU3lKcFZuVGF5dk1LaFFoMjV1dzZyZldpTFRMbTNDUjA2?=
 =?utf-8?B?em9kK3U5UUJOZE44bnRLWjhjTkV2LzRhelc4RHR1TDVQYmJmZEhmSm11Y0tD?=
 =?utf-8?B?STNNdjlCeHR6WmRUdm1CZ3dRY2xrYVMwVHh2MFYrSUJBMTRaVDBPaEJSR2gz?=
 =?utf-8?B?YzhqTVFuclJZSFhXSEQ1NXpCY3U5dm5nUytRa1FEejEwQXZ5YlhCUkVhL1NV?=
 =?utf-8?B?WncwdjhMVnlJcThxS2hPOUNvM3Q0UytuSHVaQjQrQzQzMU5renE5WlBTTndx?=
 =?utf-8?B?OVZoZTR0eW9pVDRvdGZDVGFrSXFxNmV3Z1Eyb3FoeGsrYkNKa3B5STdnUUJI?=
 =?utf-8?B?QmJLYkFCV2RqMFU5bHRGV1hXQXBEcGhOU1dSeWxOU1Jodk1LVnlnNmtSZHhi?=
 =?utf-8?B?azZjcmdhSW1ISXZZN2NWa1FScjRPSGtZQVhucURuWXBlUWVnaldvQ0w4elpH?=
 =?utf-8?Q?ylCWcBS1/Qc6LOrAUd6Vjrc3ajVtfyxNwfb5g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW0zR0pYMGtaNUloNzJTdkxSMHB1c2xtcWJSb1QxZTZENWJ5dnJFRGRWTGRX?=
 =?utf-8?B?aWl2Z29pMHkvcmJud3JOMTl2cUE4UmFjdnNJM1FaZ1ZFVmRjejZ1T3RUL0FX?=
 =?utf-8?B?aVdZcEVGb25YSS8ya2VjUE01bnF3RDlkcUQ5VXJDV1hqcEJaM3RjZmtHRC92?=
 =?utf-8?B?QUkrOFV0b1QyUDB0UzJOU2ZNNTFBc0FvZjJWY3JweW5ZVGJNNU5zMmtxN3BL?=
 =?utf-8?B?RXordnhlb1NqRUh0Z0RXVXVMZGduV3RzQllHeUFScEVRZTByM2JlVC9yNGJ4?=
 =?utf-8?B?azlUdmI2TXg1QXdFd0xCTWQ1NUl2VUtzWjc4NXoyKzdKU29HMlh5aWVJQkIv?=
 =?utf-8?B?SFhjNlZvM1Y5cUk4ME93S3NRV05QN2RZYmpBa2J5a2cra1pQWWFTTVIyZE15?=
 =?utf-8?B?RUF3VTh6YkJuZWJoeFNQb1hCOUwyejhoemJCbk1TekczR1lGRlJyeHNwcTRS?=
 =?utf-8?B?OVJwblV4elplYTM0WUtzNVU5U05nLzNROEo0c09qQ0txVDRiY3N2bW5rSzBi?=
 =?utf-8?B?QVYvWCtScFgvZW94RHFOZ1dQUC9KUG90SnhwS2o4ZEh5YXFTTmZJeG03U3ZZ?=
 =?utf-8?B?QXNVOUFyYXZZVnBUWFloTEMxeUNBRkluWStPcE5iV1RyWXBqSzdpSTg1bWtQ?=
 =?utf-8?B?a3lXNnFuN3BQSGRGQndtdkt6ZGxNMDFqTXFxL3FJTitzKytTTUtGSzQybkhh?=
 =?utf-8?B?UVBqSUFrVk5EbTNqeW94TjJFTUVZRHlzRS9FdUlaTlM5ejlBbWI3QitNdzQy?=
 =?utf-8?B?NTJnYnVaRUlUODJyWCswWXJURFQ3cjVuUG9mZnVxU0VPM1A5NHE5VFVkU1E3?=
 =?utf-8?B?cWNERjY5d1Z3bWMyVGlnU1NvRWxXc3pMY3JROTZ6QUsya0NCd2ViR2owWWRB?=
 =?utf-8?B?bk5kcHowQlB1SUFITDlUZjRaaGVGU2tucEl0bERrQXA5RndBMDhHcFVXK1pZ?=
 =?utf-8?B?bTBmOGhVWkV3clU0ZlRXTFJ6S1p4S3RVWnFZQ3RzWDI1RTB0WDNrMkZadGpt?=
 =?utf-8?B?R3BtVFhyOS9NMStzd1NhSUt5N0RVOWFpQUZDOFZKemszRWY1YnNQaVZuWEFk?=
 =?utf-8?B?Z3RKZjhLSEozblZBTXZOTzJ6b1VGQll4cVZyRWltUFEvVlZVT0dJbWlUS0pl?=
 =?utf-8?B?N3FFb1I2VDM5d3gxL2lmUk1YY3lFbFZFTUZ0aVdRMi9xZW14TXdYNWpqbVJq?=
 =?utf-8?B?N2k2bGhJY2pQRmw5d3ByV1J3WS8vdDlqdmpUb0c2S09mcGVmV29SUDJaMDhs?=
 =?utf-8?B?N1NvRVB4N2xlckw3Sm4waTh3V25DOHpUU2h1WHFHdTUwaEtPdHRqMWplbTZm?=
 =?utf-8?B?ZFVrSWVCajVmVSsxZnJ4ellQa1RQSEsyTVZlMFlNYjM3bEIyK1Q4eGdJQ0J1?=
 =?utf-8?B?YlR3dlY3RVBZMkp2Yzhndzk5Z0Y2QmFvVWxJM3NOc1lndlYyR3ZzRW1kemhN?=
 =?utf-8?B?eStaenlpN1F1S0dOOXdjY0F3eldPMzFPRTBMUUZmK2N5Q1RQcUV1bVViK3g0?=
 =?utf-8?B?TGVtL0RaV1lvYVFJTlhEbHNOaVkvZW5RWmhuSDdHem5ocmhzY2JoWlcreWxM?=
 =?utf-8?B?MXJYQ3NWTWJzcm5FWDRaK3pIU1pRdEFrK0srdm9XdDUwKzFpWHRHbXJqenVq?=
 =?utf-8?B?OWpFcnFITlcxMncrY2liNXlzdVJpOU1jNWhPVVlWR0lCbXUxQThseWIyZDRI?=
 =?utf-8?B?b3Z1Yk5QZVh1SWlndk82VmZEOWNoSG8xKzRJR1FZclNxdE1GbXBsNTFpbEVQ?=
 =?utf-8?B?Q1pUWnFoVGY0bzdsUDN5U0FJWkJCMmtQYmw1ZDNVRVFDVmFnMlcwNzJvWFNI?=
 =?utf-8?B?clhkMkwvdnFIb2lYWmErU3hvelROOXEreVg4UmZvb2JEZ0tWM1RkTTk3bGlF?=
 =?utf-8?B?Z05wNzZOZVdmSE1zSHdrKzhFNWNUTEJlWkZTY2hXZkRlbHdLT1ZUVi92b0lt?=
 =?utf-8?B?SFJTL3JRMHByOHRGdWI0aUoxTm1YejcxYjVESW5PNkc3M2JRNm4wbXRvYW1H?=
 =?utf-8?B?QWdqOXc3Rmc2cFk5M2VOT0thQlA0ajFYZGRhZy94SzIyZ2VXV2swQUNnNGpK?=
 =?utf-8?B?QmRxNDhkWHZQUUNqWk1zbEl1Szc5K1h4UG5DTjkwRDZhbi9KdDNYQm1idndj?=
 =?utf-8?B?U0FjNUNaZW1McVQzdWlmOXc4bTVxZVVrdTFCZGw1T0taM3BjS1pMQkJLdUc5?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A75316A2ABC114F99D07ABBFA7BC759@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb6b6d9-898c-47e8-2df6-08dd0301f5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 10:08:31.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhOVQnFtwvnWTQduPdRcsYLH7PVe/pPPkgE1W4Z3HNPDy72XYTR/jKX3mjaOzskjlPLn9Q15+QQBiw1jyNhAWIc/cFvZ89PecDzt1ECA2mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7288
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.275400-8.000000
X-TMASE-MatchedRID: qEAy/z09Hq3UL3YCMmnG4kPRjHu3N1uxuLwbhNl9B5V94c+e7fWIcBwA
	lHA73FsgFZbxQu+3+bpDpzq4bdndVkjlo2JU8qCx8/34U32EGt+RPtwwl97om1jw1tIWkE9uk5i
	HtyrZBeU/NmKpUPu+UFwGtnf+OY/EBm5D5IrS3s5IcJTn2HkqsfTWKs29qDlrmyiLZetSf8n5kv
	mj69FXvPkvV+z371TK5MIx11wv+CPGVuWouVipchW4SsKixsFRdK3QARkKJ+lf3NjF6aW73X/dN
	QRQ9JcVZWKZ3DCnUiswxdzFD14lFuyV3ZjiKBB3/odNRXUgNn7+5GU170Dtqlr/VRGx0IR2+Uo4
	vXq+qmzIizeCsI6wA0LUmjyL3DZSc+aWLqiwUqk=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.275400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AE49B47CE71337AD221EE1D8ECBCC8AD87BFA46EA44DFFCD4D91712755E3BAFE2000:8

SGkgTWlxdWVsL01hcnRpbiwNCkFib3V0IHRoaXMgZHJpdmVyLCBpbmNsdWRpbmcgRjM1U1FBMDAx
Ry9GMzVTUUEwMDJHIHBhcnRzLCBJJ20gY29uY2VybmVkDQp0aGF0IHRoZSBkcml2ZXIgd2lsbCBh
bHdheXMgdXNlIDMySCBmb3IgdXBkYXRlX2NhY2hlIG9wZXJhdGlvbnMsIHdoaWNoDQptZWFucyBp
dCdzIG5vdCBjb21waXRhYmxlIHdpdGggdGhvc2UgU1BJIGNvbnRyb2xsZXIgd2hvIGNhbid0IHRy
YW5zbWl0DQoyMDQ4IGJ5dGVzIChtb3N0IHNtYWxsLWRlbnNpdHkgU1BJLU5BTkQncyBwYWdlIHNp
emUgbm93YWRheXMpIGF0IG9uZQ0KdGltZS4NCg0KVGhlIGZvbGxvd2luZyBjb250cm9sbGVyJ3Mg
ZHJpdmVyIHNlZW1zIHRoYXQgdGhleSBjYW4ndCB0cmFuc21pdCAyMDQ4DQpieXRlcyBpbiBvbmUg
dHJhbnNtaXNzaW9uOg0KLSBzcGktYW1kLmM6IDY0IGJ5dGVzIChBTURfU1BJX01BWF9EQVRBKQ0K
LSBzcGktYW1sb2dpYy1zcGlmYy1hMS5jOiA1MTIgYnl0ZXMgKFNQSUZDX0ExX0JVRkZFUl9TSVpF
KQ0KLSBzcGktZnNsLXFzcGkuYzogMUtCDQotIHNwaS1oaXNpLXNmYy12M3h4LmM6IDY0KjYgYnl0
ZXMNCi0gc3BpLWludGVsLmM6IDY0IGJ5dGVzIChJTlRFTF9TUElfRklGT19TWikNCi0gc3BpLW1p
Y3JvY2hpcC1jb3JlLXFzcGkuYzogMjU2IGJ5dGVzYyAoTUFYX0RBVEFfQ01EX0xFTikNCi0gc3Bp
LW54cC1mc3BpLmM6IFRYOjFLQiwgUlg6IDUxMkIgaW4gRklGTyBtb2RlDQotIHNwaS13cGNtLWZp
dS5jOiA0Qg0KDQpJIGd1ZXNzIHdlIG5lZWQgdG8gYWRkIHNvbWUgY2hlY2sgdG8gbWFrZSBzdXJl
IHRoYXQgRjM1U1FBIHNlcmllcyB3b3JrDQpvbmx5IHdpdGggdGhvc2UgU1BJIGNvbnRyb2xsZXJz
IHdobyBjYW4gdHJhbnNtaXQgbW9yZSB0aGFuIDIwNDgNCmJ5dGVzKE5BTkQgcGFnZSBzaXplKSBh
dCBvbmUgdGltZT8NCg0KQlJzLA0KU2t5DQo=

