Return-Path: <linux-kernel+bounces-330028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66999798A2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 22:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3794F1F21C09
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5151C9DE5;
	Sun, 15 Sep 2024 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="LF72WIN2"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27860347C7;
	Sun, 15 Sep 2024 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726430694; cv=none; b=GTgdooxSgjFK/25BLdwk7ldxh7GVXF/9rxd1gY9R7LS/+WfrESzdFou4HXWaIc+Ips/I8yVA0W3yRicj9iNotvAuQj4GS+AhrsauH+fQtJaq1nneszTdMCpxuszNEwVuQU+v9SDCAlo7w7wIR6ok+2bsw8wJQhrZh1OXtue6bWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726430694; c=relaxed/simple;
	bh=GNMq1fIUPFXIXBXqBdvEWgpBmEvEMydt/X9WcLs6v14=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=q1ntT4PDVRcHP9+5KMnibu3WGuAoSZy+8dMy90lJSCp1Wg4eyfqG24aF21FIBZjdzb93LgcgPNNPIvk39YAZGeBa3pVgF5dZVSlxg37a1R0q+UpVbk7pNpY9KF6jpHq4QwRX50onybni6EKbxorUd0anQ2aMyUvMEFuLdxSKTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=LF72WIN2; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726430677; x=1727035477; i=deller@gmx.de;
	bh=GNMq1fIUPFXIXBXqBdvEWgpBmEvEMydt/X9WcLs6v14=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LF72WIN2brqvipaDxzGbuz07P3pmV97gc3BWzJdr3MUEfDLsNcBiSbHziWU/en3R
	 ckKecKvQyK4ZW5Sivd8uhYAKGgkRrbj4GcdoLdc8eWMFE/1lTlyxyp19BVlAMiUvm
	 wc/OFMn3+KJSLK8C133OLmCIZQvJova8Xo0QKXpMl5phoGgcVjKAsGTBWs1NuTrwv
	 50OxnO/GrFtfmHeQNYw0YYf72zLiHwz5mWPvY17TuK46m4qDxcLaIVn/kHeJFyxfF
	 HjUNofUafMXjh1xMtKMOjSHi8zxTvQrkP0LMkoFNspAIHnXWvlJWe7HrvL6cRLXcZ
	 hLHBDJkb5Y3RFb3Ulw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1s55KA0xvX-00yNVd; Sun, 15
 Sep 2024 22:04:37 +0200
Message-ID: <179bfa57-76d0-4c2e-ab2c-4f9856cf488a@gmx.de>
Date: Sun, 15 Sep 2024 22:04:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable
 stack
From: Helge Deller <deller@gmx.de>
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
 <87e019fe-e137-49c9-a414-8f4f373fc4b6@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <87e019fe-e137-49c9-a414-8f4f373fc4b6@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tQ4uYdt/py5julWeQIVuntSsDxbx3+Doondisvv60Ky69Tr9KYZ
 5Fospxxxt5VT4WjfWe3LTvKi8q6iS6GzwmPncOWUnBDQ/kZJYtpLPp2Bux50IiYW5JZsqaG
 JIqP/zH9wzCm5lF7NzsGM//YKp7Vklkispobu3kRfVn5K/t/SMKcK4q5psR2SMZzixXcs3z
 4z2vxg7dXGlOroZJubT0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4/wuwQll2Fw=;w0GgKeL9VGT8XdgG1x9MDEpCHyD
 cRZInXFxqTVOuuyAz/Q9YYsm1rxaE/eDHhvLoIxWDDH7edw3D9lEz+Y3I/zpZU3/Yo7XEuFEY
 Lny5QirJBRFUjquvCN3LHdlPZFtlrkpRngRMd/McYSHdwHt5nnrP8yBunULCqE7hMVGE8YJnY
 o0WvUGITe/bnDFZ+nUElGCga52rikkrFo81Vswv7VKM34vY1agSzcTutdhm9kIQOFhEiRJE4Z
 Cd12oUOWTA0USMXSzDQKYUzMQZ1rQ4AVZRISgn1XOyK1TFRvBa+sVYtAJdgRUkUsBEvkRTBwY
 fA8EtUMxra2UuqavCccNCI6lszq7IU9cUClO//oQcW9xlBJcBjz6MQYwDwsYzFSSvxnDQf1rl
 taDZ19dU9uKw+A3OqgNjMtJQ9iuMlryrbomfDMAnH/3RZqBiy+RG9KoxXCTfpZeGN0EDfEcFF
 ugrDy5YL0516rT7s4LBEVJ3WJQa4RPDqDsVC+UHR4Wsn+wUKy4NPBv6/ParEP1fqAa8iHSHqD
 6o2T3VWZnAT3tw0IVZjSU/Qa9jfinwNkpw3uwdCkFL87Pjj3M0TG94gqDOb7N4NYghXbJ/Dwr
 SsXlftKbZKVMCgIDHS1EELDncQjQMENNlBytpvmjjSLDqpqSs6L1fdxsPUY//Z8wxv4XFhkL/
 0Cxc4Q1kttlooj/ZnUZ5cFW9600HHoJZpOPRKNwv4xR4xB6f0b1KMvk0R7ublEE+YJu4K3dh2
 DIsDcZ8GahGcrTOyMcsdMWMbvS7axtgiRXCFWysNs7Djs+Mh6o+ne37HwSuZIkNyrtfy1SHqQ
 q3CpWRCMI+pckQ2v6swZlgNg==

