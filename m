Return-Path: <linux-kernel+bounces-432756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30FD9E4FD7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9553B1694A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912711D416A;
	Thu,  5 Dec 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mZWlL+ym";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Dt+IDAcg"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150E18E37B;
	Thu,  5 Dec 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387769; cv=fail; b=QaYqYwIdTElxtSGdivqUxzVd5T2dynj7N55oGy148FrLMir/n5gGD9lNLCNxy0+88iyM5iI3VvwMcdohqd7CJkCd1t/c8FT0WRnTYnsSARI8NvUJ3bJ4jWxmEs9APOIoasYwCJjJfGiSLMtyFQ2VUjYr+87hU0WK6CHv1g67oRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387769; c=relaxed/simple;
	bh=2kADaoEw2UmqzmD7fLjXonkZ2OoLttZJ/Mcu++V/cnk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oBa0pkbYWhR8r5HVZuAjF4LfHjiVvMgw2Z0I72ygEGEdpff1RJneVegAFim5fOoZfM75BobGIvfavYj30thZuBt1UpNxibbUBuT8rbtCoy7JIwMdRlXQsAnGQP+v4uXhyi7aw+pAA6haCh7PU1qZmImvxrTAzqPjUbkP/bzZMMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mZWlL+ym; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Dt+IDAcg; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f2ebc466b2e311efbd192953cf12861f-20241205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2kADaoEw2UmqzmD7fLjXonkZ2OoLttZJ/Mcu++V/cnk=;
	b=mZWlL+ymrK5lFrvQNzUpoYJmzgf6sbf6/sut8UJcei78im70e+yTyt0fIkJvGUBteLqRVt5xW2cqlq27R9hNpO2QagGFtQVA4Y/cUUfFcIgxsEloLC6wFrcr+Wezno+xfnfu83P+BqRIjUTmBhsXeFzXL9pN5rPwwxnbCfJ5GBM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:9a0b86af-d738-4c59-8b00-9ee0aef1aa93,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:62077a3b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f2ebc466b2e311efbd192953cf12861f-20241205
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 38797030; Thu, 05 Dec 2024 16:35:57 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 5 Dec 2024 16:35:56 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 5 Dec 2024 16:35:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeG6DUVR7W5nknzh3twiHrOxpBM36mlL15eBPViPek2nRT1c/31+io/bAQoZ7OA4Mv1EEuw+l3oR+Gys5pSSU2X3libw99eYOY8ugX+t9TZUcyGJFMAHMhiHndy9lwPoH8lt1qUz983WmOsRQ7EHRlVSt+3Bm2cmzldd5M5DW4xO64F9HmrCi6MpzImx1mq2dD3Mve6pkijdVorZzGtNllBMygJWY5e/r8nF6HhxOivPbWOFv1yV/N0U0nUYV1SqbL2Rv9OSdLDI8oFB3FfdqfMzyAxy8gBlj31/OK3eEtviPEIr+QsY02un9EGrQXd3rJZEUWg/hB0bkf73kEbBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kADaoEw2UmqzmD7fLjXonkZ2OoLttZJ/Mcu++V/cnk=;
 b=DV/Pw8LM0f+lrFyhRYc67VjsPgcfhXSDQshVvkXXISUV2H+hQnS2W751CDCbw/ySYoVcIk44INT7Lmydt+vTBFpwVQZfe0cWZshziKlLYtiWwkezPCoKCqiPNPP/KAIQ90RH4JV2ZPlYLI2/jPR0LTW4QmTbhJ9W+lXPmaBSgtSkJPUlztNYUDu4p4UnadtybxOqmpEk6jVMHkVKPPDHzsBTpNEM3lOMkMKw+oApR1TdVyraYPyJyLJ8ZovUjGckurnaEtSZ1WDwv5kz/tqxYyzWP+JvYPqrZQ+htsmT4Elm9Zd7KT93sSNBFro5ZE+GrDxQlfDBPxVQwQ6DhXB/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kADaoEw2UmqzmD7fLjXonkZ2OoLttZJ/Mcu++V/cnk=;
 b=Dt+IDAcg94P++cT1ZiaMrlylZKG+e1jYwRb04o6dN83yl/xSdt297M0SNTpV6hzNMD7vF587JjeBl3y2Q7/Dck7C0k/LqPLtEU3RZn7AbVCe8DL6fL/JYPmQLBD3AqhjmNFx4v+rwig9uiPjWtPGCqHeGjg9fkMOWQf662GI0uE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8682.apcprd03.prod.outlook.com (2603:1096:405:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Thu, 5 Dec
 2024 08:35:54 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Thu, 5 Dec 2024
 08:35:53 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"mripard@kernel.org" <mripard@kernel.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Topic: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Index: AQHbO0pF3Zp6UXdpSEmkHbI6wNkmT7LXas+A
Date: Thu, 5 Dec 2024 08:35:53 +0000
Message-ID: <ac1c75e310331483235183daff66c849e4ad4ba3.camel@mediatek.com>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
	 <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8682:EE_
x-ms-office365-filtering-correlation-id: fba99702-7c03-462a-dc25-08dd1507d506
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S096elNIc29NQmVrZmpONGpWWExWUVkzTDk5dG1OcHBtdW9udjF5RjhuZ0Mv?=
 =?utf-8?B?K09TUDFySmNqajlnaVlvK3plcEVQNFVRS3ZBRzdjd05zVlQrNFVSMGx4UnRJ?=
 =?utf-8?B?STZURWx3dHVzWEhkWG9BekxhUG8xb1VwSDA4QTZYYXJ5eTdGQjhtZ0pQa1JV?=
 =?utf-8?B?UnhTR3JOODlKNnIwUzc0OXF2MUsvOUZEeTJQcmIyZTZhZlNKdE1qTzcxc2ZC?=
 =?utf-8?B?VFNuZEttc0V3dUhVMXlLV2I5S3FsNW1TNnBSWFNvMmlUdWVjc1ZwU2RMYktx?=
 =?utf-8?B?TFExT3JadGlSTDhTUGJ6TUUwakZlWHg0d041M2FlUE1CajR3cFZaL1FLMXBh?=
 =?utf-8?B?ckNWU2cxU21sbTdBTmNTNFZ5UnRUQ2ovUHRNTSt5b3JwYWwrSjBjK29BQ2ll?=
 =?utf-8?B?SjJKUXJXbW1vOXk0OGdmd0hCaXczOHduMDcwbU9TN0xIa3FJNElUU0lyM1Qv?=
 =?utf-8?B?bFdlMEtSODhwSmlEYzZWaE5iN0p4dzNOclFsM0dITThLTlBOeC95clRPaFh0?=
 =?utf-8?B?dVJzekJNY3U0YkFDakc5M3ZiVUdQTkJYZGpoWlhiSmRoOXdFbEJCUjcwSGR4?=
 =?utf-8?B?dXY1R245UzR0dUpsNyszSTlkRmkxdFNmY0RYOXVRL3lGL21ZWXRsdCtBN0lL?=
 =?utf-8?B?cDlYc3lyd1czY0RkelQ5M2Jxd2dRZHV2TW5xUU1XaUZQN0tVbXM0ODZQUk9R?=
 =?utf-8?B?L2VqZi94MTljbVhqUVV0UXJCVHJKT2lBMG9BNTB6aXI0UnJmU2w5azN4REc1?=
 =?utf-8?B?UW5XODFpVWkrdWhsM25kcjQ2RUg5czBQSFkxTXp1cFd1RkNkNmRwZXBhSmhF?=
 =?utf-8?B?OC81d0ZpSnVRZWZ1V0xtQytENnBoS1RRR2xtZTJielRGUXJUdEJDbTg0SFEw?=
 =?utf-8?B?QWMrT3pKNTJpYTlwL29tL0VGcWp0UW9sbVBLUmg3aittUmgwcjlTNHphZlc1?=
 =?utf-8?B?NU9qdFpHQ1YxQTB2UTNlb3BJY1A0VEV2Qk5DWko1V2xNWlpvSjJwOTRreEU0?=
 =?utf-8?B?UjZ4dFAycGtUWlB6cUV2NDVURk9ISVBRbEcxZ2lVRlNLOUZFRHRSczk4blVO?=
 =?utf-8?B?MzlJWjhtcXBnNlVvTjUvRXYyekRhMEpOYzNUSytUTnFMUEJHQWRhOGZUMFRQ?=
 =?utf-8?B?akZrZ0IvNVFBVzM3bXA5SDBNZE1uMGVCU0o0bjk4ZnRGbFpkWXJod01lTTlF?=
 =?utf-8?B?QVcvYkNQMWNoR2tqK0ErSTEzYVVNZ2pPNmtTUFJya01Ka3NrL1ltYUZOZUJ0?=
 =?utf-8?B?b1FEQXA5S1NOSXdIcUxKNlFOQ0hFQVVmc01xbXZCWjB2bEVmb29KM2o2QTVL?=
 =?utf-8?B?TXdjYmFHVElLZFFNWXc0ejdFN1BGb0VTZkw0bjMxMzRQZ3QxTTFUbTIyNEpj?=
 =?utf-8?B?TzlQbDVNMDRlaC9PT1BFd1VSYjVIaVZQcGw0eXdBQlNyUWRSNmdVaUoxY1JW?=
 =?utf-8?B?cE13Zmg3SndIcEhraGRER2hpMXZBbDBKTHZidEJlWERBZjRIRmZHQmM0NFAv?=
 =?utf-8?B?bnlWcHFUL0dlUlV6cmNhc1J2YUNrQk1EL0VsVTlpd3A4bTR5MlBGVFYrMm5j?=
 =?utf-8?B?WVhoc2svdVhIYUM2QUlJNEI1VFRZcEtBNjVXejBWVzFITGpWakFtTHZDN2d3?=
 =?utf-8?B?dXpxY01CbkFqb3hzcURSckQyMmVhVmhWQms4Y3dNM29hbjNySEcvUlRJL29u?=
 =?utf-8?B?cnVNZ05YUFFNNUFZQWFLTmJWT0svVDhqLzRQbzhOQmRGTC90OHp4dVpsdytl?=
 =?utf-8?B?NTAyaWRLeDBHdkhZQXhEcnpwSXF6bGdjRU5ld1hFdUpzWlFZbnJoL0QyZ2d3?=
 =?utf-8?B?WHZBc0dLTkZXL1dzYUtJR3JsdUg4cFd3OGIxcmVjWkN3NHhjdFRrR2lBSDQ1?=
 =?utf-8?B?MmZoZktUV2wyTWRpWXdmWlhHUUJTK0FpSmJ5RTk1OHpTdnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TThWUE9uMmpmclhoeE44bHlQSU04UUtyQmFVc0pQK3lCd1hjcHFkM0N6Vzcy?=
 =?utf-8?B?RlFCTTFRZlZDT2VzR2RNeDN3cE5UN3dmaXJNNStnUEF3NWRJeHFNRnczcDBS?=
 =?utf-8?B?dlFFZGs3TDI4REJXM2xHckdlUXVpV2hqS3lTbGJXRkFiVzdLeVpXQXFvZ0tn?=
 =?utf-8?B?cWZZb0hRYWFmUUhSNEc5WU42NzlkZFFIcHY1c2NETGJ6U3hSSHl4eEIwRUN0?=
 =?utf-8?B?eFNneFlKUGhRbGQ5NHFiY3J2dzJUUDBjUWhDdnZZZThWbFhZOGIrUGhZMFlS?=
 =?utf-8?B?d283aUw4UlJjM2hnUmxWNW14ay81RWFxSFBUcDd6eUJGSnc1ZThVSU51VTB5?=
 =?utf-8?B?dVhjQUU2MXBmVWt6N292ZmxxSytudUpPanFmajJkZ0w5Uk5ORjEwRmlkbXVP?=
 =?utf-8?B?WURWYWpEVFZWTzlXNHMvWWUzNEMyZHhQaU5QaWE5M281SVZoektESFZiZThk?=
 =?utf-8?B?Yi9zUURhZGdUQlI5V2RRMG53Vk11cFMxelo1Q0Y2U0liK09WZHRwVjZHYzN4?=
 =?utf-8?B?bE4vZGJYSW8yc0J0blNvcnVrSTVCT0ZoNGsraHExeElSTFVGazZTMnFPbFdU?=
 =?utf-8?B?aUI1R3Y1MldneVdWRUxzbDEzaGxlNUxQb1lkaG41dFVKYVk0R3dDSzVBenVH?=
 =?utf-8?B?NEl5QmdWZjZMbUNjY3ppa1FybTlBOWx1L2ZRZzJQU09Dck5ENVpDc1FGUi91?=
 =?utf-8?B?K0k1QWh0WHYrc2dVaWFaR2J3UUIybGQ3R2lTS24wS1VQRldKbDFlbkpXZkx5?=
 =?utf-8?B?RU5pcTNNMHlCTmdKY1RjNHFiTUs1UUtCdnFFVmtqQ0MybjIvbitSeHc1MG5E?=
 =?utf-8?B?SzdEQ1dSREI5UGlkbzJGQzhZRWRnVWJ6bzBVK3FidkhGOGpqQmU0VnlOQ2ZZ?=
 =?utf-8?B?U3RuRFRhbGxNUTBSblJlSXhvdjJZUkxiM2trRUVGZDM5QnBnUEt4Rm0vWVc1?=
 =?utf-8?B?N3UxNk50ODFwZmxCNzgraFJDUTFiZHBNRFN5b0JtSU9kRCtMMjdmbzlzclUy?=
 =?utf-8?B?bzR6T3FPeXZvSmxqaUd4a1dRR29CckR1MXI2WXNlZ0VDUlpiYnBiSG1DNWdF?=
 =?utf-8?B?eVZqTElGTk0zMGpad3N5R0o3alJPaVcvcFkybVgyTm0ySEphVDkwc2FDdDdV?=
 =?utf-8?B?eFJYVHVxWDlGdkxyS2JRVXk2bjd4K05BNVlMRUVXbTR2U2g0MVJMbVYxUFhC?=
 =?utf-8?B?WVRoT2d6QkZ5SUhOVjhvMEV2MmFNeFB3TG9jMG9NeGRSQ3hzdlhxMWk5NXd6?=
 =?utf-8?B?aEpQQS91WHoxTnZDRDVPeEpEaW5rRnFTcXJISWlFNjhNcXoxSzNSMUhUcmZu?=
 =?utf-8?B?QXY2VFVRRnIwL1FlQ1ExNGtpU2pVZmh0UzhER0ErelZsU1REbjdpTjRldXd6?=
 =?utf-8?B?K1pERmV0Q3J1S0dHbzNyWFFnMXRHeXlhK05SaVpKVzJkbDJjQVBJN0dvMmlk?=
 =?utf-8?B?V0pJanNaalJ5TG0ydXkwVFlHK0pOVXlIUXB4UEkyTTBGSGxkcjAzR1hPRS80?=
 =?utf-8?B?K0pUb0dPaVRjdFNpSGdkTnRBY1o2N2xWV2tKY0F4cXlMSVBacjVRTzJQR0tG?=
 =?utf-8?B?aXptd05ZejRZRzBCOE9ZL3VPaDNCc2JjUUVHREpKbTBuYkNSV3FQWFdDSEVI?=
 =?utf-8?B?dC9zSit6dnp4MjArUUxBZGY1TCt3aURWaG90aHh3RDlSM0JpWkQydUNaR29r?=
 =?utf-8?B?Mm9nU2g3OXNVdTRVdmlTZi8yQWlXQnFXQjBvakhhbFNxdnp2ZG9LUnY5VDJN?=
 =?utf-8?B?V2xhRXNmcDh6UWdsTEhYdEx4SjQwMUh4UTJrSWtxUzRYaTgxSGVNL0dFVkZN?=
 =?utf-8?B?eUFqYzZZSG5venRueWtHR2RUK0RyODJhaUlkYW9WTERKT0xtS3dyZzM4RnJK?=
 =?utf-8?B?a1hHMWtkZUNsV244Rzl1ZXExR3JvbXBHSkVvL0dTN0pyQnlhb3hGdkQxTkt5?=
 =?utf-8?B?L3VjbHJ2ZVZFSHJpWWhXTE5ub1FwZGp4SlBDaGN0TDlHSHVTRzltNTZaY0hy?=
 =?utf-8?B?N1ZBSmd5S2Vjd09aUUtyZWorNGtnOUpnc1dpOFdUR1ozNU1ld1FPc0xab1da?=
 =?utf-8?B?SUNqZkV0Mzg2RHluYVNqME5sWVdhS2QvRmtJbHI4azd0VVhicjhzNExxZ29x?=
 =?utf-8?Q?/wEb0qVlkEJ2moR5u0G/45z/H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAE0CBF3FD27AD41A00BA92D9E17A5E2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba99702-7c03-462a-dc25-08dd1507d506
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 08:35:53.8858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TucnN7fMHE0oMSwbuDB4sNboJg46K1j463OwkkglqtwS9QnCMiLLHBfsGlk+AX9UDJ8i2y896RK3Mz79hvJ97A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8682

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
QGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArc3RhdGljIHU4IG10a19oZG1p
X2dldF9pMnNfY2hfbWFwcGluZyhzdHJ1Y3QgbXRrX2hkbWkgKmhkbWksIHU4IGNoYW5uZWxfdHlw
ZSkNCg0KUGFyYW1ldGVyIGhkbWkgaXMgcmVkdW5kYW50LCBzbyBkcm9wIGl0Lg0KDQpSZWdhcmRz
LA0KQ0sNCg0KPiArew0KPiArICAgICAgIHN3aXRjaCAoY2hhbm5lbF90eXBlKSB7DQo+ICsgICAg
ICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfMV8xOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURf
Q0hBTl9UWVBFXzJfMToNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAweDAxOw0KPiArICAgICAg
IGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzNfMDoNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAw
eDAyOw0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzNfMToNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAweDAzOw0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzNf
MF9MUlM6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfNF8wOg0KPiArICAgICAg
ICAgICAgICAgcmV0dXJuIDB4MDg7DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVf
NV8xOg0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDB4MGI7DQo+ICsgICAgICAgY2FzZSBIRE1J
X0FVRF9DSEFOX1RZUEVfNF8xX0NMUlM6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZ
UEVfNl8wOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzZfMF9DUzoNCj4gKyAg
ICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV82XzBfQ0g6DQo+ICsgICAgICAgY2FzZSBIRE1J
X0FVRF9DSEFOX1RZUEVfNl8wX09IOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBF
XzZfMF9DSFI6DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMHgwZTsNCj4gKyAgICAgICBjYXNl
IEhETUlfQVVEX0NIQU5fVFlQRV8xXzA6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZ
UEVfMl8wOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzNfMV9MUlM6DQo+ICsg
ICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfNF8xOg0KPiArICAgICAgIGNhc2UgSERNSV9B
VURfQ0hBTl9UWVBFXzVfMDoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV80XzBf
Q0xSUzoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV82XzE6DQo+ICsgICAgICAg
Y2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfNl8xX0NTOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURf
Q0hBTl9UWVBFXzZfMV9DSDoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV82XzFf
T0g6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfNl8xX0NIUjoNCj4gKyAgICAg
ICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV83XzA6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9D
SEFOX1RZUEVfN18wX0xIX1JIOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdf
MF9MU1JfUlNSOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMF9MQ19SQzoN
Cj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV83XzBfTFdfUlc6DQo+ICsgICAgICAg
Y2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18wX0xTRF9SU0Q6DQo+ICsgICAgICAgY2FzZSBIRE1J
X0FVRF9DSEFOX1RZUEVfN18wX0xTU19SU1M6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFO
X1RZUEVfN18wX0xIU19SSFM6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18w
X0NTX0NIOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMF9DU19PSDoNCj4g
KyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV83XzBfQ1NfQ0hSOg0KPiArICAgICAgIGNh
c2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMF9DSF9PSDoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVE
X0NIQU5fVFlQRV83XzBfQ0hfQ0hSOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBF
XzdfMF9PSF9DSFI6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18wX0xTU19S
U1NfTFNSX1JTUjoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV84XzBfTEhfUkhf
Q1M6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18xOg0KPiArICAgICAgIGNh
c2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMV9MSF9SSDoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVE
X0NIQU5fVFlQRV83XzFfTFNSX1JTUjoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQ
RV83XzFfTENfUkM6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18xX0xXX1JX
Og0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMV9MU0RfUlNEOg0KPiArICAg
ICAgIGNhc2UgSERNSV9BVURfQ0hBTl9UWVBFXzdfMV9MU1NfUlNTOg0KPiArICAgICAgIGNhc2Ug
SERNSV9BVURfQ0hBTl9UWVBFXzdfMV9MSFNfUkhTOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURf
Q0hBTl9UWVBFXzdfMV9DU19DSDoNCj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV83
XzFfQ1NfT0g6DQo+ICsgICAgICAgY2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18xX0NTX0NIUjoN
Cj4gKyAgICAgICBjYXNlIEhETUlfQVVEX0NIQU5fVFlQRV83XzFfQ0hfT0g6DQo+ICsgICAgICAg
Y2FzZSBIRE1JX0FVRF9DSEFOX1RZUEVfN18xX0NIX0NIUjoNCj4gKyAgICAgICBjYXNlIEhETUlf
QVVEX0NIQU5fVFlQRV83XzFfT0hfQ0hSOg0KPiArICAgICAgIGNhc2UgSERNSV9BVURfQ0hBTl9U
WVBFXzdfMV9MU1NfUlNTX0xTUl9SU1I6DQo+ICsgICAgICAgZGVmYXVsdDoNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAwOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHJldHVybiAwOw0K
PiArfQ0KPiArDQoNCg0K

