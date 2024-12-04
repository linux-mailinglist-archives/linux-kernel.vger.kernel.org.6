Return-Path: <linux-kernel+bounces-430896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1DA9E36EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516BBB29BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4821AC435;
	Wed,  4 Dec 2024 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="desFiCYT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ppna4QgT"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A207442F;
	Wed,  4 Dec 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305621; cv=fail; b=uF72tqqjoAvHFFwDDp6A4nMBoOxP+AWpk0V3KCrSPBktoNCMMynKZsMILOzPHMktY7kf4h7s/e0iFSQznWCqvsiRwzwAR/ZEweFSqZ5svNcSieRuPoIzW9OFblbHG6M1CXQfS+7PNJ+9tNEsLfbWSyIhj4DqmXebQe4fxSnR9NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305621; c=relaxed/simple;
	bh=CeRq4TvSTHEcX2/f0OWn2kJ3ujXn80MNID7oT602830=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i3sS2dx5fHnGl3dMOmiZOSh5hgOxJyvBsQ2sl/eaOvauMQOxToqsSi2TorEJEiyiKZBSznwSqqZ+8WPf3WGIqseKDNufZrjSN5RkJU1gu4NeA6rTHTd5MV5sOemJURy7AIjoPSg0T3WFKBwm0klj1oCDg8qcIBSVCWvIYO9aVos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=desFiCYT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ppna4QgT; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b0cbaa70b22411efbd192953cf12861f-20241204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CeRq4TvSTHEcX2/f0OWn2kJ3ujXn80MNID7oT602830=;
	b=desFiCYTUlh2XVzDJsNY3wDl4cIhIusRwVpf/mVN4Jxb3x4B9j57gASNOaRL1V8G04ktQVtm9MKJW3B/d9aOSPQB7YsJuqvdaJH7iAOXxGwVJGH3hvkQkmxp+AqBCE5OAP9MzZoyAtvSjds0Fv8zLPNMC9zPCnYdeD8Gc01dA7o=;
