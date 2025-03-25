Return-Path: <linux-kernel+bounces-575093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD5EA6ED78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160531895B32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B1A1DE8B4;
	Tue, 25 Mar 2025 10:18:21 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B63725485D;
	Tue, 25 Mar 2025 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897899; cv=fail; b=dKuuiXCltGD88XJ5D3Xk0qT+jQ1aZ7dsrdm44LUNpda4KUUcoJL2ZHGm3iATclSi2Lo5r4RPiQqFUoym4mnFztnz0K8MmFNVBHJ6mXiQI7Yfi2Eso5MysKsg3KZK3hIfreTr70uMYN4uSfnrU0cD56FghFlLImDtQDs2maGCWFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897899; c=relaxed/simple;
	bh=tuqTXD0+ocBcxc9+OfQ92COGjlIp3uTQBTmu8E7Vgmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWjyAjCY3TwkJY9zk2Ig6pLiTAHbuqd99hl8m2uAFFM2PmmqFNPblCExkaX6qLTbV38B2QnaV1IzFolvOHz5i9HerVuqzz0dlOI1BLdiIuAzFIdnj/6WMgQ09FVM6maiNuwM5NevzyegfwekoSDVh02y3Qixhz0nb125ZPppA3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9Q4hh5mzC5y6cZwWDU0bmL0YYZcPVSipzGvy64L2YUUxqIUq+DqSW3oQcs/T7fyZWUnvuS3k3SKCkrlYCGN4HyaJRpL5X+3Pa7ovM572rRXkwYO3gQGm8nIEmSxP4KNp7Dc6F9lWSqLF7abPKGi/q1/PfyczrZmoPBW0RG8dGttAw6tlkQ9qC/9MMK0oEIWLpnRTBnxiQZnerQJnK6C7rNWjzqtB0Hw9O+WjULMdLu6DgM1zXGCtts45du3RyUo5Ysgul5ZFH9GNFXYuR9oG4wKkuPFombrGw3UMA6mKqA8ayIF0ajNZoCNsGjLQRl8XoIwhUMS2A9I3nHWRGYSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uapK5Ugw6JG1TPMZYFtvopk7a3ug2Und82hGpojZ9Ac=;
 b=SfZ/OG7eB1StgQHaEBcAPjaTqrQdzQLfBCKTR7TC3byPzYOT9X4a+CQthTpUUqMd0c743F7sMPDa+jgkh731MbO3CAPTMHIgs5uVeXcjNNqF1z+w4YJDKbYOWwbcZltka1i/qD8ifEVBucVzXK2Tffr23Z5NzOJW9f2R4a2y8o1PcGCusbiYHeac4EX64F2dFyp5F+zMn7B+v12VBy1s7868uG8HG0zDjsFTPXWWgQc2Y/7/tVLUGIzacg7IiZPJV266HYFQtYPJeX3c0jVlrPvmQ7Bi8anpSRQOPRicmXQ1vGBi8YmnsdrKr5rrv4FCvKD02AbYrvmd9QKpYS4CKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY2PR02CA0071.apcprd02.prod.outlook.com (2603:1096:404:e2::35)
 by TYZPR06MB6618.apcprd06.prod.outlook.com (2603:1096:400:462::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 10:18:10 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:404:e2:cafe::bf) by TY2PR02CA0071.outlook.office365.com
 (2603:1096:404:e2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 10:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 10:18:09 +0000
Received: from gchen.. (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3E5834160CA2;
	Tue, 25 Mar 2025 18:18:08 +0800 (CST)
From: Guomin Chen <guomin.chen@cixtech.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	Guomin Chen <Guomin.Chen@cixtech.com>,
	Peter Chen <peter.chen@cixtech.com>,
	Lihua Liu <Lihua.Liu@cixtech.com>
Subject: [PATCH v2 2/2] mailbox: add Cixtech mailbox driver
Date: Tue, 25 Mar 2025 10:18:07 +0000
Message-Id: <20250325101807.2202758-3-guomin.chen@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325101807.2202758-1-guomin.chen@cixtech.com>
References: <20250325101807.2202758-1-guomin.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|TYZPR06MB6618:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f8f68a10-fde9-4647-48d4-08dd6b8657a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b8PefknXrzLu90l7UH8accgat6r2dpoTeMa4Raeu8GyGxYueVlNCMInqQP9I?=
 =?us-ascii?Q?RCY8oZM/+bWISS71bk11GHcAS+q/Xg4pWz0rLz0JccA2ngF5Ivl5PCTHbdej?=
 =?us-ascii?Q?hpYxW+PL/oK5SDHscO6+YWsK6iu9XjGE0PdXphUipZuySKgnnUQKpykywbdd?=
 =?us-ascii?Q?feWBokPzPiq3ml/XKVMYzQUAj9pFKVl7vGVN3L3q7wYiRDwXPx3nkoOi5W3I?=
 =?us-ascii?Q?KX+7RI8hyqVCb/Vlanj9Q7j0yu7+YAa3oV9ykIcc2FzC4fZHT6oPLvYdhwFY?=
 =?us-ascii?Q?k8mlKHXTpd2K4rtBlVsLUOC5DiAvkYX8CIFBZXs6Tl63mbV7PpDVks0padc5?=
 =?us-ascii?Q?4ShXZr5BzFhzf1uIIe/eC2huZ2HFWpiXnp0gvqnzfq1Tnhu4vniKJ/xDuPUC?=
 =?us-ascii?Q?yFkxRCW6kn4alshNNjFnBF1Ng3zkKaJiuyRMnGVXj4bR8K+EMEQ7smSdIHLm?=
 =?us-ascii?Q?ArysyMLcptE5/p0z6+HVYMnBxhDUXOKYyLSnaIOhen/kYfoUDPROIzQ8mzkK?=
 =?us-ascii?Q?0GiISV8HYBVqIHgc9R7pIUG6FRqmjrbIiug5iS5Chg1JFAsCIIdJcO24bdAZ?=
 =?us-ascii?Q?rd8PnfVhN3wOlQyHFIMG3NZc2brf2lr2jEMIIrnQ2z0UeIP0Bn+rE1dTn49q?=
 =?us-ascii?Q?kJQ6GqpJdLzHm/oQVsV4H6IVTVaTuWztFF7LvDPXClx7DI8b3o29tTUGKk9Q?=
 =?us-ascii?Q?RDzx3d4rSOTdpxTREa/jYhvsBs8h2nYWHP63fLKMsboAuqn58n564dw1tPzh?=
 =?us-ascii?Q?Wf5o+M6pwoM4tTGWdwc3RkbmRoGOQqIC1fuidv5TJoycyqOn5STHA2xpGIn8?=
 =?us-ascii?Q?d4bx39v8DRMi5qFDqbr/UsKH2Y7n9uAVtTU8ldyRUDuSKJFf/ddqdL4Mu2Wc?=
 =?us-ascii?Q?F5qJWnRcwkP2OvvY10w3kPUTiOIGtoOON97T6oz2k9G7rWZN6c9VON+GAfmx?=
 =?us-ascii?Q?sxfcCw52NfDsHlFKOVX2FUFbgQYOU1usNB+inErOMflEckRi1aEIN8KBH/Mb?=
 =?us-ascii?Q?AKpLk3q6vTiCUy4GUvRR+TzY6VJfuUmClYU62sGcKELN2F7vbRv5MnKpVGAF?=
 =?us-ascii?Q?BfpNfnxGVilIlXoGCD1F4ch/d5Sb+9FaSB5Jp7buLRq/fjV5g2BmjDpZCAGA?=
 =?us-ascii?Q?Tf1W++XM+1818fH1teX+t3+ywqpJ0RDHUeBo9/JimzA4kB2ljm+Ze6VReo+b?=
 =?us-ascii?Q?UIxklhEIw2vuVClTaCcrmTUywTIvh7c4CzyoGhFqPCPiAtO+zV9SCSWCq4sb?=
 =?us-ascii?Q?sv6Jp4vSpJupXBE62naW/mruhuC88WcNTw2fxsiPnJ33a4H+Q5lElJvFnbvi?=
 =?us-ascii?Q?nZIDaKr7QVFJxIff7DzHSJABypGzBFt3Kr1jn/OMdu2WLYgUJfV3ifKSvMWN?=
 =?us-ascii?Q?RkHmlseepbnA5scYBHR4lYZ+9S2FE6oAWJsRO5XT0WW8pa+hRXcbPBhteYPn?=
 =?us-ascii?Q?CWbrb2EP2e1pPK6NxYFjhEPr0cYJ2kcb6M3iGpMlTiVwirZerNgNiMgkYdSA?=
 =?us-ascii?Q?QbuipXwQJrU6cKc=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 10:18:09.4595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f68a10-fde9-4647-48d4-08dd6b8657a6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6618

From: Guomin Chen <Guomin.Chen@cixtech.com>

The Cixtech mailbox controller, used in the Cixtech Sky1 SoC,
facilitates message transmission between multiple processors
within the SoC, such as the AP, PM, audio DSP, SensorHub MCU,
and others.

Reviewed-by: Peter Chen <peter.chen@cixtech.com>
Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
---
 drivers/mailbox/Kconfig           |  10 +
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/cixtech-mailbox.c | 633 ++++++++++++++++++++++++++++++
 3 files changed, 645 insertions(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index ed52db272f4d..3d89e13460e2 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -330,4 +330,14 @@ config THEAD_TH1520_MBOX
 	  kernel is running, and E902 core used for power management among other
 	  things.
 
+config CIXTECH_MBOX
+        tristate "Cixtech Mailbox"
+        depends on ARCH_CIX || COMPILE_TEST
+        depends on OF
+        help
+          Mailbox implementation for Cixtech IPC system. The controller supports
+          11 mailbox channels with different operating mode and every channel
+          is unidirectional. Say Y here if you want to use the Cixtech Mailbox
+          support.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 9a1542b55539..c03a8c352b53 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -70,3 +70,5 @@ obj-$(CONFIG_QCOM_CPUCP_MBOX)	+= qcom-cpucp-mbox.o
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
 
 obj-$(CONFIG_THEAD_TH1520_MBOX)	+= mailbox-th1520.o
+
+obj-$(CONFIG_CIXTECH_MBOX)	+= cixtech-mailbox.o
diff --git a/drivers/mailbox/cixtech-mailbox.c b/drivers/mailbox/cixtech-mailbox.c
new file mode 100644
index 000000000000..28748f02c192
--- /dev/null
+++ b/drivers/mailbox/cixtech-mailbox.c
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
+MODULE_LICENSE("GPL");
-- 
2.34.1


