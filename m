Return-Path: <linux-kernel+bounces-347508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D738F98D39C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA3F1F233F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F01D0154;
	Wed,  2 Oct 2024 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RLE/a0pE"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC7B1CF7D8
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873234; cv=none; b=r0Fp/aDhRaAqhaakUrNiorFk0/Ay7wY3eS/xwczvny4+4J/Oh4yN48yjwBwjMJHQnRJBMc7IFVJQlkJgT9ijjO7bmFov+2tpyWUq5y5SHEtqH73CFIeB0OPjJU2Y11fS9PWXQZkmkS0udlolk1QHO71ubAofrk0uP/1qhWN/+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873234; c=relaxed/simple;
	bh=ydDGm6C3dK+xoowuRzZoMLy/s4R9AW7XsqWeKycwHe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgMP9H7g0Cs1TBLxjowbH8jDoeBLKf/Hz1Jj/0SMJJCv2VzerbwjrMvuixvglhfoiKRDmGuuk8Bpeks+rpaaIrgqCy6oAlUB8xAFG/UChf5fuoZG9GN1/9h5tiMMCvfcFvyETuAAAIv6CWgj46bvDZlOxc87qeXweaU0TwwX31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=RLE/a0pE; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727873228;
	bh=ydDGm6C3dK+xoowuRzZoMLy/s4R9AW7XsqWeKycwHe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RLE/a0pEhfrESSoOYSrkb14BS2HjhoJ9USNASHL/NyN9Ni3eFbiiw4cgqlnT92E2X
	 1Wq1C8zbBVSHjZWL1X5Z9trmfN3dg9W+jf7Au4T0B4dHfxJ8sm9+3VBEQXp6Un2/bf
	 WFZ0u/kr9aNZJh1NpDkMNxUuQs85AN3sjNFaY0L74aOCiUJqMAKgQQTxecawXoUmFf
	 KPlf5YXJh4ho+uASFvDzKJfW+6GF7lPkjuhvp+1Ex4glL1Wq5mcPAdKMA4V+S2w02d
	 Yr7tD6MOrAf8fG4CgoqBxgkqTgbwbtdNkZvtda2zs6IBdx9SJh3rfp6miUUrXANjBD
	 L5ZiztCvTcFUA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XJZMH73KWzpkR;
	Wed,  2 Oct 2024 08:47:07 -0400 (EDT)
Message-ID: <3d658972-6a9f-4614-9532-d322bdd7c26b@efficios.com>
Date: Wed, 2 Oct 2024 08:45:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] sched: Improve cache locality of RSEQ concurrency
 IDs for intermittent workloads
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 Valentin Schneider <vschneid@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Dmitry Vyukov <dvyukov@google.com>
References: <20240930185920.1149002-1-mathieu.desnoyers@efficios.com>
 <20240930185920.1149002-2-mathieu.desnoyers@efficios.com>
 <CANpmjNOstLxnMOfHy85_tCCrt4PAuZBhzuTbY5OOxG91tEcrjw@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CANpmjNOstLxnMOfHy85_tCCrt4PAuZBhzuTbY5OOxG91tEcrjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-02 11:49, Marco Elver wrote:
