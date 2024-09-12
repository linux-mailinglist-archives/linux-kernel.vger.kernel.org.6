Return-Path: <linux-kernel+bounces-327000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C94976FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F05F1F26A06
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E61C1AF4D3;
	Thu, 12 Sep 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="PuWdC/CP"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAE188938;
	Thu, 12 Sep 2024 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162690; cv=none; b=AhE+inpfqNJ7mnZfwuHGAI3TR8ICrPEsXzYgSHhzifyvfwbvcx2V1xQb3RyUfnam9rH+ziyne1ZqxZ2vUqeNhPFyTUiNRxkFOnBrX5FR7NXOmzpZWnfjWcfxm7KNvyXpKl2fcApoDgnnZhzhNQMgV9WBKmoYwaLBIQW+HvcUXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162690; c=relaxed/simple;
	bh=XQFOubHEtDRox5oi8I2q0my1cU7WPHuBOJ1lMOJslXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jVLExoJumNiabtW5JafswKyktlh8R8+KBKe9uZhOmhHRtOIxvM5OVZmn2Fv8hp0Gj7o0DMrtW6FBgcZLqjH2IMTN72RhOnGks+iyAeRMvnaW3ckdhuZ9OCItaxfgflU3QYVxPOQVeuU9UwUEfI3lJM4ux6mnY7VDHZoyuKt2F5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=PuWdC/CP; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726162673; x=1726767473; i=deller@gmx.de;
	bh=Z6l5XvUqYz5BUu4KSoHSQQfktiDciNafCx5gkDrZHiM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PuWdC/CPq44rdDGky+1+BDWpVf0HTZqItz3XQ+APwJX/x4AIKR9LxrC0yC5ULla+
	 Ei6sYixekE1R0cLp2VjoH0VkPfZlhe/QMFuqpPcR03B/VuASCRe1oj324/F0bXP4Z
	 HR4fgqpKQz9/+avxVGCQi9SgH2gOzDKqM424Sd/CYtxBFB5XvS43q5Q5PxDGWTw+g
	 fSKdNJxVplTaboWFrsA6rmx/6+72FN6sK1GLW7uAeBx0KPOrZMQMd5jyc/XcLRFDx
	 8JlTWCY5Cy6r1qDUT4vaPbEwwAyemQZKzjwnxJHXpLNJssIlAdx2S3o4v+jvTt+BN
	 uKPg+nOF4XRs9DctOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma24y-1sTwwu44EW-00OhEv; Thu, 12
 Sep 2024 19:37:53 +0200
Message-ID: <87e019fe-e137-49c9-a414-8f4f373fc4b6@gmx.de>
Date: Thu, 12 Sep 2024 19:37:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable
 stack
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Yang Shi <shy828301@gmail.com>, Helge Deller <deller@kernel.org>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-parisc@vger.kernel.org
References: <ZuHtb43Ar21ZptNz@p100>
 <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
 <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com>
 <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d>
 <95c4efe9-e92a-46fe-bf41-9141e125332d@gmx.de>
 <x2d4kyyeclp5fgeug2l3bjalp773ozgkl5vr5o7dpqcbopampg@5a3x2cr456qp>
 <c226a38a-3612-4949-9da7-8d42f8636b47@gmx.de>
 <bfkqcuayvrdt5xieqhv4lhx3ry6vurxzvvluxodrjzar7cyycl@id5377gr6cs4>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <bfkqcuayvrdt5xieqhv4lhx3ry6vurxzvvluxodrjzar7cyycl@id5377gr6cs4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g6yUezAG6T3zpa/3A8CqLPYc1CPjf2Fbt/GRvDr9tRc8bsC7PA5
 5EhjW/xSPfEYswiQXc56H2aFgHlMGmgdpvO9xGnixf5ZiVPjidISeX08Wxq04OHHUVnFiTL
 Sh2j0s5DlGzvY0K6ngX17wi5b+03GR6vm7DE3igx3uH5NmpWmRykd2mhL9noMNrKv/sRew1
 x+CN/pegVBggP/RIjlgsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pL3nLwybQ9A=;hOsKdzu+iqMxLSc++LEnwIC2SfI
 8GRWwpA336okYWZcN/NuAKnwajRDDPf5AwJ84kVPefl+RWUoZ01y+ZkoB37LvDILlKKQ8ylVn
 mE9aa1t3gEuBqPYTE3P5W34C2qwmWuORUoPsbXX9OWWKP6+7jkBwaZMjS4yNen21frHctRlop
 zyfZ0e0HSklqhZkFUUOTt9+DJDi3I8xP3fdCnexcWmq4tMCUs3Uyh1a05IO7fvNLDqRo0q6Qj
 +xcZevg7IFljX6M08rGeQ466JX6TGnQxD+zepUGyobtU+LjyWKSs4sGS82eP9JgqszZfDySaF
 gQhTAyxy/wfjcXT+HMBy4Zrq3BOr7DmZU05AaupUARiQcC3NJ/7h/85g80IK9KFZURA4AZkzG
 ILvjK8u8QJH9TGL0IhYnsVQJa7vQSxJaP7VAqnAxErUZ9B1e+5dVUeMf2Ft2QBZBpSxL391sj
 U9Y9VIN52/R87+nhu1mAJW9g27ZIA8y2UFB2sC43tJzQqeZ8em9bd3SnluTk5CY7a+zn4o7Pq
 97x6Z7TKPagRCGFQtMQyeobreGIrjT07vXavljBauKt8YwtPB4ztbtkiIWw/zYXGL3zvupgt6
 4mTGL4pnht3jiynSPAh7sF+bWLU2KAE4WgZG4+QPfNoo+wPHL/VwRk86IGUs5dIWDEC1vqFJ0
 FCZOX7BXLEd0XGJOJMjnmgzkUecxV3mbXL/tgJnLR+i9jWXowUr7wrTS19T72Iie5NVvw45rJ
 ACS436daz+ZaGSh7n/VK21FgtKQoJLryVAu64vel67qD0xF3KVD7YPGbaldqSJbeVt7irkkCD
 VSaPHFOHgrt5lIPmGNxQs0Xw==

