Return-Path: <linux-kernel+bounces-528670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E5A41A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B369416FF28
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4046224BC08;
	Mon, 24 Feb 2025 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3VGNXunB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0CVk7nin"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8032E17557C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392126; cv=none; b=PVCcLa4Ct+fMiqTZSfIdey9Lu2OeINNnkjvBNNhOqj6obUjSWMT6pSQuFa5znLvrYEUZiyckZ+NF+hhIrkmHF/3a8WIhf/CNoaMqYtETkulHRXuoV+8OtX1xGR+6+AsAJprmHVNOAASCOej3x5JugJsEhMaUQIX6l0xAps2aksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392126; c=relaxed/simple;
	bh=o855YPyB7MF1pSbhheBELU0bSkueTWu78hmNgmPvxVQ=;
	h=Message-ID:From:To:Cc:Subject:Date; b=MihgbNxoNXaGdvSxCsJed5KcrpHZu9pkUO31+6SVw8fZ2/GhhaoR9gThS/po0vr/VQhIEQ1zSzxOOygeEdFED7R9znM1PujxNFAVrpSyERaapmoGzzhc43ypij/NSKoDn+Ffo/lEA8W0VDKKS9zW3LLS9hEz03s44pP1V6gXRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3VGNXunB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0CVk7nin; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250224095736.145530367@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740392122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=C/6jzwPpeY3MGtT+2KO+M6Edw1PfD0hqdXJGPVT3Uk4=;
	b=3VGNXunBzbSqOVJalGoNL42y4BTW2sRlgWqprI8xC/iLb4UkcZpum5MDmgg6t3fLbQUr9c
	Jhnn+HOM5rLlcxtBJ05K2YvUNm+iIWyAJ1gHekavueblcuWW+zAcBvWcxrKsOfjSD+8cik
	Pvr6LyojDqxydkzJGCXYbrZcDg5QIrblof4ctUuwSy0bCDmPgmaRtw+77VRdnnzQhNXY7T
	OFAMyaEJ8bnzm8rOSO36JiS/nrX3wlcl66pG0wyh2zYtFBRLCxkFHdbPe6Eos8D9v9sp/T
	/Qnd8XNSvSUpHeH1NJlNuv3hkqbO41ZKv0WdtPFtfszQGqrjHhJg1/y9J4lDRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740392122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=C/6jzwPpeY3MGtT+2KO+M6Edw1PfD0hqdXJGPVT3Uk4=;
	b=0CVk7nincrnzhsv0i2wcYEOOgYbdCkWXZyL9om/Uip5Q+bj7qhAasn5ZDtNee68UTliAJ9
	fK/L8bWIwKOFAgDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 00/11] posix-timers: Rework the global hash table and provide
 a sane mechanism for CRIU
Date: Mon, 24 Feb 2025 11:15:21 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Eric submitted a series a few days ago, which tries to lower the overhead
of the global hash table and the hash lock contention:

  https://lore.kernel.org/all/20250219125522.2535263-1-edumazet@google.com

Unfortunately the approach does not solve the underlying problem.

This also reminded me of the discussion about the global hash table and the
issues created by CRIU:

   https://lore.kernel.org/all/87ednpyyeo.ffs@tglx/

The problem is that CRIU requires a mechanism to recreate the timers with
the same ID as they had at checkpointing. This is achieved by a per process
(signal_struct) counter, which is monotonically increasing. This counter is
utilized to reach the required timer ID by creating and deleting timers up
to the point where the ID matches.

As this is user space ABI, the kernel has no way to remove this
functionality on short notice. So even with per process storage this mode
needs to be preserved, but that does not prevent to implement smarter
mechanisms.

So I picked up the fixes from Eric's series and slightly reworked them as
they should go into the tree first.

On top I built the changes, which rework the global hash table and a
halfways sane mechanism to create timers with a given ID without the
create/delete dance and the counter.

