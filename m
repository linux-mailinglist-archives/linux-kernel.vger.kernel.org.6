Return-Path: <linux-kernel+bounces-290331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2043955252
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695F42834B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EAC1C463F;
	Fri, 16 Aug 2024 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UKETg2Fa"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBCF1C460C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843610; cv=none; b=Jhg9Pw9U+UUE9H45R6VBzWcPNDLFTjENm6wtMS/tyECofINbkCYF6OKFWmSCIRmmrcJibqBAZcq5I89d4qYN18qK5nrhsFOdc8eUClZ5gRVc3oFy8/BQxheiJ3X3N2RyoFbZt0Q9y0hhKA+/dQbUA1yokQAqbxu2F7OEJYx71mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843610; c=relaxed/simple;
	bh=D4cYVKJZMtkqJ9AH3ighYYzvw72p0dCyhKoG69sakaY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=HdHsrg+W7j9oRwWoWHz/VqlJLBw/ej++wMoV7VwpHUppWLuVN4n0G3K8GBQhW62aVvLFH29rORybo1tHehNiJ2HaH4e6I/d1ySwForLRwUHrDxVANw8WRDxrn/yMQ4SSBy9nfFjrm8PHAFu01/7J+lPpjZc8ombjrKRdGZjNmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UKETg2Fa; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47GLQ8Y63454923
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 16 Aug 2024 14:26:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47GLQ8Y63454923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723843572;
	bh=+7Vt5KAXlnvFFbfmtpWyM730Kav07i6jWX89zUHR6os=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UKETg2FaVwLo3nFcfUKzDI9P/uTelW9SBQzhisfB1Vk7ZLRitd7SZa1+BghB7sfFZ
	 AbqlWGfAToPmtssu7v5et8t1Xo8MSy3hX8S2WXvEa+IJkMpT+DPa1mu48gaWjhA2xR
	 gJsdlfv5fmdKkvd3ZMczZS1D7/4mSgfmS22QlcXuWlXHvjZ4Qj599PlupjWV/GdUUG
	 qbzld+AEsDNlNODTf63ep0b6Apzy9LgD6Eytuzw7T295lLZCiL6bXZn0XYeyr+N0qh
	 vEsvM5SuLjESA9FxDPaTZjZgXRmgL29r18Gexu6cWFQngYY/6ZFesvNrnlt06lGzsz
	 C+aZmn0nk9xpQ==
Content-Type: multipart/mixed; boundary="------------eEzwgDqgLY0cwdRptC9Ae9Ma"
Message-ID: <4f7566b5-a743-4819-b221-88207c132f63@zytor.com>
Date: Fri, 16 Aug 2024 14:26:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the
 alternatives mechanism
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
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <25200a9d-e222-4c40-9c97-b5e5e532db8c@citrix.com>

This is a multi-part message in MIME format.
--------------eEzwgDqgLY0cwdRptC9Ae9Ma
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/16/24 11:40, Andrew Cooper wrote:
>>
>> As the CALL instruction is 5-byte long, and we need to pad nop for both
>> WRMSR and WRMSRNS, what about not using segment prefix at all?
> 

You can use up to 4 prefixes of any kind (which includes opcode prefixes 
before 0F) before most decoders start hurting, so we can pad it out to 5 
bytes by doing 3f 3f .. .. ..

> 
> My suggestion, not that I've had time to experiment, was to change
> paravirt to use a non-C ABI and have asm_xen_write_msr() recombine
> edx:eax into rsi.  That way the top level wrmsr() retains sensible
> codegen for native even when paravirt is active.
> 

I have attached what should be an "obvious" example... famous last words.

	-hpa

--------------eEzwgDqgLY0cwdRptC9Ae9Ma
Content-Type: text/plain; charset=UTF-8; name="xen.S"
Content-Disposition: attachment; filename="xen.S"
Content-Transfer-Encoding: base64

