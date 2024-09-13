Return-Path: <linux-kernel+bounces-327471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438D3977663
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679A21C21602
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE9DF78;
	Fri, 13 Sep 2024 01:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFdTRvwh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538DD26D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190641; cv=none; b=SlHL5Lw2R/WfqsA15KECv+WfR6NZAn6eAxShUZ8BQ4Hi/ImSli9hjoeh4d1rLaFWxC1nCqFLi/JeQA1nxAqLvIqWaU/5uti5XuOftLKJj+I9/KrCUAKX7YnynzaxhUXrT1DkFcew1q6k7uL3LjTzhYNrn2DZ5xSWDM+DyBvAe8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190641; c=relaxed/simple;
	bh=k8hyjQ6zLKIyrP6WzPlytEaZuIJwtdW5n/OMi/49T14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=taYp05b+flQ6fG2vaWSMXZkWc0tQM8Y+8t9QNIcw4YJMw54NtdRnhreJyyjajTrC77EA4Pbn+lrN6UIxk9pT4h7zItxyuwJnvh9ZuRYAboM5Pvfc9FRSGB9i7uwfXI0SSz3yRHJXb14B529yGJb127XUQnDnYhkVCIyz1DR7XlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFdTRvwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D19C4CEC3;
	Fri, 13 Sep 2024 01:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726190640;
	bh=k8hyjQ6zLKIyrP6WzPlytEaZuIJwtdW5n/OMi/49T14=;
	h=Date:From:To:Cc:Subject:From;
	b=XFdTRvwhwiBEZif/z7+l/eDa8eHyghI1heqomaa/6lxIO/YXhxYABvNLzMUkxJ1WR
	 8IbkmQiihUfM81GvBZVnd7rAAw9Da7zPE8u/J9Hxxyv2V+IWg5LxW58qDizomLeEEQ
	 2FFaEpAhJAIQgynJLMYtec4ARiQcoraoZ82jXlxRkja//lKBJMpCIae8KQ/SV2tijY
	 C5OECj5Xs8rWZ+M3Kewzd+UM3m5Ykbkqz1RoXX0bmMQbso4bZvKv1/7uyVnqzpp114
	 +x6ToWT+LWai8m6/JPbe7meNr6yGZPhbaTMwDyzMHKb8y1EhmlI683G53I1oTlKftB
	 qpk5JVssHRI3w==