> On Mon, 30 Sept 2024 at 21:01, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
>> introduced a per-mm/cpu current concurrency id (mm_cid), which keeps
>> a reference to the concurrency id allocated for each CPU. This reference
>> expires shortly after a 100ms delay.
>>
>> These per-CPU references keep the per-mm-cid data cache-local in
>> situations where threads are running at least once on each CPU within
>> each 100ms window, thus keeping the per-cpu reference alive.
>>
>> However, intermittent workloads behaving in bursts spaced by more than
>> 100ms on each CPU exhibit bad cache locality and degraded performance
>> compared to purely per-cpu data indexing, because concurrency IDs are
>> allocated over various CPUs and cores, therefore losing cache locality
>> of the associated data.
>>
>> Introduce the following changes to improve per-mm-cid cache locality:
>>
>> - Add a "recent_cid" field to the per-mm/cpu mm_cid structure to keep
>>    track of which mm_cid value was last used, and use it as a hint to
>>    attempt re-allocating the same concurrency ID the next time this
>>    mm/cpu needs to allocate a concurrency ID,
>>
>> - Add a per-mm CPUs allowed mask, which keeps track of the union of
>>    CPUs allowed for all threads belonging to this mm. This cpumask is
>>    only set during the lifetime of the mm, never cleared, so it
>>    represents the union of all the CPUs allowed since the beginning of
>>    the mm lifetime. (note that the mm_cpumask() is really arch-specific
>>    and tailored to the TLB flush needs, and is thus _not_ a viable
>>    approach for this)
>>
>> - Add a per-mm nr_cpus_allowed to keep track of the weight of the
>>    per-mm CPUs allowed mask (for fast access),
>>
>> - Add a per-mm nr_cids_used to keep track of the highest concurrency
>>    ID allocated for the mm. This is used for expanding the concurrency ID
>>    allocation within the upper bound defined by:
>>
>>      min(mm->nr_cpus_allowed, mm->mm_users)
>>
>>    When the next unused CID value reaches this threshold, stop trying
>>    to expand the cid allocation and use the first available cid value
>>    instead.
>>
>> Spreading allocation to use all the cid values within the range
>>
>>    [ 0, min(mm->nr_cpus_allowed, mm->mm_users) - 1 ]
>>
>> improves cache locality while preserving mm_cid compactness within the
>> expected user limits.
>>
>> - In __mm_cid_try_get, only return cid values within the range
>>    [ 0, mm->nr_cpus_allowed ] rather than [ 0, nr_cpu_ids ]. This
>>    prevents allocating cids above the number of allowed cpus in
>>    rare scenarios where cid allocation races with a concurrent
>>    remote-clear of the per-mm/cpu cid. This improvement is made
>>    possible by the addition of the per-mm CPUs allowed mask.
>>
>> - In sched_mm_cid_migrate_to, use mm->nr_cpus_allowed rather than
>>    t->nr_cpus_allowed. This criterion was really meant to compare
>>    the number of mm->mm_users to the number of CPUs allowed for the
>>    entire mm. Therefore, the prior comparison worked fine when all
>>    threads shared the same CPUs allowed mask, but not so much in
>>    scenarios where those threads have different masks (e.g. each
>>    thread pinned to a single CPU). This improvement is made
>>    possible by the addition of the per-mm CPUs allowed mask.
>>
>> * Benchmarks
>>
>> Each thread increments 16kB worth of 8-bit integers in bursts, with
>> a configurable delay between each thread's execution. Each thread run
>> one after the other (no threads run concurrently). The order of
>> thread execution in the sequence is random. The thread execution
>> sequence begins again after all threads have executed. The 16kB areas
>> are allocated with rseq_mempool and indexed by either cpu_id, mm_cid
>> (not cache-local), or cache-local mm_cid. Each thread is pinned to its
>> own core.
>>
>> Testing configurations:
>>
>> 8-core/1-L3:        Use 8 cores within a single L3
>> 24-core/24-L3:      Use 24 cores, 1 core per L3
>> 192-core/24-L3:     Use 192 cores (all cores in the system)
>> 384-thread/24-L3:   Use 384 HW threads (all HW threads in the system)
>>
>> Intermittent workload delays between threads: 200ms, 10ms.
>>
>> Hardware:
>>
>> CPU(s):                   384
>>    On-line CPU(s) list:    0-383
>> Vendor ID:                AuthenticAMD
>>    Model name:             AMD EPYC 9654 96-Core Processor
>>      Thread(s) per core:   2
>>      Core(s) per socket:   96
>>      Socket(s):            2
>> Caches (sum of all):
>>    L1d:                    6 MiB (192 instances)
>>    L1i:                    6 MiB (192 instances)
>>    L2:                     192 MiB (192 instances)
>>    L3:                     768 MiB (24 instances)
>>
>> Each result is an average of 5 test runs. The cache-local speedup
>> is calculated as: (cache-local mm_cid) / (mm_cid).
>>
>> Intermittent workload delay: 200ms
>>
>>                       per-cpu     mm_cid    cache-local mm_cid    cache-local speedup
>>                           (ns)      (ns)                  (ns)
>> 8-core/1-L3             1374      19289                  1336            14.4x
>> 24-core/24-L3           2423      26721                  1594            16.7x
>> 192-core/24-L3          2291      15826                  2153             7.3x
>> 384-thread/24-L3        1874      13234                  1907             6.9x
>>
>> Intermittent workload delay: 10ms
>>
>>                       per-cpu     mm_cid    cache-local mm_cid    cache-local speedup
>>                           (ns)      (ns)                  (ns)
>> 8-core/1-L3               662       756                   686             1.1x
>> 24-core/24-L3            1378      3648                  1035             3.5x
>> 192-core/24-L3           1439     10833                  1482             7.3x
>> 384-thread/24-L3         1503     10570                  1556             6.8x
>>
>> [ This deprecates the prior "sched: NUMA-aware per-memory-map concurrency IDs"
>>    patch series with a simpler and more general approach. ]
>>
>> Link: https://lore.kernel.org/lkml/20240823185946.418340-1-mathieu.desnoyers@efficios.com/
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Acked-by: Marco Elver <elver@google.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Valentin Schneider <vschneid@redhat.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Marco Elver <elver@google.com>
>> Cc: Yury Norov <yury.norov@gmail.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> Changes since v0:
>> - On migration, do not move the source cid to the destination cpu if the
>>    destination cpu has a recent cid value set.
>>
>> Changes since v2:
>> - Rebase on v6.11.1.
> 
> I think the versioning and changelog got confused. I see the changes
> from [1] which was already v2 are included in this one.
> 
> [1] https://lore.kernel.org/all/5cf2c0a5-7a99-4294-b316-eee07896ddf6@efficios.com/T/#u

Which means I should have tagged this series [PATCH v3]. Sorry about
that.

> 
> In any case, I'll reiterate my Ack as this looks like an improvement
> for the common case.
> 
> Acked-by: Marco Elver <elver@google.com>

Thanks!

Peter, should I re-send as is with a v3 tag, or is it OK for merge ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


