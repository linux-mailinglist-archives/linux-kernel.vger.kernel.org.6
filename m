Return-Path: <linux-kernel+bounces-244237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D698892A162
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059431C20FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F277F48C;
	Mon,  8 Jul 2024 11:42:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B45F7D08F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438973; cv=none; b=R4JqBSBQxko0sE+UeEOvBPAcbmF2XqIxz2UebmA2mEsz3JTSZAM/a/oGAHDGabRU3H/whrCn6UAZYmjAqUjQ5UzwOlCYzltvhmLl1MRMGyaBWxrIIXyWh5rGq+EkVU0qcSsgdbLcdfEX1qMHSZthYa+nYuv01+WpZv6zeFx1wdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438973; c=relaxed/simple;
	bh=4vFXVKuWIHwg/IH+N20SCXgY/5pu/tTatiMroPqVcsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nfcj8lSwuwSfNnuXOEBtTgX2eUfwLZjGr+n7KA6KEveknlYkWhByKr2JDuHFlMhwmgoRMuyxJmlAF1uH2S1vMD+8Cv/uqJRzMAksKl/NgFEYMVGlxh7z1Z7KR8RWLd4K8dwfgzAWpeEaxjZw3jZV6Fa5MtDQvap97Q+W3hi/sjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ADC01042;
	Mon,  8 Jul 2024 04:43:15 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25CBA3F641;
	Mon,  8 Jul 2024 04:42:49 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:42:43 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: drivers/iommu/io-pgtable-arm.c:330:13: error: void value not
 ignored as it ought to be
Message-ID: <ZovQs87beTB6iRfs@J2N7QTR9R3>
References: <202407070708.Bm6Ker3L-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407070708.Bm6Ker3L-lkp@intel.com>

On Sun, Jul 07, 2024 at 07:58:28AM +0800, kernel test robot wrote:
> Hi Mark,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   22f902dfc51eb3602ff9b505ac3980f6ff77b1df
> commit: 9257959a6e5b4fca6fc8e985790bff62c2046f20 locking/atomic: scripts: restructure fallback ifdeffery
> date:   1 year, 1 month ago
> config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20240707/202407070708.Bm6Ker3L-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240707/202407070708.Bm6Ker3L-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407070708.Bm6Ker3L-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
> >> drivers/iommu/io-pgtable-arm.c:330:13: error: void value not ignored as it ought to be
>      330 |         old = cmpxchg64_relaxed(ptep, curr, new);
>          |             ^
> --
>    drivers/iommu/io-pgtable-dart.c: In function 'dart_install_table':
> >> drivers/iommu/io-pgtable-dart.c:168:13: error: void value not ignored as it ought to be
>      168 |         old = cmpxchg64_relaxed(ptep, curr, new);
>          |             ^
>    drivers/iommu/io-pgtable-dart.c:157:25: warning: variable 'new' set but not used [-Wunused-but-set-variable]
>      157 |         dart_iopte old, new;
>          |                         ^~~

The warning here is due to an extant bug for which the error message has
changed, see the example logs below.

The issue here is that the drivers/iommu/io-pgtable-* code wants cmpxchg64(),
but arch/arc doesn't provide arch_cmpxchg64()  in some configurations. The
drivers/iommu/Kconfig file tries to detect this based on
CONFIG_GENERIC_ATOMIC64, but that doesn't actually describe whether cmpxchg64()
exists, and AFAICT we have no config symbol that does describe that.

Immediately before this patch, we'd still see a build error:

