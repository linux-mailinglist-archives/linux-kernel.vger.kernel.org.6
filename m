Return-Path: <linux-kernel+bounces-212435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0222906071
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95531C20E16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DD3DDD8;
	Thu, 13 Jun 2024 01:35:20 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4347DF71;
	Thu, 13 Jun 2024 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242519; cv=fail; b=qF+U/qF8W+xmJun0HlQ4YqVEJ2Mg9heXQBU9g0hepTbG14OphpF6asZdzUbFjiGIp4VPyKstIOik8lKpRlMklk7sRALlK351HpQl8KdgHcCGHGwjuLMLKFQ25/0IUdirwHgR1TpsbXha6X5D8NSMsLJqyr/AsXbB780zZ3f8/zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242519; c=relaxed/simple;
	bh=icxKrKaZHOI1tt6z74kHrgMC80WHoLmK3l2g8/UYFdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0EqBamMY8nS/BKUEFfsibOliDjgtSX33aWSAxqsxaClul7o+1aQ3YRhNR58a/1S5ESkzwTg+Nq/kP9N8UEMEL997OGdrjgioyqsv2vvuJDUbQYcuhyS10tAC8hCcCPD/dIV8wuAgzUfR+Gklgwvq9sO8Mi1J4SyEOnFJcj+PGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu5nqCRTUUrRQno3Mt2g/SVpgDEvr0V7CEFBHAKAV/UetEgd/grehl9LzDOLl2aRLPOgF6a/Jf3zF10I4kRyjktfDvnSIEineazv2Xp4gXqKKyLhjuUe4EqhL/HaGb7by6Mz/rI7eKBKwWrpThcYUZtk9Nz47CJEV0JcGN3HwOP6hrOChM/nCY1YJc1KJ73UkHH1ef75epl3KPd6AZa+BWlLjk1mYFNFHM/uov0bkqPKPWjLo2bVcFUri8cFXv2uRk8ltB81zpaR7a9VpOml41Ntl1SfCAe7BVJ5y4bUnJdxoPTokQegQxlPq7L1S6T2LaR52vA64yuyNjkY7e+OzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icxKrKaZHOI1tt6z74kHrgMC80WHoLmK3l2g8/UYFdg=;
 b=G95FJJvvyNLHoSQJV8V0r3VfZOnG4K+uOx4yV/p99ucBca1gj5nH0SfzcI1UNOPa+an/ZW4eL/iBXeJ50jIsq6FSjH2yNRSUsqHlMrX2hkNoIWdofuO5SFXQ9FaagjBVMLH2i080Fp+F2D5SAy2da10154WeFRR61Ij9VYRTPEls/DGl0cKpBj3XVU2by2AIbrF1g20tinERBG6XovCAV+i/dWczw+vh+LpVnulpQalBbheLY/MI+l4fNrMuYT2XgrEXXIwniMYoDLhnA3oI/d2IqjguVR5pBHLWGOvZo97xKWqVxDWrdJCpZmdu6RU72QS0T0qrlsMG/zIToILA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.39; Thu, 13 Jun
 2024 01:02:57 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7611.039; Thu, 13 Jun 2024 01:02:57 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject:
 =?gb2312?B?u9i4tDogUmUgOiBbUEFUQ0ggdjFdIHJpc2N2OiBkdHM6IHN0YXJmaXZlOiBh?=
 =?gb2312?Q?dd_PCIe_dts_configuration_for_JH7110?=
Thread-Topic: Re : [PATCH v1] riscv: dts: starfive: add PCIe dts configuration
 for JH7110
Thread-Index: AQHau6H4HWcv0PbsKE2MIzy9iFiWZbHCwFiAgACdwFCAAJ5jgIAA5udg
Date: Thu, 13 Jun 2024 01:02:57 +0000
Message-ID:
 <SHXPR01MB0863726042D8AABA83576C4DE6C12@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240611015200.40996-1-minda.chen@starfivetech.com>
 <20240611-irk-hypocrite-a53e98e6c394@spud>
 <SHXPR01MB0863CFE4519C0D69E961620CE6C02@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <20240612-italicize-cultural-a10b8a387520@spud>
