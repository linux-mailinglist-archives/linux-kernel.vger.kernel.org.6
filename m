Return-Path: <linux-kernel+bounces-224362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4000D912160
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84299B216D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352B516F859;
	Fri, 21 Jun 2024 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pxTCCsNn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tLJk8izh"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE59E16F843
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963849; cv=fail; b=EQJwz7+TZkdxeiFm4YLmI9D+rP/ptLvckkJPYw+SBN+LFdBwxx5KatOzVVZiKkj5nUy8M+SEsqjLit7P+aX9nrDH65LNZ9rNyk87HUFlm094kRtEYZsDzkk2F8agv4swwjPAg7dbZZERua3qG1kkQ2O6C91dl+lHAb8srTGsBtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963849; c=relaxed/simple;
	bh=K+ous26erpaMfCTIKoRygn4dIpSneA/cinunmm6duv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZXwVyWHnaVOLlCKCoKrcHM226mVfobuQP/QhbCeZBEJ1tQC7vHKDLnbQPNTj96Towp8f6QMo9vw6X7S1IG6nK+iQRJiXoBSzdy2HBiJa4yxVozZCkHIDtb7s5ax0YO/kPXN07MRDJ6/oprlTML5GP/bh2GSR1kFSx/nKJYRjHvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pxTCCsNn; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tLJk8izh; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a5e7ec1a2fb411ef99dc3f8fac2c3230-20240621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=K+ous26erpaMfCTIKoRygn4dIpSneA/cinunmm6duv8=;
	b=pxTCCsNnfLc+TW/ifW/gOOLDjV+cD2tyYwEV2yCCrZmfx6e3wxKLNMTFhlhLRm5ylGQ5RuR+D7gKH10YVjpEmuO7eFLY/WhI/dYihS06Q0i9Z+tRqB6IzfDuzOZcXwGhbVa/Epp1SFZUm7lyhuKf365X9RxRrmt8fuWJ6MIWupY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:b8e518ba-24b3-4c8d-ad00-9e9def7f4a10,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:38adde88-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a5e7ec1a2fb411ef99dc3f8fac2c3230-20240621
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 28181771; Fri, 21 Jun 2024 17:57:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jun 2024 17:57:18 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jun 2024 17:57:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM0wfokrhE1Qvgo7jNKshJvDDXZEoyKCR1oa0vcK2eMI12FqTR8Sy5Tv7E2Dq3fBhv5VfWJRoqXjHJUUz4dgo46NRJrqkbfuLGlJ8FkBZg4iei6tFzWEowvBAdKjswYaSTqVrUigduaU2syq570UHlWd6KeRr+X79hoemViCvngvRjGnH1+xfPQEV9L6d9jNRAg4UL1kO8COF6ufSWROeNVRc8BR+gyLrGW6eftVj8Gdl1A+1wwBFqQDxX5SVl+c1TlqwiL0+1GIRHs/5FyzEFz6ztSoOaXOgTh9nFVU4C/hq0CEZmzCM1eZ53/SMhs2SfbKuBFX+cYoiA2AADPsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+ous26erpaMfCTIKoRygn4dIpSneA/cinunmm6duv8=;
 b=hZ1YbEVPqBDCy3RjGHPhApDqUtlS1iNVG87nqECbIteewNGEugBRBpmLrHZZ9KOp+MJkRBcUkX/t93tp4JbiU12OI89OWCgHaDahYdT7Uvhkh88DZxcMMRbXL66rEoVWi3Vqnz3cPihau3Fsq4wwZTT2e2gahN1EFyHgM2othvNspnmnYGnNV/iIGlDChSOn2jyFEdl3kERda4YxAvzi7uf75Uq3OJhfwQIBvvsGTpDtNgwXTDCATyrNC0LBiZHQ5NLCAu6v3jIOgzR4efUbS8Wm74gAIFYEbn1a+YVqPM4S+KgAZTGlgb1GbBOQqZV2vU3KeZh+aZ/jmk4Wb0eznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+ous26erpaMfCTIKoRygn4dIpSneA/cinunmm6duv8=;
 b=tLJk8izhHfzvrYHU/VtIcB4yPTmP/sWvc6tvs5UszvVeYAAVOCdi1qLGbAk3u312evue4z9gqfPvKynFuddNj3Up+MtOay/2+LKIyda0DD2OiSq5I6nYy6K/K4jBncmXLKyv9JjOF0YalXgnWw1ZD6yRF38MH43MWyr5mdLkbyU=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB6691.apcprd03.prod.outlook.com (2603:1096:101:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 09:57:16 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 09:57:15 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 15/16] drm/mediatek: Support CRC in OVL
