Return-Path: <linux-kernel+bounces-527023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF913A4065C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE1701381
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF652063FE;
	Sat, 22 Feb 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tnNt+A64";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DfJsad75"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066EB16BE17;
	Sat, 22 Feb 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740212687; cv=fail; b=srgDNVShJS/m5AtzFr+y6jbZTEPwZYnu5efXkTg76v62BOS8RtIcy7JL1HPL+HO2NfdOgmVfZSsPt9r8IK2EWc0rytbD/ebkp2s4PPOsVvHAThTIUyiULVfodIul+yTqyt9AN+D+oJDOGOBzHS2r9g0VaNYBPw/srtJoBs49Mgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740212687; c=relaxed/simple;
	bh=+NYny8E3OK99VKxERsXGMNHN92ggqSenmpSZF4vYJYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dZOxVXxxO4uqJzUphQDlYP5hEipsZl4h+pPzGGu0miDTZC4L3Gn4lY/djOdqstSPUaDKeCweQzkrug8WnMPhxwtvNQf6Fr/ZF4/r6LTnUZJqB0kzM0PkjSGQkRoK18QzQIUfw81I/QIY0PqgrgidvBA0leO4K98jGEDXQEqjY1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tnNt+A64; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DfJsad75; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 73dbb0b8f0f611ef8eb9c36241bbb6fb-20250222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+NYny8E3OK99VKxERsXGMNHN92ggqSenmpSZF4vYJYg=;
	b=tnNt+A64LOjEcLba/GEkGEyNiSPAjN2GoWJjgf5Hl6kbQoKLhji/zdreWTJtF8ekCFtJ+sxIOKHlGW8W7NHEKKecjMJ6mkISZ6ZgRZILtH8/IaYrLVuRgNnemdkJejp1Ya1jYuIosDiD0d3ieuYAwmqrbIudopYtZhH18d/8wkI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:1579c9a1-6457-4db6-af78-aa36055b8e34,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:37581e29-e0f8-414e-b8c3-b75c08217be8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 73dbb0b8f0f611ef8eb9c36241bbb6fb-20250222
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1372727650; Sat, 22 Feb 2025 16:24:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 22 Feb 2025 16:24:35 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sat, 22 Feb 2025 16:24:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8GsOymSQZHGr+zLNhrNilGJ5Gjk39fGYwIbnbhD3XN7tg1dR9Ye9VvqllEZC3tYhvBskV4YcZkgBk0XFBRLEbEUiwQ04k115QiP+5f3HyU7IbgFukE5N14upf2h5dVfp8mWhMx5SxplSIRpMEWI1sYVXcL1WNX/DjB+tL2Rk/eCuNzwPIH0ZJ+5RoiaN2muTKYOplCjuKyPgvwYplUr/p3a1KdVH/SPSL9eV9bD2d9VYKAkDKl5OJ04zy4ysmyCl42dxr7yZjPSVl+oT1j5hQe70YSSL4UVu8pPRHRrRlhIU08EDbyTpjWqckHVNjFqVhrrPIJw65z2lE1Mra83iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NYny8E3OK99VKxERsXGMNHN92ggqSenmpSZF4vYJYg=;
 b=npoYiDd+k1TTzHE7xzJj3U6nh3kHzcnzGy6GjLyG+DrSnXbMoik3lLvuJf5UTjT38QXE8c2ah1by3Sfuxss0/wo4hnbBnFNN/j5u2Cp20dPzNaVC7zzVzK/+E4X2STvHoBHMuDZw6Mx8yiLLI1X5zF1qKPV563umrrBRcxj+lTxCNbaBtG4uCR/uD2RzIwXl/sNczCwXbG7BRyvKXA7CGwIPkVN/tKVyl2FsGTLXfnkh4EtiRxEmcc25REeZbUN0P4FcNcIfIbCGfYjyJ1or5M7K49yxAtASZiQCAXRGL7IYwHSxFmmxMC1j8ZGfBkiFiP5V7wtGrdu+OppDjz4EmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NYny8E3OK99VKxERsXGMNHN92ggqSenmpSZF4vYJYg=;
 b=DfJsad759IH3Yj6JbK2EbfrDx6hpUTdToiohFUEQ+8uWy23mB2UEvpk8pR5QDLIgrgmnLLUxisRY3LGshhUwMsyWPSuPg8nP7DuJxWqXlVcHfeSuo+Htch4VtzHKsIi/ItjuLrx4yxsTpwJ8rDokPUsynBWdqUJSapP0KA5J13g=
