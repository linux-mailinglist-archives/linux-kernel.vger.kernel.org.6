Return-Path: <linux-kernel+bounces-543542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD1A4D6F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789AC18949FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D501FC7C1;
	Tue,  4 Mar 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3taF5hyo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C50YVNwf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8601FBCBF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078338; cv=none; b=pX6XekrwaL7dL9eH4Fdi0Wyq1bMicDHEn9csmD1WRv2beg1HtgCw8g9G9yk8ftM/OJmaGopc5BZTkgBtQbt6THZbg+099OpMJs1NLZWtOfSI7oLzw1qq7X4zUwCz1oErYjfi/ffX5h0mQ7CNrHtS8ESWaO1vz9yT/n6BKv3mPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078338; c=relaxed/simple;
	bh=LTNq1PAvvMwaaiCEIAQDrT7cmsiR7iZxBEs3QUOwm0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXOh3uHRhrKa8OcbUXaZUPohRzL/9zh61BKfCX6tw+UDxaY9TeWN6R7TEAB6OTJlzEghGvFI+kp860NSjOZnuDnOyl+ohnGdf9hsOivQ+D3mverGBFa3Ljpx1C8GkQC4gCp/UW2zf6pNNHyulKmtBTINAJp9RdoJovrvDPB1qjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3taF5hyo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C50YVNwf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zqz2NcPjvHOOoFXSqS0gay6vWbSKLIetdKM7cXiSBcY=;
	b=3taF5hyo2H+wd/vzxlsxkDCpxlndZ6tvo/sF3yTwi2CH1ObvZGpZZepTOmmtAu6sK2ZzPq
	pOp3Vvyqt0rCCfaqsQpefdMzVsQ/aRV0/KuEvKMLnSwFUuNaNIePVfyfoLm6u/A6bX6hGV
	B3l6ZVeY2TJZVV3bBxSOMN4yk6QLtP5eYbz1Wbe6Ixk09HZVSs7i6UCkCNKmR6R7UWv2Mc
	czAZ5fbgPIbZHUkTdA/5+5kzpzxQGxElcH/LTKlrVaTUt8FLDt78uYkpqrHtsudU+ZKtC8
	AwZzmrrvF6Py8hF7soOz/t/DCONHRk5W65D3BSzIL422UPpwuwwjZtzA8GuuyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zqz2NcPjvHOOoFXSqS0gay6vWbSKLIetdKM7cXiSBcY=;
	b=C50YVNwfgvsouc7ks22zHgPWHVf6rA8pYSd/MusrC4phOelQCMn1ZtaJ/zEEtMvDeZO9Cf
	kwfDjJEG5TxkfFDw==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 00/40] x86: Leaf 0x2 and leaf 0x4 refactorings
Date: Tue,  4 Mar 2025 09:51:11 +0100
Message-ID: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

As part of the onging x86-cpuid work [*], we've found that the handling
of leaf 0x2 and leaf 0x4 code paths is difficult to work with in its
current state.  This was mostly due to the organic growth of the x86/cpu
and x86/cacheinfo logic since its very early Linux days.

This series cleans up and refactors these code paths in preparation for
the new x86-cpuid model.

Summary:

- Patches 1 to 3 are independent bugfixes that were discovered during
  this refactoring work.

- Patches 4 to 10 are x86/cpu refactorings for code size and
  readability.

- Patch 10 adds standardized and kernel-doc documented logic for
  accessing leaf 0x2 one byte descriptors.

  This makes the leaf 0x2 sanitization logic centralized in one place.
  x86/cpu and x86/cacheinfo is modified to use such macros afterwards.

- Patches 11 to 28 refactors the x86/cacheinfo code.

  Beside readability, some of the unrelated logic (e.g. AMD northbridge
  cache_disable sysfs code) was first splitted from the generic leaf 0x4
  code paths, at the structure relationships level, then gutted-out into
  their own files.

- Patches 29 to 31 consolidate the existing (loop-based lookup) leaf 0x2
  cache and TLB descriptor tables into one hash-based lookup table.
  This reduces code size while still keeping rodata size in check.

  Standardized macros for accessing this consolidated table are also
  added.  Call sites can now just do:

	const struct leaf_0x2_table *entry;
	union leaf_0x2_regs regs;
	u8 *ptr;

	get_leaf_0x2_regs(&regs);
	for_each_leaf_0x2_entry(regs, ptr, entry) {
		switch (entry->c_type) {
			...
		}
	}

  without need to worry about sanitizing registers, skipping certain
  descriptors, etc.

- Patches 32 and 33 uses the consolidated table above for x86/cpu and
  x86/cacheinfo.

- Patches 34 to 40 provide the final set of x86/refactorings.

This series is based on -rc5.  It also applies cleanly on top of
tip/x86/core.

Note, testing was done by comparing below files:

	/proc/cpuinfo
	/sys/devices/system/cpu/
	/sys/kernel/debug/x86/topo/
	dmesg --notime | grep 'Last level [id]TLB entries'

before and after on various old and new x86 machine configurations.

[*] https://gitlab.com/x86-cpuid.org/x86-cpuid-db
    https://x86-cpuid.org

