Return-Path: <linux-kernel+bounces-572277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DFAA6C889
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB3D3BD70E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1031DF721;
	Sat, 22 Mar 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZm23GRA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2F1BD01F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742634641; cv=none; b=bpRqhe0BK9M3ebu1e0peRfAbDpPf8AvivHyRbSVhhXSky9p5ErgDYTkqYIr+bDz8m65Uahyg/j8MxfiEftGZ7+Stf1GQzomeoWyR2G51H9afSKM6cFfTgxB4Vqkrf+Nxi0TyFRaYTbVpupy7i8bcauazQUzYSyrex8uEtJrvyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742634641; c=relaxed/simple;
	bh=CbJfN+p0JoMCq2tPW2pHUPO9zOaH2/Z0gX0GGTIkw7A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f41ioCQnCFvR9VkKW8lADTTvDmmB1UZvXgpQJocH5WES8MhXVQ7Ou05aTxj3knV8aTUrB5lkx5qqpvTxSRVvSihHQx+ANR8hx3PRoKLzmjGtOs8UYFYdEwtsDFUmhoNBAI7gWO0J1NqAMbo7+27mTLHlKYBqwzKlov+dWqYi814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZm23GRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15BEC4CEDD;
	Sat, 22 Mar 2025 09:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742634640;
	bh=CbJfN+p0JoMCq2tPW2pHUPO9zOaH2/Z0gX0GGTIkw7A=;
	h=Date:From:To:Cc:Subject:From;
	b=NZm23GRA/BZ2KCOtoqBs57jRKnQ/qa3J1dBiQvI3KBh8laH5FwFWtG4fahFw/aS2c
	 ZS6bjZ7GxIRiPtOtH5CP2/8cFjxzyKd7PZkQEcUrCxJS1UGun9ifmfVsYF0Nar9b+u
	 fjKunvopT/QgDVCsIXECchJX1JbqDGLqparowJB7P8mtFS/kFlWNR84tGEV2lLLtV/
	 Xv2+gTz/ra25/QyXV4iA1htIn9Legj+iNpPi9t8sQez021Tjq6lXYlkJbaRqXdcfGl
	 X1n+hNYueTxpmkfvQpLp/7ynQsoljI1oeWUE6YSX1pOZKGdqrHtMtl29zpNMgh8huu
	 0AKjuX9W87LOA==
Date: Sat, 22 Mar 2025 10:10:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v6.15
Message-ID: <Z95-jK9QGbkWivvI@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest objtool/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2025-03-22

   # HEAD: 2cbb20b008dba39893f0e296dc8ca312f40a9a0e tracing: Disable branch profiling in noinstr code

Objtool changes for v6.15:

 - The biggest change is the new option to automatically fail
   the build on objtool warnings: CONFIG_OBJTOOL_WERROR.

   While there are no currently known unfixed false positives
   left, such an expansion in the severity of objtool warnings
   inevitably creates a risk of build failures, so it's disabled by
   default and depends on !COMPILE_TEST, so it shouldn't be enabled
   on allyesconfig/allmodconfig builds and won't be forced on people
   who just accept build-time defaults in 'make oldconfig'.

   While the option is strongly recommended, only people who enable
   it explicitly should see it.

   (Josh Poimboeuf)

 - Disable branch profiling in noinstr code with a broad
   brush that includes all of arch/x86/ and kernel/sched/. (Josh Poimboeuf)

 - Create backup object files on objtool errors and print exact
   objtool arguments to make failure analysis easier (Josh Poimboeuf)

 - Improve noreturn handling (Josh Poimboeuf)

 - Improve rodata handling (Tiezhu Yang)

 - Support jump tables, switch tables and goto tables on LoongArch (Tiezhu Yang)

 - Misc cleanups and fixes (Josh Poimboeuf, David Engraf, Ingo Molnar)

 Thanks,

	Ingo

------------------>
David Engraf (1):
      objtool: Hide unnecessary compiler error message

Ingo Molnar (1):
      objtool: Use O_CREAT with explicit mode mask

Josh Poimboeuf (14):
      x86/traps: Make exc_double_fault() consistently noreturn
      objtool: Fix error handling inconsistencies in check()
      objtool: Improve __noreturn annotation warning
      objtool: Update documentation
      objtool: Increase per-function WARN_FUNC() rate limit
      objtool: Remove --unret dependency on --rethunk
      objtool: Consolidate option validation
      objtool: Upgrade "Linked object detected" warning to error
      objtool: Add --output option
      objtool: Add --Werror option
      objtool: Change "warning:" to "error:" for --Werror
      objtool: Create backup on error and print args
      objtool: Add CONFIG_OBJTOOL_WERROR
      tracing: Disable branch profiling in noinstr code

Tiezhu Yang (6):
      objtool: Handle various symbol types of rodata
      objtool: Handle different entry size of rodata
      objtool: Handle PC relative relocation type
      objtool/LoongArch: Add support for switch table
      objtool/LoongArch: Add support for goto table
      LoongArch: Enable jump table for objtool


 arch/loongarch/Kconfig                          |   3 +
 arch/loongarch/Makefile                         |   6 +-
 arch/x86/Kbuild                                 |   4 +
 arch/x86/coco/sev/core.c                        |   2 -
 arch/x86/kernel/head64.c                        |   2 -
 arch/x86/kernel/traps.c                         |  18 +-
 arch/x86/mm/kasan_init_64.c                     |   1 -
 arch/x86/mm/mem_encrypt_amd.c                   |   2 -
 arch/x86/mm/mem_encrypt_identity.c              |   2 -
 drivers/acpi/Makefile                           |   4 +
 drivers/cpuidle/Makefile                        |   3 +
 drivers/idle/Makefile                           |   5 +-
 kernel/Makefile                                 |   5 +
 kernel/entry/Makefile                           |   3 +
 kernel/sched/Makefile                           |   5 +
 kernel/time/Makefile                            |   6 +
 lib/Kconfig.debug                               |  11 ++
 lib/Makefile                                    |   5 +
 scripts/Makefile.lib                            |   1 +
 tools/objtool/Documentation/objtool.txt         | 105 ++++++------
 tools/objtool/Makefile                          |   2 +-
 tools/objtool/arch/loongarch/decode.c           |  28 +++-
 tools/objtool/arch/loongarch/include/arch/elf.h |   7 +
 tools/objtool/arch/loongarch/special.c          | 159 +++++++++++++++++-
 tools/objtool/arch/powerpc/decode.c             |  14 ++
 tools/objtool/arch/x86/decode.c                 |  13 ++
 tools/objtool/builtin-check.c                   | 208 ++++++++++++++++++------
 tools/objtool/check.c                           |  83 +++++-----
 tools/objtool/elf.c                             |   3 -
 tools/objtool/include/objtool/arch.h            |   3 +
 tools/objtool/include/objtool/builtin.h         |   3 +-
 tools/objtool/include/objtool/elf.h             |   2 +-
 tools/objtool/include/objtool/warn.h            |  20 ++-
 tools/objtool/objtool.c                         |  78 +--------
 tools/objtool/orc_dump.c                        |   7 +-
 35 files changed, 571 insertions(+), 252 deletions(-)

