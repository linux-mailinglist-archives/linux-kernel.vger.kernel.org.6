Return-Path: <linux-kernel+bounces-327474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A87977669
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0642816DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4926EBA50;
	Fri, 13 Sep 2024 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aOinusi/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IpiHUVAN"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B478F5B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190727; cv=fail; b=CpzgYK8Ik5TYwxkH//C2vUJSqcUAiGnT7X4u4w/iZYooz8q0yKy+N8RMovKgE+IIrQuITUFEXlsC4uRZVJtxUUE6CvS3l0ecX13jrfbpiCpVKPhLzmWFeKD5n33R13RIzjcgFjE2qXmCPZ9kSI0ficMLM70vVMUxit1c4BPm4x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190727; c=relaxed/simple;
	bh=5jLn+HjyLOfrdtRFZwb0avdPbt4r3x0J71ZFPnzRF/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B4aV5Rpzxl/pUQAWXs1lIvnKxKw67mLjxP8O/jQYhQK8nIk61YGgtW9X/qoeaDRS1Fqok8h0N94YuUG2HZD4m7M6ZSXEfQ+Otf3MxkyE+eVNL5eIBn+88AjW2u83PQO6247q9qQ/Ip71NvBD9kp4kTLVHHyusAxaDagmIkP2nI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aOinusi/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=IpiHUVAN; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 09226020716f11efb66947d174671e26-20240913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5jLn+HjyLOfrdtRFZwb0avdPbt4r3x0J71ZFPnzRF/0=;
	b=aOinusi/vrywjHarajlOYI2OiTA9fqgmVQ8xu4RbnM+A9rcnHisxRRApKOQq41KWriH/drw0PRiBopKg1jtYo/hkEEXvfxt6/hSnNJ+tdyK97J1jrpsG9Gt+LDaS5k7mgCaWEc7lAcEW0m7Otdq8jxopGabxQdm85PMMoeDZpa8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:788527a6-082b-46e6-83ae-0a87054c5e55,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:988fe2bf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 09226020716f11efb66947d174671e26-20240913
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1621083585; Fri, 13 Sep 2024 09:25:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Sep 2024 18:25:16 -0700
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Sep 2024 09:25:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQIZljVOl8eb6KLbzGTnhz1UPCEB6SM75r7RN3SIJIUWCs2O0AmMhwBnF4uKzVpDj55ljNVYK5LrhK8I9vToUIpUCuDF+3xD+q2oelwJ9Ymb5bnHRws5DkUz+lJ7jKWvYZBK2DZ8zirk7B9RHERrLz7ufLfAShfhDAjcMVBBunaHKrIqzzkTHxRgAhcMwDVUmi8WXPMHhQXE1PIbCHx3AGdrwRkqNOEQlKzP9KlEdcSFfo6g/Pv7IkT2hzQBWh9njQqFZohH+PkbxW9Fjwf5u745HZEgXXI7OkJuWQiYm343MfBNildo6bXeStMeZrPovusOmn7+AgFRQB5XqZ0wCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jLn+HjyLOfrdtRFZwb0avdPbt4r3x0J71ZFPnzRF/0=;
 b=oAR/QsBolgjLOiWgUFCZEiljgs8P0V9ngXa5B4GKy6A0lGJWW27YyUueN/qVSBPuhY3M53YaBZuhnhx3RssB/3eoBYAX3WWrO28XX3V4fnrPVZKDxIhYe8Pgo547eJD7uFq1lVz2ucmtgwolcYNUuHqvNz6pvmSs14LwXDXK9dFYtagydTfw+JAUBuyYbSSG9/NBgEMpug1qyLpg8b/Jhbcvc9MbO4jw3W6JOoQccIKGhKWPP6sNrTle7zFwLN8ZzK3R6We9thxcLwlAD2q1nIS/5n/ywq9GHaL0AqJmPDfBVWrcVMlJx0ZLX2kjPWBycAy+U6srhVufGlxFrg8ksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jLn+HjyLOfrdtRFZwb0avdPbt4r3x0J71ZFPnzRF/0=;
 b=IpiHUVANy9GW84t1RCtinIw+uFpQjaHhRmkLrwsR9O6hqnyK0nJdcJ8P4jzdxhh0f3qu9bPtWR3l2xDo3gUSJs47DSnI5OczCmcf9PNVXq5z+kY1sZG3nSV7hQeSlH5l/ENQSOurI5T302681iKzvAMV4mJGM+IlhsO+oCFG0FE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB8453.apcprd03.prod.outlook.com (2603:1096:101:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 01:25:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 01:25:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"shawn.sung@mediatek.corp-partner.google.com"
	<shawn.sung@mediatek.corp-partner.google.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 0/5] Support alpha blending in MTK display driver
