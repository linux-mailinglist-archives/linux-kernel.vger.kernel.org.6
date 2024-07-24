Return-Path: <linux-kernel+bounces-261222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8829093B454
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DBE1C2378B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D6915B562;
	Wed, 24 Jul 2024 15:54:19 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2015AD99
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836458; cv=none; b=T9xGo1advjGTQ8keyhJDXRhc5omN3pzLvnzO394vIPCCzIR3CPjpuM377jataXubySBIHuJseCIhmQtMsRN6AmeBgfu0x2htmZyhSTBiMYqkWx0ZpSDSO1fqtx0x7YcJ4s5M7KbQU4QUU72Xt6EjrAIcSRgtheXiZMzKXreimm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836458; c=relaxed/simple;
	bh=1BJLcBATfzkO8eQk7/JSbatzdtbhhwa34p2xzM4ycZ8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=RjMV3LhMpgDUyzRC3xq1IOceansoHZ+s2LPx0+P07bWHX7cH+l/A+AR3IqsMDAavPXHzIJ9HMUc39h3IvQs3StDz/HLGBdBodr77O/G91AB3lY57RX1+eT9hqiKzY00jOnM5/f3oCMIh/oT45GHNYoKLt7NWHwTvqXXBRYh/kC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5E0CB64A3D02;
	Wed, 24 Jul 2024 17:54:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 2N7Ivzn96uxj; Wed, 24 Jul 2024 17:54:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C389E64A3D08;
	Wed, 24 Jul 2024 17:54:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id L0jP27k3j6rD; Wed, 24 Jul 2024 17:54:06 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 99D0064A3D02;
	Wed, 24 Jul 2024 17:54:06 +0200 (CEST)
Date: Wed, 24 Jul 2024 17:54:06 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <158184774.112608.1721836446346.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML Changes for v6.11-rc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: wQNab6Gx6T+BtYDYnsBlJQD6ezYbRg==
Thread-Topic: UML Changes for v6.11-rc1

Linus,

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.11-rc1

