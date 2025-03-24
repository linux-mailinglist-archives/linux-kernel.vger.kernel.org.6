Return-Path: <linux-kernel+bounces-573358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DDDA6D636
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F4816AF75
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D6C25D213;
	Mon, 24 Mar 2025 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N36c58US";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="GuQVmQAH"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BE2D7BF;
	Mon, 24 Mar 2025 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805212; cv=fail; b=BY2D/g4ANnBDc326H/nExFH0OEoK1cCw0Dgh3S7ICvANy3ydPYsqQo3Wg3bmRiBvaQaxIO+Kh+bulwBfyyfBLoIpo1BSy7R1I2AddlEoDGXrE4FbwP+rQtJC9bkVhY/2NlkIjVyGBOsznyk4Kx3EbA7mW5Q2rnRGkuz3DD+Bv0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805212; c=relaxed/simple;
	bh=K+GUeN2ytO8jWpizVusPfuAXMzu4pGbEwKlwBFT/VGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aDFRwGXSEKHEQaW5FjTTUfMffK0W/cH1rewXFnP5+/OKwj10lH0alW2PO3TXJ+3+nQHm30IVRVvMtPdnyQC21fECM37hX6ogvz9tH5vexX42OsoRsxFWOUkMW05Soi3+DDtx9ttfNcUSoZEFhPLodtHZxAyO1Ilbh2HMeJM7kKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N36c58US; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=GuQVmQAH; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a69cdd14088a11f0aae1fd9735fae912-20250324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=K+GUeN2ytO8jWpizVusPfuAXMzu4pGbEwKlwBFT/VGc=;
	b=N36c58USaFleI/HINOMiWcMnW899CWzRtsZQLRwbphhzgFQ9X95EgXfay//duiW68MqswngplsxUCFhvlR25AiX91ixPCZ09XQ7sIeZJu6I1Mio+tXJn98p3nOb3OUNZYa3eVuGbat13N3u2y2X87r5pye1TFYlts3nlJj6jsCs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:d004cfed-0ed9-4a9c-b7d5-bbdd217d892f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:412bbabc-192a-4d29-8abd-6d5530e5e205,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a69cdd14088a11f0aae1fd9735fae912-20250324
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1678568958; Mon, 24 Mar 2025 16:33:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 24 Mar 2025 16:33:22 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 24 Mar 2025 16:33:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goR1uwSLBdNoSDafRMGKcVaNj4+RoNZEy9V9hgb7XvxbQhoyCfiUc/puW4xoVLxPcyAOtMR9i0Cm92nFaU+eK3xZWutlAenHDcivmq1clwviDwtIlPjloENRem7N97bbAazza/xlUefJqPnUbvPPmfeqbfBDMyK7FH0amiUHHRQnnbwJTUg5ZLAnWci5g7c5uuCVMbvPXozpFlDYu5swNZezx0x/N/W2Men/AtaaVNPDZn2SJWHTJY2wygOcNhezXELVNXvkGG2aew/ep0Y/CzL/SLU17n8a8RCndX52cNPZcrm3yVm2dx4vQRffOkiNuOj7hmDJbcFzXV9HzzoAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+GUeN2ytO8jWpizVusPfuAXMzu4pGbEwKlwBFT/VGc=;
 b=g2BrCbA5L9mSjUnu/0j6Q4N0BC36II01OzxyG/MuS/mvYhvZ0ATEPQccLWsjxWZCZvdClIReJT9y9gfXje5g72U1NVRVoR1W16B13rw5rDXipKhnKmrsW0OTwpjzAuXLqn1xxfYC96ddA2FMDnCGnMCEceGFhbPob29y5SP0rdTgMYTxOwDuGV8h8Z8sofNJ0qxAX5MKo/VraTiLv1DmBDUkN7OYm1E+s+xR9ipbr2li9L64+kT09yMVAcZwSLhtcQkSYaz1WjRYOACXaYWHwIqXRVY/ySCRqVMEgnBJHPclXkxnPtPIX6Ot1JLO2vl177uoR848JGzsQW4mzqoHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+GUeN2ytO8jWpizVusPfuAXMzu4pGbEwKlwBFT/VGc=;
 b=GuQVmQAHxDS/UPGtbmKe2PU0KHM/gQyyqRdBSoCv9j5qBmw94gnfV5aM6KfIKPGgHIH4OBCry9RtoAJZpFQ2brBOmF6dHmN14w+8TqA/WN4Y2gZbcmZm7XD6Jyw/nurlEGM2WxP3i8F4crOByeW9UOe2lucILGE6rKqazsnBjbY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7635.apcprd03.prod.outlook.com (2603:1096:990:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:33:20 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%2]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:33:20 +0000
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
Subject: Re: [PATCH v2 11/15] drm/mediatek: add BLENDER support for MT8196
Thread-Topic: [PATCH v2 11/15] drm/mediatek: add BLENDER support for MT8196
Thread-Index: AQHbmkTZhZLzPbcGSkeDNj9BtSE+UbOB+kCA
Date: Mon, 24 Mar 2025 08:33:20 +0000
Message-ID: <0daf839388be6861c1d0d02d6167942a57ec8e38.camel@mediatek.com>
References: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
	 <20250321093435.94835-12-paul-pl.chen@mediatek.com>
