Return-Path: <linux-kernel+bounces-420558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5A09D7C52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F40282640
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC9C1714CF;
	Mon, 25 Nov 2024 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="A5GMbgja"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3A92500D5;
	Mon, 25 Nov 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521748; cv=none; b=Ulhc5CyOsk6jRJI/91DyZSn/BhwQzcxV6VxfIn7jGhyZKYHBo6W/NPfiw7dDPiVPLwEeZVV1yUVZnlaUG/OErBLYTKlh0WSKU0Wgh7QsGd3J+iA8TPnC5oLhgfuOF6PyWzeuuY77Q9WVhskCudhL2xHzeoBn5IoW4pN28XJwbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521748; c=relaxed/simple;
	bh=PsOdm12MrlwKZegNo+S1+FmJ9rMaTJQ1GPPbnbBfyQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=KA9YtbxJP4fc5TyWwr+6bk5kknexr4GThKTuKTqZpya0tbg93kYnmj7Jdpm+ETaMmPj8Nxx9sml0ZpfqiElVniN/sVAnoZf13tt7oureyurcMMlhZE8b1EI3dCh/hrvEErnm1y9zwIR3fIMujj+h85y94Q2SzeP31FjETvmjUNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=A5GMbgja reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Fjsdmbs2DLuWnuyk2HsxKqRdXQhCdYZjv3t6l2WF5m0=; b=A
	5GMbgjaJoQw6WAv9JYRJ6rF3yQay+3/63wU8VrI8HOw8u4QOHMB0dVVFZigyzC3s
	lpC2x7DLpOcGyun71FUA1FWauRGuc3kbZ9pQvarbokjO3BLEbrTWwxArjwCvrI1C
	vXQJIdQOpgzzpSuHMaUOjTU3DZPMgjlHo8W0g3gwVE=
Received: from 18500469033$163.com (
 [2001:0DB8:6ca2:a596:4eef:3859:5c34:2a04, 52.131.113.184] ) by
 ajax-webmail-wmsvr-40-123 (Coremail) ; Mon, 25 Nov 2024 16:01:36 +0800
 (CST)