On 9/12/24 17:43, Liam R. Howlett wrote:
> * Helge Deller <deller@gmx.de> [240911 22:10]:
>> On 9/12/24 03:32, Liam R. Howlett wrote:
>>> * Helge Deller <deller@gmx.de> [240911 20:51]:
>>>> On 9/12/24 01:05, Liam R. Howlett wrote:
>>>>> * Yang Shi <shy828301@gmail.com> [240911 18:16]:
>>>>>> On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
>>>>>> <Liam.Howlett@oracle.com> wrote:
>>>>>>>
>>>>>>> * Helge Deller <deller@kernel.org> [240911 15:20]:
>>>>>>>> This is a RFC to change the behaviour of mmap(MAP_STACK) to be
>>>>>>>> sufficient to map memory for usage as stack on all architectures.
>>>>>>>> Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDOW=
N
>>>>>>>> has to be used.
>>>>>>>> To clarify, here is the relevant info from the mmap() man page:
>>>>>>>>
>>>>>>>> MAP_GROWSDOWN
>>>>>>>>       This flag is used for stacks. It indicates to the kernel vi=
rtual
>>>>>>>>       memory system that the mapping should extend downward in me=
mory.  The
>>>>>>>>       return address is one page lower than the memory area that =
is
>>>>>>>>       actually created in the process's virtual address space.  T=
ouching an
>>>>>>>>       address in the "guard" page below the mapping will cause th=
e mapping
>>>>>>>>       to grow by a page. This growth can be repeated until the ma=
pping
>>>>>>>>       grows to within a page of the high end of the next lower ma=
pping,
>>>>>>>>       at which point touching the "guard" page will result in a S=
IGSEGV
>>>>>>>>       signal.
>>>>>>>>
>>>>>>>> MAP_STACK (since Linux 2.6.27)
>>>>>>>>       Allocate the mapping at an address suitable for a process o=
r thread
>>>>>>>>       stack.
>>>>>>>>
>>>>>>>>       This flag is currently a no-op on Linux. However, by employ=
ing this
>>>>>>>>       flag, applications can ensure that they transparently obtai=
n support
>>>>>>>>       if the flag is implemented in the future. Thus, it is used =
in the
>>>>>>>>       glibc threading implementation to allow for the fact that
>>>>>>>>       some architectures may (later) require special treatment fo=
r
>>>>>>>>       stack allocations. A further reason to employ this flag is
>>>>>>>>       portability: MAP_STACK exists (and has an effect) on some
>>>>>>>>       other systems (e.g., some of the BSDs).
>>>>>>>>
>>>>>>>> The reason to suggest this change is, that on the parisc architec=
ture the
>>>>>>>> stack grows upwards. As such, using solely the MAP_GROWSDOWN flag=
 will not
>>>>>>>> work. Note that there exists no MAP_GROWSUP flag.
>>>>>>>> By changing the behaviour of MAP_STACK to mark the memory area wi=
th the
>>>>>>>> VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on th=
e
>>>>>>>> architecture) the MAP_STACK flag does exactly what people would e=
xpect on
>>>>>>>> all platforms.
>>>>>>>>
>>>>>>>> This change should have no negative side-effect, as all code whic=
h
>>>>>>>> used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
>>>>>>>>
>>>>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>>>>>
>>>>>>>> diff --git a/include/linux/mman.h b/include/linux/mman.h
>>>>>>>> index bcb201ab7a41..66bc72a0cb19 100644
>>>>>>>> --- a/include/linux/mman.h
>>>>>>>> +++ b/include/linux/mman.h
>>>>>>>> @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
>>>>>>>>          return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOW=
N ) |
>>>>>>>>                 _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED  =
  ) |
