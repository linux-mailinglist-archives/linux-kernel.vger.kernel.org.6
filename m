Return-Path: <linux-kernel+bounces-177693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950878C432A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCCD1C221B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45249153BCB;
	Mon, 13 May 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kpydCOvj";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jxPssZZm"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DEB153836;
	Mon, 13 May 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715610113; cv=fail; b=l4CABWPIcCTsrYkhC65QSxsEN0Vq1bOTRY+LvAl0R29Zt23f5E11w78s3m+YJAM2lkHvD2SOJByYuDWfYJlus9waIM7cBYxNcDYz181DLpg+6lEjHpo0LfwQp2nKUQlMcaGYdOsPG/lpgimGH/YombkgGlq6qIO3MSuPRcrOxJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715610113; c=relaxed/simple;
	bh=FMzCoqiHJ7t+J4FtIX92q/VFWzmmUO3FsLH0fUhmC5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=afCHF2rvnuMDKiIekgYZU3nKUN/rtC7xZKLVCUODubMu807pZxnoCsy6FlnctVacKHDXVnH2vyhVsG0z19693we5ttq3I8+6VJZyohlBcuJoSAi4a2SjDr6deus+kEEoDuRop2mChzWrdEzKMqQlPlB3oensV2qN2Gexjmaptg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kpydCOvj; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jxPssZZm; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 21260f0a113411efb92737409a0e9459-20240513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FMzCoqiHJ7t+J4FtIX92q/VFWzmmUO3FsLH0fUhmC5s=;
	b=kpydCOvjEn8OY99l8JP4dGZd/Z3SnHDRDi7VsDoXCc1cknQIneAlNzW0q4LVcg/9PwURutQHta98pSCoolXT4J0XYqArQ4OtOHrtzG5px6qSumB4bi44pJENz/b47F1ReqPjqpzb6jKcpUaZiN0DmXsasop4x/gsYlmWTN84o7M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5cef9a66-8165-495a-a893-1d394de9e4ff,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:9e6108fc-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 21260f0a113411efb92737409a0e9459-20240513
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 985412639; Mon, 13 May 2024 22:21:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 May 2024 22:21:44 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 May 2024 22:21:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1QEKG8Pk2wWvzKiCVVgZjf23RCotPqOAAmM6SGSF5/ngj/kKAvEfh/lUjlt19xxDXSTrIMDAGp73VQXG1VZkQb2/S7r7NZ5s/F60Jml7R404hOBtKAQtNBlDdBynMtN9K7QnguZCeUPvAVOqK8xZJ+bxPHkNQ8ibAw0j9LGFp+9vt9KfPCADU7QZp7Z0A3emlv+GRDhT3xwdRy0nbqC4sh9xb7u4dYIgLIJPApPoAHPMbfn4wKH5FgBkVzpetNnd10slXbSH+0z/QS4vhk4xkvLVaPy0CMDHqgtgNQ2Bhip2XRK2ZkrJQhbs/x3cUJ79fnzmEiV1R3vX2y4ufC4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMzCoqiHJ7t+J4FtIX92q/VFWzmmUO3FsLH0fUhmC5s=;
 b=AeGbrhLBNU07maLp3Kn7vXv8+9qhEypXAXLuCHctMDALgvAcwmeltIp9HEtPugWK+xvKYxT7JFTEE7dhwax6vBjROq2tas0S7xwVemiMQWD49tBUC/yhJBfTL84SmlvX66Sp8dVjNIhJ3VyJbmaeydedcYLHhnrNXjQkldZURwYqJ7qSqtFc3BiExUO41DILTmKGrkIOFjDumfiqcUJ8wVj9Y0okNkVk9Cw48jFsWJ5brU4GPUJGMtxTUchdu1xXVSRAu5atWSKZJtHh28chKettnFLcS7jOY+3QnkymGMUzSz/k3Etjh/PJ8YyMUd1OBEtSrH063hxhVA54RHfkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMzCoqiHJ7t+J4FtIX92q/VFWzmmUO3FsLH0fUhmC5s=;
 b=jxPssZZmoUJRdcqdlS52nxvchYA+LZlIXrN/Ak9fBJ5gZzDIK/nHRYQ+kMlNdv61N4L+IhSB9xe2xHuixYy9YTXr8tGqo8QtegFplo9HJhup9WqB+gnd1ziP3aXJHeMy4rQW/RsaxOPys2XURdWplip9nxyGiI3nLLyB+8gbElc=
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com (2603:1096:400:70::13)
 by JH0PR03MB7751.apcprd03.prod.outlook.com (2603:1096:990:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.24; Mon, 13 May
 2024 14:21:42 +0000
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3]) by TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3%5]) with mapi id 15.20.7587.021; Mon, 13 May 2024
 14:21:41 +0000
