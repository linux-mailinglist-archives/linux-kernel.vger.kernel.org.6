Return-Path: <linux-kernel+bounces-558255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B460A5E384
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8069B17C1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73221256C99;
	Wed, 12 Mar 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5sRscnd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221724291F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803279; cv=none; b=D0GG6EAqJ2kfZVgPh93T8AEo8gUIuPACQiNs+y5OldUKAfTWLvX6eNkFbdQQ6SFMCts892gXV9f2b8cNiVeMbqsNzM9oTHtKfrl4wnK7DDYwvsHbgLuocvWL2/J3aOx69AQZ11xxr+flIfNHSp+nAXbtoAdikSba5bvPPhrkUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803279; c=relaxed/simple;
	bh=9InqYZjNrb0cQQB6hIFIPZXvnns1AsCgqcb98g1xo7A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Sc75F9DghfJhbQx2KQ7q3J66BrvyV8PpM5AZJocJFj9gzI3ktzM3gvlo8AgvSZjoVGUr7hIS+BuKxj5v8U9Q97A4mV5X4Q/TG+A++b0Dc/YISuCLGPxWc+yGN14s5qPlnIEKA/O9PBb8nAU1hYsg7bHUAalfGOwc9MTmmydX9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5sRscnd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741803278; x=1773339278;
  h=date:from:to:cc:subject:message-id;
  bh=9InqYZjNrb0cQQB6hIFIPZXvnns1AsCgqcb98g1xo7A=;
  b=Y5sRscndcbDFM+yMssN680ulCwKAyi4eJxDALMcYSxE+kBJ27haWCl1W
   +jJ1LVsyJ6taYFxzO/F7mm+SmS2+iCxcKcD/oMUWyBFfy38gxUlp9lx7B
   uHsEQ+9aoziD0qP3CQSd3qK1GPx+ndapCqoadQMdREnyVp25Z+T0n4lAM
   qXPzPvs8s663W/GX/0ZzTaNSMerWiklAo3URJveQCChKytuB/Kf7F3Prd
   X3I5C1Nw5qfYWEnxUMukrTIDX2CtPGercQDwkpb7cY6Ds8vEfggsV21l6
   pSPaNRoPkfUa+jlwwYuHhP/qZSBkcC3a5GHQIwi0TxziRMoe4GxxC3PxI
   w==;
X-CSE-ConnectionGUID: 9i2ImMdiQguutYwQQzlaQQ==
X-CSE-MsgGUID: VwPh8di/QQmwu69BU5F4pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42758713"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42758713"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 11:14:38 -0700
X-CSE-ConnectionGUID: 6svrWbk7TRCQblYNe5WC9A==
X-CSE-MsgGUID: Bfxx30L6QZGvHD6Vfw0Sxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="143906826"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 12 Mar 2025 11:14:36 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsQbC-0008nS-0g;
	Wed, 12 Mar 2025 18:14:34 +0000
Date: Thu, 13 Mar 2025 02:14:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 87d07e135725dd8976a5ddbc7dfa968198d9ae91
Message-ID: <202503130258.N075XFFj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: 87d07e135725dd8976a5ddbc7dfa968198d9ae91  Merge branches 'lkmm.2025.02.25a', 'nolibc.2025.03.07a' and 'stop-machine.2025.03.11a' into HEAD

elapsed time: 1458m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250312    gcc-13.2.0
arc                   randconfig-002-20250312    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250312    clang-19
arm                   randconfig-002-20250312    clang-21
arm                   randconfig-003-20250312    clang-19
arm                   randconfig-004-20250312    clang-21
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250312    clang-21
arm64                 randconfig-002-20250312    gcc-14.2.0
arm64                 randconfig-003-20250312    gcc-14.2.0
arm64                 randconfig-004-20250312    gcc-14.2.0
csky                  randconfig-001-20250312    gcc-14.2.0
csky                  randconfig-002-20250312    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250312    clang-21
hexagon               randconfig-002-20250312    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250312    clang-19
i386        buildonly-randconfig-002-20250312    clang-19
i386        buildonly-randconfig-003-20250312    gcc-12
i386        buildonly-randconfig-004-20250312    gcc-12
i386        buildonly-randconfig-005-20250312    gcc-12
i386        buildonly-randconfig-006-20250312    clang-19
i386                                defconfig    clang-19
loongarch             randconfig-001-20250312    gcc-14.2.0
loongarch             randconfig-002-20250312    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250312    gcc-14.2.0
nios2                 randconfig-002-20250312    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250312    gcc-14.2.0
parisc                randconfig-002-20250312    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250312    clang-21
powerpc               randconfig-002-20250312    clang-21
powerpc               randconfig-003-20250312    clang-21
powerpc                     sequoia_defconfig    clang-17
powerpc64             randconfig-001-20250312    clang-17
powerpc64             randconfig-002-20250312    clang-15
powerpc64             randconfig-003-20250312    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250312    clang-21
riscv                 randconfig-002-20250312    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250312    clang-15
s390                  randconfig-002-20250312    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20250312    gcc-14.2.0
sh                    randconfig-002-20250312    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250312    gcc-14.2.0
sparc                 randconfig-002-20250312    gcc-14.2.0
sparc64               randconfig-001-20250312    gcc-14.2.0
sparc64               randconfig-002-20250312    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250312    gcc-12
um                    randconfig-002-20250312    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250312    clang-19
x86_64      buildonly-randconfig-002-20250312    clang-19
x86_64      buildonly-randconfig-003-20250312    gcc-12
x86_64      buildonly-randconfig-004-20250312    clang-19
x86_64      buildonly-randconfig-005-20250312    clang-19
x86_64      buildonly-randconfig-006-20250312    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250312    gcc-14.2.0
xtensa                randconfig-002-20250312    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