Thread-Topic: [PATCH v4 0/5] Support alpha blending in MTK display driver
Thread-Index: AQHa2AmroDt1y/BtDkmY4b/bkxAN0bIQ7LWAgEQIBACAAFLCAA==
Date: Fri, 13 Sep 2024 01:25:13 +0000
Message-ID: <a2cf4e9b9c3343a7398521760934f1740505aa13.camel@mediatek.com>
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
	 <CAAOTY_8ThuusfHk9Gd5pFP8VhJkG2seuJmkFiruK1rPQFZGBzg@mail.gmail.com>
	 <6c9b7f85-f92d-44ed-ae9d-00f6d55ea614@gmail.com>
In-Reply-To: <6c9b7f85-f92d-44ed-ae9d-00f6d55ea614@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB8453:EE_
x-ms-office365-filtering-correlation-id: ea534736-4344-4a7d-38f4-08dcd392eac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cWZDREFNRm5IejhaUFBuZXpTZFYvR0R5aTBOaXExanlXRm16dXpzQWxiYzg1?=
 =?utf-8?B?WDJmaDRmN0RGTmtrTHdnOVgyTTRldlI3UE11blc1SUxpY1hsWVB1aDMrcTBB?=
 =?utf-8?B?TFplYWo1Qk9wa0pHNzkzbnZDbW9uRkl1WDV4aE5BS0pmZ05GT0dzdlBRYzFi?=
 =?utf-8?B?c2NLVXdUclNUSEhnTEN3djJWOEdRZks5Ulp2b3JIakw4OGlXL3Q1eWptZDVP?=
 =?utf-8?B?YUJ0eDVUR0lpdEVaQUdsTkMxem5wOWk4Z1IzNUcwTmVQck9oS0tLM09jVXFw?=
 =?utf-8?B?SzRuQzc5cWJZME55aVRwUW84SEliT2tpVkszRkozbXo0M1dIY1BnNk5senRj?=
 =?utf-8?B?eWlrZjJ2Mm1IMW9zV1NtVUU4NmovNGN4ZFJmM3VPdi9rRklFbCsveDVXL2xs?=
 =?utf-8?B?VzNnWnYvVVlvdlc1bDVKNWNLRVJtdmUrdUd6cm5WSWZ6eFEvZkljM2JJbTZN?=
 =?utf-8?B?ajVZN3l0Z0hrL3pqR0hoYkV0ajl5emtVNUQvZnU3Y1BTNHpoWGpRdW1TY2Zw?=
 =?utf-8?B?dGpOYWF3QWc1L2ZOQ1cvelFNWHdnVzIrSGJWeDJqeGc5NFRjcEIvTmIybU80?=
 =?utf-8?B?QzZWejhxTk5uTVZOSUtSeGdCVzdyMEwzajBKcERSb3BnVjZON0RETnoxcjRX?=
 =?utf-8?B?b2ZtUGhEWlFvNGhtdnYzdVY3MERVRGRiNVpaTllUR3RqaVpITXlhOFBMN29W?=
 =?utf-8?B?RE00SGRyWHFuWU5ydXpVU1U3ZHROTGgyWTIwVTQwK3QwRFZYL21weVRQOG9O?=
 =?utf-8?B?SWUvdFhUcEdEaFE4YUk0RllQekRpVXMrd2E1eE1PVFFkZGNxMmlkdWNvRHgw?=
 =?utf-8?B?SVZOaWRiQUk4Tmo5eVdLb2U0RC83WFhxR0M4ZmxrSko0SVRRdGdXWGlNeVQy?=
 =?utf-8?B?bVJKL2dIRFgwSkNnRlpmczBrV2lQa042cGlaU2krbDVTYTNzaHBwNnJTNkFi?=
 =?utf-8?B?c1Rva1dwSDNiY2VheW9KbmV2Sk5CSnBQZFVibk9KbWNyYVpNL0NRU2NhTXk1?=
 =?utf-8?B?aDAzMVVKZkczTzNocThBM3RkY0h0K0RHWUwzZ2p4TVNINmR2MHdaajN5RVJO?=
 =?utf-8?B?MDZBaFRuNlVBN3czUk9uVGNDdWp6bXFpcmxOcWxJaHhlUk5TMVR4cU5HWXRP?=
 =?utf-8?B?VEVGd0I4NkVVVThMVG1sY0JIdmpkNjNNcTl4QnJvUnRweHFLWHkyVHcrU1Vv?=
 =?utf-8?B?aVhqMUw3TTNmR0JYbHowVDFacWp5N1VOVmViQjJxbkRIU2xzZkdKN2x3dlYy?=
 =?utf-8?B?di9MSW4wcTNLeTZycU91SHArZFZpa0xIdHl2UlQxaHFjaFdrT2ZHQjlaZHdH?=
 =?utf-8?B?S3JaendnNjRiUzdnMkdNTWRTYjhmeGxUVXZQLzVvZjlCZ0Z5V3gvUXF0Uitx?=
 =?utf-8?B?bXN0QldYZXRwYWk2MmdDNVBkVUZSVE1jOFgzelV6bzFReXJ1MTZFd0dYeTUz?=
 =?utf-8?B?UnF2R1BOem5ianZaTCtBaVJCSUE2aGFCZzZrUytiVXlSU0l5MTNoalcxK2k5?=
 =?utf-8?B?elV5RXJRdk1oeWVQOGtzNDFDY0hzK0tTaThQMERWK3hiUkptZWtkQUNmVWpZ?=
 =?utf-8?B?SzQ1RlArdjRVb2htd1dubGV5czgzNmI3RlIzZ1pPMk0zOFBFWmJuS21tSW11?=
 =?utf-8?B?ZDVrTGR0TjhSc3VFNUpSMFhtN1pqcHpNZGVEMmt1dG8rNnc3TjYvczZLNVds?=
 =?utf-8?B?V3hhK2g2VmxCUmw4cmQyR2RobVJwMzhNYjlTTW8veHhtK3lBRVlJcWU5YUxw?=
 =?utf-8?B?T3JvaFVqZkhyaEZUcnM5TTBOYm93TlM2VnNuNkREczJ5MG9venQ0UWtGSjlE?=
 =?utf-8?Q?LLkLsE7ncHVt8jexo5YY5Fjzf+jzmz5nL2OOE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkU2SUJtQmlheTRYeURlMzhoUHEySVdRcnp0TWF2RzdXaFV2ZWZrRVVoZXBG?=
 =?utf-8?B?aVNESWxzZzltVHhCc0IycmlXZUhNY3J1Tk04b0xla2NGWUk2TEpCOThJTU02?=
 =?utf-8?B?MHBaM3B5aFhRWkozT2MwVy9PZTF6TTZlWnR2ekFkUzJHeVV1VXdmVGNhRnZ0?=
 =?utf-8?B?VCtNMnd2bDgyNktWYmZURHVFY2JNdlI2bHI3Y3ZZUHdtcGxyQmdXK1F3TUpP?=
 =?utf-8?B?dlJWUUp4MnpIVy95eitLL0RRU1N4UEhyOWNzTXFjV1ozSFdxQXB6L1poVFBr?=
 =?utf-8?B?MWM1VzNaR3dTZW1ibURHcHNlaW8vNUsrSDBTZGhGK1pCN3pUTVFiTUIyWEdk?=
 =?utf-8?B?L1h5SmNwWWpFaVE2S1JXaXN5Wk9MVG1wV1FabEZHckdFVmg4ODE5Q3hnYzdR?=
 =?utf-8?B?Z1QrQjhNQjBGODJiWVIwM3h6N2t4SlpkSkFYVUNXUFN5OWZLRDhTUXpkd0NS?=
 =?utf-8?B?Sms4ZWc2WUxwVThMVCtFK2RRbk0yZEpmUjEwM242bWpQTktQbnR0T1R6MlVL?=
 =?utf-8?B?SjRWQjRRd0grQXBDUTI4R0NkZ24xWTlTU2l4MlltdDJKUFgyRjUrbEppc1hR?=
 =?utf-8?B?WDB2SDFPZlJzWXQyVUVRcUl1M1Z2UHZNTE5STlJoeE1tRlRsdGh6STlYenln?=
 =?utf-8?B?NzQ1cDVMYWN1YmJraEwzTm5QTnR2KzVQaURtTWE5TGI2TlYrUTJYR2JFc24y?=
 =?utf-8?B?ekNRWndaREx2SGd6SHd5TFVPZ1BhY3EzaGZpQ1l4NVlZenNvRmFFdDA5ZHYy?=
 =?utf-8?B?YXU0VkdTYTdCem5iWlpuNEtONS90L2hwUEpYbXVlQURCK25yVW83eWptZzVi?=
 =?utf-8?B?VnZxeXZyOGxLMm53WDFhZmtacUZOTmV5d3VscmNMcWRUZ2VoRGFRWnpyeUJ1?=
 =?utf-8?B?Wkd4dTh3alNHNEZNcFFHSml2S2FIWEFpeTlqV0R4V3F3dU4yeFRrYmJwV2Vo?=
 =?utf-8?B?K1BjZDYrdmw1eXdVZjF3TWR6OHdtUjVKY3I0cHd1TkhWVlpUSnlGaXBDWCtV?=
 =?utf-8?B?Zzl6SDJzZW5ZalFzYVg4UGJLMFJGUHQ0d3U5dnRoeHhaMzFQc1dITFZnV3dE?=
 =?utf-8?B?KzZGTTdVaWdOYTduR2RZVDd0cTZuL09UWmJmcllaaXVTelJFTjVTWnU1N1Jm?=
 =?utf-8?B?M0o2QzQ1VENmKzcvVi9BMFBlVFpwWkIzRlVCc0FVTWc3NHFzT2IvWE1KVFU5?=
 =?utf-8?B?TW9ValFGVHFFamhMbHl5MU9sekhhOTZTbkR0R0EvcUlKSitXRmdDaVRwbVRR?=
 =?utf-8?B?RE04Mm9lWU8rdVd5VGdhU2JIem5ZWTNSaG1hRzMwc2w0bHFyVUtubTBMT29x?=
 =?utf-8?B?U3lCYkY5SEhsNzBaalI1ZHpkZjdRcmpzNWNzM1hYRXlPNUlzWUtzZXZxV1Vh?=
 =?utf-8?B?SUlvQ08yVWJqUWdaa2U0M3d0YUdWTytiNngrRjZ1aHlwRUoxNTlQWGNYNzlL?=
 =?utf-8?B?NCtJbDZGWDFORmxaemUweUp3U2kyYThBWnBiUEFRWjUxYnJ3L3UvRC94QjlS?=
 =?utf-8?B?eXhtVkZ0NXlCU25MMUFLanFZUjdaQkdLRlZveHNFeTRNeEN3bHgwTmhmcjV3?=
 =?utf-8?B?a1lmUFEyaktleWlwR0tISjdDK1BYWUNrOUV3bFBtT2t6d0JiUU1sMmQxcE83?=
 =?utf-8?B?OTc2dGdQUGh1anZCaDMwWlNXbmJPMHphUTFEN3hocjRRVUlXVGE3eFBrdTF3?=
 =?utf-8?B?VFQ2TGswZy9WTWg1ZUlJTXEzUEtKRDAyUlErNTBFM2JZYnhPVXA1MllFQmY2?=
 =?utf-8?B?RkFaOUVtNC9CU08vQ0tmTW5VM3ZTZVBDYTJyRDdXQXJremVQZGM2MWFDR0N0?=
 =?utf-8?B?eGgvQW4yL0JUSHh4eVhzOFBHbTQ4OVlrcnpwRVUxZzRtWlJTY2ppV3FHQWNP?=
 =?utf-8?B?d2pnWGlscFBWdEYzKzdORWs2eWxKdDlkdFZpYkN0OVArTzZpamI3SW5VRXJE?=
 =?utf-8?B?b2ZISk1CVFVSQllyYlRMOEFWYlhuVU5Pb1JQdlBwTlJ5Uk1YbEs3eVVnb0F6?=
 =?utf-8?B?NXNWQTRMNXhTeldaVDlYdUdNQXB3SmRlM29nMWlTR200bEpLaUZ0TGtsY3FH?=
 =?utf-8?B?bndpeVlNY0R1WU9YMUdPNjQwR0x2NVpIU2VlY0JwWTZlMlpKTFgyQ3NIWTl3?=
 =?utf-8?Q?CNTIHMINi4QcB6+7tH27oBuGs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE541A1BD1F73C48B50F72027464CB15@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea534736-4344-4a7d-38f4-08dcd392eac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 01:25:13.7143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0+7BSVhZKK/i+ER84TJXywhY3cYe6R4l58WcylPhwKYFxMki/2VPKn63jHh8b1YQkr9a2uZTOfOzlbcTs9IOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8453

