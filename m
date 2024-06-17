Return-Path: <linux-kernel+bounces-216884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F2A90A80B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA01F248F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE30C1862A1;
	Mon, 17 Jun 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YdXtfkeX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kf8DPqxc"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91804CB36
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611341; cv=fail; b=R4okWxMS9hWKXfL46LP/qj00LohnYdsOQTmDOPgAD7TgCuaXN0VSV9g/DYv2qFlGMfNzv19GwoMG7GfgoJ3FXybl5S5XzSzwdU3pCloKNZndIJaO4mph/DRMyND8TKtmOhVVVHyAzQtxbAeyu9t1VkHyU9rk/39zI5Z3bXFWDhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611341; c=relaxed/simple;
	bh=/Ly7tZCXseLEhGt2+pZAOjxx51v8c92LcROuTuNYdsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QRVvRtWAnd1gLODk61svj+Pov0xqQf4eKH0FxqKssO0cSbEhekd7nJb/f3CQmRI4WKkvxRKJcamzDlpGzRgSYusT7Au0AbUqqFB6cWvkj4AArPKQkIITHty0cPm2H3vRLPLOEhhBx7hjZpBuq1vK6CAjzSfx34OF0FmgZhksjwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YdXtfkeX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kf8DPqxc; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e82712fa2c7f11efa54bbfbb386b949c-20240617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/Ly7tZCXseLEhGt2+pZAOjxx51v8c92LcROuTuNYdsg=;
	b=YdXtfkeX87FWhmfATOXYET6x0N0yyshp8YqwFSk9ojHc11rK2ryvtvQ+CARQapxHYZxi8U/0nXJPr/3WXsiwP1Cc92Xv5gGhRvz3o++Dh/k+pMvKEWHkuaY9CGnOZayP0RrJWGyaIJGOHEY2I9FzwMr1uLYfB1WIhu68kGR4/Ns=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:96d9f368-320b-4efe-a1f1-7ff776898e32,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:b1efaa44-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e82712fa2c7f11efa54bbfbb386b949c-20240617
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 126088528; Mon, 17 Jun 2024 16:02:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 17 Jun 2024 16:02:12 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 17 Jun 2024 16:02:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfC8CYsDUPzB4ZYvokBmpvxrHafy2vxQDmCL77q6zUnzBSvOmuAK4VtML45RJCjD9RxIDWjE5J5O15qI+1ugvpUCfZ42zHVQOejOOp19ABLkFqbt+jm2p97OzxQfJOFyY8dZwOX3R/pGufnn8hgkqxq9izvY/wg3Iingj64IwRU7kjXUy4dtZFj6uiCpmyoy+PB9T8Woal6FRPW+YXPZN8doCXg1WL921OTtMxeXq87kyGTOTm6ScS5j8RDTAoqWKJGjWcek5MItctJJXOHph/VfIgx6WZ7zwaxKjXZvhOf6zFcS/CWOj1CI+OxEbKEBxQX4FX4cTeQFvvY2vYwYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ly7tZCXseLEhGt2+pZAOjxx51v8c92LcROuTuNYdsg=;
 b=A1BOj7SUYuDdaoF7TDlUcSLOxHE6KvfjtaOkKNS3BTxcw0Zwpb/S/Kg08+4kbu3+TgPnVxyL4Zz529NWR+Ltng0vq3TIVU+5Ta8Iho+CiWJrAbzgsFFy989MmsJgElIBHfZejglc9hCpjLBTcjWGewJ6XHjb7dbc1EyOZ0Vahazluu3pJ/Xx6h06qShPAzQwjNGu6zoajxVWF6q2a5MEXn4F65cFy67zTAmrSiH8JUeOUGNqsLJbq1mOhc+fNKduKgaJGCN9zkLFPm2gRulmZNDdYRssPChGMv98OvEg7q7FT5D0D2Q+ucpXgTpGLOtsYlS3mWKjwkVbtHqEGYyuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ly7tZCXseLEhGt2+pZAOjxx51v8c92LcROuTuNYdsg=;
 b=kf8DPqxcHuYpRVKxX4izRhG0tlCjKm+JUNtMAes1Mbd5vhN/lqUigeYVEoDEoLTutCdEqM6/qH4rB7J2L1RQidWnLcQtoU8FfHCy561+h0MPIFQGLkVvM8mQYaeE0NTGwoasexMDclgFR9w3MPTBe/4LTPqUmSG/qF77IZahNno=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by SEZPR03MB7267.apcprd03.prod.outlook.com (2603:1096:101:73::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Mon, 17 Jun
 2024 08:02:11 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 08:02:11 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"djkurtz@chromium.org" <djkurtz@chromium.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	=?utf-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "littlecvr@chromium.org"
	<littlecvr@chromium.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 09/13] drm/mediatek: Fix XRGB setting error in OVL
