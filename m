Return-Path: <linux-kernel+bounces-293283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FA957CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A06B1C23D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F032B1494CC;
	Tue, 20 Aug 2024 05:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZX4Nl4V8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AVeCmxPY"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6F43AA8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133398; cv=fail; b=DdbgZ/Vzi+JOTldv3fFLYNTe/xr9HEXdeRWjotFJ/58h66OzYElHj8y9VNblRfSMNHXVUBiCZpfV3aHplMuTLI59L4KlxHGpvXiJAbz/SlHSVOXH7Td1HvFHk3fmZ+0vjLfpFomOC8aSwD5Z5WarPc6Vt58LT0+A0qJ4ijQ76c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133398; c=relaxed/simple;
	bh=TgbNqCtaIl6zcCbazaPEmxW3fyvtZ8Rg2Gmf7wx3J6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qn1oneTCrW0YCKhOVJwJgPwYk5ylJZEh8MXq2eo4ZN1QzBrcdF/jcDfWuY2C1g0PRuKmPdGAgfg/VBEJlTwpViFn03Gu2+iY8Mvn8p3+psjQ+7yc1tDzibaWr2xz/rgl3aryN/9Rd7vBGWUsEPur/wXXqd2D3GH/WTAIEAtuOkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZX4Nl4V8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AVeCmxPY; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eb59ee505eb811ef8593d301e5c8a9c0-20240820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TgbNqCtaIl6zcCbazaPEmxW3fyvtZ8Rg2Gmf7wx3J6o=;
	b=ZX4Nl4V8196ALjmdN6qdlvZNwgzJMceBAitZDKNa9KYLR5U/gFDdw28LNS5ihUy8uJz8IkC0ZfQXaBcjlppk/aPIfgM3p5aJHbS/wve3SuReuNrI1IV6liItW2BFC5UmAKH9gL3kfT8J5/KWBpugQQOsQ2hEYWkrHJWxZdQFe4I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:236b3327-c8af-45f4-95ed-1bafeed60b89,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:05cbb85b-248b-45cb-bde8-d789f49f4e1e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: eb59ee505eb811ef8593d301e5c8a9c0-20240820
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1622098850; Tue, 20 Aug 2024 13:56:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Aug 2024 13:56:19 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Aug 2024 13:56:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEvm6rWiRZ8oKem/2RXXO/WvpE/8qytWPGBU43V3lsFIK58Rw8nBnOHLw371pdhdHM9tg6nBDXwfHlSheMMylU2Z6YpbUksiy2XBx+w7im/lHIZiKS5NXFoCExK6PHbkkUunLSg3jrLASsFexVc6ws7zKdxebf2fu4yon9ZsWPcGJNcxuVnuvYnzcgpBoNOMx5TdcFLaT9QN5Xp/O3BgqB/tIFawSq6c6Su54/QudKgS+GM+rbwwiIx13+3Z4qpnceIAN90wQRUndA9YDT8bmPvEghKPkYG663C/+qV1bLKm9gsNV+RQfSs/Q1lgORgbey8eDnkzxUMPW1DoeP0+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgbNqCtaIl6zcCbazaPEmxW3fyvtZ8Rg2Gmf7wx3J6o=;
 b=PRuCF847r22pwS62v6/ern9Npzbb8VaXxJqwJVJJ6RMT/TlqXLZ5Pc/DtB6fZD1RSepCJ41GsVl7AC6kPi0lxIW6mHSCsg3EFaPgNbZAFOPGz1b3opp85HDGwJtVGCnj0unu0zstTvANwtk9V7kcc7C/fXnMFJX0W/SJwMl5/IcNYM8pGez7evvi5VjKWmhVYMZSnLBJVryuIKaitlQlEnuCJlO41ueyYZg9Gw+MDMhAN7uaJr65wlSbTURpeJ9xp3/DwZfc9/QesM0eOeIUTw43jQunL99mrlbTRlnjTZ1fFbpmBTa2fOazodxcpqpQHgd3zBUGGIYpFmnXFBiZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgbNqCtaIl6zcCbazaPEmxW3fyvtZ8Rg2Gmf7wx3J6o=;
 b=AVeCmxPYzIVp/1dVB8qLcyHUuTxJoabFIoubeCKEDTt1feHmDVFJ2FhgwRYIa2/qNZtoV3uQ3tKTYsa83fODqXA8B/oUrdaVzOZ/Pz6b1JxzgAMLpDrLjC/cPPoUYfbAbMIR5vSao2CxXqKvrNPi/LDIM6IO0OZvgb3lSnV6OV0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7958.apcprd03.prod.outlook.com (2603:1096:101:17d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 05:56:15 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 05:56:14 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] drm/mediatek: Fix missing configuration flags in
 mtk_crtc_ddp_config()
