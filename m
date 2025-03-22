Return-Path: <linux-kernel+bounces-572402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3C9A6CA01
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA15D1899F6E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB261EF38A;
	Sat, 22 Mar 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSBC/1E2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C517E0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742644825; cv=none; b=XELLdlo9KAifCuMZzyviGGcqbHGOpiszR2iHn6gG7B0SzLVtIpwniofoH2MJJofa+0oy41eKxKsgx+iOu5LCceA79UnIUWzEASG/54/vAo0mJVCfnffkH3/3WMEePhhaCFFac4i3qSr+EFpNdgXqkS/ITSzPDhUshAbaFQOinoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742644825; c=relaxed/simple;
	bh=EkOsRHq1DyYqghCpDgd2/RB0ULvElsS3G/3InV58vJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jItDOW+cp2ZMBgOZQgymQtQSCLLkNNU9piJY+3zGAXI4enMMuMJYufTkV8xSGvkMFe+6rIT2bq+baQwJqPyYrt6Cr9WKcxp/klIOPToOthMbT9NWUMJ57SfnERTJ7KToBN+jXDcBZSei/NHGoATl3DJRpAbAZbVEOl7N08oY9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSBC/1E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF95FC4CEDD;
	Sat, 22 Mar 2025 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742644825;
	bh=EkOsRHq1DyYqghCpDgd2/RB0ULvElsS3G/3InV58vJ4=;
	h=Date:From:To:Cc:Subject:From;
	b=aSBC/1E2zXhPdpEglVtbMyKRzJqWwII8Kog5CjVSQsnjZSUiBU8urp8Stp8EBOYCW
	 who+D4muGAMXByqfSn90whs5PgQdHJlN7nbGDx/WzR3uEb+A4Q+AkmtScK+jhdzUII
	 wOd83iJ2CljnpwJ4TpADt+S1n00h3oM0NgBygmrD81ShRykBo4ejVHcH8yiBR3DAuz
	 xVz9d87VX2s8/Ck0oX7bCMV3q8zJG5onONY8EJgF+ZHpAWcXrhObzMwwda4ZJETIbf
	 9DD9t4FN/qsx3UsVZPDVbKOBb/HpAlt020Qtjw6NCp0OIxGYtmzt1Mj/B2kg7HEzxB
	 Z00uaGLZSFL7Q==
Date: Sat, 22 Mar 2025 13:00:21 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [GIT PULL] x86/fpu updates for v6.15
Message-ID: <Z96mVT2u3MMMbtN0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest x86/fpu Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2025-03-22

   # HEAD: dda366083e5ff307a4a728757db874bbfe7550be x86/fpu/xstate: Fix inconsistencies in guest FPU xfeatures

x86/fpu updates for v6.15:

 - Improve crypto performance by making kernel-mode FPU reliably usable
   in softirqs ((Eric Biggers)

 - Fully optimize out WARN_ON_FPU() (Eric Biggers)

 - Initial steps to support Support Intel APX (Advanced Performance Extensions)
   (Chang S. Bae)

 - Fix KASAN for arch_dup_task_struct() (Benjamin Berg)

 - Refine and simplify the FPU magic number check during signal return
   (Chang S. Bae)

 - Fix inconsistencies in guest FPU xfeatures (Chao Gao, Stanislav Spassov)

 - selftests/x86/xstate: Introduce common code for testing extended states
   (Chang S. Bae)

 - Misc fixes and cleanups (Borislav Petkov, Colin Ian King, Uros Bizjak)

 Thanks,

	Ingo

------------------>
Benjamin Berg (2):
      vmlinux.lds.h: Remove entry to place init_task onto init_stack
      x86/fpu: Avoid copying dynamic FP state from init_task in arch_dup_task_struct()

Borislav Petkov (AMD) (1):
      x86/fpu: Clarify the "xa" symbolic name used in the XSTATE* macros

Chang S. Bae (11):
      selftests/x86: Consolidate redundant signal helper functions
      selftests/x86/xstate: Refactor XSAVE helpers for general use
      selftests/x86/xstate: Enumerate and name xstate components
      selftests/x86/xstate: Refactor context switching test
      selftests/x86/xstate: Refactor ptrace ABI test
      selftests/x86/xstate: Introduce signal ABI test
      selftests/x86/xstate: Consolidate test invocations into a single entry
      selftests/x86/xstate: Clarify supported xstates
      selftests/x86/avx: Add AVX tests
      x86/fpu: Refine and simplify the magic number check during signal return
      x86/fpu/xstate: Simplify print_xstate_features()

Chao Gao (1):
      x86/fpu/xstate: Fix inconsistencies in guest FPU xfeatures

Colin Ian King (1):
      selftests/x86/xstate: Fix spelling mistake "hader" -> "header"

Eric Biggers (2):
      x86/fpu: Fully optimize out WARN_ON_FPU()
      x86/fpu: Improve crypto performance by making kernel-mode FPU reliably usable in softirqs

Stanislav Spassov (1):
      x86/fpu: Fix guest FPU state buffer allocation size

Uros Bizjak (1):
      x86/fpu: Use XSAVE{,OPT,C,S} and XRSTOR{,S} mnemonics in xstate.h


 arch/x86/include/asm/fpu/api.h                     |  17 +-
 arch/x86/kernel/fpu/core.c                         |  23 +-
 arch/x86/kernel/fpu/internal.h                     |   2 +-
 arch/x86/kernel/fpu/signal.c                       |  11 +-
 arch/x86/kernel/fpu/xstate.c                       |  30 +-
 arch/x86/kernel/fpu/xstate.h                       |  31 +-
 arch/x86/kernel/process.c                          |   7 +-
 include/asm-generic/vmlinux.lds.h                  |   1 -
 tools/testing/selftests/x86/Makefile               |   6 +-
 tools/testing/selftests/x86/amx.c                  | 442 +------------------
 tools/testing/selftests/x86/avx.c                  |  12 +
 .../testing/selftests/x86/corrupt_xstate_header.c  |  14 +-
 tools/testing/selftests/x86/entry_from_vm86.c      |  24 +-
 tools/testing/selftests/x86/fsgsbase.c             |  24 +-
 tools/testing/selftests/x86/helpers.h              |  28 ++
 tools/testing/selftests/x86/ioperm.c               |  25 +-
 tools/testing/selftests/x86/iopl.c                 |  25 +-
 tools/testing/selftests/x86/ldt_gdt.c              |  18 +-
 tools/testing/selftests/x86/mov_ss_trap.c          |  14 +-
 tools/testing/selftests/x86/ptrace_syscall.c       |  24 +-
 tools/testing/selftests/x86/sigaltstack.c          |  26 +-
 tools/testing/selftests/x86/sigreturn.c            |  24 +-
 tools/testing/selftests/x86/single_step_syscall.c  |  22 -
 tools/testing/selftests/x86/syscall_arg_fault.c    |  12 -
 tools/testing/selftests/x86/syscall_nt.c           |  12 -
 tools/testing/selftests/x86/sysret_rip.c           |  24 +-
 tools/testing/selftests/x86/test_vsyscall.c        |  13 -
 tools/testing/selftests/x86/unwind_vdso.c          |  12 -
 tools/testing/selftests/x86/xstate.c               | 477 +++++++++++++++++++++
 tools/testing/selftests/x86/xstate.h               | 195 +++++++++
 30 files changed, 812 insertions(+), 783 deletions(-)
 create mode 100644 tools/testing/selftests/x86/avx.c
 create mode 100644 tools/testing/selftests/x86/xstate.c
 create mode 100644 tools/testing/selftests/x86/xstate.h

