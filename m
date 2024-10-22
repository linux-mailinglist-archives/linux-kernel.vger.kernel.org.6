Return-Path: <linux-kernel+bounces-376069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610AF9A9F89
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78121F23D76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11397198E86;
	Tue, 22 Oct 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cXr/y+Hg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iVcRyb6/"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740C19005D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591519; cv=fail; b=E1MEPLniRTjvYBZ+vTYfsglwLkilW6kikNfO9fdL6B9KjTxFeQwqWPlxtZA8HqCly89m3LB61u7HAka2Xw5mQ7G7wwrUWqLznzJwd0G64RzWHcH6Xv6Dr1dgxWrgsu+NS6p4LEIKvzKtCU2HDuE17P4tzXYvVLs4moTlRFBiIGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591519; c=relaxed/simple;
	bh=LXpCDWx4YcsgpPNSQn1rl42koQ3SSevVnZHlHF/xjqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FKTNQquwzv95RlyRmArIBNLHILlsW6hm+METLlbWOXip94RMFZ/DtGUuONW64TFi+5pZv4Lz43/8Uc1qtR+ep3+pE0IdE982F7tEmHv4MGQeZgcrYNYWLMVhNHkFR7Gch9MAFDA23BcDEjD0Pcq2tbsBbZhGjZcHDtJDE6JAGA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cXr/y+Hg; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iVcRyb6/; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1e2c2354905d11efbd192953cf12861f-20241022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LXpCDWx4YcsgpPNSQn1rl42koQ3SSevVnZHlHF/xjqw=;
	b=cXr/y+HgH7Y1ByChkNJtZNJPmT6FmsfEiIw1Zj0VC2KUJwNArqn/hARtJITkIoz0k61bJER4MWoiF0+Ibx8IuVybEZDoqg6xt/njy6geSfSDXIlfBLydTEyxy90J0tnpFqI+hXZvKxprL4M/sOgOud4agal9oi0IjOOSjA0BD24=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:d15ed444-1c94-4c86-92b4-52bc65f2c443,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:c5477625-9cd9-4037-af6e-f4241b90f84d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1e2c2354905d11efbd192953cf12861f-20241022
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 183120901; Tue, 22 Oct 2024 18:05:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 22 Oct 2024 03:05:07 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 22 Oct 2024 18:05:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQxn4UVMk0WypMDKiTcVrhV0YcG4dgGpmTD74cXSqUxqaAT/5Eil7bRaw+FtFaSFbvuK2InVRbQeBHru3CCi0l4/jd3sFpe9/caAdfpk7NZ7lbWIL5deWjeGKbE7TCdK5RfNuT01NqqFtbkuXuxFBfcSI3J9hB8IvwIDplcycCEQVIfq7QrIYOHwCxkdiw5n9sr5qU0ZuYXPkyIqkvDFuodVUxw9OcLE3tcUQFdCkk7Jb0YDV+0thQYRqM5ksgUU2rvDCQ1PZ24Ub0x6w3pG0bDkRV1/DAnmS2kt/7u8R8B4VllwZb31+vTCmgKFLcFSJCAir2YE0x2G/j0NfhtJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXpCDWx4YcsgpPNSQn1rl42koQ3SSevVnZHlHF/xjqw=;
 b=rPPje8eQqeCfq/gqXqMUyz3Ty8ZApmoC9suyL0s3NgFQO6Fzh+v/BAqdTd/GawsztZH2DRKpwtMzUi5A+59w/a1IBTxFAknE5ozfUUA06DIyJ7v6sLIsA7+Bqv1FYdeYYj3FWUxM1xG6DtoO0ND0qpBaCNX8ofAvd7iPe5g1miIQhSRRVx4EbcQHIWOkIr3K+vuRsyDA0pyheLR9W+brmZzNC2205WLMCJSOA9rcgZ1j2vSVKMEr95Js+KTtAXUyj57C0/WVTp5ux8Y1YxkK5Fbg0PqfzzAxrzBADEDFztNUiejMAXLfsbJCVK6JWiP4C64O1O2SrrcZJZOEpZq0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXpCDWx4YcsgpPNSQn1rl42koQ3SSevVnZHlHF/xjqw=;
 b=iVcRyb6/0TEEWCM7oSAR9UK+rbZr3hqek+E3EWWANXXi04vznn+vKO9j2yF260Odln8BiQCyOOueaNywM+U1oNTShgGR2Ub2ThNefvI0R2rmKgqTbUrEs3NHvBfqJAedCIKSaBgmp21LouH6ibrOQBFZLxhq1JlvIu9EBrsJzJA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7861.apcprd03.prod.outlook.com (2603:1096:101:178::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 10:05:04 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 10:05:04 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?UGVuZyBMaXUgKOWImOm5jyk=?= <Peng.Liu@mediatek.com>,
	=?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, =?utf-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?=
	<Liankun.Yang@mediatek.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"msp@baylibre.com" <msp@baylibre.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "dmitry.osipenko@collabora.com"
	<dmitry.osipenko@collabora.com>, =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?=
	<Rex-BC.Chen@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1 1/1] drm/mediatek: Add return value check when reading
 DPCD