for you to fetch changes up to 98ff534ec2cd02496c166614e6c1391d8e092e51:

  um: vector: always reset vp->opened (2024-07-04 12:03:26 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Support for preemption
- i386 Rust support
- Huge cleanup by Benjamin Berg
- UBSAN support
- Removal of dead code

----------------------------------------------------------------
Anton Ivanov (2):
      um: Remove obsolete pcap driver
      um: Enable preemption in UML

Benjamin Berg (16):
      um: irqs: process outstanding IRQs when unblocking signals
      um: chan_user: catch EINTR when reading and writing
      um: chan_user: retry partial writes
      um: chan: use blocking IO for console output for time-travel
      um: Remove stub-data.h include from common-offsets.h
      um: Create signal stack memory assignment in stub_data
      um: Add generic stub_syscall6 function
      um: Rework syscall handling
      um: compress memory related stub syscalls while adding them
      um: remove LDT support
      um: remove copy_context_skas0
      um: Delay flushing syscalls until the thread is restarted
      um: Do not flush MM in flush_thread
      um: remove force_flush_all from fork_handler
      um: simplify and consolidate TLB updates
      um: refactor TLB update handling

David Gow (2):
      arch: um: rust: Use the generated target.json again
      arch: um: rust: Add i386 support for Rust

Dr. David Alan Gilbert (1):
      ubd: Remove unused mutex 'ubd_mutex'

Jeff Johnson (2):
      um: harddog: add missing MODULE_DESCRIPTION() macro
      hostfs: add missing MODULE_DESCRIPTION() macro

Johannes Berg (13):
      um: time-travel: fix time-travel-start option
      um: enable UBSAN
      hostfs: fix dev_t handling
      um: generalize os_rcv_fd
      um: add mmap/mremap OS calls
      um: add shared memory optimisation for time-travel=ext
      um: time-travel: remove time_exit()
      um: time-travel: fix signal blocking race/hang
      um: remove pcap driver from documentation
      um: line: always fill *error_out in setup_one_line()
      um: register power-off handler
      um: vector: remove vp->lock
      um: vector: always reset vp->opened

Mordechay Goodstein (1):
      um: time-travel: support time-travel protocol broadcast messages

Niklas Schnelle (1):
      um: Select HAS_IOREMAP for UML_IOMEM_EMULATION

Tiwei Bie (2):
      um: Remove unused ncpus variable
      um: Remove /proc/sysemu support code

Wei Yang (1):
      um/mm: remove redundant assignment of max_low_pfn

 Documentation/rust/arch-support.rst                |   2 +-
 .../virt/uml/user_mode_linux_howto_v2.rst          |   2 -
 arch/um/Kconfig                                    |   8 +-
 arch/um/drivers/Kconfig                            |  20 -
 arch/um/drivers/Makefile                           |  10 +-
 arch/um/drivers/chan.h                             |   3 +-
 arch/um/drivers/chan_kern.c                        |  81 ++-
 arch/um/drivers/chan_user.c                        |  20 +-
 arch/um/drivers/harddog_kern.c                     |   1 +
 arch/um/drivers/line.c                             |   2 +
 arch/um/drivers/pcap_kern.c                        | 113 -----
 arch/um/drivers/pcap_user.c                        | 137 ------
 arch/um/drivers/pcap_user.h                        |  21 -
 arch/um/drivers/port_kern.c                        |  14 +-
 arch/um/drivers/ubd_kern.c                         |   3 -
 arch/um/drivers/vector_kern.c                      |  19 +-
 arch/um/drivers/vector_kern.h                      |   1 -
 arch/um/drivers/xterm.c                            |   2 +-
 arch/um/drivers/xterm_kern.c                       |  13 +-
 arch/um/include/asm/mmu.h                          |  10 +-
 arch/um/include/asm/mmu_context.h                  |   2 -
 arch/um/include/asm/pgtable.h                      |  32 ++
 arch/um/include/asm/tlbflush.h                     |  46 +-
 arch/um/include/shared/as-layout.h                 |   2 +-
 arch/um/include/shared/common-offsets.h            |   5 -
 arch/um/include/shared/kern_util.h                 |   1 -
 arch/um/include/shared/os.h                        |  33 +-
 arch/um/include/shared/skas/mm_id.h                |   2 +-
 arch/um/include/shared/skas/skas.h                 |   2 +
 arch/um/include/shared/skas/stub-data.h            |  36 +-
 arch/um/include/shared/timetravel.h                |   9 +
 arch/um/include/shared/user.h                      |   8 +
 arch/um/kernel/exec.c                              |   9 -
 arch/um/kernel/irq.c                               |  80 +--
 arch/um/kernel/ksyms.c                             |   2 +-
 arch/um/kernel/mem.c                               |   1 -
 arch/um/kernel/process.c                           |  69 ---
 arch/um/kernel/reboot.c                            |  15 +
 arch/um/kernel/skas/Makefile                       |   9 +-
 arch/um/kernel/skas/clone.c                        |  48 --
 arch/um/kernel/skas/mmu.c                          |  54 +-
 arch/um/kernel/skas/process.c                      |  18 +
 arch/um/kernel/skas/stub.c                         |  69 +++
 arch/um/kernel/time.c                              | 187 ++++++-
 arch/um/kernel/tlb.c                               | 545 ++++-----------------
 arch/um/kernel/trap.c                              |  15 +-
 arch/um/kernel/um_arch.c                           |   3 -
 arch/um/os-Linux/file.c                            |  94 ++--
 arch/um/os-Linux/signal.c                          | 118 ++++-
 arch/um/os-Linux/skas/mem.c                        | 245 +++++----
 arch/um/os-Linux/skas/process.c                    | 124 +----
 arch/um/os-Linux/start_up.c                        |   1 +
 arch/x86/Makefile.um                               |   1 +
 arch/x86/um/Makefile                               |   5 +-
 arch/x86/um/asm/mm_context.h                       |  70 ---
 arch/x86/um/ldt.c                                  | 380 --------------
 arch/x86/um/shared/sysdep/stub.h                   |   2 +-
 arch/x86/um/shared/sysdep/stub_32.h                |  45 +-
 arch/x86/um/shared/sysdep/stub_64.h                |  41 +-
 arch/x86/um/stub_32.S                              |  56 ---
 arch/x86/um/stub_64.S                              |  50 --
 arch/x86/um/tls_32.c                               |   1 +
 fs/hostfs/hostfs.h                                 |   7 +-
 fs/hostfs/hostfs_kern.c                            |  11 +-
 fs/hostfs/hostfs_user.c                            |   7 +-
 include/uapi/linux/um_timetravel.h                 | 190 ++++++-
 rust/Makefile                                      |   2 +-
 scripts/Makefile                                   |   2 +-
 scripts/generate_rust_target.rs                    |  17 +
 69 files changed, 1297 insertions(+), 1956 deletions(-)
 delete mode 100644 arch/um/drivers/pcap_kern.c
 delete mode 100644 arch/um/drivers/pcap_user.c
 delete mode 100644 arch/um/drivers/pcap_user.h
 delete mode 100644 arch/um/kernel/skas/clone.c
 create mode 100644 arch/um/kernel/skas/stub.c
 delete mode 100644 arch/x86/um/asm/mm_context.h
 delete mode 100644 arch/x86/um/ldt.c
 delete mode 100644 arch/x86/um/stub_32.S
 delete mode 100644 arch/x86/um/stub_64.S

