Return-Path: <linux-kernel+bounces-540157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB509A4AE98
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 01:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B56F3AD1BF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 00:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD06A944;
	Sun,  2 Mar 2025 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exLESxMx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11F8F77
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874680; cv=none; b=QjGmQTNE7D8gRzp6l3HMHTahceD2i+w35fx6kC5lC89ZvxxE84o9bAvCZg+mDn+h3bKXbJgauHD5rTmII7nROxbIaF0cbK/bnQcaJPmxMIHPeN47bU/VNidb1ctnvTvGAwc4HAu41FK4nNgCHsrWSHArjiBjuNHKy529cqRRbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874680; c=relaxed/simple;
	bh=JOWu2kxr2yC6Upjqp5Y3hhprO8dVQdFobiHy8gxpuC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A79WLXp7m9WH0mOpxVZdRWQlDQfba2dwsCErlUeOjhknrVbYAhHNuahnMZ0mw3j4jDb/zImjaW7cysG46aReHBMXLUr2xg1u7fCAsB8iBjdRBjJFgGTs0gAA9ZMOKwspMEKu2db9UWt3iPZANnzh086fK32Ihyr4M8PfA4mIWVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exLESxMx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740874678; x=1772410678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JOWu2kxr2yC6Upjqp5Y3hhprO8dVQdFobiHy8gxpuC0=;
  b=exLESxMxP6kiqGJTRS7TG7bWmaAeertIPOJZd4quKZVHWwAfAhyoGcZs
   EL+aVUdi5Eksc8g+UcgfeIJTfvL2kyQ3W+mxmrc99Ff9ri1caqsehAv2D
   gaWWRz/lZdVefI+kEactKuKdA0MBuU4MPJO0Fx7cwFeZ9XzkyFZFsMlc5
   K6Y/jvLJIsMLtco9mP09uWqZNJINLEEPvKe99IYBFlDKznaJqYQoiFkaj
   YGYHQR0mB23ph65AS+Of8H+Pz/caVmI9n2AGJNuzE7xtNMJJRTmBcBuD2
   Lk9z/dnpBGO9Qp68ODzQbhiTRmHr6ykWjaQziO/roNJ76esMphmewRgdM
   Q==;
X-CSE-ConnectionGUID: UhTlOn27Svi7sI+uxQO3Gw==
X-CSE-MsgGUID: +UraHYTtS3Sp6eGmYeWOxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41660317"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="41660317"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 16:17:57 -0800
X-CSE-ConnectionGUID: U0cjrRFjRMy0oj43XQn2tg==
X-CSE-MsgGUID: dbnLJVLVSKGV0YhcVx9VbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="122804153"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 01 Mar 2025 16:17:55 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toX1k-000GsE-3D;
	Sun, 02 Mar 2025 00:17:52 +0000
Date: Sun, 2 Mar 2025 08:17:52 +0800
From: kernel test robot <lkp@intel.com>
To: Xi Ruoyao <xry111@xry111.site>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Guo Ren <guoren@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH] RISC-V: vDSO: Wire up getrandom() vDSO implementation
Message-ID: <202503020759.lCd4bDgK-lkp@intel.com>
References: <20250224122541.65045-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224122541.65045-1-xry111@xry111.site>

Hi Xi,

kernel test robot noticed the following build errors:

