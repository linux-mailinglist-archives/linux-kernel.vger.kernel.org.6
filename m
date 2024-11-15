Return-Path: <linux-kernel+bounces-410833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A249CED51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7829B2802D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67A01CEEB4;
	Fri, 15 Nov 2024 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kv4ofa/v"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8A54769
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681804; cv=none; b=ohW/D+a5v6SZRuhDIqlyWS0qo9beDcSoueSl4exe7y+zsOIkDHm5Kd/7L8HPVSEMTaszLWlTzqLTzP6qw0NAmbj0/4fvcknQMU1LFHKQ6eNx4LhQlj74mbYvJcte8XfVwwOxc67dC2WJC1We/dSUJPktK3ItMs4vtGKSLJzi3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681804; c=relaxed/simple;
	bh=LCIAcAm0uKz3UBzKHy1RzALFjDEwQDt7W+TxIu8Qtog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHLJttWD0PA2LIDFhY6vNlQGzCYpdQVCU5xEXTPn/LCAHc6KrnwjqSWqlkJXq17/9NFeGZS7PzK/UIZOFcNF4zFVbFsW1efIXziHvlWeOkD9Xp4my7aGfbXRc+BBzXQ9Ey0xmvd5AnN19OV84pHYd5vK7UmyIlPQuSN/nui2jAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kv4ofa/v; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1731681799;
	bh=LCIAcAm0uKz3UBzKHy1RzALFjDEwQDt7W+TxIu8Qtog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kv4ofa/vV5B6FxVUxLiQJYnX2TlDpukIFrWbbn+rPb1Ot0oGgQNTdvqnetkht7bSM
	 QhBW5kBUmAcjLroHFp75dZyK1IuvRne7BcEMstKMK3oNJXXfV4RpNZYGhgkx6J/VAj
	 jiVwai2oF3Y+sKXiwXdEbiQM+NNCKaqcF1OVykYtuyFu6Jvf7eeXDOeF6l5/HWv++m
	 J0xvrc6VoLdshua+4S85UnRLCxXr6M+bKDblRZk7flOBSAFT2tB8tfJax1wquZhvZf
	 tLsXEcCIVsP4NU41s1p3DiuOey+h5tXDznqIq9lg0nfi2CFcuMkjYSjBN04XhwHapQ
	 0QGvnyX7wzrsg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xqfs33DdYzrQ2;
	Fri, 15 Nov 2024 09:43:19 -0500 (EST)
Message-ID: <939a3bba-9e9e-4eb9-8040-e1447718b341@efficios.com>
Date: Fri, 15 Nov 2024 09:41:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
To: Peter Zijlstra <peterz@infradead.org>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
 daniel.m.jordan@oracle.com
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
 <20241114101455.GL6497@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241114101455.GL6497@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-14 05:14, Peter Zijlstra wrote:
> On Wed, Nov 13, 2024 at 02:36:58PM -0500, Mathieu Desnoyers wrote:
>> On 2024-11-13 13:50, Peter Zijlstra wrote:
>>> On Wed, Nov 13, 2024 at 12:01:22AM +0000, Prakash Sangappa wrote:
>>>
>>>> This patch set implements the above mentioned 50us extension time as posted
>>>> by Peter. But instead of using restartable sequences as API to set the flag
>>>> to request the extension, this patch proposes a new API with use of a per
>>>> thread shared structure implementation described below. This shared structure
>>>> is accessible in both users pace and kernel. The user thread will set the
>>>> flag in this shared structure to request execution time extension.
>>>
>>> But why -- we already have rseq, glibc uses it by default. Why add yet
>>> another thing?
>>
>> Indeed, what I'm not seeing in this RFC patch series cover letter is an
>> explanation that justifies adding yet another per-thread memory area
>> shared between kernel and userspace when we have extensible rseq
>> already.
>>
>> Peter, was there anything fundamentally wrong with your approach based
>> on rseq ? https://lore.kernel.org/lkml/20231030132949.GA38123@noisy.programming.kicks-ass.net
> 
> Not that I can remember, but it's a long time ago :-)
> 
>> The main thing I wonder is whether loading the rseq delay resched flag
>> on return to userspace is too late in your patch.
> 
> Too late how? It only loads it at the point we would've called
> schedule() -- no point in looking at it otherwise, right?

[...]

For the specific return-to-userspace path, I think where you've placed
the delay-resched flag check is fine.

I'm concerned about other code paths that invoke schedule() besides
return-to-userspace. For instance:

raw_irqentry_exit_cond_resched():

         if (!preempt_count()) {
[...]
                 if (need_resched())
                         preempt_schedule_irq();
         }

AFAIU, this could be triggered by an interrupt handler exit when nested
over a page fault handler, exception handler, or system call.

We may decide that we cannot care less about those scenarios, and just
ignore the delay-resched flag, but it's relevant to take those into
consideration and clearly document the rationale behind our decision.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


