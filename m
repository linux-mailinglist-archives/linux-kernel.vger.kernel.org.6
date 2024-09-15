Return-Path: <linux-kernel+bounces-329909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C28979756
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10743281CB7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F91C9848;
	Sun, 15 Sep 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ri6Gnfwm";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="brAADTaT"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487E1C7B65
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412175; cv=fail; b=IjH5Y6FF3WeArstOkNUGTn7SO9RN3CBw8zBpp9nca/moT1kC/2GUoJrQtVtV/xtKDr7sKQdgFZj6e9RFfkmREhKay6gN/SxvGR36s0d2/an4TksgxqffkZJ8TV2jEHNQFSGn4PHmOPAjhP3wNUXsDFphgWShtAh9JAjL6UKTbIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412175; c=relaxed/simple;
	bh=aG02h23OiCM7iE6kpBhZuwZmMQn8maibJrMqcAo9BVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tn0BnbHKMXnJ1JQFso4NDDL98RsWcDKwhgk3HQY+FBQWGdsBRUmKAsNf4b5rLWR7m1znIoV2H5q1MxGPjLshVHmuytV8nkLT0mEkO8kFIPENGBxaPFpXhF/jQlE+pjhJqaNA8hYedtg+hDHQi1liJK5otDSk1CWgBbCfqZeZrN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ri6Gnfwm; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=brAADTaT; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a2e94502737211ef8b96093e013ec31c-20240915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=aG02h23OiCM7iE6kpBhZuwZmMQn8maibJrMqcAo9BVg=;
	b=Ri6GnfwmPZfWcSasy4vGLce/MPMKwzfveFlm77jvmLNG4FX2soJ1M+DxhJ2k5bBr6uBJIgt5apvCR820B9WN8Z8IFYSs6EY5zP8iU67xeK3UYiQ8XgipvcNJoj6BZ2iMOrvBls+kMSM9Ve4Zch8ktVWODoD8vVNQkHD9foxd9U8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:e3fbd4a4-053f-4925-846d-36b02388fc75,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:6dc6a47,CLOUDID:41363dd0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a2e94502737211ef8b96093e013ec31c-20240915
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2088465859; Sun, 15 Sep 2024 22:56:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 15 Sep 2024 22:56:05 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 15 Sep 2024 22:56:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYQ9orW8Fi8kJDYl+Hr1+vbvJKz4r42jrPnzdroS+FgrAWtLF5ZyGHYKbe8dXEJGuptW1GwNRGIHjPNQJdRLtGUcdQiXVG6Jrmu10Dc5LyQotJDNQI9iFtB+hokrtYTKGmDKxIPijgD+wM0zC65FoTTfwn7Ao4GjR+ww8Fw81TXzhnx0P83j3mAABQbsZZ2gmu3XZdZTnhpkGQNKrpI5ObITI6z/cAY4/j8h/9CPhHfdsPNHa6wdg+RsaudYrtElN8rZeUmT5Wma12vSE29QiPi11MaBHcBMKtHR3FoGeYFVgXNW8bVkjlEH7tpmhCopbpWQRq09NtuIrRnVr+p/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG02h23OiCM7iE6kpBhZuwZmMQn8maibJrMqcAo9BVg=;
 b=Qt0nSSWI3aFo4043fOTJ7se0H3qT0pkK1kzTKadFfWN0SeDaR9s08UNH0HdtdZUgAVncU390HvzfnhWGa0NyVOIrO9b8tIn+UCkbQccWkoNKcfCkoAjQO6XZVs8N6Z/80QeTuv7tj+MXNgvGfcst7dtY2slpZ14x0jps3R9NakDK0oKYBzP0iWUCSElxR38hIDIb/D4g1UoOazpBMI5elf0vh3ryqv9dRMFY9D2piMSyjW29INds2AMkkguUU1Rg9k5VYYieq4v0980IC6N9mLyIAa2lXM3g4Q8HI1Hv/X8Y2K/RgUDnZeQDdLoIxsTCjsSxd1rIr+Dikl2ront9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG02h23OiCM7iE6kpBhZuwZmMQn8maibJrMqcAo9BVg=;
 b=brAADTaTALOPkzP145ugaE/CAzQbGhHfbrlm7rtQFBBSnG+HxybfI5ydUP/JAtlsv5lLEFfL2+GKF+3M65/MXoVYcsXRW7C/KJzuAiTW3JjMaqTTbhcCdljSlDKqhUTTct58Nl/iPokyXKCHGG6YMuub2z7uYwX2EdvFFAa9x9s=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB7603.apcprd03.prod.outlook.com (2603:1096:400:424::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Sun, 15 Sep
 2024 14:56:02 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7939.022; Sun, 15 Sep 2024
 14:56:02 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm/mediatek: ovl: Add fmt_support_man for MT8192 and
 MT8195
Thread-Topic: [PATCH] drm/mediatek: ovl: Add fmt_support_man for MT8192 and
 MT8195
Thread-Index: AQHbBuNDcX8t2xL/w0KKblb8EZpDN7JYraOAgABDWIA=
Date: Sun, 15 Sep 2024 14:56:02 +0000
Message-ID: <dfe83cde23f263f4d791da093c5655f10d56577a.camel@mediatek.com>
References: <20240914201819.3357-1-jason-jh.lin@mediatek.com>
	 <c8f8d556-77bf-4b60-abd9-bfcf7ac40ac5@gmail.com>
In-Reply-To: <c8f8d556-77bf-4b60-abd9-bfcf7ac40ac5@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB7603:EE_
x-ms-office365-filtering-correlation-id: 38b0618f-f7c1-4dfa-17bd-08dcd596848c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S2VoUUQ2VG1xWFVNcXFOMHdIbEJFTHdDbTBiT2FmODdnVnY5d1dLUmF2dGZR?=
 =?utf-8?B?THdIMllEdnU2SCtOTVd2dys1bzFMd05sdlQ3MDRPWDVWTlZuZVhnVmoyZFNz?=
 =?utf-8?B?ZnBqWGp2bEpleGlMakk4SFozaG8wSTBlQ2Z4SitlNlpzckpsYkdPci96V1FE?=
 =?utf-8?B?a2ZRc0JRaE1KQ2tOZlFEQm4wL1Q3UFJIeURJSW4yUnBSV1dVKzE4OVVZd3Yy?=
 =?utf-8?B?c205REFOVnBBRWhCSURqRStqZFJPZzViQmxwM1ZIZzJZckRGWWtucGNoZ3Ez?=
 =?utf-8?B?M3dPbXJKR1MxSzRBWENjbWs0QlhTa2FiSjJnM29uWVhQMnh4OEZPSW9oQUZi?=
 =?utf-8?B?V2ZkYzNwd0RHUG4vektZOG5NNXNBRVlETHJUT2VZcVdIbEM4WURjSWlSYTc0?=
 =?utf-8?B?dEljMG5zR2ZFQnVGU28yeEswcFNxYzl4Y0VTZ2pGY28vek83bmJkNWVFekFR?=
 =?utf-8?B?R0JaYnVBQjB5VUU5VDQxS3ZMb2hzSnpDenNBM3hIT3hnSHVRR3loYjdFT3BV?=
 =?utf-8?B?blV0Tk9jaUN3a0h0dkFjU0FaQkdHNlJGNTZLNGU4cjFKZG11TGtZZnNIalM3?=
 =?utf-8?B?c2R5ZlpxRWt5aEJXRW1aVjJvSmxlZStFY0YxQ1dWZUNMbVJONGhGSklBMy9H?=
 =?utf-8?B?Tmx1NUNSZzBxd1dUL2hBbGpINDEvVE94SnpwM0haS3pHZEJOelFUbW12ZUp6?=
 =?utf-8?B?dWZSWi9hSkkrVTRycDZYdHN0RWlXdnJmZGh2VW1BbkFCVnM3TUxCVUhKWFZq?=
 =?utf-8?B?VFRlNVpvUWFZQUVVQ3dPU3hQNkFmai9hRkQ0aml1S1RYblFGOWJmNE9sWVRt?=
 =?utf-8?B?NkZpR1AwMTZrN1B1dCtVOUpTM3pycmlZaWZWUVFRQWlGZnhsYkZiUzROM3JN?=
 =?utf-8?B?eTVYckFaU0w4aFB3UzRqdHAxeFhGbjY1dU5teTFXRHF6ZERyb3VJdFY2UjJL?=
 =?utf-8?B?UndlY04zZkVhbEdVQzhQVjh4QkFKYjdvdGFvYzhFaGxjb3Y1ZHY1TmlldHVz?=
 =?utf-8?B?a0RvVlpiUUZpUVBCbStVU1lGQXZUa1hObmhqcFBPTDVYdmtrcm5NdjdFbzlk?=
 =?utf-8?B?Z0xoRWFQdWVzTGovMjluTXV1L1M0akFPRGg1dEtXejBhVG1odUFwMUdiWWlU?=
 =?utf-8?B?TU5RMTZTOHR6M3JhMytCcVdmZHVBSnBKTlg0UGVSaElVU3pEUUNFa1RBUENv?=
 =?utf-8?B?MVVHQVlXU2FvdnBNZC9LZ3JacGZNRUZkRmoxbm5USDg0Z21IZzJmNFNmd1ZK?=
 =?utf-8?B?L1FSKzMxYXZlUkovOGVUNTVjSER2ZFFLY3BabEVESDdkaFVxckVXYzl6TDVy?=
 =?utf-8?B?Yi9TcUgyYUdPN3dIMkI3WHJOcU0zTDQzaUdjU2JnUEVqUEJsMzBtSXFsSDlw?=
 =?utf-8?B?Qno4elVlaHM4TXk1ME51alk0VEFlaGg5WU5FeE53SmszTGNKY0ZrZG40TDlE?=
 =?utf-8?B?R1lKYnBXcWR4ZkQvTkVJSjZZeDZ3MndHNDJrY01NV2FtOHN2UmE5YUJQd25C?=
 =?utf-8?B?OEE2MVV1cmVoK2F0TFhPOUhMMWFYcUMxek4zMXZ6SzhuZHRYWUFGZXZXdjVt?=
 =?utf-8?B?RysyS2xNbHZBbUl3MWV6RFpZc1I2QnZFRHZtcW9RbS9vZ3p4OVEwNk9SaCtw?=
 =?utf-8?B?Mjc2YlNGc3pXOHhjOFpYTkNwSVZtSHpMcko1b2IxS0ZkYTVpMnV2SEdqcEdH?=
 =?utf-8?B?S0grNEF0T1doNkpnWmZSeGg1VG1peXhicklpTm4vNjNQMy8xS1FNNFNOMENl?=
 =?utf-8?B?ZlFkdy9mRks3akRUa2kxbHAwZ3Jsd2t3T3FzbEtCNEtpN0lFSXpoZFZ5cHNt?=
 =?utf-8?B?R29mZ3FrWHZzY0QrWCtMdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anZvZ2V3ZExYbFFieTN6RW1zbytod09mUFpEVFVJV1p0eXpuMkZnemJDY0pJ?=
 =?utf-8?B?L0NhWUhWN3duNEZYREJEVjlDQ0NndzJsQzNPWG83R3ZTS215YVQwSjFPMndr?=
 =?utf-8?B?empJQmpLMmhZaCs3MUJhUUFqN0JlU2tZSWMrb1hocitlMzJSbnlWZFpNcFdh?=
 =?utf-8?B?a1JONExtbG5QY01IWVNoZlc4U2hVSGtrT3dlTVdMKzNMV3dBYjMyQ2RtbjB4?=
 =?utf-8?B?UkhjRXlqOG9HSUgyTGY3RklsdnV3QzYzc29QZVVHenVrRWtyNXVPdUc2V080?=
 =?utf-8?B?M1ZzTHZLVStEU2FRNXl6UmF6K2JoaGxjYU9zZWRkZSs5bTkyUmNXWU9McnBM?=
 =?utf-8?B?bnEzYUZjU3Zsa0FtdG5tL1ovNVdob3dWeEdDcjBjc25rMzRBbDc1bjE1SE83?=
 =?utf-8?B?cGV0NVNXV3lzallIWTZyMGtwTTZ4dTBkNThURmxSUE9OOWRPaVR5RDNqbzRF?=
 =?utf-8?B?VjhTMnhIRzFTa0VrWGEzZkYzWldNWkk0Q25qeVhlQUxMS0Y5NkpNT3lSbDRC?=
 =?utf-8?B?TFVTMW51aEh5eDAwV0trUGIrVG1tWVlNemJFTHhxcDE0WE4rYklnUnR0bVM3?=
 =?utf-8?B?Ykt2NldYTU0wRFV6T0J1V2IwUW0vOTQ2T2dYTSs0emxVTHNtVU5aa1c5Qmc0?=
 =?utf-8?B?aEFDcHV3NVNJam56WXpJdTUrSXQwR3FGTFFDV1FqQlNQdUdzK3Y5ZmhsRmps?=
 =?utf-8?B?YUhnZGRLa2lKWEM4by9DSmFLTmJHcmttdVNMcHZOVi81cjVxbUdYK1FVck9Z?=
 =?utf-8?B?UUdpenJNOEw4RUVDN2pkbmtRUE5ZRkttTUpmWGhxTDdFSFliWWU2c0h2YUJ2?=
 =?utf-8?B?NWdyQ3BEQndzNS9nT3Y5UkdyQnVsMEVCK1NBOElteUQ1YkpSRUR6bkNhc09y?=
 =?utf-8?B?RUVsT211UmN0d0IrdG9ETnFBU1E1cGhnVW1aTjYwMnlhWlZuWEk5dDMwY1p6?=
 =?utf-8?B?VDUrZkZHTXdWRnUrbnFaQUhycUx1Uk9EVDVEamNqc3RteCtxL0lQb0RxSk56?=
 =?utf-8?B?QmdrSkMzeGpadDNwMVJyWTJYYmo0M2o5YW4yTzZSTGxzQVkvcjhUWTRWZGlP?=
 =?utf-8?B?RHIvWmpFVS90eGRCb3B4c08xbGdBRm5pdUdjekY1K0Z3M2F0cEM3NFhXSWNa?=
 =?utf-8?B?Q0l0QWtiaVRwVFhsb3plcmJUVm8ydWJraFpUK0ZPcWQyRHZnRUM2U2MyeGM5?=
 =?utf-8?B?WVF3MlNYK1pYdTI0RnRJTm9KblZYYkVDMmw1ajdia0M5c0NRNExEck9INmFJ?=
 =?utf-8?B?N1RmaVFvOWxSUDBFSUtacXhSY3Z1dmhteStVSzNEK3BJVVJSYlU5R3dIaU93?=
 =?utf-8?B?bTlxOUg4ZGpBVngyYTlrbVBGN1NNMDBwL09QVGZ1QjVzZkRpZ3RKdVhYVzZJ?=
 =?utf-8?B?NGs5MmJ2MFNpVVVveWE1eHlRVllMZXJ3T0VWM203aEc3Wk9aVktCUjM5N1VC?=
 =?utf-8?B?YnpiL1RYd2pVYkFlTHUrbEcvdDRkNjV3QmRuSGZSc1JXWWRkOERLMjZKY0VC?=
 =?utf-8?B?TTZWelNVMktVdnpoNEtWcjRQVFZZR1ZhQTFYV3Ryay9yOGZucllOMHhoMkc3?=
 =?utf-8?B?TXlUc3UrNis5WGJodFFEbWwyZHp4NzFRU2QrS01TaDllM0VQTUdjb1JiWDJr?=
 =?utf-8?B?T1NwRHM4SThBMCtnemorcW00Q0M2ZHJpUE51T3h3VS9yT2JrWldlQklSeWx4?=
 =?utf-8?B?NzJjT2gwMlJZWlZwK0hIc1pWZklzQVRDV2d0YUVVNVlrYmVGaUpiWFBJSit4?=
 =?utf-8?B?NmR4OU5sYWFCeitsVmx0RGFrWlNVTkdic3NYSlVpbnFhaUE2dnRhWFByaWdX?=
 =?utf-8?B?VitLa24vWFh5WUhhalNnZDhqUm9KZlk4bWdNbmwvWGtRNDc4YU1wc3JvYUVT?=
 =?utf-8?B?Yk5LcDJIdnFGVlZXREJiQlhBZ3dwRzZXZ3F0VjFGNVA0cTljRklNeUJiY1VD?=
 =?utf-8?B?R3Z2V2t4MUt1SitKK0FjNVNIZGRoRC9HM3VsSEg2Y1UrMTlHV1dDUVRMSnIr?=
 =?utf-8?B?TE5teVRrZ200VUlhR3BaYXAyTjg4WGt4Tm9rbGY5Q2pZQWt5RWtuMTlkKzlv?=
 =?utf-8?B?MmUvRU9iZlJXa1plRkVhTU91K1lKbG1IcmMveEcvNzNvRlMzR0RNTDhRYUNI?=
 =?utf-8?B?a1ZTcDVBaE41cGpFTXoyQm5PbW9Gcjk4aTRRZXdoL1BkaXZYbW81dTMzb2N6?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DCFA9F75339DE4CA0626205EA561AAC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b0618f-f7c1-4dfa-17bd-08dcd596848c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2024 14:56:02.5154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WivV2pKP0/OJqmvx7LJ/uFhfpRkh5+vPSD3CM2IHbdgirTTpkhfjEJd8WG+c3PEo1jD+iwvPc3rjy/OlEa28tobsr2sbLGwtrv4nyyJUeHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7603

SGkgQWxwZXIsDQoNCk9uIFN1biwgMjAyNC0wOS0xNSBhdCAxMzo1NCArMDMwMCwgQWxwZXIgTmVi
aSBZYXNhayB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBIaSwNCj4gDQo+IE9uIDIwMjQtMDktMTQg
MjM6MTggKzAzOjAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gT1ZMX0NPTl9DTFJGTVRfTUFO
IGlzIGFuIGNvbmZpZ3VyYXRpb24gZm9yIGV4dGVuZGluZyBjb2xvciBmb3JtYXQNCj4gPiBzZXR0
aW5ncyBvZiBESVNQX1JFR19PVkxfQ09OKG4pLg0KPiA+IEl0IHdpbGwgY2hhbmdlIHNvbWUgb2Yg
dGhlIG9yaWdpbmFsIGNvbG9yIGZvcm1hdCBzZXR0aW5ncy4NCj4gPiANCj4gPiBUYWtlIHRoZSBz
ZXR0aW5ncyBvZiAoMyA8PCAxMikgZm9yIGV4YW1wbGUuDQo+ID4gLSBJZiBPVkxfQ09OX0NMUkZN
VF9NQU4gPSAwIG1lYW5zIE9WTF9DT05fQ0xSRk1UX1JHQkE4ODg4Lg0KPiA+IC0gSWYgT1ZMX0NP
Tl9DTFJGTVRfTUFOID0gMSBtZWFucyBPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODguDQo+ID4gDQo+
ID4gU2luY2UgT1ZMX0NPTl9DTFJGTVRfTUFOIGlzIG5vdCBzdXBwb3J0ZWQgb24gcHJldmlvdXMg
U29DcywNCj4gPiBJdCBicmVha3MgdGhlIE9WTCBjb2xvciBmb3JtYXQgc2V0dGluZyBvZiBNVDgx
NzMuDQo+ID4gU28gYWRkIGZtdF9zdXBwb3J0X21hbiB0byB0aGUgZHJpdmVyIGRhdGEgb2YgTVQ4
MTkyIGFuZCBNVDgxOTUNCj4gPiB0byBzb2x2ZSB0aGUgZG93bmdyYWRlIHByb2JsZW0uDQo+ID4g
DQo+ID4gRml4ZXM6IGEzZjdmN2VmNGJmZSAoImRybS9tZWRpYXRlazogU3VwcG9ydCAiUHJlLW11
bHRpcGxpZWQiDQo+IGJsZW5kaW5nIGluIE9WTCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24t
SkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgfCAyOCArKysrKysrKysrKysrKysrKyst
LS0NCj4gLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX292bC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292
bC5jDQo+ID4gaW5kZXggODliNDM5ZGNmM2E2Li5hYTU3NTU2OWY5OTYgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gQEAgLTcwLDEwICs3MCwx
OCBAQA0KPiA+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1VZVlkoNCA8PCAxMikNCj4gPiAgI2Rl
ZmluZSBPVkxfQ09OX0NMUkZNVF9ZVVlWKDUgPDwgMTIpDQo+ID4gICNkZWZpbmUgT1ZMX0NPTl9N
VFhfWVVWX1RPX1JHQig2IDw8IDE2KQ0KPiA+IC0jZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1BBUkdC
ODg4OCAoKDMgPDwgMTIpIHwgT1ZMX0NPTl9DTFJGTVRfTUFOKQ0KPiA+IC0jZGVmaW5lIE9WTF9D
T05fQ0xSRk1UX1BBQkdSODg4OCAoT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4IHwNCj4gT1ZMX0NP
Tl9SR0JfU1dBUCkNCj4gPiAtI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9QQkdSQTg4ODggKE9WTF9D
T05fQ0xSRk1UX1BBUkdCODg4OCB8DQo+IE9WTF9DT05fQllURV9TV0FQKQ0KPiA+IC0jZGVmaW5l
IE9WTF9DT05fQ0xSRk1UX1BSR0JBODg4OCAoT1ZMX0NPTl9DTFJGTVRfUEFCR1I4ODg4IHwNCj4g
T1ZMX0NPTl9CWVRFX1NXQVApDQo+ID4gKyNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4
KG92bCkoKG92bCktPmRhdGEtPmZtdF9zdXBwb3J0X21hbiANCj4gPyBcDQo+ID4gKygoMyA8PCAx
MikgfCBPVkxfQ09OX0NMUkZNVF9NQU4pIDogXA0KPiA+ICtPVkxfQ09OX0NMUkZNVF9BQkdSODg4
OCkNCj4gDQo+IFNob3VsZCBiZSBPVkxfQ09OX0NMUkZNVF9BUkdCODg4OCAoKlJHQiogdnMgKkJH
UiopPw0KPiANCj4gT3RoZXJ3aXNlIEkgc3RpbGwgc2VlIGJyb2tlbiBjb2xvcnMsIGJ1dCBpbiBi
bHVlIGluc3RlYWQgb2YgcmVkLg0KPiANCg0KWWVzLCB0aGF0IHdhcyBhIHR5cG8uIEl0IHNob3Vs
ZCBiZSBvcmlnaW5hbCBzZXR0aW5ncyAoQVJHQjg4ODgpLg0KDQo+ID4gKyNkZWZpbmUgT1ZMX0NP
Tl9DTFJGTVRfUEFCR1I4ODg4KG92bCkoKG92bCktPmRhdGEtPmZtdF9zdXBwb3J0X21hbiANCj4g
PyBcDQo+ID4gKyhPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODggfCBPVkxfQ09OX1JHQl9TV0FQKSA6
IFwNCj4gDQo+IENvbXBpbGUgZXJyb3IsIGxpa2VseSAoT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4
KG92bCkgfCAuLi4pPw0KPiANCg0KWWVzLCBteSBtaXN0YWtlLi4uDQoNCj4gPiArT1ZMX0NPTl9D
TFJGTVRfQUJHUjg4ODgpDQo+ID4gKyNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUEJHUkE4ODg4KG92
bCkoKG92bCktPmRhdGEtPmZtdF9zdXBwb3J0X21hbiANCj4gPyBcDQo+ID4gKyhPVkxfQ09OX0NM
UkZNVF9QQVJHQjg4ODggfCBPVkxfQ09OX0JZVEVfU1dBUCkgOiBcDQo+IA0KPiBTYW1lIGFzIGFi
b3ZlLCBPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODgob3ZsKQ0KPiANCj4gPiArT1ZMX0NPTl9DTFJG
TVRfQkdSQTg4ODgpDQo+ID4gKyNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUFJHQkE4ODg4KG92bCko
KG92bCktPmRhdGEtPmZtdF9zdXBwb3J0X21hbiANCj4gPyBcDQo+ID4gKyhPVkxfQ09OX0NMUkZN
VF9QQUJHUjg4ODggfCBPVkxfQ09OX0JZVEVfU1dBUCkgOiBcDQo+IA0KPiBTYW1lIGFzIGFib3Zl
LCBPVkxfQ09OX0NMUkZNVF9QQUJHUjg4ODgob3ZsKQ0KPiANCj4gPiArT1ZMX0NPTl9DTFJGTVRf
UkdCQTg4ODgpDQo+ID4gICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUkdCNTY1KG92bCkoKG92bCkt
PmRhdGEtPmZtdF9yZ2I1NjVfaXNfMCA/DQo+IFwNCj4gPiAgMCA6IE9WTF9DT05fQ0xSRk1UX1JH
QikNCj4gPiAgI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9SR0I4ODgob3ZsKSgob3ZsKS0+ZGF0YS0+
Zm10X3JnYjU2NV9pc18wID8NCj4gXA0KPiANCj4gV2l0aCB0aG9zZSBjaGFuZ2VzLCBjb2xvcnMg
YXJlIGZpbmUgb24gbXkgTVQ4MTczLCBNVDgxODMsIE1UODE4NiANCj4gQ2hyb21lYm9va3MuDQoN
ClRoYW5rcyBmb3IgeW91ciB2ZXJpZmljYXRpb24uDQpJJ2xsIGZpeCB0aGVtIGFuZCBzZW5kIHYy
IHNvb24uDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0K

