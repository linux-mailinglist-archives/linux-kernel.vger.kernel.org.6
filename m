Return-Path: <linux-kernel+bounces-325831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE313975EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7D01F23DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774543B784;
	Thu, 12 Sep 2024 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="JHxWNUTP"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D336FBF;
	Thu, 12 Sep 2024 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726107013; cv=none; b=IDuOGIj74KgE6B5zbf0VBVgGdYOGKrkTvx8pelFl3+4qcDFO6LZVphWNi5Sk0bca0/RHjN9lvhlF3SmA7hVbSOCIQY23HhCrXiqFXe5Chg/zXvsRXTDYGiwT0NZFh8kH6pj5GV/LSfhY7NWJPkSoEDUxOG0GUZsF1M1/o5XU5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726107013; c=relaxed/simple;
	bh=lJ66SGLdrvPqIf8Vi0WBZXXhKs8OzeHqt0IHKondeds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oC7Z3JZlmsjeVWo/Mpe9lLadMcNwhq3K3CnGSvyF0ypyS3vWQCgD9ucxEUmC5usTrvB+RGPtCMrxQg76N27Du0rOc5klkSgm9dDc4wQ196WmimJwiwDrKcfQ/VU88hyvb1Xz7OkJVOVkRknD/eoR1c/nw1OcseeAn02mYWXW79Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=JHxWNUTP; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726106995; x=1726711795; i=deller@gmx.de;
	bh=ZWeZAbYt0Thm33wY4VY9KYfYNYPXYf8nAkx46NDfn80=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JHxWNUTPpXtrTxLSRGDZE2fTIKvuRw3VW09xMZYCoN2nZAGuMFZucimVKrD7p9nE
	 YonxhCYR2qmsB3ORPgRyzkqzDOvxd96GBwnxBvT8v/YVz0ZAnJaKd4IKBhrcc604C
	 BJLf/7FvGbolLg+FL2zc5ZvGmL7BbJvTP6aWffkmvtx21JqHpdWKOBLWw67qZOIZX
	 B6bdJNQAEyZh6LYcwStuHTQfqPOiIwRTI5p7Svj5sfJFgX8qhMqWy5vMy/B/v99BF
	 wstIK5oS1txdbQrEJDnUkx8rzbpgn976Jum2aGBS2596ARoDzgVZrvkqvE7jIHwBA
	 JHLKIdsd/DG5unJZCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzBj-1sXAqw0Ivh-00Sbki; Thu, 12
 Sep 2024 04:09:55 +0200
