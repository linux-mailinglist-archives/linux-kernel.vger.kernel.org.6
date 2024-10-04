Return-Path: <linux-kernel+bounces-350286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF9B9902DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6566F1C21675
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91539158531;
	Fri,  4 Oct 2024 12:23:41 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A92747B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044621; cv=none; b=B/iwG/KGQ9TAxH4ym09TvhsmMAJz3kwxtc0Q+qASznhosPGby3YfCznHQcusqvbXEE0+3RCIIFSTtOXAGq9czphoNu674X4yqL9pB8SRIKq+wt7ZcqBkedSKRikR6rggm5gzzry1Kcumb6ije33D8CViLNDSyFLu7aFEoZ/sQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044621; c=relaxed/simple;
	bh=CRZcmjSIcFD8XU0GK7jNwnJodgHcgTk0BKBgoO4i4p8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b+unVGa1Wl6KL1/EgwFITUOkAsMaoUfbgFMCn6hUHsZV/geBWVDlwsHtj2rBuYHEzmK9RCiMZG0FLA4HLjFzi7rkyof3MqUe3jo30XYSwmaEE7+/DkxSbMheEZ3UgzZ4U5ud/2rF+WdMgogId5aSlCGAQVcQ/EquKQEq8f95aYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 99WfucRSSGSCvoic1wmNQA==
X-CSE-MsgGUID: SJbPCQoUQtSNTdbyisd44Q==
X-IronPort-AV: E=Sophos;i="6.11,177,1725292800"; 
   d="scan'208";a="123716249"
From: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
To: Frank van der Linden <fvdl@google.com>, David Hildenbrand
	<david@redhat.com>
CC: Xiang Gao <gxxa03070307@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbRXh0ZXJuYWwgTWFpbF1SZTogW1BBVENIIHYyXSBtbS9jbWE6?=
 =?utf-8?Q?_print_total_and_used_count_in_cma=5Falloc()?=
Thread-Topic: [External Mail]Re: [PATCH v2] mm/cma: print total and used count
 in cma_alloc()
Thread-Index: AQHbExvuUXqGmfuj+0Ctu2enzH7obbJzXD0AgAMru1A=
Date: Fri, 4 Oct 2024 12:23:30 +0000
Message-ID: <2a7b7fc3a48d4bb9a6394e51af074017@xiaomi.com>
References: <20240929032757.404707-1-gxxa03070307@gmail.com>
 <f8dde346-8a81-4cca-8497-987f6e4b5e58@redhat.com>
 <CAPTztWY-CD9REdJq_-HeELJ+dX68+OZC76T0F+YMyZKMc-DHug@mail.gmail.com>
In-Reply-To: <CAPTztWY-CD9REdJq_-HeELJ+dX68+OZC76T0F+YMyZKMc-DHug@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