LyoKICogSW5wdXQgaW4gJXJheCwgTVNSIG51bWJlciBpbiAlZWN4CiAqICVyZHggaXMgY2xv
YmJlcmVkLCBhcyB0aGUgbmF0aXZlIHN0dWIgaXMgYXNzdW1lZCB0byBkbwogKgogKiBDaGFu
Z2UgeGVuX2RvX3dyaXRlX21zciB0byByZXR1cm4gaXRzIGVycm9yIGNvZGUgaW5zdGVhZAog
KiBvZiBwYXNzaW5nIGEgcG9pbnRlcgktIHRoaXMgZ2l2ZXMgdGhlIGV4dHJhIGJlbmVmaXQg
dGhhdAogKiB3ZSBjYW4gZ2V0IHRoZSAqYWN0dWFsIGludm9jYXRpb24gYWRkcmVzcyogaW4g
dGhlIGVycm9yCiAqIG1lc3NhZ2VzLgogKgogKiBleF9oYW5kbGVyX21zcigpIHNob3VsZCBi
ZSBjaGFuZ2VkIHRvIGdldCB0aGUgTVNSIGRhdGEKICogZnJvbSAlcmF4IHJlZ2FyZGxlc3Mg
b2YgWGVuIHZzIG5hdGl2ZTsgYWx0ZXJuYXRpdmVseSB0aGUKICogWGVuIGhhbmRsZXIgY2Fu
IHNldCB1cCAlZWR4IGFzIHdlbGwuCiAqCiAqIExldCB0aGUgbmF0aXZlIHBhdHRlcm4gbG9v
ayBsaWtlOgogKgogKiA0OCA4OSBjMiAgICAgICAgICAgICAgICBtb3YgICAgJXJheCwlcmR4
CiAqIDQ4IGMxIGVhIDIwICAgICAgICAgICAgIHNociAgICAkMzIsJXJkeAogKiAzZSAwZiAz
MCAgICAgICAgICAgICAgICBkcyB3cm1zcgkJPC0tLSB0cmFwIHBvaW50CiAqCiAqIC4uLiB3
aGljaCBjYW4gYmUgcmVwbGFjZWQgd2l0aCAuLi4KICogNDggODkgYzIgICAgICAgICAgICAg
ICAgbW92ICAgICVyYXgsJXJkeAogKiA0OCBjMSBlYSAyMCAgICAgICAgICAgICBzaHIgICAg
JDMyLCVyZHgKICogMGYgMDEgYzYgICAgICAgICAgICAgICAgd3Jtc3JucwkJPC0tLSB0cmFw
IHBvaW50CiAqCiAqIC4uLiBvciAuLi4KICogZTggeHggeHggeHggeHggICAgICAgICAgY2Fs
bCBhc21feGVuX3dyaXRlX21zcgogKiA3NCAwMiAgICAgICAgICAgICAgICAgICBqeiAxZgog
KiAzZSAwZiAwYiAgICAgICAgICAgICAgICBkcyB1ZDIgICAgICAgICAgICAgICAgICA8LS0t
IHRyYXAgcG9pbnQKICogICAgICAgICAgICAgICAgICAgICAgMToKICogZHMgdWQyIGNhbiBv
ZiBjb3Vyc2UgYmUgcmVwbGFjZWQgd2l0aCBhbnkgb3RoZXIgMy1ieXRlIHRyYXBwaW5nCiAq
IGluc3RydWN0aW9uLgogKgogKiBUaGlzIGFsc28gcmVtb3ZlcyB0aGUgbmVlZCBmb3IgWGVu
IHRvIG1haW50YWluIGRpZmZlcmVudCBzYWZlIGFuZAogKiB1bnNhZmUgTVNSIHJvdXRpbmVz
LCBhcyB0aGUgZGlmZmVyZW5jZSBpcyBoYW5kbGVkIGJ5IHRoZSBzYW1lCiAqIHRyYXAgaGFu
ZGxlciBhcyBpcyB1c2VkIG5hdGl2ZWx5LgogKi8KIFNZTV9GVU5DX1NUQVJUKGFzbV94ZW5f
d3JpdGVfbXNyKQoJRlJBTUVfQkVHSU4KCXB1c2ggJXJheAkJLyogU2F2ZSBpbiBjYXNlIG9m
IGVycm9yICovCglwdXNoICVyY3gKCXB1c2ggJXJzaQoJcHVzaCAlcmRpCglwdXNoICVyOAoJ
cHVzaCAlcjkKCXB1c2ggJXIxMAoJcHVzaCAlcjExCgltb3YgJXJheCwlcmRpCgltb3YgJWVj
eCwlZXNpCgljYWxsIHhlbl9kb193cml0ZV9tc3IKCXRlc3QgJWVheCwlZWF4CQkvKiBaRj0w
IG9uIGVycm9yICovCglwb3AgJXIxMQoJcG9wICVyMTAKCXBvcCAlcjkKCXBvcCAlcjgKCXBv
cCAlcmRpCglwb3AgJXJzaQoJcG9wICVyY3gKI2lmZGVmIE9QVElPTkFMCgltb3YgNCglcnNw
KSwlZWR4CiNlbmRpZgoJcG9wICVyYXgKCUZSQU1FX0VORAoJUkVUClNZTV9GVU5DX0VORChh
c21feGVuX3dyaXRlX21zcikK

--------------eEzwgDqgLY0cwdRptC9Ae9Ma--

