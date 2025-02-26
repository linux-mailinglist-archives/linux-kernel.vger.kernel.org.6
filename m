Return-Path: <linux-kernel+bounces-533661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C4A45D67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2DA1894020
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9D215F65;
	Wed, 26 Feb 2025 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="cM5hWEUY"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A22153D1;
	Wed, 26 Feb 2025 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570132; cv=none; b=PyYnvXDp0XEvWaODKeShAHZAW4gVD4vLiAS6kOfeWhVla/VbsYEHMz9lvDE35BDFiG1iRrF8B844TlMiyR3meae15bAR+sdZ/q6pYgrr8RLeVIUPx7tECFxxssa6s66BJjJF7vhDT7XHRsecnzdzmDVdgVNEGWU1W/nyUo8IvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570132; c=relaxed/simple;
	bh=GOhTGczcTjfvMvpCsfS2BvZQ7Bz7cikultwN5meq4Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VR0sbYDd3TwvewbN/X5cZL3KjIQ/qAf+B+t/MBLnbzFpYOwJd6Am++A8FqZ73/3rU/tESnrvZ146jZGc/oZMsGXWwe1CsdGWg2c0v55ulOrgAnWg83QlEx6+GOKG0cxj6P+Vgek8RBFzMK9H7N6aeGJbcuIhVS48qlqMmreZuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=cM5hWEUY; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740569661; bh=GOhTGczcTjfvMvpCsfS2BvZQ7Bz7cikultwN5meq4Jw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cM5hWEUYw2FTzMrtuHZC2t66ICTfpbYwbB2tSIL2buu59S0fRaIsNzy+qAdUh3EFw
	 vGV+Zimv2DG1q0MuipQebSUV1SrnjSG0yU1ppTVlH1nSa047pL1KUaPtPb7/s6Z/jZ
	 byJtkByqKVJX3K5rhprdvBb1jkH/CD+0+hYdyS+8=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 18A262052D08;
	Wed, 26 Feb 2025 12:34:21 +0100 (CET)
Message-ID: <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
Date: Wed, 26 Feb 2025 12:34:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>,
 torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com,
 david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

(For context, I am the supervisor of the Tree Borrows project and the main 
author of its predecessor, Stacked Borrows. I am also maintaining Miri, a Rust 
UB detection tool that was mentioned elsewhere in this thread. I am happy to 
answer any questions you might have about any of these projects. :)

>> Not sure what I said, but Cc'ing Ralf in case he has time and wants to
>> share something on this (thanks in advance!).
> 
> Yeah, this looks like just the thing. At the conference you were talking
> more about memory provenance in C, if memory serves there was cross
> pollination going on between the C and Rust folks - did anything come of
> the C side?

