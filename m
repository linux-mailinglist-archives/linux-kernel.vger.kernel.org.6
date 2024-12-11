Return-Path: <linux-kernel+bounces-440848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028409EC557
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361662860CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39B91C5CB1;
	Wed, 11 Dec 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="aUsL7+t7"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7E1C683;
	Wed, 11 Dec 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900906; cv=none; b=S86Qi8toV85YHOKNdt5Ox8sYk0tLYe53Z5XjktnBxeV3ryW/knkhI3GCiPP2vIGvh5mNeiBxMPY2F5f0+zdTccCVnJyIo+FI6onSL8X5MrSTgzHMDfad5ev+3jnqLW+BMs3DNEd5MYwuuqB70U7BKpibRIDe3X3eD2G0V9bmeXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900906; c=relaxed/simple;
	bh=7IAaOb9H0dXCZaH3BxnTLpHYi5/c5RJbSWTWjOugDMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ZfD0/8vaUVxC5AHU+kDzflWI1hA1jCpARZENUFvtsCuM+N8VaMW9pvrDdepypbPONZqf1v86DAsl/rBfgcwUX1mwXi5YPtEXS1ZaW5WFtWoz5ux7vUUPjlhGQ3QbEO3emvgXoX60QTiwNYuzlHAGrWknjJ2fFdlBZ+kBHhOm24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=aUsL7+t7 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=em8z400Yjxvmy5FE4gJ5vG/BboB+xasR8mAbFiKC2ig=; b=a
	UsL7+t7J3xah3PH85D0WGvuQQ0idElGilFsAVMoWKI/xxwxbwGmpuuN2oSjtY6g1
	b0q8q12oSmYQvbTiXDwKspMnDmX/LytP2PinMFERm3HxllVZ6fkhAw/hhn6shR88
	9oPzMC5Ms3teoQUV3w67ahRxPYogRvMtRJ2zcmB2pA=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-102 (Coremail) ; Wed, 11 Dec 2024 15:07:21 +0800
 (CST)
Date: Wed, 11 Dec 2024 15:07:21 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: hjc@rock-chips.com, krzk+dt@kernel.org, s.hauer@pengutronix.de, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, derek.foreman@collabora.com, 
	detlev.casanova@collabora.com, "Andy Yan" <andy.yan@rock-chips.com>, 
	"Michael Riesch" <michael.riesch@wolfvision.net>
Subject: Re:Re: [PATCH v5 01/18] drm/rockchip: vop2: Add debugfs support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <4471861.MSiuQNM8U4@diego>
References: <20241209122943.2781431-1-andyshrk@163.com>
 <20241209122943.2781431-4-andyshrk@163.com> <4471861.MSiuQNM8U4@diego>
