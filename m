Return-Path: <linux-kernel+bounces-448939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E179F4770
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C223D188A538
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A07A1E3DEF;
	Tue, 17 Dec 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lTkfuJmo";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="paAe6Cvs"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E41E47AE;
	Tue, 17 Dec 2024 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427322; cv=fail; b=DRz6FYeYRJLceYjthmZ5jxoFCg/ifLu+I3nE8fggFFug9Q+l5o3QKksKVA3wrofbxvNTlH+9IN5+hLW8khEXKHFX6we3/o/eO1yN2SjzJHmAhryq1vxumDudqmmlMctNzbv8KWGqz0zdl76GQgMetDN1BymRGj4nQC7I6PoUD4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427322; c=relaxed/simple;
	bh=a5H4wHkAf9ht/hjoYHVWe9SNLrmOTZfq/GyLk8tNrTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ItIworsbpbrl4xXa2VPjdcT6Ufei4DYhH68jMTGwL2MiJ25LCDe6RkJYefQnjRFyJbLO/+0Mu1mkIMglzua+Ul62qTz3CtmnFM3gJRIKrsJCqag6426WPetUXSJvDfBNZRLgMYrwGKE13lpALHg6Sa4BPtIo1G6XFMiza3RbogQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lTkfuJmo; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=paAe6Cvs; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 566de046bc5811efbd192953cf12861f-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=a5H4wHkAf9ht/hjoYHVWe9SNLrmOTZfq/GyLk8tNrTM=;
	b=lTkfuJmo6zgpJCXKZsmMNCvZ9cvGtjt9c7EvS63W5x7FMvJ/qQJBDS/wM1HpcXpWyuSs5OElieArBGpJk+acjcnDSE8WeI3NQJv7dxGxAJNAUdGTJ6nCiXaTWi88eGXySm37lSeejDNP1Wwq1UkSNsRP2kVC8SSex1vvoE4Jq+I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:35c4f7ea-3f63-404e-bca6-35767ec7bcde,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:5597a728-d2eb-4de2-b5c9-495d1bc17256,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 566de046bc5811efbd192953cf12861f-20241217
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1279220559; Tue, 17 Dec 2024 17:21:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 17:21:45 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 17:21:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s96AtPrF8KUD0oXgXUP1sMtT8S9BbgySpc0NMpxnhEfuuzPjOlFyfgQ7XUls5fkUKFbJXZ2bf1QC5dznx1dIF3Wbv0OnsZ+FyoIufgLVQLsbh2ocBacOgEgLH+zm4Qcp/ZtW8XIfaiFCkg4wN/m8Sq5g26KIBMPrZDkLtpzNQZ7VjBEjQsGHvNjLfqVzpGvq364DudKCm7ad+GU+vtk+DDMDi3bqf+no90rmDphcGIZSWSAxWZs8V4P/VTLY37NDPhrWuzKwQ790Xpc8QToZz8/rZqzkAkeCxI9SCpKs65HpgN5ZdofSCVt+4DUUDGgm8eTMe+gnsS8OYpY1tZfi+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5H4wHkAf9ht/hjoYHVWe9SNLrmOTZfq/GyLk8tNrTM=;
 b=ZZMgEpdzc5CjfTpe5aDbaUlMxmzUadgtqP26U7Ik1y0NMk+P9cq1igNRAaHEWAkxiFfum5prcJ5SP7rhqSA/IMr+3dllm8NzPJKfQGk+v9gYrfUIskegdS6U7EuLUjFj22FBFXJ4OXwxJtHkb2HtQFzHvOEg16TCXCKt/blpovLUkmumML7OA6WI4b7DNeivOP3LGzOeSuAiySkHXOKO+mJAdZ3zZNU2yfRF7fcjfdzXg0Q9NGsUflr2UJELSbE3nVTcsfgABJAr1tN+VDGbfC3ZUFts6aMhoL9nYDIFMYmltKQoWg2drVKWnsPIkFBudlNcYOm+QILSe+yGLXC21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5H4wHkAf9ht/hjoYHVWe9SNLrmOTZfq/GyLk8tNrTM=;
 b=paAe6Cvs++FuO2cYJiF1w4qNo0xiPsu91YEPH5oNL8f0937CKCDS2dGL64ptusJOfu95+s4PgNJzG8s1JDFCmv02SZJgebHBCiRibRzKWNAfRvqXJDGGAPoustIdCSxWQQXEb1HwA/IHirelwiFRdjxQW+e7DlEgZpCOiiuScx4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7699.apcprd03.prod.outlook.com (2603:1096:101:142::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 09:21:43 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:21:43 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "jie.qiu@mediatek.com"
	<jie.qiu@mediatek.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v2 15/15] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Topic: [PATCH v2 15/15] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Index: AQHbRwuJJIpw1RNG4k2Br44bBPRYWbLqPBMA