Thread-Topic: [PATCH v1 1/1] drm/mediatek: Add return value check when reading
 DPCD
Thread-Index: AQHbExoGHsA8zyJgXUy0+IrlnLYbArKSrYWA
Date: Tue, 22 Oct 2024 10:05:04 +0000
Message-ID: <7d712b16109d3a2c8a5704ad8988f961b71a40b2.camel@mediatek.com>
References: <20240930092000.5385-1-liankun.yang@mediatek.com>
In-Reply-To: <20240930092000.5385-1-liankun.yang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7861:EE_
x-ms-office365-filtering-correlation-id: 2674ba28-b2c4-4d4f-ad04-08dcf281001a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NmhkcVVkN0FjRlFDNEMvSjNTbVBPVjJ3Ti80TWFyNVVpZzBhcDZBRzFrT2Ew?=
 =?utf-8?B?dDBHVUVDLytIVnJsdTRNZ2Vqa2ttUlYweXlDNXYrVmZxSzlZcEpra1ZRMFkv?=
 =?utf-8?B?MzgrMTFYQXV1blJ4TXFEN0V6OHNEK0VpSUlBeFZpU290Mm5LMkFrZEhHR3BR?=
 =?utf-8?B?OENTME5QZTlrZjM5Ym12N2Vud0V2UGtYd0RJbEUxWUU0cEFveUpTanJoWVBG?=
 =?utf-8?B?ZG1LcmJOV0x5UGxUckpoZEJTeFFXRkNLRktSZ0tmOWM1Q1E5TXVyRkJ3SVBO?=
 =?utf-8?B?TC84ZExCbi9Cd1ZKZy9sVWVnZ3Q3Lzh5SjdhYjRUVnpwSUE5eURLSUxVOGVx?=
 =?utf-8?B?UTJIc0V3dVo1L09BM3YxNUhvQVM2a3BLUkhkWTlYeDUrWVZsQzdZcVpzTVph?=
 =?utf-8?B?UUI3UmpjMUQ5VDhOZmpPeURkSmhvLzBvRFcwVmZWY05qYXUySFh3aXp0cERm?=
 =?utf-8?B?SFhLL3A4UmJLblJOWDluOEE3N2hGMncvb2pmMk9rUGtneU81NHdXa1NQcmdL?=
 =?utf-8?B?bjlIeGtZV2VFK1UzWDR6WUNpRC85dFVURGFRYnVYSWNRUHVqUG9vVUhRVTVV?=
 =?utf-8?B?NFArNUZkaEFETUo3eGtSZWo4ZitQRmxDQlo4QWJSenNXN2JBU0F6UzJPUUdM?=
 =?utf-8?B?WTJ5amxYZmN2dnBPQXNyM3lsMVc0MEJuK05XR2VWVytYdUpUYVdZWUllRXgz?=
 =?utf-8?B?Tm5ZZEQzYzJZR3ZHNVZTRzMwSkFvSlFWTzJpUUNLSkt4U1lRcmI3cW1veEhW?=
 =?utf-8?B?QWh1cTZxSnZ2SDJDbmdJQlVkdHBPWTVzdUZSWHNWSFdQTCtsb09BMmcvbG9q?=
 =?utf-8?B?MHhVSkNJbVlRbFNyTUdpUU96cForZFQ0MmxOWktTekRUQ2VoZmM1ZnVMNVJs?=
 =?utf-8?B?VktQcjJxSXh2RXY2d2tBN1RzYmh1QnM2MyswTWoyaS9NS3lZL0ZlVmZSajNT?=
 =?utf-8?B?dVJuSzZSZGlLU041MkxQa29iY21WdTNKbUNhaXBocUF5eTgzazJKNFJTMFUy?=
 =?utf-8?B?UmpOY2k4WUUyZ2M5eENWbERZTFBKMnZmUFdtZFpIZkxTRkRHZzladEZRQWY4?=
 =?utf-8?B?MFFZbWxzcnR6N0dWSVFwTkpWMEtpamk1YkpHWWQzaXp0N0F6cHNHR3QvM2Qw?=
 =?utf-8?B?Q0U0cWlpUmc1STZDNDV4ZjJXWWs0enhZNkNzQkpsb2xKY3RSU0ExL3hWS0xa?=
 =?utf-8?B?SEk4RkJqaHZqRDd2dGxmYytFVEFaUDV2WUJrWFE4S25pTmU1UnVDbVJwYWEy?=
 =?utf-8?B?T1QxSGkxQmV6YjR6QWxEdW1hbzc4TWNXNDNoZnpFZzl2WGFDd3pWUytBaks0?=
 =?utf-8?B?U2hFcmcvYlFqem8zNkMrdmV0SE9XaG8xSnAwajVSam1kaGJWWWROeFArT2hL?=
 =?utf-8?B?UFZKSStObUc4MlJJbWVVRGF3KzQ3QVhsZGh0Ymc4eTBrSDlNOW52SSsybFc2?=
 =?utf-8?B?dGdLeDc5V05kUWIrQ3hXbE4xK2NYQzVWODZQK3l6eWR0c0ZxNnV4NGdZR0VU?=
 =?utf-8?B?L0RuUlBEUTJTeVlMSVRXdFRvbHl5dUdnYWZVU2toSUhQU1Q2UlQvQmJkbWhm?=
 =?utf-8?B?UXZRWHdJWVNTZWpzUHIvbnI2NjF0UUp4RWUySUtzSnBIU0JoQ2R6TXIrcHZH?=
 =?utf-8?B?RFdhb3dYbkFKeVZrWTNyUGFhdDNXeDVUUkdqN3VwaFVZdmlVNkh6eGVHUnFN?=
 =?utf-8?B?eDUvcnFTcmRTSVgyR3pXMC94dXlsWHNLb0wzWGV4R0wrSzR1bXgrOGsrVS9m?=
 =?utf-8?B?SWV4MktEOGlFbi9KcTluWUNSS1BXSzVyVmw1MHU3L3R0eWwyMTBlQlNQMDVX?=
 =?utf-8?B?cVZNNGRlL2NhUjBOV1V0S1d3YnN0clJyMHZ2WWx2MEJtVkVndWJrUWJOOGFp?=
 =?utf-8?Q?OylcldHJvYKTE?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmIrclhoeHdUK0VzQ2E1WFI5SEVSRVpPZHJjVGtJMnk2dHpLdlltSVZacjFq?=
 =?utf-8?B?ODc1R3VCY0Yvb2dxTG16Z3A1QU5VK2ZNSEdlbVFweGdSNENEZXhZMHoxMk5k?=
 =?utf-8?B?Lyt3RFJaVVF2WnVuenkxNkVuZTFFTlI4Y05iR1N1V2R1M3NXZWFZMnliRmpX?=
 =?utf-8?B?WjZrVFh6cTZLQUhmSGR3Y3VQenIxeVI2Y2ZOcmQxR2NtTkVrM2ZvWlQ0L1lr?=
 =?utf-8?B?ZG1FeHJHWlVYKzc0WVI3emV1Y0Nwb3FnbkpOcit2OXJqYVpRVFM4ek5PMjhh?=
 =?utf-8?B?alo5eTNwa1UxdmhUL1lXUVpUNmlNanNnZE9oTDJXcFRlSCtIa05BdDVtOVB5?=
 =?utf-8?B?aTNxcHp6bGovUWtBeHl1em1EaUNFRGpyL2hsQWZ0bUo1eTVIMXlTQlRUdGVH?=
 =?utf-8?B?NW1PWDJLYzgzZFBKRVZ4WnFVU3BqQzhPNU5kUU5DR0VOY2h0UzIzM0FCemVj?=
 =?utf-8?B?QWorSG4xRHNHL0xBV0tMdm4rSVVYOThKK3kwU3BPc1plNkZ0aUtsM25VWk5z?=
 =?utf-8?B?MzBselMvYzBYbFNZOFNYSVBRZ2NUdEVrcmNHVnZUSG1SVzdIM3Y4Y0NiU2NT?=
 =?utf-8?B?VytTdHBvUlo2dHcvM0J5ZlBBaG9oU2hhNjByV3FRZnEvK0dWTlM5MS8wRFRZ?=
 =?utf-8?B?TVVRRzB3UWRmN05WbVY2TzdkckJDaTVPa0tqc2didU9MRFVzRDJnaGQ2THJy?=
 =?utf-8?B?cXlrU2czN0JVbjJVZ0ZodTJDd1VvTTJYdmhLaVdnWHpwSkZkdy9qUS9qZkgw?=
 =?utf-8?B?QmdyMG9HNGxReXNLamFha0pUQ29aU0kxRkttQjJEWTRSblRGbWZHMDdRdjJD?=
 =?utf-8?B?a3ZGaDcrK3cya2tmdXBETDd1K3Aya2l2SjNZMWszbnZYMCtLVWU3NHJsZ2JT?=
 =?utf-8?B?a3VpeElnVWZwcFhweWhnTzJLTjdyK0Erc09Od0VUeE5ZN1VqR1JHT0haQXgr?=
 =?utf-8?B?d1JOdmdDNURLa0R2Z1JCRnIzc0t3bi9ZWWQ0Ym50ZGFGNWJDZHJLYnVNTkJw?=
 =?utf-8?B?VmdnNzl6S2R1YWsrMUtvbVorR2JwREJreTFpSDkwQjV5WGROcFhGc2Vlall1?=
 =?utf-8?B?R3NxV2ZrTUpYcndKbUMwaDQ1TEhNKzQ5cFN6ZEQzdmEwV1o5YUlvb3dmWHVu?=
 =?utf-8?B?a3cxM0Nvdklnbm1EMDV0cEFIUlJ1WFRkTi93UTZxaitBVkpaeXpqSDNuTURs?=
 =?utf-8?B?dDdEbWFzbFNOdkZ1OXNLV3JLQkMxbnZucUFGZUFKRkE5K1QwbVByNkZXcFFr?=
 =?utf-8?B?cDlqS0hJOVFuK004SlBGQnlhMTR5RHRNMGpRVUJkeHc4MDV3dEV1MXdTRk1r?=
 =?utf-8?B?UGh4RWFMc0hGejExQWVvcFFJajlEbUNQRXRZWXQwaW96UHliRlNoODVNRk1S?=
 =?utf-8?B?S2xHZEZidjZRejZQZ3o5QkhkK1RGRFFua1ZwRUIyY1hSTUQ5WmlwZk5oN2RR?=
 =?utf-8?B?QWtGckl5QURHRDhKbGFydllXRWpNakFQRTZ3Z1k3UHh4NzhHc0gyWm5sTmtX?=
 =?utf-8?B?YlZQeWxnR0dIS1J3b3dsUnN1aW5zd1pESzVFZjRJTmp5bXBXOE5ZdFhoNk51?=
 =?utf-8?B?SmcweDBtclpHT1picjRKdzhhVkx1RjZBQjVQVXhjWXl2VVBPdTZEQUE5cHdQ?=
 =?utf-8?B?d245bU5hZTdVYmlWYXJSN3c5ZXB5bXlVV0dBaGdHTkUyU1ZYT0NHR2tWTENV?=
 =?utf-8?B?ckRQVWNrOVhaZ0ZkdWxvQ3A0UUhvZEZUMS93VFRtSUZJZFlmY0ZTQkRpMHJT?=
 =?utf-8?B?M0xFTWQ4NE5IcElPSG5mOUNvZjVEa0w5NWpxR1FOWjZxTVp2akNocWhYUXd3?=
 =?utf-8?B?NzUxY29zWWxMZ1EvOUJBc1ZERUw2ckVhcVp3azdEaWNFN2JiOG1ka21DN282?=
 =?utf-8?B?dHBsL3NXWFdUUVdGbVp2NjFYTytZc1ZDMDUxRUlaeHpxdUp1VUlyVU8xRUU2?=
 =?utf-8?B?aERrZnJyVmJOTGdKRmpVUEtFVmMxbWdLZGlBaXJwWVNhVldCZlVRTm8rRGxK?=
 =?utf-8?B?RGExOGlURWNsWkNGRytLWWh5SUpaRUJOK1RYUW1vOUJIRzkzVlVpdjVKTUti?=
 =?utf-8?B?Q0YzWGhvMm91OUhkL3F2Wjg3clg5a2o3eVFZUFlZZDdWamI5dXdVaUc3MkxV?=
 =?utf-8?B?UjhYZ2YvbWlRT0F3S3hCbGJEclNhcWdoalMwNDdtMWZyQ2ZENEpMckxCYW1j?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2E3BA8F70795D48BA5EF670E520AE7B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2674ba28-b2c4-4d4f-ad04-08dcf281001a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 10:05:04.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8xzxOJC6klt3hNRSdbLUCWnAbMFUBWoy27WB5Ej0Ujy6rORIZM5avqS/YrqLm3nAGn3xFAI4+CUJetxUOFdGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7861

