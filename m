Return-Path: <linux-kernel+bounces-412972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 404DB9D11FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5503B27DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4571A9B5B;
	Mon, 18 Nov 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="fWQCwr1p"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C919AD7E;
	Mon, 18 Nov 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936590; cv=none; b=jR1TWGuEdAZLrl3ienOUoqtDQtxwQFEYyHy4zXTvVtPhzp6fIT5LWQeI9zm+X7gucM8qbJEPntEmhCNYsfsI6JeqW1ETkgjgSseVYLx2fEF7JecMuHWPdlmiTJpKT8v8XrIjGZ9hGRdz3QBZspoAwNtb8kzCowsULdvDQtHyvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936590; c=relaxed/simple;
	bh=xXbzl2XXxqkx/Lfmf4ybowFt9Rq0TJ6W0fChWIkO/O0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ujqkwCr3U8tRf6kImHOcHmMbfhrGetCAy4vfLmWeVjRyJJfAVeg9jOjEMEzjOKkvtBeEmfPUWfDr+L0pxiNWy9geJGQ/L5LK0eiPOXd4hYogmh9IFsHknsHeX1FMTmcEvum7s4YXUeF65FJgndgQA+/cNQ8XZm7JbtUCvOjFaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=fWQCwr1p; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AICJqTU027657;
	Mon, 18 Nov 2024 13:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=C
	2pYRbTitfQkZVCPd52JrM2BtH1tJjpTazLbGTXYvSI=; b=fWQCwr1picOlC+BX6
	XgiHLnw782Zl+1DC33jrZXKRv5m6wMpbQvMbVht/r4GVLTWhxk8U4lOJno+mVTfl
	sRFlmlMEmXMwj8XSlQkDnzCUU0Es2c/Y9Pv/SSg5zQavmPB4mksRIqAKPDfcnp8H
	2OPoLFBao+bDazj28jAB2hgnR+241sTd6ymyQOp0Yl28tEwG6oBwZhDsGbvzGTg8
	rZyRVDfvvalgmpFjjf251BMB8ZyHkUN4VvYG7HM2ELrwcARVyKSMFvdhC0ZbCk3F
	/Rgpn3oIMM3zt+ljDL18BPVInFYJsMuoMpYfD9wHs9vfxm7bjG3TlARTLAKpvUuL
	3iX/g==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 42xmc1hmj5-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Nov 2024 13:02:43 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 18 Nov 2024 13:02:42 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Mon, 18 Nov 2024 13:02:08 +0000
Subject: [PATCH v2 16/21] drm/imagination: Move ELF fw utils to common file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241118-sets-bxs-4-64-patch-v1-v2-16-3fd45d9fb0cf@imgtec.com>
References: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
In-Reply-To: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7232;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=xXbzl2XXxqkx/Lfmf4ybowFt9Rq0TJ6W0fChWIkO/O0=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRbWz27m3j91jbLQM3+GSzfWThaKmylXUVvyXTzNb1iW
 ipw6XJXRykLgxgHg6yYIsuOFZYr1P6oaUnc+FUMM4eVCWQIAxenAExkWw3DX3mDyGNdjjGvus4/
 LcvUuBN16nvRotfLXZyV/Q58N75xLZyR4bJyhuc3/fBH6/4tnq7QO7npldd2P//Q1WGSi5l1P90
 R4wMA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: 03jTR1EQgqUoVGFkkscmnqrGGxI_nylN
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673b3af3 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=gtgaOig2gG6QrLUE_6sA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 03jTR1EQgqUoVGFkkscmnqrGGxI_nylN

