Return-Path: <linux-kernel+bounces-346466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F083798C501
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A174B2833BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEB61CC15B;
	Tue,  1 Oct 2024 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RhJsFoGS";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Io1pbhKy"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992C1BBBC6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805748; cv=fail; b=XfexPlHADn4p7qkgujeKESpdhT4Tdby1O+fOTHAlq6s9Bd4oC8DTihkebAQOM8zBX5xtg4nRTsZZfjQ25HLuOtuSOaohAmMKTw5ws4hKXEpYrKpP9aURkcAX6aatr7XdOgshmT3sJmedeeYlDlt4cGUwDd4CQ4R3M9UnXAMbYX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805748; c=relaxed/simple;
	bh=8bqyuUwhgp/Xwv4b3Spli4aNPS7P7B1pUl7xIog9bXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aVtVhxQ66bHNLI3zI49xdTDws+w8HftnE1ZJ+dH+kcvqYNGXOOz2yfyGzwCIkA7/GocaZ9w/j2WvMf9q+Zp8yDF6546lLfGeii0R1cMIUkUXzxzT54z5BtEvRdssdaWwlZRzGSpzM/MCjZTpn+dKWCD+Zmnl8jdCBkzuLff2ngs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RhJsFoGS; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Io1pbhKy; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4a34c44a801f11ef8b96093e013ec31c-20241002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8bqyuUwhgp/Xwv4b3Spli4aNPS7P7B1pUl7xIog9bXI=;
	b=RhJsFoGSKPY4GVy0KId/SvwXAJoLwiiwC4nma4zxphfXW8S/GqWzfDFk2MEBxsUMMr5EuIsPwulDW9UQOvRA4uNhNwRd4VWzjea/KjOvXSXdhI1wYhI+LhrUmDDoypRFGPuFV/caMRZ+U+sbZE3vwnWh/bGF7VN7Tc8BxPNEZQI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:be9e8193-4663-4007-9eb1-19ccb3b8684e,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:-32768,RULE:Release_Ham,AC
	TION:release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:824290bd-085c-4112-81e0-4d6de274b71a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4a34c44a801f11ef8b96093e013ec31c-20241002
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 639453958; Wed, 02 Oct 2024 02:02:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Oct 2024 02:02:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Oct 2024 02:02:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGvP8buE7EFII6tH9jc5w0yxl39kMLYBZJULlUa9EefLSHD0Wq+h613jbHvWwpGwyriyHKatuEiEJH/UPc1Hip+Lop1HSTAe7ofIf4x09CESE8ZWjEMawRzVbvtt1w0qrAv3NddTaLSK8vghF+ZYPKcMbfBEADRq+v7fJwQzvCUGjQvwVoqV2AfRyj4OytsbVOZU+Ee/kz+fHycJECoRrVYs6Y8pliEZKbgbFR1i4ZclsMj4ztVvRJRt5DILtBDj5rJpN9nscdi85ObeO2H7LcuH3GMSGP8gY6Bj0Sb0WuI8wgElYJ2n+jJkLBU1od7iBmPjfNsLRn//TyWLL6w1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bqyuUwhgp/Xwv4b3Spli4aNPS7P7B1pUl7xIog9bXI=;
 b=APbPla4cQcKbELxxd/2ozidVY8UTVP5sc3rQ9U/DClpCCDrO4isl6uC3V1UhuqxGpJvNzY4rT478tLsNAyGV7Wo90GUslyZPIFFWMPuXL2hZTsYVA0CWEptH82IR/mj5U20DmAwK6CCBABKppgFvg1vcKnQzLh6jFfwc2kTFMVdKIRxJln/owkyonU8gUt6r9vjC1yyTfsPoj3JyfNyk/Lz82GLv4LgSonVpuDN2/g6qN/E4sg0YQ22DyYD2xXz8MatUrnWjKKxX4L3b84TaYAXFVs8wmc6UDljP0bHlPcAzQfxt2jqwMBKGg9FCqdBCtCb/v6McKQ9Vl0/0j6ua3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bqyuUwhgp/Xwv4b3Spli4aNPS7P7B1pUl7xIog9bXI=;
 b=Io1pbhKywbLkDgzZUQO0cYfZpqt8tVPX44/rh0N+S8KlSPO78aMsW7saV/O3CQo5Oqbu2yp6+XKBUBzTwFFCfBgkZ9l935OAUZSSnC1zwYA05HXzvMS4CUrsTVwrp4++GZEgrNHpek/ua4q0HhXryOicqBclzWLHfs0OvxPVLAU=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB7275.apcprd03.prod.outlook.com (2603:1096:400:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 18:02:11 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7939.022; Tue, 1 Oct 2024
 18:02:10 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"djkurtz@chromium.org" <djkurtz@chromium.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?=
	<ck.hu@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"me@adamthiede.com" <me@adamthiede.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "littlecvr@chromium.org" <littlecvr@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/14] drm/mediatek: Support DRM plane alpha in OVL
