Return-Path: <linux-kernel+bounces-381375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82789AFE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783502887A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC11D86FF;
	Fri, 25 Oct 2024 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nTwPXFOK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hy0bUmL1"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10D1D3633;
	Fri, 25 Oct 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848791; cv=fail; b=DFb7QI3FKI82Cba7jwzezz49DTjZunouBy4Hk8qp6vShXaxSH6vXKSAWT66L3HxUhzRS4mVtqkso7EXbign9C5auN07ZWob/U8SHCAUI858zjR8uxyp9Hc9kor5dVE1tvogutRjEGg/FAiiWwPkS9Tn16l0hZqOlOmfUDpBZtao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848791; c=relaxed/simple;
	bh=P2s2oUxvGAfXeu8M5cQ4JlD7LqKsmIgZgKYzvsH3NnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i2PZauAeE75X/7cydHea7KTH1lufXnP9i9snuUacu3G1YHW99RSI5+gxG8ZZfPMkqtzJelqyZhAxHdOlFHSgpTNHp1CA0lS4olSBOrapValSjnVhyg9sZuF4Kure4ihOD0TC3lCHhAGD+CmsRzNY1hiEyiInSGEpyJiPVuzcagY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nTwPXFOK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hy0bUmL1; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1fec5aca92b411efbd192953cf12861f-20241025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=P2s2oUxvGAfXeu8M5cQ4JlD7LqKsmIgZgKYzvsH3NnQ=;
	b=nTwPXFOKLy99fdVj9w7k+6O4AOWIgHxAqAi5tx2xMU8BFZsWW4RYcxCmEoQRnc/UzQO/dQ4OX4d8r0N+N6oKJ7jqVmVnjZCCfIwUSNuTPRozn8B659ktbr5/NqT8OHbKsIR+WGwWd58zs/CAAqclye+6H//1l/qkgYvxSFyHzHU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:3f509604-2380-4edd-9801-962567571522,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:85c9d341-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1fec5aca92b411efbd192953cf12861f-20241025
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 31342667; Fri, 25 Oct 2024 17:32:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Oct 2024 17:32:58 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Oct 2024 17:32:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWXdD7BB1qdB+vDCXP+W3aWZS5nXS7oER/jZAwm4csx3dM4If/z3z0/BDTryKaQ90mfZ6zz1ZJOfaLU0MnMqdFObkU/mdcWQGYFvGZhlmG2aGeRm3PmeAU0DJvJqF+oMG9Mwpy5knW9XGvI6KJNhPB5LhWmZhOdXCnRYoymR2Y3MCIAsxGLEioniCOb3i7H+X55YF84V9Y5cB7yrqiJBaItrvIOQL2l2d1pgvD9DYf6S+uz/dJ3ND6827SVohtL+6LyvVoJufmQiazJKnPQKEbFO8Da/rvx89W5MiUj4kDw7akLkoRKHsrr1zFCNXln77JC2Czu6JJCex1oSZ4eUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2s2oUxvGAfXeu8M5cQ4JlD7LqKsmIgZgKYzvsH3NnQ=;
 b=oa1WcI5V2/1noAu29fF8MqcR5wKbzkJfZIWXuc2i8nh71yt93IJ8F+5ZyF7zTjMlwNlU+dpaYu4V4Um/kt3vd6d1nYuPf2/VeTbNAiNchK/y6RWwtTcRC8dCGhyT7T3YS0MKKgthifoUQn2VpD0CDrZDZPmuiVFB6N97h5r6pQf6aTtw24GYwFe3236MVECSXePbhP4eSSl4nXNZGSkD9hip5Wk0H0z3vonGzoItHnFRvFU7FdtSxVidOwJnl87Ly9nkNd7NPMGYsV9sV7vBo62XIgRNOGpyCbH0n7k3y4yvnzflYVPQuoYT7EFZCFUy5y7jGv80tB24aQQqWLfn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2s2oUxvGAfXeu8M5cQ4JlD7LqKsmIgZgKYzvsH3NnQ=;
 b=hy0bUmL1XXINcnVec3tI/u4lbdeOyb7J4WLiJxYNYBEjToxncwy1ddnrXT4V82V19ZukcbkVMZVFY9ci+sryIcbmyhRaT6NzrfS/VrZrYpUt4PQeikZEJwCn73+l7UT/vZCPawWzPz4+D9zZdrpJkPvGDKbFWHnhLwr/7dcpN7c=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by KL1PR03MB8217.apcprd03.prod.outlook.com (2603:1096:820:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 09:32:56 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:32:55 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
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
Thread-Index: AQHa86RRlzYUg5Gi9UG44pqPb7iOI7IxaJMAgGQYZgCAAFaLgIABwwIA
Date: Fri, 25 Oct 2024 09:32:55 +0000
Message-ID: <f4704e02bae626497b75f03eb05cde4bf482caf3.camel@mediatek.com>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
	 <20240821082845.11792-3-friday.yang@mediatek.com>
	 <3b31bf46-c5c0-41c9-bb4d-3ba9f64a5d1c@kernel.org>
	 <7ca196cf1c1f57426fc6b733d01d38f073da7d94.camel@mediatek.com>
	 <b4055440-d5a5-4d42-9cb7-9fc2f39a2148@kernel.org>
In-Reply-To: <b4055440-d5a5-4d42-9cb7-9fc2f39a2148@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|KL1PR03MB8217:EE_
x-ms-office365-filtering-correlation-id: 19f9d655-718b-4958-2c72-08dcf4d8018e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VVI5aUplOWRtc2c0NzU4Z1Jkcms2Q004ZXpnSkxTWk1jY1ZaYkhNaHpzSFVq?=
 =?utf-8?B?dUZTYkRXZEgwbEF3Qm5DNDBHaTZpazZBV3hQSHB6amRZd0c0ckhzT3NhZ21E?=
 =?utf-8?B?SkhSbVQzSWl5UXhQYnk4L1ZGTVlqMTVIb1pSS1k4MXhucFM0cmFWUUExQTgx?=
 =?utf-8?B?eitueWtPUXE2VkJGQkZaUXBpK1NxVk5YdTRPL3BMcC9jbTc0OWZpZXIwZGRk?=
 =?utf-8?B?RkZnd2ZwWDYrRFQwMXFPZlNEMHVVTXg4d0xMSVFYcm9MdWUzYi9KdXBKZzVP?=
 =?utf-8?B?T3AyNkUwTm1pRmJXU1pxTmhraXVZRllkdlFlOU5ONFk1eThjVU9QdVZMeTJo?=
 =?utf-8?B?UEN1RjYxeVFVNFkzc3hRMlRTL2Zoek9FWHFHbTZ4RnZIbUZId05Ia0Rraitx?=
 =?utf-8?B?aytiUmw3MGErMGpSMXcwK0Zha1N4elJWbHc4d2tIMHpKNk41cmh2L0dROXpv?=
 =?utf-8?B?NUt4aUsrQ0Z1OTNJRGVXMnh0UnV2Q1hVYktkM1JQWlc4cnF0Z1hhaDBvT1k4?=
 =?utf-8?B?SlUxbnBCN2Q3RVJrWmRIZzBkR0RlaWljTXNHb1d1cER0MWVQRXJnbGdGN3Y3?=
 =?utf-8?B?Wkh4aDQrNlRFc2syNUx1VzlZNVF3eFIvRFpLSUl5WWNwa05kS25NOXlqaTB1?=
 =?utf-8?B?cnpuejA5dlEwdzIwS2d5cnI3TkdZY0pEQ3dXL0xTRjl4MXcrT25sMWoyaTI2?=
 =?utf-8?B?SHhjMmVEbDA3RnphOG5lUGUrZzZUNlYySVJsaTRKRXI4MHBFU3RoZ1dVeUcy?=
 =?utf-8?B?V1hBZlpPUU1aYjVadGJ0dkgxOUpKTUVnZWl0eEFZRm1mUGVzcWNOWDRlZWF2?=
 =?utf-8?B?SytUOGdJWEFib08zUlBuM3ZBT0JDWjkrSW1vZVRSUi9yV0FjbUdMdWhiL3N5?=
 =?utf-8?B?RWdCNWU3RmhvbXBieHZQUkVyekdoWEYrWStlRUlyMDh5VE1EbkdxWXFKQzF4?=
 =?utf-8?B?K3BHWHQxYS9DUHJSRkdYaWdYS2twaC9hc01ITWRkbWkrSWY1UGlZcmoxUS84?=
 =?utf-8?B?OWZoVndZZmZqL3dqWEJOUFFWU3A3eG9MNmg4SUIvdVBSL3c0WEhxd0lxdVdr?=
 =?utf-8?B?WGpySDZKZFVyc2FJVkJ6SzNaV3ZRRmYzNGVZRjJBbkxDOHpaUlNHdVo4VG8z?=
 =?utf-8?B?bjZjVVlPVHB3NUVkWUJieEoxb3BjbE1Wbzk4MGRjS0xOSzh5cTdGLzc2MkVR?=
 =?utf-8?B?SHd3cXZ5K3VUWFQ0ZmZZYmdwTGFDYjBpSHR2YXRnVFlIUHVPWmJNelBYcUhW?=
 =?utf-8?B?dURHbUJNSFZSTFE1WTVVUjhVUXhWZHJJa25TSk9vdnVWVE5UemFaUk9hUmxS?=
 =?utf-8?B?S2c3Ny8xditiWlUwYWd5T2hacmVBWERpNk9WdUdDN2RiZ09vNkptTXZ6N05P?=
 =?utf-8?B?ekNySE81ZHRPZHA5M0xMa05sOVh3MGJsUmE2VEhSajN1VGEyTkdBZDRzMjZ1?=
 =?utf-8?B?NFNoaHpxMlNITDl1UUxKaTJIbHJqcFNlU21KU25MMGdtNWRlTytOc3Y2blRs?=
 =?utf-8?B?NlJ3YTBJWW4rODBOTHdKRTRxNWxQRXBPRGdDUEQ0SlpYajR1Zm9PcmhFdjhT?=
 =?utf-8?B?VktBc090UmpQd3Z1UTg2YmZsNmpiZ2xHNzZPNDRzMjR4cjZod3EyaXFHaU1P?=
 =?utf-8?B?ZDFsOUhybHlZNmhVQXJCWnR5ZWw5bjlkZ1lIZEMzUVFxenJ3STVBUHluZHE4?=
 =?utf-8?B?NkUyQUFPSGU2WnBLVkViTVRYQVpWWG5Ia29uTWpkT3l4UjJIYXllN2d3cUFm?=
 =?utf-8?B?d3lpOWpaTjFkdGlPMWlIUUpiZE92dDhQOWFXOGpMdVJYY2tIbjc5NzVGWFF6?=
 =?utf-8?Q?GEIRP+Tbv2Qpv87owpwGn+kT+b/+glIMYCjjI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3g5REpTZEpHMVFFNmpPdVJYLytKNkRHd1ZIU0gyZmJCNUFya0lIWDE3bzd0?=
 =?utf-8?B?VU9NemdubDZhdklLSWJ2Ukx1cEI2SVVlY3ZhSmlaRVMyVUprOHBMSUVnTUhT?=
 =?utf-8?B?SGE1M0c2V0N4RW1rZEFoUEZqaVlJbWkvcW52MlA3OTB6Si93ZDJaNWFzZEUx?=
 =?utf-8?B?SndPYmFzSGhOY0JYWE0xVlBCYkl4dEs3MU5TMlNqVnQ5SlB0bkVtbHhBU0M1?=
 =?utf-8?B?bXJGYWltdmsyVG9ja3ZuTmRUVEFCdk42RGVKY21rVjA4bGZhT042RmRFanhy?=
 =?utf-8?B?SkVuZzgyMEllUW44djUrYUh3QnN5ZFVlbGYzYmVNdFJ3bThzUm4yTlAyaHpy?=
 =?utf-8?B?Ykt2SHZYMytaa1l1Y1NYL2tvVWJYWDhUNTFXOE1vQmNieGEzdWtnMHg5WjV3?=
 =?utf-8?B?OU1nakpYZjltSW1CTk9HbFJ6NHNzSXAwWGw4clMwQ1lySHpxK3QrUXFCOXEy?=
 =?utf-8?B?SjFWV0V0THl1YjJRK2hoV0o3NWJxU2V4RDFBbzIyTytCY3ozdjF0cll6TUNp?=
 =?utf-8?B?ZXpTUTJVaDh3Um9sNlpaNHNxSTdHWUVnRGhodXhjalVOVmFEVXNEdFQ4cW12?=
 =?utf-8?B?TWpxNTFHNGRUcXQwTzVOcWxpNTNId0ZNOFl2Mm0xTG5wRFVsTkVRNmZTWTJZ?=
 =?utf-8?B?WjJOUjRDb1drUU5wR084K0F4T1pPekpWMWxFeitENE1XbEVwZEUrcHdRSno5?=
 =?utf-8?B?dW9zaVB5ZHNaU05MY0dwOGlJV2VPOGJLVy9WazM0MDlzS2g0MHhBbjFJUVRt?=
 =?utf-8?B?eFFuOUlFSy9yaHEyYWNqRjF3MzRMcElyUHBpN3E3cko2RS90dGxpeWd1YkxM?=
 =?utf-8?B?a1hpLzBlS0ViMGcyV0I3VWtqenZFQWxyM0pkTEcxcDh0Z2hXazZ2OGJZNmJZ?=
 =?utf-8?B?OG5IWWRrcHlKTk8vUUc4QTdrZzNPZHFFTitqUGQ0OFVuNCtqUG5RbFl1YnRP?=
 =?utf-8?B?eHR4WlNPYlRTM3o1ZUp1bG01elFEeFVUUDFPWWxkOVRad0YzTEtNNS8yY25a?=
 =?utf-8?B?emJTTi91Qk50U2NpamNPaXY4eXpFbENEcVlqbEdWR2IzMUVNTGhOSE0yNnZl?=
 =?utf-8?B?WVJvS3FUQXU5eVdDVGk2Q05XaUNuRit1eXMzd3h2d1dxNjVodkNPZ3p3RmlD?=
 =?utf-8?B?V0VTSHo1MkRaYnFFMTlhWDBuTXdtS1hXekRjRThxRUhlM3VsSkgzaGoxNGps?=
 =?utf-8?B?ZW9IemIwVjNnZEQvOTg3RzdZN1A1RktQUk83S1JNUTFFS2hJK1pFbkdlSnpH?=
 =?utf-8?B?V0VMb3RRSmg1UUszcmo4dVJMNHFmdVNvMXRqQUpVNVZNUjZZVVNDZlpCRkU4?=
 =?utf-8?B?allMQlJ2RjEwZDQzcHB6TU9EbGlWMGxKZ0tnckNEc1VTM0dBZDRLWWtuMXR2?=
 =?utf-8?B?K3FhL3hhVEhtcVVMSVRxT1g2WVMxSlY2KzlUWTFWak1vYXNZWXdQaHQ5Vmxj?=
 =?utf-8?B?cDhMMWl4dGlVUHdMVllMcVBETUZUQzR2Z0MwQ1hYMTdxOWR5azV4SnpnY1Qw?=
 =?utf-8?B?NUIyT0NlajZvdTI3MGhaMmJ4Uk91di9ZakpCQkZRSmZ3ZWV0MTlBSC9WTHlj?=
 =?utf-8?B?SXRmQ2RMbVFsUW1vRCtGc1hMNU9OL1dKcEJNbmhITjJnVEIrSllxR0hkeWVw?=
 =?utf-8?B?UE95THpYRGJNTjZOQjBLblRsVTJGY1RvQUZya2JNc21JckxSYVRPQTM1ak5H?=
 =?utf-8?B?dDhVZXVqOUJQUnlSVGZjWXViSXJPcllrME13STRRQlVwUzkwL04xNWJzRkVY?=
 =?utf-8?B?aVlpbURCNUFCNlY2SEVmWE9UdFdGNVRUOHc0RXppWithY2FyNFNZY3h0dFJ1?=
 =?utf-8?B?TEtualBJZ3RkTW5ST2tVWGNrcXpGbm5xb0p4R203Uzg0SEJnK2tJZmhDSWJk?=
 =?utf-8?B?cHA1ek9PWFZuTUQ3V3VNclNQSWlLamxwMEpLdnB2ZUhlemVqVU54QmRCYllz?=
 =?utf-8?B?K25ENXRWcDhVallZU2ZGaEx5UGw0YjhuNHJhOExQdlB1bEpyUjdndGViL0Ro?=
 =?utf-8?B?RWFZVUZHSyswMGRwV2lOV1JrMC81VU1GdDVKdi9HalZJQzlDUk00TE5qeGg2?=
 =?utf-8?B?K0lrWWtIRVR4UVZZd0h3QnMweVRoL29LQ0oyaWU5dU9qZ0FNU0luRjVrN3ly?=
 =?utf-8?B?andpV0tCRzdvZmVKOE81Slp1TThPMDhxcVJYT0o1cEdTL0VWN0lxZ2o4S3F6?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17DACF86D5A1294B91A0420F79AB78E6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f9d655-718b-4958-2c72-08dcf4d8018e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 09:32:55.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovaUiArKn9dCaoQAiSwSGj2YC+KXExNf6syuPlcXLzjAr9xLUl0o5+BC1xos9CfivWYG8JLDtxmC2gz4gmw1dkQdI1OqYPFSu20cN3nRfaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8217

T24gVGh1LCAyMDI0LTEwLTI0IGF0IDA4OjM4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI0LzEwLzIwMjQgMDM6MjgsIEZyaWRheSBZYW5nICjm
najpmLMpIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyNC0wOC0yMSBhdCAxMDo1NSArMDIwMCwgS3J6
eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPj4gICANCj4gPj4gRXh0ZXJuYWwgZW1haWwgOiBQ
bGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gdW50aWwNCj4g
Pj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPj4gIE9u
IDIxLzA4LzIwMjQgMTA6MjYsIGZyaWRheS55YW5nIHdyb3RlOg0KPiA+Pj4gT24gdGhlIE1lZGlh
VGVrIHBsYXRmb3JtLCBzb21lIFNNSSBMQVJCcyBhcmUgZGlyZWN0bHkgbGlua2VkIHRvDQo+IFNN
SQ0KPiA+Pj4gY29tbW9uLiBXaGlsZSBzb21lIFNNSSBMQVJCcyBhcmUgbGlua2VkIHRvIFNNSSBz
dWIgY29tbW9uLCB0aGVuDQo+IFNNSQ0KPiA+Pj4gc3ViIGNvbW1vbiBpcyBsaW5rZWQgdG8gU01J
IGNvbW1vbi4gQWRkICdtZWRpYXRlayxzbWktc3ViLWNvbW0nDQo+IGFuZA0KPiA+Pj4gJ21lZGlh
dGVrLHNtaS1zdWItY29tbS1pbi1wb3J0aWQnIHByb3BlcnRpZXMgaGVyZS4gVGhlIFNNSSByZXNl
dA0KPiA+Pj4gZHJpdmVyIGNvdWxkIHF1ZXJ5IHdoaWNoIHBvcnQgb2YgdGhlIFNNSSBzdWIgY29t
bW9uIHRoZSBjdXJyZW50DQo+ID4+IExBUkINCj4gPj4+IGlzIGxpbmtlZCB0byB0aHJvdWdoIHRo
ZSB0d28gcHJvcGVydGllcy4gVGhlIGhhcmR3YXJlIGJsb2NrDQo+IGRpYWdyYW0NCj4gPj4+IGNv
dWxkIGJlIGRlc2NyaWJlZCBhcyBiZWxvdy4NCj4gPj4+DQo+ID4+PiAgICAgICAgICAgICAgU01J
IENvbW1vbihTbWFydCBNdWx0aW1lZGlhIEludGVyZmFjZSBDb21tb24pDQo+ID4+PiAgICAgICAg
ICAgICAgICAgIHwNCj4gPj4+ICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0NCj4g
Pj4+ICAgICAgICAgIHwgICAgICAgICAgICAgICAgfA0KPiA+Pj4gICAgICAgICAgfCAgICAgICAg
ICAgICAgICB8DQo+ID4+PiAgICAgICAgICB8ICAgICAgICAgICAgICAgIHwNCj4gPj4+ICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgfA0KPiA+Pj4gICAgICAgICAgfCAgICAgICAgICAgICAgICB8
DQo+ID4+PiAgICAgICAgbGFyYjAgICAgICAgU01JIFN1YiBDb21tb24NCj4gPj4+ICAgICAgICAg
ICAgICAgICAgICB8ICAgICAgfCAgICAgfA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgbGFyYjEg
IGxhcmIyIGxhcmIzDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogZnJpZGF5LnlhbmcgPGZy
aWRheS55YW5nQG1lZGlhdGVrLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIC4uLi9tZWRpYXRlayxz
bWktY29tbW9uLnlhbWwgICAgICAgICAgICAgICAgICB8ICAyICsrDQo+ID4+PiAgLi4uL21lbW9y
eS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi55YW1sIHwgMjINCj4gPj4gKysrKysrKysr
KysrKysrKysrKw0KPiA+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPiA+
Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWVtb3J5LQ0KPiA+PiBjb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnlhbWwNCj4gPj4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LQ0KPiBjb250cm9sbGVy
cy9tZWRpYXRlayxzbWktDQo+ID4+IGNvbW1vbi55YW1sDQo+ID4+PiBpbmRleCAyZjM2YWMyMzYw
NGMuLjQzOTJkMzQ5ODc4YyAxMDA2NDQNCj4gPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZW1vcnktDQo+ID4+IGNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21t
b24ueWFtbA0KPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21l
bW9yeS0NCj4gPj4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi55YW1sDQo+ID4+PiBA
QCAtMzksNiArMzksNyBAQCBwcm9wZXJ0aWVzOg0KPiA+Pj4gICAgICAgICAgICAtIG1lZGlhdGVr
LG10ODE4Ni1zbWktY29tbW9uDQo+ID4+PiAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXNt
aS1jb21tb24tdmRvDQo+ID4+PiAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXNtaS1jb21t
b24tdnBwDQo+ID4+PiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXNtaS1zdWItY29tbW9u
DQo+ID4+PiAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLXNtaS1jb21tb24NCj4gPj4+ICAg
ICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtc21pLWNvbW1vbi12ZG8NCj4gPj4+ICAgICAgICAg
ICAgLSBtZWRpYXRlayxtdDgxOTUtc21pLWNvbW1vbi12cHANCj4gPj4+IEBAIC0xMDcsNiArMTA4
LDcgQEAgYWxsT2Y6DQo+ID4+PiAgICAgICAgICBjb21wYXRpYmxlOg0KPiA+Pj4gICAgICAgICAg
ICBjb250YWluczoNCj4gPj4+ICAgICAgICAgICAgICBlbnVtOg0KPiA+Pj4gKyAgICAgICAgICAg
ICAgLSBtZWRpYXRlayxtdDgxODgtc21pLXN1Yi1jb21tb24NCj4gPj4+ICAgICAgICAgICAgICAg
IC0gbWVkaWF0ZWssbXQ4MTk1LXNtaS1zdWItY29tbW9uDQo+ID4+PiAgICAgIHRoZW46DQo+ID4+
PiAgICAgICAgcmVxdWlyZWQ6DQo+ID4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21lbW9yeS0NCj4gPj4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxh
cmIueWFtbA0KPiA+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnkt
DQo+IGNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS0NCj4gPj4gbGFyYi55YW1sDQo+ID4+PiBpbmRl
eCAyMzgxNjYwYjMyNGMuLjVmMTYyYmIzNjBkYiAxMDA2NDQNCj4gPj4+IC0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktDQo+ID4+IGNvbnRyb2xsZXJzL21lZGlh
dGVrLHNtaS1sYXJiLnlhbWwNCj4gPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tZW1vcnktDQo+ID4+IGNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwN
Cj4gPj4+IEBAIC02OSw2ICs2OSwxNiBAQCBwcm9wZXJ0aWVzOg0KPiA+Pj4gICAgICBkZXNjcmlw
dGlvbjogdGhlIGhhcmR3YXJlIGlkIG9mIHRoaXMgbGFyYi4gSXQncyBvbmx5DQo+IHJlcXVpcmVk
DQo+ID4+IHdoZW4gdGhpcw0KPiA+Pj4gICAgICAgIGhhcmR3YXJlIGlkIGlzIG5vdCBjb25zZWN1
dGl2ZSBmcm9tIGl0cyBNNFUgcG9pbnQgb2Ygdmlldy4NCj4gPj4+ICANCj4gPj4+ICsgIG1lZGlh
dGVrLHNtaS1zdWItY29tbToNCj4gPj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+Pj4gKyAgICBkZXNjcmlwdGlvbjogYSBwaGFuZGxlIG9m
IHNtaV9zdWJfY29tbW9uIHRoYXQgdGhlIGxhcmIgaXMNCj4gPj4gbGlua2VkIHRvLg0KPiA+Pg0K
PiA+PiBXaHkgZG8geW91IGhhdmUgdG8gc21pIHBoYW5kbGUgcHJvcGVydGllcyBwZXIgZWFjaCBu
b2RlPw0KPiA+Pg0KPiA+IA0KPiA+IEFzIHNob3duIGluIHRoZSBwaWN0dXJlIGZyb20gdGhlIGNv
bW1pdCBtZXNzYWdlLCB3ZSBoYXZlIG11bHRpcHVsZQ0KPiBzbWktDQo+ID4gc3ViLWNvbW1vbiwg
ZWFjaCBTTUkgbGFyYiBtYXkgbGluayB0byBvbmUgb2YgdGhlIHNtaS1zdWItY29tbW9uLiBTbw0K
PiB3ZQ0KPiA+IG5lZWQgdGhlICdtZWRpYXRlayxzbWktc3ViLWNvbW0nIHRvIGRlc2NyaWJlIHdo
aWNoIHNtaS1zdWItY29tbW9uDQo+IHRoZQ0KPiA+IGxhcmIgaXMgbGlua2VkIHRvLg0KPiA+IElu
IG5leHQgdmVyc2lvbiwgSSB3aWxsIGFkZCB0d28gc21pLXN1Yi1jb21tb24gdG8gdGhlIGRpYWdy
YW0gaW4NCj4gdGhlDQo+ID4gY29tbWl0IG1lc3NhZ2UuDQo+IA0KPiBZb3UgcmVzcG9uZCB0d28g
bW9udGhzIGFmdGVyLi4uIFRoYXQgZW1haWwgY29udmVyc2F0aW9uIGlzIG5vdCBldmVuDQo+IGlu
DQo+IG15IG1haWxib3ggYW55bW9yZS4NCj4gDQo+IEFueXdheSwgc3ViLWNvbW1vbiBhcmUgc3Vi
bm9kZXMsIG5vPw0KPiANCg0KDQogICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVUNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICAgICAgICAgICAgICAgICAgIFNNSSBDb21tb24o
U21hcnQgTXVsdGltZWRpYSBJbnRlcmZhY2UgQ29tbW9uKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfA0KICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSsNCiAgICAgICAgICB8ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICB8DQogICAgICAgICAgfCAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
fA0KICAgICAgICAgIHwgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgIHwN
CiAgICAgICAgICB8ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICB8DQog
ICAgICAgICAgfCAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgfA0KICAg
ICAgIGxhcmIwICAgICAgIFNNSS1TdWItQ29tbW9uMCAgICAgICAgICBTTUktU3ViLUNvbW1vbjEN
CiAgICAgICAgICAgICAgICAgICB8ICAgICAgIHwgICAgIHwgICAgICAgICAgfCAgICAgICAgICAg
ICB8DQogICAgICAgICAgICAgICAgICBsYXJiMiAgIGxhcmI0ICBsYXJiNSAgIGxhcmIxICAgICAg
ICAgbGFyYjcNCg0KVGhpcyBpcyB0aGUgbmV3IHZlcnNpb24gZGlhZ3JhbS4NCkluIE1lZGlhVGVr
IHBsYXRmb3JtLCBzb21lIGxhcmJzIGFyZSBsaW5rZWQgdG8gU01JIENvbW1vbiwgd2hpbGUgc29t
ZQ0Kb3RoZXIgbGFyYnMgYXJlIGxpbmtlZCB0byBzbWktc3ViLWNvbW1vbi4gRGlmZmVyZW50IHBs
YXRmb3JtcyBoYXZlDQpkaWZmZXJlbnQgaGFyZHdhcmUgc3RydWN0dXJlcy4NCg0KSW4gdGhlIGRl
dmljZSB0cmVlLCBzbWkgc3ViIGNvbW1vbiBpcyBub3QgYSBjaGlsZCBub2RlLCBidXQgaXMgYXQg
dGhlDQpzYW1lIGxldmVsIGFzIHNtaSBjb21tb24uICdzdWInIGlzIGp1c3QgYSBpbnRlcm5hbCBu
YW1lIHJ1bGUuDQpBbmQgJ21lZGlhdGVrLHNtaScgaXMgdXNlZCB0byBkZXNjcmliZSB0aGlzIGNv
bm5lY3Rpb24uIA0KRXhhbXBsZSBhcyBiZWxvdy4uLg0KDQo+ID4gDQo+ID4+PiArDQo+ID4+PiAr
ICBtZWRpYXRlayxzbWktc3ViLWNvbW0taW4tcG9ydGlkOg0KPiA+Pj4gKyAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPj4+ICsgICAgbWluaW11bTog
MA0KPiA+Pj4gKyAgICBtYXhpbXVtOiA3DQo+ID4+PiArICAgIGRlc2NyaXB0aW9uOiB3aGljaCBw
b3J0IG9mIHNtaV9zdWJfY29tbW9uIHRoYXQgdGhlIGxhcmIgaXMNCj4gPj4gbGlua2VkIHRvLg0K
PiA+Pg0KPiA+PiBNZXJnZSBpdCBpbnRvIHBoYW5kbGUuDQo+ID4+DQo+ID4gDQo+ID4gSnVzdCBj
b25maXJtLA0KPiA+IERvIHlvdSBtZWFuIG1lcmdlIHRoZXNlIHR3byBpbnRvIG9uZSBwcm9wZXJ0
eSwgbGlrZToNCj4gPiBtZWRpYXRlayxzbWktc3ViLWNvbW0gPSA8JnBoYW5kbGUgcG9ydC1pZD47
DQo+IA0KPiBZZXMNCj4gDQoNCldlIHdpbGwgcmVtb3ZlICdtZWRpYXRlayxzbWktc3ViLWNvbW0n
LCB3aGljaCBzaG91bGQgYmUgcmVkdW5kYW50Lg0KTWVyZ2UgdGhpcyAnbWVkaWF0ZWssc21pLXN1
Yi1jb21tLWluLXBvcnRpZCcgaW50byAnbWVkaWF0ZWssc21pJywgaXMNCnRoaXMgT0sgZm9yIHlv
dT8NCg0KCQlzbWlfY29tbW9uX3Zkbzogc21pQDFjMDI0MDAwIHsNCgkJCWNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTg4LXNtaS1jb21tb24tdmRvIjsNCgkJCXJlZyA9IDwwIDB4MWMwMjQwMDAg
MCAweDEwMDA+Ow0KCQkJLi4uDQoJCX07DQoJCQ0KCQlzbWlfc3ViX2NvbW1vbl9pbWcwXzR4MTog
c21pQDE1MDAyMDAwIHsNCgkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNtaS1zdWIt
Y29tbW9uIjsNCgkJCXJlZyA9IDwwIDB4MTUwMDIwMDAgMCAweDEwMDA+Ow0KCQkJbWVkaWF0ZWss
c21pID0gPCZzbWlfY29tbW9uX3ZwcCA1PjsNCgkJCS4uLi4NCgkJfTsNCg0KCQlsYXJiMTA6IGxh
cmJAMTUxMjAwMDAgew0KCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtc21pLWxhcmIi
Ow0KCQkJcmVnID0gPDAgMHgxNTEyMDAwMCAwIDB4MTAwMD47DQoJCQltZWRpYXRlayxzbWkgPSA8
JnNtaV9zdWJfY29tbW9uX2ltZzBfNHgxIDE+Ow0KCQkJLi4uDQoJCX07DQoNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K

