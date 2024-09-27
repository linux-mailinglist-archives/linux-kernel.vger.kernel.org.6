Return-Path: <linux-kernel+bounces-342119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B79988ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FE21C2290D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDD61C243D;
	Fri, 27 Sep 2024 19:36:38 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6231C242F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465798; cv=none; b=lK0YMTDa0B7v0B2HNYlqpa8d9QSqOimK22C6qnYQDVEnN+jAHfX9syKFFeVTbBWZ05NaLlY6p4PC3HgBonvgkXlaI8DrlZVLWhWere6e885F+IvChw3QWq11JWp9eGGMJ90LG3+lon0n2/ap+NqHDZUaCbuUdtuXknVY/NjDhe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465798; c=relaxed/simple;
	bh=sC4hFjNlUQ0SDOPno3iCpmpUA7Dfvp5eJOCGaC/tLS8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=mL8wG5ObpclnZfSfJIMMopCjWfqkRM+jNm0F2hM5qRIpezZ7iHWvbqVy3ABcBfmGsqX7fnvrD+srwBZmQsP6yh30ivTJ6DKK4wIf3sxWCxH9+HJtMU4sdb1Lj+f4xvVAfLKSv2LOzoBzPzlnyR14uGOAkQy0Zb7iV4xHvsww52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 91DA064CD861;
	Fri, 27 Sep 2024 21:28:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0tq4pwMvCWFM; Fri, 27 Sep 2024 21:28:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0E2D064CD864;
	Fri, 27 Sep 2024 21:28:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5E4KcxzTF_hK; Fri, 27 Sep 2024 21:28:12 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E0E3764CD861;
	Fri, 27 Sep 2024 21:28:12 +0200 (CEST)
Date: Fri, 27 Sep 2024 21:28:12 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1875454673.111023.1727465292786.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML updates for v6.12-rc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Index: xCpkD3WT7efuMYU9z9yiA7gEewPKjA==
Thread-Topic: UML updates for v6.12-rc1

Linus,

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.12-rc1

for you to fetch changes up to 381d2f95c8aa575d5d42bf1fe0ea9a70c4bec0cf:

  um: fix time-travel syscall scheduling hack (2024-09-12 20:46:23 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Removal of dead code (TT mode leftovers, etc.)
- Fixes for the network vector driver
- Fixes for time-travel mode

----------------------------------------------------------------
Anton Ivanov (2):
      um: vector: Replace locks guarding queue depth with atomics
      um: vector: Fix NAPI budget handling

Gaosheng Cui (1):
      um: Remove obsoleted declaration for execute_syscall_skas

Johannes Berg (3):
      um: remove variable stack array in os_rcv_fd_msg()
      um: remove ARCH_NO_PREEMPT_DYNAMIC
      um: fix time-travel syscall scheduling hack

Renzo Davoli (2):
      vector_user: add VDE support
      user_mode_linux_howto_v2: add VDE vector support in doc

Tiwei Bie (7):
      um: Remove unused kpte_clear_flush macro
      um: Remove the redundant newpage check in update_pte_range
      um: Remove unused fields from thread_struct
      um: Remove unused mm_fd field from mm_id
      um: Remove the call to SUBARCH_EXECVE1 macro
      um: Remove the declaration of user_thread function
      um: Remove outdated asm/sysrq.h header

 .../virt/uml/user_mode_linux_howto_v2.rst          |  37 ++++
 arch/um/Kconfig                                    |   1 -
 arch/um/drivers/vector_kern.c                      | 212 +++++++++++----------
 arch/um/drivers/vector_kern.h                      |   4 +-
 arch/um/drivers/vector_user.c                      |  83 ++++++++
 arch/um/include/asm/pgtable.h                      |   7 -
 arch/um/include/asm/processor-generic.h            |  20 +-
 arch/um/include/asm/sysrq.h                        |   8 -
 arch/um/include/shared/skas/mm_id.h                |   5 +-
 arch/um/include/shared/skas/skas.h                 |   2 -
 arch/um/kernel/exec.c                              |   3 -
 arch/um/kernel/process.c                           |   8 +-
 arch/um/kernel/reboot.c                            |   2 +-
 arch/um/kernel/skas/mmu.c                          |  12 +-
 arch/um/kernel/skas/process.c                      |   4 +-
 arch/um/kernel/skas/syscall.c                      |  34 ++--
 arch/um/kernel/sysrq.c                             |   1 -
 arch/um/kernel/time.c                              |   2 +-
 arch/um/kernel/tlb.c                               |  16 +-
 arch/um/os-Linux/file.c                            |   8 +-
 arch/um/os-Linux/skas/mem.c                        |   2 +-
 arch/um/os-Linux/skas/process.c                    |   2 +-
 arch/x86/um/sysrq_32.c                             |   1 -
 arch/x86/um/sysrq_64.c                             |   1 -
 24 files changed, 286 insertions(+), 189 deletions(-)
 delete mode 100644 arch/um/include/asm/sysrq.h

