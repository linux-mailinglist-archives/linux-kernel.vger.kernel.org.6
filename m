Return-Path: <linux-kernel+bounces-325753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34075975DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5945F1C222FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9FC1A3047;
	Wed, 11 Sep 2024 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XcEOl5XW"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C79186E2C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726098276; cv=none; b=l62C1XB9giDIgV3RmVh+mSt5kEll9k4xp0g96NyI9ptkWuIb4mMVui4GS9YtO0WLFOonp6CIZmJ1iLVcAkvpOExkithKDGm+DL0rZH3CgOTgZbaHv+KuYBcvt84kFOXhPY3oNzhKS+BimA0YUNC3KtOFVQMxCy5m5SZE1M4UAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726098276; c=relaxed/simple;
	bh=y2VXaeJJxVoGvguqe8WDtlnLzOelU9lMxIjVbY1WZ6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNOLDk10nUxZxFz0EOQ8p1uf0R7vnJUFvlT0IJ23rIj1/TtmUYL4TyAlvH/T/C7uipdlBOmCwJENnyMrvYYc4XvyhkvuECpwfBsiKaU9H0wEXsnd7whAY2ugQL6EkfaknHyrGFzXf78fMmkZF5sF5xyClVnLrBDuMbHBAtkmbjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=XcEOl5XW; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 48BNi5BY2640137
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 11 Sep 2024 16:44:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 48BNi5BY2640137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1726098247;
	bh=Gg6xQY5ra1K8phmbiZHoNGy2VSSxwc5nYjsqFC3Pg4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XcEOl5XW9ADrF1o4FFLpCrZ7Pr02ZVSj0744ToAzev7PTHY7c2dJ4VJTkllky/l5y
	 tFJEb22xwyas25ISzHvPfK/VDWIqYYRz83NBK16GhGzpZ320/8MnrSqAQCfbKTxXVl
	 Ex85UTHpjw48N0BV4i7x5U9dw9hhIpt+1ti+Kt5yco6akn8Q6WOv55jE6vZgQ9BBH5
	 ifGOsXMDqmUdYxrBrvgPrjSfPqkykUs6usGZVQ01EAhWIshNzvw4MMxaNjqhJq3Zm3
	 UQ1wITxCwYYMH0++9trCG7y/aWRhhPCSnaO+CbP2WkKdurB6fT5fTuMaVqHBd78wZG
	 ky7QMWE5dbxBw==
Message-ID: <9efbfb57-d454-4bad-bdb8-e3000b6ba0ce@zytor.com>
Date: Wed, 11 Sep 2024 16:44:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Clear the WFE bit in missing-ENDBRANCH
 #CP