Thread-Topic: [PATCH v8 15/16] drm/mediatek: Support CRC in OVL
Thread-Index: AQHat/PHdknEuVE2R0mLZa88oDMI7bHDYaMAgA6xPIA=
Date: Fri, 21 Jun 2024 09:57:14 +0000
Message-ID: <bbd804c6d88b771da122353bae8065793abc6054.camel@mediatek.com>
References: <20240606092635.27981-1-shawn.sung@mediatek.com>
	 <20240606092635.27981-16-shawn.sung@mediatek.com>
	 <a470806f72747044c29097f33978faa545b9936d.camel@mediatek.com>
In-Reply-To: <a470806f72747044c29097f33978faa545b9936d.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB6691:EE_
x-ms-office365-filtering-correlation-id: 0a10607a-fc94-4005-e880-08dc91d8876a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?WWVFaDRncnJjeXNCdlo1SGFWaEVMOERZMVdUM1oweHdSNFoxMFR1bmdtZU5a?=
 =?utf-8?B?a2I2a0ViZEY4d0NWWmVmTmNvc2NaSFlOQmM2b3hPay9YYThFeUpEd0pGWmJX?=
 =?utf-8?B?YjZ4eTcrT2FlRzQxa3E1bmhQbnVwRllQYkFrdjZzZmROYUxFeTg1Vmx5MmRP?=
 =?utf-8?B?cGVXS3NJbU5ncmFRL3BhZzBRd2hEWEw5Tm5vN1pDdXR5K2JtR1pZcklxTGVJ?=
 =?utf-8?B?aHZMeGlZRjV2eVZBZzdJWWthOUJ5anllL1hCcHJuZE1icmNRRk9iVFg3ZWp1?=
 =?utf-8?B?Q2NGV3BHUUxkd2ZjVHNlVVZhVEd1MjNrSFJ3elN4dFlhYTdpVSs5R2o5ejFB?=
 =?utf-8?B?QlYyV3VLSkE0cWFZOXEvblV4cURpWTNiWkVBNmpOeHRXTS9zMVhNaWdHcXRJ?=
 =?utf-8?B?c2JibEV1UWErMnVvejc2U1VvaG9yL1RQdHIvRnZkWmpMbnh6RXVkNE9ZcjJC?=
 =?utf-8?B?eUxnQ0VESGdmcFZLd0ZZSVoveUJ2Q1lEMGxtSmkrekkydUlGdTBnT2xGNmNQ?=
 =?utf-8?B?eGlEYWQ0S2dSRktjbEM5Vy9OYWJiVnNRMDd2QUJYRnRDVkJHd2tJNyszcmhl?=
 =?utf-8?B?QzVGLy9NRFkwZ3NYWmlxQnFROE5XS09yVmNtZUlFSHJKZCtna3lQSVl1SG4w?=
 =?utf-8?B?SWZZMVJzY1ZpOUVDT08xRVdxWmhDNGU3UUQ3OXh6N2RxU2ZubnhIR3RmdkZn?=
 =?utf-8?B?RDllZFk1Q0JZbm90ZjZyV2M2b3V4SGZjSEdPVUpDTXI4cWlBMllHS2RqNzhN?=
 =?utf-8?B?Z0pHcHRjWEFPeTNCOEg4bENDQjZ1S05SN2pCSDE1Z3FUc2ZLSDMxNVdweHBU?=
 =?utf-8?B?OXNVUkY3MGUrTy9BQlZuZTRmSUFPa1N6NFNxTW9lZVhMUVRjYkhpMVdGZjVo?=
 =?utf-8?B?dkxRUm1scm1GSzBQUjUxNjVRYlFwMklKQ0ZodExYMlprc2lOSHRTSEdxVk40?=
 =?utf-8?B?YVo5QUtlOC9NUFBzRURjb0cyZFhQT283bTVBUFlsSG54bnQ1dVJ5bmdyMHFU?=
 =?utf-8?B?MENCNXZQSzNYZEhDdHdWVlkrWU9TZkozWWF6L3VpT2xnalZmaitPSmRUUjFt?=
 =?utf-8?B?TEJ5c2NYYzMwNzhrY1NuQVJHUHVlRDd6SjFVS2ltVUhadEExOG1LVzlSdzBp?=
 =?utf-8?B?cUh4b2JJczdBMC9rNVRCcWJtbmlWRExyZU0wNTRFbEJYdlBuQXVtRDI3dTN1?=
 =?utf-8?B?WHNOK0ludHFVQU9xdHRneUt6dHNGL25LUlQ3T1hKSCtuUG5FRi9aRHdBYm1B?=
 =?utf-8?B?UmIzc2dHaGJ5M21jZ1N4M0ppSU9mREdYa2c3VldQZHNSbFJZTDVqY3lEbzBZ?=
 =?utf-8?B?S2p4aDlESDNhUnBpRHFZODNCOVF5cHJ5YVVWMzh1R0VBSVlzaCtTTlBBTm03?=
 =?utf-8?B?Q2dOMGdieWhXUEhRblVGOGh3THVDUHhWVDhzeHFXUWxaclIyd0JRVEZyNTE4?=
 =?utf-8?B?VEpvdkZhVlBsN0NzYTBmN0x1QzQzdnIwbkNKMTJaNWQzU3E0RXJKQldPMzRu?=
 =?utf-8?B?SUhaUmwrUEhOODd1a3BnMVQzcmxMeXliZlVnSTlsK3daeDI2Y1lSZndubFo5?=
 =?utf-8?B?cjZXa3pMb3ZMMUhhWHd5S0pkbjZ4ZnVkWWI4dUlLNUtpTEV2ZWRPdnBEUHc1?=
 =?utf-8?B?UzVDcVlza1VIOE9hUm5lZHR1NTBtRWxVQ2tDeFdCakZUYUdJK0NYOXdjTmQz?=
 =?utf-8?B?NWl4d1p5WHFFNWNyZUhHdnlNZUNMNUg5WkpneFhoSEYxdEdmRmdOWGIrWXd0?=
 =?utf-8?B?RWs1WUppUEEyMmlVUHlpcXIzTURSNnlpYXdwZ2lRQWRDRnltS1QzY2FGSFZs?=
 =?utf-8?Q?EOq3DO0jr8R/niLzrI70XwXV6MJtWtHfSNM24=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWI4YXNWdWdRcGpITnp6Q0V4c1VwUDc1cFpscklxL0dJaFVQTmg4UXErWS9o?=
 =?utf-8?B?dWF3blBKcjJoQ1ViSjR5cTF2TFBxZ0I2RG83WjM3N24yYjBYWGVzNmJ4Y3cz?=
 =?utf-8?B?VTFTbzFZSWwrUXlhRlFsclRyQ0MyeGRvTXpqZG9ReWw4bmltZzhoMDVCQjBu?=
 =?utf-8?B?cVE0MnFhRVFwSXIrcVlVL3MwbnpVa2VlZVpaSW5DZ2tCN0RBc09JakpXTG1l?=
 =?utf-8?B?Y2lNTlZOU2Y3eHliazVYODZGSXNLQXlHbFg5MFlCTkhpdzM3d2wyVlRJMmNo?=
 =?utf-8?B?VU9WeUxYaUszc1VFS1pTTSttV2s5WXdhb09rQTlNNFNuY2g3eWtmVHI1YVpo?=
 =?utf-8?B?dUw3VlpNbGdFZlNOdHdSNzJ4N280SFdWbEthUjRoQ3hNSVIyalVGN25KTE5P?=
 =?utf-8?B?Sm5FWXlvem1CQ3FpaGJzZk44ODUyOWgzbEZITi80MnpFeXFTeUNYL21QTDFX?=
 =?utf-8?B?M09jN3prUUJrZE5WKzdPdGpFRERXd1I5Z0t4TmlxdjRWeVVWL2tMVmU1eHZl?=
 =?utf-8?B?bzVqbkNwMkxEUFlDRjkzS1RFRGt2NFpXU3UrVDNjUDNobzUxTDQ2TUtMdUNl?=
 =?utf-8?B?Y2ExNUhRV1QrTzJsTmppVGsrV3A5dE9OMWt0U2VDVHRkQk1EZTdJUTVQOTg0?=
 =?utf-8?B?Z3BFVmZYTmhoZklDSk5EWGMwdVJmT0hHZUlodCtXd3QyeTc0YzY1VElEUFlV?=
 =?utf-8?B?ZkRrUG8wSDN1Rnd3UHFnb2E0Z2x2eE5MWEVDTTFkVm1UaDkvdEhKMUpBQ1lJ?=
 =?utf-8?B?WGZ1Um9DdXFyT1ljR2VlVmtSSFdJSk55NjhZcy9iWjZ1RVE5QXpuODFkK3Yv?=
 =?utf-8?B?ZGVSaS84RTJzWWlIYXdkRWVCVTE4MVlmSW5aR2dJd3dpUm9hWVNkbW9QUTM5?=
 =?utf-8?B?VGxRc1BvN0lHcUZpV3hnazFNN1pWYTZoNmRPNG1JVHRDbElQMmZmK1pOMnRZ?=
 =?utf-8?B?YVBGOHpkRGh1VzdkV2ZlTDQxQ3krd0U0U2RmUHh2RlUybW1rL2ZyaW1FdERB?=
 =?utf-8?B?aXBzcXZNczAvV3pzMjlUcTBRVTdFOE54WWxyVEh1RE1MNklLQmk2aFlnQng2?=
 =?utf-8?B?L29HcWhaTmMrRk10RlkyV1FuWEZESUhkbzZmZU1PM1lsM2RrWmNrNFpmRzMz?=
 =?utf-8?B?V1BuVUNMMWFvUUNNNThLQklOeEIySkliaVpSaWdUM2o4T0MxSmU0aVVKVXN1?=
 =?utf-8?B?cENSMGc3anA0NVZxNjRrZ0lmZVRaSk52cjB2SjJoMzBPMHlwNUJJMHFpVi9t?=
 =?utf-8?B?elp5aERqTmNHZjFZaW9qa3FqZXQ5U1h1QWJiTDZxWHpKTnZHVzlJWGZmcnZj?=
 =?utf-8?B?YThLaVVCRVZwOGxQMHlaZVRUK29iUEs3WlU3VXNLUng1TnArdzFDeVJZV3RL?=
 =?utf-8?B?ZkFSM056aE1iTndXUlp2MXZVeGxwMDdTUXpGWVhEczJoNEpzQlF6SnJmckNk?=
 =?utf-8?B?clB0Q1liWnd4bjY4SnZ2K0xGVndkVHcwTjhUQmQ3V0JDazhxNGF2dGhpQ21Z?=
 =?utf-8?B?S1k4d3Jtc3lWcjZCUDZFMHI0dXVsNUhPTWl3bzlaeWg0YnRCbldnazdMejZ0?=
 =?utf-8?B?Vkl1ZHhaOFU4a0g1dUZUSGJFT1JOV0h4SkZKbnhENHJneHduQzFuaUdFZENt?=
 =?utf-8?B?VWZhc2tjcTlMMXlxSTFmMGl6VnVpQ2xYZFdRVjJwWHA0R1NyL01xL1htdVAz?=
 =?utf-8?B?TTRaMk1qMFp2QjQrbXRON3JTcGlxRXFweXN3d0k1anV6OWVBeGhGQnlFSkNG?=
 =?utf-8?B?UVVMK3h6QzR0dzJXaVdDZyt1cVN3Z2lTcG1ZTU9pYWpqMlJSdDliUW9BRDJl?=
 =?utf-8?B?czFoZ1diZXVVRTB4REJwcjVEOGJ3dXpmZzZJbVZBRWVoR2JkTjFiZjc0UUFP?=
 =?utf-8?B?UVJ5WDkrNlBHU1pndTJWbUZyRjMwYjYxRUxsZzRHYXlTZFlqT2ZZV2Rsa3ND?=
 =?utf-8?B?QzNuN0hQdFgxU24yalpnQU9ONGdNaXJqVmQ5MWVqSUd4c2gyQlNQMExFMk92?=
 =?utf-8?B?aHVXekE2TDFVTlRmZ3hJdXBDZDNieldUYTBvUEFpeHFpeDlaZWlnYWFWakRn?=
 =?utf-8?B?MlcxS2Z6akVhOGxweElMbUV1ZXZTYmN0VUE2RS82TWtTemM2Q2dSNXpZZnUw?=
 =?utf-8?B?UGltbUtZQkU1OENTbjRuMnFJd1k1Qk82enlOc0NvTTN4QUMxUDY3V3g1VmNS?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C2E4AD76FF35545ABD53CEA76D7E000@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a10607a-fc94-4005-e880-08dc91d8876a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 09:57:15.0064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TSHMFb+X7d+XYYlSDyy7W26LSqh8AReYLOEiQ1yOJtwHFilWIF+9CbfpHF9HxtGNpzIciZlm2ac6Bz5xnpEQ/XgXK1gyFE1ib0B6ndfh04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6691

