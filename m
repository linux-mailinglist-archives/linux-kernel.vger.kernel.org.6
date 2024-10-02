Return-Path: <linux-kernel+bounces-347119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9258498CE1B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F61FB20CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B51D517;
	Wed,  2 Oct 2024 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lu1z3P+6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wNfLo9Mr"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E4413FD84
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855454; cv=fail; b=XYKuvxNirv71vIfZ/nOH76fjvO+nKyw/0l7vBwIHXYII0CG6ZMiRDgBNWaXFkOZw9mIVcSa4+z6D9PaVFZeNgMezH6NyI31hR0e7DN4yqSW+BlX7ukenKu6gYUaC0eharBna45ZRx9w2RzlOSIDnsRg6KHviC83PqNWGR75JK9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855454; c=relaxed/simple;
	bh=CYBV8mJi6kLsVhCtfTq9Yv1n7WoB2MluvrfVCyiU/Co=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eSO6uFg/T3Bi6NW9Na6A1MoXbedv8gK/Q4tYmqRXhHYUZW64TkLFMrMVVNqJQQ/CMoXBkDjjQwm0flutAJQp0cuW9kWLLOV/3Kgd230S2ruSNMZ+m0Mkwx4ttYxwocQbUJMh+9q9C66zVwt5ApGtCpbgAZp/BithdHqOG/9/Aso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lu1z3P+6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=wNfLo9Mr; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 045dea36809311ef8b96093e013ec31c-20241002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CYBV8mJi6kLsVhCtfTq9Yv1n7WoB2MluvrfVCyiU/Co=;
	b=lu1z3P+6YZrmtbeuOSfZbwYMGsmzcYDngiAwuqbLsoUWeeTqadEHlIya9GbudP9mMuX/Q1C0v88r1csu3hQQrNb3brPfSXIzCtA4+aXhqOr1YNS5M3XXuIEwBOncHzyuPyGMwRFprtZBAMawbzToBeTV2zlCsU+9RFpmkIxAElE=;
X-CID-CACHE: Type:Local,Time:202410021550+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:359cd49d-db6e-48ac-af92-147cf714e78a,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:defca7ed-33c7-4396-bf34-2026ee4f15f5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:4|-5,EDM:-3,I
	P:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 045dea36809311ef8b96093e013ec31c-20241002
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 688297370; Wed, 02 Oct 2024 15:50:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Oct 2024 15:50:38 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Oct 2024 15:50:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ir2qpuj/ixvXr+hzvaibzoF4hjtPe7IRL8DPO8Gzzz2EGJKtuiKzU5ZFt0Jp9WHMUXFDAVhCL1upLNrineeppdbJhh6zcad1fHpb/byUUXesq0/8Pjks05SfLArDT3OQcCsy2U0YWRRS1TyKV50nAMMnukaWE1LDxXYvErFp24DTEIUG15GlBqUuvkdEUiEQdUVSP7hLIY87ePKAyovJxXqi0G+c2apP1Vu4W0rW3oFkN+mpzQ0hKvOFizLK3odjupHuvDglQDYguYCK1GwAgi14K3opVX9cEEHwzjsABpyMssuq5aDCGCqhLSw0YrIvR2spiAeqMMQ5oN6rLU4eKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYBV8mJi6kLsVhCtfTq9Yv1n7WoB2MluvrfVCyiU/Co=;
 b=xR56/nLAyzq9tExB3BzP9u2is9JlJSOFsU5lG/w9cs6z+4NMcM0clZ6OtVPJ3Z0/9tA/P2ft7iuKL7OsS5YtCki08nuNoGUOtIDmS0tkcTTLk9wk0XV0UuK9q/4iruYxt8xEEH2sJ1CrzIRrIEMiXE+Ue1lRrBysWecWNwwR6TSdQQQeEHqP8ehygRx9kQA4ufBbJYnU7U9ZMJoX2nJZ2w010Hb7UnuLIIQHv2SNthMKRSOyuFsmXjY8iwEY2WArrAGGt8P+l8Elb76a+TCd/cIgZzTu9DY9TYXEbd7+4BPvwaLgIui+nprdkw+vSy/bWeZvDPwZ/D+vg0bWoF21hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYBV8mJi6kLsVhCtfTq9Yv1n7WoB2MluvrfVCyiU/Co=;
 b=wNfLo9MryOwMHjT71BRUlfx1BSA2cG/dvxCHB1g/2xii1ya7QKSPPE44H+lf7jzRPzMnITaUQnJvg/w2uHlNbIptRxjDicgfXNgYJIH0Wr2KaVbfbgriTZnfb3o0yMB21FgBVirjPN0qNjcy6OT3CAKfZ489D4LANhbIgByfMSU=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB7120.apcprd03.prod.outlook.com (2603:1096:101:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 07:50:26 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7939.022; Wed, 2 Oct 2024
 07:50:25 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "djkurtz@chromium.org"
	<djkurtz@chromium.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "me@adamthiede.com"
	<me@adamthiede.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"littlecvr@chromium.org" <littlecvr@chromium.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/14] drm/mediatek: Support DRM plane alpha in OVL