Thread-Topic: [PATCH 09/13] drm/mediatek: Fix XRGB setting error in OVL
Thread-Index: AQHav8dTiGYp3jRm5k2rRFaehLgkqLHLmcAA
Date: Mon, 17 Jun 2024 08:02:11 +0000
Message-ID: <d73bc79b3d80fc05db9430d04487ef463044a42a.camel@mediatek.com>
References: <20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com>
	 <20240616-mediatek-drm-next-v1-9-7e8f9cf785d8@mediatek.com>
In-Reply-To: <20240616-mediatek-drm-next-v1-9-7e8f9cf785d8@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|SEZPR03MB7267:EE_
x-ms-office365-filtering-correlation-id: ddf49e5f-6e6a-4361-2b3d-08dc8ea3cac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|7416011|376011|366013|38070700015|921017;
x-microsoft-antispam-message-info: =?utf-8?B?Rlo1U1lmQVdUSkkzT0l1ZXRiU2x5aVN0MGI1VEoxZWtpcDNMMzM1YzhvMnBw?=
 =?utf-8?B?R01STnk0N0tTUHZTNlUvRzdOT0toeC9kZ3QyQ0FCYzUxUkFJTXMycXVGTTBh?=
 =?utf-8?B?R0RzeENHeW9LMWduSTdCSVVJdXFablRRTnovM1VpTG5YVUE2Qm1wUDF6NStK?=
 =?utf-8?B?MFNaN1lnTUtoY043Z1MxcVBuQzFsRDNoNlFIMTlLNEp6VUUydUlBV3pmd3U3?=
 =?utf-8?B?RVR5cVp0SlFmUHlpVDVqSHYzbFZpZXExZG5keW5OWnpEY2JJeG5uSExmSE1k?=
 =?utf-8?B?UFpzZUFXOTBDQlRYTUplZEMyTmRpbjM5UVFPaEJjVTNHUzNRWkN5aGdGdGc2?=
 =?utf-8?B?U3VRU2ZQSkJ6c3JpTlIvUUg5aGhYeTFZVmtRNVVvRFU1bzY1Y1lVRCs0U3c3?=
 =?utf-8?B?QXkyN0U5M09uUnZubGttL2xLR1lraXlqVnhESFFpSWZ1L0NGN2wycFJvQitl?=
 =?utf-8?B?TWcvSmxueXY0Q0hkMnVtcVFCNVhMYXBXTXZZUzR0Vjkvc0xBUUc4QVNNSnMw?=
 =?utf-8?B?bTl5NXRhVlhjWXlsdit4U2tJK3IzYVkwVzMraEpxNitKTTI2NGxtWDZNc1R1?=
 =?utf-8?B?TmFmK1RPSnZnVk14a1RZd2tDQ2JqbzZvd2dKbzFnTzdNb1Rzc0t4SlJrRCtC?=
 =?utf-8?B?ZWRBQTB0Z1hLSjFsSytSYnpaaHQ3LzJSMWhhaEtabHZCdFVlVVdSbW1FMEx5?=
 =?utf-8?B?eEdrWlpUM3JSLzZKVFFOeEdkamNMUnRNRXRyU3FoZzJqbFYxVmR3bjRRRFUw?=
 =?utf-8?B?WnA2Qmt0aUEwbUQveXhjTE5aenZwU3V5dTRsOUVKUmhtYVN6cUhvdWRvbk9j?=
 =?utf-8?B?Yk9IdElvemRGYkZZTkFYZ09qS01FR0NQWjRkRHJrUGI3MDE3djdmb1lrK2J2?=
 =?utf-8?B?amxOc1hCOTY1U3V1MUhGZFoyNk0rMDgwL3IvWE03emw2RXp2WGpsdmVONXAx?=
 =?utf-8?B?ditGL1dnSkhiNEsweWdyMEdYTlYxeTFwbW9NL1lxZS9saW9yMGppTi9NNGRu?=
 =?utf-8?B?ajdPUmZIanlDU0xEOUtWbGFRR1pyRUR1bFVMSVpsWTBmeFZod0N5dlB1SmJC?=
 =?utf-8?B?VnR0TVU3bnpKdGFFQStMRmFSbkRMZmVWdFZnTXhRZlZBblVLV05oSUs0Q1V6?=
 =?utf-8?B?dlV0Y2lYcWtLV21qdkJGTlBuL3J4S0lmZ0VWSGU2cHhtRlAyOUFnQmgzMGpy?=
 =?utf-8?B?c1ByODdaRTRhRnZacjhmTjRIaS9wT2dIWmZacDJ1S0VGMGxOajk0WG9kVDla?=
 =?utf-8?B?T0NwdkxLK2ZtZzNmTXJCdDRUMEkxSWpNVmVQa3Jvck9JbHI3YWU0R2dzTGky?=
 =?utf-8?B?TXFpb2h0ZFlXcmdNREl5RW5wNUhvWDVPOXVHZEZJbkVNREZuRko0cW15N2cy?=
 =?utf-8?B?TGEydkdHTG5QTzhSV0FkWHM0MiswUWFYbkpBczdLY0dickgzQWtIVGt1WlMz?=
 =?utf-8?B?QVdicXV0NDBHWlIrWklMZGxxc1JDemtoUTBpS2Eza05BKzdKT1hHc2NSZ1cx?=
 =?utf-8?B?aWxXeFFVcCtJLzM0TXBlMzVFaEdoUHc5V00xeFZBSURrNU1rYzdXVHpCQkhw?=
 =?utf-8?B?YlhZM2lramVDTU5RVEloNGpaVTRyNnQvcDM5V3lCM0lTVGk2K1lCOHZMSUpw?=
 =?utf-8?B?YnJ6eHJGTUg2clRNNWNpK0xiczNWbW9RVTBMREZVRGJIY3VUN1VGeEJNQzcw?=
 =?utf-8?B?aFZXVWZ0eW8yU3hqQ3dWTng3eGlJOUZuNEdIa1pBVlRBY1F4OEwvQzlwaThI?=
 =?utf-8?B?NkVCbjlOUGRXSlRBcXVocWFXcFVSUXI2cytCdEVzZ2ZybVNwcW1idXU4Z29Z?=
 =?utf-8?B?dHpBcFEzUVE2aVZTQVhYT0Vid0VaNzU5WjNheWR5QjdncllkOVgvaHV3K1VU?=
 =?utf-8?Q?vMF7yfCnpCWgW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDkrSmRWSENtK2h5U1hjVnJTSFVnN0Mrc1kyR3Vmdkp3UDJmRjlLcGozZFNl?=
 =?utf-8?B?ajkzR1FwQUJIbElaZm9vWTFqb0owengrMmMza2FpcDRUZkFlcXhDMWdwR3dp?=
 =?utf-8?B?TVVYYXpIekZ4Z2MxMisyeHF6TGZSM1lkOEkvUGNxR3Ezei9zU0N2SkFPWlFt?=
 =?utf-8?B?UHZ2c2lDRzRnREVGR2gyenZuTDN5S2lhT0trTk9uTFRzTXBrZ1pSeFFNZXM4?=
 =?utf-8?B?ZGtqa1FWTzZsSjlWTXlZWENHQ1VMQ29SeTlkS2pGVW4zS3V2cnF4bEVjcWJP?=
 =?utf-8?B?NUFkYnBBTGJ6YnJkZTIvTVI4eUNXaGZKS0Y5SERabUdmb3V4NTEzdk9tNmJy?=
 =?utf-8?B?ZXYwMVY3dWt5QlZzTkVKOXpwdC9PSjdzbWVnZ2phWnV6cHFCZm5GRlVBRjh2?=
 =?utf-8?B?dzZFZEZHc0tvOWlJdHhqY0xqQ2p1d2J0ZkY4c2J2RnpvS3dKN0RXWWJJdkc4?=
 =?utf-8?B?RDRlbTg3Q0txTUZOVE1NYWlEdlBUSFc5SWMzVDNydHBSZnR0Y3lsbmx4TTRX?=
 =?utf-8?B?LzAxSmg0bEc0N1MvbEJubHVrM21yUHJQQll2b0crcXRIaEw4YjhvTDFhaTFu?=
 =?utf-8?B?K3BNYUF5b0U4SG0yNS8yU3dWWDEyaWErL3lhRFVFMDl3YVFBUWY5Y2daMlV1?=
 =?utf-8?B?N29KZnVzRmhuMmZ5dUpCQlE4S2pSd29IVU5PZ1Nxb29iaisvUUhOQ2Y2aXFz?=
 =?utf-8?B?Vm05UDc3NmNESlZMUnA2L2k0SzVuVSs3NUdQdHBVaVo2VndwYkJYaVNISkZx?=
 =?utf-8?B?ZkNDd1c1dTIxUVJtYjFVc3puaVI3NEJ0QUJMZi9iUkpvNE5CY0JvWnErUHc5?=
 =?utf-8?B?NVR1MnJXTWR3NmJaY2J0Q01TSnJyZ2JJakt0OHJyRGNubVIvejRacWYvVzZL?=
 =?utf-8?B?VXcreDVNOHNTUW90dmJieVRwYlV0UnNRd2t5ZE1sclNLMXNZd3dsRk5wTzUx?=
 =?utf-8?B?MVBXQ1FMbWZtWVNHYmtleGRFWCtPMzgyN0cwZUorMEVML2gvWjFjcVA0VkJN?=
 =?utf-8?B?ZVc1RHJJL0VDcmk5d2hnTjFUTlZmL05FZXVhOHZxZGFKbm5GOGNKNm9hS0g2?=
 =?utf-8?B?ZEdzRGZiUHdlN3dqMTNnb0FhVkU3cVREL2NIUDA0Y3pxZ1Q3YmVDcksxM3p2?=
 =?utf-8?B?VzRmQ3JLVTBhS1QyeStwc2NUNThoVHE5OHd4dXI0d0pTdStDVjJ6SWg5N1gy?=
 =?utf-8?B?dEp1SWVCOWZpUG1YaXRPV2cxd3YyRlFjQlYwd1VoRXR3TEwwMXdGOWFDWG4v?=
 =?utf-8?B?K0IyNXJERWxYOXVvUmdtZVRhZENxbkhDOXhJTG1vSnhRR05Lblc0SUJFRUhZ?=
 =?utf-8?B?M2Q5N1l4MU1wYVhhRVhKdUQ4anhpYy9xYkVNWEllRm0wQklGZnVXQlp1Yity?=
 =?utf-8?B?ZEc4TUp5Znl2OUJ1VlFhVEFVNW0vQ3FqUnRrbUt4OERsTG15cjU3UkdaR1Av?=
 =?utf-8?B?UkNnR1dTTmJ4TWgzVW5sUXQ4RnVwL0MwYlhRTmJ2c0E4VmxNVm44RlBBTWNR?=
 =?utf-8?B?ZVIzSW1CN0lDQ1l2eENIWGR6bFoxdGdZVXhVUDJCR1dpU2JHSGp1NlJldExT?=
 =?utf-8?B?MTlHUmN6bWk2VUI5UWFEQ1ZUZDFvbTlWeGIrL016a1Z3ZDZLYTF5NmhYaU5K?=
 =?utf-8?B?YjI3am90T05zTHh5a0M2Q3A4ei8rSmYvM3NmcGZMUDF3TFVpcDhJb2hmQVBY?=
 =?utf-8?B?VXRxNGpNNHNWV0xiWk9LR2pGbUxCSG5QREc4MnMzcmRsMXZoRlczMFNXeXR1?=
 =?utf-8?B?Yzh6aUYvTk1kdFhCcVFiMVFqcGVmcWFMN0Q3TDdMK1RGNXo1ZzRHc0dLZFJw?=
 =?utf-8?B?WEJUWitDak53V1hDS040Z2dvVjdMRDR4VmNveWtOQ09xNWEzTkZhT1RadklR?=
 =?utf-8?B?VzlFSXZmdG40MnBOdkZFTy9IMmh6U2hPSHBlek04MFB0eWl0ajBMNTVrNVF3?=
 =?utf-8?B?U2dMaE1PdW1YVHM2UGQydXc4ZlpuS2s4dGJYS1JwNzR4LzFDdlRDNElJUDhB?=
 =?utf-8?B?bHI2czA2eUFNTnJaZXJuM2c0UFdOTUttYzBpdURjdUFxb0lEakdTUE9FeTVV?=
 =?utf-8?B?am92cGMrYnVYVzEybzFPVUtkTEtGSFdFR04wbVdINDVmalczc3I0d1crSHpQ?=
 =?utf-8?Q?6xxky6Ih9RkHggiweMb9iHwPA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F144C3B613AAD4B8BCF496E5CABE2C7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf49e5f-6e6a-4361-2b3d-08dc8ea3cac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 08:02:11.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lx4NT3q6kkVO10pPOYDIt5KqA7l7L7pUz0/eWNW47l1K6zhYHtMwpd1maxUYFpec3XaAZPTCSLrgzZ2XvI4Anw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7267

