Return-Path: <linux-kernel+bounces-536724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6B6A4836B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C1B174DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E7526E141;
	Thu, 27 Feb 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KijW+0SP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E93426D5AF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671063; cv=none; b=NUgDmafANYY/Wgjad9ENEIjb7WbzXS/hOXM1TyyAuD1LjSxWY9Y8fwvMwxQ7TdA2DupusTg+LIbxB2CGYZztuhgIB5TC5ekGoPWyTWC8J5DO7GipYiC9RKtuptamLJyjFcyHb0RcvQ0q37i+8NEJY+aHF6/ZtcQwKoQ/HBTC4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671063; c=relaxed/simple;
	bh=s6MD4d0DiKfJDh4A9I6m5vXbwQ6vLM/B2ZHf9+4prto=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HEw+z5JyhOOzAEQsiKoA1NHDlmdF5E9HvAxUMaN/qMWcSEZwq2V2QIjZqSGpFHmXUw/Kpcw31CTjtRT+QZljjwv/X/WHVvzhdWTEjP/HUeeX4FmNpqJwfwuiqiRQ96IMeOGo6CsS4AlFwSxbl+PWB8Ya7XBiuYq74MNtHwr70/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KijW+0SP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740671061; x=1772207061;
  h=date:from:to:cc:subject:message-id;
  bh=s6MD4d0DiKfJDh4A9I6m5vXbwQ6vLM/B2ZHf9+4prto=;
  b=KijW+0SPXRsMJOTjTcNGN6IikQQLde3OcHdKTk8tj5W2cnpSy5KpXUR4
   XmsdVihWIziCPDr+iVK9HTOt73tYRnrBv7+xqqCHbFjFE6JQ+vMnDfcxQ
   r783+AbChJ9lMT7DGxbA5MObuenzTwEtMtJ/ErPaN3dCVKwD20y/gl2GL
   RDazF4NFXMgN6wOxeiluRtZ4W3uvPxrBPH70T/9F3iqyuPsb8/QhR9LJY
   wmrQFMCU2RrXnlvdaEamvPdXjhbDrfQ8+gksg308ZsqvmCT0HmlPNwl9P
   Y1igy8bXJGZmb9L4qrbdjzJT8whfe3H881/bNxs8mF6dhStTgRJ6Z1apB
   A==;
X-CSE-ConnectionGUID: J92mrBrFRFOPM14RYFQ/xg==
X-CSE-MsgGUID: Bkqqew2kR0WCGGG2vBg/LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41486283"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41486283"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:44:18 -0800
X-CSE-ConnectionGUID: tXBv8n2DSq2SoRUbjTXeIA==
X-CSE-MsgGUID: k834fokTScGJ1cAMlCh4ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116933226"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 27 Feb 2025 07:44:17 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tng3a-000Dbk-0q;
	Thu, 27 Feb 2025 15:44:14 +0000
Date: Thu, 27 Feb 2025 23:43:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/futex] BUILD SUCCESS
 e3924279e5164d821fa2cbcf0c15e7345cb3508e
Message-ID: <202502272333.F2JNY9fC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/futex
branch HEAD: e3924279e5164d821fa2cbcf0c15e7345cb3508e  futex: Use a hashmask instead of hashsize

elapsed time: 1445m