In-Reply-To: <20250321093435.94835-12-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7635:EE_
x-ms-office365-filtering-correlation-id: be0629a1-d86f-4b72-1351-08dd6aae886e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SmNQR2VCSXMrRTBSTWk2djZqOGNJQ0FRbXBjakNQbkp2NU9JempiVlc3cFBJ?=
 =?utf-8?B?TUR5YUQrQkRyaGl4c0crYWJmUjM2MzFHMXZNUzBXWUdIVmlKY3l0cWtmRW12?=
 =?utf-8?B?VDFrb2c0NjFaWHN3VjZKUWladHNSWmdhUkxvVENNMjZlRnlWUElYUlN4aC9N?=
 =?utf-8?B?N0ZEcWx5MncvYW13SytSb2tHOVFmM0tLQlhnc3dnK2EvUjdxNExqYmg2eVVq?=
 =?utf-8?B?YVBhaXpMb2hXczVpYUYvS2xEdXpKN29Xc2QvU090bk11ZURhUXQ3cFZPMzVU?=
 =?utf-8?B?d3djcDh4RE5IKzhNMitXUEdlUk5RbzJHUU9VZm53aFpOeTFXcnJ1eGp1SVpI?=
 =?utf-8?B?ZENiLzBOcTlnaDVKalQwUjRzUVowTTZtSEZ6ckhVZU9NZFE1eW0zV0p5Nmtk?=
 =?utf-8?B?NzFaZmdpSTJoYllINEM5NzdzYXZxRUNCK3dXSlp0NE1iU0RSQVI1dFdrTFBG?=
 =?utf-8?B?MU1kamRTZTZ0Y3FVSmgxaUJ0Z2g4NHVSWmt0emYwekZwQ3F2MjBCV1VJeTE4?=
 =?utf-8?B?cW03cmJoQ210YkhKMnMwbm1YZ1M0YVJSRm5PUTgxa1lZNFZHcW1YQlpJcDZu?=
 =?utf-8?B?NEV3bnNYT1RqaGM5dDlOUGY1WUFmRVk5VVNYUGVWdUJ4Uit2ZXVZMUFlWTla?=
 =?utf-8?B?bUZldGVLQzU3RWNhbmVvYjBmeUpJMEF1Rm41Mk1EcU1oSEI0WEZHRXIxaDhI?=
 =?utf-8?B?NENGYU9FUVBlTld0QVJqS1lCQUpZeHZ2aEs5d3FLUVcyNXpFTEwyYm1BaXJh?=
 =?utf-8?B?ZnNnSTlVb3VjdXZYU0hxdml6RCtLdlpiUHA5ZkgvUjF5MkdzS2tBZGJMQ0lu?=
 =?utf-8?B?bUpXdXVLdGRzYlVOU1BGKzlydUQvdDMzRGcyN2t1ckZGdVFua0JtcVRkcmVn?=
 =?utf-8?B?cHE0V3lVU1NFNzhuMlViL3cyVjN0TFdFS21UWmZCTXQ3U083M1dud2phM01R?=
 =?utf-8?B?V2NaZmFscXdFcXZ6RmY3SVRUSEd5MjJXQ2JDVWNyTGVUaHFDZ0k1VzhSMmI5?=
 =?utf-8?B?eXA3TXVTZmVRNTR4Z1VvczlUM25YcFU0SXdBQVVWMGErdlVIeGFqRmZLT1Fh?=
 =?utf-8?B?ejYySzcwT3dtUkhPOEpTa2p1MGcvRUlBdk11Mm1QQ3RTL3BMY2VGbHpLekZE?=
 =?utf-8?B?OXErSit3UmpsWVIrVWdVOXNaRWhxNnJvK2pZN2RvZWJheUhxTjNua09kN2V3?=
 =?utf-8?B?OXFsbDBRSnZyY09INVo0cjQrNXBMM2xYYUdnZUJhVVN1eE1vN3FTRVpXSVRC?=
 =?utf-8?B?Y1BkN2RZMFRUVHFQODhtS2tVYkFSeWhJTE44SnZQSXFHcWlBZ1I2aWQxTHAx?=
 =?utf-8?B?cTcvOUVhTzd0ZUlCTXVZTzZiUGtTMCtTVXI0c3Y4cDUxcGF3NXZuMDJ3MmxL?=
 =?utf-8?B?aGppa2V0VytHeTBTTnN2NFpiczYzbXVMbGhUWnB5WStKNGp0SzBhOU9BV09s?=
 =?utf-8?B?b2hNbXljZ1BGc25WUFV5NmV0Q2FOTFJRWldZaFBtNGhVOXVtaDk1VFFXbVJU?=
 =?utf-8?B?azA2T2FOSndMVERmNS81alI5Q0JqN3oyb2tWTktLNmVSSGdJQjd0Ymw3eGVX?=
 =?utf-8?B?OENTVW1RbVpZNzRGNFFNZjBKekpObmlWUmpBWFRVY3Z1UmhEZlZ3Wm4wMHE4?=
 =?utf-8?B?emt1WEhIZHF6eDArMEo0L0tTOVJnY2h0QmNIbDhZK1AyTDNEdmdvZWxqTlVx?=
 =?utf-8?B?d2YxdHpnRXJhZUZ6eWJ1bXlEOC9wUmdPeG5DeDVkSDRzV21mWC9vTU9icHJP?=
 =?utf-8?B?Q2dTeFMzdkYwL0gzcmFEWllHRXZnRzkzaTlwd3VOVGpHV0ZKelFmekYzZ0tp?=
 =?utf-8?B?VUd2QjNybmdrYndvUlNkcWFkWG9Jang1SzdvWG9OOWx4TTY2d1BHODlMaXJq?=
 =?utf-8?B?cy9zakhPUWh3enpxVDQ4M05iQ1FGYVZiWUhOdlpiWmJiMWtXRkhsRi8zSmV3?=
 =?utf-8?B?M1E1N2VqUUxDMSsrODF3NHhqSGlSZU9ybGNuY1RCbEY3ZkxEai9ET1hDZXpv?=
 =?utf-8?Q?8+LAhqDgqwT4MhcCzenLbLG9RRBOpw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXpsZUc3VEc2cVgrNFZjTU5Oc0xXOXV6VklGZ2JLaDFNUGtvWUZVK2Q0NzVw?=
 =?utf-8?B?alcxNkNpcEZrRmhBTzdwdFBZaEpITHRIL2t3SVoxZ25NNWVqNnVxYUZoN0ty?=
 =?utf-8?B?VjRxMWRmdm5PMlU3MTgzejlaZXZ6R05rV1BQcXU5WUY2blI0TVRCQktaeEg4?=
 =?utf-8?B?bkcxUmJtZTRvU3FOUjBibDRoMENob0hiZE9idXVnR0lUdDl1YTNQMXo3TmFW?=
 =?utf-8?B?UGtWNG1QR21hUGtKUkxNWVp1aXlOWmkwWXpFdjlnZWZydUVrWWkyWDV6MzY1?=
 =?utf-8?B?dlVCV3kyYURoTlNtbk5xOWFUQURDUDk0S0lTMEVXUDlKakg5RG1UcCtXTUhP?=
 =?utf-8?B?RjkwaHBYaGUrU1ZxbTZXZjhwemtVVmRVVzBhTVhLRi84Y25xSWg0ZCt6RHAx?=
 =?utf-8?B?S3NORU43cy9WeHFma3I2UDhWTmk4THZMaDd5djByUUFBTEpmZHA0OHdWSWQ3?=
 =?utf-8?B?aGwweWNlNXhTcFJ5a1FaazBKUWhYZHA4WHZqa3Iwa2pGUmdzSGtSYXp2VEkr?=
 =?utf-8?B?NWhSWGZRQlhXK3Y2ZCtYZERYaTgvWjZzcXZNMElBbEtid3FvQ3pHVm1EelVW?=
 =?utf-8?B?dEVlOEhIU3VqM3lQZVcyUXJPV0x1cTk0dnI3eUNvWmVCWlJYK3VIeU5JRDlK?=
 =?utf-8?B?TlpLWENVTlk0RGY1Tm5RbTBGQWQxLzRoUnpieWlOS01CNzBCNGpncW5aeFN2?=
 =?utf-8?B?RVFrTlV3SEFlTG41UXFDQTFGOCt4b3FuMlErTFNJMWh6VUo5MDhXSEQvbStV?=
 =?utf-8?B?dnNjUE42OHMxeE5FQS9TYm9nMzVlNldtbVJXU0JFcUZEM003eld6dnZXV0Zr?=
 =?utf-8?B?LzQvdGFzNVdvRmpKUXVjamVqRW1NOG41SVZRQVpaemJEWTRrR0hCOHJKaFVN?=
 =?utf-8?B?aSswNkFPZ3FEeWZuSWdkN3V0R01MTStYcVJrT0krZjlkSmVuWEp0a1MyM2x0?=
 =?utf-8?B?RStKVGFCK3VZV2pTY2FHVE9wckdwWHhFbFVFQzR2Y1dNdDFFdVNib0FWZnMy?=
 =?utf-8?B?ZVJLYXQvVEk2NExuNTFRSnB6ZG9HcGg0ZnBlRHQxbjI0Ync0OFZRQ1ZkTXA3?=
 =?utf-8?B?Y0dTczQ0bGVjUU54V25FTzRkTitmUnEyNjlLK1dVa0Z5a1ZHOFFORTFuT1VJ?=
 =?utf-8?B?ZitxQ3htN2p2YUVrekI5eGUvVVRDRWFNdWxSaGhia25GeVJUazV0SDhITUg2?=
 =?utf-8?B?M3ZObi85UWdmVU03ZDRLa1BGb3VNV1UvOTYxYVVlOXZOaEF4OVpkUzlXVEk1?=
 =?utf-8?B?NUp1ZzJsWXZEeVhXVlFlNHlpdFZIbGRvRnJHTm9OMGZJajRpMHhXaUlvQ1NW?=
 =?utf-8?B?alRrbEd0SDJTb1pFSUNCWlhJNzd0ZFloTGk3cG5vcTNlaG5uT3hGOExsRmtC?=
 =?utf-8?B?ejdScmU1dSs3S2QvcjlWdjJHd3BrNXU5Vko4aUkwQ3lKNExCQXArdzZrT3M5?=
 =?utf-8?B?cm9SVXh3ZDRJaFhKTFZNMWdGZVB3bDhEYzlmYlFhQWxqaytUSGpKQm9VWmZP?=
 =?utf-8?B?cnI3djZ2VXovVlpnUTdVMXpvR1B1SWtyaG1LcFpsSjJ2aFpVZ2hGRS9PdG14?=
 =?utf-8?B?aHgrWVd1MnVZRmc4bDNacjBMSFFSZnZZbDgvMlIvNERqc2dUL25Ydnk5NkUr?=
 =?utf-8?B?ajFDN0J0VWlsSWRLU2xUMCtyVHZLS0xtVkx5S3NCSzZwNm5OeWVSQStJa1h0?=
 =?utf-8?B?cW9DRnBZNGgwd0RVMktiKzZmeFRKUG9xVENTMVIvWVdVMXQwM1hnbmJFblEr?=
 =?utf-8?B?UHVXaEFCQjBXbXNyN29LRU5qd1JaME5Lb1NUaWJnSDM0NHhYd1BhU29WSzJ5?=
 =?utf-8?B?clB4U0NKV1JlN3FaUDAza0FSM210WTZoQnkzbzd6TzFqamJSKzY0dnZOUzBO?=
 =?utf-8?B?b0xkMWY4aktYRzF3cDZJMklVVm1jdnBLZkpQdWZ2S2Zxc1NXdDUydkd2MzVz?=
 =?utf-8?B?RUkwWGlvSHF1YVFSREZ6WFNDbEpnbG4yN1pPTzNoZjArM2E5QVFobTNPT1g2?=
 =?utf-8?B?cERGeWtFZG51R0JwM2VvdVIyRk9EQStTam5adGJoajlrRGlneWpEVys4Wmkr?=
 =?utf-8?B?TWpYeFhkWm52N1FZSHE2cmFqTmZvSGtyTnNsdlBnc3NjL0Z5NzdJbnROcmNq?=
 =?utf-8?B?U09mUEx3NEVZK2lPWXFyUjlpbmZCNUxiWUtVVkZSZCtPa1RUa2dxQlY0SjVp?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C299A0E0365CA49B4DF32C9513F584A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0629a1-d86f-4b72-1351-08dd6aae886e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 08:33:20.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwQCmIwwM167l1SjcfMK/5t0qc285PATCmkS5pBb2bHQgKf2poIjoGHA49GBFHMXmeQHEbb6PQTUMALlZWbY3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7635

