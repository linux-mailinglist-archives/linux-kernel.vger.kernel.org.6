Return-Path: <linux-kernel+bounces-344347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A70F98A896
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A936CB26223
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D7A1925A0;
	Mon, 30 Sep 2024 15:30:27 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D718FDD8
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710227; cv=none; b=Iq0j+sFzdrYAKA0LZa2fqiatAsVi2QQi2igOGPbcI7jU7ui2uUSE34H0aIzdz4EdMZvKS0oFQs1C/25TGkiROyskALSzs7c8TXEBg8RLYZ7xE18gEHkS6ZWVLgzjXAc5LE9ZnqADfKA6Bu2d/nQvNMzrd1W6IieIR543J7BygrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710227; c=relaxed/simple;
	bh=zrC49XDz5oLjl5S9hck8vGUDXP7A7thoruLt+tdRTYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=GNV4VvPLc898CIfEboFtOoz7Xv9kPCWA0bMTEpkWUTWhJ548YmI/U02SMilo9Vs1izgIEqZa5Nf3v1C7BW0Qt9I7TsgMrBM6asEx1VNgMB540HdWl/wPIdxQdu6a1kJ2xmLLvaEzAMtjy7aDgPwBgwXwgHnKBjocKQ1UP2rssF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-171-CSVQ6vw3PGeDZ8KS9YKEUA-1; Mon, 30 Sep 2024 16:30:22 +0100
X-MC-Unique: CSVQ6vw3PGeDZ8KS9YKEUA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 30 Sep
 2024 16:29:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 30 Sep 2024 16:29:26 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: =?utf-8?B?J1Rob21hcyBXZWnDn3NjaHVoJw==?= <linux@weissschuh.net>, "Willy
 Tarreau" <w@1wt.eu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] tools/nolibc: compiler: add macro __nolibc_fallthrough
Thread-Topic: [PATCH v2] tools/nolibc: compiler: add macro
 __nolibc_fallthrough
