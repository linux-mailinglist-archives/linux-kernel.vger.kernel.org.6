Return-Path: <linux-kernel+bounces-543629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B47BBA4D7B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A99B1888710
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048581FCD03;
	Tue,  4 Mar 2025 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxJh7Sti"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605221F790C;
	Tue,  4 Mar 2025 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079695; cv=none; b=np5OopIMEntfiJxDCAfC7LauQhfVvDFAego05TbNQ2gUyR2o6x7dKRUtGikXsKkqEBBY8L5HAz290e0ntBk+u1XaLtMG9GohcVRTKQvB8fnw2h26/WrUgwPAoHMiwLz7H4RqX0GmOcmf80kk0tHiugoCLgoWl9eTLH5oQ2e5ScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079695; c=relaxed/simple;
	bh=xaV5V5qAKLlvXHhyPviE2Q2L3D/5lrlRMPsvppCLPKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dugy0qyPx7drKI6v8WOEOlqZwGUw5HbxJJfLMXxz/rK0mBCi72ErNxRcE4n8L7Gypau+iqsnXlEzI8oF1EBUWYe7I/+ZNBxaEocAXa/oY8I8bHwmnFV9d0yuCfb3n1AlrN4r/tsEJzOOz3YsisxtKqZ0D48U5odLtKnbcj30PoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxJh7Sti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B249C4CEE5;
	Tue,  4 Mar 2025 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741079694;
	bh=xaV5V5qAKLlvXHhyPviE2Q2L3D/5lrlRMPsvppCLPKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxJh7Stiu0SJCpa+suLuhjMC9etgbQS44tCNAwS75kdsDcV/HEglOufcykxynStcS
	 ROi+Y9QhES5oCvOqhMxxl8fQrWAN6KWLy6PfUbdOR49060IHjHu6/pOzMstqpMMgH3
	 tMXtAS5tBH8oWbD6KulsB+m0ZLJWeNHgefqAlbJpyV16xLEKIdLqu9zg+ZWhIeNrEE
	 E7po7Qi9haCXSKr3kVKu/txfOxO4MlzIIoqGnb9n69GIDko9HMpVysAU+O3nUfh0V4
	 ZJcCZc4SuEgFRvMJmbkbIdwI5f+SlRdBk4pVxxDH51EZqlgNjYg4fUfxyl/1dIrcOl
	 QE04KNUayIhrw==
Date: Tue, 4 Mar 2025 10:14:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 05/40] x86/cpu: Remove unnecessary headers and reorder
 the rest
Message-ID: <Z8bEiWu-Vvu5844p@gmail.com>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <20250304085152.51092-6-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304085152.51092-6-darwi@linutronix.de>


* Ahmed S. Darwish <darwi@linutronix.de> wrote:

> Remove the headers at intel.c that are no longer required.
> 
> Alphabetically reorder what remains since more headers will be included
> in further commits.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  arch/x86/kernel/cpu/intel.c | 35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 134368a3f4b1..72f519534e2b 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1,40 +1,29 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/kernel.h>
> -#include <linux/pgtable.h>
>  
> -#include <linux/string.h>
>  #include <linux/bitops.h>
> -#include <linux/smp.h>
> -#include <linux/sched.h>
> -#include <linux/sched/clock.h>
> -#include <linux/thread_info.h>
>  #include <linux/init.h>
> -#include <linux/uaccess.h>
> +#include <linux/kernel.h>
> +#include <linux/smp.h>
> +#include <linux/string.h>
> +
> +#ifdef CONFIG_X86_64
> +#include <linux/topology.h>
> +#endif
>  
> -#include <asm/cpufeature.h>
> -#include <asm/msr.h>
>  #include <asm/bugs.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/cpufeature.h>
>  #include <asm/cpu.h>
> +#include <asm/hwcap2.h>
>  #include <asm/intel-family.h>
>  #include <asm/microcode.h>
> -#include <asm/hwcap2.h>
> -#include <asm/elf.h>
> -#include <asm/cpu_device_id.h>
> -#include <asm/resctrl.h>
> +#include <asm/msr.h>
>  #include <asm/numa.h>
> +#include <asm/resctrl.h>
>  #include <asm/thermal.h>
>  
> -#ifdef CONFIG_X86_64
> -#include <linux/topology.h>
> -#endif
> -
>  #include "cpu.h"
>  
> -#ifdef CONFIG_X86_LOCAL_APIC
> -#include <asm/mpspec.h>
> -#include <asm/apic.h>
> -#endif

This patch has an unexpected side-effect on i386 allmodconfig builds:

  arch/x86/kernel/cpu/intel.c: In function ‘intel_workarounds’:
  arch/x86/kernel/cpu/intel.c:452:17: error: ‘movsl_mask’ undeclared (first use in this function)
  arch/x86/kernel/cpu/intel.c:452:17: note: each undeclared identifier is reported only once for each function it appears in
  make[5]: *** [scripts/Makefile.build:207: arch/x86/kernel/cpu/intel.o] Error 1

Due to the removal of the <asm/uaccess.h> header.

The attached patch fixes it.

Thanks,

	Ingo

==================>
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a7d297f6bc11..291c82816797 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -22,6 +22,7 @@
 #include <asm/numa.h>
 #include <asm/resctrl.h>
 #include <asm/thermal.h>
+#include <asm/uaccess.h>
 
 #include "cpu.h"
 

