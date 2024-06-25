Return-Path: <linux-kernel+bounces-228148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A455915B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0A61F22156
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E513ADA;
	Tue, 25 Jun 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FjwBudoq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XOp380NG"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2331FA4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277698; cv=fail; b=XwgcPB5tAgmqvr09A/5oCcAFXspr/2TgBWthWcFyToYa7eMOYIcyVKTG+eswpa7nil1I6lY9v1ieKJOGWwUXo3RN2coOOW2fByZK8qv/Omgcw4PBicVhrbD0XOJFMf6NhftPHIC4HCaAGLibCKNcLFDZanXf1Jb/vtgumdgvznA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277698; c=relaxed/simple;
	bh=I7ww2mOxBVmmJx/Nl40l0XOXVxIzylakTzw7ICGJUfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cF85rtq954bkqO8WEfw8OCGXExwXBZ76MQMr6Myvc1tfGPjdFWWbSK5GytnUsAnpLPwqhsohYxTd0UwGKacDk4ouRSB7Gxc0nA648tcyvCcnI623XM4nOev3PhhACqZtUbUDsXNPHqyBkz/SSE13Uq2amu5eHiNnzG5a0PyR7/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FjwBudoq; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=XOp380NG; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6292ff76328f11ef8da6557f11777fc4-20240625
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=I7ww2mOxBVmmJx/Nl40l0XOXVxIzylakTzw7ICGJUfA=;
	b=FjwBudoqexmANTZYOwDzi+eADvEAtwkd2eZF9OkeMvhyHaq/XjK5nV0Fzlb1nRbJU/XK1Kh0iq8uy/fXRkvQiPh2ff50wrXPfzF8FUnUGmHGvnpo0S1/OBEJsgJDpfDWbSi+NVa1SOCgZhH5zVDe1GhWznRP8x6Khh4f4jrRRzk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:8aecdbba-d46f-44aa-ba09-61bb7491c5ef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:d6f16294-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6292ff76328f11ef8da6557f11777fc4-20240625
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1070804780; Tue, 25 Jun 2024 09:08:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 25 Jun 2024 09:08:07 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 25 Jun 2024 09:08:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ8W3/KBAYhZFaE/m/D4tLWQW+PsH8UnKd+7xCck0ISGhSaaELx6XfLsUB6QHiI+VpT6FVKuywJki7RMf2jNTL+LzAkijIBM1aXuYj/M/QHE45dmU0DrYT+a2CiFqx9V/nRm+cRRQIGYXlRa0NIB4WaT3mBFbkqrOz0sHKjLbxFGocvAxBScfxOMpnibOE2lh8xGhVh63tU6SxPkKT3NmSFRkvE8XYyJ8ZtkUBF2K+LMosiGuiGX0mwUS0oZna0gpny/y4gkctKo0W4QEgcfpA/sxcw6dSHw7X//hyKrnkubY5yUOih17Zja9kEVjE2soSog449vuEX2X38xqFRKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7ww2mOxBVmmJx/Nl40l0XOXVxIzylakTzw7ICGJUfA=;
 b=l86lvweE351rnHTGttsu2SsF8X77OzwEZ6Vnp2D7wqxCpVo2GH743fRl0CNzSgWCeiQ+e/QDdozRF4+8Td+WTrvGKx7aESwnx+gQxaknEeZM+R65fgP1y2aemBJKE+rOJbLsMjBcKof+Aiq6US/S4BiS2l9FwzfRO9FBJDGRMzs8ZtnRCnzlmLBtofFeyKGVx+yRZMVSJKpHqYGq8Puf0U+fom2bE6CnRt7+xYnMFMAn9EEI69hkF44wSvnsL1e8rwb3Xb/OH2VN0g/A25Md7SqIjAO9Zw0YxgtU9DhAwpiA87OE1Uz3zILl0+6w4cKOrldIAjWRw9SY7uqIfwMZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7ww2mOxBVmmJx/Nl40l0XOXVxIzylakTzw7ICGJUfA=;
 b=XOp380NG9NeGcu5lEOzQI/SepNi7lRJ1vrQcykLeMYaLODuyLdUvaGwEhrC7+w7PsP+gEP5A5m7YTtknfwdrR0nHgkOm4i4qN49qmuz3dVc7CDmrB6Vyco93wWQtPmrDy03emZt1cK+OgoRBQuRUhCPCeHfpblUTlHUJmjI1JQs=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by KL1PR03MB6970.apcprd03.prod.outlook.com (2603:1096:820:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 01:08:05 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 01:08:05 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] soc: mediatek: Disable 9-bit alpha in ETHDR