SGksIEphc29uOg0KDQpQbGVhc2UgaGVscCB0byBmaXggdGhpcyBpc3N1ZS4NCk90aGVyd2lzZSwg
SSB3b3VsZCByZXZlcnQgdGhpcyBzZXJpZXMuDQoNClJlZ2FyZHMsDQpDSw0KDQpPbiBUaHUsIDIw
MjQtMDktMTIgYXQgMjM6MjkgKzAzMDAsIEFscGVyIE5lYmkgWWFzYWsgd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KPiAgSGksDQo+IA0KPiBPbiAyMDI0LTA3LTMxIDE2OjM0ICswMzowMCwgQ2h1bi1LdWFuZyBI
dSB3cm90ZToNCj4gPiBIaSwgU2hhd246DQo+ID4gDQo+ID4gSHNpYW8gQ2hpZW4gU3VuZyB2aWEg
QjQgUmVsYXkNCj4gPiA8ZGV2bnVsbCtzaGF3bi5zdW5nLm1lZGlhdGVrLmNvbUBrZXJuZWwub3Jn
PiDmlrwgMjAyNOW5tDfmnIgxN+aXpSDpgLHkuIkg5LiL5Y2IMToyNOWvq+mBk++8mg0KPiA+Pg0K
PiA+PiBTdXBwb3J0ICJQcmUtbXVsdGlwbGllZCIgYW5kICJOb25lIiBibGVuZCBtb2RlIG9uIE1l
ZGlhVGVrJ3MgY2hpcHMgYnkNCj4gPj4gYWRkaW5nIGNvcnJlY3QgYmxlbmQgbW9kZSBwcm9wZXJ0
eSB3aGVuIHRoZSBwbGFuZXMgaW5pdC4NCj4gPj4gQmVmb3JlIHRoaXMgcGF0Y2gsIG9ubHkgdGhl
ICJDb3ZlcmFnZSIgbW9kZSAoZGVmYXVsdCkgaXMgc3VwcG9ydGVkLg0KPiA+IA0KPiA+IEZvciB0
aGUgd2hvbGUgc2VyaWVzLCBhcHBsaWVkIHRvIG1lZGlhdGVrLWRybS1uZXh0IFsxXSwgdGhhbmtz
Lg0KPiA+IA0KPiA+IFsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9jaHVua3VhbmcuaHUvbGludXguZ2l0L2xvZy8/aD1tZWRpYXRlay1kcm0tbmV4dA0K
PiANCj4gSSBhbSBzZWVpbmcgYnJva2VuIGNvbG9ycyBvbiBhbiBNVDgxNzMgQ2hyb21lYm9vayB3
aXRoIG5leHQtMjAyNDA5MTIsDQo+IHdoaWNoIGdvZXMgYXdheSBpZiBJIGdpdC1yZXZlcnQgdGhp
cyBzZXJpZXMgKGNvbW1pdHMgMWY2NmZlNjJjYzA5DQo+IGViMTdjNTkwOTQ4MSBhM2Y3ZjdlZjRi
ZmUgNTllOWQ5ZGUyNWYwIDQyMjVkNWQ1ZTc3OSkuDQo+IA0KPiBUbyBpbGx1c3RyYXRlLCBJIHRv
b2sgYSBwaWN0dXJlIFsxXSBvZiBzb21lIGNvbG9yIG1peGluZyBkaWFncmFtcyBmcm9tDQo+IFdp
a2lwZWRpYSBbMl0uIERvIHlvdSBoYXZlIGFuIGlkZWEgb2Ygd2hhdCBnb2VzIHdyb25nPw0KPiAN
Cj4gKEknbSBidXN5IHdpdGggdG9vIG1hbnkgdGhpbmdzIHNvIEkgZG9uJ3Qgd2FudCB0byBkZWJ1
ZyBpdCBub3cuLi4pDQo+IA0KPiBbMV0gaHR0cHM6Ly9pLmltZ3VyLmNvbS90TkZ2b3ZCLmpwZWcN
Cj4gWzJdIGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0NvbG9yX3NwYWNlI0dlbmVyaWMN
Cj4gDQo=