On the C side, there is a provenance model called pnvi-ae-udi (yeah the name is 
terrible, it's a long story ;), which you can read more about at 
<http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2676.pdf>. My understanding is 
that it will not become part of the standard though; I don't understand the 
politics of WG14 well enough to say what exactly its status is. However, my 
understanding is that that model would require some changes to both clang and 
gcc for them to be compliant (and likely most other C compilers that do any kind 
of non-trivial alias analysis); I am not sure what the plans/timeline are for 
making that happen.

The Rust aliasing model 
(https://doc.rust-lang.org/nightly/std/ptr/index.html#strict-provenance) is 
designed to not require changes to the backend, except for fixing things that 
are clear bugs that also affect C code 
(https://github.com/llvm/llvm-project/issues/33896, 
https://github.com/llvm/llvm-project/issues/34577).

I should also emphasize that defining the basic treatment of provenance is a 
necessary, but not sufficient, condition for defining an aliasing model.

>>  From a quick look, Tree Borrows was submitted for publication back in November:
>>
>>      https://jhostert.de/assets/pdf/papers/villani2024trees.pdf
>>      https://perso.crans.org/vanille/treebor/
> 
> That's it.
> 
> This looks fantastic, much further along than the last time I looked.
> The only question I'm trying to answer is whether it's been pushed far
> enough into llvm for the optimization opportunities to be realized - I'd
> quite like to take a look at some generated code.

I'm glad you like it. :)

Rust has informed LLVM about some basic aliasing facts since ~forever, and LLVM 
is using those opportunities all over Rust code. Specifically, Rust has set 
"noalias" (the LLVM equivalent of C "restrict") on all function parameters that 
are references (specifically mutable reference without pinning, and shared 
references without interior mutability). Stacked Borrows and Tree Borrows kind 
of retroactively are justifying this by clarifying the rules that are imposed on 
unsafe Rust, such that if unsafe Rust follows those rules, they also follow 
LLVM's "noalias". Unfortunately, C "restrict" and LLVM "noalias" are not 
specified very precisely, so we can only hope that this connection indeed holds.

Both Stacked Borrows and Tree Borrows go further than "noalias"; among other 
differences, they impose aliasing requirements on references that stay within a 
function. Most of those extra requirements are not yet used by the optimizer (it 
is not clear how to inform LLVM about them, and Rust's own optimizer doesn't use 
them either). Part of the reason for this is that without a precise model, it is 
hard to be sure which optimizations are correct (in the sense that they do not 
break correct unsafe code) -- and both Stacked Borrows and Tree Borrows are 
still experiments, nothing has been officially decided yet.

Let me also reply to some statements made further up-thread by Ventura Jack (in 
<https://lore.kernel.org/rust-for-linux/CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com/>):

> - Aliasing in Rust is not opt-in or opt-out,
>     it is always on.
>     https://doc.rust-lang.org/nomicon/aliasing.html

This is true, but only for references. There are no aliasing requirements on raw 
pointers. There *are* aliasing requirements if you mix references and raw 
pointers to the same location, so if you want to do arbitrary aliasing you have 
to make sure you use only raw pointers, no references. So unlike in C, you have 
a way to opt-out entirely within standard Rust.

The ergonomics of working with raw pointers could certainly be improved. The 
experience of kernel developers using Rust could help inform that effort. :) 
Though currently the main issue here is that there's nobody actively pushing for 
this.

> - Rust has not defined its aliasing model.

Correct. But then, neither has C. The C aliasing rules are described in English 
prose that is prone to ambiguities and misintepretation. The strict aliasing 
analysis implemented in GCC is not compatible with how most people read the 
standard (https://bugs.llvm.org/show_bug.cgi?id=21725). There is no tool to 
check whether code follows the C aliasing rules, and due to the aforementioned 
ambiguities it would be hard to write such a tool and be sure it interprets the 
standard the same way compilers do.

For Rust, we at least have two candidate models that are defined in full 
mathematical rigor, and a tool that is widely used in the community, ensuring 
the models match realistic use of Rust.

> - The aliasing rules in Rust are possibly as hard or
>     harder than for C "restrict", and it is not possible to
>     opt out of aliasing in Rust, which is cited by some
>     as one of the reasons for unsafe Rust being
>     harder than C.

That is not quite correct; it is possible to opt-out by using raw pointers.

>     the aliasing rules, may try to rely on MIRI. MIRI is
>     similar to a sanitizer for C, with similar advantages and
>     disadvantages. MIRI uses both the stacked borrow
>     and the tree borrow experimental research models.
>     MIRI, like sanitizers, does not catch everything, though
>     MIRI has been used to find undefined behavior/memory
>     safety bugs in for instance the Rust standard library.

Unlike sanitizers, Miri can actually catch everything. However, since the exact 
details of what is and is not UB in Rust are still being worked out, we cannot 
yet make in good conscience a promise saying "Miri catches all UB". However, as 
the Miri README states:
"To the best of our knowledge, all Undefined Behavior that has the potential to 
affect a program's correctness is being detected by Miri (modulo bugs), but you 
should consult the Reference for the official definition of Undefined Behavior. 
Miri will be updated with the Rust compiler to protect against UB as it is 
understood by the current compiler, but it makes no promises about future 
versions of rustc."
See the Miri README (https://github.com/rust-lang/miri/?tab=readme-ov-file#miri) 
for further details and caveats regarding non-determinism.

So, the situation for Rust here is a lot better than it is in C. Unfortunately, 
running kernel code in Miri is not currently possible; figuring out how to 
improve that could be an interesting collaboration.

Kind regards,
Ralf


