Return-Path: <linux-kernel+bounces-335486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1652E97E65E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C9FDB20CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F7FF9D4;
	Mon, 23 Sep 2024 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e4XhddUd";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PBIou466"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A387210F9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727075255; cv=fail; b=WigtKRt7WGLQRah1VmamLQdDtgF6zjB6KgJ+lZJgpDrSyDbwQXITE60gkbx6CbOY/rhZGuvTDEhEqIFIWAyI/zRi2zdFG92uqaooj/z7hn9Ab5u9hO/r1lIll+qLoRaxCZpmJQ+GDR6oTxUBLZxKGmQ+vmoqzV1tFObE/vCd3oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727075255; c=relaxed/simple;
	bh=+P42mEeGwIZjkTn4M38Qe35dvR45/VRxmWqkYioONHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BkbFm3YX7KB21XbmUSi1Dc47DNfpxlVBoEbn1aSn7fGeBicYH4AMMV9lTu2q88mVV/lFtzegBhukd8ym7gGdpsRqdmGOKYnxPHEFqE/XtutCIbbiHRFlLxFw2hn5HQG4DBR43u80L8lYYZfBYu9qxe3DNH+5F1PmzzNdV1g7Cyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=e4XhddUd; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=PBIou466; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7e059f84797a11efb66947d174671e26-20240923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+P42mEeGwIZjkTn4M38Qe35dvR45/VRxmWqkYioONHI=;
	b=e4XhddUda0QSyGa+KynpRwL0BO4dqSVFo99nVKZdyPextIt7WlQxcezLCcWuopMXgpQq6IMzH99X3U8UKjFkc+LrDECt8e76ZStjXM4Dt/MjWpAUytKw0pXGTvq1sqKrNDvKQTLlQcIx8qsfbhgBwsLAspp6CBFb5IuKB9KuYPw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f86fe2f8-238e-4f9c-81e2-ac21d1a82232,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:c676689e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7e059f84797a11efb66947d174671e26-20240923
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 690526881; Mon, 23 Sep 2024 15:07:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Sep 2024 15:07:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Sep 2024 15:07:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHaFeKta4ywtZ1axRvqHU1HabEI6BDRxXzCPPymfMaPAMIj7YwwRbRwAZHW8w/vieEJcX5r2X1O5bj43kVD/2fJ+MhrDxQJj229mncFNIw3GzpUyKJv+B3M5WXpQptmW6c5Vl+xoIViU53Vddw4SX4XbnZUkudYRLrEigEHnL+nDVvigEjX+QXOy4aWb8UpvPRYqGZBFVzE97TTMO2J7v3R6fbWgy+ZR496MZrxBxADha3av3ni85mCrc9M0EQojjmjh8/CChCF6T4iO6eQTSKzTOll8KeJF5oE1cNfKWWlyYEuixQMCsyv4HZKq4mx8Cqn6VMhGqMXVKGuAtUgp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P42mEeGwIZjkTn4M38Qe35dvR45/VRxmWqkYioONHI=;
 b=DNXtsJOELzjMF3xxHPLol2YGUEIV/1Fs9ulmEsVDcggMB3w26q2kvYvmUvjGngTy5dseOe/6gyTGaKG1icOrq6x1dgPFG2EmgayXePEzH4g9TqPILUxt8EXFOijUEp890cnjIrbDR6icK285wvcSXeE7lemMbjBLV03J69OgxLsmcdnFlz7D7D2IWnSrpIwqDTr2iqczZLJwaBBDHrZMeS9s2C2Du4U/JrX5G2Vqn5p0VrFaQqjMRNWKy3sRO1iijbZbgA83Kg+pXPOH0Jr3gdp7XLoTrWokpe1x8ir3vx5G2q39pXWkSiT4dhmDc4+0mO8QChO5RvwV3nftoamOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P42mEeGwIZjkTn4M38Qe35dvR45/VRxmWqkYioONHI=;
 b=PBIou466gbHXk/4OBlSTo5tFw25rXn9Zeu5jwJWDHO7wE9vx20N1UfS6VoP3tahhCGiIgjrWAN22fgQgZ1pKsZDV7KASYFJeS/Ymbz5/80x/TMmfNsn1AqyFfPDXkzyY24HgJW7fWXaMG/j/2GmaA4LiiQgcVNWyVWBLogy8KxM=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB8470.apcprd03.prod.outlook.com (2603:1096:101:220::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Mon, 23 Sep
 2024 07:07:22 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7939.022; Mon, 23 Sep 2024
 07:07:21 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] drm/mediatek: ovl: Add fmt_convert function pointer to
 driver data
