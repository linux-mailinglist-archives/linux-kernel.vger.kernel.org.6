Return-Path: <linux-kernel+bounces-382890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7033B9B148D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3254A2835EB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A4146A69;
	Sat, 26 Oct 2024 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JmyG11wA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bQzJfQ9b"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973113CA99
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729915842; cv=fail; b=Bj4yjVuCPlBhVAX+EtS3y9UssW9TFYujtG5wTGH7vV5/pJRrmQPJqrI7+lr+t/QMXX8azQPil91v9Y8umh4iqqke9fGsjy9r22HfRBMNJBvls6L5IPK83+FShQwzd+e5Y/csXxli/oEveGZcjgnmOLesd1b7gkfl+XnOYoyzoGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729915842; c=relaxed/simple;
	bh=xGxRDm4l6gYjN9xDrCoFNxhEf5Av55KeqRbz8JvcoPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8U5eNngC9zr4CTaBkC3u6WSOcq/w7FF1a2OiARk/2KdbhG5v1LgE/Rf3XZ3J1eb08OTtv2t4/VtVQi7EKH0YBzWHxSNVqXbMXgSE/DXpHEfrKOHOrHQIc9Zr2tBWXGYrVd5MElSm9NGRMpqVOEhadwc/BcEb+CyxlKbm2nNnKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JmyG11wA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bQzJfQ9b; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3f32d62e935011efb88477ffae1fc7a5-20241026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xGxRDm4l6gYjN9xDrCoFNxhEf5Av55KeqRbz8JvcoPk=;
	b=JmyG11wAw/HXjyd5VLVCJS2mbn6qZXq0fcOP/BLctv7Pqv17BBNEmdrMhGhgLuyz4JC3PrB3Zgd38hCPQG1B96B6MC3MRntONdtq0Ej+VFGXSBzofFHCh8N1nEEKzEj43mpHk+Y0J/bev7/kiKN4LzKT2OHpSkQZ2hkFH3BQjJg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:1e6fef22-e100-461e-8aa0-5b06121051fe,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:e836db41-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 3f32d62e935011efb88477ffae1fc7a5-20241026
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1426649054; Sat, 26 Oct 2024 12:10:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 26 Oct 2024 12:10:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 26 Oct 2024 12:10:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8XwECuSxt5Fpuv1Rp08XAxaY9if5ihMfCQ4h+AY/2wmR+E0vvpuhBC3QDtKiD3ccdREvFuqXuWpn0PG925S0/EhDfBrQ+aRJvOoJkW0f+7zpAPxsQfBPSDO8fgLgR3YpOPjARvi/lqu3KwaRwsep0slOsB1A3o27k07TnCA1yvtGm8tGZjz9YZ3bhrrlth7XADXorxOaz3lMUiPBPKyEqWO9ySnSVPojCQ1HmSq8NABDwxusY0bI8irH4EYZlI3tchZhsMPzxmYnQNbPOx52epiCOy0TNvkAvyuIKUhmGEAN3XPycO5bQaTel08tMgXqzasc5ipt1NXO1nd9++nBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGxRDm4l6gYjN9xDrCoFNxhEf5Av55KeqRbz8JvcoPk=;
 b=XvXu2GdcL32zY3/nMVYdfJR5ueFGyWJAbzWxV1YuKeXjGehrm5q8mt6OYR1SakhPEbg0cPRoI2Yv5NAevrOf9Qi3WnDGZrmVOlW3C5+l/fgkMd03Ny0/6sBA58SD/LKeiNFNTeiCfi5Jc545KIogFMRG2RAGHh1bbbqesUI1gozsLQO8r1kKgANhvPT8kUk7HJMZ0gTeztyadrofzqNQIZigOU703al/LGwk/WcPq5SWD7ROk+1sTKXDPtADxrP8rQag4c1Hq71fJxaWH4YSZ04FIpa8TM1kHjMdFCjZTnI9ybCfGX8X1gw3D84jADukkdIKGCfHelr0vT1aHqBmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGxRDm4l6gYjN9xDrCoFNxhEf5Av55KeqRbz8JvcoPk=;
 b=bQzJfQ9bOmTaPg19wvxX9+d8uMM9wt71IT/CRH4YoVL33BFeldvLGwqrEJKQgXmMOWTs2xTZMCGWiKLQ3ThFmA6G4K70iI6SiI0ogwpE6lJJizqMXJJb2B3sORhco5/Nvd8tRKebs763FFoHkjTYx0/MpRjt45daWuaoP6ReNkc=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SEZPR03MB8634.apcprd03.prod.outlook.com (2603:1096:101:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 04:10:29 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a%5]) with mapi id 15.20.8093.021; Sat, 26 Oct 2024
 04:10:28 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: "dianders@chromium.org" <dianders@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "djkurtz@chromium.org"
	<djkurtz@chromium.org>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"hsinyi@chromium.org" <hsinyi@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "airlied@gmail.com"
	<airlied@gmail.com>, "zwisler@chromium.org" <zwisler@chromium.org>,
	=?utf-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "littlecvr@chromium.org"
	<littlecvr@chromium.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 08/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation
 property