To: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org
References: <20240911231929.2632698-1-xin@zytor.com>
 <04674df0-a026-42d1-aacf-293f3018329f@citrix.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 xsDNBGUPz1cBDACS/9yOJGojBFPxFt0OfTWuMl0uSgpwk37uRrFPTTLw4BaxhlFL0bjs6q+0
 2OfG34R+a0ZCuj5c9vggUMoOLdDyA7yPVAJU0OX6lqpg6z/kyQg3t4jvajG6aCgwSDx5Kzg5
 Rj3AXl8k2wb0jdqRB4RvaOPFiHNGgXCs5Pkux/qr0laeFIpzMKMootGa4kfURgPhRzUaM1vy
 bsMsL8vpJtGUmitrSqe5dVNBH00whLtPFM7IbzKURPUOkRRiusFAsw0a1ztCgoFczq6VfAVu
 raTye0L/VXwZd+aGi401V2tLsAHxxckRi9p3mc0jExPc60joK+aZPy6amwSCy5kAJ/AboYtY
 VmKIGKx1yx8POy6m+1lZ8C0q9b8eJ8kWPAR78PgT37FQWKYS1uAroG2wLdK7FiIEpPhCD+zH
 wlslo2ETbdKjrLIPNehQCOWrT32k8vFNEMLP5G/mmjfNj5sEf3IOKgMTMVl9AFjsINLHcxEQ
 6T8nGbX/n3msP6A36FDfdSEAEQEAAc0WWGluIExpIDx4aW5Aenl0b3IuY29tPsLBDQQTAQgA
 NxYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89XBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgID
 AQAACgkQa70OVx2uN1HUpgv/cM2fsFCQodLArMTX5nt9yqAWgA5t1srri6EgS8W3F+3Kitge
 tYTBKu6j5BXuXaX3vyfCm+zajDJN77JHuYnpcKKr13VcZi1Swv6Jx1u0II8DOmoDYLb1Q2ZW
 v83W55fOWJ2g72x/UjVJBQ0sVjAngazU3ckc0TeNQlkcpSVGa/qBIHLfZraWtdrNAQT4A1fa
 sWGuJrChBFhtKbYXbUCu9AoYmmbQnsx2EWoJy3h7OjtfFapJbPZql+no5AJ3Mk9eE5oWyLH+
 QWqtOeJM7kKvn/dBudokFSNhDUw06e7EoVPSJyUIMbYtUO7g2+Atu44G/EPP0yV0J4lRO6EA
 wYRXff7+I1jIWEHpj5EFVYO6SmBg7zF2illHEW31JAPtdDLDHYcZDfS41caEKOQIPsdzQkaQ
 oW2hchcjcMPAfyhhRzUpVHLPxLCetP8vrVhTvnaZUo0xaVYb3+wjP+D5j/3+hwblu2agPsaE
 vgVbZ8Fx3TUxUPCAdr/p73DGg57oHjgezsDNBGUPz1gBDAD4Mg7hMFRQqlzotcNSxatlAQNL
 MadLfUTFz8wUUa21LPLrHBkUwm8RujehJrzcVbPYwPXIO0uyL/F///CogMNx7Iwo6by43KOy
 g89wVFhyy237EY76j1lVfLzcMYmjBoTH95fJC/lVb5Whxil6KjSN/R/y3jfG1dPXfwAuZ/4N
 cMoOslWkfZKJeEut5aZTRepKKF54T5r49H9F7OFLyxrC/uI9UDttWqMxcWyCkHh0v1Di8176
 jjYRNTrGEfYfGxSp+3jYL3PoNceIMkqM9haXjjGl0W1B4BidK1LVYBNov0rTEzyr0a1riUrp
 Qk+6z/LHxCM9lFFXnqH7KWeToTOPQebD2B/Ah5CZlft41i8L6LOF/LCuDBuYlu/fI2nuCc8d
 m4wwtkou1Y/kIwbEsE/6RQwRXUZhzO6llfoN96Fczr/RwvPIK5SVMixqWq4QGFAyK0m/1ap4
 bhIRrdCLVQcgU4glo17vqfEaRcTW5SgX+pGs4KIPPBE5J/ABD6pBnUUAEQEAAcLA/AQYAQgA
 JhYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89ZBQkFo5qAAhsMAAoJEGu9DlcdrjdR4C0L
 /RcjolEjoZW8VsyxWtXazQPnaRvzZ4vhmGOsCPr2BPtMlSwDzTlri8BBG1/3t/DNK4JLuwEj
 OAIE3fkkm+UG4Kjud6aNeraDI52DRVCSx6xff3bjmJsJJMb12mWglN6LjdF6K+PE+OTJUh2F
 dOhslN5C2kgl0dvUuevwMgQF3IljLmi/6APKYJHjkJpu1E6luZec/lRbetHuNFtbh3xgFIJx
 2RpgVDP4xB3f8r0I+y6ua+p7fgOjDLyoFjubRGed0Be45JJQEn7A3CSb6Xu7NYobnxfkwAGZ
 Q81a2XtvNS7Aj6NWVoOQB5KbM4yosO5+Me1V1SkX2jlnn26JPEvbV3KRFcwV5RnDxm4OQTSk
 PYbAkjBbm+tuJ/Sm+5Yp5T/BnKz21FoCS8uvTiziHj2H7Cuekn6F8EYhegONm+RVg3vikOpn
 gao85i4HwQTK9/D1wgJIQkdwWXVMZ6q/OALaBp82vQ2U9sjTyFXgDjglgh00VRAHP7u1Rcu4
 l75w1xInsg==
In-Reply-To: <04674df0-a026-42d1-aacf-293f3018329f@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/2024 4:35 PM, Andrew Cooper wrote:
> On 12/09/2024 12:19 am, Xin Li (Intel) wrote:
>> The WFE, i.e., WAIT_FOR_ENDBRANCH, bit in the augmented CS of FRED
>> stack frame is set to 1 in missing-ENDBRANCH #CP exceptions.
>>
>> The CPU will generate another missing-ENDBRANCH #CP if the WFE bit
>> is left as 1, because the indirect branch tracker will be set in
>> the WAIT_FOR_ENDBRANCH state upon completion of the following ERETS
>> instruction and the CPU will restart from the IP that just caused a
>> previous missing-ENDBRANCH #CP.
>>
>> Clear the WFE bit to avoid dead looping in missing-ENDBRANCH #CP.
>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> 
> Ah - good.  Finally some evidence that this hole in CET has been plugged
> by FRED.
> 
> However, I'd suggest describing it differently.

Yep, it's a much better story including historical issues with IDT.

I will use it as the comment above ibt_clear_fred_wfe() in the next
iteration, but keep the change log.  Is it okay?

> 
> 
> By definition, all missing-ENDBRANCH #CPs are a result of WFE && !ENDBR.
> 
> But, in original CET under IDT delivery, any transfer for
> interrupt/exception/etc that does not change privilege will clobber the
> WFE state because MSR_{U,S}_CET.WFE is intentionally set by microcode so
> as to expect to find an ENDBR at the interrupt/exception/syscall entrypoint.
> 
> In practice, this means interrupts and exceptions hitting the kernel, or
> user interrupts, loose the WFE state of the interrupted context.  And
> yes, this means that a well timed interrupt (to the precise instruction
> boundary) will let an attacker sneak a bad function pointer past the
> CET-IBT enforcement.
> 
> In FRED, the WFE state of the interrupted context (even if it is the
> same privilege) is preserved and restored, in order to close this hole.
> 
> Therefore, the intentional #CP selfchecks need to clear WFE when they
> are deemed to have succeeded, now that FRED is causing the state not to
> get lost.
> 
> ~Andrew


