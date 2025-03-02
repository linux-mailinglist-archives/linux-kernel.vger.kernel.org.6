Return-Path: <linux-kernel+bounces-540738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CEDA4B46E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1351188CFC0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459AC1EB1BC;
	Sun,  2 Mar 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c51mwfy8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iugWUrhb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C3C1C5D59
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944206; cv=none; b=tz+DGSPhuMzfi/KsUDcVapImSEq3z71ml/AtzSjFZ2LIKxYtd1MGNPqZZrBNGs8xeg7PVZOB9y1lS2mBMLoyf//nHcqNhKEatCnYH8TWrRrtmqFCHQU667jbXeuiFFUBqycDQCCB3sVTP0Bh0xeQcEbLpR+9cW+H5v0kt0jV/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944206; c=relaxed/simple;
	bh=AKXqU/Vi41ODr7wcCKNP8JX8eVDns7nsjJYI72WqjVo=;
	h=Message-ID:From:To:Cc:Subject:Date; b=OkFNhkOWuSr75o56U1AZ1H/O6942HC11W8mtRs0L/DfgAStPrdyabFGtWBoRnla5lo1LRhDQu8rrWCgz9iM4pFQiJs7tboAnFhBpIkEyjMplA4fMtfEfaAf57f9An2amaMCMivMrT+Z06tkVvoemmcrug3W2yXL1BXq7smogfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c51mwfy8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iugWUrhb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302185753.311903554@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=Q/mV007jYcayTmph+9LmwJ9INtOxvOPoJygA6b9i+8A=;
	b=c51mwfy8aHU0Zx546UA1AuSln4fU2Y6lS4YP8/FNdJ9RyXhdnffOwJ9hrOCVLsCNyDO44g
	RF5LUaCxMjD46QohzT8MkEM6hiJ6Y6j+YOHU4fWuxrxxF+TfPJGk4Rzw9ZlgnAv7pIPi9i
	KFijh2Sw2fzDXPKnFyrAVPFdV3cL6h7ADHAF6BOCjIM3g5MuCT1gjbUktmBL9Vh2JaJEDX
	Bzsh6TAe5w9GHNAeG50TS0z34Pw5LEJk6pZhP6qPFO15ZwAb8Tmj+6mO8akP9Iq8vJkpqr
	OW+s/F8IAlGuafjjleaUpjKvcdA6mBdo6lxytCGgL8lAEfYkHHjEQx6+nTCu6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=Q/mV007jYcayTmph+9LmwJ9INtOxvOPoJygA6b9i+8A=;
	b=iugWUrhbdEQAwdP7UXJgtaGHf+pRGBrcJLHcq/dZIDBBS+YmRyQ6Zh3FndFUmlJacLpE+p
	YIGXQiIHDPnQFPDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 00/17] posix-timers: Rework the global hash table and
 provide a sane mechanism for CRIU
Date: Sun,  2 Mar 2025 20:36:42 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up on V1 of this work, which can be found here:

     https://lore.kernel.org/all/20250224095736.145530367@linutronix.de

It addresses the scalability problem of the posix timer hash and provides a
performant mechanism to restore Posix timers with a given ID along with a
couple of preperatory cleanups and enhancements. More details about
implementation choices are in the change logs and the cover letter of V1.

Changes vs. V1:

  - Simplify the timer removal cleanup - PeterZ
  - Use guards consistently - PeterZ
  - Switch to jhash32()
  - Avoid false sharing by reordering struct k_itimer
  - Advance the ID counter when restoring
  - A few additional cleanups

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

Peter Zijlstra (1):
      posix-timers: Make lock_timer() use guard()

Thomas Gleixner (13):
      posix-timers: Cleanup includes
      posix-timers: Remove a few paranoid warnings
      posix-timers: Remove SLAB_PANIC from kmem cache
      posix-timers: Use guards in a few places
      posix-timers: Simplify lock/unlock_timer()
      posix-timers: Rework timer removal
      posix-timers: Improve hash table performance
      posix-timers: Switch to jhash32()
      posix-timers: Avoid false cacheline sharing
      posix-timers: Make per process list RCU safe
      posix-timers: Don't iterate /proc/$PID/timers with sighand::siglock held
      posix-timers: Provide a mechanism to allocate a given timer ID
      selftests/timers/posix-timers: Add a test for exact allocation mode

 fs/proc/base.c                                |   48 --
 include/linux/cleanup.h                       |   22 -
 include/linux/posix-timers.h                  |   30 +
 include/linux/sched/signal.h                  |    3 
 include/uapi/linux/prctl.h                    |   10 
 kernel/signal.c                               |    2 
 kernel/sys.c                                  |    5 
 kernel/time/posix-timers.c                    |  530 +++++++++++++-------------
 tools/testing/selftests/timers/posix_timers.c |   60 ++
 9 files changed, 403 insertions(+), 307 deletions(-)



