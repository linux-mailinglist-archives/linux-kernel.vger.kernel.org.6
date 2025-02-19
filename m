Return-Path: <linux-kernel+bounces-521269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2027A3BAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C2F16AA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97471C5D69;
	Wed, 19 Feb 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="In+KXoMa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5D1C3F0A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958392; cv=none; b=IMoWZcs0/1eWFXIk0nOXibJaXm4O3pyriSFnKjbFmCPafJfxhe1k0xgDEHklYFmvgoEWubmD3SvjDv2L0HATRBBZyHPvgLUFH925AJKFfx31PP7muMoxVBRodQbakPtKq3TPVBpJ1AIFZ0dKCEsPsnsCw3FQfoRw2XNluW+xpNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958392; c=relaxed/simple;
	bh=LaiGN00YHMheHMicnD22/CtLfvshsjP1RLSxkBXzSqc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oJNlUD/Obn+cY3+2IBEe1nacNILfuTt8R9a1CCBC0CFp2mx9qero0SMa97gkZmstQD3q0133KYrCW9T3S+J8ub1XCVVhTFXNKzzK5NoIUjTGC3m5r5upcLC8jaeFbbhkjY1Pn6qrHj1cphT7mRsvCv8gFC3Dd7piOImD5G4b5d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=In+KXoMa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739958390; x=1771494390;
  h=date:from:to:cc:subject:message-id;
  bh=LaiGN00YHMheHMicnD22/CtLfvshsjP1RLSxkBXzSqc=;
  b=In+KXoMac21d/l/yR6jVNCdD04TRA0W892JRxl+w1XuUXgLDjNtGz7cu
   iGqi3JsfmneG4QMeCjjRNBDvl/EOhZ1s4MkqP+MAeie/ARI2S3sBfgGvu
   rXjxnSQWsmEO/cu1t/tcdU6CrIEXgT/wBe+D+hOFg4JAwqJn4SBYcI4wl
   qhUscyIoRBRzOt1k+Fy8UVFpQ3oICGVjyBADoJxcAjTDDkfNaQCmplXsk
   P39skrEUApSJGrPUK+9wt3RPqyj+P/6ApbKDGIZs4J7puRwV/TVwuIxV/
   guohsr39GvZaxYRNRGsL4AcAsv44jDQS6YTh4AY56TKpTkttVpHs91O6d
   w==;
X-CSE-ConnectionGUID: Ot6ibQpfQPuyexCbonemYw==
X-CSE-MsgGUID: YENr4cV/QGOif01z52dojg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="58094025"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="58094025"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 01:46:27 -0800
X-CSE-ConnectionGUID: gp6G8GdQQa+OmRDJlHUcBQ==
X-CSE-MsgGUID: gtY3KFI5ShWIPPrOEtmxJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="119774750"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 19 Feb 2025 01:46:26 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkgeu-0002k9-0V;
	Wed, 19 Feb 2025 09:46:24 +0000
Date: Wed, 19 Feb 2025 17:46:22 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 f99c5bb396b8d1424ed229d1ffa6f596e3b9c36b
Message-ID: <202502191716.NgmMpzQ8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: f99c5bb396b8d1424ed229d1ffa6f596e3b9c36b  posix-timers: Invoke cond_resched() during exit_itimers()

elapsed time: 1458m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250218    gcc-13.2.0
arc                   randconfig-002-20250218    gcc-13.2.0
arc                           tb10x_defconfig    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250218    gcc-14.2.0
arm                   randconfig-002-20250218    gcc-14.2.0
arm                   randconfig-003-20250218    gcc-14.2.0
arm                   randconfig-004-20250218    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250218    clang-21
arm64                 randconfig-002-20250218    clang-21
arm64                 randconfig-003-20250218    gcc-14.2.0
arm64                 randconfig-004-20250218    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250218    gcc-14.2.0
csky                  randconfig-002-20250218    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250218    clang-17
hexagon               randconfig-002-20250218    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250218    gcc-12
i386        buildonly-randconfig-002-20250218    gcc-12
i386        buildonly-randconfig-003-20250218    gcc-12
i386        buildonly-randconfig-004-20250218    clang-19
i386        buildonly-randconfig-005-20250218    clang-19
i386        buildonly-randconfig-006-20250218    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250218    gcc-14.2.0
loongarch             randconfig-002-20250218    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip22_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    clang-16
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250218    gcc-14.2.0
nios2                 randconfig-002-20250218    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250218    gcc-14.2.0
parisc                randconfig-002-20250218    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 mpc836x_rdk_defconfig    clang-18
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250218    gcc-14.2.0
powerpc               randconfig-002-20250218    gcc-14.2.0
powerpc               randconfig-003-20250218    clang-21
powerpc64             randconfig-001-20250218    gcc-14.2.0
powerpc64             randconfig-002-20250218    clang-16
powerpc64             randconfig-003-20250218    clang-18
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250218    gcc-14.2.0
riscv                 randconfig-002-20250218    clang-21
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250218    clang-21
s390                  randconfig-002-20250218    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250218    gcc-14.2.0
sh                    randconfig-002-20250218    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250218    gcc-14.2.0
sparc                 randconfig-002-20250218    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250218    gcc-14.2.0
sparc64               randconfig-002-20250218    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250218    clang-21
um                    randconfig-002-20250218    gcc-11
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250218    clang-19
x86_64      buildonly-randconfig-002-20250218    gcc-12
x86_64      buildonly-randconfig-003-20250218    clang-19
x86_64      buildonly-randconfig-004-20250218    gcc-12
x86_64      buildonly-randconfig-005-20250218    clang-19
x86_64      buildonly-randconfig-006-20250218    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250218    gcc-14.2.0
xtensa                randconfig-002-20250218    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

