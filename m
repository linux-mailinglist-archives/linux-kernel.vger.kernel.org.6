Return-Path: <linux-kernel+bounces-413248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB5C9D15AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFEA284FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4D71C4A3F;
	Mon, 18 Nov 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmqET2bT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D211C4A2A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948321; cv=none; b=Ed9+dEgsGgjhB/QgByshnqcS38jPEfw75TrZsAaCsSmrwvAp3X28D5/BKPWogk+DhGp160DdeOuQudFdeqkRW8sw8NrIGq54ayMHDaFUWRrENthi8GMfs7hbFL02A9aeG1apipvqmH9kZe5UHAoj5WIF//eOJ9sgYcTjNoHAr4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948321; c=relaxed/simple;
	bh=3/I/c+T5x6KzNz+qPcM2ztWytfBcColRnWEbTetnSxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aT5VO8kzOLfuoP24VkuESnKEb0csDgPYkxq48sAVf9eE3e760rf4cAHptvvkTRG9Mz4nzgwKpBa1EVQabU7FQ8TI7HJe/nnOMLaoOvRcdAPlUSs78E6zFuf+U7AHrESB6/FAgkfwtL8wiU3FoqOkA6qaG26BumkAAlxrzhXzdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmqET2bT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC99C4CECC;
	Mon, 18 Nov 2024 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731948320;
	bh=3/I/c+T5x6KzNz+qPcM2ztWytfBcColRnWEbTetnSxQ=;
	h=Date:From:To:Cc:Subject:From;
	b=KmqET2bTJRPUZzFFmvNiVLCDGvAyxRel32Tawo/Q4HlINHUDBIz1mWFZHjZDP+3ax
	 zT2MplllNcgvsOIH2M7WKjS9Kx6X9qIU2jobF06KP5GDCjH2IJbjpIK7mfUyqcXbv9
	 sBkWENa0Fg96YOOCYCePS02KaSGZGZDhd2P7pZYm2v0dxF1Teb19YEOr/IHVY9VFQ1
	 ihIq2O8FXuyZMbkxjnEDMx484V+d/8dNDUx9jY144hQ98uc+y67SWlFp2Oi1BpvZUx
	 PgJPEo6IkFJNZAmm/wUdyr0ePvjolIH0LSHysj3YM87b2cLspit1CIeDR+Lbai5Ksv
	 0W1apCLGjk6FA==
Date: Mon, 18 Nov 2024 06:45:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>
Subject: [GIT PULL] sched_ext: Changes for v6.13
Message-ID: <ZztvH1-v1W4eDGDU@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a759bf0dfc4db3cb6556fc79c7c98da3a46b2b80:

  sched_ext: Update scx_show_state.py to match scx_ops_bypass_depth's new type (2024-11-05 11:45:27 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.13

for you to fetch changes up to 6b8950ef993bcf198d4a80cde0b2da805b75ed70:

  sched_ext: Replace scx_next_task_picked() with switch_class() in comment (2024-11-14 15:30:24 -1000)

----------------------------------------------------------------
sched_ext: Change for v6.13

- Improve the default select_cpu() implementation making it topology aware
  and handle WAKE_SYNC better.

- set_arg_maybe_null() was used to inform the verifier which ops args could
  be NULL in a rather hackish way. Use the new __nullable CFI stub tags
  instead.

- On Sapphire Rapids multi-socket systems, a BPF scheduler, by hammering on
  the same queue across sockets, could live-lock the system to the point
  where the system couldn't make reasonable forward progress. This could
  lead to soft-lockup triggered resets or stalling out bypass mode switch
  and thus BPF scheduler ejection for tens of minutes if not hours. After
  trying a number of mitigations, the following set worked reliably:

  - Injecting artificial cpu_relax() loops in two places while sched_ext is
    trying to turn on the bypass mode.

  - Triggering scheduler ejection when soft-lockup detection is imminent (a
    quarter of threshold left).

  While not the prettiest, the impact both in terms of code complexity and
  overhead is minimal.

- A common complaint on the API is the overuse of the word "dispatch" and
  the confusion around "consume". This is due to how the dispatch queues
  became more generic over time. Rename the affected kfuncs for clarity.
  Thanks to BPF's compatibility features, this change can be made in a way
  that's both forward and backward compatible. The compatibility code will
  be dropped in a few releases.

- Pull sched_ext/for-6.12-fixes to receive a prerequisite change. Other misc
  changes.

----------------------------------------------------------------
Andrea Righi (6):
      sched_ext: improve WAKE_SYNC behavior for default idle CPU selection
      sched_ext: Clarify ops.select_cpu() for single-CPU tasks
      sched_ext: Introduce LLC awareness to the default idle selection policy
      sched_ext: Introduce NUMA awareness to the default idle selection policy
      sched_ext: Do not enable LLC/NUMA optimizations when domains overlap
      sched_ext: Fix incorrect use of bitwise AND

Changwoo Min (2):
      sched_ext: Clarify sched_ext_ops table for userland scheduler
      sched_ext: add a missing rcu_read_lock/unlock pair at scx_select_cpu_dfl()

Tejun Heo (10):
      sched_ext: Factor out move_task_between_dsqs() from scx_dispatch_from_dsq()
      sched_ext: Rename CFI stubs to names that are recognized by BPF
      sched_ext: Replace set_arg_maybe_null() with __nullable CFI stub tags
      Merge branch 'for-6.12-fixes' into for-6.13
      sched_ext: Avoid live-locking bypass mode switching
      sched_ext: Enable the ops breather and eject BPF scheduler on softlockup
      sched_ext: scx_bpf_dispatch_from_dsq_set_*() are allowed from unlocked context
      sched_ext: Rename scx_bpf_dispatch[_vtime]() to scx_bpf_dsq_insert[_vtime]()
      sched_ext: Rename scx_bpf_consume() to scx_bpf_dsq_move_to_local()
      sched_ext: Rename scx_bpf_dispatch[_vtime]_from_dsq*() -> scx_bpf_dsq_move[_vtime]*()

Tianchen Ding (1):
      sched_ext: Use btf_ids to resolve task_struct

Zhang Qiao (2):
      sched/ext: Fix unmatch trailing comment of CONFIG_EXT_GROUP_SCHED
      sched/ext: Use tg_cgroup() to elieminate duplicate code

Zhao Mengmeng (1):
      sched_ext: Replace scx_next_task_picked() with switch_class() in comment

 Documentation/scheduler/sched-ext.rst    |  71 ++-
 include/linux/sched/ext.h                |   2 +
 kernel/sched/ext.c                       | 968 +++++++++++++++++++++----------
 kernel/watchdog.c                        |   8 +
 tools/sched_ext/include/scx/common.bpf.h |  18 +-
 tools/sched_ext/include/scx/compat.bpf.h | 117 +++-
 tools/sched_ext/scx_central.bpf.c        |  14 +-
 tools/sched_ext/scx_flatcg.bpf.c         |  20 +-
 tools/sched_ext/scx_qmap.bpf.c           |  36 +-
 tools/sched_ext/scx_show_state.py        |   2 +
 tools/sched_ext/scx_simple.bpf.c         |  16 +-
 11 files changed, 878 insertions(+), 394 deletions(-)

-- 
tejun

