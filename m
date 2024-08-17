Return-Path: <linux-kernel+bounces-290877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD63F955A6B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 01:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68331C20D1B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 23:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04961553B7;
	Sat, 17 Aug 2024 23:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R0JrMxd1"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8451386C6
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723938723; cv=none; b=bONwE+QTvSi91ULmmKMk0ag5UUzc0k1VWipDn72PjqFqCjJuarlWkYw7t4JfujneFfunudMc8ZnkW87TAsOjEDTd5tcpXn1mIYbtMZ6LWZHDY8cqIUylSOQEhq5c/KD1CQhHKedTZ4A7Rjh8UOm6KdIQsXIGbqAMCexQViY2naQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723938723; c=relaxed/simple;
	bh=oBq/5CsxfavIDkhzc6XOkd6BAiIsNVbWtFifY+Es0g0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=AWJJbk3rjtyOLTjIJzqRWGgDmoSID8p+CRl+nnPEZHkDTXIF767ZoOtFE9Khx+U0JAxlmcoFDjzGDHznIMHAoW5EMwFW9FvVcwcByJ9Alkco0YbeJVBL4OP+GvMwNniTqFhWZOC2Y5MLSs1qU9EhlRf5gi0HkoQ2vfAJLXS649U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=R0JrMxd1; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47HNpFYg166463
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 17 Aug 2024 16:51:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47HNpFYg166463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723938677;
	bh=mBVo9s+hQVTQwSvRPnRg+N6pYd/JaG/4tmXI5xqwzT4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=R0JrMxd1VJhlo3VsM0A/A+G0yRay9XatVHM5ItCwvaEERfZilNpiXEmewA22DwPIj
	 Vtk76UnIGrs199ZQLKezU4DHAaQoJYSa4aUxDX/CBRsQAQQqTNHEanGf0OtrfnFrmK
	 GanklGB+LGdCkfirb7tUt9+uxu+kzlXDB0ed/E6ply6wTSNdxMUxGA1PWGQr27TNVc
	 OtBWJN0CQv7Dd5hv3zcVdrBlGOogaUZfps5sX/3qK7CnHs4ZqurdeCgz33RK4mhmgC
	 VEN/NY6fX1ULj+uGqQtyMwMApEzIiCtmcI51tjKxgHpd9OFueCxuyDAr/09IYOJN8a
	 lsP+No+OQCCOA==
Content-Type: multipart/mixed; boundary="------------K6HGkn402QTKfNdcbHYUQhPj"
Message-ID: <90b290db-22fb-432c-aa94-73e85aee0d11@zytor.com>
Date: Sat, 17 Aug 2024 16:51:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the
 alternatives mechanism
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, Xin Li <xin@zytor.com>,
        linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        seanjc@google.com
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
 <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
 <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
 <25200a9d-e222-4c40-9c97-b5e5e532db8c@citrix.com>
 <4f7566b5-a743-4819-b221-88207c132f63@zytor.com>
 <0ec48b84-d158-47c6-b14c-3563fd14bcc4@zytor.com>
Content-Language: en-US
In-Reply-To: <0ec48b84-d158-47c6-b14c-3563fd14bcc4@zytor.com>

This is a multi-part message in MIME format.
--------------K6HGkn402QTKfNdcbHYUQhPj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/16/24 15:59, H. Peter Anvin wrote:
> 
> RDMSR is a bit trickier. I think the best option there is to set up a 
> new trap fixup handler type that amounts to "get the address from 
> the stack, apply a specific offset, and invoke the fixup handler for 
> that address:
> 
> 
>      case EX_TYPE_UPLEVEL: {
>          /* Let reg hold the unsigned number of machine
>           * words to pop off the stack before the return
>           * address, and imm the signed offset from the
>           * return address to the desired trap point.
>           *
>           * pointer in units of machine words, and imm the
>           * signed offset from this stack word...
>           */
>          unsigned long *sp = (unsigned long *)regs->sp + reg;
>          regs->ip = *sp++ + (int16_t)imm;
>          regs->sp = (unsigned long)sp;
>          goto again;    /* Loop back to the beginning */
>      }
> 
> Again, "obviously correct" code attached.
> 

Here is an untested patch implemented the above functionality, tidied up 
and wrapped in a macro as _ASM_EXTABLE_FUNC_REWIND().

	-hpa

