Return-Path: <linux-kernel+bounces-406482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371329C5FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B489D1F265F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75986217F27;
	Tue, 12 Nov 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoH0dNIL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E7215039
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434450; cv=none; b=tHC9S8o4BZjuZ4Luy5lRSWeD0FGe2qzvX5w75lBJwGrF21ZHFB0h5tJXhVVO3EiSag5bMCKGzD734RBiE84dOJ4ln12oJFfp9YCaM20Bc8urCDTJtL3o1CVDwBNrxuK5UNJGJz652cBWwNB0uKADouVH1rFFEuHtp58xso+g6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434450; c=relaxed/simple;
	bh=piNNQ6boCd/Eyiu8wDRAE51layplBA5zXnNGklgm+yA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RmT8axcOLkjNh8Q7rr+5VZVvkHFLKlMwhsqQZ54pkXTLC4tniv0P+4x3xqTc06Fqq3raE7RPIU3WOXWu45nmeP/hQS3Qx2B+LZgai6v3xJMXBP2btcE3hlKPHNWuTuL4vx4i88kdOqJPYoiWTQKj9rYoezqtcKfYstrS+QTBC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DoH0dNIL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731434448; x=1762970448;
  h=date:from:to:cc:subject:message-id;
  bh=piNNQ6boCd/Eyiu8wDRAE51layplBA5zXnNGklgm+yA=;
  b=DoH0dNILnVn+gU2qM17oq4xwuVIEX33XdG0oohM8A+jqaACr7rvuwiOT
   dHXR4uk/trAsj1ltbp873nCTLwTJ+E6TSLVXVro11BdzaqTW7wslteoqu
   ZdqvJ0m4soN9eF/mpcriwxdwBAmlgdYpyM2oqbOIYMz+1G5Nfjv/2hqre
   RhL3IMk6qmvccjA4qZ0KcExqKmpmePUt2cHKJAsWqIvH+f8E2OGE+1hvm
   roFrrFAh21BkJNooOg+lQHRiEqLiLBmSSLifp4LeVMT5d+fH1oqfpmw5t
   Q1GMvZ8iWekK41cz9JqSowxtqi8QT4YZPf4BYiTOLUX4cDZ003183nQii
   Q==;
X-CSE-ConnectionGUID: xv9t3t4qTKKT7DvB+ewlqw==
X-CSE-MsgGUID: fJvaXPeiTMi7oEk/9UIi9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="35220748"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="35220748"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 10:00:48 -0800
X-CSE-ConnectionGUID: oXLIeWHxT9aJHfsGtygHqA==
X-CSE-MsgGUID: 8fC1ciD3T9CG/mnQFPqsQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="118540803"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Nov 2024 10:00:46 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAvC0-0001bT-1J;
	Tue, 12 Nov 2024 18:00:44 +0000
Date: Wed, 13 Nov 2024 02:00:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.11.09a] BUILD SUCCESS
 5e3decb0d9d168614d3f3604e0be6038705de795
Message-ID: <202411130214.faTZtVRC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.11.09a
branch HEAD: 5e3decb0d9d168614d3f3604e0be6038705de795  srcu: Unconditionally record srcu_read_lock_lite() in ->srcu_reader_flavor

elapsed time: 1015m

