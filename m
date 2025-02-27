Return-Path: <linux-kernel+bounces-537209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21512A4892A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEA81887562
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044126F450;
	Thu, 27 Feb 2025 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="v6drtZYz"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1DF1B0425;
	Thu, 27 Feb 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685513; cv=none; b=PD8iCaq/T94PcNq9g23oSITaXHYwdZdeX0BX/XeYocoRmGDfZgaNrY1khy92+jUg2Jm1pFBYYUE7K4hmsvzvy7dzrGW4+bFPAL+ZoTSghB27v8AOMJw9zLNarcXzApJjzu/x1tax6510PmhiwEFajfGYmQB5gvW4G6MGOgg/mjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685513; c=relaxed/simple;
	bh=gesQMxj7Fwq5XC+SjAAs9pihxzdHZt1//95R4hli8xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uePlWx2SRRST6QJ2SdDgREnp2liZyiQDOgxa6lKikDeOKqDdia0wqhP1o5ouyYiic9VfnkinY2v50OkT2RwazgyFqVjGeo9SKkNF/MYJdjbCBk0Kc+RmWSg46MaoBGybdvOIQUqG1nBcOadS0fKKHIQXiiKFneZGnIiN0ibfywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=v6drtZYz; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740685509; bh=gesQMxj7Fwq5XC+SjAAs9pihxzdHZt1//95R4hli8xg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v6drtZYzdLal7RxgTbqHIs5ceqAdiAwByeDHFHTq7RosFSALYmqbST9ToWf2H+kYI
	 OGk7Mt0O88jbqzbemFI/W/olHEOFX5pIzlfRQCaSlrRVMhmg/uBFNZWStq07sTWNJ8
	 TDPXZkySHlKh1/Fj4XLZLkND6H3uForr3YCBA2sY=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 92FCD2052A91;
	Thu, 27 Feb 2025 20:45:09 +0100 (CET)
Message-ID: <651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de>
Date: Thu, 27 Feb 2025 20:45:09 +0100
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
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
 <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
 <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
 <d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de>
 <CAFJgqgQ=dJk7Jte-aaB55_CznDEnSVcy+tEh83BwmrMVvOpUgQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAFJgqgQ=dJk7Jte-aaB55_CznDEnSVcy+tEh83BwmrMVvOpUgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>>> If C was willing to break code as much as Rust, it would be easier to
>>> clean up C.
>>
>> Is that true? Gcc updates do break code.
> 
> Surely not as much as Rust, right? From what I hear from users
> of Rust and of C, some Rust developers complain about
> Rust breaking a lot and being unstable, while I instead
> hear complaints about C and C++ being unwilling to break
> compatibility.

Stable Rust code hardly ever breaks on a compiler update. I don't know which 
users you are talking about here, and it's hard to reply anything concrete to 
such a vague claim that you are making here. I also "hear" lots of things, but 
we shouldn't treat hear-say as facts.
*Nightly* Rust features do break regularly, but nobody has any right to complain 
about that -- nightly Rust is the playground for experimenting with features 
that we know are no ready yet.

> Rust does admittedly a lot of the time have tools to
> mitigate it, but Rust sometimes go beyond that.
> C code from 20 years ago can often be compiled
> without modification on a new compiler, that is a common
> experience I hear about. While I do not know if that
> would hold true for Rust code. Though Rust has editions.

Well, it is true that Rust code from 20 years ago cannot be compiled on today's 
compiler any more. ;)  But please do not spread FUD, and instead stick to 
verifiable claims or cite some reasonable sources.

> The time crate breaking example above does not
> seem nice.

The time issue is like the biggest such issue we had ever, and indeed that did 
not go well. We should have given the ecosystem more time to update to newer 
versions of the time crate, which would have largely mitigated the impact of 
this. A mistake was made, and a *lot* of internal discussion followed to 
minimize the chance of this happening again. I hope you don't take that accident 
as being representative of regular Rust development.

Kind regards,
Ralf

