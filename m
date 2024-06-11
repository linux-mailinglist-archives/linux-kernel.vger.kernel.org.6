Return-Path: <linux-kernel+bounces-209449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E579034EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92071F24AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334FD172BBE;
	Tue, 11 Jun 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PpU3xN5V";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rD4/h3lF"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871E3F8C7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093421; cv=fail; b=RvwhsQR4KS0K7BtYE5SnFO+XOGAO2pa5TP9O9RcDumj9HX6JfTNoyHkJ+bw+iEDQX/3EZ0IdPgn6pTg/UsKWRpv//Mmoko34vHf9WISpWw8d4L1fb8vlGkhC9zTtWL3ap2dUS0MEVgJqicQtXPwiqwaCLyP2GsvMkU7Nzv0mrc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093421; c=relaxed/simple;
	bh=oayYdQy9HTaOMuG3Umc96C5y7CJVlZPu+PdlaCkF4uA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qySnV99UFQP9eBJcoLTcHUjA4VFE0GYRiv/g5s7lz+lS+yqXdqq7kz3EW7mWuCXtG/7RORrv0FcAqGbfSI4W00zWRt10klpATWdF6lBgIGHbxA6j+u1iFiy+6BA1rHP+UBbyaxEg94e6w7/1oGYj8meDrvzuzsyzXQVQKxxrGCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PpU3xN5V; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rD4/h3lF; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 073d23e227ca11efa54bbfbb386b949c-20240611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=oayYdQy9HTaOMuG3Umc96C5y7CJVlZPu+PdlaCkF4uA=;
	b=PpU3xN5VoXmlBHKuNESvciEdPiUNoOFLGDsU4G3oOBAH+ttGEGF3C8jtk0ycX4IJxgK7N7doDP1KcU0si89l7niNieWoMIRTlfk7JacB2CF3neTjmaJM4jvgIP5qHR4rT+dJWlHlIP9qqZZ4QJO2+VLwJe2ssM9BeexezofojO8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:f810eb62-d975-4e85-919e-db476c5d5c2d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:53317288-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 073d23e227ca11efa54bbfbb386b949c-20240611
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1697885189; Tue, 11 Jun 2024 16:10:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 11 Jun 2024 16:10:11 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Jun 2024 16:10:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrN28ErmbBDOjGQRjHRepu4JVSFAef1Ed4Kkxdggd9d12i/KWl8WYXiw4w3qeoGjqW/9iuqNyFJC+Tkfus2qL8qq61kBzRGhLVnNNiEoBMx/Lsl2S8YAFw955GGcm8pN3hf59AWvx/eLk0s77RQyEh5S6R02ygdUDtjr3VJ0lDPHMfpp0BE1yurvednJP7hyb1Eklo0Uvn36XdlY8OApZ/d3Ag1MjkLSxg1zrBXcekbGkprE2slI1RsyeDUj40EAL6dqRMT3mWMsbZqXzXT9iV3gDgcvha2nEaU4K5c3OMv9QmfAv5R//tceppPr6dhbjzcDfFKthI0qkvVfGLBk6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oayYdQy9HTaOMuG3Umc96C5y7CJVlZPu+PdlaCkF4uA=;
 b=Y8rsmyp7I1WY4Eeym/4U5m9hpiDQ584qi4iYFz8VVAQQouL69bd8Occ9pRnfgGKxvySf1RFnXevGsNlf7uG+bG1hNIsaFWuxdWCRfVPktWhRxa0Qbh6WvDbDPSdqdLGw0RpuRXHkHYMknzX20/k8FwIvPYBP4d9x6+qKVoFK4cd3SDWwNBIpV7YabUr2hMxQA2caAz45gEtIDw+EYqkwdEz++MR6V4sdBUeP++eUKZGJR+J9D0W3ZIu9s/39X9TEyDBzPiggSiVEs0Lbv8qOqHNKmv1ApCxmxXFyB/1o8HtRldC8GEfQmWLqvNM5QvB2SjXbqjhjce+SpRwRmQx+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oayYdQy9HTaOMuG3Umc96C5y7CJVlZPu+PdlaCkF4uA=;
 b=rD4/h3lFaGBSNQjWr8mqBQpgMEY2ntHsY9z8q/BUIbYb0tEv6Ir3pDLgaNQOLfPoT6eQj6QgZXBNb01CLP0cB7DdgWQTU5dTdMbhgrW3CYX5LfvQRlcv7/f9ba4/muu+ESw/86CSmXiHNO+vSfS3uB4ydENBOus8ZIMO8l8nACI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7331.apcprd03.prod.outlook.com (2603:1096:400:412::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Tue, 11 Jun
 2024 08:10:09 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7677.014; Tue, 11 Jun 2024
 08:10:09 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 08/16] drm/mediatek: Support RGBA8888 and RGBX8888 in
 OVL on MT8195
