Return-Path: <linux-kernel+bounces-576517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98956A71043
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B7E18994FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C461188907;
	Wed, 26 Mar 2025 05:54:47 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25BDC8FE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742968487; cv=none; b=twZ3om+GHNm6bdNTaPtLlr1sV2ZZfwqoHhNbeD5IytjsMvdAc3RtibRoBlaNFOc1rj4eH3KDjd2ePwfnlf5OYx8gY32ivtaAxs82PSBbqi5EaaQlZ5kAG2/zTjRqZnPAPkwE+ENgqFF7uc9S2znLRHkAmVsfABjjdiWkNBbxA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742968487; c=relaxed/simple;
	bh=d1DFvTASiMEJBPDGixpaIGg7iiTua/4vkFQRsLp7XJ8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZK7qFUarvYP2Xjx/JKXH+CGxILHejinu0syZnXG2uWEeDg7fRtzlotzq4GJWsPcv65rWpE3KJS2mJP61OaLSsul9uvxcTWfPHZjMqVH9Q80kXvGDzDR0009H7NLieNrFzqKTWqWzFt12wfMEnqAA0cOGtQc0Yw+uoFfwYaJjTPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202503261354356836;
        Wed, 26 Mar 2025 13:54:35 +0800
Received: from jtjnmail201604.home.langchao.com (10.100.2.4) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Mar 2025 13:54:36 +0800
Received: from jtjnmail201604.home.langchao.com ([fe80::2830:53ee:1228:5322])
 by jtjnmail201604.home.langchao.com ([fe80::2830:53ee:1228:5322%5]) with mapi
 id 15.01.2507.039; Wed, 26 Mar 2025 13:54:36 +0800
From: =?gb2312?B?U2ltb24gV2FuZyAozfW0q7n6KQ==?= <wangchuanguo@inspur.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: migrate: restore the nmask after successfully
 allocating on the  target node
Thread-Topic: [PATCH] mm: migrate: restore the nmask after successfully
 allocating on the  target node
Thread-Index: AdueEvX2cg199QJ4SR+adDWzi4dISQ==
Date: Wed, 26 Mar 2025 05:54:35 +0000
Message-ID: <9e14314cd04645409699ece39443765a@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
tUid: 20253261354357c1c8661663bb5d00c292cd670ae97c6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

DQo+IE9uIFdlZCwgTWFyIDI2LCAyMDI1IGF0IDExOjEyOjE4QU0gKzA4MDAsIHdhbmdjaHVhbmd1
byB3cm90ZToNCj4gPiBJZiBtZW1vcnkgaXMgc3VjY2Vzc2Z1bGx5IGFsbG9jYXRlZCBvbiB0aGUg
dGFyZ2V0IG5vZGUgYW5kIHRoZQ0KPiA+IGZ1bmN0aW9uIGRpcmVjdGx5IHJldHVybnMgd2l0aG91
dCB2YWx1ZSByZXN0b3JlIGZvciBubWFzaywgbm9uLWZpcnN0DQo+ID4gbWlncmF0aW9uIG9wZXJh
dGlvbnMgaW4gbWlncmF0ZV9wYWdlcygpIGJ5IGFnYWluIGxhYmVsIG1heSBpZ25vcmUgdGhlDQo+
ID4gbm1hc2sgc2V0dGluZ3MsIHRoZXJlYnkgYWxsb3dpbmcgbmV3IG1lbW9yeSBhbGxvY2F0aW9u
cyBmb3IgbWlncmF0aW9uDQo+ID4gb24gYW55IG5vZGUuDQo+IA0KPiBJIGhhdmUgbm8gb3Bpbmlv
biBvbiB3aGV0aGVyIHRoaXMgaXMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIG9yIG5vdCwgYnV0IGlm
IGl0IGlzDQo+DQoNCkkgZG9uJ3QgdGhpbmsgc28uIFdoZW4gbWVtb3J5IGFsbG9jYXRpb24gZmFp
bHMgb24gdGhlIHRhcmdldCBub2RlLCB0aGVyZSBpcyBhbHJlYWR5IGEgcmVjb3Zlcnkgb3BlcmF0
aW9uIGZvciB0aGUgbm1hc2sgdmFsdWUgYmVsb3cuIFRoZXJlZm9yZSwgdGhlIG5tYXNrIHZhbHVl
IHNob3VsZCBvbmx5IGJlIHJlc3RvcmVkIHdoZW4gbWVtb3J5IGFsbG9jYXRpb24gaXMgc3VjY2Vz
c2Z1bGx5IGNvbXBsZXRlZCBvbiB0aGUgdGFyZ2V0IG5vZGUuDQoNCj4gPiArKysgYi9tbS92bXNj
YW4uYw0KPiA+IEBAIC0xMDI2LDggKzEwMjYsMTAgQEAgc3RydWN0IGZvbGlvICphbGxvY19taWdy
YXRlX2ZvbGlvKHN0cnVjdCBmb2xpbyAqc3JjLA0KPiB1bnNpZ25lZCBsb25nIHByaXZhdGUpDQo+
ID4gIAltdGMtPm5tYXNrID0gTlVMTDsNCj4gPiAgCW10Yy0+Z2ZwX21hc2sgfD0gX19HRlBfVEhJ
U05PREU7DQo+ID4gIAlkc3QgPSBhbGxvY19taWdyYXRpb25fdGFyZ2V0KHNyYywgKHVuc2lnbmVk
IGxvbmcpbXRjKTsNCj4gPiAtCWlmIChkc3QpDQo+ID4gKwlpZiAoZHN0KSB7DQo+ID4gKwkJbXRj
LT5ubWFzayA9IGFsbG93ZWRfbWFzazsNCj4gPiAgCQlyZXR1cm4gZHN0Ow0KPiA+ICsJfQ0KPiA+
DQo+ID4gIAltdGMtPmdmcF9tYXNrICY9IH5fX0dGUF9USElTTk9ERTsNCj4gPiAgCW10Yy0+bm1h
c2sgPSBhbGxvd2VkX21hc2s7DQo+IA0KPiB0aGlzIHNob3VsZCBiZToNCj4gDQo+IAlkc3QgPSBh
bGxvY19taWdyYXRpb25fdGFyZ2V0KHNyYywgKHVuc2lnbmVkIGxvbmcpbXRjKTsNCj4gKwltdGMt
Pm5tYXNrID0gYWxsb3dlZF9tYXNrOw0KPiAJaWYgKGRzdCkNCj4gCQlyZXR1cm4gZHN0Ow0KPiAN
Cj4gCW10Yy0+Z2ZwX21hc2sgJj0gfl9fR0ZQX1RISVNOT0RFOw0KPiAtCW10Yy0+bm1hc2sgPSBh
bGxvd2VkX21hc2s7DQo=