Thread-Topic: [PATCH v3] drm/mediatek: ovl: Add fmt_convert function pointer
 to driver data
Thread-Index: AQHbCSDsdROuc4ZWnUKlOufOwI/zzrJkxXgAgAA2vAA=
Date: Mon, 23 Sep 2024 07:07:21 +0000
Message-ID: <09a9180341b0d4898dd8185038aecdea4b147522.camel@mediatek.com>
References: <20240917164434.17794-1-jason-jh.lin@mediatek.com>
	 <d59c3b6a965daf22750be79b0f74703c216ec44a.camel@mediatek.com>
In-Reply-To: <d59c3b6a965daf22750be79b0f74703c216ec44a.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB8470:EE_
x-ms-office365-filtering-correlation-id: 31533412-6376-4cc1-c7fd-08dcdb9e5e73
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S0VhN2htZjM3dTZJQ01IVmEvUHA1VXFYaGNsSkNneFFwa3Z1a0toUkdrUDFh?=
 =?utf-8?B?QklxeEhuNktiRk5Xc0VNOTRQempVd2g0YnRVUm1XUGd3b1B6S2ZuRUl0K2hS?=
 =?utf-8?B?ZFFESCtyTWw1SjVSYlhhKy9nVVowTEluTUsvdndGK1dYZ0tsdFVOSVlqR1k0?=
 =?utf-8?B?WUIxNWN0NWNSR3FicHhudURUMURHOXNiLzU1WE5WcWRNRW5kZVZOeTJwUDNh?=
 =?utf-8?B?MTZXS0FJbERkcU41MXU2RkVPWU5Yc3p0aEQ1bkNSWlRkeGpSYmx6RGV2N21O?=
 =?utf-8?B?OVhQOHNNRW40L3JaV0tpdFFzWWQ2bjdubHhDSkUrd2xCSVdiMTBRUU1HN2xH?=
 =?utf-8?B?eWFUL2Ewclo5Y3hQT2NRdkVLRWs4NzVhejk4TXJhNUVyWWNkQktBTUZMTGNj?=
 =?utf-8?B?a1FQS1hWNEhKc2d1b2hkTFNVSjNxZVJDaEIxVHMwN3VNblhFbHFZcUdmSjI5?=
 =?utf-8?B?cVVNcjlvT1ZKWEkreTduUDJEbjQ4N0psbXp0Z0EwL0R6Q0c0Wk5SajBKczR4?=
 =?utf-8?B?T0ZYRmNrZk9aUUhYV0FYd3dYVGxDejNTcUlnVXNwRzRLVlVNV1VYdm1qVHRj?=
 =?utf-8?B?RzRFajAySzQweWxsRGNuMTZGZENHdHJURTJGcGJnZzNMVmhFSlcyWnV1QTFN?=
 =?utf-8?B?MFFpODVrMFpVNnNoUkhucVlLV0hNT0J5TVV5djZEWXNvM1RhajVGU1NBOGdK?=
 =?utf-8?B?NTJRMjVnKzFNd0lxVmVsRk9INGZrRWRETHE3VkNpTnYrZ0pxblRmNWltQ1gv?=
 =?utf-8?B?WmdmcjhQQXM0NjlsVFA2dGtFUms0TnI0SVBVY3R6QTRCM0x0Q3NzRFpUOSta?=
 =?utf-8?B?NDNCZHJKVEplTXNlWk1yMnBRcGNIbElnck1YTGN1c1dlYVc4N0RDSTl4VFc4?=
 =?utf-8?B?amExSUd4ZC92NGxkcUJKVi9nbCtMWjVjMmpkWUlLTGQwOFpHRjI2dm1yOEMx?=
 =?utf-8?B?b3Bza2k0MmE3dm5NS1k3eGxkRy9abXkyWUFCcFRWMkt1RnkzR1IrK2w5c3BZ?=
 =?utf-8?B?QkN6WFpJWDIzcHNYYmVYd3JZdUlGazNCUjA5UG9qSDRORmhoaUtOb3h1Z3J1?=
 =?utf-8?B?aVlsY1NjZFBjMnhHbmtJaTJsRDZMK2pxQmpvOENvczg1ZzNzbzRCMkZ4eU9K?=
 =?utf-8?B?bFlIVDRQWUVJZXU4S1VjM0NacTJpaURtUEx0VHd4WDkzZGo5V2FCd1pVUkR2?=
 =?utf-8?B?RTdMTEFvU0c0UEN0a3ZkNlVtV1BscjVWVU82M05NUlkrYlFZK0Zncmt3QW5R?=
 =?utf-8?B?Ui8vazRTR1diWXV6OGhybnhiNnN6dTZTWGFqcGZxaU9HazIvR3NnYnNURkh3?=
 =?utf-8?B?WkdjMXJUNUYzRk90eTk4UWw3N2dveWp5dGxDV3pkbU14anBuUTJEVFpEdWwx?=
 =?utf-8?B?VkdDQ1VYOUJJUUlRTGNVUzBFbmJkYkNFRHg3aTdIV21DQU1CODVpellVQ0E4?=
 =?utf-8?B?RkJzVmdJYktJeFlEa3dJcG9EanAvM2J2SExnZ0hjbUFIOXJ5MmJCMjlaNUdB?=
 =?utf-8?B?SWZyQkVaK3JSalBiWXh0RXo2V0RydWRkTDY2dWhjYXhyZy9QMUMyRHJCdndV?=
 =?utf-8?B?L0sxOEVTQlk2cS9waXI2a2FLU0Yrd1c0OHcvNHFIRXdSY0wweHNuYkdraWhQ?=
 =?utf-8?B?YVRkVXNnK0Mya0J2NUtUU0JjQ3NmRjUyNUVWU3g5WEM5amZnbWl4SzVVZi9O?=
 =?utf-8?B?Y0NJV2h4V1EyQiszbjFkODdsQ29ucnpWY3Y2bVFCeW1RR2dYVHZwNXkzNmZJ?=
 =?utf-8?B?djRRMTdqRDg0SHp1NGh2bVZSZXo1am1sbXQra2RSQVhMQTIzZ3dyMTdzWEk1?=
 =?utf-8?B?T1JURGVZdUZ2Vzl4VkxmUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU8wdFM3dE1hRVdmR0wwYUxtSG5SUHZDbmpCVHFLNHFvZ1FoSTBsSVIrWnh6?=
 =?utf-8?B?LzlOa0x6YVI3ZEZSdWxBYnhmZlVDU2ZmeFhzZDNidzM0MUhlbThOYVJFYnZG?=
 =?utf-8?B?WlRQTnY5TlRUYSttZjhWMXR2VHQvaWJhUFJHUk1NdStndzdxUnpWSmRDQnlr?=
 =?utf-8?B?eFY2SHRrNTk3NnpzQ3U1SjVTTTJyaTB3cHpET3hlMWY2anNpT3UxbDQ3SGlk?=
 =?utf-8?B?cXdFM3dQNXo4VzNDb3NKMjJ5T3kzaUhSTVFvMEE4VTBxWlloRHNkN3F4U1BV?=
 =?utf-8?B?Q2xTS1hLZjZoLzdBWGYwSkRSQjVmRUtwa3YycGpVWnEvUGJLRldZaTlYejRT?=
 =?utf-8?B?ZDRrNStiejViMzFCN1Q4YmlKQXJjamcwTGtKM2ovZHRKOVl3VHNTLytZYThm?=
 =?utf-8?B?NkRFaS9RQ0twTy9PWUZJRkpnT0pJZmxBRFBzbHNLSkY4T1B0TktxL1ZDNE5Z?=
 =?utf-8?B?U1hYZkIweDNKbjRCRmpsSS9wSzZPL0MramU4K0d0YXg2YnV6NWxXamUxV29N?=
 =?utf-8?B?d04wUmRtN1ZUSEFqOSsvcFdjdmtKRmNHMDkxaTU3QXoyemhVREpJMllLRUxI?=
 =?utf-8?B?VHNGYlQyMjZIYll6Mzl5UmQ0eG92cW1rcVZheWh1NFZUcGNtZ2dLYWNZZks3?=
 =?utf-8?B?cXZHQktLUzZ0eGtJaVZLMzhVclR4NFVWNGNrTnR6SDkwS3JueG5laHdrL1BJ?=
 =?utf-8?B?SFUrZ0srMFlsRmpRcGIzUUhEbmJkUWpHcVc5NDkza1hybGVZaStVY0dGT3Fj?=
 =?utf-8?B?NEpKNld3NGhYQzM2eUt2NWZBaktQOExWQlArbFZWT0g5OEdXTGpyOUF3M3la?=
 =?utf-8?B?YzFPeHBLQ0RUQkV2dlNFZzBHT0NPNWJlQVlQR0Y5Z2c1Yy9TcjZZcjZhVGdQ?=
 =?utf-8?B?OGU2VDl4MnB1aGd2UVEzaVVoeExRVWdFTGlNWEJ5MVdzVmxNaTdoUERubTRQ?=
 =?utf-8?B?ZGFFVW5BTjNYMkZRd0QrVXJud3hBY1kyUkttMDZhQ0pXcU55QjVlM08xanZY?=
 =?utf-8?B?ZG1PdDZ6MlBjc25sblduNm5EZXBXTEcxT0VkYmYzRlBvZXprckZzS2V1NTV1?=
 =?utf-8?B?REpBa3V0bGdyQjhDMUttU1plWnovak5taytRbEliZGxaWGloVFJpaWUzVmpQ?=
 =?utf-8?B?bER2MGdNQko4MXNWR3g2TVZKWW9OeWI5UDRGU3BVQjZYcHpzQXdTR21ETXZN?=
 =?utf-8?B?dmJnUG1yZkMzQ2Z0YVhpTmwrUUhCSkEzQ0tDNk54Q0VxeUdTQm56WTllRnYv?=
 =?utf-8?B?QlNYZDgzSE5oZ0dlbGtUZkJCY21YS2JmQlY0U2NxZUF6NHIyTWdwbzc3TkFm?=
 =?utf-8?B?SFRVaFNqM1RtVk5YWTV1VFF3U3dzY2NTcmUvSkVmUG1CZC9zVm1lWFpNa2Ex?=
 =?utf-8?B?Yk1hczg4WFMzc2xYbWlOV3FKMTQ5d3F1VHJTVFcyV2kwa2k0U3MxVHFYY0xz?=
 =?utf-8?B?SnVnK2xCMGhSUlh3Z2s2d0M0L3prUUhlUVkvZlVnWWJHZTlROWlvR01VeG5t?=
 =?utf-8?B?K1JtVmxROHEvVmdiMU9zV3lKNVYrdWlRS0VQWDBmOWVyWkxodUlDOXhIWHFy?=
 =?utf-8?B?MTNMZ1hRb0JuQ1BMQm9WTFQ1WDIxOFlhdXVpZmlidnRWTUdrSzlKdDZZczJn?=
 =?utf-8?B?d0h5NkFXSlRFZ0NxSnJFL3dsalRJa2s1aFkySzNlSGpUclZualBDdnd5VFVw?=
 =?utf-8?B?MVFsSG9FbDQycFI0SUNSckZCcDB3bGFONmpuSm9PTC9iMitmclVvd3diSWUy?=
 =?utf-8?B?bmNvd0FDdndhZThmcEpiVDZYUmptaXhYU3lmeVBsMFNWaGtKNkF0djYrWkZx?=
 =?utf-8?B?bThvWUowSk0vVHE5WHdtUXpaYnJXYkpTUHMzampGMWZiTC9HM3JLZGJjeDZx?=
 =?utf-8?B?bGJ2UG1OeG8yTHdDdlFmcDdER0JjSFYxRDhFMUZOVXp3WHg4cEcvNGp6MXNW?=
 =?utf-8?B?V1hnMUliMjRnc28wL3N0SVVzYmZEYitQWGxSK1F5aXB0R1FlY1hWekdrdEpX?=
 =?utf-8?B?STNaN1Y4WDZyTElNR1NvWVpYQ21JV0ZGQUlMSlVPaWlMV1JXWDN4Y2JrSnF3?=
 =?utf-8?B?aWZ2VlF0Y0pKa0dwbEJ6OVNpUTdqQklzbENMcjRMUTlUb1E0c2w5NkJINVVI?=
 =?utf-8?B?cUxjVlBIL3JLdVdSWUJGaHBGZDVnRmJscklsamZDbi9YWkVJbEp1Z202cUhJ?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B4C999BDCB9A44A9A83961C2E2B1653@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31533412-6376-4cc1-c7fd-08dcdb9e5e73
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 07:07:21.5171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqbbBND9Q8lm+d189tMNQP/iZl+I2nqKPt96mG8QoWhs74/kL9gj+1bbVpqrAvvj4V5jhmZMjHxxbZbSUzTIU1UoyYJfN0cz/eFl6fRnpgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8470
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.661500-8.000000
X-TMASE-MatchedRID: u7Yf2n7Ca/34OiVTWoD8RCa1MaKuob8Pt3aeg7g/usCe9toQ6h6LE3/s
	DLdkieHy5JxUCI8WLKUS/JVm5D0BLHy3NtgjFBPrL3ulviDkcK2BHKTJ+sfXGWd6vNuG6CqyGU3
	GI9BKWefy8x2vJ69vL82bnZOlsU3s0x3/HP06C9wD2WXLXdz+AQrefVId6fzVCqIJhrrDy29HdE
	c8dOyw1fIjcUeQ/unplHJpPX3ZHleyRDt3x3st95X2EdBJA/laU+A7YkpDJ1htw+n+iKWyyLwvU
	FdZPHgIJANp74tHBqf9/GE3EFkz59qbFWzFHuZXXP5rFAucBUF9LQinZ4QefKU8D0b0qFy9mTDw
	p0zM3zoqtq5d3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.661500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	FE54ECB786267C30F64A20B728233BB99D0F67002E8CFF3A1D4F46399D4681762000:8

