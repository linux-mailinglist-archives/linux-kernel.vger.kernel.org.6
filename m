Return-Path: <linux-kernel+bounces-186013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B3A8CBE95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789261C21157
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A381741;
	Wed, 22 May 2024 09:52:15 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFBE81724;
	Wed, 22 May 2024 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371534; cv=fail; b=JXuketLkiV83Fjv7E24l6d8Im1W/s3C+f61oqIwl2MtAyUBejOpi8Ps35VrMzFFzhrrkWDditGALlDb5DAn+4ZGOdbKyONOcBB/W+q5zTurltK91Gj8bAlpIPc1O8C961WAn+PEfEgO4Taqz6coiRxUsPDOuD9ue4MCOHZENSR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371534; c=relaxed/simple;
	bh=1V5nxj8qMESDtF2XgCr77XVdnWPAOUfgTRJc4QYeM7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bWV2lu5oUd7iwFr407+2JfvP23JeWXc+5+4SFCOvy/5ts2+YDTGQBfuE3zlKHbFOBhfAK/FWsspYAH9F2aDfQNRd6SroYSs+L1g2WUgka1/pdGPA9ky9keCVZuBhkIzsDy0/Sz2xhS44J1jbw/UXsfZojbxq1UyDTOYqpXyzsc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ipw31Ksr7RT7AmbuTLBpLG22/AmEmN5Ga2wzZiFyeRWZGFhb2wleI27hqE3W0wIsQf3VhXMzJnzuN/oh/J+SDBrjJK6DSpYs32q4c9W/vI34y7JYsSOPyvCKcN+eqqdtcbd1TzZr/a84mkRSavaShdVUP50WnI2pVokVVh+dJ0wq/qJN4Zz41s42hrjgF7a80vf89NH6pWy905NZ69B7ZX1yOc/PM50ihvvsshHiaO1K27Y8jHLbNO26ej536/6cM/2/aa1EMR/S96gc48IaJ30CkUWeVzUElBJgQVckfPYV5gvKn142ZSVGsLAp8zMJEYJhN7+flsdbAhF1ngZErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1V5nxj8qMESDtF2XgCr77XVdnWPAOUfgTRJc4QYeM7k=;
 b=HpfX0+Qd++wrdIeejBZBfYbjnEPiKQS0TGp9BxUIraE0jYgwiCoSVHIk8qbj1qS4v4WBnjE16ErZ/B3nBpbMY8pRBjTRSB+KgPbteQ1GZuHY9wr6gbGuKCJ/KyVMLFlXOit6b+3HYzLmMNiVc5o9qOmE7dy1flcer4iD77DpTBsfHBdJPD+ZOuHet6irCSnFlM3M0oHZkwIgZVYlb2FKEtLb2n707lnTbJuGqZvelSxYnPbBPtU9Qt2T7C9N7lc09+4bSZGhNhYaM/Nqh6M2plcLBmFtN+tfW/SEv9PN2SjdHx9NbXdS3pRT0JUzhRZ0vfOrVDv7mSyoEIYgcS69oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14) by NTZPR01MB1116.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Wed, 22 May
 2024 09:37:36 +0000
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::4c03:2f99:7620:9c03]) by
 NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn ([fe80::4c03:2f99:7620:9c03%4])
 with mapi id 15.20.7472.033; Wed, 22 May 2024 09:37:35 +0000
From: Ziv Xu <ziv.xu@starfivetech.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Walker Chen
	<walker.chen@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW1BBVENIIHYxMCAyLzNdIGNsb2Nr?=
 =?utf-8?Q?source:_Add_JH7110_timer_driver?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2MTAgMi8zXSBjbG9ja3NvdXJjZTog?=
 =?utf-8?Q?Add_JH7110_timer_driver?=
Thread-Index: AQHajLXUwJ1xHqE2bkSj75330O2of7GAcubAgABDRoCACtiYkIAAIO+AgBd+BAA=
Date: Wed, 22 May 2024 09:37:35 +0000
Message-ID:
 <NTZPR01MB098641AFFB96AE34AD0C7C1EE1EB2@NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn>
References: <20240412084543.7243-1-ziv.xu@starfivetech.com>
 <20240412084543.7243-3-ziv.xu@starfivetech.com>
 <NTZPR01MB09860632D4BDB31B98E1BD18E11AA@NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z8U5ddBg_T34rHYUXQcTLdzhMhbhv3mZxehQL8VLBFtUA@mail.gmail.com>
 <NTZPR01MB0986380E0F7930DF653D7807E1E4A@NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z9mTeRKxt3gc_c-APn0oUm=oZEkF1wsNxwSkDPCXUTLGA@mail.gmail.com>
