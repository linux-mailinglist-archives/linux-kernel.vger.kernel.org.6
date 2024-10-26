Return-Path: <linux-kernel+bounces-383373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6829B1AC2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BE9282494
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9601C3F27;
	Sat, 26 Oct 2024 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0/bn5Pm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272920326
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729974686; cv=none; b=qZ2fC7PXlsP8k2oW0VVJf5JJNHOBPCWnz8/m81NZx1Xft0cJfyNxLzyVy8KpzdI6B3FJWuin0BOdogdTpWCMQ9rHvbq/DDDQtBoUC2hZ6eNqiuvXbczKPRfjBgbUjqVkd1VC8/F0jwCh+NDV/HRuFx4D5i/HYstO7ixjg8oJDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729974686; c=relaxed/simple;
	bh=98OCq10kJNhyF0o13HzeYlmiNHvVYUwrezSXHYPluDg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Hi7qfhtnhOy/OI3OfE3lrD3a6HjJcfy7NS1qeNiIckUhWss80nK8IMneAwtbCTxdzc3cDxsAiE5gWuGEsu+RNKeYH7bT+1UXscjyQsyluivBM4ZNACqqrMZmC1CNpfs14CnlrlLvXqUIwd9Ipp0C++jkR8Vu8KVkdhV+qYeU5T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0/bn5Pm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729974684; x=1761510684;
  h=date:from:to:cc:subject:message-id;
  bh=98OCq10kJNhyF0o13HzeYlmiNHvVYUwrezSXHYPluDg=;
  b=T0/bn5PmabfUEV0dGH/nxf2vqh5tZWwZS5Jd2hf+2iMfUg3r++5W6gai
   KbgqY//ihJQLF+jdZGBvliCq4XAp08ixkg0aoMeTZplZ4oZpSUF8PByYF
   BWg2f8wPL3rx0P3q9ayCphgBb/M8G06AbaiQ9XYQoJVQLhnpR47Fm93mz
   pSPVK6dOBObLaexhWs3leabpxxxzl0I1Rk2Acvhv4wEZuuD+mP7H82+EQ
   NRsTiuFPzumZmhOlfio5AxfncXNl4Rs+D79l8FfFmtYcys2Tdm0BXcaBg
   rKNa+gr7kKP0o7l2j9lbgwFld6rq2e35ALFDtFr8nebYtirZ8Su7xSX3H
   g==;
X-CSE-ConnectionGUID: utaZT/uIQm+PEY4WhWxSAQ==
X-CSE-MsgGUID: dQ28n7NuRCWzU92DH/zGjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="40994312"
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="40994312"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 13:31:23 -0700
X-CSE-ConnectionGUID: JfMyVeqtT+2ruG85X7v89Q==
X-CSE-MsgGUID: K2/Xhm5BSaKVHzE8fNBPvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="112081257"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Oct 2024 13:31:22 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4nRP-000a1C-35;
	Sat, 26 Oct 2024 20:31:19 +0000
Date: Sun, 27 Oct 2024 04:30:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241022] BUILD REGRESSION
 365ba8224e1a899e9f619290b1e5b22c2badade0
Message-ID: <202410270441.ecRpCkm6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241022
branch HEAD: 365ba8224e1a899e9f619290b1e5b22c2badade0  jbd2: Avoid dozens of -Wflex-array-member-not-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of struct_group_tagged()

Error/Warning ids grouped by kconfigs:

