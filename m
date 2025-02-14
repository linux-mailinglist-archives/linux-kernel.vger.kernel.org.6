Return-Path: <linux-kernel+bounces-515538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE25A36604
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAAC1897EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3819F495;
	Fri, 14 Feb 2025 19:11:10 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2112.outbound.protection.partner.outlook.cn [139.219.17.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05531946B1;
	Fri, 14 Feb 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739560269; cv=fail; b=CSCUNMk8YJzxRD93mkQKHJkMY/Od1J2aQuGeLxhtfklQewaylsQ2F8HvP7okmbJ60VfqCuty45IT2Sj7KJsjoNXM9cZAiu+/a9yrjZLiPb4Y8cl162aRRHVuwgoOUqpjhwtR6nPVeA+qytSPYyWtO7qosJDYCag0uiDFFhi6cS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739560269; c=relaxed/simple;
	bh=a0kUl2hXf5YyJOI7tH71fpvKMA38Y64x98ry7fSNYl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mGie60jJLYDdesCjcGqQ0VRnjtacwO3lra8ENl1UJCl0hlW+If+uSvik5hLLoOOKfvMNjt16diR8iv1F7Olhy0+4ZLH39xoYdO54fAw8Ce8KiRutwsuW+wcpFDaLo6nLEtt4/BEc/fPMGZskX/G4nixcDEPFkQZJqszDVe+RuE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSgDhdvsNCuG7BsqxHb295+dpcf1Q2/qd8XxzPiRwWSAwEWkCb8ExCRIovow7aeaV/B8mlHsqA/3o2k8yc8SB8SN/BND+eLbcTYpB5EM/fX9n2g8ohS55PONuObCzQ/sW6GbUNizgW4iNOIXDdt3CMpIwQthhRvFJVIw07lxNycAGx+IlzgWeTzEf3IL1rc1xPRjIxKz4w4ybtX5D1E37XyaUhJUsOU2m6ib/RU4Mj3x5kHwxAEEhTJIKigB/m0epZcpvPFUlhxfQRifCgvt6z3qbdqz9LtKfObzQvYGnAEF1CBvq408aRFtUpZEiLLbrqi+Tk5P6zGoXaImYSQJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0kUl2hXf5YyJOI7tH71fpvKMA38Y64x98ry7fSNYl4=;
 b=SH9OcjFEQxsRMXT3kx6CeHuGsflCpzlJXkn2/bSvhx5j1vWPp22iTfDQizzj/pTJMuOqYq6T686sootTgE5lOMJmNxTa8NrfHvMwb6zBl/Vu1qYJplqvnIiA6nS7tX6aOM22VXaAhwllWZtROkCZR65flxEmwpDqIjR+qdp4ykxknzReVxU1v7/movtoi8k/o4bBNxzJZSArXQ9JFH854JF50z7uA7BtOkSoQHdYlW+/0027MIO8zGlbij9T/Iv3JJ0R+dJH7FvEUnthfuBmkRHaRwUzzIJ0V02cwOnVDPBdjjDo61yLhdPKCazLNYrDKVA7IeCqLTmvCHToADLWsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0893.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.14; Fri, 14 Feb
 2025 10:34:56 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Fri, 14 Feb 2025 10:34:56 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: E Shattow <e@freeshell.de>, Conor Dooley <conor@kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] riscv: dts: starfive: jh7110: pciephy0 USB 3.0
 configuration registers
Thread-Topic: [PATCH v1 1/2] riscv: dts: starfive: jh7110: pciephy0 USB 3.0
 configuration registers
Thread-Index:
 AQHbZessMJgcIL10+UmGw9zpa2rChbMVwlmQgADRYoCAARlKYIADWKIAgAei6jCAAaJXgIAigW2A
Date: Fri, 14 Feb 2025 10:34:55 +0000
Message-ID:
 <SHXPR01MB0863D058F8E2F9C14DCE2B76E6FEA@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20250102183746.411526-1-e@freeshell.de>
 <20250102183746.411526-2-e@freeshell.de>
 <20250113-mushiness-snugness-0f55574e3956@spud>
 <SHXPR01MB0863DBF85A9874C9F93ECD25E618A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <20250114-recollect-dictate-104e890d116e@spud>
 <SHXPR01MB08631714C914911D343372ACE619A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <dd3aefec-0e1a-4025-812b-daa67a53f4ee@freeshell.de>
 <BJXPR01MB08553280FF7E342451053A6FE6E1A@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
 <bce19eaf-11bf-4ce8-bc15-dffb96cae9d4@freeshell.de>
