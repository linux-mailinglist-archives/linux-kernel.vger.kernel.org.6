Return-Path: <linux-kernel+bounces-325780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E50975E24
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6893C1C21859
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903638C07;
	Thu, 12 Sep 2024 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="a6G5N25I"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23923370;
	Thu, 12 Sep 2024 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102276; cv=none; b=CBXs/KUtPnyzdIGLBiaaS4zQlbzHZM6+G1jEVzWBpfFkSaktintLonk7ZCM416X0AGPDd6FXj8UFwFpzd/b7bqnQ/RS4rnfnlCPht7xOLf3PympglaX8wSY+iU4VaoY8FPoYVVAzTlaJ8K/nIK32DuSOn1X2TmquZh4n7U0e25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102276; c=relaxed/simple;
	bh=ZL0Kxz1HmFkqjxp4kUm2LIIcBpooZoOgcr6fXcTLXoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cxmYEwWGKQKCyOghT8/xGHVsAFmGFqVyNRG7KRgDZhygtUC+Lyx+tn8+2QjP893KcC93ounhT2ZxHJDDM/73b3H9ScK29KRPM22qxde4U1/QV7ocsJ6dnTIYmnkOEh7bfzw/8e+gWa4duFLfoErvxOrOY5CkYqlGf6YwAL7UXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=a6G5N25I; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726102256; x=1726707056; i=deller@gmx.de;
	bh=vTsMmWO5TzcvTsUSHDgyJDItC//7N8D5FvHORSvliFg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=a6G5N25IhgBfVduFIKgvXlsuSfYpxoHQoAq9LcjWtT/GTkBh/4esd7Fap/fav//E
	 ok1CJNAUaXX2Ag5oPOu1sX+TtQFFgDs1NRfrFCgCPaZ2lhqzswtIGyzWCKfrhrOSf
	 tHW10ewDw+9dDe9kUbHOPEjhnVBXYhy0RNGHj+XAddxxkves+WNh0awEUl/R8Pkts
	 gmtHp47ipzNKQFvo+QtqDN9jX0D4+ZZJjGXgYNTmFEJgtgIpUsloX8fK42cvcww/d
	 RRSewRmLKUz7qS/NIN3q2HKbLqrMGg7uVFTy8emQMQn1kVZ/WO/p/3FeYVs9lKQfF
	 0yh1VJwn8FSSetGsmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1sHP1X2kWZ-00cQnI; Thu, 12
 Sep 2024 02:50:56 +0200
Message-ID: <95c4efe9-e92a-46fe-bf41-9141e125332d@gmx.de>
Date: Thu, 12 Sep 2024 02:50:55 +0200
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
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g1S3WRyddOfdBcOTmeFZkNybpWnIJZsP7lXMznSYT00cdJvoje4
 vYE2Se1qJc6jcuceKZPqbNOdEnqhjMUZovIVgnImdSrYxxGazWDukkBx0Wct1WVrtsxD3Xb
 qkJdMD3tF/wWprjLURGW+vcdHMxkScjVA9lqJTunhPAPLxohf3WW2C6o3NBk8yR/NTlnCmX
 mwH7AELlgZYtjwcAfbqdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:86rQisakXaA=;xgjhLDpeHuioAsBIgfGUml0x9O5
 w+wwoNSlgGQhlCOSWu30+n4BbyMEWVfuKdHmxm1d/AItbXSHE+JpGzkE/2ZyAoYaFnARh1Uz0
 zCpSkvINceRRnwxy7YFulNoZy+7FYND/6gQwbIDMWVkMIMVh3imC9vw3oGbx1xR6V/Z3OnLSQ
 cfIsOORIOQ64vh9XOcsDGsmOHaN9ezDyCV7v7XCoB68CHPRtBhQgya713KPOvQ5NCCuHyEAzQ
 SLVp/kWcdcOOP+ybvbdSJxaLTP5hLFR0zDE3q+OHSvFMbJ7ThAeqaN6klyGh8U24f10fgxagv
 4hHCgB7tBIVZTu9aG4yQPAts/wz9Zooc+UKYacKxyiOouYiUbbFlslVi+u2/YkmKa80fBXz5M
 mmQftDS+t7Us1W3Y5UVDc1By9ejmP3ORj+Q9/58hobB1w88xI+R9l41LlaTso+S+u0L3SFUml
 dr6qfFF5PvRAkP+5WrY3c9Rq1Hfx3hOIFOJ4XHyyG2uaaCnr2o1Y9prcjoVtLygJX8KnzB444
 AmposB7NUSSfNhB4SzyPLS7swVpuzsaYOa2RpVpr62/ePxovNFph4zg04zcj47jw4XMps0uSv
 2zBPJbP7jv/7vBLIFWmAx5VtxliThVAW00tB8l+8+Ds97tBhwbFgAJKHEHSZ3T7uy242DhNJg
 dfFMwAjr8fujpQQ3cKvI6s8MBo46kTNsw3FMzAyphh4KRBRGnR0PUM2PwAd7CbwOewrXsTza7
 6FUIivXcoFHjJU42BMFIc/o3xBC62ErjZ4xtPB2m0/sf2mN93TvwYCT2IwZmx1IgI1/xHbVhF
 Ib80bO0BcvJSkj6xzUfCNr7g==

