Return-Path: <linux-kernel+bounces-375600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D20A99A980F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793341F22BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4802481751;
	Tue, 22 Oct 2024 04:52:26 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52E1C27
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729572745; cv=none; b=rMvSCXQflaQWPzFhWyG3L7jN8pG+ZPL8bvkQ/mhHMTujydalkpett+1Z1BL3Q485GPI5Pn3lnvfb7gVZo3a7A0dv2F582qs147FtJ45VEfPbfOsXIJyaqkd3m5daqAIRYbIj5at/XAtHVLoEQYm3NGNJywBBSTK8jiLwStl5sqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729572745; c=relaxed/simple;
	bh=vFnMMCXlPqjWR/jnxeFdZHoUu936YlMulc6HV3LIs2E=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=TpYqxSBov/FUqvy74FSGRPWZenYySXtw7GbgX+rPeESBqr1mYVYYVtPi73HBdi4WwsvjueAHP3P9I+O3/7Fr2XB+5w5xENRFU5yjmErVVtHLbVmAhQPbADYS3BKwaFHksAN8IkUabpwpeuud2ryiP//1nnd2UgEJIF1A9umRTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-GoodBg: 2
X-BAN-DOWNLOAD: 1
X-BAN-SHARE: 1
X-QQ-SSF: 0040000000000060
X-QQ-FEAT: D4aqtcRDiqQpBpTnjIJt3/f21w9WO3enREO5ZSgO7MU=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 6OknCajsr0V6SHUI4fdE11uCBtvd2djKoj+0O98d75A=
X-QQ-STYLE: 
X-QQ-mid: t6gz5a-0t1729572647t2240862
From: "=?utf-8?B?6Jme6ZmG6ZOt?=" <luming.yu@shingroup.cn>
To: "=?utf-8?B?Q2hyaXN0b3BoZSBMZXJveQ==?=" <christophe.leroy@csgroup.eu>, "=?utf-8?B?bGludXhwcGMtZGV2?=" <linuxppc-dev@lists.ozlabs.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bXBl?=" <mpe@ellerman.id.au>, "=?utf-8?B?bnBpZ2dpbg==?=" <npiggin@gmail.com>, "=?utf-8?B?amlhbG9uZy55YW5n?=" <jialong.yang@shingroup.cn>, "=?utf-8?B?bHVtaW5nLnl1?=" <luming.yu@gmail.com>
Subject: Re: [PATCH 1/7] powerpc/entry: convert to common and generic entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 22 Oct 2024 12:50:47 +0800
X-Priority: 3
Message-ID: <tencent_381ACB160B890CC46678170E@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <88E2581B1D024E9A+20241012035621.1245-3-luming.yu@shingroup.cn>
	<e9595d8b-d1e2-4c6a-b097-6f4f08d29866@csgroup.eu>
In-Reply-To: <e9595d8b-d1e2-4c6a-b097-6f4f08d29866@csgroup.eu>
X-QQ-ReplyHash: 303108142
X-BIZMAIL-ID: 11601653849768611381
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 22 Oct 2024 12:50:48 +0800 (CST)
Feedback-ID: t:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: OZg1hzYlSoBDCGRAhYCo+fXUlA/Zx9NevcNO13CuAuM+kIn254STmw9G
	/rT+wYfihb0Iq2IGzdeUVjx9jq/5k2KOruvfcqWMLHKXLq2ubPOAz9OVxtv8vohMuPKQsC3
	uII71gfmyvJtZifTByVn4cvWzNewovRszi6Czvr3geIAeNVI2n+QyEDDCeHBJ7JC8LnzjRJ
	olRBQ72kHrJP5y+I1zUVRd01cHk7jEmNNux6sK55xzaiW5IQRor+bZoADzTnCWE65BypxxL
	tsmMTnYtBiDKtI5YgBRwt+Q+v9VIYt/7zLAnT5kFjgqjzFg2XIp3bZqkSX073NJq1bVWwFt
	Mp7Nk4M41mMPSdKcRrtme5CNaTm/hHTqMTzOKAZz3LxKN7Y6VrTkjeVExNT5eE9niq6n5P1
	hHpOIz04XGnWMuxiwa+6PQPevHnEFS0mFSdfjsZdIKpYZfc3KM8u4PAKbwxV6QG8eRiGYj9
	Tvkw82oUsnm6R/HvElmvtGBLK4Vjp3gSf9qZ9n4dKdE6N5RjJ2ODUvbdsb0/5F6VsOQct01
	nXkyfLQcG64YuKwPXZDYDosxwUGdiVpEL4+0KNU/JYuatYcuumzHZ8J4OxUQD3wc17ju5dz
	rAIghbJdSxRWo/fbl/1AknbkVXIf66sdrMWaRNHyPG/91+HZhlThqzxcLRpfawL7wMix5Ny
	C9fvykcv1epT5OX/q6nz3VF6gkFKPKQiSuQ4uHF7B9HkBT67TFgIVniqm3Q8G93rmX/q36u
	6KvlU/zH/i/yj9jo8UEZhIpx5Oi0lWCJPtKzkY8cqGrTYYBpPwvC4e66oBrseAGeijPl93T
	VG5mAoWIHA2FGqHST8vPlQoZEadnm9UPEqZStC3Aaftn6JCvF0ug7EWp8essE+d7ExlTsYB
	74ytYkWVnojaPfpEsr/hNjwuP9C9nUNIhC4HXuQeFt3+Q4dXO3/2+Q==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

