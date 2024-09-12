Return-Path: <linux-kernel+bounces-325820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A256B975EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C80AB21B42
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730A4437C;
	Thu, 12 Sep 2024 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="qjO3GeyN"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B63A267;
	Thu, 12 Sep 2024 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726105553; cv=none; b=E8bzpmB09C5t/5eW4oNTk8CippipSG9RRZ12DiXmoeENNxm2xHpl4A+ZJJeymU6NRHy6tY7I/CeogU/zatERWggQ1RBQ75P0u2EQmwN1ElskNdKa/v6A1XP7kIV4JPCIF7SNPRHVTfF+ORlizkNthhT5o7ku7uk7mhMRtGXITdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726105553; c=relaxed/simple;
	bh=2QSGq7Hd1MMLyuiC5BTYhqH45996ucGyyGvy2UiO6+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0+QaxMnJiU3p46kXR37pSKwNWSNfx87l1b0dLHFQqqEWTgzdHUdoBd75wWrIfHIxcrARrWEVesIBQUH2Iqif5+ni/SnPqkw/YNkO+VibY/DdQ0Q5/vyd4xfpLqy2Y3+Wnk0wvxHeiPo8WAhnwaZhUpHULPQLsKAIHK6So8C8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=qjO3GeyN; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726105535; x=1726710335; i=deller@gmx.de;
	bh=9S8ZYir8xrchk1sw1I6nlFiM6OfsAfPDqkCmx/PX2JQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qjO3GeyNRw8HljolMA/yl7sWFDBBbdDgSC3aUmelZJ+ZeiLXKfJuVejybrxmJGfF
	 EvsOMnjB1brxT9/AQuey61bsWEvxd5Ey9HoikBnu3rNdc6M8Bp/LTbj7HK8RxGw1A
	 1TaLE1zjl8TP4p1GP6tgtOlt6dWk58CbMpnutjaK8IAgxQPac9IqtOg7rXHGa6v8y
	 R7MnSuw8Eks65CqqiLSRPJ2NONwUF6HvASfQ0MWBIaeEvikT9nltAF59DGVhbvdfD
	 WgRjPY4PbLUGHRIQL5S1LDXfW+bWoyaD9X7QXdYI8VVFKXFnwzGVMdX/1o3MAuRQv
	 KsppuEclNv6ak54G7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRfv-1sHz2E16d7-00iCe3; Thu, 12
 Sep 2024 03:45:35 +0200
Message-ID: <c4d0805b-127b-436d-900b-4742ddbc1d15@gmx.de>
Date: Thu, 12 Sep 2024 03:45:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable
 stack
To: Yang Shi <shy828301@gmail.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Helge Deller <deller@kernel.org>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-parisc@vger.kernel.org
References: <ZuHtb43Ar21ZptNz@p100>
 <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
 <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com>
 <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d>
 <95c4efe9-e92a-46fe-bf41-9141e125332d@gmx.de>
 <CAHbLzkotBTOf0OrPSN4o=UEvRXjT=L=NSZn_=FBA6nG51ppjYg@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAHbLzkotBTOf0OrPSN4o=UEvRXjT=L=NSZn_=FBA6nG51ppjYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B/Ce3BWOxRWAzlUCr6qoViDtODHFPqm9ZzOjouNnMpYvXYkqXlG
 aQw4KdX//Y8/TobOETNoR7ZhJ42mCfJxUuS/RsTsjh1ISoLbC47LU0p5dDGcaz0XnztIh+G
 emEVb08RRtPRS/YVFpBiliNd2q34aED3Q4wtjLYNvjGU8vVTtdvAfBAiZFdNmUk2zBIHY3x
 GH5We/fXz3YNs0FTFxoxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6NRbv/9xRcM=;3n4A+SmKFN6NsO7EqZOWEj1Qv0F
 QdbXBS5tDYsik2Lr5MXFIpcm1ZhGyypNu1U83bFOxmBDEpAklYFW6YLwJmkcXGv7skHaivLtl
 l+NzJmgIhvSK+ZReX9ITRQ1Ty2taCwlS1YR3Q4qfAfhJe6ARWlVuntfpEZoIfhb+iKhPJVzxQ
 rXyyt+gBsTuRPa3YlO5C3jMjBb34AtEv41rpT1DSIWiPgTIeDlxKPPX7cU8X0FoIr7IXYeDwj
 6LP3GPov/rknsmqj0IDqIlCw13YCbYASRWfGrFoQ06EBYUsqulZdTssZ0kHtk2jqB9YQznZsX
 oI/3TkzNGvH5OXBRxqvBJEw6HtlOrCjUr7Py+9+9mUyUp7HTfy0vuE6PEbu5w/3PpZnxg6oan
 VFzi2UOYIMkAuDL86jgTMR5SIVn3oR6EHsFrJo0KAubaASsDIrUR3iq9ho61Ijq/FfJu1WdyP
 4KBVDosNg0ZS9RtLdar08+5KWkB3bNkWJikSMa02LNmlB3eAEsHWQMvf0ZKj8igEi4L0DSZgi
 plvQ09GHOMAwwffax7rf6qqJcwhCP9SqDbNnbkY16ywOqK8NtMEzJAUxP3c9KK3KRypakssPB
 nkgjNcHaCPxMkLCmgqdX0IMbBBQqrooxkWOiw4yZgwofzu+Q6B++UP1uNFWy6r/9xJdPhtPKG
 Q/M7aB6aTu4si6slQlMUFK4nMqtvv2jNNIDCwPIpaU//gDArsVr22oaErasIk4NDZwE77k1XV
 C/jU6xLGTA0HFARQxhJAAOhsiwo4qbZjcy2VzA+68iCeHhzdSPbhcgGXrOcloaD6ZWaDycUqO
 p+WhxhD5zIIbHJM0EO+1xw0Q==

On 9/12/24 03:08, Yang Shi wrote:
> On Wed, Sep 11, 2024 at 5:50=E2=80=AFPM Helge Deller <deller@gmx.de> wro=
te:
>>
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
> Different sources and reports showed having huge pages for stack
> mapping hurts performance. A lot of applications, for example, pthread
> lib, allocate stack with MAP_STACK and they don't call MADV_NOHUGEPAGE
> on stack mapping.

That's true, and my patch does not change the behaviour wrt huge pages.
Using MAP_STACK still tags the area VM_NOHUGEPAGE. See below...


>>>>> That is mmap(MAP_STACK) would set VM_NOHUGEPAGE right now, with this
>>>>> change you'd get VM_NOHUGEPAGE | VM_GROWS<something>
>>>>>
>>>>>>                _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE)=
 |
>>>>>>                arch_calc_vm_flag_bits(flags);
>>>>>>    }
>>


