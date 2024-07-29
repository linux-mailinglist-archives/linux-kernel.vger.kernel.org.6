Return-Path: <linux-kernel+bounces-266502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3179400D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC891C2270B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F10E18E743;
	Mon, 29 Jul 2024 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da/KLeJQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30101422C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290635; cv=none; b=gbOmNMfsTEnFQ38Q0PfdbZ5SiG6IwOmaVaQ4Rjc4r6brGpsoHyXOZ6ml0tuOkIVzqhEtSH0nfOiHSWq7OUpJeXbgA2P7SqphvkNGjUfURX0+fMCv5gZBp2Rt+wIr06YNjdNtYGvi0uCR7ntUjjl6aVhGOwYJFGpAsC3o5ExIR50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290635; c=relaxed/simple;
	bh=YR3meciN4HnYSZ6SK8mDvbXK/4ZQLOsMjEC6unzQUys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oP/D2Wp4i9WlLnvQi8m0eeyK/Lcip8nzpGstcTLo8AIvsU6W1WZ/9whW2/Hi37xZE4c4U6/35t0wmN0pcBTA4AZhSvwxGf4+Lg2lGD9l7dMM7a8tCGzqQ7rHMv/3NIWMHayAQXmlQGhRoRh08MvxDjRghBH+3QUiMpvQF9DCQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da/KLeJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1518EC32786;
	Mon, 29 Jul 2024 22:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722290635;
	bh=YR3meciN4HnYSZ6SK8mDvbXK/4ZQLOsMjEC6unzQUys=;
	h=Date:From:To:Cc:Subject:From;
	b=Da/KLeJQsYlFXlkMkFuQi5XUH6sEhQIVPXf4+JZ3VDW4O/hHwfC1iCdG990atu8GZ
	 pT0DJZaklyFE0Ii5WDBdjRJsdFwpqWOSoiIC3Lzmsg6jMtiSQ5Q6WPXIskzfmDcEJE
	 s3TdHXip6SKvFCwLnm8QAyUvr/ZdOT4IHxB1uH+t2eIcU+z02ffjkG5ZsogjyUZqIy
	 dN3Z4DgOIU+ibuHR5LFImiStbHCVzUIjFfls/01Rovk0lY83YLFCErDiVwpGyILyCh
	 HrIqkN845QXISXd/6DyUn+ANMngGZnHImWZtr+NsxDeBtQG7fQLcJ42v1TObGgXbuy
	 IVbQRSD7VrXhQ==
Date: Tue, 30 Jul 2024 00:03:52 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] posix-timers updates
Message-ID: <ZqgRyO-612N37FjU@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thomas,

Please pull the latest tags/posix-timers-2024-07-29 tag from:

  git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git tags/posix-timers-2024-07-29

up to 7f8af7bac5380f2d95a63a6f19964e22437166e1:

  signal: Replace BUG_ON()s (2024-07-29 21:57:35 +0200)

----------------------------------------------------------------
Updates for posix timers and related signal code:

* Prepare posix timers selftests for upcoming changes:

	- Check signal behaviour sanity against SIG_IGN

	- Check signal behaviour sanity against timer
	  reprogramm/deletion

	- Check SIGEV_NONE pending expiry read

	- Check interval timer read on a pending SIGNAL

	- Check correct overrun count after signal block/unblock

* Various consolidations:

	- timer get/set

	- signal queue

* Fixes:
	- Correctly read SIGEV_NONE timers

	- Forward expiry while reading expired interval timers
	  with pending signal

	- Don't arm SIGEV_NONE timers

* Various cleanups all over the place

----------------------------------------------------------------
Thomas Gleixner (24):
      selftests/timers/posix_timers: Simplify error handling
      selftests/timers/posix_timers: Add SIG_IGN test
      selftests/timers/posix_timers: Validate signal rules
      selftests/timers/posix-timers: Validate SIGEV_NONE
      selftests/timers/posix-timers: Validate timer_gettime()
      selftests/timers/posix-timers: Validate overrun after unblock
      posix-cpu-timers: Split up posix_cpu_timer_get()
      posix-cpu-timers: Save interval only for armed timers
      posix-cpu-timers: Handle interval timers correctly in timer_get()
      posix-cpu-timers: Handle SIGEV_NONE timers correctly in timer_get()
      posix-cpu-timers: Handle SIGEV_NONE timers correctly in timer_set()
      posix-cpu-timers: Replace old expiry retrieval in posix_cpu_timer_set()
      posix-cpu-timers: Do not arm SIGEV_NONE timers
      posix-cpu-timers: Use @now instead of @val for clarity
      posix-cpu-timers: Remove incorrect comment in posix_cpu_timer_set()
      posix-cpu-timers: Simplify posix_cpu_timer_set()
      posix-timers: Retrieve interval in common timer_settime() code
      posix-timers: Clear overrun in common_timer_set()
      posix-timers: Convert timer list to hlist
      posix-timers: Consolidate timer setup
      posix-cpu-timers: Make k_itimer::it_active consistent
      posix-timers: Consolidate signal queueing
      signal: Remove task argument from dequeue_signal()
      signal: Replace BUG_ON()s

 fs/proc/base.c                                |   6 +-
 fs/signalfd.c                                 |   4 +-
 include/linux/posix-timers.h                  |   2 +-
 include/linux/sched/signal.h                  |   7 +-
 init/init_task.c                              |   2 +-
 kernel/fork.c                                 |   2 +-
 kernel/signal.c                               |  34 +-
 kernel/time/alarmtimer.c                      |   7 +-
 kernel/time/posix-cpu-timers.c                | 207 ++++------
 kernel/time/posix-timers.c                    |  69 ++--
 kernel/time/posix-timers.h                    |   3 +-
 tools/testing/selftests/timers/posix_timers.c | 550 +++++++++++++++++++++-----
 12 files changed, 607 insertions(+), 286 deletions(-)

