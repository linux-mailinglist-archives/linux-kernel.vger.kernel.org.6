Return-Path: <linux-kernel+bounces-301980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A5E95F839
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5DC1F23A52
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7161991A8;
	Mon, 26 Aug 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NpwW0zjK"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930B198E84
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693613; cv=none; b=BLlgPbh6xNPT7hrM4yNNURSb9t4E/XWgWcOEnn2D8AHViaCsoZoHiGaRJjyn/9r81yXLGHOHKPQP43cBnp3WHKyvAht3bFS13zeML+RGkyUXR8FNTbHx101CedPGZR5uJ8Md+FWxLPPchopVOKDGNLQsiiBjpJaIWkqWqc5OFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693613; c=relaxed/simple;
	bh=jF0AFybnEgu4YAohDDh06EmYAk8jCuZvF04I5MfW/sA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lYDu8h36D5XohEANJus0gexzKupTOq6faX3h4T11yt5iWQYCZKDIL8wRN7556dzHZmwtM+/ZveLSJEvPhWKq14r6D5qvCjInP8JxzoDzjsf+H/vJQv6GMOR1Fzkl2PXCm8qvhqAGT1QUbMXFKlu0+4DOG39xeNLM2MZX194q/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=NpwW0zjK; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47QHWWCR3949296
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 26 Aug 2024 10:32:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47QHWWCR3949296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1724693553;
	bh=IDtuNVIhlKMEKOcyuxVSY36eaZkOAiZx816C5idJyvA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=NpwW0zjKGr6DK6BhJDjW5uVqWrQfsU5uaWht1wcHFf48Sy+Ew39WRhvg5LQ6YtPOG
	 HoB9+G/FeD6MwIbmaibINF9ur9YjK75I41Mi6V/TW96o6IRAIbeYrPAzN1L3bfx72d
	 OCoVvbVJlPKL6Z9TB/hzVUJAPM5ZxsNuA3TZ3GDb06DYnBGrUO2vcSO6kYYCtHpS4H
	 I2/WU8youaGJ89KvvSQFu1M2bj6xYfWW1xlnSWxNsK6ELgVECehksUOTywS9GMGgfO
	 bbr0LHUCRMuPnXh4IaFQygzbKMggsAZCJ4lJ94+beVTxLtZjl8zX5h4gM8jmUJWH9E
	 LPU2HlknorCIw==
Message-ID: <469a7dc3-b4de-4d2b-9068-381a250273d3@zytor.com>
Date: Mon, 26 Aug 2024 10:32:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] x86: Allow variable-sized event frame
From: Xin Li <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
References: <20240617084516.1484390-1-xin@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240617084516.1484390-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/2024 1:45 AM, Xin Li (Intel) wrote:
> This was initially posted as part of the FRED patch series and turned
> down due to its unacceptable quality:
>    https://lore.kernel.org/lkml/20230410081438.1750-31-xin3.li@intel.com/
> 
> And this is another attempt to meet the bar.
> 

I'm expecting to get some review comments on this patch set :-)

> 
> a FRED event frame could contain different amount of information for
> different event types, e.g., #MCE could push extra bytes of information,
> or perhaps even for different instances of the same event type. Thus
> the size of an event frame pushed by a FRED CPU is not fixed and the
> address of a pt_regs structure that is used to save the user level
> context of current task is not at a fixed offset from top of current
> task kernel stack.
> 
> This patch set adds a new field named 'user_pt_regs' in the thread_info
> structure to save the address of user level context pt_regs structure,
> thus to eliminate the need of any advance information of event frame
> size and allow a FRED CPU to push variable-sized event frame.
> 
> With the above change, we can
> 1) Remove the padding space at top of the init stack because there is
>     no user level context for init task.
> 2) Get rid of TOP_OF_KERNEL_STACK_PADDING on x86_64, which was defined
>     to 0 for IDT to keep the code consistent with 32bit.
> 
> 
> Xin Li (Intel) (3):
>    x86/fred: Allow variable-sized event frame
>    x86: Remove the padding space at top of the init stack
>    x86: Get rid of TOP_OF_KERNEL_STACK_PADDING on x86_64
> 
>   arch/x86/entry/entry_fred.c        | 22 +++++++++++++++++
>   arch/x86/include/asm/processor.h   | 38 +++++++++++++++++++++++-------
>   arch/x86/include/asm/switch_to.h   |  2 +-
>   arch/x86/include/asm/thread_info.h | 19 +++++----------
>   arch/x86/kernel/process.c          | 21 +++++++++++++++++
>   arch/x86/kernel/vmlinux.lds.S      | 18 ++++++++++++--
>   include/linux/thread_info.h        |  1 +
>   kernel/fork.c                      |  6 +++++
>   8 files changed, 102 insertions(+), 25 deletions(-)
> 
> 
> base-commit: 49b33979e3bf0a5424420d14f026de12f34e8b1e


