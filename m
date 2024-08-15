Return-Path: <linux-kernel+bounces-288477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7F953A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57721C21EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5178C7BB15;
	Thu, 15 Aug 2024 19:07:00 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2125.outbound.protection.partner.outlook.cn [139.219.146.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1967E110;
	Thu, 15 Aug 2024 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748819; cv=fail; b=qwA23pCf9kOx9WV+xYy7kKLD6nodcV/ZaszZW2kR+nJ4Qombrfbu7FX1xrnnEXVaR0SfamsCUDoVUw7QUmg5CnBXvaEXo7IscOfmVaMQF/kuff3uthe4GVnAdirGTLYijx0UzmEVnFdWAU17tkHnL/B3RwNoUrH2gu6kngWxNiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748819; c=relaxed/simple;
	bh=qDo5SrZ/4pywN3nG4oxF3giT4t7+xTbQGbK4wFKcEBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGPqh+7ueAdbxnPr6gNYh8AvG7KtPTO5Rh1ABOM5LuY5N607IZ5aOdUrrV/HwQEkAJukNbOvFQL6fkv4RdxHJCTPA2oC/ZxCudEckFHPKrOveXci+ECjUVbzgO9Zt/lty3z1dsmOXlpEFTFRvWHOL5YNObg2+nnAxD245R/Hch0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3H9ascx/5pCw72JXZDtDzE8iGGh8zoPgS1cE1mKQkeYwKG1FbLdzrCSSH4vYEHVlybjHiTX9ZVnL78DVRd3baBlqb55wwzUdEKkY7zQefI4Y7tX86rgb6x5ZiXBis29l+AymExhCFXCIR37vRnqTDNLEYZU50LLwX/irZr7k+yOCMH8zmljkWN4ITXgPaJD3bXdTH8j80TDk39lwp77T/Y1l+qiFs8PHmX7CduLf2xM+e3vP469GU1VN9/3Pl+b0/8rot8qFktVyC2jP53e1x9CsC5LvrXLzWekHcNOuVL/GCvslyez6AHnzzJeuZmA7msL632eJ7B32wSX+d/RQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDo5SrZ/4pywN3nG4oxF3giT4t7+xTbQGbK4wFKcEBI=;
 b=I3ScJNOdHxbNvrOV9Loou043SdY7SRBdz2wByAW4CSQWULQv6jwWx8FyqomQbwNJdqyP5vDsYFeoHVrJC5bh10pb9tErtg+dtJkqrZqwdkVX4bqn+y3ScdrR5ejaV/dH2Xe2/NBjxDlWGMkjrUjxh2GN6NpbaOux14wTLdQ8l8lGah2ppoJd1MGWe3D1v3bEiq7/7IxARjeUgj2HxbZFXhKltEpY0/smQJjieQK/c691iZ/RnMmG2SqTv2lqYEhqtCyKR4C+lEqU/ycU/z7lix4yBijoMqP4hdV4CuOgir3LE8DOllpCQcqpqYqecRO9Yx45UFgH0y++B9rU6A0kmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0864.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Thu, 15 Aug
 2024 10:33:55 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9c31:a452:dc3b:7273]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9c31:a452:dc3b:7273%3])
 with mapi id 15.20.7828.031; Thu, 15 Aug 2024 10:33:55 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor.dooley@microchip.com>, Jan Kiszka
	<jan.kiszka@siemens.com>
CC: Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>, Kishon
 Vijay Abraham I <kishon@kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYyIDEvM10gZHQtYmluZGluZ3M6IHBoeTogamg3MTEw?=
 =?gb2312?Q?-usb-phy:_Add_sys-syscon_property?=
Thread-Topic: [PATCH v2 1/3] dt-bindings: phy: jh7110-usb-phy: Add sys-syscon
 property
Thread-Index: AQHa7MIqi3fKeaFdgUCkV8gwHQ6DdLIjxqIAgADkCwCAACqYgIADTTAQ
Date: Thu, 15 Aug 2024 10:33:55 +0000
Message-ID:
 <SHXPR01MB08633B523DA1F6C5632F6D9DE6802@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <cover.1723472153.git.jan.kiszka@siemens.com>
 <30f3ca9f6bd788e16767b36aa22c0e9dc4d1c6a4.1723472153.git.jan.kiszka@siemens.com>
 <20240812-overstuff-skirt-7a8aabbcdc6f@spud>
 <8cdba8b0-7364-4c09-b18a-f3f59da1eae2@siemens.com>
 <20240813-haiku-pusher-f2fb037a2f49@wendy>