[auto build test ERROR on crng-random/master]
[also build test ERROR on shuah-kselftest/next shuah-kselftest/fixes linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xi-Ruoyao/RISC-V-vDSO-Wire-up-getrandom-vDSO-implementation/20250224-203232
base:   https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master
patch link:    https://lore.kernel.org/r/20250224122541.65045-1-xry111%40xry111.site
patch subject: [PATCH] RISC-V: vDSO: Wire up getrandom() vDSO implementation
config: riscv-randconfig-r122-20250302 (https://download.01.org/0day-ci/archive/20250302/202503020759.lCd4bDgK-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250302/202503020759.lCd4bDgK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020759.lCd4bDgK-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/kernel/vdso/getrandom.c:7:9: warning: no previous prototype for '__vdso_getrandom' [-Wmissing-prototypes]
       7 | ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
         |         ^~~~~~~~~~~~~~~~
   arch/riscv/kernel/vdso/getrandom.c: In function '__vdso_getrandom':
>> arch/riscv/kernel/vdso/getrandom.c:9:16: error: implicit declaration of function '__cvdso_getrandom'; did you mean '__vdso_getrandom'? [-Wimplicit-function-declaration]
       9 |         return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
         |                ^~~~~~~~~~~~~~~~~
         |                __vdso_getrandom
   arch/riscv/kernel/vdso/vgetrandom-chacha.S: Assembler messages:
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:92: Error: unrecognized opcode `ld t2,(a2)'
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:118: Error: improper shift amount (32)
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:20: Error: unrecognized opcode `addw s0,s0,s4'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:127:  Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:21: Error: unrecognized opcode `addw s1,s1,s5'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:127:  Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:22: Error: unrecognized opcode `addw s2,s2,s6'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:127:  Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:23: Error: unrecognized opcode `addw s3,s3,s7'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:127:  Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,a5,32-16'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:   Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw a5,a5,16'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:   Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,a6,32-16'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:21:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:   Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw a6,a6,16'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:21:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:   Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,a7,32-16'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:22:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:   Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw a7,a7,16'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:22:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:   Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,t1,32-16'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:23:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:   Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw t1,t1,16'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:23:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:129:   Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:20: Error: unrecognized opcode `addw s8,s8,a5'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:131:  Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:21: Error: unrecognized opcode `addw s9,s9,a6'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:131:  Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:22: Error: unrecognized opcode `addw s10,s10,a7'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:131:  Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:23: Error: unrecognized opcode `addw s11,s11,t1'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:131:  Info: macro invoked from here
>> arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,s4,32-20'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw s4,s4,20'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,s5,32-20'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:21:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw s5,s5,20'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:21:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,s6,32-20'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:22:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw s6,s6,20'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:22:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,s7,32-20'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:23:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw s7,s7,20'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:23:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:133:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20: Error: unrecognized opcode `addw s0,s0,s4'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:135:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:21: Error: unrecognized opcode `addw s1,s1,s5'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:135:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:22: Error: unrecognized opcode `addw s2,s2,s6'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:135:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:23: Error: unrecognized opcode `addw s3,s3,s7'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:135:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,a5,32-24'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw a5,a5,24'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,a6,32-24'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:21:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw a6,a6,24'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:21:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,a7,32-24'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:22:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw a7,a7,24'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:22:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,t1,32-24'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:23:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw t1,t1,24'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:23:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:137:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20: Error: unrecognized opcode `addw s8,s8,a5'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:139:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:21: Error: unrecognized opcode `addw s9,s9,a6'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:139:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:22: Error: unrecognized opcode `addw s10,s10,a7'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:139:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:23: Error: unrecognized opcode `addw s11,s11,t1'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:139:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,s4,32-25'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw s4,s4,25'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,s5,32-25'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:21:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw s5,s5,25'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:21:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,s6,32-25'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:22:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw s6,s6,25'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:22:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,s7,32-25'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:23:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw s7,s7,25'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:23:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:141:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20: Error: unrecognized opcode `addw s0,s0,s5'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:144:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:21: Error: unrecognized opcode `addw s1,s1,s6'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:144:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:22: Error: unrecognized opcode `addw s2,s2,s7'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:144:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:23: Error: unrecognized opcode `addw s3,s3,s4'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:144:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:14: Error: unrecognized opcode `slliw t0,t1,32-16'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20:  Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:146:   Info: macro invoked from here
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:15: Error: unrecognized opcode `srliw t1,t1,16'
   arch/riscv/kernel/vdso/vgetrandom-chacha.S:20:  Info: macro invoked from here


vim +9 arch/riscv/kernel/vdso/getrandom.c

     6	
     7	ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
     8	{
   > 9		return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

