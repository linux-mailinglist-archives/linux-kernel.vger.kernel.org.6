Return-Path: <linux-kernel+bounces-572724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D3A6CDCF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 04:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571253AC0E4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 03:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBE51B21AD;
	Sun, 23 Mar 2025 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0JDgjWa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536317E0
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742699886; cv=none; b=bnFFI5c6ESvvCbFxFBmfnWAyGw9JCzWKq+leffslLk82Mn+BY6wxhhizuk2yqBTyT7I6tt6RihiKm5/sI6NGakLSaIjoAJaCncxjdW5XHpSL3mCFAosb8BuXjxI+AzFSycRcAo7IzzHgctzQ/uofSj9M3lf/lkChBtbgwUBoMUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742699886; c=relaxed/simple;
	bh=3GbtVYw2T5wWsKXMZwuD7L4SWtaChALTx4uL5ali+zs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X14MLin8lvb+C9XOrEMRFPe4s+Yy2QZxDY57ew9GTnOe2lJrIVTf+tHrvCMpPif25VMBAzXN5TKwmOy0zFGi+RYg+RD3oG6e05PZaR3aJkwsQcmq4QjyivT8kSFNr1+kXYw4DKnQtqz4NAn8IdiZjtOUpKbOdjyEEQx3wqioyMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0JDgjWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85744C4CEDD;
	Sun, 23 Mar 2025 03:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742699885;
	bh=3GbtVYw2T5wWsKXMZwuD7L4SWtaChALTx4uL5ali+zs=;
	h=Date:From:To:Cc:Subject:From;
	b=X0JDgjWas5V8Fra8fDONA0rWm6d5qxqVdzabDls0OqfkwmWN+kD4zPI2tXa7kAUpl
	 NH29/m/RolDlnz2YvKhZzpZPOEeJetrgLvq8RzWGpW0a3wL+7byR1EVlUCE8v/zomF
	 qC4T7b0gQxT6CugQvUJ0fd5HOm89XrzaTlM4cwV0XxAYJwPT3C+Q4BnvR0N0oaw5l6
	 ifeHWZwMeev7wFJN0s8PGf7DJ8QbwlraemK5EcObyfBuWyrGZtxgbRAWo5JaHspO7j
	 1+a4oUsI9KNOjHoUsRnA8C+bLttjt4XbkS3BJk2m7aCObXK8I27cU4aPRvuuoKSSyc
	 bLuA6a0y59TmA==
