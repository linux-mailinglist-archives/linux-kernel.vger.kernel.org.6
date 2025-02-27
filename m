Return-Path: <linux-kernel+bounces-536349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C01A47E75
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D6116C5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4A922CBC9;
	Thu, 27 Feb 2025 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXyEjgji"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17071DFCB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661432; cv=none; b=MHeOBlFahtNxvZFD0uBhw88GYE0d5f9h68V1LMJ5XTYI8eTryBz+helJv3SACHt1XYbBLvlOxbyGSB5v3DOCw4Dg9u5KKuHBglHDQZIbeu44QTswopOdJuJ/6CpHfhGPICkFDzysaQHF3+yGk8jctUOOwBjquchqS8ISc9cYIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661432; c=relaxed/simple;
	bh=WCRFtwHSLg5bn3nZuqbUlnrk/01hPwi2oWsj/vbyA9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmHgKsqX45lerxTpHhBah94mFfMsAh4WEQvPGmnnvTKTqmc2z3jgOi3jOIk62004Sm1N132hT31XWi+uN3YVa/171GZiLqJL6WgjTMmAy3BqcNjGq4lBO8CffT8ew70za70RgA+H6PJd5zMoVkIgNGnd5MdovHtmcjMTQlu/gpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXyEjgji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC439C4CEDD;
	Thu, 27 Feb 2025 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740661432;
	bh=WCRFtwHSLg5bn3nZuqbUlnrk/01hPwi2oWsj/vbyA9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXyEjgjilGZM7A6kfroTSd/PwWtDqRVfYIMNoS4YdMXlFCqhXMcIrglu4HXBtEUEW
	 bajWTOo7HThbzh7UKGtDJIi6ZN7mv4zie5FVAQLR9/d5Du9BqCOxMmkSjN0d60lC1T
	 k0z4ORvpDGgu2pMUL00T4nzq98WbRDHAm2yQW+hSAixfQ68r0vN3jwhCIOBghzVPyt
	 j1Y3b2cfWHuK7XmH42PctaCSzWLXF0dDRhBma4FYkU/Y8b0wFpj7m8J4mJHy7kzsAI
	 dVdVtFwul0UllSA7aK/Bx/B8Ju7beJv7WLg53xfViXJ1v4LRanJNBUouSgSSERoWA2
	 mjyYOR0GrhFDA==
Date: Thu, 27 Feb 2025 14:03:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	dan.j.williams@intel.com, dave.hansen@linux.intel.com,
	david@redhat.com, jane.chu@oracle.com, osalvador@suse.de,
	tglx@linutronix.de
Subject: Re: [PATCH v2 2/2] x86/mm: Remove unnecessary include in set_memory.h
Message-ID: <Z8BirVtqibWY6zaT@gmail.com>
References: <20241212080904.2089632-1-kevin.brodsky@arm.com>
 <20241212080904.2089632-3-kevin.brodsky@arm.com>
 <Z8BiUnkPnvrx06vp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8BiUnkPnvrx06vp@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> So I tried to pick up this patch belatedly, but there's more places 
> that mistakenly learned to rely on the stray <linux/mm.h> inclusion, 
> for example on x86 defconfig-ish kernels:
> 
> 
>   In file included from drivers/gpu/drm/i915/gt/intel_ggtt.c:6:
>   ./arch/x86/include/asm/set_memory.h:40:57: error: unknown type name ‘pgprot_t’
>   40 | int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
>   |                                                         ^~~~~~~~

BTW., I did a few touchups to the changelog (see below) - mind picking 
that up once you submit -v2?

Thanks,

	Ingo

======================>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Thu, 12 Dec 2024 08:09:04 +0000
Subject: [PATCH] x86/mm: Reduce header dependencies in <asm/set_memory.h>

Commit:

  03b122da74b2 ("x86/sgx: Hook arch_memory_failure() into mainline code")

... added <linux/mm.h> to <asm/set_memory.h> to provide some helpers.

However the following commit:

  b3fdf9398a16 ("x86/mce: relocate set{clear}_mce_nospec() functions")

... moved the inline definitions someplace else, and now <asm/set_memory.h>
just declares a bunch of mostly self-contained functions.

No need for the whole <linux/mm.h> inclusion to declare functions; just
remove that include. This helps avoid circular dependency headaches
(e.g. if <linux/mm.h> ends up including <linux/set_memory.h>).

This change requires a couple of include fixups not to break the
build:

* <asm/smp.h>: including <asm/thread_info.h> directly relies on
  <linux/thread_info.h> having already been included, because the
  former needs the BAD_STACK/NOT_STACK constants defined in the
  latter. This is no longer the case when <asm/smp.h> is included from
  some driver file - just include <linux/thread_info.h> to stay out
  of trouble.

* sev-guest.c relies on <asm/set_memory.h> including <linux/mm.h>,
  so we just need to make that include explicit.

[ mingo: Cleaned up the changelog ]

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20241212080904.2089632-3-kevin.brodsky@arm.com
---
 arch/x86/include/asm/set_memory.h       | 1 -
 arch/x86/include/asm/smp.h              | 2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index cc62ef70ccc0..023994fe6115 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_SET_MEMORY_H
 #define _ASM_X86_SET_MEMORY_H
 
-#include <linux/mm.h>
 #include <asm/page.h>
 #include <asm-generic/set_memory.h>
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..2ca1da5f16d9 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -3,10 +3,10 @@
 #define _ASM_X86_SMP_H
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
+#include <linux/thread_info.h>
 
 #include <asm/cpumask.h>
 #include <asm/current.h>
-#include <asm/thread_info.h>
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 264b6523fe52..ddec5677e247 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -23,6 +23,7 @@
 #include <linux/cleanup.h>
 #include <linux/uuid.h>
 #include <linux/configfs.h>
+#include <linux/mm.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
 

