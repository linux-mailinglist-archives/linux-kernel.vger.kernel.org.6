Return-Path: <linux-kernel+bounces-441522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E871E9ECF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0E716A4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8CD1AF0B4;
	Wed, 11 Dec 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1TLssvDP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F11A0BFA;
	Wed, 11 Dec 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930648; cv=none; b=KeHpB4adqA4jmMi4duYcMUHU/hzysMvcxFSc7O4Y+PYfSZyPjM9/RBL6KKvs4VWxO3bc6hTJpD1awdPEtDo0ZZu7480of47LaRPkY4DIalIdkfdkEKUPd0qkB3fCbYXByRPvKeG22MtFjBI9cWilDuRNN2mGmw0fPRae0MlKFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930648; c=relaxed/simple;
	bh=YWUMp0eEwkpqi4QedBPtS5+S/s1FRPc5L3EnWwZcaOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZa/7OYYmHMmi8HmjwhjWOSpY9rYgYMiSMTYr4s7NE1KBJK+KoJ21MXFs7APrEIKVrMJcHKs1GRbsL+nUD3TBpa9bplQBeWkmStWlkgSa8EfXGKmtBCySHyAPRLhYPH8BozOmELv+wd143tiHCAZwd70+qydI8nkwWP3Rng1f5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1TLssvDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A486C4CED2;
	Wed, 11 Dec 2024 15:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733930646;
	bh=YWUMp0eEwkpqi4QedBPtS5+S/s1FRPc5L3EnWwZcaOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1TLssvDP0fIGQUoBBvY+t43UDlIBZE6tXIxo+dQS3hV3PKRSKgSBMea//EK0wbNJp
	 gG5STxSgV53a7MagV3622NQciaYEmsQBK16ABaROPsV5VjYiofqqo+p99AOi/qNUAi
	 0iFLTQ/gp4c9Lm0Oe3Zadh9DXKCrgUN0ZFGKmdec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.65
Date: Wed, 11 Dec 2024 16:23:53 +0100
Message-ID: <2024121108-unplowed-astrology-38ca@gregkh>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2024121108-embroider-theology-0e46@gregkh>
References: <2024121108-embroider-theology-0e46@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 74f3867461a0..3eda4d12d924 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 64
+SUBLEVEL = 65
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/arch/openrisc/include/asm/fixmap.h b/arch/openrisc/include/asm/fixmap.h
index aece6013fead..aaa6a26a3e92 100644
--- a/arch/openrisc/include/asm/fixmap.h
+++ b/arch/openrisc/include/asm/fixmap.h
@@ -39,35 +39,6 @@ enum fixed_addresses {
 extern void __set_fixmap(enum fixed_addresses idx,
 			 phys_addr_t phys, pgprot_t flags);
 
-#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
-
-/*
- * 'index to address' translation. If anyone tries to use the idx
- * directly without tranlation, we catch the bug with a NULL-deference
- * kernel oops. Illegal ranges of incoming indices are caught too.
- */
-static __always_inline unsigned long fix_to_virt(const unsigned int idx)
-{
-	/*
-	 * this branch gets completely eliminated after inlining,
-	 * except when someone tries to use fixaddr indices in an
-	 * illegal way. (such as mixing up address types or using
-	 * out-of-range indices).
-	 *
-	 * If it doesn't get removed, the linker will complain
-	 * loudly with a reasonably clear error message..
-	 */
-	if (idx >= __end_of_fixed_addresses)
-		BUG();
-
-	return __fix_to_virt(idx);
-}
-
-static inline unsigned long virt_to_fix(const unsigned long vaddr)
-{
-	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
-	return __virt_to_fix(vaddr);
-}
+#include <asm-generic/fixmap.h>
 
 #endif
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 008a80552224..c4365a05ab83 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -100,27 +100,7 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	xor %edx, %edx
 	wrmsr
 
-	/*
-	 * Calculate load offset and store in phys_base.  __pa() needs
-	 * phys_base set to calculate the hypercall page in xen_pvh_init().
-	 */
-	movq %rbp, %rbx
-	subq $_pa(pvh_start_xen), %rbx
-	movq %rbx, phys_base(%rip)
-
-	/* Call xen_prepare_pvh() via the kernel virtual mapping */
-	leaq xen_prepare_pvh(%rip), %rax
-	subq phys_base(%rip), %rax
-	addq $__START_KERNEL_map, %rax
-	ANNOTATE_RETPOLINE_SAFE
-	call *%rax
-
-	/*
-	 * Clear phys_base.  __startup_64 will *add* to its value,
-	 * so reset to 0.
-	 */
-	xor  %rbx, %rbx
-	movq %rbx, phys_base(%rip)
+	call xen_prepare_pvh
 
 	/* startup_64 expects boot_params in %rsi. */
 	mov $_pa(pvh_bootparams), %rsi