>>>>>>>>                 _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC    =
  ) |
>>>>>>>> +            _calc_vm_trans(flags, MAP_STACK,      VM_STACK     )=
 |
>>>>>>>
>>>>>>> Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this wil=
l
>>>>>>> change the user interface to create a vma that will grow.  I'm not
>>>>>>> entirely sure this is okay?
>>>>>>
>>>>>> AFAICT, I don't see this is a problem. Currently huge page also ski=
ps
>>>>>> the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
>>>>>> __thp_vma_allowable_orders() returns 0 if the vma is a temporary
>>>>>> stack.
>>>>>
>>>>> If someone is using MAP_STACK to avoid having a huge page, they will
>>>>> also get a mapping that grows - which is different than what happens
>>>>> today.
>>>>>
>>>>> I'm not saying that's right, but someone could be abusing the existi=
ng
>>>>> flag and this will change the behaviour.
>>>>
>>>> Wouldn't a plain mmap() followed by madvise(MADV_NOHUGEPAGE) do exact=
ly that?
>>>> Why abusing MAP_STACK for that?
>>>
>>> I can think of two answers:
>>> 1. An error that has worked without issues so far
>>> 2. One less system call
>>>
>>> I'm not saying this really is a blocker, but the change is not without
>>> risk as it does change behaviour the user could see.
>>>
>>> Interestingly enough, the man page is incorrect as it is written becau=
se
>>> the flag is not strictly a no-op; it ensures no huge pages.  So the
>>> feature of applying VM_NOHUGEPAGE with the use of MAP_STACK is not
>>> documented today.
>>
>> Yes.
>>
>>> What happens to call that use the mmap(MAP_GROWSDOWN | MAP_STACK) on
>>> parisc today?
>>
>> Today, without my patch, on parisc the area is then flagged VM_GROWSDOW=
N only.
>> In that case, stack expansion will not work, as it checks for VM_GROWSU=
P.
>>
>>> How does this change with your VM_STACK change?  Wouldn't this result
>>> in failed mappings?
>>> VM_GROWSDOWN | VM_GROWSUP would fail in do_mmap(), and these would be>=
 set if you map MAP_STACK to VM_STACK which is defined as VM_GROWSUP?
>>
>> Right, with my change, the area will be tagged VM_GROWSUP and VM_GROWSD=
OWN.
>> Due to VM_GROWSUP stack expansion works.
>> The mapping doesn't fail in do_mmap(), because stacks are not file-mapp=
ed
>> or shared or droppable. They should be mapped with MAP_PRIVATE, right?
>
> Oh my, yes.  So now you will have a stack that can expand in either
> direction, but it's okay because one direction isn't checked.  I sure
> hope the rest of the code is correctly #ifdef'ed for this.

Only one direction will be handled (depending on the architecture),
even if both (VM_GROWSUP and VM_GROWSDOWN) are set.
So it shouldn't be a problem to have both directions set.

>> Another option is to introduce an alias, e.g.:
>> #define MAP_STACK_EXPANDABLE	MAP_GROWSDOWN
>> and then
>
> I don't like either of these options.
>
> I guess you could also detect the MAP_STACK and MAP_GROWSDOWN and change
> the flags for parisc, which I also don't like, but since parisc is the
> only arch using this it's hard to justify a change that may cause issues
> in other archs.

Well, I still don't actually see real issues with my proposal.
That's why I proposed to change MAP_STACK generally.
Just adapting it for parisc was my initial approach which I sent
to the parisc mailing list prior to this patch:
https://patchwork.kernel.org/project/linux-parisc/patch/Zt3yJUiczUBmEC3a@p=
100/

I'd like to wait for some possible further feedback.
In the end I might end up just changing it for parisc.

> A quick grep shows we set VM_STACK_DEFAULT_FLAGS in x86 and powerpc,
> which could affect what happens here with your change.  I am concerned
> about the bleeding of other flags through this change.

Shouldn't be a problem. The VM_STACK in VM_STACK_FLAGS is already VM_GROWS=
UP
or VM_GROWSDOWN.
include/linux/mm.h:#define VM_STACK_FLAGS       (VM_STACK | VM_STACK_DEFAU=
LT_FLAGS | VM_ACCOUNT)

Helge