X-CID-CACHE: Type:Local,Time:202412041741+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:dc2f9a2f-f5f6-4f86-abfc-5aebcb35f185,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:53e2bae0-1fe5-4c4a-bdf3-d07f9790da32,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b0cbaa70b22411efbd192953cf12861f-20241204
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 741980829; Wed, 04 Dec 2024 17:46:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 4 Dec 2024 17:46:50 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 4 Dec 2024 17:46:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjBP4BldnZnPwegQaJoQvC+8je0OiCeuHAOK0Rk5lQouk/os1ERoQsfpbGNe5D32qKVoXnbBcu+AxMMhUHHGaS2G+oXBLuyTPMFCEJfAshJiFgHbHdINVLjczv6tcGoOL9IkYBGziY29YZpbb4wDIU2MFMuWW+v5jhBqpxvBTuuz69IrTTsUuoRqJuCSh0XO3q/MMc6wbo7cSMPTf/F6zQACoLtWr54hI0gr7r5tFKQrjQqOJddJFMvAA712Lu1iOwuol/j8Zu4TRI96XeJfDeoBXb3ndVgCIuXFjgyLVzgKkcWx22pkYkt0WyBjgmV7msP2Xd8wXEQO2K4bRXXbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeRq4TvSTHEcX2/f0OWn2kJ3ujXn80MNID7oT602830=;
 b=fl01g4syoj8S6WjQattsFZ2PpneBsLCrKKSxS6weZhpMkB4QPEeXcDhdh42ejmsr1/8RE9YbZvfHqP7Z+jAe/f9AAyRt616PLfNTnrR/OmoTs2z60t5rs38yXZ56xy6ER4jqw1tSC6pZMQxUTD5oI7tFw1ffseZq03ns7HYd30FJj4d7h/PzeETc3TXOo6Alxiczfyvwfva2aFv8C9vkXUQMc/Mf5lXM6dMdUINSoBtUFLHjCpA1JHQtRq0jB8MbYPAI9Dnw9kXuoaJI1pvsyJSeB0rL8NCF2ghB/IuIOPxGF8hgLnvZsyJyFShGGHR8q4AYxggPrbGOZaWvJXuQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeRq4TvSTHEcX2/f0OWn2kJ3ujXn80MNID7oT602830=;
 b=ppna4QgTC8PoW891qCTMBZaBOnzNwpiMhTQ5wR7fF+9ox7kBXyERCVyOeTdrQRb/Trm10UBqTU6s9HmxQHTlTQTW36Uu/txVwxEodmdKhfrLYczACw8qt2SOTuTBdsajXQrverpkfCof6JpGKQ9umLbzLJZGFvexF/g1JtT1bBk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7930.apcprd03.prod.outlook.com (2603:1096:400:465::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 09:46:45 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Wed, 4 Dec 2024
 09:46:45 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "mripard@kernel.org" <mripard@kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Topic: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Index: AQHbO0pF3Zp6UXdpSEmkHbI6wNkmT7LV7EYA
Date: Wed, 4 Dec 2024 09:46:44 +0000
Message-ID: <278d55ed1b6d6f8240e8df98e915bc3ad329c2ec.camel@mediatek.com>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
	 <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7930:EE_
x-ms-office365-filtering-correlation-id: 06a0a0b0-f4dd-49ba-0550-08dd14489070
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cTl2WVZaRkwzRkZLWlVTUEpteUVNSld3WkNTSWdWelhDN2NJZ3dVM29TbmtX?=
 =?utf-8?B?US9USHZ4YUFNWXRHc2hsZks4SkczdDk0bmh1L1cvUVJtb3JQL3FDRFJTSTYx?=
 =?utf-8?B?UURrd21yL2JwSkNmUkU0d0FTaW5xK2FINEJ1R3Y4VWZxUGRzZ0svYStZemJP?=
 =?utf-8?B?WlQ3QXlLd3pvTFAxM0FMT015Y1M0TUVNejJzUTNSYUllTUFMeUxiN25aVkhT?=
 =?utf-8?B?aFdMS1BLa3RJSlFvUmx6ZDhYcXZRbThMcjh1cUY2b1E2am9KQ3JkYnJRYzlT?=
 =?utf-8?B?SFgwSTUvK0NPV0FuZTFISUNyTHRwYlBjMUJHc0lFZCtuS3hybjlzNldWQ0x2?=
 =?utf-8?B?L0cwYW81eng1MnVlUkcvTkM4MCtRbDFLOEcrc3Y0MU1ST1h1b2Z3d3hWNmJ3?=
 =?utf-8?B?ZjlqRTVhTkM4WWE0cmV2YVQrNWROS0p1QThHS1Q3K21TYUFXdmw2ZXdWbjdQ?=
 =?utf-8?B?NjFtY01Vb1FmSk11Mk4wcnRmU1JyblJuOVNpZytlVzRQQ1B5dE5HOEtmd2ZO?=
 =?utf-8?B?b3IzOGszQWh2c2FyaXJtTEZYOW5panlVSlVOU3BpSzlkNlNoQkFmbWNHQkF4?=
 =?utf-8?B?ZXlSOWZPWWc5SHlIQnBWYUlQbzZwT2tzOHhBSzFPWGFaTDdHU2JsM0x1R3Q1?=
 =?utf-8?B?cVRiZVRBdEpXS25aR1QvWGMzQjgvbXVGTXB5VFlpdU1JSHVheU91MUhBdkVt?=
 =?utf-8?B?WTdSQVdDRXVXVGZ1RjZnM3ZIeHlBckpWRG1YRzhFS3lYdE42TlRaUzhEUGVp?=
 =?utf-8?B?c3d5bGRjNzAzTlluUmZvaDV0ZzZkS20zVUF3cUVLSEkvNW00M0MvN2VuT2JQ?=
 =?utf-8?B?M2l0YXA0eGxQd2c1dHVUQURVcjFmMVlNK2ZpbDd3QVpsbG5rTUJwYXRoT2ll?=
 =?utf-8?B?Y1FheWNSUnBRbC8yUThOOWcrbFlMUDhqZDBjeW9JbE9Hc3RqT3RvVlFXWG9D?=
 =?utf-8?B?SEVDNjQyRTk3d2h0VXA3czB6NERWeGdKU08zU051RGVReUhqUEN5R3hyQ3Nw?=
 =?utf-8?B?cEQrcXFVT21FWDA1NzdRNW1oZHhvTCtyb0NLSHoxSUJDNS9kTzNINGhxMWdh?=
 =?utf-8?B?bC9PMWNJL0lMZ2NkcEVXc2Y2MkVHaVE4NzlDZHA3THdOSFgzaU4zN0lNanEr?=
 =?utf-8?B?emM0VndqSGRrNHdzdDQ4K096YlU3b0hYU2xxNTBzUEdwS0FmNXdaMkdmcGlF?=
 =?utf-8?B?QXNyZ2g5UFkrWWxNMy8rV0h2cUtod21WcFMvS3FaUDVoblJ1OW5oMU5sd3F3?=
 =?utf-8?B?cEhXUk5BZ2ZTS25wMloyYzFTd2tlTUV0VFFiRTY0dWVXSEFHUnV5YjQvUkNj?=
 =?utf-8?B?VkZ5U2xlZ2hXSHNBaVlHdDlINHJVMlF0eFpyajh6Y0hyN3FwbGtkbUhCWU1O?=
 =?utf-8?B?dm1mZjIvdWxzUnpiSGl5TEROc24wbGh0c210L1NrU0FBZGxmSWFjOW81ZS9F?=
 =?utf-8?B?cFBwQ0FkYURNMW8xK1MyK1ZVcEM5V2Jqa1NlL2h5dndJNTJQcWtkZkpJeGZ6?=
 =?utf-8?B?USs1SW5rSlpUY013eTJBdlR3ZFBYMXBXczNZTExsTUYzZm1qUThrcGtHb1RY?=
 =?utf-8?B?ZW01SU5aNkZTTmU0ZmxXWDdzWitjKzdqUG0vNW5TWi8xaHVmdXkxNXhmK2Rk?=
 =?utf-8?B?ZEtpa3hwSlFhMkVBQUdDRzFvNkd0dFREQWlka0JGOEtyaWhmTlFEMS95TzdF?=
 =?utf-8?B?L2tnWEhVWUd3OG9VZzNYWnYxWXR2eWpjRHVXc0xiZkRZdjBsWmNRMkRwYURH?=
 =?utf-8?B?QXFQQUs3aFVvdTJZdElTMFZSaEZGam9tZmpmSzQxYUN3aGoxOXl1LzlsNGZv?=
 =?utf-8?B?c1BQODA5V1JSOExlUnYrSktTWnlQUWVwRmpWZWE1b0t4VnoyaHVPMmxCWktx?=
 =?utf-8?B?T0hCOGJuN3RNT2c1bTFoc3pReU1EdmovMWd6eGsvMjh3Vnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXlLS0g0ODRQYU40a2ZGcjJXUjlRMStFZ09MaHNwTDRZSGhZbWFQSVhrV0px?=
 =?utf-8?B?eTNEbVZlTHZMdUJGZ202bkNCeVB5UFMzelFXTnd3MTduQzdwOTA0U3pVWUJT?=
 =?utf-8?B?cGJONVpxaDZzaXE4Zit1VUNySEtqMXVhM0ZKWExjOUNlOGhITTcxcVBrOWJn?=
 =?utf-8?B?b0JMcDJ1M3NOWmZzRHN2aG10aVYzRERXTkdHWDFEL3luQVoyZ3VTWEZoaXpZ?=
 =?utf-8?B?aUF1dy9vWW5GUnhHN2VzMkg3Ym5LMXAxRVNoakNlaDlHeGMxZWF5eFpjNGhB?=
 =?utf-8?B?VWZ6TVdoRVJRVHlIZ0szOWZHQUkzaVJNMDg4c2pTTHpEeDFzdnVFckh2SVpi?=
 =?utf-8?B?QXYvUGZhVkpDZ2FYWUlvdk1haS9YNkRMWE51b0dwc0N3ZzBMZGtuR0JwMXdt?=
 =?utf-8?B?aklsTGxDZHVrRTd5dDVEVitoeG9ybkUrQngwNlY2dDhCQ2xRMndoVk9NNGY1?=
 =?utf-8?B?UXpVZ0JYNDZ0ZGNMZUVkVE1Ed21DZzVURmhRN0hzcFRrOEoxY1R2RzA4VHpI?=
 =?utf-8?B?RENNdnlNRkZTVkhaaDRlbloyN2xwRnRuSW9NSzNQcitSeXRzTHpLMytPbC9F?=
 =?utf-8?B?TFRrejl1NGZSZHFkN1JOYVE5Qjg0eU1jZ21oc0JwVjhiWEMzYmQzSWdzRG55?=
 =?utf-8?B?T1N6b2trTC9rM3VZaVFkY3U0S0sxZ2h3UkUwdTFkZGE2RU93WUhmYVB4R2hh?=
 =?utf-8?B?OTkrTDhnV1RIampOOXQ5SVRCekdkeVNvdjlSU2hXaGh1NWozbEFWV1FpK2E3?=
 =?utf-8?B?R2s0cWtGaVhwVEJDbW5zamZsRjBTYTlGbHR6REJuTFgvZ1Z1bFFNS3A2OHJ4?=
 =?utf-8?B?bEszaWV3Q1NCSHFyOWp6cWRyZDFudGlkYWRSRnRqaU5CbFhWQUtoUW1OeS9F?=
 =?utf-8?B?REVFYTUrcVRWdTU3cHZkNC9QYjBiNzhyLzhoWWthRmFtTTN3MFA2a0QyRHFk?=
 =?utf-8?B?eEVQL2VHTmhkOG1WczNFNHp1a0xVSzNKYWFOMFBNN1p4Zm95bjNwa0NzeUJG?=
 =?utf-8?B?bVNZcC9RQ0MvbmZSWDh1aEREU2lEOVlBaUp5cUJ3ODdVOTU3ZFoySEZVbFpM?=
 =?utf-8?B?UXdiVURiZkdPTW9tNURFNGdrTXdlSmFNZHlycVB3dXlDZFpkQ0tDSEMwN3Jq?=
 =?utf-8?B?ZU5NaGlhVkRSV0VTZ0JuSUU2M1JNZHgrbDRWRExhd0JJYTExanZzblNHR0Fm?=
 =?utf-8?B?ZUdFT1lXUldOVStvM01IdFgxeEtDVTJiT1dTZGtCNlhORlU2OFZGUSt4NlRu?=
 =?utf-8?B?aUliYjY2Mnd4Z0huUnFEaFgrcFc2bG84UXFodmVaQWNNblprQ3RJRmJhd1l2?=
 =?utf-8?B?QXg4eUU4MTJ6bnlaNllCNFFnNTdJQzJXZjBCeWN3TC96bkxRclBJODJkbjNN?=
 =?utf-8?B?azhqMUF2Q2psOWR2MkN3dy8zTFduM2tZL0pZMDk5SDZReDZEbCtROE1xYWla?=
 =?utf-8?B?S1NsT1dTM2I0QmdYNllGMWVLUW5qQk9CSXRlOVEyVmRtQi9kcVhlNjcwY1Fm?=
 =?utf-8?B?czF6R3NOa2hUMyt1a1BBLzVQRHNwRmJUa3ZkNlE0QlhEWk5OVi81VUxQYlJB?=
 =?utf-8?B?TlV1T3cwdW9URkxzS095VytIN3FmbWZsRUpQYjMwQUJFK0xOZ1g5MlVlbkhO?=
 =?utf-8?B?enc3OU1CbE9GN3p3c0sxSjN4YjFMbnFHbmRaNXFUSk03V2g3QUp5dlhraEVV?=
 =?utf-8?B?bUViVVlxU3NZc0xPVlR0YTFCWmp4Vy8yNkUvclZiN1ZuaXIyWlBJMitSZnJs?=
 =?utf-8?B?VkNQR2krSlRITWlscmdrUEFiVHB4SlNOcE93M0JQNFhaRkJzSGlkSll6Vm9x?=
 =?utf-8?B?ek45VE15THYrWnMwa3oxeHBxek5jaEFXR2d3WE1PQ2pPWUhZSjI5cWZRMjI3?=
 =?utf-8?B?dUJEbXlqMmd2KzY3ZGdmTUFZb1BGd0pBci94MERONkpsY25uODlvd3JlbVlX?=
 =?utf-8?B?dUtJbVdlR1M2RVZKRWZIdmw2L3NzVGJndHdYNmJKM3N0QjQ0VVMvQUtIamJx?=
 =?utf-8?B?TjRSL083eCtqOUpIOXlHSkk2d2EwNmNnVXRlRU5RdlVZL1lpTFQvdjlqL3Nj?=
 =?utf-8?B?dXJyT2tobEI3Qitsdnh5cGpMS04yaE5IVlJwVDc4ZGo4WkdEYy9iZ0dZQTVp?=
 =?utf-8?Q?FCJNzXMaxnfEUDZ74LmCsVQ/y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCA7A5D8F65EFB4EA95730519D3BBDD6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a0a0b0-f4dd-49ba-0550-08dd14489070
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 09:46:44.9720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E08cO5c7xCXCvxXfRHTQvc6BUdrzNqE3SdOaLacBbOBX1/ffLkUyWV+7uBs1ZT5wg/VMCMHuUH7tZXempgScMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7930
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.507700-8.000000
X-TMASE-MatchedRID: O/y65JfDwwsNtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCsME2BsoiKJMBfVY7O+c8KbAuWcdTSiQDXvsbfoZixUT3oz
	JRX7b4NnZo4bjogR4BrW7tsa7op1l5JVxYapKMGCeAiCmPx4NwMFrpUbb72MU1B0Hk1Q1KyLUZx
	EAlFPo846HM5rqDwqtRguVz50dz/bHUVWyLuew1MpuEyXTgXXm21tmYzE/ZQqOf0EWGBZRyA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.507700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F6A2AED20D8484EF84BA8F5B3EC4304E00ED97A429B6DDB94A6089F4364285A22000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTExLTIwIGF0IDEzOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Ig
dGhlIG5ld2VyIEhETUktVFggKEVuY29kZXIpIHYyIGFuZCBEREMgdjIgSVBzDQo+IGZvdW5kIGlu
IE1lZGlhVGVrJ3MgTVQ4MTk1LCBNVDgxODggU29DIGFuZCB0aGVpciB2YXJpYW50cywgYW5kDQo+
IGluY2x1ZGluZyBzdXBwb3J0IGZvciBkaXNwbGF5IG1vZGVzIHVwIHRvIDRrNjAgYW5kIGZvciBI
RE1JDQo+IEF1ZGlvLCBhcyBwZXIgdGhlIEhETUkgMi4wIHNwZWMuDQo+IA0KPiBIRENQIGFuZCBD
RUMgZnVuY3Rpb25hbGl0aWVzIGFyZSBhbHNvIHN1cHBvcnRlZCBieSB0aGlzIGhhcmR3YXJlLA0K
PiBidXQgYXJlIG5vdCBpbmNsdWRlZCBpbiB0aGlzIGNvbW1pdC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25v
QGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArc3RhdGljIHZvaWQgbXRrX2hk
bWlfdjJfYXVkaW9faW5pdChzdHJ1Y3QgbXRrX2hkbWkgKmhkbWksIHN0cnVjdCBoZG1pX2NvZGVj
X3BkYXRhICpjb2RlY19kYXRhKQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBoZG1pX2F1ZGlvX3Bh
cmFtICphdWRfcGFyYW0gPSAmaGRtaS0+YXVkX3BhcmFtOw0KPiArDQo+ICsgICAgICAgYXVkX3Bh
cmFtLT5hdWRfY29kZWMgPSBIRE1JX0FVRElPX0NPRElOR19UWVBFX1BDTTsNCj4gKyAgICAgICBh
dWRfcGFyYW0tPmF1ZF9zYW1wbGVfc2l6ZSA9IEhETUlfQVVESU9fU0FNUExFX1NJWkVfMTY7DQo+
ICsgICAgICAgYXVkX3BhcmFtLT5hdWRfaW5wdXRfdHlwZSA9IEhETUlfQVVEX0lOUFVUX0kyUzsN
Cj4gKyAgICAgICBhdWRfcGFyYW0tPmF1ZF9pMnNfZm10ID0gSERNSV9JMlNfTU9ERV9JMlNfMjRC
SVQ7DQo+ICsgICAgICAgYXVkX3BhcmFtLT5hdWRfbWNsayA9IEhETUlfQVVEX01DTEtfMTI4RlM7
DQo+ICsgICAgICAgYXVkX3BhcmFtLT5hdWRfaW5wdXRfY2hhbl90eXBlID0gSERNSV9BVURfQ0hB
Tl9UWVBFXzJfMDsNCj4gKyAgICAgICBjb2RlY19kYXRhLT5vcHMgPSAmbXRrX2hkbWlfdjJfYXVk
aW9fY29kZWNfb3BzOw0KDQpUaGlzIGZ1bmN0aW9uIGlzIGFsbW9zdCB0aGUgc2FtZSBhcyB2MS4g
VGhlIG9ubHkgZGlmZmVyZW5jZSBpcyBjb2RlY19kYXRhLT5vcHMsIHNvIG1ha2UgYXVkaW8gaW5p
dCBhcyBjb21tb24gZnVuY3Rpb24uDQpBbmQNCg0KY29kZWNfZGF0YS0+b3BzID0gaGRtaS0+Y29u
Zi0+dmVyX2NvbmYtPmF1ZGlvX2NvZGVjX29wczsNCg0KUmVnYXJkcywNCkNLDQoNCj4gK30NCj4g
Kw0KDQo=