In-Reply-To: <bce19eaf-11bf-4ce8-bc15-dffb96cae9d4@freeshell.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0893:EE_
x-ms-office365-filtering-correlation-id: af090848-745a-4c9e-6221-08dd4ce33955
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|41320700013|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 BQCR4yjXKWPAoCibA0/DKknJAH1N/eivR1Zz+VIZCrqXK07r8b5h4m19UzSU51m5X6xjbtSuvy/kNm9cVBN6/Yz9pw47PgxCIY6kcnhylX3RRdM/inTPL07V4rG562P7nJktmrZ73CaU7IacvEir3Xguz6fo+A/BJf7UMTc99+kp8wAsBTxclTMreceBwyIGEfXwNME7XtRC+sidYtMYvttFfEDOZ8Utt1biZS1DfoT6yejhJg2ktc7w9pKkIn6NWilVVgMd033/UQHqMCNOUA6eav2AaJwcbSrqbY7wYDsPk6T3zIR+WjgWwlkUUO7pRrHAOL5k6Z359Guq2/kq31jlpf5B9uj6i+kdvsF/sgSXps32R54c8bxsQgtJyK4ycdYEIbZCpq67fyEgl9jRraYkmy83OFLIvvbZEb49UYwM9hXWguI0YC8vweE367os/QogPZ4Y2wgFXU6V8uMCPPQ+n2peNVaC89YjGBNIPGYPECZ1pCqIRKahqVUfD+62Y+pDvmfXaLdHJHuP7k3HRTI1FiIXKG3MuroLQv4f1ZdUWhjwRAVhUqZhSDJRDhAJQFuSewh56JiCTlGtGjCKnOpVQZOD2lmnv8xGQzlp5vM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(41320700013)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDBFMXVpTFdpb2o0aHU4c0xvRWNDaStHMm80S3JLZXY0R2x4WWhQMTBhTUdO?=
 =?utf-8?B?eGlsRFUyNzgxS3YwWndXOG5lZEhvUnhvWWVoaCtTdDVKZFJmZVppSkpGZytF?=
 =?utf-8?B?M09tTXo0S2VTQ2hxYWlWZEs1eU5SUm51NVdhOHlLMElyVmZldFJBUkpnL0pP?=
 =?utf-8?B?T3pvOVZ1YXk3RzM0NmhKQTZFQnVZalRERG50eXFzTmJLMVZubk0rU0RrUGVj?=
 =?utf-8?B?bEVlWEF4elpwcElDWmhKbFlNckhYWVZxa2kralFvRWEybnhSQW5VemNSNjc3?=
 =?utf-8?B?NnZOSjhieDBpQ2pqTkU4RVYzT3RKdnZycHk1MTcyV1RKMTIxSEVsaWRiUzhz?=
 =?utf-8?B?QWdPWmZ5T00rRHpZU3E5REZjdzZRSDZLUzB6ekRQRUNwT3VkaFdNcEZmUldB?=
 =?utf-8?B?T004bkhuWklqdlovYnFvODI0M3ZvdUlYS2RndE5WVWVxM0UxL1VrRHJXYkZ6?=
 =?utf-8?B?WjMyVzh3Z2ZsS3RYSnR4UjJnQmVrSHZESEo5Ylh1TXFndC9xYUhmTHllR0JQ?=
 =?utf-8?B?bm5DQXg5SjlsZ0lkNjNJcHdJU3VCdjNoWUZYd0EvekcreTdqcGx5U2pjUytO?=
 =?utf-8?B?am1RN245NXBwejI0VUdxVHh1by9yejRuY0IrOUJ6ZjVEcnZLdUJjNkhyNFlv?=
 =?utf-8?B?ZEJiaGVjY1B2ZzFUZlUxTStwdmxSZCt5QUwzKzNGTDh0Y1RGQkFoTmJHa2lC?=
 =?utf-8?B?TlRacEFSZlFNWi90Ync5dWp4dGNROTRkQnVFV1RMZ1F3V05NSEd4M0RiSHEz?=
 =?utf-8?B?RmdsWG10MmxKTnZKcmt1T2RTUEpiMU9ZMjRQNTRzT3NmbWorQUx1aEhsZ1Zy?=
 =?utf-8?B?WUEzUkVSL3ltU0oyeHJrRTZpc2hNcGJ1ODVyL3AwRzFDbGxvNG1IbXV3c1Nh?=
 =?utf-8?B?RXpBZzNvaVJkWnpUWFVaenZ5YldIK3dXMFc4NUtacEZDRVpEZWRYWUtHT21a?=
 =?utf-8?B?di9wWjNmV2V6OE9uUVBhdi9ueW9SVHZkR2FyNjg0cGpsVEpLUHhkUlpYMzd3?=
 =?utf-8?B?bnc5TkpuajN4RDVSWi9Ya2xOenpaQ0FaUWxwU3drS1p6RDNUNUZuamdESEV4?=
 =?utf-8?B?a1ArMW1Ub2toZGxhaUhSSVhZVUhQOTZBN3NkeHkrVjh4Z0pTN2FhQnNUY0hr?=
 =?utf-8?B?WXlBTlUrR1BOUTBsMFZRMkhmaTM1MTFwRzZXQmcrQjJxSVBQQk9pcTQyTFpw?=
 =?utf-8?B?SnJGclVEczZyTno0NkpSZGpRTnUyaS9GeHB5ckVpYkhJWE1obS9kU2E1a1Uz?=
 =?utf-8?B?eG8rdzcvbXFEdE04TzAvRGhGVjdpTVJseE9hM2pBR1N6djdFMjlDVFM4am41?=
 =?utf-8?B?M1U4S29pL2x5OXdrSDliNjhYMlpYdFIrT3VXOXJCVUt2UmtzcFk4b0E5NURG?=
 =?utf-8?B?ZlVTcFB0aDdMTFgwUmZ6WDZnd09mcjRmWmlpT0M0aTJ0RHpZNlBaNVUyYmZO?=
 =?utf-8?B?STFzM3JYKzRiZEJhZnBRdDV6Vm56Ukx6QVBnbElnTjhxekVybWpuZDJ5L1lq?=
 =?utf-8?B?STNueGRVWExuaFd0eFh2TFBIazdEaWtVRnlwQ2w1aFRvb1VwTjB5VFVYM2E4?=
 =?utf-8?B?RVJuMHAzMTF5d3dWKzE2QnVLakFIVkFHc2hIbjZubjNUbi9lVXo3Z1RSeE5U?=
 =?utf-8?B?WFltb3JsSGZZNko4Y1l1Vi81bSt0YVFKTEkyZ2JsNURTVzBDRGpvOGxONmFH?=
 =?utf-8?B?YXdCZmtGQlE2L3p4WTFBQ3M5ZnJ3UnFqa1lsdlJBZnM4TVdHbjQ3dnEyNWhx?=
 =?utf-8?B?Z2x0ZFJZblZYbnIvTm5QUklSbzFma2FiVDhwZ0NoZnNyS0Y1dHZvWjZVM3JB?=
 =?utf-8?B?eHdZcVByZmhUTGlBWEYrcnhYMHBCTG84aTJyT3N5MmVyK3liZHFzcU5RQjRa?=
 =?utf-8?B?NVV0TmpOQWtGYVdGTjN5Sm1SU2E5T3hpYXdUTWFKSW9xMTZMQ0pMU1ZtcmxL?=
 =?utf-8?B?cUF6UTg2ZUpuU3JUMUFpbGV5VEhhNGZOVVVmN005L1JvWXk5M3R4RWpHUE5Y?=
 =?utf-8?B?cXNrck9wQmZRaTk4amczV0N6SklIRGpjYWJEclNHNEUyL2JSN2hLOUttYXhx?=
 =?utf-8?B?WUNNMkxuU041ZUdZOHZtVGtLQVIxV3R6bmxUdmNFYThGREtITlJpNUx2NUpD?=
 =?utf-8?Q?PXFaWVogk+7PGdnaQ+yOhwMzf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: af090848-745a-4c9e-6221-08dd4ce33955
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 10:34:55.9288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Xuan+tkDgG8jTWCDXlpI22PAncGP6pFZC6rXPSaZ5aU79/dDXCKfoTOD/fzWRMp5BsjFbXh9cIUm5QgV8cN4cMwXtgtlubC3lFM3OFBFr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0893

