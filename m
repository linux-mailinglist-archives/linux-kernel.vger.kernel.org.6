Return-Path: <linux-kernel+bounces-285879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D04F9513C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696AF1C23504
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F6F54662;
	Wed, 14 Aug 2024 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGynePeI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26019F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723612709; cv=none; b=as3OpdLPqGVfbaAcPjwBEc0h39LWUaZzl990fAJkhcT7jqCnIuyAb4V+HQGb3W+TbzDEVAIQl5aoxcuqHwnUPat+Zd7ni3lszadThOmkWwVcgI2T3pLeW+Z1AA49RzIaF+M+gD6v0bMMd/H9orS9pqbJP1KYbxXAdcb0qYYVbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723612709; c=relaxed/simple;
	bh=Boq1/IlH9DeNoxkQ9MKTMCGQDEZW+p2p6zZPS7xdmeA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U30NrGefVkzkcfFeOzuyo5zE6r4wsq9Jwn8uSVgZsxkqurE861U8rW/xwnLO96+lD6egQzrK8MC+iZ2s4KXeyDoEdmtQahyauy8MA7KGMXha8av5bTnrAJiOVyeS/74pSBg5GVXqqOf+3UkTwljjN20PmkVW+wffwGdQTHpllOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGynePeI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723612708; x=1755148708;
  h=date:from:to:cc:subject:message-id;
  bh=Boq1/IlH9DeNoxkQ9MKTMCGQDEZW+p2p6zZPS7xdmeA=;
  b=DGynePeIcmBIyyGw2dXRx4K9FqlT3oa2Umd3/p7fwIGaYV8200aUhrIw
   KXwnyVA84C3r8njSE9aZCT/bLjW0s9ccogDGGy57KaSElA1rEge+kQELZ
   JjEBeJl3dUxQ3HwHatTgmVKW6hZ6YwGz3ZSgqIZApNqQ3nLxhBLC5Syrr
   Tb/x4oqcvg0vJrLotnkSdzXq+J4x2V1VxM2MdrvXUnuLjdrOYMCsDChwd
   8AaPvYSKs7Rtj2oJpJDMQAk/K551VNR5KanY9Phn5QId97DWFHekvLXqP
   f9+izI2nsUj2tBj+o+uwjuYvfc0Tx5qJs3cL0sPpnuzwz1dMEWaX6YAqB
   g==;
X-CSE-ConnectionGUID: kz5GHkuxS3CyOnt7dqV9Eg==
X-CSE-MsgGUID: CH+rExCRRWmxnaOwa+Crew==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21940409"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21940409"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 22:18:27 -0700
X-CSE-ConnectionGUID: hus8RJMVQhSuaxVuMR4OQw==
X-CSE-MsgGUID: s3H9SJvbSauJs9flb660Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="59470267"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Aug 2024 22:18:25 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1se6Os-0001Bu-34;
	Wed, 14 Aug 2024 05:18:22 +0000
Date: Wed, 14 Aug 2024 13:18:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 a1fab3e69d9d0e9b62aab4450cb97da432ac3ef2
Message-ID: <202408141311.eWItaAE4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: a1fab3e69d9d0e9b62aab4450cb97da432ac3ef2  x86/irq: Fix comment on IRQ vector layout

elapsed time: 1119m