recent_errors
|-- hexagon-randconfig-002-20241026
|   `-- include-rdma-uverbs_ioctl.h:error:static-assertion-failed-due-to-requirement-__builtin_offsetof(struct-uverbs_attr_bundle-attrs)-sizeof(struct-uverbs_attr_bundle_hdr):struct-member-likely-outside-of-s
`-- powerpc-randconfig-003-20241026
    `-- include-rdma-uverbs_ioctl.h:error:static-assertion-failed-due-to-requirement-__builtin_offsetof(struct-uverbs_attr_bundle-attrs)-sizeof(struct-uverbs_attr_bundle_hdr):struct-member-likely-outside-of-s

elapsed time: 1464m

configs tested: 160
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                            hsdk_defconfig    clang-20
arc                   randconfig-001-20241026    gcc-13.2.0
arc                   randconfig-001-20241026    gcc-14.1.0
arc                   randconfig-002-20241026    gcc-13.2.0
arc                   randconfig-002-20241026    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                        clps711x_defconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                      integrator_defconfig    clang-20
arm                        mvebu_v7_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                   randconfig-001-20241026    gcc-14.1.0
arm                   randconfig-002-20241026    clang-20
arm                   randconfig-002-20241026    gcc-14.1.0
arm                   randconfig-003-20241026    gcc-14.1.0
arm                   randconfig-004-20241026    gcc-14.1.0
arm                           sama7_defconfig    clang-20
arm                           sunxi_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241026    gcc-14.1.0
arm64                 randconfig-002-20241026    clang-20
arm64                 randconfig-002-20241026    gcc-14.1.0
arm64                 randconfig-003-20241026    clang-20
arm64                 randconfig-003-20241026    gcc-14.1.0
arm64                 randconfig-004-20241026    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241026    gcc-14.1.0
csky                  randconfig-002-20241026    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241026    clang-20
hexagon               randconfig-001-20241026    gcc-14.1.0
hexagon               randconfig-002-20241026    clang-17
hexagon               randconfig-002-20241026    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241026    gcc-12
i386        buildonly-randconfig-002-20241026    gcc-12
i386        buildonly-randconfig-003-20241026    gcc-12
i386        buildonly-randconfig-004-20241026    gcc-12
i386        buildonly-randconfig-005-20241026    gcc-12
i386        buildonly-randconfig-006-20241026    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241026    gcc-12
i386                  randconfig-002-20241026    gcc-12
i386                  randconfig-003-20241026    gcc-12
i386                  randconfig-004-20241026    gcc-12
i386                  randconfig-005-20241026    gcc-12
i386                  randconfig-006-20241026    gcc-12
i386                  randconfig-011-20241026    gcc-12
i386                  randconfig-012-20241026    gcc-12
i386                  randconfig-013-20241026    gcc-12
i386                  randconfig-014-20241026    gcc-12
i386                  randconfig-015-20241026    gcc-12
i386                  randconfig-016-20241026    gcc-12
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241026    gcc-14.1.0
loongarch             randconfig-002-20241026    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241026    gcc-14.1.0
nios2                 randconfig-002-20241026    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    clang-20
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241026    gcc-14.1.0
parisc                randconfig-002-20241026    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                      arches_defconfig    clang-20
powerpc                      ep88xc_defconfig    clang-20
powerpc                       maple_defconfig    clang-20
powerpc                      pasemi_defconfig    clang-20
powerpc               randconfig-001-20241026    gcc-14.1.0
powerpc               randconfig-002-20241026    gcc-14.1.0
powerpc               randconfig-003-20241026    clang-20
powerpc               randconfig-003-20241026    gcc-14.1.0
powerpc64             randconfig-001-20241026    clang-20
powerpc64             randconfig-001-20241026    gcc-14.1.0
powerpc64             randconfig-002-20241026    clang-20
powerpc64             randconfig-002-20241026    gcc-14.1.0
powerpc64             randconfig-003-20241026    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241026    gcc-14.1.0
riscv                 randconfig-002-20241026    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241026    gcc-14.1.0
s390                  randconfig-002-20241026    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          r7780mp_defconfig    clang-20
sh                    randconfig-001-20241026    gcc-14.1.0
sh                    randconfig-002-20241026    gcc-14.1.0
sh                           se7722_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc64_defconfig    clang-20
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241026    gcc-14.1.0
sparc64               randconfig-002-20241026    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241026    gcc-14.1.0
um                    randconfig-002-20241026    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241026    gcc-14.1.0
xtensa                randconfig-002-20241026    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

