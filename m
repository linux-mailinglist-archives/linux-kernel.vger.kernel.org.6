Return-Path: <linux-kernel+bounces-313950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842FB96ACC6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5451C23245
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF011D5CEB;
	Tue,  3 Sep 2024 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Tzbl6dTT"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1A126C13
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405782; cv=none; b=e/NfkRRcFZbJ/oxqF+6gRuUnpRuAVmqd3OBg4PTqiP/M4mPWkT7SnhM7ley6Ygmde26BNzd94lcvV+EtgoEb+XPQrsn9sG93J5xhiQxoTbAPat+BxVSYTELkPHW8zjhy8gnBLewFw+kCekUkB8nhYSXEG2SSTZlj6p6DN0qDv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405782; c=relaxed/simple;
	bh=gIcUC1BSwLdR6iM2GsWO6B24F4CIc2hhblObzlEIGtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChVTdOkioh526CadAQwk5op9osUsSbtX2nrRstOZ/zOBReHgOIAQUUAZ7RkOuk9CU5M+7M9LPLAZN6/xDOLHBaKX/Ed7hAgF4PvNGhD2Ua7F+yDy7GDIQinMlvI+j8T/mU0/8jazAIwCjGM9pezaJgcTAmNa5tJYKYF2MOpf8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Tzbl6dTT; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725405777;
	bh=gIcUC1BSwLdR6iM2GsWO6B24F4CIc2hhblObzlEIGtk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tzbl6dTTo8G+AtA3+oq0/Im+s4/QVTeZlm+ZpV9fkKdJGUUdr3C/XNdgtHKBUqaOp
	 om1Dsa/rB3Sd2yQqK8E+5cJyzCqrYUTgl3bVpNETRCTqyQl7lX9yyneJZJ324qPfaT
	 Xe6xp2OnRmt1ZQ25L5bgf1NgJSi5+QS1bdEhyuklbKEgtGiDXBgE7k1bFftTz4zufg
	 mOFRNrz8456afjAN1/8l1TtsJPiPLPx/rTySq6q6OmuUg7SON5IYMQfkGv2gEOf0Zb
	 cCqY9mtXrAOi1lpFn6ERdU5fdIOA2ICbnLW8KwATYtKqVhBlguNqq/WiSRZu/4QrjP
	 S42kmCpXrrybQ==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wz1rK60fKz1JsR;
	Tue,  3 Sep 2024 19:22:57 -0400 (EDT)
Message-ID: <615f169b-3b24-4661-8a2c-185c6d80f7a4@efficios.com>
Date: Tue, 3 Sep 2024 19:22:37 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] sched: Improve cache locality of RSEQ concurrency
 IDs for intermittent workloads
To: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
References: <20240903190650.53644-1-mathieu.desnoyers@efficios.com>
 <20240903190650.53644-3-mathieu.desnoyers@efficios.com>
 <ZtdqhmKmbVsCSAkJ@yury-ThinkPad>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZtdqhmKmbVsCSAkJ@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-03 15:59, Yury Norov wrote:
> On Tue, Sep 03, 2024 at 03:06:50PM -0400, Mathieu Desnoyers wrote:
[...]
>> +
>> +static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask)
>> +{
>> +	struct cpumask *mm_allowed = mm_cpus_allowed(mm);
>> +	int cpu, nr_set = 0;
>> +
>> +	if (!mm)
>> +		return;
>> +	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
>> +	for (cpu = 0; cpu < nr_cpu_ids; cpu = cpumask_next_andnot(cpu, cpumask, mm_allowed)) {
>> +		if (!cpumask_test_and_set_cpu(cpu, mm_allowed))
>> +			nr_set++;
>> +	}
> 
> You can do the same nicer:
> 
>    for_each_cpu(cpu, cpumask)
>    	nr_set += !cpumask_test_and_set_cpu(cpu, mm_allowed);
> 
> This should be faster and a bit simpler, to me.

In this scenario, I expect the following per-thread cpumask properties 
for a given process (typically): those will be typically the same bits
set repeated over all threads belonging to a process. There are of
course scenarios where specific threads will override the mask, but
I don't expect this to be the most frequent case.

So we typically have an operation which initially copies the initial
thread's allowed cpus mask to the mm allowed cpus mask, and then when
additional affinity changes are done, we want to augment the mm allowed
cpus masks with any additional cpu that may show up. But again, I expect
the initial thread to typically have the complete mask and other
operations won't typically change the mm allowed cpumask bits.

I also expect the cpumask to be often quite dense (often all bits
are set).

Now if we look at the operations for your proposal here:

- for_each_cpu loads cpumask word-by-word and for each set bit, it
   issues cpumask_test_and_set_cpu on mm_allowed, which is really a
   test_and_set_bit, a fully ordered atomic operation, on each _bit_
   set. That's O(nr_cpus) fully ordered atomic operations, and thus
   expensive exclusive cache line accesses.

My approach does:

- The equivalent of a for_each_cpu_andnot (actually I should use
   exactly that! I just noticed it exists in the API.), which loads
   both thread and mm CPUs allowed masks in parallel, word-by-word,
   and only issues a cpumask_test_and_set_cpu for CPUs which are set
   in the per-thread mask, but not in the mm mask. In the typical cases
   discussed above, we pretty much never need to issue the atomic
   test-and-set. So all we need to do for the common case is to read
   both cpu masks in parallel, no stores/atomic ops needed.

> What concerns me is that you call atomic function in a loop, which makes
> the whole procedure non-atomic. If it's OK, can you put a comment why a
> series of atomic ops is OK here? If not - I believe external locking
> would be needed.

Good point, so the whole mm CPUs allowed masks tracks the allowed set,
and based on the result of the test_and_set it accumulates the number of
bits set and atomically add the total to nr_allowed_cpus. The mm_cid
algorithms only care about mm nr_allowed_cpus, so those don't even need
to look at the mm CPUs allowed mask, therefore there is no need to
provide any ordering guarantees across the two data structures.

If we'd have a cpumask_test_and_set_cpu_relaxed() it would be sufficient
here.

As you say, I should explain this in a comment.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


