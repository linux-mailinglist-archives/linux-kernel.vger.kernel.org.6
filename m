Return-Path: <linux-kernel+bounces-206692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9F2900CCF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069831C2142F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6814F111;
	Fri,  7 Jun 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sD84pO/Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ojEtW3h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7833EE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791737; cv=none; b=lZcSV8dIgbpBgcZQhXKkkPR6YWkWWq7hLpQ2L0d2sE1bUQEKDDN/iW7W61B22NOgw/k5XJh+wsnSdPZuiR1S3wrKSCiS0lJhFry4H6aJiNUJOOg/qXFYFaNcjKbVFwTKPb2B1TZLW0V8EJfyeloF+1EQ33nYmhXODNY6fHgSnns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791737; c=relaxed/simple;
	bh=YxUzYoHE+R+dtYjDWQYkl313ZUeVoqUy01UITCRL2ek=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APn0MfR3ATJub/uXzdGHUk6QpBZqCsIVKMYhDEjmwgp9JFmpHCLeb8IRoJmEGgYJXGcRW389oCQLZz0mWK8YqGTWqQChVBv24ymRC8V/7djyWXJEfbKtzcomj5pRtqP/JQWLozU9DU5PWsyboT5Uu4aIDZ5I+5HFS2xz3wmyoIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sD84pO/Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ojEtW3h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn6XVXZM59Nth6p5tsQDc4XnTOplZUQTrnvegHUFwrU=;
	b=sD84pO/ZxF8vHvHfZgaOrW5D7kvyq5EI0jJbj4W+SN6ILAClGy5VssRHErCgGiHyp/NwXO
	OZnpD5JzqSFGWBiat2vuhQB4gv+G0m1PrtfMfafLZDdtPvMeYzJc5IflhGoLSWb8nS8wjt
	kJxyansVjaEjcaPglhJjXow7vTGq2KNE3FUU8PwsPnJsEz+U+lmyOVSXoaiSAlMvvII/6m
	k7kxbe5pAKDnVaG9qF4tpQIuGjB6S0rlGDKPQN7uGHI2vG7cMEc4iE3ClM+DExPnVhM7iC
	25S7NRNQBIZ7/1eQ8rI9/dWg7InxsXNoQPcxiQvp7GVnNOD1/0d5iPkEUqdbBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn6XVXZM59Nth6p5tsQDc4XnTOplZUQTrnvegHUFwrU=;
	b=3ojEtW3hB0mfLXr+O+vmKQZ403TBBNLnM77VmV5V/6nREtIuy9sp4RkPWThWftXATWKLaI
	RaWPtBh1X93IkXBQ==
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] riscv: don't export va_kernel_pa_offset in vmcoreinfo for XIP kernel
Date: Fri,  7 Jun 2024 22:22:07 +0200
Message-Id: <8f8760d3f9a11af4ea0acbc247e4f49ff5d317e9.1717789719.git.namcao@linutronix.de>
In-Reply-To: <cover.1717789719.git.namcao@linutronix.de>
References: <cover.1717789719.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The crash utility uses va_kernel_pa_offset to translate virtual addresses.
This is incorrect in the case of XIP kernel, because va_kernel_pa_offset is
not the virtual-physical address offset (yes, the name is misleading; this
variable will be removed for XIP in a following commit).

Stop exporting this variable for XIP kernel. The replacement is to be
determined, note it as a TODO for now.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/kernel/vmcore_info.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/kernel/vmcore_info.c b/arch/riscv/kernel/vmcore_info.c
index 6d7a22522d63..d5e448aa90e7 100644
--- a/arch/riscv/kernel/vmcore_info.c
+++ b/arch/riscv/kernel/vmcore_info.c
@@ -19,6 +19,13 @@ void arch_crash_save_vmcoreinfo(void)
 #endif
 #endif
 	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
+#ifdef CONFIG_XIP_KERNEL
+	/* TODO: Communicate with crash-utility developers on the information to
+	 * export. The XIP case is more complicated, because the virtual-physical
+	 * address offset depends on whether the address is in ROM or in RAM.
+	 */
+#else
 	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",
 						kernel_map.va_kernel_pa_offset);
+#endif
 }
-- 
2.39.2


