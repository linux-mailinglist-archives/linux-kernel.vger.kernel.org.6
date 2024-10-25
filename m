Return-Path: <linux-kernel+bounces-381376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3999AFE41
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9E828838B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23E1D47C0;
	Fri, 25 Oct 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E/12Bbya";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cHz4B+Tm"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A111D4351;
	Fri, 25 Oct 2024 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848804; cv=fail; b=XPAVeDe1CbOEUj+UK0vNMULzqPvt8EhFIveHxHTkBXcZ4yxFRfKA9eCUdqcp0eU1ehJgZrcQtgllx7zB3WrD1p8uZMJbdO8C28q5RKJcYmjqb9oTSY1gjQNb2f4YgcGQgYbGZXFmL2cQO5HVBgyJzRx0p8gEETFDBWggszkx4M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848804; c=relaxed/simple;
	bh=2wPv5Dgn/YBaQm+ywxV1Nr/6V4VuMVs2CV32hiMnrD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGgVs6dtJYPh0P8INOePmDYA8ntgZICt/W+56rF3p80vBS3vyOCAONzP8aNpwwmw4z/H+/hZzKis8Ubp5GEN+WBNl52Vyzq7RLuwygOEsV/UvZAsXaJOg/WfevuimRxXuM9Xill93XsHGBXhTKkU3u0BKrHL+Ze0nuIzhgUqH8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E/12Bbya; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=cHz4B+Tm; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 292734d492b411efb88477ffae1fc7a5-20241025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2wPv5Dgn/YBaQm+ywxV1Nr/6V4VuMVs2CV32hiMnrD0=;
	b=E/12BbyaI8M7MGpiFaio9Zg+xVO+xLhLJTNYa/VbRwf71HWy1Ffp+ox1vdzQ+/YVYPIk9GzG8FVyqxTmZBoGThDnbHt4WsnQ2bfOl5PlrATa0ZU2v82zhs70FEICuqBNaxJzJZNE4DCwsAQciZN+bpnZOYhjbvsx5CDoDZKPK5s=;
