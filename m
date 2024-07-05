Return-Path: <linux-kernel+bounces-242261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2E2928572
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA0FB21CE2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B7B148312;
	Fri,  5 Jul 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZUPakEXi";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HvHRnPne"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74D147C82
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172974; cv=fail; b=ibLKA+X6XlEiWbytOnhADBVNd1u3d6cEqNB9zG6ziP0E96DmLy+xXCxq5a9Ab3UXKLvQcHFk7f6GthhTw3987/6DFQ7RSvd0PRtcJS48Paf3ZdnJtQgs0HfCFHuB7wPVh9bhjk1/uFIUVGnZqEBA4x66mi74vZtMklqCibFMKuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172974; c=relaxed/simple;
	bh=avN5fk+SWYfTg1GwcSy2vfqKYJPStvMzF71z049sjbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kZumKc0HswpOvnQclGCQT5fFWRSHiKCpmHN4RCjtFOqEEWqV81why5O6c9EYh8heQxaC3VYH/+9ITZWlxGqTPxvAxui8p+wc/PIR0k/ZDrdSuDJJjX8JJJu99yC7r2LUkmqSnSN5QshmRo2u2qRaWPg4R4kymxPbwhS/EIEUxSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZUPakEXi; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HvHRnPne; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ddbd2d9e3ab311ef99dc3f8fac2c3230-20240705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=avN5fk+SWYfTg1GwcSy2vfqKYJPStvMzF71z049sjbs=;
	b=ZUPakEXi890ZW17NK3GA/vMYUf8CKid401l5x7j/dmj9deDQdBJLtNESEYsUNRapJbkez0qUa7wNsaeARbPHbVNNpmVnzDGhLxtGRlv6hbsA20M+/Ytq7J5dhFyV4vDFXPLTKj3GGHZO7AN4N223tIC7fxVuW+OoMVyXrDzgFPo=;
X-CID-CACHE: Type:Local,Time:202407051736+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:ca3518f5-76ee-4502-91f1-245bfbf132c1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:1656fed4-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ddbd2d9e3ab311ef99dc3f8fac2c3230-20240705
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1300107648; Fri, 05 Jul 2024 17:49:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Jul 2024 17:49:25 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Jul 2024 17:49:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFZQmIsjblgN6a1K1Ribj2Rk+SZ9hf80WEl2QlRDfpJfxe7toEO2DA72qRn3S/DMg8Td09mXerzCQ5nJbUprcvC1hhnPSB4Z+2fTSqbEHyIpeevzTZ8l5TK0VmNd8jHWb8m7dlhScB2dRBNnCcG/hbScmRDCWozTkB+s27vm4HuB1T6tSx4Z2KjYAjQM1HR0txxXnTUFa1a+s/XWBCeqS89lhbgpsw/rjVxbrcfvDSY2Bbn3AxdUVeWD/OFGtGKSht3rZ+cY1MESUW2JtvRsugtKmtXsn2tG+qgr+Tj//2DCVIgoqgBM6EjXXcem5fccVEZo99dpFpTUimwxA4F8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avN5fk+SWYfTg1GwcSy2vfqKYJPStvMzF71z049sjbs=;
 b=BTN6XbPywPfs7Z1Y2MWib8vNN2EwlDMOUHbIpYP5UT6CDYmHdyq3dRhpxE2ZWIbEEcWjBzoeNCsUGllQ+G+RyCmmgUGEe7e9PlhHcNM3W34vV5HHWYpzZ7VevMtEzLSSz9oT33apt20U+Z9EArK79wKzO5RNZAd5WXXYenDBfVeUWyj313Ksd+93j9N8xWDk/1gXAEw18OBw7ymEvbPW5GurhQcclC6CBHOYPO9DcseW+Zh+kyaMM1YGtcsZCPuvjsWa71rdUncKeHD4FAqAAKv/6InyPCqSIc5i7d05M5ZU2i9IYEARdwyaMLwNO/X6m9YkdMLDWTSdM+oq5AFnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avN5fk+SWYfTg1GwcSy2vfqKYJPStvMzF71z049sjbs=;
 b=HvHRnPnek+tjM++M9U4rIUnFGiGaSDEpiM47c7mzNQ/IETrXd8bI/zdawbweORc+Yz7+vnlOnbsCVH60Lp5KSEkM5fn+PvMVvzyD9+GncGSdfy8N/H0oPXggwMKBPry2jBMDv0pe4Je3vm762BEINLhgq445dts8N5KfORLOTyo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7583.apcprd03.prod.outlook.com (2603:1096:400:410::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 09:49:23 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7719.029; Fri, 5 Jul 2024
 09:49:23 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/5] drm/mediatek: Support "None" blending in Mixer