Date: Tue, 17 Dec 2024 09:21:43 +0000
Message-ID: <6ed3b9ee742dcf814f35e15d88db538480ba2d48.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-16-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-16-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7699:EE_
x-ms-office365-filtering-correlation-id: 9355c909-7679-4a00-bd6e-08dd1e7c38ca
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WVlrb29WU2s3czhFTm5IcUZhcEpQU3hkakhHYThBendWeDA4TW1vNVVPODVp?=
 =?utf-8?B?NmpKM0U0dDhVY2tBZGxQKzlEMm9rWXpEYVZXaVJReTBSV0FwOUx6bm4rZVlz?=
 =?utf-8?B?cVVaNFd2MjBMWnlzTlJZWFp0WS9lSzdwWW9KOVBpNkFnaHZhV2xIaGhzVllH?=
 =?utf-8?B?VWNUZG5ncU9GQ1RaSkRySnlmVXV4T016b0lLY25BcFRzeUJFYjFaUDBnQ2hp?=
 =?utf-8?B?ajZXZ05QTFJNZDlaVjRtd3pnd2JOaWVQTVlhTVlRMkw5TzlZR1MwKy9NZ2RO?=
 =?utf-8?B?cW5vVHdiUzc2NnNGYkUwZkIyaHZqZm0xc3JldXYxTW84OEhDWjZiZ25oajh1?=
 =?utf-8?B?YnpremN0WE9mWWh6bnFKQUJyWXFNT29pUDJKc2Q4VllrZ1VlSW1la09WOXdO?=
 =?utf-8?B?MFAyYnJtRzdsWGtXTFRTR3RkTXFSL3FmR2ZlenVlVkM2MXVWUjdSd2JwNTFY?=
 =?utf-8?B?RXRuUXFnTVRRN3RQSkM2WW5ZTnViY1VrTXc5VGkrVWpkWXV0aytob3l6Q2hJ?=
 =?utf-8?B?Y2VidWM5Z2M5Q1VibnVmSmY0aVpVQ3E1aGNQanNRazJXUDJYVzBWWlF5U2JT?=
 =?utf-8?B?dU1jQ0ljejFadTROZjFmc1hEZVB1Vk56ZFViK2h1U1NjVXh3c3prejZiRFl5?=
 =?utf-8?B?M3ZLRjhnWUZ6YjJ2RVBxRlBlcUJqNjZudXIwTkNucGQ5ZFpBTmtnU1NGTzdz?=
 =?utf-8?B?ZG1icGpqK29xSEt2b3NVdkl3ZVJnOWpBU3V6MXVBMkxtY1k2ZnY0M1loSW1p?=
 =?utf-8?B?RDZrQnRRUXdTcGExZHArK1BzbXAzUk42Uk5QMnJsdEEyZnhzOWhwZHM0L25I?=
 =?utf-8?B?OVppMld1ZGhIZndIaUJRS2UyUkNmczM0RDB3V2N0WGkzVEY3UmU5TnNXUTBj?=
 =?utf-8?B?enAvZHVvUUsvcm84NHBXMEdGdUk0KzRFWkZSeERNMjdGZSsvOThROWpJMkxZ?=
 =?utf-8?B?ZnI3UEtHckZWazdlb0c5TE93WDRWVmU0ZVpSOEdEc1hYSWpoZmx5ejVhQVA4?=
 =?utf-8?B?VzBvbmp6K2FPaEdHRDRyZ1BpejRNK1pYempNeUtqdGJEQUVVT0k2RG5lUFFY?=
 =?utf-8?B?K1hDeS9RamkwOXVoZmVXY2lJNmF5ZnhpZXZWVSs5S0FjUm1VU1VKZG56ZGw0?=
 =?utf-8?B?cHRWajB0VUt4eGVjb01zcFF6Q29pT1hXRi9Wdm1mWVAreTBQekR5VWtYREk5?=
 =?utf-8?B?UmVhdmFJWGRORUVyY0JWR2NNRk9uTk9BS2M1eFozU2x1WEs0d2dBQkNJNjVw?=
 =?utf-8?B?bFhQS1RXcTJ3a0JGRmdad1F6RVpQOGQ1WFNWaWVUK1NPN0FOa2o4VlNrclJl?=
 =?utf-8?B?cnVHT2x2SWgvMWx2MVhxZUlQdXl2YU5jYnFqekVpZ0FtbWFWSGg1YWJZL2Q5?=
 =?utf-8?B?SGNsRVd2bytVb2RVdzBmUFlVV2E5T05HQTRndUJodmdQUzhzTXE5RWQ1RzdW?=
 =?utf-8?B?MWd6UXB0a1hMV0V0cFI3YTdtK05aaW85MEo1Y1Vhcjd6RWorVC9lV3hyR09S?=
 =?utf-8?B?R0lHMUhaWWJCaGZ1RmJoVWI4ODN4MkgxR2xKNTJmWCtYb3VHWGI2anYrS2pV?=
 =?utf-8?B?K2RpU2N3dERaYzQ3clBDOUNEcXROY1djTXVENWo3Y3JWWTVmdEg3OFhXdTd4?=
 =?utf-8?B?SUc2ZG9DUm5lT3NjSnlUWTEzdTFsdFZPRmdXd2EyVXlYNXpBY2x1NUFYZEVJ?=
 =?utf-8?B?NFByS0U0TW5SZmxTZjhpVVQ0LytBbWF2MjdlMjVxV2JuZ0pieG1MZy92TVlD?=
 =?utf-8?B?VEF5SlJ5T3NmSTVVZlI2bzIwbE9UbXJub3JwZndISHJXZTJObEQwRDV0eHRQ?=
 =?utf-8?B?a2FWaHBUbTR6ZG8yVnkvZzB4dXlwdzdEbWFxeitMcGhjMlBoU00ydDFIaml0?=
 =?utf-8?B?STRUd1RDbGlaazBzbE50YVJ6NWVyQ0ZDSnpreDIwTE1CaHVjTnFaV1RrcU5h?=
 =?utf-8?Q?N51h0H66QxhZ+aDyEiLdV2QmBNERrAfh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGFZZGJvVE5FL1JRQlNCbXB4aVVaU3lDbWZPak9sZ0pYc0pDWUsrbGV2ZUZp?=
 =?utf-8?B?b1FHbzJkUWRmQkF1NWVjclVDL2JOcHRMc2Q1N0FIUkVJdmZRYmFRY0czbTkx?=
 =?utf-8?B?VHhEUVhuWXNXS1RWYWFrcEJLQ2cwL3o2L1FYVmorMTB2Wmc0bTNHaDhRMnY3?=
 =?utf-8?B?UjBhdEc5Sk9OZytzYWVnNmJDOW1mcVdxckxKSFBkdSttN0VMZExQWEwvK25s?=
 =?utf-8?B?enQ0NVJyZzlRbi9KWUhieDFORzZPcWdxUXRFOW5OY3VmMTZ6bGo2M1BCN2R2?=
 =?utf-8?B?YVVJais5SDVESDFWbUwvYm9XQUZ3a2krTDA0d0pRRGFnWlRDVThOOC9ZQzBC?=
 =?utf-8?B?WHdOK0tPQkoyVXdrWVB5ZHZRVXh6RUo3T1JhNGV6bFA2cjlXdEo5d0pCdFpP?=
 =?utf-8?B?U2x4MlF0WnlaMFZCdUZtdXJYbHFNMjhadkJsMWF2OUFEQ0IrWk8wWUVTRFRo?=
 =?utf-8?B?M0hOSjYxTnpHR0dXejlySHhiMDZCMFVHYU5KNURUTHFkZHJDQjR4eStHczlq?=
 =?utf-8?B?UUZYSUlRL01SZDM3RVZWd3QvMG5QU2hoc0YrN0VvMjJxd3ZWcGxyN1JaWGY3?=
 =?utf-8?B?ZFNVYnF6UlNGMDA2bWRNR3dRSExXOVZjTGp3UVo0emxyNkliSjgvNFVNbTRT?=
 =?utf-8?B?a1d2VFlaclhPMTlac3M4ajJWc3I4Q284ZDlicVJoZDVXdmJqY3lsTlRRVEpV?=
 =?utf-8?B?SmFWMkx5TFZQNGhIWHhFRGRFTFBIZUhJck9HOU1OdC9TYThneXZ4Y0JmSlp0?=
 =?utf-8?B?K3J5SjlIYk5oNGRIOE1oWDFZWVREcUhsVDRrR1BrdHFpWVdJQThQT2RHTnhs?=
 =?utf-8?B?TDdBY0VvZTFrWG11RCsyNDA2RFBxRm90dXV1TFo2NU5CekZkMVBvVk1hYjVp?=
 =?utf-8?B?bDJiY0lxa2FMckZEQjMxV0V6NTBxbC9CczBUV1FRTVVBYjlmZGVyb2lQU254?=
 =?utf-8?B?WFdIYjFGSVViengzQnBGZXR5Tm9UL1gxcmJJOGxuRU9BeEExVkU3NWh1Nkgr?=
 =?utf-8?B?MXB5TVh3ZlFuR24zSXFZRGc2Sk1SSk9QQURmcFhxaXR3R1UzKzU2WFdrZGRo?=
 =?utf-8?B?R2R6YUdpSHBBSmk0WHNQZ1duRGhMSWw5Q3N2c25IL090ZHBFUENTSkRZeEtE?=
 =?utf-8?B?S2FsQVZSc29GcGRwNGVuSGhLZ2lsc3d1dzY3djZJdG5XRmRiVHBMMFIzdEtU?=
 =?utf-8?B?QjFqR3FKNDZyTlVHMkhibXdzUGpqRUVKTnZuenVRUE9pOS9wdVFONVJmOFNi?=
 =?utf-8?B?Snh2MjFSakttald5TzRTejlhM1VYZ3FTcGFxcmZJa0dUOWZOd0NaUXhPQ3N3?=
 =?utf-8?B?MmxJTllvZU9hNnZDelhKNFQxS3YvSERIcUh0S01DK2c0RXd2ZDJZZ3BQMVdW?=
 =?utf-8?B?a2lWcXlMNzJodmttNUN2azdQM0JveDFtU1cvcDVMVGJGTDFBWkhHNDdaK01z?=
 =?utf-8?B?U0RoZVgxaU50UDBhb2FMWVYydjBQWGpleVRoMGNkbDQ5M1pvemJWbmJKeUI3?=
 =?utf-8?B?L1p2QjRkNzRZOWd2TWF6Zjd6T21aUW91akkzTlhrOGdMQ0ZBVjBnRGNzRnNj?=
 =?utf-8?B?YS9rcHNzcFpHOVVaNW40MitCekJtR2ZmRzAwaUo5SVZjU2hENmMyUjVudzB2?=
 =?utf-8?B?dFh4UTBDSUhkTGtMYjRNdmxuTHU2RlRIS3hIR3oyeTV4cDJoYkNhQTZhVnd0?=
 =?utf-8?B?bk1NbWJMSzFBbi9YMFBMdUk4ZU45SDFkTE16d3piMDRrVVg0bVhma1Z2UWRM?=
 =?utf-8?B?Z2hseWxSY2hkZTlqbjZnQjJISUJxSG9DRWVqUFpONzZMM05yNHRId3RadFRH?=
 =?utf-8?B?RDlLVnloZkUwcnoxQmZUYlhReXMrSUIyNU83TzlLZEtwL2tmQXUzQk1nbmdt?=
 =?utf-8?B?MSt0NFVWTk8xU2JKSm8reURBK2wzY2VBcTRGTmdGM3h2UDR3RWc0TW1rTWxN?=
 =?utf-8?B?a29FRnJuUVhXMlN0WUd0YXdnWHFkdTdNRDdhZHBJUXFMcjNKbVN5bVk3dXpw?=
 =?utf-8?B?d0JYMnFKa2libmxyeXFhcmJwM0FFampSejFuQThud1NpQUltV3lSeGVKemFK?=
 =?utf-8?B?bEhZeVhzSmVYczkyOUNOcTA0WEFNNmNYQXprSk0vbTd5RE5SZDdtZEx5ZWdx?=
 =?utf-8?Q?xupeW8cZFjDlzzXvZ1gKt9hxu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A674275BFADD1D4BA6B32E9DA6870FA1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9355c909-7679-4a00-bd6e-08dd1e7c38ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 09:21:43.4022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcm8oDi9+MQSEvBsiFksDQiQjgeB/XgmPzVJRCFOdbzOET+Z7PHDI6TzCTEAexSE0zgs+dbmgGBx+KeJGMdSOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7699

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTEyLTA1IGF0IDEyOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Ig
dGhlIG5ld2VyIEhETUktVFggKEVuY29kZXIpIHYyIGFuZCBEREMgdjIgSVBzDQo+IGZvdW5kIGlu
IE1lZGlhVGVrJ3MgTVQ4MTk1LCBNVDgxODggU29DIGFuZCB0aGVpciB2YXJpYW50cywgYW5kDQo+
IGluY2x1ZGluZyBzdXBwb3J0IGZvciBkaXNwbGF5IG1vZGVzIHVwIHRvIDRrNjAgYW5kIGZvciBI
RE1JDQo+IEF1ZGlvLCBhcyBwZXIgdGhlIEhETUkgMi4wIHNwZWMuDQo+IA0KPiBIRENQIGFuZCBD
RUMgZnVuY3Rpb25hbGl0aWVzIGFyZSBhbHNvIHN1cHBvcnRlZCBieSB0aGlzIGhhcmR3YXJlLA0K
PiBidXQgYXJlIG5vdCBpbmNsdWRlZCBpbiB0aGlzIGNvbW1pdCBhbmQgdGhhdCBhbHNvIHBvc2Vz
IGEgc2xpZ2h0DQo+IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgVjIgYW5kIFYxIGNvbnRyb2xsZXJz
IGluIGhvdyB0aGV5IGhhbmRsZQ0KPiBIb3RwbHVnIERldGVjdGlvbiAoSFBEKS4NCj4gDQo+IFdo
aWxlIHRoZSB2MSBjb250cm9sbGVyIHdhcyB1c2luZyB0aGUgQ0VDIGNvbnRyb2xsZXIgdG8gY2hl
Y2sNCj4gSERNSSBjYWJsZSBjb25uZWN0aW9uIGFuZCBkaXNjb25uZWN0aW9uLCBpbiB0aGlzIGRy
aXZlciB0aGUgdjINCj4gb25lIGRvZXMgbm90Lg0KPiANCj4gVGhpcyBpcyBkdWUgdG8gdGhlIGZh
Y3QgdGhhdCBvbiBwYXJ0cyB3aXRoIHYyIGRlc2lnbnMsIGxpa2UgdGhlDQo+IE1UODE5NSBTb0Ms
IHRoZXJlIGlzIG9uZSBDRUMgY29udHJvbGxlciBzaGFyZWQgYmV0d2VlbiB0aGUgSERNSQ0KPiBU
cmFuc21pdHRlciAoSERNSS1UWCkgYW5kIFJlY2VpdmVyIChIRE1JLVJYKTogYmVmb3JlIGV2ZW50
dWFsbHkNCj4gYWRkaW5nIHN1cHBvcnQgdG8gdXNlIHRoZSBDRUMgSFcgdG8gd2FrZSB1cCB0aGUg
SERNSSBjb250cm9sbGVycw0KPiBpdCBpcyBuZWNlc3NhcnkgdG8gaGF2ZSBzdXBwb3J0IGZvciBv
bmUgVFgsIG9uZSBSWCAqYW5kKiBmb3IgYm90aA0KPiBhdCB0aGUgc2FtZSB0aW1lLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQoNCltzbmlwXQ0KDQo+ICtzdGF0aWMg
dm9pZCBtdGtfaGRtaV92Ml9icmlkZ2VfcHJlX2VuYWJsZShzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJp
ZGdlLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
ZHJtX2JyaWRnZV9zdGF0ZSAqb2xkX3N0YXRlKQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBtdGtf
aGRtaSAqaGRtaSA9IGhkbWlfY3R4X2Zyb21fYnJpZGdlKGJyaWRnZSk7DQo+ICsgICAgICAgc3Ry
dWN0IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlID0gb2xkX3N0YXRlLT5iYXNlLnN0YXRlOw0KPiAr
ICAgICAgIHN0cnVjdCBkcm1fY29ubmVjdG9yX3N0YXRlICpjb25uX3N0YXRlOw0KPiArICAgICAg
IHVuaW9uIHBoeV9jb25maWd1cmVfb3B0cyBvcHRzID0gew0KPiArICAgICAgICAgICAgICAgLmRw
ID0geyAubGlua19yYXRlID0gaGRtaS0+bW9kZS5jbG9jayAqIEtJTE8gfQ0KPiArICAgICAgIH07
DQo+ICsNCj4gKyAgICAgICAvKiBSZXRyaWV2ZSB0aGUgY29ubmVjdG9yIHRocm91Z2ggdGhlIGF0
b21pYyBzdGF0ZSAqLw0KPiArICAgICAgIGhkbWktPmN1cnJfY29ubiA9IGRybV9hdG9taWNfZ2V0
X25ld19jb25uZWN0b3JfZm9yX2VuY29kZXIoc3RhdGUsIGJyaWRnZS0+ZW5jb2Rlcik7DQo+ICsN
Cj4gKyAgICAgICBjb25uX3N0YXRlID0gZHJtX2F0b21pY19nZXRfbmV3X2Nvbm5lY3Rvcl9zdGF0
ZShzdGF0ZSwgaGRtaS0+Y3Vycl9jb25uKTsNCj4gKyAgICAgICBpZiAoV0FSTl9PTighY29ubl9z
dGF0ZSkpDQo+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ICsNCj4gKyAgICAgICAvKg0KPiAr
ICAgICAgICAqIFByZWNvbmZpZ3VyZSB0aGUgSERNSSBjb250cm9sbGVyIGFuZCB0aGUgSERNSSBQ
SFkgYXQgcHJlX2VuYWJsZQ0KPiArICAgICAgICAqIHN0YWdlIHRvIG1ha2Ugc3VyZSB0aGF0IHRo
aXMgSVAgaXMgcmVhZHkgYW5kIGNsb2NrZWQgYmVmb3JlIHRoZQ0KPiArICAgICAgICAqIG10a19k
cGkgZ2V0cyBwb3dlcmVkIG9uIGFuZCBiZWZvcmUgaXQgZW5hYmxlcyB0aGUgb3V0cHV0Lg0KDQpJ
biBwYXRjaCBbNi8xNV0sIHlvdSBkb2VzIG5vdCBwb3dlciBvbiBEUEkgcG93ZXIgaW4gRFBJIGRy
aXZlci4NCkNvdWxkIHlvdSBwb2ludCBvdXQgdGhlIGNvZGUgYWJvdXQgJ210a19kcGkgZ2V0cyBw
b3dlcmVkIG9uJz8NCg0KUmVnYXJkcywNCkNLDQoNCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBo
ZG1pLT5kdmlfbW9kZSA9ICFoZG1pLT5jdXJyX2Nvbm4tPmRpc3BsYXlfaW5mby5pc19oZG1pOw0K
PiArICAgICAgIG10a19oZG1pX3YyX291dHB1dF9zZXRfZGlzcGxheV9tb2RlKGhkbWksICZoZG1p
LT5tb2RlKTsNCj4gKw0KPiArICAgICAgIC8qIFJlY29uZmlndXJlIHBoeSBjbG9jayBsaW5rIHdp
dGggYXBwcm9wcmlhdGUgcmF0ZSAqLw0KPiArICAgICAgIHBoeV9jb25maWd1cmUoaGRtaS0+cGh5
LCAmb3B0cyk7DQo+ICsNCj4gKyAgICAgICAvKiBQb3dlciBvbiB0aGUgUEhZIGhlcmUgdG8gbWFr
ZSBzdXJlIHRoYXQgRFBJX0hETUkgaXMgY2xvY2tlZCAqLw0KPiArICAgICAgIHBoeV9wb3dlcl9v
bihoZG1pLT5waHkpOw0KPiArDQo+ICsgICAgICAgaGRtaS0+cG93ZXJlZCA9IHRydWU7DQo+ICt9
DQo+ICsNCg0KDQo=

