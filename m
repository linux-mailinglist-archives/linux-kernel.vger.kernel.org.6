Return-Path: <linux-kernel+bounces-538401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E1A4982A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AB61896E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9091126137B;
	Fri, 28 Feb 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVUeoFzE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AF139E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741291; cv=none; b=LBx/R5UzfzbqrQ+2wkTqmTFG2euFaAtroxbwpeWVuUQ/VEob3Ropzpzh54keTkhHDLhKxy9ShCSclL7AEFVAwuUokAD6M2eMe7H4ue69Ujxl3J5a0RSfkE3yI4fXqpK+82bYJtrPeQ5jPyB4I6pOAFTBnQ75cc6LrjJIJz360z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741291; c=relaxed/simple;
	bh=Mn5kHga+a3YCr5mjw6QT9+Uui66E5SpTX0E+4v/FRQA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BzRYEdeyze8AVvcr0PbdVF56r8+QQ3NXtNeQK7PlVLzJdxaxUln7jGPB8NNRBqHUYs6OssVmc5ax3V1f50myCH6mbEwW+ziHLOJk8MXv/FQ330upfEIlR+MQ3/wFe/lAquD5fzncR+rReXWctQnlK+LHskXvJqmzUT+LCmCZFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVUeoFzE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740741290; x=1772277290;
  h=date:from:to:cc:subject:message-id;
  bh=Mn5kHga+a3YCr5mjw6QT9+Uui66E5SpTX0E+4v/FRQA=;
  b=cVUeoFzEWWsJVxQW2KtZXvs2V+VJSBPLghj9/Zxx+Tetk/pL3QVoA/oG
   gocaiwsowhWy+l66bD12D92EF/XTQfUUVnAOzqi0bHEQsmdaxpb0qqNn0
   s8LGpPuO9wP/pZAKxzZaRP+HYHzyRbdqLsdLNunvnZEXL25YOF6fVTf8w
   VZ2myL2rGbxOnVAflZjvXZ9QsvuCwN1NupyCwQLq1/YefVrtoaI6/mZ06
   enYiwOrpsJIDEhlxSJudR7RpkCvNBy5u3wcTvn25FvudzLkovGjBa9I7m
   hcgnn9SHclRi5+gkSJYy6GJN6rVZF7UiSbRRQH7a52WoO3037ByiuccMf
   Q==;
X-CSE-ConnectionGUID: 8gom8AWBQuW6/7sjh6MbTQ==
X-CSE-MsgGUID: /JqvmlW2RRWXcTywlp1W2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52300839"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="52300839"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 03:14:50 -0800
X-CSE-ConnectionGUID: ZGJ7WUWzQ76CCxW6c+LmNA==
X-CSE-MsgGUID: 1/7IMjl0TaKbZzlIt3bunA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="121918752"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 28 Feb 2025 03:14:49 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnyKM-000En0-2s;
	Fri, 28 Feb 2025 11:14:46 +0000
Date: Fri, 28 Feb 2025 19:14:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 c1fcf41cf37f7a3fd3bbf6f0c04aba3ea4258888
Message-ID: <202502281919.IRW2juC5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: c1fcf41cf37f7a3fd3bbf6f0c04aba3ea4258888  x86/mm: Clear _PAGE_DIRTY for kernel mappings when we clear _PAGE_RW

elapsed time: 1479m

configs tested: 101
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250227    gcc-13.2.0
arc                   randconfig-002-20250227    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-21
arm                            qcom_defconfig    clang-17
arm                   randconfig-001-20250227    gcc-14.2.0
arm                   randconfig-002-20250227    clang-17
arm                   randconfig-003-20250227    gcc-14.2.0
arm                   randconfig-004-20250227    clang-21
arm                             rpc_defconfig    clang-17
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250227    gcc-14.2.0
arm64                 randconfig-002-20250227    clang-19
arm64                 randconfig-003-20250227    gcc-14.2.0
arm64                 randconfig-004-20250227    gcc-14.2.0
csky                  randconfig-001-20250227    gcc-14.2.0
csky                  randconfig-002-20250227    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250227    clang-14
hexagon               randconfig-002-20250227    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250227    gcc-12
i386        buildonly-randconfig-002-20250227    gcc-11
i386        buildonly-randconfig-003-20250227    clang-19
i386        buildonly-randconfig-004-20250227    gcc-12
i386        buildonly-randconfig-005-20250227    gcc-11
i386        buildonly-randconfig-006-20250227    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250227    gcc-14.2.0
loongarch             randconfig-002-20250227    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                     loongson1b_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250227    gcc-14.2.0
nios2                 randconfig-002-20250227    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250227    gcc-14.2.0
parisc                randconfig-002-20250227    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250227    clang-19
powerpc               randconfig-002-20250227    gcc-14.2.0
powerpc               randconfig-003-20250227    clang-19
powerpc                     tqm8548_defconfig    clang-19
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250227    clang-17
powerpc64             randconfig-002-20250227    clang-21
powerpc64             randconfig-003-20250227    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250227    gcc-14.2.0
riscv                 randconfig-002-20250227    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250227    clang-18
s390                  randconfig-002-20250227    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          landisk_defconfig    gcc-14.2.0
sh                    randconfig-001-20250227    gcc-14.2.0
sh                    randconfig-002-20250227    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250227    gcc-14.2.0
sparc                 randconfig-002-20250227    gcc-14.2.0
sparc64               randconfig-001-20250227    gcc-14.2.0
sparc64               randconfig-002-20250227    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250227    clang-17
um                    randconfig-002-20250227    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250227    clang-19
x86_64      buildonly-randconfig-002-20250227    clang-19
x86_64      buildonly-randconfig-003-20250227    gcc-12
x86_64      buildonly-randconfig-004-20250227    gcc-12
x86_64      buildonly-randconfig-005-20250227    clang-19
x86_64      buildonly-randconfig-006-20250227    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250227    gcc-14.2.0
xtensa                randconfig-002-20250227    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

