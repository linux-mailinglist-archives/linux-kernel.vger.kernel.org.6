Return-Path: <linux-kernel+bounces-440655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9959EC270
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AE2282A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E888A1FBEB1;
	Wed, 11 Dec 2024 02:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IZzwPAUS";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FTrxP6o4"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C002451CD;
	Wed, 11 Dec 2024 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885220; cv=fail; b=EPL5Wab7RXEQj0k48Ik7SMbbNLOpUnZ9KuzgDaCinbLJgB0voGSzhwPWfMKg1mdWnEizq0N78TMRdP7gwXkDZZdfoHWFhxIXwcdnGjtP4tzG26peP+UEPJYz3vFKpCXKPhX0Sm7zqD6WtGbf0CXmJ7lRxN677MZ0pdGtzWlmKUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885220; c=relaxed/simple;
	bh=pbUVGoSD3+IQKF/BVCxmua+9Otpte+5BAJTGO0mcgig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Flh3Rr8TN2dTtztOyUPiyszbXoaRflxLxmIlkGKcM/0XHF8mjWuqLEwqLQRVfKasEdo4zWRECohoCDpTE5/kjBd2D54DX6hHqouht1zi8YWL4VchTE8Rgkvi6AHpc3JResdNmoI/zkOKMwSGZ23GtEU/WdewQj5aFWQRlG2VM2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IZzwPAUS; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=FTrxP6o4; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2c458e60b76a11efbd192953cf12861f-20241211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pbUVGoSD3+IQKF/BVCxmua+9Otpte+5BAJTGO0mcgig=;
	b=IZzwPAUSppMZ5BOJkDUNH4E9Urc1zalg2VQGW3VZ25pHjfYdhNo8dLiddhOHGj/dmRcRxrrTC9Y/MknPvpxxzU+73bFHTo3giKvDn1OvSZbvQ/QOmCnH9GauV+fxQCCZ0aZwQvooTrZ25VCrYP4D+lYhhFJtyxULYXHKQb2b73U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:76c579bb-1fb6-4648-954a-1a5acd5c2490,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:71752cc1-1c82-4420-82d9-d6eb228f5c4a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2c458e60b76a11efbd192953cf12861f-20241211
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1116202103; Wed, 11 Dec 2024 10:46:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 11 Dec 2024 10:46:49 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 11 Dec 2024 10:46:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAej/x72E1G+OZFQKMUEAWwP3FcCIDwY6NqBVZG26okiWVcaetxguYEVh5HnBLhZGiSAylJmwfMDnQccpcVT8a5yjoHhReRacsubAeBcfsDY0op5dj1t+raxf5altwj9+KIV/x+awRsGmcuVGdnhD+VPwp1m+qD60nAmRegE/fhVtL9hWHiIPHbiQcgkrnyawSMOSnki9Z3xjY5ODcCK4PMkzJN6j+9cmbuo8vDOu7Q2CdsKAVHzix5JTgDRWd5M95LmT3YoFm7ucnrKbQhUVnL1g+Ku1VCebqDG9EhJKW3+423jZKCTs4TxRJdoe6DV6XxHF8IzExlLFa7BUNlI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbUVGoSD3+IQKF/BVCxmua+9Otpte+5BAJTGO0mcgig=;
 b=eyIj83jqgWcCYBsgLiysGlBzCtpB4ks1tchyXJWV3jNa9oEAZGlbCQ1d1A05475AR45z0/cxj9+mbEeeRju/SnR/xX+T7JUQumTJgBlTrWnu2+FA1Zg0uJ9STIoZDPOYDc4dkUajItp42sAOjBIWzBDxaOZzky/McHi9I0h8Rt1/Y5HSetslY+yeGQwFJ0hsvjYsU7sy4Iinehjrv2+L6Q4cx2+BGrjCIu2ElIIo4w9/W8QLoTbYzvSwHQvn3vq6qxNEEPfyJH1CGRne0m2arKwTqsXZPchbXLof5ryR+6LaoJ/m2xapKyJ0KJoToghFMEjxjoGPMcWW+eYx6Gt3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbUVGoSD3+IQKF/BVCxmua+9Otpte+5BAJTGO0mcgig=;
 b=FTrxP6o4VTrHl3zH4UgA53/l75MtR5u7IRkKX9mW8b+JkRqlS85tMAVkferYWcv+YlL0U50sRu1pbQuKKUpP+BYd7TSt1U2kTijiJrMIRq9OiVQ53JEbWlq1aHB2LztlkaWvipdT8NAudTn6CgTsZa07ZcQLyfk3Hx1Buo6mFtY=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by OSQPR03MB8481.apcprd03.prod.outlook.com (2603:1096:604:27b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 02:46:44 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 02:46:44 +0000
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
Subject: Re: [PATCH v2 12/15] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Topic: [PATCH v2 12/15] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Index: AQHbRwuDKzLMLP8gmEqSnf1CFqiN77LgX7oA
Date: Wed, 11 Dec 2024 02:46:43 +0000
Message-ID: <a07fdebcad66bf85c30da1323e655b29df1ee108.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-13-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|OSQPR03MB8481:EE_
x-ms-office365-filtering-correlation-id: 3b06d9d2-c979-4b49-616b-08dd198e0c58
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVdra2NRTzF3MkxkVFF0Mk5YcFdHMFZHTjdNSGY0YkRrbC90KytESDBQYlVZ?=
 =?utf-8?B?RW9VSWh1eGkrVTM5MUpGc2MrQk9mSTBSaENFWmtaU2pvVjFMalFEclhJQ0dv?=
 =?utf-8?B?alBkK0tiZ1JuWWt5VGpDS05BaTcrdUJERlpFd3hwMVZDd01GdjMweUo3RDZq?=
 =?utf-8?B?blB2R0pkZjZiaXRhSHVzZTBidTlzUjM4MldjVjRjN3BwL1hCaEFrT3dhbG1I?=
 =?utf-8?B?WmN0b2JoQkFjN3hSNUdBeEMxOU9EY0plQ1pNLzlpMFZmb2RXbVVWSlJ2WEpv?=
 =?utf-8?B?M2NFNmJHNTFYN3NwMFp2dEpnUEg0cDluS1JObnVBQlRCbnlyZXVwVDFFTE9l?=
 =?utf-8?B?dXg4YTlkWkZKNDNHeUxDUnFrY2lndFdWRG1XRTNDS0UyeEJHZ1dxeWFRRndl?=
 =?utf-8?B?cnNGUVE1RGQrVUQ2ejVzbDNza3NtWUtjOTBvczQyTHg0amoxMlByVVFZRzA5?=
 =?utf-8?B?Q1lOY0JWak0yM1VFQ1MvLzBHQlRLTlJtVFBTOTc0cE5NU2sxajJ4c1RDTGJP?=
 =?utf-8?B?SlFBVndKOXVQbFBWdzdvcWMvQXdKc1pxcFMrekJpYllCcGNWeVJmR3IrdlBS?=
 =?utf-8?B?T2lSQldpVE1sS2JxSXRFVC9yeURJN1kzaktMNHNEOHFUdUJyQmdJT0JxOFox?=
 =?utf-8?B?WnZMSU5nbVJTdm5qS0pwamFJYkNhVlNkUjZaM25jNTNsQVcxVHN2OTRvanZR?=
 =?utf-8?B?YmI4T3FFd2pQZEpyRGNwVkw2MFZlcENvd1BvY0RBdUxnL3h4bFlmbHhVMGxo?=
 =?utf-8?B?WjhITFVLckJxdXI1NjBXVUxyQUQrRVpDcXEwakRGRVJzcURTVVZyUytVWEMz?=
 =?utf-8?B?UzRkZDNaNlhaTG1La1ZaZGcyVWI1OGV5NnROekdJK2FBVnpqeGF2bmE2aEQz?=
 =?utf-8?B?UTVEdzBIQzBzeHZaNzFLdnZwLzQzQzVtdC82RHUyWmhIbE9mT1NrMWdYU0RW?=
 =?utf-8?B?eGU5WitaZGZTZ1UzRy9yeVdyaWpJam9sa3J6SURMM2dQU3hHNjdSazRvUVRT?=
 =?utf-8?B?Yis1eG84UFdTQ01seURKZnlFNXU3RWtxR21wd0VqUUFZdWlES1RzaWhLSXFq?=
 =?utf-8?B?Q05nZG1BaGlRZ2pVUVdqRHI4b3FwTDAxRHQ3ZUF0QWNETjl1VHI5YTF2VStD?=
 =?utf-8?B?Zmp2dmMvdXdxMzVsNTJZRjVHWHM1TEcvMTFSeUlyeE1NaTNrL0VTMm5SWW9U?=
 =?utf-8?B?Rm1yOHZJaW5JNzQvTkVvV09FbTNhcmxzUm1qTEtkRzkvRFpMRzRkd2V1RFZH?=
 =?utf-8?B?T1BvN3l3OElxaTVBWkRCREs5bTg5VitPMkR0RFE5ZzlnQ2JXVlNHaCsrRHl0?=
 =?utf-8?B?N1BlUTNaaGFvL2tzWjF5cytaL0FUTldMNFpwL2RjcldhaTRCV1MvSk1US2xo?=
 =?utf-8?B?eGNKYkV1eW5UVlRaUTF4SkVTWEpXMS9jUEw3VEhLY2laR0VNek53bkZQU2JQ?=
 =?utf-8?B?M0NTWEdVcjJaay8rcW1oMjVOWGdKT0VPVXIzK294Q1V6STNGSlVHbFZSOW9O?=
 =?utf-8?B?blZFSXgzclBSTnIzWDY5RmlDODMzZVdoKzZzL2F6M3lZTlJMRDl1Z1U1ejYy?=
 =?utf-8?B?VTcxU2dpdUVUTXlObFMrUzhJc3o0MTltR1pMNWticHJud0VTLzZFdUZPMnBl?=
 =?utf-8?B?eUJQR2VuVk5XVFllaUM0T3JaK0lta1RsMThiOWt2UFJWTTNmYWFTT3JRMzk4?=
 =?utf-8?B?bHl5WHJKOGlkMWdhb2Ruc1BRWTNVMDlMSGMxcTgwVU90SjQ5UHY0WWxIZXpy?=
 =?utf-8?B?dnRuNi9YL01QZGxUMmNjL29FVitQTFk5TXVXTW5NdThTajBic1RjSUhUdUhX?=
 =?utf-8?B?VEhkZElISkFPeDZnQ05KRnhLd0NKajk4RGoweml6bEJ0WVIrU3dhVXQvdEsy?=
 =?utf-8?B?TDQ2OXluMWRxSUpucTZTV1ppczdDRU1QSGoxM1dIL1UrQlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW5WZ1dNUmc3M3l6UzEzTy8vTzJTQnY0N0poRXdoUzkyRDZlN3U3aVpkRTJ1?=
 =?utf-8?B?Y0JyVDIxT2JQaGJkdEtET0M1UjJYL2dybkg2V256czgzbkprdU94YWVTRTNB?=
 =?utf-8?B?Y3kvTkk4T1ByUEJxQkRCRGR0Ky9QZTBVTys5OWlUTTJoN0pHNzdyam5CdXpt?=
 =?utf-8?B?WW15aDRxeGdzQ1ZhVENnY2J2d0FJNTR4cFdqTElCdzRnSVdiZ0FQWWNhTllR?=
 =?utf-8?B?SncrdGVvOU96Rnl2bkluM2NuVmFveG45L3AzL2p5WVo2RFArSDhNWGdod3g5?=
 =?utf-8?B?UHlvakMyejhkeEpCMmw1ZExZS0dkN3FvVjZqbm15L3pQcFhUdHA4SkphS2Mz?=
 =?utf-8?B?a0N1bm9rNFYvb2oyTWdqMGJYTEJRZFkyVnE1OU1KeGQxck1TQitRdTRNZWxr?=
 =?utf-8?B?VkhPSkpJakhOWnBZWjRLNkJLdG5sYmNUcmJvOW9mM1dsNE82cFlOYTBXckh6?=
 =?utf-8?B?UDNLd1JhZkZsV2I1OHE0TTZQS2V2RGQyRldzWWdydkFpeUMyaGJ0VDFUSGh3?=
 =?utf-8?B?VWFRSnpWTnF5OGhYdFpQeFFZc0t5aHF3NlFLK1pwa1JzMkZmTzVVVXllVUtE?=
 =?utf-8?B?TkxDNlhhY1BxUzhGbmdXUmRHQjBqK042RU9idmZHcTdKRWZ0K01oMThmZkhB?=
 =?utf-8?B?bk1CVFIxUGpBKzJ0dlJlUHMrNmFaRlpPRTBpTWdZNFJFTWFqU29nUi9VcGVY?=
 =?utf-8?B?NkJpV2RiU3lrR3V3ZjQwd1EzS2dPcEx2NDNMdndselZIM3U4czhkTnp6TUV3?=
 =?utf-8?B?ME9kNlFTZ2pVWFR2NXEyN05nZExkR3lHdzB3dnJUVVQ4Y20vaUdiWFNtTFJY?=
 =?utf-8?B?OGJsN1YvNGhZMmhlRzJQd21BM0tMeS9leFQxbG5mdzFUUEF0L2FPcnhqbGdW?=
 =?utf-8?B?ckFNSHBsNEI4N2xuVkNmR0NQOHVBS2dhRVdGY01ZWldZY0JoMlZpa1Byejlw?=
 =?utf-8?B?RkQxeXY1WGxWK0FxditDQ0thaEZmS3dFRENqK1JFdEYvZ1NhTVhvUW5nT2w0?=
 =?utf-8?B?cGhqTC94d1VwNGlldy94eFlZaEU2aTZ4OGNSbks2MmdRTDlUcjlvbUFoZ3B1?=
 =?utf-8?B?OThGWUxMUkRmeENjK1BtUzc3aUZndU1DY0J0aGRDTzU5blllZG55TUV3Y2x5?=
 =?utf-8?B?ZGY5UytSeUhWVkNDSDJUYWhTd3FtemNiZmRmczZCbkg2VnpKOVAza2RTMWFn?=
 =?utf-8?B?QXF3aEdFM0p5dlc4Mk15N3F2UjJjN1JWbUlrb1I4Ny83QU9BY0hWWGhzOGtu?=
 =?utf-8?B?SEtjS0JUSXhORFNrdDJnNHRtN285b0FCNGtXQmZDQjJiWHh2aHoyNmJ5VzJn?=
 =?utf-8?B?b2tiQXU1SmN6QWI0Qyt1Y3RZRThsWGR0anY2R2IxbHJQMWdnSzhjdnhEOXd5?=
 =?utf-8?B?d2ZRTWhzUlhWRjVPbkY4aHl0ZEhXMGYrdWh5NUJRd0NmaGNKUVl3VGZxSXF3?=
 =?utf-8?B?NFhqa2Rwd2Q3cWRENmw4Uyt3ejdKRUJSVTh4RXdWbzlBbXZQY2x2WEZGbDE2?=
 =?utf-8?B?TnVtNDFRdThVZ3ZsSTJkclB0OVdISnkyaFNoSW42ZmUyRzBGdU1qK1pmblRp?=
 =?utf-8?B?TW0xb2s4YzJwU2JnSWV0ZzFCWTZTWHh6WEpPK1p1R1VCQ2xhaHo2NjBiSDRn?=
 =?utf-8?B?bUdGd0dieEpjd3JOMGduRkRTMGhZcW1lNmhEMnV4T2Q0QlBXQlhSMEFNR2pu?=
 =?utf-8?B?eFJVSlU3bzlwOVMxbTJ2dC9iZ2xiWXp2SGRPVm1SWm9RVWVWa0s5dzUvUnJO?=
 =?utf-8?B?by9wRS94WDZrbGd4cURoRUtzbjhaTlBQd2hSNElXWEg5OUZEcW8zMjVscFgw?=
 =?utf-8?B?UHdQQjV4TjRsdkl4MEhQZlpzeEVsNklrTU9aY3QxcjNBMmhaSW5VSzlINVIx?=
 =?utf-8?B?bWUwQVVkUkMwOUpMVS82ME9PQk9rWVFZcDljTnFlU2RzS3R6aVZLdW9mZjd0?=
 =?utf-8?B?M2l5WnY2QnNQRWxSeXRwaTBYdEZKcEhNNlZFOTFnVnk4QU5uWmxlRVZYMTd4?=
 =?utf-8?B?Uitsa1hhWUZyVllZcFBQOWJCWS9EODBObzhPUW0xR3N1eE85MlpTeXBGZ1BD?=
 =?utf-8?B?MXRybklzUkM1S2V5ZjJobEt4cmtRd24vZXh1LyszMUJYekljdFV4ZjFZMkZN?=
 =?utf-8?Q?i3+Te2wXJyXwoX8W5Uj+3/5Dq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61D37BBE7A27184DA457B00E9E95137F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b06d9d2-c979-4b49-616b-08dd198e0c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 02:46:43.9049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knwCBrIN8LRPUikclqQAFCRlzlUb2i+DmI0aucYo3laXf5aNZeYHeOLZqqDDrRsrYDEBcEa2l3bRg1zNkivFeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8481

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTEyLTA1IGF0IDEyOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBm
b3IgYWRkaW5nIGEgbmV3IGRyaXZlciBmb3IgdGhlIEhETUkgVFggdjIgSVAsDQo+IHNwbGl0IG91
dCB0aGUgZnVuY3Rpb25zIHRoYXQgd2lsbCBiZSBjb21tb24gYmV0d2VlbiB0aGUgYWxyZWFkeQ0K
PiBwcmVzZW50IG10a19oZG1pICh2MSkgZHJpdmVyIGFuZCB0aGUgbmV3IG9uZS4NCj4gDQo+IFNp
bmNlIHRoZSBwcm9iZSBmbG93IGZvciBib3RoIGRyaXZlcnMgaXMgOTAlIHNpbWlsYXIsIGFkZCBh
IGNvbW1vbg0KPiBwcm9iZSBmdW5jdGlvbiB0aGF0IHdpbGwgYmUgY2FsbGVkIGZyb20gZWFjaCBk
cml2ZXIncyAucHJvYmUoKQ0KPiBjYWxsYmFjaywgYXZvaWRpbmcgbG90cyBvZiBjb2RlIGR1cGxp
Y2F0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8g
PGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQoNCltzbmlw
XQ0KDQo+ICtlbnVtIGhkbWlfaHBkX3N0YXRlIHsNCg0KVGhpcyBpcyB1c2VkIG9ubHkgYnkgdjIu
IFNvIG1vdmUgdG8gcGF0Y2ggWzE1LzE1XS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKyAgICAgICBI
RE1JX1BMVUdfT1VUID0gMCwNCj4gKyAgICAgICBIRE1JX1BMVUdfSU5fQU5EX1NJTktfUE9XRVJf
T04sDQo+ICsgICAgICAgSERNSV9QTFVHX0lOX09OTFksDQo+ICt9Ow0KPiArDQo+IDIuNDcuMA0K
PiANCg0K