Thread-Topic: [PATCH] soc: mediatek: Disable 9-bit alpha in ETHDR
Thread-Index: AQHaxibAKPgz/W6sO0yAct40Ls6lHrHXq/UA
Date: Tue, 25 Jun 2024 01:08:05 +0000
Message-ID: <07a931ca249ab7de3d9c2412d5974ba6d36b2b1e.camel@mediatek.com>
References: <20240620-9bit_alpha-v1-1-13c69daaf29f@mediatek.com>
	 <171922725447.131974.17550647418404472695.b4-ty@collabora.com>
In-Reply-To: <171922725447.131974.17550647418404472695.b4-ty@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|KL1PR03MB6970:EE_
x-ms-office365-filtering-correlation-id: e9b27393-b3c9-4cb7-e33f-08dc94b344a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?bkFKaDh5aFNYUDBpckxjM0prMitZbkRjZ0IxZHM5NVNpNmI3Nkx0MkRzZjJ1?=
 =?utf-8?B?R3p4WlNvVVRHcnpWd3ZuOWVoeE9Nak5GakZzNEs5MktuemJrY01IUnFVZXhy?=
 =?utf-8?B?aHNpSFJkZjF1QzFmYURubzh5WjJjTGlUWm5MNmhLNm9haVc4Rlh5YXF6NVRK?=
 =?utf-8?B?U01kQUllc0h1S0FxY0hSb3RrN1VXRkZJcVdLR2d1eWF3YWx6V0JndXhRNjFn?=
 =?utf-8?B?NHNsUnp4bmhwRmJESUFnZVBLYW1qY3RScDYwc2NrUUFsUEpqYjZFYWV4MGEr?=
 =?utf-8?B?cHg5bjVBMWJtWkFHbEJ2WllkSEdiVkQzTWlmUEplTWdMUGpLY0REUGQ4NER4?=
 =?utf-8?B?UjhCWkM5cG1YZ0RqbExuUFNIWWU1dmZKR3pKa243NWVpT2d6MHRadVJPZWVC?=
 =?utf-8?B?N01uUzlNbGJyeVhFbktEUlNMS0tCbmtTKzE0UURmUWd2eHplNlI2R1BxMzZ1?=
 =?utf-8?B?U0cwZmRDWXBhU3VVcy9TU2tqbkZVamdBdHRXYm5xcVZCdjd6TjJYREJMMVlM?=
 =?utf-8?B?VVRNZ3VsSzZ3cU9EalJPaDdNcnVzWUNFQWh4aVhQRWY2UTUvQ0I2YXRnUHlE?=
 =?utf-8?B?c1VoMHdnb2o5Mmhocjc5M1AxSTR6ZUZVR25PQ1BKT2NQTTNTMnRjemhQcmpu?=
 =?utf-8?B?MWZxV2N4ZW5qZzloWmdQY0NsVTNxWlVpODNIK1k1eEh2QkRLZXRtelJFTWNH?=
 =?utf-8?B?Zzk0c1dMbHRyVnRLL1lkak0rSWVBNWtWbjhBRjBQaEEvWDJFNXc1MGlwdlF1?=
 =?utf-8?B?VEhjSXJzTExSd0dDYVMyRFRpUHN4OFJCWmlEWlR0MWE5em1Xb2tCUUdvNVlm?=
 =?utf-8?B?YjVsSWlJeUVVaGVHQnZEeTdlZGpUaEpGamh5N1d3bUg2OWVGdDRuckxaZldq?=
 =?utf-8?B?RWhITUszSmdBODdRTVBtRHJuZjhMYVcxN0hNeTZTQWtoaGNLOTFvWWtpUW5H?=
 =?utf-8?B?SmVCQlhheThwVU5Qa1poc3BoUDA1dGRiT3R0cEVPbHI4clRXbnNRS01iNllL?=
 =?utf-8?B?bkVXNTV2NGd2aG1xanNydnNRV1lPSEdMSi9OcndsUmorZVc3L1NmOFVRRHhj?=
 =?utf-8?B?d05udG9RdHBMUHdSV3NnVGlXYUhNZ1hNd0svcnRqNWhvMU1XcWVGekJNaWk4?=
 =?utf-8?B?S0lIVnZ0Szl1eDBtMmNiRUd0VWZ5QkpDaEJBRCthWlRIUjk3aGpYcStmZld4?=
 =?utf-8?B?RC9EMnVwWlRjWS9FZm41VWlubUhrN1kwWjMxZUIyNzRDb3FqMDl1d0hzNlY3?=
 =?utf-8?B?SzZBYWliREtpUFVyc0xUcXVMM212LzFnK1hSZGxLNkRZZ21uUElaZU5xcmtv?=
 =?utf-8?B?Y0tXT3ZYRTdKOW1rVW51OFJZSFBsWFJNUWtHNkF2dWwvT1paYUpEZnMweXJM?=
 =?utf-8?B?T0JXTnVLOFdpdlFjanREL1dic1ZTV09TSVpqdlVOcHJpL0crZE9OWE85SVU3?=
 =?utf-8?B?RGhjeitGaVhpeE1Cc1ZqeVlVOXU3QVhtVFpsYUtPSlNLVUNVRWpwem9EM1Rw?=
 =?utf-8?B?NXdXSDR5SmpIcGZ0Q0FlMUUwb0NNU3lhbW4vRVV4UkNGa3FlOXcyNy9hTGRN?=
 =?utf-8?B?U3dPL0pXdkIyMlIrN0lQYVUzVTRMK1BncW9mN1Bjd2RXcFh2bEY5dUlScGpo?=
 =?utf-8?B?R2ZSang5VTdzd3lweS9rUjdGc2lKR1BaaUdxOGZEWElmcDFoRjZWT1dUWHhK?=
 =?utf-8?B?cXNKZ3hMOEZnbzRZbm0rRGFBN0VDc2xKdHR5cnMwK0Z4dHlUeTNjZXZUc3hR?=
 =?utf-8?B?L3NsS0g5Y3BJY0VKYk1IMXBidlcwa1RzUjdNREhMYnRVbzNSRm5BazRTSit6?=
 =?utf-8?B?c3RUNG9INmgvQlMvYXdTYVVYR252clNaY1RLdE94eno4ZXEyYzJpQjNXTlhi?=
 =?utf-8?B?VVVBam1iTFl4WXR6R2hwa09tZFNJUFJnbHhrcDJSa0JtU3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXZLTGNLamJrNXIvRlQ0MjNaNndzdENjV09HQWFRSmZydGFmdThpZFJja0Rk?=
 =?utf-8?B?T1RuTG5aUHRydkNPNjZDaTFUbEZSaE42NWUvb0RRNnpTWE1vUlZtSHNHMFpV?=
 =?utf-8?B?Njg3UUw4amZPc0EzU1MyT1k0WTBlSFN4ZVhvKzVtTlcvTjhDcHJjbkxackNF?=
 =?utf-8?B?N2pPb1RmQW9kL3p5dXMxQVhUVldBT3AveElYaC9DNHgvaEFJWDh0cGR2cDEz?=
 =?utf-8?B?Q3Bmd3NSbUtYeTB4Vkt1VUJuMW1INnNrY2EzTm56YmlTY3lKSTl3WDlYMldr?=
 =?utf-8?B?eW56dlZCZEdxaWpUaWRLSmdGNjM4dFlyQWd2Z0dFSUJUcWVIbHBLZEs5dVZJ?=
 =?utf-8?B?S3pYcUdoRndsT1pzZWY1SzZRellOWU9ROFp5dDlQT0NPd1FZNGYvZ0lYbVRR?=
 =?utf-8?B?VEdpL2QycnNISDBIb2xiY2ZVMjRwdzE0SUw5ejIxaC9wOEFuQml5TkcxTExh?=
 =?utf-8?B?MG45M1FkMTR6eFlzN0tGeG93L3NwY1NvQmc1MFpjbHp4d01RWlJVM21RQm50?=
 =?utf-8?B?ZGlWV0g4bitGcXNpR2pFRUhjSjVqTzdGa2VUbEE3WW9JUTVMRDczQUg4aURl?=
 =?utf-8?B?Z1dyMmtWUEdSUmRMbXBPVTVDdjVHNVdzVnVDZjhwRUZTZGVUR2w5VlhiOXpn?=
 =?utf-8?B?eHR1RkYyR0l2ZHhBS043c3EyYStweEh5M3BGbVA2Q291K2w5V2VJM1lqTC9O?=
 =?utf-8?B?YzA2aE9SNmlNU3BwT1VtOEdDYlBZdXZyS0tGUW53bkk1VUh5ZXdmdHVLdlp5?=
 =?utf-8?B?bFppNGExWlk3ZDNqRzlJc0tBbDdnZEF6V3BlUVhId2oybWkyVkhpRTQzWTFy?=
 =?utf-8?B?QkRtT1JISXhjSUlJU1JXeUJDQ09RNW55M3FHcDhQMVRYd1RPV0tRa3ptRytH?=
 =?utf-8?B?allWaldoK3RqTTJidTZLdUxFWk1FRiswWFZOdjhCcjJpeXpiRzhYYlBwSTVi?=
 =?utf-8?B?ZlYxeExoSDN3VlhlUzNWekRJVUR0WXB1UVVUN1Y5ZGZZWjVmRE96Y2JvV29M?=
 =?utf-8?B?NkdBeU5acWxVMTZFbkRMU3RBMWIvTCtxSGtUS1BNVk5NR3IvcVl3aFVZR2ly?=
 =?utf-8?B?MEJoY0hjeVFFQm1MdGpBNWE1Y3dWWHJOdm1kUkpOWHhrVHkrWTVaRCtPeUtT?=
 =?utf-8?B?NjhYYUhTNkd0RUQrR1ErQmRrUmpqVVJ0dzAzRUlQcTlGM3FROHJyeG5XQ3dy?=
 =?utf-8?B?N3QvZjh0ODhZcmVzcUM5NFFnV25WZ1h6Qk9XZy9zZ0xTM3lxdWs2Z0p4cWhI?=
 =?utf-8?B?d3kwVFJvNU1vNVZnemRxWHlzWUtoMnFnQTVVb011ZjZMVXl0Mm9PekRVOEJB?=
 =?utf-8?B?cmJiNHlSUDc1QmxRY3ExclN0N3RJb3h5dng3bVV0VkVDbmhFdVBWcHlsWjI1?=
 =?utf-8?B?ZXdyR1diTkwzTlI2WGpxYXpDK0tnc2xkaXFjT3NKWHdIRU1UOFBsbm1MNURv?=
 =?utf-8?B?V0xyMnUrWlhXQ1N6aWNwc0l4UWlpVGFnZEQzd0ZoZlBoRUhVYnlocmJqbGtS?=
 =?utf-8?B?UXY0WEhkc2o5akFpeEcvZUd1WlNYQmJxS0tDdncyV1d1SVd1UnIveHZkM3p3?=
 =?utf-8?B?VFBZekdKKzV6UCtHendVM2pxNjU5UitheFVWenBXaEp2dG93YWp4QXVDSlJF?=
 =?utf-8?B?dU9XU3FpNHpPSm9DU3YwNEMrT012UnE2eUFOOHVvVlI4VXRDRzRGRldod3lx?=
 =?utf-8?B?c2FvcmFYalBFTG9lazFLcmNDRGNFMG1nd0l0RUNaaXdoaUtlQ3ptcXNBZEZr?=
 =?utf-8?B?SzBYOWpFN1BDR2FWbDFuL3N5TmsvMG44T29mbzRHN3R4eUI0bytUMnVtTWNi?=
 =?utf-8?B?QS9TdzNLaWEycWNZSkdCY2tzV2Q2RmNMY2kvSkM3cTRnTG1aMlZrbUhxWDJw?=
 =?utf-8?B?eU5tdVVJTm0yaW9jaWZSbUtmTlFpK2dvMEdDdW0wWGRDUGY3dHZEemVuQVNQ?=
 =?utf-8?B?SDhsR3JwY0dINFZCOE8xV0hVTXZIUVZGdXIzb0RhRTZnOFFEWlRmS2RzcnVM?=
 =?utf-8?B?UDM5WGRHcTFsdXdUTTBLdjllbHhUVE1tQUNxT0pMZVRJYlVJVXdwTVYxanJt?=
 =?utf-8?B?OG9BR3BkNVlGdU9rbGovWmwrNCtsUno1Um5PU2ZKdVJvOUVDK2gzUThjbmtP?=
 =?utf-8?B?ektHUWtNeUcvMFRXZWUxUnN0SWtEOGs5UDZaS0F5TUlhOVhoQjVMTUR2WmNO?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F34CC5338857294AAF2FE77017E14B71@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b27393-b3c9-4cb7-e33f-08dc94b344a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 01:08:05.1612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBciHR6sJryabBSDQPfruSyClgp63fEOyuGfTjVvKTqga3C3EBZSG01FEoxb0oQATd59NJnZrZWXAYGajpj/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6970

