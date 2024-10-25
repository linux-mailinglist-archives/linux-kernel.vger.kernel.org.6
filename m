Return-Path: <linux-kernel+bounces-380844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A39AF6D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0009F1F2285F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F72744B;
	Fri, 25 Oct 2024 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NgBiG3vQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jE5gUeOY"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7332261D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819971; cv=fail; b=KnPVWb1KrN78U/aDCYdsXwZIeQorJc56JWZ5NNf7C+W3vM4Pt+0yUkuVyg5J0ahRSu575Z6Yfs7QMuRightuQ3WmVjGS1rTrTAN+9fhBYHmklbYv3VrgtP3cF+OGCgEcgGx1J8CusH2mracTWyesppGNuIYhy2lZkb0hWgIoT0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819971; c=relaxed/simple;
	bh=z6oLxTZorx7qbehkUavYggVPaNG7Y/6pk4tK4RfMeaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zc+5UfjTL9N61svTErl0NdbYUAKobqxqXQUGzJAaVmhhgPIsr1johI+yQrnftTXmrPbZq7CcjiYQMrhxRIxdJ/82Wnpo8Qcr+aLC/8reRdif8o98Q4J/D5HZO30yTWouUlXCcRjZh68TG1bNytOJbUcRcxL0n5K4ml/VSii90Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NgBiG3vQ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jE5gUeOY; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 065b0a86927111efb88477ffae1fc7a5-20241025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=z6oLxTZorx7qbehkUavYggVPaNG7Y/6pk4tK4RfMeaU=;
	b=NgBiG3vQ0TDXM1xRGoyL6cNO9UFZSmXWswdrUtL+yfs+Cw0RrECBd9cIZzKjOl3Eu6HMetSoe8n5tVJZ2EiP5qNHEsI7HYej8cIByY9p15UkS75+CA3K9GOIFq895CAngoSHlkVCenDJTorbXKJC2mH4kiqch8jOlcUbP0u3YYE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:5c8ef4eb-97ea-49e0-9a32-127ee140e1d6,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:3a21d4cc-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 065b0a86927111efb88477ffae1fc7a5-20241025
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 235981387; Fri, 25 Oct 2024 09:32:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Oct 2024 09:32:39 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Oct 2024 09:32:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSsplYsDbwW+ff0nRIB+5RZ4xbrbZDOefFq+T2c64f/S/x/dds0fRq0Ij+Fs4Hl6dRoIJHElN9AE/uImJqmIR0EEP61cwNIuZOyQWJa12fgDeICK7azs3hzqLXJHhsNbaTHhpUONbxP56lim1Y0FcuY0SbwvbgZ71KjN7mICwWPrpK1B1A2xuTR2rGO6EdMc/Q5AI/i8K1Xrcc5vtJ+0ScKd/HBYWNQTvZaY4y0LiDCpoqsdJgkMZyYkbl3Nj6P3fXEDd1bnyPigkIjUgkR8Fp7GXhA1MeRMskEEI+6z0VKH/lm7MTWBAvEp2DgtFq3MeWwEBveJWIzVmxdYHbBNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6oLxTZorx7qbehkUavYggVPaNG7Y/6pk4tK4RfMeaU=;
 b=AmSXG5LrCbpXJZOyUJEuM9h4i3weL0ms8qJkmVzAtI1p1yY4ATFZ1pEQyK6wjVqXrDLrxNIqQhJY6pt0WpodyiCfXHyQRCutK6h52kA5vwA8+f6a4BiZAaGfrMoZZwXTZIdWKW2ad3t4JAGEKmLD3JcN5ZLkK9yStlxPRZVEHjVZk+yroii8qGTSLWLmB+P/FKT1+b/NmaRzTzJZ88qoSAf7AuCWe62g8MZ50HaLiz1/cz9XMMzgkyD5VU+n7IOJRoCPJzgz/JLmlmVM0ADjFm/eq+8O9HtoQe1zIz9au/XarU7f8uVIMZNz3K6tV8sd6sn8IM3U9911tcFNKIAAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6oLxTZorx7qbehkUavYggVPaNG7Y/6pk4tK4RfMeaU=;
 b=jE5gUeOYIsgKxKwrdAVqsAbp5p/W7YJZdME1X94p8ZEKT4wHwgh2k5nR7dm52sEE6aRqgiKLwAQ+bZPUCnTNFrxoie6ZSmz67TEc7XzNCBpfkac874msYGWH5CFIyLxxB3X4lbw9axBTLrN1m/yv/hfCnkJNTIE7vVRenCX454Y=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB7668.apcprd03.prod.outlook.com (2603:1096:400:41a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 01:32:37 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a%5]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 01:32:37 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: "dianders@chromium.org" <dianders@chromium.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?=
	<Bibby.Hsieh@mediatek.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
	<Jason-JH.Lin@mediatek.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "djkurtz@chromium.org" <djkurtz@chromium.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?=
	<ck.hu@mediatek.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	=?utf-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "littlecvr@chromium.org"
	<littlecvr@chromium.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 08/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation
 property
