Return-Path: <linux-kernel+bounces-436726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A169E8A01
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25429281381
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17FB14831D;
	Mon,  9 Dec 2024 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEFEImnr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415C3F9D5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733716326; cv=none; b=m+cFsbYL96tJ4PmcEgFFDhzJr/fSByN96l11k1/TnwDLN1C7uCQBg7Ikur7uuFvNRjzS0BIQf8nCi2/4aVCpjihd5neVE7EqVBCEMPoJTGkX3PhUU+mn1vxFnGa8w5sYL6D7cZZ9qk6Zib2y2D7KLrKo3CrWDh/k/s0qgLlRhs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733716326; c=relaxed/simple;
	bh=5f+EKzLruWIZvUHHCL3VF+E0f6HNQAGcmnw77Sziaao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XXK6xcGBwEADmk7lbMea/iFmI2XYvTnzpNolzB5bfEo0fk7nJc9irP70akxmEiAwFN9cbgm2ZmLuTtpIAbypIdeog425+l2viM28+GbqOLTxI9daCF/ERvuhaLSB0BmwmhxYL+D57GTbtvXJqMG8tlO+dgtjOT6lTqgTbFWP1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEFEImnr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733716325; x=1765252325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5f+EKzLruWIZvUHHCL3VF+E0f6HNQAGcmnw77Sziaao=;
  b=dEFEImnr0/WULQ/543PiS0ZVLVUpP16mdTnHAq8dzQXVk9Bq5/DKD9Z3
   uDCRsSLl9tRMdLxJYZIAZXvdnhwrwA1T550ZR4GoOhjvGpn5v5bRINw3c
   G2gekVrxJbGO4RajMD40wb4nvnT5hQsAoHLxv/uTOSvkFRRulGjwn6qFk
   0Hrno450Lq7Z11Nk6C428cGbNKIf1KLgdHc0lRxKUAxQSAYdznRjx3gXJ
   bC4T1YouNJgi/XnJ/16r9/x5jJ5RuTtqBFf9SuUmZVyqmmysh7hi56dsd
   oFS0TZ63h3puFdl3yotT82UUz3ulAMAH/EaYWcBYVgJqet4kIdcMXzoYx
   g==;
X-CSE-ConnectionGUID: yqhNnurqRFWVAj9kENyS6w==
X-CSE-MsgGUID: R1T5CJpJTgab/Abo+ZCxpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="59401552"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="59401552"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 19:52:04 -0800
X-CSE-ConnectionGUID: 9jyGdJPZRjCUQ3UkIxxfEQ==
X-CSE-MsgGUID: y7HjST92QoGVQqH3YA8xfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="100000434"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Dec 2024 19:52:03 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKUoS-0003kx-1d;
	Mon, 09 Dec 2024 03:52:00 +0000
Date: Mon, 9 Dec 2024 11:51:35 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/loongarch/include/asm/cmpxchg.h:70:42: sparse: sparse: cast
 truncates bits from constant value (8000000000000000 becomes 0)
Message-ID: <202412070819.BY7VDlYB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c7cde621b2acfd6bc7d5f002b19b60ad2ed25df8
commit: 453924de6212ac159f946b75c6b59918e2e30944 afs: Overhaul invalidation handling to better support RO volumes
date:   11 months ago
config: loongarch-randconfig-r123-20241206 (https://download.01.org/0day-ci/archive/20241207/202412070819.BY7VDlYB-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241207/202412070819.BY7VDlYB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070819.BY7VDlYB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/afs/callback.c: note: in included file (through arch/loongarch/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
>> arch/loongarch/include/asm/cmpxchg.h:70:42: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/loongarch/include/asm/cmpxchg.h:73:24: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   fs/afs/callback.c:146:22: sparse: sparse: context imbalance in 'afs_lookup_volume_rcu' - different lock contexts for basic block
--
   fs/afs/rotate.c: note: in included file (through arch/loongarch/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
>> arch/loongarch/include/asm/cmpxchg.h:70:42: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/loongarch/include/asm/cmpxchg.h:73:24: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)

vim +70 arch/loongarch/include/asm/cmpxchg.h

720dc7ab252bbdf Huacai Chen   2022-08-25  63  
ddf502717da029c Huacai Chen   2022-10-12  64  static __always_inline unsigned long
068550631fbe0b7 Andrzej Hajda 2023-01-18  65  __arch_xchg(volatile void *ptr, unsigned long x, int size)
5b0b14e550a006b Huacai Chen   2022-05-31  66  {
5b0b14e550a006b Huacai Chen   2022-05-31  67  	switch (size) {
720dc7ab252bbdf Huacai Chen   2022-08-25  68  	case 1:
720dc7ab252bbdf Huacai Chen   2022-08-25  69  	case 2:
720dc7ab252bbdf Huacai Chen   2022-08-25 @70  		return __xchg_small(ptr, x, size);
720dc7ab252bbdf Huacai Chen   2022-08-25  71  
5b0b14e550a006b Huacai Chen   2022-05-31  72  	case 4:
5b0b14e550a006b Huacai Chen   2022-05-31  73  		return __xchg_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
5b0b14e550a006b Huacai Chen   2022-05-31  74  
5b0b14e550a006b Huacai Chen   2022-05-31  75  	case 8:
5b0b14e550a006b Huacai Chen   2022-05-31  76  		return __xchg_asm("amswap_db.d", (volatile u64 *)ptr, (u64)x);
5b0b14e550a006b Huacai Chen   2022-05-31  77  
5b0b14e550a006b Huacai Chen   2022-05-31  78  	default:
5b0b14e550a006b Huacai Chen   2022-05-31  79  		BUILD_BUG();
5b0b14e550a006b Huacai Chen   2022-05-31  80  	}
5b0b14e550a006b Huacai Chen   2022-05-31  81  
5b0b14e550a006b Huacai Chen   2022-05-31  82  	return 0;
5b0b14e550a006b Huacai Chen   2022-05-31  83  }
5b0b14e550a006b Huacai Chen   2022-05-31  84  

:::::: The code at line 70 was first introduced by commit
:::::: 720dc7ab252bbdf404cab7b909e26b31e602bf7e LoongArch: Add subword xchg/cmpxchg emulation

:::::: TO: Huacai Chen <chenhuacai@loongson.cn>
:::::: CC: Huacai Chen <chenhuacai@loongson.cn>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

