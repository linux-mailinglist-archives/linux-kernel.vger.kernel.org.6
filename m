Return-Path: <linux-kernel+bounces-341475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE8E9880AB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97C9B22E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0591898FC;
	Fri, 27 Sep 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1rTBmfaG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B/v0TOYe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CDF165EF1
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426928; cv=none; b=ebTKGD0lhXfSOqPMz6k5HbkXYSAFvwNHpuRsAs6fprfBvIlmBvvGQMpMB/CZuBJMl6tcOUUtxGhEQplmlvZ3kze/TCG5Vewk7TQnMzyugRoPg9NgmAwNKgXh6AHppt9D1CjtykhWcwvltbB+9BwjRPMXUznlQC49mX60eJmguRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426928; c=relaxed/simple;
	bh=Zj6GnmzofEPeaIwNFLl4zb6HomGr37p2ivngjcJUHug=;
	h=Message-ID:From:To:Cc:Subject:Date; b=G+QiQXAiLhrOCq3Dr890NniutyZ4r3GKAVBp+lFjdBXsogDUhNUyE+oYuiz3urHBiWCWBnQ7Sie7dsYEIX4V9olxqQmAi3IFJlOY/8VEfjIg544d0rtNXne9bb0JCpV/e4XLHvDWksnj4YgsTs5CKww7htpTF2VR+7VAMQKw6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1rTBmfaG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B/v0TOYe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927083900.989915582@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=qTFwI4NT3XQxjA+gmEPIhOBSX7tA+Bx+3r2hYp/NWNs=;
	b=1rTBmfaGhpBnpPja6peMQKnR/M+x4klpukf3rJQONNky0GIrThK1GyDW/p5ZVSNNrkApt2
	0hajopOIy39Djoz4bby/s1SDr641mueTDeiedEHkaNcwxZSJR10czlBij4VsG+6J+aK3/k
	B93DAcmOAmgfgBz3Zc5SzwMtZNud8zENh7Yr3VVrruBlCT2VeMbYlq7qOMh1f2ZPGYx8M+
	fyKvCnrMMJhklW7NfqOwV7OuBbgBqhnm8BkhikXRsSQWuKN/Flb+cCjiFWxmum42vm4Su3
	Yb4nVNI5AJT5g5MKJ6zqLtoyJDM85LUFWDzf6+HwVORLBqd0DeipF3EZYl1qVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=qTFwI4NT3XQxjA+gmEPIhOBSX7tA+Bx+3r2hYp/NWNs=;
	b=B/v0TOYewwZEUlbNBM6TzPiHX7saTHiTSA9vge3CUuQkcshqH8NuMX7vUD7idDmSiU/gHg
	IL0bdoOPFdDWADAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch v4 00/27] posix-timers: Cure the SIG_IGN mess
Date: Fri, 27 Sep 2024 10:48:39 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This are the remaining bits to cure the SIG_IGN mess. The preparatory work
from the previous version 3 has been merged already. Version 3 can be found
here:

   https://lore.kernel.org/lkml/20240610163452.591699700@linutronix.de

Last year I reread a 15 years old comment about the SIG_IGN problem:

 "FIXME: What we really want, is to stop this timer completely and restart
  it in case the SIG_IGN is removed. This is a non trivial change which
  involves sighand locking (sigh !), which we don't want to do late in the
  release cycle.  ...  A more complex fix which solves also another related
  inconsistency is already in the pipeline."

The embarrasing part was that I put that comment in back then. So I went
back and rumaged through old notes as I completely had forgotten why our
attempts to fix this back then failed.

It turned out that the comment is about right: sighand locking and life
time issues. So I sat down with the old notes and started to wrap my head
around this again.

The problem to solve:

Posix interval timers are not rearmed automatically by the kernel for
various reasons:

   1) To prevent DoS by extremly short intervals.
   2) To avoid timer overhead when a signal is pending and has not
      yet been delivered.

This is achieved by queueing the signal at timer expiry and rearming the
timer at signal delivery to user space. This puts the rearming basically
under scheduler control and the work happens in context of the task which
asked for the signal.

There is a problem with that vs. SIG_IGN. If a signal has SIG_IGN installed
as handler, the related signals are discarded. So in case of posix interval
timers this means that such a timer is never rearmed even when SIG_IGN is
replaced later with a real handler (including SIG_DFL).

To work around that the kernel self rearms those timers and throttles them
when the interval is smaller than a tick to prevent a DoS.

That just keeps timers ticking, which obviously has effects on power and
just creates work for nothing.

So ideally these timers should be stopped and rearmed when SIG_IGN is
replaced, which aligns with the regular handling of posix timers.

Sounds trivial, but isn't:

  1) Lock ordering.

     The timer lock cannot be taken with sighand lock held which is
     problematic vs. the atomicity of sigaction().

  2) Life time rules

     The timer and the sigqueue are separate entities which requires a
     lookup of the timer ID in the signal rearm code. This can be handled,
     but the separate life time rules are not necessarily robust.

  3) Finding the relevant timers

     Obviosly it is possible to walk the posix timer list under sighand
     lock and handle it from there. That can be expensive especially in the
     case that there are no affected timers as the walk would just end up
     doing nothing.

The following series is a new and this time actually working attempt to
solve this. It addresses it by:

  1) Embedding the preallocated sigqueue into struct k_itimer, which makes
     the life time rules way simpler and just needs a trivial reference
     count.

  2) Having a separate list in task::signal on which ignored timers are
     queued.

     This avoids walking a potentially large timer list for nothing on a
     SIG_IGN to handler transition.

  3) Requeueing the timers signal in the relevant signal queue so the timer
     is rearmed when the signal is actually delivered

     That turned out to be the least complicated way to address the sighand
     lock vs. timer lock ordering issue.

With that timers which have their signal ignored are not longer self
rearmed and the relevant workarounds including throttling for DoS
prevention are removed.

The series is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git posixt-v4

Changes vs. V3:

    - Rebased to mainline
   
    - Fixed up a intermediate build breakage reported by 0-day

Thanks,

	tglx
---
 arch/x86/kernel/signal_32.c            |    2 
 arch/x86/kernel/signal_64.c            |    2 
 drivers/power/supply/charger-manager.c |    3 
 fs/proc/base.c                         |    4 
 fs/timerfd.c                           |    4 
 include/linux/alarmtimer.h             |   10 
 include/linux/posix-timers.h           |   67 +++-
 include/linux/sched/signal.h           |    4 
 include/uapi/asm-generic/siginfo.h     |    2 
 init/init_task.c                       |    5 
 kernel/fork.c                          |    1 
 kernel/signal.c                        |  476 +++++++++++++++++++--------------
 kernel/time/alarmtimer.c               |   87 ------
 kernel/time/itimer.c                   |   22 +
 kernel/time/posix-cpu-timers.c         |   38 +-
 kernel/time/posix-timers.c             |  227 +++++++--------
 kernel/time/posix-timers.h             |    8 
 net/netfilter/xt_IDLETIMER.c           |    4 
 18 files changed, 523 insertions(+), 443 deletions(-)