On 9/12/24 19:37, Helge Deller wrote:
> On 9/12/24 17:43, Liam R. Howlett wrote:
>> * Helge Deller <deller@gmx.de> [240911 22:10]:
>>> On 9/12/24 03:32, Liam R. Howlett wrote:
>>>> * Helge Deller <deller@gmx.de> [240911 20:51]:
>>>>> On 9/12/24 01:05, Liam R. Howlett wrote:
>>>>>> * Yang Shi <shy828301@gmail.com> [240911 18:16]:
>>>>>>> On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
>>>>>>> <Liam.Howlett@oracle.com> wrote:
>>>>>>>>
>>>>>>>> * Helge Deller <deller@kernel.org> [240911 15:20]:
>>>>>>>>> This is a RFC to change the behaviour of mmap(MAP_STACK) to be
>>>>>>>>> sufficient to map memory for usage as stack on all architectures=
.
>>>>>>>>> Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDO=
WN
>>>>>>>>> has to be used.
>>>>>>>>> To clarify, here is the relevant info from the mmap() man page:
>>>>>>>>>
>>>>>>>>> MAP_GROWSDOWN
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This flag is used for stacks. It =
indicates to the kernel virtual
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory system that the mapping sh=
ould extend downward in memory.=C2=A0 The
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return address is one page lower =
than the memory area that is
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 actually created in the process's=
 virtual address space.=C2=A0 Touching an
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 address in the "guard" page below=
 the mapping will cause the mapping
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to grow by a page. This growth ca=
n be repeated until the mapping
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grows to within a page of the hig=
h end of the next lower mapping,
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at which point touching the "guar=
d" page will result in a SIGSEGV
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signal.
>>>>>>>>>
>>>>>>>>> MAP_STACK (since Linux 2.6.27)
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Allocate the mapping at an addres=
s suitable for a process or thread
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stack.
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This flag is currently a no-op on=
 Linux. However, by employing this
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flag, applications can ensure tha=
t they transparently obtain support
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if the flag is implemented in the=
 future. Thus, it is used in the
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 glibc threading implementation to=
 allow for the fact that
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 some architectures may (later) re=
quire special treatment for
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stack allocations. A further reas=
on to employ this flag is
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 portability: MAP_STACK exists (an=
d has an effect) on some
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other systems (e.g., some of the =
BSDs).
>>>>>>>>>
>>>>>>>>> The reason to suggest this change is, that on the parisc archite=
cture the
>>>>>>>>> stack grows upwards. As such, using solely the MAP_GROWSDOWN fla=
g will not
>>>>>>>>> work. Note that there exists no MAP_GROWSUP flag.
>>>>>>>>> By changing the behaviour of MAP_STACK to mark the memory area w=
ith the
>>>>>>>>> VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on t=
he
>>>>>>>>> architecture) the MAP_STACK flag does exactly what people would =
expect on
>>>>>>>>> all platforms.
>>>>>>>>>
>>>>>>>>> This change should have no negative side-effect, as all code whi=
ch
>>>>>>>>> used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>>>>>>
>>>>>>>>> diff --git a/include/linux/mman.h b/include/linux/mman.h
>>>>>>>>> index bcb201ab7a41..66bc72a0cb19 100644
>>>>>>>>> --- a/include/linux/mman.h
>>>>>>>>> +++ b/include/linux/mman.h
>>>>>>>>> @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return _calc_vm=
_trans(flags, MAP_GROWSDOWN,=C2=A0 VM_GROWSDOWN ) |
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 _calc_vm_trans(flags, MAP_LOCKED,=C2=A0=C2=A0=
=C2=A0=C2=A0 VM_LOCKED=C2=A0=C2=A0=C2=A0 ) |
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 _calc_vm_trans(flags, MAP_SYNC,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 VM_SYNC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ) |
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 _calc_vm_trans(flags, MAP_STACK,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VM_STAC=
K=C2=A0=C2=A0=C2=A0=C2=A0 ) |
>>>>>>>>
>>>>>>>> Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this wi=
ll
>>>>>>>> change the user interface to create a vma that will grow.=C2=A0 I=
'm not
>>>>>>>> entirely sure this is okay?
>>>>>>>
>>>>>>> AFAICT, I don't see this is a problem. Currently huge page also sk=
ips
>>>>>>> the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
>>>>>>> __thp_vma_allowable_orders() returns 0 if the vma is a temporary
>>>>>>> stack.
>>>>>>
>>>>>> If someone is using MAP_STACK to avoid having a huge page, they wil=
l
>>>>>> also get a mapping that grows - which is different than what happen=
s
>>>>>> today.
>>>>>>
>>>>>> I'm not saying that's right, but someone could be abusing the exist=
ing
>>>>>> flag and this will change the behaviour.
>>>>>
>>>>> Wouldn't a plain mmap() followed by madvise(MADV_NOHUGEPAGE) do exac=
tly that?
>>>>> Why abusing MAP_STACK for that?
>>>>
>>>> I can think of two answers:
>>>> 1. An error that has worked without issues so far
>>>> 2. One less system call
>>>>
>>>> I'm not saying this really is a blocker, but the change is not withou=
t
>>>> risk as it does change behaviour the user could see.
>>>>
>>>> Interestingly enough, the man page is incorrect as it is written beca=
use
>>>> the flag is not strictly a no-op; it ensures no huge pages.=C2=A0 So =
the
>>>> feature of applying VM_NOHUGEPAGE with the use of MAP_STACK is not
>>>> documented today.
>>>
>>> Yes.
>>>
>>>> What happens to call that use the mmap(MAP_GROWSDOWN | MAP_STACK) on
>>>> parisc today?
>>>
>>> Today, without my patch, on parisc the area is then flagged VM_GROWSDO=
WN only.
>>> In that case, stack expansion will not work, as it checks for VM_GROWS=
UP.
>>>
>>>> How does this change with your VM_STACK change?=C2=A0 Wouldn't this r=
esult
>>>> in failed mappings?
>>>> VM_GROWSDOWN | VM_GROWSUP would fail in do_mmap(), and these would be=
> set if you map MAP_STACK to VM_STACK which is defined as VM_GROWSUP?
>>>
>>> Right, with my change, the area will be tagged VM_GROWSUP and VM_GROWS=
DOWN.
>>> Due to VM_GROWSUP stack expansion works.
>>> The mapping doesn't fail in do_mmap(), because stacks are not file-map=
ped
>>> or shared or droppable. They should be mapped with MAP_PRIVATE, right?
>>
>> Oh my, yes.=C2=A0 So now you will have a stack that can expand in eithe=
r
>> direction, but it's okay because one direction isn't checked.=C2=A0 I s=
ure
>> hope the rest of the code is correctly #ifdef'ed for this.
>
> Only one direction will be handled (depending on the architecture),
> even if both (VM_GROWSUP and VM_GROWSDOWN) are set.
> So it shouldn't be a problem to have both directions set.
>
>>> Another option is to introduce an alias, e.g.:
>>> #define MAP_STACK_EXPANDABLE=C2=A0=C2=A0=C2=A0 MAP_GROWSDOWN
>>> and then
>>
>> I don't like either of these options.
>>
>> I guess you could also detect the MAP_STACK and MAP_GROWSDOWN and chang=
e
>> the flags for parisc, which I also don't like, but since parisc is the
>> only arch using this it's hard to justify a change that may cause issue=
s
>> in other archs.
>
> Well, I still don't actually see real issues with my proposal.
> That's why I proposed to change MAP_STACK generally.
> Just adapting it for parisc was my initial approach which I sent
> to the parisc mailing list prior to this patch:
> https://patchwork.kernel.org/project/linux-parisc/patch/Zt3yJUiczUBmEC3a=
@p100/
>
> I'd like to wait for some possible further feedback.
> In the end I might end up just changing it for parisc.

No further input, so I will apply a patch which changes the default behavi=
or
on parisc only. Other architectures will stay unchanged.

Thanks!
Helge

