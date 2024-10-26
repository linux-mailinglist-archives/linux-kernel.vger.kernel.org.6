Return-Path: <linux-kernel+bounces-383412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C641C9B1B63
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 01:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B2F1F21A97
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 23:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2741D4609;
	Sat, 26 Oct 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AyNsUOv5"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA0F9CF
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729985930; cv=none; b=ryMR8JrtqrAw0V4AA+Za2VoBwfJrBvCGatinjRk/8pw95cfdLua8KwHkfU5J+gNe1pcpVqpix0MwHaJPyGpOHlFM3ZJ7auf1rdShog9/Kv0WSsVkLlH+4XzBlL8uvXty7lBYJ/rYbwBZj+6ioejk1+DSxZuEOykmv4VehieTmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729985930; c=relaxed/simple;
	bh=wErGNSpNUaRHUEoqP2cdlEvjK9I0pU4hYug/HVWWNQw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=mwHhsSVQx/qopXniHHF78qI8PIxO6fAEmzb2w6cqReLMBkuPJLpVkXrF9CURDNrf1AtrmElLeDp//0HAmY4+kwLBYg1gFUYFiBFdlgrznn8dtfIfWSNjKCuZM7XZhLNw9lsrhtQLv+sUdQayScSDt8JjB4K6l/29IegMWjf4nEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=AyNsUOv5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49QNcOxk3063925
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 26 Oct 2024 16:38:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49QNcOxk3063925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1729985905;
	bh=kCD9wSqDnoTQJUbczup2AbrEOzOCBFBAKHeDS3M7h0U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=AyNsUOv5ayt6kwBdxxJ4AkiVmSk+mCrkUJ3nNx6gl/Yt0eIErzaxEv9ehgBCUu4x4
	 rAr/AxfMRoo6qp1qT1rSWjz0spK9J4YqhA2wvfZ73Heur8Z7VI9lfvIf24cBeQNuGP
	 PSYVkycGNAJAOeK4Dsy92A+z6HIWSKigszQujAdAYesMdtWxg0moj2LM9/Ykg5U8Ax
	 /ciatDibcH3fmjBIgjcNwT5WoNUZbZKITdZTp9c4Eopsk6B073CVmbAwqmjoGPg4Oa
	 z3ygdiHN3VOkiXWb3LN54HXUPpy6U8Y/hZJfyQ+KzcW0QevfSL7+I/8nPBPwB0uiWV
	 qrC0SaZBA08VA==
Content-Type: multipart/mixed; boundary="------------0n9JcszkqoqIJlUbZ3WXbsBn"
Message-ID: <3f0da3c0-22e8-4a19-9537-ac9c92b03174@zytor.com>
Date: Sat, 26 Oct 2024 16:38:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20241007083345.47215-1-ubizjak@gmail.com>
 <be62f9c4-eca2-46bb-b566-77c0cbe1f15b@intel.com>
 <CAFULd4Yux5FPvvuvzy6C5J_LTcWsLmPaMmttH2rPvjQG-ZPMVg@mail.gmail.com>
 <12E72F30-EF1D-4A1B-9D71-3A7FD5AF343C@zytor.com>
 <CAFULd4a5+er=7xk+oXOtOsJVUqg86ZWxxvX7jdtOEBcMX60fKg@mail.gmail.com>
 <77294ea6-480b-456e-8102-6c36ed4b7b96@zytor.com>
Content-Language: en-US
In-Reply-To: <77294ea6-480b-456e-8102-6c36ed4b7b96@zytor.com>

This is a multi-part message in MIME format.
--------------0n9JcszkqoqIJlUbZ3WXbsBn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/24 16:28, H. Peter Anvin wrote:
> 
> By any sane definition, the constraint should actually be an input 
> constraint on the frame pointer itself; something like:
> 
> #define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
> 
> ... except that "r" really should be a %rbp constraint, but %rbp doesn't 
> seem to have a constraint letter. At least gcc 14.2 seems to do the 
> right thing anyway, though: __builtin_frame_address(0) seems to force a 
> frame pointer to have been created (even with -fomit-frame-pointer 
> specified, and in a leaf function), and the value is always passed in 
> %rbp (because why on Earth would it do it differently, when it is 
> sitting right there?)
> 
cl
This also matches the "tell the compiler [and programmer] what we 
actually mean" issue that you have mentioned in other contexts.

Anyway, here is a simple test case that can be used to verify that this 
construct does indeed work; at least with gcc 14.2.1 and clang 18.1.8 
(the ones I ran a very quick test on).

It's simple enough that it is pretty straightforward to mess around with 
various modifications. So far I haven't been able to trip up the 
compilers this way.

	-hpa

--------------0n9JcszkqoqIJlUbZ3WXbsBn
Content-Type: text/x-csrc; charset=UTF-8; name="fp.c"
Content-Disposition: attachment; filename="fp.c"
Content-Transfer-Encoding: base64

dW5zaWduZWQgbG9uZyB0ZXN0aXRfcmVnKHVuc2lnbmVkIGxvbmcgeCwgdW5zaWduZWQgbG9u
ZyB5KQp7CiAgICB1bnNpZ25lZCBsb25nIHogPSB4ICsgeTsKICAgIHVuc2lnbmVkIGxvbmcg
djsKCiAgICBhc20oIiMgRnJhbWUgcG9pbnRlciBpbiAlW2ZwXVxuXHRtb3YgJVtpbl0sJVtv
dXRdIgoJOiBbb3V0XSAiPXIiICh2KQoJOiBbaW5dICJyIiAoeiksIFtmcF0gInIiIChfX2J1
aWx0aW5fZnJhbWVfYWRkcmVzcygwKSkpOwoKICAgIHJldHVybiB2Owp9Cgp1bnNpZ25lZCBs
b25nIHRlc3RpdF9idWYodW5zaWduZWQgbG9uZyB4LCB1bnNpZ25lZCBsb25nIHkpCnsKICAg
IHVuc2lnbmVkIGxvbmcgeiA9IHggKyB5OwogICAgdW5zaWduZWQgbG9uZyBidWZmZXJbNjRd
OwoKICAgIGFzbSgiIyBGcmFtZSBwb2ludGVyIGluICVbZnBdXG5cdG1vdiAlW2luXSwlW291
dF0iCgk6IFtvdXRdICI9bSIgKGJ1ZmZlcikKCTogW2luXSAiciIgKHopLCBbZnBdICJyIiAo
X19idWlsdGluX2ZyYW1lX2FkZHJlc3MoMCkpKTsKCiAgICByZXR1cm4gYnVmZmVyWzBdOwp9
Cg==

--------------0n9JcszkqoqIJlUbZ3WXbsBn--