Currently only MIPS firmware processors use ELF-formatted firmware. When
adding support for RISC-V firmware processors, it will be useful to have
ELF handling functions ready to go.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v2:
- None
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-16-4ed30e865892@imgtec.com
---
 drivers/gpu/drm/imagination/Makefile      |  1 +
 drivers/gpu/drm/imagination/pvr_fw.h      |  5 +++
 drivers/gpu/drm/imagination/pvr_fw_mips.c | 59 +--------------------------
 drivers/gpu/drm/imagination/pvr_fw_util.c | 67 +++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/imagination/Makefile b/drivers/gpu/drm/imagination/Makefile
index 9bc6a3884c2239e44265f3cdebee149841b270de..077e4762c7c383b6e339da1584c3865d830ef8d6 100644
--- a/drivers/gpu/drm/imagination/Makefile
+++ b/drivers/gpu/drm/imagination/Makefile
@@ -16,6 +16,7 @@ powervr-y := \
 	pvr_fw_mips.o \
 	pvr_fw_startstop.o \
 	pvr_fw_trace.o \
+	pvr_fw_util.o \
 	pvr_gem.o \
 	pvr_hwrt.o \
 	pvr_job.o \
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index ab69f40a7fbc6304171f16dd16d825a68b0362a5..8d3f0ee0aac69373f15ac5919d5b0f27c67cb284 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -478,4 +478,9 @@ pvr_fw_object_get_fw_addr(struct pvr_fw_object *fw_obj, u32 *fw_addr_out)
 	pvr_fw_object_get_fw_addr_offset(fw_obj, 0, fw_addr_out);
 }
 
+/* Util functions defined in pvr_util.c. These are intended for use in pvr_fw_<arch>.c files. */
+int
+pvr_fw_process_elf_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code_ptr,
+				  u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr);
+
 #endif /* PVR_FW_H */
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index 524a9bd0a20b64c509f5708cc61d93b4c864b835..7f341ceb0661c61ac059654faeec91e149036467 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -8,7 +8,6 @@
 #include "pvr_rogue_mips.h"
 #include "pvr_vm_mips.h"
 
-#include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/types.h>
 
@@ -16,60 +15,6 @@
 #define ROGUE_FW_HEAP_MIPS_SHIFT 24 /* 16 MB */
 #define ROGUE_FW_HEAP_MIPS_RESERVED_SIZE SZ_1M
 
