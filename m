Return-Path: <linux-kernel+bounces-382544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C29B0FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C4A1F234C3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F181FB8BF;
	Fri, 25 Oct 2024 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CeuXiRx8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBEA1B21A7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887332; cv=none; b=Y38Ow6A/XbaVLg3BXaFPm73zbLTmcTaOF+JPLZ7Q5De+g7GUfPhB/6VxCwTpvN14AwvRCw8JSp2JetQdvmW7sWSJFbATgCCGR4q+ATCKKQnATIdQ3LrTqV6cnBZhofrkptXFZTVen9ouyL686jPJniPLAGoK2LhjHj6a1YSN7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887332; c=relaxed/simple;
	bh=ndKj/L9ZIsdQiEwOwbnFeZNcLFW6A/2og4YzSeP5ig0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eNVNhawSPlWbAPXldC0Ju284ffy8+elUqAGCCT6zMsWi1iWkq6nmCU5H02coHLej/cQgrKWHIlcHG1FoAK2X0q1VxuwChpX7mkBpovzS34ZoKkpvIg0h0RRZhj4kQeYT9CytC36PmObp+btlQKa2en8/kyJJI6so5RsISucoulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CeuXiRx8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729887330; x=1761423330;
  h=date:from:to:cc:subject:message-id;
  bh=ndKj/L9ZIsdQiEwOwbnFeZNcLFW6A/2og4YzSeP5ig0=;
  b=CeuXiRx8wMQm9ikl+cKYBneB/MYiEWXBV/XK0fPrtgHn/5XqI5Oh/vWF
   8JG1LTyqcuqMvhokqRoxErYedanLJskf+NaqG6Jhmo/I+tr7fuTAS4YdL
   Vz3S0s7BbD2LX0PVAkN1qOX3FmV6S5eoK9bQVHmi5rh7hZmRQpOyHVaTp
   eH6kx9CLhZhLS0EawuWfXHFo418C3A+sh9K0P5cY73lhb3rJrdWklBAlS
   oZevBJ4SvJs746QWlBSDR4DzSO0Oihl4TxTusIcenEYeDlgefaC1O+YCl
   tDMg9K8j5nxAHk06f02UePDktBUkuN1dUi6rPbgqlIAV5yMxxuFcvC1dn
   w==;
X-CSE-ConnectionGUID: rk3j/9HoQ6exeX6rSzQCUg==
X-CSE-MsgGUID: zhNqihMCTWiE8SRQck7Xxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="47053415"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="47053415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 13:15:29 -0700
X-CSE-ConnectionGUID: 9Gqt+isjQra9JLl1dXPgJg==
X-CSE-MsgGUID: 5qvPDhwzR/Km/HPMmugzPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="85563488"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Oct 2024 13:15:29 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4QiU-000YqX-15;
	Fri, 25 Oct 2024 20:15:26 +0000
Date: Sat, 26 Oct 2024 04:15:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 4d756095d3994cb41393817dc696b458938a6bd0
Message-ID: <202410260412.ObzMn7bz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 4d756095d3994cb41393817dc696b458938a6bd0  uprobe: Add support for session consumer

elapsed time: 734m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                         lpc32xx_defconfig    gcc-14.1.0
arm                         s3c6400_defconfig    gcc-14.1.0
arm                          sp7021_defconfig    gcc-14.1.0
arm                    vt8500_v6_v7_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             alldefconfig    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241025    gcc-12
i386        buildonly-randconfig-002-20241025    gcc-12
i386        buildonly-randconfig-003-20241025    gcc-12
i386        buildonly-randconfig-004-20241025    gcc-12
i386        buildonly-randconfig-005-20241025    gcc-12
i386        buildonly-randconfig-006-20241025    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241025    gcc-12
i386                  randconfig-002-20241025    gcc-12
i386                  randconfig-003-20241025    gcc-12
i386                  randconfig-004-20241025    gcc-12
i386                  randconfig-005-20241025    gcc-12
i386                  randconfig-006-20241025    gcc-12
i386                  randconfig-011-20241025    gcc-12
i386                  randconfig-012-20241025    gcc-12
i386                  randconfig-013-20241025    gcc-12
i386                  randconfig-014-20241025    gcc-12
i386                  randconfig-015-20241025    gcc-12
i386                  randconfig-016-20241025    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                            gpr_defconfig    gcc-14.1.0
mips                           jazz_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     sequoia_defconfig    gcc-14.1.0
powerpc                      tqm8xx_defconfig    gcc-14.1.0
powerpc                        warp_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-14.1.0
sh                        edosk7705_defconfig    gcc-14.1.0
sh                          kfr2r09_defconfig    gcc-14.1.0
sh                     magicpanelr2_defconfig    gcc-14.1.0
sh                           se7619_defconfig    gcc-14.1.0
sh                           se7705_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