LS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBGcmFuayB2YW4gZGVyIExpbmRlbiA8
ZnZkbEBnb29nbGUuY29tPiANCuWPkemAgeaXtumXtDogMjAyNOW5tDEw5pyIM+aXpSAzOjUwDQrm
lLbku7bkuro6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0K5oqE6YCBOiBY
aWFuZyBHYW8gPGd4eGEwMzA3MDMwN0BnbWFpbC5jb20+OyBha3BtQGxpbnV4LWZvdW5kYXRpb24u
b3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IOmr
mOe/lCA8Z2FveGlhbmcxN0B4aWFvbWkuY29tPg0K5Li76aKYOiBbRXh0ZXJuYWwgTWFpbF1SZTog
W1BBVENIIHYyXSBtbS9jbWE6IHByaW50IHRvdGFsIGFuZCB1c2VkIGNvdW50IGluIGNtYV9hbGxv
YygpDQoNClvlpJbpg6jpgq7ku7ZdIOatpOmCruS7tuadpea6kOS6juWwj+exs+WFrOWPuOWklumD
qO+8jOivt+iwqOaFjuWkhOeQhuOAguiLpeWvuemCruS7tuWuieWFqOaAp+WtmOeWke+8jOivt+Ww
humCruS7tui9rOWPkee7mW1pc2VjQHhpYW9taS5jb23ov5vooYzlj43ppogNCg0KT24gTW9uLCBT
ZXAgMzAsIDIwMjQgYXQgMjozNOKAr0FNIERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQu
Y29tPiB3cm90ZToNCj4NCj4gT24gMjkuMDkuMjQgMDU6MjcsIFhpYW5nIEdhbyB3cm90ZToNCj4g
PiBGcm9tOiBnYW94aWFuZzE3IDxnYW94aWFuZzE3QHhpYW9taS5jb20+DQo+ID4NCj4NCj4gV2Ug
c2hvdWxkIGFkZCBoZXJlDQo+DQo+ICJUbyBkZWJ1ZyBDTUEgYWxsb2NhdGlvbnMgKGVzcGVjaWFs
bHkgZmFpbGluZyBvbmVzKSwgaXQgaXMgdmFsdWFibGUgdG8gDQo+IGtub3cgdGhlIHN0YXRlIG9m
IENNQTogaG93IG1hbnkgcGFnZXMgb3V0IG9mIHRoZSB0b3RhbCBvbmVzIGFyZSANCj4gYWxsb2Nh
dGVkLCBhbmQgaG93IG1hbnkgd2VyZSByZXF1ZXN0ZWQgdG8gYmUgYWxsb2NhdGVkLiBMZXQncyBw
cmludCANCj4gc29tZSBtb3JlIGluZm9ybWF0aW9uLiINCj4NCj4gSSBhc3N1bWUgQW5kcmV3IGNh
biBmaXggdGhhdCB1cCB3aGVuIGFwcGx5aW5nLg0KPg0KPiA+IGJlZm9yZToNCj4gPiBbICAgMjQu
NDA3ODE0XSBjbWE6IGNtYV9hbGxvYyhjbWEgKF9fX19wdHJ2YWxfX19fKSwgbmFtZTogcmVzZXJ2
ZWQsIGNvdW50IDEsIGFsaWduIDApDQo+ID4gWyAgIDI0LjQxMzM5N10gY21hOiBjbWFfYWxsb2Mo
Y21hIChfX19fcHRydmFsX19fXyksIG5hbWU6IHJlc2VydmVkLCBjb3VudCAxLCBhbGlnbiAwKQ0K
PiA+IFsgICAyNC40MTU4ODZdIGNtYTogY21hX2FsbG9jKGNtYSAoX19fX3B0cnZhbF9fX18pLCBu
YW1lOiByZXNlcnZlZCwgY291bnQgMSwgYWxpZ24gMCkNCj4gPg0KPiA+IGFmdGVyOg0KPiA+IFsg
ICAyNC4wNjk3MzhdIGNtYTogY21hX2FsbG9jKGNtYSAoX19fX3B0cnZhbF9fX18pLCBuYW1lOiBy
ZXNlcnZlZCwgdG90YWwgcGFnZXM6IDE2Mzg0LCB1c2VkIHBhZ2VzOiA2NCwgcmVxdWVzdCBwYWdl
czogMSwgYWxpZ24gMCkNCj4gPiBbICAgMjQuMDc1MzE3XSBjbWE6IGNtYV9hbGxvYyhjbWEgKF9f
X19wdHJ2YWxfX19fKSwgbmFtZTogcmVzZXJ2ZWQsIHRvdGFsIHBhZ2VzOiAxNjM4NCwgdXNlZCBw
YWdlczogNjUsIHJlcXVlc3QgcGFnZXM6IDEsIGFsaWduIDApDQo+ID4gWyAgIDI0LjA3ODQ1NV0g
Y21hOiBjbWFfYWxsb2MoY21hIChfX19fcHRydmFsX19fXyksIG5hbWU6IHJlc2VydmVkLCB0b3Rh
bCBwYWdlczogMTYzODQsIHVzZWQgcGFnZXM6IDY2LCByZXF1ZXN0IHBhZ2VzOiAxLCBhbGlnbiAw
KQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogZ2FveGlhbmcxNyA8Z2FveGlhbmcxN0B4aWFvbWku
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgbW0vY21hLmMgfCAxNSArKysrKysrKysrKysrLS0NCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL21tL2NtYS5jIGIvbW0vY21hLmMNCj4gPiBpbmRleCAyZDlmYWU5Mzky
ODMuLjkwYjNmZGJhYzE5YyAxMDA2NDQNCj4gPiAtLS0gYS9tbS9jbWEuYw0KPiA+ICsrKyBiL21t
L2NtYS5jDQo+ID4gQEAgLTQwMyw2ICs0MDMsMTcgQEAgc3RhdGljIHZvaWQgY21hX2RlYnVnX3No
b3dfYXJlYXMoc3RydWN0IGNtYSAqY21hKQ0KPiA+ICAgICAgIHNwaW5fdW5sb2NrX2lycSgmY21h
LT5sb2NrKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdW5zaWduZWQgbG9uZyBjbWFfZ2V0
X3VzZWRfcGFnZXMoc3RydWN0IGNtYSAqY21hKSB7DQo+ID4gKyAgICAgdW5zaWduZWQgbG9uZyB1
c2VkOw0KPiA+ICsNCj4gPiArICAgICBzcGluX2xvY2tfaXJxKCZjbWEtPmxvY2spOw0KPiA+ICsg
ICAgIHVzZWQgPSBiaXRtYXBfd2VpZ2h0KGNtYS0+Yml0bWFwLCAoaW50KWNtYV9iaXRtYXBfbWF4
bm8oY21hKSk7DQo+ID4gKyAgICAgc3Bpbl91bmxvY2tfaXJxKCZjbWEtPmxvY2spOw0KPg0KPiBU
aGlzIGFkZHMgb3ZlcmhlYWQgdG8gZWFjaCBhbGxvY2F0aW9uLCBldmVuIGlmIGRlYnVnIG91dHB1
dHMgYXJlIA0KPiBpZ25vcmVkIEkgYXNzdW1lPw0KPg0KPiBJIHdvbmRlciBpZiB3ZSdkIHdhbnQg
dG8gcHJpbnQgdGhlc2UgZGV0YWlscyBvbmx5IHdoZW4gb3VyIGFsbG9jYXRpb24gDQo+IGZhaWxl
ZD8NCj4NCj4gQWx0ZXJuYXRpdmVseSwgd2UgY291bGQgYWN0dWFsbHkgdHJhY2sgaG93IG1hbnkg
cGFnZXMgYXJlIGFsbG9jYXRlZCBpbiANCj4gdGhlIGNtYSwgc28gd2UgZG9uJ3QgaGF2ZSB0byB0
cmF2ZXJzZSB0aGUgY29tcGxldGUgYml0bWFwIG9uIGV2ZXJ5IA0KPiBhbGxvY2F0aW9uLg0KPg0K
DQpZZXAsIHRoYXQncyB3aGF0IEkgZGlkIGFzIHBhcnQgb2YNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDI0MDcyNDEyNDg0NS42MTRjMDNhZDM5ZjhhZjM3MjljZWJlZTZAbGludXgtZm91
bmRhdGlvbi5vcmcvVC8NCg0KVGhhdCBwYXRjaCBkaWRuJ3QgbWFrZSBpdCBpbiAoeWV0KS4gSSdt
IGhhcHB5IGZvciBpdCB0byBiZSBjb21iaW5lZCB3aXRoIHRoaXMgb25lIGlmIHRoYXQncyBlYXNp
ZXIuDQoNCi0gRnJhbmsNCg0KWWVzLCBJIHRoaW5rIGl0J3Mgc2ltcGxlciB0byBhZGQgbmV3IG1l
bWJlcnMgdG8gdGhlIGNtYSBzdHJ1Y3R1cmUgdG8gbWFuYWdlLiANClRoaXMgZG9lcyBub3QgYWRk
IG11Y2ggb3ZlcmhlYWQgdG8gdGhlIHVzZWQgY291bnQgcGVyIHByaW50Lg0KDQpJZiB0aGlzIGlz
IHBvc3NpYmxlLCB3ZSBjYW4gYWxzbyBhZGQgImNhbGxlciIgbWVtYmVycyB0byB0cm91Ymxlc2hv
b3QgcHJvYmxlbXMuDQo=