Thread-Topic: [PATCH v3 13/14] drm/mediatek: Support DRM plane alpha in OVL
Thread-Index: AQHbE2FMBZwycJSOpEepDGqWsN2C6LJxmIIAgACYzICAAB6HgIAAyOGA
Date: Wed, 2 Oct 2024 07:50:25 +0000
Message-ID: <272b47f0c9e27268d29b58c341e0b48bce7e8e25.camel@mediatek.com>
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
	 <20240620-igt-v3-13-a9d62d2e2c7e@mediatek.com>
	 <1a3af354-bd15-4219-960e-089b6a6e673c@adamthiede.com>
	 <49df03e8b982cc5ee97e09ef9545c1d138c32178.camel@mediatek.com>
	 <00ebe9ca262b6a95fd726e5be06334b1e923db02.camel@mediatek.com>
	 <5975b361-c1b4-4c57-89d4-0d247ae99d8c@adamthiede.com>
In-Reply-To: <5975b361-c1b4-4c57-89d4-0d247ae99d8c@adamthiede.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB7120:EE_
x-ms-office365-filtering-correlation-id: 293d89f0-922c-44ed-301d-08dce2b6e02f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?UmsycnJ1V1VSaE9HeFRCbnVFYzFTNXhtOGN6OW9Na1JNWE5xeUJiUVdNVHVk?=
 =?utf-8?B?citkc28vbkRoRDJzQ1RCeGxPdmRxNE5rbEp6M1JkejV6Vmp6OEdtRmlVem9n?=
 =?utf-8?B?YncrQURSOUxKZUJBWFkzRXFoUUwzOWxBU2dSS00zcEl4bHVLUHYvNWFHRjRY?=
 =?utf-8?B?dUlkekJ1UzJZVXB0YjQxbkZoNENidXczSjFFOHBUSGFaUmJaVElzeTh2MElX?=
 =?utf-8?B?WWlKR0oyOGprajZkamFWZ2pCWEdQbll3VzN1dTc3SHV2Z29hTjA0WkNUY2Fk?=
 =?utf-8?B?OEVHa29LTElmVHhOTW5NTWNxS0xxZTJpeWFIZ1lleUp5TWdhN1FZU3J4Q2hw?=
 =?utf-8?B?QXViVlR2dDdlNDFyZUsyVjFKaThTY05xWC8vcVl3cXYvYlllcnJhc0pOZDV4?=
 =?utf-8?B?enAvUDNrNC9kYzFrZmo5bEhSZlR4QUsxamlyQmlGZXdQOEQrVzhCQkRJT2x3?=
 =?utf-8?B?ZUpWOFB3SE0xejFla0hWeWNRajZKQVQvSUl5Z1kwcU82MzBpNHVjNHgrY05X?=
 =?utf-8?B?cXJEcjU2RmxDL0Zlb3Z2eEd4YUxoaHBKeC9IbERXVC9HSjVzZytja3RzK3lG?=
 =?utf-8?B?ckFCMHhvdmNvR3BRWk5NcWt3cklHWnFKU3FLY2JVNVlCb3liMDdqWThXYWZh?=
 =?utf-8?B?aXBBS0w5aWpvMHRHNzhSdU9ITkU1OW5zTzlrWitXVkxJckwxWVZtTHg0U0Jy?=
 =?utf-8?B?akVvTHI3dHZYOGp2TFNHd3QzVkI5Mk4yTFEzUlY3amw0TE5hWFNaVHpCMlMv?=
 =?utf-8?B?S09IY2tyOGlEQmY1UU1YR04rYjVOeTJYeERaWktEcTFsdmxJVlBWaGtOcGRr?=
 =?utf-8?B?RU50aEU3OUE4b3I0dUZVajRCNDYwOWlybnpBUitQSmxWYmplZnlWR3FwcitE?=
 =?utf-8?B?MXpwWkVsNFU4VzF3VThreWgybXlvVWJJMUxyNkdIbTZRblVWaHp2aHJOYWNn?=
 =?utf-8?B?VEFCNUpsalVIZGxnWXA0cEJNQlMwTjJuNTBWVkFEczY1SGF5V2plM3gxZjVv?=
 =?utf-8?B?RmNYQjdjUnNrMVdrM1NaejdXUUdXRVpKeWNOYVpmRzhmU1gxRC9SbXF3bFhB?=
 =?utf-8?B?QnFVbTM3RWcybmllVUZ3TWtZVE84QllMTElXZVlSTWtrdDRMOGlSNTFjSzFU?=
 =?utf-8?B?ZXpuZ0d5YmlhdzRrS202MHhkVngvR0dJcDVrZG9EYUhYbzBjT0htNkhUbFNm?=
 =?utf-8?B?TkZKcUJ2S3h2L1Y1cW4vVmZXSkFiTVJ0VG9XRzBJbC82QUFLUm11a2ZyNjdS?=
 =?utf-8?B?WUxKckRHQTZzRERkb24wY0FGVFZ1QldDODNYa215TlVrSVU2a3ZrMkl6Unph?=
 =?utf-8?B?bVB5ZFR2bGhQUW9SM201cUp0a2NLVEg4NTQvM2NUam11Z0IvZEk5U1dlV3gz?=
 =?utf-8?B?a2RRRTdNR040Nmg2TGJnano4K2pYSFlRbnNOUjQzY2ZrdzFhZXJPOEVSVXhP?=
 =?utf-8?B?c2JQRW12QTVDTjRUVyt2eWpsb2JqVmZaVWpua1pzbEptVWZaUHlibkJ6Ulp1?=
 =?utf-8?B?SGJ4U05aYlNJVHpSWXFra2EyZkp4QjBuUU9QUUk5RDdoSXZueldIbUFuSll3?=
 =?utf-8?B?TUgrNXhvVktMVm5najVyZW13SG9WaGNuZlNVNHE5ZWoxTEVTL1BQbExrWjdD?=
 =?utf-8?B?MWdoZU54SjB5a1RhMk9OdXdnR2tKblZQL0s0YjlGV3ZXWDhERU93ejByS3hp?=
 =?utf-8?B?NGkvUjlyQ1RrdjViR3FVZ0NRc3dYdm9yUjVZM1pnK3RqMFFEZGJlQllSK2dn?=
 =?utf-8?Q?jk48VPjMyTGZknhw07+XUkM/C071dwWNoS6D9LP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVMydkNCOE5BcTRzbFpsMmEwcWUyYXd1ZDNZTzB6R2d5TTJvU1d2Rkx2OFhZ?=
 =?utf-8?B?LzB5K292UEcyaXlsNStQa2ROOGZhWDJwUWJleEVOWmxPOVhQQ0hmem9JNTlT?=
 =?utf-8?B?aVdtTUV1ckhGczM4NEthbXZTdmdQRDlycE9NVXdVSUYvS2QzSW9USXNkNGh6?=
 =?utf-8?B?WmVxVHdOR3lBWTlGem4wN0pLNUxBMW02QjI1Z0ZvYzgrekxmcTdIWGJjaUlw?=
 =?utf-8?B?a2dBTUVEY3RFckpMcG5BTzViK0FJdDFtdHpYTHdGUmlKSWRrdTFUbUE2aWhC?=
 =?utf-8?B?NStiMGxVTWJWbFlDRjNENzNVWitvSXpSSHk2U2hIZjc5NUpjam1nUjh4dS9N?=
 =?utf-8?B?L3RiM1RhcFFKOHlnTFVoSFpTUmdkVld3UzVXbnhnS1ArZ2pEeWFESTl0R2Zh?=
 =?utf-8?B?aStOOExUajVPMFhMUFp4Nk50WjBFck5RLzdueWNzRW9oQ3VJK2N5Z3VJQWpv?=
 =?utf-8?B?OVdrNm1WU2l3VldHbWlINTg3UC8yUDJKNXA1RWFQN1labUkxWFdBR3pNVVk1?=
 =?utf-8?B?bFBjTDBzakN2aGg1VWxjb2hMK3RoN3hTRWU3L3VqNFQrSXRPWG52aVgvc1Bm?=
 =?utf-8?B?UUxkVWlsam5mQjVnUTdmVDdyME9waU5EQktQU2FZakd3bzkvMTdOZUZmQXdk?=
 =?utf-8?B?d0VFUFRlZFFGbGRRb293MUt0cXZWSUdxZ25oak04aExNdW5OMVI2RWJwdU4w?=
 =?utf-8?B?ZXR2dUxHYW05Ly9LREJTUnhIam94Y016c3YvTEkzYlBoK09pSzJQRkNaT1Rp?=
 =?utf-8?B?NythNGZVRnNTNHdUSVhZK2l5bHZCVVVIbTFZeXg3UUZvV1VPaFJ2SkJzaEti?=
 =?utf-8?B?ckhGZG0ycm1SLzFCU2l2b2drNC9aYjlBaHVsM3Y3SHE5T20rK0ZVUlkvTjUy?=
 =?utf-8?B?UXZvTlFRUkhGbFduRzhCWjhacHZiSG9RSkpCNkJPK3Qvd1JBVSs1eEV5c0FP?=
 =?utf-8?B?cUJoa21NNzRJOHNZSHhCM0lzeXY5UGk2ZHMyVUgzbjBKU2tzZ1FPWDdRb2FJ?=
 =?utf-8?B?YVMxTlZ4bXhYak9zcW1LRGhWZWpjYzZ6eHYrZ3FydFRnSloyNG5DUHViU21s?=
 =?utf-8?B?dmtqYnM5SWhIekFuNlhmbElPcWRyOW1QaGk4ak5hNlJGclFBZGdydFIwYXda?=
 =?utf-8?B?UzhTZERVUkdZaS9uUUJmdHY3bTFUN0hia29QTFZ1Yi9IaDNOcXhCUk9jdkpE?=
 =?utf-8?B?WFZ5MnhvZUVpWkkzbGZQcUxQRms3R0ZpZGhTbDJJZGo1MjdmZHZkQ1pqSnJi?=
 =?utf-8?B?bUJONDJXbndzVys1bHNVdTdWSmxIcjV2V2xLdzBiSlJPQlJWbDFzNDFKZ1ZS?=
 =?utf-8?B?N1IySTBqZEJIcDd2QXdqbytvOFpZZklSMjQxRTlleUNvbERHb3FpTUFLbzZR?=
 =?utf-8?B?ZisyR0RENnArVzNvWkpFWHIzaFFCeVBrK2Y0ZDBKQnVvMkkycjBPQ3VqSnY0?=
 =?utf-8?B?N0xMYjQwekx2ZjFKblpya3kvcmNnSUx1T1p2NWUxcWh2MHpiNy8wOVFLQ2Nj?=
 =?utf-8?B?d2dnZHNmWUE1UXJINDZXRDZQZ0RWV0gxN0tDZVNFdm1rZjl3bjBFekRyUVlv?=
 =?utf-8?B?NC9jVEpCQ3dyczF3TXFoZkJhNmNHSEtqaFd0bGRwdFlMbUtSSWNaU2V4ZDFL?=
 =?utf-8?B?eVdlbFltbEs0cXlqS0lyc012RWVhODZlK3ZEb3gveHVER2I5NkU0VTZGNnIr?=
 =?utf-8?B?UzZoSzdacFpLNDlBeG9BbHBNdnErREYyS0l4a3hwc2dCMWdoMGk4T1o2L09k?=
 =?utf-8?B?L1FWQmhyN0dTbm9WNFhtcUYrS041RmlLNUFhZzQxY0hYaTRBMG1hM2RRR0RD?=
 =?utf-8?B?V2JLNHpLRldxZmMxa1pidm5JRGFzaUFkY2xqOE9PSHdsZ1IvWWpyRHJQU0c4?=
 =?utf-8?B?OGIrbnAyZTJ2c2RLKzQwb0pKYm1NK1VFYnQ0elNZV3hyV0JtNU1oeWZnV3hX?=
 =?utf-8?B?OFIxMXVWcHA1Y25PNzRlMUhraVRWWUVkSzBEMkRMcytic0h4dDVqeXRleml6?=
 =?utf-8?B?c0s4SzBMNmR0ck5mL2N6VVRBUWM1ZDVHVWQrb0dyRDlPUS9NRmtubFBBVjgw?=
 =?utf-8?B?NHRHMURGTy9pV3VKZDJaeCszYnc3cjU1V2xNdXpGejRaRzF6MEpuQ0dGWG9M?=
 =?utf-8?B?eHNpQ3dxaEVIdFI4bkUxNTMyMllUQ01sZ3ptZEZqS2dxa2hUZ3owOUEvNmFD?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0CBFE97BDC1B44B99D59676BCD7B448@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293d89f0-922c-44ed-301d-08dce2b6e02f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 07:50:25.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJYJ9dc9Hu3qSK7/WuWsh3MmVAOPjZ86y2gNtk0+xI5wa2ZVI8GBfeNajTAl0lL9aqQP5OttnnM//M00PNceh70TQZHe3t7Oc9i+rVWjhbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7120

