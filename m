Return-Path: <linux-kernel+bounces-539588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21BFA4A620
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6B8189C13F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99631DED64;
	Fri, 28 Feb 2025 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcztzW80"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F823F39A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782703; cv=none; b=C1EGh+nzLasa94qJt4IGqDDf/2J6HkY4FSUWP6ZO4lJagNniJTBXT2x/ymrjjQhvahRgcUvI/9dM5IGZfWMPFJbfAhrzuPk4LLl/eI5OtdA5sx0oSEs4BvYiwXqygyL41Xq+dqyR4aYnPG8n9QzfEVxr1LvWdDNE4Ev2GB6yWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782703; c=relaxed/simple;
	bh=w2m+Z3JL8m0f9OF/1fSxSnuEKWQkqmCF1Qf9mcQMi4U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MQtWqKiopM3g0I8o9krndJ//3kNexvZKXPzfbod+XMPgR3AJz3jhmBMqenmbaAsMaernrxQ2WAJTgHr/X3OS/fJXTFt1AShAkltRHMTTHPBejPUvVwTbk/NKAl39MSqKi7czbZpnRk14Wpt0Jow7M7tiYWttQ/vUhFURnw1DYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcztzW80; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740782701; x=1772318701;
  h=date:from:to:cc:subject:message-id;
  bh=w2m+Z3JL8m0f9OF/1fSxSnuEKWQkqmCF1Qf9mcQMi4U=;
  b=RcztzW80CgLOfPO0/k5hDI/iQ2/ZeMcWDTvL6BY67+7l78GmNP/+7zhZ
   34NghSHXYYbaePxnEX7+5Z2vec6GuXPsqu2jBNx4JuLaCpaLxv9BWe4Lg
   qAgK+X2YZXAyiPAenuCgBxylru8sWDSY3CMDFAuf7rwppYiIUAqo/LjmW
   2PzF0BJH18rBBxvrWxS+deGMFXfnl2Ya6J8qXsml73+5ghLrv+3kyt4cg
   wwYop/G8cVQCA06jD5s25NReMrK8j4uT379jSGY35YYgFdh9xjpf3QSI7
   MmihPw34z+dmEBIMsS5M4+L1MxcztKXXo1GGeAab2CDifETxHomr8nfwv
   Q==;
X-CSE-ConnectionGUID: vaYbELxqR3KDKKAEa/1NbA==
X-CSE-MsgGUID: QIKgQ5npRxuQVP7csHqRxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="67097418"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="67097418"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 14:45:00 -0800
X-CSE-ConnectionGUID: jf6MIUrWQD69Q4se38wbdg==
X-CSE-MsgGUID: IHRxqvkZRRG0oY5n1+77HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122073272"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 28 Feb 2025 14:44:59 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to96H-000FbG-0J;
	Fri, 28 Feb 2025 22:44:57 +0000
Date: Sat, 01 Mar 2025 06:44:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 ad546940b5991d3e141238cd80a6d1894b767184
Message-ID: <202503010637.0nkCwFjU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: ad546940b5991d3e141238cd80a6d1894b767184  x86/ia32: Leave NULL selector values 0~3 unchanged

elapsed time: 1459m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250228    gcc-13.2.0
arc                  randconfig-002-20250228    gcc-13.2.0
arm                  randconfig-001-20250228    clang-21
arm                  randconfig-002-20250228    gcc-14.2.0
arm                  randconfig-003-20250228    gcc-14.2.0
arm                  randconfig-004-20250228    gcc-14.2.0
arm64                randconfig-001-20250228    gcc-14.2.0
arm64                randconfig-002-20250228    clang-21
arm64                randconfig-003-20250228    clang-16
arm64                randconfig-004-20250228    gcc-14.2.0
csky                 randconfig-001-20250228    gcc-14.2.0
csky                 randconfig-002-20250228    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250228    clang-19
hexagon              randconfig-002-20250228    clang-21
i386       buildonly-randconfig-001-20250228    clang-19
i386       buildonly-randconfig-002-20250228    clang-19
i386       buildonly-randconfig-003-20250228    gcc-12
i386       buildonly-randconfig-004-20250228    clang-19
i386       buildonly-randconfig-005-20250228    clang-19
i386       buildonly-randconfig-006-20250228    clang-19
loongarch            randconfig-001-20250228    gcc-14.2.0
loongarch            randconfig-002-20250228    gcc-14.2.0
nios2                randconfig-001-20250228    gcc-14.2.0
nios2                randconfig-002-20250228    gcc-14.2.0
parisc               randconfig-001-20250228    gcc-14.2.0
parisc               randconfig-002-20250228    gcc-14.2.0
powerpc              randconfig-001-20250228    gcc-14.2.0
powerpc              randconfig-002-20250228    clang-16
powerpc              randconfig-003-20250228    clang-18
powerpc64            randconfig-001-20250228    clang-16
powerpc64            randconfig-002-20250228    clang-18
powerpc64            randconfig-003-20250228    gcc-14.2.0
riscv                randconfig-001-20250228    gcc-14.2.0
riscv                randconfig-002-20250228    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250228    gcc-14.2.0
s390                 randconfig-002-20250228    clang-17
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250228    gcc-14.2.0
sh                   randconfig-002-20250228    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250228    gcc-14.2.0
sparc                randconfig-002-20250228    gcc-14.2.0
sparc64              randconfig-001-20250228    gcc-14.2.0
sparc64              randconfig-002-20250228    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250228    clang-21
um                   randconfig-002-20250228    clang-21
x86_64     buildonly-randconfig-001-20250228    clang-19
x86_64     buildonly-randconfig-002-20250228    clang-19
x86_64     buildonly-randconfig-003-20250228    gcc-12
x86_64     buildonly-randconfig-004-20250228    clang-19
x86_64     buildonly-randconfig-005-20250228    gcc-12
x86_64     buildonly-randconfig-006-20250228    gcc-12
xtensa               randconfig-001-20250228    gcc-14.2.0
xtensa               randconfig-002-20250228    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

