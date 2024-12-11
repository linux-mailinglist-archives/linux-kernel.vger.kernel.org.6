Return-Path: <linux-kernel+bounces-441073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6CF9EC909
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534ED166D46
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19D1236F9A;
	Wed, 11 Dec 2024 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzQ6rai9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25456236F8E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909259; cv=none; b=f/MEcFlYPVgsaphcZcB8vOP5uy+gM7QJyTn7rb2SARmSva0BygXLrZP72w5ytP8zwv19qb4VF3kCk1rU+09kyfbB9Y1sCUqNDVQMmKf9Wiu69B0aw+0JjwrRke71auTOQg57iHguj1B6+WCi/xy8bT+nMzpk+9BIj28oktlHbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909259; c=relaxed/simple;
	bh=iZSrasQoSRBFpoNP7UVR/fq1HuP5rywVm+Po53ifmWo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=btpxlqmixQljm17JOvUQm2fJQ1jC3rWGrAL6acmVT1n9JRDWgVLf0CNOuawjPamiL0L668TTx0sJOYhMoPCBttLzXyDaDbg6MIfd9wn1EEIC5nb6MnlBBGOQpPa2uZmp2NLEKJqYoIuIcsRXRsOB2HfzijYmY1RNsXYeG6fwGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzQ6rai9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733909258; x=1765445258;
  h=date:from:to:cc:subject:message-id;
  bh=iZSrasQoSRBFpoNP7UVR/fq1HuP5rywVm+Po53ifmWo=;
  b=NzQ6rai92cXUkZ+otwFegYSCjkxAp6KJ7mYeSgAlPXkU0Agl2POn2qzI
   use3pw3rqdjxqkG1xEkjTmVBhP9t+XhLlVbjSYB6ZIshf5rP6UVzV5WJX
   9UkGBewXG98Taf0xULGoTuf3ZyrKdg7AjlDAkDaSqEFnRl+8JjKvdcdBS
   R956vbeYJx4bo4TJUHKDWRhmpQr13AFaEMgCZj11KPjrdWJWfJjYuFTau
   6mgwfbhWCI3wjhSGXH5k2cDdpMJALLPRgglHh7EMYryeExNufRYNLNuS1
   E+J3xCO1te01uOwNvkYVJwHDbyHEsOgKqf4BiBXke4eUStGKFHXYuH2OA
   w==;
X-CSE-ConnectionGUID: U+p7nBueQeSorzY/Uz2K+g==
X-CSE-MsgGUID: xVN/y8b6QrySmBHskW+aTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34181928"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34181928"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 01:27:38 -0800
X-CSE-ConnectionGUID: CPkkdL97TgqgA49zmmsl5Q==
X-CSE-MsgGUID: EutWKAmDTi2jpIfUyqLvvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95930359"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Dec 2024 01:27:36 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLJ0I-0006UL-0u;
	Wed, 11 Dec 2024 09:27:34 +0000
Date: Wed, 11 Dec 2024 17:26:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 3560a023a9b9965803e8a967ee88343879b5dc1b
Message-ID: <202412111740.MvWSX0CO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 3560a023a9b9965803e8a967ee88343879b5dc1b  x86/cpu: Fix typo in x86_match_cpu()'s doc

elapsed time: 743m

