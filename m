Return-Path: <linux-kernel+bounces-316980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F9D96D7D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873671F24358
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F12199FB4;
	Thu,  5 Sep 2024 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WETROs2D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC503185956
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537829; cv=none; b=ruGBulCzu/Bmc1UWzPFVaP6lX/k7G6hS3sHxnPiudBPRNXuJ5EY/nr1liN2vZ0XI5t6E+2gdl+Vc654TxzZSqDOXArvG7wnO9qU8eGHebnT+Rp8Yb03iBQe0W603VI1N+Ggl1XJ7myztPVgqa/ifW0ZepbKhHwqJbmx7CzoKee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537829; c=relaxed/simple;
	bh=1zqJh2hE5x7y50yPygkbxpJIsiK5zsbSjgayNP1upic=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HqRjB58ER+xPff1k3XUhXMOaIoSYFOZHtO+tlGGJ0m1nzfwbU9BQtalvp2w++4Pew8qGopxWAQ78CUjtPiBPD3rubPdU1Il5296GEKZ8+JebT0HW3kLS1t57GCdhgKwDUrmJStFPOJ/87XjLk6zs/BzvtT2NxCD/LTCg+ZZEgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WETROs2D; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725537828; x=1757073828;
  h=date:from:to:cc:subject:message-id;
  bh=1zqJh2hE5x7y50yPygkbxpJIsiK5zsbSjgayNP1upic=;
  b=WETROs2DZm9aublPr6710xyi4VFz6plaHySJ0LBexE2GpjJ63ipTYA8T
   pYRTtQ3gpmaXD42qzSSfi5g1UrHMHM+bXmetiUznJcNsQsSDvNUog9VdQ
   ppZG8R6gHDjB4Puks/Ohu559xWNfAlRCoLvWCOqqKH9zkd8tO8QAGyzo4
   kZq5EXiVqx1N7iJyXEByDMEd5IxYr/HkHsJ3nXTLIS6IciexDTddU8RLc
   XQn4cGUaeBmxeARrUxPFQl8RnKFVu7MK6+uJGeTOUwkXfGBEaUdtc6HZ5
   D5RgNromLVv3NDTXW0Bmm8oQuF2PcwoyKltsOy3jKMtbFGAncm9ihmI5s
   g==;
X-CSE-ConnectionGUID: wZfWvHqCQ0K5jnTlEO9pxQ==
X-CSE-MsgGUID: l8TLuboKSiqSZE+2trW2Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34851915"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34851915"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:03:47 -0700
X-CSE-ConnectionGUID: NjKIg/odTEikypzurwKwvg==
X-CSE-MsgGUID: 2qSoUGHLSiuzsfUZ+XwBYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70021503"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Sep 2024 05:03:46 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smBDD-0009ot-24;
	Thu, 05 Sep 2024 12:03:43 +0000
Date: Thu, 05 Sep 2024 20:03:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 79f8b28e85f83563c86f528b91eff19c0c4d1177
Message-ID: <202409052037.5XU9Remp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 79f8b28e85f83563c86f528b91eff19c0c4d1177  timers: Annotate possible non critical data race of next_expiry

elapsed time: 1497m

