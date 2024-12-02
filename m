Return-Path: <linux-kernel+bounces-428007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDCD9E0926
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBAFBC6758
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB5E1632E6;
	Mon,  2 Dec 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LZHtSpiI"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526C13C6BA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157011; cv=none; b=mQqYP96movtOSCjfQM9ULdTBn6QcTJ30jDfGNW52C/OUe4JcJUn//lY0984jKLuBC5nKcNt58FSyDfTK6S6yb06H+FTvUdr/gD4McNfwYOSxBhPr2gVwIxmbxn2YRxWxuyJ2z1FQ33iWILUmPL0i/DnsAuQv+pINos+7XF3oICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157011; c=relaxed/simple;
	bh=Sz226XoxQNqwv6a0DZ9qgFudn74WRpAQ06Xjcrc8X00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhyKdFbSSXi89EDrScrxI6IetKCX4piA9FICmN86J25IYwe2RU76s6YOWqFurHneCyNxgZAQiqqFXwdlyuOmzzgjMGtQ/xiMAW6d9dsSB4JC/bO17PIZPhykScuBv0y3/SIkUnAkYLGjz7M8XECHtodowhnoQyU92yC2OQqRYNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LZHtSpiI; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1733157008;
	bh=Sz226XoxQNqwv6a0DZ9qgFudn74WRpAQ06Xjcrc8X00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LZHtSpiIPK3//ZnACZjKmoHt5rspMUb2P35fsRJK5bL7ZL9JwNqo5Y3VqoLxFVdyh
	 rLONdHf3DKqxz9hAsO5J5kgkAapGAD9gAp8NhWZuCI/QXIZ/7kJlNMyu9fzhjobP7s
	 QyOgWvwHK0SOcVJ4eGDV4TpxCzFaBkHBBPI7+r+sVCaC1Ge0Xu/PsIFqPXxB4bZp3m
	 zchRLo6rDxdSn0PGQOEdJo7E1KoM5xIU44RmBufni3CjrqkmpZkkGLJ5kbTKHhTUIQ
	 bu21p16bZtMEVgLOPDKKl0cZGVXubgjoBhg/mdw6OqjMEPvCA62j81JFVDUyQdDXM4
	 E32oRNjsNfEsw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Y28QS0PKnzVDB;
	Mon,  2 Dec 2024 11:30:08 -0500 (EST)
Message-ID: <9b3bd9b0-fd5b-4239-8ee4-ebabd0667b4b@efficios.com>
Date: Mon, 2 Dec 2024 11:30:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:x86/mm] [x86/mm/tlb] 209954cbc7:
 will-it-scale.per_thread_ops 13.2% regression
To: Rik van Riel <riel@surriel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>
References: <202411282207.6bd28eae-lkp@intel.com>
 <Z0jIsYsuo_9w16tK@localhost.localdomain>
 <8bf303a222ba27f3a86b357db58ee3df3fa7f82e.camel@surriel.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <8bf303a222ba27f3a86b357db58ee3df3fa7f82e.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-28 21:52, Rik van Riel wrote:
> On Thu, 2024-11-28 at 14:46 -0500, Mathieu Desnoyers wrote:
>>
>> I suspect you could use a similar per-cpu data structure per-mm
>> to keep track of the pending TLB flush mask, and update it simply
>> with
>> load/store to per-CPU data rather than have to cacheline-bounce all
>> over
>> the place due to frequent mm_cpumask atomic updates.
>>
>> Then you get all the benefits without introducing a window where
>> useless
>> TLB flush IPIs get triggered.
>>
>> Of course it's slightly less compact in terms of memory footprint
>> than a
>> cpumask, but you gain a lot by removing cache line bouncing on this
>> frequent context switch code path.
>>
>> Thoughts ?
> 
> The first thought that comes to mind is that we already
> have a per-CPU variable indicating which is the currently
> loaded mm on that CPU.

Only on x86 though.

> 
> We could probably just skip sending IPIs to CPUs that do
> not have the mm_struct currently loaded.
> 
> This can race against switch_mm_irqs_off() on a CPU
> switching to that mm simultaneously with the TLB flush,
> which should be fine because that CPU cannot load TLB
> entries from previously cleared page tables.
> 
> However, it does mean we cannot safely clear bits
> out of the mm_cpumask, because a race between clearing
> the bit on one CPU, and setting it on another would not
> be something we could easily catch at all, unless we
> can figure out some clever memory ordering thing there.
> 

Or we just build a per-cpu mm_cpumask from per-CPU state
every time we want to use the mm_cpumask. But AFAIU this
is going to be a tradeoff between:

- Overhead of context switch at scale

(e.g. will-it-scale:)
for a in $(seq 1 2); do (./context_switch1_threads -t 192 -s 20 &); done

For reference, my POC reaches 50% performance improvement with this.

   vs

- Overhead of TLB flush

(e.g. will-it-scale:)
./tlb_flush2_threads -t 192 -s 20

For reference, my POC has about 33% regression on that test case due
to extra work when using mm_cpumask.

So I guess what we end up doing really depends which scenario we consider
most frequent.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


