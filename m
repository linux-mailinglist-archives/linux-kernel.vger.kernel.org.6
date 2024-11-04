Return-Path: <linux-kernel+bounces-394964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F009BB699
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E817C1F22777
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41ED433A4;
	Mon,  4 Nov 2024 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDuQtVkU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD1134AB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727886; cv=none; b=Sp9cWIUmX3+JO4AUuV1LyuttAhPXCaAw1L+G7DuhXlP8tkavUqRI4AttjdOsGYoGpSYzqL8bU2/oTZF+Gtyjhq+a+aYAas1XRXA2QC6pbJa8BTYLZu4Fku81EyhbTCMmpJSIPBojSTsRmaVf8Vliy1M3SbLFkBE0T0kPSH/Bqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727886; c=relaxed/simple;
	bh=ZYStMk4Gi55h1tWu0d9Ok+yaVMiLEPxOaSI+uXt7PgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTlrqunJ3L410DiGSmFrc4yJnFqqrDQLnZuallq0ZwFinJjQ2/FjPYbTYxqyftUI3S11Ennc6x1hnq68HCZYRGERs6LA6JBpHlUXjGpzPtrnJP4QERR9OHEW53fzFpZazBSL4DNF1rC5te6MdvmMc8Q779f4hdGyBLYXYdyPsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDuQtVkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2017EC4CECE;
	Mon,  4 Nov 2024 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730727885;
	bh=ZYStMk4Gi55h1tWu0d9Ok+yaVMiLEPxOaSI+uXt7PgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KDuQtVkU7GMbwv3ENspt5cXF0KnqhZXTLCibyipkRAlQvHkUmKDrPdirKVjIjZVyg
	 dAG/OjoSbB/TNvxtfyv3EyDb6YKZ77Y2YsoXNIMts6JGhapZ+t8/l6UGKUL6/fNmTK
	 t/LSi0dBft2xSFkagAHihqawXs3ouHnYWXpyzJz86prKJ9hf9m0sY3cQhw2w61ZU25
	 wW04VSh5YDh15i0l/MAAycWZ7lwkM4x+DFwweTu1//6aRML0gBNK65mb0OABCO14Dg
	 SgK7g5G4f11CQ/sal3/7zU17+MZPiCuvxoVCJBLUyEvAuYvByVL3WTaiEPw1Z05hxL
	 4YKixCM6ApJnQ==
Message-ID: <d3432361-5ef1-4199-a65a-f36b7db3503e@kernel.org>
Date: Mon, 4 Nov 2024 23:44:41 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] [v3] m68k: move sun3 into a top-level platform option
To: Arnd Bergmann <arnd@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20241030195638.22542-1-arnd@kernel.org>
Content-Language: en-US
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <20241030195638.22542-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnd,

On 31/10/24 05:56, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It is possible to select an m68k MMU build but not actually
> enable any of the three MMU options, which then results in a
> build failure:
> 
>   arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
> 
> Change the Kconfig selection to ensure that exactly one of the
> three options is always enabled whenever an MMU-enabled kernel
> is built, but moving CONFIG_SUN3 into a top-level option next
> to M68KCLASSIC and COLDFIRE.
> 
> All defconfig files should keep working without changes,
> but alldefconfig now builds support for the classic MMU.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408032138.P7sBvIns-lkp@intel.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

All looks fine to me, thanks for taking care of this.

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



