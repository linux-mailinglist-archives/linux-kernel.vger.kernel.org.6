Return-Path: <linux-kernel+bounces-408923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B619C852B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786781F219C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952F1F77A1;
	Thu, 14 Nov 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfIsElKR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06751F757C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574033; cv=none; b=mUiCHNeRQmVd+E5d9rC2d0vrz5ijmLdUJDYhKHePae4Jb32lbFY3jYDgH0s8WIYWV0o1kQGBkCq6UCADx5NXYzqhoiDYvlsbk8xCN3IfYB7YdxUO1jD3WZ9sLO0covCYEGbtv1meT3VbWCZYyaBXtsg6wwNCKZYnio1Bmr+GRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574033; c=relaxed/simple;
	bh=VjsgxQMBaRvhG6xDfqCGMeZjFn5Ah1/PKP10OUcSxcQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LdZ7Kpzg2Z2JrBbdI5fNNFMw80qw/YMnD0BnPOZ69vq6N3WPjUom/ByxB0bMGZGcqQzrItAXgSJW/KI7V784tsNqq2DA+qXq4QCm3eqyg7hBsEt+tZpfTg58dQCeHnb4gze/pLaJuUrrO55BdQ00u4ZPDY9dW9A7hZivtgGGMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfIsElKR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731574032; x=1763110032;
  h=date:from:to:cc:subject:message-id;
  bh=VjsgxQMBaRvhG6xDfqCGMeZjFn5Ah1/PKP10OUcSxcQ=;
  b=RfIsElKRuE+7vXuCeD7OUFZmmjmlfDb3whU+ndq/LMgViWeTZBi3EGRz
   dFWy4Y+ebpEwGYN6JB7S5+RlonZ+2gxvKw9VrPkGrvXq5yYlElwGk/xpe
   h8wSEx2nAlmYXmxvCO+yUsUiYBOoJbsny0K0FPEssRDu9dw3380t5G7y8
   InVWCyIw2FMZlIDjH6zuY8VnhgFY0y+Oj+sxTu7QkmJldcMESS0fdQtVx
   hoZmTr8cgINAIzcYKXDzd63AA2mJvsDqjbag4QnttKATfejxYfy39MUSv
   ptg0sy14NVPJ31LdDE8+JT+7Ev6JwgTvycDTs3RuZMkuG3fm34IOtQuG2
   Q==;
X-CSE-ConnectionGUID: /ZwD+NdPR/uJAyiifUIOOw==
X-CSE-MsgGUID: yp9aIhuESJKcRCmeQX3Q2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31659165"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31659165"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:47:12 -0800
X-CSE-ConnectionGUID: DxKZGM5NTSGSYE1gX38r6Q==
X-CSE-MsgGUID: THd2Jl1RRYemAXze4ps5JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="119066042"
Received: from lkp-server01.sh.intel.com (HELO 8eed2ac03994) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Nov 2024 00:47:09 -0800
Received: from kbuild by 8eed2ac03994 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBVVK-00007n-1z;
	Thu, 14 Nov 2024 08:47:06 +0000
Date: Thu, 14 Nov 2024 16:46:44 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 228ad72e7660e99821fd430a04ac31d7f8fe9fc4
Message-ID: <202411141635.xsh0lE1w-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 228ad72e7660e99821fd430a04ac31d7f8fe9fc4  Merge tag 'timers-v6.13-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-allnoconfig
    `-- Warning:drivers-regulator-core.c-references-a-file-that-doesn-t-exist:Documentation-timers-timers-howto.rst

elapsed time: 739m

configs tested: 100
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241114    gcc-13.2.0
arc                   randconfig-002-20241114    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241114    gcc-14.2.0
arm                   randconfig-002-20241114    gcc-14.2.0
arm                   randconfig-003-20241114    gcc-14.2.0
arm                   randconfig-004-20241114    clang-14
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241114    clang-20
arm64                 randconfig-002-20241114    gcc-14.2.0
arm64                 randconfig-003-20241114    gcc-14.2.0
arm64                 randconfig-004-20241114    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241114    gcc-14.2.0
csky                  randconfig-002-20241114    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241114    clang-20
hexagon               randconfig-002-20241114    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241114    clang-19
i386        buildonly-randconfig-002-20241114    gcc-11
i386        buildonly-randconfig-003-20241114    gcc-12
i386        buildonly-randconfig-004-20241114    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241114    gcc-14.2.0
loongarch             randconfig-002-20241114    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241114    gcc-14.2.0
nios2                 randconfig-002-20241114    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241114    gcc-14.2.0
parisc                randconfig-002-20241114    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20241114    gcc-14.2.0
powerpc               randconfig-002-20241114    clang-14
powerpc               randconfig-003-20241114    gcc-14.2.0
powerpc64             randconfig-001-20241114    gcc-14.2.0
powerpc64             randconfig-002-20241114    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241114    gcc-14.2.0
riscv                 randconfig-002-20241114    clang-14
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                  randconfig-001-20241114    gcc-14.2.0
s390                  randconfig-002-20241114    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241114    gcc-14.2.0
sh                    randconfig-002-20241114    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-002-20241114    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