SGkgQ0ssDQoNCk9uIFdlZCwgMjAyNC0wNi0xMiBhdCAwMTozNSArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBTaGF3bjoNCj4gDQo+IE9uIFRodSwgMjAyNC0wNi0wNiBhdCAx
NzoyNiArMDgwMCwgU2hhd24gU3VuZyB3cm90ZToNCj4gPiBGcm9tOiBIc2lhbyBDaGllbiBTdW5n
IDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBXZSBjaG9vc2UgT1ZMIGFzIHRo
ZSBDUkMgZ2VuZXJhdG9yIGZyb20gb3RoZXIgaGFyZHdhcmUNCj4gPiBjb21wb25lbnRzIHRoYXQg
YXJlIGFsc28gY2FwYWJsZSBvZiBjYWxjdWxhdGluZyBDUkNzLA0KPiA+IHNpbmNlIGl0cyBmcmFt
ZSBkb25lIGV2ZW50IHRyaWdnZXJzIHZibGFua3MsIGl0IGNhbiBiZQ0KPiA+IHVzZWQgYXMgYSBz
aWduYWwgdG8ga25vdyB3aGVuIGlzIHNhZmUgdG8gcmV0cmlldmUgQ1JDIG9mDQo+ID4gdGhlIGZy
YW1lLg0KPiA+IA0KPiA+IFBsZWFzZSBub3RlIHRoYXQgcG9zaXRpb24gb2YgdGhlIGhhcmR3YXJl
IGNvbXBvbmVudA0KPiA+IHRoYXQgaXMgY2hvc2VuIGFzIENSQyBnZW5lcmF0b3IgaW4gdGhlIGRp
c3BsYXkgcGF0aCBpcw0KPiA+IHNpZ25pZmljYW50LiBGb3IgZXhhbXBsZSwgd2hpbGUgT1ZMIGlz
IHRoZSBmaXJzdCBtb2R1bGUNCj4gPiBpbiBWRE9TWVMwLCBpdHMgQ1JDIHdvbid0IGJlIGFmZmVj
dGVkIGJ5IHRoZSBtb2R1bGVzDQo+ID4gYWZ0ZXIgaXQsIHdoaWNoIG1lYW5zIGVmZmVjdHMgYXBw
bGllZCBieSBQUSwgR2FtbWEsDQo+ID4gRGl0aGVyIG9yIGFueSBvdGhlciBjb21wb25lbnRzIGFm
dGVyIE9WTCB3b24ndCBiZQ0KPiA+IGNhbGN1bGF0ZWQgaW4gQ1JDIGdlbmVyYXRpb24uDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gIA0KPiA+ICB2b2lkIG10a19v
dmxfc3RvcChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gQEAgLTQ4OSw2ICs1NzksODMgQEAgdm9p
ZCBtdGtfb3ZsX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gdW5zaWduZWQg
aW50IGlkeCwNCj4gPiAgCSAgICAoc3RhdGUtPmJhc2UuZmIgJiYgIXN0YXRlLT5iYXNlLmZiLT5m
b3JtYXQtPmhhc19hbHBoYSkpDQo+ID4gIAkJaWdub3JlX3BpeGVsX2FscGhhID0gT1ZMX0NPTlNU
X0JMRU5EOw0KPiA+ICANCj4gPiArCS8qDQo+ID4gKwkgKiBPVkwgb25seSBzdXBwb3J0cyA4IGJp
dHMgZGF0YSBpbiBDUkMgY2FsY3VsYXRpb24sIHRyYW5zZm9ybQ0KPiA+IDEwLWJpdA0KPiA+ICsJ
ICogUkdCIHRvIDgtYml0IFJHQiBieSBsZXZlcmFnaW5nIHRoZSBhYmlsaXR5IG9mIHRoZSBZMlIg
KFlVVi0NCj4gPiB0by1SR0IpDQo+ID4gKwkgKiBoYXJkd2FyZSB0byBtdWx0aXBseSBjb2VmZmlj
aWVudHMsIGFsdGhvdWdoIHRoZXJlIGlzIG5vdGhpbmcNCj4gPiB0byBkbw0KPiA+ICsJICogd2l0
aCB0aGUgWVVWIGZvcm1hdC4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKG92bC0+ZGF0YS0+c3VwcG9y
dHNfY2xyZm10X2V4dCkgew0KPiA+ICsJCXUzMiB5MnJfY29lZiA9IDAsIHkycl9vZmZzZXQgPSAw
LCByMnJfY29lZiA9IDAsIGNzY19lbg0KPiA+ID0gMDsNCj4gPiArDQo+ID4gKwkJaWYgKGlzXzEw
Yml0X3JnYihmbXQpKSB7DQo+ID4gKwkJCWNvbiB8PSBPVkxfQ09OX01UWF9BVVRPX0RJUyB8IE9W
TF9DT05fTVRYX0VOIHwNCj4gPiBPVkxfQ09OX01UWF9QUk9HUkFNTUFCTEU7DQo+ID4gKw0KPiA+
ICsJCQkvKg0KPiA+ICsJCQkgKiBZMlIgY29lZmZpY2llbnQgc2V0dGluZw0KPiA+ICsJCQkgKiBi
aXQgMTMgaXMgMl4xLCBiaXQgMTIgaXMgMl4wLCBiaXQgMTEgaXMgMl4tDQo+ID4gMSwNCj4gPiAr
CQkJICogYml0IDEwIGlzIDJeLTIgPSAwLjI1DQo+ID4gKwkJCSAqLw0KPiA+ICsJCQl5MnJfY29l
ZiA9IEJJVCgxMCk7DQo+ID4gKw0KPiA+ICsJCQkvKiAtMSBpbiAxMGJpdCAqLw0KPiA+ICsJCQl5
MnJfb2Zmc2V0ID0gR0VOTUFTSygxMCwgMCkgLSAxOw0KPiANCj4gSSBkb24ndCBrbm93IHdoeSBk
byB0aGlzPyBJZiBhbiBpbnB1dCB2YWx1ZSBpcyAweDEwMCwgdGhlbg0KPiANCj4gMHgxMDAgcmln
aHQgc2hpdCAyIGJpdCBiZWNvbWUgMHg0MC4NCj4gMHg0MCAtIDEgPSAweDNmLg0KPiAweDNmIGxl
ZnQgc2hpZnQgMiBiaXQgYmVjb21lIDB4ZmMuDQo+IA0KPiBTbyBpbnB1dCAweDEwMCBhbmQgb3V0
cHV0IDB4ZmMuIFdoeT8NCj4gDQpUaGlzIHNob3VsZCBiZSAtMiwgbm90IC0xLg0KSXQgaXMgdG8g
cmlkIG9mIHRoZSBsYXN0IDIgYml0Lg0KDQpPVkwgSFcgZG9lcyBub3QgdXNlID4+IDIgYW5kIHRo
ZW4gPDwgMiwgYnV0IHVzZXMgKjAuMjUgYW5kIHRoZW4gcm91bmRzDQp0byBhIHBvc2l0aXZlIGlu
dGVnZXIgYW5kIHRoZW4gKjQsIHNvIGl0IGlzIG5lY2Vzc2FyeSB0byByZW1vdmUgdGhlDQpsYXN0
IDIgYml0cyBieSAtMiBiZWZvcmUgZG9pbmcgdGhlIG9wZXJhdGlvbi4NCg0KSWYgdGhlIGZvcm11
bGEgaXM6IHJvdW5kKGlucHV0IGRhdGEgKjAuMjUsIDApICo0DQpUaGUgaW5wdXQgZGF0YSBpcyAz
LCBhbmQgaXQgd2lsbCBiZWNvbWUgNCBhZnRlciBjYWxjdWxhdGlvbi4NCg0KSWYgdGhlIGZvcm11
bGEgaXM6IHJvdW5kKChpbnB1dCBkYXRhIC0gMikgKjAuMjUsIDApICo0DQpUaGUgaW5wdXQgZGF0
YSBpcyAzLCBhbmQgaXQgd2lsbCBiZWNvbWUgMCBhZnRlciBjYWxjdWxhdGlvbi4NCg0KPiA+ICsN
Cj4gPiArCQkJLyoNCj4gPiArCQkJICogUjJSIGNvZWZmaWNpZW50IHNldHRpbmcNCj4gPiArCQkJ
ICogYml0IDE5IGlzIDJeMSwgYml0IDE4IGlzIDJeMCwgYml0IDE3IGlzIDJeLQ0KPiA+IDEsDQo+
ID4gKwkJCSAqIGJpdCAyMCBpcyAyXjIgPSA0DQo+ID4gKwkJCSAqLw0KPiA+ICsJCQlyMnJfY29l
ZiA9IEJJVCgyMCk7DQo+ID4gKw0KPiA+ICsJCQkvKiBDU0NfRU4gaXMgZm9yIFIyUiAqLw0KPiA+
ICsJCQljc2NfZW4gPSBPVkxfQ0xSRk1UX0VYVDFfQ1NDX0VOKGlkeCk7DQo+ID4gKw0KPiA+ICsJ
CQkvKg0KPiA+ICsJCQkgKiAxLiBZVVYgaW5wdXQgZGF0YSAtIDEgYW5kIHNoaWZ0IHJpZ2h0IGZv
ciAyDQo+ID4gYml0cyB0byByZW1vdmUgaXQNCj4gPiArCQkJICogW1InXSAgIFswLjI1ICAgIDAg
ICAgMF0gICBbWSBpbiAtIDFdDQo+ID4gKwkJCSAqIFtHJ10gPSBbICAgMCAwLjI1ICAgIDBdICog
W1UgaW4gLSAxXQ0KPiA+ICsJCQkgKiBbQiddICAgWyAgIDAgICAgMCAwLjI1XSAgIFtWIGluIC0g
MV0NCj4gPiArCQkJICoNCj4gPiArCQkJICogMi4gc2hpZnQgbGVmdCBmb3IgMiBiaXQgbGV0dGlu
ZyB0aGUgbGFzdCAyDQo+ID4gYml0cyBiZWNvbWUgMA0KPiANCj4gWW91IHRydW5jYXRlIHRoZSBs
YXN0IHR3byBiaXQsIHNvIHNvbWUgcXVhbGl0eSBsb3N0LiBJIHRoaW5rIHRoZQ0KPiBxdWFsaXR5
IGlzIG1haW4gZnVuY3Rpb24gYW5kIENSQyBpcyBqdXN0IGZvciBkZWJ1Zy4gU28gaXQncyBiZXR0
ZXINCj4gdGhhdA0KPiBpbiBub3JtYWwgY2FzZSB3ZSBrZWVwIHF1YWxpdHkgYW5kIG9ubHkgZm9y
IGRlYnVnIHRvIGxvc3QgdGhlDQo+IHF1YWxpdHkuDQoNCkkgYWdyZWUgd2l0aCB0aGlzLCBJJ2xs
IGFkZCBjcmMub3BlbmQgZmxhZyB0byBieXBhc3MgdGhlc2Ugc2V0dGluZ3MuDQoNCj4gIA0KPiBJ
IGhhdmUgYW5vdGhlciBxdWVzdGlvbi4gWW91IGp1c3QgdHJ1bmNhdGUgdGhlIGxhc3QgdHdvIGJp
dCBidXQgaXQgaXMNCj4gc3RpbGwgMTAgYml0IHZhbHVlLCBzbyBDUkMgY291bGQgY2FsY3VsYXRl
IHRoaXMgMTAgYml0IHZhbHVlPyBJIGRvbid0DQo+IGtub3cgd2h5IHlvdSBzYXkgQ1JDIGp1c3Qg
Zm9yIDggYml0Pw0KPiAgDQoNCk9WTCBpcyAxMC1iaXQgcGVyIFJHQiBjaGFubmVsLCBzbyB0aGUg
OC1iaXQgdmFsdWUgd2lsbCBiZSBwYWRkaW5nIHdpdGgNCjItYml0cyAwIGluIHRoZSBlbmQsIHNv
IHRoZSBDUkMgdHJ1bmNhdGluZyB0aGUgbGFzdCAyLWJpdCBpbiAxMC1iaXQNCnZhbHVlIHdvdWxk
IGJlIHRoZSBzYW1lIGFzIG9yaWdpbmFsIGNhc2UuDQoNCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQo+
ID4gKwkJCSAqIFtSIG91dF0gICBbIDQgIDAgIDBdICAgW1InXQ0KPiA+ICsJCQkgKiBbRyBvdXRd
ID0gWyAwICA0ICAwXSAqIFtHJ10NCj4gPiArCQkJICogW0Igb3V0XSAgIFsgMCAgMCAgNF0gICBb
QiddDQo+ID4gKwkJCSAqLw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJbXRrX2RkcF93cml0ZV9t
YXNrKGNtZHFfcGt0LCB5MnJfY29lZiwNCj4gPiArCQkJCSAgICZvdmwtPmNtZHFfcmVnLCBvdmwt
PnJlZ3MsDQo+ID4gRElTUF9SRUdfT1ZMX1kyUl9QQVJBX1IwKGlkeCksDQo+ID4gKwkJCQkgICBP
VkxfWTJSX1BBUkFfQ19DRl9STVkpOw0KPiA+ICsJCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3Br
dCwgKHkycl9jb2VmIDw8IDE2KSwNCj4gPiArCQkJCSAgICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJl
Z3MsDQo+ID4gRElTUF9SRUdfT1ZMX1kyUl9QQVJBX0cwKGlkeCksDQo+ID4gKwkJCQkgICBPVkxf
WTJSX1BBUkFfQ19DRl9HTVUpOw0KPiA+ICsJCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwg
eTJyX2NvZWYsDQo+ID4gKwkJCQkgICAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiA+IERJ
U1BfUkVHX09WTF9ZMlJfUEFSQV9CMShpZHgpLA0KPiA+ICsJCQkJICAgT1ZMX1kyUl9QQVJBX0Nf
Q0ZfQk1WKTsNCj4gPiArDQo+ID4gKwkJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCB5MnJf
b2Zmc2V0LA0KPiA+ICsJCQkJICAgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywNCj4gPiBESVNQ
X1JFR19PVkxfWTJSX1BBUkFfWVVWX0FfMChpZHgpLA0KPiA+ICsJCQkJICAgT1ZMX1kyUl9QQVJB
X0NfQ0ZfWUEpOw0KPiA+ICsJCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgKHkycl9vZmZz
ZXQgPDwgMTYpLA0KPiA+ICsJCQkJICAgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywNCj4gPiBE
SVNQX1JFR19PVkxfWTJSX1BBUkFfWVVWX0FfMChpZHgpLA0KPiA+ICsJCQkJICAgT1ZMX1kyUl9Q
QVJBX0NfQ0ZfVUEpOw0KPiA+ICsJCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgeTJyX29m
ZnNldCwNCj4gPiArCQkJCSAgICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3MsDQo+ID4gRElTUF9S
RUdfT1ZMX1kyUl9QQVJBX1lVVl9BXzEoaWR4KSwNCj4gPiArCQkJCSAgIE9WTF9ZMlJfUEFSQV9D
X0NGX1ZBKTsNCj4gPiArDQo+ID4gKwkJbXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCBy
MnJfY29lZiwNCj4gPiArCQkJCSAgICAgICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3MsDQo+ID4g
RElTUF9SRUdfT1ZMX1IyUl9SMChpZHgpKTsNCj4gPiArCQltdGtfZGRwX3dyaXRlX3JlbGF4ZWQo
Y21kcV9wa3QsIHIycl9jb2VmLA0KPiA+ICsJCQkJICAgICAgJm92bC0+Y21kcV9yZWcsIG92bC0+
cmVncywNCj4gPiBESVNQX1JFR19PVkxfUjJSX0cxKGlkeCkpOw0KPiA+ICsJCW10a19kZHBfd3Jp
dGVfcmVsYXhlZChjbWRxX3BrdCwgcjJyX2NvZWYsDQo+ID4gKwkJCQkgICAgICAmb3ZsLT5jbWRx
X3JlZywgb3ZsLT5yZWdzLA0KPiA+IERJU1BfUkVHX09WTF9SMlJfQjIoaWR4KSk7DQo+ID4gKw0K
PiA+ICsJCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgY3NjX2VuLA0KPiA+ICsJCQkJICAg
Jm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywNCj4gPiBESVNQX1JFR19PVkxfQ0xSRk1UX0VYVDEs
DQo+ID4gKwkJCQkgICBPVkxfQ0xSRk1UX0VYVDFfQ1NDX0VOKGlkeCkpOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiAgCWlmIChwZW5kaW5nLT5yb3RhdGlvbiAmIERSTV9NT0RFX1JFRkxFQ1RfWSkgew0K
PiA+ICAJCWNvbiB8PSBPVkxfQ09OX1ZJUlRfRkxJUDsNCj4gPiAgCQlhZGRyICs9IChwZW5kaW5n
LT5oZWlnaHQgLSAxKSAqIHBlbmRpbmctPnBpdGNoOw0KPiA+IA0K

