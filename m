Return-Path: <linux-kernel+bounces-239771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0D9926526
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9239D282B7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7F4181CE6;
	Wed,  3 Jul 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtwslHaf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46918131E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021426; cv=none; b=QyNf7O0fd9jTdJ37Uvi5VrWt3x+AwseIdLkFysZzeAIXaaOsErKawegRFC4DN0CSjv90w15zb+htetMHaSELlX7gFIwWYR25KxGZ6R0FgPTPoKY7mRWsZIqYb8wKSDV/iIs5IeQGiBSJbgIgOyrOqtUl3f9vUMNfH8RpSPyAToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021426; c=relaxed/simple;
	bh=TBP2XF1Ja5nxsZ+pbolvqfGOTjBBqZS0pmGG+rvHKxY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dzYvz6S5iyqW1a7+cFEemBVKnUi4vLJMTbrCdhLIFvEI8+GifX2sL+JB4zRucrv71c+ajQFMQ1l8rqWLUA5t2RXXyJQQjrqKUhqKQsd9wX097Afm9yi7g8a4IJjzNPF2xByVTDDEiFehXwsr172F14/x6sQKAm1djRPOG/OF+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtwslHaf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720021424; x=1751557424;
  h=date:from:to:cc:subject:message-id;
  bh=TBP2XF1Ja5nxsZ+pbolvqfGOTjBBqZS0pmGG+rvHKxY=;
  b=KtwslHafm3uqQ99Rb9zFIKDfEOWDRqHQRmIXEN60KEHwv/M8T0xBVgZx
   oZAijQufyYjLk7LavtiCCWXsh0Tbsso/hCiWaYt4PRaY4OD/NK+tTCiSV
   kn7ZcFS7ad+C4mkSuAl6JQfEfIW16AFDcPf7nv2xD0LSQorTW07v0n1tA
   56NYzDuwlkFPrDvGFf29qsL9Z+BwLlAOTYpZVvdhihWR8zXgo8rNazujD
   Jjj0xJ3KEwjjg5zdxuq4kzwofydVTwEx7mff3+7ZAvCE7XZ13eRhJpcki
   WxEMtGu2t6owwtjOLZVbPWNGIsz3U1TfrWzCzCyMBwnNki2vOMlOBJOoN
   A==;
X-CSE-ConnectionGUID: u9pdanWNTKGRLvXe5/74Yw==
X-CSE-MsgGUID: Dgeb+2+/QP6dDfVS/LkwaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16912009"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="16912009"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 08:43:44 -0700
X-CSE-ConnectionGUID: M9xPezE2S9e3DWljv+hUeQ==
X-CSE-MsgGUID: 6vDKA9ktSdK+6B7xuc3BzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46270186"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2024 08:43:43 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sP28y-000Pue-2p;
	Wed, 03 Jul 2024 15:43:40 +0000
Date: Wed, 03 Jul 2024 23:42:57 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 8434cf006ceae2183533f04ce3ac11fba6ee1613
Message-ID: <202407032355.M3zsMLh0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 8434cf006ceae2183533f04ce3ac11fba6ee1613  Documentation/ABI/configfs-tsm: Fix an unexpected indentation silly

elapsed time: 1779m

configs tested: 122
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240703   gcc-13.2.0
arc                   randconfig-002-20240703   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                   randconfig-001-20240703   clang-19
arm                   randconfig-002-20240703   gcc-13.2.0
arm                   randconfig-003-20240703   clang-19
arm                   randconfig-004-20240703   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240703   clang-19
arm64                 randconfig-002-20240703   gcc-13.2.0
arm64                 randconfig-003-20240703   gcc-13.2.0
arm64                 randconfig-004-20240703   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240703   gcc-13.2.0
csky                  randconfig-002-20240703   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240703   clang-16
hexagon               randconfig-002-20240703   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240703   clang-18
i386         buildonly-randconfig-002-20240703   gcc-13
i386         buildonly-randconfig-003-20240703   gcc-13
i386         buildonly-randconfig-004-20240703   gcc-13
i386         buildonly-randconfig-005-20240703   clang-18
i386         buildonly-randconfig-006-20240703   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240703   gcc-13
i386                  randconfig-002-20240703   clang-18
i386                  randconfig-003-20240703   gcc-13
i386                  randconfig-004-20240703   gcc-11
i386                  randconfig-005-20240703   clang-18
i386                  randconfig-006-20240703   gcc-7
i386                  randconfig-011-20240703   gcc-13
i386                  randconfig-012-20240703   gcc-13
i386                  randconfig-013-20240703   gcc-13
i386                  randconfig-014-20240703   gcc-13
i386                  randconfig-015-20240703   gcc-13
i386                  randconfig-016-20240703   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240703   gcc-13.2.0
loongarch             randconfig-002-20240703   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240703   gcc-13.2.0
nios2                 randconfig-002-20240703   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                randconfig-001-20240703   gcc-13.2.0
parisc                randconfig-002-20240703   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240703   clang-19
powerpc               randconfig-002-20240703   gcc-13.2.0
powerpc               randconfig-003-20240703   clang-15
powerpc64             randconfig-001-20240703   gcc-13.2.0
powerpc64             randconfig-002-20240703   gcc-13.2.0
powerpc64             randconfig-003-20240703   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                 randconfig-001-20240703   clang-19
riscv                 randconfig-002-20240703   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                  randconfig-001-20240703   clang-15
s390                  randconfig-002-20240703   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                    randconfig-001-20240703   gcc-13.2.0
sh                    randconfig-002-20240703   gcc-13.2.0
sparc64               randconfig-001-20240703   gcc-13.2.0
sparc64               randconfig-002-20240703   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                    randconfig-001-20240703   clang-19
um                    randconfig-002-20240703   clang-19
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240703   clang-18
x86_64       buildonly-randconfig-002-20240703   clang-18
x86_64       buildonly-randconfig-003-20240703   clang-18
x86_64       buildonly-randconfig-004-20240703   clang-18
x86_64       buildonly-randconfig-005-20240703   clang-18
x86_64       buildonly-randconfig-006-20240703   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240703   clang-18
x86_64                randconfig-002-20240703   clang-18
x86_64                randconfig-003-20240703   clang-18
x86_64                randconfig-004-20240703   clang-18
x86_64                randconfig-005-20240703   clang-18
x86_64                randconfig-006-20240703   clang-18
x86_64                randconfig-011-20240703   clang-18
x86_64                randconfig-012-20240703   clang-18
x86_64                randconfig-013-20240703   clang-18
x86_64                randconfig-014-20240703   clang-18
x86_64                randconfig-015-20240703   clang-18
x86_64                randconfig-016-20240703   clang-18
x86_64                randconfig-071-20240703   clang-18
x86_64                randconfig-072-20240703   clang-18
x86_64                randconfig-073-20240703   clang-18
x86_64                randconfig-074-20240703   clang-18
x86_64                randconfig-075-20240703   clang-18
x86_64                randconfig-076-20240703   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240703   gcc-13.2.0
xtensa                randconfig-002-20240703   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

