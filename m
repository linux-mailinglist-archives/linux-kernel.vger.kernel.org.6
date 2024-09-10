Return-Path: <linux-kernel+bounces-322883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B94C9731F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D351F2949B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFD2193073;
	Tue, 10 Sep 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PC67wB7s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C16MkPeq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03091188A38
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963133; cv=none; b=LQkkXu6h3ZSqE7IU3aHNve1EU4Qn8PMrcuxRIyp+26dV8CPE8zaW4SAHDr4IGEB7lFaA7KMxbFhHjqas/yNdj0UpKDoNUZEA3Qy2eD4dz4rg5n4AfC1G9EPkKmqtLlYodxrFtQHSc7q1q+wV3kzeJ46CjWTXJwUxUI4Nrmmzqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963133; c=relaxed/simple;
	bh=8arqUqlv9Yca0CDTv97whbQWjAlS4Kk1slWC0wCJ1a0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NxBDVRm0uaA9/xzmo1Fq5uiQByzH1T2Lne6EWDos4jZvO693cE/UGRkstvt64+Li/WuO/RV7ugLYRbdXRcjCTNy46nU174Kxj0mHDCAFfg0hEOhaf2mBAHTih/pqQHwH4XKZSvZ0pu/3cB8oZ7x1e/+FEat3m8gUBf1zT+eS3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PC67wB7s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C16MkPeq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725963130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw53a5Rvwg/dU49bAIlP8Mu7Fhnc5e3mxIRp66Y411k=;
	b=PC67wB7sXxnn4OzWOcNiWmHW9UUtULit/pRNW8fo3ldFj7Irb3D20na336QuimHP9p/SUV
	7wQ1g3yZM1S4WGkviH6mInOqJAyRftYYaK2xaW4Adfxp6Xk+itHHAOpplmNurQCkeiDNKX
	sjulgHoMQUVy/q+X6FIqx1krqgJTVFpC8F3TrAvLdnb5HatqZQ6ls9z7BRuqi97YMpXaNy
	lhf49TrA+TVn3ZTEpYogQtJcNwLm1smr/n+BEeRv3J9PsZc2bYCu7TN986PnVGH0mHJrBM
	kpDOaIac7COg73qIfnrsPKyIEOfMabNofqumL5vkN2YklNiWXzpOK8FcJix5IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725963130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw53a5Rvwg/dU49bAIlP8Mu7Fhnc5e3mxIRp66Y411k=;
	b=C16MkPeqF9S7M7bBC6sXXAP7mUCI7b5tJ7gNYAZnlHkMFKP1dNonJsD2yrupPYBhccmGdH
	Q2wX/OcjlQntVxCg==
Date: Tue, 10 Sep 2024 12:11:35 +0200
Subject: [PATCH 1/2] x86: vdso: Remove ifdeffery around page setup variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240910-x86-vdso-ifdef-v1-1-877c9df9b081@linutronix.de>
References: <20240910-x86-vdso-ifdef-v1-0-877c9df9b081@linutronix.de>
In-Reply-To: <20240910-x86-vdso-ifdef-v1-0-877c9df9b081@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725963129; l=3300;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8arqUqlv9Yca0CDTv97whbQWjAlS4Kk1slWC0wCJ1a0=;
 b=tapd06fgPweJXzTdfvCva07z0vfQI3KpTMKs/6gmn6mpk0TXnR8+iMC3arJc2Q7MsFdajtJ2Y
 2XIfiRst9gKCaWCbE/KrAF2i/9S55t0Lv+7/gb1NU/Hoa2zq898/mxd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Replace the open-coded ifdefs in C sources files with IS_ENABLED().
This makes the code easier to read and enables the compiler to typecheck
also the disabled parts, before optimizing them away.
To make this work, also remove the ifdefs from declarations of used
variables.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/entry/vdso/vma.c   | 31 ++++++++++++-------------------
 arch/x86/include/asm/elf.h  |  4 ----
 arch/x86/include/asm/vdso.h |  8 --------
 3 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 6d83ceb7f1ba..9059b9d96393 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -300,7 +300,6 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 	return map_vdso(image, addr);
 }
 
-#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 static int load_vdso32(void)
 {
 	if (vdso32_enabled != 1)  /* Other values all mean "disabled" */
@@ -308,39 +307,33 @@ static int load_vdso32(void)
 
 	return map_vdso(&vdso_image_32, 0);
 }
-#endif
 
-#ifdef CONFIG_X86_64
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
-	if (!vdso64_enabled)
-		return 0;
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		if (!vdso64_enabled)
+			return 0;
+
+		return map_vdso(&vdso_image_64, 0);
+	}
 
-	return map_vdso(&vdso_image_64, 0);
+	return load_vdso32();
 }
 
 #ifdef CONFIG_COMPAT
 int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp, bool x32)
 {
-#ifdef CONFIG_X86_X32_ABI
-	if (x32) {
+	if (IS_ENABLED(CONFIG_X86_X32_ABI) && x32) {
 		if (!vdso64_enabled)
 			return 0;
 		return map_vdso(&vdso_image_x32, 0);
 	}
-#endif
-#ifdef CONFIG_IA32_EMULATION
-	return load_vdso32();
-#else
+
+	if (IS_ENABLED(CONFIG_IA32_EMULATION))
+		return load_vdso32();
+
 	return 0;
-#endif
-}
-#endif
-#else
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
-{
-	return load_vdso32();
 }
 #endif
 
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 1fb83d47711f..d5a5dadc1cbe 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -75,12 +75,8 @@ typedef struct user_i387_struct elf_fpregset_t;
 
 #include <asm/vdso.h>
 
-#ifdef CONFIG_X86_64
 extern unsigned int vdso64_enabled;
-#endif
-#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 extern unsigned int vdso32_enabled;
-#endif
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index d7f6592b74a9..3f45bcc60b4d 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -33,17 +33,9 @@ struct vdso_image {
 	long sym_vdso32_rt_sigreturn_landing_pad;
 };
 
-#ifdef CONFIG_X86_64
 extern const struct vdso_image vdso_image_64;
-#endif
-
-#ifdef CONFIG_X86_X32_ABI
 extern const struct vdso_image vdso_image_x32;
-#endif
-
-#if defined CONFIG_X86_32 || defined CONFIG_COMPAT
 extern const struct vdso_image vdso_image_32;
-#endif
 
 extern int __init init_vdso_image(const struct vdso_image *image);
 

-- 
2.46.0


