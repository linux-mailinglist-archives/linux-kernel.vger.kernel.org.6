Return-Path: <linux-kernel+bounces-568949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F732A69C93
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F76188EB20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52773223308;
	Wed, 19 Mar 2025 23:09:53 +0000 (UTC)
Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92C221F3A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425792; cv=pass; b=fxsq+7YyMrpWC/I/PHA6T1teySVwB6ralLwG+Fymp3nXbjKnejxw3v1PwicBqDCm67//apFdzyMpy/As4KxLa/CQNHYa0ZpReBZMkvAFguKge09Ec0SKHhfZpAuJGA7Ef5D1bufEjTZPpnxXPjFRrEUAbHRMeGbGupEcAzcOwk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425792; c=relaxed/simple;
	bh=MqedC4jb+7xSFoNxBswHEDtuQOfj3EgYnhVRz5cbDUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTKNz+LhK5hJoMI1ByXr9A1SojZ1nyQlA9SkvK8nXtieV+8bZKnUTntUk87pOWEX5pa6jbhdJcYTWP43N+ztNr6o8YxX2NAVx0zb5RvT74xPHjCle7os4y6cjPJ0yNRcPI/kxvH0FC+K66ZczyC0hssdKuPF2DzQptt2otds6kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AE09B182BCE;
	Wed, 19 Mar 2025 23:00:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a256.dreamhost.com (100-114-55-81.trex-nlb.outbound.svc.cluster.local [100.114.55.81])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 665B4182AD6;
	Wed, 19 Mar 2025 23:00:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1742425222; a=rsa-sha256;
	cv=none;
	b=W8FDJ2MrrgEhknazuZztYoLcDNsbIKnY/VJHidFs5pdDM773+lcCtwlSSIz099ADKfZDEp
	rJBGee4e/NQAEzesUcSQYYP9N3DEIiOfOllGUUiu3l9kKnd6xcPnCo/pFzzANE4Wz39kxy
	xdcDGSlVM8+QPE4toMYuLshgX0xK25/Imatq0ywO6UHDne1+JMGWKkbkvwpMVcdgu3RwrH
	KUvJPFBCq95ttnDRcx+HRzECXMYNi+im86O1w6OHEKuHQ4R7otc7HAz8M31DLEYospm+EG
	EhmOMLjy1fnEBYAcwfCL3z/3Z9dF9L7ZxIGIA6XJPHrYXs0a05ncxGN1jZbekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1742425222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M66vDTr9uFQHHIsxbflMv0B7kp8pQH7JOl3wHWe2bKQ=;
	b=tPSc7WOMQH/PnPvmnIoeWlO4G//MfgLHUxYhmoUylFdFzFoIHTdkb8yvzV/462s2+vqaji
	A4fphhrnE4sPY6U6P2dgsRc+rpKUXP0bBnASAUIgl8YQ9azo4R3u1jXa/tvMV/DlF4QCKY
	HUI23g2dUGK9etw01S4hBeD6URH7QyA5oP7xXeoN/epSrcXfv1RCZgPLNmYbNP9Sd9dBGR
	+fFZFZ1/0n2HqlHQxuCVI0pVof4/Dg8Os9pyuoMFRz591VA4pof/Z2NN8z4KbSB5r82xmx
	bzVQT2vQSpiOQxlckLfCbnAAXTvkMuEZZTzVR2W2WdGrUwSbgNh5Hq88Hyi8Bg==
ARC-Authentication-Results: i=1;
	rspamd-588454d544-vzpl7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Descriptive: 0688a6ab4984de9b_1742425222992_917053809
X-MC-Loop-Signature: 1742425222992:3803010955
X-MC-Ingress-Time: 1742425222992
Received: from pdx1-sub0-mail-a256.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.55.81 (trex/7.0.2);
	Wed, 19 Mar 2025 23:00:22 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a256.dreamhost.com (Postfix) with ESMTPSA id 4ZJ41G6d0Cz1K;
	Wed, 19 Mar 2025 16:00:18 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:00:15 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Michael.Day@amd.com, akpm@linux-foundation.org, bharata@amd.com,
	dave.hansen@intel.com, david@redhat.com,
	dongjoo.linux.dev@gmail.com, feng.tang@intel.com, gourry@gourry.net,
	hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
	jhubbard@nvidia.com, jon.grimm@amd.com, k.shutemov@gmail.com,
	kbusch@meta.com, kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com,
	leillc@google.com, liam.howlett@oracle.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, riel@surriel.com,
	rientjes@google.com, rppt@kernel.org, santosh.shukla@amd.com,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com,
	Jonathan.Cameron@huawei.com, alok.rathore@samsung.com
Subject: Re: [RFC PATCH V1 00/13] mm: slowtier page promotion based on PTE A
 bit
