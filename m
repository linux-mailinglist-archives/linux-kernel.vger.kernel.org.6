Return-Path: <linux-kernel+bounces-559597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE91DA5F5F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B8317DC42
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2C267713;
	Thu, 13 Mar 2025 13:26:14 +0000 (UTC)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020104.outbound.protection.outlook.com [52.101.128.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936772676C1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872373; cv=fail; b=VdSZZBpdpekC4EXzAMVCwtvmAJlYLABlad7Ua1G6142J/ibUKx4xrfXLoMY0f9B+wxHWQRFCpeFAqZlOd1hPjvg9ROJQU0x3xhnWqZlh2tSApRWT6Tb4ZsjX7TuN66b7uoMEivl+Ezn9hiP2/eEaWYSvvnXDlJu69M3PWXQYwVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872373; c=relaxed/simple;
	bh=76Qu0yJEBfVe7f54bZ2TgSJwsAvjoCx/BAJrPIaXXRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CuyLV65oMNprAoGmUlC+GUF+rluAfXVV51flvJX2ZpmCrhSZP+CY9ADZEkJW1p/PckkyXI8KqVp3ELQfAERd8rFpZm06ikIQlKlkO2K2vgPbI0TjZ7Bm7a49cFE5svO4it9TrtGfuD0ltwtLXfuHrP8T/4NkR67fk16oLUumUdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.128.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jULo+2bp6dmDBNpwuyBFxsZTqKH3espYDlYdpun5Vg69Xt84K69Do7rWw2D52lMJ1dKsUMPVfDLfJU3CGWX6PTHP3dZHvNHjKnS/5HN62AAHQfACfWnzLiA/6RNq4VNscNcBlj3ESvFv/OP3+5L5tUb69Ul68BHZ5HzCzgjqNuApylWKuuFqd9W6Nb8pKT521kgAUj682C8WUMsE5XcYLMvo0V5Juhw+L7j9Tum4QlfOPEOB/+STSyHA1y2Wg50kjFyP5NKzogUqCjVm1PDo+5BecyR2ZYvMFttDrxxgTptS1cRp1RU08CxXRhZrhB3rBTnFwaJf8FLjsRYt6dVcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HS+j5V8U026IQCUCEyIl6vOWbI9QhIHoiB038vyhvE=;
 b=EMCR1f9jajSdQlhr8El7o02W3GrU2V2jhFPnZoHH13SuBpwMwAFXwpSA88yKQZjR4xjQBKTTg7VM/mbSeLeExQbeHIHhUWvVFFaX89T/ua7ffvk7BhL/e1OoWACFPEENlTpY3HowZzdluCRAi42+ytVJY6wOPha+wey44X7DIRdtVDWnzf00EHvCL74j3MvWVhDIfLFAg8FICVBF8RRYzu8BYfAamZB9BOz7PGLfCh64dVSaFpjaXh15YxE4r/NQbz/Aoe8zTEhUkQHXphGHBV/GGO1sXW55kBcmRDHy5w8yvlWA/ht8abTQcYYKXZoOGuhaIqP+yvzVaXf0+oSKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0024.apcprd02.prod.outlook.com (2603:1096:3:17::36) by
 SEZPR06MB5173.apcprd06.prod.outlook.com (2603:1096:101:71::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Thu, 13 Mar 2025 13:26:02 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:3:17:cafe::8c) by SG2PR02CA0024.outlook.office365.com
 (2603:1096:3:17::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 13:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 13:26:01 +0000
Received: from gchen.. (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id BADF541C0A00;
	Thu, 13 Mar 2025 21:26:00 +0800 (CST)
From: Guomin Chen <guomin.chen@cixtech.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	Guomin Chen <Guomin.Chen@cixtech.com>,
	Peter Chen <peter.chen@cixtech.com>,
	Lihua Liu <Lihua.Liu@cixtech.com>
Subject: [PATCH 2/2] mailbox: cix: add Cixtech mailbox driver
Date: Thu, 13 Mar 2025 13:26:00 +0000
Message-Id: <20250313132600.742502-1-guomin.chen@cixtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|SEZPR06MB5173:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: da8a96f8-9bb8-4dc3-890a-08dd62329979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TH9kehyKgZOVh5ZthXr5gloZAgcouYJFTfcbBFmI027EKwOsq9psp7SlgZdi?=
 =?us-ascii?Q?wvQDKj4pE+2jL40MFVKsmdbHoMg5yThl3aGxXajx++iqd3j6jqsHNuRDiSpN?=
 =?us-ascii?Q?pNu8ul9SW2jSE4Vlluv9LgZ7Ls2yoa2UGvr+ifVnAfcOwQB4WMTMHNUYFwFh?=
 =?us-ascii?Q?w6v4FxrhfE/Nx/iCnvPkz+5TBpEuwF+6STBydy9hfThI6AZUA0HxNITuuVeg?=
 =?us-ascii?Q?1tr+C2sQ6hOQgzJRAnZLVyAperkE6IiJR6yPUx7aUf+34tkajjOXOI8LUY55?=
 =?us-ascii?Q?MZKkDw5Jy3w9IPbTt4iUMv6M0Sd6XzjzDpGfKW1p+NQqqy6Na/rsh2xCEtoZ?=
 =?us-ascii?Q?XbYCgc2Dq0UI+Z94JvaG650GNgSs9XlU64Ba/mueYENFcFe0rRmylciPTb60?=
 =?us-ascii?Q?a4zWL356JCkkyyRwVkJvTDZZiywTcj1RcYiLDVfhFguv23WRDFvJIsexLy39?=
 =?us-ascii?Q?WzfIcZOKNCD9zxBpmZf3DziItaQafFi8+E+3Vlyt1x5H7IAAX5f5FKPvNfc8?=
 =?us-ascii?Q?yDvSJpPS5sHs+vpWQ0+aHmprGgU0MwmcP3ScU1AI5bUznwb9heSiECc0ow8j?=
 =?us-ascii?Q?O7kBhRf8IQ6MZD2QMjJpGNtWOaAlg2mF/4bWtCF03rOAJnjKQh+m+27yUQwY?=
 =?us-ascii?Q?Tc86iqUPi+5BJz5xxZj1asoQSVfa77z9JzZ7hI0KMdf8na5u3Db9eZ+9aigC?=
 =?us-ascii?Q?Rhn4wH6jSYx/IqIffRPaAMwan8G53TzFTXqs8CV7Jp+RfItfp6qzIR8NJc7k?=
 =?us-ascii?Q?waOm3HAzLfdQ44mRZgYkUM/PJdZtH72YQMwgF9v3hi7vRQBh0lj1w+HClbb8?=
 =?us-ascii?Q?fIiJnkH63ConFsHov3w3WqKEPTJAC3mpru3ZSGNR0kEu/tYnqBGF7xvg2kF9?=
 =?us-ascii?Q?vBJAN+H0/pmnSF0BC0K5PbGW7b1vPH5dFpbXnVWasHxM8eCKIuWGGfPhL9A/?=
 =?us-ascii?Q?IC/z89i1GpsE+PkCfS3dFcXu9RnR+bVhUZzO208oC93seg7qqwYetAHxFv3s?=
 =?us-ascii?Q?isJ6KfW5mYIub3zLRMm8aGf6sLit+eQ6cFL31HC2M/xuXz3X45f1sOYjDSa9?=
 =?us-ascii?Q?jGlZJwrgcURvb2MT+H96g8xnwctmXhmz+JGfTkkpMqFGV0aCwfCdxzgxBXLO?=
 =?us-ascii?Q?UORpYlldI68bB/Jl0rz8Z85dk35XtsLM/EhNGzbCclDKvgXB+Vldhwd0XF0e?=
 =?us-ascii?Q?LUkXYCaQ4SrHjy21h6wtAV3x8nnuQmAzHdinSqg+slq0Ck2hhdf5WxZgezHD?=
 =?us-ascii?Q?7Lc6OrMC4mmSPP8MvCsIs1BPxhfzec60mwMagA4FrrCxN2WhpylhUxAzZ+nJ?=
 =?us-ascii?Q?lY8BjYi3Rs/SF4UiKiBvlsXqiw3qMGTIImhsiljqcM1ry81sdhhbYeeegUv3?=
 =?us-ascii?Q?ayThgR54bzTvzGnOEugcfB115opQdnNvUz8EGHVwvFnjePLreBN11Xb0ZKQN?=
 =?us-ascii?Q?pszmgd03ZW+85bZIIbGWqrn2DJlSv6zkflcV1OW4SP6pk497tEfQ/UAqC05M?=
 =?us-ascii?Q?sjd0qUY1uZiva6w=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:26:01.7369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da8a96f8-9bb8-4dc3-890a-08dd62329979
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5173

From: Guomin Chen <Guomin.Chen@cixtech.com>

This commit adds a driver for the Cixtech mailbox controller.
Cixtech mailbox controller is used to exchange message within
multiple processors, such as AP, AUDIO DSP, SensorHub MCU,
etc. It support 10 mailbox channels with different operating
mode and every channel is unidirectional.

Reviewed-by: Peter Chen <peter.chen@cixtech.com>
Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
---
 drivers/mailbox/Kconfig       |  10 +
 drivers/mailbox/Makefile      |   2 +
 drivers/mailbox/cix-mailbox.c | 633 ++++++++++++++++++++++++++++++++++
 3 files changed, 645 insertions(+)
 create mode 100644 drivers/mailbox/cix-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index ed52db272f4d..d155ba5150f1 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -330,4 +330,14 @@ config THEAD_TH1520_MBOX
 	  kernel is running, and E902 core used for power management among other
 	  things.
 
+config CIX_MBOX
+        tristate "CIX Mailbox"
+        depends on ARCH_CIX || COMPILE_TEST
+        depends on OF
+        help
+          Mailbox implementation for CIX IPC system. The controller supports
+          10 mailbox channels with different operating mode and every channel
+          is unidirectional. Say Y here if you want to use the CIX Mailbox
+          support.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 9a1542b55539..97a5a7068c10 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -70,3 +70,5 @@ obj-$(CONFIG_QCOM_CPUCP_MBOX)	+= qcom-cpucp-mbox.o
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
 
 obj-$(CONFIG_THEAD_TH1520_MBOX)	+= mailbox-th1520.o
+
+obj-$(CONFIG_CIX_MBOX)	+= cix-mailbox.o
diff --git a/drivers/mailbox/cix-mailbox.c b/drivers/mailbox/cix-mailbox.c
new file mode 100644
index 000000000000..28748f02c192
--- /dev/null
+++ b/drivers/mailbox/cix-mailbox.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Cix Technology Group Co., Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "mailbox.h"
+
+/* Register define */
+#define REG_MSG(n)		(0x0 + 0x4*(n)) /* 0x0~0x7c */
+#define REG_DB_ACK		REG_MSG(CIX_MBOX_MSG_LEN) /* 0x80 */
+#define ERR_COMP		(REG_DB_ACK + 0x4) /* 0x84 */
+#define ERR_COMP_CLR		(REG_DB_ACK + 0x8) /* 0x88 */
+#define REG_F_INT(IDX)		(ERR_COMP_CLR + 0x4*(IDX+1)) /* 0x8c~0xa8 */
+#define FIFO_WR			(REG_F_INT(MBOX_FAST_IDX+1)) /* 0xac */
+#define FIFO_RD			(FIFO_WR + 0x4) /* 0xb0 */
+#define FIFO_STAS		(FIFO_WR + 0x8) /* 0xb4 */
+#define FIFO_WM			(FIFO_WR + 0xc) /* 0xb8 */
+#define INT_ENABLE		(FIFO_WR + 0x10) /* 0xbc */
+#define INT_ENABLE_SIDE_B	(FIFO_WR + 0x14) /* 0xc0 */
+#define INT_CLEAR		(FIFO_WR + 0x18) /* 0xc4 */
+#define INT_STATUS		(FIFO_WR + 0x1c) /* 0xc8 */
+#define FIFO_RST		(FIFO_WR + 0x20) /* 0xcc */
+
+/* [0~7] Fast channel
+ * [8] doorbell base channel
+ * [9]fifo base channel
+ * [10] register base channel
+ */
+#define CIX_MBOX_CHANS		(11)
+
+/*
+ * The maximum transmission size is 32 words or 128 bytes.
+ */
+#define CIX_MBOX_MSG_LEN	(32)  /* Max length = 32 words */
+#define MBOX_MSG_LEN_MASK	(0x7fL) /* Max length = 128 bytes */
+
+#define MBOX_FAST_IDX		(7)
+#define MBOX_DB_IDX		(8)
+#define MBOX_FIFO_IDX		(9)
+#define MBOX_REG_IDX		(10)
+
+#define MBOX_TX			(0)
+#define MBOX_RX			(1)
+
+#define DB_INT_BIT		BIT(0)
+#define DB_ACK_INT_BIT		BIT(1)
+
+#define FIFO_WM_DEFAULT		CIX_MBOX_MSG_LEN
+#define FIFO_STAS_WMK		BIT(0)
+#define FIFO_STAS_FULL		BIT(1)
+#define FIFO_STAS_EMPTY		BIT(2)
+#define FIFO_STAS_UFLOW		BIT(3)
+#define FIFO_STAS_OFLOW		BIT(4)
+
+#define FIFO_RST_BIT		BIT(0)
+
+#define DB_INT			BIT(0)
+#define ACK_INT			BIT(1)
+#define FIFO_FULL_INT		BIT(2)
+#define FIFO_EMPTY_INT		BIT(3)
+#define FIFO_WM01_INT		BIT(4)
+#define FIFO_WM10_INT		BIT(5)
+#define FIFO_OFLOW_INT		BIT(6)
+#define FIFO_UFLOW_INT		BIT(7)
+#define FIFO_N_EMPTY_INT	BIT(8)
+#define FAST_CH_INT(IDX)	BIT((IDX)+9)
+
+enum cix_mbox_chan_type {
+	CIX_MBOX_TYPE_DB,
+	CIX_MBOX_TYPE_REG,
+	CIX_MBOX_TYPE_FIFO,
+	CIX_MBOX_TYPE_FAST,
+};
+
+struct cix_mbox_con_priv {
+	enum cix_mbox_chan_type type;
+	struct mbox_chan    *chan;
+	int index;
+};
+
+struct cix_mbox_priv {
+	struct device *dev;
+	int irq;
+	int dir;
+	bool tx_irq_mode; /* flag of enabling tx's irq mode */
+	void __iomem *base; /* region for mailbox */
+	unsigned int chan_num;
+	struct cix_mbox_con_priv con_priv[CIX_MBOX_CHANS];
+	struct mbox_chan mbox_chans[CIX_MBOX_CHANS];
+	struct mbox_controller mbox;
+};
+
+/*
+ * The CIX mailbox supports four types of transfers:
+ * CIX_MBOX_TYPE_DB, CIX_MBOX_TYPE_FAST, CIX_MBOX_TYPE_REG, and CIX_MBOX_TYPE_FIFO.
+ * For the REG and FIFO types of transfers, the message format is as follows:
+ */
+union cix_mbox_msg_reg_fifo {
+	u32 length; /* unit is byte */
+	u32 buf[CIX_MBOX_MSG_LEN]; /* buf[0] must be the byte length of this array */
+};
+
+static struct cix_mbox_priv *to_cix_mbox_priv(struct mbox_controller *mbox)
+{
+	return container_of(mbox, struct cix_mbox_priv, mbox);
+}
+
+static void cix_mbox_write(struct cix_mbox_priv *priv, u32 val, u32 offset)
+{
+	iowrite32(val, priv->base + offset);
+}
+
+static u32 cix_mbox_read(struct cix_mbox_priv *priv, u32 offset)
+{
+	return ioread32(priv->base + offset);
+}
+
+static bool mbox_fifo_empty(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+
+	return ((cix_mbox_read(priv, FIFO_STAS) & FIFO_STAS_EMPTY) ? true : false);
+}
+
+/*
+ *The transmission unit of the CIX mailbox is word.
+ *The byte length should be converted into the word length.
+ */
+static inline u32 mbox_get_msg_size(void *msg)
+{
+	u32 len;
+
+	len = ((u32 *)msg)[0] & MBOX_MSG_LEN_MASK;
+	return DIV_ROUND_UP(len, 4);
+}
+
+static int cix_mbox_send_data_db(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+
+	/* trigger doorbell irq */
+	cix_mbox_write(priv, DB_INT_BIT, REG_DB_ACK);
+
+	return 0;
+}
+
+static int cix_mbox_send_data_reg(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	int i;
+	union cix_mbox_msg_reg_fifo *msg = data;
+	u32 len;
+
+	if (!data)
+		return -EINVAL;
+
+	len = mbox_get_msg_size(data);
+	for (i = 0; i < len; i++)
+		cix_mbox_write(priv, msg->buf[i], REG_MSG(i));
+
+	/* trigger doorbell irq */
+	cix_mbox_write(priv, DB_INT_BIT, REG_DB_ACK);
+
+	return 0;
+}
+
+static int cix_mbox_send_data_fifo(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	int i;
+	union cix_mbox_msg_reg_fifo *msg = data;
+	u32 len, val_32;
+
+	if (!data)
+		return -EINVAL;
+
+	len = mbox_get_msg_size(data);
+	cix_mbox_write(priv, len, FIFO_WM);
+	for (i = 0; i < len; i++)
+		cix_mbox_write(priv, msg->buf[i], FIFO_WR);
+
+	/* Enable fifo empty interrupt */
+	val_32 = cix_mbox_read(priv, INT_ENABLE);
+	val_32 |= FIFO_EMPTY_INT;
+	cix_mbox_write(priv, val_32, INT_ENABLE);
+
+	return 0;
+}
+
+static int cix_mbox_send_data_fast(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+	u32 *arg = (u32 *)data;
+	int index = cp->index;
+
+	if (!data)
+		return -EINVAL;
+
+	if (index < 0 || index > MBOX_FAST_IDX) {
+		dev_err(priv->dev, "Invalid Mbox index %d\n", index);
+		return -EINVAL;
+	}
+
+	cix_mbox_write(priv, arg[0], REG_F_INT(index));
+
+	return 0;
+}
+
+static int cix_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+
+	if (priv->dir != MBOX_TX) {
+		dev_err(priv->dev, "Invalid Mbox dir %d\n", priv->dir);
+		return -EINVAL;
+	}
+
+	switch (cp->type) {
+	case CIX_MBOX_TYPE_DB:
+		cix_mbox_send_data_db(chan, data);
+		break;
+	case CIX_MBOX_TYPE_REG:
+		cix_mbox_send_data_reg(chan, data);
+		break;
+	case CIX_MBOX_TYPE_FIFO:
+		cix_mbox_send_data_fifo(chan, data);
+		break;
+	case CIX_MBOX_TYPE_FAST:
+		cix_mbox_send_data_fast(chan, data);
+		break;
+	default:
+		dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void cix_mbox_isr_db(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	u32 int_status;
+
+	int_status = cix_mbox_read(priv, INT_STATUS);
+
+	if (priv->dir == MBOX_RX) {
+		/* rx interrupt is triggered */
+		if (int_status & DB_INT) {
+			cix_mbox_write(priv, DB_INT, INT_CLEAR);
+			mbox_chan_received_data(chan, NULL);
+			/* trigger ack interrupt */
+			cix_mbox_write(priv, DB_ACK_INT_BIT, REG_DB_ACK);
+		}
+	} else {
+		/* tx ack interrupt is triggered */
+		if (int_status & ACK_INT) {
+			cix_mbox_write(priv, ACK_INT, INT_CLEAR);
+			mbox_chan_received_data(chan, NULL);
+		}
+	}
+}
+
+static void cix_mbox_isr_reg(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	u32 int_status;
+	u32 data[CIX_MBOX_MSG_LEN];
+	int i;
+	u32 len;
+
+	int_status = cix_mbox_read(priv, INT_STATUS);
+
+	if (priv->dir == MBOX_RX) {
+		/* rx interrupt is triggered */
+		if (int_status & DB_INT) {
+			cix_mbox_write(priv, DB_INT, INT_CLEAR);
+			data[0] = cix_mbox_read(priv, REG_MSG(0));
+			len = mbox_get_msg_size(data);
+			for (i = 0; i < len; i++)
+				data[i] = cix_mbox_read(priv, REG_MSG(i));
+
+			/* trigger ack interrupt */
+			cix_mbox_write(priv, DB_ACK_INT_BIT, REG_DB_ACK);
+			mbox_chan_received_data(chan, data);
+		}
+	} else {
+		/* tx ack interrupt is triggered */
+		if (int_status & ACK_INT) {
+			cix_mbox_write(priv, ACK_INT, INT_CLEAR);
+			mbox_chan_txdone(chan, 0);
+		}
+	}
+}
+
+static void cix_mbox_isr_fifo(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	u32 data[CIX_MBOX_MSG_LEN] = { 0 };
+	int i = 0;
+	u32 int_status, status, val_32;
+
+	int_status = cix_mbox_read(priv, INT_STATUS);
+
+	if (priv->dir == MBOX_RX) {
+		/* FIFO waterMark interrupt is generated */
+		if (int_status & (FIFO_FULL_INT | FIFO_WM01_INT)) {
+			cix_mbox_write(priv, (FIFO_FULL_INT | FIFO_WM01_INT), INT_CLEAR);
+			do {
+				data[i++] = cix_mbox_read(priv, FIFO_RD);
+			} while (!mbox_fifo_empty(chan) && i < CIX_MBOX_MSG_LEN);
+			mbox_chan_received_data(chan, data);
+		}
+		/* FIFO underflow is generated */
+		if (int_status & FIFO_UFLOW_INT) {
+			status = cix_mbox_read(priv, FIFO_STAS);
+			dev_err(priv->dev,
+				"fifo underflow: int_stats %d\n",
+				status);
+			cix_mbox_write(priv, FIFO_UFLOW_INT, INT_CLEAR);
+		}
+	} else {
+		/* FIFO empty interrupt is generated */
+		if (int_status & FIFO_EMPTY_INT) {
+			cix_mbox_write(priv, FIFO_EMPTY_INT, INT_CLEAR);
+			/* Disable empty irq*/
+			val_32 = cix_mbox_read(priv, INT_ENABLE);
+			val_32 &= ~FIFO_EMPTY_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE);
+			mbox_chan_txdone(chan, 0);
+		}
+		/* FIFO overflow is generated */
+		if (int_status & FIFO_OFLOW_INT) {
+			status = cix_mbox_read(priv, FIFO_STAS);
+			dev_err(priv->dev,
+				"fifo overlow: int_stats %d\n",
+				status);
+			cix_mbox_write(priv, FIFO_OFLOW_INT, INT_CLEAR);
+		}
+	}
+}
+
+static void cix_mbox_isr_fast(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+	u32 int_status, data;
+
+	/* no irq will be trigger for TX dir mbox */
+	if (priv->dir != MBOX_RX)
+		return;
+
+	int_status = cix_mbox_read(priv, INT_STATUS);
+
+	if (int_status & FAST_CH_INT(cp->index)) {
+		cix_mbox_write(priv,
+			       FAST_CH_INT(cp->index),
+			       INT_CLEAR);
+		data = cix_mbox_read(priv, REG_F_INT(cp->index));
+		mbox_chan_received_data(chan, &data);
+	}
+}
+
+static irqreturn_t cix_mbox_isr(int irq, void *arg)
+{
+	struct mbox_chan *chan = arg;
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+
+	switch (cp->type) {
+	case CIX_MBOX_TYPE_DB:
+		cix_mbox_isr_db(chan);
+		break;
+	case CIX_MBOX_TYPE_REG:
+		cix_mbox_isr_reg(chan);
+		break;
+	case CIX_MBOX_TYPE_FIFO:
+		cix_mbox_isr_fifo(chan);
+		break;
+	case CIX_MBOX_TYPE_FAST:
+		cix_mbox_isr_fast(chan);
+		break;
+	default:
+		dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int cix_mbox_startup(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+	int ret;
+	int index = cp->index;
+	u32 val_32;
+
+	ret = request_irq(priv->irq, cix_mbox_isr, 0,
+			  dev_name(priv->dev), chan);
+	if (ret) {
+		dev_err(priv->dev,
+			"Unable to acquire IRQ %d\n",
+			priv->irq);
+		return ret;
+	}
+
+	dev_info(priv->dev, "%s, irq %d, dir %d, type %d, index %d\n",
+		 __func__, priv->irq, priv->dir, cp->type, cp->index);
+
+	switch (cp->type) {
+	case CIX_MBOX_TYPE_DB:
+		/* Overwrite txdone_method for DB channel */
+		chan->txdone_method = TXDONE_BY_ACK;
+		fallthrough;
+	case CIX_MBOX_TYPE_REG:
+		if (priv->dir == MBOX_TX) {
+			/* Enable ACK interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE);
+			val_32 |= ACK_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE);
+		} else {
+			/* Enable Doorbell interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 |= DB_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FIFO:
+		/* reset fifo */
+		cix_mbox_write(priv, FIFO_RST_BIT, FIFO_RST);
+		/* set default watermark */
+		cix_mbox_write(priv, FIFO_WM_DEFAULT, FIFO_WM);
+		if (priv->dir == MBOX_TX) {
+			/* Enable fifo overflow interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE);
+			val_32 |= FIFO_OFLOW_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE);
+		} else {
+			/* Enable fifo full/underflow interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 |= FIFO_UFLOW_INT|FIFO_WM01_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FAST:
+		/* Only RX channel has intterupt */
+		if (priv->dir == MBOX_RX) {
+			if (index < 0 || index > MBOX_FAST_IDX) {
+				dev_err(priv->dev,
+					"Invalid index %d\n", index);
+				return ret;
+			}
+			/* enable fast channel interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 |= FAST_CH_INT(index);
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
+		}
+		break;
+	default:
+		dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void cix_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+	u32 val_32;
+	int index = cp->index;
+
+	switch (cp->type) {
+	case CIX_MBOX_TYPE_DB:
+	case CIX_MBOX_TYPE_REG:
+		if (priv->dir == MBOX_TX) {
+			/* Disable ACK interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE);
+			val_32 &= ~ACK_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE);
+		} else if (priv->dir == MBOX_RX) {
+			/* Disable Doorbell interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 &= ~DB_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FIFO:
+		if (priv->dir == MBOX_TX) {
+			/* Disable empty/fifo overflow irq*/
+			val_32 = cix_mbox_read(priv, INT_ENABLE);
+			val_32 &= ~(FIFO_EMPTY_INT | FIFO_OFLOW_INT);
+			cix_mbox_write(priv, val_32, INT_ENABLE);
+		} else if (priv->dir == MBOX_RX) {
+			/* Disable fifo WM01/underflow interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 &= ~(FIFO_UFLOW_INT | FIFO_WM01_INT);
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FAST:
+		if (priv->dir == MBOX_RX) {
+			if (index < 0 || index > MBOX_FAST_IDX) {
+				dev_err(priv->dev,
+					"Invalid index %d\n", index);
+				break;
+			}
+			/* Disable fast channel interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 &= ~FAST_CH_INT(index);
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
+		}
+		break;
+
+	default:
+		dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
+		break;
+	}
+
+	free_irq(priv->irq, chan);
+}
+
+static const struct mbox_chan_ops cix_mbox_chan_ops = {
+	.send_data = cix_mbox_send_data,
+	.startup = cix_mbox_startup,
+	.shutdown = cix_mbox_shutdown,
+};
+
+static void cix_mbox_init(struct cix_mbox_priv *priv)
+{
+	int i;
+	struct cix_mbox_con_priv *cp;
+
+	for (i = 0; i < CIX_MBOX_CHANS; i++) {
+		cp = &priv->con_priv[i];
+		cp->index = i;
+		cp->chan = &priv->mbox_chans[i];
+		priv->mbox_chans[i].con_priv = cp;
+		if (cp->index <= MBOX_FAST_IDX)
+			cp->type = CIX_MBOX_TYPE_FAST;
+		if (cp->index == MBOX_DB_IDX)
+			cp->type = CIX_MBOX_TYPE_DB;
+		if (cp->index == MBOX_FIFO_IDX)
+			cp->type = CIX_MBOX_TYPE_FIFO;
+		if (cp->index == MBOX_REG_IDX)
+			cp->type = CIX_MBOX_TYPE_REG;
+	}
+}
+
+static int cix_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cix_mbox_priv *priv;
+	int ret;
+	u32 dir;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return priv->irq;
+
+	if (device_property_read_u32(dev, "cix,mbox-dir", &dir)) {
+		dev_err(priv->dev, "cix,mbox_dir property not found\n");
+		return -EINVAL;
+	}
+
+	if ((dir != MBOX_TX)
+	    && (dir != MBOX_RX)) {
+		dev_err(priv->dev, "Dir value is not expected! dir %d\n", dir);
+		return -EINVAL;
+	}
+
+	cix_mbox_init(priv);
+
+	priv->dir = (int)dir;
+	priv->mbox.dev = dev;
+	priv->mbox.ops = &cix_mbox_chan_ops;
+	priv->mbox.chans = priv->mbox_chans;
+	priv->mbox.txdone_irq = true;
+	priv->mbox.num_chans = CIX_MBOX_CHANS;
+	priv->mbox.of_xlate = NULL;
+	dev_info(priv->dev, "%s, irq %d, dir %d\n",
+		 __func__, priv->irq, priv->dir);
+
+	platform_set_drvdata(pdev, priv);
+	ret = devm_mbox_controller_register(dev, &priv->mbox);
+	if (ret)
+		dev_err(dev, "Failed to register mailbox %d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id cix_mbox_dt_ids[] = {
+	{ .compatible = "cix,sky1-mbox" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cix_mbox_dt_ids);
+
+static struct platform_driver cix_mbox_driver = {
+	.probe = cix_mbox_probe,
+	.driver = {
+		.name = "cix_mbox",
+		.of_match_table = cix_mbox_dt_ids,
+	},
+};
+
+static int __init cix_mailbox_init(void)
+{
+	return platform_driver_register(&cix_mbox_driver);
+}
+arch_initcall(cix_mailbox_init);
+
+MODULE_AUTHOR("Cix Technology Group Co., Ltd.");
+MODULE_DESCRIPTION("CIX mailbox driver");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1