configs tested: 190
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240905   gcc-12
arc                   randconfig-002-20240905   gcc-12
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                     am200epdkit_defconfig   clang-20
arm                         assabet_defconfig   clang-20
arm                        clps711x_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                          ep93xx_defconfig   clang-20
arm                      footbridge_defconfig   clang-20
arm                            mps2_defconfig   clang-20
arm                   randconfig-001-20240905   gcc-12
arm                   randconfig-002-20240905   gcc-12
arm                   randconfig-003-20240905   gcc-12
arm                   randconfig-004-20240905   gcc-12
arm                         socfpga_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240905   gcc-12
arm64                 randconfig-002-20240905   gcc-12
arm64                 randconfig-003-20240905   gcc-12
arm64                 randconfig-004-20240905   gcc-12
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240905   gcc-12
csky                  randconfig-002-20240905   gcc-12
hexagon                          alldefconfig   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240905   gcc-12
hexagon               randconfig-002-20240905   gcc-12
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240905   clang-18
i386         buildonly-randconfig-001-20240905   gcc-12
i386         buildonly-randconfig-002-20240905   gcc-12
i386         buildonly-randconfig-003-20240905   gcc-12
i386         buildonly-randconfig-004-20240905   clang-18
i386         buildonly-randconfig-004-20240905   gcc-12
i386         buildonly-randconfig-005-20240905   clang-18
i386         buildonly-randconfig-005-20240905   gcc-12
i386         buildonly-randconfig-006-20240905   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240905   gcc-12
i386                  randconfig-002-20240905   clang-18
i386                  randconfig-002-20240905   gcc-12
i386                  randconfig-003-20240905   gcc-12
i386                  randconfig-004-20240905   gcc-11
i386                  randconfig-004-20240905   gcc-12
i386                  randconfig-005-20240905   gcc-12
i386                  randconfig-006-20240905   gcc-12
i386                  randconfig-011-20240905   clang-18
i386                  randconfig-011-20240905   gcc-12
i386                  randconfig-012-20240905   clang-18
i386                  randconfig-012-20240905   gcc-12
i386                  randconfig-013-20240905   gcc-12
i386                  randconfig-014-20240905   clang-18
i386                  randconfig-014-20240905   gcc-12
i386                  randconfig-015-20240905   clang-18
i386                  randconfig-015-20240905   gcc-12
i386                  randconfig-016-20240905   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240905   gcc-12
loongarch             randconfig-002-20240905   gcc-12
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                            q40_defconfig   clang-20
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   clang-20
mips                     decstation_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240905   gcc-12
nios2                 randconfig-002-20240905   gcc-12
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240905   gcc-12
parisc                randconfig-002-20240905   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                       holly_defconfig   clang-20
powerpc                        icon_defconfig   clang-20
powerpc               randconfig-001-20240905   gcc-12
powerpc               randconfig-002-20240905   gcc-12
powerpc               randconfig-003-20240905   gcc-12
powerpc64             randconfig-001-20240905   gcc-12
powerpc64             randconfig-002-20240905   gcc-12
powerpc64             randconfig-003-20240905   gcc-12
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                    nommu_k210_defconfig   clang-20
riscv                 randconfig-001-20240905   gcc-12
riscv                 randconfig-002-20240905   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240905   gcc-12
s390                  randconfig-002-20240905   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                 kfr2r09-romimage_defconfig   clang-20
sh                    randconfig-001-20240905   gcc-12
sh                    randconfig-002-20240905   gcc-12
sh                          urquell_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240905   gcc-12
sparc64               randconfig-002-20240905   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240905   gcc-12
um                    randconfig-002-20240905   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240905   gcc-12
x86_64       buildonly-randconfig-002-20240905   gcc-12
x86_64       buildonly-randconfig-003-20240905   gcc-12
x86_64       buildonly-randconfig-004-20240905   gcc-12
x86_64       buildonly-randconfig-005-20240905   gcc-12
x86_64       buildonly-randconfig-006-20240905   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240905   gcc-12
x86_64                randconfig-002-20240905   gcc-12
x86_64                randconfig-003-20240905   gcc-12
x86_64                randconfig-004-20240905   gcc-12
x86_64                randconfig-005-20240905   gcc-12
x86_64                randconfig-006-20240905   gcc-12
x86_64                randconfig-011-20240905   gcc-12
x86_64                randconfig-012-20240905   gcc-12
x86_64                randconfig-013-20240905   gcc-12
x86_64                randconfig-014-20240905   gcc-12
x86_64                randconfig-015-20240905   gcc-12
x86_64                randconfig-016-20240905   gcc-12
x86_64                randconfig-071-20240905   gcc-12
x86_64                randconfig-072-20240905   gcc-12
x86_64                randconfig-073-20240905   gcc-12
x86_64                randconfig-074-20240905   gcc-12
x86_64                randconfig-075-20240905   gcc-12
x86_64                randconfig-076-20240905   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240905   gcc-12
xtensa                randconfig-002-20240905   gcc-12

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

