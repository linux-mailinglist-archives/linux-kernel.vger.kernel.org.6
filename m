Return-Path: <linux-kernel+bounces-552057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BB8A574CC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF30C7A59E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C445257437;
	Fri,  7 Mar 2025 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEyyqHdj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B11FFC44
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385638; cv=none; b=cth4EJtUCBBSyMWLaW0ahhT4WXNQb1XczkYbKgEebjJiKgZzjf4AeZzPwrzRhB0FcSh8igCsmqEVKDy+Oe7mg6cTRJqa3LNHL620pGjfgjCZeiU4ofDGNkJyzVQahTJ4+0uPhog09HqfRepkhCDmbjl2aXayqnayTSXZY002N64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385638; c=relaxed/simple;
	bh=XZfBGAgmfAXVkwwmjtULjqLGVdXNlXIUMwjJrlIe05g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pGdCrC7wIElbLrIhfSXEcq8runfRLIuwIEWwlHjP+EJlDAjcyhvXwWK2mxUP3YAHS8H7ZbwB/vNdww9Ia8Gtu3574YeTIUMvdfAjl28/uMleWYuFcop1HfqwiEU+DotUSYE3zdRax6kzFkZ5Ry0melK51oUi/WkuKsH0BFhso1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEyyqHdj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741385637; x=1772921637;
  h=date:from:to:cc:subject:message-id;
  bh=XZfBGAgmfAXVkwwmjtULjqLGVdXNlXIUMwjJrlIe05g=;
  b=nEyyqHdjNfZIg+geJzZyfZTp1WegQTUCD4FEkZtAmeU8WmkkmHnBUuKa
   SAOGKOpwUmGVasaOVI6u4UtzuX0jf8oGmnPvVkWQyupGY1XeC9sdjn6a0
   qj00rF6e6r5hMD9DHuQbe9q/qIy4XVRaEbYmb5RZd19/Khx+RyS1UvM4g
   t6QH48yNj6FH6d8AiVxvvEAZDrMliTCmHUeFYbeODXTXV3xNvYCTaHehJ
   EsR5BRKW3vHXqit6xASiqUShwx/FTGJCPc9Q6uqvuIfm5+A0H8/mB8l8Z
   m5+N971wXFzL87hSuxbLJd3zg+MNAkJBh8Ka625bKvWdYp6+yLosmyVdf
   w==;
X-CSE-ConnectionGUID: hj+F8P/YSduR4DHm8oBekA==
X-CSE-MsgGUID: Ueu9PczHS5SyDYRcp0pnyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="52657743"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="52657743"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:13:56 -0800
X-CSE-ConnectionGUID: aKs5VYozS2WyNiRL3h0WdQ==
X-CSE-MsgGUID: s4XKT1VBRnKDFuKDE9emog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119961030"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 07 Mar 2025 14:13:56 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqfx3-000181-1n;
	Fri, 07 Mar 2025 22:13:53 +0000
Date: Sat, 08 Mar 2025 06:13:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 fd881d0a085fc54354414aed990ccf05f282ba53
Message-ID: <202503080612.fQAVfHZm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: fd881d0a085fc54354414aed990ccf05f282ba53  rseq: Fix segfault on registration when rseq_cs is non-zero

elapsed time: 1455m

configs tested: 80
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                     axs103_smp_defconfig    gcc-13.2.0
arc                       nsim_700_defconfig    gcc-13.2.0
arc                  randconfig-001-20250307    gcc-13.2.0
arc                  randconfig-002-20250307    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                           dove_defconfig    gcc-14.2.0
arm                  randconfig-001-20250307    clang-21
arm                  randconfig-002-20250307    gcc-14.2.0
arm                  randconfig-003-20250307    clang-19
arm                  randconfig-004-20250307    clang-21
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250307    gcc-14.2.0
arm64                randconfig-002-20250307    clang-15
arm64                randconfig-003-20250307    gcc-14.2.0
arm64                randconfig-004-20250307    clang-15
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250307    gcc-14.2.0
csky                 randconfig-002-20250307    gcc-14.2.0
hexagon                          allnoconfig    clang-21
hexagon              randconfig-001-20250307    clang-21
hexagon              randconfig-002-20250307    clang-21
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250307    clang-19
i386       buildonly-randconfig-002-20250307    clang-19
i386       buildonly-randconfig-003-20250307    gcc-11
i386       buildonly-randconfig-004-20250307    clang-19
i386       buildonly-randconfig-005-20250307    gcc-12
i386       buildonly-randconfig-006-20250307    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250307    gcc-14.2.0
loongarch            randconfig-002-20250307    gcc-14.2.0
m68k                             allnoconfig    gcc-14.2.0
mips                             allnoconfig    gcc-14.2.0
nios2                            allnoconfig    gcc-14.2.0
nios2                randconfig-001-20250307    gcc-14.2.0
nios2                randconfig-002-20250307    gcc-14.2.0
openrisc                        alldefconfig    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250307    gcc-14.2.0
parisc               randconfig-002-20250307    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250307    gcc-14.2.0
powerpc              randconfig-002-20250307    clang-21
powerpc              randconfig-003-20250307    clang-19
powerpc64            randconfig-001-20250307    clang-21
powerpc64            randconfig-002-20250307    gcc-14.2.0
powerpc64            randconfig-003-20250307    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250307    gcc-14.2.0
riscv                randconfig-002-20250307    clang-19
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250307    gcc-14.2.0
s390                 randconfig-002-20250307    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250307    gcc-14.2.0
sh                   randconfig-002-20250307    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250307    gcc-14.2.0
sparc                randconfig-002-20250307    gcc-14.2.0
sparc64              randconfig-001-20250307    gcc-14.2.0
sparc64              randconfig-002-20250307    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250307    clang-17
um                   randconfig-002-20250307    clang-21
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250307    clang-19
x86_64     buildonly-randconfig-002-20250307    gcc-12
x86_64     buildonly-randconfig-003-20250307    clang-19
x86_64     buildonly-randconfig-004-20250307    clang-19
x86_64     buildonly-randconfig-005-20250307    clang-19
x86_64     buildonly-randconfig-006-20250307    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250307    gcc-14.2.0
xtensa               randconfig-002-20250307    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