SGkgQW5nZWxvLA0KDQpJIHNlZSB0aGUgcGF0Y2ggaGFzIGJlZW4gbWVyZ2VkLg0KVGhhbmsgeW91
IGZvciB0aGUgbm90aWZpY2F0aW9uLg0KDQpDaGVlcnMsDQpTaGF3bg0KDQpPbiBNb24sIDIwMjQt
MDYtMjQgYXQgMTM6MDcgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0K
PiBPbiBUaHUsIDIwIEp1biAyMDI0IDAwOjUwOjI0ICswODAwLCBIc2lhbyBDaGllbiBTdW5nIHdy
b3RlOg0KPiA+IFdoZW4gOS1iaXQgYWxwaGEgaXMgZW5hYmxlZCwgaXRzIHZhbHVlIHdpbGwgYmUg
Y29udmVydGVkIGZyb20gMC0yNTUgDQo+ID4gdG8NCj4gPiAwLTI1NiAoMjU1ID0gbm90IGRlZmlu
ZWQpLiBUaGlzIGlzIGRlc2lnbmVkIGZvciBzcGVjaWFsIEhEUiByZWxhdGVkDQo+ID4gY2FsY3Vs
YXRpb24sIHdoaWNoIHNob3VsZCBiZSBkaXNhYmxlZCBieSBkZWZhdWx0LCBvdGhlcndpc2UsIGFs
cGhhDQo+ID4gYmxlbmRpbmcgd2lsbCBub3Qgd29yayBjb3JyZWN0bHkuDQo+ID4gDQo+ID4gDQo+
IA0KPiBBcHBsaWVkIHRvIHY2LjEwLW5leHQvc29jLCB0aGFua3MhDQo+IA0KPiBbMS8xXSBzb2M6
IG1lZGlhdGVrOiBEaXNhYmxlIDktYml0IGFscGhhIGluIEVUSERSDQo+ICAgICAgIGNvbW1pdDog
ZWIzNmFkMDk2ODE4ZTExZDU0MjU2NTcwZDdkNDllMjY1NjVkYWY1Yw0KPiANCj4gQ2hlZXJzLA0K
PiBBbmdlbG8NCj4gDQo+IA0K

