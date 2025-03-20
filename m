Return-Path: <linux-kernel+bounces-570477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99875A6B0FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3593BCBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DC521B9CD;
	Thu, 20 Mar 2025 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGtVFh1y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E333D994
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510089; cv=none; b=JxayoLakxKMOhMJwR4+V7AQ0lY6XZBcZnRJtRlkKTy+LAu+TZ5G1nTMMadeZ7hGwg9lPcLdg5FPe/Bq/bydy+qqeuZK2z/pM788fT4D8kIFQz8dmhfoiMYLSNzkVrHC76wPVCsVqlT8T8jlvIz7zJqtKxYeAX3e4Ul1FizMT9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510089; c=relaxed/simple;
	bh=xp+f14rxIkvQJOoTO411QSGlc44wVP92epHY2IztsRk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QCBm3SV+l6gmVtOYxa5y5uW9DGMxplNHeG1ZshG87GGYwuvHYqIRJwUG6W0dQFJKzvI1wv7cPxS7lkqbtOCoAzr6Dt1H3IPNf/9648wkUzJCfjWxmiUEUzqMgVYA01PRM0jz7VIZLsG0eTxKM9HDlEcm2vyi8E1Gh6y085pZiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGtVFh1y; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742510088; x=1774046088;
  h=date:from:to:cc:subject:message-id;
  bh=xp+f14rxIkvQJOoTO411QSGlc44wVP92epHY2IztsRk=;
  b=jGtVFh1y8g6s8/2VQwmMy4Se4TRcReGVDIRPPS2UIkcz8twA38xmrQS3
   p+1mRrE63uO91TlKKAJ24zGS51jnTfZUud2oXhcXTd0BMFTbn0VhKs9Ek
   b3L+vGoXdHmyki26oNzzLbCYCT3nw81AbR2rCbQQATYYchP/XaRbw1pbt
   +x+hcCS+9MfLMQ08WJZ3KiTWhCb5PqnnLNkEJHb3fe5Rx+Me5l8DoIQh4
   N6pCA1IzwkZdG1W+aWxrF+y5yDMPe71Nmu6S3QILw3JixMzBQYIFri9hZ
   ALC5PMFcGtksyZIU+kHV8S5OiHXsFJK1ZglW2uA3b4dGofF8QB4s6JzUj
   Q==;
X-CSE-ConnectionGUID: pW+PN0aeTpyfnjelyuCEbw==
X-CSE-MsgGUID: /0CGfjzXT8+T1y4Gpm1iTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43897307"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="43897307"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 15:34:47 -0700
X-CSE-ConnectionGUID: zavdKwhhQrCBhohEO4Upgw==
X-CSE-MsgGUID: ni7J45sbTjWUG3EggdDf2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="123217489"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 Mar 2025 15:34:47 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvOTM-0000pb-10;
	Thu, 20 Mar 2025 22:34:44 +0000
Date: Fri, 21 Mar 2025 06:34:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:WIP.sched/core] BUILD SUCCESS
 b52173065e0aad82a31863bb5f63ebe46f7eb657
Message-ID: <202503210622.DP5Tvi5P-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.sched/core
branch HEAD: b52173065e0aad82a31863bb5f63ebe46f7eb657  sched/debug: Remove CONFIG_SCHED_DEBUG

elapsed time: 1447m

