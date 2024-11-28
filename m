Return-Path: <linux-kernel+bounces-424109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3146F9DB0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CB0166AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EC21E87B;
	Thu, 28 Nov 2024 01:31:02 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC08467;
	Thu, 28 Nov 2024 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757461; cv=fail; b=E8EWEjJcCyVLSPZdsN5qTa0DF+7UFYONaOesHL74Dt3qc9zoDlVRXMtOTcAb0xf1rjBL0XipdhXOAmCu8cL4WGbzYt42RjuESqRdBWXYB6Lt9lawXYalSH6I1c1OctfMTVPDZOhVdqY1bJ73RXOfUKT9KHoIQhDW+5fZCg0GBas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757461; c=relaxed/simple;
	bh=Bf5Cb/LeDIRwvu3jTmWJ700f3MHu6ShchTtpWKA8pv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cALnySwKO9mi3Rsd9G32/8wSzCeFE8YNKasyxKOmAzULwp2GH0baL9wmfxKNNjo6mdM4TvJAtUKfig4WLEIAj94tGDlqfKzMEbDkPnCP+qmYGyP4Qg8mzzHAo6Yl3mqCIMs5/bUvcULUfuG9WeFOXG4KlL91DTLFY4Bw+Zr3meI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKV1vJr6KM5mEPW8whMdYciznY86XDll2iFIB74nqxSodZ/XrGxipOUVIsWv8ev/jATDvhlUbCfD4YDJpZlzybsWHm7z4r4JC9pPw9x5CY/vsagpBvsdOPGfshupV5aWyelovWoUaY32r1g/XdR0eeaBb+ui9tmjDEqqgEshRM9Cyv192LCe1tH3iBYSYCPZe5hEYWhyyeWF6Kif1qYxv3TeZA6vp3CL267e9dwyD1jphUS6UVmiaHSBObb6dLblpGOar2yIYTcC4hcmX/4BuONj680Q08vWix1z9p23wpGBfsk9SeSroRq7M47ErkFoeELG99jwztw51TzN0jb5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf5Cb/LeDIRwvu3jTmWJ700f3MHu6ShchTtpWKA8pv8=;
 b=I/UNmntafLnY2jdbKeVvP9k+/DWHjCLAQSQuoCTuiw7+Mer5q3YVNWaU1JOQdk1mMuw07ifVvvhS2s9hSjzoFLHP2/isHVd2AGtFSzcCqlc5OLpnkSyC6fU3XHgb3DVR6Tt778WDX3VnaX3kmwqJRHIg0UA0P/K1DfdBvxE8V+TAmbc3FLVIYTwVz2QOlzZ2FG3WWAPJz3HN8ce8mHtXvcPHD6s2jjIDINOjRq43URX1e+ZdXAKHA2lff5oBgibqseAturhozsj3a53ZuKQganzC8IgftUeM8vUaJmVjw6Mqy6DH4LqpjzxCODgQrYHD6JmdPjMDMQ6D66/UWp1SxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0766.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.22; Thu, 28 Nov
 2024 01:31:04 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.8158.024; Thu, 28 Nov 2024 01:31:04 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, E Shattow
	<e@freeshell.de>, Jisheng Zhang <jszhang@kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v5 0/1] riscv: dts: starfive: jh7110-milkv-mars: enable
 usb0 host function
Thread-Topic: [PATCH v5 0/1] riscv: dts: starfive: jh7110-milkv-mars: enable
 usb0 host function
Thread-Index: AQHbQMLfDfZzD0SJ20qNmmZxwfIJNrLLG7qAgADNAjA=
Date: Thu, 28 Nov 2024 01:31:04 +0000
Message-ID:
 <SHXPR01MB086308813C0B311845FDA2C7E629A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20241126075740.17419-1-e@freeshell.de>
 <CAJM55Z9wWCaS+FxZ=Gg_RfXXafNEJZC1zHZoPWQ2Y9QYDf9OyA@mail.gmail.com>
 <eb06c8e0-ebda-47b9-94f6-6e6eca21097d@freeshell.de>
 <CAJM55Z_Cy2aAfWY-6csKBuv3AJ44h4fCCvJ0ZSbLOYcKw6g=bA@mail.gmail.com>