Thread-Topic: [PATCH v2] drm/mediatek: Fix missing configuration flags in
 mtk_crtc_ddp_config()
Thread-Index: AQHa8kwpokoD1LM1p0OJnhuMoDm0oLIvpruA
Date: Tue, 20 Aug 2024 05:56:14 +0000
Message-ID: <2a7b8d46a0358dfe538de1299d2d7c5c5c3ab626.camel@mediatek.com>
References: <20240819-drm-fixup-0819-v2-1-a03580ece3ec@mediatek.com>
In-Reply-To: <20240819-drm-fixup-0819-v2-1-a03580ece3ec@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7958:EE_
x-ms-office365-filtering-correlation-id: 2355a8d9-789a-40ae-9bc1-08dcc0dcccfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d1YxVWMwalBQMVNmaWNZcDhZMEQ5SjlGbThrd1ZiVVNJaGdZUS9IaE1HbU9k?=
 =?utf-8?B?M3RyM3gyR2V1Zkp4b2tFN2hFbVU5VlQvWE1RbmZRTU9yQVl6dEduZlJqdTFj?=
 =?utf-8?B?dFlVeFdJeXQwaWNCMzlqQW1TbCtzSDFyR2ZpNTRFUFBrYXk2RXVTUEJIVHJt?=
 =?utf-8?B?ZGQ3V3pGaHYwUDFrMXhUSis5SG5QT05uM0JRZ2g0L1oybXpCRVNQT3N3cS9w?=
 =?utf-8?B?bWdqT1RaZHkxVnpwUC8vWnJOSzlJVzhaT3p5YlhRSExGcitZVU54NjJ3TnJT?=
 =?utf-8?B?SDhMbUJyazM0RFRHcG53akJSODFLVVQ0RlpyK2ZneFlHSXNianpERzVjTjh1?=
 =?utf-8?B?TTY3MjMvSVhiM1ByemU5YlJweGd2dUQ2a2c4Qng1NlIrcmZMZjlHdXN3UFhX?=
 =?utf-8?B?bmVRUTRlTkx1dE92Si84VXEwWjB3Tjl3cnhmZVl4M2JSZnlUc2gxRGVsQmJ5?=
 =?utf-8?B?aC9SVStlV2RINGxQNnZIS0VTNmtoNEhCVlhoSG1Edml0OUNpU2tvYnFtT2RJ?=
 =?utf-8?B?cW16amxKZEsxaCtCNkFvWXRHVGd3MDQ2bG8wNnQvTHJxU25jalhNS0RscXc2?=
 =?utf-8?B?Lyt5b0p5MXg3M2hzbjBqcjhvSHJYTmZwWkhCWDAremlFL2YzZVQzVUVibmtp?=
 =?utf-8?B?bHVLbmFTcVpybFNjVDdWcnN6WXpraU1MYUpVekxldCtCTTl2Zlpoc0VkWERu?=
 =?utf-8?B?QU80VUJzSXhEb0o4QXFBeTAyMXlYYy9SemswdkdFU3R3Q0JVb255TzhuT1d5?=
 =?utf-8?B?R0M2d3RrZFVLRjEvS2swTUxzdmhSZTlMMU9xMDBXd3hsR2pKVnZ3TjdTaElr?=
 =?utf-8?B?ZHVNeXZsZ3pwS0JJQlM2a0pQTEhFRDcyUFdEZVhFN2hIWW9QMmlkRW5wN1dz?=
 =?utf-8?B?T3V5OVFUUUpDbnN1cmpFbmlYNmZrVEJldzdYcGlYUWl5blkxMUp5ek0xbXFJ?=
 =?utf-8?B?WHhpWU9RaDdmN3plNnc1c0c3ZFBHMGJqNjkxeXduWU1jbmdMTk1JdG5HcTc4?=
 =?utf-8?B?TS9BU0lHdXR3Yy9FUjRaNFlaVlFCektzaEZkU0oxQ2JYeDNQOUNidFoybHU5?=
 =?utf-8?B?SHo0VXRoYk9ucFdoOUQ3ZFI1VzdUMjh4d2swN2FWRHZjL2pwKzNFT0Ztb0Zi?=
 =?utf-8?B?K01kelpNVnBtbWRFeWU5K3dXdG5aWGR4WTJkWFBrZUphT3ppY2xWalF1OTZG?=
 =?utf-8?B?U0Nxc2NLZFF1ck1CY2pCWTNsYjRoeHZMeTBMVmxkcjhCRCszUFFPdWNYWk14?=
 =?utf-8?B?MEJQUElHWFV5OXQ1M0lMbktMbURydHhZL3ZHMzc2b05IM2U1Z1BiQ2c5TTFl?=
 =?utf-8?B?WUhvcFVWakxRTVI0TjJQQ2pCN2xTOGRheVphNXNYVkdMSGg2dzNQZXFLcm1p?=
 =?utf-8?B?ZkR2R2t4T3FrK3JNemxNcUVjcllXSXNMT3dGU29STjA1bnV3dTdKYnI1ZTVt?=
 =?utf-8?B?R0JrNkxwMWxZY1ljcUJBUXVBSDE4ZnI5Y1hrekl3c0ozUzRRaFI1VFZ5eDZs?=
 =?utf-8?B?eC8wMHlEYWJ1TElrS1IwbmhBMnNkN29ybFB6NHBFUllFVngyOXZ0cS9lZ2xD?=
 =?utf-8?B?cmV6TS9tNlV2YURkcGt4YUxuQ3pqQTk5a0pxM2luSmsremNTOXl1ekJhVkFa?=
 =?utf-8?B?V1l4VVJsT3pJUmdTQVkrZ3ZQYTBBaTZNUUdJcS92UHk3QTRaNDcwa2Y1azRx?=
 =?utf-8?B?ZktBNGRrYzFmTnJVbm5uZUFMd0V5QTRVWmtwUjV3emRLcUpMMWFPZ2xKd1Z3?=
 =?utf-8?B?ajdab3hTWFFnYTRnR1FkdHdJek9aTE0yUVpNY0dxemRZTnhjamlSeEsrblBK?=
 =?utf-8?B?Y2xsTitobGJUYnBKMktwS2Q0bWFxU1JQZHVscmJhb0twSElUbWZHckllN2FR?=
 =?utf-8?B?aVVQQW1mUG5jVm15WDlyMCtyYnBoK2ZtK0lJVDFTbUgyNVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWx5SWJYSW9OMU16UzNTUXo3TDdsSWZ5L2FBMW1VUlFzM29qQ2xZQzJMWmJJ?=
 =?utf-8?B?SVBENlRjbWpyb1huaXV6aHF3RXdQelJLbzhTYUZwVHBwRUxpL1M5Z1JLRGx6?=
 =?utf-8?B?NHU1Z2ROa09Fc1NqUkRZL0hMQXhmRHE0b0MwL3h6Ylc4OGk3Z3pJc2hMVDhn?=
 =?utf-8?B?WGtENXNiTjBVN2gwak1WeUwvbCtFVzR2cENSbkdzZUdMYW1CZlJ5UDFDNk16?=
 =?utf-8?B?V2FIazRJNXlWVVJyMlBHR0NXVmI1ZkREL3ZkYlZwT3JZM3QrQStjOHQzWUFK?=
 =?utf-8?B?MXdPZjBodU1FanZSREN3N01zRThZZEhFQkxiUFlNZ2RSMC9pb1Y0TEwxaVpX?=
 =?utf-8?B?eGZ1dy90MmhYcThpQnY1SDR6aFNaRDAvZDlDUzQzUVJPckFvQVNKTXlOOXZN?=
 =?utf-8?B?dkE2Y09KZHdLcXFrNDFXYno1QTUrNVJpeDd2NWU2K3ppdm1QclFyZlJTWENP?=
 =?utf-8?B?em5pdE15dUFMOTBuV2E0Mml1cEZIekFQajFaY1kreXNHMGNyeGlvRVhzT21t?=
 =?utf-8?B?cTFFajRIOEgwbUI0cEtWVWdhTjVYTlJRNGhJV0NZd2NHRldrTlZWQVgzVTVL?=
 =?utf-8?B?SlNsTnhGVXlvVzJiejZUSHZzd3FUNEJkMU1aa09QR2h0YTYyRWxibWFTRUVt?=
 =?utf-8?B?U3Vxd3lQQkVITSs5MWVtU3RCUVhwVk4rZ0lNK1VkQUdVUzY0TmR2SlNMQ2lv?=
 =?utf-8?B?bzNFekk0YjFvc2l1V2p6RlhTakMzTGMwTGFzWk5GeWVqV2MzOUl5cGFvY0dT?=
 =?utf-8?B?VnBwOGp6Yko3SnpkOEF6TlUxdUJVdE5iNXZYakNBcFdRVHRwNytHSHFDY3Q0?=
 =?utf-8?B?b1lJTTRKbkV5MExyV3l1VURaTDFoUTZ6N3h3K2wvdENXMW1xN0RzUFVLR21I?=
 =?utf-8?B?WXBKaTR4bUc3Q0ZtcUl4OHlxM05UdGE0dnJob0NVdU9xb1pVWXp3TWRjcVVT?=
 =?utf-8?B?bVdlK2RKeEpvcys1RUNMZ21QL2g5U2pjQWhVT0R0YU9UUjExMTdPbGtjcTE1?=
 =?utf-8?B?aGg5U3lPeXAzUVFodXl2b3N1OHFtUEszY3pNZTFJVDZkMmtWQ0x2SEs0OUlu?=
 =?utf-8?B?bU5tTlpCQWxmUDV0NnBybGlYdlMzeU1RN3Q3eFZrQ1N5cEp0Ym5MMVEvRmFy?=
 =?utf-8?B?SmJIeEVCU1J5TCtkTVlUSnVWTmtpbmVFUjA4d1UvempKRk1BakhmZVNYOFJ3?=
 =?utf-8?B?MzYxeTNLY0ltR21mc3l6bXBiNDBiUU83alNOWCt2VW5uOE5JVDM0aUV3bFBF?=
 =?utf-8?B?Z0RpL2hJZXZaZXlHOHo2dXg5enJwNXJCMUJleTNDTzVXTzZnRDVXcEVra3pW?=
 =?utf-8?B?eHJCN1RlMDA1Q3JmOVVkNE5jTUdSaTlHV1drbk1aWmkyaEFETWxPMWR5cjIx?=
 =?utf-8?B?U0dhOUY1bGJGM2JFc3gwanYrMjdBQ2Y1SVhiOTJJNEExZ2hyNnAxNGd4WEVC?=
 =?utf-8?B?QURXRHh4VE13QUJHRTFtWnNXNmhvYTZMWEx4OCtWV0ZIL1ZmczlyUVkyNnEy?=
 =?utf-8?B?c3NNNG9BVGV3NUZvNE1QalFQWlJWOGg1d2R1WVdpUWJrb3pVWVQvQUlpWUhS?=
 =?utf-8?B?OEo2WEVJYnpXZmpNaGRlVTFUaWJOSk5Xa3FHdFhrNEs3ekYzM3MzU1NaTzVS?=
 =?utf-8?B?c21Vb3FHYndPelNaVWM2M1lxTGoycEJpWWFKOGpuNDVMNVNrdFRxMWZCaUxq?=
 =?utf-8?B?SVZKTU05SzJSamVwN1NTdzRmdkpEK0g3K2piSlBaUG9zd0xDbG1LVGZzd0xn?=
 =?utf-8?B?T3djY0F5VTJCaTdUQVg1N3VXUldlUWx1R01LUTlZdks0UmVYYjRMdzhiWjMx?=
 =?utf-8?B?ZytOUXJ1SHd3SUdWanZLdzV4UXczOTdGTnUzUVBJVjBTM1FOSDI0YkZDdDFX?=
 =?utf-8?B?VG53Y3dZdWN2YnpHL3dvRkVldWpyWmRXbFhxMWQwKzJmZDRDWE9yc3JYVEV4?=
 =?utf-8?B?STNhWjB2USt0T1VMMWZpdzZyRWU1dUJWU3E3eTNoRUZHUjZlQU5WOFlnK3dp?=
 =?utf-8?B?WXR0dHBmRzBWNlpyRW1yVEVRVzA2UzUwTnZNL1B1cWlQcytseEFrTlVoRS9l?=
 =?utf-8?B?MUxuS3d4ZnR5TlZVcFFpUWw4R2srTDBMY01lK21FRUtuRTdPQXprZG9lOFRQ?=
 =?utf-8?Q?Xa5Jwt0agRW0gTPJbF4KQktIU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EED3766EC3C4140825BEE6B84756870@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2355a8d9-789a-40ae-9bc1-08dcc0dcccfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 05:56:14.3865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jna9rfNNAQuIdHfFGbejGrE8ic8A65KCZXRG5nGIvBo64BdH/l2NTG1XJ++oXSmNH0yXcWAvsRaGbz3GUTfqVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7958
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--27.680900-8.000000
X-TMASE-MatchedRID: 8+bhjh9TQnH4OiVTWoD8RCa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCk2VnXMRzIBjM8ORI7N4NZbUqhJbkmLVe7/A+0D1to6P9Ng
	smL8Bq9hQEoNHPY5y0Agm5qcgW8yDFTogJImN/3s6N/cDgNNi4bWTdtEh1dU0q8z7POX8FJMDdb
	qf2nbl9KGBfdklbHH5oWFwdFy9edolLXaRonFeEQPZZctd3P4Bbd6rGhWOAwQKogmGusPLb7ovK
	ovaKnx4ujf9yj7KQrqlNYPZYfiOdM9tfSEZlKTRDB+ErBr0bAOZ2scyRQcer2O8D0RGuSzo4nPT
	8jZv1NHi8zVgXoAltj2Xsf5MVCB1t7DW3B48kkHdB/CxWTRRuyUIayx+Skid
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--27.680900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	EFDCD849C59B47025622C58C6B747AB609F62A4F2C71F053A1D91E884673F1C82000:8

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjQtMDgtMTkgYXQgMjM6MjUgKzA4MDAsIEphc29uLUpI
LkxpbiB2aWEgQjQgUmVsYXkgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFz
ZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgRnJvbTogIkphc29uLUpILkxp
biIgPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IA0KPiBJbiBtdGtfY3J0Y19kZHBfY29u
ZmlnKCksIG10a19jcnRjIHdpbGwgdXNlIHNvbWUgY29uZmlndXJhdGlvbiBmbGFncyB0bw0KPiBn
ZW5lcmF0ZSBpbnN0cnVjdGlvbnMgdG8gY21kcV9oYW5kbGUsIHN1Y2ggYXM6DQo+ICAgc3RhdGUt
PnBlbmRpbmdfY29uZmlnDQo+ICAgbXRrX2NydGMtPnBlbmRpbmdfcGxhbmVzDQo+ICAgcGxhbmVf
c3RhdGUtPnBlbmRpbmcuY29uZmlnDQo+ICAgbXRrX2NydGMtPnBlbmRpbmdfYXN5bmNfcGxhbmVz
DQo+ICAgcGxhbmVfc3RhdGUtPnBlbmRpbmcuYXN5bmNfY29uZmlnDQo+IA0KPiBUaGVzZSBjb25m
aWd1cmF0aW9uIGZsYWdzIG1heSBiZSBzZXQgdG8gZmFsc2Ugd2hlbiBhIEdDRSBJUlEgY29tZXMg
Y2FsbGluZw0KPiBkZHBfY21kcV9jYigpLiBUaGlzIG1heSByZXN1bHQgaW4gbWlzc2luZyBwcmVw
YXJlIGluc3RydWN0aW9ucywNCj4gZXNwZWNpYWxseSBpZiBtdGtfY3J0Y191cGRhdGVfY29uZmln
KCkgd2l0aCB0aGUgZmxhc2UgbmVlZF92YmxhbmsgKG5vIG5lZWQNCj4gdG8gd2FpdCBmb3IgdmJs
YW5rKSBjYXNlcy4NCj4gDQo+IFRoZXJlZm9yZSwgdGhlIG10a19jcnRjLT5jb25maWdfdXBkYXRp
bmcgZmxhZyBpcyBzZXQgYXQgdGhlIGJlZ2lubmluZyBvZg0KPiBtdGtfY3J0Y191cGRhdGVfY29u
ZmlnKCkgdG8gZW5zdXJlIHRoYXQgdGhlc2UgY29uZmlndXJhdGlvbiBmbGFncyB3b24ndCBiZQ0K
PiBjaGFuZ2VkIHdoZW4gdGhlIG10a19jcnRjX2RkcF9jb25maWcoKSBpcyBwcmVwYXJpbmcgaW5z
dHJ1Y3Rpb25zLg0KPiBCdXQgc29tZWhvdyB0aGUgZGRwX2NtZHFfY2IoKSBkaWRuJ3QgdXNlIHRo
ZSBtdGtfY3J0Yy0+Y29uZmlnX3VwZGF0aW5nDQo+IGZsYWcgdG8gcHJldmVudCB0aG9zZSBwZW5k
aW5nIGNvbmZpZyBmbGFncyBmcm9tIGJlaW5nIGNsZWFyZWQuDQo+IA0KPiBUbyBhdm9pZCBtaXNz
aW5nIHRoZSBjb25maWd1cmF0aW9uIHdoZW4gZ2VuZXJhdGluZyB0aGUgY29uZmlnIGluc3RydWN0
aW9uLA0KPiB0aGUgY29uZmlnX3VwZGF0aW5nIGZsYWcgc2hvdWxkIGJlIGFkZGVkIGludG8gZGRw
X2NtZHFfY2IoKSBhbmQgYmUNCj4gcHJvdGVjdGVkIHdpdGggc3Bpbl9sb2NrLg0KDQpSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gRml4ZXM6IDdmODJkOWM0
Mzg3OSAoImRybS9tZWRpYXRlazogQ2xlYXIgcGVuZGluZyBmbGFnIHdoZW4gY21kcSBwYWNrZXQg
aXMgZG9uZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1l
ZGlhdGVrLmNvbT4NCj4gLS0tDQo+IENoYW5nZSBpbiB2MjoNCj4gQWRkIHNwaW5fbG9jayBwcm90
ZWN0aW9uIGZvciBjb25maWdfdXBkYXRpbmcgZmxhZy4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2NydGMuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfY3J0Yy5jDQo+IGluZGV4IDZmMzRmNTczZTEyNy4uYjc1MmMwYjQ2MzgzIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiBAQCAtNjksNiArNjksOCBAQCBzdHJ1
Y3QgbXRrX2NydGMgew0KPiAgLyogbG9jayBmb3IgZGlzcGxheSBoYXJkd2FyZSBhY2Nlc3MgKi8N
Cj4gIHN0cnVjdCBtdXRleGh3X2xvY2s7DQo+ICBib29sY29uZmlnX3VwZGF0aW5nOw0KPiArLyog
bG9jayBmb3IgY29uZmlnX3VwZGF0aW5nIHRvIGNtZCBidWZmZXIgKi8NCj4gK3NwaW5sb2NrX3Rj
b25maWdfbG9jazsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBtdGtfY3J0Y19zdGF0ZSB7DQo+IEBA
IC0xMDcsMTAgKzEwOSwxMyBAQCBzdGF0aWMgdm9pZCBtdGtfY3J0Y19maW5pc2hfcGFnZV9mbGlw
KHN0cnVjdCBtdGtfY3J0YyAqbXRrX2NydGMpDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHJtX2Zpbmlz
aF9wYWdlX2ZsaXAoc3RydWN0IG10a19jcnRjICptdGtfY3J0YykNCj4gIHsNCj4gIGRybV9jcnRj
X2hhbmRsZV92YmxhbmsoJm10a19jcnRjLT5iYXNlKTsNCj4gKw0KPiArc3Bpbl9sb2NrKCZtdGtf
Y3J0Yy0+Y29uZmlnX2xvY2spOw0KPiAgaWYgKCFtdGtfY3J0Yy0+Y29uZmlnX3VwZGF0aW5nICYm
IG10a19jcnRjLT5wZW5kaW5nX25lZWRzX3ZibGFuaykgew0KPiAgbXRrX2NydGNfZmluaXNoX3Bh
Z2VfZmxpcChtdGtfY3J0Yyk7DQo+ICBtdGtfY3J0Yy0+cGVuZGluZ19uZWVkc192YmxhbmsgPSBm
YWxzZTsNCj4gIH0NCj4gK3NwaW5fdW5sb2NrKCZtdGtfY3J0Yy0+Y29uZmlnX2xvY2spOw0KPiAg
fQ0KPiAgDQo+ICAjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4gQEAgLTMxNCw2
ICszMTksMTMgQEAgc3RhdGljIHZvaWQgZGRwX2NtZHFfY2Ioc3RydWN0IG1ib3hfY2xpZW50ICpj
bCwgdm9pZCAqbXNzZykNCj4gIA0KPiAgc3RhdGUgPSB0b19tdGtfY3J0Y19zdGF0ZShtdGtfY3J0
Yy0+YmFzZS5zdGF0ZSk7DQo+ICANCj4gK3NwaW5fbG9jaygmbXRrX2NydGMtPmNvbmZpZ19sb2Nr
KTsNCj4gKw0KPiAraWYgKG10a19jcnRjLT5jb25maWdfdXBkYXRpbmcpIHsNCj4gK3NwaW5fdW5s
b2NrKCZtdGtfY3J0Yy0+Y29uZmlnX2xvY2spOw0KPiArZ290byBkZHBfY21kcV9jYl9vdXQ7DQo+
ICt9DQo+ICsNCj4gIHN0YXRlLT5wZW5kaW5nX2NvbmZpZyA9IGZhbHNlOw0KPiAgDQo+ICBpZiAo
bXRrX2NydGMtPnBlbmRpbmdfcGxhbmVzKSB7DQo+IEBAIC0zNDAsNiArMzUyLDEwIEBAIHN0YXRp
YyB2b2lkIGRkcF9jbWRxX2NiKHN0cnVjdCBtYm94X2NsaWVudCAqY2wsIHZvaWQgKm1zc2cpDQo+
ICBtdGtfY3J0Yy0+cGVuZGluZ19hc3luY19wbGFuZXMgPSBmYWxzZTsNCj4gIH0NCj4gIA0KPiAr
c3Bpbl91bmxvY2soJm10a19jcnRjLT5jb25maWdfbG9jayk7DQo+ICsNCj4gK2RkcF9jbWRxX2Ni
X291dDoNCj4gKw0KPiAgbXRrX2NydGMtPmNtZHFfdmJsYW5rX2NudCA9IDA7DQo+ICB3YWtlX3Vw
KCZtdGtfY3J0Yy0+Y2JfYmxvY2tpbmdfcXVldWUpOw0KPiAgfQ0KPiBAQCAtNTcxLDcgKzU4Nywx
MSBAQCBzdGF0aWMgdm9pZCBtdGtfY3J0Y191cGRhdGVfY29uZmlnKHN0cnVjdCBtdGtfY3J0YyAq
bXRrX2NydGMsIGJvb2wgbmVlZHNfdmJsYW5rKQ0KPiAgaW50IGk7DQo+ICANCj4gIG11dGV4X2xv
Y2soJm10a19jcnRjLT5od19sb2NrKTsNCj4gKw0KPiArc3Bpbl9sb2NrKCZtdGtfY3J0Yy0+Y29u
ZmlnX2xvY2spOw0KPiAgbXRrX2NydGMtPmNvbmZpZ191cGRhdGluZyA9IHRydWU7DQo+ICtzcGlu
X3VubG9jaygmbXRrX2NydGMtPmNvbmZpZ19sb2NrKTsNCj4gKw0KPiAgaWYgKG5lZWRzX3ZibGFu
aykNCj4gIG10a19jcnRjLT5wZW5kaW5nX25lZWRzX3ZibGFuayA9IHRydWU7DQo+ICANCj4gQEAg
LTYyNSw3ICs2NDUsMTAgQEAgc3RhdGljIHZvaWQgbXRrX2NydGNfdXBkYXRlX2NvbmZpZyhzdHJ1
Y3QgbXRrX2NydGMgKm10a19jcnRjLCBib29sIG5lZWRzX3ZibGFuaykNCj4gIG1ib3hfY2xpZW50
X3R4ZG9uZShtdGtfY3J0Yy0+Y21kcV9jbGllbnQuY2hhbiwgMCk7DQo+ICB9DQo+ICAjZW5kaWYN
Cj4gK3NwaW5fbG9jaygmbXRrX2NydGMtPmNvbmZpZ19sb2NrKTsNCj4gIG10a19jcnRjLT5jb25m
aWdfdXBkYXRpbmcgPSBmYWxzZTsNCj4gK3NwaW5fdW5sb2NrKCZtdGtfY3J0Yy0+Y29uZmlnX2xv
Y2spOw0KPiArDQo+ICBtdXRleF91bmxvY2soJm10a19jcnRjLT5od19sb2NrKTsNCj4gIH0NCj4g
IA0KPiBAQCAtMTA2OCw2ICsxMDkxLDcgQEAgaW50IG10a19jcnRjX2NyZWF0ZShzdHJ1Y3QgZHJt
X2RldmljZSAqZHJtX2RldiwgY29uc3QgdW5zaWduZWQgaW50ICpwYXRoLA0KPiAgZHJtX21vZGVf
Y3J0Y19zZXRfZ2FtbWFfc2l6ZSgmbXRrX2NydGMtPmJhc2UsIGdhbW1hX2x1dF9zaXplKTsNCj4g
IGRybV9jcnRjX2VuYWJsZV9jb2xvcl9tZ210KCZtdGtfY3J0Yy0+YmFzZSwgMCwgaGFzX2N0bSwg
Z2FtbWFfbHV0X3NpemUpOw0KPiAgbXV0ZXhfaW5pdCgmbXRrX2NydGMtPmh3X2xvY2spOw0KPiAr
c3Bpbl9sb2NrX2luaXQoJm10a19jcnRjLT5jb25maWdfbG9jayk7DQo+ICANCj4gICNpZiBJU19S
RUFDSEFCTEUoQ09ORklHX01US19DTURRKQ0KPiAgaSA9IHByaXYtPm1ib3hfaW5kZXgrKzsNCj4g
DQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNDY5ZjFiYWQzYzFjNmUyNjgwNTlmNzhjMGVlYzdlOTU1
MmIzODk0Yw0KPiBjaGFuZ2UtaWQ6IDIwMjQwODE5LWRybS1maXh1cC0wODE5LWY1MWUyZDM3ZmNk
Nw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLSANCj4gSmFzb24tSkguTGluIDxqYXNvbi1qaC5s
aW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gDQo=