configs tested: 242
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    gcc-14.2.0
arc                   randconfig-001-20250320    gcc-10.5.0
arc                   randconfig-001-20250321    clang-21
arc                   randconfig-002-20250320    gcc-8.5.0
arc                   randconfig-002-20250321    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                   randconfig-001-20250320    clang-20
arm                   randconfig-001-20250321    clang-21
arm                   randconfig-002-20250320    clang-16
arm                   randconfig-002-20250321    clang-21
arm                   randconfig-003-20250320    gcc-8.5.0
arm                   randconfig-003-20250321    clang-21
arm                   randconfig-004-20250320    gcc-7.5.0
arm                   randconfig-004-20250321    clang-21
arm                           sama7_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm                       versatile_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250320    clang-21
arm64                 randconfig-001-20250321    clang-21
arm64                 randconfig-002-20250320    clang-21
arm64                 randconfig-002-20250321    clang-21
arm64                 randconfig-003-20250320    clang-19
arm64                 randconfig-003-20250321    clang-21
arm64                 randconfig-004-20250320    gcc-8.5.0
arm64                 randconfig-004-20250321    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250320    gcc-10.5.0
csky                  randconfig-001-20250321    gcc-7.5.0
csky                  randconfig-002-20250320    gcc-14.2.0
csky                  randconfig-002-20250321    gcc-7.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250320    clang-18
hexagon               randconfig-001-20250321    gcc-7.5.0
hexagon               randconfig-002-20250320    clang-21
hexagon               randconfig-002-20250321    gcc-7.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250320    gcc-12
i386        buildonly-randconfig-002-20250320    clang-20
i386        buildonly-randconfig-003-20250320    clang-20
i386        buildonly-randconfig-004-20250320    clang-20
i386        buildonly-randconfig-005-20250320    gcc-12
i386        buildonly-randconfig-006-20250320    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250321    clang-20
i386                  randconfig-002-20250321    clang-20
i386                  randconfig-003-20250321    clang-20
i386                  randconfig-004-20250321    clang-20
i386                  randconfig-005-20250321    clang-20
i386                  randconfig-006-20250321    clang-20
i386                  randconfig-007-20250321    clang-20
i386                  randconfig-011-20250321    clang-20
i386                  randconfig-012-20250321    clang-20
i386                  randconfig-013-20250321    clang-20
i386                  randconfig-014-20250321    clang-20
i386                  randconfig-015-20250321    clang-20
i386                  randconfig-016-20250321    clang-20
i386                  randconfig-017-20250321    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250320    gcc-14.2.0
loongarch             randconfig-001-20250321    gcc-7.5.0
loongarch             randconfig-002-20250320    gcc-12.4.0
loongarch             randconfig-002-20250321    gcc-7.5.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-6.5.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-9.3.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250320    gcc-6.5.0
nios2                 randconfig-001-20250321    gcc-7.5.0
nios2                 randconfig-002-20250320    gcc-12.4.0
nios2                 randconfig-002-20250321    gcc-7.5.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250320    gcc-13.3.0
parisc                randconfig-001-20250321    gcc-7.5.0
parisc                randconfig-002-20250320    gcc-11.5.0
parisc                randconfig-002-20250321    gcc-7.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250320    gcc-6.5.0
powerpc               randconfig-001-20250321    gcc-7.5.0
powerpc               randconfig-002-20250320    clang-21
powerpc               randconfig-002-20250321    gcc-7.5.0
powerpc               randconfig-003-20250320    clang-21
powerpc               randconfig-003-20250321    gcc-7.5.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250320    clang-21
powerpc64             randconfig-001-20250321    gcc-7.5.0
powerpc64             randconfig-002-20250320    gcc-8.5.0
powerpc64             randconfig-002-20250321    gcc-7.5.0
powerpc64             randconfig-003-20250320    clang-21
powerpc64             randconfig-003-20250321    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250320    clang-21
riscv                 randconfig-001-20250321    gcc-6.5.0
riscv                 randconfig-002-20250320    gcc-8.5.0
riscv                 randconfig-002-20250321    gcc-6.5.0
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                             allyesconfig    gcc-8.5.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250320    gcc-5.5.0
s390                  randconfig-001-20250321    gcc-6.5.0
s390                  randconfig-002-20250320    gcc-7.5.0
s390                  randconfig-002-20250321    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250320    gcc-14.2.0
sh                    randconfig-001-20250321    gcc-6.5.0
sh                    randconfig-002-20250320    gcc-10.5.0
sh                    randconfig-002-20250321    gcc-6.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250320    gcc-7.5.0
sparc                 randconfig-001-20250321    gcc-6.5.0
sparc                 randconfig-002-20250320    gcc-7.5.0
sparc                 randconfig-002-20250321    gcc-6.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250320    gcc-5.5.0
sparc64               randconfig-001-20250321    gcc-6.5.0
sparc64               randconfig-002-20250320    gcc-13.3.0
sparc64               randconfig-002-20250321    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-15
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250320    gcc-12
um                    randconfig-001-20250321    gcc-6.5.0
um                    randconfig-002-20250320    clang-16
um                    randconfig-002-20250321    gcc-6.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250320    clang-20
x86_64      buildonly-randconfig-001-20250321    clang-20
x86_64      buildonly-randconfig-002-20250320    gcc-12
x86_64      buildonly-randconfig-002-20250321    clang-20
x86_64      buildonly-randconfig-003-20250320    clang-20
x86_64      buildonly-randconfig-003-20250321    clang-20
x86_64      buildonly-randconfig-004-20250320    clang-20
x86_64      buildonly-randconfig-004-20250321    clang-20
x86_64      buildonly-randconfig-005-20250320    clang-20
x86_64      buildonly-randconfig-005-20250321    clang-20
x86_64      buildonly-randconfig-006-20250320    gcc-12
x86_64      buildonly-randconfig-006-20250321    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250321    clang-20
x86_64                randconfig-002-20250321    clang-20
x86_64                randconfig-003-20250321    clang-20
x86_64                randconfig-004-20250321    clang-20
x86_64                randconfig-005-20250321    clang-20
x86_64                randconfig-006-20250321    clang-20
x86_64                randconfig-007-20250321    clang-20
x86_64                randconfig-008-20250321    clang-20
x86_64                randconfig-071-20250321    gcc-12
x86_64                randconfig-072-20250321    gcc-12
x86_64                randconfig-073-20250321    gcc-12
x86_64                randconfig-074-20250321    gcc-12
x86_64                randconfig-075-20250321    gcc-12
x86_64                randconfig-076-20250321    gcc-12
x86_64                randconfig-077-20250321    gcc-12
x86_64                randconfig-078-20250321    gcc-12
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250320    gcc-9.3.0
xtensa                randconfig-001-20250321    gcc-6.5.0
xtensa                randconfig-002-20250320    gcc-11.5.0
xtensa                randconfig-002-20250321    gcc-6.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

