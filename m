Return-Path: <linux-kernel+bounces-374730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12B9A6F16
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86791C21A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CEA1D0153;
	Mon, 21 Oct 2024 16:10:25 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17C17C224
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527025; cv=none; b=NTMrzt3SJxu7/QJwZfXlXZiyMoTbHO0yRtGhAPI7fkH8Gy3MEnTSIj8EkXF5kvTYiK9h8OCDoYe2rj/yUaWRUoqPeSKLw/wWJsIimuuSzQzlKXUh97+E9L+9ZCFzPv+cnKFFmbPOLjFBj1tY0ouscGXfTuW4IVzUxbAEWcWsnOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527025; c=relaxed/simple;
	bh=SHkfl7zwwdOZZpM3tZyCrj6DU/+eGm7kRwBKaChlot8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NWTSFQIXcwZWzI2FufS47pOER3+qvhnI/4lUHwSgMC4wkN2rCsOzGVG9TTZWD+Fqhur+iJ9wmghxtxIFcD4txaDtax6ZvvvIo8ZYhqM601Dh+JLdFYhuo/6N3odTSN6cTYr0jqmGs38IXwp4csE3eGxiawI+Umg01GOpRtfZ1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-42-GJKTBsbbNASPdj52kXe81Q-1; Mon, 21 Oct 2024 17:10:19 +0100
X-MC-Unique: GJKTBsbbNASPdj52kXe81Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 21 Oct
 2024 17:10:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 21 Oct 2024 17:10:18 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'Liam R. Howlett'" <Liam.Howlett@oracle.com>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "sidhartha.kumar@oracle.com" <sidhartha.kumar@oracle.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools: fix -Wunused-result in linux.c
Thread-Topic: [PATCH] tools: fix -Wunused-result in linux.c
Thread-Index: AQHbHp870qBUIivxfUSvLqqqTfcy0bKRaOAw
Date: Mon, 21 Oct 2024 16:10:18 +0000
Message-ID: <13ddebb3e15b4a94b466c6ee5f3f2f42@AcuMS.aculab.com>
References: <20241011225155.27607-1-skhan@linuxfoundation.org>
 <ddepbtajvjqoftjqanab7dpcx62pjrl4s3cowhciocevfa43wa@sncxpv75hpjp>
In-Reply-To: <ddepbtajvjqoftjqanab7dpcx62pjrl4s3cowhciocevfa43wa@sncxpv75hpjp>
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