X-CID-CACHE: Type:Local,Time:202410251733+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:36880526-787f-481b-97de-00903e9e3198,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:82c9d341-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 292734d492b411efb88477ffae1fc7a5-20241025
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1752631297; Fri, 25 Oct 2024 17:33:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Oct 2024 17:33:14 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Oct 2024 17:33:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qz4VZiJ+jWbZW9uUu4M5iG79OyFacU4BanCYtzxnd0DCuBF+UnQAet/syR+FpWfYDGMJi198XNZbOLylMUzQqAQf0ZNSOZ/EijOzL1aRHn4mqqe2N5a3BV4hFeYmGVqlu9oCgoDS+67QnXJi8w4QLXNyfmVB5YCCNV5DgbXxMIPpWt1GHZO7w2Y0qHc8NZ54q4Icr0wWOCzl2+hHpl9vrx4AE26RZMO9ngMVjBeH0dFlb67PBC7IWwH+wh//KweZBUz4FMzFxvKO1xcWfdIQgdxROSIRSW1jiU0fjF71+DTjgDJmbl82rTpBkSTSoWeEabIasktKJ/IlkpjfniqQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wPv5Dgn/YBaQm+ywxV1Nr/6V4VuMVs2CV32hiMnrD0=;
 b=SJw7E27xgFXynQJneAM2U6Yfb7JMGrGNbdc63baGix9v32BII1cO/sg/ufwUt+MdAbMLslKHl6bHpHH3mnd5YaFYaYF5H7JTuqEuV9fYATz621TTUta2e4MkSt0MDLRaa7JEm0JTGv1ofTFB/8Nawxj+QQ+upgbT4660GZJ5piZoQRHPv4hIMHpALeD/OzRXoyL7DkpkbE8L5LZZi7B/iT9ES6WhN8tjDH4exfX9LGdXfEU671GDO2o7OthLaH/OTKU683YYFHEkLoZ9Q75qNwMMczVvzIUuFvP0huM03L1RciLSjBzpDgWsKnD2uw3n3L5KGpq2ThpcaGTgoyPgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wPv5Dgn/YBaQm+ywxV1Nr/6V4VuMVs2CV32hiMnrD0=;
 b=cHz4B+Tmy20gWk7vDjRuqaZzuUDOQtPMpVU247v7WeG99jlpGg0gYKgteJS2y4iZ7LgM8t9fBMm/QZpryWCvqFmwKRppjr7SwnBBspnZPxN2Nyq4n9d1Nc88Ivp4F+g1a7DmHVHGFIoQu1WHiHrfD6Whg2A2N6YOe6MAyWanZ9k=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by KL1PR03MB8217.apcprd03.prod.outlook.com (2603:1096:820:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 09:33:11 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:33:11 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>
CC: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: memory: mediatek: Add smi-sub-common
 property for reset
Thread-Topic: [PATCH 2/4] dt-bindings: memory: mediatek: Add smi-sub-common
 property for reset
Thread-Index: AQHa86RRlzYUg5Gi9UG44pqPb7iOI7IxaJMAgGQYZgCAALAogIABaXsA
Date: Fri, 25 Oct 2024 09:33:11 +0000
Message-ID: <e57e8319fc09e6d6f7f39df6773a02ca6715d17d.camel@mediatek.com>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
	 <20240821082845.11792-3-friday.yang@mediatek.com>
	 <3b31bf46-c5c0-41c9-bb4d-3ba9f64a5d1c@kernel.org>
	 <7ca196cf1c1f57426fc6b733d01d38f073da7d94.camel@mediatek.com>
	 <216c62ae-04ae-4eb9-8344-9e5de2efdd14@collabora.com>
In-Reply-To: <216c62ae-04ae-4eb9-8344-9e5de2efdd14@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|KL1PR03MB8217:EE_
x-ms-office365-filtering-correlation-id: 5cf83d2d-151c-4c02-a0b6-08dcf4d80af8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bXRiTkFsMG1wUENSZ1FKaGh1aldlajhPV2FyQkt6ZTFuZEU1VFBYbHloZlEx?=
 =?utf-8?B?MDZxcHplY3lxRWY0aDJBTjNWd2h4dFpScHA2VmhQMVhvZzBlYzl2L09JZlJ4?=
 =?utf-8?B?VXZCdW5lTlB3OW13WDhhRXVuREIvT0hZcHZTMHd1UytFdW9td2pIUTdIenZq?=
 =?utf-8?B?SG5iUlJobUJ1T3JERjJtNDc3dUQzM3pmUlRmK3UxbHdWZjJDMXJhY045V09r?=
 =?utf-8?B?d3cyUGl0Z1FFNldkNWkydTdLblJTN2M2MTg1b2EzVU8xa3RuSDRzNFN4cnBx?=
 =?utf-8?B?bG91dFhVMnN6OU9wS2JxUlM4NkM4a3MxZW9NR3FsSmRBMHZ1VXpuektIaWZh?=
 =?utf-8?B?enVoSk1RUko3dk5lVzZNUzhSN09oRlp6RVNFUUFNK0xyNU5JUXd6WmJPemJ0?=
 =?utf-8?B?OXpQcDhpcTNkSlByRHF3VllkUlFMT1BLV0I4dnZIdkpDcTUyU1VoN0w0WVRQ?=
 =?utf-8?B?RHZ2Zm1JcW9TVHB1b2lqS0xWVU1sLzlZNXFxejdiVGdsd0lSZU1hV2hFQytI?=
 =?utf-8?B?VG9udUZCMzM1UGE4T1ZHT2NoRXU1RFVXakN0V084RThiZ2hQZWhvMWtoTmlX?=
 =?utf-8?B?MUhsQWFENXRYbm0xQ1hKRFU1alIvWFZLLzBNc1d3aDRPMm1oMVBnckNjajlW?=
 =?utf-8?B?RFVYUnZHclpxV1lPN1B2Y0FsNWV3c3BGTncycjBkT3JWeHRaZk9NRDJOOW4z?=
 =?utf-8?B?UVNXRllRMVlRaHhPcCtBakZxSjgzZlZraXdlcVJiQTk2SFFlVE84eTZ4MDVF?=
 =?utf-8?B?QnRhMFIwYnhGMFp4YWM0cG9qNXNLY0Y1M1k2WW4renpEYStRR2c5T0FLbG9P?=
 =?utf-8?B?SitiREc0Y1psVmNEY1hVSGttQ0xpR0xMbVFuWWZCcVdud2FIWU1oM0gxVXZr?=
 =?utf-8?B?cG1nRStqY2QrNmkxWHRoYUxjTnVQUElJcjhIS2N4YjcxNGI5czhRZ1MyVm5L?=
 =?utf-8?B?dkhyNUx5TEFMa0I4QXlOVlVlak9lNHY1OW1aY1JpYnovd0FJMkY2cG83S29j?=
 =?utf-8?B?ZHUvYXVyRWdjK3g1ekxYd25MVVZQaEptV2p3QWVYZndIMER6MnV5d0tHK2Uy?=
 =?utf-8?B?V1QxVnM4RUdVenRvY2xiKzkyZ0c4MFpaZnpRajVESjRodGhROFYrQUN5SEU2?=
 =?utf-8?B?TWZmeks5TUtpVEJsNTB1TWV6OTlOSGoyYkhwUUJya0FndjExWkxweVFtRmNo?=
 =?utf-8?B?VVpENFppeFpQa0tYcUNKVmhaUkJIODJWS2U5MG5oeWUvcTFJTDQrcGN4d1RB?=
 =?utf-8?B?V1ZzRHhYank3V0o4bzdSdEc0WHVmQ1dzbGU3TnVwMkI2ZnQ0enZ3TWtaYm85?=
 =?utf-8?B?TnpnaGQyVjNTQ3duNGZwNTdCOHlrSlc5N29hYnVzTzdYQUVJYTVBbEQxZHVm?=
 =?utf-8?B?YXUzTlgvd3NQcTY3R2VPR3BDTFdoanNJN2RBN2tOeTdXVjVjYUdvSmhYbGV4?=
 =?utf-8?B?eEZiT3BKZW9KN1UrQ1FXbGNmZjFsbUpFZVdtRlAwQTFuUmt0N3pMdFBtRXJE?=
 =?utf-8?B?K1JhMHBVZEc2bTUrRWpPVFYzV241eWxVUG82ejFOZ3FqMkdQNXVXODdqWEdu?=
 =?utf-8?B?Yi83eU0rZ2hSM2NFNnp2YUNVQmRGRTBnZ0N0U1R6RitYMmhRMUI2aXVpc1pm?=
 =?utf-8?B?MUJXek5hQmpKL0VNSERyT3FVQjR5UGFtVVdFMW84dC8rUzRNSWRnNHFrb3BP?=
 =?utf-8?B?K3IzckFGYVArWCtrVjBYaHRXbWlMNUZGZkZ4akpGL1BGY05lRGc4eXZnejdI?=
 =?utf-8?B?WlFCRlNJT0VKS2xYd09SZGlmOVQ5NFRSNVlteENpNHI5ZktHRUEvVUYrQUZl?=
 =?utf-8?Q?IE8N4hN5B7TsN+dFuWTF2Iz7c/zbhuRM42fFM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am4vbTVhZFU3YTMvVWR1V3BBRDV1RG56VzFuYzNpaTE5K3Q5eW11YWkvckF3?=
 =?utf-8?B?WlRZMWpCUkh6T05PM2Z6aWZtL2dVK2I4OWh1alVnS2cxaUN4SUt3VGdMTjVF?=
 =?utf-8?B?ZUpkbHp4Ni9wSWttekpIRm1NNUZVVHp3TVk1N3ZSMmwwazVmK0swckwzelBN?=
 =?utf-8?B?S0UvcUlwQnZiY2FHbW5aaVp5b2VEYzg0ZHRtaHZxbSs5aWhaQXNHb3Exc0U0?=
 =?utf-8?B?Unp6U0hHYlQ5YXNDK28wWU9yZ0xPTHYyOUw5ZTl6ZnFGL2FJU1FldUFlTjF3?=
 =?utf-8?B?VEQrSG8yVXNkM25Sa0dGV1JxSFRjZmRQUi9hQzEzV3NWN1ZEc09IdlFHUWJV?=
 =?utf-8?B?WUtpR3R3OEZYNGRzSFFiNiswSEdiSFovL25PbVNUQ1pndEsxYWt1eEpGRUIx?=
 =?utf-8?B?VldjMkpnNlRVK3VobVVtM3F3aFU2akViSFgvbzhPdWptOFg4K1JHNkJvaFI3?=
 =?utf-8?B?VXdMdGtQRnhzcmNUSlJMNDh4bWwrenlTbFdWWUFqWDM4Mi9QTFlMdWNqS25G?=
 =?utf-8?B?SjRFVmVSVlNON0RTbFk5b2dQUDFEOUZKbUM1QlF6MU9lVVFhUURZNTUraVFt?=
 =?utf-8?B?ZDYrNFppNTY5V0cvRXJ0b2FKYTc0MEdPQnpoM3EvblBNZDN5ODh1aEMrNnRx?=
 =?utf-8?B?OTlvcUhVemtSbkVTdXlyS282MmpNZ2h6TVdyL0ZEb2tVNnNXZG9lWjRReG15?=
 =?utf-8?B?U1I5TUo4ZGN3UG16VzN0Z1dFVDVRTDBNWXdXSEpDWFd2T1FkRFRlM241Njk0?=
 =?utf-8?B?VmlMS3RXSWtuOUhGdHBDUTNPTmpiLzlGS3J0Wk55TWptTERQRmtJTzRHTDND?=
 =?utf-8?B?UFQvdk1qTVNWWjl3blI0WDcvdjh4RHZBa2s5NnJxSjZNU0FGbFcwdGlsVDly?=
 =?utf-8?B?bWFxei9TMm5Ta1VvNUFsZEplYWZQbkxzR0hmRENzRkN5TDI5MTNkenhNWXQ3?=
 =?utf-8?B?dXVSbHJCdUNTUDYxRGkwVzRmTmhBNkNMRm9yRTd2Ujg0ZFRWQjgrVVBKVU56?=
 =?utf-8?B?L2tNRDE3QlUrOTh1NlkvQWxhb2dOVkRWMS9Ealg5cjVJR05vcWx2b2t6T2Vw?=
 =?utf-8?B?N0ZneFdxaUROZS9TMnF3TnpCWk1ud2Y5VGMvZXM3WDFvWkFyRGk1Yk5NZjB5?=
 =?utf-8?B?NmFLSnJkZ0VkcmRaMnNreWhZS0JVbCtPOFdxZWRqdnM1WDdiU25Ic3oweUZr?=
 =?utf-8?B?WWRnazBMMExYakJVeGN5RC80aFAxNXRKTnUycHVPV1NMbjN4VFY0bkNqcE0v?=
 =?utf-8?B?T21RNFlDaFM4SGM1bWV0UEdZWTIzaFlzbmwvUVNOblYwa2dNMGZGUW9mOTdH?=
 =?utf-8?B?clA2dDFQYXhSWnBpamVMNldpUlhiaCtYL29WNEhCYjJ6cER4TjN5cDZIUHc4?=
 =?utf-8?B?TE85NEhlUW51eGFENTQyMG5WR21ZdFpKbEJmcW9CL1RTOWNkdklNL1NNa1Vs?=
 =?utf-8?B?NTRneGN5N0c4Rk0vdkZCNWZ3VDU1M0lvZSt0MGZobU8rcW9UYWVpM1paazFQ?=
 =?utf-8?B?ajNlazkyR2hYOUYzeDB2WCtEN2RUVlh5VWJMcTlaa2tmMTRTL2ViWXRFN3px?=
 =?utf-8?B?c0F4TXJmWXZyT2Z6eWt2b3QxamFINmhCaEdIWVM1UFpUV1N3aXZ6c3R2aTQ1?=
 =?utf-8?B?SWhHMFJTRGRFeG1kZTF0WDUzT0JIZkRXMlY5TUJCWXQwV1RWUC94OVcybk5L?=
 =?utf-8?B?eUNweFVVWXFyZkpicVB5L01ja0lLQUg5OU0wZG1CVW1BTXkycjZCRUF2YlU5?=
 =?utf-8?B?MUo5N2d2ZXdVenRuS2VuQzMzWDU1ODZMb2FaeXVQY0ZaeHl1UGlTTzQ4ZENn?=
 =?utf-8?B?Y3h6Y2wySGZrck5vN2RzKzRzc0FtWlBJQzBCK1RmR1c4em9hRHRGS0xoMGNj?=
 =?utf-8?B?YVdmSXo4MVVKSW1wVEhqMDZCSVBjdFBVQ3dxSGU5V1doT1VNS0VBY25GYVor?=
 =?utf-8?B?REgvVGJvV1FKUEdhS0RoekxBNkhDd1BkSGtCS3o1TjNhaWtuMEFNZWg4d3dZ?=
 =?utf-8?B?YlZJWWRUYThpZWlGTmp5bFV0cHFGVnFiOTB0bjYyWGJMd0lZbjJ2YWZhNmVG?=
 =?utf-8?B?Rk4rK3UxK0lkbnBNY0o3Nm95dDBTanlhMnZoOWRDWGZyb1ZmdkdVN2Z2dTVt?=
 =?utf-8?B?dSszNXNHM2VyQmRmRU03SFV5Z0EvSXo3eVpBNTJEbW9WNGZxazFvWno3QW14?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C6A3F75700CCA498DFC3051475D6178@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf83d2d-151c-4c02-a0b6-08dcf4d80af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 09:33:11.3501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NUHFbIV0dFjalpZ+EnMovIXGnIAqPLzlhyJRQ2LSketqIAYPIeXHZcjaAOLn1H1ICD1YrahqU2yY6T6FRoifkuOVi15NljsQXANTyNVtew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8217

T24gVGh1LCAyMDI0LTEwLTI0IGF0IDEzOjU5ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjQvMTAvMjQgMDM6MjgsIEZyaWRheSBZYW5nICjmnajpmLMpIGhh
IHNjcml0dG86DQo+ID4gT24gV2VkLCAyMDI0LTA4LTIxIGF0IDEwOjU1ICswMjAwLCBLcnp5c3p0
b2YgS296bG93c2tpIHdyb3RlOg0KPiA+ID4gICAJDQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBs
ZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwN
Cj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4g
PiAgIE9uIDIxLzA4LzIwMjQgMTA6MjYsIGZyaWRheS55YW5nIHdyb3RlOg0KPiA+ID4gPiBPbiB0
aGUgTWVkaWFUZWsgcGxhdGZvcm0sIHNvbWUgU01JIExBUkJzIGFyZSBkaXJlY3RseSBsaW5rZWQg
dG8NCj4gPiA+ID4gU01JDQo+ID4gPiA+IGNvbW1vbi4gV2hpbGUgc29tZSBTTUkgTEFSQnMgYXJl
IGxpbmtlZCB0byBTTUkgc3ViIGNvbW1vbiwgdGhlbg0KPiA+ID4gPiBTTUkNCj4gPiA+ID4gc3Vi
IGNvbW1vbiBpcyBsaW5rZWQgdG8gU01JIGNvbW1vbi4gQWRkICdtZWRpYXRlayxzbWktc3ViLWNv
bW0nIA0KPiA+ID4gPiBhbmQNCj4gPiA+ID4gJ21lZGlhdGVrLHNtaS1zdWItY29tbS1pbi1wb3J0
aWQnIHByb3BlcnRpZXMgaGVyZS4gVGhlIFNNSQ0KPiA+ID4gPiByZXNldA0KPiA+ID4gPiBkcml2
ZXIgY291bGQgcXVlcnkgd2hpY2ggcG9ydCBvZiB0aGUgU01JIHN1YiBjb21tb24gdGhlIGN1cnJl
bnQNCj4gPiA+IA0KPiA+ID4gTEFSQg0KPiA+ID4gPiBpcyBsaW5rZWQgdG8gdGhyb3VnaCB0aGUg
dHdvIHByb3BlcnRpZXMuIFRoZSBoYXJkd2FyZSBibG9jaw0KPiA+ID4gPiBkaWFncmFtDQo+ID4g
PiA+IGNvdWxkIGJlIGRlc2NyaWJlZCBhcyBiZWxvdy4NCj4gPiA+ID4gDQo+ID4gPiA+ICAgICAg
ICAgICAgICAgU01JIENvbW1vbihTbWFydCBNdWx0aW1lZGlhIEludGVyZmFjZSBDb21tb24pDQo+
ID4gPiA+ICAgICAgICAgICAgICAgICAgIHwNCj4gPiA+ID4gICAgICAgICAgICstLS0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0NCj4gPiA+ID4gICAgICAgICAgIHwgICAgICAgICAgICAgICAgfA0KPiA+
ID4gPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICB8DQo+ID4gPiA+ICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgIHwNCj4gPiA+ID4gICAgICAgICAgIHwgICAgICAgICAgICAgICAgfA0KPiA+
ID4gPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICB8DQo+ID4gPiA+ICAgICAgICAgbGFyYjAg
ICAgICAgU01JIFN1YiBDb21tb24NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICB8ICAgICAg
fCAgICAgfA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgbGFyYjEgIGxhcmIyIGxhcmIzDQo+
ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBmcmlkYXkueWFuZyA8ZnJpZGF5LnlhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gICAuLi4vbWVkaWF0ZWssc21pLWNv
bW1vbi55YW1sICAgICAgICAgICAgICAgICAgfCAgMiArKw0KPiA+ID4gPiAgIC4uLi9tZW1vcnkt
Y29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbCB8IDIyDQo+ID4gPiANCj4gPiA+ICsr
KysrKysrKysrKysrKysrKysNCj4gPiA+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlv
bnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWVtb3J5LQ0KPiA+ID4gDQo+ID4gPiBjb250cm9sbGVycy9tZWRpYXRl
ayxzbWktY29tbW9uLnlhbWwNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21lbW9yeS0NCj4gPiA+IGNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS0NCj4gPiA+IGNvbW1v
bi55YW1sDQo+ID4gPiA+IGluZGV4IDJmMzZhYzIzNjA0Yy4uNDM5MmQzNDk4NzhjIDEwMDY0NA0K
PiA+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LQ0K
PiA+ID4gDQo+ID4gPiBjb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnlhbWwNCj4gPiA+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS0NCj4gPiA+
IA0KPiA+ID4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi55YW1sDQo+ID4gPiA+IEBA
IC0zOSw2ICszOSw3IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAgICAgICAgICAgIC0gbWVkaWF0
ZWssbXQ4MTg2LXNtaS1jb21tb24NCj4gPiA+ID4gICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgx
ODgtc21pLWNvbW1vbi12ZG8NCj4gPiA+ID4gICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgt
c21pLWNvbW1vbi12cHANCj4gPiA+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1zbWkt
c3ViLWNvbW1vbg0KPiA+ID4gPiAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1zbWktY29t
bW9uDQo+ID4gPiA+ICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LXNtaS1jb21tb24tdmRv
DQo+ID4gPiA+ICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LXNtaS1jb21tb24tdnBwDQo+
ID4gPiA+IEBAIC0xMDcsNiArMTA4LDcgQEAgYWxsT2Y6DQo+ID4gPiA+ICAgICAgICAgICBjb21w
YXRpYmxlOg0KPiA+ID4gPiAgICAgICAgICAgICBjb250YWluczoNCj4gPiA+ID4gICAgICAgICAg
ICAgICBlbnVtOg0KPiA+ID4gPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1zbWkt
c3ViLWNvbW1vbg0KPiA+ID4gPiAgICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtc21p
LXN1Yi1jb21tb24NCj4gPiA+ID4gICAgICAgdGhlbjoNCj4gPiA+ID4gICAgICAgICByZXF1aXJl
ZDoNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZW1vcnktDQo+ID4gPiANCj4gPiA+IGNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlh
bWwNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS0NCj4g
PiA+IGNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS0NCj4gPiA+IGxhcmIueWFtbA0KPiA+ID4gPiBp
bmRleCAyMzgxNjYwYjMyNGMuLjVmMTYyYmIzNjBkYiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS0NCj4gPiA+IA0KPiA+ID4gY29u
dHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbA0KPiA+ID4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LQ0KPiA+ID4gDQo+ID4gPiBjb250cm9sbGVy
cy9tZWRpYXRlayxzbWktbGFyYi55YW1sDQo+ID4gPiA+IEBAIC02OSw2ICs2OSwxNiBAQCBwcm9w
ZXJ0aWVzOg0KPiA+ID4gPiAgICAgICBkZXNjcmlwdGlvbjogdGhlIGhhcmR3YXJlIGlkIG9mIHRo
aXMgbGFyYi4gSXQncyBvbmx5DQo+ID4gPiA+IHJlcXVpcmVkDQo+ID4gPiANCj4gPiA+IHdoZW4g
dGhpcw0KPiA+ID4gPiAgICAgICAgIGhhcmR3YXJlIGlkIGlzIG5vdCBjb25zZWN1dGl2ZSBmcm9t
IGl0cyBNNFUgcG9pbnQgb2YNCj4gPiA+ID4gdmlldy4NCj4gPiA+ID4gICANCj4gPiA+ID4gKyAg
bWVkaWF0ZWssc21pLXN1Yi1jb21tOg0KPiA+ID4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVz
LnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4gPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogYSBw
aGFuZGxlIG9mIHNtaV9zdWJfY29tbW9uIHRoYXQgdGhlIGxhcmIgaXMNCj4gPiA+IA0KPiA+ID4g
bGlua2VkIHRvLg0KPiA+ID4gDQo+ID4gPiBXaHkgZG8geW91IGhhdmUgdG8gc21pIHBoYW5kbGUg
cHJvcGVydGllcyBwZXIgZWFjaCBub2RlPw0KPiA+ID4gDQo+ID4gDQo+ID4gQXMgc2hvd24gaW4g
dGhlIHBpY3R1cmUgZnJvbSB0aGUgY29tbWl0IG1lc3NhZ2UsIHdlIGhhdmUgbXVsdGlwdWxlDQo+
ID4gc21pLQ0KPiA+IHN1Yi1jb21tb24sIGVhY2ggU01JIGxhcmIgbWF5IGxpbmsgdG8gb25lIG9m
IHRoZSBzbWktc3ViLWNvbW1vbi4gU28NCj4gPiB3ZQ0KPiA+IG5lZWQgdGhlICdtZWRpYXRlayxz
bWktc3ViLWNvbW0nIHRvIGRlc2NyaWJlIHdoaWNoIHNtaS1zdWItY29tbW9uDQo+ID4gdGhlDQo+
ID4gbGFyYiBpcyBsaW5rZWQgdG8uDQo+ID4gSW4gbmV4dCB2ZXJzaW9uLCBJIHdpbGwgYWRkIHR3
byBzbWktc3ViLWNvbW1vbiB0byB0aGUgZGlhZ3JhbSBpbg0KPiA+IHRoZQ0KPiA+IGNvbW1pdCBt
ZXNzYWdlLg0KPiA+IA0KPiA+ID4gPiArDQo+ID4gPiA+ICsgIG1lZGlhdGVrLHNtaS1zdWItY29t
bS1pbi1wb3J0aWQ6DQo+ID4gPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVm
aW5pdGlvbnMvdWludDMyDQo+ID4gPiA+ICsgICAgbWluaW11bTogMA0KPiA+ID4gPiArICAgIG1h
eGltdW06IDcNCj4gPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogd2hpY2ggcG9ydCBvZiBzbWlfc3Vi
X2NvbW1vbiB0aGF0IHRoZSBsYXJiIGlzDQo+ID4gPiANCj4gPiA+IGxpbmtlZCB0by4NCj4gPiA+
IA0KPiA+ID4gTWVyZ2UgaXQgaW50byBwaGFuZGxlLg0KPiA+ID4gDQo+ID4gDQo+ID4gSnVzdCBj
b25maXJtLA0KPiA+IERvIHlvdSBtZWFuIG1lcmdlIHRoZXNlIHR3byBpbnRvIG9uZSBwcm9wZXJ0
eSwgbGlrZToNCj4gPiBtZWRpYXRlayxzbWktc3ViLWNvbW0gPSA8JnBoYW5kbGUgcG9ydC1pZD47
DQo+ID4gDQo+ID4gPiA+ICsNCj4gPiA+ID4gICByZXF1aXJlZDoNCj4gPiA+ID4gICAgIC0gY29t
cGF0aWJsZQ0KPiA+ID4gPiAgICAgLSByZWcNCj4gPiA+ID4gQEAgLTEyNSw2ICsxMzUsMTggQEAg
YWxsT2Y6DQo+ID4gPiA+ICAgICAgICAgcmVxdWlyZWQ6DQo+ID4gPiA+ICAgICAgICAgICAtIG1l
ZGlhdGVrLGxhcmItaWQNCj4gPiA+ID4gICANCj4gPiA+ID4gKyAgLSBpZjoNCj4gPiA+ID4gKyAg
ICAgIHByb3BlcnRpZXM6DQo+ID4gPiA+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gPiA+ICsg
ICAgICAgICAgY29udGFpbnM6DQo+ID4gPiA+ICsgICAgICAgICAgICBlbnVtOg0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1zbWktbGFyYg0KPiA+ID4gPiArDQo+ID4g
PiA+ICsgICAgdGhlbjoNCj4gPiA+ID4gKyAgICAgIHJlcXVpcmVkOg0KPiA+ID4gPiArICAgICAg
ICAtIG1lZGlhdGVrLHNtaS1zdWItY29tbQ0KPiA+ID4gPiArICAgICAgICAtIG1lZGlhdGVrLHNt
aS1zdWItY29tbS1pbi1wb3J0aWQNCj4gPiA+ID4gKw0KPiA+ID4gDQo+ID4gPiBhbmQgYWRkIGl0
IHRvIHRoZSBleGFtcGxlIChzaW5jZSB5b3UgY2xhaW0gaXQgaXMgdmFsaWQgZm9yIGV2ZXJ5DQo+
ID4gPiBkZXZpY2UpLg0KPiA+ID4gDQo+IA0KPiBJdCdzIHZhbGlkIG9ubHkgZm9yIHRoZSBMb2Nh
bCBBcmJpdGVycyB0aGF0IGhhdmUgYSBzdWItY29tbW9uIHBvcnQsDQo+IHdoaWNoIGFueXdheQ0K
PiBhcmUgb25seSB0aGUgb25lcyB0aGF0IGFyZSB1c2VkIGJ5IENBTVNZUyBpZiBJJ20gbm90IHdy
b25nLi4uLg0KPiANCj4gUmVnYXJkbGVzcyBvZiB0aGF0LCBub3QgYWxsIG9mIHRoZSBtdDgxODgt
c21pLWxhcmIgKnJlcXVpcmUqIHNtaS1zdWItDQo+IGNvbW0uDQo+IA0KPiBCZXNpZGVzLCBpZiB0
aGUgbGFyYiBpcyBhbnl3YXkgYWxyZWFkeSBsaW5rZWQgdG8gYSBzdWItY29tbW9uLCBjYW4ndA0K
PiB3ZSBqdXN0IGdyYWINCj4gdGhhdCBmcm9tIHdhbGtpbmcgYmFjaz8NCj4gT3IgaXMgdGhpcyBw
cm9wZXJ0eSdzIHB1cnBvc2UgdG8gYWN0dWFsbHkgYWRkIGEgbGluayB0byBhIHN1Yi1jb21tb24/
DQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+ID4gDQo+ID4gT0ssIEkgd2lsbCBhZGQg
dGhpcyB0byB0aGUgZXhhbXBsZS4NCj4gPiANCj4gPiA+IEJlc3QgcmVnYXJkcywNCj4gPiA+IEty
enlzenRvZg0KPiA+ID4gDQo+IA0KDQpOb3Qgb25seSBjYW1lcmFzeXMgaGFzIHNtaS1zdWItY29t
bW9uLCBvdGhlciBzdWJzeXMgYWxzbyBoYXMgc21pLXN1Yi0NCmNvbW1vbi4gQW5kIHRoaXMgcHJv
cGVydHkncyBwdXJwb3NlIGlzIHRvIGFkZCBhIGxpbmsgdG8gYSBzdWItY29tbW9uLA0KdGhpcyBp
cyByaWdodC4NCldlIHdpbGwgcmVtb3ZlICdtZWRpYXRlayxzbWktc3ViLWNvbW0nLCBqdXN0IHVz
ZSAnbWVkaWF0ZWssc21pJy4NCk1lcmdlICdtZWRpYXRlayxzbWktc3ViLWNvbW0taW4tcG9ydGlk
JyBpbnRvICdtZWRpYXRlayxzbWknLCBTTUkNCmRyaXZlciBzaG91bGQgYmUgY2hhbmdlZCB0byBh
ZGFwdCB0aGlzLiBJcyB0aGlzIG9rIGZvciB5b3U/DQoNCj4gDQo=