In-Reply-To: <20240612-italicize-cultural-a10b8a387520@spud>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
x-ms-office365-filtering-correlation-id: 918ba0d1-69a3-4f7c-3b2d-08dc8b449042
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230034|1800799018|41320700007|366010|7416008|38070700012;
x-microsoft-antispam-message-info:
 Xh9EB81nOauQx74tb01n/GbnwiwA7p3oS5ffNSJs3sh0rSjCAwOmXKk9cUO/xTXCy+uH9iozETZL1fZta4QZE4E8Wz4beBr4AYcFRIE5LW4VSZAJZODmDTTqGpDdKyQThgN3g419hCskS7uKi8oYy5pfsQhM7s6U8ZuwRzdW8JrdraYhB/Lg2gE+9TfmnzH39LHr3fUiGNzuNcM3BiOSpoxyz3nxiXVq9+zs89C8wnRXpMF7lKIXMOYTZh2yTdVjl9Es7FFUdDf17FddpijmMVTOWrlY1kuI8sbTSN2TWuvJs6G8s5T411L32pf/OLFgigkmppxH2C4Y/GB2wUUMTFyYS2V+DR3ZSIkCq7DuEX01SUfBVTMAf6VW3EvRw92OZjhPrwKqGEYud7cl+kC5c78GQsfUyxl1XYgqMDZ1Obx38pBGadXoHq4EVacU3pZjE13CRw18BlPbJa/9RXEf/MGRalEleRHwnbvNIaYRWdJ7ZxvNrsv7ztR0IMOg+1yKox7+siYmEnfK4DMcBy1f9qc6Oa5p2/1COwdPj+RVqa4+aS52obsJ9l75dF6do+0BPitm+c/aqK1gA7U5EjsIfEq1DbqldHjU7KHnXhFYrT2XPyNqdL5jJBFm/mpUtqXa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230034)(1800799018)(41320700007)(366010)(7416008)(38070700012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TU5hcUJ4RjlhaE1IZyszQ0pIQkw3WldpdDhjbmYwVjVUb1RmWStLMjhQNmRu?=
 =?gb2312?B?enhqM1RFeEN1YVBvc013bjFBNnRIamJEc0h0ZFlFYldFdlN5cVJsZXhOQzlM?=
 =?gb2312?B?VDhWVzc5ODhxYnZpeHRzVUlCaTdzVHlEOWhlM2hqYnMyWTJTV1V6cmlXaGZ5?=
 =?gb2312?B?ZUpmSFArYWxDcmcweGZqNnp5dUEwY2pJVzVDN3dyRXlBY0Y4Q0NLK0FZeGx5?=
 =?gb2312?B?MHU3cFN0ZFZCSnlzUDEwTlBlVXJOWWRjQVlMSjlEOENNeWtYcTJIaWtjblpr?=
 =?gb2312?B?R3VLRHF6YUVQYzgzc2VKdTVnaWpzR1hKL0tORG1EUW1BWmFKWURLRXJDVkls?=
 =?gb2312?B?VzJrc3o3ME8zT2NDcWFlU1dQTnlKTzdVWWt2dnRQU1Q1Wk5JN0VsUU5zWnpp?=
 =?gb2312?B?eUpGa2tHSThBRzg4bG91VFl0eHUyczhmNEhtWUNZdDU4RC8yNVRLNUF3clpC?=
 =?gb2312?B?YUZudG9NUk1wKzJRbjN2a0RVMEtKcVcyVDJ3VzVpa2lQSDcyUDBKOTY1WVQw?=
 =?gb2312?B?UGpEZmVnYk9aM3NSS3lVRnlWUlV5alB1cE1yempVZVRGYnB3Ry9QQnI1NG92?=
 =?gb2312?B?UWFRc0VESmpHODRXSXB5RDhONWpXSjNoL1JISnFXNitaK29IOEZhWTVJNXV2?=
 =?gb2312?B?RDNxZEdiRUgraXo2OVN4RjJkU3FGYXBKTVNZVjZNMlFtVGRzaXBpRUtaSVBN?=
 =?gb2312?B?VXZKRzBlNEl5eDBQTlVPYzZXMlAxT0lUSXRibVpmU3JkKzlHZC95cGJyckNn?=
 =?gb2312?B?VjhmTmY2M3FXbzFTdmdaSjI0NHNTR1ErMnlNVnNheW1DdTFFMWUxeUllK3Fz?=
 =?gb2312?B?Q1RWT3FQaGVwSnpBTFFtMWZYYzd3MHZjVGtCRUY4QjlGNmxVNlg4NmFJS2cz?=
 =?gb2312?B?QzBKK1BhcnlQT2hUUVFQMC9Kanl2d0NtaitHY3Z4aGhGbGpleHlxdnE2R0VW?=
 =?gb2312?B?b21vVXdMYXZkMUFFcnFrTSt6L1VCb0tIMm9wSWFSc2VJNndMZ1NaRnNwOHdX?=
 =?gb2312?B?RHZUQ3RUUkRWYngyTHczUEY4UlZJTWhPZDJkcDYrMG9VRVlWcUJaY0dpeHlK?=
 =?gb2312?B?ekFpYjFaaHB5MTdGRVMzN1d5TTF0SXpaa1l4K01tcEcwcnI1YnAzcVhpc2lF?=
 =?gb2312?B?WkxOU0JxU0luK09XQWJTRVMvc0NoazY1Mk5ubm0zSXRnT2IwdVhTc05SUkpt?=
 =?gb2312?B?dUlWWmFkMTlUbW9XZW8xYk5wbUVEdzFlSUJhWS9rWkdnMXJPdVZsblNJUnpj?=
 =?gb2312?B?ZjNlYlpqS1lVWC9reENIbUc4enNBbVljSzhIQkM2dExQSXZnbUFjZ3BLQVJq?=
 =?gb2312?B?Uk5ueVFDcHp3TE1FcFg0a2k0TGgxMUQyY0RIckhhSVNvNVNIZXhmYkxZWWJL?=
 =?gb2312?B?VlVRbG5QcmlMZ1NXMGNmZDI5S0gyZFhzcG02eGkxcWNLWi9UZWVEWTBOeGhs?=
 =?gb2312?B?d000bjNMOWVOUVREcml2T2cwdHNKNTVkSFBaNFlFdGE0L1FLWmkrM294MWsv?=
 =?gb2312?B?cENvYVlIaG1sOGYzNWUrMjJpZUVDUGo1NVQ3RjVURWJCdDZVOWwrOEVsMXVF?=
 =?gb2312?B?R0J6K1Bic1p3czVLdXV4anprWllNemQ2eWtMNmtTeHlrbmJmcVFhbS9Kai9V?=
 =?gb2312?B?VXZUdXJVVnUrSkM1RG1tNFZaaFlFMUphVWF1cWFKWGhVYnB4cTB2UHNaaExy?=
 =?gb2312?B?VE1yYTJFV0xuT2RnZWtnRFppcXY4L3dsSHRhYXgwQ3BlaXNmSlhMbXNxdWlU?=
 =?gb2312?B?RWF2Yk42UGtaVnFLYUVIYUtKQzR5SGFtdGdZWmlSRE5jRHlXMTVBVXB0SWJM?=
 =?gb2312?B?NXpSem10T2JLL0JUYkNCUEtHM0c1ZGdwSW14aWp1UDNXUHBjZkJMbGJtQkNF?=
 =?gb2312?B?OVdxdFJ0RVR2T3BmWnlINUFrUnJjT0RlWUU5T3VDSnBjZnZXa2t1Ri94eUl1?=
 =?gb2312?B?amNZc20zS2Z3eTg5dWhKL3BmUGlOVWZ1bnFNditScVdHRzhsZjZFZDEvSUU4?=
 =?gb2312?B?MXpSQVVuMjg2VGNYSE43Q1hKY0JHK0sxbkZ4NjdQZHBQa2ljaStRMDdPWTNj?=
 =?gb2312?B?dDE3UWlReGZFbzE1VnM1VHRsNWpCSkFpS29jRmkvNWJwWDF6MFZGZ0FoK256?=
 =?gb2312?Q?ZK7BZY8tL9AiEpsvz9PCgBxkI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 918ba0d1-69a3-4f7c-3b2d-08dc8b449042
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 01:02:57.3785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNLqm0yuP4o5rYwYHrDvTH0PtOvgwp29ge3N+EuHYLm2OfZC1dMDuKvM+Yo9iU8/K3vGaEqf76mxdK33E1bRN0W+M+neqGDBmDaVDpgesYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

DQoNCj4gDQo+IE9uIFdlZCwgSnVuIDEyLCAyMDI0IGF0IDAxOjQ4OjU1QU0gKzAwMDAsIE1pbmRh
IENoZW4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgSnVuIDExLCAyMDI0
IGF0IDA5OjUyOjAwQU0gKzA4MDAsIE1pbmRhIENoZW4gd3JvdGU6DQo+ID4gPiA+IEFkZCBQQ0ll
IGR0cyBjb25maWd1cmFpb24gZm9yIEpINzExMCBTb0MgcGxhdGZvcm0uDQo+ID4gPiA+DQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IE1pbmRhIENoZW4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNv
bT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2gu
Y29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIC4uLi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAt
Y29tbW9uLmR0c2kgICAgICB8IDY0ICsrKysrKysrKysrKysrDQo+ID4gPiA+ICBhcmNoL3Jpc2N2
L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC5kdHNpICAgICAgfCA4Ng0KPiArKysrKysrKysrKysr
KysrKysrDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE1MCBpbnNlcnRpb25zKCspDQo+ID4g
PiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2po
NzExMC1jb21tb24uZHRzaQ0KPiA+ID4gPiBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUv
amg3MTEwLWNvbW1vbi5kdHNpDQo+ID4gPiA+IGluZGV4IDhmZjZlYTY0ZjA0OC4uMWRhNzM3OWY0
ZTA4IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2po
NzExMC1jb21tb24uZHRzaQ0KPiA+ID4gPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJm
aXZlL2poNzExMC1jb21tb24uZHRzaQ0KPiA+ID4gPiBAQCAtMjk0LDYgKzI5NCwyMiBAQA0KPiA+
ID4gPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gPiA+ID4gIH07DQo+ID4gPiA+DQo+ID4gPiA+ICsm
cGNpZTAgew0KPiA+ID4gPiArCXBlcnN0LWdwaW9zID0gPCZzeXNncGlvIDI2IEdQSU9fQUNUSVZF
X0xPVz47DQo+ID4gPiA+ICsJcGh5cyA9IDwmcGNpZXBoeTA+Ow0KPiA+ID4gPiArCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gPiA+ICsJcGluY3RybC0wID0gPCZwY2llMF9waW5zPjsN
Cj4gPiA+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gPiA+ICt9Ow0KPiA+ID4gPiArDQo+ID4g
PiA+ICsmcGNpZTEgew0KPiA+ID4gPiArCXBlcnN0LWdwaW9zID0gPCZzeXNncGlvIDI4IEdQSU9f
QUNUSVZFX0xPVz47DQo+ID4gPiA+ICsJcGh5cyA9IDwmcGNpZXBoeTE+Ow0KPiA+ID4gPiArCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gPiA+ICsJcGluY3RybC0wID0gPCZwY2llMV9w
aW5zPjsNCj4gPiA+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gPiA+ICt9Ow0KPiA+ID4NCj4g
PiA+IERvIGFsbCAzIG9mIHRoZSBtYXJzLCBzdGFyNjQgYW5kIHZpc2lvbmZpdmUgMiBoYXZlIGJv
dGggUENJZSBwb3J0cw0KPiA+ID4gZXhwb3NlZD8gSSBhc3N1bWUgaWYgb25lIGRvZXMsIGFsbCBk
b2VzLCBzaW5jZSB0aGV5J3JlIGJhc2ljYWxseSBpZGVudGljYWw/DQo+ID4NCj4gPiBWaXNpb25m
aXZlIDIgYW5kIG1pbGt2IG1hcnMgYXJlIGFsbCB0aGUgc2FtZS4gU3RhcjY0IGRvIE5PVCBlbmFi
bGUgUENJZTAsDQo+IFBDSWUxIHBpbnMgYXJlIHRoZSBzYW1lLg0KPiANCj4gVGhpcyBwYXRjaCBh
ZGRzIGJvdGggUENJZSBpbnN0YW5jZXMgZm9yIHRoZSBTdGFyNjQgdGhvdWdoLCBzaW5jZSB0aGF0
IGFsc28NCj4gaW5jbHVkZXMgamg3MTEwLWNvbW1vbi5kdHNpLiBJIHRoaW5rIHlvdSBuZWVkIHRv
IGVuYWJsZSB0aGVzZSBpbiB0aGUgYm9hcmQgZHRzDQo+IGZpbGVzIGluc3RlYWQ/DQoNCk9LLiBJ
IHdpbGwgZW5hYmxlIHRoZW0gaW4gYm9hcmQgZHRzIGZpbGUuIFRoYW5rcy4NCg==

