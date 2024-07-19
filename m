Return-Path: <linux-kernel+bounces-256946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6D9372EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8D91C210CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FE52BB0D;
	Fri, 19 Jul 2024 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IWYGNQ0B";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dG3GLE4b"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4846B168D0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 04:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721361926; cv=fail; b=CS4LcDWbRULSCgxxnN3jdhT+OVKV+f9IClsxAfJoptQZFQ2XUMGl8fvaIL3t/q65pBdkpj/AQt/L3QeugGJq7zpBTqwcIHkUezlJkThQ1b7rOe8wuklkuYbRjYnmFpEov1JPWFRgloadwzkCBjzNpIF/iTDy/V6Elb67FROs0Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721361926; c=relaxed/simple;
	bh=Sqn0co/ocn3u3+gXGJVT0tf1arly/vtadFECwRXV7ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FQS44Di7qxACSDK9iQvCaPqFuDrjSHeSTvHIthX+V19Jps06hpngL07VKDC41mukVSKOe0RZFQGL07TDceKNpFr4XA+QHIqvX+bQuDA4eQplrel7vNRHM76vbRuK7DbgfSvI5VmxUGWLmu9k/QcqQuOFhdnRs86cCzyQMZBKlLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IWYGNQ0B; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dG3GLE4b; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1b23e3e6458411efb5b96b43b535fdb4-20240719
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Sqn0co/ocn3u3+gXGJVT0tf1arly/vtadFECwRXV7ws=;
	b=IWYGNQ0Bi1ZZaoPAffrNhLL/p3k5mTsJVrXXuA8XFgUizLPvqjpLR5Rjy0OGQVxVq95AXQVvJurbv+iLIipjoNJ/5epOnH/EyFq16kCT+ebsORBOU2WdvSem4TdWKfuxCiqDPtEiMUUohcCtavWeqdYazdqVG8kwsaE+nURsUYY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:d3813562-d73c-4c7d-8b4b-6e1cee07e5c2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:02ea7a45-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1b23e3e6458411efb5b96b43b535fdb4-20240719
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1805231827; Fri, 19 Jul 2024 12:05:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Jul 2024 12:05:15 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Jul 2024 12:05:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybaqbJ/R3pQdCm62YzhNJFO4p88c3wfASSKLPsbI6aDjRcjLhkRgpiirMqshdr59Nyx6KWEIy3rjOyGiEVipvjazI9J8lLBnygAa3rgujH97qQcYHd1ZBTddsHTX2Gt7QL6HhVnkgxuhGH0QaDZdHjjAto5j5OCqLiM+ecaXdP5Kjji4CGfs0CBF+CuuEaio+3wUWwAWmbDVRuMGHmuWtk5yTsYZYisGzSr2jL19vHQP2SJMx2ut3DGfS5qoZRf4mJZgjj6PcaEE5oHeA+OHW3UpCkluFSfD315maTDxmb8eeeJeosk2zo7v7OL+85KAxLsvn6Dpft0UGlz2rxHJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sqn0co/ocn3u3+gXGJVT0tf1arly/vtadFECwRXV7ws=;
 b=eZS4uIaRozjQe63xNvJxk9xGDAxnnAtZ+7KU0tDSXMYRBfFiON9G6aTaC5m/otI16ikO0FjEclc27QAbY2g6CMJ12Wsw61aXpd77AyezGtNnrx9IDCyRNQRLUeeivssIcKZiPrj/DdsDxg+Q0WbIjJdRSIL8pXX6pwJHC1k3IMvOglXDZ7g0ZMm5PmrLYSVLnHoK5l0C/yKhEGe+d5ByXlfkYGdNmx+zTU8GFhhO4aL5NZywza/LxQPlfgR/X1o1nFEsuRb3ZTcpyzY3P0wCiJEa/0kHTpXEiZt0WEzTKZXrVfHOzEhjCi1S0GINrWHJ8W0IVtzcPbEtr3giyD3z0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sqn0co/ocn3u3+gXGJVT0tf1arly/vtadFECwRXV7ws=;
 b=dG3GLE4bnyjtzMtrkku0uXE9habnQKqottaQBzzsGbWFk979yCxhWlAwD7Tf4gyh5yr88mZ7fyW70udfzoaQtP+gK6spAP6Lc3SNH1oh503KBucXfSWqPixIL8oOVoAsL3ib32lfcjQDJTkoXw2jnxhSsojFccdw1r6P7CaX0jU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8800.apcprd03.prod.outlook.com (2603:1096:820:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 04:05:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 04:05:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
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
Thread-Index: AQHauZvjSsoBOfJjC0GAI+NtmELueLH9rnwA
Date: Fri, 19 Jul 2024 04:05:13 +0000
Message-ID: <c72c1114514452450c8248f894bc332ce2778477.camel@mediatek.com>
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
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8800:EE_
x-ms-office365-filtering-correlation-id: ab447829-4606-48ce-5744-08dca7a7fd68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGhKSUZHMDZMSkpjZWgxcS9yMW43M1NvUVM3UloxV3FkT1RHbndwT051b3Qw?=
 =?utf-8?B?S2F5enNkUXhWczY0UlIxQmtRV3FQenNhdUdyQS9SZk5VbitiSHlRR05JZCtF?=
 =?utf-8?B?TFpBOFA3aG9ncWtLd0F2WnFFTUMxcngwM3Z4NmZUZFVvYlZUUWhUTGE1SThG?=
 =?utf-8?B?M3Qwb0FuRHE5RkNvWTBCTTZadzJmNFJZdG02RmhVS0JNUTltSmRGczVYK1NP?=
 =?utf-8?B?d3Q1TmhxS3dLbnJvNkdWaUhGYW1TVStja2IyVWlUQWJ0bHhGNFVrVU9MZGRK?=
 =?utf-8?B?UDdpY25vSXJhcmk3ZHZkNGNibjV2dUVKajJ3ZFZaSVNhT1lOL1BoZnUvckND?=
 =?utf-8?B?dlBPeWVZbFhYV29Qdnd1U2M5L095empidFNUUThNaGFiQVZiWE5NZjgySDNV?=
 =?utf-8?B?bytrSmRQcG81amlmR1FWc1p2T2FldDQ2OXdnbTVJSFlUa0Z4TUdXeDFtazR2?=
 =?utf-8?B?Wi9mSmVzdi91UHhNMlpGa3VmUnZiTE9Rd1NIYWhpbG1pVG9SOUkrVFd6Nncx?=
 =?utf-8?B?Qk9tNEprTUxmc2JWanRhSFNLNU9DTFYyNDZYWUtyTzRGQ1dYOTdCWGV4YkRo?=
 =?utf-8?B?bWc0Y3BYWkdCdDZWTUlhSDZVblIzNmJMOU5od1R3YmQ5ZDc3SmwyRjBoaVhv?=
 =?utf-8?B?Ym82VW5wcE1jTll2YXd3cFV5YWJuOXpjY0d0bjU1Z3hGd3lOMlhaTVFuTm1l?=
 =?utf-8?B?VCtLMlF5MEx5OUtvMGF3dEREV3NHbS9HZG15N2F4N3RRV0NJcXZoRmx3eTVk?=
 =?utf-8?B?bitzRjJNeXVGd2NtOUUwQmJHdHdmd1NHeTZYd2svUndvQTRDQWlvbkhRaDlR?=
 =?utf-8?B?TmlvanZ0Uno1Tkk5U1VSWDVJZDRRbDM4V1ZkUTk1VkpvTGdLVGZHM2tYSThq?=
 =?utf-8?B?aDFDL205aFRFNisrM1h1WTh2OEhBZHJsSWpoZjAyWHB2ZGdiY2tDYkE5akhJ?=
 =?utf-8?B?d2d3elU5aDQ5OGxqUkxaVG1mTmtBQThlYmtnWTNKK2doUXB1aFNpQmtBS3p0?=
 =?utf-8?B?RXRxWDdqWG1YMGE4YjhUUVNGMEVRTTY3TG5sWWNsZGtNRWVHRGVzeU9ZYWhQ?=
 =?utf-8?B?WWtSSG1IS3pPOUdRSHRVUWpXYS9waGo5aklJSGJCdkdKcDJkZ0JXK3NBdXhT?=
 =?utf-8?B?TkZKYlgyc2M1WWxUSlMyS0kyVENCNHgwYWRKNGsvdi9iRndGVHhXejB1U1Jy?=
 =?utf-8?B?dHZwRjdwL3dURkVuNG91RkJPcW9hQnk2dDFQMUpLbE9CNnI5aHVFSDVGWmsw?=
 =?utf-8?B?YkVPWXM3MkNiUVNZb3FVcFFCNUxMZzdlMDJYUGFmSVdYdi9EMXNpc3pYTnhp?=
 =?utf-8?B?UExNclIvSW9RbEJKVVZTSG1xd2ZaZ1htallGS0dHWFpyU0p4RVYzSHV6MmhE?=
 =?utf-8?B?M0xDaG1rYmR5SHNWODUxNGliM3EwNXpJUDF3K2dTS1ZUQ2d6Q2dYcWxaVTk2?=
 =?utf-8?B?Z2Q2ZkZ1S21BbndGK3dKSUZpRjNtM0ZvWkErRVlYb1lVdFh1T0VhS0ZwWmo4?=
 =?utf-8?B?VjVGVWVrMHFjSVYwcXlJbUt5YWVaMWRpdGt0ZERZVG5YQWg3MUk2clNFcmkx?=
 =?utf-8?B?UjBLdU80d0pyVTRTNGdVQnV3bXNvZDB6dWRmWEdaM3FrSTc5eGlCSFRFN3di?=
 =?utf-8?B?TWdkTXp3WVZBR3JVRGc4Vk9mRWs3WjUvdDVYS2xPK1c4cG1UbzJkNCtOUlZG?=
 =?utf-8?B?VkNQSzlqZkYyUG8xZXBpWUNtYTBOMXNXeFVDMHJYMVJscEZlYzRPNFMvK3p0?=
 =?utf-8?B?L3VzcFRPRUhQc0l2RzU5ekh6YzdOaFR3eHQra3ROeWxMYTk0NHdHSDEzaE5R?=
 =?utf-8?Q?Si9AhMroMsQOO5xZxKU/JQR+zb6ccrMdUaEno=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2xmTUJZd0ZXT3JMQzZ4bHBQM21uUTljbmlhWnVwdTZUZlpPZTAzR05hZFkz?=
 =?utf-8?B?YmNncEY4QXFtY2wrY1RPeGtEVmZGYlk4eWY3TVNmazdwd0xFc2NFaUpBVlgx?=
 =?utf-8?B?YnNNUUhOdFQ5cEFUQVduTmVZTkdLemRPdlJmOTM0NTNmOURySm9hQWZmKytK?=
 =?utf-8?B?WHRTcVJITG9WOEoxbFppMVpyU1pTemkxMUN1cFI2UGIyUGFvV3BEVmVzRFd1?=
 =?utf-8?B?dGNGSFFFTy83SThzQ1JVdHY4WDkwTXhiOW1ySjlicmdlZVB0aXQzSFczZ3F3?=
 =?utf-8?B?OERuRTZGMHo5NDdtN0lKZXNQQVpwdzVNb0M3cHVuUW8vYVd6UXQ1SHBPZS9y?=
 =?utf-8?B?bGdrQWJiU29rYVZoV2sxWHRoS3RJNHd6eFRpYW54dDZYUTRMZ2JRVXpKOFM1?=
 =?utf-8?B?SjI1NjJDOUJXZUg5VHAyNXRWckNrcDFCdHRyaUwvekhFLzlsL2E2ZEJHZjA2?=
 =?utf-8?B?N2FjVHc1TkhFTkcwZEZqQVpFeng3cGNYS1VvN2xPelJ6MCtLeFNRb0lUTXJE?=
 =?utf-8?B?Y1ljeHlndEdETUFkdVhOVnRWcXBBU2ZFUnZ1bEFxRkt1cytQWjVqajZOMnM4?=
 =?utf-8?B?RjhDK0ZxRlk4NUlKSnZ5cE5KRTRiQzRGaWduck1JM1VYckc3YmF5ZXljOUx6?=
 =?utf-8?B?clVrL0pxMENDcjhxbXNuLzdXOHJVNXBHb3FseXoraEpBQnd2V21yNWtGOXdO?=
 =?utf-8?B?MXhBSTI5SmQyYnU2d2I0Q1o5MHY3MERiVVBpTHd5K0Rpd0dFK1ZHcjA5aDFp?=
 =?utf-8?B?dlNJbkI4VjdzOHZudmFiQTA5MFVqWmNBbGx6Tzh1V0tnRU9uNEdVN0c0amtY?=
 =?utf-8?B?cUFpVUgxamFHcG51cFNMcGF6emx3SDlpUTNVUHlleUErYXIzc01MSDFsVEVp?=
 =?utf-8?B?L3Nsbmp2ejY0UnBiZmNJY2xoR1Z0MWx5WktJWDUrSUphdFhablFvRGF6MU9a?=
 =?utf-8?B?dyswRjBhUjJCM2RrU1ROV1U5QW01OHVjYWhQWVBhTFRVWWM5T2lVRERBVnhH?=
 =?utf-8?B?a2ZYWUFYSmk2YUxjSnVqUVVLZHZOOGtXczM2eEN2aS9HcUJsVGJpUTNWMEJX?=
 =?utf-8?B?dDdHVDRSblpROGo4UW8xWWFzanJTYytQQ2Z0eVkySXVzOXhTVm10NitIMDRt?=
 =?utf-8?B?RGZvWnZCM2htS2NGa0ZCcE0xZXlvVlgxVmNsbklNcVhLNTRhTDhndVpJV2JK?=
 =?utf-8?B?VjFBSmV1V1dMbWhyMFRLbTVsNVA4SCtaeG0zQTBnakZQUkJsb2srVTBtaTlU?=
 =?utf-8?B?SytrdXVYVnpNMzNVbE1wNnhNeDVhRzVuUG9DUjh3QjlvU1VEYzJsQUtLcU1K?=
 =?utf-8?B?WThIUExOcGZJdEJacitDc1pFZVJ0dmlhMGlWODc5SGZLVUFBVEJxSkcvMVht?=
 =?utf-8?B?ZSt0MjQ0aG1qSytRTjRKdTJtaUJUOVdRODBLUThuSWg4YVBKZXdtelJqRGV5?=
 =?utf-8?B?dWNDQjU4cVlwcC9MYXJGRXc3bWJ1VTF1bjhVYVVDZ0lkeXR6RGpEL3JSd3Vx?=
 =?utf-8?B?YTh3VUZSeUI5MXRFV0N6R0ZhaERvRFVGMEovOVpTOGNoRWYvWmEyWnBSTE1M?=
 =?utf-8?B?Mi9KNktYZjNrblpmbVhxZGx6YXVVdUZSVldKOGxKMVgwZEI5RlBMaGllL0Jp?=
 =?utf-8?B?Z2tjUElqZjVYVURxaVBXVGl0SFY2c0pMU2lQSTVjYVhtOFZ2SkhZTXZGQ0di?=
 =?utf-8?B?S0l2SW53d1ZqNHd4cFY0ei9EeHFXK09UQjV0NEVjTzJSR0FrZ3p5Vml6VG9Z?=
 =?utf-8?B?bDRoVkNVK0xhR2J2VW5ISVV2V1FGSmVqb0tkTVhHbFdlcXhyUEI2N3lyY0dH?=
 =?utf-8?B?bDFYSEd0TjdsTUI3bk9vRVQ2MFU1bVIzYjd3UW1ZNEo1Z1hTTUZvZjlJWnhh?=
 =?utf-8?B?SVhSS0JZakR6VHBwV2N1TC9Yc3hxcmFya2JSc2I2MmdMT0tyaDhqTVFtcUVD?=
 =?utf-8?B?TmxzMExzQmdRZm1xZndSQkJlVjdGMkI5Yi9BRkY1c1BCTjIvKytWMG9rcU9M?=
 =?utf-8?B?Qy9vT3ZzcEVTMVlIVEh0emZBbEkzRlNlRzRGcUUvNkRkaXhpbmdFK2tmb3p2?=
 =?utf-8?B?RUdsa0F0NVJremZyeTcyMUVnVjRMRmorR2FMQ0hRWG5oalhWdWdSOXZJWFVT?=
 =?utf-8?Q?0HoDzYHV/BE5C78sTHMcT0Vzs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E945682DBB412468B4993CD3C9E52CC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab447829-4606-48ce-5744-08dca7a7fd68
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 04:05:13.2155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKbYbI6c37gM4jFCg4Kd6oxPxhUzb/0vvTkaDFoqNoDMUtQfTuSxgPbrtJjncD6JvJZQ8U5PF4pj3Zg71+7Fiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8800

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
DQoNCj4gK3N0YXRpYyBpbnQgZHBfdHhfaGRjcDJ4X2VuYWJsZV9hdXRoKHN0cnVjdCBtdGtfaGRj
cF9pbmZvICpoZGNwX2luZm8sIGJvb2wgZW5hYmxlKQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZHAg
Km10a19kcCA9IGNvbnRhaW5lcl9vZihoZGNwX2luZm8sIHN0cnVjdCBtdGtfZHAsIGhkY3BfaW5m
byk7DQo+ICsJdTMyIHZlcnNpb247DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWRwX3R4X2hkY3Ay
eF9zZXRfYXV0aF9wYXNzKGhkY3BfaW5mbywgZW5hYmxlKTsNCj4gKwlpZiAoIWVuYWJsZSkgew0K
PiArCQlyZXQgPSB0ZWVfaGRjcF9lbmFibGVfZW5jcnlwdChoZGNwX2luZm8sIGVuYWJsZSwgSERD
UF9OT05FKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsJCW10a19kcF91
cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9FTkMwX1AwXzMwMDAsIDAsIEhEQ1BfRlJBTUVfRU5f
RFBfRU5DMF9QMCk7DQo+ICsNCj4gKwkJcmV0dXJuIDA7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKEhE
Q1BfMl8yX0hEQ1AxX0RFVklDRV9DT05ORUNURUQoaGRjcF9pbmZvLT5oZGNwMl9pbmZvLmhkY3Bf
cngucmVjdmlkX2xpc3QucnhfaW5mb1sxXSkpDQo+ICsJCXZlcnNpb24gPSBIRENQX1YxOw0KDQpk
cF90eF9oZGNwMnhfZW5hYmxlX2F1dGgoKSBpcyBjYWxsZWQgb25seSB3aGVuIEhEQ1AgMi54LCBi
dXQgaGVyZSBkZXRlY3QgdGhhdCB2ZXJzaW9uIGlzIDEuDQpJIGRvbid0IGtub3cgdGhlIHNwZWNp
ZmljYXRpb24gb2YgSERDUCwgaXMgdGhpcyBpcyBhbiBlcnJvciBjYXNlPw0KT3IgaWYgdGhpcyBp
cyBhIG5vcm1hbCBjYXNlLCBwbGVhc2UgYWRkIHNvbWUgY29tbWVudCBoZXJlIHRvIGV4cGxhaW4g
Zm9yIHNvbWVvbmUgd2hvIGRvbid0IGtub3cgSERDUCBzcGVjaWZpY2F0aW9uLg0KDQpSZWdhcmRz
LA0KQ0sNCg0KPiArCWVsc2UgaWYgKEhEQ1BfMl8yX0hEQ1BfMl8wX1JFUF9DT05ORUNURUQNCj4g
KwkJKGhkY3BfaW5mby0+aGRjcDJfaW5mby5oZGNwX3J4LnJlY3ZpZF9saXN0LnJ4X2luZm9bMV0p
KQ0KPiArCQl2ZXJzaW9uID0gSERDUF9WMjsNCj4gKwllbHNlDQo+ICsJCXZlcnNpb24gPSBIRENQ
X1YyXzM7DQo+ICsNCj4gKwlyZXQgPSB0ZWVfaGRjcF9lbmFibGVfZW5jcnlwdChoZGNwX2luZm8s
IGVuYWJsZSwgdmVyc2lvbik7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwlt
dGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfRU5DMF9QMF8zMDAwLA0KPiArCQkJICAg
SERDUF9GUkFNRV9FTl9EUF9FTkMwX1AwLCBIRENQX0ZSQU1FX0VOX0RQX0VOQzBfUDApOw0KPiAr
DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCg==

