Return-Path: <linux-kernel+bounces-190501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450A48CFF49
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686F11C222B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97D15DBC0;
	Mon, 27 May 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="TO+g9YmD"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E0015ECDC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810520; cv=none; b=t56p6ZtfTOA4F/SPBnfRjV9CRDvRgckSu3jrntZgrOHaAonTqkYmaTYdTHKvGESjqyPCiNU9jr3mGQmPxue+bGTpEtEZjZROo3dQnNPXo+9P/lmFs2PvUxoins0O29RbovKH88qsegNWCsXMsJJRckoNFSDiwfhqGgK7TXEFpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810520; c=relaxed/simple;
	bh=ELInLR+Lko8mBhGp6mtx9BtXttG/YAaRngxjpD/6AJ8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOwMGzK6BRBbAwivAP+KMyv7tUNYC13KNaAsUop3wcxKqCM2qZQFcHlc2FgrzY/P03OEB8Xd6oXLeXWKzZYtYACKZ0/IhkLCigcC8z2TdTaMHLWgOcf/kdvO/3NBh4k0EaxRUtdWEq13T2GGyJt529KURrNb1JLSjOkiBkMFJ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=TO+g9YmD; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716810481; bh=ELInLR+Lko8mBhGp6mtx9BtXttG/YAaRngxjpD/6AJ8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TO+g9YmDNR5d9xc6IMDsrO2nWnBmhVuEuI542RLxzXKGtSB2f5V2zCiQsviyNHyYA
	 4G2H/SZhLDRsvb36nUPnyzVNHq9IkGCDBcz83iNKOpTNu835vajOQVUeBNKo9MprYs
	 zErObBmnQjI4IA772p71ZtMLkv1P8SlWJ07b/vZlHO0d5FRMsMZvUF5j2qfh2XA6Ry
	 BhOxvVHP/wjTSHFZGodfd/uWkL6JE7q2Cb5XkYuB8PeucJKHJUnURxSmiiY3GS6+k6
	 3fc2bwLP5beEtCoFMInY4av7EixKGvqi4+wRivImSsPRvAvo6OcUmkF+Q7b+TPqIlp
	 +l0No5DVOYYUQ==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RBltNi1919357;
	Mon, 27 May 2024 14:47:55 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] accel/habanalabs/gaudi2: align embedded specs headers
Date: Mon, 27 May 2024 14:47:41 +0300
Message-Id: <20240527114746.1919292-4-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527114746.1919292-1-obitton@habana.ai>
References: <20240527114746.1919292-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align embedded headers to latest release.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
---
 .../habanalabs/include/gaudi2/gaudi2_fw_if.h  | 27 +++++------------
 .../include/gaudi2/gaudi2_reg_map.h           |  8 +++++
 include/linux/habanalabs/cpucp_if.h           | 10 +++++--
 include/linux/habanalabs/hl_boot_if.h         | 29 ++++++++++++++-----
 4 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/drivers/accel/habanalabs/include/gaudi2/gaudi2_fw_if.h b/drivers/accel/habanalabs/include/gaudi2/gaudi2_fw_if.h
index 18ca147b1c86..6ea936c9594e 100644
--- a/drivers/accel/habanalabs/include/gaudi2/gaudi2_fw_if.h
+++ b/drivers/accel/habanalabs/include/gaudi2/gaudi2_fw_if.h
@@ -45,6 +45,13 @@
 #define GAUDI2_ARM_RX_MB_OFFSET		(GAUDI2_ARM_RX_MB_ADDR - \
 					GAUDI2_SP_SRAM_BASE_ADDR)
 