RnJvbTogTGlhbSBSLiBIb3dsZXR0DQo+IFNlbnQ6IDE1IE9jdG9iZXIgMjAyNCAwMjoxMQ0KPiAN
Cj4gKiBTaHVhaCBLaGFuIDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPiBbMjQxMDExIDE4OjUy
XToNCj4gPiBGaXggdGhlIGZvbGxvd2luZyAtV3VudXNlZC1yZXN1bHQgd2FybmluZ3Mgb24gcG9z
aXhfbWVtYWxpZ24oKQ0KPiA+IHJldHVybiB2YWx1ZXMgYW5kIGFkZCBlcnJvciBoYW5kbGluZy4N
Cj4gPg0KPiA+IC4vc2hhcmVkL2xpbnV4LmM6MTAwOjI1OiB3YXJuaW5nOiBpZ25vcmluZyByZXR1
cm4gdmFsdWUgb2Yg4oCYcG9zaXhfbWVtYWxpZ27igJkgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUN
Cj4g4oCYd2Fybl91bnVzZWRfcmVzdWx04oCZIFstV3VudXNlZC1yZXN1bHRdDQo+ID4gICAxMDAg
fCAgICAgICAgICBwb3NpeF9tZW1hbGlnbigmcCwgY2FjaGVwLT5hbGlnbiwgY2FjaGVwLT5zaXpl
KTsNCj4gPiAgICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+DQo+ID4gLi4vc2hhcmVkL2xpbnV4LmM6IEluIGZ1bmN0aW9uIOKAmGtt
ZW1fY2FjaGVfYWxsb2NfYnVsa+KAmToNCj4gPiAuLi9zaGFyZWQvbGludXguYzoxOTg6MzM6IHdh
cm5pbmc6IGlnbm9yaW5nIHJldHVybiB2YWx1ZSBvZiDigJhwb3NpeF9tZW1hbGlnbuKAmSBkZWNs
YXJlZCB3aXRoIGF0dHJpYnV0ZQ0KPiDigJh3YXJuX3VudXNlZF9yZXN1bHTigJkgWy1XdW51c2Vk
LXJlc3VsdF0NCj4gPiAgIDE5OCB8ICAgICAgICAgIHBvc2l4X21lbWFsaWduKCZwW2ldLCBjYWNo
ZXAtPmFsaWduLA0KPiA+ICAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQo+ID4gICAxOTkgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y2FjaGVwLT5zaXplKTsNCj4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB+fn5+fn5+fn5+fn5+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHVhaCBLaGFuIDxza2hh
bkBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiANCj4gUmV2aWV3ZWQtYnk6IExpYW0gUi4gSG93bGV0
dCA8TGlhbS5Ib3dsZXR0QE9yYWNsZS5jb20+DQo+IA0KPiA+IC0tLQ0KPiA+ICB0b29scy90ZXN0
aW5nL3NoYXJlZC9saW51eC5jIHwgMTQgKysrKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NoYXJlZC9saW51eC5jIGIvdG9vbHMvdGVzdGluZy9zaGFyZWQvbGlu
dXguYw0KPiA+IGluZGV4IDE3MjYzNjk2YjVkOC4uNjZkYmIzNjIzODVmIDEwMDY0NA0KPiA+IC0t
LSBhL3Rvb2xzL3Rlc3Rpbmcvc2hhcmVkL2xpbnV4LmMNCj4gPiArKysgYi90b29scy90ZXN0aW5n
L3NoYXJlZC9saW51eC5jDQo+ID4gQEAgLTk2LDEwICs5NiwxMyBAQCB2b2lkICprbWVtX2NhY2hl
X2FsbG9jX2xydShzdHJ1Y3Qga21lbV9jYWNoZSAqY2FjaGVwLCBzdHJ1Y3QgbGlzdF9scnUgKmxy
dSwNCj4gPiAgCQlwID0gbm9kZTsNCj4gPiAgCX0gZWxzZSB7DQo+ID4gIAkJcHRocmVhZF9tdXRl
eF91bmxvY2soJmNhY2hlcC0+bG9jayk7DQo+ID4gLQkJaWYgKGNhY2hlcC0+YWxpZ24pDQo+ID4g
LQkJCXBvc2l4X21lbWFsaWduKCZwLCBjYWNoZXAtPmFsaWduLCBjYWNoZXAtPnNpemUpOw0KPiA+
IC0JCWVsc2UNCj4gPiArCQlpZiAoY2FjaGVwLT5hbGlnbikgew0KPiA+ICsJCQlpZiAocG9zaXhf
bWVtYWxpZ24oJnAsIGNhY2hlcC0+YWxpZ24sIGNhY2hlcC0+c2l6ZSkgPCAwKQ0KPiA+ICsJCQkJ
cmV0dXJuIE5VTEw7DQo+ID4gKwkJfSBlbHNlIHsNCj4gPiAgCQkJcCA9IG1hbGxvYyhjYWNoZXAt
PnNpemUpOw0KPiA+ICsJCX0NCj4gPiArDQoNCllvdSByZWFsbHkgb3VnaHQgdG8gYmUgY2hlY2tp
bmcgbWFsbG9jKCkgYXMgd2VsbC4NClBlcmhhcHM6DQoJCWlmICguLi4pIHsNCgkJCWlmIChwb3Np
eF9tZW1hbGlnbiguLi4pIDwgMCkNCgkJCQlwID0gTlVMTDsNCgkJfSBlbHNlIHsNCgkJCXAgPSBt
YWxsb2MoLi4uKTsNCgkJfQ0KCQlpZiAoIXApDQoJCQlyZXR1cm4gTlVMTDsNCg0KT3IganVzdCB1
c2UgYSBoYWNrIHRvIGdldCB0aGUgY29tcGlsZXIgdG8gU1RGVSA6LSkNCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==


