Return-Path: <linux-kernel+bounces-559590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB600A5F5D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AAC17A2E38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09610267B01;
	Thu, 13 Mar 2025 13:22:15 +0000 (UTC)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020108.outbound.protection.outlook.com [52.101.128.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE1A267737
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872134; cv=fail; b=tpQf0DeVUU79XPS3iDsHb1Ktf1L3gUJVNedayDyTxuY/uT96Z4WJiVp8yOKgHON5fskPAICKtGl5+zUjWb8lc4GEiEZgvA+WabdlPfbAB3cE0puW9vyjKNifnRilkNV4kJy+ExKV53QfNlVZSVzzgSvOH7hOZM5RyUDZvn7kK/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872134; c=relaxed/simple;
	bh=SEYA3vXsuzEnBkjQlSTjAVBKn0maHvadEKRJKTxCKrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mB1nWmtcbcol5lqIFz68r9xW7LmZ3GviqcOS9uKZ3RqjTS7RTzBLhTWDdzVlhrp4Z012HRhO8cn2l0JaV+LRDHS+/4BlA9IcVz24fIABTdxQNQaUBU7fwlYLyD2rJwi5MNlDOiX5KbVjglj/QewX1rxh4/0me8rvYvz7jO9rd1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.128.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWt8S6EGvrjmRFiOZZ82hJyagU0h8tALiaU323fnIMY3UV+Q7IaILcpUJdMU0BYwR5WMsSknU+JYN8qaspCZBQUVV/IFNuN2UCqEdLNFh/7qZlZA2u6UHox2sNtRHGsl1W6MQS3nQDqTv7xOE+fC5ygDV00LZFY2/KTl8yCFOxiaz3HyJNbEmeiHSaoAeSKnTJPVxvNTFnEt4Ox25SU2+Jd8WkGMqdK2HED3MytavIZFVhz8PeKKPjvHBAH55BKmT0LjmAJdHlMiKYWRMDmYR9Hwlbo28VxvIIrvx0jJ3sNpizIEP7nB9XFJGSBD40Eh+jafmf2UJGOIj6RtktatjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCqGBOH3JiEb+5q+tfsxQvcXPvzzP7JdMw6VNDdIhGs=;
 b=e1XtQFSP2ruxkFf9WJsN4TXD7a58PWoIRICn4hKbP7His1A1qAekwaPoOnig6e4QDmVONbZzS0dy4Gbbky5hF65UK9nGepHOCmg00e/P/3XIMkPQFPHdH5c50ipf+J/58URmwbFz/djywYIiDeYu/t57Fd+mkUPbcuWEPtRDz3uPZ7aujQIhrGo1/qjUGc0inMtv8W8+fm0SsyXPg9SG2cY5JG6MouC1YbI0qFCPwKaMYCF9h06SERlxQq7rpaT6mp9Q2wYdXmLYPWJzmb3wWab2DB0zb0144FEYS376a0by7rbjNK5h7ax3oQbQUrBM/vXU8LnypZrNfWKMCHNQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0052.apcprd02.prod.outlook.com (2603:1096:4:1f5::20)
 by JH0PR06MB6920.apcprd06.prod.outlook.com (2603:1096:990:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 13:22:06 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:1f5:cafe::2d) by SI1PR02CA0052.outlook.office365.com
 (2603:1096:4:1f5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Thu,
 13 Mar 2025 13:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 13:22:06 +0000
Received: from gchen.. (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1F1FA41C0A00;
	Thu, 13 Mar 2025 21:22:05 +0800 (CST)
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
Subject: [PATCH 1/2] dt-bindings: mailbox: cix: add device tree binding documentation.
Date: Thu, 13 Mar 2025 13:22:04 +0000
Message-Id: <20250313132204.736545-1-guomin.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|JH0PR06MB6920:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 460424f5-43fe-4e04-89c9-08dd62320cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lYetwaZHgm/EF/cnzH4BDaKGPHLe/i4WPN6LCYwf17XLM4+qEc4w2qxio+WG?=
 =?us-ascii?Q?uXLBwd9CZ6CndBfUhFOyjcofGswfr+iopGyK9ioQ/NiPGjphq3SvKFl3juGC?=
 =?us-ascii?Q?k+fs74F9xDpPZKZty190Xte5aq9pdKFrcG90bIdhO0WGi2Od5PS2nb8F/Vcj?=
 =?us-ascii?Q?lB6dLJJ2KB8wxl/e5fPWPqzlCO1Giw5cyECgmCr0H+QrzGta+37d8H4JAyKZ?=
 =?us-ascii?Q?xIQMlnSk81qxC0BgB4l3tTNeC26WMriB1LvcI7+ulELeLuS8h1qDyaTQMXwP?=
 =?us-ascii?Q?uoSNZyhbQyIW755h3ZoY+ay1UL4fjxBCbnCCrQCMG8VFFpLWD8a7kk7NxAJa?=
 =?us-ascii?Q?C8qOw/ndAJtR16Nv8XDe03en1Wiy4oQ69YyEo0iuKvTMPryVtcszL1WoSkgk?=
 =?us-ascii?Q?GXyHrXW/H/Ry0Xv31PQohBc25IHWfZYZQvkkmQ4Bdxh8S1MxDli1Yt+Qx0l3?=
 =?us-ascii?Q?6uXvByCJ6qlltIsXAcZ7BcNmgCwAdJ7nWRPS3ZiJpxJpYDhLi209FnrQi6lG?=
 =?us-ascii?Q?hN+xdiWOzkbbi1g9KxyFh5lHfFW0yiNVYlZoh1Fig2IN5B6hyNlq9mKE+tP2?=
 =?us-ascii?Q?Wj4tA6D+mUoPzvdEfSo3c/J3j1nfUMjuEaUFpIv+d6ZBRL6SH33XjlWnGUja?=
 =?us-ascii?Q?4ZinW6cZZXHsFML1Rl7pMH5S+RYZzYJhXTFfSzR7ly7ILoaYjSbN1X338/0z?=
 =?us-ascii?Q?zEsb0E3OOURKSBF3+W9f166GsbRj8aXmY/h3Cg8eaNRWUWpMZD2F4YCN0Jbo?=
 =?us-ascii?Q?lVPC4eyD4a/2i/rN4xj8BCIw5LI5HMYsQJMjr2NThdAcS1uLHfaoKYV71KDo?=
 =?us-ascii?Q?xVfkD/D/fuFUeRZa9//KLfBMx4+NAMkJKH88CpUaf0pwUQ5dY8Sr2fP0yItr?=
 =?us-ascii?Q?UAAKypwHQ/FUWEfqruD6dEBgKQWrL3wmPKBTFHgfdKKwA2/ku65LqKK3ytar?=
 =?us-ascii?Q?NP88Ej/qrxO2YuZQiK+v80tjj6CikRShYnmT/sKQIrEAEpWpV633SQ9ScTH4?=
 =?us-ascii?Q?KEbmp3DsCSMqUhB+iBvioIAFcZBRca1P6/spFNvcU6eN7kC2SaaF52Lzcev6?=
 =?us-ascii?Q?3qb1oNppvnDfnJ19jp8GRqq79pXHon5HXvmr9Sd59ydAgTBtsltfXgH+/K8A?=
 =?us-ascii?Q?YXF5zTieszFjDTwcyl/aS+92U1FLvcMeaTeRRjuBRsKiY5YwGLfCy0uyavON?=
 =?us-ascii?Q?ZgPK5AXEh8N0H208OqjdA+HasDWGeTFjuYCCQGaqKxT4vkvpzaHbY0oCjiEx?=
 =?us-ascii?Q?PMBdImYnLBjevOIJvjEjXTsRwlN+RzZU9MYUMbvB8qcFPxJX2/JKTr2W7H/y?=
 =?us-ascii?Q?06df+9Ez63JThohgH28RxMj8T2ISU0TMqxqknMXx73+2jgTFB9dd7UV/ZPcO?=
 =?us-ascii?Q?iw6atSTP6pWS4ONhuoUT4n/33ENkiHLR9xyI62hEYt7Rk9kOQx/JsJR4Lt4W?=
 =?us-ascii?Q?NB+RImPKR6yr3Mt1JJhreJvDnfX5vGej?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:22:06.0548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 460424f5-43fe-4e04-89c9-08dd62320cfa
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6920

From: Guomin Chen <Guomin.Chen@cixtech.com>

This patch adds device tree binding for mailbox from Cixtech.

Reviewed-by: Peter Chen <peter.chen@cixtech.com>
Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
---
 .../bindings/mailbox/cix-mailbox.yaml         | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml
new file mode 100644
index 000000000000..85cb54ae2e79
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/cix-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cix mailbox controller
+
+maintainers:
+  - Lihua Liu <Lihua.Liu@cixtech.com>
+
+description:
+  CIX mailbox controller is used to exchange message within
+  multiple processors, such as AP, AUDIO DSP, SensorHub MCU,
+  etc. It supports 10 mailbox channels with different operating
+  mode and every channel is unidirectional.
+
+properties:
+  compatible:
+    const: cix,sky1-mbox
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#mbox-cells":
+    description: |
+      <&phandle channel>
+      phandle   : Label name of controller
+      channel   : Channel number
+
+      This controller supports three types of unidirectional channels, they are
+      1 register based channel, 1 fifo based channel and 8 fast channels.
+      A total of 10 channels for each controller. Following types are
+      supported:
+      channel 0_7 - Fast channel with 32bit transmit register and IRQ support.
+      channel 8   - Reg based channel with 32*32bit transsmit register and
+                    Doorbell+transmit acknowledgment IRQ support
+      channel 9   - Fifo based channel with 32*32bit depth fifo and IRQ support.
+    const: 1
+
+  cix,mbox-dir:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Direction of the mailbox (0:TX or 1:RX)
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#mbox-cells"
+  - cix,mbox-dir
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mbox0: mailbox@30000000 {
+            compatible = "cix,sky1-mbox";
+            reg = <0 0x30000000 0 0x10000>;
+            interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH 0>;
+            #mbox-cells = <1>;
+            cix,mbox-dir = <0>;
+            status = "okay";
+        };
+    };
-- 
2.34.1


