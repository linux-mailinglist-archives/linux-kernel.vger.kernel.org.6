Return-Path: <linux-kernel+bounces-564677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F12CA65947
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9211D1896E27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC6C1A3031;
	Mon, 17 Mar 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3YbZPgi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/kMyn4G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F901A2381
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230354; cv=none; b=Zwum/e1cIGKAG1IFKwdM3TwBT8Ezs2XzB8rnONLbWxwbwGBF/98tX0An9y5kcT5HRVLvognNHrKUCMrnM0ccOoSXt0m3VG+zGB7nEYbsR85wDPL1SdSR4On5kVxC5MxXBLjp3Stm7wTbY38/FF/7OO2Fr3DmkCnwlNlKKEEyIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230354; c=relaxed/simple;
	bh=hsEDh+FXuLx9NTdy3JG4IFZ0feffgG/Vq0QbD5wEMVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRsa32vK93V88DO/nIYhII0AUKG9UM8mUCemNctPes+TzBa498FRZ1ahvgKJgUWaElN+ZswbpBnm0Dpdgt0A7PNPlp+Gti1gQ4llJbyZoBAqORSKhx5MyRQkJwYOjULS5/rl1pdzmcro/UwlD6eiZSUqz4JTz5KS9DTPukKOifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a3YbZPgi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/kMyn4G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DSUrRlzDo/2i3jKk5S/thoktaQleNXutIuMAY0cSvNg=;
	b=a3YbZPgiM/Y6SpPGdDEzudvBWxkBVt0xs6OeoeVJ8OwO4tYdVYu9VEaNrKZHE89BShZBrC
	V3H3T1c7zCuJIlxJTh06SNu3ucsvLyRpn9zOsLhiiX/5sZznmp1kRXNVnjdfgDk1YELGJy
	YV0GNo/egubyHYTxbNW8PZPjirNzI4XTYQhI/njomCL4l6UrhZsCYbHP3Xa2daJf05BUrK
	JmUxhda2DY6aZEBFZ90kc+tNhi4AyzYK4ziCvsfWv6cId7u04ya71NdLlX6MLeVL1ldO7Z
	j/5U0xZ7JiyezCgL/tlVscWWSAH2HG7VHOm6VN0dvmgEjcD5v/xARI1WRkMBhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DSUrRlzDo/2i3jKk5S/thoktaQleNXutIuMAY0cSvNg=;
	b=m/kMyn4GcJCHpRmWRaWJ/Cu4uF7QXhrr8PHmBVp88mDTvlzp+uU35h8pTpCiTHSA/HGWPr
	RklXOXl0lxmdXxBg==
To: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 00/29] x86: Leaf 0x2 and leaf 0x4 refactorings
Date: Mon, 17 Mar 2025 17:47:16 +0100
Message-ID: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is a v2 of the leaf 0x2 and leaf 0x4 code paths cleanup, in
preparation for the x86-cpuid-db CPUID model on top of this series.

Changelog v2
============

Twelve patches got merged from v1, and they're now at tip/x86/core
(thanks a lot).  Thus, this is on top of tip/x86/core as well.

