Return-Path: <linux-kernel+bounces-569627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE53A6A56E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4892E8A0FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3817A2236F4;
	Thu, 20 Mar 2025 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="kG3zDda2"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA718221F1C;
	Thu, 20 Mar 2025 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471392; cv=none; b=UD/Qx7G5UtU3JUvKwDexuKhwDl19TFUizlhxbDx07aRsEekPnTxU0LNq9vyYMu9CZYHDq0CF+PSfi9lbtysg81Oikud7hTz6ce0uDZ9GKPVUOehrA4AFstiex5vxmPnWwINITDCcwLFH2RaER3pFOXN2LpJtaI1WquSGvh8Hcts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471392; c=relaxed/simple;
	bh=hwlKcU7EPs4Wk7fYxA1CZM266u1B3uwcxd+J8QiAJAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ULK5kfpJA7ciKuGYeZ8CWCw7GZjb6k0hCSHZlp9lgozu2nvWsKvkpVTj+cXoKYXAWZXUayZK9AjiQqA11iM9avzwQ3YN7hMjZqLjgs29Sw4MuD+q/sru07Cz4tgL9DEjhKAKfoweyYed+Avh217BIwJnWN+K9dGvkBnTQRNAFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=kG3zDda2; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K7I9lW006831;
	Thu, 20 Mar 2025 11:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=0
	/LMOGl36EsBhYPPnnsrjLJHCxzgGSEbX7mYNxwWjQU=; b=kG3zDda2X43wsL/BD
	nydDuxY7zv/SeYY9dHA3taDcLb3qN4aHcApy3ADHGJEpQhFH51P0nNMWQyU5xIma
	DNSxkl2F31RknxhEyZP0uxpR80Lu0QZtCy2+QyVvyYq08mIteIEKZV+5mJxyHQUt
	XXpaVbJktcSngPYMovJTayk2PJghGxfSC+3tOdFqdBBNcFxqSMU88hvl35XORk7k
	leKwTQJqTNpNSmLGYSwLi+YGv480XbzdeFltYhCEZHQq4EsVzHt5rTmKuux5Mzns
	iQA3A2omJ/DSUcguYCCK+iVQ04F76nlzUXajSpmC6u/GPr6uqBIVbi6S3BrJBFSa
	9AIRw==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 45d2h1kwg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Mar 2025 11:32:33 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.0.133) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 11:32:32 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Thu, 20 Mar 2025 11:32:22 +0000
Subject: [PATCH v4 12/18] drm/imagination: Use callbacks for fw irq
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250320-sets-bxs-4-64-patch-v1-v4-12-d987cf4ca439@imgtec.com>
References: <20250320-sets-bxs-4-64-patch-v1-v4-0-d987cf4ca439@imgtec.com>
In-Reply-To: <20250320-sets-bxs-4-64-patch-v1-v4-0-d987cf4ca439@imgtec.com>
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
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>,
        "Michal
 Wilczynski" <m.wilczynski@samsung.com>,
        Alessio Belle
	<alessio.belle@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7137;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=hwlKcU7EPs4Wk7fYxA1CZM266u1B3uwcxd+J8QiAJAQ=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaTf/nM07Nu+TN0mhpCSU6mL7l967Mmy+8pUS4MNOdfEr
 pf/ba+831HKwiDGwSArpsiyY4XlCrU/aloSN34Vw8xhZQIZwsDFKQATiWVh+O8VMfW54svbAgcc
 QzL/bqxdyFsqlJwcVXBi+3u+1Uu1q3YzMsyvFT/UXKqnNkd3ZVWNseROjhDrsmWfb1d0CDYle+R
 KMAAA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: kUptmVa49Pk6x5hxbk2HjTILvu5lpPT6
X-Proofpoint-ORIG-GUID: kUptmVa49Pk6x5hxbk2HjTILvu5lpPT6
X-Authority-Analysis: v=2.4 cv=V8Z90fni c=1 sm=1 tr=0 ts=67dbfcd1 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=ETbM1kImDFEA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=6iF6CzAXET1p6JnpVhoA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22