In-Reply-To:
 <CAJM55Z9mTeRKxt3gc_c-APn0oUm=oZEkF1wsNxwSkDPCXUTLGA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0986:EE_|NTZPR01MB1116:EE_
x-ms-office365-filtering-correlation-id: 5087898e-8b39-47aa-43c5-08dc7a42d039
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|1800799015|41320700004|38070700009;
x-microsoft-antispam-message-info:
 QgLWLNBG3505ulnW/KfozEmyFFa+Eckhs4Jb0JyXkHjT5ram9DxP067EWpMl978RiKTkMNZpJ0UBXLF9rZ0DKZe67wcQX87c+sQNjRUtWIEfXYfbKgT0NWe0ZhEM0EikSX1ulEQwH2B3dxrdlLKwuSMuXZAd6sRFWjIN+p2CzlcYaavFKq/o8MoRKyNyoC7/qwohe+Q0z7AHVR/iPz72vqssO2ohKc3QgKs18nEu8PuMepjZYCaSzn+9j9IdrNvDrtYZnSM1nnSycmQoKSMVKsdKmnl54+7bp8SgTWe3zYn4aZBZJdAYzbPg8qo8rSOysomzwEyUwFDcBsMoxhMCibHmS52yqvsSC0KwCfdmpYcibJ7N8spw9eHVKqAYTpDksV+BqZnFegvjnRcgCV9FrF2jl6qhkDYXtKYK1YygRMMukIgXbaYkwPeYqJEudhcqsknr9KFyUcm+h1NRbesLyjfoKDygV8Ttyud496o8gAdIYbICvoHD+Iavr7+txGblVrZaW4NIQ8GxvpDhu6b3iIizC+0joCInGv440BcA9E6VjlawQLABIosKcSsSs3hoCyeBbQQBhEJMaKRaLFv+/EiX/n/uSPZR/GLyCYGcTopNXUeuEEbu0I692EWxjIfk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2ZFVW9PblZWM2ttd2I2Yllsa3JSYWxBbGVkN1UxL3Bsd2Zwa3A4TE1RaDZU?=
 =?utf-8?B?NS9YYlpsWTE1NDRkVGFnMzJqcFdvN3lZV0wyV0l0MUtpSHczR3pKM0V2MFNV?=
 =?utf-8?B?aFFSSW5wWkZTd3FRVVRkK2ZvbkJrYmd4dnBtZVJXSGEzdlVENXkzWXIyNW4x?=
 =?utf-8?B?VGtRRk5HcUV6TG0rNmdBbmpid1VYazhvQjhCVXdoUXArTEV0Rnd6ZW00eVRY?=
 =?utf-8?B?MXkwNVBTZUw3YWVVdk82Uk1kTnNSc2MrcDJnQnYvclk2dkRZUnluY212OVY4?=
 =?utf-8?B?NlBDMzZ2QUZXSGNZNzhMT0V0UFprUEVJTHhkSWJoVDkyOVNMV2lTMDk2cjQ5?=
 =?utf-8?B?TXpDZ01ZcWtQY2dtZHA4TjhCWHZYc3VTRUhKaTdPSGJWQXBsc1RWcnFoVWJU?=
 =?utf-8?B?RDM1NlIyclpMWUVxVG42REpZcmNXTzBGVEJ6NndDc2lWNWVHK0gwbzhlYXVk?=
 =?utf-8?B?Q1g1dnhFU2laOG5OY1F0bVhHVXV2Y2l6NkwxZitzNXFqUlg3MjBqNElxNG00?=
 =?utf-8?B?aW12Wm1UTzZvaFRPTTdiYVZ4S3dwM01EdVBXWmpRdzhKSlh3K0htL2hpbjZk?=
 =?utf-8?B?ekpHc3VtSjdYQVF1aHFpNDE1WEJpVktaVjU2cXZoQm5CS1haLzIwVk90eFQ3?=
 =?utf-8?B?ZlJKRlFpVS9DNVVQSmNkdGVwckMrSll6Q01MYkxpOUEzVVZYS2pKNnVOUFV6?=
 =?utf-8?B?Z3pCaHRrNWpjSkJsSTlRbXFJRm5udjZMVWNqODBZWi9nNWgvc1AzckJoaHNo?=
 =?utf-8?B?SDBNbG5oNGxJNGNXTFhIMk56d1pXVlNhVXVmV2lBVjBxNklqcjVUaEtlZnN1?=
 =?utf-8?B?VFBsbUgvdHorcXVwNnJYVlc3blNXTi94dEtNQkE1a2krVWVSSnd5ZFZzM1d3?=
 =?utf-8?B?UWN5Y3Q0OHFUZXd1V05WeVZJQXJjQlhxNFZZV1l5M0lSaFNYRGFwWVFyOWpZ?=
 =?utf-8?B?U3EyS0YzM2oydHVQTTlBbjZTSCtac2RkdVJod1R2bksxeGRvbzgzR0Zid2Fx?=
 =?utf-8?B?djBDSEdrc1A3eW5rV05ubm15dGd5MXhVVkxtUXZ2Mk1TWStUNUo2RGZaYTdI?=
 =?utf-8?B?TmNqaG8zdlNLNmNxVXdZZW5BUnJQYXNlbjNob2U0YytzdXkrWXl3WU81cjJG?=
 =?utf-8?B?aG1FZ1RhWHRWNXRLQmFjeEZLL2wwNzQ0bGtZU1BOM1FEZjFjOXhVVzdQWlc2?=
 =?utf-8?B?OXErRzVjTnlhMG4rbDZiVWRUSXVmMEpwdGJpcnRvVTRiWW9qcXFhUmNvbDgz?=
 =?utf-8?B?OWUwZ3N1RXBaQnpSbzFGWUQyUGRkZTNEYTZDcFJvL25DaEpyaEwrOWdPYW1z?=
 =?utf-8?B?MHg3YWRoM2Q5dkZlMG5temgwK0F1YjFxKzdsdUR0MUlHT1N1YlQ2enFvdzF6?=
 =?utf-8?B?WldWeDQ4MGx4dlhYRXEvMmVDUmU3VjMyTjBwcm1qTDB4cVk0aWE2ZXMra29x?=
 =?utf-8?B?Q1ZkcTZWMW5yaHpjNUtuN09IRWVnRFpJUDdqZDhpSFFpb1FwalVxa255Smls?=
 =?utf-8?B?cTJHaC8rck44ZkhVL1VRYnB4VlM1a29kdmFGbFhMdStaODZxK2JDVENxUmVk?=
 =?utf-8?B?VEw4eW1oU2lOVVBHZ29KSEZJTDJmTFEwUFFKbFpvQ2RvV2tXblU2amZ2b2hw?=
 =?utf-8?B?dlE1NGM1SFI5OTJFTHhDVkZlSFhYbXVYVW9tbmJ6TjNlVmVpQmJRSUZQaFJq?=
 =?utf-8?B?RWp6dkJNKzNSYVZYMHQydE5Pa1FCc1ZydFFUeEg1RXdkZ2x2VU5sNDAwa0NU?=
 =?utf-8?B?bnRaMmJSTGxoOEpHY285ZW95OVFxcUtwdE16TitRZ3NoeEFBdHJIMURuTjcx?=
 =?utf-8?B?eFdZQzVya1RFSFdYWUduVzFON0F6b0FKaFNvbTRqNmU2TkViT3ZTdWwxTVcx?=
 =?utf-8?B?MjVuVjJqOHIzTEpNalVVRXUzYmdaNUp5U1NIQ0IyVk1SUzM0MjU0Tmk4VFR0?=
 =?utf-8?B?VlliWmhWS2pUQUVsQ2ZSNE9KN2NQb21GTVNiMThETTZoeGE4RnVGaUdURnJO?=
 =?utf-8?B?VnVhUjRiRGlVZ2haWUJYb04vUG9TMDRBK2MxUlVaSklLbjVxODI2QWZZUVVS?=
 =?utf-8?B?ZG1SMDVpM2tEOU4vUThMK0RjOWkzWFJKVngzSlpDUzJMdUlzMjNONjdEME1v?=
 =?utf-8?Q?dwupWNc1+NSFyquG3fWeVLHvp?=
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
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 5087898e-8b39-47aa-43c5-08dc7a42d039
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 09:37:35.9506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qb65itcfVYDSVMya7ZrUBLgVAtP0CyU8AkP/p4myeahZNB/0n0/2gzWQQvRJhrxgJaJcmnjy6QXVhfCLBv1T1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1116

