Return-Path: <linux-kernel+bounces-207279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4539014EF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 10:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05380281B33
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F901C6A7;
	Sun,  9 Jun 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUq5EGI4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878ED18C3D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921381; cv=none; b=agz3NWRwaRbR2LA9VGFVs9QFw7wfem9qFE7MQzB8eC9D/vTHmLtf6Yc59Ts0DLX1WUmLzKT94EdO0+ID7zIJUi9NBTnsn3oH+3yvN7QJTyYvTIX/k55+T3D4W1CEJTjQ23BAn5YTanEXhCFPBVyIm9QpQADmoieTBGTXp+Nh1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921381; c=relaxed/simple;
	bh=aYbhmIouizHZNA+e1YXn+Q5/h6TyBnnjode5JopwoWY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Bhb+XBt1qAa9yPd2bgwUtrYyeRHxbY6B8fsIjduCg3r/CNfu9WfdlP9ZLNxKQKlSZg4u79jYDQVM6ytO22sSs09tuwDjkH587/GTndufTg2RZ3smn+5S0N7IK+YhEMM4ylFm/v0KIvpCj31PnSPVUflXyWIp5UjSfFsZkC7/B98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUq5EGI4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717921379; x=1749457379;
  h=date:from:to:cc:subject:message-id;
  bh=aYbhmIouizHZNA+e1YXn+Q5/h6TyBnnjode5JopwoWY=;
  b=QUq5EGI4HhhxOmaegGbvaW1RQ/rskpIWeiekyf6q+bCCMtt7uvZgHhZu
   6uwfu1ZsV2FI9/eGUSOqPseQ4GlFLu4t7milZosOGiUVbt+8XPMXYCO88
   X8QuIXlpBHFGOS/UA6ruAsTDLbzbsP4LfdPzpbYSDHz42cYAUL2cShMKp
   ylTcGqMTUDaikNV4CZSaTrEKBx+vlJXTCP7ArB+cYQ5TSkgwX4ykM23N3
   KcqeHDSIeImv+Ju7rvyjQpRiZwWCecHW7uRzGecAK9dEPLn/5zp+y0gHD
   6mMSglAszxfi45sA2hBsdd7ZEyZ4l8xvXnE8yFicNuqpt8azuhwxqL+0l
   g==;
X-CSE-ConnectionGUID: gvsDyWa4ShWH0DkUrh1VNg==
X-CSE-MsgGUID: TcJE3kpNSt++bX+0rwYU2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="14479680"
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="14479680"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 01:22:59 -0700
X-CSE-ConnectionGUID: 7TGqeQFRRKy89bfzFfm6zg==
X-CSE-MsgGUID: kSYf+nPyS0OxwIsR5vWOag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="38836714"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Jun 2024 01:22:58 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGDpH-0000zf-1p;
	Sun, 09 Jun 2024 08:22:55 +0000
Date: Sun, 09 Jun 2024 16:22:15 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 91aa264023e0bdf3560faa6f20c7f7688eec95f1
Message-ID: <202406091613.gsbaDz1m-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 91aa264023e0bdf3560faa6f20c7f7688eec95f1  Merge branch into tip/master: 'x86/percpu'

elapsed time: 1448m

configs tested: 48
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386         buildonly-randconfig-001-20240609   gcc  
i386         buildonly-randconfig-002-20240609   gcc  
i386         buildonly-randconfig-003-20240609   gcc  
i386         buildonly-randconfig-004-20240609   gcc  
i386         buildonly-randconfig-005-20240609   clang
i386         buildonly-randconfig-006-20240609   gcc  
i386                  randconfig-001-20240609   clang
i386                  randconfig-002-20240609   clang
i386                  randconfig-003-20240609   gcc  
i386                  randconfig-004-20240609   gcc  
i386                  randconfig-005-20240609   clang
i386                  randconfig-006-20240609   clang
i386                  randconfig-011-20240609   clang
i386                  randconfig-012-20240609   clang
i386                  randconfig-013-20240609   clang
i386                  randconfig-014-20240609   clang
i386                  randconfig-015-20240609   gcc  
i386                  randconfig-016-20240609   clang
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64       buildonly-randconfig-001-20240609   clang
x86_64       buildonly-randconfig-002-20240609   clang
x86_64       buildonly-randconfig-003-20240609   clang
x86_64       buildonly-randconfig-004-20240609   gcc  
x86_64       buildonly-randconfig-005-20240609   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

