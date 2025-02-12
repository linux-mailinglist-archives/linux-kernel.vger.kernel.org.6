Return-Path: <linux-kernel+bounces-510808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D872A3224D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B113A7ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68342204F81;
	Wed, 12 Feb 2025 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoHPEgm7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA951F0E56
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352936; cv=none; b=MzEe56AOTuOnDTFyNM+m7OTHt1ZXAvUqCR0jClmxdaG+jEsudr7dy6m+g9xqY7nLeTIUCS2VCzy1t1r+ae4nJy8UIfyuI0CdDTnrsi/tT6eVrFhPiW45BlrX3ymifoDAFPpHCzUaxN7oJLppZSmIJ3VXquoF0QPnsFJ73iTNmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352936; c=relaxed/simple;
	bh=TywHvju8H//FMXAG5rOoTaJNZv1IFklKjNHqTmhsrSA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ejm7Q1CvWhlH2l0SpYLcKOTcYuJAqXqXtNrmWhmz/n4qJp6KLYquX8shdu0N/FJDqvRtZ4HKKN0wCjvhsPoQX6MaPjfop040VBEuu/jE+gT5xPg50p3TQrZnLsxm3O5r4NVzOwbJQ1nRmzY9KroPyaU4N9eJrLSkQBrCeAiaoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoHPEgm7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739352934; x=1770888934;
  h=date:from:to:cc:subject:message-id;
  bh=TywHvju8H//FMXAG5rOoTaJNZv1IFklKjNHqTmhsrSA=;
  b=NoHPEgm7LaK4B52V0pTBjPTFHdJROL9X5lY6QXkkBTCq91HNMc/xVeKc
   Z1ghtO7T2EaBDdQncx5e0x3vyvKlHMCA6BgREeeOkJqnpI9GBNQt8eM9u
   7lhCr9LweeQkPgN/labCxcakvEZqQ1ARIvN1u8b2b1MRM2Ee5sz67+joq
   /tTzxqdw64UNXiihsW4CuChezGpDVflKkX6wBfY5cusAGPYFaqQ0LotEg
   7nxv5SCoSCOoTo0ICWZTV7LHZbVrDKqXrcom+VEnGxfQpx9WILlGX3rc6
   unbTGftk4FBQg7BeWACzbhQ4rBmaZBts3YRyVNLYkifUD3dYtgAIn0hhA
   w==;
X-CSE-ConnectionGUID: LHZkZMpoTaK1noHujK8Cew==
X-CSE-MsgGUID: KcxcLvxLQHmERPWerT9sWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="62467353"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="62467353"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 01:35:34 -0800
X-CSE-ConnectionGUID: qzC1B6reSvmyvrRQi8ud8A==
X-CSE-MsgGUID: tuKIMIbrTc6VkqCEAKJlPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112756475"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Feb 2025 01:35:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti99W-0015Rf-2Q;
	Wed, 12 Feb 2025 09:35:30 +0000
Date: Wed, 12 Feb 2025 17:35:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250210] BUILD SUCCESS
 85e9e79e48ba1042e61ff8bf0f100e35e1b9e3bc
Message-ID: <202502121748.DuNg35NR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250210
branch HEAD: 85e9e79e48ba1042e61ff8bf0f100e35e1b9e3bc  cifs: Avoid multiple -Wflex-array-member-not-at-end warnings

elapsed time: 1457m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250211    gcc-13.2.0
arc                   randconfig-002-20250211    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                         lpc32xx_defconfig    clang-21
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250211    gcc-14.2.0
arm                   randconfig-002-20250211    clang-21
arm                   randconfig-003-20250211    gcc-14.2.0
arm                   randconfig-004-20250211    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250211    clang-17
arm64                 randconfig-002-20250211    clang-19
arm64                 randconfig-003-20250211    gcc-14.2.0
arm64                 randconfig-004-20250211    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250211    gcc-14.2.0
csky                  randconfig-002-20250211    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250211    clang-18
hexagon               randconfig-002-20250211    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250211    gcc-12
i386        buildonly-randconfig-002-20250211    gcc-12
i386        buildonly-randconfig-003-20250211    gcc-12
i386        buildonly-randconfig-004-20250211    gcc-12
i386        buildonly-randconfig-005-20250211    gcc-12
i386        buildonly-randconfig-006-20250211    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250211    gcc-14.2.0
loongarch             randconfig-002-20250211    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250211    gcc-14.2.0
nios2                 randconfig-002-20250211    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250211    gcc-14.2.0
parisc                randconfig-002-20250211    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      cm5200_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    clang-18
powerpc                      pcm030_defconfig    clang-17
powerpc               randconfig-001-20250211    clang-15
powerpc               randconfig-002-20250211    clang-21
powerpc               randconfig-003-20250211    clang-19
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250211    clang-21
powerpc64             randconfig-002-20250211    gcc-14.2.0
powerpc64             randconfig-003-20250211    clang-17
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250211    gcc-14.2.0
riscv                 randconfig-002-20250211    clang-19
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250211    clang-21
s390                  randconfig-002-20250211    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250211    gcc-14.2.0
sh                    randconfig-002-20250211    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250211    gcc-14.2.0
sparc                 randconfig-002-20250211    gcc-14.2.0
sparc64               randconfig-001-20250211    gcc-14.2.0
sparc64               randconfig-002-20250211    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250211    clang-17
um                    randconfig-002-20250211    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250211    clang-19
x86_64      buildonly-randconfig-002-20250211    gcc-12
x86_64      buildonly-randconfig-003-20250211    clang-19
x86_64      buildonly-randconfig-004-20250211    gcc-11
x86_64      buildonly-randconfig-005-20250211    clang-19
x86_64      buildonly-randconfig-006-20250211    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250211    gcc-14.2.0
xtensa                randconfig-002-20250211    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