SGksIFNoYXduOg0KDQpPbiBTdW4sIDIwMjQtMDYtMTYgYXQgMTY6MjkgKzA4MDAsIEhzaWFvIENo
aWVuIFN1bmcgdmlhIEI0IFJlbGF5IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQ
bGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhh
dmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEZyb206IEhzaWFvIENo
aWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiANCj4gQ09OU1RfQkxEIG11c3Qg
YmUgZW5hYmxlZCBmb3IgWFJHQiBmb3JtYXRzIGFsdGhvdWdoIHRoZSBhbHBoYSBjaGFubmVsDQo+
IGNhbiBiZSBpZ25vcmVkLCBvciBPVkwgd2lsbCBzdGlsbCByZWFkIHRoZSB2YWx1ZSBmcm9tIG1l
bW9yeS4NCj4gVGhpcyBlcnJvciBvbmx5IGFmZmVjdHMgQ1JDIGdlbmVyYXRpb24uDQoNClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBGaXhlczogMTE5ZjUx
NzM2MjhhICgiZHJtL21lZGlhdGVrOiBBZGQgRFJNIERyaXZlciBmb3IgTWVkaWF0ZWsgU29DIE1U
ODE3My4iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1l
ZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
b3ZsLmMgfCAxNCArKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX292bC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jDQo+IGluZGV4IDczODI0NGE2MTY0ZS4uNjE1Yjc1OTE5ZDFiIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IEBAIC0zOCw2ICszOCw3IEBA
DQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9QSVRDSF9NU0IobikoMHgwMDQwICsgMHgyMCAqIChu
KSkNCj4gICNkZWZpbmUgT1ZMX1BJVENIX01TQl8yTkRfU1VCQlVGQklUKDE2KQ0KPiAgI2RlZmlu
ZSBESVNQX1JFR19PVkxfUElUQ0gobikoMHgwMDQ0ICsgMHgyMCAqIChuKSkNCj4gKyNkZWZpbmUg
T1ZMX0NPTlNUX0JMRU5EQklUKDI4KQ0KPiAgI2RlZmluZSBESVNQX1JFR19PVkxfUkRNQV9DVFJM
KG4pKDB4MDBjMCArIDB4MjAgKiAobikpDQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9SRE1BX0dN
QyhuKSgweDAwYzggKyAweDIwICogKG4pKQ0KPiAgI2RlZmluZSBESVNQX1JFR19PVkxfQUREUl9N
VDI3MDEweDAwNDANCj4gQEAgLTQyOCw2ICs0MjksNyBAQCB2b2lkIG10a19vdmxfbGF5ZXJfY29u
ZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gIHVuc2lnbmVkIGlu
dCBmbXQgPSBwZW5kaW5nLT5mb3JtYXQ7DQo+ICB1bnNpZ25lZCBpbnQgb2Zmc2V0ID0gKHBlbmRp
bmctPnkgPDwgMTYpIHwgcGVuZGluZy0+eDsNCj4gIHVuc2lnbmVkIGludCBzcmNfc2l6ZSA9IChw
ZW5kaW5nLT5oZWlnaHQgPDwgMTYpIHwgcGVuZGluZy0+d2lkdGg7DQo+ICt1bnNpZ25lZCBpbnQg
aWdub3JlX3BpeGVsX2FscGhhID0gMDsNCj4gIHVuc2lnbmVkIGludCBjb247DQo+ICBib29sIGlz
X2FmYmMgPSBwZW5kaW5nLT5tb2RpZmllciAhPSBEUk1fRk9STUFUX01PRF9MSU5FQVI7DQo+ICB1
bmlvbiBvdmVybGF5X3BpdGNoIHsNCj4gQEAgLTQ0OSw2ICs0NTEsMTQgQEAgdm9pZCBtdGtfb3Zs
X2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+ICBp
ZiAoc3RhdGUtPmJhc2UuZmIgJiYgc3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKQ0K
PiAgY29uIHw9IE9WTF9DT05fQUVOIHwgT1ZMX0NPTl9BTFBIQTsNCj4gIA0KPiArLyogQ09OU1Rf
QkxEIG11c3QgYmUgZW5hYmxlZCBmb3IgWFJHQiBmb3JtYXRzIGFsdGhvdWdoIHRoZSBhbHBoYSBj
aGFubmVsDQo+ICsgKiBjYW4gYmUgaWdub3JlZCwgb3IgT1ZMIHdpbGwgc3RpbGwgcmVhZCB0aGUg
dmFsdWUgZnJvbSBtZW1vcnkuDQo+ICsgKiBGb3IgUkdCODg4IHJlbGF0ZWQgZm9ybWF0cywgd2hl
dGhlciBDT05TVF9CTEQgaXMgZW5hYmxlZCBvciBub3Qgd29uJ3QNCj4gKyAqIGFmZmVjdCB0aGUg
cmVzdWx0LiBUaGVyZWZvcmUgd2UgdXNlICFoYXNfYWxwaGEgYXMgdGhlIGNvbmRpdGlvbi4NCj4g
KyAqLw0KPiAraWYgKHN0YXRlLT5iYXNlLmZiICYmICFzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5o
YXNfYWxwaGEpDQo+ICtpZ25vcmVfcGl4ZWxfYWxwaGEgPSBPVkxfQ09OU1RfQkxFTkQ7DQo+ICsN
Cj4gIGlmIChwZW5kaW5nLT5yb3RhdGlvbiAmIERSTV9NT0RFX1JFRkxFQ1RfWSkgew0KPiAgY29u
IHw9IE9WTF9DT05fVklSVF9GTElQOw0KPiAgYWRkciArPSAocGVuZGluZy0+aGVpZ2h0IC0gMSkg
KiBwZW5kaW5nLT5waXRjaDsNCj4gQEAgLTQ2NCw4ICs0NzQsOCBAQCB2b2lkIG10a19vdmxfbGF5
ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gIA0KPiAg
bXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCBjb24sICZvdmwtPmNtZHFfcmVnLCBvdmwt
PnJlZ3MsDQo+ICAgICAgICBESVNQX1JFR19PVkxfQ09OKGlkeCkpOw0KPiAtbXRrX2RkcF93cml0
ZV9yZWxheGVkKGNtZHFfcGt0LCBvdmVybGF5X3BpdGNoLnNwbGl0X3BpdGNoLmxzYiwgJm92bC0+
Y21kcV9yZWcsIG92bC0+cmVncywNCj4gLSAgICAgIERJU1BfUkVHX09WTF9QSVRDSChpZHgpKTsN
Cj4gK210a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgb3ZlcmxheV9waXRjaC5zcGxpdF9w
aXRjaC5sc2IgfCBpZ25vcmVfcGl4ZWxfYWxwaGEsDQo+ICsgICAgICAmb3ZsLT5jbWRxX3JlZywg
b3ZsLT5yZWdzLCBESVNQX1JFR19PVkxfUElUQ0goaWR4KSk7DQo+ICBtdGtfZGRwX3dyaXRlX3Jl
bGF4ZWQoY21kcV9wa3QsIHNyY19zaXplLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiAg
ICAgICAgRElTUF9SRUdfT1ZMX1NSQ19TSVpFKGlkeCkpOw0KPiAgbXRrX2RkcF93cml0ZV9yZWxh
eGVkKGNtZHFfcGt0LCBvZmZzZXQsICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3MsDQo+IA0KPiAt
LSANCj4gR2l0LTE0NikNCj4gDQo+IA0K