T24gTW9uLCAyMDI0LTA5LTIzIGF0IDAzOjUxICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gV2VkLCAyMDI0LTA5LTE4IGF0IDAwOjQ0ICswODAw
LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gT1ZMX0NPTl9DTFJGTVRfTUFOIGlzIGEgY29uZmln
dXJhdGlvbiBmb3IgZXh0ZW5kaW5nIGNvbG9yIGZvcm1hdA0KPiA+IHNldHRpbmdzIG9mIERJU1Bf
UkVHX09WTF9DT04obikuDQo+ID4gSXQgd2lsbCBjaGFuZ2Ugc29tZSBvZiB0aGUgb3JpZ2luYWwg
Y29sb3IgZm9ybWF0IHNldHRpbmdzLg0KPiA+IA0KPiA+IFRha2UgdGhlIHNldHRpbmdzIG9mICgz
IDw8IDEyKSBmb3IgZXhhbXBsZS4NCj4gPiAtIElmIE9WTF9DT05fQ0xSRk1UX01BTiA9IDAgbWVh
bnMgT1ZMX0NPTl9DTFJGTVRfUkdCQTg4ODguDQo+ID4gLSBJZiBPVkxfQ09OX0NMUkZNVF9NQU4g
PSAxIG1lYW5zIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OC4NCj4gPiANCj4gPiBTaW5jZSBPVkxf
Q09OX0NMUkZNVF9NQU4gaXMgbm90IHN1cHBvcnRlZCBvbiBwcmV2aW91cyBTb0NzLA0KPiA+IEl0
IGJyZWFrcyB0aGUgT1ZMIGNvbG9yIGZvcm1hdCBzZXR0aW5nIG9mIE1UODE3My4NCj4gPiANCj4g
PiBUaGVyZWZvcmUsIHRoZSBmbXRfY29udmVydCBmdW5jdGlvbiBwb2ludGVyIGlzIGFkZGVkIHRv
IHRoZSBkcml2ZXINCj4gPiBkYXRhDQo+ID4gYW5kIG10a19vdmxfZm10X2NvbnZlcnRfd2l0aF9i
bGVuZCBpcyBpbXBsZW1lbnRlZCBmb3IgTVQ4MTkyIGFuZA0KPiA+IE1UODE5NQ0KPiA+IHRoYXQg
c3VwcG9ydCBPVkxfQ09OX0NMUkZNVF9NQU4sIGFuZCBtdGtfb3ZsX2ZtdF9jb252ZXJ0IGlzDQo+
ID4gaW1wbGVtZW50ZWQNCj4gPiBmb3Igb3RoZXIgU29DcyB0aGF0IGRvIG5vdCBzdXBwb3J0IGl0
IHRvIHNvbHZlIHRoZSBkZWdyYWRhdGlvbg0KPiA+IHByb2JsZW0uDQo+ID4gDQo+ID4gRml4ZXM6
IGEzZjdmN2VmNGJmZSAoImRybS9tZWRpYXRlazogU3VwcG9ydCAiUHJlLW11bHRpcGxpZWQiDQo+
ID4gYmxlbmRpbmcgaW4gT1ZMIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGph
c29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gVGVzdGVkLWJ5OiBBbHBlciBOZWJpIFlhc2Fr
IDxhbHBlcm5lYml5YXNha0BnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyB8IDYzDQo+ID4gKysrKysrKysrKysrKysrKysrKysr
Ky0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMN
Cj4gPiBpbmRleCA4OWI0MzlkY2YzYTYuLjQ5NDhmMjY5ZmI4MSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBAQCAtMTQzLDYgKzE0Myw3IEBA
IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YSB7DQo+ID4gIAl1bnNpZ25lZCBpbnQgYWRkcjsNCj4g
PiAgCXVuc2lnbmVkIGludCBnbWNfYml0czsNCj4gPiAgCXVuc2lnbmVkIGludCBsYXllcl9ucjsN
Cj4gPiArCXVuc2lnbmVkIGludCAoKmZtdF9jb252ZXJ0KShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdA0KPiA+IG10a19wbGFuZV9zdGF0ZSAqc3RhdGUpOw0KPiA+ICAJYm9vbCBmbXRfcmdiNTY1
X2lzXzA7DQo+ID4gIAlib29sIHNtaV9pZF9lbjsNCj4gPiAgCWJvb2wgc3VwcG9ydHNfYWZiYzsN
Cj4gPiBAQCAtMzg2LDEzICszODcsNTQgQEAgdm9pZCBtdGtfb3ZsX2xheWVyX29mZihzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+ID4gdW5zaWduZWQgaW50IGlkeCwNCj4gPiAgCQkgICAgICBESVNQX1JF
R19PVkxfUkRNQV9DVFJMKGlkeCkpOw0KPiA+ICB9DQo+ID4gIA0KPiA+IC1zdGF0aWMgdW5zaWdu
ZWQgaW50IG92bF9mbXRfY29udmVydChzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsDQo+ID4gdW5z
aWduZWQgaW50IGZtdCwNCj4gPiAtCQkJCSAgICB1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSkNCj4g
PiArc3RhdGljIHVuc2lnbmVkIGludCBtdGtfb3ZsX2ZtdF9jb252ZXJ0KHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0DQo+ID4gbXRrX3BsYW5lX3N0YXRlICpzdGF0ZSkNCj4gPiAgew0KPiA+IC0J
LyogVGhlIHJldHVybiB2YWx1ZSBpbiBzd2l0Y2ggIk1FTV9NT0RFX0lOUFVUX0ZPUk1BVF9YWFgi
DQo+ID4gLQkgKiBpcyBkZWZpbmVkIGluIG1lZGlhdGVrIEhXIGRhdGEgc2hlZXQuDQo+ID4gLQkg
KiBUaGUgYWxwaGFiZXQgb3JkZXIgaW4gWFhYIGlzIG5vIHJlbGF0aW9uIHRvIGRhdGENCj4gPiAt
CSAqIGFycmFuZ2VtZW50IGluIG1lbW9yeS4NCj4gPiArCXN0cnVjdCBtdGtfZGlzcF9vdmwgKm92
bCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsJdW5zaWduZWQgaW50IGZtdCA9IHN0YXRl
LT5wZW5kaW5nLmZvcm1hdDsNCj4gPiArDQo+ID4gKwlzd2l0Y2ggKGZtdCkgew0KPiA+ICsJZGVm
YXVsdDoNCj4gPiArCWNhc2UgRFJNX0ZPUk1BVF9SR0I1NjU6DQo+ID4gKwkJcmV0dXJuIE9WTF9D
T05fQ0xSRk1UX1JHQjU2NShvdmwpOw0KPiA+ICsJY2FzZSBEUk1fRk9STUFUX0JHUjU2NToNCj4g
PiArCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfUkdCNTY1KG92bCkgfCBPVkxfQ09OX0JZVEVfU1dB
UDsNCj4gPiArCWNhc2UgRFJNX0ZPUk1BVF9SR0I4ODg6DQo+ID4gKwkJcmV0dXJuIE9WTF9DT05f
Q0xSRk1UX1JHQjg4OChvdmwpOw0KPiA+ICsJY2FzZSBEUk1fRk9STUFUX0JHUjg4ODoNCj4gPiAr
CQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfUkdCODg4KG92bCkgfCBPVkxfQ09OX0JZVEVfU1dBUDsN
Cj4gPiArCWNhc2UgRFJNX0ZPUk1BVF9SR0JYODg4ODoNCj4gPiArCWNhc2UgRFJNX0ZPUk1BVF9S
R0JBODg4ODoNCj4gPiArCWNhc2UgRFJNX0ZPUk1BVF9SR0JYMTAxMDEwMjoNCj4gPiArCWNhc2Ug
RFJNX0ZPUk1BVF9SR0JBMTAxMDEwMjoNCj4gPiArCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfUkdC
QTg4ODg7DQo+IA0KPiBDb21wYXJpbmcgbXRrX292bF9mbXRfY29udmVydCgpIHdpdGgNCj4gbXRr
X292bF9mbXRfY29udmVydF93aXRoX2JsZW5kKCksIHNvbWUgcGl4ZWwgZm9ybWF0cyBhcmUgc3Vw
cG9ydGVkLA0KPiBzdWNoIGFzIEJHUkE4ODg4Lg0KPiBCdXQgaW4ga2VybmVsIHY2LjEwLCB0aGVz
ZSBmb3JtYXRzIGFyZSBzdXBwb3J0ZWQuDQo+IElzIHRoZSBjb2RlIHdyb25nIGluIHY2LjEwPw0K
PiANCg0KWWVzLCBJIGxvc3QgdGhvc2UgcGFydHMuLi4NCg0KSSdsbCBhZGQgdGhlIGNhc2VzOg0K
DQpjYXNlIEJHUlg4ODg4Og0KY2FzZSBCR1JBODg4ODoNCmNhc2UgQkdSWDEwMTAxMDI6DQpjYXNl
IEJHUkExMDEwMTAyOg0KICAgIHJldHVybiBPVkxfQ09OX0NMUkZNVF9CR1JBODg4ODsNCg0KYW5k
IHNlbmQgdGhlIHY0IHNvb24uDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBSZWdhcmRz
LA0KPiBDSw0K