+#define POWER_MODE_LEVELS	{	\
+	150000,		/* 00 */	\
+	250000,		/* 01 */	\
+	400000,		/* 10 */	\
+	/* 11: Normal mode */		\
+}
+
 enum gaudi2_fw_status {
 	GAUDI2_PID_STATUS_UP = 0x1,	/* PID on ARC0 is up */
 	GAUDI2_ARM_STATUS_UP = 0x2,	/* ARM Linux Boot complete */
@@ -52,26 +59,6 @@ enum gaudi2_fw_status {
 	GAUDI2_STATUS_LAST = 0xFF
 };
 
-struct gaudi2_cold_rst_data {
-	union {
-		struct {
-			u32 recovery_flag: 1;
-			u32 validation_flag: 1;
-			u32 efuse_read_flag: 1;
-			u32 spsram_init_done : 1;
-			u32 fake_security_enable : 1;
-			u32 fake_sig_validation_en : 1;
-			u32 bist_skip_enable : 1;
-			u32 reserved1 : 1;
-			u32 fake_bis_compliant : 1;
-			u32 wd_rst_cause_arm : 1;
-			u32 wd_rst_cause_arcpid : 1;
-			u32 reserved : 21;
-		};
-		__le32 data;
-	};
-};
-
 enum gaudi2_rst_src {
 	HL_COLD_RST = 1,
 	HL_MANUAL_RST = 2,
diff --git a/drivers/accel/habanalabs/include/gaudi2/gaudi2_reg_map.h b/drivers/accel/habanalabs/include/gaudi2/gaudi2_reg_map.h
index f3eaeb6d9b7e..1e9c056e437d 100644
--- a/drivers/accel/habanalabs/include/gaudi2/gaudi2_reg_map.h
+++ b/drivers/accel/habanalabs/include/gaudi2/gaudi2_reg_map.h
@@ -58,4 +58,12 @@
 #define mmWD_GPIO_DATAOUT_REG			mmPSOC_GPIO3_DATAOUT
 #define mmSTM_PROFILER_SPE_REG			mmPSOC_STM_STMSPER
 
+/* Registers below are used to pass the boot_if data between ARM and ARC1 */
+#define mmARM_MSG_BOOT_ERR_SET			mmCPU_IF_SPECIAL_GLBL_SPARE_0
+#define mmARM_MSG_BOOT_ERR_CLR			mmCPU_IF_SPECIAL_GLBL_SPARE_1
+#define mmARM_MSG_BOOT_DEV_STS_SET		mmCPU_IF_SPECIAL_GLBL_SPARE_2
+#define mmARM_MSG_BOOT_DEV_STS_CLR		mmCPU_IF_SPECIAL_GLBL_SPARE_3
+#define mmMGMT_MSG_BOOT_ERR			mmCPU_MSTR_IF_SPECIAL_GLBL_SPARE_0
+#define mmMGMT_MSG_BOOT_DEV_STS			mmCPU_MSTR_IF_SPECIAL_GLBL_SPARE_1
+
 #endif /* GAUDI2_REG_MAP_H_ */
diff --git a/include/linux/habanalabs/cpucp_if.h b/include/linux/habanalabs/cpucp_if.h
index f316c8d0f3fc..1ac1d68193e3 100644
--- a/include/linux/habanalabs/cpucp_if.h
+++ b/include/linux/habanalabs/cpucp_if.h
@@ -42,6 +42,12 @@ enum eq_event_id {
 	EQ_EVENT_PWR_BRK_ENTRY,
 	EQ_EVENT_PWR_BRK_EXIT,
 	EQ_EVENT_HEARTBEAT,
+	EQ_EVENT_CPLD_RESET_REASON,
+	EQ_EVENT_CPLD_SHUTDOWN,
+	EQ_EVENT_POWER_EVT_START,
+	EQ_EVENT_POWER_EVT_END,
+	EQ_EVENT_THERMAL_EVT_START,
+	EQ_EVENT_THERMAL_EVT_END,
 };
 
 /*
@@ -1165,7 +1171,7 @@ struct cpucp_security_info {
 struct cpucp_info {
 	struct cpucp_sensor sensors[CPUCP_MAX_SENSORS];
 	__u8 kernel_version[VERSION_MAX_LEN];
-	__le32 reserved;
+	__le32 reserved1;
 	__le32 card_type;
 	__le32 card_location;
 	__le32 cpld_version;
@@ -1187,7 +1193,7 @@ struct cpucp_info {
 	__u8 substrate_version;
 	__u8 eq_health_check_supported;
 	struct cpucp_security_info sec_info;
-	__le32 fw_hbm_region_size;
+	__le32 reserved2;
 	__u8 pll_map[PLL_MAP_LEN];
 	__le64 mme_binning_mask;
 	__u8 fw_os_version[VERSION_MAX_LEN];
diff --git a/include/linux/habanalabs/hl_boot_if.h b/include/linux/habanalabs/hl_boot_if.h
index 93366d5621fd..d2a9fc96424b 100644
--- a/include/linux/habanalabs/hl_boot_if.h
+++ b/include/linux/habanalabs/hl_boot_if.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2018-2020 HabanaLabs, Ltd.
+ * Copyright 2018-2023 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -49,7 +49,6 @@ enum cpu_boot_err {
 #define CPU_BOOT_ERR_FATAL_MASK					\
 		((1 << CPU_BOOT_ERR_DRAM_INIT_FAIL) |		\
 		 (1 << CPU_BOOT_ERR_PLL_FAIL) |			\
-		 (1 << CPU_BOOT_ERR_DEVICE_UNUSABLE_FAIL) |	\
 		 (1 << CPU_BOOT_ERR_BINNING_FAIL) |		\
 		 (1 << CPU_BOOT_ERR_DRAM_SKIPPED) |		\
 		 (1 << CPU_BOOT_ERR_ENG_ARC_MEM_SCRUB_FAIL) |	\
@@ -194,6 +193,8 @@ enum cpu_boot_dev_sts {
 	CPU_BOOT_DEV_STS_FW_NIC_STAT_EXT_EN = 24,
 	CPU_BOOT_DEV_STS_IS_IDLE_CHECK_EN = 25,
 	CPU_BOOT_DEV_STS_MAP_HWMON_EN = 26,
+	CPU_BOOT_DEV_STS_NIC_MEM_CLEAR_EN = 27,
+	CPU_BOOT_DEV_STS_MMU_PGTBL_DRAM_EN = 28,
 	CPU_BOOT_DEV_STS_ENABLED = 31,
 	CPU_BOOT_DEV_STS_SCND_EN = 63,
 	CPU_BOOT_DEV_STS_LAST = 64 /* we have 2 registers of 32 bits */
@@ -331,6 +332,17 @@ enum cpu_boot_dev_sts {
  *					HWMON enum mapping to cpucp enums.
  *					Initialized in: linux
  *
+ * CPU_BOOT_DEV_STS0_NIC_MEM_CLEAR_EN
+ *					If set, means f/w supports nic hbm memory clear and
+ *					tmr,txs hbm memory init.
+ *					Initialized in: zephyr-mgmt
+ *
+ * CPU_BOOT_DEV_STS_MMU_PGTBL_DRAM_EN
+ *					MMU page tables are located in DRAM.
+ *					F/W initializes security settings for MMU
+ *					page tables to reside in DRAM.
+ *					Initialized in: zephyr-mgmt
+ *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
  *					running FW populates the device status
@@ -367,6 +379,8 @@ enum cpu_boot_dev_sts {
 #define CPU_BOOT_DEV_STS0_FW_NIC_STAT_EXT_EN	(1 << CPU_BOOT_DEV_STS_FW_NIC_STAT_EXT_EN)
 #define CPU_BOOT_DEV_STS0_IS_IDLE_CHECK_EN	(1 << CPU_BOOT_DEV_STS_IS_IDLE_CHECK_EN)
 #define CPU_BOOT_DEV_STS0_MAP_HWMON_EN		(1 << CPU_BOOT_DEV_STS_MAP_HWMON_EN)
+#define CPU_BOOT_DEV_STS0_NIC_MEM_CLEAR_EN	(1 << CPU_BOOT_DEV_STS_NIC_MEM_CLEAR_EN)
+#define CPU_BOOT_DEV_STS0_MMU_PGTBL_DRAM_EN	(1 << CPU_BOOT_DEV_STS_MMU_PGTBL_DRAM_EN)
 #define CPU_BOOT_DEV_STS0_ENABLED		(1 << CPU_BOOT_DEV_STS_ENABLED)
 #define CPU_BOOT_DEV_STS1_ENABLED		(1 << CPU_BOOT_DEV_STS_ENABLED)
 
@@ -450,11 +464,11 @@ struct cpu_dyn_regs {
 	__le32 gic_dma_core_irq_ctrl;
 	__le32 gic_host_halt_irq;
 	__le32 gic_host_ints_irq;
-	__le32 gic_host_soft_rst_irq;
+	__le32 reserved0;
 	__le32 gic_rot_qm_irq_ctrl;
-	__le32 cpu_rst_status;
+	__le32 reserved1;
 	__le32 eng_arc_irq_ctrl;
-	__le32 reserved1[20];		/* reserve for future use */
+	__le32 reserved2[20];		/* reserve for future use */
 };
 
 /* TODO: remove the desc magic after the code is updated to use message */
@@ -551,8 +565,9 @@ enum lkd_fw_ascii_msg_lvls {
 	LKD_FW_ASCII_MSG_DBG = 3,
 };
 
-#define LKD_FW_ASCII_MSG_MAX_LEN	128
-#define LKD_FW_ASCII_MSG_MAX		4	/* consider ABI when changing */
+#define LKD_FW_ASCII_MSG_MAX_LEN		128
+#define LKD_FW_ASCII_MSG_MAX			4	/* consider ABI when changing */
+#define LKD_FW_ASCII_MSG_MIN_DESC_VERSION	3
 
 struct lkd_fw_ascii_msg {
 	__u8 valid;
-- 
2.34.1


