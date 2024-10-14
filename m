Return-Path: <linux-kernel+bounces-363045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17D499BD47
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265C71F21D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95CDF9D9;
	Mon, 14 Oct 2024 01:24:18 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2102.outbound.protection.partner.outlook.cn [139.219.17.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366BCD2FA;
	Mon, 14 Oct 2024 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869058; cv=fail; b=dQigS3QX8MNnQolwAenstyshdEy2W9do+U6IZplErfRNq6ZbJFroeLZ9UNcV29v3//B5NQa6nPuydB6WgaSqno6hTn8LXKAhvsDJ4aJs01//r3VJm0aI3mf7Y8DaQ9ZXG+yCEQ4uuO4eWBVMHtYVU7kvj2nN0o6yTx/bixpL5l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869058; c=relaxed/simple;
	bh=edFeEyUl3o36dC0SU0em86NpJu7PnB/92fdmiZ1uq4c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WUmPEIqR9cEpIuCMKH5i7tpeaXGzvCgud1+Mq2aAxneLSA6cikUqBL4/xMtkMj040qttdbXQwvleyhNM+LCKJ30eNStHorFKIGEpYET/+bFJWxa+9DTHv41du3OaG9sqWTcRQh0zmHDk0EA9IN1da/TeTg/QPhxSlP/GrQ+0AUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+JIQv7w+w/OLN3krxNHoVnRRvStH3yv3JcGmgO3X8/Elr5fIa6EaItdo0S8mlV5ZHCxK3KhEyXD7ZOldbAn0OCYEMOvhk2PnFN4P118Sl38N8//eB4aXENNwIKcq9+xDXigk8yVhOFsfzrJ5PMEtlJkeNB7zeKsuPRrHZAZ9VvlNEQWLYPwHQ83XXlmX8MsOsE1em7mZ7Bbpb3p0cZHQ4Y2HryAOPDIA/8ln5UEa0nKNvumnzVBTYl01eX4Wj6/36D8dsMhZD5SDb59DOozhwv6WbjkWsHEshaAi+PGFI93hf8kWRtrsNapalXg4DU7XRCG5FNAeS6j/QUZmw+hBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edFeEyUl3o36dC0SU0em86NpJu7PnB/92fdmiZ1uq4c=;
 b=oORN3CqtzwHV2J6aGUHXh2WEEtXhbWe2Vgwu8xaonp4iBTmPJK4ahZuhYXdhhwlP+avqCIzI7qKWR3URNtB8isdo63q1+gCv6r6YM66TUXNoSwAwVi0p58o6F1Yjr8vwBeKnKQtprX2HcTsxsaWQ4LcmoTc7w/jsll20i1Mi9W+FIxyHJpeWLPWhJLDT1vz3YPJlRlLygH35Uljo09GgQvnwFnp5/P+jtEvS1kmNiRJCn/NEtvBZw0X89fMr0KZG7oHvEF8V5d8oJt9qTAlJEjemnsN6eh9kP3yZM8C+mzXrCgoRjYduNZWhqJOJE9h5L0pWPcfgVzhINPrIegrUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB0997.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.15; Mon, 14 Oct
 2024 01:08:51 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%5])
 with mapi id 15.20.8048.020; Mon, 14 Oct 2024 01:08:51 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Aurelien Jarno <aurelien@aurel32.net>
CC: Conor Dooley <conor+dt@kernel.org>, Jack Zhu <jack.zhu@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, E Shattow
	<lucent@gmail.com>
Subject:
 =?gb2312?B?u9i4tDogW3YzXSByaXNjdjogZHRzOiBzdGFyZml2ZTogamg3MTEwOiBBZGQg?=
 =?gb2312?Q?camera_subsystem_nodes?=
Thread-Index: AQHaYuOc3DLoHtmcok6fGjHMmNfPx7KEj74AgAJUtFA=
Date: Mon, 14 Oct 2024 01:08:51 +0000
Message-ID:
 <ZQ0PR01MB13026F78B2580376095AF7E7F2442@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB0997:EE_