configs tested: 217
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    clang-20
arc                   randconfig-001-20241112    gcc-13.2.0
arc                   randconfig-001-20241112    gcc-14.2.0
arc                   randconfig-002-20241112    gcc-13.2.0
arc                   randconfig-002-20241112    gcc-14.2.0
arc                           tb10x_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                      footbridge_defconfig    clang-20
arm                          gemini_defconfig    gcc-14.2.0
arm                      integrator_defconfig    gcc-14.2.0
arm                          pxa168_defconfig    gcc-14.2.0
arm                   randconfig-001-20241112    clang-20
arm                   randconfig-001-20241112    gcc-14.2.0
arm                   randconfig-002-20241112    gcc-14.2.0
arm                   randconfig-003-20241112    clang-14
arm                   randconfig-003-20241112    gcc-14.2.0
arm                   randconfig-004-20241112    gcc-14.2.0
arm                           sama5_defconfig    gcc-14.2.0
arm                       spear13xx_defconfig    clang-20
arm                           sunxi_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241112    gcc-14.2.0
arm64                 randconfig-002-20241112    clang-20
arm64                 randconfig-002-20241112    gcc-14.2.0
arm64                 randconfig-003-20241112    clang-20
arm64                 randconfig-003-20241112    gcc-14.2.0
arm64                 randconfig-004-20241112    clang-20
arm64                 randconfig-004-20241112    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241112    gcc-14.2.0
csky                  randconfig-002-20241112    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241112    clang-17
hexagon               randconfig-001-20241112    gcc-14.2.0
hexagon               randconfig-002-20241112    clang-20
hexagon               randconfig-002-20241112    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241112    clang-19
i386        buildonly-randconfig-002-20241112    clang-19
i386        buildonly-randconfig-003-20241112    clang-19
i386        buildonly-randconfig-004-20241112    clang-19
i386        buildonly-randconfig-005-20241112    clang-19
i386        buildonly-randconfig-006-20241112    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241112    clang-19
i386                  randconfig-002-20241112    clang-19
i386                  randconfig-003-20241112    clang-19
i386                  randconfig-004-20241112    clang-19
i386                  randconfig-005-20241112    clang-19
i386                  randconfig-006-20241112    clang-19
i386                  randconfig-011-20241112    clang-19
i386                  randconfig-012-20241112    clang-19
i386                  randconfig-013-20241112    clang-19
i386                  randconfig-014-20241112    clang-19
i386                  randconfig-015-20241112    clang-19
i386                  randconfig-016-20241112    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    clang-20
loongarch             randconfig-001-20241112    gcc-14.2.0
loongarch             randconfig-002-20241112    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    clang-20
mips                           gcw0_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
mips                           mtx1_defconfig    clang-20
mips                           mtx1_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241112    gcc-14.2.0
nios2                 randconfig-002-20241112    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           alldefconfig    clang-20
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241112    gcc-14.2.0
parisc                randconfig-002-20241112    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-20
powerpc                   lite5200b_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc               mpc834x_itxgp_defconfig    gcc-14.2.0
powerpc                 mpc836x_rdk_defconfig    clang-20
powerpc                      pasemi_defconfig    clang-20
powerpc                      ppc64e_defconfig    clang-20
powerpc               randconfig-001-20241112    gcc-14.2.0
powerpc               randconfig-002-20241112    gcc-14.2.0
powerpc               randconfig-003-20241112    gcc-14.2.0
powerpc                        warp_defconfig    clang-20
powerpc64             randconfig-001-20241112    gcc-14.2.0
powerpc64             randconfig-002-20241112    gcc-14.2.0
powerpc64             randconfig-003-20241112    clang-14
powerpc64             randconfig-003-20241112    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                               defconfig    gcc-14.2.0
riscv                 randconfig-001-20241112    gcc-14.2.0
riscv                 randconfig-002-20241112    clang-20
riscv                 randconfig-002-20241112    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241112    gcc-14.2.0
s390                  randconfig-002-20241112    clang-20
s390                  randconfig-002-20241112    gcc-14.2.0
s390                       zfcpdump_defconfig    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                         ecovec24_defconfig    clang-20
sh                               j2_defconfig    gcc-14.2.0
sh                    randconfig-001-20241112    gcc-14.2.0
sh                    randconfig-002-20241112    gcc-14.2.0
sh                          rsk7203_defconfig    clang-20
sh                          rsk7264_defconfig    clang-20
sh                           se7750_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241112    gcc-14.2.0
sparc64               randconfig-002-20241112    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241112    gcc-12
um                    randconfig-001-20241112    gcc-14.2.0
um                    randconfig-002-20241112    gcc-12
um                    randconfig-002-20241112    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241112    gcc-12
x86_64      buildonly-randconfig-002-20241112    gcc-12
x86_64      buildonly-randconfig-003-20241112    gcc-12
x86_64      buildonly-randconfig-004-20241112    gcc-12
x86_64      buildonly-randconfig-005-20241112    gcc-12
x86_64      buildonly-randconfig-006-20241112    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241112    gcc-12
x86_64                randconfig-002-20241112    gcc-12
x86_64                randconfig-003-20241112    gcc-12
x86_64                randconfig-004-20241112    gcc-12
x86_64                randconfig-005-20241112    gcc-12
x86_64                randconfig-006-20241112    gcc-12
x86_64                randconfig-011-20241112    gcc-12
x86_64                randconfig-012-20241112    gcc-12
x86_64                randconfig-013-20241112    gcc-12
x86_64                randconfig-014-20241112    gcc-12
x86_64                randconfig-015-20241112    gcc-12
x86_64                randconfig-016-20241112    gcc-12
x86_64                randconfig-071-20241112    gcc-12
x86_64                randconfig-072-20241112    gcc-12
x86_64                randconfig-073-20241112    gcc-12
x86_64                randconfig-074-20241112    gcc-12
x86_64                randconfig-075-20241112    gcc-12
x86_64                randconfig-076-20241112    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    clang-20
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241112    gcc-14.2.0
xtensa                randconfig-002-20241112    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

