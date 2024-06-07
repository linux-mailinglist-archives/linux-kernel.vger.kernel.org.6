Return-Path: <linux-kernel+bounces-206698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23322900CD4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6FC1F2109C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B37F155393;
	Fri,  7 Jun 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cQzPkJdt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="baW3tS6A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448E153BF6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791740; cv=none; b=WobZyfo0Okc5thKyvNxuRZ9n1OsteYlFwD/ohGptvYJ0/E5pQHyk9Y5xezjuzH3HvqOEbvINmVLW7/+dpm8D7VtCo1Y9UNHcqflxST1yz2XeWEBQjjUJTTPipgQ9OBmD319ahhE8GHe1wT7QhJjwej725rIJuhcNq42UpYjnKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791740; c=relaxed/simple;
	bh=rqgphNpvAIswvOtuYW+jmZOKl/Ada8Dg9FW1BkMfDMY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FwJEfeQrNaDiEbvMhsPb8GqneMJ7xqIX2MiUSwJeQva8fDh2NDXRagCziX1wXw/tmjegOsVopZmFvBtrfL6aB7kdB4MUhLU43BDd1ExQyaIRfkB/7OuYRGyJFp7Al3l0iV05lox2rgkYNzCqVnDYQ9nT1KTDDWT7t9HQz5Rn6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cQzPkJdt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=baW3tS6A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TP0ssdDAE0NqzBzFQW76UUCVj0BXnEtRoVuuQq7wR+A=;
	b=cQzPkJdtRWilbFwWhEzmOk8wKwdQTdbrjtndb3Y+dC72TGNip7QyeYIf1ym/rDYhKOvXAV
	g994mSyBhfaKP0VLrAYutCQeOoCRfCg3/c6N7Ooiiq4J42a9dL9ikGhDy2gI6+VwOgig6o
	LYu3oKF2qoHLTrsZH8sR0rxBHpp8GagcYhHJIsZXck56+Cdwfd0Aa8CQEFLVTWCk9QjPh0
	q+Iqu8K+S5rKHIJEE14bL/y5+hvGLNoNxkVCmmTGF6o41jKT3C/ObAx1aCE9nVgByBznCn
	NOGPBxuG1TyxM5shHTfhaE3dQBGBZBWyROq3eLWp0auUC3K3Use7X6JyaPCRjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TP0ssdDAE0NqzBzFQW76UUCVj0BXnEtRoVuuQq7wR+A=;
	b=baW3tS6AU1ouireVhMZXJaC7HqFegaRe4WIoi/evjK5RZHILiI6VHVnu0W4qgXHjbRUBRY
	DcR18wEhRuGd6mDA==
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] riscv: drop the use of XIP_OFFSET in kernel_mapping_va_to_pa()
Date: Fri,  7 Jun 2024 22:22:11 +0200
Message-Id: <644c13d9467525a06f5d63d157875a35b2edb4bc.1717789719.git.namcao@linutronix.de>
In-Reply-To: <cover.1717789719.git.namcao@linutronix.de>
References: <cover.1717789719.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XIP_OFFSET is the hard-coded offset of writable data section within the
kernel.

By hard-coding this value, the read-only section of the kernel (which is
placed before the writable data section) is restricted in size.

As a preparation to remove this hard-coded macro XIP_OFFSET entirely,
remove the use of XIP_OFFSET in kernel_mapping_va_to_pa(). The macro
XIP_OFFSET is used in this case to check if the virtual address is mapped
to Flash or to RAM. The same check can be done with kernel_map.xiprom_sz.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index b1fcf0d733c4..cda4a917f90a 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -159,7 +159,7 @@ phys_addr_t linear_mapping_va_to_pa(unsigned long x);
 #ifdef CONFIG_XIP_KERNEL
 #define kernel_mapping_va_to_pa(y) ({						\
 	unsigned long _y = (unsigned long)(y);					\
-	(_y < kernel_map.virt_addr + XIP_OFFSET) ?				\
+	(_y < kernel_map.virt_addr + kernel_map.xiprom_sz) ?			\
 		(_y - kernel_map.va_kernel_xip_text_pa_offset) :		\
 		(_y - kernel_map.va_kernel_xip_data_pa_offset);			\
 	})
-- 
2.39.2