Message-ID: <c226a38a-3612-4949-9da7-8d42f8636b47@gmx.de>
Date: Thu, 12 Sep 2024 04:09:53 +0200
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
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <x2d4kyyeclp5fgeug2l3bjalp773ozgkl5vr5o7dpqcbopampg@5a3x2cr456qp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zysq1m0TRlLp+0WjAOa05HKUhrrYy6RqiAe+zWgfcoMoPf8AWi/
 4xCxGksj5i5R8e5IzUVq+YbvYtfPEBjYX+/5YcHhnldktjKHRGYeyf+/2R6DrafYcmWg3oc
 AuJLvuQnTIwUKE6MZXB9ybxCgPBiTJOO8ELKYHNqDnkhpsr9oV7KFjFpdhWDp9q27EolOak
 YTxCGEEHJ1Y50POhVmSQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VodjKea71YY=;as7RnIUlDjj2hM3ssJZ2tUOjOve
 V05GOmJNa/smGnON7ZuAuGymFO4MDpHoFd6JAOn0Wm7ABTMr2SFMOqXz1oVI0kJPYqszEaSEq
 ngF+rvNqPIT+uA4I3+4TnHYbFsnyU4FDyflrjIpzxRQWXCDKqC4k0oDXLl/u57knr0ksqWNCq
 tjoKybc3W1eyvTkFmvpVrrI3o8EKdn0ht08jbv432/70Ogl2/rZq9AFsPAbuKfMcGAkwt0WUU
 ScwEhxKc2f5sRpOmLL8yrFfpW6Rc9m6EaxR6bDVsqwqMUQWbct0yOMPV2NDHyxqgzBbbF3G9A
 AjefJhONdYFIp6iFfh2sm1kTvj9Fq4kdwBZJE4OCBqznJ3CXl/q4edSMk/Ft4xPmZb/W660Q8
 Ct1emBPOiwEVpe2kj85Nfz84kqv13axqXsV+HCVgEgBVYwLSpglNfmZJmG8hJcZKawXMmQdwB
 SKboRqTlIMznCmkW5JpoW0iRi2d/+NDyZTaflzM3wlPBoz+UlPlE3WwKgv2n4xQlqgeB47lDH
 tjIqwBpjkymDt3TK5UrmeKvVFnII/AEE8dLfoQh/t90E+lKl8+iK3puezoKY5llYDlBjLL51d
 VaoeteDLgR3UpT6b/I0UikFyXJgsohiOJi8psu4tMcik+RRv9pmLU6E448UyD558RW1mDN6zr
 oRcbduGpaypK6Cv71gqoxBNFDS2lCt+eZsuTVjv2l/6cStgzoC3wsV8Av3+Jdx55mOOHlQlyO
 zBqpB3mVZ9lTLush6+wgg8wAqw8DN+N0IWqLp4Y/mv827v4MwbpKhiXQXy+5TlTlGrqIzn1nW
 U9/r69hGCR9vfnZ7WWDC3nRQ==

On 9/12/24 03:32, Liam R. Howlett wrote:
> * Helge Deller <deller@gmx.de> [240911 20:51]:
>> On 9/12/24 01:05, Liam R. Howlett wrote:
>>> * Yang Shi <shy828301@gmail.com> [240911 18:16]:
>>>> On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
>>>> <Liam.Howlett@oracle.com> wrote:
>>>>>
>>>>> * Helge Deller <deller@kernel.org> [240911 15:20]:
>>>>>> This is a RFC to change the behaviour of mmap(MAP_STACK) to be
>>>>>> sufficient to map memory for usage as stack on all architectures.
>>>>>> Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDOWN
>>>>>> has to be used.
>>>>>> To clarify, here is the relevant info from the mmap() man page:
>>>>>>
>>>>>> MAP_GROWSDOWN
>>>>>>      This flag is used for stacks. It indicates to the kernel virtu=
al
>>>>>>      memory system that the mapping should extend downward in memor=
y.  The
>>>>>>      return address is one page lower than the memory area that is
>>>>>>      actually created in the process's virtual address space.  Touc=
hing an
>>>>>>      address in the "guard" page below the mapping will cause the m=
apping
>>>>>>      to grow by a page. This growth can be repeated until the mappi=
ng
>>>>>>      grows to within a page of the high end of the next lower mappi=
ng,
>>>>>>      at which point touching the "guard" page will result in a SIGS=
EGV
>>>>>>      signal.
>>>>>>
>>>>>> MAP_STACK (since Linux 2.6.27)
>>>>>>      Allocate the mapping at an address suitable for a process or t=
hread
>>>>>>      stack.
>>>>>>
>>>>>>      This flag is currently a no-op on Linux. However, by employing=
 this
>>>>>>      flag, applications can ensure that they transparently obtain s=
upport
>>>>>>      if the flag is implemented in the future. Thus, it is used in =
the
>>>>>>      glibc threading implementation to allow for the fact that
>>>>>>      some architectures may (later) require special treatment for
>>>>>>      stack allocations. A further reason to employ this flag is
>>>>>>      portability: MAP_STACK exists (and has an effect) on some
>>>>>>      other systems (e.g., some of the BSDs).
>>>>>>
>>>>>> The reason to suggest this change is, that on the parisc architectu=
re the
>>>>>> stack grows upwards. As such, using solely the MAP_GROWSDOWN flag w=
ill not
>>>>>> work. Note that there exists no MAP_GROWSUP flag.
>>>>>> By changing the behaviour of MAP_STACK to mark the memory area with=
 the