x-ms-office365-filtering-correlation-id: 470d2b24-591c-43ce-1d3f-08dcebecc420
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|38070700018;
x-microsoft-antispam-message-info:
 TgKwQQkOo8y5b8kgBhBmAB1qxa1pJDk/mgC1Jkj2zAkLj/IQi//QxsB4IOJYPbtlNXDxKwbekr4iVde2qQbSt0K4TMMoUpppVtYUXZM5NNnFVWTuQw0fWy07ylVZQhIcuzezMBKKxlknrf+nonWe1liKhDTmPI1Xe3sYrh5Rjo86lycvSr9XuxDfT+qJzev5WbuXUSB05PQksMglgqXiEvpWFVx1T3RjOcYRBps6wFFZDbeZvXWzCqEIEQ1hPcdtMOuPSVH9+iaP7qQPAm3EZSKMMc2mt1XixyOm+Ks5wludDSR0QxyHr+wv/1dPwuWOKK9WJE/0beAeBY/vVmRFbVxWTEcdL5oEpWsgw6BYTEHwmRcGOLduK+3Op0B92Ll52j4b7M2YMZL1e8A8XCunVT1sSibkzAEWFqzYp9v1zhbIcI318LVJdJIaAsvV4PlYFqEDD+jXbNkQu74HQsE9TqWqZQic6eEwZIiPVZNCn4bxVy5zyNLYmTX4RCMZ08hKnZL7RKZkaW3k2zU6wWig+hJ5f90LRqH+tXVmphLNAasrKCTVM1EBfrhpf9ffVXVy2dD2sAAXOHdySX1/7zWX3Sg1QW521nDDhqqWsWRpvQ61y1zmTrQTbo19dZuz/s5x
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?L2oraWNEelRHQ2p2QktWWGZGZmF5QXBBYWpXcmVJS0tDcVpGdjFQcXFkL0tI?=
 =?gb2312?B?NEsyWkNPcHBMbXQzdVBUSXljSndhSUcweEcyRnhiQ1BQR0w1b004MDAzUk1x?=
 =?gb2312?B?UU5kR3QvRW1IU0pCSmF1WW5WRjBTYVVqbUxvUGNFNUFyTW10RXAwQkFENHVz?=
 =?gb2312?B?RVQzdjZ2YVFtSU1LTkE1L3BSM1p4L1REVkgzWGZOVzVRVjd0MjdJejFXMFUz?=
 =?gb2312?B?TnN3ZG8rMnRFUENidzZra1AyTlFuVzlyeG5HWktubnUwajhMQkF2aDQvVjVq?=
 =?gb2312?B?a2Z4VnRKeU5pa3BPTk43VUxOMVYvb2JUNmVBU3l3TUprYmthNTFHNlBxQytk?=
 =?gb2312?B?N3poajNBVGFrcmtpLzRwdzBEakxVVEJaeTNBUWwvcldFR2VpYWhzT0g0YTVy?=
 =?gb2312?B?TEtUbVh4TEpkZTR3dUE4TFB4MUo0NGMxS0UwemVGOEh1Y0RSSzBJVnEyTFEr?=
 =?gb2312?B?N2NYUUxJR0pjUTZBenRyL0hoMzl0dE9xK0EvUE0wNkNyUm80TCtEVmViblRX?=
 =?gb2312?B?aUN2NENaRzZwOVVkazdtZGM1NEs0dFVpcjcxdlV5VmhMZE9hRXRJUTFMMm1L?=
 =?gb2312?B?UWJ0aUZHVis5dnh2VjByVk15eWpMd2syemlqTjBtMjEwczRQSHpsT1BDdDFv?=
 =?gb2312?B?SUs3NzF1Y2FQUWVlOEgyUmRha2tGNjA2azFTc2c4NmluQnFvcGROZnRMYits?=
 =?gb2312?B?ZE1TU1gwNFlXSmJKbzVDTWN1WkY3aVE5ZTBINE1UQVdqM0FWTU9JeXViU054?=
 =?gb2312?B?NnVLWHZQdC9VSnRHQTN5Smt0dzNacUFHWVM3MEgvVkYwRzZzOTFFWWs4Nkxi?=
 =?gb2312?B?U2daWFdPSnErYUF6Vks3dGd6dzQvbmRZTWdjcUhKc3QvRU9EREdqbXpZOFdk?=
 =?gb2312?B?citkZEl1NStkd0J5Y3pUbzZCdVE2TjB3MXZQN3pwUnZZU3RGK1A1QjZ5cUt5?=
 =?gb2312?B?QkMzcUpXa2crbG5lUTZrQU9oaXRjRVNVaHdMZCtrNlhtTzhWWXJWbWtyajVL?=
 =?gb2312?B?THMwUDYzKy9SSlZhYU9JeEFPQ25JanNrMmRGL3N4OUx1US83ZS9kdTNxUXBM?=
 =?gb2312?B?VG5oMVU4akRDSlo0RG9WaVlzTkxRNTBKSGlWTC9JNnFtQ2V2NU1TK2wxbWRo?=
 =?gb2312?B?ODdRWlRTYS9vZTMxMzZhUHFUcEJxTjdHQ3Y0bUxZbnpYcWFrUkNZM2pnd0ZD?=
 =?gb2312?B?ejBtbkRhUlQxTlk1TGE2Q1ZxYTlva0s1aVFkd0hpTG1yZ2hUUW9MUzNYYWRC?=
 =?gb2312?B?Skhrb0V5WTJmTnlMSVNURTlqRjBoQUtFWlNQWTc4bWZIUVNWSkN0Y3BVemxH?=
 =?gb2312?B?aFVSRkVBWTdvN3BhU3FXRnh5L0NEcGsyb1NhQ3VIWkJJdFh4VWN0NmxhN3Uy?=
 =?gb2312?B?R1orVUExaEllWE9BSjhyYjZLQnJYQVlFL08wQ3I1L2ZZTElSUjBPRVlhT05V?=
 =?gb2312?B?Y1RTMUdnRVF3S09Wc1VGZldsU3RWeXR0cnFUUWtTNHorbnVZY0FVY0l2Z05P?=
 =?gb2312?B?SFdZWHg5cnZ0SnJDbGQveGh4VWRacEwwQ1gxbzkybmVJS1p5N0tyRHF5Zno1?=
 =?gb2312?B?WnBxZnpiZ2xPQXZUREY4ZEszRGJoNGNDaGc5UGZZcDJBTkNBUVBuR3h3bStt?=
 =?gb2312?B?cVVETEpnSFU4NktIMld0L0xiVEZwR3ZhdGVGdVBYeDEybFpsbFRGbGxWSmcw?=
 =?gb2312?B?M1dzVERmV2ZnN1RCWEs1dXBwUFloQjY1ZU0zcllpUCtZNi9hTlByYmI3Z2lC?=
 =?gb2312?B?MndRY1hSUWpuMkQ4RkZPQVNub24rckhlZ0JXT1Y4T3RyNXdKUE0wWmhzVGpK?=
 =?gb2312?B?NEM4R2dEUEF5VVNmUUxkTnN4SDdOdVNlb3RqQ1k4dkpKVGVndlJJWjIzbk9o?=
 =?gb2312?B?dSsrQ3AvOU0xMnBhQ01NTTMvVkp6NlF4NmJtVmVPU2R5TWZQMGhjcW1TRnI2?=
 =?gb2312?B?VEpMM0VQUHJ6dW5heDZYM3FIczYzREtkVFc4ZC9iQll3THBOVm80QzFISTVP?=
 =?gb2312?B?NVh2ZytWT21SMGNTc3RpREVJQk9mZTFyNnZHUElYRS9tRzl2NzJPUEZQdkY2?=
 =?gb2312?B?Ui9PRnVyNnhEeFQrQnBPcDh3YVVtdVpwNlVTQVZyYW00Q01xeXQxMjd3ajJB?=
 =?gb2312?B?OXk3U3lXWlEzS0t6TnNmWVg1TmJwNVBvYzZucUd1b0lXQkNSVldmWUkyMmNX?=
 =?gb2312?B?K2c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 470d2b24-591c-43ce-1d3f-08dcebecc420
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 01:08:51.4427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jffcDqtcYxzEcabYzpVIQOG/kRem8gJUzkpiAXlk+/EHpsqd5YlzmocNMeRWWrzavffEV2CNdcpNFkfZi8uppocNtVBdMHJx7YdG5qmaLJaSqBewhfvc2nWFLpfeKb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0997