SGksIExpYW5rdW46DQoNCk9uIE1vbiwgMjAyNC0wOS0zMCBhdCAxNzoxNyArMDgwMCwgTGlhbmt1
biBZYW5nIHdyb3RlOg0KPiBSZXR1cm5zIHRoZSBudW1iZXIgb2YgYnl0ZXMgdHJhbnNmZXJyZWQg
KDEpIG9uIHN1Y2Nlc3MuDQo+IENoZWNrIHRoZSByZXR1cm4gdmFsdWUgdG8gY29uZmlybSB0aGF0
IEFVWCBjb21tdW5pY2F0aW9uIGlzIHN1Y2Nlc3NmdWwuDQo+IA0KPiBGaXhlczogZjcwYWMwOTdh
MmNmICgiZHJtL21lZGlhdGVrOiBBZGQgTVQ4MTk1IEVtYmVkZGVkIERpc3BsYXlQb3J0IGRyaXZl
ciIpDQoNCkZpeGVzOiBkOWU2ZWEwMmZjM2YgKCJkcm0vbWVkaWF0ZWs6IGRwOiBBZGQgTVQ4MTk1
IEV4dGVybmFsIERpc3BsYXlQb3J0IHN1cHBvcnQiKQ0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTGlhbmt1biBZYW5nIDxsaWFua3VuLnlhbmdAbWVkaWF0ZWsuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYyB8IDggKysrKysrKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gaW5kZXggZDg3OTZhOTA0ZWNhLi4zY2FiNjUz
NDVkMWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gQEAgLTIwMTgsNiAr
MjAxOCw3IEBAIHN0YXRpYyBlbnVtIGRybV9jb25uZWN0b3Jfc3RhdHVzIG10a19kcF9iZGdfZGV0
ZWN0KHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UpDQo+ICAJZW51bSBkcm1fY29ubmVjdG9yX3N0
YXR1cyByZXQgPSBjb25uZWN0b3Jfc3RhdHVzX2Rpc2Nvbm5lY3RlZDsNCj4gIAlib29sIGVuYWJs
ZWQgPSBtdGtfZHAtPmVuYWJsZWQ7DQo+ICAJdTggc2lua19jb3VudCA9IDA7DQo+ICsJc2l6ZV90
IHZhbHVlOw0KPiAgDQo+ICAJaWYgKCFtdGtfZHAtPnRyYWluX2luZm8uY2FibGVfcGx1Z2dlZF9p
bikNCj4gIAkJcmV0dXJuIHJldDsNCj4gQEAgLTIwMzIsNyArMjAzMywxMiBAQCBzdGF0aWMgZW51
bSBkcm1fY29ubmVjdG9yX3N0YXR1cyBtdGtfZHBfYmRnX2RldGVjdChzdHJ1Y3QgZHJtX2JyaWRn
ZSAqYnJpZGdlKQ0KPiAgCSAqIGZ1bmN0aW9uLCB3ZSBqdXN0IG5lZWQgdG8gY2hlY2sgdGhlIEhQ
RCBjb25uZWN0aW9uIHRvIGNoZWNrDQo+ICAJICogd2hldGhlciB3ZSBjb25uZWN0IHRvIGEgc2lu
ayBkZXZpY2UuDQo+ICAJICovDQo+IC0JZHJtX2RwX2RwY2RfcmVhZGIoJm10a19kcC0+YXV4LCBE
UF9TSU5LX0NPVU5ULCAmc2lua19jb3VudCk7DQo+ICsJdmFsdWUgPSBkcm1fZHBfZHBjZF9yZWFk
YigmbXRrX2RwLT5hdXgsIERQX1NJTktfQ09VTlQsICZzaW5rX2NvdW50KTsNCj4gKwlpZiAodmFs
dWUgPCAwKSB7DQo+ICsJCWRybV9lcnIobXRrX2RwLT5kcm1fZGV2LCAiRmFpbGVkIHRvIHJlYWQg
RFAgU2luayBDb3VudDogJXpkXG4iLCB2YWx1ZSk7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0K
PiArDQo+ICAJaWYgKERQX0dFVF9TSU5LX0NPVU5UKHNpbmtfY291bnQpKQ0KPiAgCQlyZXQgPSBj
b25uZWN0b3Jfc3RhdHVzX2Nvbm5lY3RlZDsNCj4gIA0K

