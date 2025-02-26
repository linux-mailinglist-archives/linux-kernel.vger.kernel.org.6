Return-Path: <linux-kernel+bounces-534432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA8A466E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9277E19C58AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBC722258B;
	Wed, 26 Feb 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="YjrkjbhZ"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE702222584;
	Wed, 26 Feb 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587561; cv=none; b=Q3Do+WiuXiVzwSxuAQhpUZqlpSsXg8j8m7H+MdgRQaeezSkOBdRVvGf9roqWL79eUnuc0W2A9tDPbgdwYDOfWpaO1i+l1RBg9VdnyjIb8m+SV3slnPsV/MoXg3V9gQ1wVAXi4ocw0FzX6MVJJzppCNa7oTTaZvxlAKCUdYy95Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587561; c=relaxed/simple;
	bh=dLY21KoCoTtcPIJVWDbdSVxDOSaKowQVO40jIG8etkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdiOOrhw/CC/Uz0XOw6RQGyZmWgbYCoyVGhJ1ti+5LFJProptGDc/lpeQPeAFrIUAzwqhnUy3J4JQbQ8jroOoLolH7eE3TYFUXOgNRvHlNbepXXlFgUGxilJn7JRLuqe93HXDxayn+lWhHYcxzG8tQB0LSK5Wg+DXbeJkd6IfyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=YjrkjbhZ; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740587557; bh=dLY21KoCoTtcPIJVWDbdSVxDOSaKowQVO40jIG8etkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YjrkjbhZwXRhQvII1s4aE5PcJLxidQ/y3EUYVfd5ao/jPD7hmKeH8Rpg+FBFYr/Z3
	 GEW6dR8QNGwvdds5XTb5WZSomLCSYU1H++hfP9y/zasRqsWX1IV0If0Bj4w/hOsyNl
	 0DikD4LnE3FzgTSweiaRv2duZ+Dv3bYYoVTJrGjY=
Received: from [IPV6:2001:67c:10ec:5784:8000::12e7] (2001-67c-10ec-5784-8000--12e7.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::12e7])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 143A22052D08;
	Wed, 26 Feb 2025 17:32:37 +0100 (CET)
Message-ID: <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
Date: Wed, 26 Feb 2025 17:32:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>,
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
 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
 <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi VJ,

>>
>>> - Rust has not defined its aliasing model.
>>
>> Correct. But then, neither has C. The C aliasing rules are described in English
>> prose that is prone to ambiguities and misintepretation. The strict aliasing
>> analysis implemented in GCC is not compatible with how most people read the
>> standard (https://bugs.llvm.org/show_bug.cgi?id=21725). There is no tool to
>> check whether code follows the C aliasing rules, and due to the aforementioned
>> ambiguities it would be hard to write such a tool and be sure it interprets the
>> standard the same way compilers do.
>>
>> For Rust, we at least have two candidate models that are defined in full
>> mathematical rigor, and a tool that is widely used in the community, ensuring
>> the models match realistic use of Rust.
> 
> But it is much more significant for Rust than for C, at least in
> regards to C's "restrict", since "restrict" is rarely used in C, while
> aliasing optimizations are pervasive in Rust. For C's "strict aliasing",
> I think you have a good point, but "strict aliasing" is still easier to
> reason about in my opinion than C's "restrict". Especially if you
> never have any type casts of any kind nor union type punning.

Is it easier to reason about? At least GCC got it wrong, making no-aliasing 
assumptions that are not justified by most people's interpretation of the model:
https://bugs.llvm.org/show_bug.cgi?id=21725
(But yes that does involve unions.)

>>> - The aliasing rules in Rust are possibly as hard or
>>>      harder than for C "restrict", and it is not possible to
>>>      opt out of aliasing in Rust, which is cited by some
>>>      as one of the reasons for unsafe Rust being
>>>      harder than C.
>>
>> That is not quite correct; it is possible to opt-out by using raw pointers.
> 
> Again, I did have this list item:
> 
> - Applies to certain pointer kinds in Rust, namely
>      Rust "references".
>      Rust pointer kinds:
>      https://doc.rust-lang.org/reference/types/pointer.html
> 
> where I wrote that the aliasing rules apply to Rust "references".

Okay, fair. But it is easy to misunderstand the other items in your list in 
isolation.

> 
>>>      the aliasing rules, may try to rely on MIRI. MIRI is
>>>      similar to a sanitizer for C, with similar advantages and
>>>      disadvantages. MIRI uses both the stacked borrow
>>>      and the tree borrow experimental research models.
>>>      MIRI, like sanitizers, does not catch everything, though
>>>      MIRI has been used to find undefined behavior/memory
>>>      safety bugs in for instance the Rust standard library.
>>
>> Unlike sanitizers, Miri can actually catch everything. However, since the exact
>> details of what is and is not UB in Rust are still being worked out, we cannot
>> yet make in good conscience a promise saying "Miri catches all UB". However, as
>> the Miri README states:
>> "To the best of our knowledge, all Undefined Behavior that has the potential to
>> affect a program's correctness is being detected by Miri (modulo bugs), but you
>> should consult the Reference for the official definition of Undefined Behavior.
>> Miri will be updated with the Rust compiler to protect against UB as it is
>> understood by the current compiler, but it makes no promises about future
>> versions of rustc."
>> See the Miri README (https://github.com/rust-lang/miri/?tab=readme-ov-file#miri)
>> for further details and caveats regarding non-determinism.
>>
>> So, the situation for Rust here is a lot better than it is in C. Unfortunately,
>> running kernel code in Miri is not currently possible; figuring out how to
>> improve that could be an interesting collaboration.
> 
> I do not believe that you are correct when you write:
> 
>      "Unlike sanitizers, Miri can actually catch everything."
> 
> Critically and very importantly, unless I am mistaken about MIRI, and
> similar to sanitizers, MIRI only checks with runtime tests. That means
> that MIRI will not catch any undefined behavior that a test does
> not encounter. If a project's test coverage is poor, MIRI will not
> check a lot of the code when run with those tests. Please do
> correct me if I am mistaken about this. I am guessing that you
> meant this as well, but I do not get the impression that it is
> clear from your post.

Okay, I may have misunderstood what you mean by "catch everything". All 
sanitizers miss some UB that actually occurs in the given execution. This is 
because they are inserted in the pipeline after a bunch of compiler-specific 
choices have already been made, potentially masking some UB. I'm not aware of a 
sanitizer for sequence point violations. I am not aware of a sanitizer for 
strict aliasing or restrict. I am not aware of a sanitizer that detects UB due 
to out-of-bounds pointer arithmetic (I am not talking about OOB accesses; just 
the arithmetic is already UB), or UB due to violations of "pointer lifetime end 
zapping", or UB due to comparing pointers derived from different allocations. Is 
there a sanitizer that correctly models what exactly happens when a struct with 
padding gets copied? The padding must be reset to be considered "uninitialized", 
even if the entire struct was zero-initialized before. Most compilers implement 
such a copy as memcpy; a sanitizer would then miss this UB.

In contrast, Miri checks for all the UB that is used anywhere in the Rust 
compiler -- everything else would be a critical bug in either Miri or the compiler.
But yes, it only does so on the code paths you are actually testing. And yes, it 
is very slow.

Kind regards,
Ralf


