Return-Path: <linux-kernel+bounces-303197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4124D9608E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56B41F23EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EC01A01C3;
	Tue, 27 Aug 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="pWzeeCV9"
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9151219DF7A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758694; cv=none; b=MBQqeEJ3RAO8OPJVGbfTa5MMjPN6bxxLniJ0rAQcrNb7vSio5vXNcrqyt6cSMUxUnZhXJeaVSxsRThM+ByhwfIgrk230I9t3UK/ZFMVX0+iwkDzbAkDPW/kxXwKos2f4XYQaJEGjyLlgfEVqjH5BOxOqgr2JHez1GqWn3MT5YUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758694; c=relaxed/simple;
	bh=F50f3qIUpTHn684n3f885wQ8c6LqK97tiJsfNPZU8Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rxnw7yE2gPbRT1snI1sw13QRT978giKyVGVaBYAO42d6DrRMrjlEUQaUu/NoKjOYbPCJ30ZrQ8oMC0RlH53phvDzCcBE6xAKukNpiB4dokjCQCzEt3ZkBUoaTPdcxc+KAh21035osVI6qpHGRVWBl5TsZ+DYuTNOAcWrB4j75IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=pWzeeCV9 reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1724758689; x=1756294689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F50f3qIUpTHn684n3f885wQ8c6LqK97tiJsfNPZU8Ws=;
  b=pWzeeCV9YIb9QGtH9lJLXGkz4l7kWYwGh2ZpNV4lX+3BzGOYf2R1O2HD
   dWxmuaJY9FsCPUwj/yABm8HG6glHVMJLA16JnjZTVb70wRKNmF0y+K/yl
   COEd8vFQqkxsw3Xuo+hY5gwuh1SWBtxafeUhcWmCOz/90p+7OsMhmkW6b
   jjHlnGkk3GInmJ6rRdeuwFLheWjC+InzCo/5UmlElui7wcuIEFqFciotz
   SDcu45vO4NF7nL0qNcPMaR0ATrdDE2asvF3HLN3UxXce6ipuSPB1ZDhAC
   ezIGaG7D77pgfcqebpCYKrRfu6cXZUYO4h9sBzabFXKftN5HzNV4A0sKr
   A==;
X-CSE-ConnectionGUID: 8Vt/tCSYTPeXDg8jGQvKyg==
X-CSE-MsgGUID: vWMdrELcRTeflhf4xAzopQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:36:55 +0300
X-CSE-ConnectionGUID: l89z8843QFKHaLS15hpymQ==
X-CSE-MsgGUID: IuEfY1SqQ3WNUTEuklfTEg==
Received: from unknown (HELO epgd022.me-corp.lan) ([10.154.54.6])
  by ces03_data.me-corp.lan with SMTP; 27 Aug 2024 14:36:54 +0300
Received: by epgd022.me-corp.lan (sSMTP sendmail emulation); Tue, 27 Aug 2024 14:36:54 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] riscv: make ZONE_DMA32 optional
Date: Tue, 27 Aug 2024 14:36:11 +0300
Message-Id: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not necessary any RISCV platform has ZONE_DMA32.

Example - if platform has no DRAM in [0..4G] region,
it will report failure like below each boot.

[    0.088709] swapper/0: page allocation failure: order:7, mode:0xcc4(GFP_KERNEL|GFP_DMA32), nodemask=(null),cpuset=/
[    0.088832] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc5 #30
[    0.088864] Call Trace:
[    0.088869] [<ffffffff800059f2>] dump_backtrace+0x1c/0x24
[    0.088910] [<ffffffff805f328c>] show_stack+0x2c/0x38
[    0.088957] [<ffffffff805fd800>] dump_stack_lvl+0x52/0x74
[    0.088987] [<ffffffff805fd836>] dump_stack+0x14/0x1c
[    0.089010] [<ffffffff801a23a8>] warn_alloc+0xf4/0x176
[    0.089041] [<ffffffff801a3052>] __alloc_pages_noprof+0xc28/0xcb4
[    0.089067] [<ffffffff80086eda>] atomic_pool_expand+0x62/0x1f8
[    0.089090] [<ffffffff8080d674>] __dma_atomic_pool_init+0x46/0x9e
[    0.089115] [<ffffffff8080d762>] dma_atomic_pool_init+0x96/0x11c
[    0.089139] [<ffffffff80002146>] do_one_initcall+0x5c/0x1b2
[    0.089158] [<ffffffff8080127c>] kernel_init_freeable+0x214/0x274
[    0.089190] [<ffffffff805fefd8>] kernel_init+0x1e/0x10a
[    0.089209] [<ffffffff8060748a>] ret_from_fork+0xe/0x1c

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/Kconfig | 2 +-
 mm/Kconfig         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0f3cd7c3a436..94a573112625 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -50,6 +50,7 @@ config RISCV
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_DATA
+	select ARCH_HAS_ZONE_DMA_SET if 64BIT
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
@@ -200,7 +201,6 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
-	select ZONE_DMA32 if 64BIT
 
 config CLANG_SUPPORTS_DYNAMIC_FTRACE
 	def_bool CC_IS_CLANG
diff --git a/mm/Kconfig b/mm/Kconfig
index b72e7d040f78..97c85da98e89 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1032,7 +1032,7 @@ config ZONE_DMA
 config ZONE_DMA32
 	bool "Support DMA32 zone" if ARCH_HAS_ZONE_DMA_SET
 	depends on !X86_32
-	default y if ARM64
+	default y if ARM64 || (RISCV && 64BIT)
 
 config ZONE_DEVICE
 	bool "Device memory (pmem, HMM, etc...) hotplug support"
-- 
2.37.3


