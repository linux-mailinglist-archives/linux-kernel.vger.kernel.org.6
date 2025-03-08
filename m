Return-Path: <linux-kernel+bounces-552752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29703A57DAD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6349F16B7BC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481461EFF9C;
	Sat,  8 Mar 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="heUJRSTQ"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345A1A8403
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741460939; cv=none; b=nc39al9gLzRKSPV7B/mDlmtLKIBpu16EzYdJn4jaBjras2Vxp/cvJysoYUpoG6Uou5x64KtZDGikEnCDIq+qKGVUUolT6zPKud8KU2roYw4tpC9pGMQLjNEhYZ/NfHSbCMCSHZBQyaNoP+FMRMjl7u6PH7/pth6DSUIvi/GRUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741460939; c=relaxed/simple;
	bh=HN6sybrOqzy3o4ZNRPHcGmJpL/umIrCvKbvnrjaDzfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udUNPA8DUAjwTGoKD2lBxAL2MQNG7c8XlWLSkt1tqYXvNhoTnEsp+Sxr1Rzp7qzvkzHa6Zg48wIC+cY6pSqsLP5gB9ClPXj6cgH0vSM6cmdDygVXMwjB2IEjUj9eneIcl45j74dcrAakj3TiFBZg4Hxi13nlR6JcuJnUULzeFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=heUJRSTQ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8003:ca73:434c:8ca7:921e:6209] ([IPv6:2601:646:8003:ca73:434c:8ca7:921e:6209])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 528J8DAG909937
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 8 Mar 2025 11:08:14 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 528J8DAG909937
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741460895;
	bh=ASEmqZoEsQ9vQDaSfYF27u21eOMajeVX46NKvJosq3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=heUJRSTQet1YpRfXmujiS+InLKJiAT0BvjwD0Xp1CWqUK9BjR9Fii19Slrsyfr+TM
	 xQiEGQjqjgT65fElUL9MHqbIhh1rXRThLp3KQAWRzCf3T9tmwdIiKUqGO4QCJjtH4Z
	 QN8ZA0dhl8RdZ1OZNYyrFFGvdZ78M7LeIcmTdk/E6EPmXopSCctxfjd/PeJug2+bff
	 4V6LpoVjtuXLivXdGPSqQ9BZOK3pwMKQF+qS4yDM/YzcfpimY73C5SxoZgBsgoBRPr
	 ffVW3L1cEYCsneYg5UMn9GmDOLHTb1LhtNDbIKKIEKgB7UFVn0pMWWpB35r+5QQNBr
	 Z7Ya+v0BNkzYw==
Message-ID: <954c7084-3d6f-47b8-b6cc-08a912eda74c@zytor.com>
Date: Sat, 8 Mar 2025 11:08:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Dave Hansen <dave.hansen@intel.com>, Uros Bizjak <ubizjak@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 08:48, Dave Hansen wrote:
> On 2/28/25 04:35, Uros Bizjak wrote:
>> The code size of the resulting x86_64 defconfig object file increases
>> for 33.264 kbytes, representing 1.2% code size increase:
>>
>>     text    data     bss     dec     hex filename
>> 27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
>> 27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o
> 
> So, first of all, thank you for including some objective measurement of
> the impact if your patches. It's much appreciated.
> 
> But I think the patches need to come with a solid theory of why they're
> good. The minimum bar for that, I think, is *some* kind of actual
> real-world performance test. I'm not picky. Just *something* that spends
> a lot of time in the kernel and ideally where a profile points at some
> of the code you're poking here.
> 
> I'm seriously not picky: will-it-scale, lmbench, dbench, kernel
> compiles. *ANYTHING*. *ANY* hardware. Run it on your laptop.
> 
> But performance patches need to come with performance *numbers*.

Incidentally, this is exactly the reason why gcc added "asm inline" *at 
our request*. We just haven't caught up with it everywhere yet.

In fact, I would wonder if we shouldn't simply do:

#define asm __asm__ __inline__
#define asm_noinline __asm__

... in other words, to make asm inline an opt-out instead of an opt-in.
It is comparatively unusual that we do complex things in inline assembly 
that we would want gcc to treat as something that should be avoided.

	-hpa