In-Reply-To: <20240813-haiku-pusher-f2fb037a2f49@wendy>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0864:EE_
x-ms-office365-filtering-correlation-id: 43711e8d-88d4-4375-dc59-08dcbd15c372
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 dzGRQBuEJVAahcmvEqPP4Q/1N7+J64hmgyPaf5P492i7veJDiJt4EFJTOQvZBzBRnu0jPIQUEqjcTZmT9fLuM8Nj0m1I1ifHQYr+Yh3tfT9FBxfeDPv9gX5mWe29mrQ9qBw8PPnxtvw0ruTHk3RCRB/Qimy0g4AGAMSMQLIE8/g1gDsSvG+n65Dt2tpxfs4WIAaNxi/w4CEIjJwBKX98tJzOka5MReGiHbgISwThjuPf4mWPEPe8NfgYz1BR9Thx2RkBZ0DhVsixNMnZ+I0KdOb8S92b+97mHJH1KDrTxLKhcTKP0MvvwsgDUkngtDQEbBqzJ3mcFEqFZBeAB5s6mg7QFu93ZFG0Kcn5lRyVJLnJGxAy7SHw6V269lzAzNAqwAf2rgPoRd/0GFtqqyiR9i6jP4PSwsdFisALcJp0AiUoCrrPLQmBGOd8tG7VgQyLJleZYeAg2Ni4cEsfJbgR5kv6BZq4WZfTtEP7NxBqwe2NbTAtOk8eDE8Ds3slOEq9LQ75QTpDYKbEO8tffgeSWMRuhisvXOZyINiL1wkFdnB24xMgfSjsnbyXbG70LqLPRuZY/c2nn3W11Ci1gJ/rIQgaO5TemBH90rYaXaqFrpVFEqS/EyFveM2OPzKXLO6i
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WndoaExqcks3bjR0L205alF5WlJIWjRBbXF3b0g0Q3FvU2pRdk1RQSt5OTZY?=
 =?gb2312?B?OVFxVUtEd2E3LzBDV0NBbWVob1pqa1p0Y1VCVENnT2Y5K24yT1V1MWhvbUdw?=
 =?gb2312?B?dGx0aWc1aG5OMWF1SG9zTUMyV25qUnhLdUZXRmtmRkx0YVFRb0pnL1VJY3A1?=
 =?gb2312?B?NmV4dzRDMkRwemJMZmhwTmoxMEhvQXBTUGxiTzVocmVFL3YrL3Q5aUtGcTJF?=
 =?gb2312?B?MUpJNnZkOUcwUkRSTHhmTWJvQnI1a29Xb2p3UVZqTWlvcExPb29VQlk3R0pX?=
 =?gb2312?B?ZkRNZ1dXeldqSHgyaXRPS3BFOTc5dmM0Q1RuY0s4SE1CR2hyN1NhY0lPVVFr?=
 =?gb2312?B?ZVFSSjZvQzlzaGkrRERCMmN5VjNLejBtMUV3NktONmIxTnlLcjQyc3NKdHNQ?=
 =?gb2312?B?WG5oZ2NSclZlVUM2aUtRbjI1cnBTQmZiUmQvbFlndEhQVzJrSlVrVm1IZEMz?=
 =?gb2312?B?UnhnR1JQTXlPaExXS3Jyd2pQS0s0a05YWnZWYng0WUxXa2hxdkpNcFZ4Y0dM?=
 =?gb2312?B?UnU2bVNBT09GTHdjQVpFaXVPbTFsTEpEMzRhNStibTNQbEF2dXZQd2l3SXRK?=
 =?gb2312?B?VHczc2s4UGNaVGtwQTREQVIvaERRWmwyb2ZwZ29EU0R1SUdyVVl3VGRDQUt4?=
 =?gb2312?B?dE9ESk1UcXZDeTRqUlR6M2YyMzlUeC9vN1llUDhiai96NWNkd21aZDN6Rng2?=
 =?gb2312?B?TC94YXlFQjNuUzJ4RkNEWWJqdUltQ1pVS2hQYnBTcWVKVFRmSGc3Y0JEVTll?=
 =?gb2312?B?SkVWdHNaUFZvc1QzcW5rNlpCSndEamNmRHBwOHBVdGlDS1JKRnRwMzJnVXhj?=
 =?gb2312?B?T3hEd01Xc0hLTW5TL0tDRlVwNk0rNDMyTk1iM2ZhWnprU0x3K0NMaThXdXdZ?=
 =?gb2312?B?TEhpdS94NWVaWjhuS2t0MnBZOXc0YkxSSHNSOGlhZjNkbDViSkhrK3NZSUtF?=
 =?gb2312?B?T2tCb3JPVzhBOWVZQTJkSkJJU3JsRkdFUzljbTBsdUpzTFVHS2hESVplVlRT?=
 =?gb2312?B?QVFhSHNHT3hQam1CWTZDS2FTOEtpR2FrZGk5SkQ1OXAvSi9TMVl0WHA3VTly?=
 =?gb2312?B?bVh1WDk3NjNldm45N3RUSGFRaVN0enp5OUh4aUlaMmNVQ1Q2QzdxbHk2TzZZ?=
 =?gb2312?B?eXJuTmJTRmpXU0RPYld1Ny9mRFdtaXZCdGh2aEpYcFoyZWdGem1tTTVBL3Zy?=
 =?gb2312?B?OVpMUldSZU55OU1CdXhjM1NzdFZjRXpVaTBZVW5RMDlpSWV5dkdxL2liMlMz?=
 =?gb2312?B?cGNjTUg0aTNRamJpR092RXZqZnJQZDlsZW1OdnFMdHFXR2MrSTNmNUszZk1h?=
 =?gb2312?B?NjRGMGc1WjJWREJJQ0JVUXp1ZU5EV0p6M3JmL2NaZmkwS1REb1YxZ2FFUHht?=
 =?gb2312?B?ZjI4cFc0VzNLSDRQcm96WHN3cWxHL01DWGpvckVrRHltbTVYWk1EUytEcXd2?=
 =?gb2312?B?MDVBMmJHSjI0N2Y2Q3QydU9taUwvd2JpT1BCbmhxOUpIUkhmekh4ajk3TC81?=
 =?gb2312?B?cWg5TjhueWpKTXRvQk9iQmRxbUwxOVhmRDdHdGxiU1RtUmlEWUlyR0V1Z2FF?=
 =?gb2312?B?N3IrTEd4K0ozdkFYUytielV3SHRGM2JVNzVwVitlOEFmdzE4a3pTejdRQ2Ew?=
 =?gb2312?B?Sk5qaDlOUlc4UVJQTjlYenJtVHRnUTQ0VXJXMXZ0Q2hyUnRpMkRsL0xtVWdp?=
 =?gb2312?B?aWt2NFdCZzNkZi9UVGJYZVNtNm5qcHNiNkNtQWVmRVFXckkyWDNpckVyWGJU?=
 =?gb2312?B?YnlsQzFhTGcvRDhrZ1pBV1pTd3N4YXhVRVl6RjFJVm5kSVhDL1owMlBVcjFy?=
 =?gb2312?B?TjdxY3hOc2l3ODYwNDBNS0RUMHl6cEdYbnNBOGxlOHVsMmkwTERwZitzL1Bo?=
 =?gb2312?B?UU00R1RrNnZnVDR4QjdyeC8wNVZvTHduK1JWSFAyY1hVa1ovb2FRSTJyNXho?=
 =?gb2312?B?QUNaWDVWVWRWeGZDQi93NnlHMUZVbEVvUDFKMkluRnA1RU9yL2NJL3ZhaWxj?=
 =?gb2312?B?M2JBSlcya1BmZTBEQVpOWnJSLzUrcGdqb3NFRWJQQzZLRFQxcFAwQk1OaVF0?=
 =?gb2312?B?L0I5VUJnQWhvdkkvbmwyakYvNHUwWDNpYnE5V2VRN21qajNkTzZySGlabmo1?=
 =?gb2312?Q?fBdA=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43711e8d-88d4-4375-dc59-08dcbd15c372
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 10:33:55.0446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7spdvmdBOS/xtX5gV4jzZ4sZd3HSNm9HIVo2vLBvkj2fkw5UKsgJsyXfAhW4GQnnKEFaHqrG8h/fhrDl2b+X1gSw5+G9oiqBYJwmkJT/s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0864

