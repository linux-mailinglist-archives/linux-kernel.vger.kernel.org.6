Return-Path: <linux-kernel+bounces-410795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433649CE10D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AB0283174
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14EA1B3941;
	Fri, 15 Nov 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="f124p95m"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8E54769
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680117; cv=none; b=ZQLwFX0DSPJfJcZ8QmWRz7uOcRx7LFFhMkFqLzdx4LdY/v/cvzTRHyIu110swJZbxSQlsS0HcCysJ/UmFKtDTuLr6HDF/Y8dIzN784MsH1tjxks5jKPdKiqkjX5uQiGjd30C82ZwfgEV+zdwyEi4LA4WelfLTvyb2fGFb1BKrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680117; c=relaxed/simple;
	bh=z2U/Tg43c7yZnkyRAD+eMAP2jfUHf8dwoGPROxeZzcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXARhTsmCYdx3h+W9ZEPp45U2lIIfqO0bp2BAmlBDET7jsHScBsHOn4ITDCE7dAK9Zw+lgaX5vP6BZ2aACjVUbeEkwKX4h8GMB+XiLK8/tMsGmI+DXS2ipDHkSMIaEaxC1ru6SFxs0mjFffyyUwnh1xziM5gw9A1KD6r90Mh5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=f124p95m; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1731680098;
	bh=z2U/Tg43c7yZnkyRAD+eMAP2jfUHf8dwoGPROxeZzcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f124p95mWYIIymF6sAFY/w0IUWeM/mPHl1GtHAM51ggZoTYoKHNhT1p3DvJmOLwXa
	 1hGLmOg2BIKr+vsS4Zq165w/1BkypGisUBevXl1pAWqey24RseBgzEtG+6T4ensvBz
	 Go1/rsinL/d5bDhMmH+utrhfwmq3YcWIwvOtvtmjJubNnZ9/SqQTYfttQjMKWiOMd6
	 s+M7nXOEawbmFHSs/bbpKcXSOfuTeDPx7ElCJO2KJo00SoFOcPeozxQMOlhALeiJB7
	 nIuF6FKjK5Sac3woV+rza0EZrvm9D2HEong1OkZjFz4mVgaXsAcYvpGN11oSYcahb3
	 MM8AUi5D7F00Q==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XqfDL2lNDzrTb;
	Fri, 15 Nov 2024 09:14:58 -0500 (EST)
Message-ID: <d86d463c-14ea-47cf-adc6-d3e9caa4ebf1@efficios.com>
Date: Fri, 15 Nov 2024 09:13:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
 <896BA407-E19C-4CEB-BF5E-9707543BA365@oracle.com>
 <20241114102834.GM6497@noisy.programming.kicks-ass.net>
 <CF032474-7725-48C1-BA31-A8728C6C06E7@oracle.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CF032474-7725-48C1-BA31-A8728C6C06E7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-14 14:42, Prakash Sangappa wrote:
> 
> 
>> On Nov 14, 2024, at 2:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:

[...]

>>
>> See:
>>
>>   https://lkml.kernel.org/r/20220113233940.3608440-4-posk@google.com
>>
>> for a more elaborate scheme.
>>
>>>> Peter, was there anything fundamentally wrong with your approach based
>>>> on rseq ? https://lore.kernel.org/lkml/20231030132949.GA38123@noisy.programming.kicks-ass.net
>>>>
>>>> The main thing I wonder is whether loading the rseq delay resched flag
>>>> on return to userspace is too late in your patch. Also, I'm not sure it is
>>>> realistic to require that no system calls should be done within time extension
>>>> slice. If we have this scenario:
>>>
>>> I am also not sure if we need to prevent system calls in this scenario.
>>> Was that restriction mainly because of restartable sequence API implements it?
>>
>> No, the whole premise of delaying resched was because people think that
>> syscalls are too slow. If you do not think this, then you shouldn't be
>> using this.
> 
> Agree.

I only partially agree with Peter here. I agree that we don't want to
add system calls on the delay-resched critical section fast path,
because this would have a significant performance hit.

But there are scenarios where issuing system calls from within that
critical section would be needed, even though those would not belong
to the fast path:

1) If a signal handler nests over a delay-resched critical section.
    That signal handler is allowed to issue system calls.

2) If the critical section fast-path is calling GNU C library API and/or
    a vDSO, which is typically fast, but can end up calling a system call
    as fallback. e.g. clock_gettime, sched_getcpu. Preventing use of a
    system call by killing the application punches a hole in the
    abstractions meant to be provided by GNU libc and vDSO.

I would recommend that we allow issuing system calls while the
delay-resched bit is set. However, we may not strictly need to honor
the delay-resched hint from a system call context, as those would
be expected to be either infrequent or a portability fallback,
which means the enhanced performance provided by delay-resched
really won't matter.

Another scenario to keep in mind are page faults happening within a
delay-resched critical section. This is a scenario where page fault
handling can explicitly reschedule. If this happens, I suspect we
really don't care about the delay-resched hint, but we should consider
whether this hint should be left as-is or cleared.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