Thread-Topic: [PATCH v8 08/16] drm/mediatek: Support RGBA8888 and RGBX8888 in
 OVL on MT8195
Thread-Index: AQHat/O/H0LpcxS9O0CpWiyDO5MGV7HCPaQA
Date: Tue, 11 Jun 2024 08:10:09 +0000
Message-ID: <32f449f826a5e48c8acdc3ee8c1bab7864b86d2d.camel@mediatek.com>
References: <20240606092635.27981-1-shawn.sung@mediatek.com>
	 <20240606092635.27981-9-shawn.sung@mediatek.com>
In-Reply-To: <20240606092635.27981-9-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7331:EE_
x-ms-office365-filtering-correlation-id: ff9a6d7a-c8a3-4728-2122-08dc89ede921
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VzJ4clVNd01NZWlHYUllT1BJTXRDaFhOUWZYOVZiNXVEcUxyaVFwd3RBQ1Za?=
 =?utf-8?B?TFZITXU3VVN1aGt6MUVRNDVrMzY2UzVYUFlsQUl5UDkvQVNLQ09EQ2gvbDBY?=
 =?utf-8?B?Z0R4WHlWcXNlT0ZHOFplRnBHeHpLbUVXR0djWHF4b1V5Q05tT0o4WDk1eHlX?=
 =?utf-8?B?RDVtNjl2eXltYmxtQllQazhJajdGc09IUFNWMXJMbFBmcmYwQmloaCt1cWlQ?=
 =?utf-8?B?ZFFsZUV6cVk2K3B0aU5zN2UvZ1pLMUo0UCtsMzhtUDlUMU1zaC8wS2JmbTIw?=
 =?utf-8?B?UWNzSmxaV0g5OWUyL3pVOEdkQzRET01TSzBFeXV3Z1hYWm9oTzhUT3k4c1B5?=
 =?utf-8?B?SnF4eGZEdjJDRU5PcGZGK1RjOUVTd2E1MW9MdHhDcnRoa1p4VnpkSEhxK09w?=
 =?utf-8?B?UlN6MEN5VGpmb3kvTnpvTE1vMERDZDVkY3RWV2tjZ3NQYU1md3F2U2pDRGZk?=
 =?utf-8?B?TzdqaDJDRXBZTHprNkdlWmV3eVRXZ2lWcTNFR1FzUU4yaVRQdkpHWDV3MEJO?=
 =?utf-8?B?REJSTzk0Y1lSQjMwS2NDK2hOWm5TMExISFFaRE9SL25USVdBQ0FmMDVyS3Y4?=
 =?utf-8?B?b1RlVVdhcDRPbmNhWUlQZzdKY2Vla0VsbUMzZnQySUF4a3h6SW1CZVlUa2JB?=
 =?utf-8?B?azZCZC90em5yaUFJQUp6cnJ1Y0plOW1Ja3M0SWFkNnNLK0RHVldObGhFd1hp?=
 =?utf-8?B?dTBtZ1pPaFdNNXlyV2tsTEx6OVFpcVFzT0ZMUFZGN1RrRXhtMURmbkdMV0Nm?=
 =?utf-8?B?M0h5NWt2VnFKWDhvRlJvRFZHMkRMRUV5SjhudUF5elRQcjljOVNybzBIdHdu?=
 =?utf-8?B?NWNSM3l3TzNTdFhtOHpJUlNKdmhzNFVNM3ZYNFc5Q0N1WjhtNWk0Vkp5NTQ0?=
 =?utf-8?B?MzMvbExLZ0VlQXZPd0ROZDE2YVh1TUFhdWtMb3RldENhOEJ4UnV2L3pPd1hS?=
 =?utf-8?B?U1FMWnFjQ2RORHYvd0lDd00xS0xmcUN5VXdkK2NSNldkWHk3TU10SUQ4L01Z?=
 =?utf-8?B?Z0dycXE1V0NqUlBrWlpkazlZaEpGTkYxV1NyRWdDNzVDWE02SHJvNmpXbGhM?=
 =?utf-8?B?WEpqS1luVjlZY3Vmd2tmWi9uSFVQQjhKemdYWXJOT0U2K1U2TXVUK25xVE9C?=
 =?utf-8?B?bVorTVJ6aVo0Mm1sL2RNMzhET3FSRCtxZWNSV1h5OWxmL0ZabFJQOU5PQktq?=
 =?utf-8?B?bVprK2V4NXczUkxtNEdiUExJMlRQR2huQXRmS2NCYnBUc3I5T1kwNzk3M2U0?=
 =?utf-8?B?akJLMWQ5MzFIeXVVK2VndEN2QWx4akkvUDl0dEpaQ1l0VUo1Mnp5bThwYnFv?=
 =?utf-8?B?M1A1TDRRb0h1M3FmMFRoeUhZdFFhSUd5WSs3Q1R3SllVL0ZFcEVPZUllTkVQ?=
 =?utf-8?B?YUd5VEk5dFdzL2ViZHRVVFZtMldZMnZwMTVYU3FPRFJMYzhWSnZTN3IrUkNp?=
 =?utf-8?B?ajBBdFo5bzhXd3FqZDBLeGh4bG56ZWhlZGZiUEJYZnh6MDNlMzArQTk4UjNJ?=
 =?utf-8?B?M2tZSytJbUF3VWtTUUI5c0F2cWl5cXpLUjlsbTlKak1rWHMyUC9JUnE0SnRV?=
 =?utf-8?B?dU43VDluRHpWVmFWYkw4TTA0bE01NXVNSmJMcFhTRHZwWTR0UEdtWDFuaDFV?=
 =?utf-8?B?Y09weURYMi9TZFEza1lUOFhJRUN4OTlMNDQwRUZzclVXTnN0dHpsK3hvbmxk?=
 =?utf-8?B?bFlPTE8yQjVxMklaYk13TXg5RWRmeGxlT29sSWpRdkQxcFZzSklrRFpRL2xG?=
 =?utf-8?B?QWMrMjBnbUNUTW82TWNHS0tPd1F0TGhDZW9jNU9hNDY4YTNtRm9oeXRMM1dx?=
 =?utf-8?Q?4AZkVEVMh9UGpSo/G4hvuQwCs1lPLbllIXbhs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnVRbWFWLzM2OWFDMkZVYmJWR1RXejVIaDMwbDhaV1lFcWhzUE1OZlBqVGU0?=
 =?utf-8?B?a2M3QlRYM1ROOER2VTBsWVI5L0lJbUNGSElaS1RsWDJRNjJ1a0hFRGhlaCty?=
 =?utf-8?B?cnFsdzZpZVJMeUJsbXpscTNpZEdndm1PMGp1d3hJUmtSVElEQkJNRGsyMHVM?=
 =?utf-8?B?UC9kN2VTQjVYU3UxaTZzbFM2a0J3MWQ5djkzUjlMN29GZVppdEdJYWdDa2J4?=
 =?utf-8?B?elE0T0Y1Y0Rld2FWdTB6T2dXcktNV2VTUEg3ZElJa1BuMjRTbGJ2TWxMMFFS?=
 =?utf-8?B?azIyS2tkZ29kT3BGd3RjUFVVVk1zVXVSU3F4NkFQUDluUlBLUHBDbDBydGxy?=
 =?utf-8?B?MGVjR1V4ZDV6RkZwdHQ2YWw5QWhzZlBjQWJ6dXh0dFdqYnpJYithUUFWUDdT?=
 =?utf-8?B?aXh0T2Q5cVZSMUo2R2NabTN0ZDlkTHFWM2JqNCt4Y2VOS1BENDhveitBakFO?=
 =?utf-8?B?dENsTUJhVytQWG1Tdk5nVlNTeVlsbFExZE14WGxtRGV2TDVTbjFsQVh4UC9p?=
 =?utf-8?B?bjByL1ozV2U5NTFIc2xuR0ZVVmZNa24yTlBudVovTm1qNmQ4c0pIK29PTGdH?=
 =?utf-8?B?ck41VEp1OWNuYzIwYnJqRnhiUDhGT0hwU0o1akJSdVJCMXVTR05jQURJWTdS?=
 =?utf-8?B?WDcreXpzN2RTa3dSOWkrQWJaak5OdmNhQlZwWGN5aUxtdlJ3a2lhaXpHWERq?=
 =?utf-8?B?OGtWMFhsdzR1aDgvZStuUkJ2UDBUQzN3RTN2U2pNdzdGRTdRSVQzdHV3Q01n?=
 =?utf-8?B?SzMxZ0VsSWFMT1N6d3lvMUFnV2QvNHFwNFByQzh2VFJqWkYwYnlhamFETjZ1?=
 =?utf-8?B?b0U4eUJTMlZIbjVUYWJxcFZrVjRpZlpLcE9kbVdpa0swTEdUb3BZK3hweWdE?=
 =?utf-8?B?OTFTNVhZY0QvbTJydUo5cmhTQzVoOU1Samh1U2RMaVdzWmlaRFo4U2NLMzZ0?=
 =?utf-8?B?SFNSYy85MlZjL09tT2tONk82ZzhuS29jQlMrWkxsRFJTcUdxZTA1dngvaDJB?=
 =?utf-8?B?L1hjMCtPWHNPTVU1dVF5bDFoVGJzR25vamR6OE9CeXF4RWpFMnZma2tZbHNm?=
 =?utf-8?B?MkEySlcxTHpXNXh2ZFl0dDk5MWhUMHptaWRuZzJGeGNoa1p2SC9LbWNOYVh2?=
 =?utf-8?B?bFc1UnNCcmYzMjE1bGpnZ3RDZWJ6ZVZldzdCa3VaQ0hSNEphQ3c1QVNmSUhZ?=
 =?utf-8?B?NTZNZ1BUd2VLcXhGbC9UeVdPRWZLMG8rOVlHTUJkVHZablhPSUdwRHArRVMv?=
 =?utf-8?B?WGJFMmpCbEQ3YTZ2cVVPREFHeXp3djdDUzhqU3ZjQi9RMXNOcVFUK0psdVk4?=
 =?utf-8?B?OWhxd2RKMUV2NjBiWld3NE1LQ1k4NXBuWXVmMUh4WTF0WTNDSnNwNVRoSlkz?=
 =?utf-8?B?TzBPOTFJNlc4cnlXT2hGUldqT0V0RzYvRVRTZnBLczdBSFVud1ZuNFdiYWVo?=
 =?utf-8?B?WlZFQWdCSVc3c0R1aWd0YlAwZnBUQm85emhYUnVnS2V1SHZ4V3dQV1Y5cWtz?=
 =?utf-8?B?ZVZDem9WaHp4cElRdDVFUWg0VDdyTVlnTFQ4WGhnRFhQanhYVjBqaHdOTm5R?=
 =?utf-8?B?aDRDY3Y4UFZ4VjNSS2RWNEQ0UXo2Z1RrNHduMTBhVE13YnZ4ZzhGdWJBZm52?=
 =?utf-8?B?ZW4xSHc0N2lKWVhsVzVkeXpHOWtMZ1VTaHVHQVI5S21OLzRvS0JHb2VFYzdI?=
 =?utf-8?B?QXVCc2R4a1R5OGN4VStiUzVLeWVhT1BhQTJsTmxYSUdWbWpLNlg4cGtpdVZR?=
 =?utf-8?B?Q0dPNEtCTlJBdEJ3NjI4em1sV3NZMkpKOVlXQjdNeGlxeWRJR3J0Z3IwOFYx?=
 =?utf-8?B?RE15eWpmTUdvVk9FRXVScnByR0E2UWxuMXljakV4NlU5VXR3Y24yMzdRWHF1?=
 =?utf-8?B?dnJRT1N5OFB3cnBQUXU3MXY2TW5WQ1Jsck9oR21IQnRIYzFnZ0kvYVNTMllm?=
 =?utf-8?B?MzlMS1ZvOWFqZGJPUHo4OHJwNFI5UWFtYlpUWW50d3MrTW95eW1abkR0bFNw?=
 =?utf-8?B?d3lHejg1QnV5TGwzNlBtR2pONkhUbjMwNS9wU2JsTXBXWVA3WjNFa2ZtWlQ4?=
 =?utf-8?B?cFQ2K3E3d2RqKzRza0FxZFBuV2x3eElwSkxRUDhYODl1cERyLy9oUXNMaHc0?=
 =?utf-8?Q?zTrgCE+MPWve7HUD+tx5JLCg/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F223FC47ABD7C4DB1681896C1A3CF9F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9a6d7a-c8a3-4728-2122-08dc89ede921
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 08:10:09.0788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqhigNIFPX2q1el1RwqaewJVOkz6+aMP2BPp790IKUk00XcfUE+38nnabqB7szbDSFgg8LiOI+GSKxK/97hblA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7331

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDYtMDYgYXQgMTc6MjYgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCBSR0JBODg4OCBhbmQgUkdCWDg4ODggZm9ybWF0cyBpbiBPVkwg
b24gTVQ4MTk1Lg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5j
IHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBpbmRleCBkOTcwY2RjZTA2YmMuLjcz
ODI0NGE2MTY0ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwu
Yw0KPiBAQCAtMTE0LDYgKzExNCw4IEBAIHN0YXRpYyBjb25zdCB1MzIgbXQ4MTk1X2Zvcm1hdHNb
XSA9IHsNCj4gIAlEUk1fRk9STUFUX1hCR1I4ODg4LA0KPiAgCURSTV9GT1JNQVRfWEJHUjIxMDEw
MTAsDQo+ICAJRFJNX0ZPUk1BVF9BQkdSMjEwMTAxMCwNCj4gKwlEUk1fRk9STUFUX1JHQlg4ODg4
LA0KPiArCURSTV9GT1JNQVRfUkdCQTg4ODgsDQo+ICAJRFJNX0ZPUk1BVF9SR0JYMTAxMDEwMiwN
Cj4gIAlEUk1fRk9STUFUX1JHQkExMDEwMTAyLA0KPiAgCURSTV9GT1JNQVRfUkdCODg4LA0K