configs tested: 164
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250227    clang-17
arc                   randconfig-001-20250227    gcc-13.2.0
arc                   randconfig-002-20250227    clang-17
arc                   randconfig-002-20250227    gcc-13.2.0
arm                               allnoconfig    gcc-14.2.0
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250227    clang-17
arm                   randconfig-001-20250227    gcc-14.2.0
arm                   randconfig-002-20250227    clang-17
arm                   randconfig-003-20250227    clang-17
arm                   randconfig-003-20250227    gcc-14.2.0
arm                   randconfig-004-20250227    clang-17
arm                   randconfig-004-20250227    clang-21
arm                         socfpga_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250227    clang-17
arm64                 randconfig-001-20250227    gcc-14.2.0
arm64                 randconfig-002-20250227    clang-17
arm64                 randconfig-002-20250227    clang-19
arm64                 randconfig-003-20250227    clang-17
arm64                 randconfig-003-20250227    gcc-14.2.0
arm64                 randconfig-004-20250227    clang-17
arm64                 randconfig-004-20250227    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250227    gcc-14.2.0
csky                  randconfig-002-20250227    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250227    clang-14
hexagon               randconfig-001-20250227    gcc-14.2.0
hexagon               randconfig-002-20250227    clang-16
hexagon               randconfig-002-20250227    gcc-14.2.0
i386        buildonly-randconfig-001-20250227    gcc-12
i386        buildonly-randconfig-002-20250227    gcc-11
i386        buildonly-randconfig-002-20250227    gcc-12
i386        buildonly-randconfig-003-20250227    clang-19
i386        buildonly-randconfig-003-20250227    gcc-12
i386        buildonly-randconfig-004-20250227    gcc-12
i386        buildonly-randconfig-005-20250227    gcc-11
i386        buildonly-randconfig-005-20250227    gcc-12
i386        buildonly-randconfig-006-20250227    clang-19
i386        buildonly-randconfig-006-20250227    gcc-12
i386                  randconfig-001-20250227    clang-19
i386                  randconfig-002-20250227    clang-19
i386                  randconfig-003-20250227    clang-19
i386                  randconfig-004-20250227    clang-19
i386                  randconfig-005-20250227    clang-19
i386                  randconfig-006-20250227    clang-19
i386                  randconfig-007-20250227    clang-19
i386                  randconfig-011-20250227    gcc-12
i386                  randconfig-012-20250227    gcc-12
i386                  randconfig-013-20250227    gcc-12
i386                  randconfig-014-20250227    gcc-12
i386                  randconfig-015-20250227    gcc-12
i386                  randconfig-016-20250227    gcc-12
i386                  randconfig-017-20250227    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250227    gcc-14.2.0
loongarch             randconfig-002-20250227    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250227    gcc-14.2.0
nios2                 randconfig-002-20250227    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-15
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250227    gcc-14.2.0
parisc                randconfig-002-20250227    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                      bamboo_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250227    clang-19
powerpc               randconfig-001-20250227    gcc-14.2.0
powerpc               randconfig-002-20250227    gcc-14.2.0
powerpc               randconfig-003-20250227    clang-19
powerpc               randconfig-003-20250227    gcc-14.2.0
powerpc64             randconfig-001-20250227    clang-17
powerpc64             randconfig-001-20250227    gcc-14.2.0
powerpc64             randconfig-002-20250227    clang-21
powerpc64             randconfig-002-20250227    gcc-14.2.0
powerpc64             randconfig-003-20250227    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250227    gcc-14.2.0
riscv                 randconfig-002-20250227    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250227    clang-18
s390                  randconfig-001-20250227    gcc-14.2.0
s390                  randconfig-002-20250227    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250227    gcc-14.2.0
sh                    randconfig-002-20250227    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250227    gcc-14.2.0
sparc                 randconfig-002-20250227    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250227    gcc-14.2.0
sparc64               randconfig-002-20250227    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250227    clang-17
um                    randconfig-001-20250227    gcc-14.2.0
um                    randconfig-002-20250227    gcc-12
um                    randconfig-002-20250227    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250227    clang-19
x86_64      buildonly-randconfig-002-20250227    clang-19
x86_64      buildonly-randconfig-003-20250227    clang-19
x86_64      buildonly-randconfig-003-20250227    gcc-12
x86_64      buildonly-randconfig-004-20250227    clang-19
x86_64      buildonly-randconfig-004-20250227    gcc-12
x86_64      buildonly-randconfig-005-20250227    clang-19
x86_64      buildonly-randconfig-006-20250227    clang-19
x86_64      buildonly-randconfig-006-20250227    gcc-12
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250227    gcc-12
x86_64                randconfig-002-20250227    gcc-12
x86_64                randconfig-003-20250227    gcc-12
x86_64                randconfig-004-20250227    gcc-12
x86_64                randconfig-005-20250227    gcc-12
x86_64                randconfig-006-20250227    gcc-12
x86_64                randconfig-007-20250227    gcc-12
x86_64                randconfig-008-20250227    gcc-12
x86_64                randconfig-071-20250227    gcc-12
x86_64                randconfig-072-20250227    gcc-12
x86_64                randconfig-073-20250227    gcc-12
x86_64                randconfig-074-20250227    gcc-12
x86_64                randconfig-075-20250227    gcc-12
x86_64                randconfig-076-20250227    gcc-12
x86_64                randconfig-077-20250227    gcc-12
x86_64                randconfig-078-20250227    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250227    gcc-14.2.0
xtensa                randconfig-002-20250227    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

