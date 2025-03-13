Return-Path: <linux-kernel+bounces-559592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFA4A5F5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B872188443A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F79267721;
	Thu, 13 Mar 2025 13:24:17 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023094.outbound.protection.outlook.com [40.107.44.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EE6264FBB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872257; cv=fail; b=iEbmZ+9Exlctm6D+YVXF83NsohcvqfOoMNsI2AaCzWvH0kxfEPs03PupiFOO9YCJpSJ0brx1a+gEDF7HSyvkimC8TgIASk8oYe4pEKy0dQWk/wLKZByX/FTWHA4UQ3JlXHQLcImumOARS+g4KgwsltEC9P7DMtHn22ncfhgenQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872257; c=relaxed/simple;
	bh=SEYA3vXsuzEnBkjQlSTjAVBKn0maHvadEKRJKTxCKrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cuNLbh8PJ3UqNk4hHB3P4Fze+mZ+nOwnMn1bJ03RqT/iizcp6aVWlj4o6OpEOYwl5faOv/LkSLSZ7NimxXVZ5Gn/2TjnpRNZpkxERNT2I35IaecipkvMlO3q6bFPNhSns/0C00jfBsuIPWAMbnZUSaeOhm0ZPLGBKHCWy7ACwuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UN+ZEdMTsxMw5vwFMhWP16ndbIq+rcucKHH++DYHVNjpcegnoKGl2rlQFjFJZsc50vKqyT2PovA3bvXPAJVZvd2oU6XBKNH/rOKSccXq71BGRVPP25GT3iTazR+nQJx74UG/RV0T68NKIGU9lLGIhWIaPd8Rzxo3P5nuz9CVcKoSYVhgskbgt4Mh2SltF7XJk9Ecy2yQZm9BTyUJclGOHSFnAp8K0rtCoGlkVRftoWCQmtfb40X67hhywlBqiSkVvjpUkcwgMSbJeiukNZuyJE+sDSdEd7jFUGsG/yJ8CL3XMUb+pZ98VQSGPIgyP9xmaVLkO24b5z3rRo4uWgV68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCqGBOH3JiEb+5q+tfsxQvcXPvzzP7JdMw6VNDdIhGs=;
 b=s8ZjgLRnKWv4RNh2L21eNK8b8ZS5uJvP+X63Qw35JFRMEF3QC9GFl2s4hPzNyE2jSvjCALM0ddsh07XyTBb2Pxbwv3/WTyLaQGQKZWGCbiSeS6LXk+LEtitz/b+yUUtdMcbRNU17yUoonltEwEIcllYBPldsHfGyuDqWQQZsszVW+yD8XFYvqfPvdj0F8dxN4TfJvUutDC9dAVhr/+4F4KUjgkiBDuHsyBiUA7+XbVbQzx9qT865Y3D7GFvqLmvBznfaeeqsAhYhd+5/5iINPZFOLN76j3K+OYV/tRr7TFyMUilPAeFL9lSvFTn6Fszb6opue4LefJGRkkHIEYIZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33) by
 PUZPR06MB5537.apcprd06.prod.outlook.com (2603:1096:301:ed::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Thu, 13 Mar 2025 13:24:09 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:4:b8:cafe::c2) by SGXP274CA0021.outlook.office365.com
 (2603:1096:4:b8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 13:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 13:24:08 +0000
Received: from gchen.. (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D6ECE41C0A00;
	Thu, 13 Mar 2025 21:24:05 +0800 (CST)
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
Date: Thu, 13 Mar 2025 13:24:05 +0000
Message-Id: <20250313132405.742360-1-guomin.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|PUZPR06MB5537:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a31446a6-052a-49e6-ee5d-08dd623255f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FkTuzCuJg6RS1un/paeQ027SktZZqQ/vmANqEfrMZ/DM3HTcJ4lPtrg0RS2a?=
 =?us-ascii?Q?fLFM0yerEyTYnrnf/zAzWv7TIEMQjkeuGrc/AAEK90WywpKGGxw8T/kPp60n?=
 =?us-ascii?Q?MfHZOO1HyYF7bhlkGRUjJKN9ui1nL3+QiwBMHP5ooMGWyH58s3cUlkGK1CKY?=
 =?us-ascii?Q?D+t/C7OH/Pz43MucRS/DZ0JtCkuXsTANxarJdIpxKyQq8bXv8nOlp4WqYW7t?=
 =?us-ascii?Q?OFdI+ECa8eFmog0+VdAzK3sg+YwBQ4g3zRqVowKM+bq2xCT4fvDhy8gpoEF7?=
 =?us-ascii?Q?qS88Ocj9RyxIgJSPGNvG88I+1E2pzQu2AgyORHrmW8z6s83Ikaml85aRhRa+?=
 =?us-ascii?Q?M4D6L8jqlGXVa55D0WZC/wZMl/THVtHdNGLW6N/fbE0dQYS6jaEU+MuKrA6h?=
 =?us-ascii?Q?GLMD+ovTneltMm0AJ9UwOYeKSuLaSo0JMiPiBFCuuF1+p0qtk+KkqjacYlML?=
 =?us-ascii?Q?DjjE5E4oFGpVmulQgo4/5sMDxSF5zbYAP9GRhj++V9tbOSHzS40dCwLlnt1K?=
 =?us-ascii?Q?B1fjAj4zvYSJS6lsxQ5y8RmcSW0a84s6c0UYZU/VyIwEmwVKTQHQnCNBElVX?=
 =?us-ascii?Q?nSCvLHEhZc9I2uzzS+2aFcHN7uDRBgadFEb3VfIY6ye/sV1OKvU3Zg4F2Xye?=
 =?us-ascii?Q?gOPGlJPmE9Zknz3piWAnbxV8NhWji6KU0XcDFc/UbGKS6ai2YG/tLJNmDt+9?=
 =?us-ascii?Q?4g+MSbSOCf5zyS6D2/ckWnvavTC3n0yzJ5/bjuq3jp0QIni0zryD5uOI65Qi?=
 =?us-ascii?Q?zbkEkYuQGT2JXpx2ZnaEqwpcCQYd76XEXsvzc5GgbVbFoEx8kmquZCUQrg3e?=
 =?us-ascii?Q?NHzYQaWZYAj3cTRgXkcWJgNYnk9HzbmdfZ4BWnE1HZa51sE01NjjnZi/xw4P?=
 =?us-ascii?Q?hVhfXFEBR9ExzO52W2pYR14ZTeUrTmr1X9eRo6c5iR835r7T0jirAG4SypWf?=
 =?us-ascii?Q?ZJowAz7TsyKPftfxr3zPhzg3HQXWLYP28PbqsW/XJpcvn/4qzjP564aXaMlE?=
 =?us-ascii?Q?P6jUkRglERnd9XXpC9fsh37hYdsOCaPCJHGlV4ETF3GmEFlwZvcZ1kJ0sgJH?=
 =?us-ascii?Q?WLz4sWvzzPCES8rO67N/l2YnUM6Kf+ROWCZB53WiPNz+0/r5DuhG/qS4fTNY?=
 =?us-ascii?Q?7mHRHJn/MuyYDD8WsMMQUsEbnWTmFGdoWwelpWi7AQPTe8B6p9l5pgv7tLci?=
 =?us-ascii?Q?w3LudgT4bcktUtOlPYEKYJXanHg3IWiiG9i7JIAKi6OM9imeMcSh5z2LX90I?=
 =?us-ascii?Q?lRm+gajExuVjQ1bQJPMQRy0wUhOG69KmHrNgzwKNnIybi+rWKvaAf7ZTNzLP?=
 =?us-ascii?Q?yCdIhBBaCRpxNpS4s+bR/8yqx0xavmzEXdIHKjoiSBvl/Nwz2M8XAza6ihK1?=
 =?us-ascii?Q?zNl3/4/5AMqeFQtW+ciEeSF7YrNZQVaMa9opT4RasQCAsjcquPjOc7LuweOa?=
 =?us-ascii?Q?WI8lI2kj2bnUyik5TYb+e30Hq0mx7wpN?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:24:08.3889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31446a6-052a-49e6-ee5d-08dd623255f5
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5537

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