PiA+PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9v
dmwuYw0KPiA+PiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMN
Cj4gPj4gPiA+IGluZGV4IDk0M2RiNGYxYmQ2Yi4uNGIzNzBiYzA3NDZkIDEwMDY0NA0KPiA+PiA+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4+ID4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPj4gPiA+
IEBAIC00NTgsOCArNDU4LDEwIEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRl
dmljZQ0KPiA+PiA+ID4gKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gPj4gPiA+ICAgfQ0KPiA+
PiA+ID4gICANCj4gPj4gPiA+ICAgY29uID0gb3ZsX2ZtdF9jb252ZXJ0KG92bCwgZm10KTsNCj4g
Pj4gPiA+IC1pZiAoc3RhdGUtPmJhc2UuZmIgJiYgc3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFz
X2FscGhhKQ0KPiA+PiA+ID4gLWNvbiB8PSBPVkxfQ09OX0FFTiB8IE9WTF9DT05fQUxQSEE7DQo+
ID4+ID4gPiAraWYgKHN0YXRlLT5iYXNlLmZiKSB7DQo+ID4+ID4gPiArY29uIHw9IE9WTF9DT05f
QUVOOw0KPiA+PiA+ID4gK2NvbiB8PSBzdGF0ZS0+YmFzZS5hbHBoYSAmIE9WTF9DT05fQUxQSEE7
DQo+ID4gDQo+ID4gSGkgQWRhbSwNCj4gPiANCj4gPiBDb3VsZCB5b3UgcHJpbnQgb3V0IHRoZSAi
Zm10IiwgInN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtDQo+ID4+aGFzX2FscGhhIiwgInN0YXRlLT5i
YXNlLmFscGhhIiBhbmQgImNvbiIgaGVyZT8NCj4gPiANCj4gPiBwcl9pbmZvKCJmbXQ6MHgleCwg
aGFzX2FscGhhOjB4JXgsIGFscGhhOjB4JXgsIGNvbjoweCV4IFxuIiwNCj4gPiAgICAgICAgICBm
bXQsIHN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSwNCj4gPiAgICAgICAgICBzdGF0
ZS0+YmFzZS5hbHBoYSwgY29uKTsNCj4gPiANCj4gPiBJJ20gbm90IHN1cmUgaWYgaXQncyB0aGUg
Y29sb3IgZm9ybWF0IHNldHRpbmcgcHJvYmxlbSwgbWF5YmUgdGhlcmUNCj4gaXMNCj4gPiBzb21l
dGhpbmcgd2lyZSBjb25maWd1cmF0aW9uIGhlcmUsIHN1Y2ggYXMgWFJHQjg4ODggd2l0aCBhbHBo
YSBvcg0KPiA+IEFSR0I4ODg4IHdpdGhvdXQgYWxwaGEuDQo+ID4gDQo+ID4gU28gSSB3YW50IHRo
ZXNlIGluZm9ybWF0aW9uIHRvIGNvbXBhcmUgd2l0aCBteSBNVDgxODguIFRoYW5rcyENCj4gPiAN
Cj4gPiBSZWdhcmRzLA0KPiA+IEphc29uLUpILkxpbg0KPiA+IA0KPiBKYXNvbiwgdGhhbmsgeW91
IGZvciB5b3VyIHRpbWVseSByZXBseS4gSSBhZGRlZCB0aGUgY29kZSB5b3UgcHJvdmlkZWQNCj4g
dG8gDQo+IG15IHBhdGNoLCBhbmQgbm93IGdldCB0aGlzIGxpbmUgb24gZW5kbGVzcyByZXBlYXQg
aW4gZG1lc2c6DQo+IA0KPiBmbXQ6MHgzNDMyNTI1OCwgaGFzX2FscGhhOjB4MCwgYWxwaGE6MHhm
ZmZmLCBjb246MHgyMDAwDQo+IA0KDQpUaGlzIGZ1bmN0aW9uIGlzIHVzZWQgdG8gY29uZmlndXJl
IHRoZSA0IE9WTCBoYXJkd2FyZSBsYXllciBwZXItZnJhbWUsDQpzbyBpdCBtYXkgYmUgY2FsbGVk
IDQgdGltZXMgaW4gZXZlcnkgVlNZTkMuIElmIHlvdXIgZGlzcGxheSBkZXZpY2UgaXMNCjYwZnBz
LCB0aGVuIHRoaXMgbGluZSB3b3VsZCBiZSBjYWxsZWQgTiBsYXllcnMgdGltZXMgaW4gZXZlcnkg
MTYuNjZtcy4NCg0KPiBUaGlzIGxpbmUgYWxzbyBzaG93cyB1cCBzb21ldGltZXMgaW4gdGhlcmUs
IGJ1dCBJIGhhdmUgbm8gaWRlYSB3aGF0IA0KPiB0cmlnZ2VycyBpdC4NCj4gDQo+IGZtdDoweDM0
MzI1MjQxLCBoYXNfYWxwaGE6MHgxLCBhbHBoYToweGZmZmYsIGNvbjoweDIxZmYNCj4gDQoNCkZy
b20gdGhlIERSTSBjb2xvciBmb3JtYXQgZGVmaW5pdGlvbiBoZXJlOg0KDQpodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92Ni4xMS4xL3NvdXJjZS9pbmNsdWRlL3VhcGkvZHJtL2RybV9m
b3VyY2MuaCNMMTk4DQoNCldlIGNhbiBzZWUgdGhlIE1BQ1JPczoNCiNkZWZpbmUgZm91cmNjX2Nv
ZGUoYSwgYiwgYywgZCkgXA0KICAgICAgICAoKCh1aW50MzJfdCkoYSkgPDwgMCkgfCAoKHVpbnQz
Ml90KShiKSA8PCA4KSB8IFwNCiAgICAgICAgKCh1aW50MzJfdCkoYykgPDwgMTYpIHwgKCh1aW50
MzJfdCkoZCkgPDwgMjQpKQ0KLi4uDQojZGVmaW5lIERSTV9GT1JNQVRfWFJHQjg4ODggZm91cmNj
X2NvZGUoJ1gnLCAnUicsICcyJywgJzQnKQ0KLi4uDQojZGVmaW5lIERSTV9GT1JNQVRfQVJHQjg4
ODggZm91cmNjX2NvZGUoJ0EnLCAnUicsICcyJywgJzQnKQ0KDQpHaXZlbiB0aGUgZm91cmNjX2Nv
ZGUgbWFjcm8gYXMgcHJldmlvdXNseSBkZXNjcmliZWQsDQp0aGUgRFJNX0ZPUk1BVF9YUkdCODg4
OCBtYWNybyB3b3VsZCB0cmFuc2xhdGUgdGhlIGNoYXJhY3RlcnMNCidYJywgJ1InLCAnMicsICc0
JyBpbnRvIGEgMzItYml0IGludGVnZXIgdmFsdWUsIHdpdGggZWFjaCBjaGFyYWN0ZXINCm9jY3Vw
eWluZyA4IGJpdHMgaW4gdGhlIG9yZGVyIGZyb20gbGVhc3Qgc2lnbmlmaWNhbnQgYnl0ZSB0byBt
b3N0IA0Kc2lnbmlmaWNhbnQgYnl0ZS4NCg0KSGVyZSBhcmUgdGhlIEFTQ0lJIHZhbHVlcyBmb3Ig
dGhlc2UgY2hhcmFjdGVyczoNCg0KJ0EnIGhhcyBhbiBBU0NJSSB2YWx1ZSBvZiA2NSAoMHg0MSkN
CidYJyBoYXMgYW4gQVNDSUkgdmFsdWUgb2YgODggKDB4NTgpDQonUicgaGFzIGFuIEFTQ0lJIHZh
bHVlIG9mIDgyICgweDUyKQ0KJzInIGhhcyBhbiBBU0NJSSB2YWx1ZSBvZiA1MCAoMHgzMikNCic0
JyBoYXMgYW4gQVNDSUkgdmFsdWUgb2YgNTIgKDB4MzQpDQoNClRoZXJlZm9yZSwgdGhlIGludGVn
ZXIgdmFsdWUgb2YgWFIyNCB3aXRoIGhleCBmb3JtYXQgd291bGQgYmU6DQoweDM0MzI1MjU4LCBh
bmQgQVIyNCB3b3VsZCBiZTogMHgzNDMyNTI0MQ0KDQo+IERvZXMgdGhhdCBoZWxwPw0KPiANCj4g
LUFkYW0NCg0KSGVyZSBpcyB0aGUgdHJhbnNsYXRpb24gZnJvbSB5b3VyIGxvZ3MgOg0KDQpmbXQ6
MHgzNDMyNTI1OCwgaGFzX2FscGhhOjB4MCwgYWxwaGE6MHhmZmZmLCBjb246MHgyMDAwDQotIERS
TSBjb2xvciBmb3JtYXQ9WFJHQjg4ODgNCi0gdXNlciBzZXQgaGFzX2FscGhhPTANCi0gdXNlciBz
ZXQgYWxwaGEgdmFsdWU9MHhmZg0KLSBjb25maWd1cmUgdmFsdWUgdG8gT1ZMIGhhcmR3YXJlPTB4
MjAwMA0KDQpmbXQ6MHgzNDMyNTI0MSwgaGFzX2FscGhhOjB4MSwgYWxwaGE6MHhmZmZmLCBjb246
MHgyMWZmDQotIERSTSBjb2xvciBmb3JtYXQ9QVJHQjg4ODgNCi0gdXNlciBzZXQgaGFzX2FscGhh
PTENCi0gdXNlciBzZXQgYWxwaGEgdmFsdWU9MHhmZg0KLSBjb25maWd1cmUgdmFsdWUgdG8gT1ZM
IGhhcmR3YXJlPTB4MjFmZg0KDQpDb3VsZCB5b3UgdGVsbCBtZSBpbiB3aGljaCBsb2cgeW91IGNh
biBzZWUgYW5kIG5vdCBzZWUgdGhlIHRleHQgb24gdGhlDQp0dHk/DQoNCg0KDQpIZXJlIGlzIHNv
bWUgb2YgbXkgYW5hbHlzaXM6DQoNCkluIG9yaWdpbmFsIGNvbmRpdGlvbjoNCmlmIChzdGF0ZS0+
YmFzZS5mYiAmJiBzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpDQoJY29uIHw9IE9W
TF9DT05fQUVOIHwgT1ZMX0NPTl9BTFBIQTsNCi0gWFJHQjg4ODggd2lsbCBnZXQgY29uID0gMHgy
MDAwDQotIEFSR0I4ODg4IHdpbGwgZ2V0IGNvbiA9IDB4MjFmZg0KCQ0KSW4gY3VycmVudCBjb25k
aXRpb246DQppZiAoc3RhdGUtPmJhc2UuZmIpIHsNCgljb24gfD0gT1ZMX0NPTl9BRU47DQoJY29u
IHw9IHN0YXRlLT5iYXNlLmFscGhhICYgT1ZMX0NPTl9BTFBIQTsNCn0NCi0gWFJHQjg4ODggd2ls
bCBnZXQgY29uID0gMHgyMWZmDQotIEFSR0I4ODg4IHdpbGwgZ2V0IGNvbiA9IDB4MjFmZg0KDQpC
dXQgdGhlbiBYUkdCODg4OCB3aWxsIHNldCB0aGUgaWdub3JlX3BpeGVsX2FscGhhIGJ5IHRoZSBj
b2RlIGJlbG93Og0KLyogQ09OU1RfQkxEIG11c3QgYmUgZW5hYmxlZCBmb3IgWFJHQiBmb3JtYXRz
IGFsdGhvdWdoIHRoZSBhbHBoYQ0KY2hhbm5lbA0KICogY2FuIGJlIGlnbm9yZWQsIG9yIE9WTCB3
aWxsIHN0aWxsIHJlYWQgdGhlIHZhbHVlIGZyb20gbWVtb3J5Lg0KICogRm9yIFJHQjg4OCByZWxh
dGVkIGZvcm1hdHMsIHdoZXRoZXIgQ09OU1RfQkxEIGlzIGVuYWJsZWQgb3Igbm90DQp3b24ndA0K
ICogYWZmZWN0IHRoZSByZXN1bHQuIFRoZXJlZm9yZSB3ZSB1c2UgIWhhc19hbHBoYSBhcyB0aGUg
Y29uZGl0aW9uLg0KICovDQppZiAoKHN0YXRlLT5iYXNlLmZiICYmICFzdGF0ZS0+YmFzZS5mYi0+
Zm9ybWF0LT5oYXNfYWxwaGEpIHx8DQogICAgYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVORF9Q
SVhFTF9OT05FKQ0KCWlnbm9yZV9waXhlbF9hbHBoYSA9IE9WTF9DT05TVF9CTEVORDsNCg0KRG9l
cyB5b3VyIGNvZGUgaW5jbHVkZSB0aGlzIHBhdGNoPw0KDQpodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyNDA2MjAtaWd0LXYzLTMtYTlk
NjJkMmUyYzdlQG1lZGlhdGVrLmNvbS8NCg0KSWYgeW91IGhhdmUgaW5jbHVkZWQgdGhpcyBwYXRj
aCwgSSB3b3VsZCB0aGVuIGNoZWNrIHdpdGggdGhlIE9WTA0KaGFyZHdhcmUgZGVzaWduZXJzIHdo
ZXRoZXIgdGhlIE1UODE3MyBzdXBwb3J0cyBPVkxfQ09OU1RfQkxFTkQuDQoNClJlZ2FyZHMsDQpK
YXNvbi1KSC5MaW4NCg==