Date: Thu, 12 Sep 2024 15:23:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [GIT PULL] sched_ext: Initial pull request for v6.12
Message-ID: <ZuOULxlZmbvY1skN@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit bc9057da1a220ff2cb6c8885fd5352558aceba2c:

  sched/cpufreq: Use NSEC_PER_MSEC for deadline task (2024-09-11 11:25:22 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12

for you to fetch changes up to 902d67a2d40f5b0815f4f627b26d91f96cc51fb3:

  sched: Move update_other_load_avgs() to kernel/sched/pelt.c (2024-09-11 20:00:21 -1000)

----------------------------------------------------------------
sched_ext: Initial pull request for v6.12

This is the initial pull request of sched_ext. The v7 patchset
(https://lkml.kernel.org/r/20240618212056.2833381-1-tj@kernel.org) is
applied on top of tip/sched/core + bpf/master as of Jun 18th.

  tip/sched/core 793a62823d1c ("sched/core: Drop spinlocks on contention iff kernel is preempti
ble")
  bpf/master f6afdaf72af7 ("Merge branch 'bpf-support-resilient-split-btf'")

Since then, the following pulls were made:

- v6.11-rc1 is pulled to keep up with the mainline.

- tip/sched/core was pulled several times:

  - 7b9f6c864a34, 0df340ceae2e, 5ac998574f93, 0b1777f0fa04: To resolve
    conflicts. See each commit for details on conflicts and their
    resolutions.

  - d7b01aef9dbd: To receive fd03c5b85855 ("sched: Rework pick_next_task()")
    and related commits. @prev in added to sched_class->put_prev_task() and
    put_prev_task() is reordered after ->pick_task(), which makes
    sched_class->switch_class() unnecessary. The follow-up commits update
    sched_ext accordingly and drop sched_class->switch_class().

- bpf/master was pulled to receive baebe9aaba1e ("bpf: allow passing struct
  bpf_iter_<type> as kfunc arguments") and related changes in preparation
  for the DSQ iterator patchset

To obtain the net sched_ext changes, diff against:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git for-6.12-base

which is the merge of:

  tip/sched/core bc9057da1a22 ("sched/cpufreq: Use NSEC_PER_MSEC for deadline task")
  bpf/master 2ad6d23f465 ("selftests/bpf: Do not update vmlinux.h unnecessarily")

Since the v7 patchset, the following changes were made:

- cpuperf support which was a part of the v6 patchset was posted separately
  and then applied after reviews.

- cgroup support which was a part of the v6 patchset was posted seprately,
  iterated and then applied.

- Improve integration with sched core.

- Double locking usage in migration paths dropped. Depend on
  TASK_ON_RQ_MIGRATING synchronization instead.

- The BPF scheduler couldn't directly dispatch to the local DSQ of another
  CPU using a SCX_DSQ_LOCAL_ON verdict. This caused difficulties around
  handling non-wakeup enqueues. Updated so that SCX_DSQ_LOCAL_ON can be used
  in the enqueue path too.

- DSQ iterator which was a part of the v6 patchset was posted separately.
  The iterator itself was applied after a couple revisions. The associated
  selective consumption kfunc can use further improvements and is still
  being worked on.

- scx_bpf_dispatch[_vtime]_from_dsq() added to increase flexibility. A task
  can now be transferred between two DSQs from almost any context. This
  involved significant refactoring of migration code.

- Various fixes and improvements.

As the branch is based on top of tip/sched/core + bpf/master, please merge
after both are applied.

----------------------------------------------------------------
Aboorva Devarajan (1):
      sched_ext: Documentation: Remove mentions of scx_bpf_switch_all

Andrea Righi (2):
      sched_ext: fix typo in set_weight() description
      sched_ext: add CONFIG_DEBUG_INFO_BTF dependency

Colin Ian King (1):
      sched_ext: Fix spelling mistake: "intead" -> "instead"

David Vernet (8):
      sched_ext: Implement runnable task stall watchdog
      sched_ext: Print sched_ext info when dumping stack
      sched_ext: Implement SCX_KICK_WAIT
      sched_ext: Implement sched_ext_ops.cpu_acquire/release()
      sched_ext: Add selftests
      sched_ext: Make scx_bpf_cpuperf_set() @cpu arg signed
      scx: Allow calling sleepable kfuncs from BPF_PROG_TYPE_SYSCALL
      scx/selftests: Verify we can call create_dsq from prog_run

Hongyan Xia (1):
      sched/ext: Add BPF function to fetch rq

Jiapeng Chong (1):
      sched_ext: Fixes incorrect type in bpf_scx_init()

Manu Bretelle (1):
      sched_ext: define missing cfi stubs for sched_ext

Tejun Heo (102):
      Merge branch 'bpf/for-next' into sched_ext-base
      sched: Restructure sched_class order sanity checks in sched_init()
      sched: Allow sched_cgroup_fork() to fail and introduce sched_cancel_fork()
      sched: Add sched_class->reweight_task()
      sched: Add sched_class->switching_to() and expose check_class_changing/changed()
      sched: Factor out cgroup weight conversion functions
      sched: Factor out update_other_load_avgs() from __update_blocked_others()
      sched: Add normal_policy()
      sched_ext: Add boilerplate for extensible scheduler class
      sched_ext: Implement BPF extensible scheduler class
      sched_ext: Add scx_simple and scx_example_qmap example schedulers
      sched_ext: Add sysrq-S which disables the BPF scheduler
      sched_ext: Allow BPF schedulers to disallow specific tasks from joining SCHED_EXT
      sched_ext: Print debug dump after an error exit
      tools/sched_ext: Add scx_show_state.py
      sched_ext: Implement scx_bpf_kick_cpu() and task preemption support
      sched_ext: Add a central scheduler which makes all scheduling decisions on one CPU
      sched_ext: Make watchdog handle ops.dispatch() looping stall
      sched_ext: Add task state tracking operations
      sched_ext: Implement tickless support
      sched_ext: Track tasks that are subjects of the in-flight SCX operation
      sched_ext: Implement sched_ext_ops.cpu_online/offline()
      sched_ext: Bypass BPF scheduler while PM events are in progress
      sched_ext: Implement core-sched support
      sched_ext: Add vtime-ordered priority queue to dispatch_q's
      sched_ext: Documentation: scheduler: Document extensible scheduler class
      sched, sched_ext: Replace scx_next_task_picked() with sched_class->switch_class()
      cpufreq_schedutil: Refactor sugov_cpu_is_busy()
      sched_ext: Add cpuperf support
      sched_ext: Drop tools_clean target from the top-level Makefile
      sched_ext: Swap argument positions in kcalloc() call to avoid compiler warning
      Merge branch 'sched/core' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into for-6.11
      sched, sched_ext: Simplify dl_prio() case handling in sched_fork()
      sched_ext: Account for idle policy when setting p->scx.weight in scx_ops_enable_task()
      sched_ext: Disallow loading BPF scheduler if isolcpus= domain isolation is in effect
      sched_ext: Minor cleanups in kernel/sched/ext.h
      sched, sched_ext: Open code for_balance_class_range()
      sched, sched_ext: Move some declarations from kernel/sched/ext.h to sched.h
      sched_ext: Take out ->priq and ->flags from scx_dsq_node
      sched_ext: Implement DSQ iterator
      sched_ext/scx_qmap: Add an example usage of DSQ iterator
      sched_ext: Reimplement scx_bpf_reenqueue_local()
      sched_ext: Make scx_bpf_reenqueue_local() skip tasks that are being migrated
      sched: Move struct balance_callback definition upward
      sched_ext: Open-code task_linked_on_dsq()
      sched_ext: Unpin and repin rq lock from balance_scx()
      sched_ext: s/SCX_RQ_BALANCING/SCX_RQ_IN_BALANCE/ and add SCX_RQ_IN_WAKEUP
      sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispatches
      sched_ext/scx_qmap: Pick idle CPU for direct dispatch on !wakeup enqueues
      Merge tag 'v6.11-rc1' into for-6.12
      sched_ext: Build fix on !CONFIG_STACKTRACE[_SUPPORT]
      sched_ext: Allow p->scx.disallow only while loading
      Merge branch 'sched/core' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into for-6.12
      sched_ext: Simplify scx_can_stop_tick() invocation in sched_can_stop_tick()
      sched_ext: Add scx_enabled() test to @start_class promotion in put_prev_task_balance()
      sched_ext: Use update_curr_common() in update_curr_scx()
      sched_ext: Simplify UP support by enabling sched_class->balance() in UP
      sched_ext: Improve comment on idle_sched_class exception in scx_task_iter_next_locked()
      sched_ext: Make task_can_run_on_remote_rq() use common task_allowed_on_cpu()
      sched_ext: Fix unsafe list iteration in process_ddsp_deferred_locals()
      sched_ext: Make scx_rq_online() also test cpu_active() in addition to SCX_RQ_ONLINE
      sched_ext: Improve logging around enable/disable
      sched_ext: Don't use double locking to migrate tasks across CPUs
      Merge branch 'tip/sched/core' into for-6.12
      scx_central: Fix smatch checker warning
      sched_ext: Add missing cfi stub for ops.tick
      sched_ext: Use task_can_run_on_remote_rq() test in dispatch_to_local_dsq()
      sched_ext: Use sched_clock_cpu() instead of rq_clock_task() in touch_core_sched()
      Merge branch 'tip/sched/core' into for-6.12
      sched_ext: Don't call put_prev_task_scx() before picking the next task
      sched_ext: Replace SCX_TASK_BAL_KEEP with SCX_RQ_BAL_KEEP
      sched_ext: Unify regular and core-sched pick task paths
      sched_ext: Relocate functions in kernel/sched/ext.c
      sched_ext: Remove switch_class_scx()
      sched_ext: Remove sched_class->switch_class()
      sched_ext: TASK_DEAD tasks must be switched out of SCX on ops_disable
      sched_ext: TASK_DEAD tasks must be switched into SCX on ops_enable
      sched: Expose css_tg()
      sched: Make cpu_shares_read_u64() use tg_weight()
      sched: Introduce CONFIG_GROUP_SCHED_WEIGHT
      sched_ext: Add cgroup support
      sched_ext: Add a cgroup scheduler which uses flattened hierarchy
      Merge branch 'bpf/master' into for-6.12
      sched_ext: Temporarily work around pick_task_scx() being called without balance_scx()
      sched_ext: Add missing static to scx_has_op[]
      sched_ext: Add missing static to scx_dump_data
      sched_ext: Rename scx_kfunc_set_sleepable to unlocked and relocate
      sched_ext: Refactor consume_remote_task()
      sched_ext: Make find_dsq_for_dispatch() handle SCX_DSQ_LOCAL_ON
      sched_ext: Fix processs_ddsp_deferred_locals() by unifying DTL_INVALID handling
      sched_ext: Restructure dispatch_to_local_dsq()
      sched_ext: Reorder args for consume_local/remote_task()
      sched_ext: Move sanity check and dsq_mod_nr() into task_unlink_from_dsq()
      sched_ext: Move consume_local_task() upward
      sched_ext: Replace consume_local_task() with move_local_task_to_local_dsq()
      sched_ext: Compact struct bpf_iter_scx_dsq_kern
      sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()
      scx_qmap: Implement highpri boosting
      sched_ext: Synchronize bypass state changes with rq lock
      sched_ext: Don't trigger ops.quiescent/runnable() on migrations
      Merge branch 'tip/sched/core' into sched_ext/for-6.12
      sched: Move update_other_load_avgs() to kernel/sched/pelt.c

Yipeng Zou (1):
      sched_ext: Allow dequeue_task_scx to fail

 Documentation/scheduler/index.rst                                   |    1
 Documentation/scheduler/sched-ext.rst                               |  316
 MAINTAINERS                                                         |   13
 drivers/tty/sysrq.c                                                 |    1
 include/asm-generic/vmlinux.lds.h                                   |    1
 include/linux/cgroup.h                                              |    4
 include/linux/sched.h                                               |    5
 include/linux/sched/ext.h                                           |  215
 include/linux/sched/task.h                                          |    8
 include/trace/events/sched_ext.h                                    |   32
 include/uapi/linux/sched.h                                          |    1
 init/Kconfig                                                        |   10
 init/init_task.c                                                    |   12
 kernel/Kconfig.preempt                                              |   27
 kernel/fork.c                                                       |   17
 kernel/sched/build_policy.c                                         |   11
 kernel/sched/core.c                                                 |  281
 kernel/sched/cpufreq_schedutil.c                                    |   50
 kernel/sched/debug.c                                                |    3
 kernel/sched/ext.c                                                  | 7173 +++++++++++++++++++
 kernel/sched/ext.h                                                  |   91
 kernel/sched/fair.c                                                 |   23
 kernel/sched/idle.c                                                 |    2
 kernel/sched/pelt.c                                                 |   20
 kernel/sched/pelt.h                                                 |    1
 kernel/sched/sched.h                                                |  190
 kernel/sched/syscalls.c                                             |    7
 lib/dump_stack.c                                                    |    1
 tools/Makefile                                                      |   10
 tools/sched_ext/.gitignore                                          |    2
 tools/sched_ext/Makefile                                            |  246
 tools/sched_ext/README.md                                           |  270
 tools/sched_ext/include/bpf-compat/gnu/stubs.h                      |   11
 tools/sched_ext/include/scx/common.bpf.h                            |  412 +
 tools/sched_ext/include/scx/common.h                                |   75
 tools/sched_ext/include/scx/compat.bpf.h                            |   28
 tools/sched_ext/include/scx/compat.h                                |  186
 tools/sched_ext/include/scx/user_exit_info.h                        |  111
 tools/sched_ext/scx_central.bpf.c                                   |  361
 tools/sched_ext/scx_central.c                                       |  135
 tools/sched_ext/scx_flatcg.bpf.c                                    |  949 ++
 tools/sched_ext/scx_flatcg.c                                        |  233
 tools/sched_ext/scx_flatcg.h                                        |   51
 tools/sched_ext/scx_qmap.bpf.c                                      |  827 ++
 tools/sched_ext/scx_qmap.c                                          |  153
 tools/sched_ext/scx_show_state.py                                   |   39
 tools/sched_ext/scx_simple.bpf.c                                    |  156
 tools/sched_ext/scx_simple.c                                        |  107
 tools/testing/selftests/sched_ext/.gitignore                        |    6
 tools/testing/selftests/sched_ext/Makefile                          |  218
 tools/testing/selftests/sched_ext/config                            |    9
 tools/testing/selftests/sched_ext/create_dsq.bpf.c                  |   58
 tools/testing/selftests/sched_ext/create_dsq.c                      |   57
 tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c         |   42
 tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.c             |   57
 tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c        |   39
 tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.c            |   56
 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c                |   65
 tools/testing/selftests/sched_ext/dsp_local_on.c                    |   58
 tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c       |   21
 tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c           |   60
 tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c        |   43
 tools/testing/selftests/sched_ext/enq_select_cpu_fails.c            |   61
 tools/testing/selftests/sched_ext/exit.bpf.c                        |   84
 tools/testing/selftests/sched_ext/exit.c                            |   55
 tools/testing/selftests/sched_ext/exit_test.h                       |   20
 tools/testing/selftests/sched_ext/hotplug.bpf.c                     |   61
 tools/testing/selftests/sched_ext/hotplug.c                         |  168
 tools/testing/selftests/sched_ext/hotplug_test.h                    |   15
 tools/testing/selftests/sched_ext/init_enable_count.bpf.c           |   53
 tools/testing/selftests/sched_ext/init_enable_count.c               |  166
 tools/testing/selftests/sched_ext/maximal.bpf.c                     |  164
 tools/testing/selftests/sched_ext/maximal.c                         |   51
 tools/testing/selftests/sched_ext/maybe_null.bpf.c                  |   36
 tools/testing/selftests/sched_ext/maybe_null.c                      |   49
 tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c         |   25
 tools/testing/selftests/sched_ext/maybe_null_fail_yld.bpf.c         |   28
 tools/testing/selftests/sched_ext/minimal.bpf.c                     |   21
 tools/testing/selftests/sched_ext/minimal.c                         |   58
 tools/testing/selftests/sched_ext/prog_run.bpf.c                    |   33
 tools/testing/selftests/sched_ext/prog_run.c                        |   78
 tools/testing/selftests/sched_ext/reload_loop.c                     |   75
 tools/testing/selftests/sched_ext/runner.c                          |  201
 tools/testing/selftests/sched_ext/scx_test.h                        |  131
 tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c              |   40
 tools/testing/selftests/sched_ext/select_cpu_dfl.c                  |   72
 tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c   |   89
 tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c       |   72
 tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c         |   41
 tools/testing/selftests/sched_ext/select_cpu_dispatch.c             |   70
 tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c |   37
 tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.c     |   56
 tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c |   38
 tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.c     |   56
 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c            |   92
 tools/testing/selftests/sched_ext/select_cpu_vtime.c                |   59
 tools/testing/selftests/sched_ext/test_example.c                    |   49
 tools/testing/selftests/sched_ext/util.c                            |   71
 tools/testing/selftests/sched_ext/util.h                            |   13
 99 files changed, 16029 insertions(+), 126 deletions(-)

-- 
tejun

