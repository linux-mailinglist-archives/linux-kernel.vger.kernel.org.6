Return-Path: <linux-kernel+bounces-525680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 234FFA3F31A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B4216E56E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1CA208993;
	Fri, 21 Feb 2025 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gWfjwFT0";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aJDolsWW"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFE1FCFCC;
	Fri, 21 Feb 2025 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137975; cv=fail; b=Qxqinr4O7827A726/C4dBr0xC/MwJWTs4EdnvisR2sYm0LqU1SgZCqEj4lS3OxQsUUdApqaGvNh+hbre09DAb9bFLsQmLpKXDwASrW2kncZ5PsXumEGJ4Gjb5DuSuPdxFtwr3B439tWXqIKAIbAgFw5Z7hKC4/oDE3q49l1Sors=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137975; c=relaxed/simple;
	bh=k4ymkFCc8zjEFd7HCUvTlu03WZRil6PyJYkBGFXMbOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MDgd8+s/AfVljkXyXBwyvlBfFNjIuRooGvDZUO6xYmB/9o8agAOeDzJN1C8k6g5DEb6OK2GQ8D7sNywrgPcHTES86wtwHHDkli91ncvWw+eRORxo4m3mYpISbjibyesdMH1lSK1EGMMswg1CHFtntG6ywRPIq0seRyp0mjkPdr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gWfjwFT0; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=aJDolsWW; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 81bd45b0f04811efaae1fd9735fae912-20250221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=k4ymkFCc8zjEFd7HCUvTlu03WZRil6PyJYkBGFXMbOo=;
	b=gWfjwFT0aolgBsdJ76mH8lE4jl7PMn++uvGrwhd1rK6z9hXT4h6wjUNejlhmyjmjA0EOXZEgi1hZxis/yqyJ+KHDg4sWN5SqJIUD0Xg3cvdJjoS7sra96H1zf2aw2neThyI/ON8TWgETOhaH6k6cDl04F4oADixvMcJ/vXnMI8c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:6f77ab7e-0754-4d1f-8c2d-218ce56da3a5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:2d6c65a4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 81bd45b0f04811efaae1fd9735fae912-20250221
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 813074498; Fri, 21 Feb 2025 19:39:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 21 Feb 2025 19:39:26 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 21 Feb 2025 19:39:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/w6saG5ux2/9yqpOHReS443byezWalNHG9A6m04SyK6dFh8vPnyeKyRYqezd7YZy31iWSsJwvnW8MtJr+OJUvOQF+DFiyiDWWdK+ibyQGb9jZrgPNwbJB9rPfuBkP+JHmWDIHmcURdPaaygL1lgYz+DW55pKZuqGMjKlk+VheNq77GCqpi0rltOt/nRn66sk18I2J4ncalsJxdJUhJfJrxNjZMZiV4AS6xU77F0tx9OmcVF8JXSnRBETx8OrZ/OsRInR/pdXEDbivFCo02riyxZDHDFIgKSuBPUXoykg5bqAhpUEWtsDo75ieQbePBWxxrZEMMgxbg9+szP0xXjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4ymkFCc8zjEFd7HCUvTlu03WZRil6PyJYkBGFXMbOo=;
 b=YIRiSMiOVHq8DTzhMAn9+HhEa8K7OFoVxG1jkWeOuS5OTxflj788nzYt4ob7q0QG2SH0MaqhkkeQmVprh65uqmfD8Vfgot5C7LiRF8zmR9z887qW6GEXtEpaBVXkriTcRpWwOHRNAB0PY9alDurLWKqzTFYX6yCXj/UEgw+/qgbjmnUqAazGZ6q+Un7iOLiKM2Acq2hB59saHF5hvyruBHe6AQ+ayPOeLsCnxfm2qLjs3rzYOzCg5nHbK4nRdAhk/mZYAvbzJfMlggNq2Sv/TvCXtdPlSRpaQUVDnQy6kPYrZA09neC+Mkr43foABdSYiNrZ4Z5zWQ3ggC1MaR7Mkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4ymkFCc8zjEFd7HCUvTlu03WZRil6PyJYkBGFXMbOo=;
 b=aJDolsWWfBhNYntxO7EjRyPxu5tjJ9dG3bYWVhdjElPZNAiuOoD2eYjGFPhshdVjb8BHHfJIcP/2W7URjhqstI7i79eqAVX1I0krs83vdUbG8V8kmsQvHtN07Hn+2Ymayh20g+jU8Aqk7IifRG57b6AAMvJu59jhNnJ/flUlSbg=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEZPR03MB7299.apcprd03.prod.outlook.com (2603:1096:101:12d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 11:39:11 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 11:39:10 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"cy_huang@richtek.com" <cy_huang@richtek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
CC: "fparent@baylibre.com" <fparent@baylibre.com>,
	=?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "macpaul@gmail.com"
	<macpaul@gmail.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
	<pablo.sun@mediatek.com>, "simon.sun@yunjingtech.com"
	<simon.sun@yunjingtech.com>, =?utf-8?B?WW93LXNoaW4gTGlvdSAo5YqJ56WQ54KYKQ==?=
	<yow-shin.liou@mediatek.com>,
	=?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
Thread-Topic: [PATCH v4 1/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
Thread-Index: AQHbg6SNhfGWmd7O1kKNZUdizLZ2K7NQWWMAgAFJxIA=
Date: Fri, 21 Feb 2025 11:39:09 +0000
Message-ID: <f09f880b7f9b642140109f17ed3f89aa44195b99.camel@mediatek.com>
References: <20250220143354.2532448-1-macpaul.lin@mediatek.com>
	 <cb392432-e452-4460-ace6-54b3649aed52@collabora.com>
In-Reply-To: <cb392432-e452-4460-ace6-54b3649aed52@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEZPR03MB7299:EE_
x-ms-office365-filtering-correlation-id: 5ad93e32-e59a-4b83-9bd8-08dd526c5b60
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RzQ5bXFvL3lsUjk0RFZxQXIwL2NlbitSeHkrUjBBaUlJMkJsSERFcVhXTFNi?=
 =?utf-8?B?ajRPNEdYOXdSdzM1RllYdDN2Q05jbWU4a3pGM1hBcjFRSFkrajRURTE4V1JI?=
 =?utf-8?B?SjVzQXZsNmNldzFIMExwMEU0Z1VoeUdmem5pUkhGUmo5eU5kMjFYbDEyMCs0?=
 =?utf-8?B?eFUrdDZnbGRXU21PU2lNdmZkV1lEUEZBdlpWRkkrSHR6QW5WMUlzUGhleFI2?=
 =?utf-8?B?clVnWmZzamU4blVqbTlBRjE3T05iY1RER1ptQmQyTnd0emF6NURKbThObDRI?=
 =?utf-8?B?OHF5Q1YybjJtWmw1VWJYZTNnSkhSZytqRnVRa25XdGVraVJCUUZMZ3RWQWo0?=
 =?utf-8?B?TVI0SXdzTlZ5L3hSZHVBZnFaNkJES1MraWhHVkFlSFBvbHhaRHI2Qk5hRFVJ?=
 =?utf-8?B?L0dyc1RmbkMrQjJyZEtEd00wa2NuQ2FOSzZkS1ArQU1NemRtU3lMRmdmeldK?=
 =?utf-8?B?YXpwSURJV0szUEZ4VlVzNGhoNlM0a0tuMHNQeE42ZkxkWmFlRHN3TG5xdzd5?=
 =?utf-8?B?RGZWd2VxQzJ6VHcrK1k2Nm1qaXJVODkwYW51WHBJa3hSbnpqUkpnamVjS3dV?=
 =?utf-8?B?eGorcWNVbzhOTVVpS3dQTjVrTFRZSFhJeVJ5K2hWL0NsZWhWZmZTRlhGYStk?=
 =?utf-8?B?bjMwUk5CVi9mZFh1K01ib1VNbDBIa2tBUWN3a21kamI5R0s5UTU3U3dRUzN6?=
 =?utf-8?B?eXJwN290TStObm9adGFqQnRwYUF1LzlVMW0zbG1pSE9rNW9YZm1PZDIvS2hl?=
 =?utf-8?B?L2xFelFGVnBsbjlRckhEOXBrdUdQSWRiNlNHczVER3JoTTZvR2RHc1RibkdH?=
 =?utf-8?B?djhGR2czbTNDSWJaa0lqbXdNa0hyZ21kaHNlb1lieEQ1VW93bnNDWHNDNjVK?=
 =?utf-8?B?RkFRMDNBMURFTXI1aHphdW1neUVWdlY5YjJwWTFTMldSSjdScGU5MFVncEFH?=
 =?utf-8?B?SmVORXo3c1BYRjhDWXhaVGozQlFLQzlyWDlsMGM1OEdYZWJhekk4TVFuSDJC?=
 =?utf-8?B?b3pOVU9RYTRKRllOUmEyR1pXV05kTC9DOUlpRjFSZmVTY0hROVVnQmhMT0M4?=
 =?utf-8?B?M0crM21NS3B3TTZuNG9pVkJhOUg1ZjB4bHpvYVJWWEdEekpvSjZpcGdvVHBV?=
 =?utf-8?B?K2RMaEZvQjEwRWYwcnBzT3JEQ3RJVjJSalVpM1hyT3FGT1U3S29MVlhHYmQ4?=
 =?utf-8?B?NysvNUVYZ3M3RW93N0VHeDVkMU9FZW9MSEVSVWdjdjAyQTBLQjdkMEpDU2Qz?=
 =?utf-8?B?K3hLaUg1Tm1mamFtS3lWRGlMUDRZZlo4NkpabnRLOEdVaUpCSk1PL3RmcDdl?=
 =?utf-8?B?SzVNU2FPUGJzVjhqODN4Z3AyV1lHRmxSKzgrV1AydHZianVhSmh6bGtZeDJH?=
 =?utf-8?B?VHNoQk93Tmtpd1BJYlUwa2wyMnZVc1dqT0hydVVTT0FqSmgreVkxNXNOTkV5?=
 =?utf-8?B?QldSY20wMS8yTENCazk5WU5BVXhPdDZYbEp6TnRvdmRValRLcW4ycy9qekRF?=
 =?utf-8?B?U3B1MGxZSytLZU5PY1dzVkdHV2FrdEdDMlN1Z2tybHFQYis4UitEeGh4S3lB?=
 =?utf-8?B?N2RSOHZCV3lLUUdXdG9LL3MxVFdXUU45V2FXeW9YUEhFUFhGNGo5Rm9SWURy?=
 =?utf-8?B?OXNiQ1M3Z3B4RUk0M1BQUy9lNzJ1WUE0b3VhWWFnN2taaTc1TDJHZ1d3VTQw?=
 =?utf-8?B?MS9HcjBVdHhsZHdIVThVcTlRakhWbWYzcy80RDRxdGo4N1grQXZEZDF3L0Qz?=
 =?utf-8?B?QkxXalZLdGk5bThwdnM3NlFnMTVLNWRpK21VMnpRZk5xc29IN0l4cnJmNTlC?=
 =?utf-8?B?dG54eFd0TVZxNmdjWVErS0JhdkxOY1orclFnWGswS04vZEhTd0JLUUZ0ZGFP?=
 =?utf-8?B?VXZIaXVRU1B2eGNjbGExMVA0c1hLbmlpZ1docENlQm9SSjRYMFE4NGlhZ3Z5?=
 =?utf-8?B?R2JZWGlaYm10dUtBYU9IWmlzQ1B2QVNzMVhPeEQzWFpwS2o3NVV0RFV4dDJj?=
 =?utf-8?B?bTh3M1BRUnNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7810.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0FqMWxlWnFWSFRvN01PUmtsMWpCUWlHZm53RXlsYmlNb3pCc3RmT1UrV1h3?=
 =?utf-8?B?cmlvTUphNGtKSXRHLzI2amNzd1lVYXRVNGo1dy9pMDRmaE5tbisrSWRHV2Mz?=
 =?utf-8?B?cDUxVUJCM1ZKVnJKQkthMVdoMTlVUEExREtRRGxqd3VJRy9qbVVLY1VzMVQ2?=
 =?utf-8?B?eDl4RW01TVR1N1JpK1NMUyszWmFLYlQvUUJUV0pmb2Y4ZG1lUzRZRjJWVHdx?=
 =?utf-8?B?a2lXYmxXRGZ3eUkvd0RoUTkvRkt1MndlTXJqVmNrNTFoSHhJcXRCSFJQZ3B2?=
 =?utf-8?B?MXlNWVJkblZLQUZ3NHl6dU9zNUVuWk51NHJlNTgzTUVtWUFDN01Hd2xQYTVQ?=
 =?utf-8?B?SGZlL2VKK2NMcjRBUXJ4cEJaQjhVL09BdmJoM1ptelpxcTR4T0R3MzdabzlE?=
 =?utf-8?B?ZVpRV2krYmo2M3FxcmY4bHhBUHgzU0V6aFQ3VEpJazlHcnA1QXprYyt4Y3A3?=
 =?utf-8?B?VVp2cG84OEFLSTZKbG5teGcvUUl2WnI2VVdKSDdUMGZ2N3h6WlBKemUzTVlr?=
 =?utf-8?B?SzlVU0VQNlpQUE9GVXVUanQzdlpjcFRKbHBUd3BLdkpjM3lNc3dvalViVkpM?=
 =?utf-8?B?a0JvcytVd3FzcU16S1d5SENxaGtTbTFQMjB5Z1ZWQTlOaHR2VFlNb3dGQkVl?=
 =?utf-8?B?WEZhTU9MdUx1NU1YNnhWTnA1K09PbFkrcS9QTFJhWWlORmR6dTUrOEdObFRB?=
 =?utf-8?B?T0hQQ2ppai80RDN4R0JaU2Z5Z1pETW03M3V2ZXExK2kwRTdnYWhBNWdiTlg3?=
 =?utf-8?B?RDFoc1lwVDRnVk95bGNPcSswR2tsVkVHRFNMNlJSdU9QSUpvZURtUG5oaUxk?=
 =?utf-8?B?SDJvS2NCZFVMQmxzRFVBU3FYdlRoWStMVmpVbzRDK1p2aCtpTS84TFIwZTkr?=
 =?utf-8?B?QksrK2xCL0JUS0ZvQXFoekRWa2IycG40THEwY1BYbVlmbU13Nk1XWG9OcDli?=
 =?utf-8?B?cU1qdXIzNGFLNkc5aTkzV1NGamk4bXJ1cm5wa3EwdFY0dlhwd21PaFB4cW5o?=
 =?utf-8?B?bnVQZitaREc0bm1nZEMvNGpDK3hOZk1zdDNjbnM3TkJzVzRIMlRqeTZkL0N5?=
 =?utf-8?B?U3RYekw1aXVYWjRocUJZRjhxWkJIZkVYOWk4Z2tYYkZpcERUdG5EZEpGRHJH?=
 =?utf-8?B?bGRhZnlTQzA0Lzlnc2duUTFqR2Z3M0pJSW9MUkpnanZvVjU0TXVJYUFFekR1?=
 =?utf-8?B?YUFlcWNnWTJOYk1GbnRjblFyTnlCYWM2aERjNmNaUnFRbDU3ZlJoMVBzMkZI?=
 =?utf-8?B?ejZiT3ZEZkkyU0ZOaXp2b1dWNTRlTW43MDZ2TEdiU1FVWlZwVjJ4cHIxQWND?=
 =?utf-8?B?Ynpsd2hubzVpcHVWa0RoU0d2ME9xZnowa1RWWU11UGNzM3EwR3FlVU5PRWd4?=
 =?utf-8?B?elh3NjRhd3JvaVZMTHJRdGZkNTlXbkd3d2xEVFNtU2FLY1RLYkh2V2psTzFZ?=
 =?utf-8?B?aFMzMGx5NzVwSEFudzUxMmo3R01LRDlGOGlxOXFjL3BnMElGeCtkMG51TWht?=
 =?utf-8?B?a253Z2ZDRngxeWxSUGpxVWw4WFdNL0tYUzF0Z2xJY29FdkYwNjBCL0Y5T1Bl?=
 =?utf-8?B?cVgxZzdFVFk3VXdlNVNWdytxYWNKNmFYMGgzRGJFaDh3WWg1aStLOGpORnla?=
 =?utf-8?B?VUtnSmlzRWl3RXFJZXRvM3ZSTkcwS0JKeXVmL0VkRzJnNXkrUFIvWCszWkpx?=
 =?utf-8?B?Z1hrZStOTWxYbUZCOU9zVFVWOG1QZXBPK3pRSVN1WHlhbzJ2NzZtaDdXeDdE?=
 =?utf-8?B?anlZNUJ3MmxrZnhCMGJIUU51VGNuZ244a1IyN21XVzBXUXY0aVJ6K2Rpd1Zx?=
 =?utf-8?B?blp4WDI1RWVwREVPNHBxRzkzSWFTTUIrMTJod2E0Uk1adGxtWXBXTmFwckQw?=
 =?utf-8?B?QVJPUG1QT0xTTDc2ZDJCTko1RzNMWS9tR0JMVzB6VXhGVHQzZm5nbWR2bTRj?=
 =?utf-8?B?Zk4vbFdsRm05N2RmMms3Yk9EeEZnMXBxdmJsVEZyZHZnWUtoU2JLbzZxcnJV?=
 =?utf-8?B?R3lXcFFsZDQ2MlA2Vk1lS2l3dG5FN1RCV1V2M0xZd0xCVS82MGxrN3hNTEky?=
 =?utf-8?B?aXdubXZYRXBydzRVNVNFMUo2RXpUTGk5RnNUcGdVdVlKWTd4b2Y3R3RPQ2tn?=
 =?utf-8?B?RmluVmFZNm96OWt2ZENNUk0wQVJkQk9IM3BjdllFYWNIU2RNY2IyVFZWVU8w?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07109190CBB17D458CD142E562AA9964@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad93e32-e59a-4b83-9bd8-08dd526c5b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 11:39:09.9231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDHnohoAcLtUn8m6s3H8XBQdNsb7+QYsJ3fLm/CVtnFE0I9oXQNAtAZQNXWH1ZbfCSy80FWby+bjk4KkBM9VRHM4OFdCuvru/Ev1OC+YX3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7299

T24gVGh1LCAyMDI1LTAyLTIwIGF0IDE2OjU4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToKPiAKPiAKCltzbmlwXQoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dGNwYyB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10NjM2MC10Y3BjIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVycnVwdHMtZXh0ZW5kZWQgPSA8JnBpbyAxNwo+ID4g
SVJRX1RZUEVfTEVWRUxfTE9XPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGludGVycnVwdC1uYW1lcyA9ICJQRF9JUlFCIjsKPiA+ICsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbm5lY3RvciB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0
aWJsZSA9ICJ1c2ItYy1jb25uZWN0b3IiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxhYmVsID0gIlVTQi1DIjsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRh
LXJvbGUgPSAiZHVhbCI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgb3Atc2luay1taWNyb3dhdHQgPSA8MTAwMDAwMDA+Owo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHBvd2VyLXJvbGUgPSAiZHVhbCI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJ5LXBvd2VyLXJvbGUgPSAic2luayI7Cj4gCj4g
V291bGQgYmUgYXBwcmVjaWF0ZWQgaWYgeW91IGNvdWxkIGFsc28gY29tcGxldGUgdGhlIG5vZGUg
YnkgYWRkaW5nCj4gdGhlIHBkLXJldmlzaW9uCj4gcHJvcGVydHksIGVuYWJsaW5nIGZ1bGwgVVNC
QyBQb3dlciBEZWxpdmVyeSBmb3IgdGhlIE1UNjM2MCBQTUlDLgo+IAoKV2VsbCwgSSBoYXZlIG5v
IGlkZWEgYWJvdXQgdGhlIHBkLXJldmlzaW9uIG9mIE1UNjM2MC4KSSBjb3VsZCBmb3VuZCBNVDYz
NjAgc3VwcG9ydHMgUEQgMy4wIGFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0LApob3dldmVyLCBJ
IGhhdmUgbm8gaWRlYSBhYm91dCB0aGUgb3RoZXIgZmllbGRzIGxpa2UgbWFqb3IgYW5kIG1pbm9y
CnZhbHVlcy4gRGVhciBDaGlZdWFuLCBjb3VsZCB5b3UgaGVscCB0byBwcm92aWRlIHRoZSB2YWx1
ZSBvZiBwZC0KcmV2aXNpb24/IFRoZSBwcm9wZXJ0eSBoYXMgYmVlbiBkZWZpbmVkIGluIApEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY29ubmVjdG9yL3VzYi1jb25uZWN0b3IueWFt
bC4KCgo+IFNhbWUgZm9yIHRoZSBhbHRlcm5hdGUgbW9kZXMsIGFkZGluZyB0aGUgRFAgYWx0IG1v
ZGUgaXMgYSBtYXR0ZXIgb2YKPiBzZWNvbmRzLi4uIGFuZAo+IHdlbGwsIGl0IGRvZXMgc291bmQg
YSBiaXQgd2VpcmQgdG8gYWRkIGFsdGVybmF0ZSBtb2RlcyB3aXRob3V0IGEKPiBtdXguLi4gc28s
IGluIHRoaXMKPiBjYXNlIHlvdSBjYW4gY2hvb3NlIGVpdGhlciB0bzoKPiDCoCAtIFNxdWFzaCB0
aGUgdHdvIGNvbW1pdHMgKHRjcGMsIGl0NTIwNSkgYW5kIGRvIGV2ZXJ5dGhpbmcgaW4gb25lOwo+
IG9yCj4gwqAgLSBBZGQgdGhlIGFsdGVybmF0ZSBtb2RlIG5vZGUgdG8gdGhlIGNvbm5lY3RvciBp
biB0aGUgY29tbWl0Cj4gaW50cm9kdWNpbmcgdGhlIG11eC4KPiAKPiBFaXRoZXIgb2YgdGhlIHR3
byBvcHRpb25zIGlzIG9rYXkgZm9yIG1lLCBzbyB5b3UgY2hvb3NlLgo+ID4gCgpXZWxsLCBJIGNv
dWxkIHNxdWFzaCB0aGUgdHdvIGNvbW1pdHMgdG9nZXRoZXIgYW5kIGFkZGluZyB0aGUgRFAgYWx0
Cm1vZGUgdmFsdWVzIGluIG5leHQgdmVyc2lvbi4KCj4gPiAKPiA+IMKgICZzc3VzYjAgewo+ID4g
K8KgwqDCoMKgIGRyX21vZGUgPSAib3RnIjsKPiA+ICvCoMKgwqDCoCBwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOwo+ID4gK8KgwqDCoMKgIHBpbmN0cmwtMCA9IDwmdTNfcDBfdmJ1cz47Cj4gPiAr
wqDCoMKgwqAgcm9sZS1zd2l0Y2gtZGVmYXVsdC1tb2RlID0gInBlcmlwaGVyYWwiOwo+IAo+IFRo
ZXJlJ3Mgbm8gbmVlZCBmb3IgYSBkZWZhdWx0IG1vZGUgaGVyZSwgbHVja2lseSB0aGUgTWVkaWFU
ZWsgTVRVMwo+IGNvbnRyb2xsZXJzCj4gZG9uJ3QgbmVlZCB0aGF0IGZvciByZWFsIDotKQoKT2th
eSwgd2lsbCBkcm9wIGl0IHRoYW4uCgoKVGhhbmtzLgpNYWNwYXVsIExpbgoKPiBEcm9wIHBsZWFz
ZS4KPiAKPiBDaGVlcnMsCj4gQW5nZWxvCj4gCj4gCgo=