In-Reply-To:
 <CAJM55Z_Cy2aAfWY-6csKBuv3AJ44h4fCCvJ0ZSbLOYcKw6g=bA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0766:EE_
x-ms-office365-filtering-correlation-id: 85d97fc4-e999-433e-d7c6-08dd0f4c5300
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|41320700013|38070700018;
x-microsoft-antispam-message-info:
 IDS96x6dpR9dr4kydCrmqkINlSx8E3iBqvvayGWXNGqtbpgKhilliohvStQd+ZuXAnldE7fT+GDY+hlym22Cwjj/o/P5Mg4OhU5W4WR601rctskpAgcltZSNxZ/DCAe4i9mr/y7fRRoMWT46EP0FE0KfCLwh6uZAPvLIAw5ZCD1QhR1YUVAlERnXko5bK+uUSxUUg1RN75fsuCWpq4GiJhiJ0k+TBuMzxexzQsFJAVvjQA7ycl+hNAUccTf0rcbzxtLf1PtJCM3Eli0M9vvXiHLNdtEysZgBfe6If2+Xi5tVAR3zGCAnsRV3AxBm2sh7mu/FhE6z+rNK1dvP0Jto4gGLcwZJEzcNoF4RJT/j4/pqzvUtXuTUxB69NoRdrCxX8I7tLnu+aIr/iCamNC2fEoC3djtb3I39mLWSZsd4gV+dRrENBI+1fWiKYj+FnL3cfp6VQZpeju67zUv9LJfDcs74HpSyv2Hs1uQEihmx/gHDAxyu/uvkaZlhO+9gGgFiOOFQ+z9VdWnRtGix/Rfmn9hs4VzcR1JWrOd11PdVWs1uMC2AEO81hwArdQc92x3EM1qVvjIHaKVfjjIZxCgx68atQxWzIEkcCKv1avg8SoyluX9wYd+6/7eMEH//ZLUr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(41320700013)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0NQVnMyOG05SDVVNlhRUkdBL0xVTjR0SWNua2JzRFI0UTVCMXR1ZWNOQ2h3?=
 =?utf-8?B?QzgzS0xKYnJPMHdMaTNlWEtNRzlNRDVVOWV5czljdFNyRU1kNkhhZEV0Rmxh?=
 =?utf-8?B?RGZQUmEwSy9ZNEhnK2ttNDVmU2M0TGpBeitkWmNIWi8yVzliSXJOR1poSmY1?=
 =?utf-8?B?SGM4djgvZ2xGWlVvQWZzalMyZXhDamhiSG9qVHZVY01XU1ljNFhBV1NBY1U0?=
 =?utf-8?B?T053V3Nqd3BKbHgrTHJyUnU1dkdhVTArM2YwT3hMRGRvN3JOV2JWUEVxNHpT?=
 =?utf-8?B?TWcrOUp2ZitJWThzK0lieHNzbXBlSUVUVjVrTWszN25BT1NlRy8wSzhjVGto?=
 =?utf-8?B?Tmk4cURMdmE1cU04UWM2MDRiTGFxTjI4OW5WVkFnekp3QmVQaXdSZ3RnV3hv?=
 =?utf-8?B?Zll2cWc2NG8xZVlBRHJtMXBDL1c4LzBoQzRoeldiNnJTbVpMYVVqa1h3RHRR?=
 =?utf-8?B?SDRDdDBMVllEd1RDYndCY3o2cmVoeXYxNm5BeGc0eDhLN01YdkVuMlJDSC9j?=
 =?utf-8?B?dDhBdVMyZllWL1VCYWJlYWhnRUtHZ0FaZmtEcTJEWnlrMHh1Lzc5NWd3WENW?=
 =?utf-8?B?bXl5MTVySkpPTmdsRnNlVnhoS2I5TmI3SUdEb3AwZ2RLNHFoZXZ5TjM4UWJW?=
 =?utf-8?B?ZzFJQ1pHV1Q0UUdSSWM3LzZwWUpoa0pBWkRPT1VNNjIvbVc1L2ZmcFFhYzN3?=
 =?utf-8?B?amtQWGdSNy8yT0UvVGZQdTdUL0FpK3lJL0YvTG9XNFd5Szd4ODlQMFJaZTM2?=
 =?utf-8?B?eGdBYXBQYzIvRk5ZMmd0L0hMTjlMaHdPSERNYi9lN3BEQlhOc1RFbGQxNlBJ?=
 =?utf-8?B?dVQ0OFZnRHZidUNqN1BpcUlsMEFGcHY0anQ5cXp3UDFTMHFXcWRoMXBGT0VS?=
 =?utf-8?B?WStscTVzMkx3b3ZvQkxnNzFrUFBHZGJrN2RDWFVDL1RiOUJ5anRLOU5oenVs?=
 =?utf-8?B?UjFENnZyN0ltZnM2eXoyajRqV3hseWZZTGhtdFdBQnJobWczNUZBenZSUTJi?=
 =?utf-8?B?UWhMejUwMWlYNE5CNlVOMCtVK3prT1NvUHNyTGdVVE9WWWVKaHRKdHg0ZGZo?=
 =?utf-8?B?VUZ0MkxlZWtDTmJ1QjlPYW9uRDBzUHpNQzdQcG1MbUwveUFoR1FWYWRQbXRY?=
 =?utf-8?B?TFh0YlhzQStCQlRVcUZoWWo0elNJREVJS1JEcEpWNGJQRHMvSG9tZUk5Sklw?=
 =?utf-8?B?Z2JVaGVqNUpOMjM4anVwWnhMMDlaQ2xtZDBHRG9xZW9jYTBxQ21lcUN4YUlZ?=
 =?utf-8?B?TTBuaG9sYkhqTFNoMWliMDl0QzhHUXIvVXdtTUN0THR1WmZySDFQanBZek1U?=
 =?utf-8?B?enNVcVRkREcxdU5iM3AyMXpsTVkrQUFyRlc2ditLamlmU1I4UjNSWWMxSTdk?=
 =?utf-8?B?Q1AxSmxDYXlENVUvS05zQWE5ZjVzUTg5UjhwMGVSbFBjc2ZIU1ZBa25DQ0xn?=
 =?utf-8?B?cFZ1Q2RRZCttKyswL2xEWkw3WVhWNXFiN1I1dXFyRW1Zb1gyaG9DVHJUSUNv?=
 =?utf-8?B?YWVMejF5Nkl0K3pLemZTUGhici93ZVJQeW4yTDdJa0pJTGtXN1pxQnZtanpC?=
 =?utf-8?B?bGluSENaanprWFZ6bVNMZTNFU0FmVTBORFZncEg4ZXo2NjhZOGsrSVpqaUVC?=
 =?utf-8?B?N3Y1QnpEcXVnYmJTMjYvK1lsNGg2akV0ME5uN2QwTjFHaDZCczVwSDB4ZnV3?=
 =?utf-8?B?WkpVU0w1aWxlOTdUcGh2T1ZCeDdGQVp1cTJOQkoyY2VUSk9SZmpvVzBpSE1j?=
 =?utf-8?B?YXZxeCtLczFKR0VsVmt6TmU3NllaL1FydkhOaDE0Rm9YVGh3VE1pcjlKdEdK?=
 =?utf-8?B?ZFA4Qzc5N0RiZ1pFOThjWTdwY2xQUFhjYkI0RWJ1V2RZRitzL0ROdnBXOUhj?=
 =?utf-8?B?YTkxMUJsS3Ria2pBVDY5VzhGKzluL0pJVFBvQUFvWUMrZHVpOVRUTmltOVQ1?=
 =?utf-8?B?TGJxT0lLREpoZS9TdVZmeW1ON3BWUXZJdmdnSk1LeU94TmZXVTdkbGtOVks4?=
 =?utf-8?B?UnpJSTRSdU5FMlJ5OC9FVUF6MWZDeVY3M05rZGF6YmdJcFdCNXR4THFjWGF1?=
 =?utf-8?B?Wm41U1pIZ2lVbzkxOTJFemxkV3JSc0UvOVVvWUNUVytjbGpTUXR0d2VsbEZn?=
 =?utf-8?B?MkJKVkdtenQ3RldFdnNKQ0NETFJFd1ljdnNHT3JhUnVnWG9QemZ0MG9IRVpD?=
 =?utf-8?B?amc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d97fc4-e999-433e-d7c6-08dd0f4c5300
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 01:31:04.0817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oo2xI+Mm069B/sMRPQcuHk+G6T8XmcYjfLV3iq9+jAzzGfIlPamFOWTKxQk8a0yJB+sFvyx05e2OQLh45/eHG4OwkZtX7Y51D//RZY0kjjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0766

