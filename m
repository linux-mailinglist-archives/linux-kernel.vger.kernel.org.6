Return-Path: <linux-kernel+bounces-553166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD77A5851E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2BC188EC47
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3ED1DE3DC;
	Sun,  9 Mar 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhvmyqKj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BEC9460
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532207; cv=none; b=Mov2+mlwMfzcojb7MK4H1hlX0p8T2g1ZfPSpX8BZPL8kLq1SEnDNZZMZqP9j30ELgTuasbvQr+6XdtKC04ier+lvFJOSosKm5ErMUfzPJDMo0hChSwqQfASnMyjLOVsN+wzOsfWcziAxBGG+s0YfNRdYPIFWC0YkR5zDNHbYPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532207; c=relaxed/simple;
	bh=qCP9OjInYT8omi9lawwRx4SQSaNEaVHOkwM+Dyl8vSM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tiUuIPprzMPVm587oSbIIKDjWilY9UP61EXZoRvqkIcYyF8W0DA9KrjujqVpGP2bHh4z74V4zJbsu+v1lEasETvhhhKmFufAXsFuKj65pmVoztYsNE8E0uhTLMqIHXoS0axd/mp4YkIP9ZvJnElUWVDLjPrb6u8+az9xPaKQTWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhvmyqKj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741532206; x=1773068206;
  h=date:from:to:cc:subject:message-id;
  bh=qCP9OjInYT8omi9lawwRx4SQSaNEaVHOkwM+Dyl8vSM=;
  b=bhvmyqKjGM/5WDp/FXhqUHNO1aF8toZDw0PQ8aQOgVXdcppcRPXWgmks
   P9rplm7s6+W5/XIsuj7DvLvBudfH9ZTPiPGDtUnTcw6lo26NuOwhkSvO+
   7/Fx6eAjNg7SY1I1Qd6vGdxzKsCcKKmf/wFUdhKNqYvrWuw6HYYJVBfkV
   ZBMmpRtGL9MbSNyh9QZSG0CPcKmGlxJJFJREFC6SlUWjOzTwoR6oI2CMk
   TQQqFodAA/CcJLA6nMRxUIV1haf4WrHI2AxUdxyx3BBc/+dXstPpBbrGu
   9RRyHMeysvybq4xhYLwNjckMr0RZmiHp5vlWpRDUUdyihD84bQcEG97qn
   g==;
X-CSE-ConnectionGUID: aYwpEZm1R5+sRuCphgAXnQ==
X-CSE-MsgGUID: McD0/90HQQ6uh3Av52BI9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="41692621"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="41692621"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 07:56:44 -0700
X-CSE-ConnectionGUID: loWoug94ReCMsPLwmx3wYA==
X-CSE-MsgGUID: Zofhukm7QDeU3dll8XvLow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150711423"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 09 Mar 2025 07:56:43 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trI4w-0003Cq-2n;
	Sun, 09 Mar 2025 14:56:36 +0000
Date: Sun, 09 Mar 2025 22:56:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/vdso] BUILD SUCCESS
 886653e36639177dd3ec2e7a4f0dc843d7def3f4
Message-ID: <202503092214.dPw9CWVQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
branch HEAD: 886653e36639177dd3ec2e7a4f0dc843d7def3f4  vdso: Rework struct vdso_time_data and introduce struct vdso_clock

elapsed time: 1447m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250308    gcc-13.2.0
arc                   randconfig-002-20250308    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         nhk8815_defconfig    clang-21
arm                           omap1_defconfig    gcc-14.2.0
arm                   randconfig-001-20250308    gcc-14.2.0
arm                   randconfig-002-20250308    gcc-14.2.0
arm                   randconfig-003-20250308    gcc-14.2.0
arm                   randconfig-004-20250308    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250308    gcc-14.2.0
arm64                 randconfig-002-20250308    gcc-14.2.0
arm64                 randconfig-003-20250308    clang-16
arm64                 randconfig-004-20250308    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250309    gcc-14.2.0
csky                  randconfig-002-20250309    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250309    clang-21
hexagon               randconfig-002-20250309    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250308    gcc-12
i386        buildonly-randconfig-002-20250308    gcc-11
i386        buildonly-randconfig-003-20250308    clang-19
i386        buildonly-randconfig-004-20250308    clang-19
i386        buildonly-randconfig-005-20250308    clang-19
i386        buildonly-randconfig-006-20250308    gcc-12
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250309    gcc-14.2.0
loongarch             randconfig-002-20250309    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-16
mips                     loongson1b_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250309    gcc-14.2.0
nios2                 randconfig-002-20250309    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250309    gcc-14.2.0
parisc                randconfig-002-20250309    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    clang-21
powerpc               randconfig-001-20250309    gcc-14.2.0
powerpc               randconfig-002-20250309    clang-21
powerpc               randconfig-003-20250309    clang-21
powerpc64             randconfig-001-20250309    clang-15
powerpc64             randconfig-002-20250309    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250308    clang-21
riscv                 randconfig-002-20250308    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250308    clang-19
s390                  randconfig-002-20250308    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250308    gcc-14.2.0
sh                    randconfig-002-20250308    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250308    gcc-14.2.0
sparc                 randconfig-002-20250308    gcc-14.2.0
sparc64               randconfig-001-20250308    gcc-14.2.0
sparc64               randconfig-002-20250308    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250308    gcc-12
um                    randconfig-002-20250308    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250308    gcc-12
x86_64      buildonly-randconfig-002-20250308    clang-19
x86_64      buildonly-randconfig-003-20250308    gcc-12
x86_64      buildonly-randconfig-004-20250308    clang-19
x86_64      buildonly-randconfig-005-20250308    clang-19
x86_64      buildonly-randconfig-006-20250308    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250308    gcc-14.2.0
xtensa                randconfig-002-20250308    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