Message-ID: <20250319230015.bewglxf3hrf2mx3f@offworld>
Mail-Followup-To: Raghavendra K T <raghavendra.kt@amd.com>,
	AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Michael.Day@amd.com, akpm@linux-foundation.org, bharata@amd.com,
	dave.hansen@intel.com, david@redhat.com,
	dongjoo.linux.dev@gmail.com, feng.tang@intel.com, gourry@gourry.net,
	hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
	jhubbard@nvidia.com, jon.grimm@amd.com, k.shutemov@gmail.com,
	kbusch@meta.com, kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com,
	leillc@google.com, liam.howlett@oracle.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, riel@surriel.com,
	rientjes@google.com, rppt@kernel.org, santosh.shukla@amd.com,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com,
	Jonathan.Cameron@huawei.com, alok.rathore@samsung.com
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250319193028.29514-1-raghavendra.kt@amd.com>
User-Agent: NeoMutt/20220429

On Wed, 19 Mar 2025, Raghavendra K T wrote:

>Introduction:
>=============
>In the current hot page promotion, all the activities including the
>process address space scanning, NUMA hint fault handling and page
>migration is performed in the process context. i.e., scanning overhead is
>borne by applications.
>
>This is RFC V1 patch series to do (slow tier) CXL page promotion.
>The approach in this patchset assists/addresses the issue by adding PTE
>Accessed bit scanning.
>
>Scanning is done by a global kernel thread which routinely scans all
>the processes' address spaces and checks for accesses by reading the
>PTE A bit.
>
>A separate migration thread migrates/promotes the pages to the toptier
>node based on a simple heuristic that uses toptier scan/access information
>of the mm.
>
>Additionally based on the feedback for RFC V0 [4], a prctl knob with
>a scalar value is provided to control per task scanning.
>
>Initial results show promising number on a microbenchmark. Soon
>will get numbers with real benchmarks and findings (tunings).
>
>Experiment:
>============
>Abench microbenchmark,
>- Allocates 8GB/16GB/32GB/64GB of memory on CXL node
>- 64 threads created, and each thread randomly accesses pages in 4K
>  granularity.
>- 512 iterations with a delay of 1 us between two successive iterations.
>
>SUT: 512 CPU, 2 node 256GB, AMD EPYC.
>
>3 runs, command:  abench -m 2 -d 1 -i 512 -s <size>
>
>Calculates how much time is taken to complete the task, lower is better.
>Expectation is CXL node memory is expected to be migrated as fast as
>possible.
>
>Base case: 6.14-rc6    w/ numab mode = 2 (hot page promotion is enabled).
>patched case: 6.14-rc6 w/ numab mode = 1 (numa balancing is enabled).
>we expect daemon to do page promotion.
>
>Result:
>========
>         base NUMAB2                    patched NUMAB1
>         time in sec  (%stdev)   time in sec  (%stdev)     %gain
> 8GB     134.33       ( 0.19 )        120.52  ( 0.21 )     10.28
>16GB     292.24       ( 0.60 )        275.97  ( 0.18 )      5.56
>32GB     585.06       ( 0.24 )        546.49  ( 0.35 )      6.59
>64GB    1278.98       ( 0.27 )       1205.20  ( 2.29 )      5.76
>
>Base case: 6.14-rc6    w/ numab mode = 1 (numa balancing is enabled).
>patched case: 6.14-rc6 w/ numab mode = 1 (numa balancing is enabled).
>         base NUMAB1                    patched NUMAB1
>         time in sec  (%stdev)   time in sec  (%stdev)     %gain
> 8GB     186.71       ( 0.99 )        120.52  ( 0.21 )     35.45
>16GB     376.09       ( 0.46 )        275.97  ( 0.18 )     26.62
>32GB     744.37       ( 0.71 )        546.49  ( 0.35 )     26.58
>64GB    1534.49       ( 0.09 )       1205.20  ( 2.29 )     21.45

Very promising, but a few things. A more fair comparison would be
vs kpromoted using the PROT_NONE of NUMAB2. Essentially disregarding
the asynchronous migration, and effectively measuring synchronous
vs asynchronous scanning overhead and implied semantics. Essentially
save the extra kthread and only have a per-NUMA node migrator, which
is the common denominator for all these sources of hotness.

Similarly, while I don't see any users disabling NUMAB1 _and_ enabling
this sort of thing, it would be useful to have data on no numa balancing
at all. If nothing else, that would measure the effects of the dest
node heuristics.

Also, data/workload involving demotion would also be good to have for
a more complete picture.