>>>>>> VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on the
>>>>>> architecture) the MAP_STACK flag does exactly what people would exp=
ect on
>>>>>> all platforms.
>>>>>>
>>>>>> This change should have no negative side-effect, as all code which
>>>>>> used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
>>>>>>
>>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>>>
>>>>>> diff --git a/include/linux/mman.h b/include/linux/mman.h
>>>>>> index bcb201ab7a41..66bc72a0cb19 100644
>>>>>> --- a/include/linux/mman.h
>>>>>> +++ b/include/linux/mman.h
>>>>>> @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
>>>>>>         return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN )=
 |
>>>>>>                _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    )=
 |
>>>>>>                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      )=
 |
>>>>>> +            _calc_vm_trans(flags, MAP_STACK,      VM_STACK     ) |
>>>>>
>>>>> Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this will
>>>>> change the user interface to create a vma that will grow.  I'm not
>>>>> entirely sure this is okay?
>>>>
>>>> AFAICT, I don't see this is a problem. Currently huge page also skips
>>>> the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
>>>> __thp_vma_allowable_orders() returns 0 if the vma is a temporary
>>>> stack.
>>>
>>> If someone is using MAP_STACK to avoid having a huge page, they will
>>> also get a mapping that grows - which is different than what happens
>>> today.
>>>
>>> I'm not saying that's right, but someone could be abusing the existing
>>> flag and this will change the behaviour.
>>
>> Wouldn't a plain mmap() followed by madvise(MADV_NOHUGEPAGE) do exactly=
 that?
>> Why abusing MAP_STACK for that?
>
> I can think of two answers:
> 1. An error that has worked without issues so far
> 2. One less system call
>
> I'm not saying this really is a blocker, but the change is not without
> risk as it does change behaviour the user could see.
>
> Interestingly enough, the man page is incorrect as it is written because
> the flag is not strictly a no-op; it ensures no huge pages.  So the
> feature of applying VM_NOHUGEPAGE with the use of MAP_STACK is not
> documented today.

Yes.

> What happens to call that use the mmap(MAP_GROWSDOWN | MAP_STACK) on
> parisc today?

Today, without my patch, on parisc the area is then flagged VM_GROWSDOWN o=
nly.
In that case, stack expansion will not work, as it checks for VM_GROWSUP.

> How does this change with your VM_STACK change?  Wouldn't this result
> in failed mappings?
> VM_GROWSDOWN | VM_GROWSUP would fail in do_mmap(), and these would be> s=
et if you map MAP_STACK to VM_STACK which is defined as VM_GROWSUP?

Right, with my change, the area will be tagged VM_GROWSUP and VM_GROWSDOWN=
.
Due to VM_GROWSUP stack expansion works.
The mapping doesn't fail in do_mmap(), because stacks are not file-mapped
or shared or droppable. They should be mapped with MAP_PRIVATE, right?


Another option is to introduce an alias, e.g.:
#define MAP_STACK_EXPANDABLE	MAP_GROWSDOWN
and then
diff --git a/include/linux/mman.h b/include/linux/mman.h
index bcb201ab7a41..6a7ec3e0078a 100644
=2D-- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -153,7 +153,7 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pk=
ey)
  static inline unsigned long
  calc_vm_flag_bits(unsigned long flags)
  {
-       return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
+       return _calc_vm_trans(flags, MAP_STACK_EXPANDABLE,  VM_STACK ) |
                _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
                _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |

This simply uses the existing MAP_GROWSDOWN flag to mark a stack,
is independend on the stack growth direction and is fully backwards
compatible to existing behaviour.

I prefer my initial proposal to change MAP_STACK though, as it's
simpler and clearer.

Helge

