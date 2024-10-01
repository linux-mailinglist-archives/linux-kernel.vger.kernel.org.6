Return-Path: <linux-kernel+bounces-346324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FC398C322
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5BEB23E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EA11CDA1B;
	Tue,  1 Oct 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GloO7cRZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE3B1CCEE4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799066; cv=none; b=Z8Uehnbnx4Sr3bIlCHTvNk9I+uQP78BmVs6Q4M848D0qi62mP4W4Tldv07BBXn2IVV0vuo2Q4Kie49CQSBKpmG3ZCJb06b7gUF6r1HdeWZpsMsVLDkbHS72hZafS+Dh6WB+W26DTv+OMPkLdLPuRjowNqxvZFUUKyx/5YAS/9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799066; c=relaxed/simple;
	bh=og3ptKplKRERSZZ6uPlQwnlGAsXnoXNYZX9O9+GAwnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvzutkhyak+SPSAvCP7Xmhw1M1Mc5B/5sVl5jwRUO3jkSKJXJGlfCC1Xr8DNxUteBn+vAA/4dTG3AYWC5+7dHRFIS2wWm24H0YU8onOw7z9ryQaSxLnldYYIJ+F7czWO78vO+6LS91ZZHC0qg1hv0xuzWFu2aPTv87yVBxmLgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GloO7cRZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727799064; x=1759335064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=og3ptKplKRERSZZ6uPlQwnlGAsXnoXNYZX9O9+GAwnE=;
  b=GloO7cRZqTHCK5G3pH8eVv1ZBrM5KGYvHku0qIe3n3QWtUwDm2UZtKDX
   Lg8AAALTPCD5nt+bzTyl1WHO3vn81umN/7tOGmzlCbA8UlKuJAOwI9BuT
   S2eBndAvCdyQp8ZhNUqoTBkadHZHC7LHb1FK+K8Agh3+LiuGHwl1IYwTm
   rQgnhYDqtiCLqghhcfaPstdIZOHC7EPcFSPzGr9Y9H7gvMaMpEUsHR4vD
   O17/OPLlaDQ676pqkPphCLDwA+/+QlsqjZgdNQFsjYypzYjso1quUpAFF
   s9FYvflOEhRXWD8ZIjqq5znVoekdex8lII+KHAx5F9PXJq6c4X3kAUIav
   w==;
X-CSE-ConnectionGUID: 1XwUQQOSRtu1Hmq90P+sew==
X-CSE-MsgGUID: 7L15KRYfTumW785ITbIIZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37539404"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37539404"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:11:04 -0700
X-CSE-ConnectionGUID: XkQWciR5RY6iqv11TVqRaQ==
X-CSE-MsgGUID: b74saRphQZSphBzHhulFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78586008"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.136.21])
  by orviesa003.jf.intel.com with ESMTP; 01 Oct 2024 09:11:04 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC 6/7] x86/microcode/intel_staging: Support mailbox data transfer
Date: Tue,  1 Oct 2024 09:10:41 -0700
Message-Id: <20241001161042.465584-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001161042.465584-1-chang.seok.bae@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The staging architecture features a narrowed interface for data transfer.
Instead of allocating MMIO space based on data chunk size, it utilizes
two data registers: one for reading and one for writing, enforcing the
serialization of read and write operations. Additionally, it defines a
mailbox data format.

To facilitate data transfer, implement helper functions in line with this
specified format for reading and writing staging data. This mailbox
format is a customized version and is not compatible with the existing
mailbox code, so reuse is not feasible.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel_staging.c | 55 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel_staging.c b/arch/x86/kernel/cpu/microcode/intel_staging.c
index 9989a78f9ef2..d56bad30164c 100644
--- a/arch/x86/kernel/cpu/microcode/intel_staging.c
+++ b/arch/x86/kernel/cpu/microcode/intel_staging.c
@@ -3,6 +3,7 @@
 #define pr_fmt(fmt) "microcode: " fmt
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/pci_ids.h>
 
 #include "internal.h"
 