This allows for more versatility in checking and clearing firmware
registers used for interrupt handling.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v4:
- None
- Link to v3: https://lore.kernel.org/r/20250310-sets-bxs-4-64-patch-v1-v3-12-143b3dbef02f@imgtec.com
Changes in v3:
- None
- Link to v2: https://lore.kernel.org/r/20241118-sets-bxs-4-64-patch-v1-v2-14-3fd45d9fb0cf@imgtec.com
Changes in v2:
- None
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-14-4ed30e865892@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_device.h  | 18 +++++++++++++
 drivers/gpu/drm/imagination/pvr_fw.h      | 45 +++++++++----------------------
 drivers/gpu/drm/imagination/pvr_fw_meta.c | 22 ++++++++++-----
 drivers/gpu/drm/imagination/pvr_fw_mips.c | 22 ++++++++++-----
 4 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index 12bf0b9e5bfb48ef9e5ed9faa44e0896b7555f49..eb5da8c7040fc9e9751f433279cb0c92fd4d1336 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -739,4 +739,22 @@ pvr_ioctl_union_padding_check(void *instance, size_t union_offset,
 					      __union_size, __member_size);  \
 	})
 
+/*
+ * These utility functions should more properly be placed in pvr_fw.h, but that
+ * would cause a dependency cycle between that header and this one. Since
+ * they're primarily used in pvr_device.c, let's put them in here for now.
+ */
+
+static __always_inline bool
+pvr_fw_irq_pending(struct pvr_device *pvr_dev)
+{
+	return pvr_dev->fw_dev.defs->irq_pending(pvr_dev);
+}
+
+static __always_inline void
+pvr_fw_irq_clear(struct pvr_device *pvr_dev)
+{
+	pvr_dev->fw_dev.defs->irq_clear(pvr_dev);
+}
+
 #endif /* PVR_DEVICE_H */
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 88ad713468ce3a1ee459b04dde5363c24791a4f1..ab69f40a7fbc6304171f16dd16d825a68b0362a5 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -167,29 +167,22 @@ struct pvr_fw_defs {
 	int (*wrapper_init)(struct pvr_device *pvr_dev);
 
 	/**
-	 * @irq: FW Interrupt information.
+	 * @irq_pending: Check interrupt status register for pending interrupts.
 	 *
-	 * Those are processor dependent, and should be initialized by the
-	 * processor backend in pvr_fw_funcs::init().
+	 * @pvr_dev: Target PowerVR device.
+	 *
+	 * This function is mandatory.
 	 */
-	struct {
-		/** @status_reg: FW interrupt status register. */
-		u32 status_reg;
+	bool (*irq_pending)(struct pvr_device *pvr_dev);
 
-		/**
-		 * @clear_reg: FW interrupt clear register.
-		 *
-		 * If @status_reg == @clear_reg, we clear by write a bit to zero,
-		 * otherwise we clear by writing a bit to one.
-		 */
-		u32 clear_reg;
-
-		/** @status_mask: Bitmask of events to listen for in the status_reg. */
-		u32 status_mask;
-
-		/** @clear_mask: Value to write to the clear_reg in order to clear FW IRQs. */
-		u32 clear_mask;
-	} irq;
+	/**
+	 * @irq_clear: Clear pending interrupts.
+	 *
+	 * @pvr_dev: Target PowerVR device.
+	 *
+	 * This function is mandatory.
+	 */
+	void (*irq_clear)(struct pvr_device *pvr_dev);
 
 	/**
 	 * @has_fixed_data_addr: Specify whether the firmware fixed data must be loaded at the
@@ -390,18 +383,6 @@ struct pvr_fw_device {
 	} fw_objs;
 };
 
-#define pvr_fw_irq_read_reg(pvr_dev, name) \
-	pvr_cr_read32((pvr_dev), (pvr_dev)->fw_dev.defs->irq.name ## _reg)
-
-#define pvr_fw_irq_write_reg(pvr_dev, name, value) \
-	pvr_cr_write32((pvr_dev), (pvr_dev)->fw_dev.defs->irq.name ## _reg, value)
-
-#define pvr_fw_irq_pending(pvr_dev) \
-	(pvr_fw_irq_read_reg(pvr_dev, status) & (pvr_dev)->fw_dev.defs->irq.status_mask)
-
-#define pvr_fw_irq_clear(pvr_dev) \
-	pvr_fw_irq_write_reg(pvr_dev, clear, (pvr_dev)->fw_dev.defs->irq.clear_mask)
-
 enum pvr_fw_processor_type {
 	PVR_FW_PROCESSOR_TYPE_META = 0,
 	PVR_FW_PROCESSOR_TYPE_MIPS,
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 62ddfea6b7306784b979ce209bfdf4a9938f8984..d72e0eae9e4b16cb31c48797ffcf5138d2728862 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -533,6 +533,20 @@ pvr_meta_vm_unmap(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 			 fw_obj->fw_mm_node.start, fw_obj->fw_mm_node.size);
 }
 
+static bool
+pvr_meta_irq_pending(struct pvr_device *pvr_dev)
+{
+	return pvr_cr_read32(pvr_dev, ROGUE_CR_META_SP_MSLVIRQSTATUS) &
+	       ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_EN;
+}
+
+static void
+pvr_meta_irq_clear(struct pvr_device *pvr_dev)
+{
+	pvr_cr_write32(pvr_dev, ROGUE_CR_META_SP_MSLVIRQSTATUS,
+		       ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_CLRMSK);
+}
+
 const struct pvr_fw_defs pvr_fw_defs_meta = {
 	.init = pvr_meta_init,
 	.fw_process = pvr_meta_fw_process,
@@ -540,11 +554,7 @@ const struct pvr_fw_defs pvr_fw_defs_meta = {
 	.vm_unmap = pvr_meta_vm_unmap,
 	.get_fw_addr_with_offset = pvr_meta_get_fw_addr_with_offset,
 	.wrapper_init = pvr_meta_wrapper_init,
-	.irq = {
-		.status_reg = ROGUE_CR_META_SP_MSLVIRQSTATUS,
-		.clear_reg = ROGUE_CR_META_SP_MSLVIRQSTATUS,
-		.status_mask = ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_EN,
-		.clear_mask = ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_CLRMSK,
-	},
+	.irq_pending = pvr_meta_irq_pending,
+	.irq_clear = pvr_meta_irq_clear,
 	.has_fixed_data_addr = false,
 };
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index 2c3172841886b70eb7a9992ec3851f18adcad8d5..524a9bd0a20b64c509f5708cc61d93b4c864b835 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -227,6 +227,20 @@ pvr_mips_get_fw_addr_with_offset(struct pvr_fw_object *fw_obj, u32 offset)
 	       ROGUE_FW_HEAP_MIPS_BASE;
 }
 
+static bool
+pvr_mips_irq_pending(struct pvr_device *pvr_dev)
+{
+	return pvr_cr_read32(pvr_dev, ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS) &
+	       ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS_EVENT_EN;
+}
+
+static void
+pvr_mips_irq_clear(struct pvr_device *pvr_dev)
+{
+	pvr_cr_write32(pvr_dev, ROGUE_CR_MIPS_WRAPPER_IRQ_CLEAR,
+		       ROGUE_CR_MIPS_WRAPPER_IRQ_CLEAR_EVENT_EN);
+}
+
 const struct pvr_fw_defs pvr_fw_defs_mips = {
 	.init = pvr_mips_init,
 	.fini = pvr_mips_fini,
@@ -235,11 +249,7 @@ const struct pvr_fw_defs pvr_fw_defs_mips = {
 	.vm_unmap = pvr_vm_mips_unmap,
 	.get_fw_addr_with_offset = pvr_mips_get_fw_addr_with_offset,
 	.wrapper_init = pvr_mips_wrapper_init,
-	.irq = {
-		.status_reg = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS,
-		.clear_reg = ROGUE_CR_MIPS_WRAPPER_IRQ_CLEAR,
-		.status_mask = ROGUE_CR_MIPS_WRAPPER_IRQ_STATUS_EVENT_EN,
-		.clear_mask = ROGUE_CR_MIPS_WRAPPER_IRQ_CLEAR_EVENT_EN,
-	},
+	.irq_pending = pvr_mips_irq_pending,
+	.irq_clear = pvr_mips_irq_clear,
 	.has_fixed_data_addr = true,
 };

-- 
2.49.0