configs tested: 139
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                              allmodconfig    clang-18
arc                              allyesconfig    clang-18
arc                   randconfig-001-20241211    gcc-14.2.0
arc                   randconfig-002-20241211    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allyesconfig    clang-18
arm                        mvebu_v5_defconfig    clang-20
arm                   randconfig-001-20241211    gcc-14.2.0
arm                   randconfig-002-20241211    gcc-14.2.0
arm                   randconfig-003-20241211    gcc-14.2.0
arm                   randconfig-004-20241211    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20241211    gcc-14.2.0
arm64                 randconfig-002-20241211    gcc-14.2.0
arm64                 randconfig-003-20241211    gcc-14.2.0
arm64                 randconfig-004-20241211    gcc-14.2.0
csky                  randconfig-001-20241211    gcc-14.2.0
csky                  randconfig-002-20241211    gcc-14.2.0
hexagon               randconfig-001-20241211    gcc-14.2.0
hexagon               randconfig-002-20241211    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241211    clang-19
i386        buildonly-randconfig-002-20241211    gcc-11
i386        buildonly-randconfig-003-20241211    clang-19
i386        buildonly-randconfig-004-20241211    gcc-11
i386        buildonly-randconfig-005-20241211    gcc-12
i386        buildonly-randconfig-006-20241211    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241211    gcc-12
i386                  randconfig-002-20241211    gcc-12
i386                  randconfig-003-20241211    gcc-12
i386                  randconfig-004-20241211    gcc-12
i386                  randconfig-005-20241211    gcc-12
i386                  randconfig-006-20241211    gcc-12
i386                  randconfig-007-20241211    gcc-12
i386                  randconfig-011-20241211    gcc-12
i386                  randconfig-012-20241211    gcc-12
i386                  randconfig-013-20241211    gcc-12
i386                  randconfig-014-20241211    gcc-12
i386                  randconfig-015-20241211    gcc-12
i386                  randconfig-016-20241211    gcc-12
i386                  randconfig-017-20241211    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20241211    gcc-14.2.0
loongarch             randconfig-002-20241211    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    clang-20
nios2                 randconfig-001-20241211    gcc-14.2.0
nios2                 randconfig-002-20241211    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241211    gcc-14.2.0
parisc                randconfig-002-20241211    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241211    gcc-14.2.0
powerpc               randconfig-002-20241211    gcc-14.2.0
powerpc               randconfig-003-20241211    gcc-14.2.0
powerpc                     skiroot_defconfig    clang-20
powerpc                         wii_defconfig    clang-20
powerpc64             randconfig-001-20241211    gcc-14.2.0
powerpc64             randconfig-002-20241211    gcc-14.2.0
powerpc64             randconfig-003-20241211    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    clang-20
riscv                 randconfig-001-20241211    clang-20
riscv                 randconfig-002-20241211    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241211    clang-20
s390                  randconfig-002-20241211    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-20
sh                    randconfig-001-20241211    clang-20
sh                    randconfig-002-20241211    clang-20
sh                   sh7770_generic_defconfig    clang-20
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20241211    clang-20
sparc                 randconfig-002-20241211    clang-20
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241211    clang-20
sparc64               randconfig-002-20241211    clang-20
um                                allnoconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241211    clang-20
um                    randconfig-002-20241211    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241211    gcc-12
x86_64      buildonly-randconfig-002-20241211    gcc-11
x86_64      buildonly-randconfig-002-20241211    gcc-12
x86_64      buildonly-randconfig-003-20241211    gcc-12
x86_64      buildonly-randconfig-004-20241211    gcc-12
x86_64      buildonly-randconfig-005-20241211    gcc-12
x86_64      buildonly-randconfig-006-20241211    clang-19
x86_64      buildonly-randconfig-006-20241211    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241211    clang-19
x86_64                randconfig-002-20241211    clang-19
x86_64                randconfig-003-20241211    clang-19
x86_64                randconfig-004-20241211    clang-19
x86_64                randconfig-005-20241211    clang-19
x86_64                randconfig-006-20241211    clang-19
x86_64                randconfig-007-20241211    clang-19
x86_64                randconfig-008-20241211    clang-19
x86_64                randconfig-071-20241211    clang-19
x86_64                randconfig-072-20241211    clang-19
x86_64                randconfig-073-20241211    clang-19
x86_64                randconfig-074-20241211    clang-19
x86_64                randconfig-075-20241211    clang-19
x86_64                randconfig-076-20241211    clang-19
x86_64                randconfig-077-20241211    clang-19
x86_64                randconfig-078-20241211    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                randconfig-001-20241211    clang-20
xtensa                randconfig-002-20241211    clang-20
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

