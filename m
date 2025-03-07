Return-Path: <linux-kernel+bounces-551078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA596A567DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71F53B21DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7387721771E;
	Fri,  7 Mar 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzzRV1pd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DB14A4F9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350728; cv=none; b=IJP/Ou8DcWLSOyZvceL06QGgyxjBfyg+gPHgncyYmTEnuuYPxkhUYTM48gYmbOc5VNPGVUH+EdoO8RPTlUPXdGqzM3YdjOjZufH+Lv0QxwJjMGumHOT/fMAFjco/3J6QYTkKEu4sdkVLjrT7Dh+aN3LsI32ccBshaxH1ePq+ZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350728; c=relaxed/simple;
	bh=5IF2rvPntwMmqVw/FP3XxpZmqFIGI/SFIO9N9/GSmCU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z6NTyBtj+lXC/noObtOEBQ9Ha/c87cPm9GZA7/i+/AoI6LrpeHrQJz/viUhSc547LFsAI3sPW3krB5mm7wK6Vtfje/3aci92EF85zDtInwNINLL/2eq4LpjQRiSzlMnHiZxyElwSv5jwUg/QjglfGV1lOGZbaRJjle2c98Abe8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzzRV1pd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741350727; x=1772886727;
  h=date:from:to:cc:subject:message-id;
  bh=5IF2rvPntwMmqVw/FP3XxpZmqFIGI/SFIO9N9/GSmCU=;
  b=FzzRV1pdKmV0ssyJwYv5Tp3ON+8EOkKJ1aPkUWowxSCmO02+kZmtiYdl
   RNW4ojW6FRpLH2FEtD1orRNsJlXK9y8vzYWRdgnS9TELh0DVwAkNNRca5
   //s4s5ha1BfrWpoHmZMdCJ6in9j8z9aEdhsAUbOxHLjCaDdWXw4boKvt3
   MM+HCHdMalOTyMf3s5hF84QMbdZ3ceqqxfjX0BnTGdS6oST8nP/0ANT41
   YPG0UYn0zyvx2/B/zdbYIgScWGlnhoojboDBr0Cs4CCAEKTyOAszESS/r
   Uq4+39NQkOGVvo212VpKInRgOP6eg9/thuC5QIwPu8J11OmrOH3cD+c2a
   Q==;
X-CSE-ConnectionGUID: 0u+wwFHpTFKb7r2jBvd7FA==
X-CSE-MsgGUID: +F0RfBAbQIa3Mkw8vh7Tmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42538656"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42538656"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:32:05 -0800
X-CSE-ConnectionGUID: foe9veuZTIuR/PWrOmJgtw==
X-CSE-MsgGUID: o6y78SZYQ6aldmD11mly6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="124347104"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 07 Mar 2025 04:32:05 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqWry-0000TF-0r;
	Fri, 07 Mar 2025 12:32:02 +0000
Date: Fri, 07 Mar 2025 20:31:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 d02198550423a0b695e7a24ec77153209ad45b09
Message-ID: <202503072034.S7ph55fz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: d02198550423a0b695e7a24ec77153209ad45b09  x86/fpu: Improve crypto performance by making kernel-mode FPU reliably usable in softirqs

elapsed time: 1452m

configs tested: 74
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250306    gcc-13.2.0
arc                  randconfig-002-20250306    gcc-13.2.0
arm                  randconfig-001-20250306    gcc-14.2.0
arm                  randconfig-002-20250306    gcc-14.2.0
arm                  randconfig-003-20250306    gcc-14.2.0
arm                  randconfig-004-20250306    clang-18
arm64                randconfig-001-20250306    gcc-14.2.0
arm64                randconfig-002-20250306    gcc-14.2.0
arm64                randconfig-003-20250306    gcc-14.2.0
arm64                randconfig-004-20250306    gcc-14.2.0
csky                 randconfig-001-20250307    gcc-14.2.0
csky                 randconfig-002-20250307    gcc-14.2.0
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250307    clang-21
hexagon              randconfig-002-20250307    clang-21
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250306    clang-19
i386       buildonly-randconfig-002-20250306    clang-19
i386       buildonly-randconfig-003-20250306    clang-19
i386       buildonly-randconfig-004-20250306    gcc-12
i386       buildonly-randconfig-005-20250306    gcc-12
i386       buildonly-randconfig-006-20250306    clang-19
loongarch            randconfig-001-20250307    gcc-14.2.0
loongarch            randconfig-002-20250307    gcc-14.2.0
m68k                             allnoconfig    gcc-14.2.0
mips                             allnoconfig    gcc-14.2.0
nios2                            allnoconfig    gcc-14.2.0
nios2                randconfig-001-20250307    gcc-14.2.0
nios2                randconfig-002-20250307    gcc-14.2.0
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
riscv                randconfig-001-20250306    clang-18
riscv                randconfig-002-20250306    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250306    gcc-14.2.0
s390                 randconfig-002-20250306    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                               allnoconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250306    gcc-14.2.0
sh                   randconfig-002-20250306    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                            allnoconfig    gcc-14.2.0
sparc                randconfig-001-20250306    gcc-14.2.0
sparc                randconfig-002-20250306    gcc-14.2.0
sparc64              randconfig-001-20250306    gcc-14.2.0
sparc64              randconfig-002-20250306    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250306    gcc-12
um                   randconfig-002-20250306    clang-16
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250306    gcc-11
x86_64     buildonly-randconfig-002-20250306    clang-19
x86_64     buildonly-randconfig-003-20250306    clang-19
x86_64     buildonly-randconfig-004-20250306    clang-19
x86_64     buildonly-randconfig-005-20250306    clang-19
x86_64     buildonly-randconfig-006-20250306    gcc-12
x86_64                             defconfig    gcc-11
xtensa                           allnoconfig    gcc-14.2.0
xtensa               randconfig-001-20250306    gcc-14.2.0
xtensa               randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