From: =?utf-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?= <Liankun.Yang@mediatek.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
	<Chunfeng.Yun@mediatek.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?=
	<Mac.Shen@mediatek.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Add write DP phyd register from parse dts
Thread-Topic: [PATCH v2 1/2] Add write DP phyd register from parse dts
Thread-Index: AQHaosoq7X5Ma7JxMUq62e1u26odj7GUussAgACBXgA=
Date: Mon, 13 May 2024 14:21:41 +0000
Message-ID: <5745c652790b9a917a39d941065f3d9c53725b1c.camel@mediatek.com>
References: <20240510110523.12524-1-liankun.yang@mediatek.com>
	 <20240510110523.12524-2-liankun.yang@mediatek.com>
	 <93690c52-7da7-4fee-9b58-6087b3fb1d71@kernel.org>
In-Reply-To: <93690c52-7da7-4fee-9b58-6087b3fb1d71@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5760:EE_|JH0PR03MB7751:EE_
x-ms-office365-filtering-correlation-id: c457e97d-4918-4e16-6716-08dc735802ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?ZkRBVG8veU56N2NQOE5BejJkYkhlM3F3QWxpcFA1WDdPQzM4MUE4VkVlVnpx?=
 =?utf-8?B?RlpTTUtUSHJ6VVVucCtYaGw3cTFFNzFVSGZrSHE0TWN6SHF5TjE5aGhCNVpu?=
 =?utf-8?B?NUk3cmdTWFhma2l0RXE4bWc1ZzU4b2dDdTlmYUl1SHNMcUZZd3VGYUxVNnZR?=
 =?utf-8?B?dEpoaWl1MCtiL2oxUU9lcHl2UGkzV3hVOGRuVWJOZlpoNTFEYWJnY0I1ajNQ?=
 =?utf-8?B?RVVWT2VsT3l2cVA3UGthNDU5OW5OZTFsNVhhSDZyZzdaVHN2OFNHU2RraFYw?=
 =?utf-8?B?TXE0bzdpdExwMHRiS3dwUjM2ZmNodnYxNjJHcDZxK2lxS0FCcHBLSGR3bWhU?=
 =?utf-8?B?cWtYdUpQV2xvUWFGTnM2WGIyMmZrNVVGa1ZVSjV1OStEcVc4enZ0cnRacTVl?=
 =?utf-8?B?UCs2RWhBaTh4aWw1bFcvc3Z0eHlCSTZ2RUFaMHRWMGYvcHhIYmg2SURqS3Ez?=
 =?utf-8?B?TkVGQys3UUplV0dxVGVucEppL2UxZk55clNTUmVJdURlK281TTRkTTdpZDcx?=
 =?utf-8?B?RUswdEdpZXVEUkh1L3p5dmxkdDBPZGt1MEQ1by91bnlkbDZYNFBaVFBGdUFq?=
 =?utf-8?B?czkyWGlpekx5TFcrRUVIYUtaaTkway9meG9vdGc1YkpUN25pb3craVFURjdH?=
 =?utf-8?B?akh0NmkxYXE2TUloclhsekpHZ0RBWkVnY2pNajJsMVRZZVEzYm5WdVlSWG9l?=
 =?utf-8?B?UkZpalJyS3NHUjF0OTZsSmYwdmJPdDZXWFYzQUNEZTBrbjVuZHhQVkJHcjVY?=
 =?utf-8?B?bmZHeVVOODVhQURyakRjZWhpNHRHUE5vbTZib2xCQk0xRW5XNkJLWUg2TVFh?=
 =?utf-8?B?TWpoaCtIZUMxV2cyQ05VTGVwSWxvMFdERGovaFBCU0gycVNXU1h0bzVZKzQ4?=
 =?utf-8?B?ZDY2bnFIRWpZL3Z6ZnA2R3hsMHNqa0IrZXFaYVJYWUprai9uT1JUTEIxMzZh?=
 =?utf-8?B?djY0d3FqVWgrSXN2VlQwZy9VS3dqUFU2WDE5Y1FLNDRlYXc2UnhNdVdIbnpw?=
 =?utf-8?B?UEd5dWVVeWN0c2ZGZTdtbHVlU214QXJjS3FWc2JJRkh6a0psWElSU2M0MTFU?=
 =?utf-8?B?Z3kyWlArQlZhdDU2K0F5R0VURjYrSm5rVjlISVRzL2lEaWVUdG5pK05QWnJ5?=
 =?utf-8?B?anJKaStzT2hEOE9NMGdudWVvOVc4ZGN4SjJrQVA3azlsemFydjBlM3ltdWdr?=
 =?utf-8?B?MWVRakloVEtyOHVJRzFPMGNiaTA1OWlnbWQ2bzZlM2svMUZYQW10Smh4Qy9W?=
 =?utf-8?B?V0ZoQjRsN0kyMk5QSFFvUWkvTVBZTjgzUElBWWpxMEJ4ZHJiQmhxaGNLb0NF?=
 =?utf-8?B?Zmx3Y3lMQk5nbys0RWFGbzMrRFB2VFFlajl6OHljdVlrTFVydTVjazdWUURn?=
 =?utf-8?B?aSt2U0I3VkZvTU9hU0hvbjVSVFVRZTdoQ280RUdWY0NwQS82RVgwamVYZ3hq?=
 =?utf-8?B?V2tHK3BtSVJWNGgvUWplU1hjTTJFWTZWSTZPSE1JM0JDeEZzeFIrUE5EWmNa?=
 =?utf-8?B?NXF6R3ZETkNLOHk5TFVrdWF3NnJJSGxBUnRUa2hnYkRRcEJrak05RFRBaTFT?=
 =?utf-8?B?T0xoMGtwMHYvUUlzbDN5OHpCSDBuUk1nczg0MXpselpLMWMzU1czbEZXMDN3?=
 =?utf-8?B?a3lhdkxzWVB6MHdndzdpUkxDRDh2bGJTZ09PT2RXMkRqY2wrSVJjQ05xMmVJ?=
 =?utf-8?B?SHdYVHBDdFZubkpqMng0NGFHTXExS0lKcGFWSnpBWEtkQnZFNldIc3JQc09t?=
 =?utf-8?Q?BL3MCYdabyu185xSCI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5760.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGlENTFOS2ZsZGlrMWl4Z0ZReFRpdklqSlRsUmRON1FONXZJYzdzczRwd2RJ?=
 =?utf-8?B?QlZqK2xSUG44bnh4aU9QN0tJL1N0bitXY2pnbDlYMkxrNWF0WDl6aWNXQ2ZN?=
 =?utf-8?B?NisrK2pacFAzNXo2NitwRnNIcDN6WlBSdlAxMTYrcVZZa3RZMm1pTythaGdO?=
 =?utf-8?B?d2p1SHQ0Ymt1RDZoWU5Hc2FQRWpQY2hIOWNvZGNya0x2RGJRMERURnlRU0Vo?=
 =?utf-8?B?TTBjbWVONzZOT0ZaQndRVVBPK1BKZzBYVXpJVGJ4OHhTaG5SMVQ4b0pnSFVJ?=
 =?utf-8?B?b1M3bzRXeFFGM2o1VC95ZVdUNmppVkkwclBHMmJSUnRxalE1VkNEZWxUOUNt?=
 =?utf-8?B?bFFHcWJSWnovdjdTYUkrd0tWQ2syWFpSS2JVdzlwMTZvZmpFRitjd0hySWs3?=
 =?utf-8?B?bkZYZWZiZ2Z3eVZwWFVMWjdLd3hXTXE5ZDhrRkpIbktPbnpiOUlqTnZCdFh6?=
 =?utf-8?B?cEhyNlp0c1dpVE03VDFRVUsvVG1zMUtML1hqa0ZiTU5CenlGbm5xQm9oQzc1?=
 =?utf-8?B?bkpqN1JhREwwOCtmN2ZTdWQ1NWpKMk5DeXBxcDJEMWV2MlRZYnA3eFBpdXhn?=
 =?utf-8?B?aUx6aTczeDR3SW0zZ0g0Tk9CUzRWOHVCL0tmNmJoR2hWemRmTngxZlo5NXhn?=
 =?utf-8?B?Z3ZYaG55cDk0NDNxY3NNSng5VGhZeUNYeE1RVFlNT0pCTFJxcVY1eHFUWDVo?=
 =?utf-8?B?ck1jMmx1cW4rSDVpWG55a3Z4Y09wZnNTYVBtNVhuOStpOHNROGZiblR1aXB6?=
 =?utf-8?B?OW4rQ000UEtTcG9MVGlLV2d5aUtaU1VtaklFWnZkNndIT2szcFZpVVRYbXhy?=
 =?utf-8?B?TVBTVENGa2gwTWdSbVowZGdZOFF3L1BYd0x2R3JlWDN1eFloMUc0VTNUbDcv?=
 =?utf-8?B?N1VqM2tQYVFpeFVneDhIUGxqdGppRnY1MlNJSkkrZVNweWhGVGJuenhDem4x?=
 =?utf-8?B?ckY3aFJwUXVqUDFMSkFXNmtvdUhHQyt1aThUQTJhYTVEdFcrYXFkc0Y0Nm1l?=
 =?utf-8?B?M1loTnBKYzgrM0Ztbml6eWJRbk8rY05MUGRselZtZ1BCMTROWG1HbzJLRjFH?=
 =?utf-8?B?YXpGZnYyb3J6OEFKWjdXTy9sRTEwQVhHRWdiMEFyQnFiM1FGV3hVbFJqN3lD?=
 =?utf-8?B?RGg3TXQrR2ZsdzFXWmJVcTlDS0JBanc3SEtOQVRYNDRnWW0vam5ycnZwa0hN?=
 =?utf-8?B?Uy8yY0FycW5vUEZYZVdUMXpLd3BWcFA4ckg0eFNRcTVLSGplZVJ0Sk9abFFN?=
 =?utf-8?B?NGR1OUpSZE9qdE1nNHMrTGlrTFNwWjdYMktDY01sMDRlc0JFU2hpVFhvK0xW?=
 =?utf-8?B?dW5DOGxhZWRMWWJjQzl1QUltUGJwcHIvclN2OWlDTFhaTFVWS2I0S21PRzg4?=
 =?utf-8?B?ZCtSc0ZSNGh6clBTU3ByTVlkb05pZjhCTy83OW9SZFdFR2xnT0FkYVJLdWpZ?=
 =?utf-8?B?d1UzYmxJMVE5RlpZUnh0cUpLaE8xVUZQSWdkeitpZmZ0ZXZuYmMvQkMwZ0hI?=
 =?utf-8?B?MTZpQmR3d1AxKzJkOEt1R080Z1l4UjhLU2RqdzhabVJGOFM1V2owb1QwSWV1?=
 =?utf-8?B?aDZzUk5UL2RqWlkvVmUyclZaTUwrVzZoME8xN3J5dXpPd011UGkyVm1TcnBG?=
 =?utf-8?B?cVdiQlJWUXduMFlmZVlxRWtBUzhqNXVJWVF4UDJHYlNCbUpxSmJRU0hKWXpQ?=
 =?utf-8?B?TngvcWZaTHpQQnNpend6bGtmWFpYLytOZ2JZWHcyc0VrZDlxWGJkRW12bm9D?=
 =?utf-8?B?bmFnWmhzOEREVm5xOUVGY0dNaXVZMVlRMHo4NXp6aS9sZGZJVmdVS0owYmR2?=
 =?utf-8?B?WUhjQ3U1ODA1ckJSVDl0cjBhd1pRRHphT3RVd3BxaCtWc1NyeVdzTm1lbDlC?=
 =?utf-8?B?SWlyMG9HTkttWU55cFY3UnhJQ1BQZUtFNnhNdWFldUxpQThKbjRESGFWSEZT?=
 =?utf-8?B?OFIzOC9Yc1ptQVlhUXpqQTA1VW80YTdDa2NGaFFObXBXL29zK01pbURGRVFa?=
 =?utf-8?B?R2tFYmlaTktXTGJxWUliS2tVYVd0RFR4elJhT1BJS2pYc0JhVXRqeTdobkRj?=
 =?utf-8?B?Zjd4SUpsR0IwWWhpTkdhRmxHZEU5cXFRaVl4WUVHQTVJemJVMjBlSVNkUlNW?=
 =?utf-8?B?TkVmSnowaEV1VkN3TmUrakNidWxBUWdIWFFXR0k5dDZNWXRjZTk5Tlp1TG9Q?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8A475F6CC4193488855C62386C260B3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5760.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c457e97d-4918-4e16-6716-08dc735802ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 14:21:41.8856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Cur/YHWSTSS5EdHNoVEPnsWNyLVLrJ4hmjs9o10dI+VYMuPy5E5YhOmhyGznjR6qQ43Vptrlx3ru38EvtDPeE0Y1evbbKEktsrr08+/wDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7751
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.101900-8.000000
X-TMASE-MatchedRID: c/HXCguHooHUL3YCMmnG4vGG8F2k2BBV+WzVGPiSY8gNcckEPxfz2DEU
	xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+Cx+Mk6ACsw4JoKwF4K/wIz9TQF
	fM0Uvf4x2rjLHwV4/qCAroJaBm/+JNEWCshKSxvIyByMiwk6+3qFpKA8DI06JEd+K6O5Nt5113e
	8TptaRwWADXdyaV7dZvMX41ujcXaixMp1BoR4RCLMsPmSZxbpkCt59Uh3p/NUKogmGusPLbxFG4
	EGBR4d4hOZ64jWnvZLrhNvj0xGPQZH0YXYnbGoz0gVVXNgaM0pyZ8zcONpAscRB0bsfrpPI6T/L
	TDsmJmg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.101900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9530E33FE9A16D0E7A2CD19F370E593A4FB94B9C62C1820E30419950835465322000:8