Thread-Topic: [PATCH 2/5] drm/mediatek: Support "None" blending in Mixer
Thread-Index: AQHawm4CehGZ7j4H80uVSodFizERF7HhQ4EAgASciwCAAhxMAA==
Date: Fri, 5 Jul 2024 09:49:22 +0000
Message-ID: <8d3e5a22fcfdc3ce231805d991f8ec3202af8894.camel@mediatek.com>
References: <20240620-blend-v1-0-72670072ca20@mediatek.com>
	 <20240620-blend-v1-2-72670072ca20@mediatek.com>
	 <2bcb715c19c8445746a00bcd4b633ceb42c286a1.camel@mediatek.com>
	 <5cee68d3bee73e034781c8ee8b5ff2c2c045791f.camel@mediatek.com>
In-Reply-To: <5cee68d3bee73e034781c8ee8b5ff2c2c045791f.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7583:EE_
x-ms-office365-filtering-correlation-id: dfe1ebd3-b7a6-4592-3814-08dc9cd7bfcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RE91UHhDb1ZPRnR6UWJUQ2c2ZDF6MzAwd3BGcHAwVUgzaStvRW9WaTBySTR4?=
 =?utf-8?B?L1B2VVBzZkNmaVkzTkhHaGlib21xZFZCMU81UHJmVVNNZVlMbzVOeXA0bUE3?=
 =?utf-8?B?MmFhaEtJU0VqUng5dEhER3FZVkV5ZGxrODBWOG96bUpLWXdRWUpuRWVuaFdX?=
 =?utf-8?B?aHhrdmczc1NvaWtsTFVyU2hMNmpWTlQ0S1kzSVRJa2h0L3lVQXlvL3dFQTJJ?=
 =?utf-8?B?UVpJaStnWFg3cXpUdFg2eDZQNzhuelRzSnVkM2RZZlA5N2tKMncxZmtLOThZ?=
 =?utf-8?B?UkFJTFMwR2tlakU4cmZYcThpQXhncmtCYTdPajlaOVZvRFF2eVVvZDJZdkpw?=
 =?utf-8?B?R2xiZW5jRVRlSDVKUHRHbEUvYkxYRmlubkxTL0RsUzVITGl0THdwV0JvLzBL?=
 =?utf-8?B?WnRIZUVhNlRTREp2L3BQcmgzdVJPZlp5dVhLVWpCRzRzaUMvZE1iSEZCamN4?=
 =?utf-8?B?ai9oazl5Q2h0RnJXRlM5aFRBS2JlWkUzaFp1eGY3VWtGSUZvYW9obEs5aElX?=
 =?utf-8?B?NEtVV1BDRzRLTWZvam1yN1FqTUh2NHp6cXBQK3V2QTAybk1iQ2EyWW1nWW84?=
 =?utf-8?B?UExYYmtWS3lkRXdsanpHZnBreG9TNlBVVHRUZkVkN1JVQ2pLdWc3a3UvWFZW?=
 =?utf-8?B?dGN6L2owdXY5cG5DZGplK2ZFQ3kyODhxSWROc2VZeXhHSTk1RW45RWVWd29C?=
 =?utf-8?B?b2pLWEExMkZjOWhRZ2tSUzlib0dJaEU0VEI2ZHRGRXVrd2NRQ3VNTmtjcngy?=
 =?utf-8?B?UjZ0YTBMZjc5THBGdUpoQXdRSHFJRStyU1JWaHdLNitYMjVBbGJlR1N6aHZX?=
 =?utf-8?B?T3FQZHJIOTJ6WGZ1cHpVMjRlOTMrTk9WbTJrOXljNjFYSmdpalFYYldwbDZp?=
 =?utf-8?B?TjRTa29kemRGa0xZMlpWRzNsU0loYUk5Q0ZRZmcwNE5NV0NCUERJQ05lckk2?=
 =?utf-8?B?V1hkaGxDcVVwZXFZeFJtV2RvT3B4ZDRBcmQ1RHVHWTA5TGlwSmkxQXVlemhW?=
 =?utf-8?B?WGcwbEd0RjV5d3Uxc2Z0SU0rQ1pHYlE5ZXNwZmtoWWlpU0Zqb3NGTXJmaDBY?=
 =?utf-8?B?dkhCMHVVaWZqanVzR3pob3l1V1cwUityNWxsTGM0TnBPeHNDZDdYOHFzSEZE?=
 =?utf-8?B?NGVUSTZoM3V4TlgzTGRpZlVpL08wL3hRN0gxL1I1cjNkZElteGlLbGtDZC9D?=
 =?utf-8?B?QXlFUWI2RW1OSnljNFhONDVVenpXZVFWMmQyUUNQdTI4SEtHV2craTJZOWNC?=
 =?utf-8?B?eWU1K0JtNURVNjc3K1BBRWNlNXowUnd2Rkp1MFN3KzZvZk1LWGUrdyt0NGc5?=
 =?utf-8?B?STNaUzBTcnhkalg4QmtHTUkrT1NlYUpJRVFXRjhZbUtSancwL2ltUXVJcWJ2?=
 =?utf-8?B?YTNGUElMczJJaXJxcS9OOUJoTkhuUS8yZWJDRGRWUzF2RVZ0TG8xQ2FHSCtT?=
 =?utf-8?B?Z1U4Q3lhcUJ1anZndTY2YzQrTktLUExVOC9ua2QvVURtUXd6YVMzb2tFS2Qr?=
 =?utf-8?B?NTFJUjNZcENWSHZjdTBMb21sSWVDWElhOUFYQWl4QlJjam5GdG9YeWFFNWpw?=
 =?utf-8?B?ZGZxSjJFdmxHZ1BGQmcyK1psUC82RnE5NVRyUFdwQWcwM3A3dzJaUmwweVJ3?=
 =?utf-8?B?Z3hIbnBQOEZVeUgwUTlsU3JKWGlSTTlIejZLb0ozOFFvdFlyNlJKZXNwT1hn?=
 =?utf-8?B?bW5Na3plTC9JTmgyVjVxLzNNWmVUU3pNQ1JHMUV1emhvYkxNYURaV2xOQ0VO?=
 =?utf-8?B?ZGRVdDZ5UGI2Nm9EWDh2REVibXRKcVhGUE5EYXBQMWZJMUhIZmRUUUl2ZTg1?=
 =?utf-8?B?ZDErSWxiaFowYmxrN09JOTV3eXZWUE1laHpFc1BjOUJoZTVmSjlaTVI0UWNP?=
 =?utf-8?B?TEJvR1ZZWHg1ZE5uVEYyK0VCajVvTkFpUkZmY0VlVnlad3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE4vV0FUMmtIQjhsQnA1bVdNcmhwTm1xZGxjOVBuaWptNHBMZmFZRHBoVC94?=
 =?utf-8?B?LzI5Mk50SVFhcEhQUDd1RUdRZEN2TFZmSGNtcEdrbGxoK3BYbWFnZ0xuSUJH?=
 =?utf-8?B?dWkwUWhOM3JQbTQ3K3pZWC9XU0M0NFhvR25FUk0xVitCaHRGZEwxZzNTYlE0?=
 =?utf-8?B?enllUjYxQkFiekVuL2RlZFppaTFFNkU3S3hXZ0NPd3pUa2RTWmxYUEJhWW0r?=
 =?utf-8?B?bWlKZTRRUHh1V2tQbjNEaE9SUVBDN3BhV1lTSW1QTmpjbUVpSVBCdlVrSDdt?=
 =?utf-8?B?VW1wem4rdU1rRkVzODBlWHRmd0ZXQS94MXYwdkhHZ2syTFpKbmhiVExPTGdh?=
 =?utf-8?B?U2VwZFZkdXdBcHpGMnRpbHpmTVo5aU45N3hTMXM5UjJoSVhsMklNSU5ma3F3?=
 =?utf-8?B?SzNaSHA5ODJVajFycFlnZFBOSkFPUXlXc3hiWnFGVEw2RGNqSTFLbDFOWDdN?=
 =?utf-8?B?VnNVUmlCeHRwejhvK1k0M3dPY3d1YlZhZytvQU1hd0RSUkNaaW5jdWh3NVBW?=
 =?utf-8?B?MXBiMXhzYVlmUDlYMEw3RDg4ZGQ4VGk2dlFYbXY2Qk1YcG4xcE1hbkM5TDQ4?=
 =?utf-8?B?UlZ5cnFjSk94WlBoS1dmekxNUXBvbEVZa0hoRC9rZ1dlbEZlenQrbzBDS1M0?=
 =?utf-8?B?TlBXd0IwWDJWUFg4OW9GY0pRSnpISjYrU3krS05ZYlJZQ2txMlNZamY0RjR4?=
 =?utf-8?B?OUtIOThGMktUNFhmY29uYnF6eVU0TUk4VkhDOEFDdlA3bVMyOUEyZnIvZjJX?=
 =?utf-8?B?aFRhdStSVk5xMkZIZ2E4bFhpRkVKa2hpa1lmWkY5a3Q0WGlxaTdCbFNubzF3?=
 =?utf-8?B?LytIcnpLWFpac29RZG1YcjBhV015Z2xrajNhT3FNTlhqTGo2Vk1rSXpBK29k?=
 =?utf-8?B?anV2MEtoNUpiY05TNURsTWZ0VjRXUlhKeEdHYmt5OUltUG4rT3BDeE5DamM5?=
 =?utf-8?B?SXRWWXo4aEZQR241QTdwSTRTaHNyU2ZIV3FJTTAvSUgxR3FFeG5KT0pDOHE3?=
 =?utf-8?B?SEF0ekN0SlRXMjhUakZPM1laZWlMVXpVQ2MxbVAwNUNONGFsRnMxeTFqZnZK?=
 =?utf-8?B?NlBoYnVYTG1FanI1UjRIeUhNZCsyRWZZOEp1WE85cEF0MG1YMWlTY2VldmF5?=
 =?utf-8?B?cTZMeEhtZzlvVXdaMkNCNFB4RjlOeHpRb2wxOTFkT1FhWlFEMERJM29KTExC?=
 =?utf-8?B?VzdPOEMrY1N5bnZWcVBDVEs4WXpiL1lrcTdjcGsxTTRaOS9aaFNlRmFWYlE1?=
 =?utf-8?B?Nnk5ZVhpL1Z4YnBJWDgxVzNvYTk1Vk9NOGl3c0M0eVJ0YmJFeHJXY2RpWWhB?=
 =?utf-8?B?RVJqWVNhTEZEOUhTclNlUUVoVFVoaWhjTTdWdGtiZ1F2OEcrRVB6N1hpUEkw?=
 =?utf-8?B?VUYrckw3WEc4N0hxa1o4ZXdlWERBZ09VTytaT3Z5ZEJrMHV4M2FNZDkzZWg3?=
 =?utf-8?B?RDltSmQzRkIvckl6eit0UVVmbWVLQy82Z2NNZlU5d0Q2Wk1ncFJTVkdKcC9a?=
 =?utf-8?B?WE5PSVhXdmM1Ri9hQm5vM1dZbnhZd25MWldHK0c1MjZ2eTdxMDVIREZ4S0FY?=
 =?utf-8?B?ZWlsV1kwOEdjcGpQajZ0TVcvVEFBSkxJVW1xUDg5aEk1cHFva1ZCdVpSaUpQ?=
 =?utf-8?B?SzBSSVpNS3ZUN3g3ODAvSXRKa1Nic3VYempOelpxN29OemRBQjhWbGJocENr?=
 =?utf-8?B?YlpjaVh6VzlML1VSa2RkNGpZN2dwVDBMSHNiODI2Rm5zWkNzdmFlRkhJTEFa?=
 =?utf-8?B?YnJSdmZYWjFFVlNhTTRLRTZPYTBnQ0I2L3RvTzZTbnR5eUpjOUhiZjROS0x1?=
 =?utf-8?B?WXl1UEorcjdpRzA5WVNBOE5ZRThMM29pKzRaS0NaNjV1Q2RZeEFnWFhvZkNP?=
 =?utf-8?B?ZmpjZVpEUUlqdGptSEN3bnY2NkxYd3FHQ3VYZVBJSW1VVkJOZ0FpTTAzbU0r?=
 =?utf-8?B?RlR1N1dGRDI0ajh2dGVMQ0dFME9uZTAxZnFjdHVZdG1RL2hua2VkWkhtcmxw?=
 =?utf-8?B?NTBwYnBTdHlGRkNRZU01QTZWbExQMjBmVFhkeVJzWDVHdXBiUGltNXNQZGdy?=
 =?utf-8?B?K2doeTZ0ZzRwMlNSNHpyeTZxSGtwS3JEQXFnRHlFaHh4bjZCWmkyNXBFbVk5?=
 =?utf-8?Q?VfZI+CPwBM0W+ldn77ivgGG5b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BF4357B59E28140AA2E144307DF9980@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe1ebd3-b7a6-4592-3814-08dc9cd7bfcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 09:49:22.9477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNEkqnAMbItU2xpzPGr7ZMRo4fomqgUNeKuwOZZXYw/SMxd/KYn6pnsplh1NZn6hAlAQzmcI1HPTSKGb0H2Scw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7583

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDctMDQgYXQgMDE6MzUgKzAwMDAsIFNoYXduIFN1
bmcgKOWui+WtneismSkgd3JvdGU6DQo+IEhpIENLLA0KPiANCj4gT24gTW9uLCAyMDI0LTA3LTAx
IGF0IDAzOjEwICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiBIaSwgU2hhd246
DQo+ID4gDQo+ID4gT24gVGh1LCAyMDI0LTA2LTIwIGF0IDAxOjI3ICswODAwLCBIc2lhbyBDaGll
biBTdW5nIHZpYSBCNCBSZWxheQ0KPiA+IHdyb3RlOg0KPiA+ID4gIAkgDQo+ID4gPiBFeHRlcm5h
bCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0K
PiA+ID4gdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4N
Cj4gPiA+ICBGcm9tOiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiA+IA0KPiA+ID4gU3VwcG9ydCAiTm9uZSIgYWxwaGEgYmxlbmRpbmcgbW9kZSBvbiBNZWRp
YVRlaydzIGNoaXBzLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBT
dW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYyB8IDEzICsrKysrKysrKystLS0NCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+IA0K
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0K
PiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gPiA+IGluZGV4
IDM2MDIxY2I4ZGY2Mi4uNDhiNzE0OTk0NDkyIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gPiA+IEBAIC0zLDYgKzMsNyBAQA0KPiA+ID4gICAqIENv
cHlyaWdodCAoYykgMjAyMSBNZWRpYVRlayBJbmMuDQo+ID4gPiAgICovDQo+ID4gPiAgDQo+ID4g
PiArI2luY2x1ZGUgPGRybS9kcm1fYmxlbmQuaD4NCj4gPiA+ICAjaW5jbHVkZSA8ZHJtL2RybV9m
b3VyY2MuaD4NCj4gPiA+ICAjaW5jbHVkZSA8ZHJtL2RybV9mcmFtZWJ1ZmZlci5oPg0KPiA+ID4g
ICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiA+IEBAIC0zNSw2ICszNiw3IEBADQo+ID4gPiAg
I2RlZmluZSBNSVhfU1JDX0wwX0VOQklUKDApDQo+ID4gPiAgI2RlZmluZSBNSVhfTF9TUkNfQ09O
KG4pKDB4MjggKyAweDE4ICogKG4pKQ0KPiA+ID4gICNkZWZpbmUgTk9OX1BSRU1VTFRJX1NPVVJD
RSgyIDw8IDEyKQ0KPiA+ID4gKyNkZWZpbmUgUFJFTVVMVElfU09VUkNFKDMgPDwgMTIpDQo+ID4g
PiAgI2RlZmluZSBNSVhfTF9TUkNfU0laRShuKSgweDMwICsgMHgxOCAqIChuKSkNCj4gPiA+ICAj
ZGVmaW5lIE1JWF9MX1NSQ19PRkZTRVQobikoMHgzNCArIDB4MTggKiAobikpDQo+ID4gPiAgI2Rl
ZmluZSBNSVhfRlVOQ19EQ00wMHgxMjANCj4gPiA+IEBAIC0xNzUsNyArMTc3LDEzIEBAIHZvaWQg
bXRrX2V0aGRyX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlDQo+ID4gPiAqZGV2LCB1bnNpZ25l
ZCBpbnQgaWR4LA0KPiA+ID4gIGFscGhhX2NvbiB8PSBzdGF0ZS0+YmFzZS5hbHBoYSAmIE1JWEVS
X0FMUEhBOw0KPiA+ID4gIH0NCj4gPiA+ICANCj4gPiA+IC1pZiAoc3RhdGUtPmJhc2UuZmIgJiYg
IXN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSkgew0KPiA+ID4gK2lmIChzdGF0ZS0+
YmFzZS5waXhlbF9ibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUpDQo+ID4g
PiArYWxwaGFfY29uIHw9IFBSRU1VTFRJX1NPVVJDRTsNCj4gPiANCj4gPiBUbyBzdXBwb3J0IERS
TV9NT0RFX0JMRU5EX1BJWEVMX05PTkUsIEkgdGhpbmsgaWdub3JlIHBpeGVsIGFscGhhIGlzDQo+
ID4gZW5vdWdoLiBXaHkgbmVlZCB0aGlzIHNldHRpbmc/DQo+IA0KPiBZZXMsIGJ5IHNldHRpbmcg
UFJFTVVMVElfU09VUkNFIGJpdCwgRVRIRFIgd2lsbCBpZ25vcmUgdGhlIHBpeGVsIGFscGhhDQo+
IG9mIHRoZSBsYXllci4NCg0KSW4gdGhlIGxhdGVyIGNvZGUsIHJlcGxhY2Vfc3JjX2Egd291bGQg
YmUgc2V0IHRvIHRydWUuDQpJIHRoaW5rIHJlcGxhY2Vfc3JjX2EgaXMgZW5vdWdoIHRvIGltcGxl
bWVudCBEUk1fTU9ERV9CTEVORF9QSVhFTF9OT05FLg0KU28gaXQncyBub3QgbmVjZXNzYXJ5IHRv
IHNldCBQUkVNVUxUSV9TT1VSQ0UuDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBUaGFua3MsDQo+
IFNoYXduDQo+IA0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gQ0sNCj4gPiANCj4gPiA+ICtlbHNl
DQo+ID4gPiArYWxwaGFfY29uIHw9IE5PTl9QUkVNVUxUSV9TT1VSQ0U7DQo+ID4gPiArDQo+ID4g
PiAraWYgKChzdGF0ZS0+YmFzZS5mYiAmJiAhc3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2Fs
cGhhKSB8fA0KPiA+ID4gKyAgICBzdGF0ZS0+YmFzZS5waXhlbF9ibGVuZF9tb2RlID09IERSTV9N
T0RFX0JMRU5EX1BJWEVMX05PTkUpIHsNCj4gPiA+ICAvKg0KPiA+ID4gICAqIE1peGVyIGRvZXNu
J3Qgc3VwcG9ydCBDT05TVF9CTEQgbW9kZSwNCj4gPiA+ICAgKiB1c2UgYSB0cmljayB0byBtYWtl
IHRoZSBvdXRwdXQgZXF1aXZhbGVudA0KPiA+ID4gQEAgLTE5MSw4ICsxOTksNyBAQCB2b2lkIG10
a19ldGhkcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ID4gdW5zaWduZWQg
aW50IGlkeCwNCj4gPiA+ICBtdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBwZW5kaW5nLT5oZWlnaHQg
PDwgMTYgfCBhbGlnbl93aWR0aCwNCj4gPiA+ICZtaXhlci0+Y21kcV9iYXNlLA0KPiA+ID4gICAg
ICAgIG1peGVyLT5yZWdzLCBNSVhfTF9TUkNfU0laRShpZHgpKTsNCj4gPiA+ICBtdGtfZGRwX3dy
aXRlKGNtZHFfcGt0LCBvZmZzZXQsICZtaXhlci0+Y21kcV9iYXNlLCBtaXhlci0+cmVncywNCj4g
PiA+IE1JWF9MX1NSQ19PRkZTRVQoaWR4KSk7DQo+ID4gPiAtbXRrX2RkcF93cml0ZV9tYXNrKGNt
ZHFfcGt0LCBhbHBoYV9jb24sICZtaXhlci0+Y21kcV9iYXNlLCBtaXhlci0NCj4gPiA+ID4gcmVn
cywgTUlYX0xfU1JDX0NPTihpZHgpLA0KPiA+ID4gDQo+ID4gPiAtICAgMHgxZmYpOw0KPiA+ID4g
K210a19kZHBfd3JpdGUoY21kcV9wa3QsIGFscGhhX2NvbiwgJm1peGVyLT5jbWRxX2Jhc2UsIG1p
eGVyLT5yZWdzLCANCj4gPiA+IE1JWF9MX1NSQ19DT04oaWR4KSk7DQo+ID4gPiAgbXRrX2RkcF93
cml0ZV9tYXNrKGNtZHFfcGt0LCBCSVQoaWR4KSwgJm1peGVyLT5jbWRxX2Jhc2UsIG1peGVyLQ0K
PiA+ID4gPiByZWdzLCBNSVhfU1JDX0NPTiwNCj4gPiA+IA0KPiA+ID4gICAgIEJJVChpZHgpKTsN
Cj4gPiA+ICB9DQo+ID4gPiANCj4gPiA+IC0tIA0KPiA+ID4gR2l0LTE0NikNCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiANCg==

