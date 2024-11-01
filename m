Return-Path: <linux-kernel+bounces-391809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3799B8BF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302151F23079
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A414B086;
	Fri,  1 Nov 2024 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P4W0iNo5";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JXByHYwx"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477C1531C2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445522; cv=fail; b=JmIpscIAMCBChNnVilRE23X4i2kWblxsp9A0gzBYHogbBWCTwHSgHCe8mxT0FoT3LwE4iHpg1LMKlr1EsoeMJRqLNrr7++XN1zv6aUNyECf4qsJNicsiBHlE5qYkot+NZe1sQ5D/60hUmOj00nKabncKUnDOZLVp9Wo1adE9JUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445522; c=relaxed/simple;
	bh=g+VvjMOax/7p/berqIOJgaHG5JihU9FcRJfr/OrtL+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d6snqvGmqhgRvxfYKeJ2MTqqNKHDhZMVcLERGSKwkV9QDfu+8bPHUMhUDzFM+7HKl96S6SemKcirlgSQJ/WccAXrtIlYKHlq3j3bnepeYu5TvbNs96c6JUJl/pIopokwANawIcwBoml3ilJz+bw+CIagNqDKXk2+JAxod5q3x/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=P4W0iNo5; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JXByHYwx; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7f79abb0982111efbd192953cf12861f-20241101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=g+VvjMOax/7p/berqIOJgaHG5JihU9FcRJfr/OrtL+I=;
	b=P4W0iNo50kIYy7sFHh/X8Kd/g4LEC4GPiyaAFrdtsanFgSGtUS1yKM9dMf2ayLjfC2zc2fn57SsncP7ppk4bAfnmOMLwwDsatB2qizOXh9ujj1j7bCYXyf7a54MHX2kZFcZwAyhAb4Jgk/L+BVoY5V/nHUB6wTYyXgQV0LkWQaU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:5addb860-833f-4d31-9643-98af067dc4f6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:a87263e7-cb6b-4a59-bfa3-98f245b4912e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 7f79abb0982111efbd192953cf12861f-20241101
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 508163352; Fri, 01 Nov 2024 15:18:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Nov 2024 15:18:30 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Nov 2024 15:18:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMdbMt4eiA97Rdbu1i6uRYn9xVdQjNQ7hshuWen6tgPgePygV1e4hS+Twho2c9LH6PKH140jB0XPtIdNfBiAcZJHEqd0AAvtLttYsk9FAOOp9s+zpa/qBipWV3dZnpeBH0vi00gCmZaOGQFPmGd/lal0Qu+cBUMqZeTjvPFqB8m14Rd80NIiirQZ+13WOiW5WWdWtrj46XPWq72/qzxSopk66HG0v8xzY2ftyVaHwH1/OFg0iRgAH6Ec2gYhxo3rCclzK4iZNBnN5ot6jd44D0PU2RHJU7/NaFy8ECl2hmGkoEkzxRycHBVVb2iV5WtmC86hcyzh2hvsXxYHYkMXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+VvjMOax/7p/berqIOJgaHG5JihU9FcRJfr/OrtL+I=;
 b=wicz91s8s6QTxYxFmZ40snXdIx7ypSQA5JSak1llGZLBJHCXufBFEjYUGAYzNojsfJ2a6ZT6k51tc0+hodUOcUX7kzt05nW/xOZCeigICvmNue1pqtUUadvWD3IwwITmAORSPiz2zQeK91ioG2NT8iwJaZHAbWfySEPbN6wTJ/84rFaMbhLz5LZljaRTqmRjIR1hxxcKF2/C+OhoG33gFpwUml6RV3qOHXdphE7eX91ItrQnrOPIScMOK2Z+dm62wbMSH3fu9/dYcNV2z+v/KFOX+7hO6bFo9qIeR8epCvvlns7GxwFcM5Y5W/oHKOdsxQi9ConwnF/53oFsQ6BCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+VvjMOax/7p/berqIOJgaHG5JihU9FcRJfr/OrtL+I=;
 b=JXByHYwxo6mN2eQ0yisHty1p/BKFyHWjnYjZprbm77URxF7xGAuwcDNnUnYtamDH7DSDRhrc2uswnJA9ojHozqTQXFMNOK1YlBgrV2/xSZ+rV3jHdl2RO+DSlK4T9pVhcTRpnqbqzFnMcBms7Ls7xXiczcYYgCUWvdlLPOUTVc4=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by KL1PR03MB7647.apcprd03.prod.outlook.com (2603:1096:820:e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 07:18:27 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 07:18:26 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
Subject: Re: [PATCH v3 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Topic: [PATCH v3 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Index: AQHauZvjSsoBOfJjC0GAI+NtmELueLKi6UOA
Date: Fri, 1 Nov 2024 07:18:26 +0000
Message-ID: <c44f75106e0b4bf04f8158231c1bf6cbdae93a64.camel@mediatek.com>
References: <20240608120219.21817-1-mac.shen@mediatek.com>
	 <20240608120219.21817-3-mac.shen@mediatek.com>
In-Reply-To: <20240608120219.21817-3-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|KL1PR03MB7647:EE_
x-ms-office365-filtering-correlation-id: 41381168-110f-4ee1-41f8-08dcfa4560de
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QlYvZ1loaHBmSFMyZnc3dFdhYXVnMzQ5eGZmUFF4QzFXMm1xamZmVTNZa0pU?=
 =?utf-8?B?bVVVcUhMb0o2TGRZdXZqZ05wYWh4QmdPUE1Pc0EycFBPa2hxY0xjNUp5ZWRI?=
 =?utf-8?B?NjJpQWl4MTgraG4vbkNjMzAranBiOFArZlFsTVNPbE1XL29DV05NWEhJTWpG?=
 =?utf-8?B?ZTZHUExHKzdzOGVhYkw2MzBQZHVhV3JRRU0yTmRjK0RZaDdGWVBZb3lUdlUr?=
 =?utf-8?B?c3ZFYUllWldyYllYQUFmQjJYMFlsR3JnZk1vM1o2Ukw0ak9zVlNzcjlNRmtW?=
 =?utf-8?B?WjE5T3VCKytReklpRk0zbGRJeGN5YlpWelJlRFZuaS9uWmdNenB0Mm5NdjBp?=
 =?utf-8?B?am5KSWQ5aWVXT2Z6QmFkVVl6aU0rb1FTRi9qc0x5dXNIWFdCUXJvR0RVNmVU?=
 =?utf-8?B?WkJiMGpmcXRQbW1jNDk5cmRrWTBKaTYrWlUzbjU4bTBWZDNSSXNMRVNHVjgv?=
 =?utf-8?B?VU9wV2M5dEkwbXhEdFVXeitIUkwxd2k1Rlp2MFBncHBZL2NpV3h2WUkvSzFX?=
 =?utf-8?B?dWZpSUdaRTJ3eUo4dWJVanN6dHlwdnZaMlBXRGtDYWFNYkpMWTMrRG5paGE4?=
 =?utf-8?B?KzIrU3hmQS9BWlpvUkhsaFFIS1NEY2JmVzR1cjlrcTVDeGl2SllDWmpYUGpS?=
 =?utf-8?B?Y3l1K2N4MEtOTTJBeTE5K0tqb3FEcUplaGZDK2srM203K2RsSXc1ZzBzNVRV?=
 =?utf-8?B?WFNUd2xRdmN5SjNBemRUZTd3K0tpWlgvYjlaYUVXUUF6WnJ6anZuUnNlQ1Uy?=
 =?utf-8?B?STZ2TXFnZHVsMnhQcUh3Zy9kdUh3anNQRUE3RFZSRVFDVDZBd0ZaU1RHWG9V?=
 =?utf-8?B?TzRKZFR4dm41bG5FUktvVC9ZTFNBMThyOUtlZ2RQSVBkcmt5VmVWbmtCMnNQ?=
 =?utf-8?B?ZnN5QVFEeVZnSE1xSnk4U1VUN0hQbnUyKzYwQmVFTUxIRFo0L1JqZEVGZWFx?=
 =?utf-8?B?cUxMWjJtWjlzZ2NhQ1l0eklFTmJ3TjdqbFB0dmVkc1NFVnpvYy9xaGNWZ2xx?=
 =?utf-8?B?a08wYWVwdHFWdmo4YVFKajVSSFY0UTYrUmUyNWJ0aGxhZTNhWTZyM0RzTzhz?=
 =?utf-8?B?VFdCRHIxa3FyK0FGN1hVdm1INlV3WXZXV0hKcEcyWnhrUzBPVVQ1OTVUT29J?=
 =?utf-8?B?WnIzNHpMYmFSYmd5SDNYVUtaUkwzTXVDL1paSU4yR3U0RkhlMDFPWU9nN1RP?=
 =?utf-8?B?SnExU1ZHcEVFZGpQUTByMWRXNGNRZlBnUXNxemhiY29Ba2E5VERXUnYzeEk5?=
 =?utf-8?B?UUdDZ2xDbGNFeUc0eUx4ZWVYM3QxNFB5TzcvNE0vbUVEaWRjOEZQTFVoeEx5?=
 =?utf-8?B?NWR3NVNURDJ6aUNmblE1RnM0Q3E1b1NyNFBCMEVaSzFRenhkTW83RFVHT1ZV?=
 =?utf-8?B?N1lKRXVVZDhPaUJIRDBFbittdEd3cnJ1UmVKR2pYdmg5VGE0c0RJMGo2MGxM?=
 =?utf-8?B?WEptc1pOUmk4b0g1anI0YWZkbEVZeldHRkJDSzVpNUV5N2ltVUxqWkdrMktr?=
 =?utf-8?B?Y3RPdUNoeTlvaUlDMTdEN1dYc3BiSTJIVEFhNEs4bGZHdEZmNVBHejc1YW5q?=
 =?utf-8?B?WFd3ZmNYQkZFRTV3VVU2SWJHL3NLZUFuMit3TG9QZ3gxOERkakswMWwwZW84?=
 =?utf-8?B?RWw5cXJ0b2NodWNOQzUwSzJuUndFaUJVS2xXWXRmQng2dldzbUdqWGRVMmFP?=
 =?utf-8?B?NmN2R0FlTVVFVHFXQUtxN3NhUCtrSlBLUVR2SVhHUmJOeEpKcjVwSkMzcm1X?=
 =?utf-8?B?aUR6MzhyaFNlUmdhSURwVDhEcWhCQm92TXdHcVgwMlNJV0dJN3U3R1hVMmZ5?=
 =?utf-8?B?VG1xdjVFcEtJOFFSL29uRW1mMEk3bUNmTlJTQ0l5K0xDdzViUTQ2OWJSaGZu?=
 =?utf-8?Q?RiQ5oXX5mBH3A?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWd3N25FRWVNQXVRYkpaMzFkWmJ0UGoySzFrY2pSUmZvZ29wVUZVaDlDOWdK?=
 =?utf-8?B?TjZTZXY0NEVUSE1oSktuK3hOK2o5a3BkMTRiTUxxUjZyNmZJWDJ1YmFkZjZj?=
 =?utf-8?B?VWVLcXhWeS9VM2hTZlIvT0NLYlgrdXlrUUhPTDlCLzNxbTJ3bUJOeGpoZ294?=
 =?utf-8?B?WnJJM2RBeS84aU0wclo3WEtDcTdlckVkRUljQlYrTFVab2toWDY2NzlGb0V0?=
 =?utf-8?B?V2s1UEdMUDlDTnZ4by93bFM2aEJTeENibEV1c1E3QkNKcDNvaElZbitaQTBl?=
 =?utf-8?B?S2F2Q1dLNXhIRTRvK3gzaExRVXlOOFVHOHhGNXNmM295Y3c0WkpZbkVwbExK?=
 =?utf-8?B?RHhDL1NXaU52MDdKZGdsZjZ4L1AxQjMzVDFua1J0dmJjekMraHlqNEdIVzl6?=
 =?utf-8?B?c20wTkFnR0NtM0lxWWoxb3FndTlLU0pvKy9lTmtoV1kzVGdCdTQ0QkkycmtU?=
 =?utf-8?B?bDFTQVpuMkNKQ2VkU3ZYdmladWxpblpsb3ZxajM2QVhPV085bnJEc1Axekxv?=
 =?utf-8?B?bURnOElIcVZ2Vy9GNlExU05FMC9GZ0R3aFpJeGZBZU1IY1hTQWZLMkdDbjNa?=
 =?utf-8?B?ZWpqWDZyMUVaYzl6Q1U5K2VIeE5GQ05Gd3BSVXBtQkpRNGwrcWlsK0ZQSkZP?=
 =?utf-8?B?STRBd2RZMEdkODk2WWdRWkNocmtCUDBZTlRkTU1maUdpMW4zR2k2M1libzZX?=
 =?utf-8?B?TzRKTWhRQnNra1JkSmR5cG1pa0grc2ZuQjllL0Q2a2U5WUNlTkxCVFF3T04r?=
 =?utf-8?B?b1l3RWROU1dqbXM2RWhITVlxRktyMkJPQmZFUXh2YnNTc0o2NUo1QkdEelRK?=
 =?utf-8?B?OG1BUDExZXRMTTdFTFFsdFFoTzQ4ZVZmeXo2WHo4VW1yMitRMG5ib3RYS3FD?=
 =?utf-8?B?eU5BMTZwdmdnMWY2aVdjZ0VjcVZ3QzZRUmRyYmdNZjIrU1FxRUwrLzlmc3FQ?=
 =?utf-8?B?NDBHY1dGNVVZZFBqTFUyck5kNzl1amhLd3RUbFI4L2JuTzByZDVJdmg4eDlx?=
 =?utf-8?B?MTFRZkxJODJ0WDlMaytDVTFKamtvMHF3OSs2MzhPOVNxSEp2ME9JY0ZyODhE?=
 =?utf-8?B?eC83U0hLV0Q0aW5sUmsrVmh1V0JPTkZQNXN3KzVhQUNCeDdzTFZ1bVFVMEkw?=
 =?utf-8?B?dXNRQkN2OWJ3bVE3UFNBZy92Nzd1N25BRVkzOEJnR0ZJcnQxYkpmc0ZjeWUr?=
 =?utf-8?B?SFVJTlJFeDVENlhUd2xFK1cwdXN0YzE5ZnhwS29TZG1HVi93VWRoRDRPRHlC?=
 =?utf-8?B?ajNZODBCM24yaUM3QWd4dkRkNmhTVzZEVVdKRTBvenFiTUdSQkQvNEcyTUla?=
 =?utf-8?B?UUlmRStOQytPc1cvdUs3NURodmh6djhaT09vTHR5WFRZN0IyMFI4NUJOU0RU?=
 =?utf-8?B?aVVZTEFvVTlLWjJpYUdrbmMrSzBnTG5GdngyS0hXMUJ5T2Q3d21xWURLcWlX?=
 =?utf-8?B?VVFhQTEwVEZhaFNnTEFjNEpFTG9STnMwSmNSNVVOTjBoVmh6YTFibFQwMXh4?=
 =?utf-8?B?Nkl2blhBRzBmUlBOZXo0a252Q2NTbUVtU3NwaTI2RTd1bVpneTdDbHlSN2Nm?=
 =?utf-8?B?Y200MGFsZmdFM3VzQ2dQZk1RMG9ibExZWnBnejh2ZWpDcDAvbEdkT3FWenFy?=
 =?utf-8?B?TUpFZE9vc3JWZEtUZDFPSnBOamxUeCtzN1FDTEhHa0p0YmNiZlpRK2dmT2xY?=
 =?utf-8?B?Y3M0b3FVclAyV2piMDFoWUJ3Q05CS1BONnJQdHB6VHJmWS9YcGFSWjhkRnRo?=
 =?utf-8?B?MzFGVDBqQUphcHNTbFRxUnB1azNxeXo4cDF3YnUwalVHdkdua2MrcXNUT0NW?=
 =?utf-8?B?ZWM0bVlMbDU5Yzd1cHhMeWUwbTE1WS9XNFFiek42eHBNcTExbWRQK1NscnRS?=
 =?utf-8?B?anlnbElndCt0dUlBczFzQVg2Y3hwZnE5eVZjelBwa2gva3pCSHpPY05PNVUy?=
 =?utf-8?B?OGp3ZEc4aVdMa3FFTW1oTjFvdGVTVk9wYmROSXRnNWdZb05xdU9UWHgySU4w?=
 =?utf-8?B?OTdVTjlFenBZZ3M0L016M294Y0tzbFVtMlNkSkFLdkRFOGxUU1FwUENWYXUv?=
 =?utf-8?B?UERlNS9aaHMrYXN6TEZHVDB6RHhVelVYajNjRmMyWURxTFJlWjdaZ1k4dHpB?=
 =?utf-8?Q?hEORmivoek8JOqzkl2YzJwl+F?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68D17D8144F4674F8998F2F441267D0E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41381168-110f-4ee1-41f8-08dcfa4560de
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 07:18:26.4144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABocC2406GFp7CFkYdqXv+a8VbTjd1F38/t75XZHs7JfyWHvLjsI1wk+xfiGj3vVtuLlzqhgB4nu86pk01frlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7647

SGksIE1hYzoNCg0KT24gU2F0LCAyMDI0LTA2LTA4IGF0IDIwOjAxICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSByZWZpbmUgdGhlIGZ1bmN0aW9uIHRvIGdldCBz
eXN0ZW0gdGltZQ0KPiAtIHJlZmluZSB0aGUgZmxvdyB0byBkbyBIRENQIHdpdGggY29udGVudCB0
eXBlIGFuZA0KPiAgIHByb3RlY3Rpb24gdmFsdWUgd2hpY2ggc2V0IGJ5IHVzZXIgc3BhY2UNCj4g
LSByZWZpbmUgdGhlIGZsb3cgdG8gdXBkYXRlIGNvbnRlbnQgcHJvdGVjdGlvbg0KPiAtIHJlZmlu
ZSB0aGUgZmxvdyB0byBkbyBIRENQMi54IGF1dGhlbnRpY2F0aW9uDQo+IHBlciBzdWdnZXN0aW9u
IGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRla19fOyEh
Q1RSTktBOXdNZzBBUmJ3IW1kNnhVaVlOODhEMlltRVRzOEZRZ2FFeE0yekg4UzFTbUFFVTlHUmNo
d3BOc1hPeURGdWwzemlWS2hScENKYWo4UmNuLWd2TS04MDFydW5qd0EkIA0KPiAvcGF0Y2gvMjAy
NDAyMDUwNTUwNTUuMjUzNDAtMy1tYWMuc2hlbkBtZWRpYXRlay5jb20vDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBtYWMuc2hlbiA8bWFjLnNoZW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCg0KW3NuaXBd
DQoNCj4gKw0KPiArc3RhdGljIGludCBkcF90eF9oZGNwMnhfcmVhZF9yZXBfc2VuZF9yZWN2aWRf
bGlzdChzdHJ1Y3QgbXRrX2hkY3BfaW5mbyAqaGRjcF9pbmZvKQ0KPiArew0KPiArCXN0cnVjdCBt
dGtfZHAgKm10a19kcCA9IGNvbnRhaW5lcl9vZihoZGNwX2luZm8sIHN0cnVjdCBtdGtfZHAsIGhk
Y3BfaW5mbyk7DQo+ICsJdTggcnhfc3RhdHVzID0gMDsNCj4gKwlzc2l6ZV90IHJldDsNCj4gKw0K
PiArCWRldl9kYmcobXRrX2RwLT5kZXYsICJbSERDUDIuWF0gSERDUF8yXzJfUkVQX1NFTkRfUkVD
VklEX0xJU1RcbiIpOw0KPiArDQo+ICsJZHBfdHhfaGRjcDJ4X3dhaXRfZm9yX2NwX2lycShoZGNw
X2luZm8sIEhEQ1BfMl8yX1JFQ1ZJRF9MSVNUX1RJTUVPVVRfTVMpOw0KPiArCWhkY3BfaW5mby0+
aGRjcDJfaW5mby5jcF9pcnFfY2FjaGVkID0gYXRvbWljX3JlYWQoJmhkY3BfaW5mby0+aGRjcDJf
aW5mby5jcF9pcnEpOw0KPiArDQo+ICsJcmV0ID0gZHJtX2RwX2RwY2RfcmVhZCgmbXRrX2RwLT5h
dXgsIERQX0hEQ1BfMl8yX1JFR19SWFNUQVRVU19PRkZTRVQsICZyeF9zdGF0dXMsDQo+ICsJCQkg
ICAgICAgSERDUF8yXzJfRFBfUlhTVEFUVVNfTEVOKTsNCj4gKwlpZiAocmV0ICE9IEhEQ1BfMl8y
X0RQX1JYU1RBVFVTX0xFTikNCj4gKwkJcmV0dXJuIHJldCA+PSAwID8gLUVJTyA6IHJldDsNCj4g
Kw0KPiArCWlmICghSERDUF8yXzJfRFBfUlhTVEFUVVNfUkVBRFkocnhfc3RhdHVzKSkgew0KPiAr
CQlkZXZfZXJyKG10a19kcC0+ZGV2LCAiW0hEQ1AyLlhdIFJYIHN0YXR1cyBubyByZWFkeVxuIik7
DQo+ICsJCXJldHVybiAtRUFHQUlOOw0KPiArCX0NCj4gKw0KPiArCXJldCA9IGRybV9kcF9kcGNk
X3JlYWQoJm10a19kcC0+YXV4LCBEUF9IRENQXzJfMl9SRVBfU0VORF9SRUNWSURfTElTVF9PRkZT
RVQsDQo+ICsJCQkgICAgICAgaGRjcF9pbmZvLT5oZGNwMl9pbmZvLmhkY3BfcngucmVjdmlkX2xp
c3QucnhfaW5mbywNCj4gKwkJSERDUF8yXzJfUlhJTkZPX0xFTik7DQoNCkluIFsxXSwgaW50ZWwg
dXNlIERQX0hEQ1BfMl8yX1JFR19SWElORk9fT0ZGU0VUIHRvIGdldCBkZXZpY2UgY291bnQuDQpC
dXQgaGVyZSB5b3UgdXNlIERQX0hEQ1BfMl8yX1JFUF9TRU5EX1JFQ1ZJRF9MSVNUX09GRlNFVCB0
byBnZXQgZGV2aWNlIGNvdW50Lg0KU28gYm90aCBjb21tYW5kIGNhbiBnZXQgZGV2aWNlIGNvdW50
PyBPciBzb21ldGhpbmcgd3Jvbmc/DQoNClsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2dwdS9k
cm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwX2hkY3AuYz9oPXY2LjEyLXJjNSNuNDk3DQoNClJlZ2Fy
ZHMsDQpDSw0KDQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwlo
ZGNwX2luZm8tPmhkY3AyX2luZm8uZGV2aWNlX2NvdW50ID0NCj4gKwkoSERDUF8yXzJfREVWX0NP
VU5UX0hJKGhkY3BfaW5mby0+aGRjcDJfaW5mby5oZGNwX3J4LnJlY3ZpZF9saXN0LnJ4X2luZm9b
MF0pIDw8IDQgfA0KPiArCUhEQ1BfMl8yX0RFVl9DT1VOVF9MTyhoZGNwX2luZm8tPmhkY3AyX2lu
Zm8uaGRjcF9yeC5yZWN2aWRfbGlzdC5yeF9pbmZvWzFdKSk7DQo+ICsNCj4gKwlyZXQgPSBkcm1f
ZHBfZHBjZF9yZWFkKCZtdGtfZHAtPmF1eCwgRFBfSERDUF8yXzJfUkVHX1NFUV9OVU1fVl9PRkZT
RVQsDQo+ICsJCQkgICAgICAgaGRjcF9pbmZvLT5oZGNwMl9pbmZvLmhkY3BfcngucmVjdmlkX2xp
c3Quc2VxX251bV92LA0KPiArCQlIRENQXzJfMl9TRVFfTlVNX0xFTik7DQo+ICsJaWYgKHJldCA8
IDApDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwlyZXQgPSBkcm1fZHBfZHBjZF9yZWFkKCZt
dGtfZHAtPmF1eCwgRFBfSERDUF8yXzJfUkVHX1ZQUklNRV9PRkZTRVQsDQo+ICsJCQkgICAgICAg
aGRjcF9pbmZvLT5oZGNwMl9pbmZvLmhkY3BfcngucmVjdmlkX2xpc3Qudl9wcmltZSwNCj4gKwkJ
SERDUF8yXzJfVl9QUklNRV9IQUxGX0xFTik7DQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVy
biByZXQ7DQo+ICsNCj4gKwlyZXQgPSBkcm1fZHBfZHBjZF9yZWFkKCZtdGtfZHAtPmF1eCwgRFBf
SERDUF8yXzJfUkVHX1JFQ1ZfSURfTElTVF9PRkZTRVQsDQo+ICsJCQkgICAgICAgaGRjcF9pbmZv
LT5oZGNwMl9pbmZvLmhkY3BfcngucmVjdmlkX2xpc3QucmVjZWl2ZXJfaWRzLA0KPiArCQloZGNw
X2luZm8tPmhkY3AyX2luZm8uZGV2aWNlX2NvdW50ICogSERDUF8yXzJfUkVDRUlWRVJfSURfTEVO
KTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldHVybiAw
Ow0KPiArfQ0KPiArDQoNCg==