Thread-Topic: [PATCH v3 13/14] drm/mediatek: Support DRM plane alpha in OVL
Thread-Index: AQHbE2FMBZwycJSOpEepDGqWsN2C6LJxmIIAgACYzIA=
Date: Tue, 1 Oct 2024 18:02:10 +0000
Message-ID: <00ebe9ca262b6a95fd726e5be06334b1e923db02.camel@mediatek.com>
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
	 <20240620-igt-v3-13-a9d62d2e2c7e@mediatek.com>
	 <1a3af354-bd15-4219-960e-089b6a6e673c@adamthiede.com>
	 <49df03e8b982cc5ee97e09ef9545c1d138c32178.camel@mediatek.com>
In-Reply-To: <49df03e8b982cc5ee97e09ef9545c1d138c32178.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB7275:EE_
x-ms-office365-filtering-correlation-id: 9c894c0f-2bb9-4e2f-7893-08dce2432bd4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OHFVaHV2Zzc4VkdpMU1VOEhtakQ2OVY0cm10OWx6R1gwSDlNNW9ydlI1R3Bq?=
 =?utf-8?B?Q0tuaFZlamtkL2k1d1IySXVKeGIwZFhndENwVnhMU1MxNklSQjB0bDhacVBn?=
 =?utf-8?B?R2NBSWtWT1R4MGwyNTk3dW5VdzVGcURQdEYzL1pwN2pubDcvRWRNUElQVy9X?=
 =?utf-8?B?RllaVDdNS3dmTkZ2T3VubmQ5V1UzV2VnRjA2TlR0NGtsaU1KU2p2ajVTakVS?=
 =?utf-8?B?Tkdnb1g5WjdWVUpIUVVmZmlIT0MxM1NQbU16dW5XOEVDMjV0UHBJbFUyY3J2?=
 =?utf-8?B?WWlta1ZPNktxZUxzVFQ4YldMUFcvN3JkOWMxOVRzaGtRSDdWUVdtUVBReWZN?=
 =?utf-8?B?OElsRmtHakdhVnFndXNzVUNFTTRHUklUT3RSMWhCT1RNenZzUmh4L0tsVkJR?=
 =?utf-8?B?bUh1OW1ScmYwamhqLzcwOElwT1BkSVV0Vjl4MGE3M09NS1JvVXJWdzBkRjUw?=
 =?utf-8?B?cTNlMnFmRCtKbzlNVjFMVUJONlJwdDhBTmpvSjQzNGkyRTlQTWd0V0NHY294?=
 =?utf-8?B?Ky90NDVlOG9keWw1emFlbmNyUlp0aDNrdGhKeTZJRUtTVDNaV2tnazVrdDdL?=
 =?utf-8?B?NEtxUEhxZ00vVXV4YlRMRUtBKzB6S0lxU1h0MlRJUUNad21aNldYZHd6Q0pp?=
 =?utf-8?B?V3JuVG9OUUhVUCtoRmFmRXhVVzZReVV0NDdxN3ZkcG9xeUFmZEgvRWhpbFRq?=
 =?utf-8?B?MnlOYWFFUEM0aDZJY25rd3VVL29KdktlUGkxdHVVT05LWVJmZ2s3cEQ3KzF2?=
 =?utf-8?B?MHA4RWtsMkpxV0JxUHVjdmdDdWh3b1VXckpOUys2L2xaeVlPcmVTb0kzRmR0?=
 =?utf-8?B?VkpwcGErVmcvb0FaOWFZYm1IeHVDalNxSFV5WGo1RElRU0pwR3dzMzlnMkZy?=
 =?utf-8?B?UmdjdDd3N2RTUGg0UTRVRHF4aVhBVXpRYnNIUlA3TVR2Si84a1RpZGwxMTQr?=
 =?utf-8?B?Z3R2blNUZHY0bWRlTGtrZU9XaHJqL2w0YzhXR2ZhUGFwOVVXZjNvZUVhbWlH?=
 =?utf-8?B?NWlES1d2ZVN4b3p0SXhjdmNYVGhOb3NacndKeTdMM2ZrQ0VkZVJsdlZZMzZZ?=
 =?utf-8?B?VmZhK0lRMWdGZWg2TzNmZ0FtSXdtaGRYK2pBWWlTMGl1dFJDWjN2THlrYjNL?=
 =?utf-8?B?c1pZbVd5Y2lNZDNNUHJ0dmlzOENKK0hYdVAzQm0yYmtPaVNIN2pwVy83NkUr?=
 =?utf-8?B?KzZxMnVobnBZTytGRFBGM0hqYUwvNDd1ZitaeUVaNjJqalIyUk54OGtJNXdh?=
 =?utf-8?B?alhCN0pkNjJlSnJJMktmaFhJREhpVXZHME1OcjlHZ2pMWFJyaFpHTUxtVUsw?=
 =?utf-8?B?aEpmWG9qWDIreFZpWVRqT28yeUZGVS9RV0RySy9hSlptcGFxWHl5RitXNU1x?=
 =?utf-8?B?OUk4VDNZdkZLSFFYZUswZlNXWTVSR0hHQXY1N24rbEF3ZEFjZjd5TmFpbWcz?=
 =?utf-8?B?QjdZak9BSFpadzlDVVVhSlZVcDJSQ1hQV3c2OFdDbjNoTXZIUGpKcU1wVVhk?=
 =?utf-8?B?MkJjRGViQjRsS0J4SXJHckprUWVXNTdiSUh3T2F4S0RTeEdkYzM3U0FRWEZq?=
 =?utf-8?B?SWNtQmIzY3Y4dTBJUDFwQXZoSlZ6OXpNVHpDQ1YyWVBJYng4M29ycjJRaTFL?=
 =?utf-8?B?SlZzaFRYRzc0VDNZdC8wUDI0aHRWOUZGYWpJQ2N3WDFmMnhXVzRxaVRyMXJI?=
 =?utf-8?B?cnFRSXZCNWM1L0RIUFZkdEpUTHdBdFF3aHh5SFVaYWUrWllaYU03K0J2a3lP?=
 =?utf-8?B?TEV3RjRnU2ZCT2hrME9wWTk4d3prRDNDbWt6V1l3WlVBL3JjM0hIbGh0eGRk?=
 =?utf-8?Q?MMzrrfK+sIfQWWrEc3yf0Q0Z2Iasg1uhzwEnQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDJpN0R1Qm1HMVUxSngwUEhhVXdldFZOZWpuZ29aL09mSEswelpsSjFHN29C?=
 =?utf-8?B?NkE5dm9aZHhoRHErVThoVFF0cDNvREVmVzNyWnd4VWRMTGJSdmpHbGtMV29X?=
 =?utf-8?B?V2dvNzRiTTlDbTZnL05CUEtXU2lhYlVNTHByNFY2YlZSbXJRelRyaGI0M0RM?=
 =?utf-8?B?K1Y0WGs3TjVITHdjSTFhdmo2YXE5TUYxZTBUUUNyVVFZSHRaekcrMDBsVThL?=
 =?utf-8?B?VmFlNElOT1V4bHZVMFpGcG5NOEdmUGdiSHF5c09tY3ZEQ3dEUzRRSTZKZjVa?=
 =?utf-8?B?UXZHOGFzTU44emdMSko3MTByK0phTEdoR2RxaVBmUTF6OWJ3aGJLdkxzMTFv?=
 =?utf-8?B?dWRSN3VUN1g3WHFrRUVId1FFcSswQ1c4UEI5K0dMWE00dEV4T3RVMnI3OC9Y?=
 =?utf-8?B?SDVzVXpxZ1hFV1BnalM3am5ENGZrQ3BLWnZFb3ZoQTNKU0tPZmhmZGRVT3BY?=
 =?utf-8?B?RDFuci9Kb1o3SE1pVmNNSlZ5aFVJZW1CZUtnTFQwNHNPOFg1T1BvKzRtdDZH?=
 =?utf-8?B?Tyt1RUdEMlFvYjlBdmkwMjhmL1MwaUhxYzd0Rk9OcDYvUlNiQnRwMzhGWnh6?=
 =?utf-8?B?QlhkS1oxQkNiRnp5a0hqV1lxalJEeHBWcXVEU0JQblZGT3NFUDF5Z1FIdHFx?=
 =?utf-8?B?eGpsQ2xsbUV1SW1vY2VoK2x4cUs3TXdOcHN0d2ppcnl4UGJmM0dMSkkwdmpR?=
 =?utf-8?B?SmNubFMvTFRjSWlVK0RNVEVldnVMYVVlTGMzb1U3ckM4NUN1QXIyZkE1SVd2?=
 =?utf-8?B?bFlnNlAwYnpWV05ydnU4Z2k5a3p2bG54bHRSTVd1bStYZ2o2QnBacUxQNjhL?=
 =?utf-8?B?QUhoVFRNVU1uYWdnRTl2Mit6SVZEb1IvMGJZUStHWEZ3SU1TREFOWldkUDZ6?=
 =?utf-8?B?djdYaDVIWFRCUDd5VkRKaDBEVVBlUnZMWnljSVhLcHlBdzF3QnQ1d1lBYUtG?=
 =?utf-8?B?NDZ0UHRWVVk1dVZFSVhybUR2MUNNUDd5YU0ra1lPVC95Tm92Q1FBdzZFb1ps?=
 =?utf-8?B?QW85Uk83S21LSnU1QTc0YnM2bk5BeWc1cjFZV2pZMU9ZQW1qeERWV0JUZTZ3?=
 =?utf-8?B?ZnFiN2dBald6WnVsYSs0RERETFUzdGtCd0hWa0VGTmhMOE9GZGpyWGxkUjhl?=
 =?utf-8?B?WHZCWFdCUFBzekc5QStVZE5pNE16TTU2L1hLMW14SCtJUVhVd2xuZHRkQWl5?=
 =?utf-8?B?UTVxTUprdmxYdEY5WjhURStidi9reEtXTjJCZXhISVJIZjJMamRFaEhWTUpY?=
 =?utf-8?B?TlNxT3BBZGtPMkNOOVhHRTFmaVBkRGVlR2JxeVY5bU9qSXdwR1pnS2V6bTNB?=
 =?utf-8?B?VlkxVkRkbC95OTFGdk9TUHdjRkx6OE5CL2lDYXNkS1p5Mkp5WUNHVlNXeHdQ?=
 =?utf-8?B?dmhlUmhxNlR2MDlEdDZsaGNqazA2NVBIMmxVZDBNMVY0NmZpOURoTWpmYlJj?=
 =?utf-8?B?WDVLY3BJMkRvS2lLY0FOaUFGRUhLQ0RHaUVWMDJWZE1JZStkOVhMSnRhMFd4?=
 =?utf-8?B?Y0IxMkQxWG04Sjc2ejE1S25xZkN0TC9xUTdCb2F0dEg4Q3o2N0NzeGJXSDhx?=
 =?utf-8?B?cTRhVUhrYjNoaElGWWx4MGhCV3RwMDNiUllCdFhyU3BoZlVEUVZOYTlWTTdN?=
 =?utf-8?B?QnpYNkxKTXVkTVl2b1pXcmh5OWVUZmQ2VFg1R0NyNXZQTS9yVDZBbSthWHpZ?=
 =?utf-8?B?SkZGZy9iYjFkdmRJaGFKWEU0YUdJZjNpSWw0Nlg5TElNeWhkdDRvNFREM3gr?=
 =?utf-8?B?QmZGczQ3R1RoWVBnMUFtVk1Pbjk2VzRhTXcxbFpEYVlrUDBiSXJqU2k4VnF4?=
 =?utf-8?B?UGVFc3NmOTUzU3NadHQ0VVZXbkM2V2thOHJOTGJCN25yUGZ6SDF4K2gyVW1H?=
 =?utf-8?B?TFJxRXJtR09BNTYxVE94OEdoWnFDZEFld1pCNU1PQUZHdGt1NG4xY1IwRU1E?=
 =?utf-8?B?U1kxc0lrNEUrc1JkbS91cUwweVh2LzQ1eDVxSGV5ZlZpU2NLVjVlVU1BQlZY?=
 =?utf-8?B?eHByeUsreS8xMlVMRTg2NG93dDVMem5xcFRPTmNCb200YXRSZGRBYS9UTmtZ?=
 =?utf-8?B?ZGhhMlQzdVFUNTIvYlcrWkN1R1lwZWFrcUxzcThEcGJLenBmTzFoejFBcS8w?=
 =?utf-8?B?eTJ2VElHSFZNZHd0L29IMTdZTERDeElTMGpHWTRGZWpCQUxkSjc2RDBlZjFw?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CDF76D63A54FC4A98C33DEE7004E5EA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c894c0f-2bb9-4e2f-7893-08dce2432bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 18:02:10.5506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcuuKiWrAGFgaxNiuOvwYFnqCHDYHDXUjQ9JVOgi9jJOZQzfwkXAgsdF9EMeOQq8b2vml955Xd9TAU+AjngUgZbQguIYKfQZww5AdE34tao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7275
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.857000-8.000000
X-TMASE-MatchedRID: X4bcv0S75KkOwH4pD14DsPHkpkyUphL90i/hFXziUdOLWuywoQz7tO+1
	giXGd3Eefdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CxfgZIkbJhzfgTozVi1xfq8R+m
	RDHa7QqxHHz/ncFSz1eGKEwEzyKks0x3/HP06C9wD2WXLXdz+AQrefVId6fzV63RWgrXHe9cTBr
	T5FMhW3Y1H8ImYhbTQrv0h5l4pUaFehll0JtAbYRcqpH7D1rtQEtdrY/Wb3fNCannV/b7f2bwvU
	FdZPHgIUa7nG2SDWWA+Jck2RObbKqTBNmfHIEnzV/Yjw+UEme40AKed0u9fB2ecrqZc3vab6Bo4
	lLEMN2m4RgI4OvCY01MoNtm7QNfuWU6oo0jZCQaeAiCmPx4NwMFrpUbb72MU1kTfEkyaZdz6C0e
	Ps7A07QKmARN5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.857000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	8F0A10376977C35A0FD6814C02F5C7B05E635B00872DFFD6F9AB0D322A843CFD2000:8