> ---
> v3:
>   - fix coldfire+mmu build failure, by taking out the m68020 default
> 
> v2:
>   - resend
> ---
>   arch/m68k/Kconfig         | 11 +++++------
>   arch/m68k/Kconfig.cpu     | 35 ++++++++++++++++++++++-------------
>   arch/m68k/Kconfig.machine | 25 -------------------------
>   arch/m68k/kernel/Makefile | 12 ++----------
>   arch/m68k/kernel/time.c   |  4 ++--
>   5 files changed, 31 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index cc26df907bfe..7c4f7bcc89d7 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -84,24 +84,23 @@ config MMU
>   	  support by paged memory management. If unsure, say 'Y'.
>   
>   config MMU_MOTOROLA
> -	bool
> +	def_bool MMU && M68KCLASSIC
>   	select HAVE_PAGE_SIZE_4KB
>   
>   config MMU_COLDFIRE
> +	def_bool MMU && COLDFIRE
>   	select HAVE_PAGE_SIZE_8KB
> -	bool
>   
>   config MMU_SUN3
> -	bool
> +	def_bool MMU && SUN3
>   	select HAVE_PAGE_SIZE_8KB
> -	depends on MMU && !MMU_MOTOROLA && !MMU_COLDFIRE
>   
>   config ARCH_SUPPORTS_KEXEC
> -	def_bool M68KCLASSIC && MMU
> +	def_bool (M68KCLASSIC || SUN3) && MMU
>   
>   config BOOTINFO_PROC
>   	bool "Export bootinfo in procfs"
> -	depends on KEXEC && M68KCLASSIC
> +	depends on KEXEC && (M68KCLASSIC || SUN3)
>   	help
>   	  Say Y to export the bootinfo used to boot the kernel in a
>   	  "bootinfo" file in procfs.  This is useful with kexec.
> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> index c777a129768a..e7b5f6b55947 100644
> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -2,7 +2,7 @@
>   comment "Processor Type"
>   
>   choice
> -	prompt "CPU family support"
> +	prompt "CPU/machine family support"
>   	default M68KCLASSIC if MMU
>   	default COLDFIRE if !MMU
>   	help
> @@ -19,7 +19,7 @@ choice
>   	  processor, select COLDFIRE.
>   
>   config M68KCLASSIC
> -	bool "Classic M68K CPU family support"
> +	bool "Classic M68K CPU/machine family support"
>   	select HAVE_ARCH_PFN_VALID
>   
>   config COLDFIRE
> @@ -32,13 +32,23 @@ config COLDFIRE
>   	select HAVE_LEGACY_CLK
>   	select HAVE_PAGE_SIZE_8KB if !MMU
>   
> -endchoice
> +config SUN3
> +	bool "Sun3 machine support"
> +	depends on MMU
> +	select HAVE_ARCH_PFN_VALID
> +	select LEGACY_TIMER_TICK
> +	select NO_DMA
> +	select M68020
> +	help
> +	  This option enables support for the Sun 3 series of workstations
> +	  (3/50, 3/60, 3/1xx, 3/2xx systems). These use a classic 68020 CPU
> +	  but the custom memory management unit makes them incompatible with
> +	  all other classic m68k machines, including Sun 3x.
>   
> -if M68KCLASSIC
> +endchoice
>   
>   config M68000
> -	def_bool y
> -	depends on !MMU
> +	def_bool M68KCLASSIC && !MMU
>   	select CPU_HAS_NO_BITFIELDS
>   	select CPU_HAS_NO_CAS
>   	select CPU_HAS_NO_MULDIV64
> @@ -56,7 +66,7 @@ config M68000
>   	  a paging MMU.
>   
>   config M68020
> -	bool "68020 support"
> +	bool "68020 support" if M68KCLASSIC
>   	depends on MMU
>   	select FPU
>   	select CPU_HAS_ADDRESS_SPACES
> @@ -66,9 +76,10 @@ config M68020
>   	  68851 MMU (Memory Management Unit) to run Linux/m68k, except on the
>   	  Sun 3, which provides its own version.
>   
> +if M68KCLASSIC && MMU
> +
>   config M68030
>   	bool "68030 support"
> -	depends on MMU && !MMU_SUN3
>   	select FPU
>   	select CPU_HAS_ADDRESS_SPACES
>   	help
> @@ -78,7 +89,6 @@ config M68030
>   
>   config M68040
>   	bool "68040 support"
> -	depends on MMU && !MMU_SUN3
>   	select FPU
>   	select CPU_HAS_ADDRESS_SPACES
>   	help
> @@ -89,13 +99,14 @@ config M68040
>   
>   config M68060
>   	bool "68060 support"
> -	depends on MMU && !MMU_SUN3
>   	select FPU
>   	select CPU_HAS_ADDRESS_SPACES
>   	help
>   	  If you anticipate running this kernel on a computer with a MC68060
>   	  processor, say Y. Otherwise, say N.
>   
> +endif # M68KCLASSIC
> +
>   config M68328
>   	bool
>   	depends on !MMU
> @@ -117,8 +128,6 @@ config M68VZ328
>   	help
>   	  Motorola 68VZ328 processor support.
>   
> -endif # M68KCLASSIC
> -
>   if COLDFIRE
>   
>   choice
> @@ -325,7 +334,7 @@ comment "Processor Specific Options"
>   
>   config M68KFPU_EMU
>   	bool "Math emulation support"
> -	depends on M68KCLASSIC && FPU
> +	depends on (M68KCLASSIC || SUN3) && FPU
>   	help
>   	  At some point in the future, this will cause floating-point math
>   	  instructions to be emulated by the kernel on machines that lack a
> diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
> index d06b1c5d9b0c..de39f23b180e 100644
> --- a/arch/m68k/Kconfig.machine
> +++ b/arch/m68k/Kconfig.machine
> @@ -6,7 +6,6 @@ if M68KCLASSIC
>   config AMIGA
>   	bool "Amiga support"
>   	depends on MMU
> -	select MMU_MOTOROLA if MMU
>   	select LEGACY_TIMER_TICK
>   	help
>   	  This option enables support for the Amiga series of computers. If
> @@ -16,7 +15,6 @@ config AMIGA
>   config ATARI
>   	bool "Atari support"
>   	depends on MMU
> -	select MMU_MOTOROLA if MMU
>   	select HAVE_ARCH_NVRAM_OPS
>   	select LEGACY_TIMER_TICK
>   	help
> @@ -31,7 +29,6 @@ config ATARI_KBD_CORE
>   config MAC
>   	bool "Macintosh support"
>   	depends on MMU
> -	select MMU_MOTOROLA if MMU
>   	select HAVE_ARCH_NVRAM_OPS
>   	select HAVE_PATA_PLATFORM
>   	select LEGACY_TIMER_TICK
> @@ -44,7 +41,6 @@ config MAC
>   config APOLLO
>   	bool "Apollo support"
>   	depends on MMU
> -	select MMU_MOTOROLA if MMU
>   	select LEGACY_TIMER_TICK
>   	help
>   	  Say Y here if you want to run Linux on an MC680x0-based Apollo
> @@ -53,7 +49,6 @@ config APOLLO
>   config VME
>   	bool "VME (Motorola and BVM) support"
>   	depends on MMU
> -	select MMU_MOTOROLA if MMU
>   	help
>   	  Say Y here if you want to build a kernel for a 680x0 based VME
>   	  board.  Boards currently supported include Motorola boards MVME147,
> @@ -97,7 +92,6 @@ config BVME6000
>   config HP300
>   	bool "HP9000/300 and HP9000/400 support"
>   	depends on MMU
> -	select MMU_MOTOROLA if MMU
>   	select LEGACY_TIMER_TICK
>   	help
>   	  This option enables support for the HP9000/300 and HP9000/400 series
> @@ -110,7 +104,6 @@ config SUN3X
>   	bool "Sun3x support"
>   	depends on MMU
>   	select LEGACY_TIMER_TICK
> -	select MMU_MOTOROLA if MMU
>   	select M68030
>   	help
>   	  This option enables support for the Sun 3x series of workstations.
> @@ -124,7 +117,6 @@ config SUN3X
>   config Q40
>   	bool "Q40/Q60 support"
>   	depends on MMU
> -	select MMU_MOTOROLA if MMU
>   	select LEGACY_TIMER_TICK
>   	help
>   	  The Q40 is a Motorola 68040-based successor to the Sinclair QL
> @@ -133,22 +125,6 @@ config Q40
>   	  Q60. Select your CPU below.  For 68LC060 don't forget to enable FPU
>   	  emulation.
>   
> -config SUN3
> -	bool "Sun3 support"
> -	depends on MMU
> -	depends on !MMU_MOTOROLA
> -	select MMU_SUN3 if MMU
> -	select LEGACY_TIMER_TICK
> -	select NO_DMA
> -	select M68020
> -	help
> -	  This option enables support for the Sun 3 series of workstations
> -	  (3/50, 3/60, 3/1xx, 3/2xx systems). Enabling this option requires
> -	  that all other hardware types must be disabled, as Sun 3 kernels
> -	  are incompatible with all other m68k targets (including Sun 3x!).
> -
> -	  If you don't want to compile a kernel exclusively for a Sun 3, say N.
> -
>   config VIRT
>   	bool "Virtual M68k Machine support"
>   	depends on MMU
> @@ -157,7 +133,6 @@ config VIRT
>   	select GOLDFISH_TIMER
>   	select GOLDFISH_TTY
>   	select M68040
> -	select MMU_MOTOROLA if MMU
>   	select RTC_CLASS
>   	select RTC_DRV_GOLDFISH
>   	select TTY
> diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
> index f335bf3268a1..6c732ed3998b 100644
> --- a/arch/m68k/kernel/Makefile
> +++ b/arch/m68k/kernel/Makefile
> @@ -5,16 +5,8 @@
>   
>   extra-y			+= vmlinux.lds
>   
> -obj-$(CONFIG_AMIGA)	:= head.o
> -obj-$(CONFIG_ATARI)	:= head.o
> -obj-$(CONFIG_MAC)	:= head.o
> -obj-$(CONFIG_APOLLO)	:= head.o
> -obj-$(CONFIG_VME)	:= head.o
> -obj-$(CONFIG_HP300)	:= head.o
> -obj-$(CONFIG_Q40)	:= head.o
> -obj-$(CONFIG_SUN3X)	:= head.o
> -obj-$(CONFIG_VIRT)	:= head.o
> -obj-$(CONFIG_SUN3)	:= sun3-head.o
> +obj-$(CONFIG_MMU_MOTOROLA)	:= head.o
> +obj-$(CONFIG_SUN3)		:= sun3-head.o
>   
>   obj-y	+= entry.o irq.o module.o process.o ptrace.o
>   obj-y	+= setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
> diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
> index a97600b2af50..108debb87cfb 100644
> --- a/arch/m68k/kernel/time.c
> +++ b/arch/m68k/kernel/time.c
> @@ -62,7 +62,7 @@ void timer_heartbeat(void)
>   }
>   #endif /* CONFIG_HEARTBEAT */
>   
> -#ifdef CONFIG_M68KCLASSIC
> +#if defined(CONFIG_M68KCLASSIC) || defined(CONFIG_SUN3)
>   /* machine dependent timer functions */
>   int (*mach_hwclk) (int, struct rtc_time*);
>   EXPORT_SYMBOL(mach_hwclk);
> @@ -149,7 +149,7 @@ static int __init rtc_init(void)
>   
>   module_init(rtc_init);
>   #endif /* CONFIG_RTC_DRV_GENERIC */
> -#endif /* CONFIG M68KCLASSIC */
> +#endif /* CONFIG M68KCLASSIC || SUN3 */
>   
>   void __init time_init(void)
>   {

