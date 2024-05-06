Return-Path: <linux-kernel+bounces-169552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7809D8BCA46
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3F41C210C5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F0D1422B8;
	Mon,  6 May 2024 09:09:49 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3784FB3
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714986588; cv=none; b=njbIZMTLl+Nt9ibgZRNpkRTTbc/jOZ8c7uUvM4Yxy8dtQtNHgozuilgZJPRfBjuzO/gr+H0UYLv683U5U0zUk7cMnK6ixU9+zet5LZcj+7sc4A56Sf/juVJcVt/bQJ49XqbnHFOFgkEC1UuBjRiK5gHv2cEeWolNPVAnG79XBN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714986588; c=relaxed/simple;
	bh=5lA1D4S6YxhuCeP05CVFZMsmQG/T21iCoPwF8LZtQqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLO/lwaqR8DfAS3Ynx2hx7byGNfF/UzUtpT/QnY5lICuHcErRTTI8oackOaxR09hw5XW/TeyiLnbMv7KVpn1oFN3QDlyFxuoscJYnnTFFh4D/yI+/WCRNfk37bKavmPG6U2qVrhjWg9UhP3Onqo+7bgRYum7ntr+IDnIxah+gx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VXwCb5W5pz9xGnR
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:52:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A7A561403D2
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:09:27 +0800 (CST)
Received: from [10.81.216.243] (unknown [10.81.216.243])
	by APP2 (Coremail) with SMTP id GxC2BwDnICU9njhm9uacBw--.33645S2;
	Mon, 06 May 2024 10:09:24 +0100 (CET)
Message-ID: <569605b7-1b87-4c67-97a4-fa883cec0ff8@huaweicloud.com>
Date: Mon, 6 May 2024 11:09:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC+Patch] Formal models as source of truth for Software
 Architects.
To: "Mathew, Cherry G.*" <c@bow.st>
Cc: linux-kernel@vger.kernel.org
References: <85v8axxrmo.fsf@bow.st>
 <2defe3ff-90df-2627-dd19-0442a90b20a4@huaweicloud.com>
 <857cmw2ael.fsf@bow.st>
 <b260c8f8-266f-08c5-2e87-875174042a5b@huaweicloud.com>
 <85lebb1kc6.fsf@bow.st>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <85lebb1kc6.fsf@bow.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDnICU9njhm9uacBw--.33645S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1kZw18Ar18GF17Gw45Jrb_yoWxXrWUpF
	WrK3WYkayDJw1xCwn7Za17XFyrAw4rtrW5GryYqwnrA398XFyfKF4Skr1Y9FyUurZ3uw1j
	va1jvr15ZFyDZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 11/6/2023 um 7:12 AM schrieb Mathew, Cherry G.*:
> Hi Jonas,
> 
>>>>>> Jonas Oberhauser <jonas.oberhauser@huaweicloud.com> writes:
> 
> 
> [...]
> 
> 
>      > I meant that we implemented an internal tool to transpile from C
>      > to PlusCal.
> 
> I'm curious about the design/architecture here - how did you manage the
> logical mappings from C->PlusCal - did you have a third language to
> specify the mappings, or did you use heuristics with inherent
> assumptions ?


We stayed within a subset of C where we were quite certain about what 
the semantics is on our architecture. You can add assertions for UB 
conditions.


> 
>      > It sounded like a great idea at the time. But then it quickly fell
>      > out of use.
> 
> This is something I'm keen to understand why - was this because
> programmers focussed on the C code, and the transpiler+constraints
> became a "testing problem" which ended up in bitrot ? Or is there
> something related to the software methodology/development process ? Or
> perhaps the percieved ROI of formal verification wasn't as much as
> initially thought ? Something else ?
>

