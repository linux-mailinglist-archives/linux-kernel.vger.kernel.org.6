Return-Path: <linux-kernel+bounces-528227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539FDA4151E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A222E3A620D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E491C6FF2;
	Mon, 24 Feb 2025 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="opz2Bz5w";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="es2fuGYC"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AFE28DB3;
	Mon, 24 Feb 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377486; cv=fail; b=Mp8GMg67BWbgXS+RbZG6HrtXXfTQCRRdPE6Ucp/MNH8Cs2x//S/sYdR0yGyFEXtayqViu2buCh/toep8eMZxoHWxmzKMG8L2E2ThvR3Hd5vs/p4sUam7XEkHkFaNq5uffyfntcJjPF8qebtb+ORTijkKvC/LcaA+3tQIH04Mst0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377486; c=relaxed/simple;
	bh=j8x8bqDfNyXps6Xl/0H4zNI7qzTNHQhPeHfijM2zXco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JW/eQxTzm0GDXXE75Noq5Vx2cMUU38CnqFCKYGnRvPiDgSHY289w8DJbxGJfsvZ3QGx95UKpXYuQF2Thl5Abz/VTMtyGFczV5KOn8BjIr0RAFdsLUjX8bo9LKIgBOZLdytRpngECt+JxWpU4+CpPZxFcB+fwVAQPBv1xrPBIlao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=opz2Bz5w; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=es2fuGYC; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2a111d2af27611ef8eb9c36241bbb6fb-20250224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=j8x8bqDfNyXps6Xl/0H4zNI7qzTNHQhPeHfijM2zXco=;
	b=opz2Bz5wZKaPq74ysigamNMk5UNVqfxbzGSFL9a4/55/QhQMuel75iVphOu41Ti0w2b0MgFMOZAeB88eiomNwoPgh31zm8sv6O5m3NkHQWpBDmM1qaY0/x1wWH+AJsAJbi36qaiiTRi1Gr+PhekLXQmBYRYkdBQSX62OBz3vf3M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:adf81773-5f32-4e8a-a2c6-cb33d456c5eb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:cba740dc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2a111d2af27611ef8eb9c36241bbb6fb-20250224
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1827214690; Mon, 24 Feb 2025 14:11:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Feb 2025 14:11:18 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 24 Feb 2025 14:11:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qoz3x0DsmPylePdrNRBWdQiJi7Aa21otOeQITsIGQ75e/amCRfgqiHjMnUacFuCP9XY8/ZDLBNAk88Jk+zUThGY1fzXZQrDGDfP7RVVNaorbTMH0iC6SQh4ZeUpd88XBv4A48kItFJgfaS8mBGhxZeNSCAgDoyztkK8+0tMdgOaW06lz2SXCqbB9EXqeH1Nfb8c9dweiw06YTfGykwX37ndZBxFGugBCq174+E7xyTikOAE08/B3iDoOMOnY23FFQPaZE1+Tb1nFQfew2+31F6GnWetiPCLgnsO2SECed+7g+omWTiJoYtH7j0B5GDoMeSt67bU0gAUOOViw6JInTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8x8bqDfNyXps6Xl/0H4zNI7qzTNHQhPeHfijM2zXco=;
 b=c/lfOEQMdXaYJE28OCSdAzftWFh9e8KJ2ACxnV7NyZN4RJ2f1G7Ns5pzrTKWXgKJO6KCWq9dJoP+ExCfQyLc1D38OzODEPfKU4Vo6KH6byt5YG/nu83+6rPGEVhyiJVG+Rp/AY9TXRHEQNUw/EefO6OidYRf/F9dij0DIkS8iFsnCZlTL6Ut5GnfxHZhHxUIugQ7oQ9X82fMzzYT1ABjstnvz4pb8fZKRTuwty3Ta7QuT8/WGFeIh8a4J8sGX4UgAPGaNkwTiyxIRXnjlrhEyTh23hSlMWIE2HC64pCoXI68zpdkkqnvr3SPt5LFazuBUS38s/Frwd0XTgTMYGtXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8x8bqDfNyXps6Xl/0H4zNI7qzTNHQhPeHfijM2zXco=;
 b=es2fuGYCr0fiGN50Nh8MRKm+jON+zctrG+pZRO05SoqkQmilz8ZAuNnd1fhSyNyZaIXUwa0WS2MPZyZUk6JMYLm/sshlV7eL3CDnOAe2tL5YZsFs73gCeYlSUBOQdbneJ5P18KVuO2gPaf2MEE8E1Gx8yftvKccrQtgkjJOkwuU=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by SEYPR03MB6994.apcprd03.prod.outlook.com (2603:1096:101:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 06:11:16 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:11:16 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 0/2] Add SMI reset and clamp for MediaTek MT8188 SoC