Received: from PSAPR03MB6236.apcprd03.prod.outlook.com (2603:1096:301:9d::13)
 by TYZPR03MB7345.apcprd03.prod.outlook.com (2603:1096:400:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Sat, 22 Feb
 2025 08:24:32 +0000
Received: from PSAPR03MB6236.apcprd03.prod.outlook.com
 ([fe80::2b28:30c4:61a8:20f6]) by PSAPR03MB6236.apcprd03.prod.outlook.com
 ([fe80::2b28:30c4:61a8:20f6%7]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 08:24:31 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 4/4] usb: mtu3: add support remote wakeup of mt8196
Thread-Topic: [PATCH v2 4/4] usb: mtu3: add support remote wakeup of mt8196
Thread-Index: AQHbbBPPPDZzX/JviUGkRts1859fH7MiiHkAgBvloYCADohDgIAGN94A
Date: Sat, 22 Feb 2025 08:24:31 +0000
Message-ID: <8978db24a7fefb92052aaa9d6991077d6730c419.camel@mediatek.com>
References: <20250121145008.22936-1-chunfeng.yun@mediatek.com>
	 <20250121145008.22936-4-chunfeng.yun@mediatek.com>
	 <e63fdeba-04dd-4b88-a6d6-ca8a64e28e36@collabora.com>
	 <a689f7d25fb05ba83ac2de6ba879998fe2e21bcb.camel@mediatek.com>
	 <a286cb5c-40f8-48ec-921d-bcf0b67728ed@collabora.com>
In-Reply-To: <a286cb5c-40f8-48ec-921d-bcf0b67728ed@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6236:EE_|TYZPR03MB7345:EE_
x-ms-office365-filtering-correlation-id: 067cbfe1-79ee-4971-9cae-08dd531a54f6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZitWM0M1TG9uYmk4ajVyWkFUL204WHRWQ3ZScFlBNFFLOS9EVjMxL2EzMmNm?=
 =?utf-8?B?ajZMNUpYbHp3Wis4eHJvOXluTHhoSnRkU0ExbzErajA2TC9neGZVUDRsNks1?=
 =?utf-8?B?bHk4SjkvK3VMcU1tL256S3dTcnFlYm1ySFMvMDRvanoyV0UyUUJVZVVuT1lL?=
 =?utf-8?B?SXVabHRSQ3RUQ1JvaW0wc24xSXJWckxBQVp3bnNvNXJ3ZHIrM1I0SkJqdkpY?=
 =?utf-8?B?R3ZqTjAvbVY2TjUzdWl6VDA1cFlFREROZEtBYUovdEVYWGlPNE9QSkthZmxJ?=
 =?utf-8?B?dzBZK2MrcTdRT1JacDljaXNpc3hJQUhQdjk4MnExc01ibGszRFltTm1Fd0Vv?=
 =?utf-8?B?ekdzWFNnYjBDQ283YXhsbkViUk11b2IrZjFNWDFXQWt6WUtyeFNvc3Y3N1Fj?=
 =?utf-8?B?emxHNXU5T3ZJUHV4NXc1NVFwZTkreFB5TkxxSlBHR1hvYURYK2ZMdDJwaVR3?=
 =?utf-8?B?RGg5b2VCYzVseFhIemdGVy9udDZsb29IRkREcDJIcEFkdzR6RHYraWU3cmdk?=
 =?utf-8?B?S0hmYWNEQ1A1cmwyMkFTUytjK2xCWjJ5VTI3MDNXOTBvSWlhUUlHSGQxRDZy?=
 =?utf-8?B?WGFGdEJzVjMrRkxxc083SGx3SC9ta2IyU0wrWFBCRktkNjJ3dWtDYktZYkVB?=
 =?utf-8?B?Nm8veERpOVhZN1gxM095bExrRWRSNCtHcUdRdUhWcWVJcGJnbTAvTlRTU2Vy?=
 =?utf-8?B?aXpDVENuM3hETWloWFFQVFNRWDNzWEEwc0VHNnZPaWtNL3FqTzJkeWNuaTND?=
 =?utf-8?B?VzRHazQzUUdYMkJQSXVmZEFCWEppZitkY0Jmc2hzZ2xrT1dwR2F6cEkzUTNs?=
 =?utf-8?B?T1kyUytJQXBmaGRheDBRbENtM0hBUDRuUTdzc1JHRW1qVld6SlFTelFqMTNN?=
 =?utf-8?B?Yi9vbG9vUitlcmQycWM0OXV6QmlybmNwa05OdjBiYmg3aG5Fc21TYUg0TmxU?=
 =?utf-8?B?bWFWQ1JwQndjcGwwencrWFE5aDhYSkV5MFZWdFdmd1dTc05JY09qZm44emlE?=
 =?utf-8?B?d1ExWGxqMElTVHF6RTE3WHFJNG9NWDk1amNVdElHVDhGUGx2TW1WT2h0RDlw?=
 =?utf-8?B?cDFjbGNQZGZFeVR5dm15YnFXM05MWFZJc1Z4a0dmNmZiQVdmelhGb2RzNHRn?=
 =?utf-8?B?Mno1TkhaN2hBZXlZcVpjWEo1djVVL3BqcFJaT2JWQTg5eXYzcUFPVUJqbENl?=
 =?utf-8?B?WnlKY1RLYVpxK2xmSUxiUXdhdmpBblFyN0MrTkhqTkZ6VFpscDhMZUtod2xE?=
 =?utf-8?B?SFczcjM5TnZ2cUprNWRxa0JHZ2xZV2dSRzluZFp4RFAzY1I3VnJNNVJ5bS9q?=
 =?utf-8?B?UjFtdDlEV2xhTTh1SXJnNkV2NTlKN3llVFJhbStPd1RXY1RJZk40VlpGSjJi?=
 =?utf-8?B?Vzd2V2w4L0pyZlFpcVpNQmlRVlJTSjI5WjQra05TamE2QmhzSVQzN2d2bjR1?=
 =?utf-8?B?cGNLTlNNLzJLUDJ3VjEzQkhpU3U3cVFyTTBBcHZpKzh4ZC9Ka09mZHNmcjNB?=
 =?utf-8?B?NXZaKzE2U2JNeG1ZVWVWeW02dFFTUXFoeW1kWmFHQzRBMm1Nd1lxa2txMkx5?=
 =?utf-8?B?WmYyZ1pJeFlucWxkZklFa2VxdDNyZFdBZkpReWsrakdGY1RsWlJKaDNUaUI5?=
 =?utf-8?B?QjRsM1Y3S1VkL21UWEtIWnJxODBQNXlRcSsyYmEvRkhMZ0h6T1c4U1JpOGhj?=
 =?utf-8?B?SnhqZ2JvaXhBOTg1WkpuTzc4ZWdxWFNzaTFVTUJYd1diUDZuL2V1ZS9OV3BM?=
 =?utf-8?B?R1A3NTlHdWl0T3YyVlJnMEROZkpOOEpCaFFNUlJMT09lc1FwaEZqVFM2dXY3?=
 =?utf-8?B?R1VzM3IzbE1VT0E3NEVBK3hiOUVOai9xWFY2NFNuSzVCYms3RUtnRFZWNnF6?=
 =?utf-8?B?WjMvM3NHeWY1ZWxjWTY1T0ZvWXJMWHQ1TWNrRUVLYVhwbGZZQ3BkVTg3VDFO?=
 =?utf-8?Q?zYI0ZdDbXX2hl5HOZpIVJdJKR6nUgDdB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6236.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RERFR2tBY3VFOXZLaUJnN3QvNktYMVhhajdZYkpXN0JnQVlWVDQ2dFpCSGox?=
 =?utf-8?B?azh2Rk4vbVNpcFNmMHM5UWVxZDg0WG5DS2dzcjZYd0t0em5UT09VSEdsdExX?=
 =?utf-8?B?VWQxSTRmU1MvTWtsTGFSVUU1VW5VZVprcmlVS0NDcldMVjZXTnhDOFFZeVJC?=
 =?utf-8?B?akdrZmJYVTdzbHhvZzZNT3JnU2RHTk55YWhlbkZzNXRKYm90SGZZSEY5VUh5?=
 =?utf-8?B?NmlyNVVoZnlNL2VrVjY5TllvQzBrcjdtdVc3MDBGN1NTNnp1cWtKc0hSL0Na?=
 =?utf-8?B?REFONTlWREV0NzE4UUVWS1BvZCs1N05ZTURLcFdPMlpuVGg5THFvbjJoQ2Nw?=
 =?utf-8?B?NUF3eXR6OE44OStIcklQcW5UM0ZCYkFhVm5DMnphb1gyV1FsTlQ5TXBERU9h?=
 =?utf-8?B?T2hBbTFRZjhpeW8zRFZtVEdhMzR0bFVRU0NWcXpiQ1M3VUNpQmhoaEpKSlY1?=
 =?utf-8?B?MWtTNE9uMUc1SWxFaVVpTDFQcEdLK240WGVGK1FDWnVJZGhyNVU5cW5OODkz?=
 =?utf-8?B?eGtoNy9KYllGQ0FxN3JmaU02MFpKS0JxZUlMbnpYR0VxVXhsWVlPZk5mMDNW?=
 =?utf-8?B?NlJFNDcvUm1JeGFXcGliU3lnSjc1TXM3QSthS1ovSjBZNVV5amtJY2RGdnFo?=
 =?utf-8?B?djlsakVSVVF0MzFkN2pLMEt0dlhsVVBjQTBQOWxRekxRQUlvZXhJWXV4ZHlV?=
 =?utf-8?B?UkJGS1NlNGVpaHFvSWQ2ZGp6UG00Sk5QOXIrbThJTjZ3SDFqOE1FdU9hSFox?=
 =?utf-8?B?VDlGMzF1V3VPU21SZkdjMVhUcUpnWXhOZEd5SjNWTGdFWExZWWVOd3dkM1hK?=
 =?utf-8?B?VVphZ2tIWXFJcTFlN1J3YmtHTGxaenBrNDFIbzY2NzZ4eDlsUGFYS1ZYN2Mx?=
 =?utf-8?B?K3ZBT2VzYkJHTEk1NXRHMjBwOE1JaWdRK05VR2xSY3dnbUR6WDZHTzJ0dnNF?=
 =?utf-8?B?eTI5QzFjZlZud0dGd3Z1L2JaQlpta3VZSWszK21YV2Q0RnRKRHlqTjJKZGQr?=
 =?utf-8?B?ZHZzNUFTQzltemZsQXZINUp0U2ljOG1TY1pPZkZQeDcvWHc1UDdtWUpxWVVD?=
 =?utf-8?B?eFNSanQyVlFydUd1MzBXMmJueEZKTHU4OGl3Zlg4N0tQQXYwK0RKZTdxQ2ZV?=
 =?utf-8?B?OVRwM0dYenNrc1hEQ1diRHBrTmxMYkp2SVlScEw2bk5raTNyQjdFQ09FQ08y?=
 =?utf-8?B?a1FsbXpXN0xKUy9HYTdpeEpXU2tEb3FBNkR2OE84aVNZRWdBR25KbXoyNVBO?=
 =?utf-8?B?RUJ0eWk3bmNqaVNHU3hDaFNrcmlYVnlYTnBNV09QSFEvWlhySmVnSWFlTkJw?=
 =?utf-8?B?aXBvaGdORUlxVzFMNWxkZHkzeUxEQ0l5VlRuNW40bDZEbkg4bE9GUVF5M1dD?=
 =?utf-8?B?UFp1cVlrSExoVDNMNkxnemhEbjJXa3hFYVhmamllTlMwb3c3c1YxR2M0blEz?=
 =?utf-8?B?ZjQwSm42VElwUU92elZDOWNkR1JST3laTjQ4eDZEYXBCcGtEZGVkZ05rSE4y?=
 =?utf-8?B?dEZKRmV3TFNvbStTR2dEZ0tqS2dNcUtVQmlTZUxnalZmeW91TnFnb2k5cjAr?=
 =?utf-8?B?WHVsYkE1VmkxQm5nOWRJWStraHVzRmtTRkNQbmdLL21jV04vWmFHaTVBcHpI?=
 =?utf-8?B?MDJ6bFdzUWFta1Vlc0syc2lSbDYzNUI0STIxdzIwb3d3SGhxSDE5VlpPYS9q?=
 =?utf-8?B?Nk43RnJyRERnbnd5L1hOSXFnc3JRMml1RzdONnNNMTVXMzVXSWc5bjR3UkhQ?=
 =?utf-8?B?cy9MQW1tVTFvVHZRam1oS1BhTndrSFA0aitDanRIdy8rOEsrNmtkOGFJdm9s?=
 =?utf-8?B?ZnV0RVZ4TlZqNEFJUHBYbDNLK0cwbEk2dzhRV0pSMTUxSitQZUZBWUlVK0ZF?=
 =?utf-8?B?U3UrazRiTHNRWFNKZWN0alN6L1F3WUtPZ0lmMEMvd0hRT3lTeWZyekZWT2Mr?=
 =?utf-8?B?UjlWai9oY1hOcFN2dFF6ckNPemNuaE9TTXNyWHI3VlE1U3lMeXQ0NE45TEE3?=
 =?utf-8?B?SnZUcFpIS2dLc3pXNExDL0pMN1hnSTJpWHVDZXpld2kvSEgyVUxOb3FwbEJa?=
 =?utf-8?B?MG1TMGNxZGpxNFltS3BYQVprSG0rcFlwbmI4MGhyTUNlbDMxNXRmWEJ3ak9h?=
 =?utf-8?B?TUhEeHpKSENlUnA0U2FSWTZ6Tk9HMDlLT0wyNXFhbjMyWEs5ZVN2MkE2VTRM?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C6C18682788EF4483B4A44F1FBCA715@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6236.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067cbfe1-79ee-4971-9cae-08dd531a54f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 08:24:31.5626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1x6pGX4eLQxqHs60dAHhTMmt9jLTXb8T3b6xhmcjF6BcF0O3mQCa0o5JmH/htWyYYoV9JqwbOTXZkKPu7c6j8lGJ12Udg/Ctgp5K1PW2Bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7345
X-MTK: N

T24gVHVlLCAyMDI1LTAyLTE4IGF0IDEwOjI2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwOS8wMi8yNSAwNDozMSwgQ2h1bmZlbmcg
WXVuICjkupHmmKXls7ApIGhhIHNjcml0dG86DQo+ID4gT24gV2VkLCAyMDI1LTAxLTIyIGF0IDEw
OjMwICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMNCj4gPiA+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IElsIDIxLzAxLzI1IDE1OjUwLCBD
aHVuZmVuZyBZdW4gaGEgc2NyaXR0bzoNCj4gPiA+ID4gVGhlcmUgYXJlIHRocmVlIFVTQiBjb250
cm9sbGVycyBvbiBtdDgxOTYsIGVhY2ggY29udHJvbGxlcidzDQo+ID4gPiA+IHdha2V1cA0KPiA+
ID4gPiBjb250cm9sIGlzIGRpZmZlcmVudCwgYWRkIHNvbWUgc3BlY2lmaWMgdmVyc2lvbnMgZm9y
IHRoZW0uDQo+ID4gPiA+IEhlcmUgYWRkIG9ubHkgZm9yIGR1YWwtcm9sZSBjb250cm9sbGVycy4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcu
eXVuQG1lZGlhdGVrLmNvbT4NCj4gPiA+IA0KPiA+ID4gICBGcm9tIHRoZSBkYXRhc2hlZXRzLCBJ
IGNhbiByZWFkIHRoZSBmb2xsb3dpbmc6DQo+ID4gPiANCj4gPiA+IElQMDogaG9zdCAtPiAweDE2
NzBfMDAwMCAgZGV2aWNlKG10dTMpIC0+IDB4MTY3MF8xMDAwDQo+ID4gPiBJUDE6IGhvc3QgLT4g
MHgxNjcxXzAwMDAgIGRldmljZShtdHUzKSAtPiAweDE2NzFfMTAwMA0KPiA+ID4gSVAyOiBob3N0
IC0+IDB4MTY3Ml8wMDAwICBkZXZpY2UobXR1MykgLT4gMHgxNjcyXzEwMDANCj4gPiA+IA0KPiA+
IA0KPiA+IEknbGwgY2hlY2sgaXQuDQo+ID4gDQo+ID4gPiAuLi50aGlzIG1lYW5zIHRoYXQgeW91
J3JlIG1pc3NpbmcgdGhlIElQMiBoZXJlLCB3aGljaCB5b3UgZGlkIG5vdA0KPiA+ID4gbWlzcyBp
biB0aGUNCj4gPiA+IGNvbW1pdCBhZGRpbmcgdGhlIHdha2V1cCBjb250cm9sIGluIG10ay14aGNp
IGluc3RlYWQuDQo+ID4gPiANCj4gPiA+IFNvLCBzaW5jZSBJIHNlZSB0aGF0IGFsbCBvZiB0aGUg
VVNCIElQcyBhcmUgYmVoaW5kIE1UVTMsIGFuZCB0aGF0DQo+ID4gPiB0aGVyZSBpcyBubw0KPiA+
ID4gVVNCIElQIHRoYXQgZG9lcyAqbm90KiBzdXBwb3J0IGdhZGdldCBtb2RlIChzbywgdGhlcmUn
cyBubyBVU0IgSVANCj4gPiA+IHRoYXQgZG9lcyBOT1QNCj4gPiA+IHN1cHBvcnQgTVRVMyksIHlv
dSBzaGFsbCBhZGQgYWxsIHRocmVlIGhlcmUsIGFuZCB5b3Ugc2hhbGwgZHJvcA0KPiA+ID4gdGhl
DQo+ID4gPiBjb21taXQgdGhhdA0KPiA+ID4gYWRkcyB0aGUgd2FrZXVwIGNvbnRyb2wgaW4gbXRr
LXhoY2kgZW50aXJlbHkuDQo+ID4gDQo+ID4gTm8sIEknbGwgc3RpbGwgYWRkIHRoZW0gaW4gbXRr
LXhoY2kgZHJpdmVyIGFzIGJlZm9yZSBmb3IgdGhlIGNhc2VzDQo+ID4gdGhhdA0KPiA+IG9ubHkg
dXNlIHhoY2kgb25seSwgbm8gbmVlZCB1c2UgbXR1MyBkcml2ZXIuDQo+ID4gDQo+ID4gQXMgSSBz
YWlkIGJlZm9yZSwgZXZlbnQgdGhlIGNvbnRyb2xsZXIgc3VwcG9ydHMgZHVhbC1yb2xlIG1vZGUs
DQo+ID4gd2hpY2gNCj4gPiBkb24ndCBtZWFuIHRoYXQgaXQgY2FuIHVzZSB0aGlzIHVwc3RyZWFt
IG10dTMgZHJpdmVyLCBzb21lIFNvQyBoYXZlDQo+ID4gbGltaXRhdGlvbiBhbmQgY2FuJ3Qgc3Vw
cG9ydCB0aGUgZHVhbC1yb2xlIG1vZGUgc3dpdGNoIHVzZWQgaW4NCj4gPiB1cHN0cmVhbQ0KPiA+
IGRyaXZlci4gYnV0IGFsbCBTb0MgY2FuIHVzZSB1cHN0cmVhbSB4aGNpLW10ayBkcml2ZXIuIHRo
YXQgd2h5IEkNCj4gPiBhZGQNCj4gPiBzb21lIFNvQydzIHdha2V1cCBjb250cm9sIGluIHhoY2kt
bXRrLCBidXQgbm90IGluIG10dTMgZHJpdmVyLg0KPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGlzIGlz
IGJlY2F1c2UgdGhlcmUgd2lsbCBiZSBubyBEVCBub2RlIGRlY2xhcmluZyBvbmx5IFhIQ0kuDQo+
ID4gPiANCj4gPiA+IFNpbmNlIGFmdGVyIHRoZSBwcm9wb3NlZCBjaGFuZ2UgYWxsIGNvbnRyb2xs
ZXJzIHdpbGwgYmUgTVRVMyAtPg0KPiA+ID4gWEhDSSwNCj4gPiA+IHRoZXJlJ3MNCj4gPiA+IG5v
IG5lZWQgdG8gYWRkIHRoZSBzYW1lIGluIHRoZSBtdGsteGhjaSBkcml2ZXIuDQo+ID4gDQo+ID4g
SSB0aGluayBpdCdzIGJldHRlciB0byBsZWF2ZSB0aGUgc2VsZWN0aW9uIHRvIHRoZSBjdXN0b21l
ciwgZm9yDQo+ID4gZXhhbXBsZSwgb24gY2hyb21lYm9vaywgd2Ugb25seSB1c2UgeGhjaSBkcml2
ZXIgYW5kIGRvIG5vdCBlbmFibGUNCj4gPiBtdHUzLg0KPiA+IA0KPiANCj4gQ2hyb21lYm9va3Mg
Y2FuIHVzZSBNVFUzIGFuZCBsb2NrIGl0IGluIEhPU1QgbW9kZSBvbmx5Lg0KPiANCj4gVGhlIE1U
VTMgaGFyZHdhcmUgaXMgdGhlcmUgLSBkb24ndCBoaWRlIGl0Lg0KSSBkb24ndCB3YW50IHRvIGhp
ZGUgaXQsIHRoZSBkdHMgYmluZGluZyBzdXBwb3J0IHR3byB3YXlzIHRvIHVzZSB4aGNpLQ0KbXRr
IGRyaXZlci4gQW5kIHdlIGNhbid0IGZvcmNlIGN1c3RvbWVycyB0byB1c2UgdGhlIG1vZHVsZSBo
ZSBkb24ndA0KbmVlZCBpdCwgcmlnaHQ/IHRoYXQgd2lsbCBiZSBlYXNpZXIgdG8gZW5jb3VudGVy
IG1vcmUgcHJvYmxlbXMuDQoNCk9uIG1vcmUgTWVkaWFUZWsgU29Dcywgd2Ugc3VwcG9ydCBkdWFs
LXJvbGUgY29udHJvbGxlciBhbmQgaG9zdCBvbmx5DQpjb250cm9sbGVyIGF0IHRoZSBzYW1lLCB0
aGVuIHdlIHdpbGwgYWRkIHRoZSB3YWtldXAgZnVuY3Rpb24gb24gYm90aA0KbXR1MyBhbmQgeGhj
aS1tdGsgZHJpdmVycy4gU28gZm9yIHRoZSBTb0NzIHRoYXQgb25seSBzdXBwb3J0cyBkdWFsLXJv
bGUgDQpjb250cm9sbGVyLCB3ZSBhbHNvIHdhbnQgdG8gYWRkIHRoZW0gYXMgdGhlIHNhbWUgd2F5
LiBUaGlzIGNhbiBiZQ0KdHJlYXRlZCBhcyBhIGNvbW1vbiBwcmFjdGljZS4NCg0KDQpUaGFua3MN
Cg0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KPiA+IFRoYW5rcw0KPiA+IA0KPiA+ID4g
DQo+ID4gPiBDaGVlcnMsDQo+ID4gPiBBbmdlbG8NCj4gPiA+IA0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gdjI6IGFkZCB3YWtldXAgZm9yIGR1YWwtcm9sZSBjb250cm9sbGVycw0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gICAgZHJpdmVycy91c2IvbXR1My9tdHUzX2hvc3QuYyB8IDE3ICsrKysrKysrKysr
KysrKysrDQo+ID4gPiA+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+ID4g
PiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX2hvc3QuYw0K
PiA+ID4gPiBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19ob3N0LmMNCj4gPiA+ID4gaW5kZXggN2M2
NTdlYTJkYWJkLi5kNjViMGYzMTg0MzYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNi
L210dTMvbXR1M19ob3N0LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2hv
c3QuYw0KPiA+ID4gPiBAQCAtNDYsNiArNDYsMTEgQEANCj4gPiA+ID4gICAgI2RlZmluZSBXQzFf
SVNfUF85NSAgICAgICAgIEJJVCgxMikNCj4gPiA+ID4gICAgI2RlZmluZSBXQzFfSVNfRU5fUDBf
OTUgICAgICAgICAgICAgQklUKDYpDQo+ID4gPiA+IA0KPiA+ID4gPiArLyogbXQ4MTk2ICovDQo+
ID4gPiA+ICsjZGVmaW5lIFBFUklfV0tfQ1RSTDBfODE5NiAgIDB4MDgNCj4gPiA+ID4gKyNkZWZp
bmUgV0MwX0lTX0VOX1AwXzk2ICAgICAgICAgICAgICBCSVQoMCkNCj4gPiA+ID4gKyNkZWZpbmUg
V0MwX0lTX0VOX1AxXzk2ICAgICAgICAgICAgICBCSVQoNykNCj4gPiA+ID4gKw0KPiA+ID4gPiAg
ICAvKiBtdDI3MTIgZXRjICovDQo+ID4gPiA+ICAgICNkZWZpbmUgUEVSSV9TU1VTQl9TUE1fQ1RS
TCAweDANCj4gPiA+ID4gICAgI2RlZmluZSBTU0NfSVBfU0xFRVBfRU4gICAgIEJJVCg0KQ0KPiA+
ID4gPiBAQCAtNTksNiArNjQsOCBAQCBlbnVtIHNzdXNiX3V3a192ZXJzIHsNCj4gPiA+ID4gICAg
ICAgIFNTVVNCX1VXS19WMV8zLCAgICAgICAgIC8qIG10ODE5NSBJUDAgKi8NCj4gPiA+ID4gICAg
ICAgIFNTVVNCX1VXS19WMV81ID0gMTA1LCAgIC8qIG10ODE5NSBJUDIgKi8NCj4gPiA+ID4gICAg
ICAgIFNTVVNCX1VXS19WMV82LCAgICAgICAgIC8qIG10ODE5NSBJUDMgKi8NCj4gPiA+ID4gKyAg
ICAgU1NVU0JfVVdLX1YxXzcsICAgICAgICAgLyogbXQ4MTk2IElQMCAqLw0KPiA+ID4gPiArICAg
ICBTU1VTQl9VV0tfVjFfOCwgICAgICAgICAvKiBtdDgxOTYgSVAxICovDQo+ID4gPiA+ICAgIH07
DQo+ID4gPiA+IA0KPiA+ID4gPiAgICAvKg0KPiA+ID4gPiBAQCAtMTAwLDYgKzEwNywxNiBAQCBz
dGF0aWMgdm9pZA0KPiA+ID4gPiBzc3VzYl93YWtldXBfaXBfc2xlZXBfc2V0KHN0cnVjdA0KPiA+
ID4gPiBzc3VzYl9tdGsgKnNzdXNiLCBib29sIGVuYWJsZSkNCj4gPiA+ID4gICAgICAgICAgICAg
ICAgbXNrID0gV0MwX0lTX0VOX1AzXzk1IHwgV0MwX0lTX0NfOTUoMHg3KSB8DQo+ID4gPiA+IFdD
MF9JU19QXzk1Ow0KPiA+ID4gPiAgICAgICAgICAgICAgICB2YWwgPSBlbmFibGUgPyAoV0MwX0lT
X0VOX1AzXzk1IHwNCj4gPiA+ID4gV0MwX0lTX0NfOTUoMHgxKSkgOg0KPiA+ID4gPiAwOw0KPiA+
ID4gPiAgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ID4gKyAgICAgY2FzZSBTU1VTQl9VV0tf
VjFfNzoNCj4gPiA+ID4gKyAgICAgICAgICAgICByZWcgPSBzc3VzYi0+dXdrX3JlZ19iYXNlICsg
UEVSSV9XS19DVFJMMF84MTk2Ow0KPiA+ID4gPiArICAgICAgICAgICAgIG1zayA9IFdDMF9JU19F
Tl9QMF85NjsNCj4gPiA+ID4gKyAgICAgICAgICAgICB2YWwgPSBlbmFibGUgPyBtc2sgOiAwOw0K
PiA+ID4gPiArICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gPiArICAgICBjYXNlIFNTVVNCX1VX
S19WMV84Og0KPiA+ID4gPiArICAgICAgICAgICAgIHJlZyA9IHNzdXNiLT51d2tfcmVnX2Jhc2Ug
KyBQRVJJX1dLX0NUUkwwXzgxOTY7DQo+ID4gPiA+ICsgICAgICAgICAgICAgbXNrID0gV0MwX0lT
X0VOX1AxXzk2Ow0KPiA+ID4gPiArICAgICAgICAgICAgIHZhbCA9IGVuYWJsZSA/IG1zayA6IDA7
DQo+ID4gPiA+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiA+ICAgICAgICBjYXNlIFNTVVNC
X1VXS19WMjoNCj4gPiA+ID4gICAgICAgICAgICAgICAgcmVnID0gc3N1c2ItPnV3a19yZWdfYmFz
ZSArIFBFUklfU1NVU0JfU1BNX0NUUkw7DQo+ID4gPiA+ICAgICAgICAgICAgICAgIG1zayA9IFNT
Q19JUF9TTEVFUF9FTiB8IFNTQ19TUE1fSU5UX0VOOw0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0K
PiANCj4gDQo=