X-NTES-SC: AL_Qu2YAfWbv0Av5yeYZukZnEobh+Y5UcK2s/ki2YFXN5k0tCTI0SYQW29KGUD2y86DDiKsoAirUQVL5MpFRpJHY44O5ZHuAvn9d2IiHBf8lhwP
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <121ab3c0.68d0.193b48b32ed.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZigvCgDXf2YpOllnXYI8AA--.65315W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwCyXmdZM7GV6gAIsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEhlaWtvLAoKQXQgMjAyNC0xMi0xMCAxOTo1Nzo0NCwgIkhlaWtvIFN0w7xibmVyIiA8aGVp
a29Ac250ZWNoLmRlPiB3cm90ZToKPkhpIEFuZHksCj4KPkFtIE1vbnRhZywgOS4gRGV6ZW1iZXIg
MjAyNCwgMTM6Mjk6MTMgQ0VUIHNjaHJpZWIgQW5keSBZYW46Cj4+IEZyb206IEFuZHkgWWFuIDxh
bmR5LnlhbkByb2NrLWNoaXBzLmNvbT4KPj4gCj4+IC9zeXMva2VybmVsL2RlYnVnL2RyaS92b3Ay
L3N1bW1hcnk6ICBkdW1wIHZvcCBkaXNwbGF5IHN0YXRlCj4+IC9zeXMva2VybmVsL2RlYnVnL2Ry
aS92b3AyL3JlZ3M6IGR1bXAgd2hvbGUgdm9wIHJlZ2lzdGVycwo+PiAvc3lzL2tlcm5lbC9kZWJ1
Zy9kcmkvdm9wMi9hY3RpdmVfcmVnczogb25seSBkdW1wIHRoZSByZWdpc3RlcnMgb2YKPj4gYWN0
aXZhdGVkIG1vZHVsZXMKPj4gCj4+IFJldmlld2VkLWJ5OiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU+Cj4+IFNpZ25lZC1vZmYtYnk6IEFuZHkgWWFuIDxhbmR5LnlhbkByb2Nr
LWNoaXBzLmNvbT4KPj4gVGVzdGVkLWJ5OiBNaWNoYWVsIFJpZXNjaCA8bWljaGFlbC5yaWVzY2hA
d29sZnZpc2lvbi5uZXQ+ICMgb24gUkszNTY4Cj4+IFRlc3RlZC1ieTogRGV0bGV2IENhc2Fub3Zh
IDxkZXRsZXYuY2FzYW5vdmFAY29sbGFib3JhLmNvbT4KPj4gLS0tCj4KPj4gK3N0YXRpYyB2b2lk
IF9fdm9wMl9yZWdzX2R1bXAoc3RydWN0IHNlcV9maWxlICpzLCBib29sIGFjdGl2ZV9vbmx5KQo+
PiArewo+PiArCXN0cnVjdCBkcm1faW5mb19ub2RlICpub2RlID0gcy0+cHJpdmF0ZTsKPj4gKwlz
dHJ1Y3Qgdm9wMiAqdm9wMiA9IG5vZGUtPmluZm9fZW50LT5kYXRhOwo+PiArCXN0cnVjdCBkcm1f
bWlub3IgKm1pbm9yID0gbm9kZS0+bWlub3I7Cj4+ICsJc3RydWN0IGRybV9kZXZpY2UgKmRybV9k
ZXYgPSBtaW5vci0+ZGV2Owo+PiArCWNvbnN0IHN0cnVjdCB2b3AyX3JlZ3NfZHVtcCAqZHVtcDsK
Pj4gKwl1bnNpZ25lZCBpbnQgaTsKPj4gKwo+PiArCWRybV9tb2Rlc2V0X2xvY2tfYWxsKGRybV9k
ZXYpOwo+PiArCj4+ICsJcmVnY2FjaGVfZHJvcF9yZWdpb24odm9wMi0+bWFwLCAwLCB2b3AyX3Jl
Z21hcF9jb25maWcubWF4X3JlZ2lzdGVyKTsKPj4gKwo+PiArCWlmICh2b3AyLT5lbmFibGVfY291
bnQpIHsKPj4gKwkJZm9yIChpID0gMDsgaSA8IHZvcDItPmRhdGEtPnJlZ3NfZHVtcF9zaXplOyBp
KyspIHsKPj4gKwkJCWR1bXAgPSAmdm9wMi0+ZGF0YS0+cmVnc19kdW1wW2ldOwo+PiArCQkJdm9w
Ml9yZWdzX3ByaW50KHZvcDIsIHMsIGR1bXAsIGFjdGl2ZV9vbmx5KTsKPj4gKwkJfQo+PiArCX0g
ZWxzZSB7Cj4+ICsJCXNlcV9wcmludGYocywgIlZPUCBkaXNhYmxlZFxuIik7Cj4+ICsJfQo+PiAr
CWRybV9tb2Rlc2V0X3VubG9ja19hbGwoZHJtX2Rldik7Cj4+ICsKPgo+bml0OiBub3QgbmVlZGVk
IGVtcHR5IGxpbmUgYXQgdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24KCldpbGwgZml4ZWQgaW4gVjYu
Cgo+Cj4+ICt9Cj4+ICsKPgo+PiArc3RhdGljIHZvaWQgdm9wMl9kZWJ1Z2ZzX2luaXQoc3RydWN0
IHZvcDIgKnZvcDIsIHN0cnVjdCBkcm1fbWlub3IgKm1pbm9yKQo+PiArewo+PiArCXN0cnVjdCBk
ZW50cnkgKnJvb3Q7Cj4+ICsJdW5zaWduZWQgaW50IGk7Cj4+ICsKPj4gKwlyb290ID0gZGVidWdm
c19jcmVhdGVfZGlyKCJ2b3AyIiwgbWlub3ItPmRlYnVnZnNfcm9vdCk7Cj4+ICsJaWYgKCFJU19F
UlIocm9vdCkpIHsKPj4gKwkJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUodm9wMl9kZWJ1Z2Zz
X2xpc3QpOyBpKyspCj4+ICsJCQl2b3AyX2RlYnVnZnNfbGlzdFtpXS5kYXRhID0gdm9wMjsKPj4g
Kwo+PiArCQlkcm1fZGVidWdmc19jcmVhdGVfZmlsZXModm9wMl9kZWJ1Z2ZzX2xpc3QsCj4+ICsJ
CQkJCSBBUlJBWV9TSVpFKHZvcDJfZGVidWdmc19saXN0KSwKPj4gKwkJCQkJIHJvb3QsIG1pbm9y
KTsKPj4gKwl9Cj4+ICt9Cj4+ICsKPj4gK3N0YXRpYyBpbnQgdm9wMl9jcnRjX2xhdGVfcmVnaXN0
ZXIoc3RydWN0IGRybV9jcnRjICpjcnRjKQo+PiArewo+PiArCXN0cnVjdCB2b3AyX3ZpZGVvX3Bv
cnQgKnZwID0gdG9fdm9wMl92aWRlb19wb3J0KGNydGMpOwo+PiArCXN0cnVjdCB2b3AyICp2b3Ay
ID0gdnAtPnZvcDI7Cj4+ICsKPj4gKwlpZiAoZHJtX2NydGNfaW5kZXgoY3J0YykgPT0gMCkKPj4g
KwkJdm9wMl9kZWJ1Z2ZzX2luaXQodm9wMiwgY3J0Yy0+ZGV2LT5wcmltYXJ5KTsKPj4gKwo+PiAr
CXJldHVybiAwOwo+PiArfQo+Cj5JJ20gd29uZGVyaW5nIGFib3V0LCBzaG91ZGxuJ3QgdGhlcmUg
YmUgYW4gdW5yZWdpc3RlciBzdGVwIHRvbz8KPkkuZS4gdGhlIGxhdGVfcmVnaXN0ZXIgY2FsbGJh
Y2sgc2F5czoKPiJzaG91bGQgYmUgdW5yZWdpc3RlcmVkIGluIHRoZSBlYXJseV91bnJlZ2lzdGVy
IGNhbGxiYWNrIiBbMF0uCj4KPkFuZCB0aGVyZSBleGlzdHMgZHJtX2RlYnVnZnNfcmVtb3ZlX2Zp
bGVzKCksIHRob3VnaCBpdCBkb2Vzbid0Cj5zZWVtIHQgYmUgdXNlZCBtdWNoIC0ganVzdCBieSB0
ZWdyYS4KPgo+SSBoYXZlbid0IG1hbmFnZWQgdG8gZmluZCBkcm0gY29kZSBoYW5kbGluZyB0aGF0
IGF1dG9tYXRpY2FsbHkgdGhvdWdoPwoKRGlkIGEgbGl0dGxlIGRpZ2dpbmfvvJoKIHJvY2tjaGlw
X2RybV91bmJpbmQgLS3jgItkcm1fZGV2X3VucmVnaXN0ZXIoZHJtX2RldiktLeOAi2RybV9kZWJ1
Z2ZzX2Rldl9maW5pCi0t44CLZGVidWdmc19yZW1vdmVfcmVjdXJzaXZlKGRldi0+ZGVidWdmc19y
b290KTsKVGhpcyB3aWxsIHJlbW92ZSBhbGwgdGhlIGRlYnVnZnMgZmlsZSB1bmRlciAvZHJpLzAt
LT5kaXNwbGF5LXN1YnN5c3RlbSAgd2hlbiB3ZQpyZW1vdmUgcm9ja2NoaXBkcm0gd2hlbiBpdCBi
dWlsZCBhcyBtb2R1bGUuCklmIGl0IGlzIGJ1aWx0aW4sIHdoZXRoZXIgd2UgcmVtb3ZlIHRoZW0g
c2VlbXMgdG8gbWFrZSBubyBkaWZmZXJlbmNlIHdoZW4gd2UKcmVib290IG9yIHRodXRkb3duIHRo
ZSBzeXN0ZW0gPwpJIGFsc28gc2VhcmNoZWQgZm9yIG90aGVyIHBsYXRmb3JtcyB1c2luZyBzaW1p
bGFyIGxhdGUgcmVnaXN0ZXIgaG9vaywgYW5kIGl0IHNlZW1zIHRoZXkgaGF2ZW4ndCByZW1vdmUg
ZGVidWdmcyAgZWl0aGVyLgoKPgo+Cj5IZWlrbwo+Cj4KPlswXSBodHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC92Ni4xMi40L3NvdXJjZS9pbmNsdWRlL2RybS9kcm1fY3J0Yy5oI0w3MzcK
PlsxXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xMi40L3NvdXJjZS9kcml2
ZXJzL2dwdS9kcm0vZHJtX2RlYnVnZnMuYyNMMjY1Cj4K