T24gVHVlLCAyMDI0LTEwLTAxIGF0IDA4OjU1ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gV291bGQgeW91IGNsYXJpZnkgdGhpcyBwcm9ibGVtPw0K
PiANCg0KT0t+DQoNCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQo+IE9uIE1vbiwgMjAyNC0wOS0zMCBh
dCAxMjo0OCAtMDUwMCwgQWRhbSBUaGllZGUgd3JvdGU6DQo+ID4gIAkgDQo+ID4gRXh0ZXJuYWwg
ZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4g
PiB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+
ICBPbiA2LzE5LzI0IDExOjM4LCBIc2lhbyBDaGllbiBTdW5nIHZpYSBCNCBSZWxheSB3cm90ZToN
Cj4gPiA+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0K
PiA+ID4gDQo+ID4gPiBTZXQgdGhlIHBsYW5lIGFscGhhIGFjY29yZGluZyB0byBEUk0gcGxhbmUg
cHJvcGVydHkuDQo+ID4gPiANCj4gPiA+IFJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0
ZWsuY29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwN
Cj4gPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiA+IEZp
eGVzOiAxMTlmNTE3MzYyOGEgKCJkcm0vbWVkaWF0ZWs6IEFkZCBEUk0gRHJpdmVyIGZvciBNZWRp
YXRlaw0KPiA+ID4gU29DIE1UODE3My4iKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hp
ZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIHwgNiArKysrLS0NCj4gPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0K
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwu
Yw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiA+
IGluZGV4IDk0M2RiNGYxYmQ2Yi4uNGIzNzBiYzA3NDZkIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiA+IEBAIC00NTgsOCArNDU4LDEw
IEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmljZQ0KPiA+ID4gKmRldiwg
dW5zaWduZWQgaW50IGlkeCwNCj4gPiA+ICAgfQ0KPiA+ID4gICANCj4gPiA+ICAgY29uID0gb3Zs
X2ZtdF9jb252ZXJ0KG92bCwgZm10KTsNCj4gPiA+IC1pZiAoc3RhdGUtPmJhc2UuZmIgJiYgc3Rh
dGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKQ0KPiA+ID4gLWNvbiB8PSBPVkxfQ09OX0FF
TiB8IE9WTF9DT05fQUxQSEE7DQo+ID4gPiAraWYgKHN0YXRlLT5iYXNlLmZiKSB7DQo+ID4gPiAr
Y29uIHw9IE9WTF9DT05fQUVOOw0KPiA+ID4gK2NvbiB8PSBzdGF0ZS0+YmFzZS5hbHBoYSAmIE9W
TF9DT05fQUxQSEE7DQoNCkhpIEFkYW0sDQoNCkNvdWxkIHlvdSBwcmludCBvdXQgdGhlICJmbXQi
LCAic3RhdGUtPmJhc2UuZmItPmZvcm1hdC0NCj5oYXNfYWxwaGEiLCAic3RhdGUtPmJhc2UuYWxw
aGEiIGFuZCAiY29uIiBoZXJlPw0KDQpwcl9pbmZvKCJmbXQ6MHgleCwgaGFzX2FscGhhOjB4JXgs
IGFscGhhOjB4JXgsIGNvbjoweCV4IFxuIiwNCiAgICAgICAgZm10LCBzdGF0ZS0+YmFzZS5mYi0+
Zm9ybWF0LT5oYXNfYWxwaGEsDQogICAgICAgIHN0YXRlLT5iYXNlLmFscGhhLCBjb24pOw0KDQpJ
J20gbm90IHN1cmUgaWYgaXQncyB0aGUgY29sb3IgZm9ybWF0IHNldHRpbmcgcHJvYmxlbSwgbWF5
YmUgdGhlcmUgaXMNCnNvbWV0aGluZyB3aXJlIGNvbmZpZ3VyYXRpb24gaGVyZSwgc3VjaCBhcyBY
UkdCODg4OCB3aXRoIGFscGhhIG9yDQpBUkdCODg4OCB3aXRob3V0IGFscGhhLg0KDQpTbyBJIHdh
bnQgdGhlc2UgaW5mb3JtYXRpb24gdG8gY29tcGFyZSB3aXRoIG15IE1UODE4OC4gVGhhbmtzIQ0K
DQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gPiA+ICt9DQo+ID4gPiAgIA0KPiA+ID4gICAv
KiBDT05TVF9CTEQgbXVzdCBiZSBlbmFibGVkIGZvciBYUkdCIGZvcm1hdHMgYWx0aG91Z2ggdGhl
DQo+ID4gPiBhbHBoYSBjaGFubmVsDQo+ID4gPiAgICAqIGNhbiBiZSBpZ25vcmVkLCBvciBPVkwg
d2lsbCBzdGlsbCByZWFkIHRoZSB2YWx1ZSBmcm9tDQo+ID4gPiBtZW1vcnkuDQo+ID4gPiANCj4g
PiANCj4gPiBIZWxsbywgSSBiZWxpZXZlIHRoYXQgdGhpcyBjb21taXQgaGFzIGNhdXNlZCBhIHBy
b2JsZW0gZm9yIG15DQo+ID4gTGVub3ZvIA0KPiA+IEMzMzAgQ2hyb21lYm9vayBydW5uaW5nIHBv
c3RtYXJrZXRPUy4NCj4gPiANCj4gPiBXaXRoIGtlcm5lbCA2LjExIHRoaXMgZGV2aWNlIGRpZG4n
dCBzaG93IGFueSB0ZXh0IG9uIHRoZSB0dHkgb3INCj4gPiBzcGxhc2ggDQo+ID4gc2NyZWVuIGR1
cmluZyBib290aW5nLCBidXQgZ3JhcGhpY2FsIGVudmlyb25tZW50cyAod2F5bGFuZCwgeG9yZykN
Cj4gPiBkbyANCj4gPiBhcHBlYXIuIFdpdGggYSBmZXcgYmlzZWN0cyBJIGZvdW5kIGl0IHRvIGJl
IHRoaXMgY29tbWl0LiBXaXRoIGl0IA0KPiA+IHJldmVydGVkIEknbSBhYmxlIHRvIGdldCB0ZXh0
IG9uIHRoZSB0dHkgYWdhaW4uDQo+ID4gDQo+ID4gVGhlIGtlcm5lbCBjb25maWcgaXMgaGVyZTog
DQo+ID4gDQpodHRwczovL2dpdGxhYi5jb20vYWRhbXRoaWVkZS9wbWFwb3J0cy8tL3RyZWUvbXQ4
MTczLTYxMS9kZXZpY2UvY29tbXVuaXR5L2xpbnV4LXBvc3RtYXJrZXRvcy1tZWRpYXRlay1tdDgx
NzMvDQo+ID4gVG8gYmUgcGVyZmVjdGx5IGNsZWFyLCB0aGlzIGRldmljZSBpcyBub3QgcnVubmlu
ZyBDaHJvbWUgT1MuDQo+ID4gDQo+ID4gSSdtIHN0aWxsIHJhdGhlciBuZXcgYXQgdGhpcyBzbyBp
dCdzIGFsc28gbGlrZWx5IEkgZ290IHNvbWV0aGluZw0KPiA+IHdyb25nIA0KPiA+IG9yIGhhdmUg
YSBiYWQgY29uZmlndXJhdGlvbiBvcHRpb24uIElmIHRoZXJlIGlzIGFueSBtb3JlDQo+ID4gaW5m
b3JtYXRpb24gSSANCj4gPiBjYW4gcHJvdmlkZSBwbGVhc2UgbGV0IG1lIGtub3cuIFRoYW5rIHlv
dS4NCj4gPiANCj4gPiAtIEFkYW0gVGhpZWRlDQo=

