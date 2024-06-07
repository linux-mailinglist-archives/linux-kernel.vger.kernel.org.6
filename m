Return-Path: <linux-kernel+bounces-206696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 496B4900CD3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8011F211F9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB25154BF9;
	Fri,  7 Jun 2024 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KDmLcRrD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kkEBxDTw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF16D1AB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791738; cv=none; b=TeU4ZFpOExiVNVaQIVNE97kya/nkV7SHzM0xi2hZiqLxYn0F4wOD+ZpPTs4iN/yXdeHf4kQxTCT2vNKWObK0hT+c5+WK3jdsCikaoych0Q6M4SnLlHJN9IoFn5QjHr6lPQhKJN0I+u0W/hfQEKtFCuSFsIRnJ+dKcH9zq0wFK+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791738; c=relaxed/simple;
	bh=GRVB1JZor8DNIf+EA76uz1CDrc9HGTu45kFvmt1Bnko=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iWw51HnPYIuNTLXKUWG5flumNbPXxI7lN3dEpGk6Puu4GYer8nv2xpFu+XfhA6eweo9hJpFgf5zLXTgmKmyhvsAEMXaUWH15ARYo76C0QHoHIRhK3OyfiRUnnt5bI8J4ltNRKuqG79MGtEwMztcm4gf5f2AMHHU7IyLTae0hlHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KDmLcRrD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kkEBxDTw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=95PpUWaV62SsrnL0BPckok51h7bQ1MXWT68WtYsi6ZU=;
	b=KDmLcRrDD/geGDzKxZ7XAY0NSrzjB5ssHpXsodTzg2B5lqPgH3Degn0hcmblSkD3yt9twq
	Owlh9AEmDQexYrtRhMyfuhQW7gQ6is3I67r7OFRndJfA9vB18ko1kUdJxXS4n9dXJJ1pE3
	S4SVaJtWc00v2nNxE2SIHnCD0roOtHB9vuEdRw0P7alD4srihU8ai6H2fimZzUgBkh9E/P
	iP7sfYbk5xCORBxjGIXwTDHVBs6SYud0sp9cgaJ+4vGVQB/PhlsniDV6FfOWzUJeBmJrl5
	u79H9dsry7buSvCifWTC3y38x7+Ix0vcy7XOAnCOAaOPjutzER9OBMNaEGWAyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=95PpUWaV62SsrnL0BPckok51h7bQ1MXWT68WtYsi6ZU=;
	b=kkEBxDTwLGDhUmHWmppMYOcw4k9zSfrUSiHwbrf3F4PLLWFPVNOD1g7RNXufuykyhtquEx
	rCgxUBbJC/+m0pBw==
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] remove size limit on XIP kernel
Date: Fri,  7 Jun 2024 22:22:05 +0200
Message-Id: <cover.1717789719.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

For XIP kernel, the writable data section is always at offset specified in
XIP_OFFSET, which is hard-coded to 32MB.

Unfortunately, this means the read-only section (placed before the
writable section) is restricted in size. This causes build failure if the
kernel gets too large.

This series remove the use of XIP_OFFSET one by one, then remove this
macro entirely at the end, with the goal of lifting this size restriction.

Also some cleanup and documentation along the way.

This series depends on
https://lore.kernel.org/linux-riscv/20240508191917.2892064-1-namcao@linutronix.de/

v2: address all Alex's comments (thanks Alex!). This includes the addition of a
new patch (riscv: don't export va_kernel_pa_offset in vmcoreinfo for XIP kernel),
which fix a build failure if CONFIG_VMCORE_INFO=y

Best regards,
Nam

Nam Cao (8):
  riscv: cleanup XIP_FIXUP macro
  riscv: don't export va_kernel_pa_offset in vmcoreinfo for XIP kernel
  riscv: replace misleading va_kernel_pa_offset on XIP kernel
  riscv: drop the use of XIP_OFFSET in XIP_FIXUP_OFFSET
  riscv: drop the use of XIP_OFFSET in XIP_FIXUP_FLASH_OFFSET
  riscv: drop the use of XIP_OFFSET in kernel_mapping_va_to_pa()
  riscv: drop the use of XIP_OFFSET in create_kernel_page_table()
  riscv: remove limit on the size of read-only section for XIP kernel

 arch/riscv/include/asm/page.h       | 29 ++++++++++++++++++++--------
 arch/riscv/include/asm/pgtable.h    | 18 +++++++----------
 arch/riscv/include/asm/set_memory.h |  2 +-
 arch/riscv/include/asm/xip_fixup.h  | 30 +++++++++++++++++++++++------
 arch/riscv/kernel/vmcore_info.c     |  7 +++++++
 arch/riscv/kernel/vmlinux-xip.lds.S |  5 +++--
 arch/riscv/mm/init.c                | 13 ++++++++-----
 7 files changed, 71 insertions(+), 33 deletions(-)

-- 
2.39.2