> 
>>> A fear I have is that there may be hidden reliance in
>>> multiple different ways on LLVM, as well as on rustc.
>>> Maybe even very deeply so. The complexity of Rust's
>>> type system and rustc's type system checking makes
>>> me more worried about this point. If there are hidden
>>> elements, they may turn out to be very difficult to fix,
>>> especially if they are discovered to be fundamental.
>>> While having one compiler can be an advantage in
>>> some ways, it can arguably be a disadvantage
>>> in some other ways, as you acknowledge as well
>>> if I understand you correctly.
>>
>> The Rust type system has absolutely nothing to do with LLVM. Those are
>> completely separate parts of the compiler. So I don't see any way that LLVM
>> could possibly influence our type system.
> 
> Sorry for the ambiguity, I packed too much different
> information into the same block.
> 
>>> You mention ossifying, but the more popular Rust becomes,
>>> the more painful breakage will be, and the less suited
>>> Rust will be as a research language.
>>
>> I do not consider Rust a research language. :)
> 
> It reminds me of Scala, in some ways, and some complained
> about Scala having too much of a research and experimental
> focus. I have heard similar complaints about Rust being
> too experimental, and that was part of why they did not
> wish to adopt it in some organizations. On the other hand,
> Amazon Web Services and other companies already
> use Rust extensively. AWS might have more than 300
> Rust developer employed. The more usage and code,
> the more painful breaking changes might be.
> 
>>> I hope that any new language at least has its
>>> language developers ensure that they have a type
>>> system that is formalized and proven correct
>>> before that langauge's 1.0 release.
>>> Since fixing a type system later can be difficult or
>>> practically impossible. A complex type system
>>> and complex type checking can be a larger risk in this
>>> regard relative to a simple type system and simple
>>> type checking, especially the more time passes and
>>> the more the language is used and have code
>>> written in it, making it more difficult to fix the language
>>> due to code breakage costing more.
>>
>> Uff, that's a very high bar to pass.^^ I think there's maybe two languages ever
>> that meet this bar? SML and wasm.
> 
> You may be right about the bar being too high.
> I would have hoped that it would be easier to achieve
> with modern programming language research and
> advances.
> 
>>>>> There are some issues in Rust that I am curious as to
>>>>> your views on. rustc or the Rust language has some type
>>>>> system holes, which still causes problems for rustc and
>>>>> their developers.
>>>>>
>>>>>        https://github.com/lcnr/solver-woes/issues/1
>>>>>        https://github.com/rust-lang/rust/issues/75992
>>>>>
>>>>> Those kinds of issues seem difficult to solve.
>>>>>
>>>>> In your opinion, is it accurate to say that the Rust language
>>>>> developers are working on a new type system for
>>>>> Rust-the-language and a new solver for rustc, and that
>>>>> they are trying to make the new type system and new solver
>>>>> as backwards compatible as possible?
>>>>
>>>> It's not really a new type system. It's a new implementation for the same type
>>>> system. But yes there is work on a new "solver" (that I am not involved in) that
>>>> should finally fix some of the long-standing type system bugs. Specifically,
>>>> this is a "trait solver", i.e. it is the component responsible for dealing with
>>>> trait constraints. Due to some unfortunate corner-case behaviors of the old,
>>>> organically grown solver, it's very hard to do this in a backwards-compatible
>>>> way, but we have infrastructure for extensive ecosystem-wide testing to judge
>>>> the consequences of any given potential breaking change and ensure that almost
>>>> all existing code keeps working. In fact, Rust 1.84 already started using the
>>>> new solver for some things
>>>> (https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html) -- did you notice?
>>>> Hopefully not. :)
>>>
>>> If it is not a new type system, why then do they talk about
>>> backwards compatibility for existing Rust projects?
>>
>> If you make a tiny change to a type system, is it a "new type system"? "new type
>> system" sounds like "from-scratch redesign". That's not what happens.
> 
> I can see your point, but a different type system would be
> different. It may be a matter of definition. In practice, the
> significance and consequences would arguably depend on
> how much backwards compatibility it has, and how many and
> how much existing projects are broken.
> 
> So far, it appears to require a lot of work and effort for
> some of the Rust language developers, and my impression
> at a glance is that they have significant expertise, yet have
> worked on it for years.
> 
> Best, VJ.


