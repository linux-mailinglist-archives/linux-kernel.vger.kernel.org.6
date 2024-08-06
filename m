Return-Path: <linux-kernel+bounces-276280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 407D6949198
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6129A1C2131F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BC41D2F50;
	Tue,  6 Aug 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAL0B3T9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7D1D278F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951135; cv=none; b=q1Mzs4yDECZqJ9XP2va5j9HyBZ/N7beRHhYWWmXJkIJbM+PpLikv/SkCTF2fy0qG02oqfaRmq8s6ylTPfZc6xHmISL9YAZgCtJ1RQUeaGBsxM+00eGHx3LdEojzcslv+OPz7tWwcu4H4wMIdwjXmiprCkbIe0IYDBY+CiHaD5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951135; c=relaxed/simple;
	bh=chhYUwzOr0K5HDybMheufebZhqzY8A3IqKrmmPm6MI4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WNy2CnrdXFJyYcuorPJ8g8t/GXVjs7ddoM2FemJEr8TqyJ95QZvlkFDtNJ/QOqzEPTq+6ha1tNgYx5T065OR7WoW4M8L9KD2jr6S30rEIWR0tpyS4FuiXSJ5Mcw/oxy9/4lijb3C/oSlFiexcLxfXhZlGWQBM1e3EfqrZi7pvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAL0B3T9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722951133; x=1754487133;
  h=date:from:to:cc:subject:message-id;
  bh=chhYUwzOr0K5HDybMheufebZhqzY8A3IqKrmmPm6MI4=;
  b=FAL0B3T9mGQBYE1Wtl6fMeo1D/YkcuIVPbaWRqb1mZYGCuGPB5aoRrCQ
   eVjQagko30EMIxw4kzP7Ak6GOO2e2HHs3Zye40r40WA4MFeiabihttcSx
   qm6AWKmX3l/B8/zKxaYG/L443po51OceLiPjoScIeHmGIr0sE6qVaW/eq
   OmuWjEZce+JjOHI+ocEy7T0iPgrccxsQR+InVerLsSPJCSn0zdv9Nv28l
   if1kxmS5MtrkKpriZR2lfrKUWNaXPn6Q/PDPMsYekMxbWuX/vUZA2bvxQ
   uDTvHbDJFdsJgB9AhoYuhCZMZgEePfccOffhwdPc+DlgVIk5piyBoblgs
   g==;
X-CSE-ConnectionGUID: N/GXFS/jQmifu2tr8GTWaw==
X-CSE-MsgGUID: 9Z1VuiFZRwG+rLOZ46MQDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31600663"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="31600663"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:32:13 -0700
X-CSE-ConnectionGUID: IjcZ4cAUTxCElbYkofWLqA==
X-CSE-MsgGUID: G+MQYmjyS9uAFXMnBQSRnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="61375469"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 06 Aug 2024 06:32:11 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbKIK-0004W0-1H;
	Tue, 06 Aug 2024 13:32:08 +0000
Date: Tue, 06 Aug 2024 21:31:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 320805a45df3ba5e5d1f7e59b868ea455449c394
Message-ID: <202408062121.tvvK0S3b-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: 320805a45df3ba5e5d1f7e59b868ea455449c394  Merge branches 'cmpxchg.2024.08.02a', 'lkmm.2024.08.02a', 'kcsan.2024.08.01a' and 'misc.2024.08.02a' into HEAD

elapsed time: 1046m