-/**
- * process_elf_command_stream() - Process ELF firmware image and populate
- *                                firmware sections
- * @pvr_dev: Device pointer.
- * @fw: Pointer to firmware image.
- * @fw_code_ptr: Pointer to FW code section.
- * @fw_data_ptr: Pointer to FW data section.
- * @fw_core_code_ptr: Pointer to FW coremem code section.
- * @fw_core_data_ptr: Pointer to FW coremem data section.
- *
- * Returns :
- *  * 0 on success, or
- *  * -EINVAL on any error in ELF command stream.
- */
-static int
-process_elf_command_stream(struct pvr_device *pvr_dev, const u8 *fw, u8 *fw_code_ptr,
-			   u8 *fw_data_ptr, u8 *fw_core_code_ptr, u8 *fw_core_data_ptr)
-{
-	struct elf32_hdr *header = (struct elf32_hdr *)fw;
-	struct elf32_phdr *program_header = (struct elf32_phdr *)(fw + header->e_phoff);
-	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
-	u32 entry;
-	int err;
-
-	for (entry = 0; entry < header->e_phnum; entry++, program_header++) {
-		void *write_addr;
-
-		/* Only consider loadable entries in the ELF segment table */
-		if (program_header->p_type != PT_LOAD)
-			continue;
-
-		err = pvr_fw_find_mmu_segment(pvr_dev, program_header->p_vaddr,
-					      program_header->p_memsz, fw_code_ptr, fw_data_ptr,
-					      fw_core_code_ptr, fw_core_data_ptr, &write_addr);
-		if (err) {
-			drm_err(drm_dev,
-				"Addr 0x%x (size: %d) not found in any firmware segment",
-				program_header->p_vaddr, program_header->p_memsz);
-			return err;
-		}
-
-		/* Write to FW allocation only if available */
-		if (write_addr) {
-			memcpy(write_addr, fw + program_header->p_offset,
-			       program_header->p_filesz);
-
-			memset((u8 *)write_addr + program_header->p_filesz, 0,
-			       program_header->p_memsz - program_header->p_filesz);
-		}
-	}
-
-	return 0;
-}
-
 static int
 pvr_mips_init(struct pvr_device *pvr_dev)
 {
@@ -100,8 +45,8 @@ pvr_mips_fw_process(struct pvr_device *pvr_dev, const u8 *fw,
 	u32 page_nr;
 	int err;
 
-	err = process_elf_command_stream(pvr_dev, fw, fw_code_ptr, fw_data_ptr, fw_core_code_ptr,
-					 fw_core_data_ptr);
+	err = pvr_fw_process_elf_command_stream(pvr_dev, fw, fw_code_ptr, fw_data_ptr,
+						fw_core_code_ptr, fw_core_data_ptr);
 	if (err)
 		return err;
 
diff --git a/drivers/gpu/drm/imagination/pvr_fw_util.c b/drivers/gpu/drm/imagination/pvr_fw_util.c
new file mode 100644
index 0000000000000000000000000000000000000000..7bc8a5c48e9b0eed2045607ab2cfed80a60a32b5
--- /dev/null
+++ b/drivers/gpu/drm/imagination/pvr_fw_util.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/* Copyright (c) 2024 Imagination Technologies Ltd. */
+
+#include "pvr_device.h"
+#include "pvr_fw.h"
+
+#include <drm/drm_device.h>
+#include <drm/drm_print.h>
+
+#include <linux/elf.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+/**
+ * pvr_fw_process_elf_command_stream() - Process ELF firmware image and populate
+ *                                       firmware sections
+ * @pvr_dev: Device pointer.
+ * @fw: Pointer to firmware image.
+ * @fw_code_ptr: Pointer to FW code section.
+ * @fw_data_ptr: Pointer to FW data section.
+ * @fw_core_code_ptr: Pointer to FW coremem code section.
+ * @fw_core_data_ptr: Pointer to FW coremem data section.
+ *
+ * Returns :
+ *  * 0 on success, or
+ *  * -EINVAL on any error in ELF command stream.
+ */
+int
+pvr_fw_process_elf_command_stream(struct pvr_device *pvr_dev, const u8 *fw,
+				  u8 *fw_code_ptr, u8 *fw_data_ptr,
+				  u8 *fw_core_code_ptr, u8 *fw_core_data_ptr)
+{
+	struct elf32_hdr *header = (struct elf32_hdr *)fw;
+	struct elf32_phdr *program_header = (struct elf32_phdr *)(fw + header->e_phoff);
+	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
+	u32 entry;
+	int err;
+
+	for (entry = 0; entry < header->e_phnum; entry++, program_header++) {
+		void *write_addr;
+
+		/* Only consider loadable entries in the ELF segment table */
+		if (program_header->p_type != PT_LOAD)
+			continue;
+
+		err = pvr_fw_find_mmu_segment(pvr_dev, program_header->p_vaddr,
+					      program_header->p_memsz, fw_code_ptr, fw_data_ptr,
+					      fw_core_code_ptr, fw_core_data_ptr, &write_addr);
+		if (err) {
+			drm_err(drm_dev,
+				"Addr 0x%x (size: %d) not found in any firmware segment",
+				program_header->p_vaddr, program_header->p_memsz);
+			return err;
+		}
+
+		/* Write to FW allocation only if available */
+		if (write_addr) {
+			memcpy(write_addr, fw + program_header->p_offset,
+			       program_header->p_filesz);
+
+			memset((u8 *)write_addr + program_header->p_filesz, 0,
+			       program_header->p_memsz - program_header->p_filesz);
+		}
+	}
+
+	return 0;
+}

-- 
2.47.0


