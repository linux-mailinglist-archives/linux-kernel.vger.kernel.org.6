Return-Path: <linux-kernel+bounces-337594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F127984C26
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF2F1C229FE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF7313BAE4;
	Tue, 24 Sep 2024 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNTZqoT2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38812EBE1;
	Tue, 24 Sep 2024 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209547; cv=none; b=JtNO0CVXUw3BlWS2lpm43pVlzpI3Cul6UicIb/9nhF4uSF4j4blYSGJt+DioZ7Nu3Oc9wz8WpMvwKLQmkuc6T5YxFdEa+caUioGjIhXfd+Ma77wfqngPctB9bd0nlONv/Pm9/XW8ux5OoPFyBa7RdfBLIDs5h06czunydyn+bwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209547; c=relaxed/simple;
	bh=93gxUKIopDOuDyl7RueuP8to9UNOVhpzwFUiRm2mDGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLICp0teTHCuMVZjCkWfmZKRo7+wSwXZcBaZPiQRBbfY4lhzRxwx7gEcsKDrjOPJb+OmNSUpNB/mB/ZMyrEBwObKcLNntBc0AEPBtMi9Kxgci0ZisdGOV7tt2Sr1zfz/+9Apig1PZs4B4O3FmLvCk+Qmd+K1+laRmp0vPn1d0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNTZqoT2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727209544; x=1758745544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=93gxUKIopDOuDyl7RueuP8to9UNOVhpzwFUiRm2mDGU=;
  b=VNTZqoT2eU+JO19h5Im+7ct4LpI77HWbt4fAAVBmajhAyesI66VNqs92
   44NjNdupHgW47Pyx9N2SQo0KvLxEe3N+TcOROk2MF+6EozOC88j0m4IPf
   hyJ/HxL3AmM7fwjuRW9STkmTf3bjlC/gCrGiZfdoh9CCCJhmejRvAYe5l
   SPKx2BW1GL0ENtDHqr+HE5B9lY4/s54YgEBtMx/DeZ8sayiSukoYwBvw1
   8vIkhf71Hql4bUN/NyeQRZfacRwwDDDPzcCmKVDvVnIAHOcxZPMDo2BB8
   Wob+WAQkYdPc/AwvDnS8DZAl4wSAux3gkaXjxQf2entZJGeMwtChIXz4c
   w==;
X-CSE-ConnectionGUID: 6qBHoSVpTQKE9oRAhbGEUg==
X-CSE-MsgGUID: T7edcR5dQAOhBELvyQIc6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="29938367"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="29938367"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 13:25:43 -0700
X-CSE-ConnectionGUID: iGvYRx9hQPu42ih2tE1DAQ==
X-CSE-MsgGUID: HS6cwghiQVS5NxpipcoCcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="75642370"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Sep 2024 13:25:39 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stC6K-000IoH-2X;
	Tue, 24 Sep 2024 20:25:36 +0000
Date: Wed, 25 Sep 2024 04:25:18 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Vetter <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
	Yann Sionneau <ysionneau@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>
Subject: Re: [PATCH v4 2/5] Replace generic memcpy and memset by IO memcpy
 functions