On 9/12/24 01:05, Liam R. Howlett wrote:
> * Yang Shi <shy828301@gmail.com> [240911 18:16]:
>> On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
>> <Liam.Howlett@oracle.com> wrote:
>>>
>>> * Helge Deller <deller@kernel.org> [240911 15:20]:
>>>> This is a RFC to change the behaviour of mmap(MAP_STACK) to be
>>>> sufficient to map memory for usage as stack on all architectures.
>>>> Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDOWN
>>>> has to be used.
>>>> To clarify, here is the relevant info from the mmap() man page:
>>>>
>>>> MAP_GROWSDOWN
>>>>     This flag is used for stacks. It indicates to the kernel virtual
>>>>     memory system that the mapping should extend downward in memory. =
 The
>>>>     return address is one page lower than the memory area that is
>>>>     actually created in the process's virtual address space.  Touchin=
g an
>>>>     address in the "guard" page below the mapping will cause the mapp=
ing
>>>>     to grow by a page. This growth can be repeated until the mapping
>>>>     grows to within a page of the high end of the next lower mapping,
>>>>     at which point touching the "guard" page will result in a SIGSEGV
>>>>     signal.
>>>>
>>>> MAP_STACK (since Linux 2.6.27)
>>>>     Allocate the mapping at an address suitable for a process or thre=
ad
>>>>     stack.
>>>>
>>>>     This flag is currently a no-op on Linux. However, by employing th=
is
>>>>     flag, applications can ensure that they transparently obtain supp=
ort
>>>>     if the flag is implemented in the future. Thus, it is used in the
>>>>     glibc threading implementation to allow for the fact that
>>>>     some architectures may (later) require special treatment for
>>>>     stack allocations. A further reason to employ this flag is
>>>>     portability: MAP_STACK exists (and has an effect) on some
>>>>     other systems (e.g., some of the BSDs).
>>>>
>>>> The reason to suggest this change is, that on the parisc architecture=
 the
>>>> stack grows upwards. As such, using solely the MAP_GROWSDOWN flag wil=
l not
>>>> work. Note that there exists no MAP_GROWSUP flag.
>>>> By changing the behaviour of MAP_STACK to mark the memory area with t=
he
>>>> VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on the
>>>> architecture) the MAP_STACK flag does exactly what people would expec=
t on
>>>> all platforms.
>>>>
>>>> This change should have no negative side-effect, as all code which
>>>> used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
>>>>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>
>>>> diff --git a/include/linux/mman.h b/include/linux/mman.h
>>>> index bcb201ab7a41..66bc72a0cb19 100644
>>>> --- a/include/linux/mman.h
>>>> +++ b/include/linux/mman.h
>>>> @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
>>>>        return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>>>>               _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>>>>               _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
>>>> +            _calc_vm_trans(flags, MAP_STACK,      VM_STACK     ) |
>>>
>>> Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this will
>>> change the user interface to create a vma that will grow.  I'm not
>>> entirely sure this is okay?
>>
>> AFAICT, I don't see this is a problem. Currently huge page also skips
>> the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
>> __thp_vma_allowable_orders() returns 0 if the vma is a temporary
>> stack.
>
> If someone is using MAP_STACK to avoid having a huge page, they will
> also get a mapping that grows - which is different than what happens
> today.
>
> I'm not saying that's right, but someone could be abusing the existing
> flag and this will change the behaviour.

Wouldn't a plain mmap() followed by madvise(MADV_NOHUGEPAGE) do exactly th=
at?
Why abusing MAP_STACK for that?

Helge

>>> That is mmap(MAP_STACK) would set VM_NOHUGEPAGE right now, with this
>>> change you'd get VM_NOHUGEPAGE | VM_GROWS<something>
>>>
>>>>               _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
>>>>               arch_calc_vm_flag_bits(flags);
>>>>   }