>
>Major Changes since V0:
>======================
>- A separate migration thread is used for migration, thus alleviating need for
>  multi-threaded scanning (atleast as per tracing).
>
>- A simple heuristic for target node calculation is added.
>
>- prctl (David R) interface with scalar value is added to control per task scanning.
>
>- Steve's comment on tracing incorporated.
>
>- Davidlohr's reported bugfix.
>
>- Initial scan delay similar to NUMAB1 mode added.
>
>- Got rid of migration lock during mm_walk.
>
>PS: Occassionally I do see if scanning is too fast compared to migration,
>scanning can stall waiting for lock. Should be fixed in next version by
>using memslot for migration..
>
>Disclaimer, Takeaways and discussion points and future TODOs
>==============================================================
>1) Source code, patch seggregation still to be improved, current patchset only
>provides a skeleton.
>
>2) Unification of source of hotness is not easy (as mentioned perhaps by Jonathan)
>but perhaps all the consumers/producers can work coopertaively.
>
>Scanning:
>3) Major positive: Current patchset is able to cover all the process address
>space scanning effectively with simple algorithms to tune scan_size and scan_period.
>
>4) Effective tracking of folio's or address space using / or ideas used in DAMON
>is yet to be explored fully.
>
>5) Use timestamp information-based migration (Similar to numab mode=2).
>instead of migrating immediately when PTE A bit set.
>(cons:
> - It will not be accurate since it is done outside of process
>context.
> - Performance benefit may be lost.)
>
>Migration:
>
>6) Currently fast scanner can bombard migration list, need to maintain migration list in a more
>organized way (for e.g. using memslot, so that it is also helpful in maintaining recency, frequency
>information (similar to kpromoted posted by Bharata)
>
>7) NUMAB2 throttling is very effective, we would need a common interface to control migration
>and also exploit batch migration.

Does NUMAB2 continue to exist? Are there any benefits in having two sources?

Thanks,
Davidlohr

>
>Thanks to Bharata, Joannes, Gregory, SJ, Chris, David Rientjes, Jonathan, John Hubbard,
>Davidlohr, Ying, Willy, Hyeonggon Yoo and many of you for your valuable comments and support.
>
>Links:
>[1] https://lore.kernel.org/lkml/20241127082201.1276-1-gourry@gourry.net/
>[2] kstaled: https://lore.kernel.org/lkml/1317170947-17074-3-git-send-email-walken@google.com/#r
>[3] https://lore.kernel.org/lkml/Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net/
>[4] RFC V0: https://lore.kernel.org/all/20241201153818.2633616-1-raghavendra.kt@amd.com/
>[5] Recap: https://lore.kernel.org/linux-mm/20241226012833.rmmbkws4wdhzdht6@ed.ac.uk/T/
>[6] LSFMM: https://lore.kernel.org/linux-mm/20250123105721.424117-1-raghavendra.kt@amd.com/#r
>[7] LSFMM: https://lore.kernel.org/linux-mm/20250131130901.00000dd1@huawei.com/
>
>I might have CCed more people or less people than needed
>unintentionally.
>
>Patch organization:
>patch 1-4 initial skeleton for scanning and migration
>patch 5: migration
>patch 6-8: scanning optimizations
>patch 9: target_node heuristic
>patch 10-12: sysfs, vmstat and tracing
>patch 13: A basic prctl implementation.
>
>Raghavendra K T (13):
>  mm: Add kmmscand kernel daemon
>  mm: Maintain mm_struct list in the system
>  mm: Scan the mm and create a migration list
>  mm: Create a separate kernel thread for migration
>  mm/migration: Migrate accessed folios to toptier node
>  mm: Add throttling of mm scanning using scan_period
>  mm: Add throttling of mm scanning using scan_size
>  mm: Add initial scan delay
>  mm: Add heuristic to calculate target node
>  sysfs: Add sysfs support to tune scanning
>  vmstat: Add vmstat counters
>  trace/kmmscand: Add tracing of scanning and migration
>  prctl: Introduce new prctl to control scanning
>
> Documentation/filesystems/proc.rst |    2 +
> fs/exec.c                          |    4 +
> fs/proc/task_mmu.c                 |    4 +
> include/linux/kmmscand.h           |   31 +
> include/linux/migrate.h            |    2 +
> include/linux/mm.h                 |   11 +
> include/linux/mm_types.h           |    7 +
> include/linux/vm_event_item.h      |   10 +
> include/trace/events/kmem.h        |   90 ++
> include/uapi/linux/prctl.h         |    7 +
> kernel/fork.c                      |    8 +
> kernel/sys.c                       |   25 +
> mm/Kconfig                         |    8 +
> mm/Makefile                        |    1 +
> mm/kmmscand.c                      | 1515 ++++++++++++++++++++++++++++
> mm/migrate.c                       |    2 +-
> mm/vmstat.c                        |   10 +
> 17 files changed, 1736 insertions(+), 1 deletion(-)
> create mode 100644 include/linux/kmmscand.h
> create mode 100644 mm/kmmscand.c
>
>
>base-commit: b7f94fcf55469ad3ef8a74c35b488dbfa314d1bb
>--
>2.34.1
>