Message-ID: <202409250346.N624LLrr-lkp@intel.com>
References: <20240924092223.534040-3-jvetter@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924092223.534040-3-jvetter@kalrayinc.com>

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on arm64/for-next/core soc/for-next linus/master v6.11 next-20240924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Vetter/Consolidate-__memcpy_-to-from-io-and-__memset_io-into-a-single-lib/20240924-172751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240924092223.534040-3-jvetter%40kalrayinc.com
patch subject: [PATCH v4 2/5] Replace generic memcpy and memset by IO memcpy functions
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20240925/202409250346.N624LLrr-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250346.N624LLrr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250346.N624LLrr-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/time/time.c:31:
   In file included from include/linux/timekeeper_internal.h:10:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from kernel/time/time.c:31:
   In file included from include/linux/timekeeper_internal.h:10:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/time/time.c:31:
   In file included from include/linux/timekeeper_internal.h:10:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> include/asm-generic/io.h:1166:2: error: call to undeclared function '__memset_io'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           __memset_io(__io_virt(addr), value, size);
           ^
   include/asm-generic/io.h:1166:2: note: did you mean 'memset_io'?
   include/asm-generic/io.h:1163:20: note: 'memset_io' declared here
   static inline void memset_io(volatile void __iomem *addr, int value,
                      ^
   include/asm-generic/io.h:1154:19: note: expanded from macro 'memset_io'
   #define memset_io memset_io
                     ^
>> include/asm-generic/io.h:1184:2: error: call to undeclared function '__memcpy_fromio'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           __memcpy_fromio(buffer, __io_virt(addr), size);
           ^
   include/asm-generic/io.h:1184:2: note: did you mean 'memcpy_fromio'?
   include/asm-generic/io.h:1180:20: note: 'memcpy_fromio' declared here
   static inline void memcpy_fromio(void *buffer,
                      ^
   include/asm-generic/io.h:1171:23: note: expanded from macro 'memcpy_fromio'
   #define memcpy_fromio memcpy_fromio
                         ^
>> include/asm-generic/io.h:1201:2: error: call to undeclared function '__memcpy_toio'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           __memcpy_toio(__io_virt(addr), buffer, size);
           ^
   include/asm-generic/io.h:1201:2: note: did you mean 'memcpy_toio'?
   include/asm-generic/io.h:1198:20: note: 'memcpy_toio' declared here
   static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
                      ^
   include/asm-generic/io.h:1189:21: note: expanded from macro 'memcpy_toio'
   #define memcpy_toio memcpy_toio
                       ^
   12 warnings and 3 errors generated.
--
   In file included from kernel/time/hrtimer.c:30:
   In file included from include/linux/syscalls.h:93:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from kernel/time/hrtimer.c:30:
   In file included from include/linux/syscalls.h:93:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/time/hrtimer.c:30:
   In file included from include/linux/syscalls.h:93:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> include/asm-generic/io.h:1166:2: error: call to undeclared function '__memset_io'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           __memset_io(__io_virt(addr), value, size);
           ^
   include/asm-generic/io.h:1166:2: note: did you mean 'memset_io'?
   include/asm-generic/io.h:1163:20: note: 'memset_io' declared here
   static inline void memset_io(volatile void __iomem *addr, int value,
                      ^
   include/asm-generic/io.h:1154:19: note: expanded from macro 'memset_io'
   #define memset_io memset_io
                     ^
>> include/asm-generic/io.h:1184:2: error: call to undeclared function '__memcpy_fromio'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           __memcpy_fromio(buffer, __io_virt(addr), size);
           ^
   include/asm-generic/io.h:1184:2: note: did you mean 'memcpy_fromio'?
   include/asm-generic/io.h:1180:20: note: 'memcpy_fromio' declared here
   static inline void memcpy_fromio(void *buffer,
                      ^
   include/asm-generic/io.h:1171:23: note: expanded from macro 'memcpy_fromio'
   #define memcpy_fromio memcpy_fromio
                         ^
>> include/asm-generic/io.h:1201:2: error: call to undeclared function '__memcpy_toio'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           __memcpy_toio(__io_virt(addr), buffer, size);
           ^
   include/asm-generic/io.h:1201:2: note: did you mean 'memcpy_toio'?
   include/asm-generic/io.h:1198:20: note: 'memcpy_toio' declared here
   static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
                      ^
   include/asm-generic/io.h:1189:21: note: expanded from macro 'memcpy_toio'
   #define memcpy_toio memcpy_toio
                       ^
   kernel/time/hrtimer.c:121:21: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
                                     ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:119:27: note: previous initialization is here
           [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
                                     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:22: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
                                     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:119:27: note: previous initialization is here
           [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
                                     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:21: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
                                     ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:119:27: note: previous initialization is here
           [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
                                     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:124:17: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [CLOCK_TAI]             = HRTIMER_BASE_TAI,
                                     ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:119:27: note: previous initialization is here
           [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
                                     ^~~~~~~~~~~~~~~~~~~~~~~
   16 warnings and 3 errors generated.


vim +/__memset_io +1166 include/asm-generic/io.h

  1152	
  1153	#ifndef memset_io
  1154	#define memset_io memset_io
  1155	/**
  1156	 * memset_io	Set a range of I/O memory to a constant value
  1157	 * @addr:	The beginning of the I/O-memory range to set
  1158	 * @val:	The value to set the memory to
  1159	 * @count:	The number of bytes to set
  1160	 *
  1161	 * Set a range of I/O memory to a given value.
  1162	 */
  1163	static inline void memset_io(volatile void __iomem *addr, int value,
  1164				     size_t size)
  1165	{
> 1166		__memset_io(__io_virt(addr), value, size);
  1167	}
  1168	#endif
  1169	
  1170	#ifndef memcpy_fromio
  1171	#define memcpy_fromio memcpy_fromio
  1172	/**
  1173	 * memcpy_fromio	Copy a block of data from I/O memory
  1174	 * @dst:		The (RAM) destination for the copy
  1175	 * @src:		The (I/O memory) source for the data
  1176	 * @count:		The number of bytes to copy
  1177	 *
  1178	 * Copy a block of data from I/O memory.
  1179	 */
  1180	static inline void memcpy_fromio(void *buffer,
  1181					 const volatile void __iomem *addr,
  1182					 size_t size)
  1183	{
> 1184		__memcpy_fromio(buffer, __io_virt(addr), size);
  1185	}
  1186	#endif
  1187	
  1188	#ifndef memcpy_toio
  1189	#define memcpy_toio memcpy_toio
  1190	/**
  1191	 * memcpy_toio		Copy a block of data into I/O memory
  1192	 * @dst:		The (I/O memory) destination for the copy
  1193	 * @src:		The (RAM) source for the data
  1194	 * @count:		The number of bytes to copy
  1195	 *
  1196	 * Copy a block of data to I/O memory.
  1197	 */
  1198	static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
  1199				       size_t size)
  1200	{
> 1201		__memcpy_toio(__io_virt(addr), buffer, size);
  1202	}
  1203	#endif
  1204	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