@@ -11,17 +12,44 @@
 
 #define MBOX_CONTROL_OFFSET	0x0
 #define MBOX_STATUS_OFFSET	0x4
+#define MBOX_WRDATA_OFFSET	0x8
+#define MBOX_RDDATA_OFFSET	0xc
 
 #define MASK_MBOX_CTRL_ABORT	BIT(0)
+#define MASK_MBOX_CTRL_GO	BIT(31)
 
 #define MASK_MBOX_STATUS_ERROR	BIT(2)
 #define MASK_MBOX_STATUS_READY	BIT(31)
 
+#define MASK_MBOX_RESP_SUCCESS	BIT(0)
+#define MASK_MBOX_RESP_PROGRESS	BIT(1)
+#define MASK_MBOX_RESP_ERROR	BIT(2)
+
+#define MBOX_CMD_LOAD		0x3
+#define MBOX_OBJ_STAGING	0xb
+#define MBOX_HDR		(PCI_VENDOR_ID_INTEL | (MBOX_OBJ_STAGING << 16))
+#define MBOX_HDR_SIZE		16
+
 #define MBOX_XACTION_LEN	PAGE_SIZE
 #define MBOX_XACTION_MAX(imgsz)	((imgsz) * 2)
 #define MBOX_XACTION_TIMEOUT	(10 * MSEC_PER_SEC)
 
 #define STAGING_OFFSET_END	0xffffffff
+#define DWORD_SIZE(s)		((s) / sizeof(u32))
+
+static inline u32 read_mbox_dword(void __iomem *base)
+{
+	u32 dword = readl(base + MBOX_RDDATA_OFFSET);
+
+	/* Inform the read completion to the staging firmware */
+	writel(0, base + MBOX_RDDATA_OFFSET);
+	return dword;
+}
+
+static inline void write_mbox_dword(void __iomem *base, u32 dword)
+{
+	writel(dword, base + MBOX_WRDATA_OFFSET);
+}
 
 static inline void abort_xaction(void __iomem *base)
 {
@@ -30,7 +58,18 @@ static inline void abort_xaction(void __iomem *base)
 
 static void request_xaction(void __iomem *base, u32 *chunk, unsigned int chunksize)
 {
-	pr_debug_once("Need to implement staging mailbox loading code.\n");
+	unsigned int i, dwsize = DWORD_SIZE(chunksize);
+
+	write_mbox_dword(base, MBOX_HDR);
+	write_mbox_dword(base, dwsize + DWORD_SIZE(MBOX_HDR_SIZE));
+
+	write_mbox_dword(base, MBOX_CMD_LOAD);
+	write_mbox_dword(base, 0);
+
+	for (i = 0; i < dwsize; i++)
+		write_mbox_dword(base, chunk[i]);
+
+	writel(MASK_MBOX_CTRL_GO, base + MBOX_CONTROL_OFFSET);
 }
 
 static enum ucode_state wait_for_xaction(void __iomem *base)
@@ -55,8 +94,18 @@ static enum ucode_state wait_for_xaction(void __iomem *base)
 
 static enum ucode_state read_xaction_response(void __iomem *base, unsigned int *offset)
 {
-	pr_debug_once("Need to implement staging response handler.\n");
-	return UCODE_ERROR;
+	u32 flag;
+
+	WARN_ON_ONCE(read_mbox_dword(base) != MBOX_HDR);
+	WARN_ON_ONCE(read_mbox_dword(base) != DWORD_SIZE(MBOX_HDR_SIZE));
+
+	*offset = read_mbox_dword(base);
+
+	flag = read_mbox_dword(base);
+	if (flag & MASK_MBOX_RESP_ERROR)
+		return UCODE_ERROR;
+
+	return UCODE_OK;
 }
 
 static inline unsigned int get_chunksize(unsigned int totalsize, unsigned int offset)
-- 
2.43.0


