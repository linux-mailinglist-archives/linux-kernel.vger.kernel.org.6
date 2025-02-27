Return-Path: <linux-kernel+bounces-536269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27418A47D79
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377D83B3948
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D9F22DFB4;
	Thu, 27 Feb 2025 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUTagwtn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC822D7BD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658732; cv=none; b=JkOrFrIqJbRbcFwsn7L9tdh2AhcK2vs96b8qKGHhfXFeC2fuJO0vwaOSkask/uGglpC5Gv7RDKzrJB+Sa/oUhBIRIGVhvCEsDZ6u902SOUfkYK9xI/tvQCFNG2QdLpbCHngjaA/bNVWmphUJz18spK8B2CdTb8m/VuQMstQ2a7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658732; c=relaxed/simple;
	bh=ZZjeJBG/Bzh+5m95eZg1qhnnDWmekuEjAAFkFlDYJ5E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XY3K/+VTQX5xSeyZ0sXCsLH0Me2fzibazHHIvF6Rng7D/lqUdBj6a1X6MogVaiERr0ej4fobtK4UVOA8n8RQi7CS4doJcx9wr++40Lg9bf14i9fi1hTwQAulBTnh2N7VkuKWi/SfIbSpBr0dlHMmeI9COkUyFqIlUkhdV1qxkxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUTagwtn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740658730; x=1772194730;
  h=date:from:to:cc:subject:message-id;
  bh=ZZjeJBG/Bzh+5m95eZg1qhnnDWmekuEjAAFkFlDYJ5E=;
  b=JUTagwtnMTJd7VArlgYzC5ZK4247ZgrA5jtsLzuhLrwcKCaQmf9da4av
   zEzG1BP4lPKNy1pKRvLxKhDlhfsdY/qNFI4bQenEmO5GG/H7Ml6pmMO/p
   /QyKTRb+cHFlNjz4FjbskhHqD/rUYVO50IAUIenAO0FPn1xvwIj8hzC+8
   ZuP0rI93M6LtMaKDo9zodFP7xrjgeknIL3n+TOtkgZlC7kaR02QBH07Ay
   cVeQWjGkdRsAEs4683ZBk+0gJ6YlBdAr8LNMFz+n7xpJG6aC2uOn8WPpA
   NAJBeXIiDBxCBl5eR5O4S7AAxN/HtO9dC29GSe1B2Tt6gGVS7GC21Af/E
   w==;
X-CSE-ConnectionGUID: A1nwjzVbTVek8mxrr3MyAA==
X-CSE-MsgGUID: +CsXR+MBS9Gs3Ui2vKsWBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52184253"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="52184253"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 04:18:49 -0800
X-CSE-ConnectionGUID: bbuKLQ2zQQ+L6azsR1CgDQ==
X-CSE-MsgGUID: phCij7ZKT2ucBLJze6a2tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117017129"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 27 Feb 2025 04:18:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tncqk-000DKe-0G;
	Thu, 27 Feb 2025 12:18:46 +0000
Date: Thu, 27 Feb 2025 20:17:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 6447828875b7d768e4ef0f58765b4bd4e16bcf18
Message-ID: <202502272048.3ATCbkZS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 6447828875b7d768e4ef0f58765b4bd4e16bcf18  x86/mce/inject: Remove call to mce_notify_irq()

elapsed time: 1458m

configs tested: 37
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386      buildonly-randconfig-001-20250226    gcc-12
i386      buildonly-randconfig-001-20250227    gcc-12
i386      buildonly-randconfig-002-20250226    gcc-12
i386      buildonly-randconfig-002-20250227    gcc-12
i386      buildonly-randconfig-003-20250226    gcc-12
i386      buildonly-randconfig-003-20250227    gcc-12
i386      buildonly-randconfig-004-20250226    clang-19
i386      buildonly-randconfig-004-20250227    gcc-12
i386      buildonly-randconfig-005-20250226    gcc-12
i386      buildonly-randconfig-005-20250227    gcc-12
i386      buildonly-randconfig-006-20250226    gcc-12
i386      buildonly-randconfig-006-20250227    gcc-12
i386                randconfig-011-20250227    gcc-12
i386                randconfig-012-20250227    gcc-12
i386                randconfig-013-20250227    gcc-12
i386                randconfig-014-20250227    gcc-12
i386                randconfig-015-20250227    gcc-12
i386                randconfig-016-20250227    gcc-12
i386                randconfig-017-20250227    gcc-12
openrisc                        allnoconfig    clang-15
parisc                          allnoconfig    clang-15
powerpc                         allnoconfig    clang-15
riscv                           allnoconfig    clang-15
s390                            allnoconfig    clang-15
um                              allnoconfig    clang-15
x86_64    buildonly-randconfig-001-20250226    clang-19
x86_64    buildonly-randconfig-001-20250227    clang-19
x86_64    buildonly-randconfig-002-20250226    clang-19
x86_64    buildonly-randconfig-002-20250227    clang-19
x86_64    buildonly-randconfig-003-20250226    gcc-12
x86_64    buildonly-randconfig-003-20250227    clang-19
x86_64    buildonly-randconfig-004-20250226    clang-19
x86_64    buildonly-randconfig-004-20250227    clang-19
x86_64    buildonly-randconfig-005-20250226    gcc-12
x86_64    buildonly-randconfig-005-20250227    clang-19
x86_64    buildonly-randconfig-006-20250226    gcc-12
x86_64    buildonly-randconfig-006-20250227    clang-19

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