Thread-Topic: [PATCH v4 0/2] Add SMI reset and clamp for MediaTek MT8188 SoC
Thread-Index: AQHbhDUOD5EI06zWY0Spg3u/Aww7RbNTFJgAgALoz4A=
Date: Mon, 24 Feb 2025 06:11:16 +0000
Message-ID: <35f09250a310021a6cccd0f0aa569468d9f6c52f.camel@mediatek.com>
References: <20250221074846.14105-1-friday.yang@mediatek.com>
	 <20250222-miniature-coral-starling-eda1bc@krzk-bin>
In-Reply-To: <20250222-miniature-coral-starling-eda1bc@krzk-bin>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|SEYPR03MB6994:EE_
x-ms-office365-filtering-correlation-id: 640fc6b8-99e5-4c64-2cec-08dd549a0c20
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MVFIZ2s1MkF3SFpyaWZPYTJ1akVOeHdSdTdGL3JiMTllRC9RcVBENmw3YlZX?=
 =?utf-8?B?VUdPaEN3YXZYQ0s4bUFueUw1WHZUVmJQY0o0NFBqZld3SlRJYWlZdzdYUFVH?=
 =?utf-8?B?TE5jMkQydnJoQjFOVmNWMVJEWkUreHRieFprVWV0cnczQ1AraVpRRm9oRGcr?=
 =?utf-8?B?cTlIdktWNmEwWUJseHRQdUNjTFIyNENZR1gwM2Q4ZXl5RWlFa0RSRlZHQmxR?=
 =?utf-8?B?QTlKUkRMSi9GT2ZoTHNWMnM4SHl1REx2QXg3WHJXRXVwSC8zQVcyMTlhaWtK?=
 =?utf-8?B?bmFmV0M1cXI4MVZiRERjUEpvbFdOMG8zejdBb0lScHFmRUNaanZjam1ScFZY?=
 =?utf-8?B?OVpNc0lXem02Qnk1eXJXeXE0WlhXVUZBa01CVVpPS21EbEhLN2ZlQXIvVmtx?=
 =?utf-8?B?UDlvMkIyTEtkWjVucDNWa2VXVzFVNzNjbDljSHYwYVFiU1djS3FLOGdrbVpU?=
 =?utf-8?B?YmNQakREaEluUDJ5SHB2amMwWCtCQWVhVDJNcDFVMDUrRktyaGNtQW1wVHN2?=
 =?utf-8?B?dlUxNDBhYmltaktYRWNOQWlZOVJGY0hsbUtMVWR1NWRpZWVONmRtZ1grQkVG?=
 =?utf-8?B?UFA1UmJmRUwyUkg3Z2ltcGxuZWZESmxZV1YzNzByU1dFQUtuU0tDK3BKZGYv?=
 =?utf-8?B?Q3lGa0xLRWpwVFdPSjM3WUs1ck54U0E2b213M1ZZYlh5Q2wyWkZselVYR2Fu?=
 =?utf-8?B?clNZclJISC8xdmNySHFhQjNIenljNzU4YWtxSEhLWmQxdGphcy9kWDhSYlFn?=
 =?utf-8?B?ZUIzSTRkNkRVOVVFZ09sL2FDOG5lNXZ1R0F2ajd4WFA0V2RFYUNBb1pRY2FB?=
 =?utf-8?B?c0dGWEl3R200Qy84U08yUWM2LytGV3lGQ3VPTUZpek9JSlFYUHVDOXBCMWR5?=
 =?utf-8?B?ejV0NFNpUkhEa2FTbVJFbERTNnVtUFVJemZ0c1JhOHprNUJtRzlsWnhqR3cy?=
 =?utf-8?B?OXZ5UEdEbzRUdUhvWE1WV3BMU0k0MDhaZitHWHY1Vm04ajQrYUhzN0lhdDU4?=
 =?utf-8?B?NmFHQWd4TGs4MzFTcHlxZDJMVHY0bDlVTmIxZU1MeUlGbzhIQXR0WitWWmZF?=
 =?utf-8?B?dVJ4VVdnN0Y2cVJsL0dOSW9JbitIQ1ZlL3dkQWlqZVlTaUpJeFNIMmRMVHJ0?=
 =?utf-8?B?R0EweHVBbDJVTlZtUFk0anEyK0JvYkdjQ0ZRRlR2bjlWNDg1QkJqeDlGR1Zu?=
 =?utf-8?B?N0swRjhoYlhHUEw5TjZ5bThKWWU3MHNnWGc2TWx1RXIzZjBrcTZPeVFUNEEv?=
 =?utf-8?B?ejNpSVhFV3pxempSNEhPNlNDeFVuRURxUi9aYTE1VHVaMVkyWDd2RUxPVEtx?=
 =?utf-8?B?bnozSUVqQ0YrYmRFQWtMMSsyRS9RVFczVE5OQ3ZHRXNsSEpiWnZLYlRMT2h5?=
 =?utf-8?B?SVJoOW5SdDZPQmpWaWwyYWJYbEIwSHo5YnI1OTNQL2VkbWs3ZndZaFJodk9G?=
 =?utf-8?B?RkFCZGNrKzE2S3pnN3FPVlFKZWJUajVmOE5US1ZDSkllcjJqN0VKaDcvVzhZ?=
 =?utf-8?B?U083M0dlVmRWTmFNUnJQSEdUZWlJQWdOVnF0SHN4M2JSTU9TcE01ZFZEa3or?=
 =?utf-8?B?VUM2QjhRQTYzYjVoQVlhM29CcFpLR0diaXRTNER2UGtlSTZzd3EwWWJRSWlt?=
 =?utf-8?B?R1luNWFzVnY0T1l1RHl1UVI3Z0tKU0F4UGQxWFNzSU9UWWZTTzNkSXczM2Jv?=
 =?utf-8?B?VnJUMW43QWd3cW5mSzdkQjFmVXd5bmM1OFk1UTcyM211bVFNbS9HR2drRmVS?=
 =?utf-8?B?TXdMdm5NcnE3UXRSdHVramFrZjdjaVo4Y3g1dFFlMnYweUFMZGtjYnBYMVFv?=
 =?utf-8?B?clJyMjFGYUFIbk5wbWF2U1JKamZpUW1ZcXVZemdLMUZJSzZxUEUwTGZqQ3pr?=
 =?utf-8?B?dTZHYi91SFdYekllMVhEWUhKV3NxZnpOYUxKem9Ddi84V25XdG1sWFJpdW04?=
 =?utf-8?Q?bg+1vrwnvG2tPtxziYDREuWLgaiX6cHj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjhFa25lUjJYZFFMVk9KeEZGbkdFZDZVVVZUdEFCcmVmalU5QU0vaFdjZnFr?=
 =?utf-8?B?MzNBUnNsa2V2SldDZkM2UytIK1kyckE3Ujdlbk1iNGthUWkvMFRhMUVJNXla?=
 =?utf-8?B?N3cyRlJkanVVQ0x3TW9tTStlUDRsQTNSa0R6V0VyWEhSQUE4enIxQXI4dmts?=
 =?utf-8?B?aHF0UDVEdVU2SUVsVTZWNHhFY0FONUxENDlKTngxK0I2U0dDS29WMmhlNmp3?=
 =?utf-8?B?WFFvNXpmMUVoVWJPdG9aUW92Q2UxRFlLRDlHWVIvRGxFellLaEhKSStOZGJL?=
 =?utf-8?B?USt1NVFZSE5uQmxrZnlGc3dueFVsbVdoczlVS2F4TkVXL0RGcmE2dFRndVM5?=
 =?utf-8?B?eHJjMGhaRzlIcjl5dTQyc09sY3k2RlBiTlBpNkhrVWNnZFI1VVo2UHlVMjQy?=
 =?utf-8?B?UERXVWRmOXkwY1hMVFoyZUI1VmdwWkVVZTFPV2NCREZBZXgxNzU3cmFXNWtx?=
 =?utf-8?B?OVhGMVdka2k2TUlWVmYvRE1aN3lmMFdxMWVnb2pOa3ZydUJ5VmdOMmtXbmEz?=
 =?utf-8?B?d3B4NzV6eVBNU1U2Um52d0pacDlEOHBFakh4V1c4dGdYN0VZRG1uK2Y0UVJv?=
 =?utf-8?B?OEdJc3VMblJvamNDQlRmQjU5QzU5ZzlEOXVFV0Jvd1RLQU1uNENtV2Nma21C?=
 =?utf-8?B?UlR0bW55Nk9TQjNZT0RsUlZzSVFQMVI3NitLbENpZURRVHM2bEYrSkxEaHlE?=
 =?utf-8?B?TyttM2tSeVRNNkROa0thTFNSNmxCWnVKcWw3N080MGZpWWYzRnZWVC9UM1RE?=
 =?utf-8?B?WHFLK3luMng2SXVHaHJmVGRLUjJxQkFpbHVhTGxDNVNqRTB5RDlXQXNDQVJP?=
 =?utf-8?B?cUUzRERORmZVTFd0STBYa04yMGJ5OXYzL0NsbnJNSzQ0OGEvR282WjVHVHEx?=
 =?utf-8?B?NkNPakM2dDVGTWYyeEttUDRRcUcvMGFvV29WWCt3Z29SbjNCc0tUWWdHZU1w?=
 =?utf-8?B?YWtackd5ODlWcFZWcmlyNlhKZkdOUTVBZ0JSRGhIRTk2djdpMVFNYjd0ODd2?=
 =?utf-8?B?cEpLSGxGcWtvUUNsdTlRT3Z2QlJTN0s2cEpGYlM2UUNlSFZyNG5MM1BXdTNB?=
 =?utf-8?B?clFmekg1M0thSmZJK1RCaXVteFBiSjNsWEVxNFZhMEMxaEtad1pDc0V0MDgx?=
 =?utf-8?B?cWN0WGtvSHZzYmxmcUVSbHBJMDVsL2dMbm5KUDkrUTBMTmk4U3pOSDJxd25a?=
 =?utf-8?B?bEdlaWtkUWlHQjZHNDdMT2tCc0Y5MTJWNHZ6NEk1S3pOZ3dwVjMrZE9HVldQ?=
 =?utf-8?B?VXpkLzJtNmtWVkJTbWtBT2ZoWWN6eWtHUm0wMDN4c09jRFlEaE5tMXRNc0Yr?=
 =?utf-8?B?QzdkVmJrTHMyT3E3a1FGdFZpeGhaZm83cjliaXAzRG00Ry8wMjdxYktVVWND?=
 =?utf-8?B?cW94M3BnT1I0bVljVlV1VHZ2L0JrZDNoY1VoeWFVSVR1Y28wd1VEUEpqZnoz?=
 =?utf-8?B?VXhzN2R2Y1VndDlnaFF2QjRaT0VjVTF2K1hBMmxwV0lQTVZNWXQycHVIeDEw?=
 =?utf-8?B?WGpSNVZjUytxcUFwbU95Uit4WGNjakRIOE5TcGNaNU5NQTY2ZlB1UGFjMUhv?=
 =?utf-8?B?N1NqSHAxYTJ2ZG96T1Y0b2pQYk0zQWVDWFN0UEUwWHJiWlN2QVYxK1VEMHFp?=
 =?utf-8?B?RklNMDBrc3k2Z3RwWnlYbGNETUJVcnpZTzlUbjRGUmJDS2VScDIyTmYrZm1Z?=
 =?utf-8?B?S2w0cjl3QTZHR1NjQkFLaWE1cTVDQVlQTUZvc2FneTB5V2ZiRjhQalFHOXFn?=
 =?utf-8?B?UUJ6c0JQc0FrbjFPUVhqVGJTRTFzQkpnTVl5R2tXU0Nwd1g3eko3UnJFdHd6?=
 =?utf-8?B?b0E0U3FtVTdPYnFQRkU4VUxkMVJpdG5SK1RWY3U2c1F3SkNKOFVKWmd2N2w2?=
 =?utf-8?B?MytjZFV3NXVmZTFlU2dWVTk4UWlUQjFsWEhEYmlpc2RLOVdIOGl2R2xyTmdZ?=
 =?utf-8?B?Rm1ZNTM0cVdsckRlRnZUekIrYkpRK3MyOWFsR2o0QWEvN2dXOWxMeWRxdncw?=
 =?utf-8?B?Rno5eGRLS1hVamIxWmtnWk8zeTA1MDFjREZWaTFwL2x2a2ZnclYwZERUdnVS?=
 =?utf-8?B?RU14MVpoWGFCU1V2VnpYZHRvSTBGM1lSYXFqNTMwbVVPNFV2Slo1RWtRLzd2?=
 =?utf-8?B?Z05PbWorQ0pTbkxLY2tOM1VRZUtycllGUmZLcVE3YTFMTDdySDBCR0hYWXJ3?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CE1B1B820999B41AB43D42AB013503D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640fc6b8-99e5-4c64-2cec-08dd549a0c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 06:11:16.1288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AF2MuHzOh3W8r0FDEkA7RplgOwXrimCQMS4juFpQBVJvPakcCu38FodyT3TO1ivCsPROERpZV9/z3AT6lYO5TME1dGcYIyOnJrKjdsdUI6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6994