There are actually two real solutions to the hashing problem:

  1) Provide a per process (signal struct) xarray storage

  2) Implement a smarter hash like the one in the futex code

#1 works perfectly fine for most cases, but the fact that CRIU enforced a
   linear increasing timer ID to restore timers makes this problematic.

   It's easy enough to create a sparse timer ID space, which amounts very
   fast to a large junk of memory consumed for the xarray. 2048 timers with
   a ID offset of 512 consume more than one megabyte of memory for the
   xarray storage.

#2 The main advantage of the futex hash is that it uses per hash bucket
   locks instead of a global hash lock. Aside of that it is scaled
   according to the number of CPUs at boot time.

Experiments with artifical benchmarks have shown that a scaled hash with
per bucket locks comes pretty close to the xarray performance and in some
scenarios it performes better.

Test 1:

     A single process creates 20000 timers and afterwards invokes
     timer_getoverrun(2) on each of them:

            mainline        Eric   newhash   xarray
create         23 ms       23 ms      9 ms     8 ms
getoverrun     14 ms       14 ms      5 ms     4 ms

Test 2:

     A single process creates 50000 timers and afterwards invokes
     timer_getoverrun(2) on each of them:

            mainline        Eric   newhash   xarray
create         98 ms      219 ms     20 ms    18 ms
getoverrun     62 ms       62 ms     10 ms     9 ms

Test 3:

     A single process creates 100000 timers and afterwards invokes
     timer_getoverrun(2) on each of them:

            mainline        Eric   newhash   xarray
create        313 ms      750 ms     48 ms    33 ms
getoverrun    261 ms      260 ms     20 ms    14 ms

Erics changes create quite some overhead in the create() path due to the
double list walk, as the main issue according to perf is the list walk
itself. With 100k timers each hash bucket contains ~200 timers, which in
the worst case need to be all inspected. The same problem applies for
getoverrun() where the lookup has to walk through the hash buckets to find
the timer it is looking for.

The scaled hash obviously reduces hash collisions and lock contention
significantly. This becomes more prominent with concurrency.

Test 4:

     A process creates 63 threads and all threads wait on a barrier before
     each instance creates 20000 timers and afterwards invokes
     timer_getoverrun(2) on each of them. The threads are pinned on
     seperate CPUs to achive maximum concurrency. The numbers are the
     average times per thread:

            mainline        Eric   newhash   xarray
create     180239 ms    38599 ms    579 ms   813 ms
getoverrun   2645 ms     2642 ms     32 ms     7 ms

Test 5:

     A process forks 63 times and all forks wait on a barrier before each
     instance creates 20000 timers and afterwards invokes
     timer_getoverrun(2) on each of them. The processes are pinned on
     seperate CPUs to achive maximum concurrency. The numbers are the
     average times per process:

            mainline        eric   newhash   xarray
create     157253 ms    40008 ms     83 ms    60 ms
getoverrun   2611 ms     2614 ms     40 ms     4 ms

So clearly the reduction of lock contention with Eric's changes makes a
significant difference for the create() loop, but the same could have been
achieved with

	 ndelay(total_hashed_timers * $CONSTANT);

The extra lookup just creates enough interleaving to let the other CPUs
make progress, but it does not mitigate the underlying problem of long list
walks, which is clearly visible on the getoverrun() side because that is
purely dominated by the lookup itself. Once the timer is found, the syscall
just reads from the timer structure with no other locks or code paths
involved and returns.

The reason for the difference between the thread and the fork case for the
new hash and the xarray is that both suffer from contention on
sighand::siglock and the xarray suffers additionally from contention on the
xarray lock on insertion.

The only case where the reworked hash slighly outperforms the xarray is a
tight loop which creates and deletes timers.

Test 4:

     A process creates 63 threads and all threads wait on a barrier before
     each instance runs a loop which creates and deletes a timer 100000
     times in a row. The threads are pinned on seperate CPUs to achive
     maximum concurrency. The numbers are the average times per thread:

            mainline        Eric   newhash   xarray