Date: Sat, 22 Mar 2025 17:18:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Changes for v6.15
Message-ID: <Z999bMA5tftvV28a@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9360dfe4cbd62ff1eb8217b815964931523b75b3:

  sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl() (2025-03-03 07:55:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.15

for you to fetch changes up to e4855fc90e52efef7e3926205c8dc53ce39b6138:

  sched_ext: idle: Refactor scx_select_cpu_dfl() (2025-03-14 08:17:11 -1000)

----------------------------------------------------------------
sched_ext: Changes for v6.15

- Add mechanism to count and report internal events. This significantly
  improves visibility on subtle corner conditions.

- The default idle CPU selection logic is revamped and improved in multiple
  ways including being made topology aware.

- sched_ext was disabling ttwu_queue for simplicity, which can be costly
  when hardware topology is more complex. Implement
  SCX_OPS_ALLOWED_QUEUED_WAKEUP so that BPF schedulers can selectively
  enable ttwu_queue.

- tools/sched_ext updates to improve compatibility among others.

- Other misc updates and fixes.

- sched_ext/for-6.14-fixes were pulled a few times to receive prerequisite
  fixes and resolve conflicts.

----------------------------------------------------------------
Andrea Righi (16):
      sched_ext: Move built-in idle CPU selection policy to a separate file
      mm/numa: Introduce nearest_node_nodemask()
      sched/topology: Introduce for_each_node_numadist() iterator
      sched_ext: idle: Make idle static keys private
      sched_ext: idle: Introduce SCX_OPS_BUILTIN_IDLE_PER_NODE
      sched_ext: idle: Per-node idle cpumasks
      sched_ext: idle: Introduce node-aware idle cpu kfunc helpers
      sched_ext: idle: Introduce scx_bpf_nr_node_ids()
      sched_ext: idle: Fix scx_bpf_pick_any_cpu_node() behavior
      tools/sched_ext: Provide consistent access to scx flags
      selftests/sched_ext: Add NUMA-aware scheduler test
      tools/sched_ext: Provide a compatible helper for scx_bpf_events()
      sched_ext: Documentation: add task lifecycle summary
      sched_ext: Skip per-CPU tasks in scx_bpf_reenqueue_local()
      sched_ext: idle: Honor idle flags in the built-in idle selection policy
      sched_ext: idle: Refactor scx_select_cpu_dfl()

Changwoo Min (18):
      sched_ext: Implement event counter infrastructure
      sched_ext: Add an event, SCX_EV_SELECT_CPU_FALLBACK
      sched_ext: Add an event, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE
      sched_ext: Add an event, SCX_EV_DISPATCH_KEEP_LAST
      sched_ext: Add an event, SCX_EV_ENQ_SKIP_EXITING
      sched_ext: Add an event, SCX_EV_BYPASS_ACTIVATE
      sched_ext: Add an event, SCX_EV_BYPASS_DISPATCH
      sched_ext: Add an event, SCX_EV_BYPASS_DURATION
      sched_ext: Add scx_bpf_events() and scx_read_event() for BPF schedulers
      sched_ext: Print core event count in scx_central scheduler
      sched_ext: Print core event count in scx_qmap scheduler
      sched_ext: Add an event, SCX_EV_ENQ_SLICE_DFL
      sched_ext: Print an event, SCX_EV_ENQ_SLICE_DFL, in scx_qmap/central
      tools/sched_ext: Compatible testing of SCX_ENQ_CPU_SELECTED
      tools/sched_ext: Update enum_defs.autogen.h
      sched_ext: Provides a sysfs 'events' to expose core event counters
      sched_ext: Change the event type from u64 to s64
      sched_ext: Add trace point to track sched_ext core events

Li RongQing (1):
      sched_ext: Take NUMA node into account when allocating per-CPU cpumasks

Tejun Heo (8):
      Merge branch 'for-6.14-fixes' into for-6.15
      tool/sched_ext: Event counter dumping updates
      sched_ext: Count SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE in the right spot
      sched_ext: Add SCX_EV_ENQ_SKIP_MIGRATION_DISABLED
      Merge branch 'for-6.14-fixes' into for-6.15
      sched_ext: Implement SCX_OPS_ALLOW_QUEUED_WAKEUP
      tools/sched_ext: Sync with scx repo
      sched_ext: Merge branch 'for-6.14-fixes' into for-6.15

Yury Norov (2):
      nodemask: add nodes_copy()
      nodemask: numa: reorganize inclusion path

 Documentation/scheduler/sched-ext.rst           |   36 +
 MAINTAINERS                                     |    3 +-
 include/linux/nodemask.h                        |    8 +-
 include/linux/nodemask_types.h                  |   11 +-
 include/linux/numa.h                            |   17 +-
 include/linux/sched/ext.h                       |    1 +
 include/linux/topology.h                        |   30 +
 include/trace/events/sched_ext.h                |   19 +
 kernel/sched/build_policy.c                     |    1 +
 kernel/sched/core.c                             |    9 +-
 kernel/sched/ext.c                              | 1085 +++++++--------------
 kernel/sched/ext.h                              |   10 +
 kernel/sched/ext_idle.c                         | 1171 +++++++++++++++++++++++
 kernel/sched/ext_idle.h                         |   35 +
 mm/mempolicy.c                                  |   31 +
 tools/sched_ext/include/scx/common.bpf.h        |   34 +
 tools/sched_ext/include/scx/common.h            |    1 +
 tools/sched_ext/include/scx/compat.bpf.h        |   95 ++
 tools/sched_ext/include/scx/compat.h            |   16 +-
 tools/sched_ext/include/scx/enum_defs.autogen.h |  120 +++
 tools/sched_ext/scx_central.c                   |   15 +-
 tools/sched_ext/scx_qmap.bpf.c                  |   23 +-
 tools/testing/selftests/sched_ext/Makefile      |    1 +
 tools/testing/selftests/sched_ext/numa.bpf.c    |  100 ++
 tools/testing/selftests/sched_ext/numa.c        |   59 ++
 25 files changed, 2148 insertions(+), 783 deletions(-)
 create mode 100644 kernel/sched/ext_idle.c
 create mode 100644 kernel/sched/ext_idle.h
 create mode 100644 tools/sched_ext/include/scx/enum_defs.autogen.h
 create mode 100644 tools/testing/selftests/sched_ext/numa.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/numa.c

-- 
tejun