T24gU2F0LCAyMDI1LTAyLTIyIGF0IDEwOjQ1ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIEZyaSwgRmViIDIxLCAyMDI1IGF0IDAzOjQ4OjMwUE0g
KzA4MDAsIEZyaWRheSBZYW5nIHdyb3RlOg0KPiA+IEJhc2VkIG9uIHRhZzogbmV4dC0yMDI1MDIy
MCwgbGludXgtbmV4dC9tYXN0ZXINCj4gPiANCj4gPiBPbiB0aGUgTWVkaWFUZWsgTVQ4MTg4IFNv
QyBwbGF0Zm9ybSwgd2UgZW5jb3VudGVyZWQgcG93ZXItb2ZmDQo+ID4gZmFpbHVyZXMNCj4gPiBh
bmQgU01JIGJ1cyBoYW5nIGlzc3VlcyBkdXJpbmcgY2FtZXJhIHN0cmVzcyB0ZXN0cy4gVGhlIGlz
c3VlDQo+ID4gYXJpc2VzDQo+ID4gYmVjYXVzZSBidXMgZ2xpdGNoZXMgYXJlIHNvbWV0aW1lcyBw
cm9kdWNlZCB3aGVuIE1UQ01PUyBwb3dlcnMgb24NCj4gPiBvcg0KPiA+IG9mZi4gV2hpbGUgdGhp
cyBpcyBmYWlybHkgbm9ybWFsLCB0aGUgc29mdHdhcmUgbXVzdCBoYW5kbGUgdGhlc2UNCj4gPiBn
bGl0Y2hlcyB0byBhdm9pZCBtaXN0YWtpbmcgdGhlbSBmb3IgdHJhbnNhY3Rpb24gc2lnbmFscy4g
V2hhdCdzDQo+ID4gbW9yZSwgdGhpcyBpc3N1ZSBlbWVyZ2VkIG9ubHkgYWZ0ZXIgdGhlIGluaXRp
YWwgdXBzdHJlYW1pbmcgb2YgU01JDQo+ID4gZHJpdmVyLg0KPiA+IA0KPiA+IFRoZSBzb2Z0d2Fy
ZSBzb2x1dGlvbnMgY2FuIGJlIHN1bW1hcml6ZWQgYXMgZm9sbG93czoNCj4gPiANCj4gPiAxLiBV
c2UgQ0xBTVAgdG8gZGlzYWJsZSB0aGUgU01JIHN1Yi1jb21tb24gcG9ydCBhZnRlciB0dXJuaW5n
IG9mZg0KPiA+IHRoZQ0KPiA+ICAgIExBUkIgQ0cgYW5kIGJlZm9yZSB0dXJuaW5nIG9mZiB0aGUg
TEFSQiBNVENNT1MuDQo+ID4gMi4gVXNlIENMQU1QIHRvIGRpc2FibGUvZW5hYmxlIHRoZSBTTUkg
c3ViLWNvbW1vbiBwb3J0Lg0KPiA+IDMuIEltcGxlbWVudCBhbiBBWEkgcmVzZXQgZm9yIFNNSSBM
QVJCcy4NCj4gPiANCj4gPiBDaGFuZ2VzIHY0Og0KPiA+IC0gVXNlICdkZXZtX3Jlc2V0X2NvbnRy
b2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZScgaW5zdGVhZCBvZg0KPiA+ICAgJ2Rldm1fcmVzZXRf
Y29udHJvbF9nZXQnLg0KPiA+IA0KPiA+IHYzOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvMjAyNTAxMjEwNjQ5MzQuMTM0ODItMi0NCj4gDQo+IFRoYXQncyBub3QgYSB2YWxpZCBs
aW5rLiBGaXggeW91ciBlbWFpbCBjbGllbnQuDQo+IA0KDQpTb3JyeSBmb3IgdGhlIGluY29udmVu
aWVuY2UuIFRoZSBXZWIgbGluayBpcyBxdWl0ZSBsb25nLCBzbyBJIGhhdmUNCnNwbGl0IGl0IGlu
dG8gdHdvIGxpbmVzLiBQbGVhc2UgY29weSB0aGUgZW50aXJlIGxpbmsgYW5kIHBhc3RlIGl0IGlu
dG8NCnRoZSBicm93c2VyLCBpdCBzaG9sdWxkIHdvcmsuIA0KDQoNCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCj4gDQo=

