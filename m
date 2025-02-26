Return-Path: <linux-kernel+bounces-535078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0CA46E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06060188A66F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C7025D8FB;
	Wed, 26 Feb 2025 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="NLAiKZp4"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3425D8E6;
	Wed, 26 Feb 2025 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608905; cv=none; b=NNTdxK/7ezzw9yZ8x4cJWJhkJQzOpzauPXcnu2xUV9wMa5iH/T6pSUh0PsXtxwxDHR6xxGfgiSGkio18kYe/6vmlgYAScPRz/Q74XsEtoM7A7p9P8AtmihgRlKDNPNy1q6lEzkH5qbmlqDk0vOuomJ6UPTUDjg2bmtBFRBlROFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608905; c=relaxed/simple;
	bh=GKE7jAd+DEerxlLvTvnQYNFFCIylpNATZ5ST/9xZg8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sw0yqpki5Lk8UkfTSCzUmmzKIpcjUSzhMabJtZGg/9RS0mohvcr++7XeVax06aCwZHDErvF+eF9mbYS5v1uXnIYNqkmoZMAlNAnTojCHkv8lM/RlzAHQce8warFr5FrUrDxTVt1i43el2IwbC1ouvzVKFDloqYJac3o/7LLrtfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=NLAiKZp4; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740608901; bh=GKE7jAd+DEerxlLvTvnQYNFFCIylpNATZ5ST/9xZg8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NLAiKZp4AzxKLYV+VA2gBa/JS3CL4rAJG5pErMifCUiw1Jh5Dq9/l86a2dMkY+Jj0
	 h2rlfeGz+zT16TeJWOsnc4C6/Y1enWqdNcosWBMK6W+bysDg9fnmbvPWrxZNgO74MF
	 SrFkd3rqJIlccBuANmu/EZmeOjgtW2QDTViWMVuY=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 337112052D08;
	Wed, 26 Feb 2025 23:28:21 +0100 (CET)
Message-ID: <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
Date: Wed, 26 Feb 2025 23:28:20 +0100
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
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

On 26.02.25 19:09, Ventura Jack wrote:
> On Wed, Feb 26, 2025 at 9:32 AM Ralf Jung <post@ralfj.de> wrote:
>>
>> Hi VJ,
>>
>>>>
>>>>> - Rust has not defined its aliasing model.
>>>>
>>>> Correct. But then, neither has C. The C aliasing rules are described in English
>>>> prose that is prone to ambiguities and misintepretation. The strict aliasing
>>>> analysis implemented in GCC is not compatible with how most people read the
>>>> standard (https://bugs.llvm.org/show_bug.cgi?id=21725). There is no tool to
>>>> check whether code follows the C aliasing rules, and due to the aforementioned
>>>> ambiguities it would be hard to write such a tool and be sure it interprets the
>>>> standard the same way compilers do.
>>>>
>>>> For Rust, we at least have two candidate models that are defined in full
>>>> mathematical rigor, and a tool that is widely used in the community, ensuring
>>>> the models match realistic use of Rust.
>>>
>>> But it is much more significant for Rust than for C, at least in
>>> regards to C's "restrict", since "restrict" is rarely used in C, while
>>> aliasing optimizations are pervasive in Rust. For C's "strict aliasing",
>>> I think you have a good point, but "strict aliasing" is still easier to
>>> reason about in my opinion than C's "restrict". Especially if you
>>> never have any type casts of any kind nor union type punning.
>>
>> Is it easier to reason about? At least GCC got it wrong, making no-aliasing
>> assumptions that are not justified by most people's interpretation of the model:
>> https://bugs.llvm.org/show_bug.cgi?id=21725
>> (But yes that does involve unions.)
> 
> For that specific bug issue, there is a GitHub issue for it.
> 
>      https://github.com/llvm/llvm-project/issues/22099

Yeah sorry this was an LLVM issue, not a GCC issue. I mixed things up.

> And the original test case appears to have been a compiler bug
> and have been fixed, at least when I run on Godbolt against
> a recent version of Clang. Another comment says.
> 
>      "The original testcase seems to be fixed now but replacing
>      the union by allocated memory makes the problem come back."
> 
> And the new test case the user mentions involves a void pointer.
> 
> I wonder if they could close the issue and open a new issue
> in its stead that only contains the currently relevant compiler
> bugs if there are any. And have this new issue refer to the old
> issue. They brought the old issue over from the old bug tracker.
> But I do not have a good handle on that issue.
> 
> Unions in C, C++ and Rust (not Rust "enum"/tagged union) are
> generally sharp. In Rust, it requires unsafe Rust to read from
> a union.

Definitely sharp. At least in Rust we have a very clear specification though, 
since we do allow arbitrary type punning -- you "just" reinterpret whatever 
bytes are stored in the union, at whatever type you are reading things. There is 
also no "active variant" or anything like that, you can use any variant at any 
time, as long as the bytes are "valid" for the variant you are using. (So for 
instance if you are trying to read a value 0x03 at type `bool`, that is UB.)
I think this means we have strictly less UB here than C or C++, removing as many 
of the sharp edges as we can without impacting the rest of the language.

>> In contrast, Miri checks for all the UB that is used anywhere in the Rust
>> compiler -- everything else would be a critical bug in either Miri or the compiler.
>> But yes, it only does so on the code paths you are actually testing. And yes, it
>> is very slow.
> 
> I may have been ambiguous again, or unclear or misleading,
> I need to work on that.
> 
> The description you have here indicates that Miri is in many ways
> significantly better than sanitizers in general.
> 
> I think it is more accurate of me to say that Miri in some aspects
> shares some of the advantages and disadvantages of sanitizers,
> and in other aspects is much better than sanitizers.

I can agree with that. :)