configs tested: 265
configs skipped: 14

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
arc                   randconfig-001-20240813   gcc-13.2.0
arc                   randconfig-001-20240814   gcc-13.2.0
arc                   randconfig-002-20240813   gcc-13.2.0
arc                   randconfig-002-20240814   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         assabet_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-12.4.0
arm                            hisi_defconfig   gcc-12.4.0
arm                          moxart_defconfig   gcc-12.4.0
arm                         mv78xx0_defconfig   gcc-12.4.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240813   gcc-13.2.0
arm                   randconfig-001-20240814   gcc-13.2.0
arm                   randconfig-002-20240813   gcc-13.2.0
arm                   randconfig-002-20240814   gcc-13.2.0
arm                   randconfig-003-20240813   gcc-13.2.0
arm                   randconfig-003-20240814   gcc-13.2.0
arm                   randconfig-004-20240813   gcc-13.2.0
arm                   randconfig-004-20240814   gcc-13.2.0
arm                           sunxi_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-12.4.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240813   gcc-13.2.0
arm64                 randconfig-001-20240814   gcc-13.2.0
arm64                 randconfig-002-20240813   gcc-13.2.0
arm64                 randconfig-002-20240814   gcc-13.2.0
arm64                 randconfig-003-20240813   gcc-13.2.0
arm64                 randconfig-003-20240814   gcc-13.2.0
arm64                 randconfig-004-20240813   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240813   gcc-13.2.0
csky                  randconfig-001-20240814   gcc-13.2.0
csky                  randconfig-002-20240813   gcc-13.2.0
csky                  randconfig-002-20240814   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             alldefconfig   gcc-12.4.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240813   gcc-12
i386         buildonly-randconfig-001-20240814   clang-18
i386         buildonly-randconfig-002-20240813   gcc-12
i386         buildonly-randconfig-002-20240814   clang-18
i386         buildonly-randconfig-003-20240813   gcc-12
i386         buildonly-randconfig-003-20240814   clang-18
i386         buildonly-randconfig-004-20240813   gcc-11
i386         buildonly-randconfig-004-20240814   clang-18
i386         buildonly-randconfig-005-20240813   clang-18
i386         buildonly-randconfig-005-20240814   clang-18
i386         buildonly-randconfig-006-20240813   gcc-12
i386         buildonly-randconfig-006-20240814   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240813   gcc-12
i386                  randconfig-001-20240814   clang-18
i386                  randconfig-002-20240813   clang-18
i386                  randconfig-002-20240814   clang-18
i386                  randconfig-003-20240813   gcc-12
i386                  randconfig-003-20240814   clang-18
i386                  randconfig-004-20240813   gcc-12
i386                  randconfig-004-20240814   clang-18
i386                  randconfig-005-20240813   clang-18
i386                  randconfig-005-20240814   clang-18
i386                  randconfig-006-20240813   clang-18
i386                  randconfig-006-20240814   clang-18
i386                  randconfig-011-20240813   gcc-12
i386                  randconfig-011-20240814   clang-18
i386                  randconfig-012-20240813   gcc-12
i386                  randconfig-012-20240814   clang-18
i386                  randconfig-013-20240813   clang-18
i386                  randconfig-013-20240814   clang-18
i386                  randconfig-014-20240813   clang-18
i386                  randconfig-014-20240814   clang-18
i386                  randconfig-015-20240813   clang-18
i386                  randconfig-015-20240814   clang-18
i386                  randconfig-016-20240813   clang-18
i386                  randconfig-016-20240814   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240813   gcc-13.2.0
loongarch             randconfig-001-20240814   gcc-13.2.0
loongarch             randconfig-002-20240813   gcc-13.2.0
loongarch             randconfig-002-20240814   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-12.4.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme16x_defconfig   gcc-12.4.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240813   gcc-13.2.0
nios2                 randconfig-001-20240814   gcc-13.2.0
nios2                 randconfig-002-20240813   gcc-13.2.0
nios2                 randconfig-002-20240814   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                  or1klitex_defconfig   gcc-12.4.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240813   gcc-13.2.0
parisc                randconfig-001-20240814   gcc-13.2.0
parisc                randconfig-002-20240813   gcc-13.2.0
parisc                randconfig-002-20240814   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      katmai_defconfig   gcc-12.4.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc                       ppc64_defconfig   gcc-12.4.0
powerpc               randconfig-002-20240813   gcc-13.2.0
powerpc               randconfig-002-20240814   gcc-13.2.0
powerpc               randconfig-003-20240813   gcc-13.2.0
powerpc               randconfig-003-20240814   gcc-13.2.0
powerpc                 xes_mpc85xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240813   gcc-13.2.0
powerpc64             randconfig-002-20240813   gcc-13.2.0
powerpc64             randconfig-003-20240813   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240813   gcc-13.2.0
riscv                 randconfig-001-20240814   gcc-13.2.0
riscv                 randconfig-002-20240813   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-13.2.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240813   gcc-13.2.0
s390                  randconfig-001-20240814   gcc-13.2.0
s390                  randconfig-002-20240813   gcc-13.2.0
s390                  randconfig-002-20240814   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-12.4.0
sh                          polaris_defconfig   gcc-12.4.0
sh                    randconfig-001-20240813   gcc-13.2.0
sh                    randconfig-001-20240814   gcc-13.2.0
sh                    randconfig-002-20240813   gcc-13.2.0
sh                    randconfig-002-20240814   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-12.4.0
sh                          sdk7780_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-12.4.0
sh                     sh7710voipgw_defconfig   gcc-12.4.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-12.4.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240813   gcc-13.2.0
sparc64               randconfig-001-20240814   gcc-13.2.0
sparc64               randconfig-002-20240813   gcc-13.2.0
sparc64               randconfig-002-20240814   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240813   gcc-13.2.0
um                    randconfig-001-20240814   gcc-13.2.0
um                    randconfig-002-20240813   gcc-13.2.0
um                    randconfig-002-20240814   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240814   clang-18
x86_64       buildonly-randconfig-002-20240814   clang-18
x86_64       buildonly-randconfig-002-20240814   gcc-12
x86_64       buildonly-randconfig-003-20240814   clang-18
x86_64       buildonly-randconfig-004-20240814   clang-18
x86_64       buildonly-randconfig-005-20240814   clang-18
x86_64       buildonly-randconfig-005-20240814   gcc-12
x86_64       buildonly-randconfig-006-20240814   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240814   clang-18
x86_64                randconfig-002-20240814   clang-18
x86_64                randconfig-002-20240814   gcc-12
x86_64                randconfig-003-20240814   clang-18
x86_64                randconfig-003-20240814   gcc-11
x86_64                randconfig-004-20240814   clang-18
x86_64                randconfig-004-20240814   gcc-12
x86_64                randconfig-005-20240814   clang-18
x86_64                randconfig-005-20240814   gcc-12
x86_64                randconfig-006-20240814   clang-18
x86_64                randconfig-006-20240814   gcc-12
x86_64                randconfig-011-20240814   clang-18
x86_64                randconfig-012-20240814   clang-18
x86_64                randconfig-013-20240814   clang-18
x86_64                randconfig-013-20240814   gcc-11
x86_64                randconfig-014-20240814   clang-18
x86_64                randconfig-015-20240814   clang-18
x86_64                randconfig-015-20240814   gcc-12
x86_64                randconfig-016-20240814   clang-18
x86_64                randconfig-071-20240814   clang-18
x86_64                randconfig-072-20240814   clang-18
x86_64                randconfig-073-20240814   clang-18
x86_64                randconfig-074-20240814   clang-18
x86_64                randconfig-075-20240814   clang-18
x86_64                randconfig-075-20240814   gcc-12
x86_64                randconfig-076-20240814   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240813   gcc-13.2.0
xtensa                randconfig-001-20240814   gcc-13.2.0
xtensa                randconfig-002-20240813   gcc-13.2.0
xtensa                randconfig-002-20240814   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