| [mark@lakrids:~/src/linux]% git describe HEAD  
| v6.4-rc2-33-g1815da1718aa4
| [mark@lakrids:~/src/linux]% git clean -qfdx
| [mark@lakrids:~/src/linux]% usekorg 13.2.0 make ARCH=arc CROSS_COMPILE=arc-linux- -s allmodconfig
| [mark@lakrids:~/src/linux]% usekorg 13.2.0 make ARCH=arc CROSS_COMPILE=arc-linux- -s drivers/iommu/io-pgtable-arm.o
| In file included from ./include/linux/atomic.h:80,
|                  from drivers/iommu/io-pgtable-arm.c:12:
| drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
| ./include/linux/atomic/atomic-arch-fallback.h:60:32: error: implicit declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'? [-Werror=implicit-function-declaration]
|    60 | #define arch_cmpxchg64_relaxed arch_cmpxchg64
|       |                                ^~~~~~~~~~~~~~
| ./include/linux/atomic/atomic-raw.h:1063:9: note: in expansion of macro 'arch_cmpxchg64_relaxed'
|  1063 |         arch_cmpxchg64_relaxed(__VA_ARGS__)
|       |         ^~~~~~~~~~~~~~~~~~~~~~
| ./include/linux/atomic/atomic-instrumented.h:2029:9: note: in expansion of macro 'raw_cmpxchg64_relaxed'
|  2029 |         raw_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
|       |         ^~~~~~~~~~~~~~~~~~~~~
| drivers/iommu/io-pgtable-arm.c:330:15: note: in expansion of macro 'cmpxchg64_relaxed'
|   330 |         old = cmpxchg64_relaxed(ptep, curr, new);
|       |               ^~~~~~~~~~~~~~~~~
| cc1: all warnings being treated as errors
| make[3]: *** [scripts/Makefile.build:252: drivers/iommu/io-pgtable-arm.o] Error 1
| make[2]: *** [scripts/Makefile.build:494: drivers/iommu] Error 2
| make[1]: *** [scripts/Makefile.build:494: drivers] Error 2
| make: *** [Makefile:2026: .] Error 2

... which is the same as before the series which added this patch:

| [mark@lakrids:~/src/linux]% git describe HEAD                                                                      
| v6.4-rc2
| [mark@lakrids:~/src/linux]% git clean -qfdx  
| [mark@lakrids:~/src/linux]% usekorg 13.2.0 make ARCH=arc CROSS_COMPILE=arc-linux- -s allmodconfig
| [mark@lakrids:~/src/linux]% usekorg 13.2.0 make ARCH=arc CROSS_COMPILE=arc-linux- -s drivers/iommu/io-pgtable-arm.o
| In file included from ./include/linux/atomic.h:80,
|                  from drivers/iommu/io-pgtable-arm.c:12:
| drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
| ./include/linux/atomic/atomic-arch-fallback.h:60:32: error: implicit declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'? [-Werror=implicit-function-declaration]
|    60 | #define arch_cmpxchg64_relaxed arch_cmpxchg64
|       |                                ^~~~~~~~~~~~~~
| ./include/linux/atomic/atomic-instrumented.h:2034:9: note: in expansion of macro 'arch_cmpxchg64_relaxed'
|  2034 |         arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
|       |         ^~~~~~~~~~~~~~~~~~~~~~
| drivers/iommu/io-pgtable-arm.c:330:15: note: in expansion of macro 'cmpxchg64_relaxed'
|   330 |         old = cmpxchg64_relaxed(ptep, curr, new);
|       |               ^~~~~~~~~~~~~~~~~
| cc1: all warnings being treated as errors
| make[3]: *** [scripts/Makefile.build:252: drivers/iommu/io-pgtable-arm.o] Error 1
| make[2]: *** [scripts/Makefile.build:494: drivers/iommu] Error 2
| make[1]: *** [scripts/Makefile.build:494: drivers] Error 2
| make: *** [Makefile:2026: .] Error 2

We could probably make the error message a bit nicer in future, but I
don't think this is a bug in the commit in question, and regardless we
should figure out a way to detect the presence/absence of cmpxchg64().

Since GCC errors out on the return type first, we'd need something like
the below to get a nice error message.

Mark.

---->8----
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 86aca4f9f315a..3dd8844b9af53 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -193,8 +193,8 @@ gen_xchg_order_fallback()
        fi
 
        printf "#else\n"
-       printf "extern void raw_${xchg}${order}_not_implemented(void);\n"
-       printf "#define raw_${xchg}${order}(...) raw_${xchg}${order}_not_implemented()\n"
+       printf "#define raw_${xchg}${order}(ptr, ...) \\\\\n"
+       printf "        ({ BUILD_BUG_ON_MSG(1, \"raw_${xchg}${order}() not implemented\"); (typeof(*(ptr)))0UL; })\n"
        printf "#endif\n\n"
 }