Thread-Index: AQHbEvp4XNdYqzzLMEK9LZTYvqsJ5LJwcjuw
Date: Mon, 30 Sep 2024 15:29:26 +0000
Message-ID: <61eb467389f24216b77aaedb85006153@AcuMS.aculab.com>
References: <20240930-nolibc-fallthrough-v2-1-2e8d10fe3430@weissschuh.net>
In-Reply-To: <20240930-nolibc-fallthrough-v2-1-2e8d10fe3430@weissschuh.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVGhvbWFzIFdlacOfc2NodWgNCj4gU2VudDogMzAgU2VwdGVtYmVyIDIwMjQgMDY6MzUN
Cj4gDQo+IFJlY2VudCB2ZXJzaW9uIG9mIEdDQyBhbmQgY2xhbmcgZ2FpbmVkIC1XaW1wbGljaXQt
ZmFsbHRocm91Z2gsDQo+IHdhcm5pbmcgYWJvdXQgaW1wbGljaXQgZmFsbC10aHJvdWdoIGJldHdl
ZW4gc3dpdGNoIGxhYmVscy4NCj4gQXMgbm9saWJjIGRvZXMgbm90IGNvbnRyb2wgdGhlIGNvbXBp
bGF0aW9uIGZsYWdzLCB0aGlzIGNhbiB0cmlnZ2VyDQo+IHdhcm5pbmdzIGZvciB3aGVuIGJ1aWx0
IGJ5IHRoZSB1c2VyLg0KPiBNYWtlIHVzZSBvZiB0aGUgImZhbGx0aHJvdWdoIiBhdHRyaWJ1dGUg
dG8gZXhwbGljaXRseSBhbm5vdGF0ZSB0aGUNCj4gZXhwZWN0ZWQgZmFsbC10aHJvdWdocyBhbmQg
c2lsZW5jZSB0aGUgd2FybmluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBXZWnDn3Nj
aHVoIDxsaW51eEB3ZWlzc3NjaHVoLm5ldD4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0g
QWRkIGEgZG8td2hpbGUgbG9vcCB0byBpbXByb3ZlIGNvbXBpbGVyIGNvbXBhdGliaWxpdHkNCj4g
LSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwOTI5LW5vbGliYy1m
YWxsdGhyb3VnaC12MS0xLTVlZTA3ZWE5YTY4M0B3ZWlzc3NjaHVoLm5ldA0KLi4uDQo+IA0KPiAr
I2lmIF9fbm9saWJjX2hhc19hdHRyaWJ1dGUoZmFsbHRocm91Z2gpDQo+ICsjICBkZWZpbmUgX19u
b2xpYmNfZmFsbHRocm91Z2ggZG8geyB9IHdoaWxlICgwKTsgX19hdHRyaWJ1dGVfXygoZmFsbHRo
cm91Z2gpKQ0KPiArI2Vsc2UNCj4gKyMgIGRlZmluZSBfX25vbGliY19mYWxsdGhyb3VnaCBkbyB7
IH0gd2hpbGUgKDApDQo+ICsjZW5kaWYgLyogX19ub2xpYmNfaGFzX2F0dHJpYnV0ZShmYWxsdGhy
b3VnaCkgKi8NCj4gKw0KPiAgI2VuZGlmIC8qIF9OT0xJQkNfQ09NUElMRVJfSCAqLw0KPiBkaWZm
IC0tZ2l0IGEvdG9vbHMvaW5jbHVkZS9ub2xpYmMvc3RkaW8uaCBiL3Rvb2xzL2luY2x1ZGUvbm9s
aWJjL3N0ZGlvLmgNCj4gaW5kZXggYzk2OGRiYmM0ZWY4MTM3ZTIzN2I4NTliZjE4YTZkMjk3MDIz
MGNiZi4uMzg5MjAzNDE5OGRkNTY2ZDIxYTVjYzBhOWY2N2NmMDk3ZDQyODM5MyAxMDA2NDQNCj4g
LS0tIGEvdG9vbHMvaW5jbHVkZS9ub2xpYmMvc3RkaW8uaA0KPiArKysgYi90b29scy9pbmNsdWRl
L25vbGliYy9zdGRpby5oDQo+IEBAIC0xNSw2ICsxNSw3IEBADQo+ICAjaW5jbHVkZSAic3RkYXJn
LmgiDQo+ICAjaW5jbHVkZSAic3RkbGliLmgiDQo+ICAjaW5jbHVkZSAic3RyaW5nLmgiDQo+ICsj
aW5jbHVkZSAiY29tcGlsZXIuaCINCj4gDQo+ICAjaWZuZGVmIEVPRg0KPiAgI2RlZmluZSBFT0Yg
KC0xKQ0KPiBAQCAtMjY0LDcgKzI2NSw3IEBAIGludCB2ZnByaW50ZihGSUxFICpzdHJlYW0sIGNv
bnN0IGNoYXIgKmZtdCwgdmFfbGlzdCBhcmdzKQ0KPiAgCQkJCWNhc2UgJ3AnOg0KPiAgCQkJCQkq
KG91dCsrKSA9ICcwJzsNCj4gIAkJCQkJKihvdXQrKykgPSAneCc7DQo+IC0JCQkJCS8qIGZhbGwg
dGhyb3VnaCAqLw0KPiArCQkJCQlfX25vbGliY19mYWxsdGhyb3VnaDsNCj4gIAkJCQlkZWZhdWx0
OiAvKiAneCcgYW5kICdwJyBhYm92ZSAqLw0KDQpEb2Vzbid0IHRoaXMgYnJlYWsgYW55IG9sZCB0
b29scyB0aGF0IHdvdWxkIGhhdmUgcGFyc2VkIHRoZSAvKiBmYWxsIHRob3VnaCAqLw0KY29tbWVu
dCAob3IgYW55IG9mIGl0cyB2YXJpYW50cyk/DQoNCklmIHlvdSBtb3ZlIHRoZSA7IGludG8gdGhl
IGRlZmluZSB0aGUgJ29sZCcgZGVmaW5pdGlvbiBjYW4gYmUgZW1wdHkuDQpBbmQgdGhlbiBpdCBp
cyBwb3NzaWJsZSB0aGF0Og0KCQkJCWNhc2UgeDoNCgkJCQkJeHh4eHg7DQoJCQkJCS8qIGZhbGwg
dGhvdWdoICovDQoJCQkJCV9fbm9saWJjX2ZhbGx0aG91Z2gNCgkJCQljYXNlIHk6DQoNCndpbGwg
YmUgcHJvY2Vzc2VkIGNvcnJlY3RseSBiZSBhbGwgdG9vbHMuDQpJIGtub3cgSSBoYWQgdG8gbG93
ZXIgdGhlIHdhcm5pbmcgbGV2ZWwgZm9yIG9uZSBvZiBvdXIga2VybmVsIGRyaXZlcnMuDQpCdXQg
SSd2ZSBmb3Jnb3R0ZW4gd2h5IC0gdGhhdCBjb2RlIGhhcyB0byBnbyB0aHJvdWdoIGEgbG90IG9m
DQpjb21waWxlcnMgLSBpbmNsdWRpbmcgTWljcm9zb2Z0cy4NCg0KCURhdmlkDQoNCg0KPiAgCQkJ
CQl1NjR0b2hfcih2LCBvdXQpOw0KPiAgCQkJCQlicmVhazsNCj4gDQo+IC0tLQ0KPiBiYXNlLWNv
bW1pdDogZTdlZDM0MzY1ODc5Mjc3MWNmMWI4NjhkZjA2MTY2MWI3YmNjNWNlZg0KPiBjaGFuZ2Ut
aWQ6IDIwMjQwOTI5LW5vbGliYy1mYWxsdGhyb3VnaC1iYTgyMmE0YTkyNTUNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gLS0NCj4gVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0
Pg0KPiANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K