RW1pbCB3cm90ZToNCj4gDQo+ID4gPiA+IEhpIERhbmllbCAvIFRob21hcw0KPiA+ID4gPg0KPiA+
ID4gPiBJIGhhdmUgc3VibWl0dGVkIG5ldyB2ZXJzaW9uIG9mIHBhdGNoIGZvciBqaDcxMTAgdGlt
ZXIgZHJpdmVyLg0KPiA+ID4gPiBDb3VsZCB5b3UgcGxlYXNlDQo+ID4gPiBoZWxwIHRvIHJldmll
dyBhbmQgZ2l2ZSB5b3VyIGNvbW1lbnRzPw0KPiA+ID4gPiBUaGFua3MgYSBsb3QhDQo+ID4gPg0K
PiA+ID4gSGkgWml2DQo+ID4gPg0KPiA+ID4gSSB0cmllZCB0aGlzIG9uIDYuOS1yYzYgb24gbXkg
VkYyLiBJdCBib290cywgYnV0IHZlcnkgc2xvd2x5IGFuZA0KPiA+ID4gImNob3BweSIuIFRoYXQg
aXMgaXQgcmVwZWF0ZWRseSBydW5zIGZvciA8MXMgYW5kIHRoZW4gaGFuZ3MgZm9yIGFib3V0IDRz
Lg0KPiA+ID4NCj4gPiA+IERvZXMgdGhpcyBwYXRjaCB3b3JrIGZvciB5b3U/DQo+ID4gPg0KPiA+
ID4gL0VtaWwNCj4gPg0KPiA+IEhpLCBFbWlsDQo+ID4NCj4gPiBJIHRyaWVkIHRoaXMgb24gNi45
LXJjNyBhbmQgNi45LXJjNywgYnV0IGl0IGRvZXNuJ3QgcmVwcm9kdWNlIHRoZSBwaGVub21lbm9u
DQo+IHlvdSBzYWlkLg0KPiA+IFRoZSBhdHRhY2htZW50IGlzIHRoZSBsb2cgZm9yIDYuOS1yYzYu
IENvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgeW91ciBjb25maWcgZmlsZQ0KPiAoc3RhcmZpdmVfdmlz
aW9uZml2ZTJfZGVmY29uZmlnIG9yIC5jb25maWcpIHdpdGggbWU/DQo+IA0KPiBZZWFoLCBJIGp1
c3QgdHJpZWQgYWdhaW4gb24gNi45LXJjNyAoKyBDb25vcidzIHJpc2N2LWR0LWZvci1uZXh0LCBN
aW5kYSdzIFBDSWUNCj4gcGF0Y2hlcyBhbmQgdGhlIFBXTSBkcml2ZXIpIHdpdGggdGhpcyBjb25m
aWc6DQo+IA0KPiBodHRwczovL3NwcnVuZ2UudXMva2lYWGJhDQo+IA0KPiBJIGRvbid0IGtub3cg
aWYgaXQgbWFrZXMgYSBkaWZmZXJlbmNlIGJ1dCBteSBhbHNvIGJvYXJkIGJvb3RzIHZpYSBFRkku
DQo+IA0KPiAvRW1pbA0KDQpIaSwgRW1pbA0KDQpUaGUgY2F1c2Ugb2YgYm9vdGluZyBzbG93bHkg
aXMgdGhhdCB3aGVuIEpINzExMC1UaW1lciBpcyByZWdpc3RlcmVkIGFzIGNsb2NrZXZlbnQgZGV2
aWNlLCB0aGUgc29mdCB0aW1lciB3aWxsIGJlIHBlbmRpbmcgd2hpbGUNCnRoZSBjcm5nIHRyaWVz
IHRvIGdlbmVyYXRlIGVudHJvcHkodHJ5X3RvX2dlbmVyYXRlX2VudHJvcHkgZnVuY2l0aW9uIGlu
IGxpbnV4L2RyaXZlci9jaGFyL3JhbmRvbS5jKS4NClRoaXMgY2FuIGJlIGF2b2lkZWQgd2l0aCBz
ZXR0aW5nIENPTkZJR19IV19SQU5ET00gYW5kIENPTkZJR19IV19SQU5ET01fSkg3MTEwIGFzICJ5
Ii4gQnV0IEkgY2FuJ3QgZmluZCBhIHJvb3QgY2FzdWUuDQoNCkNvdWxkIHlvdSBwbGVhc2UgZ2l2
ZSBtZSBzb21lIGFkdmljZT8NCg0KQmVzdCBSZWdhcmRzDQpaaXYuWHUgDQo=