T24gRnJpLCAyMDI1LTAzLTIxIGF0IDE3OjMzICswODAwLCBwYXVsLXBsLmNoZW4gd3JvdGU6DQo+
IEZyb206IE5hbmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gDQo+IEJMRU5ERVIg
ZXhlY3V0ZXMgdGhlIGFscGhhIGJsZW5kaW5nIGZ1bmN0aW9uIGZvciBvdmVybGFwcGluZw0KPiBs
YXllcnMgZnJvbSBkaWZmZXJlbnQgc291cmNlcywgd2hpY2ggaXMgdGhlIHByaW1hcnkgZnVuY3Rp
b24NCj4gb2YgdGhlIG92ZXJsYXBwaW5nIHN5c3RlbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5h
bmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGF1bC1w
bCBDaGVuIDxwYXVsLXBsLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgIHwgICAxICsNCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuYyAgICAgfCAgIDEgKw0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfYmxlbmRlci5jIHwgMjc2ICsrKysrKysrKysrKysrKysr
KysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfYmxlbmRlci5oIHwgIDE4
ICsrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgIHwgIDEy
ICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jICAgICAgfCAgIDEg
Kw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmggICAgICB8ICAgMSAr
DQo+ICA4IGZpbGVzIGNoYW5nZWQsIDMxMSBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2JsZW5kZXIuYw0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9ibGVuZGVy
LmgNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUNCj4gaW5kZXggZGI5MmY0ZmIzNTNk
Li5hN2I5ZWJlMjdmNjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9N
YWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUNCj4gQEAg
LTMsNiArMyw3IEBADQo+ICBtZWRpYXRlay1kcm0teSA6PSBtdGtfY3J0Yy5vIFwNCj4gIAkJICBt
dGtfZGRwX2NvbXAubyBcDQo+ICAJCSAgbXRrX2Rpc3BfYWFsLm8gXA0KPiArCQkgIG10a19kaXNw
X2JsZW5kZXIubyBcDQo+ICAJCSAgbXRrX2Rpc3BfY2NvcnIubyBcDQo+ICAJCSAgbXRrX2Rpc3Bf
Y29sb3IubyBcDQo+ICAJCSAgbXRrX2Rpc3BfZXhkbWEubyBcDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gaW5kZXggM2UwNzM5ZDhlNmYxLi5lNjVjNmRmOTg3ZjIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gQEAgLTQ0
NSw2ICs0NDUsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IG10a19kZHBfY29tcF9zdGVt
W01US19ERFBfQ09NUF9UWVBFX01BWF0gPSB7DQo+ICAJW01US19EUF9JTlRGXSA9ICJkcC1pbnRm
IiwNCj4gIAlbTVRLX0RQSV0gPSAiZHBpIiwNCj4gIAlbTVRLX0RTSV0gPSAiZHNpIiwNCj4gKwlb
TVRLX09WTF9CTEVOREVSXSA9ICJibGVuZGVyIiwNCj4gIAlbTVRLX09WTF9FWERNQV0gPSAiZXhk
bWEiLA0KPiAgfTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kZHBfY29tcC5oIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5o
DQo+IGluZGV4IDg2ZGMwZWUzOTI0Yy4uMDc1YmE1NjgzZjkzIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmgNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+IEBAIC00Myw2ICs0Myw3IEBAIGVudW0gbXRr
X2RkcF9jb21wX3R5cGUgew0KPiAgCU1US19EUEksDQo+ICAJTVRLX0RQX0lOVEYsDQo+ICAJTVRL
X0RTSSwNCj4gKwlNVEtfT1ZMX0JMRU5ERVIsDQo+ICAJTVRLX09WTF9FWERNQSwNCj4gIAlNVEtf
RERQX0NPTVBfVFlQRV9NQVgsDQo+ICB9Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2JsZW5kZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9ibGVuZGVyLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAw
MDAwMDAwLi4zMmM5ZTNkNDYzYTQNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfYmxlbmRlci5jDQo+IEBAIC0wLDAgKzEsMjc2IEBADQo+
ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ICsvKg0KPiArICog
Q29weXJpZ2h0IChjKSAyMDI1IE1lZGlhVGVrIEluYy4NCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVk
ZSA8ZHJtL2RybV9mb3VyY2MuaD4NCj4gKyNpbmNsdWRlIDxkcm0vZHJtX2JsZW5kLmg+DQo+ICsj
aW5jbHVkZSA8ZHJtL2RybV9mcmFtZWJ1ZmZlci5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2Nsay5o
Pg0KPiArI2luY2x1ZGUgPGxpbnV4L2NvbXBvbmVudC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29m
Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgv
b2ZfYWRkcmVzcy5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVr
L210ay1jbWRxLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5o
Pg0KPiArDQo+ICsjaW5jbHVkZSAibXRrX2NydGMuaCINCj4gKyNpbmNsdWRlICJtdGtfZGRwX2Nv
bXAuaCINCj4gKyNpbmNsdWRlICJtdGtfZGlzcF9kcnYuaCINCj4gKyNpbmNsdWRlICJtdGtfZHJt
X2Rydi5oIg0KPiArI2luY2x1ZGUgIm10a19kaXNwX2JsZW5kZXIuaCINCj4gKyNpbmNsdWRlICJt
dGtfZGlzcF9vdmwuaCINCj4gKw0KPiArI2RlZmluZSBPVkxfQkxEX0FMUEhBCQkJCQkweGZmDQo+
ICsjZGVmaW5lIERJU1BfUkVHX09WTF9CTERfREFUQVBBVEhfQ09OCQkJMHgwMTANCj4gKyNkZWZp
bmUgT1ZMX0JMRF9CR0NMUl9JTl9TRUwJCQkJCUJJVCgwKQ0KPiArI2RlZmluZSBPVkxfQkxEX0JH
Q0xSX09VVF9UT19QUk9DCQkJCUJJVCg0KQ0KPiArI2RlZmluZSBPVkxfQkxEX0JHQ0xSX09VVF9U
T19ORVhUX0xBWUVSCQkJCUJJVCg1KQ0KPiArDQo+ICsjZGVmaW5lIERJU1BfUkVHX09WTF9CTERf
RU4JCQkJMHgwMjANCj4gKyNkZWZpbmUgT1ZMX0JMRF9FTgkJCQkJCUJJVCgwKQ0KPiArI2RlZmlu
ZSBPVkxfQkxEX0ZPUkNFX1JFTEFZX01PREUJCQkJQklUKDQpDQo+ICsjZGVmaW5lIE9WTF9CTERf
UkVMQVlfTU9ERQkJCQkJQklUKDUpDQo+ICsjZGVmaW5lIERJU1BfUkVHX09WTF9CTERfUlNUCQkJ
CTB4MDI0DQo+ICsjZGVmaW5lIE9WTF9CTERfUlNUCQkJCQkJQklUKDApDQo+ICsjZGVmaW5lIERJ
U1BfUkVHX09WTF9CTERfU0hBRE9XX0NUUkwJCQkweDAyOA0KPiArI2RlZmluZSBPVkxfQkxEX0JZ
UEFTU19TSEFET1cJCQkJCUJJVCgyKQ0KPiArI2RlZmluZSBESVNQX1JFR19PVkxfQkxEX0JHQ0xS
X0JBTENLCQkJMHhmZjAwMDAwMA0KPiArI2RlZmluZSBESVNQX1JFR19PVkxfQkxEX1JPSV9TSVpF
CQkJMHgwMzANCj4gKyNkZWZpbmUgRElTUF9SRUdfT1ZMX0JMRF9MX0VOCQkJCTB4MDQwDQo+ICsj
ZGVmaW5lIE9WTF9CTERfTF9FTgkJCQkJCUJJVCgwKQ0KPiArI2RlZmluZSBESVNQX1JFR19PVkxf
QkxEX09GRlNFVAkJCQkweDA0NA0KPiArI2RlZmluZSBESVNQX1JFR19PVkxfQkxEX1NSQ19TSVpF
CQkJMHgwNDgNCj4gKyNkZWZpbmUgRElTUF9SRUdfT1ZMX0JMRF9MMF9DTFJGTVQJCQkweDA1MA0K
PiArI2RlZmluZSBPVkxfQkxEX0NPTl9GTERfQ0xSRk1UCQkJCQlHRU5NQVNLKDMsIDApDQo+ICsj
ZGVmaW5lIE9WTF9CTERfQ09OX0NMUkZNVF9NQU4JCQkJCUJJVCg0KQ0KPiArI2RlZmluZSBPVkxf
QkxEX0NPTl9GTERfQ0xSRk1UX05CCQkJCUdFTk1BU0soOSwgOCkNCj4gKyNkZWZpbmUgT1ZMX0JM
RF9DT05fQ0xSRk1UX05CXzEwX0JJVAkJCQlCSVQoOCkNCj4gKyNkZWZpbmUgT1ZMX0JMRF9DT05f
QllURV9TV0FQCQkJCQlCSVQoMTYpDQo+ICsjZGVmaW5lIE9WTF9CTERfQ09OX1JHQl9TV0FQCQkJ
CQlCSVQoMTcpDQo+ICsjZGVmaW5lIERJU1BfUkVHX09WTF9CTERfQkdDTFJfQ0xSCQkJMHgxMDQN
Cj4gKyNkZWZpbmUgRElTUF9SRUdfT1ZMX0JMRF9MX0NPTjIJCQkJMHgyMDANCj4gKyNkZWZpbmUg
T1ZMX0JMRF9MX0FMUEhBCQkJCQkJR0VOTUFTSyg3LCAwKQ0KPiArI2RlZmluZSBPVkxfQkxEX0xf
QUxQSEFfRU4JCQkJCUJJVCgxMikNCj4gKyNkZWZpbmUgRElTUF9SRUdfT1ZMX0JMRF9MMF9QSVRD
SAkJCTB4MjA4DQoNCkRJU1BfUkVHX09WTF9CTERfTDBfUElUQ0ggaXMgdXNlbGVzcywgc28gZHJv
cCBpdC4NCg0KPiArI2RlZmluZSBPVkxfQkxEX0wwX0NPTlNUCQkJCQlCSVQoMjQpDQo+ICsjZGVm
aW5lIERJU1BfUkVHX09WTF9CTERfTDBfQ0xSCQkJCTB4MjBjDQo+ICsjZGVmaW5lIE9WTF9CTERf
Q09OX0NMUkZNVF9NQU4JCQkJCUJJVCg0KQ0KPiArI2RlZmluZSBPVkxfQkxEX0wwX1NSQ19QSVRD
SAkJCQkJR0VOTUFTSygxNSwgMCkNCj4gKyNkZWZpbmUgRElTUF9SRUdfT1ZMX0JMRF9QSVRDSAkJ
CQkweDJmNA0KPiArDQo+ICtzdHJ1Y3QgbXRrX2Rpc3BfYmxlbmRlciB7DQo+ICsJdm9pZCBfX2lv
bWVtCQkqcmVnczsNCj4gKwlzdHJ1Y3QgY2xrCQkqY2xrOw0KPiArCXN0cnVjdCBjbWRxX2NsaWVu
dF9yZWcJY21kcV9yZWc7DQo+ICt9Ow0KPiArDQo+ICt2b2lkIG10a19kaXNwX2JsZW5kZXJfbGF5
ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG10a19wbGFuZV9zdGF0ZSAqc3Rh
dGUsDQo+ICsJCQkJICAgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkNCj4gK3sNCj4gKwlzdHJ1
Y3QgbXRrX2Rpc3BfYmxlbmRlciAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArCXN0
cnVjdCBtdGtfcGxhbmVfcGVuZGluZ19zdGF0ZSAqcGVuZGluZyA9ICZzdGF0ZS0+cGVuZGluZzsN
Cj4gKwl1bnNpZ25lZCBpbnQgYWxpZ25fd2lkdGggPSBBTElHTl9ET1dOKHBlbmRpbmctPndpZHRo
LCAyKTsNCg0KSWYgd2lkdGggaXMgMTAxLCBjaGFuZ2luZyB3aWR0aCB0byAxMDAgd291bGQgZ2V0
IGNvcnJlY3QgZGlzcGxheSBvdXRwdXQ/DQoNCj4gKwl1bnNpZ25lZCBpbnQgYWxwaGE7DQo+ICsJ
dW5zaWduZWQgaW50IGNscmZtdDsNCj4gKwl1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSA9IG10a19v
dmxfZ2V0X2JsZW5kX21vZGUoc3RhdGUsDQo+ICsJCQkJCQkJIEJJVChEUk1fTU9ERV9CTEVORF9Q
UkVNVUxUSSkgfA0KPiArCQkJCQkJCSBCSVQoRFJNX01PREVfQkxFTkRfQ09WRVJBR0UpIHwNCj4g
KwkJCQkJCQkgQklUKERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUpKTsNCj4gKwl1bnNpZ25lZCBp
bnQgaWdub3JlX3BpeGVsX2FscGhhID0gMDsNCj4gKw0KPiArCWlmICghcGVuZGluZy0+ZW5hYmxl
KSB7DQo+ICsJCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIDAsICZwcml2LT5jbWRxX3JlZywgcHJp
di0+cmVncywgRElTUF9SRUdfT1ZMX0JMRF9MX0VOKTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4g
Kw0KPiArCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIHBlbmRpbmctPnkgPDwgMTYgfCBwZW5kaW5n
LT54LCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+ICsJCSAgICAgIERJU1BfUkVHX09W
TF9CTERfT0ZGU0VUKTsNCj4gKw0KPiArCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIHBlbmRpbmct
PmhlaWdodCA8PCAxNiB8IGFsaWduX3dpZHRoLCAmcHJpdi0+Y21kcV9yZWcsDQo+ICsJCSAgICAg
IHByaXYtPnJlZ3MsIERJU1BfUkVHX09WTF9CTERfU1JDX1NJWkUpOw0KPiArDQo+ICsJY2xyZm10
ID0gbXRrX292bF9mbXRfY29udmVydChwZW5kaW5nLT5mb3JtYXQsIGJsZW5kX21vZGUsIHRydWUs
IGZhbHNlLCAwLA0KPiArCQkJCSAgICAgT1ZMX0JMRF9DT05fQ0xSRk1UX01BTiwgT1ZMX0JMRF9D
T05fQllURV9TV0FQLA0KPiArCQkJCSAgICAgT1ZMX0JMRF9DT05fUkdCX1NXQVApOw0KPiArCWNs
cmZtdCB8PSBtdGtfb3ZsX2lzXzEwYml0X3JnYihwZW5kaW5nLT5mb3JtYXQpID8gT1ZMX0JMRF9D
T05fQ0xSRk1UX05CXzEwX0JJVCA6IDA7DQo+ICsJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0
LCBjbHJmbXQsICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywNCj4gKwkJCSAgIERJU1BfUkVH
X09WTF9CTERfTDBfQ0xSRk1ULCBPVkxfQkxEX0NPTl9DTFJGTVRfTUFOIHwNCj4gKwkJCSAgIE9W
TF9CTERfQ09OX1JHQl9TV0FQIHwgIE9WTF9CTERfQ09OX0JZVEVfU1dBUCB8DQo+ICsJCQkgICBP
VkxfQkxEX0NPTl9GTERfQ0xSRk1UIHwgT1ZMX0JMRF9DT05fRkxEX0NMUkZNVF9OQik7DQo+ICsN
Cj4gKwlhbHBoYSA9IChPVkxfQkxEX0FMUEhBICYgKHN0YXRlLT5iYXNlLmFscGhhID4+IDgpKSB8
DQo+ICsJCU9WTF9CTERfTF9BTFBIQV9FTjsNCj4gKw0KPiArCWlmIChtdGtfb3ZsX2lzX2lnbm9y
ZV9waXhlbF9hbHBoYShzdGF0ZSwgYmxlbmRfbW9kZSkpDQo+ICsJCWlnbm9yZV9waXhlbF9hbHBo
YSA9IE9WTF9CTERfTDBfQ09OU1Q7DQo+ICsNCj4gKwltdGtfZGRwX3dyaXRlX21hc2soY21kcV9w
a3QsIHBlbmRpbmctPnBpdGNoIHwgaWdub3JlX3BpeGVsX2FscGhhLA0KPiArCQkJICAgJnByaXYt
PmNtZHFfcmVnLCBwcml2LT5yZWdzLA0KPiArCQkJICAgRElTUF9SRUdfT1ZMX0JMRF9QSVRDSCwg
T1ZMX0JMRF9MMF9DT05TVCB8IE9WTF9CTERfTDBfU1JDX1BJVENIKTsNCg0KRVhETUEgYWxyZWFk
eSBoYXMgcGl0Y2ggZnVuY3Rpb24sIHdoeSBCTEVOREVSIGFsc28gaGFzIHBpdGNoIGZ1bmN0aW9u
Pw0KV2hhdCBkb2VzIEJMRU5ERVIgcGl0Y2ggZG8/DQoNCj4gKw0KPiArCW10a19kZHBfd3JpdGVf
bWFzayhjbWRxX3BrdCwgYWxwaGEsICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywNCj4gKwkJ
CSAgIERJU1BfUkVHX09WTF9CTERfTF9DT04yLCBPVkxfQkxEX0xfQUxQSEFfRU4gfCBPVkxfQkxE
X0xfQUxQSEEpOw0KPiArDQo+ICsJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgT1ZMX0JMRF9MX0VO
LCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsIERJU1BfUkVHX09WTF9CTERfTF9FTik7DQo+
ICt9DQo+ICsNCj4gK3ZvaWQgbXRrX2Rpc3BfYmxlbmRlcl9jb25maWcoc3RydWN0IGRldmljZSAq
ZGV2LCB1bnNpZ25lZCBpbnQgdywNCj4gKwkJCSAgICAgdW5zaWduZWQgaW50IGgsIHVuc2lnbmVk
IGludCB2cmVmcmVzaCwNCj4gKwkJCSAgICAgdW5zaWduZWQgaW50IGJwYywgYm9vbCBtb3N0X3Rv
cCwNCj4gKwkJCSAgICAgYm9vbCBtb3N0X2JvdHRvbSwgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3Br
dCkNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2Rpc3BfYmxlbmRlciAqcHJpdiA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPiArCXUzMiBkYXRhcGF0aDsNCj4gKw0KPiArCWRldl9kYmcoZGV2LCAiJXMt
dzolZCwgaDolZFxuIiwgX19mdW5jX18sIHcsIGgpOw0KPiArCW10a19kZHBfd3JpdGUoY21kcV9w
a3QsIGggPDwgMTYgfCB3LCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+ICsJCSAgICAg
IERJU1BfUkVHX09WTF9CTERfUk9JX1NJWkUpOw0KPiArCW10a19kZHBfd3JpdGUoY21kcV9wa3Qs
IERJU1BfUkVHX09WTF9CTERfQkdDTFJfQkFMQ0ssICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVn
cywNCj4gKwkJICAgICAgRElTUF9SRUdfT1ZMX0JMRF9CR0NMUl9DTFIpOw0KPiArCW10a19kZHBf
d3JpdGUoY21kcV9wa3QsIERJU1BfUkVHX09WTF9CTERfQkdDTFJfQkFMQ0ssICZwcml2LT5jbWRx
X3JlZywgcHJpdi0+cmVncywNCj4gKwkJICAgICAgRElTUF9SRUdfT1ZMX0JMRF9MMF9DTFIpOw0K
DQpJIHRoaW5rIEkga25vdyB3aGF0IGlzIEJHTENSX0NMUiwgYnV0IHdoYXQgaXMgTDBfQ0xSPw0K
DQo+ICsNCj4gKwlpZiAobW9zdF90b3ApDQo+ICsJCWRhdGFwYXRoID0gT1ZMX0JMRF9CR0NMUl9P
VVRfVE9fUFJPQzsNCj4gKwllbHNlDQo+ICsJCWRhdGFwYXRoID0gT1ZMX0JMRF9CR0NMUl9PVVRf
VE9fTkVYVF9MQVlFUjsNCj4gKwkvKg0KPiArCSAqIFRoZSBwcmltYXJ5IGlucHV0IGlzIGZyb20g
RVhETUEgYW5kIHRoZSBzZWNvbmQgaW5wdXQNCj4gKwkgKiBpcyBvcHRpb25hbGx5IGZyb20gYW5v
dGhlciBibGVuZGVyDQo+ICsJICovDQo+ICsJaWYgKCFtb3N0X2JvdHRvbSkNCj4gKwkJZGF0YXBh
dGggfD0gT1ZMX0JMRF9CR0NMUl9JTl9TRUw7DQo+ICsNCj4gKwltdGtfZGRwX3dyaXRlX21hc2so
Y21kcV9wa3QsIGRhdGFwYXRoLA0KPiArCQkJICAgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5yZWdz
LCBESVNQX1JFR19PVkxfQkxEX0RBVEFQQVRIX0NPTiwNCj4gKwkJCSAgIE9WTF9CTERfQkdDTFJf
T1VUX1RPX1BST0MgfCBPVkxfQkxEX0JHQ0xSX09VVF9UT19ORVhUX0xBWUVSIHwNCj4gKwkJCSAg
IE9WTF9CTERfQkdDTFJfSU5fU0VMKTsNCj4gK30NCj4gKw0KPiArdm9pZCBtdGtfZGlzcF9ibGVu
ZGVyX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkN
Cj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2Rpc3BfYmxlbmRlciAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KPiArCXVuc2lnbmVkIGludCB0bXA7DQo+ICsNCj4gKwl0bXAgPSByZWFkbChwcml2
LT5yZWdzICsgRElTUF9SRUdfT1ZMX0JMRF9TSEFET1dfQ1RSTCk7DQo+ICsJdG1wID0gdG1wIHwg
T1ZMX0JMRF9CWVBBU1NfU0hBRE9XOw0KPiArCXdyaXRlbCh0bXAsIHByaXYtPnJlZ3MgKyBESVNQ
X1JFR19PVkxfQkxEX1NIQURPV19DVFJMKTsNCj4gKwltdGtfZGRwX3dyaXRlX21hc2soY21kcV9w
a3QsIE9WTF9CTERfRU4sICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywNCj4gKwkJCSAgIERJ
U1BfUkVHX09WTF9CTERfRU4sIE9WTF9CTERfRU4pOw0KPiArfQ0KPiArDQo+ICt2b2lkIG10a19k
aXNwX2JsZW5kZXJfc3RvcChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBjbWRxX3BrdCAqY21k
cV9wa3QpDQo+ICt7DQo+ICsJc3RydWN0IG10a19kaXNwX2JsZW5kZXIgKnByaXYgPSBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIDAsICZwcml2
LT5jbWRxX3JlZywgcHJpdi0+cmVncywgRElTUF9SRUdfT1ZMX0JMRF9MX0VOKTsNCj4gKwltdGtf
ZGRwX3dyaXRlX21hc2soY21kcV9wa3QsIDAsICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywN
Cj4gKwkJCSAgIERJU1BfUkVHX09WTF9CTERfRU4sIE9WTF9CTERfRU4pOw0KDQpZb3UgYWxyZWFk
eSBjb250cm9sIE9WTF9CTERfRU4gaW4gbGF5ZXIgY29uZmlnLCBzbyBpdCdzIG5vdCBuZWNlc3Nh
cnkgdG8gY29udHJvbCBoZXJlLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCW10a19kZHBfd3JpdGVf
bWFzayhjbWRxX3BrdCwgT1ZMX0JMRF9SU1QsICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywN
Cj4gKwkJCSAgIERJU1BfUkVHX09WTF9CTERfUlNULCBPVkxfQkxEX1JTVCk7DQo+ICsJbXRrX2Rk
cF93cml0ZV9tYXNrKGNtZHFfcGt0LCAwLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+
ICsJCQkgICBESVNQX1JFR19PVkxfQkxEX1JTVCwgT1ZMX0JMRF9SU1QpOw0KPiArfQ0KPiArDQo+
IA0KDQo=