8<-----

Ahmed S. Darwish (33):
  x86/cacheinfo: Validate cpuid leaf 0x2 EDX output
  x86/cpu: Validate cpuid leaf 0x2 EDX output
  x86/cpu: Properly parse leaf 0x2 TLB descriptor 0x63
  x86/cpuid: Include linux/build_bug.h
  x86/cpu: Remove unnecessary headers and reorder the rest
  x86/cpu: Use max() for leaf 0x2 TLB descriptors parsing
  x86/cpu: Simplify TLB entry count storage
  x86/cpu: Remove leaf 0x2 parsing loop and add helpers
  x86/cacheinfo: Remove unnecessary headers and reorder the rest
  x86/cacheinfo: Use cpuid leaf 0x2 parsing helpers
  x86/cacheinfo: Constify _cpuid4_info_regs instances
  x86/cacheinfo: Align ci_info_init() assignment expressions
  x86/cacheinfo: Standardize _cpuid4_info_regs instance naming
  x86: treewide: Introduce x86_vendor_amd_or_hygon()
  x86/cacheinfo: Consolidate AMD/Hygon leaf 0x8000001d calls
  x86/cacheinfo: Separate amd_northbridge from _cpuid4_info_regs
  x86/cacheinfo: Move AMD cache_disable_0/1 handling to separate file
  x86/cacheinfo: Use sysfs_emit() for sysfs attributes show()
  x86/cacheinfo: Separate Intel and AMD leaf 0x4 code paths
  x86/cacheinfo: Rename _cpuid4_info_regs to _cpuid4_info
  x86/cacheinfo: Clarify type markers for leaf 0x2 cache descriptors
  x86/cacheinfo: Use enums for cache descriptor types
  x86/cpu: Use enums for TLB descriptor types
  sizes.h: Cover all possible x86 cpu cache sizes
  x86/cacheinfo: Use consolidated leaf 0x2 descriptor table
  x86/cpu: Use consolidated leaf 0x2 descriptor table
  x86/cacheinfo: Separate leaf 0x2 handling and post-processing logic
  x86/cacheinfo: Separate intel leaf 0x4 handling
  x86/cacheinfo: Extract out cache level topology ID calculation
  x86/cacheinfo: Extract out cache self-snoop checks
  x86/cacheinfo: Relocate leaf 0x4 cache_type mapping
  x86/cacheinfo: Introduce amd_hygon_cpu_has_l3_cache()
  x86/cacheinfo: Apply maintainer-tip coding style fixes

Thomas Gleixner (7):
  x86/cpu: Get rid of smp_store_cpu_info() indirection
  x86/cpu: Remove unused TLB strings
  x86/cacheinfo: Remove the P4 trace leftovers for real
  x86/cacheinfo: Refactor leaf 0x2 cache descriptor lookup
  x86/cacheinfo: Properly name amd_cpuid4()'s first parameter
  x86/cacheinfo: Use proper name for cacheinfo instances
  x86/cpu: Consolidate CPUID leaf 0x2 tables

 arch/x86/events/amd/uncore.c            |    3 +-
 arch/x86/events/rapl.c                  |    3 +-
 arch/x86/include/asm/cpuid.h            |    1 +
 arch/x86/include/asm/cpuid/types.h      |  173 ++++
 arch/x86/include/asm/processor.h        |   26 +-
 arch/x86/include/asm/smp.h              |    2 -
 arch/x86/kernel/amd_nb.c                |   16 +-
 arch/x86/kernel/cpu/Makefile            |    5 +-
 arch/x86/kernel/cpu/amd.c               |   18 +-
 arch/x86/kernel/cpu/amd_cache_disable.c |  301 +++++++
 arch/x86/kernel/cpu/bugs.c              |   12 +-
 arch/x86/kernel/cpu/cacheinfo.c         | 1062 +++++++----------------
 arch/x86/kernel/cpu/common.c            |   31 +-
 arch/x86/kernel/cpu/cpu.h               |   17 +-
 arch/x86/kernel/cpu/cpuid_0x2_table.c   |  128 +++
 arch/x86/kernel/cpu/hygon.c             |   16 +-
 arch/x86/kernel/cpu/intel.c             |  208 ++---
 arch/x86/kernel/cpu/mce/core.c          |    4 +-
 arch/x86/kernel/cpu/mce/severity.c      |    3 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c      |    3 +-
 arch/x86/kernel/smpboot.c               |   27 +-
 arch/x86/kvm/svm/svm.c                  |    3 +-
 arch/x86/pci/amd_bus.c                  |    3 +-
 arch/x86/xen/enlighten.c                |   15 +-
 arch/x86/xen/pmu.c                      |    3 +-
 arch/x86/xen/smp_pv.c                   |    2 +-
 include/linux/sizes.h                   |    8 +
 27 files changed, 1076 insertions(+), 1017 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/types.h
 create mode 100644 arch/x86/kernel/cpu/amd_cache_disable.c
 create mode 100644 arch/x86/kernel/cpu/cpuid_0x2_table.c

base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
--
2.48.1