Thread-Topic: [PATCH v3 08/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation
 property
Thread-Index: AQHbJlcM+XgY83PS/UONQZcY0r8SzrKWrtwAgAD8PICAAMIzgA==
Date: Sat, 26 Oct 2024 04:10:28 +0000
Message-ID: <379e9580603483731f849e708c4f8a4c3f5a843d.camel@mediatek.com>
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
	 <20240620-igt-v3-8-a9d62d2e2c7e@mediatek.com>
	 <CAD=FV=XTsPBQ7Qp_oQmBXkNY==KQWZdN7VYbuVPoBTHhMvzjUQ@mail.gmail.com>
	 <b75276ff8dc2f73818ccd132530c0d3825e17888.camel@mediatek.com>
	 <CAD=FV=WSD9p61ePKXVOcUBGktRJkUx+KbiJXF-9QUtWE8zDt0A@mail.gmail.com>
In-Reply-To: <CAD=FV=WSD9p61ePKXVOcUBGktRJkUx+KbiJXF-9QUtWE8zDt0A@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SEZPR03MB8634:EE_
x-ms-office365-filtering-correlation-id: 4366e763-b23b-4632-c309-08dcf574206c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UlRDU3AzZ3N1ZTM4NGdzSWZlVi94ZjdLZ1kwQ2ZiaE9BNEJaRGVrWVhWZzM1?=
 =?utf-8?B?YTRibU96UndLcm00K0hvYkdBUVFXV3lBbmRzUW40MDJ5ZnppT1BBSk5JanVS?=
 =?utf-8?B?b2RGSHRxUHFsZ1JQWU44Um1Va0ZEejhaQVVwQkY1Q2h4QUVsMG1FWlVseEw2?=
 =?utf-8?B?bU90VGdVUy9ScU1RWVNMeURJajdaMVhyS0lzZjBPUTgyL1ZqM2lUODRxRFRh?=
 =?utf-8?B?TWxTTUpEN3hQRFBWSVpxWGpTdlBQUE14QTBUNHRmNlJZS3N5cDRYWEFhaVNp?=
 =?utf-8?B?ZHBjaTRqTEdUTEJWbzBuck9xRnJuVDhiS3QzVGJaUmZWNXhjcjVVb2NkUXNm?=
 =?utf-8?B?RE80S2h6Z2JZa3NqUzFVWFlVL2hEdyswQ21MT1A5NXpUTmlLYTY4WTZ5eUF2?=
 =?utf-8?B?UGFaTWVMcGR6ZFdqYndsMEJDZDBwYURJN2FFaTQzRzB6ZWtvSkFaOHpIeVRJ?=
 =?utf-8?B?eCtROXBZZFF5Nm5yRWliS24xdGtZS1JhN2pGRVNacDZKOU11OGR3Ty9sVnlW?=
 =?utf-8?B?WlN2eDd0dDVveGpKaE81RnlDSHc4eFhRS3pNbEFiV28xVTlYSlVPZW5lbXhn?=
 =?utf-8?B?OXdtR2hXUnFuMU1HcXJ6Qml6aGlLTjd1S21ZS2dUQWE5ZDliR3R5TEw2RGxH?=
 =?utf-8?B?NVlWaytZK0RCSmc3TGlwaFZPdU5mRFJVSFp4Q0IrREtYL2d4OEFmNGxKOW9W?=
 =?utf-8?B?NEJ5SGxXR2Q5NW1iMStYb1lDSElXbUNrS0ZqTi9GT1UybDZDNXowLzJFWTlJ?=
 =?utf-8?B?SWFtMmFJdXhWTWhGRll1NzFlQzRBSGhRb09VczlOYXQwZWZsZktKVWxNbFlE?=
 =?utf-8?B?aXNybEVNVmhjMDViR1I2NXJaZEQzV1lJeG82bjc0WUQ4b0t2TzVJWFcxaklW?=
 =?utf-8?B?SmpWd0pOR2RpTEt5cDg3UUs1R1NhNlEvTGFuenJxb3FzM1N5MVJIWXovclE0?=
 =?utf-8?B?bHhrM1BYWHNWL1RDRENMTzE5OHVacUVqdHJjMkg3bVczQThxOUhxN3grcUhK?=
 =?utf-8?B?NUpLQXl5RHBObEkzOXBQOEd1Q0xaTlU0Y01XYVZNNnNZbmUwZGRmUnRXTmJo?=
 =?utf-8?B?TnJ5WmdUYVJLdjBjQ0d3MjhMN2hJWU1Uait4NVVOTmhUMXEvUTBOSkpaRGZH?=
 =?utf-8?B?ckswencvekV5RitvZkptcFFxZTh2VGJkVnZkV2JTckZLTU84Q0RSQ0hNNjRW?=
 =?utf-8?B?MGRBZ3VuVVYvZktVcTRxTVlBVTJmMmxvK01OTFJBM09ENGFWVjRvZm4wVE9R?=
 =?utf-8?B?NzlDcVRtWjZkdnFVYVlNV3o4UjZJTXpqUE5ZMTRKNWJ4Rkwxa1lpZTBnSTRo?=
 =?utf-8?B?TmFiQnVsb0tPTnV4WEpFOTRaNDlxRElJTGJiaDJjOE14ekdQS3pnekM1Z3dh?=
 =?utf-8?B?d1ZtQk51RWJpVXdtanhsZjkxVWdvRzZPUWQvdHZyeWIyUEF5MFZ1UVFtd1c3?=
 =?utf-8?B?R1dWN2pOY0trTXN3YSszTEdaa1V6VzNGVGJMMEtWSjczV2FUbnc3Qi9scURs?=
 =?utf-8?B?aFJtenBGVGJFMFRzeGdjeW1IeVJVZHQzaEQ0OEhvam41cmQvd21TMGRVdDE5?=
 =?utf-8?B?ZEh4bm1yUnc3b1V6eXhJejBkN2lWb1h4Yk05RDZobmVTUG1DVCtKb3B4clVy?=
 =?utf-8?B?MksvbEo0U2krVE9YWHRGZ2tjME5XTG14Z3ByNlFOYVpaQzRUSXhETXNoUFVE?=
 =?utf-8?B?R2xCU2Zvc0FLc3BWSnpBS1ZPNUZOV1RWVi9BRy82U204K3d4UUJoaXpqVzFt?=
 =?utf-8?B?NTNkbngwZGhBZVhYd0VoQmtkT3RMNm1McDZPNWE4QkpZZ1o1cmhWZVRvQkFs?=
 =?utf-8?B?Nld6UHl5ODZOSjhBRGdDQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0d0aDV0N1BnUFI3alZpMzdnWmJRRlQ0dDNOUFZZQ0NvVjVmUTArdGtmNG5r?=
 =?utf-8?B?TUZOMlFpckNFeUFNMEhRYThsQTNNQVJyY1lSdXRhVmRoeEtMYXp4cFZ1S3hN?=
 =?utf-8?B?a2xMc1lCVUQwbXpoSlF2eWtSUFRsdlZOR1lKMjdNeHMwRTFyYXMyN3RRRHY5?=
 =?utf-8?B?WlY3Y083eXM0b01HTUVJSnVUNXl5SjJCMGp0Q0ZqVW1ESzJmaTlUUUo1MUNq?=
 =?utf-8?B?ZEVQaWM4d1ZKV1hEZnFDR0UzM1JpRU5FZzZoWndvVXhzV1QvcmFUckRma29a?=
 =?utf-8?B?N01ydEFjaHMzajh2RlpDRDBMVmlLNUFXRVdSS3R2bWtqc0h0eklWclFIQ2xR?=
 =?utf-8?B?TXJzV0d0OUYyM0RQNGZUVG1xUDdTWU5xZnNJK1J5b2VPSUdEOUFteUJPUkwr?=
 =?utf-8?B?RUZnVmZ4TitlYi82QjNjV2I4ZVNiVXhwaVhnRjUxU3hVZXc3b01NTUw2d0VS?=
 =?utf-8?B?TnNEeTdJQ05id0l5ZkdoOVo4RU4xR0FCdEd3N3gxTkZMaFNMUlJVWWdvZnJw?=
 =?utf-8?B?TmQ0MjJuamNCYkxLVG5RRVlhV256WGtrQmVsYWc0Lzltdi9BQ2Y3N0ZValQr?=
 =?utf-8?B?cU1waUU2WG5uY2d5cWpJbXg5QkZtUGVuaEJVcU82a0NOUzdxRTB3MzZhSFJB?=
 =?utf-8?B?UWZSWVdnK2JxdWZFdm55dGZXVmNhWmtxUzkyeDdwUmI3UVBmSDlqSFlDM05K?=
 =?utf-8?B?S2JNd0JrNHhQdkhnT1M1ZnBNaWg0VCtwRmx0ODFrYTRhMVdoOHhjZEhaL0xV?=
 =?utf-8?B?N2grc2ZjNE9GVXJqUnZYSUsvUklhdTBUbTlTaTBLdFVZRE9sbWxMWUkxQUR5?=
 =?utf-8?B?OW5XVUR6T0dMMVRKWGZ0d2pZMmdWNDBRY1pMbTFMUEFucVY1RHdOWWMyQ1dH?=
 =?utf-8?B?T0VKMWtJRmVKWmZKNExreDNVNEZVSzM1WXFVWVFROEE3WEJjL1dkZm5vdldr?=
 =?utf-8?B?RHlwd2I0M0pGSVYzYmtwYWp3NmxyNFdRakNBMEF0dS9NaXI3OFo1eTRRbm92?=
 =?utf-8?B?cjlsK1crOXZwUnZWMHV1TEZZbDRSdWJ5K0RsVUpESUZvWmQ0U05aV3lUWGhh?=
 =?utf-8?B?MSt3VGNpLytnRnNmR0pGRTlLUkMyK2tWN0xQSUFpRFN6QnlwdmF1bk15eTY2?=
 =?utf-8?B?SXpnbjMyOFJkRUlNYzl6eDJwRGpwZVR5c1RFb1c0T0hMZFB5WWJNQjEzSXl1?=
 =?utf-8?B?S0V6d1dGUVMzR2FzWkVIU0xSeEtqWlpWUUZ0cm9JNThNSWlERkVSZllQR1FV?=
 =?utf-8?B?Z2VtTGdrN01qUThuMDE0U1ZubnBkLzh3SmQ4N0ZXellTNGp1ZW84Y0lHV3pw?=
 =?utf-8?B?aHU0WGNOSEdQclFLSFo1THBqcFlLU1VjZXdZM0YvTm5scllQaFZSUjRNOXIw?=
 =?utf-8?B?RW1MbTZ0dk40V1FuVXhqM3B4TzNUeTZ6OVVWQWw1MjNMNHQzWnEwakF6dDg3?=
 =?utf-8?B?S204a3lNcDVQV200Uk5FZXFuenQzL0lQb3ZFaU1yZDVaNS9SZTVwemtkSW5E?=
 =?utf-8?B?aGUra1hZRENGOXlxL2Y1QVJ2OCtkdEpnN1czaEdWSzQzbm9xb2paYW1jUnkv?=
 =?utf-8?B?L28yMllaRlpqazNLL0QycG5qRzFMeE1abnQ1c2xDVmlmNHoxUlJiYTNTbjM5?=
 =?utf-8?B?TUJOemdJVXJnajBEbm9wTE1nOXhibjVodTE1Q1pJYnZLR2VJaXM1UWE2NVR4?=
 =?utf-8?B?dUhSc0ZSWTlOSGI2WnRGSTVoRWVrdEZUVlBXaTNIU0hTNjNkbnozRnFvMHVs?=
 =?utf-8?B?bHhoTUJQVkRzNXcrZndqWnVzK3ZWdGcwZyt0Z2svbExLa3plVHFoUHZHLzlN?=
 =?utf-8?B?QWFFWHBDT2YwTEpUSlVzbDcwa05ZUEZuMWFXQTNzM1ViTG1SOXhENGJ5c0pS?=
 =?utf-8?B?K0FjSUUrYXg1T0c2YW9VSy9XUC84ZlRUQzJINXg1UzZlc0c5YWNaaFJ0L0JL?=
 =?utf-8?B?eWNuYXBoelpCMlIvTnlFVlNTbzlLNW1GWlBoSVl6VjlyMUFKZmV4TVZjNVpB?=
 =?utf-8?B?MDJrb2Z0UjZtUjBiUzNIczc0N0RvbzVPU0VQSFhwdytrM2VXa0pvZ25GY3VD?=
 =?utf-8?B?aFFUUGt2SkQwb2llcFovQVVjWTZCWng1S0sxQ3FsMGkwcXB1TG8yS2xQL21U?=
 =?utf-8?B?b0JoTkZUR0tpcE1UdXczcXkxdFdHc2xXS3ZkaS9yZFdhWkRMMjRHb3dsaG9m?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68F88B670DB47443B34AB7B913DB7F1B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4366e763-b23b-4632-c309-08dcf574206c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 04:10:28.8765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXHqh2X3VeMIyHzldAJiTx0TI1DgurXzdSUBFDI7/eIqz/jlU6nfnWxyoNAH8ZHh7HpCri//1JLOWDv4n5q6TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8634

SGkgRG91ZywNCg0KT24gRnJpLCAyMDI0LTEwLTI1IGF0IDA5OjM1IC0wNzAwLCBEb3VnIEFuZGVy
c29uIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IEhpIFNoYXduLA0KPiANCj4gT24gVGh1LCBPY3Qg
MjQsIDIwMjQgYXQgNjozMuKAr1BNIFNoYXduIFN1bmcgKOWui+WtneismSkNCj4gPFNoYXduLlN1
bmdAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiBIaSBEb3VnLA0KPiA+IA0KPiA+IE9u
IFRodSwgMjAyNC0xMC0yNCBhdCAxMzo0NyAtMDcwMCwgRG91ZyBBbmRlcnNvbiB3cm90ZToNCj4g
PiA+IA0KPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMNCj4gPiA+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gIEhpLA0KPiA+ID4gDQo+ID4gPiBPbiBX
ZWQsIEp1biAxOSwgMjAyNCBhdCA5OjM54oCvQU0gSHNpYW8gQ2hpZW4gU3VuZyB2aWEgQjQgUmVs
YXkNCj4gPiA+IDxkZXZudWxsK3NoYXduLnN1bmcubWVkaWF0ZWsuY29tQGtlcm5lbC5vcmc+IHdy
b3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gRnJvbTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3Vu
Z0BtZWRpYXRlay5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBBbHdheXMgYWRkIERSTV9NT0RFX1JP
VEFURV8wIHRvIHJvdGF0aW9uIHByb3BlcnR5IHRvIG1lZXQNCj4gPiA+ID4gSUdUJ3MgKEludGVs
IEdQVSBUb29scykgcmVxdWlyZW1lbnQuDQo+ID4gPiA+IA0KPiA+ID4gPiBSZXZpZXdlZC1ieTog
Q0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiA+IA0KPiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxy
ZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gPiBGaXhlczogMTE5ZjUxNzM2MjhhICgiZHJtL21l
ZGlhdGVrOiBBZGQgRFJNIERyaXZlciBmb3IgTWVkaWF0ZWsNCj4gPiA+ID4gU29DDQo+ID4gPiAN
Cj4gPiA+IE1UODE3My4iKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5n
IDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmggfCAgNiArKysrKy0NCj4gPiA+ID4gIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyB8IDE3ICsrKysrLS0tLS0tLS0t
LS0tDQo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMgICAgfCAg
MiArLQ0KPiA+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxNCBkZWxl
dGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gRldJVywgdGhpcyBwYXRjaCBnb3QgaW50byBDaHJvbWVP
UydzIDUuMTUgYnJhbmNoIHZpYSBzdGFibGUgbWVyZ2UNCj4gPiA+IGFuZA0KPiA+ID4gYXBwYXJl
bnRseSBicm9rZSB0aGluZ3MuIEFzIGEgc2hvcnQgdGVybSBmaXggd2UndmUgcmV2ZXJ0ZWQgaXQN
Cj4gPiA+IHRoZXJlOg0KPiA+ID4gDQo+ID4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL2NycmV2LmNvbS9jLzU5NjA3OTlfXzshIUNUUk5LQTl3TWcwQVJidyFrU0kybHla
SjVGOFNDcEFGZktDZVpzTDFxaWUycVJ2cFhXUGh0RDRJbEhpazd1UzRxNmhkUjZFalBic2tReGxU
TlA2T0lCU3dQT0tVMkt0RmY1TlhLUSQNCj4gPiANCj4gPiBUaGFuayB5b3UgZm9yIHJlcG9ydGlu
ZyB0aGlzIGlzc3VlLiBXZSBhcmUgY3VycmVudGx5IGludmVzdGlnYXRpbmcNCj4gPiB0aGUNCj4g
PiBidWcuDQo+ID4gDQo+ID4gU2luY2UgSSBhbSB1bmFibGUgdG8gYWNjZXNzIHRoZSBHb29nbGUg
aXNzdWUgdHJhY2tlciBbMV0sIGNvdWxkIHlvdQ0KPiA+IHBsZWFzZSBwcm92aWRlIG1vcmUgZGV0
YWlscyBhYm91dCB0aGlzIGJ1Zz8gVGhlIG1lc3NhZ2UgaW4gdGhlDQo+ID4gcmV2ZXJ0DQo+ID4g
Y29tbWl0IG1lbnRpb25zICJoYW5hL3N5Y2Ftb3JlMzYwIiAoTVQ4MTczKSBhbmQgaXQgYXBwZWFy
cyB0aGF0DQo+ID4gdGhlcmUNCj4gPiBpcyBhIHJvdGF0aW9uIGlzc3VlIGluIHRhYmxldCBtb2Rl
Lg0KPiANCj4gVGhhbmtzIGZvciB0aGUgZm9sbG93dXAuIEkndmUgb25seSBiZWVuIHBlcmlwaGVy
YWxseSBpbnZvbHZlZCBpbiB0aGUNCj4gcHJvYmxlbSwgYnV0IEkgY2FuIGF0IGxlYXN0IGNvcHkg
dGhlIHJlbGV2YW50IGJpdHMgb3Zlci4NCj4gDQo+IEl0IGxvb2tzIGFzIGlmIHRoZSBwcm9ibGVt
IGlzIHNvbWVob3cgb25seSBzaG93aW5nIHVwIHdoZW4gcnVubmluZw0KPiBBbmRyb2lkIGFwcHMg
b24gdGhvc2UgZGV2aWNlcywgc28gd2hhdGV2ZXIgdGhlIHByb2JsZW0gaXMgaXQncw0KPiBzdWJ0
bGUuDQo+IFRoZSByZXBvcnQgc2F5cyB0aGF0IHRoZSBhcHBzIHdvcmsgT0sgd2hlbiB0aGUgZGV2
aWNlIGlzIGluIHRhYmxldA0KPiBtb2RlIGFuZCBpbiBvbmUgcm90YXRpb24gYnV0IHRoZSBwcm9i
bGVtIHNob3dzIHVwIHdoZW4gcm90YXRlZCA5MA0KPiBkZWdyZWVzLiBUaGUgcmVwb3J0IHNheXMg
dGhhdCAiU2NyZWVuIGNvbnRlbnQgYXBwZWFycyBpbnZlcnRlZCIuIFRvDQo+IG1lDQo+IGl0IGFs
c28gc291bmRzIF9wb3NzaWJsZV8gdGhhdCB0aGUgcHJvYmxlbSBpcyBzb21ld2hlcmUgaW4gb3Vy
DQo+IHVzZXJzcGFjZS4NCg0KVGhhbmsgeW91IGZvciBwcm92aWRpbmcgdGhlIGRldGFpbHMuIFdl
IGhhdmUgYWxzbyByZWFjaGVkIG91dCB0byBvdXINCnBhcnRuZXIgYXQgR29vZ2xlIGFuZCBnYWlu
ZWQgYSBiZXR0ZXIgdW5kZXJzdGFuZGluZyBvZiB0aGUgc2l0dWF0aW9uLg0KDQpXZSBkaXNjb3Zl
cmVkIHRoYXQgdGhlIGNhcGFiaWxpdHkgZm9yIDE4MC1kZWdyZWUgcm90YXRpb24gd2FzIG5vdA0K
cHJldmlvdXNseSBjbGFpbWVkLiBIb3dldmVyLCB3ZSByZXBvcnRlZCB0aGlzIGNhcGFiaWxpdHkg
YnkgYWRkaW5nDQpEUk1fTU9ERV9ST1RBVEVfMTgwIHRvIHRoZSBwbGFuZSBwcm9wZXJ0eSwgYXMg
Y29tYmluaW5nIGZsaXAteCBhbmQNCmZsaXAteSBlZmZlY3RpdmVseSByZXN1bHRzIGluIGEgMTgw
LWRlZ3JlZSByb3RhdGlvbi4gVW5mb3J0dW5hdGVseSwgaXQNCmFwcGVhcnMgdGhhdCB3ZSBkaWQg
bm90IHByb3Blcmx5IGhhbmRsZSB0aGUgcm90YXRpb24gcHJvcGVydHkgaW4gdGhlDQpkcml2ZXIs
IHdoaWNoIGhhcyBsZWQgdG8gdGhlIGN1cnJlbnQgaXNzdWVzLg0KDQpUaGUgcmVhc29uIHRoZXJl
IGlzIG5vIHByb2JsZW0gYWZ0ZXIgcmV2ZXJ0aW5nIHRoaXMgcGF0Y2ggaXMgbGlrZWx5DQpiZWNh
dXNlLCB3aGVuIHRoZSBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCByb3RhdGlvbiwgQW5kcm9pZCBh
cHBzIHdpbGwNCmhhbmRsZSBzY3JlZW4gcm90YXRpb24gdmlhIHNvZnR3YXJlLiBBZnRlciB0aGlz
IHBhdGNoLCBzaW5jZSB3ZSBjbGFpbQ0KdGhhdCBvdXIgZHJpdmVyIHN1cHBvcnRzIDE4MC1kZWdy
ZWUgcm90YXRpb24sIHRoZSBhcHAgYXR0ZW1wdHMgdG8NCnV0aWxpemUgaGFyZHdhcmUgZm9yIHRo
aXMgZnVuY3Rpb24sIHdoaWNoIGhhcyByZXN1bHRlZCBpbiB0aGUgYnVnLg0KDQo+IA0KPiBJIHRo
aW5rIEhzaW4tWWkgYW5kIFJvc3MgYXJlIGNvbnRpbnVpbmcgdG8gZGlnIGEgYml0IG1vcmUuIE1h
eWJlIG9uY2UNCj4gdGhleSd2ZSBkdWcgdGhleSBjYW4gYWRkIGFueSBkZXRhaWxzIHRoZXkgZmlu
ZCBvciBjYW4gbG9vcCBpbiBvdGhlcnMNCj4gYXMgaXQgbWFrZXMgc2Vuc2U/DQoNClRoYW5rIHlv
dSBmb3IgeW91ciBhc3Npc3RhbmNlLCBhbmQgd2Ugd2lsbCBjb250aW51ZSB0byBpbnZlc3RpZ2F0
ZSB0aGlzDQptYXR0ZXIuIFNpbmNlIEkgYW0gbm8gbG9uZ2VyIGludm9sdmVkIGluIHRoZSByZWxh
dGVkIHByb2plY3QsIEphc29uLUpIDQp3aWxsIGFzc2lzdCBpbiBpbnZlc3RpZ2F0aW5nIHRoaXMg
aXNzdWUgYW5kIHdpbGwgc3VibWl0IGEgZml4IG9uY2Ugd2UNCmNvbmZpcm0gdGhlIHJvb3QgY2F1
c2UuDQoNCj4gDQo+IA0KPiA+ID4gLi4uYXBwYXJlbnRseSB0aGUgcGF0Y2ggaXMgZmluZSBvbiBu
ZXdlciBrZXJuZWxzIHNvIG1heWJlIHRoZXJlDQo+ID4gPiBpcyBhDQo+ID4gPiBtaXNzaW5nIGRl
cGVuZGVuY3k/IEhvcGVmdWxseSBzb21lb25lIG9uIHRoaXMgbGlzdCBjYW4gZGlnIGludG8NCj4g
PiA+IHRoaXMNCj4gPiA+IGFuZCBlaXRoZXIgcG9zdCB0aGUgcmV2ZXJ0IHRvIHN0YWJsZSA1LjE1
IGtlcm5lbHMgb3Igc3VnZ2VzdA0KPiA+ID4gYWRkaXRpb25hbCBiYWNrcG9ydHMuDQo+ID4gPiAN
Cj4gPiANCj4gPiBUaGVyZSBhcmUga25vd24gaXNzdWVzIFsyXSByZWdhcmRpbmcgZm9yd2FyZCBj
b21wYXRpYmlsaXR5LiBDb3VsZA0KPiA+IHlvdQ0KPiA+IGNvbmZpcm0gd2hldGhlciB0aGlzIHBh
dGNoIGlzIHVuYWJsZSB0byByZXNvbHZlIHRoZSBtZW50aW9uZWQNCj4gPiBwcm9ibGVtPw0KPiA+
IFRoYW5rcy4NCj4gPiANCj4gPiBbMV0gDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vaXNzdWV0cmFja2VyLmdvb2dsZS5jb20vaXNzdWVzLzM2OTY4ODY1OV9fOyEhQ1RS
TktBOXdNZzBBUmJ3IWtTSTJseVpKNUY4U0NwQUZmS0NlWnNMMXFpZTJxUnZwWFdQaHRENElsSGlr
N3VTNHE2aGRSNkVqUGJza1F4bFROUDZPSUJTd1BPS1UyS3NHUXdkb2JBJA0KPiA+IFsyXQ0KPiA+
IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9ODk2OTY0X187ISFDVFJOS0E5
d01nMEFSYncha1NJMmx5Wko1RjhTQ3BBRmZLQ2Vac0wxcWllMnFSdnBYV1BodEQ0SWxIaWs3dVM0
cTZoZFI2RWpQYnNrUXhsVE5QNk9JQlN3UE9LVTJLdVhDaFdCakEkDQo+IA0KPiBUaGUgcGF0Y2hl
cyBpbiBbMl0gbG9vayByZWxhdGVkIHRvIGFscGhhIGJsZW5kaW5nIGJ1dCBJIHRoaW5rIHRoZXkN
Cj4gYXJlDQo+IHNlZWluZyBpc3N1ZXMgcmVsYXRlZCB0byByb3RhdGlvbi4gLi4uc28gSSdtIGdv
aW5nIHRvIGFzc3VtZSBpdCdzDQo+IGRpZmZlcmVudD8gSSBkb24ndCBoYXZlIHRoaXMgaGFyZHdh
cmUgaW4gZnJvbnQgb2YgbWUsIHNvIEknbSBqdXN0DQo+IGdvaW5nIGJ5IHRoZSByZXBvcnQuDQoN
Ck5vIHByb2JsZW0uIEJhc2VkIG9uIHlvdXIgZGV0YWlsZWQgZGVzY3JpcHRpb24gYWJvdmUsIGl0
IHNlZW1zIHdlIGhhdmUNCmlkZW50aWZpZWQgdGhlIHBvc3NpYmxlIGNhdXNlLiANCg0KPiANCj4g
LURvdWcNCg0KQmVzdCByZWdhcmRzLA0KU2hhd24NCg==