--------------K6HGkn402QTKfNdcbHYUQhPj
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-extable-implement-EX_TYPE_FUNC_REWIND.patch"
Content-Disposition: attachment;
 filename="0001-x86-extable-implement-EX_TYPE_FUNC_REWIND.patch"
Content-Transfer-Encoding: base64

RnJvbSAzNWY5OTI1NWYyYmMwMTc0YWJhOTBjNDRiM2U3MDQxNWYwNjU4MjU3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29t
PgpEYXRlOiBTYXQsIDE3IEF1ZyAyMDI0IDE2OjQ1OjI0IC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0geDg2L2V4dGFibGU6IGltcGxlbWVudCBFWF9UWVBFX0ZVTkNfUkVXSU5ECgpBZGQgYSBu
ZXcgZXhjZXB0aW9uIHR5cGUsIHdoaWNoIGFsbG93cyBlbXVsYXRpbmcgYW4gZXhjZXB0aW9u
IGFzIGlmIGl0CmhhZCBoYXBwZW5lZCBhdCBvciBuZWFyIHRoZSBjYWxsIHNpdGUgb2YgYSBm
dW5jdGlvbi4gVGhpcyBhbGxvd3MgYQpmdW5jdGlvbiBjYWxsIGluc2lkZSBhbiBhbHRlcm5h
dGl2ZSBmb3IgaW5zdHJ1Y3Rpb24gZW11bGF0aW9uIHRvICJraWNrCmJhY2siIHRoZSBleGNl
cHRpb24gaW50byB0aGUgYWx0ZXJuYXRpdmVzIHBhdHRlcm4sIHBvc3NpYmx5IGludm9raW5n
IGEKZGlmZmVyZW50IGV4Y2VwdGlvbiBoYW5kbGluZyBwYXR0ZXJuIHRoZXJlLCBvciBhdCBs
ZWFzdCBpbmRpY2F0aW5nIHRoZQoicmVhbCIgbG9jYXRpb24gb2YgdGhlIGZhdWx0LgoKVW50
ZXN0ZWQtYnk6IEguIFBldGVyIEFudmluIChJbnRlbCkgPGhwYUB6eXRvci5jb20+ClNpZ25l
ZC1vZmYtYnk6IEguIFBldGVyIEFudmluIChJbnRlbCkgPGhwYUB6eXRvci5jb20+Ci0tLQog
YXJjaC94ODYvaW5jbHVkZS9hc20vYXNtLmggICAgICAgICAgICAgICAgIHwgICA2ICsKIGFy
Y2gveDg2L2luY2x1ZGUvYXNtL2V4dGFibGVfZml4dXBfdHlwZXMuaCB8ICAgMSArCiBhcmNo
L3g4Ni9tbS9leHRhYmxlLmMgICAgICAgICAgICAgICAgICAgICAgfCAxMzYgKysrKysrKysr
KysrKy0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDkyIGluc2VydGlvbnMoKyksIDUxIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2FzbS5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vYXNtLmgKaW5kZXggMmJlYzBjODlhOTVjLi43Mzk4MjYx
YjBmNGEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2FzbS5oCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2FzbS5oCkBAIC0yMzIsNSArMjMyLDExIEBAIHJlZ2lzdGVy
IHVuc2lnbmVkIGxvbmcgY3VycmVudF9zdGFja19wb2ludGVyIGFzbShfQVNNX1NQKTsKICNk
ZWZpbmUgX0FTTV9FWFRBQkxFX0ZBVUxUKGZyb20sIHRvKQkJCQlcCiAJX0FTTV9FWFRBQkxF
X1RZUEUoZnJvbSwgdG8sIEVYX1RZUEVfRkFVTFQpCiAKKyNkZWZpbmUgX0FTTV9FWFRBQkxF
X0ZVTkNfUkVXSU5EKGZyb20sIGlwZGVsdGEsIHNwZGVsdGEpCVwKKwlfQVNNX0VYVEFCTEVf
VFlQRShmcm9tLCBmcm9tIC8qIHVudXNlZCAqLywJCVwKKwkJCSAgRVhfVFlQRV9GVU5DX1JF
V0lORCB8CQkJXAorCQkJICBFWF9EQVRBX1JFRyhzcGRlbHRhKSB8CQlcCisJCQkgIEVYX0RB
VEFfSU1NKGlwZGVsdGEpKQorCiAjZW5kaWYgLyogX19LRVJORUxfXyAqLwogI2VuZGlmIC8q
IF9BU01fWDg2X0FTTV9IICovCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9l
eHRhYmxlX2ZpeHVwX3R5cGVzLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9leHRhYmxlX2Zp
eHVwX3R5cGVzLmgKaW5kZXggOTA2YjBkNTU0MWU4Li4yZWVkN2YzOTg5M2YgMTAwNjQ0Ci0t
LSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2V4dGFibGVfZml4dXBfdHlwZXMuaAorKysgYi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9leHRhYmxlX2ZpeHVwX3R5cGVzLmgKQEAgLTY3LDUgKzY3
LDYgQEAKICNkZWZpbmUJRVhfVFlQRV9aRVJPUEFECQkJMjAgLyogbG9uZ3dvcmQgbG9hZCB3
aXRoIHplcm9wYWQgb24gZmF1bHQgKi8KIAogI2RlZmluZQlFWF9UWVBFX0VSRVRVCQkJMjEK
KyNkZWZpbmUgRVhfVFlQRV9GVU5DX1JFV0lORAkJMjIKIAogI2VuZGlmCmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9tbS9leHRhYmxlLmMgYi9hcmNoL3g4Ni9tbS9leHRhYmxlLmMKaW5kZXgg
NTE5ODZlOGE5ZDM1Li4wNzZmMTQ5MmI5MzUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L21tL2V4
dGFibGUuYworKysgYi9hcmNoL3g4Ni9tbS9leHRhYmxlLmMKQEAgLTI5MCw2ICsyOTAsMjgg
QEAgc3RhdGljIGJvb2wgZXhfaGFuZGxlcl9lcmV0dShjb25zdCBzdHJ1Y3QgZXhjZXB0aW9u
X3RhYmxlX2VudHJ5ICpmaXh1cCwKIH0KICNlbmRpZgogCisvKgorICogRW11bGF0ZSBhIGZh
dWx0IHRha2VuIGF0IHRoZSBjYWxsIHNpdGUgb2YgYSBmdW5jdGlvbi4KKyAqIFRoZSBjb21i
aW5lZCByZWcgYW5kIGZsYWdzIGZpZWxkIGFyZSB1c2VkIGFzIGFuIHVuc2lnbmVkCisgKiBu
dW1iZXIgb2YgbWFjaGluZSB3b3JkcyB0byBwb3Agb2ZmIHRoZSBzdGFjayBiZWZvcmUgdGhl
CisgKiByZXR1cm4gYWRkcmVzcywgdGhlbiB0aGUgc2lnbmVkIGltbSBmaWVsZCBpcyB1c2Vk
IGFzIGEgZGVsdGEKKyAqIGZyb20gdGhlIHJldHVybiBJUCBhZGRyZXNzLgorICovCitzdGF0
aWMgYm9vbCBleF9oYW5kbGVyX2Z1bmNfcmV3aW5kKHN0cnVjdCBwdF9yZWdzICpyZWdzLCBp
bnQgZGF0YSkKK3sKKwljb25zdCBsb25nIGlwZGVsdGEgPSBGSUVMRF9HRVQoRVhfREFUQV9J
TU1fTUFTSywgIGRhdGEpOworCWNvbnN0IHVuc2lnbmVkIGxvbmcgcG9wcyA9CisJCUZJRUxE
X0dFVChFWF9EQVRBX1JFR19NQVNLfEVYX0RBVEFfRkxBR19NQVNLLCBkYXRhKTsKKwl1bnNp
Z25lZCBsb25nICpzcDsKKworCXNwID0gKHVuc2lnbmVkIGxvbmcgKilyZWdzLT5zcDsKKwlz
cCArPSBwb3BzOworCXJlZ3MtPmlwID0gKnNwKysgKyBpcGRlbHRhOworCXJlZ3MtPnNwID0g
KHVuc2lnbmVkIGxvbmcpc3A7CisKKwlyZXR1cm4gdHJ1ZTsKK30KKwogaW50IGV4X2dldF9m
aXh1cF90eXBlKHVuc2lnbmVkIGxvbmcgaXApCiB7CiAJY29uc3Qgc3RydWN0IGV4Y2VwdGlv
bl90YWJsZV9lbnRyeSAqZSA9IHNlYXJjaF9leGNlcHRpb25fdGFibGVzKGlwKTsKQEAgLTMw
Miw2ICszMjQsNyBAQCBpbnQgZml4dXBfZXhjZXB0aW9uKHN0cnVjdCBwdF9yZWdzICpyZWdz
LCBpbnQgdHJhcG5yLCB1bnNpZ25lZCBsb25nIGVycm9yX2NvZGUsCiB7CiAJY29uc3Qgc3Ry
dWN0IGV4Y2VwdGlvbl90YWJsZV9lbnRyeSAqZTsKIAlpbnQgdHlwZSwgcmVnLCBpbW07CisJ
Ym9vbCBhZ2FpbjsKIAogI2lmZGVmIENPTkZJR19QTlBCSU9TCiAJaWYgKHVubGlrZWx5KFNF
R01FTlRfSVNfUE5QX0NPREUocmVncy0+Y3MpKSkgewpAQCAtMzE3LDYwICszNDAsNzEgQEAg
aW50IGZpeHVwX2V4Y2VwdGlvbihzdHJ1Y3QgcHRfcmVncyAqcmVncywgaW50IHRyYXBuciwg
dW5zaWduZWQgbG9uZyBlcnJvcl9jb2RlLAogCX0KICNlbmRpZgogCi0JZSA9IHNlYXJjaF9l
eGNlcHRpb25fdGFibGVzKHJlZ3MtPmlwKTsKLQlpZiAoIWUpCi0JCXJldHVybiAwOwotCi0J
dHlwZSA9IEZJRUxEX0dFVChFWF9EQVRBX1RZUEVfTUFTSywgZS0+ZGF0YSk7Ci0JcmVnICA9
IEZJRUxEX0dFVChFWF9EQVRBX1JFR19NQVNLLCAgZS0+ZGF0YSk7Ci0JaW1tICA9IEZJRUxE
X0dFVChFWF9EQVRBX0lNTV9NQVNLLCAgZS0+ZGF0YSk7Ci0KLQlzd2l0Y2ggKHR5cGUpIHsK
LQljYXNlIEVYX1RZUEVfREVGQVVMVDoKLQljYXNlIEVYX1RZUEVfREVGQVVMVF9NQ0VfU0FG
RToKLQkJcmV0dXJuIGV4X2hhbmRsZXJfZGVmYXVsdChlLCByZWdzKTsKLQljYXNlIEVYX1RZ
UEVfRkFVTFQ6Ci0JY2FzZSBFWF9UWVBFX0ZBVUxUX01DRV9TQUZFOgotCQlyZXR1cm4gZXhf
aGFuZGxlcl9mYXVsdChlLCByZWdzLCB0cmFwbnIpOwotCWNhc2UgRVhfVFlQRV9VQUNDRVNT
OgotCQlyZXR1cm4gZXhfaGFuZGxlcl91YWNjZXNzKGUsIHJlZ3MsIHRyYXBuciwgZmF1bHRf
YWRkcik7Ci0JY2FzZSBFWF9UWVBFX0NMRUFSX0ZTOgotCQlyZXR1cm4gZXhfaGFuZGxlcl9j
bGVhcl9mcyhlLCByZWdzKTsKLQljYXNlIEVYX1RZUEVfRlBVX1JFU1RPUkU6Ci0JCXJldHVy
biBleF9oYW5kbGVyX2ZwcmVzdG9yZShlLCByZWdzKTsKLQljYXNlIEVYX1RZUEVfQlBGOgot
CQlyZXR1cm4gZXhfaGFuZGxlcl9icGYoZSwgcmVncyk7Ci0JY2FzZSBFWF9UWVBFX1dSTVNS
OgotCQlyZXR1cm4gZXhfaGFuZGxlcl9tc3IoZSwgcmVncywgdHJ1ZSwgZmFsc2UsIHJlZyk7
Ci0JY2FzZSBFWF9UWVBFX1JETVNSOgotCQlyZXR1cm4gZXhfaGFuZGxlcl9tc3IoZSwgcmVn
cywgZmFsc2UsIGZhbHNlLCByZWcpOwotCWNhc2UgRVhfVFlQRV9XUk1TUl9TQUZFOgotCQly
ZXR1cm4gZXhfaGFuZGxlcl9tc3IoZSwgcmVncywgdHJ1ZSwgdHJ1ZSwgcmVnKTsKLQljYXNl
IEVYX1RZUEVfUkRNU1JfU0FGRToKLQkJcmV0dXJuIGV4X2hhbmRsZXJfbXNyKGUsIHJlZ3Ms
IGZhbHNlLCB0cnVlLCByZWcpOwotCWNhc2UgRVhfVFlQRV9XUk1TUl9JTl9NQ0U6Ci0JCWV4
X2hhbmRsZXJfbXNyX21jZShyZWdzLCB0cnVlKTsKLQkJYnJlYWs7Ci0JY2FzZSBFWF9UWVBF
X1JETVNSX0lOX01DRToKLQkJZXhfaGFuZGxlcl9tc3JfbWNlKHJlZ3MsIGZhbHNlKTsKLQkJ
YnJlYWs7Ci0JY2FzZSBFWF9UWVBFX1BPUF9SRUc6Ci0JCXJlZ3MtPnNwICs9IHNpemVvZihs
b25nKTsKLQkJZmFsbHRocm91Z2g7Ci0JY2FzZSBFWF9UWVBFX0lNTV9SRUc6Ci0JCXJldHVy
biBleF9oYW5kbGVyX2ltbV9yZWcoZSwgcmVncywgcmVnLCBpbW0pOwotCWNhc2UgRVhfVFlQ
RV9GQVVMVF9TR1g6Ci0JCXJldHVybiBleF9oYW5kbGVyX3NneChlLCByZWdzLCB0cmFwbnIp
OwotCWNhc2UgRVhfVFlQRV9VQ09QWV9MRU46Ci0JCXJldHVybiBleF9oYW5kbGVyX3Vjb3B5
X2xlbihlLCByZWdzLCB0cmFwbnIsIGZhdWx0X2FkZHIsIHJlZywgaW1tKTsKLQljYXNlIEVY
X1RZUEVfWkVST1BBRDoKLQkJcmV0dXJuIGV4X2hhbmRsZXJfemVyb3BhZChlLCByZWdzLCBm
YXVsdF9hZGRyKTsKKwlkbyB7CisJCWUgPSBzZWFyY2hfZXhjZXB0aW9uX3RhYmxlcyhyZWdz
LT5pcCk7CisJCWlmICghZSkKKwkJCXJldHVybiAwOworCisJCWFnYWluID0gZmFsc2U7CisK
KwkJdHlwZSA9IEZJRUxEX0dFVChFWF9EQVRBX1RZUEVfTUFTSywgZS0+ZGF0YSk7CisJCXJl
ZyAgPSBGSUVMRF9HRVQoRVhfREFUQV9SRUdfTUFTSywgIGUtPmRhdGEpOworCQlpbW0gID0g
RklFTERfR0VUKEVYX0RBVEFfSU1NX01BU0ssICBlLT5kYXRhKTsKKworCQlzd2l0Y2ggKHR5
cGUpIHsKKwkJY2FzZSBFWF9UWVBFX0RFRkFVTFQ6CisJCWNhc2UgRVhfVFlQRV9ERUZBVUxU
X01DRV9TQUZFOgorCQkJcmV0dXJuIGV4X2hhbmRsZXJfZGVmYXVsdChlLCByZWdzKTsKKwkJ
Y2FzZSBFWF9UWVBFX0ZBVUxUOgorCQljYXNlIEVYX1RZUEVfRkFVTFRfTUNFX1NBRkU6CisJ
CQlyZXR1cm4gZXhfaGFuZGxlcl9mYXVsdChlLCByZWdzLCB0cmFwbnIpOworCQljYXNlIEVY
X1RZUEVfVUFDQ0VTUzoKKwkJCXJldHVybiBleF9oYW5kbGVyX3VhY2Nlc3MoZSwgcmVncywg
dHJhcG5yLCBmYXVsdF9hZGRyKTsKKwkJY2FzZSBFWF9UWVBFX0NMRUFSX0ZTOgorCQkJcmV0
dXJuIGV4X2hhbmRsZXJfY2xlYXJfZnMoZSwgcmVncyk7CisJCWNhc2UgRVhfVFlQRV9GUFVf
UkVTVE9SRToKKwkJCXJldHVybiBleF9oYW5kbGVyX2ZwcmVzdG9yZShlLCByZWdzKTsKKwkJ
Y2FzZSBFWF9UWVBFX0JQRjoKKwkJCXJldHVybiBleF9oYW5kbGVyX2JwZihlLCByZWdzKTsK
KwkJY2FzZSBFWF9UWVBFX1dSTVNSOgorCQkJcmV0dXJuIGV4X2hhbmRsZXJfbXNyKGUsIHJl
Z3MsIHRydWUsIGZhbHNlLCByZWcpOworCQljYXNlIEVYX1RZUEVfUkRNU1I6CisJCQlyZXR1
cm4gZXhfaGFuZGxlcl9tc3IoZSwgcmVncywgZmFsc2UsIGZhbHNlLCByZWcpOworCQljYXNl
IEVYX1RZUEVfV1JNU1JfU0FGRToKKwkJCXJldHVybiBleF9oYW5kbGVyX21zcihlLCByZWdz
LCB0cnVlLCB0cnVlLCByZWcpOworCQljYXNlIEVYX1RZUEVfUkRNU1JfU0FGRToKKwkJCXJl
dHVybiBleF9oYW5kbGVyX21zcihlLCByZWdzLCBmYWxzZSwgdHJ1ZSwgcmVnKTsKKwkJY2Fz
ZSBFWF9UWVBFX1dSTVNSX0lOX01DRToKKwkJCWV4X2hhbmRsZXJfbXNyX21jZShyZWdzLCB0
cnVlKTsKKwkJCWJyZWFrOworCQljYXNlIEVYX1RZUEVfUkRNU1JfSU5fTUNFOgorCQkJZXhf
aGFuZGxlcl9tc3JfbWNlKHJlZ3MsIGZhbHNlKTsKKwkJCWJyZWFrOworCQljYXNlIEVYX1RZ
UEVfUE9QX1JFRzoKKwkJCXJlZ3MtPnNwICs9IHNpemVvZihsb25nKTsKKwkJCWZhbGx0aHJv
dWdoOworCQljYXNlIEVYX1RZUEVfSU1NX1JFRzoKKwkJCXJldHVybiBleF9oYW5kbGVyX2lt
bV9yZWcoZSwgcmVncywgcmVnLCBpbW0pOworCQljYXNlIEVYX1RZUEVfRkFVTFRfU0dYOgor
CQkJcmV0dXJuIGV4X2hhbmRsZXJfc2d4KGUsIHJlZ3MsIHRyYXBucik7CisJCWNhc2UgRVhf
VFlQRV9VQ09QWV9MRU46CisJCQlyZXR1cm4gZXhfaGFuZGxlcl91Y29weV9sZW4oZSwgcmVn
cywgdHJhcG5yLCBmYXVsdF9hZGRyLCByZWcsIGltbSk7CisJCWNhc2UgRVhfVFlQRV9aRVJP
UEFEOgorCQkJcmV0dXJuIGV4X2hhbmRsZXJfemVyb3BhZChlLCByZWdzLCBmYXVsdF9hZGRy
KTsKICNpZmRlZiBDT05GSUdfWDg2X0ZSRUQKLQljYXNlIEVYX1RZUEVfRVJFVFU6Ci0JCXJl
dHVybiBleF9oYW5kbGVyX2VyZXR1KGUsIHJlZ3MsIGVycm9yX2NvZGUpOworCQljYXNlIEVY
X1RZUEVfRVJFVFU6CisJCQlyZXR1cm4gZXhfaGFuZGxlcl9lcmV0dShlLCByZWdzLCBlcnJv
cl9jb2RlKTsKICNlbmRpZgotCX0KKwkJY2FzZSBFWF9UWVBFX0ZVTkNfUkVXSU5EOgorCQkJ
YWdhaW4gPSBleF9oYW5kbGVyX2Z1bmNfcmV3aW5kKHJlZ3MsIGUtPmRhdGEpOworCQkJYnJl
YWs7CisJCWRlZmF1bHQ6CisJCQlicmVhazsJLyogV2lsbCBCVUcoKSAqLworCQl9CisJfSB3
aGlsZSAoYWdhaW4pOworCiAJQlVHKCk7CisJcmV0dXJuIDA7CiB9CiAKIGV4dGVybiB1bnNp
Z25lZCBpbnQgZWFybHlfcmVjdXJzaW9uX2ZsYWc7Ci0tIAoyLjQ2LjAKCg==

--------------K6HGkn402QTKfNdcbHYUQhPj--