Apply Ingo Molnar's review remarks:

   - New <asm/cpuid/> header structure matching what is at <asm/fpu/>:

	<asm/cpuid/>
	  |
	  +-- api.h
	  +-- leaf_0x2_api.h
	  `-- types.h

   - Standardize words usage and header file references across commit
     logs and comments (CPUID, vendor names, <header.h>, etc.)

   - Use cpuid_ prefix for all new functions at <asm/cpuid/api.h> and
     <asm/cpuid/leaf_0x2_api.h>.

Note, by the end of this series, leaf 0x2 call sites become:

	const struct leaf_0x2_table *entry;
	union leaf_0x2_regs regs;
	u8 *ptr;

	cpuid_get_leaf_0x2_regs(&regs);
	for_each_leaf_0x2_entry(regs, ptr, entry) {
		switch (entry->c_type) {
			...
		}
	}

Changelog v1
============

https://lkml.kernel.org/r/20250304085152.51092-1-darwi@linutronix.de

As part of the onging x86-cpuid work [*], we've found that the handling
of leaf 0x2 and leaf 0x4 code paths is difficult to work with in its
current state.  This was mostly due to the organic incremental growth of
the x86/cpu and x86/cacheinfo logic since the very early Linux days.

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

Ahmed S. Darwish (25):
  x86: treewide: Introduce x86_vendor_amd_or_hygon()
  x86/cpuid: Refactor <asm/cpuid.h>
  x86/cpu: Remove leaf 0x2 parsing loop and add helpers
  x86/cacheinfo: Use CPUID leaf 0x2 parsing helpers
  x86/cacheinfo: Constify _cpuid4_info_regs instances
  x86/cacheinfo: Align ci_info_init() assignment expressions
  x86/cacheinfo: Standardize _cpuid4_info_regs instance naming
  x86/cacheinfo: Consolidate AMD/Hygon leaf 0x8000001d calls
  x86/cacheinfo: Separate amd_northbridge from _cpuid4_info_regs
  x86/cacheinfo: Move AMD cache_disable_0/1 handling to separate file
  x86/cacheinfo: Use sysfs_emit() for sysfs attributes show()
  x86/cacheinfo: Separate Intel and AMD leaf 0x4 code paths
  x86/cacheinfo: Rename _cpuid4_info_regs to _cpuid4_info
  x86/cacheinfo: Clarify type markers for leaf 0x2 cache descriptors
  x86/cacheinfo: Use enums for cache descriptor types
  x86/cpu: Use enums for TLB descriptor types
  x86/cacheinfo: Use consolidated leaf 0x2 descriptor table
  x86/cpu: Use consolidated leaf 0x2 descriptor table
  x86/cacheinfo: Separate leaf 0x2 handling and post-processing logic
  x86/cacheinfo: Separate Intel leaf 0x4 handling
  x86/cacheinfo: Extract out cache level topology ID calculation
  x86/cacheinfo: Extract out cache self-snoop checks
  x86/cacheinfo: Relocate leaf 0x4 cache_type mapping
  x86/cacheinfo: Introduce cpuid_amd_hygon_has_l3_cache()
  x86/cacheinfo: Apply maintainer-tip coding style fixes

Thomas Gleixner (4):
  x86/cacheinfo: Refactor leaf 0x2 cache descriptor lookup
  x86/cacheinfo: Properly name amd_cpuid4()'s first parameter
  x86/cacheinfo: Use proper name for cacheinfo instances
  x86/cpu: Consolidate CPUID leaf 0x2 tables

 arch/x86/events/amd/uncore.c              |    3 +-
 arch/x86/events/rapl.c                    |    3 +-
 arch/x86/include/asm/cpuid.h              |  218 +----
 arch/x86/include/asm/cpuid/api.h          |  217 +++++
 arch/x86/include/asm/cpuid/leaf_0x2_api.h |   96 ++
 arch/x86/include/asm/cpuid/types.h        |  121 +++
 arch/x86/include/asm/processor.h          |    5 +
 arch/x86/kernel/amd_nb.c                  |   16 +-
 arch/x86/kernel/cpu/Makefile              |    5 +-
 arch/x86/kernel/cpu/amd_cache_disable.c   |  301 ++++++
 arch/x86/kernel/cpu/bugs.c                |   12 +-
 arch/x86/kernel/cpu/cacheinfo.c           | 1041 +++++++--------------
 arch/x86/kernel/cpu/cpu.h                 |    9 +
 arch/x86/kernel/cpu/cpuid_0x2_table.c     |  128 +++
 arch/x86/kernel/cpu/intel.c               |  123 +--
 arch/x86/kernel/cpu/mce/core.c            |    4 +-
 arch/x86/kernel/cpu/mce/severity.c        |    3 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c        |    3 +-
 arch/x86/kvm/svm/svm.c                    |    3 +-
 arch/x86/pci/amd_bus.c                    |    3 +-
 arch/x86/xen/enlighten.c                  |   15 +-
 arch/x86/xen/pmu.c                        |    3 +-
 22 files changed, 1241 insertions(+), 1091 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/api.h
 create mode 100644 arch/x86/include/asm/cpuid/leaf_0x2_api.h
 create mode 100644 arch/x86/include/asm/cpuid/types.h
 create mode 100644 arch/x86/kernel/cpu/amd_cache_disable.c
 create mode 100644 arch/x86/kernel/cpu/cpuid_0x2_table.c

base-commit: 6d536cad0d55e71442b6d65500f74eb85544269e
--
2.48.1

