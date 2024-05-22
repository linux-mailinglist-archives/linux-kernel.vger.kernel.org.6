Return-Path: <linux-kernel+bounces-185701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEBC8CB906
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3665E1F23616
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461EC200B7;
	Wed, 22 May 2024 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKT8nsWl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BAA33C9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345947; cv=none; b=YxJBtl/BI5rU+nn+atPkdXSSVuAG1W/MLkaZrxWmkMzxW+ZkJjFGAweBfp9mFNSc2glahELMuPKmCv+PpkCS36y1wMrxNSyj/qLOPdCwvNygKuWmqBIQ6Ir0ypb/Iy3i9H/X4zy2i9PVY5ZDASz4SEJ2gq8jKjmdoI5v+8Dafhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345947; c=relaxed/simple;
	bh=Ryp/YPUpZSNRuoAZIq3fRtNOGcBL/62un33/5dHlVEI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ifq5MXWwF5as//0x7Is7UYRgyS7VVbb1MDXcGqZ0XUVNXSa57h49lIgieQQ+yuyQiKxXQ9LWwuJ09oONJDQIeq8c76yazF9BCaU/sOi27/Rd5ZvqsmDQtX66rvDTnkh4qbZPUHVTghNf171jUcJZ7Ze6CGfkqPiGtV+vW8WIhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKT8nsWl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716345946; x=1747881946;
  h=date:from:to:cc:subject:message-id;
  bh=Ryp/YPUpZSNRuoAZIq3fRtNOGcBL/62un33/5dHlVEI=;
  b=KKT8nsWlvX7Xhg1xvOCLfdLiN88DiprXYdb8/o/bbHDKsVifUVi91JEq
   sQ6NHKdrZuKDG54YQR46mwg2R86p/oULhFd/KN0BwZ06FUMDqzBlu1Wcm
   VtVzuFV1iAbrg57gCEZHf+7hal+aXRm+EPjrx8gE6RGxr+1SODamZukCx
   76wK4vevqvmZBxHe0wOKu55G1Tct0glV6pW+RMHL1DyjiQQsBGsh76jKn
   w0dOZWjKLlDNsg88kS77SVN+cfHhbFFcFxy6/C084zGonOZ6+6bDBnpER
   Vcm/USjDVSQJCqVi3VBaGoV9UzZXM0p7FUY2ze8hemx3Sp8N/SVkK2XnY
   g==;
X-CSE-ConnectionGUID: A/VeOp6QScqsm9URXdhXXw==
X-CSE-MsgGUID: Dead3iQkTDavSQqOjFZKMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="15523587"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="15523587"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 19:45:46 -0700
X-CSE-ConnectionGUID: T5uUHmgyQ7y2hB7F6Emb1g==
X-CSE-MsgGUID: ZnOcQv3fRd+rgZYDdYEuag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33047745"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 21 May 2024 19:45:45 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9bz4-0000yH-2Q;
	Wed, 22 May 2024 02:45:42 +0000
Date: Wed, 22 May 2024 10:45:02 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 47ff30cc1be7bf426c03ecc84371452109b416e4
Message-ID: <202405221000.XcYnWE2t-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: 47ff30cc1be7bf426c03ecc84371452109b416e4  x86/percpu: Enable named address spaces for all capable GCC versions

elapsed time: 727m

configs tested: 26
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240522   clang
i386         buildonly-randconfig-002-20240522   clang
i386         buildonly-randconfig-003-20240522   gcc  
i386         buildonly-randconfig-004-20240522   clang
i386         buildonly-randconfig-005-20240522   clang
i386         buildonly-randconfig-006-20240522   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240522   clang
i386                  randconfig-002-20240522   clang
i386                  randconfig-003-20240522   clang
i386                  randconfig-004-20240522   clang
i386                  randconfig-005-20240522   clang
i386                  randconfig-006-20240522   clang
i386                  randconfig-011-20240522   clang
i386                  randconfig-012-20240522   gcc  
i386                  randconfig-013-20240522   gcc  
i386                  randconfig-014-20240522   gcc  
i386                  randconfig-015-20240522   gcc  
i386                  randconfig-016-20240522   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