DQoNCj4gDQo+IEUgU2hhdHRvdyB3cm90ZToNCj4gPiBIaSBFbWlsLCB0aGFua3MgZm9yIHRha2lu
ZyB0aW1lIHRvIHJldmlldyENCj4gPg0KPiA+IEFkZGVkIENDOiBNaW5kYSBDaGVuLCBIYWwgRmVu
Zw0KPiA+DQo+ID4gUGxlYXNlIE1pbmRhIGFuZCBIYWwgY2FuIHlvdSBmb2xsb3ctdXAgb24gRW1p
bCdzIGNvbW1lbnRzIGFzIHdlbGw/DQo+ID4NCj4gPiBPbiAxMS8yNy8yNCAwMzowMCwgRW1pbCBS
ZW5uZXIgQmVydGhpbmcgd3JvdGU6DQo+ID4gPiBFIFNoYXR0b3cgd3JvdGU6DQo+ID4gPj4gRW5h
YmxlIGhvc3QgbW9kZSBKSDcxMTAgb24tY2hpcCBVU0IgZm9yIE1pbGstViBNYXJzIGJ5IHNldHRp
bmcgaG9zdA0KPiA+ID4+IG1vZGUgYW5kIGNvbm5lY3QgdmJ1cyBwaW5jdHJsLg0KPiA+ID4+DQo+
ID4gPj4gVGhpcyBmdW5jdGlvbmFsaXR5IGRlcGVuZHMgb24gc2V0dGluZyB0aGUgVVNCIG92ZXIt
Y3VycmVudCByZWdpc3Rlcg0KPiA+ID4+IHRvIGRpc2FibGUgYXQgYm9vdGxvYWRlciBwaGFzZSwg
Zm9yIGV4YW1wbGUgVS1Cb290Og0KPiA+ID4+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcv
cHJvamVjdC91Ym9vdC9wYXRjaC8yMDI0MTAxMjAzMTMyOC40MjYNCj4gPiA+PiA4LTYtbWluZGEu
Y2hlbkBzdGFyZml2ZXRlY2guY29tLw0KPiA+ID4gSGkgRSwNCj4gPiA+DQo+ID4gPiBJZGVhbGx5
IHRoZSBKSDcxMTAgcGluY3RybCBkcml2ZXIgd291bGQgYmUgdXBkYXRlZCwgc28gTGludXggY2Fu
IGRvDQo+ID4gPiB0aGlzIGl0c2VsZiBhbmQgZG9lc24ndCBuZWVkIHRvIHJlbHkgb24gdS1ib290
IGRvaW5nIGl0LiBJIGFscmVhZHkgYXNrZWQgZm9yIHRoaXMNCj4gaGVyZToNCj4gPiA+DQo+ID4g
Pg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FKTTU1Wi0rQ3hkZWJjbjRNTFhmUWRP
Vmh4NGMyU1Erek1IOGNqbg0KPiA+ID4gLVlxMzV4TzhnMEFAbWFpbC5nbWFpbC5jb20vDQo+ID4N
Cj4gPiBZZXMsIEkgYWdyZWUsIGFuZCBMaW51eCBpcyBub3QgdGhlIG9ubHkgY29uc3VtZXIgb2Yg
ZGV2aWNldHJlZS4gSQ0KPiA+IHdvdWxkIGxpa2UgVVNCIGZ1bmN0aW9uIHRvIHdvcmsgZm9yIHVz
ZXJzIG9mIExpbnV4IGFuZCBVLUJvb3Qgb24gdGhlc2UNCj4gPiBib2FyZHMgYnkgY29weWluZyB3
aGF0IHRoZSB2ZW5kb3IgQm9hcmQgU3VwcG9ydCBQYWNrYWdlIGRvZXMgd2hhdCBpcw0KPiA+IHNo
aXBwZWQgd2l0aCB0aGUgcHJvZHVjdHMuIElmIGl0IGlzIG1vcmUgaW4tZGVwdGggdGhhbiB0aGlz
IEkgd2lsbA0KPiA+IGRlZmVyIHRvIEhhbCBvciBNaW5kYS4NCj4gPg0KPiA+DQo+ID4gRm9yIHNv
bWUgd2lkZXIgY29udGV4dCwgdXBzdHJlYW0gVS1Cb290IGlzIGFib3V0IHRvIGFkb3B0IHRoZQ0K
PiA+IGR0LXJlYmFzaW5nIHZpYSBIYWwncyBPRl9VUFNUUkVBTSBmb3IgSkg3MTEwIGJvYXJkcyBz
ZXJpZXMgYW5kIHRoZW4NCj4gPiBhbHNvIHRoZXJlIGlzIGEgcGF0Y2ggc2V0IGZyb20gTWluZGEg
Q2hlbiB0byBhZGQgdGhlIG9uLWNoaXAgSkg3MTEwDQo+ID4gVVNCIHN1cHBvcnQgdG8gVS1Cb290
LCBhbmQgc28gdGhlbiBhbmQgdGhlcmUgaXQgd2lsbCBkZXBlbmQgb24gdGhlc2UNCj4gPiBkdHMg
Y2hhbmdlcy4gSWYgeW91IGhhdmUgTWlsay1WIE1hcnMgdGhlbiBhbHJlYWR5IHRoZXJlIGFyZSB0
aHJlZSBvZg0KPiA+IGZvdXIgVVNCLUEgcmVjZXB0YWNsZSBwb3J0cyB3aGljaCBhcmUgZnVuY3Rp
b25hbCBvbiBQQ0llLWNvbm5lY3RlZA0KPiA+IFZMODA1IFVTQiBjaGlwc2V0Lg0KPiA+DQo+ID4g
Pg0KPiA+ID4+IElmIHRoZSBvdmVyLWN1cnJlbnQgcmVnaXN0ZXIgaXMgbm90IHByZXBhcmVkIGZv
ciB1cyB0aGVuIHRoZSByZXN1bHQNCj4gPiA+PiBpcyBubyBjaGFuZ2UgaW4gZnVuY3Rpb25hbCBv
dXRjb21lIHdpdGggdGhpcyBwYXRjaCBhcHBsaWVkOyB0aGVyZQ0KPiA+ID4+IGlzIGFuIGVycm9y
IHZpc2libGUgdG8gdGhlIHVzZXIgYW5kIHRoaXMgYWRkaXRpb25hbCB1c2INCj4gPiA+PiBjb25m
aWd1cmF0aW9uIGZhaWxzIChzYW1lIGFzIGl0IGlzIG5vdykuIE9uIE1pbGstViBNYXJzIHdpdGgg
Zm91cg0KPiA+ID4+IFVTQi1BIHBvcnRzIHRoaXMgYXBwbGllcyB0byBvbmUgb2YgdGhlIHBvcnRz
IGFuZCB0aGUgcmVtYWluaW5nIHRocmVlDQo+IFZMODA1LWNvbm5lY3RlZCBwb3J0cyB2aWEgUENJ
ZSBhcmUgbm90IGNoYW5nZWQuDQo+ID4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaGVzLiBJIGRvbid0
IHF1aXRlIHVuZGVyc3RhbmQgd2hlbiB5b3Ugd3JpdGUgIm5vDQo+ID4gPiBjaGFuZ2UgaW4gZnVu
Y3Rpb25hbCBvdXRjb21lIHdpdGggdGhpcyBwYXRjaCBhcHBsaWVkIi4gVGhlIFVTQi1DDQo+ID4g
PiBwb3J0IGlzIGFscmVhZHkgY29uZmlndXJlZCBhcyBhIHBlcmlwaGVyYWwsIGFuZCBJIGp1c3Qg
dHJpZWQgc2V0dGluZw0KPiA+ID4gdXAgYW4gZXRoZXJuZXQgZ2FkZ2V0IG9uIG15IFZGMiBydW5u
aW5nIDYuMTIgYW5kIHRoYXQgd29ya3MgcXVpdGUNCj4gPiA+IHdlbGwuIERvZXMgaXQgbm90IHdv
cmsgb24gdGhlIE1pbGstViBNYXJzIGJvYXJkPyBJZiBpdCBkb2VzIHRoZW4gdGhlc2UNCj4gcGF0
Y2hlcyB3b3VsZCBicmVhayB0aGF0IGZ1bmN0aW9uYWxpdHkuDQo+ID4gPg0KPiA+ID4gSGVyZSBp
cyB0aGUgc2NyaXB0IEkgdXNlZCBmb3IgdGhhdDoNCj4gPiA+IGh0dHBzOi8vcGFzdGUuYy1uZXQu
b3JnL0JyYXZvTG9uZWx5DQo+ID4gPg0KPiA+ID4gQXQgdGhlIHZlcnkgbGVhc3QgeW91J2xsIG5l
ZWQgdG8gZXhwbGFpbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UNCj4gPiA+IGl0c2VsZiB3aHkgY2hh
bmdpbmcgdGhlIFVTQi1DIHBvcnQgZnJvbSBwZXJpcGhlcmFsIG1vZGUgdG8gaG9zdCBtb2RlDQo+
ID4gPiBpcyBPSy4gQnV0IGlkZWFsbHkgbWF5YmUgeW91IGNvdWxkIG1ha2UgaXQgd29yayBpbiBP
VEcgbW9kZSwgc28NCj4gPiA+IHVzZXJzcGFjZSBjYW4gY2hvb3NlIGhvdyB0aGV5IHdhbnQgdG8g
dXNlIHRoZSBwb3J0LiBUaGUgc2FtZSBnb2VzIGZvciB0aGUNCj4gUElORTY0IGJvYXJkIHRvby4N
Cj4gPiA+DQo+ID4gPiAvRW1pbA0KPiA+DQo+ID4gVVNCLUMgcG9ydCBvbiBNYXJzIGlzIG5vdCB3
aXJlZCBmb3IgZGF0YSBoZXJlLCB0aGF0IGlzIG9ubHkgdHJ1ZSBmb3INCj4gPiBWaXNpb25GaXZl
Mi4gSWYgdGhlIHVzZXIgd2FudHMgdG8gdXNlIHRoZWlyIFVTQi1BIHJlY2VwdGFjbGUgYXMgT1RH
DQo+ID4gcG9ydCBJIHdpbGwgbm90IG9iamVjdCB0byBhIGZ1dHVyZSBpbXByb3ZlbWVudCwgYnV0
IGhlcmUgd2Ugd2FudCB0aGUNCj4gPiBiYXNpYyBleHBlY3RhdGlvbnMgb2YgdXNlcnMgY292ZXJl
ZCB0aGF0IHRoZXkgc2hvdWxkIGhhdmUgZm91ciB3b3JraW5nDQo+ID4gVVNCLUEgcmVjZXB0YWNs
ZSBwb3J0cyBpbiBVLUJvb3QgKGFuZCBwb3NzaWJseSBpbiBMaW51eCwgZGVwZW5kaW5nIG9uDQo+
ID4gdGhlIG92ZXJjdXJyZW50IHJlZ2lzdGVyIHdoZXJldmVyIGl0IGlzIHNldCkuIFRoaXMgaXMg
d2hhdCBJIGFtDQo+ID4gbWVhbmluZywgdGhlcmUgbWF5IGJlIHNvbWVib2R5IHVzaW5nIGEgbWFs
ZS1tYWxlIFVTQi1BIFVTQi1BIGNhYmxlIGZvcg0KPiA+IE9URyBidXQgbW9yZSBsaWtlbHkgaXMg
dGhhdCBwZW9wbGUganVzdCB3YW50IHRvIHBsdWcgaW4gVVNCDQo+ID4gcGVyaXBoZXJhbHMgdG8g
aG9zdCBwb3J0cyBhbmQgdXNlIHRoZWlyIG1vdXNlIC8ga2V5Ym9hcmQgLyBmbGFzaCBtZW1vcnks
IEkNCj4gdGhpbmsuDQo+IA0KPiBZb3UncmUgcmlnaHQsIHNvcnJ5LiBJJ20gc28gdXNlZCB0byB0
aGUgSkg3MTEwIGJvYXJkcyBiZWluZyBzaW1pbGFyLCBidXQgdGhpcyBpcw0KPiBhY3R1YWxseSBv
bmUgb2YgdGhlIGZldyBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRoZSBNYXJzIGFuZCBWRjIgdGhhdCB3
YXMgbm90DQo+IGNhdWdodCB3aGVuIHRoZSBNYXJzIGR0cyB3YXMgZmlyc3QgdXBzdHJlYW1lZC4N
Cj4gDQo+IFllcywgd2l0aCA0IHNpbWlsYXIgVVNCLUEgcG9ydHMgeW91J2QgZGVmaW5pdGVseSBl
eHBlY3QgYWxsIG9mIHRoZW0gdG8gd29yayBpbiBob3N0DQo+IG1vZGUuIFdpdGggYW4gZXhwbGFu
YXRpb24gbGlrZSB0aGUgYWJvdmUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIEkgKG5vdykgdGhpbmsN
Cj4geW91ciBjaGFuZ2VzIG1ha2VzIHNlbnNlLg0KPiANCj4gVGhhbmtzIQ0KPiAvRW1pbA0KPiAN
ClRoYW5rcy4gRSBTaGFkb3cNCg0KVGhlIFVTQiBhbmQgUENJZTAgc2V0dGluZyBpbiBzb21lIEpI
NzExMCBib2FyZHMuDQogICAgICAgICAgICAgICAgIFBDSWUwICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjYWRlbmNlIFVTQiBjb250cm9sbGVyDQpWRjI6ICAgICAgIGNvbm5l
Y3Qgd2l0aCBWTDgwNSBVU0IzLjAgKCA0IFVTQiAzLjAgdHlwZSBBIHBvcnRzKSAgICAgICAoVVNC
IDIuMClUeXBlIEMgcG9ydChyb2xlOiBwZXJpcGhlcmFsKQ0KTWlsa3YgbWFycyAgY29ubmVjdCB3
aXRoIFZMODA1IFVTQjMuMCAoIDMgVVNCIDMuMCB0eXBlIEEgcG9ydHMpICAgICAgIChVU0IgMi4w
KTEgVHlwZSBBIHBvcnQgKHJvbGU6aG9zdCkNCk1pbGt2IGNtICAgIFBDSWUgc2xvdAkJCQkJCQkJ
CQkJKFVTQiAyLjApbWljcm8gQiBwb3J0IChyb2xlOmhvc3QpDQpTdGFyNjQgICAgICAgZGlzYWJs
ZWTvvIhwY2llIFBIWTAgY29ubmVjdCB0byBjYWRlbmNlIFVTQu+8iSAgICAgICAgIDEgdXNiIDMu
MCBwb3J0ICsgVVNCIDIuMCBodWIgKHJvbGU6aG9zdCkNCg0KSCBFIFNoYWRvdw0KSSBzZWUgeW91
IGFsc28gYWRkIHN0YXI2NCBVU0IgY29uZmlndXJhdGlvbi4gSSBob3BlIGFsc28gYWRkIHRoaXMg
dG8gc3RhcjY0IGJvYXJkIGR0cyBiYXNlIG9uDQpWNi4xMy1yYzEuIFRoYW5rcy4NCg0KJnBjaWUw
IHsNCglzdGF0dXMgPSAiZGlzYWJsZWQiOw0KfTsNCg0KJnBjaWVwaHkwIHsNCglzdGFyZml2ZSxz
eXMtc3lzY29uID0gPCZzeXNfc3lzY29uIDB4MTg+Ow0KCXN0YXJmaXZlLHN0Zy1zeXNjb24gPSA8
JnN0Z19zeXNjb24gMHgxNDggMHgxZjQ+Ow0KCXN0YXR1cyA9ICJva2F5IjsNCn07DQoNCiZ1c2Iw
IHsNCglwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KCXBpbmN0cmwtMCA9IDwmdXNiX3BpbnM+
Ow0KCWRyX21vZGUgPSAiaG9zdCI7DQoJc3RhdHVzID0gIm9rYXkiOw0KfTsNCg0KJnVzYl9jZG5z
MyB7DQoJcGh5cyA9IDwmdXNicGh5MD4sIDwmcGNpZXBoeTA+Ow0KCXBoeS1uYW1lcyA9ICJjZG5z
Myx1c2IyLXBoeSIsICJjZG5zMyx1c2IzLXBoeSI7DQp9Ow0KDQo+ID4NCj4gPg0KPiA+IFRoZXJl
IGlzIG5vIFVTQi1DIHBvcnQgb24gU3RhcjY0Lg0KPiA+DQo+ID4gPg0KPiA+ID4+IENoYW5nZXMg
c2luY2UgdjQ6DQo+ID4gPj4gICAtIFJlYmFzZSBvbiBsYXRlc3QgbWFzdGVyDQo+ID4gPj4NCj4g
PiA+PiBDaGFuZ2VzIHNpbmNlIHYzOg0KPiA+ID4+ICAgLSBSZWJhc2Ugb24gbGludXgtbmV4dC9t
YXN0ZXINCj4gPiA+PiAgIC0gdXNlIHRhYnMgZm9yIGNvZGUgaW5kZW50DQo+ID4gPj4NCj4gPiA+
PiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiA+ID4+ICAgLSBSZWJhc2Ugb24gNi4xMg0KPiA+ID4+DQo+
ID4gPj4gRSBTaGF0dG93ICgxKToNCj4gPiA+PiAgICByaXNjdjogZHRzOiBzdGFyZml2ZTogamg3
MTEwLW1pbGt2LW1hcnM6IGVuYWJsZSB1c2IwIGhvc3QNCj4gPiA+PiBmdW5jdGlvbg0KPiA+ID4+
DQo+ID4gPj4gICAuLi4vYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLW1pbGt2LW1hcnMuZHRzICAg
IHwgMTgNCj4gKysrKysrKysrKysrKysrKystDQo+ID4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4+DQo+ID4gPj4gLS0NCj4gPiA+PiAy
LjQ1LjINCj4gPiA+Pg0KPiA+IFRoYW5rcyBhZ2FpbiBFbWlsLsKgIC1FDQo+ID4NCg==

