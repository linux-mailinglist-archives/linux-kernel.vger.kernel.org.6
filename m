Return-Path: <linux-kernel+bounces-242215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2153E928519
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D86283262
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86A146A74;
	Fri,  5 Jul 2024 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FblsCrQS";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bW5W+ZoA"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589414659B;
	Fri,  5 Jul 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171697; cv=fail; b=KuZTWhQVD+J24H0W8KVemX8JZb22PoCO6WaZWVK/YPGus/79qHXbJkViXSXvXyPN71DqEDT/3UXlTwYz6vweW3JTRKnWA4OK1cgl4IhavJUAP18utHCpS2ziR7zekT2EHlAo5K4CbkJrO3W9Nj0SCUvDnmveE+4uGDJ1YjKR/XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171697; c=relaxed/simple;
	bh=jKwrsOMbhPrF9yxVatbsA4j/n1d7CW32qaJjg6UEUnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wb6UJl7dcNhW36l49ine5BlzCor/8dYDTkcH30ID8ajriG/b6ho2iweac9M2ojT928fibzTNrU0QP8hB1uU52zN+TfuMOd1O/9Qw5ibmJr3o4PJxXLszEXbzFuvc1xxuIzyd5R9TOenlSeVZhIcRlg7o+AgDgB3Y0Gqe7zm2qgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FblsCrQS; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bW5W+ZoA; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e3d295283ab011ef99dc3f8fac2c3230-20240705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jKwrsOMbhPrF9yxVatbsA4j/n1d7CW32qaJjg6UEUnM=;
	b=FblsCrQSSHxKOM8JUnKT5nPI8g7zq/kN3/UFX5130dSKKtnt71G9rNLK+3VK09CfpO6ZTP4iI9/HSVCxgCwujaaNwo0YGczZyBmGs+jXpAqzp41/RsKqnLuhAG/navfxxDUNt2hYHXnwvW1a3BN/nq/6Rt46jo6ZLCYF3Y3Ctrc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:56001fde-4993-4b2f-88f2-5e0032a5e0d8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:683dfed4-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e3d295283ab011ef99dc3f8fac2c3230-20240705
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 657527407; Fri, 05 Jul 2024 17:28:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Jul 2024 17:28:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Jul 2024 17:28:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLP7zO+vZ2vwSO+osbuqUFwBJSk2eNUt+zQBg0UJBeLU1IEEHoj/7AIP0/6nHSRVxNgbtXfIa0WfebaKJZ3DfLzyRKpXBdLyO0lC6au9F+LqjOeoSx2Lk4Essd4CZ428ZmIyZzREOM/fBykfZmfrxW3p9eDt2lWJu2S2U4yH8SS3+i6YxDX5lH7H7dq4V6s3IYUn5R6aJsWGJOwxOdsNPrUBKzuzcTO5PluSNl5NGM942hfn3iJRAt+4dEBIrcBejsuXpyMAqs2KMxk61UA9ATMoGx2QoT8bOWh7XQgH4ig83EgczXBv9RyK0f0RnxRBnxWcglOJMdQUDKhLw/+36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKwrsOMbhPrF9yxVatbsA4j/n1d7CW32qaJjg6UEUnM=;
 b=IOsshLKr0HAmVIUig2SIGbMHP99mwVvmaESV48UDLN0I8ylIyMmwFX+wQW781i5DhroPt+gjVgJ2p2wYG160AL+yCzd0IDuhdcPFmzi6mhrw5Vz4fEB2eIqnFcJ9GE8YVNVhLXBoQccLZaFOnv3UDSHXPOv4mnwIZxfq8XXfPW4YK9lihyGccpQDCVVwle3XhU2fqKA5QXd94q8Yq5ifTG+4l88EA/VBL/fWJzMNvjpDawKyhRQFp4WGkUNuhn+htZ7Z4BQWV2l0nfknR+u5iXcExH2i3YW6VMRLgziJpjjrMH0LcH2GviPxMavb7bq6dfknT44/ut/WxFXbK4JGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKwrsOMbhPrF9yxVatbsA4j/n1d7CW32qaJjg6UEUnM=;
 b=bW5W+ZoAgtEsGUKwDi2963jme8+88JBvtXDYQz2XAISHXfSSZ01xdqd030DhRac6o1n4ZX11SlucfwqPG29h6/Uq641CKtjXqq3bViK7yFk51sGo8Ku7CoN99e/I3Y4abeII1igT4AxKHD5WktplsIq2SJcvC4j/jmIpF3QGQBE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7778.apcprd03.prod.outlook.com (2603:1096:101:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 09:28:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7719.029; Fri, 5 Jul 2024
 09:28:03 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?=
	<Yu-chang.Lee@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "amergnat@baylibre.com"
	<amergnat@baylibre.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Thread-Topic: [PATCH v5 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Thread-Index: AQHaq1SdB3VktOcCqkqfEslqsj0mTLG4e18AgAChMYCAATHigIAGeyMAgAF2fYCAAAGUAIAl4vQA
Date: Fri, 5 Jul 2024 09:28:03 +0000
Message-ID: <fbb00e4cc81d8e1e47fac01c3c9146148747fa55.camel@mediatek.com>
References: <20240521075717.50330-1-angelogioacchino.delregno@collabora.com>
	 <20240521075717.50330-3-angelogioacchino.delregno@collabora.com>
	 <e7845300fa822413f6308cb6297222cde89c39e0.camel@mediatek.com>
	 <0e0fe86c-92da-43f5-89d7-8084274a908a@collabora.com>
	 <0f20214ab3a86f68669ad1392398b16228e699ee.camel@mediatek.com>
	 <47f05439-815e-4ca1-b20d-8e427fef0a2a@collabora.com>
	 <ee0209dac731b36ffe2ee20a2ff537ce7758b01f.camel@mediatek.com>
	 <aa991aa4-7e9e-4cc6-b6ae-69539700691f@collabora.com>
In-Reply-To: <aa991aa4-7e9e-4cc6-b6ae-69539700691f@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7778:EE_
x-ms-office365-filtering-correlation-id: 1c4e8ee0-265e-44c8-6d74-08dc9cd4c553
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UmNQdVVxZmV2aTdZR1Z1enhnWVFPeExCUkNwR0E0OFA2Q2MzSjkwVzd6WnZM?=
 =?utf-8?B?TERvejdrdHNqaW5NVWJIakxia2FRUmxqUGhneFRHSkt4dmFzSFpZakFRS2hK?=
 =?utf-8?B?eDNNTk9wWEtRNncxUTg2Wkw5RnhucVQ1Qk4vanl3c1ZBaXNXN1R4bTlLQll6?=
 =?utf-8?B?dm5FNW02aTczanQwZXoyc3d2OSt1VGUxS0FIaTZ2VHhQU0xUZWtPOFZsaGhF?=
 =?utf-8?B?RDhYVVArS0hFMU14c1hyY3ZGT3hqbEhpblMyc0dzSmJqdVJNZGtNVVhzSUNs?=
 =?utf-8?B?MENPQ2srZjJOVEdDdG1DT1BvS3ltVERGN1lTWmk3M1hLVFdlT3l6RWRTQ2RI?=
 =?utf-8?B?WkhqTDNOWVFLQXFOTXpNNE9WNDQwV3ZlN1lLTHZwbElUN1p0a25vVkZKcmFq?=
 =?utf-8?B?Q0xCU2UxOEYvV3hLWVE3K2Jtekl2Ni8vQTR6cU1kYUhVcHZsdlZhMGV6STBI?=
 =?utf-8?B?WVcwV09pNTcvK3BmUFB0VERQaTZoa1FVUngyQUR5b1RBbTdPZ3pwYkdwaXp2?=
 =?utf-8?B?ZDNDU29WSlVvd1RrSXg2djIyeGh3SENtdTlaYU05a0RLUHpuK2VIdDJUeVN5?=
 =?utf-8?B?QmVkekVCZks0WEp5Rmo1Y2laNXdmOUJheGIwS1Zmd1JES1I3ejRBNzdHaXFz?=
 =?utf-8?B?V3BWMHZmUlNlbUNYYWhuY3EwektIQk90S2ZGTWN2M09nRWdhUXgvMm03WjYr?=
 =?utf-8?B?b2lIT0xScGlyTEdGd2kzYU5rWVdFNFNRb0RSSm53QXZqVUZxbDQybi8yQUpa?=
 =?utf-8?B?MHJXY0lMUDFyMWNhaXg4VHNxemg3TzBhMWJpdHpseHpXbGgzQlVOeWhGc2xk?=
 =?utf-8?B?R1hnTTJmTXU4b2VTSlg1aG5KL0hWRlk2QmYraWhKazZyQnpaSzFOZVkyWDE5?=
 =?utf-8?B?WXllQ3JNUmlIS0NQcDFqbXE2Z09BdEY4bzg0WlFiRGV4Y2dxdTZxM1ZNYXlB?=
 =?utf-8?B?ekZQYUNIS2s2NlN6elZkNjJDWnN1d1MzM0ZKbmQrYVhZSHBaTThCeURZVU5M?=
 =?utf-8?B?Wmc1dTNEWXp1MHN6L0NqcGlyVkhxQUJFVVc4MDZZalBCSlNIQkRtRktpUVRt?=
 =?utf-8?B?U1pjU1pWRlc1V2g1dDFtN2Vmd1ozSGZPTTVvODhVTllBS3lCT0YxS0NhdmhT?=
 =?utf-8?B?VlJpUFd2RzlOem8xMjZncVRTc2VzK0Q3dWQ1TFdqczhRNVBuckp6VE9IbnZE?=
 =?utf-8?B?T2NlSGZmRmRJVWRQNlpSd3VsMlJxUkxNaE9JWTc0VGxlbmRaR1c1blpFUktC?=
 =?utf-8?B?MlBrYTMzMGQ5Y2NoTzJpYXo1NGlsU2V1Y1ZFSWI5UEtHcTlHSGx2UDFGMVdX?=
 =?utf-8?B?VVhOS1hRNnJ2ZkN0dWxONUFOR2dPOFpiejREYmdCY0dTdHhiOWNaUGR6aDdU?=
 =?utf-8?B?Y2o4UDJ5Y2VFRWZseE9za1ArZmNzeWxyMTdzdCt6TXVHV25BVnc3aEVBZzB4?=
 =?utf-8?B?d2tVZW9mbk5CZnA5Qmw1Nm1MZ0VJdGUvdFhXSExIVUIxdDRkWDVRNWVkS0xR?=
 =?utf-8?B?eGlIOExQVjJLdkRZdDVEcXpUUk1pSWM1TFhwb3Q0ZGRaUmhqek1LSEFyYjk3?=
 =?utf-8?B?TnkrNDRGQkJkRHROTEhtREU2MCtqdm5tcXpnSnJrZHZZMEpxUFVJSi9DalFu?=
 =?utf-8?B?UGw3aENpcEM1aDEyNXhLd2Y2MTVTOGJXVVpRSncyaXlBSmNpOHYxa1Zua2Rt?=
 =?utf-8?B?U1VJTGVmUnp1SXdLUEZ6OWNiZ1U1ZFRqVHVsNWUvVTh4Ykt1ekNJT0VOUTAy?=
 =?utf-8?B?RUpPNmdnOTU1SkFnckloRDJmU2VlZGhiTnhBTWEzR3BqdGtkNmlSZmQxaTdq?=
 =?utf-8?B?cDNTTjdlNnpjeEU0N2ZNbzZ5S3N4MmdWVU5KL016dzZHQWIyODYrQlJkUFZo?=
 =?utf-8?B?TldBamZMSHd3YzVpUmw5NGI0V2pWL1VUZSt0azVaRm1abmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MC9BV3VuaHJZc1BDd1VvV1ozWVlScUw0djFOOWVIMlExakhmczZSTldsVVRC?=
 =?utf-8?B?Ymp5N2lmNVJKVkZINFJEV09iWFg3WHlaaXpCSjlsQTNLaE1MaGcveUFOa0lY?=
 =?utf-8?B?RHdsYkFOZ0Z0QTNRMHFraVhJbHFjV1JDSDB2S1BvRkxNcDV1eGp6S21FWFVY?=
 =?utf-8?B?WnFldWQ0WE1vdzdiMHdDQm4wdmYyOHdQNHFsU2hsdFJna1lLYXBuMlBQT1VR?=
 =?utf-8?B?blJBWjNBMnhmQXc3dHBjSEJyMmJ6UGU1Nk1waEszT2o5dEJicXowZWN4a2V1?=
 =?utf-8?B?OEFBcHN1R1gzL0tkSkQrK1VMOWdNcXBIaGo2Mi9tQUxsWHg1cXMwUGNvRHJ6?=
 =?utf-8?B?Q3BtWkIwK05YMzh1Uml3SFhVMmhRR0ZZVXU4aHR3QVlGNzQxUnA3enBuL0xs?=
 =?utf-8?B?RndyTVpEUVQrK3ZQbE11aTUyczloSmlBeWNMN3RFWDNHNllWb1RaY3ZLc2Zr?=
 =?utf-8?B?TjZiS0Z5anVoWHRHcnhaa2pOYldiU0VJamUxd1JuK3lNdlZSTnRpWVFoeWtI?=
 =?utf-8?B?NmQzTjUyQVZ1L0IzdWNWZEthc0lEWHVTQkV0S0xUQno0bmw1TUgvRlJKQzN3?=
 =?utf-8?B?YUtkZHdaYWJqMVF4Q2lybW5LWFJxbGR0elBQNUduR1hVTGVwclorRFl1bzdK?=
 =?utf-8?B?N01TdDBEOERyMEtsYVhseWJBMDlZeXEzUytEWUIzdGFzbHFLWlVMRTZTd2g3?=
 =?utf-8?B?ZEI5UlVGWWY4aHI0bmdGSjJKWnlEYjQreml6L3FnbVZrUHFidGVvcVltcWJJ?=
 =?utf-8?B?QlJ2ZGJwRlBheUtiRWVCdlFwbzdhcmNPN2tnQWcxWEVuLzBwbWl4Zjk4U3RY?=
 =?utf-8?B?SnQ4S0wwTWR6RlBLRTMrOVdSdGJaWWs1ZEk1TUxFdGJOTy9KR3J1RklIOTFh?=
 =?utf-8?B?MDRtSW1zaVVBZllycXd2NUxPU2QvOUpVa1E4cjlqZzlVdjlJdWFGSGFvLzF1?=
 =?utf-8?B?UjJ4NWJVTEE3bGQydnVNY0VGdUFXWStFSHk2RHBsY2VtVGRIMlh2VWVzKytW?=
 =?utf-8?B?eFIxa2tCenljM0tSdkZlN3ZWWDlFSU42K1Ewelhha0lROHJqYjRLTXhtdzh0?=
 =?utf-8?B?TFdLd3lYTWFFY3RWN0VrRUNPdzhHQ1Y2YjVKUkJKdGxDR1d2WFROUDNybUNS?=
 =?utf-8?B?T1pRellST1hYZ3ZzVWFieE9aNGxBbnk3bTVNSlZyV1FyTUNVVGNSSWJ6QW1V?=
 =?utf-8?B?M0U1cUIvZGV5bFU4UHlOeXJkalBqSW5jSlpaL01wSGdUNGhlUnhvSnF0NytN?=
 =?utf-8?B?cmMvTUhvUFo1ZURNNnZkYm9lMlZaSW95aCtQU1FoSlZZWGpKVnE5K3pMQXhB?=
 =?utf-8?B?TUZhS0pEN0ZzRlJoZW1zMzV1dmRwd09lR2g3aS9RaDFyUDhKTVg2MVRuYW9N?=
 =?utf-8?B?RFN2YkRjK1NHdWNxQnN4NEd4VEFWaS9NenVaSzl2KzAxMHByM01BNXdWR1Vw?=
 =?utf-8?B?cld2NmVGaDZPQmRhUlptbGNIakl6eUZ4VTJIcTNtTlE4c2ppTXMrSnc5YmVF?=
 =?utf-8?B?YVhGYkJZaVJsSUlUdXhkTmJocWl0RU5sUE9OdE05OHFvZlR3NHI4YlhYUFZF?=
 =?utf-8?B?bHpWVzFpd0s1R1JqNFNaTi9tQ3FiZ1kybTVRa0FmQzJ1ckdhMk5SVUxyTita?=
 =?utf-8?B?VTNzdHdXTlpxNWE5disybjRwTjNyWDRVNjRQaEVjbzlXL3g0UTlGUjZIcjhC?=
 =?utf-8?B?b3FhZFlGUlMzWlFTRmlnd1ZsR2tNWTIzNkhoT2FTcTNZR2I5Q3c2ZHE5djJi?=
 =?utf-8?B?cnc2T3JUUWFSSUJ5bW9jMEpsZnRFNWQ0d0trelp6STRkZ2thaUtsQ2hiTnFK?=
 =?utf-8?B?OWxaM21oZURlNnFXVzRYR1FBK1dGeTNyMkxBZ3VMelRDUXFCd1JzMVBFR0lN?=
 =?utf-8?B?M1plT0NkRzh1WGVYVlI2UzVWZnZNbXF5TndwR1pKQTRzRzROclBZUFJ2Q0t2?=
 =?utf-8?B?clJvSXVRb1E5b0hXcWR3VVNZWUVqRG9Kc3EvRFNLa2ZLM2V5dVV3UWFqVmUy?=
 =?utf-8?B?RXhLanQwRnVtZFpFYjcvY0J4YU9vbjJsU1d1NGprS0tqVnYzbkEzTGxYSzhY?=
 =?utf-8?B?VmwvVVlMQ0kxdjJGaW9TR2NTSmJrM0loeThTZW5QdUNubGNmdGEwaDBmY3lT?=
 =?utf-8?Q?OsKoCZsidJGz9tp4d2UHUVL4G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <850F88280D568446A630F313BF21B685@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4e8ee0-265e-44c8-6d74-08dc9cd4c553
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 09:28:03.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/1zppz8jba9n7fXa7CQiefFCkpBZrXa7Gw/ShcM7UuJjAtJTfQZU97PzzrI4+mm6pYuNXf3fhbA3qMhaFj7wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7778
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.254900-8.000000
X-TMASE-MatchedRID: nI1cAR4k0HYNtKv7cnNXnSa1MaKuob8PofZV/2Xa0cJauByPtDzndbmn
	rGB/kwGMtq7wcCw4AGoHOdvowRYwKA+9QmShUWvCY1bQMCMvmn4wCmrLlx+Sdd9RlPzeVuQQl0B
	rH8BQUYVul7/bdpACHmxKxpQo2DDFXtBWIrlQ/3CUa50su1E7W8nlJe2gk8vIWltirZ/iPP4C8g
	kDxMuSmc4ZqNSq2iE6tNJKMhNbpDYItCgNwNY8YYDqq/69Hfgs0i/hFXziUdNtEzN0mAVDNgJjL
	DMzzZnzQbROmirHzn6Xr8R8eISeabG8dzu2wTUiHcQQBuf4ZFskKs3LoBtQlVLFyalIP3pyZgt5
	gnSc7QeRJ1uPRlLfN+kAXE+8HEbEhT738bImf5ttzb3s8Aa1ZpxfK35V7okVMBIR1uSlQM97PlV
	pTaVSO8ugQSrxb8MEitqmw2mRWTPlW1X3S7HG14bBPrt55wnwgdhI7ndNtOAfwQ5+r4+IN5xcqy
	imK04xu2hBKIBuS12Pms/RExaSr0+sh1YjwC0xhrs6JAEL1u7fSJ1kqMcqwY1eRh5mhJr6VSdAA
	6mVeIayVuPO+vBdmUw3m0nPdhDkj2hRzH1UwuDSBVVc2BozSnJnzNw42kCxxEHRux+uk8jpP8tM
	OyYmaA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.254900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	50638552680115CAD674F184234368036ADEE3AE57601A4435170847E6025E142000:8

T24gVHVlLCAyMDI0LTA2LTExIGF0IDA4OjU0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTEvMDYvMjQgMDg6NDgsIENLIEh1ICjog6Hkv4rlhYkpIGhhIHNj
cml0dG86DQo+ID4gT24gTW9uLCAyMDI0LTA2LTEwIGF0IDEwOjI4ICswMjAwLCBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gPiA+IElsIDA2LzA2LzI0IDA3OjI5LCBDSyBIdSAo
6IOh5L+K5YWJKSBoYSBzY3JpdHRvOg0KPiA+ID4gPiBIaSwgQW5nZWxvOg0KPiA+ID4gPiANCj4g
PiA+ID4gT24gV2VkLCAyMDI0LTA2LTA1IGF0IDEzOjE1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyB3cm90ZToNCj4gPiA+ID4gPiBJbCAwNS8wNi8yNCAwMzozOCwgQ0sgSHUgKOiD
oeS/iuWFiSkgaGEgc2NyaXR0bzoNCj4gPiA+ID4gPiA+IEhpLCBBbmdlbG86DQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IE9uIFR1ZSwgMjAyNC0wNS0yMSBhdCAwOTo1NyArMDIwMCwgQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IERvY3VtZW50IE9GIGdy
YXBoIG9uIE1NU1lTL1ZET1NZUzogdGhpcyBzdXBwb3J0cyB1cCB0byB0aHJlZSBERFAgcGF0aHMN
Cj4gPiA+ID4gPiA+ID4gcGVyIEhXIGluc3RhbmNlIChzbyBwb3RlbnRpYWxseSB1cCB0byBzaXgg
ZGlzcGxheXMgZm9yIG11bHRpLXZkbyBTb0NzKS4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiA+IFRoZSBNTVNZUyBvciBWRE9TWVMgaXMgYWx3YXlzIHRoZSBmaXJzdCBjb21wb25lbnQgaW4g
dGhlIEREUCBwaXBlbGluZSwNCj4gPiA+ID4gPiA+ID4gc28gaXQgb25seSBzdXBwb3J0cyBhbiBv
dXRwdXQgcG9ydCB3aXRoIG11bHRpcGxlIGVuZHBvaW50cyAtIHdoZXJlIGVhY2gNCj4gPiA+ID4g
PiA+ID4gZW5kcG9pbnQgZGVmaW5lcyB0aGUgc3RhcnRpbmcgcG9pbnQgZm9yIG9uZSBvZiB0aGUg
KGN1cnJlbnRseSB0aHJlZSkNCj4gPiA+ID4gPiA+ID4gcG9zc2libGUgaGFyZHdhcmUgcGF0aHMu
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcg
KEFybSkgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiA+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IEFsZXhh
bmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+ID4gPiA+ID4gPiA+IFRlc3Rl
ZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0QGJheWxpYnJlLmNvbT4NCj4gPiA+ID4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dp
b2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gPiA+ICAgICAuLi4vYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnlh
bWwgfCAyOCArKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gPiA+ICAgICAxIGZpbGUgY2hh
bmdlZCwgMjggaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsv
bWVkaWF0ZWssbW1zeXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMueWFtbA0KPiA+ID4gPiA+ID4gPiBpbmRleCBiM2M2
ODg4YzE0NTcuLjBlZjY3Y2E0MTIyYiAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy55
YW1sDQo+ID4gPiA+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMueWFtbA0KPiA+ID4gPiA+ID4gPiBAQCAtOTMs
NiArOTMsMzQgQEAgcHJvcGVydGllczoNCj4gPiA+ID4gPiA+ID4gICAgICAgJyNyZXNldC1jZWxs
cyc6DQo+ID4gPiA+ID4gPiA+ICAgICAgICAgY29uc3Q6IDENCj4gPiA+ID4gPiA+ID4gICAgIA0K
PiA+ID4gPiA+ID4gPiArICBwb3J0Og0KPiA+ID4gPiA+ID4gPiArICAgICRyZWY6IC9zY2hlbWFz
L2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMvcG9ydA0KPiA+ID4gPiA+ID4gPiArICAgIGRlc2NyaXB0
aW9uOg0KPiA+ID4gPiA+ID4gPiArICAgICAgT3V0cHV0IHBvcnQgbm9kZS4gVGhpcyBwb3J0IGNv
bm5lY3RzIHRoZSBNTVNZUy9WRE9TWVMgb3V0cHV0IHRvDQo+ID4gPiA+ID4gPiA+ICsgICAgICB0
aGUgZmlyc3QgY29tcG9uZW50IG9mIG9uZSBkaXNwbGF5IHBpcGVsaW5lLCBmb3IgZXhhbXBsZSBv
bmUgb2YNCj4gPiA+ID4gPiA+ID4gKyAgICAgIHRoZSBhdmFpbGFibGUgT1ZMIG9yIFJETUEgYmxv
Y2tzLg0KPiA+ID4gPiA+ID4gPiArICAgICAgU29tZSBNZWRpYVRlayBTb0NzIHN1cHBvcnQgbXVs
dGlwbGUgZGlzcGxheSBvdXRwdXRzIHBlciBNTVNZUy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gVGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIG1lLiBKdXN0IHdhbnQgdG8gc2hhcmUgYW5vdGhl
ciBpbmZvcm1hdGlvbiBmb3IgeW91Lg0KPiA+ID4gPiA+ID4gSGVyZSBpcyBhbiBleGFtcGxlIHRo
YXQgbW1zeXMvdmRvc3lzIGNvdWxkIHBvaW50IHRvIHRoZSBkaXNwbGF5IGludGVyZmFjZSBub2Rl
Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiB2ZG9zeXMwOiBzeXNjb25AMWMwMWEwMDAgew0K
PiA+ID4gPiA+ID4gICAgICAgICAgICAgIG1tc3lzLWRpc3BsYXktaW50ZXJmYWNlID0gPCZkc2kw
PiwgPCZkc2kxPiwgPCZkcF9pbnRmMD47DQo+ID4gPiA+ID4gPiB9Ow0KPiA+ID4gPiA+ID4gICAg
IA0KPiA+ID4gPiA+ID4gdmRvc3lzMTogc3lzY29uQDFjMTAwMDAwIHsNCj4gPiA+ID4gPiA+ICAg
ICAgICAgICAgICBtbXN5cy1kaXNwbGF5LWludGVyZmFjZSA9IDwmZHBfaW50ZjE+Ow0KPiA+ID4g
PiA+ID4gfTsNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlcmUgaXMgbm8gY29uZmxpY3Qg
dGhhdCBtbXN5cy92ZG9zeXMgcG9pbnQgdG8gZmlyc3QgY29tcG9uZW50IG9mIG9uZSBkaXNwbGF5
IHBpcGVsaW5lIG9yIHBvaW50IHRvIGRpc3BsYXkgaW50ZXJmYWNlLg0KPiA+ID4gPiA+ID4gQm90
aCBjb3VsZCBjby1leGlzdC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEhl
eSBDSywNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiB5ZXMsIHRoaXMgY291bGQgYmUgYW4gYWx0ZXJu
YXRpdmUgdG8gdGhlIE9GIGdyYXBocywgYW5kIEknbSBzdXJlIHRoYXQgaXQnZCB3b3JrLA0KPiA+
ID4gPiA+IGV2ZW4gdGhvdWdoIHRoaXMga2luZCBvZiBzb2x1dGlvbiB3b3VsZCBzdGlsbCByZXF1
aXJlIHBhcnRpYWwgaGFyZGNvZGluZyBvZiB0aGUNCj4gPiA+ID4gPiBkaXNwbGF5IHBhdGhzIHVw
IHVudGlsIG1tc3lzLWRpc3BsYXktaW50ZXJmYWNlIChzbywgdXAgdW50aWwgRFNJMCwgb3IgRFNJ
MSwgZXRjKS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgcHJvYmxlbSB3aXRoIGEgc29sdXRp
b24gbGlrZSB0aGlzIGlzIHRoYXQsIHdlbGwsIGV2ZW4gdGhvdWdoIGl0IHdvdWxkIHdvcmssDQo+
ID4gPiA+ID4gZXZlbiBpZiB3ZSBpZ25vcmUgdGhlIHN1Ym9wdGltYWwgcGFydGlhbCBoYXJkY29k
aW5nLCBPRiBncmFwaHMgYXJlIHNvbWV0aGluZw0KPiA+ID4gPiA+IGdlbmVyaWMsIHdoaWxlIHRo
ZSBtbXN5cy1kaXNwbGF5LWludGVyZmFjZSB3b3VsZCBiZSBhIE1lZGlhVGVrIHNwZWNpZmljL2N1
c3RvbQ0KPiA+ID4gPiA+IHByb3BlcnR5Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEluIHRoZSBl
bmQsIHJldXNpbmcgZ2VuZXJpYyBrZXJuZWwgYXBpcy9pbnRlcmZhY2VzL2V0YyBpcyBhbHdheXMg
cHJlZmVycmVkDQo+ID4gPiA+ID4gY29tcGFyZWQgdG8gY3VzdG9tIHNvbHV0aW9ucywgZXNwZWNp
YWxseSBpbiB0aGlzIGNhc2UsIGluIHdoaWNoIHRoZSBnZW5lcmljDQo+ID4gPiA+ID4gc3R1ZmYg
aXMgb24tcGFyIChvciBhY3R1YWxseSwgZGVwZW5kaW5nIHB1cmVseSBvbiBwZXJzb25hbCBvcGlu
aW9ucywgc3VwZXJpb3IpLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFzIGZvciB0aGUgdHdvIHRv
IGNvLWV4aXN0LCBJJ20gbm90IHN1cmUgdGhhdCB0aGlzIGlzIGFjdHVhbGx5IG5lZWRlZCwgYXMg
dGhlDQo+ID4gPiA+ID4gT0YgZ3JhcGhzIGFyZSBhbHJlYWR5IChhdCB0aGUgZW5kIG9mIHRoZSBn
cmFwaCkgcG9pbnRpbmcgdG8gdGhlIGRpc3BsYXkgaW50ZXJmYWNlLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IEluIGFueSBjYXNlLCBqdXN0IGFzIGEgcmVtaW5kZXI6IGlmIHRoZXJlIHdpbGwgYmUg
YW55IG5lZWQgdG8gYWRkIGFueSBjdXN0b20NCj4gPiA+ID4gPiBNZWRpYVRlayBzcGVjaWZpYyBw
cm9wZXJ0aWVzIGxhdGVyLCBpdCdzIG9rIGFuZCB3ZSBjYW4gZG8gdGhhdCBhdCBhbnkgdGltZS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBhbHRlcm5hdGl2ZSBzb2x1dGlvbiBpcyB1c2luZyBPRiBn
cmFwaHMgdG8gcG9pbnQgZGlzcGxheSBpbnRlcmZhY2UgYW5kIHVzZSBNZWRpYVRlayBzcGVjaWZp
YyBwcm9wZXJ0eSB0byBmaXJzdCBjb21wb25lbnQ6DQo+ID4gPiA+IA0KPiA+ID4gPiB2ZG9zeXMw
OiBzeXNjb25AMWMwMWEwMDAgew0KPiA+ID4gPiAgICAgICAgICAgICBwb3J0cyB7DQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgIHBvcnRAMCB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBlbmRwb2ludCB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZW1vdGUtZW5kcG9pbnQgPSA8JmRzaTBfZW5kcG9pbnQ+Ow0KPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgfTsNCj4gPiA+ID4gICAgDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
IHBvcnRAMSB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbmRwb2lu
dCB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZW1v
dGUtZW5kcG9pbnQgPSA8JmRzaTFfZW5kcG9pbnQ+Ow0KPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+
ID4gICAgDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIHBvcnRAMiB7DQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbmRwb2ludCB7DQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZW1vdGUtZW5kcG9pbnQgPSA8JmRwX2lu
dGYwX2VuZHBvaW50PjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07
DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gPiA+ICAgICAgICAgICAgIH07
DQo+ID4gPiA+ICAgIA0KPiA+ID4gPiAgICAgICAgICAgICBkaXNwbGF5LWZpcnN0LWNvbXBvbmVu
dCA9IDwmb3ZsMD47DQo+ID4gPiA+IH07DQo+ID4gPiA+IA0KPiA+ID4gPiBBbmQgSSBhZ3JlZSB0
byBpdCdzIGJldHRlciB0byBrZWVwIG9ubHkgT0YgZ3JhcGhzIHByb3BlcnR5LCBzbyBpdCB3b3Vs
ZCBiZQ0KPiA+ID4gPiANCj4gPiA+ID4gdmRvc3lzMDogc3lzY29uQDFjMDFhMDAwIHsNCj4gPiA+
ID4gICAgICAgICAgICAgcG9ydHMgew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICBwb3J0
QDAgew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5kcG9pbnQgew0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVtb3RlLWVu
ZHBvaW50ID0gPCZkc2kwX2VuZHBvaW50PjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAN
Cj4gPiA+ID4gICAgICAgICAgICAgIH07DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIH07
DQo+ID4gPiA+ICAgIA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICBwb3J0QDEgew0KPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5kcG9pbnQgew0KPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0g
PCZkc2kxX2VuZHBvaW50PjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0K
PiA+ID4gPiAgICAgIH07DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gPiA+
ICAgIA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICBwb3J0QDIgew0KPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5kcG9pbnQgew0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZkcF9pbnRm
MF9lbmRwb2ludD47DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+
ID4gPiA+IDsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+ID4gICAgICAg
ICAgICAgfTsNCj4gPiA+ID4gfTsNCj4gPiA+ID4gDQo+ID4gPiA+IE1heWJlIHdlIGNvdWxkIHVz
ZSBPRiBncmFwaHMgZm9yIGJvdGggZmlyc3QgY29tcG9uZW50IGFuZCBkaXNwbGF5IGludGVyZmFj
ZSBhbmQgZHJvcCB1c2luZyBNZWRpYVRlayBzcGVjaWZpYyBwcm9wZXJ0eS4NCj4gPiA+ID4gDQo+
ID4gPiANCj4gPiA+IFdlIGNvdWxkLCBvciB3ZSBjYW4gc2ltcGx5IHdhbGsgdGhyb3VnaCB0aGUg
T0YgR3JhcGggaW4gdGhlIGRyaXZlciBhbmQgZ2V0IHRoZQ0KPiA+ID4gZGlzcGxheSBpbnRlcmZh
Y2UgbGlrZSB0aGF0LCBhcyBpdCdzIGJvYXJkLXNwZWNpZmljIDstKQ0KPiA+ID4gDQo+ID4gPiAu
Li5idXQgYW55d2F5LCBsZXQncyBzZWUgdGhhdCBsYXRlcjogYWZ0ZXIgZ2V0dGluZyB0aGlzIHNl
cmllcyB1cHN0cmVhbWVkLCBJIHdpbGwNCj4gPiA+IGNvbnZlcnQgYWxsIE1lZGlhVGVrIGJvYXJk
cyAoaW5jbHVkaW5nIENocm9tZWJvb2tzKSB0byB1c2UgdGhlIGdyYXBocyBpbnN0ZWFkLCBhbmQN
Cj4gPiA+IHlvdSdsbCBzZWUgdGhhdCwgYXQgbGVhc3QgZm9yIHRoZSBjdXJyZW50bHkgc3VwcG9y
dGVkIGJvYXJkcywgdGhlcmUncyBubyBuZWVkIGZvcg0KPiA+ID4gYW55IGN1c3RvbSBwcm9wZXJ0
eS4NCj4gPiA+IA0KPiA+ID4gQWxzbywgc2V0dGluZyB0aGUgRFNJMC8xL2RwaW50ZiBlbmRwb2lu
dCB0byBWRE8wIGlzIHRlY2huaWNhbGx5IHdyb25nLCBhcyB0aGF0IGlzDQo+ID4gPiBzdXBwb3Nl
ZCB0byBiZSB0aGUgbGFzdCBvbmUsIGFuZCBhIGdyYXBoIGlzIGNvbmNlcHR1YWxseSBzdXBwb3Nl
ZCB0byBnbyBmcm9tIHRoZQ0KPiA+ID4gZmlyc3QgdG8gdGhlIGxhc3QgaW4gc2VxdWVuY2UuDQo+
ID4gPiANCj4gPiA+ICppZiogd2Ugd2lsbCBldmVyIG5lZWQgKHByb2JhYmx5IG5vdCkgdG8gZ2V0
IHRoZSBWRE8wIG5vZGUgdG8gcG9pbnQgZGlyZWN0bHkgdG8NCj4gPiA+IHRoZSBsYXN0IG5vZGUg
Zm9yIHdoYXRldmVyIHJlYXNvbiwgdGhlIHJpZ2h0IHdheSB3b3VsZCBiZSB0aGUgZmlyc3Qgb25l
IHlvdSBzYWlkLA0KPiA+ID4gc28sIG1lZGlhdGVrLG1tc3lzLWRpc3BsYXktaW50ZXJmYWNlID0g
PCZkc2kwPiwgPCZkc2kxPiwgZXRjIGV0Yw0KPiA+ID4gDQo+ID4gPiAuLi5vciBtZWRpYXRlayxt
bXN5cy1wb3NzaWJsZS1kaXNwbGF5cyA9IDwgLi4uIHBoYW5kbGVzID4NCj4gPiA+IA0KPiA+ID4g
Li4ub3IgYW55d2F5LCBtYW55IG90aGVyIHNvbHV0aW9ucyBhcmUgcG9zc2libGUgLSBidXQgYWdh
aW4sIEkgdGhpbmsgdGhpcyBpcyBub3QNCj4gPiA+IHRoZSByaWdodCB0aW1lIHRvIHRoaW5rIGFi
b3V0IHRoYXQuIEtub3dpbmcgdGhhdCB0aGVyZSBhcmUgZXZlbnR1YWwgc29sdXRpb25zIGZvcg0K
PiA+ID4gYW55IG5lZWQgdGhhdCBtaWdodCBhcmlzZSBpbiB0aGUgZnV0dXJlIGlzIGVub3VnaCwg
SU1PIDotKQ0KPiA+IA0KPiA+IFRoaXMgaXMgb25lIHJvdXRpbmcgb2YgZGlzcGxheSBwaXBlbGlu
ZSBhbmQgdGhlIHJlbGF0aW9uIG9mIFZET1NZUzAgd2l0aCBkaXNwbGF5IHBpcGVsaW5lLg0KPiA+
IA0KPiA+ICAgICAgICAgICAgICAgICArLS0gVkRPU1lTMCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gICAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KPiA+IERSQU0gLT4gSU9NTVUgLS0tPiBPVkwwIC0+IFJETUEwIC0+IC4u
LiAtPiBEU0MwIC0+IE1FUkdFMCAtPiBEUF9JTlRGMCAtLS0tPg0KPiA+ICAgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8DQo+ID4gICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+IA0K
PiA+IFZpZGVvIGRhdGEgaXMgcmVhZCBieSBJT01NVSBmcm9tIERSQU0gYW5kIHNlbmQgdG8gZGlz
cGxheSBwaXBlbGluZS4gVGhlbiB2aWRlbyBkYXRhIHRyYXZlbCB0aHJvdWdoIGZpcnN0IGNvbXBv
bmVudCB0byBkaXNwbGF5IGludGVyZmFjZS4NCj4gPiBWRE9TWVMwIG1hbmFnZSBlYWNoIGNvbXBv
bmVudCBpbiB0aGUgcGlwZWxpbmUgaW5jbHVkZSBmaXJzdCBjb21wb25lbnQgYW5kIGRpc3BsYXkg
aW50ZXJmYWNlLg0KPiA+IFRoZSBtYW5hZ2VtZW50IGluY2x1ZGUgY2xvY2sgZ2F0aW5nLCByZXNl
dCwgdmlkZW8gZGF0YSBpbnB1dC9vdXRwdXQgcm91dGluZy4NCj4gPiBUaGUgcmVsYXRpb25zaGlw
IG9mIFZET1NZVFMwIHdpdGggZmlyc3QgY29tcG9uZW50IGlzIHRoZSBzYW1lIGFzIHRoZSByZWxh
dGlvbnNoaXAgb2YgVkRPU1lTMCB3aXRoIGRpc3BsYXkgaW50ZXJmYWNlLg0KPiA+IElmIFZET1NZ
UzAgaXMgbm90IHN1aXRhYmxlIHVzaW5nIE9GIGdyYXBoIHBvaW50IHRvIGRpc3BsYXkgaW50ZXJm
YWNlLCBWRE9TWVMwIGlzIGFsc28gbm90IHN1aXRhYmxlIHVzaW5nIE9GIGdyYXBoIHBvaW50IHRv
IGZpcnN0IGNvbXBvbmVudC4NCj4gDQo+IEluIHRoZSBjYXNlcyBpbiB3aGljaCBWRE8gZ29lcyBk
aXJlY3RseSB0byB0aGUgZGlzcGxheSwgaXQgKmlzKiBwb3NzaWJsZSB0byBtYWtlIGl0DQo+IHBv
aW50IGRpcmVjdGx5IHRvIHRoZSBkaXNwbGF5Lg0KPiANCj4gSW4gdGhlIGNhc2VzIGluIHdoaWNo
IHRoZSBwaXBlbGluZSBpcyBsYXJnZXIsIFZETyBzdGlsbCBwb2ludHMgdG8gdGhlIGRpc3BsYXks
IGJ1dA0KPiBvbmx5IGxhdGVyIGluIHRoZSBwaXBlbGluZS4NCg0KSSBtZWFuIFZET1NZUzAgaXMg
bm90IHN1aXRhYmxlICd1c2luZyBPRiBncmFwaCcgdG8gcG9pbnQgdG8gYm90aCBkaXNwbGF5IGlu
dGVyZmFjZSBhbmQgZmlyc3QgY29tcG9uZW50Lg0KU28gVkRPU1lTMCBzaG91bGQgdXNlIHNwZWNp
ZmljIHByb3BlcnR5IHRvIHBvaW50IHRvIGJvdGggZGlzcGxheSBpbnRlcmZhY2UgYW5kIGZpcnN0
IGNvbXBvbmVudC4NCk1heWJlDQoNCnZkb3N5czAgew0KCWRtYS1kZXZpY2UgPSA8b3ZsMD47DQoJ
ZGlzcGxheS1pbnRlcmZhY2UgPSA8JmRzaTA+LCA8JmRzaTE+LCA8JmRwX2ludGYwPjsNCn07DQoN
ClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiA+IFRoZSBqb2Igb2YgdGhlIGNvbXBvbmVudCBpbiBkaXNw
bGF5IHBpcGVsaW5lIGlzIHRvIHByb2Nlc3MgdGhlIHZpZGVvIGRhdGEsDQo+ID4gYnV0IHRoZSBq
b2Igb2YgVkRPU1lTMCBpcyB0byBtYW5hZ2UgKGNsb2NrIGdhdGluZywgcmVzZXQsIHJvdXRpbmcp
IHRoZSBwaXBlbGluZS4NCj4gPiBJZiB0aGUgT0YgZ3JhcGggaXMgdG8gc2hvdyB0aGUgdmlkZW8g
ZGF0YSB0cmF2ZWwgcGF0aCwgVkRPU1lTMCBzaG91bGQgbm90IGV4aXN0IGluIHRoZSBPRiBncmFw
aC4NCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IENLDQo+ID4gDQo+ID4gPiANCj4gPiA+IENoZWVy
cywNCj4gPiA+IEFuZ2Vsbw0KPiA+ID4gDQo+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+IENLDQo+
ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IENoZWVycyENCj4gPiA+ID4gPiBBbmdlbG8N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+ID4gPiBDSw0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ICsgICAgcHJvcGVydGllczoNCj4gPiA+ID4gPiA+ID4gKyAg
ICAgIGVuZHBvaW50QDA6DQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL2dy
YXBoLnlhbWwjL3Byb3BlcnRpZXMvZW5kcG9pbnQNCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgZGVz
Y3JpcHRpb246IE91dHB1dCB0byB0aGUgcHJpbWFyeSBkaXNwbGF5IHBpcGVsaW5lDQo+ID4gPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gKyAgICAgIGVuZHBvaW50QDE6DQo+ID4gPiA+ID4gPiA+
ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMvZW5kcG9pbnQN
Cj4gPiA+ID4gPiA+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IE91dHB1dCB0byB0aGUgc2Vjb25k
YXJ5IGRpc3BsYXkgcGlwZWxpbmUNCj4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiArICAg
ICAgZW5kcG9pbnRAMjoNCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgJHJlZjogL3NjaGVtYXMvZ3Jh
cGgueWFtbCMvcHJvcGVydGllcy9lbmRwb2ludA0KPiA+ID4gPiA+ID4gPiArICAgICAgICBkZXNj
cmlwdGlvbjogT3V0cHV0IHRvIHRoZSB0ZXJ0aWFyeSBkaXNwbGF5IHBpcGVsaW5lDQo+ID4gPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gKyAgICBhbnlPZjoNCj4gPiA+ID4gPiA+ID4gKyAgICAg
IC0gcmVxdWlyZWQ6DQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgLSBlbmRwb2ludEAwDQo+ID4g
PiA+ID4gPiA+ICsgICAgICAtIHJlcXVpcmVkOg0KPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0g
ZW5kcG9pbnRAMQ0KPiA+ID4gPiA+ID4gPiArICAgICAgLSByZXF1aXJlZDoNCj4gPiA+ID4gPiA+
ID4gKyAgICAgICAgICAtIGVuZHBvaW50QDINCj4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4g
PiAgICAgcmVxdWlyZWQ6DQo+ID4gPiA+ID4gPiA+ICAgICAgIC0gY29tcGF0aWJsZQ0KPiA+ID4g
PiA+ID4gPiAgICAgICAtIHJlZw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gDQo+ID4g
PiANCj4gDQo+IA0KPiANCg==

