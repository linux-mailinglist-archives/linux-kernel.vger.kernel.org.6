Return-Path: <linux-kernel+bounces-555061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA9FA5A511
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A9418910B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B531DEFD4;
	Mon, 10 Mar 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVNRCSLr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA7288D6;
	Mon, 10 Mar 2025 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639055; cv=none; b=PAXH54Q2gO5j09oK7FTi5M6Q5gACXLgUjBbLZTV2uX+i14XZ51/UiBCIfO61Iloz6lWLAvoTGsm7C7586av8SyIyxI3LX6bUnQUQJTjFGYGLH+AFpY+wAdJzo6DvCLE+DxnXFXqJm7VbFoISaopS8fHGad8fi983rdhHbpLN50E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639055; c=relaxed/simple;
	bh=OfMVYqqFFkSNq/+Ee2JetRRusWo5/h3tArQ8z2C4Z20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny/+zj3bFlyMDwdlrlDBHDv1vAJYSqMdGPcNO0I4CzvR5yyE3IS8HZVrWHD70HOfwskN0JS5/YtA6ae3va1Ut5PePTBBbQvmJoJTKUNyYPRv1mlDxgdRH7GUybuo5o0Bl6nhaRBgne9dyRBVnjLLdT88E6qhtWj5WsnUrYuJlX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVNRCSLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2C1C4CEE5;
	Mon, 10 Mar 2025 20:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639054;
	bh=OfMVYqqFFkSNq/+Ee2JetRRusWo5/h3tArQ8z2C4Z20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVNRCSLr+1275JLWhr2XlHUVENMs5dBX2OgWgPpeJFqkwc1pcU1G6p0OZimqdJhmZ
	 5pyMCHbW5anEVCwcDBNq4jjA4ZLYQwuBz9PRRIYk43kP/+txjcWyygMFRZTsLY+uZB
	 uxmP0/hNH5Bwm7Zly0jPEt9A44Uno355EnI/QC3pqcr/D4FzDgBIwMmXA/8l5O70XI
	 q/29lLZTYlyU1kIBbzXI1dhOv/i21z/S+M4nLK1TNPMJdiyN3O/LpHXBkxmxEPRlJa
	 WaXKENBZkFEjB3BiwqudQE/U76lpskmWXmibnUyQx8w7KzLS+b6JihSX2wX/Gi3DuP
	 VU9naJB+PsefA==
Date: Mon, 10 Mar 2025 21:37:29 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>, Christian Eggers <ceggers@arri.de>
Cc: Russell King <linux@armlinux.org.uk>,
	Yuntao Liu <liuyuntao12@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: substitute OVERLAY description in linker
 script
Message-ID: <20250310203729.GA26968@ax162>
References: <20250224125414.2184-1-ceggers@arri.de>
 <202503050230.820w99b6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503050230.820w99b6-lkp@intel.com>

On Wed, Mar 05, 2025 at 02:49:38AM +0800, kernel test robot wrote:
> Hi Christian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on soc/for-next]
> [also build test ERROR on linus/master v6.14-rc5 next-20250304]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Eggers/ARM-avoid-that-vectors-are-removed-during-linker-garbage-collection/20250224-210146
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> patch link:    https://lore.kernel.org/r/20250224125414.2184-1-ceggers%40arri.de
> patch subject: [PATCH v2 1/2] ARM: substitute OVERLAY description in linker script
> config: arm-milbeaut_m10v_defconfig (https://download.01.org/0day-ci/archive/20250305/202503050230.820w99b6-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503050230.820w99b6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503050230.820w99b6-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: section .vectors.bhb.bpiall virtual address range overlaps with .vectors.bhb.loop8
>    >>> .vectors.bhb.bpiall range is [0xFFFF0000, 0xFFFF001F]
>    >>> .vectors.bhb.loop8 range is [0xFFFF0000, 0xFFFF001F]
> --
> >> ld.lld: error: section .vectors.bhb.loop8 virtual address range overlaps with .vectors
>    >>> .vectors.bhb.loop8 range is [0xFFFF0000, 0xFFFF001F]
>    >>> .vectors range is [0xFFFF0000, 0xFFFF001F]

Looking at ld.lld's code, this error is intentionally ignored for
OVERLAY:

https://github.com/llvm/llvm-project/blob/9f170e6abed4a7b393bb8abbf07ac8d6930aa3b0/lld/ELF/Writer.cpp#L2751-L2761

I have submitted a patch that allows KEEP within OVERLAY to match GNU
ld:

https://github.com/llvm/llvm-project/pull/130661

Once/if that is accepted, we should go back to your v1 with something
like the following diff on top to keep things working for all linkers. I
hope that it won't take long for the ld.lld change to get reviewed and
landed but if this needs to be fixed urgently, this whole diff minus
'|| LLD_VERSION >= 210000' on the init/Kconfig change should work (with
a comment change). I can always send a follow up change to add it back.

Cheers,
Nathan

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 835b5f100e92..f3f6b7a33b79 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -121,7 +121,7 @@ config ARM
 	select HAVE_KERNEL_XZ
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
-	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD)
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_CAN_USE_KEEP_IN_OVERLAY)
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPTPROBES if !THUMB2_KERNEL
diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index f2ff79f740ab..14811b4f48ec 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -34,6 +34,12 @@
 #define NOCROSSREFS
 #endif
 
+#ifdef CONFIG_LD_CAN_USE_KEEP_IN_OVERLAY
+#define OVERLAY_KEEP(x)		KEEP(x)
+#else
+#define OVERLAY_KEEP(x)		x
+#endif
+
 /* Set start/end symbol names to the LMA for the section */
 #define ARM_LMA(sym, section)						\
 	sym##_start = LOADADDR(section);				\
@@ -125,13 +131,13 @@
 	__vectors_lma = .;						\
 	OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma) {		\
 		.vectors {						\
-			KEEP(*(.vectors))				\
+			OVERLAY_KEEP(*(.vectors))			\
 		}							\
 		.vectors.bhb.loop8 {					\
-			KEEP(*(.vectors.bhb.loop8))			\
+			OVERLAY_KEEP(*(.vectors.bhb.loop8))		\
 		}							\
 		.vectors.bhb.bpiall {					\
-			KEEP(*(.vectors.bhb.bpiall))			\
+			OVERLAY_KEEP(*(.vectors.bhb.bpiall))		\
 		}							\
 	}								\
 	ARM_LMA(__vectors, .vectors);					\
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..fc994f5cd5db 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -129,6 +129,11 @@ config CC_HAS_COUNTED_BY
 	# https://github.com/llvm/llvm-project/pull/112636
 	depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)
 
+config LD_CAN_USE_KEEP_IN_OVERLAY
+	# ld.lld prior to 21.0.0 did not support KEEP within an overlay description
+	# https://github.com/llvm/llvm-project/pull/130661
+	def_bool LD_IS_BFD || LLD_VERSION >= 210000
+
 config RUSTC_HAS_COERCE_POINTEE
 	def_bool RUSTC_VERSION >= 108400
 

