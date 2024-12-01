Return-Path: <linux-kernel+bounces-426750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391B09DF747
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 23:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A37281608
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FF61D9324;
	Sun,  1 Dec 2024 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fr4DUEh3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D51D86F1
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733092308; cv=none; b=iThVLxoJub5SOEIAbVqNsC0/nX8a4HO7pUxPBY7D3qPdLUOnbseOb1zMx7tb3N1W61zk8uqh2DygDCYUG46/mGvf3v64Jd2unFfZgRzCNPgg4+Ur9X1eJSDvtY3u3Wy/rKvD18ylGWZa9gZTH772TrEIKqt1JEMQ+eHXlp6vOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733092308; c=relaxed/simple;
	bh=o/ZcRs0TmEbaXEbtEkgp8PMkcFmqFni61T1n008tANQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iQHIYgmC/ZIch1Ke8IElUfqdEbwQIhFghvLgZrwCZ5HNHlCHBIqGpHnjOr+5VeM3A1I6fvjt0r4z/nOF1qJkPrekZcZwKZ1O17q4er0P4plEbL63D5MwTK7CNjCeUlWwkTDAVqggdOcejTQS9teCPHx8T/pApIThZo+xhE+5BIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fr4DUEh3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733092307; x=1764628307;
  h=date:from:to:cc:subject:message-id;
  bh=o/ZcRs0TmEbaXEbtEkgp8PMkcFmqFni61T1n008tANQ=;
  b=Fr4DUEh3R7Vvx6UoRHRPXvLFEnIS9LKtghAM3YIzD2c3UdUxVEPtP2LZ
   EQeyfD5zw2yyQ6Lgg795U4Sjn0bK/MSvceFhbk406UGLxlFpHUmDeLmQl
   jLig4h+6ef9loXTI8nROD8gFlnu6bzVfcFHNCMK0dBm1JyAvorlSb1LNz
   lVYKq5pQjIehKq2sBpjbNwv5gtfqtmVQQqGISgOXS88n+ICEsEbaSvfSu
   nFRRyfapHJgPAraPopf78Mybjz0bZHM7Z5PbjtZAriAa5GCeLOC6NUGaZ
   m1m7NbmJAIP8O7p/rmK9Z56p3yDakH5iPnSqSXb/bQ/xehz6nYnKghsX1
   w==;
X-CSE-ConnectionGUID: xyBfP8VQTfirMoxBdilZsw==
X-CSE-MsgGUID: ykESAJM4TMClmr+J+So16A==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="58644903"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="58644903"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 14:31:46 -0800
X-CSE-ConnectionGUID: dVqtM39sQsyPNXYsrWtHig==
X-CSE-MsgGUID: UY1ZXO65SbWN0+kIPdNowg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="93105234"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 01 Dec 2024 14:31:45 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHsTf-0001tZ-0F;
	Sun, 01 Dec 2024 22:31:43 +0000
Date: Mon, 02 Dec 2024 06:29:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 ee044f0ee9c4ac706010c543b5dc470c4a600cb4
Message-ID: <202412020616.90cdqY6y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: ee044f0ee9c4ac706010c543b5dc470c4a600cb4  Merge branch into tip/master: 'x86/urgent'

elapsed time: 721m

configs tested: 161
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    clang-20
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                   randconfig-001-20241201    gcc-13.2.0
arc                   randconfig-002-20241201    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    gcc-14.2.0
arm                          exynos_defconfig    clang-20
arm                      footbridge_defconfig    clang-20
arm                       imx_v4_v5_defconfig    clang-16
arm                           imxrt_defconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-20
arm                        multi_v7_defconfig    clang-20
arm                        mvebu_v5_defconfig    clang-20
arm                       netwinder_defconfig    gcc-14.2.0
arm                            qcom_defconfig    clang-20
arm                   randconfig-001-20241201    clang-20
arm                   randconfig-002-20241201    gcc-14.2.0
arm                   randconfig-003-20241201    clang-20
arm                   randconfig-004-20241201    clang-20
arm                           sama7_defconfig    clang-20
arm                        shmobile_defconfig    gcc-14.2.0
arm                           stm32_defconfig    clang-20
arm                           sunxi_defconfig    clang-20
arm                           u8500_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    clang-20
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241201    clang-15
arm64                 randconfig-002-20241201    clang-20
arm64                 randconfig-003-20241201    gcc-14.2.0
arm64                 randconfig-004-20241201    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386        buildonly-randconfig-001-20241201    gcc-12
i386        buildonly-randconfig-002-20241201    clang-19
i386        buildonly-randconfig-003-20241201    clang-19
i386        buildonly-randconfig-004-20241201    gcc-12
i386        buildonly-randconfig-005-20241201    clang-19
i386        buildonly-randconfig-006-20241201    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    clang-20
m68k                       m5475evb_defconfig    clang-20
m68k                        mvme16x_defconfig    clang-20
m68k                        stmark2_defconfig    clang-20
m68k                           sun3_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-20
mips                        maltaup_defconfig    clang-20
mips                        qi_lb60_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-20
powerpc                      cm5200_defconfig    clang-20
powerpc                    gamecube_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    clang-20
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-14
powerpc                   motionpro_defconfig    clang-17
powerpc                   motionpro_defconfig    clang-20
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-20
powerpc                      pasemi_defconfig    clang-20
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-20
powerpc                    socrates_defconfig    clang-20
powerpc                     tqm8555_defconfig    clang-20
powerpc                         wii_defconfig    clang-20
powerpc64                        alldefconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                       zfcpdump_defconfig    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                         ecovec24_defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                          sdk7780_defconfig    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                     sh7710voipgw_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                             i386_defconfig    clang-20
um                           x86_64_defconfig    gcc-14.2.0
x86_64      buildonly-randconfig-001-20241201    clang-19
x86_64      buildonly-randconfig-002-20241201    gcc-12
x86_64      buildonly-randconfig-003-20241201    gcc-12
x86_64      buildonly-randconfig-004-20241201    clang-19
x86_64      buildonly-randconfig-005-20241201    clang-19
x86_64      buildonly-randconfig-006-20241201    gcc-12
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