> Is Miri the only one of its kind in the programming world?
> There are not many system languages in mass use, and
> those are the languages that first and foremost deal
> with undefined behavior. That would make Miri extra impressive.

I am not aware of a comparable tool that would be in wide-spread use, or that is 
carefully aligned with the semantics of an actual compiler.
For C, there is Cerberus (https://www.cl.cam.ac.uk/~pes20/cerberus/) as an 
executable version of the C specification, but it can only run tiny examples.
The verified CompCert compiler comes with a semantics one could interpret, but 
that only checks code for compatibility with CompCert C, which has a lot less 
(and a bit more) UB than real C.
There are also two efforts that turned into commercial tools that I have not 
tried, and for which there is hardly any documentation of how they interpret the 
C standard so it's not clear what a green light from them means when compiling 
with gcc or clang. I also don't know how much real-world code they can actually run.
- TrustInSoft/tis-interpreter, mostly gone from the web but still available in 
the wayback machine 
(https://web.archive.org/web/20200804061411/https://github.com/TrustInSoft/tis-interpreter/); 
I assume this got integrated into their "TrustInSoft Analyzer" product.
- kcc, a K-framework based formalization of C that is executable. The public 
repo is dead (https://github.com/kframework/c-semantics) and when I tried to 
build their tool that didn't work. The people behind this have a company that 
offers "RV-Match" as a commercial product claiming to find bugs in C based on "a 
complete formal ISO C11 semantics" so I guess that is where their efforts go now.

For C++ and Zig, I am not aware of anything comparable.

Part of the problem is that in C, 2 people will have 3 ideas for what the 
standard means. Compiler writers and programmers regularly have wildly 
conflicting ideas of what is and is not allowed. There are many different places 
in the standard that have to be scanned to answer "is this well-defined" even 
for very simple programs. (https://godbolt.org/z/rjaWc6EzG is one of my favorite 
examples.) A tool can check a single well-defined semantics, but who gets to 
decide what exactly those semantics are?
Formalizing the C standard requires extensive interpretation, so I am skeptical 
of everyone who claims that they "formalized the C standard" and built a tool on 
that without extensive evaluation of how their formalization compares to what 
compilers do and what programmers rely on. The Cerberus people have done that 
evaluation (see e.g. https://dl.acm.org/doi/10.1145/2980983.2908081), but none 
of the other efforts have (to my knowledge). Ideally such a formalization effort 
would be done in close collaboration with compiler authors and the committee so 
that the ambiguities in the standard can be resolved and the formalization 
becomes the one canonical interpretation. The Cerberus people are the ones that 
pushed the C provenance formalization through, so they made great progress here. 
However, many issues remain, some quite long-standing (e.g. 
https://www.open-std.org/jtc1/sc22/wg14/www/docs/dr_260.htm and 
https://www.open-std.org/jtc1/sc22/wg14/www/docs/dr_451.htm, which in my eyes 
never got properly resolved by clarifying the standard). Martin and a few others 
are slowly pushing things in the right direction, but it takes a long time. 
Rust, by having a single project in charge of the one canonical implementation 
and the specification, and having an open process that is well-suited for 
incorporating user concerns, can move a lot quicker here. C has a huge 
head-start, Rust has nothing like the C standard, but we are catching up -- and 
our goal is more ambitious than that; we are doing our best to learn from C and 
C++ and concluded that that style of specification is too prone to ambiguity, so 
we are trying to achieve a formally precise unambiguous specification. Wasm 
shows that this can be done, at industry scale, albeit for a small language -- 
time we do it for a large one. :)

So, yes I think Miri is fairly unique. But please let me know if I missed something!

(As an aside, the above hopefully also explains why some people in Rust are 
concerned about alternative implementations. We do *not* want the current 
de-factor behavior to ossify and become the specification. We do *not* want the 
specification to just be a description of what the existing implementations at 
the time happen to do, and declare all behavior differences to be UB or 
unspecified or so just because no implementation is willing to adjust their 
behavior to match the rest. We want the specification to be prescriptive, not 
descriptive, and we will adjust the implementation as we see fit to achieve that 
-- within the scope of Rust's stability guarantees. That's also why we are so 
cagey about spelling out the aliasing rules until we are sure we have a good 
enough model.)

> There are some issues in Rust that I am curious as to
> your views on. rustc or the Rust language has some type
> system holes, which still causes problems for rustc and
> their developers.
> 
>      https://github.com/lcnr/solver-woes/issues/1
>      https://github.com/rust-lang/rust/issues/75992
> 
> Those kinds of issues seem difficult to solve.
> 
> In your opinion, is it accurate to say that the Rust language
> developers are working on a new type system for
> Rust-the-language and a new solver for rustc, and that
> they are trying to make the new type system and new solver
> as backwards compatible as possible?

It's not really a new type system. It's a new implementation for the same type 
system. But yes there is work on a new "solver" (that I am not involved in) that 
should finally fix some of the long-standing type system bugs. Specifically, 
this is a "trait solver", i.e. it is the component responsible for dealing with 
trait constraints. Due to some unfortunate corner-case behaviors of the old, 
organically grown solver, it's very hard to do this in a backwards-compatible 
way, but we have infrastructure for extensive ecosystem-wide testing to judge 
the consequences of any given potential breaking change and ensure that almost 
all existing code keeps working. In fact, Rust 1.84 already started using the 
new solver for some things 
(https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html) -- did you notice? 
Hopefully not. :)

Kind regards,
Ralf