T24gTW9uLCAyMDI0LTA1LTEzIGF0IDA4OjM4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDEwLzA1LzIwMjQgMTM6MDQsIExpYW5rdW4gWWFuZyB3
cm90ZToNCj4gPiBEdXJpbmcgdGhlIHRlc3RpbmcgcGhhc2UsIHNjcmVlbiBmbGlja2VyaW5nIGlz
IG9ic2VydmVkIHdoZW4NCj4gPiB1c2luZyBkaXNwbGF5cG9ydCBmb3Igc2NyZWVuIGNhc3Rpbmcu
IFJlbGV2YW50IFNTQyByZWdpc3Rlcg0KPiBwYXJhbWV0ZXJzDQo+ID4gYXJlIHNldCBpbiBkdHMg
dG8gYWRkcmVzcyB0aGUgc2NyZWVuIGZsaWNrZXJpbmcgaXNzdWUgZWZmZWN0aXZlbHkNCj4gYW5k
DQo+ID4gaW1wcm92ZSBjb21wYXRpYmlsaXR5IHdpdGggZGlmZmVyZW50IGRldmljZXMgYnkgYWRq
dXN0aW5nIHRoZSBTU0MNCj4gZ2Vhci4NCj4gPiANCj4gPiBPYnRhaW5pbmcgdGhlIERQVFggbm9k
ZSwgcGFyc2luZyB0aGUgZHRzIHRvIG9idGFpbiBQSFkgcmVnaXN0ZXINCj4gYWRkcmVzcw0KPiA+
IGFuZCB2YWx1ZSBjYW4gYWRhcHQgdG8gc2V0dGluZ3Mgb2YgZGlmZmVyZW50IG1hbnVmYWN0dXJl
cnMNCj4gcHJvamVjdHMuDQo+ID4gDQo+ID4gQ2hhbmdlZHMgaW4gdjI6DQo+ID4gLSBPcHRpbWl6
ZWQgbWV0aG9kIG9mIHdyaXRpbmcgdG8gRFAgUEhZIHJlZ2lzdGVyDQo+ID4gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLw0KPiA+IDIwMjQw
NDAzMDQwNTE3LjMyNzktMS1saWFua3VuLnlhbmdAbWVkaWF0ZWsuY29tLw0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IExpYW5rdW4gWWFuZyA8bGlhbmt1bi55YW5nQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1kcC5jIHwgMzcNCj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzcgaW5z
ZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9w
aHktbXRrLWRwLmMNCj4gYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLWRwLmMNCj4gPiBp
bmRleCBkNzAyNGExNDQzMzUuLmNlNzgxMTJkNTkzOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3BoeS9tZWRpYXRlay9waHktbXRrLWRwLmMNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9tZWRpYXRl
ay9waHktbXRrLWRwLmMNCj4gPiBAQCAtMjgsNiArMjgsMTAgQEANCj4gPiAgI2RlZmluZSBNVEtf
RFBfUEhZX0RJR19TV19SU1QoUEhZX09GRlNFVCArIDB4MzgpDQo+ID4gICNkZWZpbmUgRFBfR0xC
X1NXX1JTVF9QSFlEQklUKDApDQo+ID4gIA0KPiA+ICsjZGVmaW5lIE1US19EUF9QSFlfRElHX0dM
Ql9EQV9SRUdfMTQoUEhZX09GRlNFVCArIDB4RDgpDQo+ID4gKyNkZWZpbmUgWFRQX0dMQl9UWFBM
TF9TU0NfREVMVEFfUkJSX0RFRkFVTFRHRU5NQVNLKDE1LCAwKQ0KPiA+ICsjZGVmaW5lIFhUUF9H
TEJfVFhQTExfU1NDX0RFTFRBX0hCUl9ERUZBVUxUR0VOTUFTSygzMSwgMTYpDQo+ID4gKw0KPiA+
ICAjZGVmaW5lIE1US19EUF9MQU5FMF9EUklWSU5HX1BBUkFNXzMoUEhZX09GRlNFVCArIDB4MTM4
KQ0KPiA+ICAjZGVmaW5lIE1US19EUF9MQU5FMV9EUklWSU5HX1BBUkFNXzMoUEhZX09GRlNFVCAr
IDB4MjM4KQ0KPiA+ICAjZGVmaW5lIE1US19EUF9MQU5FMl9EUklWSU5HX1BBUkFNXzMoUEhZX09G
RlNFVCArIDB4MzM4KQ0KPiA+IEBAIC03OCwxMCArODIsMzkgQEANCj4gPiAgI2RlZmluZSBEUklW
SU5HX1BBUkFNXzhfREVGQVVMVChYVFBfTE5fVFhfTENUWENQMV9TVzJfUFJFMV9ERUZBVUxUDQo+
IHwgXA0KPiA+ICAgWFRQX0xOX1RYX0xDVFhDUDFfU1czX1BSRTBfREVGQVVMVCkNCj4gPiAgDQo+
ID4gKyNkZWZpbmUgU1NDX1NFVFRJTkciZHAtc3NjLXNldHRpbmciDQo+ID4gKyNkZWZpbmUgUkdf
WFRQX0dMQl9UWFBMTF9TU0NfREVMVEFfSEJSInNzYy1kZWx0YS1oYnIiDQo+ID4gKw0KPiA+ICBz
dHJ1Y3QgbXRrX2RwX3BoeSB7DQo+ID4gIHN0cnVjdCByZWdtYXAgKnJlZ3M7DQo+ID4gK3N0cnVj
dCBkZXZpY2UgKmRldjsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gK3N0YXRpYyBpbnQgbXRrX2RwX3Nl
dF9zc2NfY29uZmlnKHN0cnVjdCBwaHkgKnBoeSwgc3RydWN0DQo+IG10a19kcF9waHkgKmRwX3Bo
eSkNCj4gPiArew0KPiA+ICtpbnQgcmV0Ow0KPiA+ICt1MzIgcmVhZF92YWx1ZSA9IDAsIHJlZ19t
YXNrID0gMDsNCj4gPiArc3RydWN0IGRldmljZV9ub2RlICpzc2Nfbm9kZSA9IE5VTEw7DQo+ID4g
Kw0KPiA+ICtzc2Nfbm9kZSA9IG9mX2ZpbmRfbm9kZV9ieV9uYW1lKGRwX3BoeS0+ZGV2LT5vZl9u
b2RlLA0KPiBTU0NfU0VUVElORyk7DQo+IA0KPiBObywgcmVhbGx5LiBOb2RlIG5hbWUgY2FuIGNo
YW5nZS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQpUaGFuayB5b3Ug
Zm9yIHlvdXIgY29tbWVudC4NCkkgd2lsbCBjaGFuZ2UgdGhlIG5vZGUgbmFtZS4NCg0KQmVzdCBy
ZWdhcmRzLg0KTGlhbmt1biB5YW5nDQo=

