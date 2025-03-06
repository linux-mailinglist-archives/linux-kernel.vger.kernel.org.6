Return-Path: <linux-kernel+bounces-549822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 109DAA55798
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BEC17694B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7792780F0;
	Thu,  6 Mar 2025 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxQUD2eF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C6249E5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293611; cv=none; b=FnHaypruyGtjdsJsNRmA9ZWBvuoW6SI6iOekBkEKHu99xmaz5oXagT+EZ3ektkmIlAIEy3Pd9BNFnn1dHMbsgMbX2fatXdhG24RSJ2N09Vbg5VRvqAOzaFif/2uIzEtDEY+5so1UgdUU58SKAZQyid7N1XbZaA9QpR3IJEAAXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293611; c=relaxed/simple;
	bh=DEYvNVxnuG0CK4oLzt9GQAxyecFKWMQahXDamOyH+zc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GfPHipFgkRh9kkc7KiwiR6h/XX+8QSux0Tn9EqAkfVXSEkYI2O02ru88d6d7yRTO7fOkFYHtPcFUjATdE397NT/IZ2yzffgEpfG3oIO2JyipBXdDchgRE2QzRmP/sBA3iLVXvxMBTyGDt9q2HI2ls3rLA+MvPPV2o40h5Ajvzx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxQUD2eF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741293609; x=1772829609;
  h=date:from:to:cc:subject:message-id;
  bh=DEYvNVxnuG0CK4oLzt9GQAxyecFKWMQahXDamOyH+zc=;
  b=IxQUD2eFujre3c+y8FnDlgQKsRVzUzkdQZb9O+cByDL+0BnRkmsJGZIz
   3hgmd20RUJpfsRfxG42uDKQfOwrJhItb/SkjllYdH1iNza6gdEX+QR7GV
   AXOKZz7BzW2+rk0kw17r8/0GYAbgHEn30/f9kH/EJTnthjFWTj01Dw6xW
   6o5QIq5ANQukeUf8tFej7T8ZeCMbIk63bAe/B3Qwy3VKB81LbaveNrnc+
   JAfi/fxts63/MoRA8G76AsLVTdvB+hZTcWWAZK9x2wrdErporljII5VHe
   jQIJQqM8mpPGuTYziZ7CQqr3o+uChkkr/FQqC9aYTcSCSfFVeyMmBzb7v
   w==;
X-CSE-ConnectionGUID: LaKRahq0T5Gd6qWliuUSYA==
X-CSE-MsgGUID: ZA7lLyISSQyA+IioIjXrOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42468080"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42468080"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:40:09 -0800
X-CSE-ConnectionGUID: Lh9/dSYhQqinMFuxrLK4pA==
X-CSE-MsgGUID: gyOdO0+aQ9GrWYX5bANHNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="123728775"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Mar 2025 12:40:08 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqI0j-000Nak-37;
	Thu, 06 Mar 2025 20:40:05 +0000
Date: Fri, 07 Mar 2025 04:39:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 ec20d53540aa1be851902a7655b20591a71672e4
Message-ID: <202503070401.QpgWoYFz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: ec20d53540aa1be851902a7655b20591a71672e4  Merge branches 'clocksource.2025.03.05a' and 'lkmm.2025.02.25a' into HEAD

elapsed time: 1455m

configs tested: 90
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20250306    gcc-13.2.0
arc                   randconfig-002-20250306    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                   randconfig-001-20250306    gcc-14.2.0
arm                   randconfig-002-20250306    gcc-14.2.0
arm                   randconfig-003-20250306    gcc-14.2.0
arm                   randconfig-004-20250306    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250306    gcc-14.2.0
arm64                 randconfig-002-20250306    gcc-14.2.0
arm64                 randconfig-003-20250306    gcc-14.2.0
arm64                 randconfig-004-20250306    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250306    gcc-14.2.0
csky                  randconfig-002-20250306    gcc-14.2.0
hexagon                           allnoconfig    clang-21
hexagon               randconfig-001-20250306    clang-21
hexagon               randconfig-002-20250306    clang-19
i386        buildonly-randconfig-001-20250306    clang-19
i386        buildonly-randconfig-001-20250307    clang-19
i386        buildonly-randconfig-002-20250306    clang-19
i386        buildonly-randconfig-002-20250307    clang-19
i386        buildonly-randconfig-003-20250306    clang-19
i386        buildonly-randconfig-003-20250307    gcc-11
i386        buildonly-randconfig-004-20250306    gcc-12
i386        buildonly-randconfig-004-20250307    clang-19
i386        buildonly-randconfig-005-20250306    gcc-12
i386        buildonly-randconfig-005-20250307    gcc-12
i386        buildonly-randconfig-006-20250306    clang-19
i386        buildonly-randconfig-006-20250307    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250306    gcc-14.2.0
loongarch             randconfig-002-20250306    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250306    gcc-14.2.0
nios2                 randconfig-002-20250306    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250306    gcc-14.2.0
parisc                randconfig-002-20250306    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250306    clang-21
powerpc               randconfig-002-20250306    clang-18
powerpc               randconfig-003-20250306    gcc-14.2.0
powerpc64             randconfig-001-20250306    clang-18
powerpc64             randconfig-002-20250306    clang-21
powerpc64             randconfig-003-20250306    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250306    clang-18
riscv                 randconfig-002-20250306    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250306    gcc-14.2.0
s390                  randconfig-002-20250306    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250306    gcc-14.2.0
sh                    randconfig-002-20250306    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250306    gcc-14.2.0
sparc                 randconfig-002-20250306    gcc-14.2.0
sparc64               randconfig-001-20250306    gcc-14.2.0
sparc64               randconfig-002-20250306    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20250306    gcc-12
um                    randconfig-002-20250306    clang-16
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250306    gcc-11
x86_64      buildonly-randconfig-001-20250307    clang-19
x86_64      buildonly-randconfig-002-20250306    clang-19
x86_64      buildonly-randconfig-002-20250307    gcc-12
x86_64      buildonly-randconfig-003-20250306    clang-19
x86_64      buildonly-randconfig-003-20250307    clang-19
x86_64      buildonly-randconfig-004-20250306    clang-19
x86_64      buildonly-randconfig-004-20250307    clang-19
x86_64      buildonly-randconfig-005-20250306    clang-19
x86_64      buildonly-randconfig-005-20250307    clang-19
x86_64      buildonly-randconfig-006-20250306    gcc-12
x86_64      buildonly-randconfig-006-20250307    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250306    gcc-14.2.0
xtensa                randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