DQoNCj4gDQo+IE9uIFR1ZSwgQXVnIDEzLCAyMDI0IGF0IDA3OjMxOjUwQU0gKzAyMDAsIEphbiBL
aXN6a2Egd3JvdGU6DQo+ID4gT24gMTIuMDguMjQgMTc6NTUsIENvbm9yIERvb2xleSB3cm90ZToN
Cj4gPiA+IE9uIE1vbiwgQXVnIDEyLCAyMDI0IGF0IDA0OjE1OjUxUE0gKzAyMDAsIEphbiBLaXN6
a2Egd3JvdGU6DQo+ID4gPj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNv
bT4NCj4gPiA+Pg0KPiA+ID4+IEFuYWxvZ291c2x5IHRvIHRoZSBQQ0kgUEhZLCBhY2Nlc3MgdG8g
c3lzX3N5c2NvbiBpcyBuZWVkZWQgdG8NCj4gPiA+PiBjb25uZWN0IHRoZSBVU0IgUEhZIHRvIGl0
cyBjb250cm9sbGVyLg0KPiA+ID4+DQo+ID4gPj4gU2lnbmVkLW9mZi1ieTogSmFuIEtpc3prYSA8
amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gPiA+PiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcg
KEFybSkgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiA+PiAtLS0NCj4gPiA+PiBDQzogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiA+PiBDQzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
aytkdEBrZXJuZWwub3JnPg0KPiA+ID4+IENDOiBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5l
bC5vcmc+DQo+ID4gPj4gLS0tDQo+ID4gPj4gIC4uLi9iaW5kaW5ncy9waHkvc3RhcmZpdmUsamg3
MTEwLXVzYi1waHkueWFtbCAgICAgICAgIHwgMTENCj4gKysrKysrKysrKysNCj4gPiA+PiAgMSBm
aWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gPiA+Pg0KPiA+ID4+IGRpZmYgLS1naXQN
Cj4gPiA+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvc3RhcmZpdmUs
amg3MTEwLXVzYi1waHkueWFtDQo+ID4gPj4gbA0KPiA+ID4+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BoeS9zdGFyZml2ZSxqaDcxMTAtdXNiLXBoeS55YW0NCj4gPiA+PiBs
IGluZGV4IDI2OWU5ZjlmMTJiNi4uZWFmMDA1MGM2ZjE3IDEwMDY0NA0KPiA+ID4+IC0tLQ0KPiA+
ID4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9zdGFyZml2ZSxqaDcx
MTAtdXNiLXBoeS55YW0NCj4gPiA+PiBsDQo+ID4gPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BoeS9zdGFyZml2ZSxqaDcxMTAtdXNiLXBoeQ0KPiA+ID4+ICsrKyAu
eWFtbA0KPiA+ID4+IEBAIC0xOSw2ICsxOSwxNiBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4+ICAgICIj
cGh5LWNlbGxzIjoNCj4gPiA+PiAgICAgIGNvbnN0OiAwDQo+ID4gPj4NCj4gPiA+PiArICBzdGFy
Zml2ZSxzeXMtc3lzY29uOg0KPiA+ID4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0KPiA+ID4+ICsgICAgaXRlbXM6DQo+ID4gPj4gKyAg
ICAgIC0gaXRlbXM6DQo+ID4gPj4gKyAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBwaGFuZGxlIHRv
IFN5c3RlbSBSZWdpc3RlciBDb250cm9sbGVyDQo+IHN5c19zeXNjb24gbm9kZS4NCj4gPiA+PiAr
ICAgICAgICAgIC0gZGVzY3JpcHRpb246IFBIWSBjb25uZWN0IG9mZnNldCBvZg0KPiBTWVNfU1lT
Q09OU0FJRl9fU1lTQ0ZHIHJlZ2lzdGVyIGZvciBVU0IgUEhZLg0KPiA+ID4NCj4gPiA+IFdoeSBp
cyBoYXZpbmcgYSBuZXcgcHJvcGVydHkgZm9yIHRoaXMgcmVxdWlyZWQ/IFRoZSBkZXZpY2V0cmVl
IG9ubHkNCj4gPiA+IGhhcyBhIHNpbmdsZSB1c2IgcGh5LCBzbyBpc24ndCBpdCBzdWZmaWNpZW50
IHRvIGxvb2sgdXAgdGhlIHN5c2Nvbg0KPiA+ID4gYnkgY29tcGF0aWJsZSwgcmF0aGVyIHRoYW4g
dmlhIHBoYW5kbGUgKyBvZmZzZXQ/DQo+ID4gPg0KPiA+DQo+ID4gSSBkaWRuJ3QgZGVzaWduIHRo
aXMsIEkganVzdCBjb3BpZWQgaXQgZnJvbQ0KPiA+IHN0YXJmaXZlLGpoNzExMC1wY2llLXBoeS55
YW1sLiBBcyB0aGF0IGFscmVhZHkgZXhpc3RzLCBJJ20gbmVpdGhlcg0KPiA+IHN1cmUgd2Ugd2Fu
dCB0byBjaGFuZ2UgdGhhdCBhbnltb3JlIG5vciBkZXZpYXRlIGluIHRoZSBwYXR0ZXJuIGhlcmUu
DQo+IA0KPiBUbyBiZSBob25lc3QsIEkgdGhpbmsgc29tZSBvZiB0aGUgb3RoZXIgdXNlcnMgb2Yg
cGhhbmRsZSArIG9mZnNldCBvbiB0aGlzIHNvYyB3ZXJlDQo+IGp1c3QgY29weS1wYXN0ZWQgd2l0
aG91dCB0aGlua2luZyBhYm91dCB3aGV0aGVyIG9yIG5vdCB0aGV5IHdlcmUgcmVxdWlyZWQgdG9v
Lg0KPiBUaGlzIG9uZSBzZWVtcyBsaWtlIGl0IHNob3VsZCBqdXN0IGJlIGEgbG9va3VwIGJ5IGNv
bXBhdGlibGUgaW4gdGhlIGRyaXZlciBpbnN0ZWFkDQo+IG9mIGJ5IHBoYW5kbGUuIEFzIGEgYm9u
dXMsIGl0IHdpbGwgd29yayB3aXRoIGV4aXN0aW5nIGRldmljZXRyZWVzIC0gd2hlcmVhcyB5b3Vy
DQo+IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gd2lsbCBmYWlsIHRvIHByb2JlIG9uIHN5c3RlbXMg
dGhhdCBoYXZlIHRoZSBvbGQNCj4gZGV2aWNldHJlZSwgYSByZWdyZXNzaW9uIGZvciBzeXN0ZW1z
IHJ1bm5pbmcgd2l0aCB0aGF0IGRldmljZXRyZWUgYW5kDQo+IGRvd25zdHJlYW0gZmlybXdhcmUu
DQo+IA0KPiBDaGVlcnMsDQo+IENvbm9yLg0KPiANCkhpIENvbm9yDQpJIGtub3cgeW91IHdvdWxk
IGxpa2UgdG8gcHV0IHRoZSBvZmZzZXQgdmFsdWUgdG8gdGhlIGNvZGUsIEp1c3Qgc2V0IHN5c2Nv
biBpbiBkdHMuDQpKdXN0IGxpa2UgcGNpZS1zdGFyZml2ZS5jLiByaWdodD8NCg0KPiA+IEphbg0K
PiA+DQo+ID4gPj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiA+PiArICAgICAgVGhlIHBoYW5kbGUg
dG8gU3lzdGVtIFJlZ2lzdGVyIENvbnRyb2xsZXIgc3lzY29uIG5vZGUgYW5kIHRoZQ0KPiBQSFkg
Y29ubmVjdCBvZmZzZXQNCj4gPiA+PiArICAgICAgb2YgU1lTX1NZU0NPTlNBSUZfX1NZU0NGRyBy
ZWdpc3Rlci4gQ29ubmVjdCBQSFkgdG8gVVNCDQo+IGNvbnRyb2xsZXIuDQo+ID4gPj4gKw0KPiA+
ID4+ICAgIGNsb2NrczoNCj4gPiA+PiAgICAgIGl0ZW1zOg0KPiA+ID4+ICAgICAgICAtIGRlc2Ny
aXB0aW9uOiBQSFkgMTI1bQ0KPiA+ID4+IEBAIC00Nyw0ICs1Nyw1IEBAIGV4YW1wbGVzOg0KPiA+
ID4+ICAgICAgICAgICAgICAgICAgIDwmc3RnY3JnIDY+Ow0KPiA+ID4+ICAgICAgICAgIGNsb2Nr
LW5hbWVzID0gIjEyNW0iLCAiYXBwXzEyNW0iOw0KPiA+ID4+ICAgICAgICAgICNwaHktY2VsbHMg
PSA8MD47DQo+ID4gPj4gKyAgICAgICAgc3RhcmZpdmUsc3lzLXN5c2NvbiA9IDwmc3lzX3N5c2Nv
biAweDE4PjsNCj4gPiA+PiAgICAgIH07DQo+ID4gPj4gLS0NCj4gPiA+PiAyLjQzLjANCj4gPiA+
Pg0KPiA+DQo+ID4gLS0NCj4gPiBTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+ID4gTGludXggRXhw
ZXJ0IENlbnRlcg0KPiA+DQo=