configs tested: 264
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                   randconfig-001-20240806   gcc-13.2.0
arc                   randconfig-002-20240806   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.2.0
arm                          ep93xx_defconfig   gcc-13.2.0
arm                           imxrt_defconfig   clang-20
arm                          ixp4xx_defconfig   clang-20
arm                         orion5x_defconfig   gcc-13.2.0
arm                          pxa3xx_defconfig   clang-20
arm                            qcom_defconfig   gcc-13.2.0
arm                   randconfig-001-20240806   clang-20
arm                   randconfig-001-20240806   gcc-13.2.0
arm                   randconfig-002-20240806   gcc-13.2.0
arm                   randconfig-002-20240806   gcc-14.1.0
arm                   randconfig-003-20240806   gcc-13.2.0
arm                   randconfig-003-20240806   gcc-14.1.0
arm                   randconfig-004-20240806   gcc-13.2.0
arm                   randconfig-004-20240806   gcc-14.1.0
arm                           spitz_defconfig   clang-20
arm64                            alldefconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240806   clang-20
arm64                 randconfig-001-20240806   gcc-13.2.0
arm64                 randconfig-002-20240806   clang-20
arm64                 randconfig-002-20240806   gcc-13.2.0
arm64                 randconfig-003-20240806   clang-14
arm64                 randconfig-003-20240806   gcc-13.2.0
arm64                 randconfig-004-20240806   gcc-13.2.0
arm64                 randconfig-004-20240806   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240806   gcc-13.2.0
csky                  randconfig-001-20240806   gcc-14.1.0
csky                  randconfig-002-20240806   gcc-13.2.0
csky                  randconfig-002-20240806   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240806   clang-20
hexagon               randconfig-002-20240806   clang-17
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240806   gcc-11
i386         buildonly-randconfig-002-20240806   gcc-11
i386         buildonly-randconfig-002-20240806   gcc-12
i386         buildonly-randconfig-003-20240806   gcc-11
i386         buildonly-randconfig-003-20240806   gcc-12
i386         buildonly-randconfig-004-20240806   gcc-11
i386         buildonly-randconfig-004-20240806   gcc-12
i386         buildonly-randconfig-005-20240806   clang-18
i386         buildonly-randconfig-005-20240806   gcc-11
i386         buildonly-randconfig-006-20240806   gcc-11
i386         buildonly-randconfig-006-20240806   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240806   clang-18
i386                  randconfig-001-20240806   gcc-11
i386                  randconfig-002-20240806   gcc-11
i386                  randconfig-002-20240806   gcc-12
i386                  randconfig-003-20240806   gcc-11
i386                  randconfig-003-20240806   gcc-12
i386                  randconfig-004-20240806   gcc-11
i386                  randconfig-004-20240806   gcc-12
i386                  randconfig-005-20240806   clang-18
i386                  randconfig-005-20240806   gcc-11
i386                  randconfig-006-20240806   clang-18
i386                  randconfig-006-20240806   gcc-11
i386                  randconfig-011-20240806   clang-18
i386                  randconfig-011-20240806   gcc-11
i386                  randconfig-012-20240806   gcc-11
i386                  randconfig-012-20240806   gcc-12
i386                  randconfig-013-20240806   clang-18
i386                  randconfig-013-20240806   gcc-11
i386                  randconfig-014-20240806   clang-18
i386                  randconfig-014-20240806   gcc-11
i386                  randconfig-015-20240806   clang-18
i386                  randconfig-015-20240806   gcc-11
i386                  randconfig-016-20240806   clang-18
i386                  randconfig-016-20240806   gcc-11
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240806   gcc-13.2.0
loongarch             randconfig-001-20240806   gcc-14.1.0
loongarch             randconfig-002-20240806   gcc-13.2.0
loongarch             randconfig-002-20240806   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath25_defconfig   clang-20
mips                 decstation_r4k_defconfig   clang-20
mips                          eyeq5_defconfig   clang-20
mips                           ip28_defconfig   gcc-13.2.0
nios2                         10m50_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240806   gcc-13.2.0
nios2                 randconfig-001-20240806   gcc-14.1.0
nios2                 randconfig-002-20240806   gcc-13.2.0
nios2                 randconfig-002-20240806   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240806   gcc-13.2.0
parisc                randconfig-001-20240806   gcc-14.1.0
parisc                randconfig-002-20240806   gcc-13.2.0
parisc                randconfig-002-20240806   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        cell_defconfig   clang-20
powerpc                       ebony_defconfig   gcc-13.2.0
powerpc                 mpc836x_rdk_defconfig   clang-20
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                  mpc885_ads_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240806   gcc-13.2.0
powerpc               randconfig-001-20240806   gcc-14.1.0
powerpc               randconfig-003-20240806   clang-20
powerpc               randconfig-003-20240806   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-13.2.0
powerpc                     tqm8540_defconfig   gcc-13.2.0
powerpc                        warp_defconfig   clang-20
powerpc64             randconfig-001-20240806   gcc-13.2.0
powerpc64             randconfig-001-20240806   gcc-14.1.0
powerpc64             randconfig-002-20240806   clang-16
powerpc64             randconfig-002-20240806   gcc-13.2.0
powerpc64             randconfig-003-20240806   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240806   gcc-13.2.0
riscv                 randconfig-001-20240806   gcc-14.1.0
riscv                 randconfig-002-20240806   clang-20
riscv                 randconfig-002-20240806   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240806   clang-20
s390                  randconfig-001-20240806   gcc-13.2.0
s390                  randconfig-002-20240806   clang-20
s390                  randconfig-002-20240806   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240806   gcc-13.2.0
sh                    randconfig-001-20240806   gcc-14.1.0
sh                    randconfig-002-20240806   gcc-13.2.0
sh                    randconfig-002-20240806   gcc-14.1.0
sh                           se7343_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240806   gcc-13.2.0
sparc64               randconfig-001-20240806   gcc-14.1.0
sparc64               randconfig-002-20240806   gcc-13.2.0
sparc64               randconfig-002-20240806   gcc-14.1.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240806   clang-20
um                    randconfig-001-20240806   gcc-13.2.0
um                    randconfig-002-20240806   gcc-12
um                    randconfig-002-20240806   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240806   clang-18
x86_64       buildonly-randconfig-002-20240806   clang-18
x86_64       buildonly-randconfig-003-20240806   clang-18
x86_64       buildonly-randconfig-004-20240806   clang-18
x86_64       buildonly-randconfig-005-20240806   clang-18
x86_64       buildonly-randconfig-005-20240806   gcc-12
x86_64       buildonly-randconfig-006-20240806   clang-18
x86_64       buildonly-randconfig-006-20240806   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240806   clang-18
x86_64                randconfig-001-20240806   gcc-12
x86_64                randconfig-002-20240806   clang-18
x86_64                randconfig-002-20240806   gcc-11
x86_64                randconfig-003-20240806   clang-18
x86_64                randconfig-003-20240806   gcc-12
x86_64                randconfig-004-20240806   clang-18
x86_64                randconfig-005-20240806   clang-18
x86_64                randconfig-006-20240806   clang-18
x86_64                randconfig-011-20240806   clang-18
x86_64                randconfig-011-20240806   gcc-12
x86_64                randconfig-012-20240806   clang-18
x86_64                randconfig-012-20240806   gcc-12
x86_64                randconfig-013-20240806   clang-18
x86_64                randconfig-014-20240806   clang-18
x86_64                randconfig-014-20240806   gcc-12
x86_64                randconfig-015-20240806   clang-18
x86_64                randconfig-015-20240806   gcc-12
x86_64                randconfig-016-20240806   clang-18
x86_64                randconfig-016-20240806   gcc-12
x86_64                randconfig-071-20240806   clang-18
x86_64                randconfig-071-20240806   gcc-12
x86_64                randconfig-072-20240806   clang-18
x86_64                randconfig-073-20240806   clang-18
x86_64                randconfig-073-20240806   gcc-11
x86_64                randconfig-074-20240806   clang-18
x86_64                randconfig-074-20240806   gcc-12
x86_64                randconfig-075-20240806   clang-18
x86_64                randconfig-075-20240806   gcc-12
x86_64                randconfig-076-20240806   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                           alldefconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240806   gcc-13.2.0
xtensa                randconfig-001-20240806   gcc-14.1.0
xtensa                randconfig-002-20240806   gcc-13.2.0
xtensa                randconfig-002-20240806   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

