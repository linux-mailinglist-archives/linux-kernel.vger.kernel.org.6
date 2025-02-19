Return-Path: <linux-kernel+bounces-520734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3642DA3AE70
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99EA41887D28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD481925AF;
	Wed, 19 Feb 2025 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aDKsDhJg"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085FC7DA95;
	Wed, 19 Feb 2025 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926852; cv=none; b=Swpo1cZ1ebUEJxYH5kjFke1Pdc6I8P83W3UFnUgX6fP2tvhQMGpnCWRM6Dt/uUZphczUYaO+LlPFm2dp8/eH1VcRzd9gjPrdkpMtdYbZQhtZ3Jkzqhbt6sm9BoIVUPRlz8Z2rBEyVfsl9DWqeKHphDU2Km7jc5uEy1m/gLZVtT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926852; c=relaxed/simple;
	bh=vV2D+GMbSCNS9cysj5oqLuuwY43GbGL4ZDsBupCeyYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlSxgld9ZHrJQiGVRv8ths5vXcuafXNl7+uCxTg4SJVehaBgnyA37qZ16bBvuLzKMbPb6BnA9uiSvnMqvCFUq2zCtEpdXUkqyfENGkqyV/h7NI3StC3Gx4SJh3M5t8xa2P42qaacAgL9tRuxxysRXyjEdqrJXntKGwNaCm5hL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=aDKsDhJg; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51J10emT1542300
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Feb 2025 17:00:41 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51J10emT1542300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1739926843;
	bh=e4r1WlzGt+tt37TywQHGre3Fqi+PlceQuuKabeTUd3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aDKsDhJgHbm5ZZJH5SnUXkoPaBc32IDsNvv1qVT597Fn50TiUeI/wGDmEhDsvbWt9
	 p4nFgvp8haFXwgKAuP4EwDqkiBn9ialPrc4f6nTxoEB8r2Z9OezUl23rwdQ0+hKIvE
	 v0WVKM8QOPek76bjiPs0YjMQlLsM46+0mYFtR7Fi8cIQMPZ/m2UsAb6GjxB4+xSOzA
	 g3wKk9j+QWyRAYvJtW60KL5N++MX1zaKI2C2COVjxXm/ycCJsSLk9CN7EMX8YwjjlT
	 fpwIVV9rfIs3oEjSrQvTha7Y0mBQ2lJ3d3luSzCnzy/FT23yaAhMT9r3lwgNrFjlyC
	 1YkxGC2MwyWUg==
Message-ID: <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
Date: Tue, 18 Feb 2025 16:58:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rust kernel policy
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/18/25 14:54, Miguel Ojeda wrote:
> On Tue, Feb 18, 2025 at 10:49 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> I have a few issues with Rust in the kernel:
>>
>> 1. It seems to be held to a *completely* different and much lower standard than the C code as far as stability. For C code we typically require that it can compile with a 10-year-old version of gcc, but from what I have seen there have been cases where Rust level code required not the latest bleeding edge compiler, not even a release version.
> 
> Our minimum version is 1.78.0, as you can check in the documentation.
> That is a very much released version of Rust, last May. This Thursday
> Rust 1.85.0 will be released.
> 
> You can already build the kernel with the toolchains provided by some
> distributions, too.
> 

So at this point Rust-only kernel code (other than experimental/staging) 
should be deferred to 2034 -- or later if the distributions not included 
in the "same" are considered important -- if Rust is being held to the 
same standard as C.

> I think you may be referring to the "unstable features". There remain
> just a few language features (which are the critical ones to avoid
> source code changes), but upstream Rust is working to get them stable
> as soon as possible -- the Linux kernel has been twice, in 2024H2 and
> 2025H1, a flagship goal of theirs for this reason:
> 
>      https://rust-lang.github.io/rust-project-goals/2025h1/goals.html#flagship-goals
>      https://rust-lang.github.io/rust-project-goals/2024h2/index.html
> 
> Meanwhile that happens, upstream Rust requires every PR to
> successfully build a simple configuration of the Linux kernel, to
> avoid mistakenly breaking us in a future release. This has been key
> for us to be able to establish a minimum version with some confidence.
> 
> This does not mean there will be no hiccups, or issues here and there
> -- we are doing our best.

Well, these cases predated 2024 and the 1.78 compiler you mentioned above.

>> 2. Does Rust even support all the targets for Linux?
> 
> Rust has several backends. For the main (LLVM) one, there is no reason
> why we shouldn't be able to target everything LLVM supports, and we
> already target several architectures.
> 
> There is also a GCC backend, and an upcoming Rust compiler in GCC.
> Both should solve the GCC builds side of things. The GCC backend built
> and booted a Linux kernel with Rust enabled a couple years ago. Still,
> it is a work in progress.
> 
> Anyway, for some of the current major use cases for Rust in the
> kernel, there is no need to cover all architectures for the time
> being.

That is of course pushing the time line even further out.

>> 3. I still feel that we should consider whether it would make sense to compile the *entire* kernel with a C++ compiler. I know there is a huge amount of hatred against C++, and I agree with a lot of it – *but* I feel that the last few C++ releases (C++14 at a minimum to be specific, with C++17 a strong want) actually resolved what I personally consider to have been the worst problems.
> 
> Existing Rust as a realistic option nowadays, and not having any
> existing C++ code nor depending on C++ libraries, I don't see why the
> kernel would want to jump to C++.

You can't convert the *entire existing kernel code base* with a single 
patch set, most of which can be mechanically or semi-mechanically 
generated (think Coccinelle) while retaining the legibility and 
maintainability of the code (which is often the hard part of automatic 
code conversion.)

Whereas C++ syntax is very nearly a superset of C, Rust syntax is 
drastically different -- sometimes in ways that seem, at least to me, 
purely gratuitous. That provides a huge barrier, both technical (see 
above) and mental.

>> As far as I understand, Rust-style memory safety is being worked on for C++; I don't know if that will require changes to the core language or if it is implementable in library code.
> 
> Rust-style memory safety for C++ is essentially the "Safe C++"
> proposal. My understanding is that C++ is going with "Profiles" in the
> end, which is not Rust-style memory safety (and remains to be seen how
> they achieve it). "Contracts" aren't it, either.
> 
> My hope would be, instead, that C is the one getting an equivalent
> "Safe C" proposal with Rust-style memory safety, and we could start
> using that, including better interop with Rust.

So, in other words, another long horizon project... and now we need 
people with considerable expertise to change the C code.

>> David Howells did a patch set in 2018 (I believe) to clean up the C code in the kernel so it could be compiled with either C or C++; the patchset wasn't particularly big and mostly mechanical in nature, something that would be impossible with Rust. Even without moving away from the common subset of C and C++ we would immediately gain things like type safe linkage.
> 
> That is great, but that does not give you memory safety and everyone
> would still need to learn C++.

The point is that C++ is a superset of C, and we would use a subset of 
C++ that is more "C+"-style. That is, most changes would occur in header 
files, especially early on. Since the kernel uses a *lot* of inlines and 
macros, the improvements would still affect most of the *existing* 
kernel code, something you simply can't do with Rust.

It is, however, an enabling technology. Consider the recent introduction 
of patchable immediates. Attaching them to types allows for that to be a 
matter of declaration, instead of needing to change every single call 
site to use a function-like syntax.

	-hpa