SGksIEF1cmVsaWVuDQoNCj4gDQo+IEhpLA0KPiANCj4gT24gMjAyNC0wMi0xOCAxOToyNywgQ2hh
bmdodWFuZyBMaWFuZyB3cm90ZToNCj4gPiBBZGQgY2FtZXJhIHN1YnN5c3RlbSBub2RlcyBmb3Ig
dGhlIFN0YXJGaXZlIEpINzExMCBTb0MuIFRoZXkgY29udGFpbg0KPiA+IHRoZSBkcGh5LXJ4LCBj
c2kycngsIGNhbXNzIG5vZGVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hhbmdodWFuZyBM
aWFuZyA8Y2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpICAgICAgICAgfCA0OSArKysrKysr
KysrKysrKw0KPiA+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC5kdHNpICAg
ICAgfCA2Nw0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTE2
IGluc2VydGlvbnMoKykNCj4gDQo+IFdlIGhhdmUgYmVlbiBhc2tlZCB0byBlbmFibGUgQ09ORklH
X1ZJREVPX1NUQVJGSVZFX0NBTVNTIGluIHRoZQ0KPiBEZWJpYW4ga2VybmVsLCB3aGljaCBmcm9t
IG15IHVuZGVyc3RhbmRpbmcgYW5kIGdpdmVuIHRoZSBkZXZpY2UgdHJlZSBzaG93bg0KPiBiZWxv
dyBhbHNvIHJlcXVpcmVzIGVuYWJsaW5nIENPTkZJR19WSURFT19DQURFTkNFX0NTSTJSWC4gVGhh
dCBzYWlkDQo+IGRvaW5nIHNvIHRyaWdnZXJzIHRoZSBmb2xsb3dpbmcgZXJyb3IgaW4gZG1lc2c6
DQo+IA0KPiBbICAgMjUuMTQzMjgyXSBjZG5zLWNzaTJyeCAxOTgwMDAwMC5jc2k6IHByb2JlIHdp
dGggZHJpdmVyIGNkbnMtY3NpMnJ4DQo+IGZhaWxlZCB3aXRoIGVycm9yIC0yMg0KPiANCj4gRnJv
bSBhIHF1aWNrIGxvb2sgaXQgc2VlbXMgdGhlcmUgaXMgc29tZXRoaW5nIGluIHRoZSBwb3J0QDAg
Y3NpMnJ4IGVudHJ5LiBEbw0KPiB5b3UgaGFwcGVuIHRvIGtub3cgd2hhdCBpcyB3cm9uZz8NCj4g
DQoNCllvdSBuZWVkIHRvIGFkZCB5b3VyIHNlbnNvciBub2RlLiBZb3UgY2FuIHJlZmVyIHRvIHRo
aXMgcGF0Y2g6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmlz
Y3YvcGF0Y2gvMjAyNDAxMTkxMDA2MzkuODQwMjktMy1jaGFuZ2h1YW5nLmxpYW5nQHN0YXJmaXZl
dGVjaC5jb20vDQoNCldlIHN1Z2dlc3QgdGhhdCB1c2luZyB0aGUgaW14MjE5DQoNCj4gVGhhbmtz
DQo+IEF1cmVsaWVuDQo+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2FyY2gvcmlzY3YvYm9vdC9k
dHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpDQo+ID4gYi9hcmNo
L3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRz
aQ0KPiA+IGluZGV4IGI4OWU5NzkxZWZhNy4uNzM3ZWU5N2EzNTc3IDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUt
Mi5kdHNpDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtc3Rh
cmZpdmUtdmlzaW9uZml2ZS0yLmR0c2kNCj4gPiBAQCAtMTI1LDYgKzEyNSw1NSBAQCAmdGRtX2V4
dCB7DQo+ID4gIAljbG9jay1mcmVxdWVuY3kgPSA8NDkxNTIwMDA+Ow0KPiA+ICB9Ow0KPiA+DQo+
ID4gKyZjYW1zcyB7DQo+ID4gKwlhc3NpZ25lZC1jbG9ja3MgPSA8JmlzcGNyZyBKSDcxMTBfSVNQ
Q0xLX0RPTTRfQVBCX0ZVTkM+LA0KPiA+ICsJCQkgIDwmaXNwY3JnIEpINzExMF9JU1BDTEtfTUlQ
SV9SWDBfUFhMPjsNCj4gPiArCWFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDQ5NTAwMDAwPiwgPDE5
ODAwMDAwMD47DQo+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gKw0KPiA+ICsJcG9ydHMgew0K
PiA+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsJCSNzaXplLWNlbGxzID0gPDA+Ow0K
PiA+ICsNCj4gPiArCQlwb3J0QDAgew0KPiA+ICsJCQlyZWcgPSA8MD47DQo+ID4gKwkJfTsNCj4g
PiArDQo+ID4gKwkJcG9ydEAxIHsNCj4gPiArCQkJcmVnID0gPDE+Ow0KPiA+ICsNCj4gPiArCQkJ
Y2Ftc3NfZnJvbV9jc2kycng6IGVuZHBvaW50IHsNCj4gPiArCQkJCXJlbW90ZS1lbmRwb2ludCA9
IDwmY3NpMnJ4X3RvX2NhbXNzPjsNCj4gPiArCQkJfTsNCj4gPiArCQl9Ow0KPiA+ICsJfTsNCj4g
PiArfTsNCj4gPiArDQo+ID4gKyZjc2kycnggew0KPiA+ICsJYXNzaWduZWQtY2xvY2tzID0gPCZp
c3BjcmcgSkg3MTEwX0lTUENMS19WSU5fU1lTPjsNCj4gPiArCWFzc2lnbmVkLWNsb2NrLXJhdGVz
ID0gPDI5NzAwMDAwMD47DQo+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gKw0KPiA+ICsJcG9y
dHMgew0KPiA+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsJCSNzaXplLWNlbGxzID0g
PDA+Ow0KPiA+ICsNCj4gPiArCQlwb3J0QDAgew0KPiA+ICsJCQlyZWcgPSA8MD47DQo+ID4gKw0K
PiA+ICsJCQkvKiByZW1vdGUgTUlQSSBzZW5zb3IgZW5kcG9pbnQgKi8NCj4gPiArCQl9Ow0KPiA+
ICsNCj4gPiArCQlwb3J0QDEgew0KPiA+ICsJCQlyZWcgPSA8MT47DQo+ID4gKw0KPiA+ICsJCQlj
c2kycnhfdG9fY2Ftc3M6IGVuZHBvaW50IHsNCj4gPiArCQkJCXJlbW90ZS1lbmRwb2ludCA9IDwm
Y2Ftc3NfZnJvbV9jc2kycng+Ow0KPiA+ICsJCQl9Ow0KPiA+ICsJCX07DQo+ID4gKwl9Ow0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiAgJmdtYWMwIHsNCj4gPiAgCXBoeS1oYW5kbGUgPSA8JnBoeTA+Ow0K
PiA+ICAJcGh5LW1vZGUgPSAicmdtaWktaWQiOw0KPiANCj4gDQo+IC0tDQo+IEF1cmVsaWVuIEph
cm5vICAgICAgICAgICAgICAgICAgICAgICAgICBHUEc6IDQwOTZSLzFEREQ4QzlCDQo+IGF1cmVs
aWVuQGF1cmVsMzIubmV0ICAgICAgICAgICAgICAgICAgICAgaHR0cDovL2F1cmVsMzIubmV0DQoN
ClRoYW5rcywgDQpjaGFuZ2h1YW5nDQoNCg==