PkxlIDEyLzEwLzIwMjQgw6AgMDU6NTYsIEx1bWluZyBZdSBhIMOpY3JpdCA6DQo+PiBjb252
ZXJ0IHBvd2VycGMgZW50cnkgY29kZSBpbiBzeXNjYWxsIGFuZCBmYXVsdCB0byB1c2Ugc3lz
Y2FsbF93b3JrDQo+PiBhbmQgaXJxZW50cnlfc3RhdGUgYXMgd2VsbCBhcyBjb21tb24gY2Fs
bHMgaW1wbGVtZW50ZWQgaW4gZ2VuZXJpYw0KPj4gZW50cnkgaW5mcmFzdHJ1Y3R1cmUuDQo+
PiANCj4+IFNpZ25lZC1vZmYtYnk6IEx1bWluZyBZdSA8bHVtaW5nLnl1QHNoaW5ncm91cC5j
bj4NCj4+IC0tLQ0KPj4gICBhcmNoL3Bvd2VycGMvS2NvbmZpZyAgICAgICAgICAgICAgICAg
ICB8IDEgKw0KPj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vaHdfaXJxLmggICAgICB8
IDUgKysrKysNCj4+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oICAg
fCA2ICsrKysrKw0KPj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vc3lzY2FsbC5oICAg
ICB8IDUgKysrKysNCj4+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3RocmVhZF9pbmZv
LmggfCAxICsNCj4+ICAgYXJjaC9wb3dlcnBjL2tlcm5lbC9zeXNjYWxsLmMgICAgICAgICAg
fCA1ICsrKystDQo+PiAgIGFyY2gvcG93ZXJwYy9tbS9mYXVsdC5jICAgICAgICAgICAgICAg
IHwgMyArKysNCj4+ICAgNyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+PiANCj4NCj4uLi4NCj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2Vy
cGMva2VybmVsL3N5c2NhbGwuYyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvc3lzY2FsbC5jDQo+
PiBpbmRleCA3N2ZlZGIxOTBjOTMuLmUwMzM4YmQ4ZDM4MyAxMDA2NDQNCj4+IC0tLSBhL2Fy
Y2gvcG93ZXJwYy9rZXJuZWwvc3lzY2FsbC5jDQo+PiArKysgYi9hcmNoL3Bvd2VycGMva2Vy
bmVsL3N5c2NhbGwuYw0KPj4gQEAgLTMsNiArMyw3IEBADQo+PiAgICNpbmNsdWRlIDxsaW51
eC9jb21wYXQuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2NvbnRleHRfdHJhY2tpbmcuaD4N
Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L3JhbmRvbWl6ZV9rc3RhY2suaD4NCj4+ICsjaW5jbHVk
ZSA8bGludXgvZW50cnktY29tbW9uLmg+DQo+PiAgIA0KPj4gICAjaW5jbHVkZSA8YXNtL2lu
dGVycnVwdC5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL2t1cC5oPg0KPj4gQEAgLTEzMSw3ICsx
MzIsNyBAQCBub3RyYWNlIGxvbmcgc3lzdGVtX2NhbGxfZXhjZXB0aW9uKHN0cnVjdCBwdF9y
ZWdzICpyZWdzLCB1bnNpZ25lZCBsb25nIHIwKQ0KPj4gICAJCSAqIGFuZCB0aGUgdGVzdCBh
Z2FpbnN0IE5SX3N5c2NhbGxzIHdpbGwgZmFpbCBhbmQgdGhlIHJldHVybg0KPj4gICAJCSAq
IHZhbHVlIHRvIGJlIHVzZWQgaXMgaW4gcmVncy0+Z3ByWzNdLg0KPj4gICAJCSAqLw0KPj4g
LQkJcjAgPSBkb19zeXNjYWxsX3RyYWNlX2VudGVyKHJlZ3MpOw0KPj4gKwkJcjAgPSBzeXNj
YWxsX2VudGVyX2Zyb21fdXNlcl9tb2RlKHJlZ3MsIHIwKTsNCj4NCj5DYW4geW91IHByb3Zp
ZGUgZGV0YWlscyBvbiBob3cgdGhpcyB3b3JrcyA/DQpJIGFzc3VtZSB0aGUgY29tbW9uIGVu
dHJ5IHdvdWxkIHRha2Ugb3ZlciB0aCBkZXRhaWxzLg0KU28gSSBqdXN0IG1hZGUgdGhlIHN3
aXRjaCBmcm9tIHRoZSBoaWdoIGxldmVsIGNhbGwuDQoNCkFzIHlvdSBzYWlkIGFzIHRoZSBz
dWJ0bGUgQUJJIHJlcXVpcmVtZW50IGFib3V0IHJlZ3MtPnIzIG5lZWRzIHRvDQpiZSByZXN0
b3JlZCwgSSdtIHdvbmRlcmluZyB3aGljaCB0ZXN0IGNhbiBjYXB0dXJlIHRoZSBsb3N0DQpB
QkkgZmVhdHVyZS4gQXMgc2ltcGxlIEJvb3QgdGVzdCBpcyBpbnN1ZmZpY2llbnQsIHdoYXQg
aXMgdGhlIHRlc3Qgc2V0DQp0aGF0IGNhbiBjYXB0dXJlIGl0Pw0KDQpJIHdpbGwgbG9vayBp
bnRvIHRoZSBkZXRhaWxzIGxhdGUgdGhpcyB3ZWVrLg0KDQo+DQo+Rm9yIGluc3RhbmNlLCBk
b19zeXNjYWxsX3RyYWNlX2VudGVyKCkgd2FzIGNhbGxpbmcgZG9fc2VjY29tcCgpLg0KPmRv
X3NlY2NvbXAoKSBzZXRzIHJlZ3MtPnIzIHRvIC1FTk9TWVMgdGhlbiBjYWxscyBfX3NlY3Vy
ZV9jb21wdXRpbmcoKS4NCj4NCj5Ob3cgeW91IGNhbGwgc3lzY2FsbF9lbnRlcl9mcm9tX3Vz
ZXJfbW9kZSgpIGluc3RlYWQgd2hpY2ggY2FsbHMgDQo+c3lzY2FsbF9lbnRlcl9mcm9tX3Vz
ZXJfbW9kZV93b3JrKCkgd2hpY2ggY2FsbHMgc3lzY2FsbF90cmFjZV9lbnRlcigpIA0KPndo
aWNoIGNhbGxzICBfX3NlY3VyZV9jb21wdXRpbmcoKSBidXQgd2l0aG91dCBzZXRpbmcgcmVn
cy0+cjMgdG8gLUVOT1NZUy4NCj4NCj5TbyB3aGF0IHdpbGwgYmUgcmV0dXJuZWQgYnkgdGhl
IGJlbG93IHJldHVybiB3aGVuIA0KPnN5c2NhbGxfZW50ZXJfZnJvbV91c2VyX21vZGUgcmV0
dXJucyAtMSA/DQo+DQo+PiAgIAkJaWYgKHVubGlrZWx5KHIwID49IE5SX3N5c2NhbGxzKSkN
Cj4+ICAgCQkJcmV0dXJuIHJlZ3MtPmdwclszXTsNCj4+ICAgDQo+PiBAQCAtMTg0LDYgKzE4
NSw4IEBAIG5vdHJhY2UgbG9uZyBzeXN0ZW1fY2FsbF9leGNlcHRpb24oc3RydWN0IHB0X3Jl
Z3MgKnJlZ3MsIHVuc2lnbmVkIGxvbmcgcjApDQo+PiAgIAkgKiBTbyB0aGUgcmVzdWx0aW5n
IDYgb3IgNyBiaXRzIG9mIGVudHJvcHkgaXMgc2VlbiBpbiBTUFs5OjRdIG9yIFNQWzk6M10u
DQo+PiAgIAkgKi8NCj4+ICAgCWNob29zZV9yYW5kb21fa3N0YWNrX29mZnNldChtZnRiKCkp
Ow0KPj4gKwkvKmNvbW1vbiBlbnRyeSovDQo+PiArCXN5c2NhbGxfZXhpdF90b191c2VyX21v
ZGUocmVncyk7DQo+PiAgIA0KPj4gICAJcmV0dXJuIHJldDsNCj4+ICAgfQ==


