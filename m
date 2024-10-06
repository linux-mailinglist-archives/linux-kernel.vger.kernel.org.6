Return-Path: <linux-kernel+bounces-352563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA039920C4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0A0280C2C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3C018A6C4;
	Sun,  6 Oct 2024 19:39:06 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC6F4F1
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728243546; cv=none; b=VP3+9Bn8kG0C6rm5VVFGzCBNUpoS0kGzE17EV697qfps1ikS8VsLmfGJE3EeSJCjPs/M8cMMou0MO50uP0qwUpsIQVC44iBnCFpNujEhMBg4VuXT240WnR5yYfjRZ1+XYATND753Vopx0M/KbOVQ/GOwKrA1ojFz9Z79sSGs2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728243546; c=relaxed/simple;
	bh=OBak1uHJl3ZubY+7sFMouOJ6LXknbTouSx/aTwbNTaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=X2/t65Jb8QLiauCOyYrI31Qzj407mTjYwE/MWSaYL60vWcckQghBk/87+F4dr/M189Q/fTN4hMKCjD7Jh+RuwiMXSGAMYMSL1LGhhP2W34FHIgQsxtVJ44WStOUSGeCKjNWUuGYqjhtJV7vjR7Cm5acZlPAysnTCwcC/bxs+oFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-166-CaeKJMmCMmWEp8bxsb_GbA-1; Sun, 06 Oct 2024 20:39:01 +0100
X-MC-Unique: CaeKJMmCMmWEp8bxsb_GbA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 6 Oct
 2024 20:38:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 6 Oct 2024 20:38:07 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Al Viro' <viro@zeniv.linux.org.uk>, Brahmajit Das
	<brahmajit.xyz@gmail.com>
CC: "brauner@kernel.org" <brauner@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] fs/qnx6: Fix building with GCC 15
Thread-Topic: [PATCH 1/1] fs/qnx6: Fix building with GCC 15
Thread-Index: AQHbFpcN/zElNcWuRkuJdieTZ+k397J6HYnw
Date: Sun, 6 Oct 2024 19:38:07 +0000
Message-ID: <665bcd89cf5f4679a38e9a84fa0ba42a@AcuMS.aculab.com>
References: <vch6gmzqaeo22c7473qyabrfwxlkdhx5vgvosjyp5l2nwgqnxl@5x3ny35qyfgx>
 <20241004094921.615688-1-brahmajit.xyz@gmail.com>
 <20241004184440.GQ4017910@ZenIV>
In-Reply-To: <20241004184440.GQ4017910@ZenIV>
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

Li4uDQo+IHdvdWxkIGV4cGxhaW4gd2hhdCB3YXMgcmVhbGx5IGdvaW5nIG9uIC0gdGhlIHBvaW50
IGlzIG5vdCB0byBtYWtlIGdjYyBTVEZVLCBpdCdzDQo+IHRvIG1ha2UgdGhlIGNvZGUgbW9yZSBz
dHJhaWdodGZvcndhcmQuICBUaGUgd2FybmluZyBpcyBiYXNpY2FsbHkgIml0IHNtZWxscw0KPiBz
b21ld2hhdCBmaXNoeSBhcm91bmQgPmhlcmU8LCBtaWdodCBiZSB3b3J0aCB0YWtpbmcgYSBsb29r
Ii4gIEFuZCB5ZXMsIGl0IHR1cm5lZA0KPiBvdXQgdG8gYmUgZmlzaHk7IG1pbmltYWwgIm1ha2Ug
aXQgU1RGVSIgd291bGQgYmUgdG8gc3RyaXAgdGhvc2UgTlVMcyBmcm9tDQo+IHRoZSBpbml0aWFs
aXplcnMgKGkuZS4ganVzdCBnbyBmb3Igc3RhdGljIGNoYXIgbWF0Y2hfcm9vdFsyXVszXSA9IHsi
LiIsICIuLiJ9OyAtDQo+IGFuIGFycmF5IGluaXRpYWxpemVyIGlzIHplcm8tcGFkZGVkIGlmIGl0
J3Mgc2hvcnRlciB0aGFuIHRoZSBhcnJheSksIGJ1dCB0aGF0DQo+IHdhc24ndCB0aGUgb25seSwg
ZXIsIG9kZGl0eSBpbiB0aGF0IGNvZGUuDQoNCkluZGVlZCAtIGxvb2tzIGxpa2UgaXQgaXMgY2hl
Y2tpbmcgdGhhdCB0aGUgZmlyc3QgdHdvIGRpcmVjdG9yeSBlbnRyaWVzDQphcmUgIi4iIGFuZCAi
Li4iIGluIGFib3V0IHRoZSBtb3N0IGNvbXBsZXggd2F5IHBvc3NpYmxlLg0KDQpJIGhhdmUgdmFn
dWUgcmVjb2xsZWN0aW9ucyBvbiBzb21lIGNvZGUgdGhhdCBpZ25vcmVkIHRoZSBmaXJzdCB0d28g
ZW50cmllcw0KYmVjYXVzZSB0aGV5ICdtdXN0IGJlICIuIiBhbmQgIi4uIicgLSBhbmQgdGhlbiBm
YWlsZWQgYmVjYXVzZSBzb21lIGZpbGVzeXN0ZW0NCihhbmQgSSBjYW4ndCBldmVuIHJlbWVtYmVy
IHRoZSBPL1MpIGRpZG4ndCBtZWV0IGl0cyBleHBlY3RhdGlvbnMhDQoNCkEgc2ltcGxlOg0KCWlm
IChzdHJjbXAoZGlyX2VudHJ5WzBdLmRlX2ZuYW1lLCAiLiIpIHx8IHN0cmNtcChkaXJfZW50cnlb
MV0uZGVfZm5hbWUsICIuLiIpKQ0KCQllcnJvciA9IDE7DQp3b3VsZCBzdWZmaWNlLg0KVGhlIGNv
bXBpbGVyIG91Z2h0IHRvIGNvbXBsZXRlbHkgaW5saW5lIHRoZW0uDQpPbiB4ODYgdG86DQoJZXJy
b3IgfD0gKih1MTYgKilkaXJfZW50cnlbMF0uZGVfZm5hbWUgXiAnLic7DQoJZXJyb3IgfD0gKCoo
dTMyICopZGlyX2VudHJ5WzFdLmRlX2ZuYW1lICYgMHhmZmZmZmYpIF4gKCcuJyAqIDB4MTAxKTsN
CmJ1dCBJIGJldCBpdCBkb2Vzbid0IQ0KKGFuZCBpdCBpc24ndCBxdWl0ZSB0aGUgc2FtZSkNCg0K
CURhdmlkLg0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=