Mostly because TLA became too slow. We are using much faster stateless 
modelcheckers
with optimal DPOR or fast SMT backends now ( 
https://gitee.com/s4c/vsyncer ) which work on llvm-ir level, so the need 
to transpile into yet another language disappeared.

> 
> [...]
> 
> 
>      > For reuse, I think the main issue is that implementation code is
>      > always a source of truth - the truth of what's really going to be
>      > executed.  If we want to have a second source of truth, it should
>      > be a different truth, such as "assumptions of the other parts of
>      > the system".
> 
>      > Since you already have this source of truth, if you make a
>      > different implementation in another kernel, you can compare what
>      > the original driver was doing with what your new implementation is
>      > doing.  There's no need to have yet another copy of what the
>      > driver might be doing.
> 
> 
> I understand what you're saying, but there are a few points that I'm
> probably not able to express clearly.
> 
> Just to set context, and not to state the obvious - as you likely
> already know, Formal languages such as pluscal or promela have an
> "execution model" that is different from a programming language - in
> that, when one writes code in them, one's mental model needs to pay
> attention to behaviour, whereas function becomes a more abstract
> problem[...]. I wrote a very hand wavy description of
> this in the context of spin:
> 
> https://mail-index.netbsd.org/tech-kern/2023/09/28/msg029203.html


I don't understand this paragraph.

> 
> So to return to your concern about code duplication, in the context of
> codegen, one could make the same argument about compiled or transpiled
> code - if it were manually transpiled. And yet we are comfortable as
> programmers, assuming that the "higher level language" is the source of
> truth, while happily stepping "down" to gcc __inline__ __asm__ {} when
> needed. So, for eg: (and I believe there are tools out there that can
> do this to some degree) - if the programming code could be
> auto-generated/"compiled" from the formal specification, then this would
> become directly analogous.


In system software, there are a lot of implementation concerns that go 
beyond what you'd normally express in a formal spec. Once you add all of 
that detail, it becomes an implementation.


> 
> 
> [...]
> 
>      >> Can you give me an example of how this works/a pre-existing tool
>      >> that helps with this simplification ? I'm actually currently
>      >> looking at re-writing modex to do precisely this (but with the
>      >> translation end-point being something close to the original
>      >> model).
> 
> 
>      > I think any higher level language, including C, goes into this
>      > direction. Some are just a lot better at building abstractions and
>      > describing the code more model-like than
>      > tiniest-implementation-detail-like.
> 
> C is problematic because it doesn't for eg: define concurrency or
> consistency models - in many cases, even the data types are not clearly
> defined (eg: "integer" is machine word size dependant). So it's really
> hard to specify something formal at the level of C that is not very
> context (OS/CPU arch) specific.


In practice this is a non-issue.
Either prove that it works for the least common denominator. E.g. if you 
prove that your int values stay within 16 bit, or you know your 
architectures all have 32 bit int, there's no issue. Or you use a u32 or 
uint32_t.

If you're paranoid about future use, you can write some assertions 
checking that the assumptions you make here are really valid in your 
real environment.

And C has concurrency models, both in C11+ and in LKMM.


> 
>      > By executable comment I mean a comment that has a formal semantics
>      > that can be executed.
> 
>      > Think more pre&post conditions + ghost code. E.g., for a tricky
>      > sort algorithm like timsort the comment might be something like
> 
>      > var __ghost_array = copy(input_array);
> 
>      > .... // complicated timsort code here
> 
>      > insertion_sort(&__ghost_array); // timsort should give the same
>      > output as insertion stort, note that both are stable
> 
>      > for (i in 0...array_len) {     assert (sorted_array[i] ==
>      > __ghost_array[i]); }
> 
> 
>      > This is probably not going to help you find the well-known timsort
>      > bug, but it might be enough to find more trivial mistakes when
>      > rolling your own timsort.  Anyways this is what I mean by
>      > executable comment - a more readable, maintainable implementation
>      > of the code that tells you what the code ought to be doing + some
>      > checks to say that they're really doing the same thing.
> 
> This looks closer to testing to me - the assertions for eg: seems to be
> atemporal ie; only concerned about "immedate" values, unlike LTL which
> can check behaviour across an "execution sequence" (in the set of all
> possible execution sequences). So from an FV perspective, I would write
> the assertion to look more like: "eventually is_sorted(array)", where
> is_sorted() has magic to check to if the array elements are sorted in
> whatever required order.

In principle you can extend the assertion language to temporal formulas 
as well. There are some cases where we write assertions over a whole 
trace. But it's easier to find engineers who write some non-temporal 
assertions than those who write temporal assertions.

Best wishes,

jonas


