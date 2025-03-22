Return-Path: <linux-kernel+bounces-572395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6226A6C9EF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF6317A540
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EDF1FC0FE;
	Sat, 22 Mar 2025 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPNq0h4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F38634D
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742643729; cv=none; b=Zo810Bq/2HJcN4qw+SVxKE8A9D+M54NxL1ZERl3ek1lcGcA8F2oQBvS6EMh7JuksjBscYAxi8/U+zLbsrlK8VsAN88DE4MERwO5vaTOVBCahrgg7whhYRIOj9+7/2mLHtstZMyHL0SNsfcmIwFPCnIh8z7WjgAzzUIcdmvr0pkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742643729; c=relaxed/simple;
	bh=eIemp+Iol2I0D5itYwfTZ4zkWjRifAqm3ObI6YGa6JU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D47YE9JnygNX6cInvIX+9RiM/4Ort/kkcOZj0QuQFV//bkE4Nmrzd/B64dqhdDZv8aC3lrRq38mJ1a8qLlvTm9lGzaIF+F60eqFvRsdkvatNpIO/RvVWJUUKnhg2/4V2Wp+V+ElVyivZurEbb5KIkbEWOyZyNQ3eXOdv1fcDKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPNq0h4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A20C4CEDD;
	Sat, 22 Mar 2025 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742643728;
	bh=eIemp+Iol2I0D5itYwfTZ4zkWjRifAqm3ObI6YGa6JU=;
	h=Date:From:To:Cc:Subject:From;
	b=VPNq0h4y6+fozbbdtduGSh3Vs0eFbfDYNw2mMsto+1Gz8FqWyO0cypRNb/tyewswm
	 WAn+Hzt6cFqSTrRoRWwVWqOazjDl7vgoonswQq1Kw1trdDatNUA4GGAPzv1qWC5DYO
	 w0kvHE7mNN/ZGffidPwqLayj/GEAUIQLVCvThwW3G1byyNfIBbL8MQD/K+oEIKyta8
	 hxQ58FM+dL7NgE+t7LRMSz/vHOA0qhOmubZL6W8PxD4Nn7rvEnLvBT881IUnXVH34E
	 uGP8t/smp/1JKDssn4vdr7WFbYx8WzO4ic0fTK+Q3XMmOR6vm9A0MEt5+P6NGu1MGd
	 Q4tXtz2h4deIw==
Date: Sat, 22 Mar 2025 12:42:04 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/boot updates for v6.15
Message-ID: <Z96iDEs6-HZ7UVa8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/boot Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2025-03-22

   # HEAD: b25eb5f5e419b81f124d5ba2abaaacf1948fb97e x86/kexec: Add relocate_kernel() debugging support: Load a GDT

Updates to the x86 boot code for the v6.15 cycle:

  - Memblock setup and other early boot code cleanups (Mike Rapoport)
  - Export e820_table_kexec[] to sysfs (Dave Young)
  - Baby steps of adding relocate_kernel() debugging support (David Woodhouse)
  - Replace open-coded parity calculation with parity8() (Kuan-Wei Chiu)
  - Move the LA57 trampoline to separate source file (Ard Biesheuvel)
  - Misc micro-optimizations (Uros Bizjak)
  - Drop obsolete E820_TYPE_RESERVED_KERN and related code (Mike Rapoport)

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      x86/boot: Move the LA57 trampoline to separate source file

Dave Young (1):
      x86/kexec: Export e820_table_kexec[] to sysfs

David Woodhouse (1):
      x86/kexec: Add relocate_kernel() debugging support: Load a GDT

Kuan-Wei Chiu (1):
      x86/bootflag: Replace open-coded parity calculation with parity8()

Mike Rapoport (Microsoft) (4):
      x86/boot: Move setting of memblock parameters to e820__memblock_setup()
      x86/boot: Split kernel resources setup into the setup_kernel_resources() helper function
      x86/boot: Split parsing of boot_params into the parse_boot_params() helper function
      x86/e820: Drop obsolete E820_TYPE_RESERVED_KERN and related code

Uros Bizjak (3):
      x86/boot: Change some static bootflag functions to bool
      x86/bootflag: Micro-optimize sbf_write()
      x86/boot: Do not test if AC and ID eflags are changeable on x86_64

Zhou Ding (1):
      x86/boot: Add missing has_cpuflag() prototype


 arch/x86/boot/compressed/Makefile     |   1 +
 arch/x86/boot/compressed/head_64.S    | 103 --------------------------
 arch/x86/boot/compressed/la57toggle.S | 112 ++++++++++++++++++++++++++++
 arch/x86/boot/cpuflags.c              |  26 +++----
 arch/x86/boot/cpuflags.h              |   7 +-
 arch/x86/include/asm/e820/api.h       |   1 -
 arch/x86/include/asm/e820/types.h     |   9 ---
 arch/x86/kernel/bootflag.c            |  29 ++------
 arch/x86/kernel/e820.c                | 115 +++++++++++------------------
 arch/x86/kernel/relocate_kernel_64.S  |  23 ++++++
 arch/x86/kernel/setup.c               | 134 ++++++++++++++++------------------
 arch/x86/kernel/tboot.c               |   3 +-
 arch/x86/mm/init_64.c                 |   8 --
 arch/x86/virt/svm/sev.c               |   1 -
 14 files changed, 266 insertions(+), 306 deletions(-)
 create mode 100644 arch/x86/boot/compressed/la57toggle.S