loop	    5917  ms	 5897 ms   5473 ms  7846 ms

Test 5:

     A process forks 63 times and all forks wait on a barrier before each
     each instance runs a loop which creates and deletes a timer 100000
     times in a row. The processes are pinned on seperate CPUs to achive
     maximum concurrency. The numbers are the average times per process:

            mainline        Eric   newhash   xarray
loop	     5137 ms	 7828 ms    891 ms   872 ms

In both test there is not much contention on the hash, but the ucount
accounting for the signal and in the thread case the sighand::siglock
contention (plus the xarray locking) contribute dominantly to the overhead.

As the memory consumption of the xarray in the sparse ID case is
significant, the scaled hash with per bucket locks seems to be the better
overall option. While the xarray has faster lookup times for a large number
of timers, the actual syscall usage, which requires the lookup is not an
extreme hotpath. Most applications utilize signal delivery and all syscalls
except timer_getoverrun(2) are all but cheap.

The next challenge was to provide a mechanism for CRIU to recreate timers
by requesting the ID in the syscall. There is no way to extend
timer_create() in a sane way to achieve that, so in the previous discussion
a new syscall was considered. But that's tedious because timer_create()
requires a sigevent_t argument, which is unfortunately incompatible between
32 and 64 bit applications. That would require either a complete new data
structure or a compat syscall.

After sitting back and thinking more about this, I came to the conclusion,
that a new syscall is overkill. The only use case for this is CRIU. CRIU
creates the timers after recreating the threads, which are "parked" at that
point in the restorer code waiting for a barrier to be released. So there
is no concurrency and the restorer has exclusive control.

That allows to solve this with an prctl(), which enables a 'restore' mode
for timer_create() only for the current process. If this is enabled,
timer_create() expects the requested timer ID to be provided via the
timer_t pointer, which is used to copy the allocated timer ID back to user
space. After creating the timers the restorer disables the 'restore' mode
via prctl() and timer_create() regains it's normal behaviour.

This is backwards compatible because the prctl() fails on older kernels and
CRIU can fall back to the linear timer ID mechanism. CRIU versions which do
not know about the prctl() just work as before.

There is also no dependency on library changes as the CRIU restorer uses
the raw syscalls because it has to avoid modifying the state of the to be
restored process.

The series also reworks the /proc/$PID/timers iterator which was taking
sighand::lock across the walk, which can be trivialy replaced with RCU
protection.

The series survives all posix timer tests and did not show any regressions
so far.

The series is based on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip timers/core

and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/posix

Thanks,

	tglx
---
Eric Dumazet (3):
      posix-timers: Initialise timer before adding it to the hash table
      posix-timers: Add cond_resched() to posix_timer_add() search loop
      posix-timers: Make signal_struct::next_posix_timer_id an atomic_t

Thomas Gleixner (8):
      posix-timers: Cleanup includes
      posix-timers: Remove pointless unlock_timer() wrapper
      posix-timers: Rework timer removal
      posix-timers: Improve hash table performance
      posix-timers: Make per process list RCU safe
      posix-timers: Don't iterate /proc/$PID/timers with sighand::siglock held
      posix-timers: Provide a mechanism to allocate a given timer ID
      selftests/timers/posix-timers: Add a test for exact allocation mode

 fs/proc/base.c                                |   48 +--
 include/linux/posix-timers.h                  |    9 
 include/linux/sched/signal.h                  |    3 
 include/uapi/linux/prctl.h                    |   10 
 kernel/signal.c                               |    2 
 kernel/sys.c                                  |    5 
 kernel/time/posix-timers.c                    |  373 +++++++++++++++-----------
 tools/testing/selftests/timers/posix_timers.c |   68 ++++
 8 files changed, 338 insertions(+), 180 deletions(-)