Date: Mon, 25 Nov 2024 16:01:36 +0800 (CST)
From: "Dingyan Li" <18500469033@163.com>
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	usb-storage@lists.one-eyed-alien.net
Subject: Re:[PATCH v1] usb: storage: add a macro for the upper limit of max
 LUN
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20241030083858.46907-1-18500469033@163.com>
References: <20241030083858.46907-1-18500469033@163.com>
X-NTES-SC: AL_Qu2YAPmZvk4i4CKbYOkfmkgbhek8X8q5uPQj3IBeOJ5+jAnp+yQ6TW5SInTW4se0FzGTmgmGSiBk289mf5Zyb40Wj8mf/yvwNFtCAWzJXRhGVg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <56abaf44.86c3.19362571bee.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eygvCgDnz4HgLkRnw00vAA--.59492W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/1tbioBagy2dCFEWY3wADst
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgRXhwZXJ0cywKCkFueSB0aG91Z2h0cyBvbiB0aGlzIHBhdGNoPwoKUmVnYXJkcywKCgpBdCAy
MDI0LTEwLTMwIDE2OjM4OjU4LCAiRGluZ3lhbiBMaSIgPDE4NTAwNDY5MDMzQDE2My5jb20+IHdy
b3RlOgo+VGhlIG1lYW5pbmcgb2YgdGhpcyB2YWx1ZSBpcyBhbHJlYWR5IHVzZWQgaW4gc2V2ZXJh
bCBwbGFjZXMsCj5idXQgd2l0aCBjb25zdGFudCB2YWx1ZXMgYW5kIGNvbW1lbnRzIHRvIGV4cGxh
aW4gaXQgc2VwYXJhdGVseS4KPkl0J3MgYmV0dGVyIHRvIGhhdmUgYSBjZW50cmFsIHBsYWNlIHRv
IGRvIHRoaXMgdGhlbiB1c2UgdGhlIG1hY3JvCj5pbiB0aG9zZSBwbGFjZXMgZm9yIGJldHRlciBy
ZWFkYWJpbGl0eS4KPgo+U2lnbmVkLW9mZi1ieTogRGluZ3lhbiBMaSA8MTg1MDA0NjkwMzNAMTYz
LmNvbT4KPi0tLQo+IGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3RjbS5jICAgICAgICAg
IHwgOCArKy0tLS0tLQo+IGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9zdG9yYWdlX2NvbW1v
bi5oIHwgMiArLQo+IGRyaXZlcnMvdXNiL3N0b3JhZ2UvdHJhbnNwb3J0LmMgICAgICAgICAgICAg
IHwgOCArKy0tLS0tLQo+IGluY2x1ZGUvbGludXgvdXNiL3N0b3JhZ2UuaCAgICAgICAgICAgICAg
ICAgIHwgOCArKysrKysrKwo+IDQgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTMg
ZGVsZXRpb25zKC0pCj4KPmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24v
Zl90Y20uYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3RjbS5jCj5pbmRleCAxNWJi
M2FhMTJhYTguLmUxOTE0YjIwZjgxNiAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9m
dW5jdGlvbi9mX3RjbS5jCj4rKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20u
Ywo+QEAgLTQ0MSwxNCArNDQxLDEwIEBAIHN0YXRpYyBpbnQgdXNiZ19ib3Rfc2V0dXAoc3RydWN0
IHVzYl9mdW5jdGlvbiAqZiwKPiAJCQlwcl9lcnIoIk5vIExVTnMgY29uZmlndXJlZD9cbiIpOwo+
IAkJCXJldHVybiAtRUlOVkFMOwo+IAkJfQo+LQkJLyoKPi0JCSAqIElmIDQgTFVOcyBhcmUgcHJl
c2VudCB3ZSByZXR1cm4gMyBpLmUuIExVTiAwLi4zIGNhbiBiZQo+LQkJICogYWNjZXNzZWQuIFRo
ZSB1cHBlciBsaW1pdCBpcyAweGYKPi0JCSAqLwo+IAkJbHVucy0tOwo+LQkJaWYgKGx1bnMgPiAw
eGYpIHsKPisJCWlmIChsdW5zID4gVVNfQlVMS19NQVhfTFVOX0xJTUlUKSB7Cj4gCQkJcHJfaW5m
b19vbmNlKCJMaW1pdGluZyB0aGUgbnVtYmVyIG9mIGx1bnMgdG8gMTZcbiIpOwo+LQkJCWx1bnMg
PSAweGY7Cj4rCQkJbHVucyA9IFVTX0JVTEtfTUFYX0xVTl9MSU1JVDsKPiAJCX0KPiAJCXJldF9s
dW4gPSBjZGV2LT5yZXEtPmJ1ZjsKPiAJCSpyZXRfbHVuID0gbHVuczsKPmRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vc3RvcmFnZV9jb21tb24uaCBiL2RyaXZlcnMvdXNi
L2dhZGdldC9mdW5jdGlvbi9zdG9yYWdlX2NvbW1vbi5oCj5pbmRleCBjZWQ1ZDJiMDkyMzQuLjEx
YWM3ODVkNWVlZSAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9zdG9y
YWdlX2NvbW1vbi5oCj4rKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vc3RvcmFnZV9j
b21tb24uaAo+QEAgLTEzMSw3ICsxMzEsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgZnNnX2x1bl9p
c19vcGVuKHN0cnVjdCBmc2dfbHVuICpjdXJsdW4pCj4gI2RlZmluZSBGU0dfQlVGTEVOCSgodTMy
KTE2Mzg0KQo+IAo+IC8qIE1heGltYWwgbnVtYmVyIG9mIExVTnMgc3VwcG9ydGVkIGluIG1hc3Mg
c3RvcmFnZSBmdW5jdGlvbiAqLwo+LSNkZWZpbmUgRlNHX01BWF9MVU5TCTE2Cj4rI2RlZmluZSBG
U0dfTUFYX0xVTlMJKFVTX0JVTEtfTUFYX0xVTl9MSU1JVCArIDEpCj4gCj4gZW51bSBmc2dfYnVm
ZmVyX3N0YXRlIHsKPiAJQlVGX1NUQVRFX1NFTkRJTkcgPSAtMiwKPmRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9zdG9yYWdlL3RyYW5zcG9ydC5jIGIvZHJpdmVycy91c2Ivc3RvcmFnZS90cmFuc3Bv
cnQuYwo+aW5kZXggOWQ3NjdmNmJmNzIyLi5lNmJjOGVjYWVjYmIgMTAwNjQ0Cj4tLS0gYS9kcml2
ZXJzL3VzYi9zdG9yYWdlL3RyYW5zcG9ydC5jCj4rKysgYi9kcml2ZXJzL3VzYi9zdG9yYWdlL3Ry
YW5zcG9ydC5jCj5AQCAtMTA4NywxMyArMTA4Nyw5IEBAIGludCB1c2Jfc3Rvcl9CdWxrX21heF9s
dW4oc3RydWN0IHVzX2RhdGEgKnVzKQo+IAl1c2Jfc3Rvcl9kYmcodXMsICJHZXRNYXhMVU4gY29t
bWFuZCByZXN1bHQgaXMgJWQsIGRhdGEgaXMgJWRcbiIsCj4gCQkgICAgIHJlc3VsdCwgdXMtPmlv
YnVmWzBdKTsKPiAKPi0JLyoKPi0JICogSWYgd2UgaGF2ZSBhIHN1Y2Nlc3NmdWwgcmVxdWVzdCwg
cmV0dXJuIHRoZSByZXN1bHQgaWYgdmFsaWQuIFRoZQo+LQkgKiBDQlcgTFVOIGZpZWxkIGlzIDQg
Yml0cyB3aWRlLCBzbyB0aGUgdmFsdWUgcmVwb3J0ZWQgYnkgdGhlIGRldmljZQo+LQkgKiBzaG91
bGQgZml0IGludG8gdGhhdC4KPi0JICovCj4rCS8qIElmIHdlIGhhdmUgYSBzdWNjZXNzZnVsIHJl
cXVlc3QsIHJldHVybiB0aGUgcmVzdWx0IGlmIHZhbGlkLiAqLwo+IAlpZiAocmVzdWx0ID4gMCkg
ewo+LQkJaWYgKHVzLT5pb2J1ZlswXSA8IDE2KSB7Cj4rCQlpZiAodXMtPmlvYnVmWzBdIDw9IFVT
X0JVTEtfTUFYX0xVTl9MSU1JVCkgewo+IAkJCXJldHVybiB1cy0+aW9idWZbMF07Cj4gCQl9IGVs
c2Ugewo+IAkJCWRldl9pbmZvKCZ1cy0+cHVzYl9pbnRmLT5kZXYsCj5kaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC91c2Ivc3RvcmFnZS5oIGIvaW5jbHVkZS9saW51eC91c2Ivc3RvcmFnZS5oCj5p
bmRleCA4NTM5OTU2YmMyYmUuLjUxYmUzYmI4ZmNjYiAxMDA2NDQKPi0tLSBhL2luY2x1ZGUvbGlu
dXgvdXNiL3N0b3JhZ2UuaAo+KysrIGIvaW5jbHVkZS9saW51eC91c2Ivc3RvcmFnZS5oCj5AQCAt
ODIsNCArODIsMTIgQEAgc3RydWN0IGJ1bGtfY3Nfd3JhcCB7Cj4gI2RlZmluZSBVU19CVUxLX1JF
U0VUX1JFUVVFU1QgICAweGZmCj4gI2RlZmluZSBVU19CVUxLX0dFVF9NQVhfTFVOICAgICAweGZl
Cj4gCj4rLyoKPisgKiBJZiA0IExVTnMgYXJlIHN1cHBvcnRlZCB0aGVuIHRoZSBMVU5zIHdvdWxk
IGJlCj4rICogbnVtYmVyZWQgZnJvbSAwIHRvIDMsIGFuZCB0aGUgcmV0dXJuIHZhbHVlIGZvcgo+
KyAqIFVTX0JVTEtfR0VUX01BWF9MVU4gcmVxdWVzdCB3b3VsZCBiZSAzLiBUaGUgdmFsaWQKPisg
KiBMVU4gZmllbGQgaXMgNCBiaXRzIHdpZGUsIHRoZSB1cHBlciBsaW1pdCBpcyAweDBmLgo+KyAq
Lwo+KyNkZWZpbmUgVVNfQlVMS19NQVhfTFVOX0xJTUlUICAgMHgwZgo+Kwo+ICNlbmRpZgo+LS0g
Cj4yLjI1LjEK