DQoNCj4gDQo+IA0KPiANCj4gT24gMS8yMi8yNSAwMjo0MSwgTWluZGEgQ2hlbiB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4NCj4gPj4NCj4gPj4gSGkgTWluZGEsDQo+ID4+DQo+ID4+IE9uIDEvMTUvMjUg
MDI6NTgsIE1pbmRhIENoZW4gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+IE9u
IFR1ZSwgSmFuIDE0LCAyMDI1IGF0IDA1OjQyOjI4QU0gKzAwMDAsIE1pbmRhIENoZW4gd3JvdGU6
DQo+ID4+Pj4+DQo+ID4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gT24gVGh1LCBKYW4gMDIsIDIw
MjUgYXQgMTA6Mzc6MzZBTSAtMDgwMCwgRSBTaGF0dG93IHdyb3RlOg0KPiA+Pj4+Pj4+IFN0YXJG
aXZlIEpINzExMCBjb250YWlucyBhIENhZGVuY2UgVVNCMi4wK1VTQjMuMCBjb250cm9sbGVyIElQ
DQo+ID4+Pj4+Pj4gYmxvY2sgdGhhdCBtYXkgZXhjbHVzaXZlbHkgdXNlIHBjaWVwaHkwIGZvciBV
U0IzLjAgY29ubmVjdGl2aXR5Lg0KPiA+Pj4+Pj4+IEFkZCB0aGUgcmVnaXN0ZXIgb2Zmc2V0cyBm
b3IgdGhlIGRyaXZlciB0byBlbmFibGUvZGlzYWJsZSBVU0IzLjANCj4gPj4+Pj4+PiBvbg0KPiA+
Pj4+IHBjaWVwaHkwLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRSBTaGF0
dG93IDxlQGZyZWVzaGVsbC5kZT4NCj4gPj4+Pj4+PiAtLS0NCj4gPj4+Pj4+PiAgICBhcmNoL3Jp
c2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC5kdHNpIHwgMiArKw0KPiA+Pj4+Pj4+ICAgIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IGRpZmYg
LS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC5kdHNpDQo+ID4+Pj4+
Pj4gYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC5kdHNpDQo+ID4+Pj4+Pj4g
aW5kZXggMGQ4MzM5MzU3YmFkLi43NWZmMDczMDNlOGIgMTAwNjQ0DQo+ID4+Pj4+Pj4gLS0tIGEv
YXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAuZHRzaQ0KPiA+Pj4+Pj4+ICsrKyBi
L2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLmR0c2kNCj4gPj4+Pj4+PiBAQCAt
NjExLDYgKzYxMSw4IEBAIHVzYnBoeTA6IHBoeUAxMDIwMDAwMCB7DQo+ID4+Pj4+Pj4gICAgCQlw
Y2llcGh5MDogcGh5QDEwMjEwMDAwIHsNCj4gPj4+Pj4+PiAgICAJCQljb21wYXRpYmxlID0gInN0
YXJmaXZlLGpoNzExMC1wY2llLXBoeSI7DQo+ID4+Pj4+Pj4gICAgCQkJcmVnID0gPDB4MCAweDEw
MjEwMDAwIDB4MCAweDEwMDAwPjsNCj4gPj4+Pj4+PiArCQkJc3RhcmZpdmUsc3lzLXN5c2NvbiA9
IDwmc3lzX3N5c2NvbiAweDE4PjsNCj4gPj4+Pj4+PiArCQkJc3RhcmZpdmUsc3RnLXN5c2NvbiA9
IDwmc3RnX3N5c2NvbiAweDE0OCAweDFmND47DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gV2h5IHdlcmVu
J3QgdGhlc2UgYWRkZWQgaW4gdGhlIGZpcnN0IHBsYWNlPyBNaW5kYSwgZG8geW91IGtub3c/DQo+
ID4+Pj4+Pg0KPiA+Pj4+PiBUaGUgZHJpdmVyIG9ubHkgcmVxdWlyZSB0byBzZXQgc3lzY29uIHJl
Z2lzdGVyIHdoaWxlIHRoZSBQSFkNCj4gPj4+Pj4gYXR0YWNoIHRvIENhZGVuY2UgVVNCLihzdGFy
NjQgYm9hcmQgY2FzZSkgVGhlIFBIWSBkZWZhdWx0IGF0dGFjaA0KPiA+Pj4+PiB0byBQQ0llMCwN
Cj4gPj4+Pj4gVkYyIGJvYXJkDQo+ID4+Pj4gZG8gbm90IHNldCBhbnkgc2V0dGluZy4gU28gSSBk
b24ndCBzZXQgaXQuDQo+ID4+Pj4NCj4gPj4+PiBEb2VzIHRoaXMgbWVhbiB0aGF0IHRoZSBjaGFu
Z2Ugc2hvdWxkIGJlIG1hZGUgaW4gZmlsZXMgd2hlcmUgaXQNCj4gPj4+PiB3aWxsIG9ubHkgYWZm
ZWN0DQo+ID4+Pj4gbm9uLVZGMiBib2FyZHMsIG9yIGlzIGl0IGhhcm1sZXNzIGlmIGFwcGxpZWQg
dG8gdGhlIFZGMiBhbHNvPw0KPiA+Pj4gSGFybWxlc3MuIFRoZSBQQ0llIFBIWSBkcml2ZXIgc3Rp
bGwgc2V0IHRoZSBQQ0llIG1vZGUgc3lzY29uIHNldHRpbmcuDQo+ID4+DQo+ID4+IFNvdW5kcyBn
b29kIHRvIG1lLiBIb3dldmVyIHNvbWUgdGFuZ2VudCB0b3BpYyByZWxhdGVkIHRvIHRoaXMgc2Vy
aWVzOg0KPiA+Pg0KPiA+PiBPdXIgcXVlc3Rpb25zIGFuZCBhbnN3ZXJzIGluIHRoaXMgZGlzY3Vz
c2lvbiBhcmUgYSByZXByZXNlbnRhdGlvbiBvZg0KPiA+PiB3aGF0IGlzIG1pc3NpbmcgZnJvbSB0
aGUgZG9jdW1lbnRhdGlvbi4NCj4gPj4NCj4gPj4gV2hhdCBkbyBJIHdhbnQgdG8ga25vdz8gOiAg
InBkcnN0biBzcGxpdCBzdyB1c2JwaXBlIHBsdWdlbiIgYWJicmV2aWF0aW9uLg0KPiA+Pg0KPiA+
PiBXaGF0IGFyZSB0aGUgZnVsbCB3b3JkcyB0aGF0IGlzIGZyb20/DQo+ID4+DQo+ID4+IEkgd2ls
bCBndWVzcyB0aGUgd29yZHMgYXJlOg0KPiA+Pg0KPiA+PiAiUG93ZXIgZG9tYWluIHJlc2V0IG5l
Z2F0aXZlPyBTcGxpdC4uLiBTd2l0Y2g/IFVTQiBwaXBlbGluZSBwbHVnIGVuYWJsZT8iDQo+ID4+
DQo+ID4+IFdoZW4gdGhpcyBpcyBleHBsYWluZWQgZm9yIG1lIEkgd2lsbCBzZW5kIGEgcGF0Y2gg
dG8gYWRkIGluZm9ybWF0aW9uDQo+ID4+IGludG8gZG9jdW1lbnRhdGlvbiBhdCBkdC1iaW5kaW5n
cy9waHkvc3RhcmZpdmUsamg3MTEwLXBjaWUtcGh5LnlhbWwNCj4gPj4gZmlsZS4gSSBrbm93IHRo
YXQgdGhlIGZ1bmN0aW9uYWxpdHkgaXMgYWxyZWFkeSBzYWlkIGluIGRpc2N1c3Npb247DQo+ID4+
IFdoYXQgSSB3YW50IGFyZSB0aGUgZnVsbCB3b3JkcyB0byBleHBhbmQgdGhlICJwZHJzdG4gc3Bs
aXQgc3cgdXNicGlwZQ0KPiBwbHVnZW4iDQo+ID4+IGFzIGFueSBhYmJyZXZpYXRpb24gd291bGQg
YWxzbyBiZSBleHBhbmRlZCBhbmQgZXhwbGFpbmVkIGluDQo+IGRvY3VtZW50YXRpb24uDQo+ID4+
DQo+ID4+IEl0IHdvdWxkIGJlIGRpZmZpY3VsdCB0byBpbXByb3ZlIHRoZSBkb2N1bWVudGF0aW9u
IGJlZm9yZSBvdXINCj4gPj4gZGlzY3Vzc2lvbiBhYm91dCB0aGlzIHNlcmllcyBoZXJlLiBOb3cg
aXQgaXMgY2xlYXIgd2hhdCBxdWVzdGlvbnMgYW5kDQo+ID4+IGFuc3dlcnMgYXJlIG1pc3Npbmcg
ZnJvbSBkb2N1bWVudGF0aW9uLg0KPiA+Pg0KPiA+PiAtRQ0KPiA+IEluIG15IHZpZXcsIHBkcnN0
biBzcGxpdCBzdyB1c2JwaXBlIGlzIGJpdDE3IHNldHRpbmcuIFNldCB0byAxIGlzIG1lYW4NCj4g
PiBzcGxpdCB0aGUgUENJZSBQSFkgZnJvbSBDYWRlbmNlIFVTQiBjb250cm9sbGVyLg0KPiANCj4g
SGksIE1pbmRhLiBZZXMsIHRoZSBmdW5jdGlvbmFsIGRlc2NyaXB0aW9uIGlzIHZlcnkgZ29vZC4N
Cj4gDQo+IFdoYXQgSSB3YW50IHRvIGtub3cgaXMgdGhlIGxhbmd1YWdlICJwZHJzdG4iIGZvciBl
eGFtcGxlLCB3YXMgdGhpcyBmcm9tDQo+IFN0YXJGaXZlIGFuZCBzb21lb25lIHlvdSBjYW4gYXNr
IHdoYXQgdGhvc2Ugd29yZHMgYXJlID8gRWxzZSBpcyBpdCBmcm9tDQo+IENhZGVuY2UgYW5kIEkg
c2hvdWxkIG5leHQgYXNrIHNvbWUgZGVzaWduIHBlcnNvbiBmcm9tIENhZGVuY2UgY29tcGFueT8g
SQ0KPiB3YW50IHRvIHNob3cgaW4gZG9jdW1lbnRhdGlvbiB3aGF0IGlzIHRoZSBsb25nIHdvcmQg
KG9yIG1hbnkgd29yZHMpIHRoYXQgYXJlDQo+IGNoYW5nZWQgdG8gc2hvcnQgd29yZHMgYW5kIGJl
Y29tZSAicGRyc3RuIHNwbGl0IHN3IHVzYnBpcGUgcGx1Z2VuIi4NCj4gDQo+IFdoZW4gSSByZWFk
ICJwZHJzdG4gc3BsaXQgc3cgdXNicGlwZSBwbHVnZW4iOg0KPiANCj4gcGRyc3RuID0gPyAgSSBk
byBub3Qga25vdywgaXQgaXMgZGlmZmVyZW50IHRoYW4gYW55IHdvcmQgSSBrbm93LiBUaGlzIGNv
dWxkIGJlIGxpa2UNCj4gUG93ZXIgRG9tYWluIChvciBQb3dlciBEZWxpdmVyeSksIFJlc2V0LCBO
ZWdhdGl2ZS4uLiBQdWxzZSBEYXRhIFJhdGUNCj4gU3RhbmRhcmQuLi4gUGx1ZyBEcml2ZXJzIFRy
YW5zbWlzc2lvbi4uLiBpdCBpcyBub24tc2Vuc2UgdG8gZ3Vlc3MuIEkgcHJlZmVyIGluDQo+IHdy
aXRpbmcgZG9jdW1lbnRhdGlvbiB0byBnaXZlIHNvbWUgaW5mb3JtYXRpb24gdGhhdCBpcyBhY2N1
cmF0ZS4NCj4gDQo+IHNwbGl0ID0gc3BsaXQuIE9rLiBJIHRoaW5rIHRoaXMgaXMgdHJ1ZS4gWW91
IHByb3ZpZGUgdXMgY29kZSBhbmQgZ29vZCBkZXNjcmlwdGlvbiB0aGF0DQo+IGJpdDE3IHNldHRp
bmcgaXMgYSAic3BsaXQiIGFjdGlvbiBzbyB0aGlzIGlzIGVhc3kgZm9yIHVuZGVyc3RhbmRpbmcu
DQo+IA0KPiBzdyA9ID8gbWF5YmUgdGhpcyBpcyAic3dpdGNoIj8gIG9yICJzb2Z0d2FyZSIsICJz
b3V0aHdlc3QiLCAic2lnbmFsIHdhdGNoIiwNCj4gInNpbmUgd2F2ZSIsIC4uLiBwcm9iYWJseSBz
d2l0Y2guDQo+IA0KPiB1c2JwaXBlID0gJ3BpcGUnIGlzIGEgY29ubmVjdGlvbi4gb2theSwgdGhp
cyBpcyBhY2NlcHRhYmxlLiBJdCBpcyBhICJwaXBlIiBjb25uZWN0aW9uDQo+IG9mIENhZGVuY2Ug
SVAgYmxvY2sgd2l0aCBhIGRpZmZlcmVudCBwYXJ0IG9mIEpINzExMCBkZXNpZ24gKFBDSWU/KQ0K
PiANCj4gcGx1Z2VuID0gcGx1ZyBlbmFibGU/IEkgZG8gbm90IHRoaW5rIG9mIGFueSBkaWZmZXJl
bnQgcG9zc2libGUgd29yZHMgZm9yIHRoaXMsIHNvIGl0DQo+IG1heSBiZSB0aGF0Lg0KPiANCj4g
SSBhbSBhd2FyZSB0aGlzIHJlcXVlc3QgaXMgbm90IGFueSBiZXR0ZXIgZm9yIHVzIHRvIHVuZGVy
c3RhbmQgdGhlIGNvZGUuDQo+IFdlIGRvIGtub3cgd2hhdCB0aGUgY29kZSBkb2VzIC0gVGhhbmsg
eW91LCBJIGFwcHJlY2lhdGUgeW91ciB0aW1lISBUaGUNCj4gRW5nbGlzaCB3b3JkIGNob2ljZXMg
YXJlIG5vdCB2ZXJ5IGludGVyZXN0aW5nICg/KSBidXQgSSB3YW50IHRvIGJlIGFjY3VyYXRlIGZv
cg0KPiBkb2N1bWVudGF0aW9uLg0KPiANCj4gU29tZW9uZSBhdCBhIG1vbWVudCBpbiBwYXN0IHRp
bWUgZGVjaWRlZCAicGRyc3RuIHNwbGl0IHN3IHVzYnBpcGUgcGx1Z2VuIiBpcyBhDQo+IGdvb2Qg
ZGVzY3JpcHRpb24gZm9yIHRoaXMuIFdobyBpcyB0aGF0IHBlcnNvbj8gV2hhdCBhcmUgdGhvc2Ug
bG9uZyB3b3JkcyB0aGV5DQo+IGRpZCBjaGFuZ2UgaW50byBjb25mdXNpbmcgc2hvcnQgZm9ybT8g
Oi0pDQo+IA0KPiBJZiB5b3UgY2FuIGFzayBhcm91bmQgYW5kIG1heWJlIHNvbWVvbmUgYXQgU3Rh
ckZpdmUgZG9lcyBrbm93PyAgRWxzZSB5b3UgY2FuDQo+IGNvbmZpcm0gdGhhdCBpdCB3YXMgc29t
ZXRoaW5nICJub3QgZG9jdW1lbnRlZCIgYW5kIEkgd2lsbCBleHBsYWluIGluDQo+IGRvY3VtZW50
YXRpb24gdGhhdCBpdCB3YXMgIm5vdCBkb2N1bWVudGVkIiB0aGlzIGV4YWN0IHNvdXJjZSBvZiB3
b3JkcyBmb3INCj4gInBkcnN0biBzcGxpdCBzdyB1c2JwaXBlIHBsdWdlbiIuIFdlIGNhbiBzdWJz
dGl0dXRlIGEgZnVuY3Rpb25hbCBkZXNjcmlwdGlvbiB3aXRoDQo+IG9yIHdpdGhvdXQgYSBzb3Vy
Y2Ugb2YgdGhlIHdvcmRzLg0KPiANCkkgdGhpbmsgc2V0IGl0IHRvICJub3QgZG9jdW1lbnRlZCIg
aXMgT2theS4gVGhlIEpINzExMCBVU0Igc3lzdGVtIERlc2lnbmVyDQpoYXMgbGVmdCBmcm9tIFN0
YXJGaXZlLiBTbyBJIGNhbnQgZ2l2ZSBtb3JlIGRldGFpbCBhYm91dCB0aGlzLg0KDQo+IEJlc3Qg
cmVnYXJkcywNCj4gDQo+IEUgU2hhdHRvdw0K