Thread-Topic: [PATCH v3 08/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation
 property
Thread-Index: AQHbJlcM+XgY83PS/UONQZcY0r8SzrKWrtwA
Date: Fri, 25 Oct 2024 01:32:37 +0000
Message-ID: <b75276ff8dc2f73818ccd132530c0d3825e17888.camel@mediatek.com>
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
	 <20240620-igt-v3-8-a9d62d2e2c7e@mediatek.com>
	 <CAD=FV=XTsPBQ7Qp_oQmBXkNY==KQWZdN7VYbuVPoBTHhMvzjUQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XTsPBQ7Qp_oQmBXkNY==KQWZdN7VYbuVPoBTHhMvzjUQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB7668:EE_
x-ms-office365-filtering-correlation-id: b920cf94-8586-4aa3-b3a9-08dcf494e87d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bTFOSnhXLzVEc2oyMmZoWTFlNS85TXhVRzVhaDd6Ynp2QWNSS1dCWkhraDVH?=
 =?utf-8?B?K1RmSjY2enNqdEtTSDlrS2h6Y1FHcXpIVWlVRXR4eWhoRk53MExkTHljSWVk?=
 =?utf-8?B?a3lZdzFOQWNyZzNaUVU4TkF6TkpEa2Z2akRVcmI0SElKeUVGRVJ3ZjBFYnpr?=
 =?utf-8?B?bVcxT3FQREw5aHM5UFQwUllLMGFkbnBCNzlhYkxJSWgwOVpFKytUbnpaaElV?=
 =?utf-8?B?Y2hwYVhKZmkzb0phUHhiWURGQXVVRGFCNWlPdlk1NWFuNHZlVitaQ1VZMmU5?=
 =?utf-8?B?OGxPdy81NHk3czdZNCtkWFlsVUhrSXhpcTR4Q1BoRGV3cFB5Z0w5Y2ZUdEIx?=
 =?utf-8?B?ZWx2Rmd2bGo2aklyZks1YnIwa2YyYURtYkZ0SlVXME5yQkpsME9DN0NUbGFU?=
 =?utf-8?B?dXNTQnNwQmdtbU92Nmlnei9xME8yR1lnVzJDQmtaaXloSFNCQmlVT0pEeU4x?=
 =?utf-8?B?YllYbUIvK2s0Mm9TUHZjeFhoRE9kR0RHMXdLd285THA3UlVTQ0NwZkFITjdB?=
 =?utf-8?B?K2M0U2VISThWTGE3di80NW11Tm44OTd4SHRJalJUalRQQmV2Zjl1dHV1b0VB?=
 =?utf-8?B?bUN1K2ZxVFlYZjRkYzZnWlVZeHVicGt4UGRyVjkyUm8xcmlQR05qd2REMGg5?=
 =?utf-8?B?eTZTOVFTMkNXUHdjQXVYdnJod3N5ME5lWHNkaENkUkZHVWdiYTcvV0toQW9u?=
 =?utf-8?B?UVBlVSs3OVdFYjQ4UlNLYXhIMzVjdzR0RExiZ1ljMmlmQVVMazVPdTRHdy9N?=
 =?utf-8?B?U0RGWFAxUzJQOVZ5L0lmV01CeW52ZHgrZmt4TDJWd0c4UStuR0J4dmtkbWNo?=
 =?utf-8?B?QlJoK25uREQ2cVZrdHZBVy94dUZjcS82YXh2T2hvODdhMGZkcjF0SFpWeHVC?=
 =?utf-8?B?dkY3bjZMMi9jRjB0djJRU0hraVp4Nm9iVHNtWG10Qm9xV2s4S21ESjVsRnZE?=
 =?utf-8?B?M21Da05vT2JuSHljNEpKQUZDUzUvbm5lN1MyZmFlakk3b1FuaDBCUXBIbmpr?=
 =?utf-8?B?VmhON2psVWtONDFQL09TYmNJaWlIUmlsVjRoc0dNYThQSmRTVk5xU09aUm1j?=
 =?utf-8?B?ajViS2xsTXdBbTVnOEZBdWN6cll5L1o3cTlLOGRwU2tEemJrMDhXdDZ5YlI1?=
 =?utf-8?B?bkxNSThWaUp2R1ZqbC9nSm1ZUXo5Y3p6S0oyQ2dRWWpZK2lHRGMyQUwvN2hj?=
 =?utf-8?B?NFlwdy9qQ3NDZ09PcGllaUZDaWVkbTdzanFTbDdwZ3p5eEMyWkZQKzNva01m?=
 =?utf-8?B?a0xzRk81N1I2MWFybThHaldZSjBWTWVGdHdTMXhvWVI3TDJBYzY2cTc3M0Y3?=
 =?utf-8?B?VkFqTTJSemhBSGJPY1BiSkZtNjkwRkVvai81T0tUNTZ1dmE1UUdnSktrYyt2?=
 =?utf-8?B?RXV3czY4SWx6eFFKUlE1SjRnRitWQnNzUkZsQkN0N0MwYktnY1JzcDJFU3dy?=
 =?utf-8?B?dEh6NHlQcFAwUXpFVGVwTVZXNGUxeWpTUU9FMU02cGhlK0JBaXFZckl0ZkRV?=
 =?utf-8?B?ZW1pV3ZNVlpaVExhSGdjcm0vZFZpRENISUJHdTIyYVJRaXIwamVyVUxCODdn?=
 =?utf-8?B?UjZ4V1Mzc0VOcS9WeTdZcWsxK2NscHRoM1VGeGZraGNLN01QaENGcm15NHow?=
 =?utf-8?B?UmNQcURGKzh3L0xCcmtocWY0ZHlZTEw1NnA4cERNVGdHZTQ3UWJOSjNOQ2Q3?=
 =?utf-8?B?eUJDMGZqcnYxRzVGVkdjNkY5R1h0UTR6RjliWU11NnNkRktiNDZIbmxxWC90?=
 =?utf-8?Q?6coZy4Sv7dbHcR54nqup+sGLKwJcO6pkqwdGXPN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0Z4T1EzaGhTdStFdThSUVFNRTVETHdjeHFmSlhRT05JVFZ1UWhCWTRvZUls?=
 =?utf-8?B?NGFvc0dXTGpaYTYyZGRiTDZ3bnBWTFF6dXU1ZUsyQ2JzVXVJaFd1dHFnZVdT?=
 =?utf-8?B?ZE5VUU9sdDFkWDFwUzB4V2dtdVBPWHY4REpLU3B2U0RPUFhzNGE1bC84OUV3?=
 =?utf-8?B?anFWUldrSHBGRkZ4U2cyWDhzS3NrZXhmY0dSZ0xEK1ZoMTBkWmlmNGpxNElm?=
 =?utf-8?B?OWc4VXB2QzgxWmk1NUMvajdTSWw3bjEzcWVLQllSYytYM1lRWTB4TnBmNWd5?=
 =?utf-8?B?cmRQTWUyQ0hORHFXQmxoQTFCK1BGR3l6RkxDYzUyOFlNQ0UxL2h3OGhvQVZq?=
 =?utf-8?B?U0QzRXpsdTBtNEVoNkpzdVFvK2pDK1hWWk00aHVCMGpaWEJuMmZSSUJxZlpO?=
 =?utf-8?B?alpYc0N5aDZCYTJLd1F0OGJMN2hHaWxYVEc2MVBDYmYxYXV3SjhuYUVHSTJj?=
 =?utf-8?B?M3ZHVG16eW5HZk5yR3ZJSVZKT2lWUVJCSnBVNlNiS25qVWJMazFQSCtiSHhy?=
 =?utf-8?B?aFEzUXhBY3lWbGlKVXhSYTBla0crTHFtYVZtbFJrc0JJcG1vZTBlT0diVWtT?=
 =?utf-8?B?MStyNXRFUlpFWTduUlJDKytHVGkreU4wVXdqOXJrQlNUTmRRU1k5M0RUM1Vv?=
 =?utf-8?B?a2FHZUhWMGd1aWFhZ3RZSjJ3MlM2dUpKYjZRb0x5S0k1Z0tzL0JkdHlyWGhy?=
 =?utf-8?B?SVZpZUQ2eHdjWVcwUDdXcEt3R1FhVVA2UmM1aVk3MTQ1S0FQQ3dSQ0JxYXk2?=
 =?utf-8?B?ZzgxR3dQZkZ6V1RqVmg0Vldlc0lacllPcmhRVmZMWVNpSHZJUHhzK0FidUZm?=
 =?utf-8?B?YnltN20rVVh5azU0eHZNVXdRVTJsTUZ5MzJSaVdqUUh1c001OTBOLzZMNnNX?=
 =?utf-8?B?b3FDK21iQ3kvb0ErbGpRS0hjcFdqQ2ZyQk0xOFV4UGJCMW9VRWtLZEhTMlBQ?=
 =?utf-8?B?TDRIdU05YWUxdG9XRnpZbFBZN1piYlJHblpycGM3TnE3OEk1TDhua2plZ3RX?=
 =?utf-8?B?c0dDTHBxZ0NuNEhRVnlQcnphRDcwRWVGTXhaamlFUkpLMTNuOXFscWZvRzRG?=
 =?utf-8?B?TmVmRkNJblN6MVVYc3M2T1YzTUovQUtoampCaE9qUk1YUVB4RHJQd0Z0UjRT?=
 =?utf-8?B?UFRTMG1oWDQzVjZIaUJRQlBFREhPakg1dXJ1RkM1aWt6QzBzYjEzMnV3RnJ2?=
 =?utf-8?B?UG05UDBWL2hvUVFMUEZ6WGxMdnlUVXp4dmduSDNiYzcyZmprRS92VWNMakkw?=
 =?utf-8?B?MEVvNmxOeG53RktMRUFleHErN2xZN09lZUNWdjVyVHRLbzVpQ3E5VENjZFY3?=
 =?utf-8?B?ODhtdm9FL0J6c3hQU0FFMXJNOUNvWkowdjJCTzJJTks4YW9wWFg0UCtPVEVV?=
 =?utf-8?B?blFFU1dBNmNLU3ZjRjh4MWl5VzMrVXdTclhzOUVRUjlzaFlSYXh1RG02Qm1r?=
 =?utf-8?B?aHVuMzNHQk9XTkwvRjBTZVgwRzdiYWd1Mkk1WWkzd3pIZDg3WjJpS0p3eWhB?=
 =?utf-8?B?ZU9qWEJSanlNZnVGZTVTaVpqak5ONUFid3NweGh2ZVd3b3ZhTEt6Vk5OeUxM?=
 =?utf-8?B?VkpxRG5tSGVSaGJId3h1MmdIa29KaVcrVGZjUEowYmFwcm1xT0hxL2dyalRE?=
 =?utf-8?B?VTdJVi9FZlhlZkdFQjdLanJFaVVsSXg0VXFyL0ZjU0t4b0ptUHpNUTVBZHhx?=
 =?utf-8?B?K05Wb0J2V0FnMjBVUmYyK3ZEVnJ4cUhVTnd1Ni84YVFKdFZvNWROaUhKQTNL?=
 =?utf-8?B?ZGZDL05ndkFGMUFtbW94bkRhMU12TzQ0Wkpjekt5RWJnNk1XTmx6SjZTdEVi?=
 =?utf-8?B?Q1l1bEpiWUE2RzZWb2FRSU9yVzFqTFdYMFh3Sy80R0FRVFJTRUF3Q3ZaTHox?=
 =?utf-8?B?TEFaRnV0anEzbUtFWGoxbGZoR3FjV1NlOEhMUU1GTlJkQTZLdlE3UFZpQXdz?=
 =?utf-8?B?ZUVxOXZKcGp0QkhVWE8wVWY3WTlSQ01hdDRsY09UYUNyL2RJcXlQdDNxczE5?=
 =?utf-8?B?Z2tNTjh4K001cUlBWEkyNnhRZ2IxKzNYSXprZXpVc0NPNzloTGtid0h6V210?=
 =?utf-8?B?c0lST1kxYlYwc3RReHZJYm5mTjU1b0dLV2NrY2tPREtxMk1iT1JZMjNBTHAx?=
 =?utf-8?B?V01jNllqOWZ6RktnRWduOEM5aGRVWm53ZTJBVC9RemZuTzJjTDJpeWdMdUh5?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B749AF4936EDA40A08D42278A7CDF7E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b920cf94-8586-4aa3-b3a9-08dcf494e87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 01:32:37.2469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtw1bzIbH2kpa7TlgRoe0bTTqciX2Jk7ko25PGOl6D/3qleoKNvNeVFDwEAcpZwNtYAD37jqYZmE1/7jQUXPsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7668

SGkgRG91ZywNCg0KT24gVGh1LCAyMDI0LTEwLTI0IGF0IDEzOjQ3IC0wNzAwLCBEb3VnIEFuZGVy
c29uIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhl
IHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEhpLA0KPiANCj4gT24gV2VkLCBKdW4gMTksIDIw
MjQgYXQgOTozOeKAr0FNIEhzaWFvIENoaWVuIFN1bmcgdmlhIEI0IFJlbGF5DQo+IDxkZXZudWxs
K3NoYXduLnN1bmcubWVkaWF0ZWsuY29tQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gRnJv
bTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4NCj4gPiBB
bHdheXMgYWRkIERSTV9NT0RFX1JPVEFURV8wIHRvIHJvdGF0aW9uIHByb3BlcnR5IHRvIG1lZXQN
Cj4gPiBJR1QncyAoSW50ZWwgR1BVIFRvb2xzKSByZXF1aXJlbWVudC4NCj4gPg0KPiA+IFJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBBbmdl
bG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29s
bGFib3JhLmNvbT4NCj4gPiBGaXhlczogMTE5ZjUxNzM2MjhhICgiZHJtL21lZGlhdGVrOiBBZGQg
RFJNIERyaXZlciBmb3IgTWVkaWF0ZWsgU29DDQo+IE1UODE3My4iKQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmggfCAgNiArKysrKy0N
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIHwgMTcgKysrKyst
LS0tLS0tLS0tLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5jICAg
IHwgIDIgKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxNCBkZWxl
dGlvbnMoLSkNCj4gDQo+IEZXSVcsIHRoaXMgcGF0Y2ggZ290IGludG8gQ2hyb21lT1MncyA1LjE1
IGJyYW5jaCB2aWEgc3RhYmxlIG1lcmdlIGFuZA0KPiBhcHBhcmVudGx5IGJyb2tlIHRoaW5ncy4g
QXMgYSBzaG9ydCB0ZXJtIGZpeCB3ZSd2ZSByZXZlcnRlZCBpdCB0aGVyZToNCj4gDQo+IGh0dHBz
Oi8vY3JyZXYuY29tL2MvNTk2MDc5OQ0KIA0KVGhhbmsgeW91IGZvciByZXBvcnRpbmcgdGhpcyBp
c3N1ZS4gV2UgYXJlIGN1cnJlbnRseSBpbnZlc3RpZ2F0aW5nIHRoZQ0KYnVnLg0KDQpTaW5jZSBJ
IGFtIHVuYWJsZSB0byBhY2Nlc3MgdGhlIEdvb2dsZSBpc3N1ZSB0cmFja2VyIFsxXSwgY291bGQg
eW91DQpwbGVhc2UgcHJvdmlkZSBtb3JlIGRldGFpbHMgYWJvdXQgdGhpcyBidWc/IFRoZSBtZXNz
YWdlIGluIHRoZSByZXZlcnQNCmNvbW1pdCBtZW50aW9ucyAiaGFuYS9zeWNhbW9yZTM2MCIgKE1U
ODE3MykgYW5kIGl0IGFwcGVhcnMgdGhhdCB0aGVyZQ0KaXMgYSByb3RhdGlvbiBpc3N1ZSBpbiB0
YWJsZXQgbW9kZS4NCg0KPiANCj4gLi4uYXBwYXJlbnRseSB0aGUgcGF0Y2ggaXMgZmluZSBvbiBu
ZXdlciBrZXJuZWxzIHNvIG1heWJlIHRoZXJlIGlzIGENCj4gbWlzc2luZyBkZXBlbmRlbmN5PyBI
b3BlZnVsbHkgc29tZW9uZSBvbiB0aGlzIGxpc3QgY2FuIGRpZyBpbnRvIHRoaXMNCj4gYW5kIGVp
dGhlciBwb3N0IHRoZSByZXZlcnQgdG8gc3RhYmxlIDUuMTUga2VybmVscyBvciBzdWdnZXN0DQo+
IGFkZGl0aW9uYWwgYmFja3BvcnRzLg0KPiANCg0KVGhlcmUgYXJlIGtub3duIGlzc3VlcyBbMl0g
cmVnYXJkaW5nIGZvcndhcmQgY29tcGF0aWJpbGl0eS4gQ291bGQgeW91DQpjb25maXJtIHdoZXRo
ZXIgdGhpcyBwYXRjaCBpcyB1bmFibGUgdG8gcmVzb2x2ZSB0aGUgbWVudGlvbmVkIHByb2JsZW0/
DQpUaGFua3MuDQoNClsxXSBodHRwczovL2lzc3VldHJhY2tlci5nb29nbGUuY29tL2lzc3Vlcy8z
Njk2ODg2NTkNClsyXSANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51
eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9ODk2OTY0DQoNCj4gDQo+IC1Eb3VnDQoNCkJlc3QgcmVn
YXJkcywNClNoYXduDQoNCg==

