Return-Path: <linux-kernel+bounces-575090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA673A6ED6B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CB31893EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3720253B66;
	Tue, 25 Mar 2025 10:18:16 +0000 (UTC)
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021137.outbound.protection.outlook.com [52.101.129.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3AB19004B;
	Tue, 25 Mar 2025 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897896; cv=fail; b=aoGKIPf12kQXkTTIoqWDcjrs40NIDrlrC90zNfGL/4SR7Az4C/5j52vFMIJrrgQC0IpeY134AYe15mlcdXe2wCfaz+pld72jKaYmRHq4VBPsLGTX4NrkQ0Qz9Tz1RXNgqgYz/WXq3pam7k+B49tlhPxRpWilro1BjQl0Bj1K9aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897896; c=relaxed/simple;
	bh=d0wmspuvbxQHnyJAoLriCOQR7/2pdy7vGIE8ks4KSU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSrDIHs4/oluKIvm9z5J+0GH2aJ1kkm8Jf75fBAEoul73//eetVCa5zY2aAYILXJVa+3cxyaXrI592esgf2UXKZ46NfhdWJgEvMFeYU+bCX3T7Xx0KGGKBGFE3wL/cB0OHOo58ZvuqmTs6BiiT/15rGhKVUNAQeH2ncPFuT14Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyY956Vt/ty4pgxZLUf8kPS8/bZwpkX9DQAWU9Fa8oIaHkftPQGjjMd3VhCJluZfUPa/uP9XTnmROnv7Krxnt/ekKQjdiHFihfAHxRgpl5rYp4F+9gc9uPZe5JlKQN2S/FxhLz2OZ+ShQ0p7tzBmy1BU76PQla9jK9Kz4ivZtPV6+FML0kIg9VduNQLBFY4Qt3JtEdY2w4esZT4Eap3ZcyTWkywf08c66QDF3kD7kOBHBad7v62zE8NV6+j0rRsHFOvYjgGZg7G1io24V9OpVAQKjicN96Oa6qNhnRwAOAhGASp8FoPPwnlc3ZncR6VJimed6uOtCCmUuztFF5pcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqiyPfKcDFxNKiRq0655nkIWJKR7drFzc+Jv3R6Miig=;
 b=fygomZEq7AY616iOpjtGuBLnwL7I9pRBFdoy+fkLcaGEpBCCRQz5JE7tsawcMQpciICrIs2UiLYSsmIofmfWWEcEaaSFIeZkMm7jc9+5jYLV4zqUjKs5m7JoDXbndFohH61W3B90/kaeSrHCBpI/MZ48us7ZBnQQ1KLKDh85XWiS9awhI9LptSpfYuI4Lgosi1sfIRAa00ImbhE+q0NgV8dOJ44B5Vz56TL+7bi+/mf6aZh28Lcdi/TbGBS1Eexa5b5At9jztAOszFMdtGRD7IbLWG+y21ZLPitxb4Qvco4ciQ7VMFf0hq71ic3aoKJwUR/89ORkbEUdh6M92EeXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS7PR01CA0186.jpnprd01.prod.outlook.com (2603:1096:604:250::9)
 by PUZPR06MB5956.apcprd06.prod.outlook.com (2603:1096:301:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 10:18:10 +0000
Received: from OSA0EPF000000CD.apcprd02.prod.outlook.com
 (2603:1096:604:250:cafe::69) by OS7PR01CA0186.outlook.office365.com
 (2603:1096:604:250::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 10:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CD.mail.protection.outlook.com (10.167.240.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 10:18:09 +0000
Received: from gchen.. (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D731B4160CA1;
	Tue, 25 Mar 2025 18:18:07 +0800 (CST)
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
Subject: [PATCH v2 1/2] dt-bindings: mailbox: add cix,sky1-mbox
Date: Tue, 25 Mar 2025 10:18:06 +0000
Message-Id: <20250325101807.2202758-2-guomin.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CD:EE_|PUZPR06MB5956:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 835b8ab9-620c-473e-a14d-08dd6b86579d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rM6T36NK666cwrDCK9jWqlb4/vlRTO79t9c1bY7rZA+1AF9in61WMFFkJKsR?=
 =?us-ascii?Q?lMDLb4UHXNFMUmudQVpG4s+YHEoijLB15rk7ylub4MQlKYadKtk5SFke1ZSN?=
 =?us-ascii?Q?ulrbUUWKW5K0lMx2hOQANOtGvBtvJwW8gj+MbDrD9d1Y06bFQAdJJESYkSJS?=
 =?us-ascii?Q?fi76GMNwwNMnLnIVMFQfxEnLIKINrlJLSfFIPQtC6vkqC8Us6tCDxkucLpJb?=
 =?us-ascii?Q?MnmHdb/WUOgGFGN+OqtuaLim5DNPdFv0DX0fYsWkFDncKPAcxdOLhRwPI5yj?=
 =?us-ascii?Q?GDL1Q41ZZtaHu3QQYqOkQK41vWLAFBj9MSMuCPWaitmfd/4cvCgV7ekNB3hF?=
 =?us-ascii?Q?K/MD/xubGIE0D40CWIiFR6406ueep7ZCmi4D3xPXJ1qVi95WFTULJTEiFkhc?=
 =?us-ascii?Q?Hld7dkwNvI5kHlDPDwL9P4E/k/eQ71Kk4dYvoviOaAr/DkXtpniuDy8aPzdS?=
 =?us-ascii?Q?ycKeRS/xqFgY/HuIDOENhl7kWFQ0tjNe7Mv5GzzPDjYzMWAFghOrCvcSrB8Z?=
 =?us-ascii?Q?tuB0SdAI0pTsc6SOomMLbqtKVmzC3L5Dm8Y9tohzA2sPCz2BNEl28pQRnK9g?=
 =?us-ascii?Q?mtF26H80zDY89Lj/CJIA9WAcVLo89aNhtjTcKH3cErgMQqdve+sax6/aY34H?=
 =?us-ascii?Q?BHYkYRQU0DbMTtMz5zjquEkndNoggCHyCYI6/ERdeAhUuuXk1AZYaidNJacn?=
 =?us-ascii?Q?qxS+RTRiTMEEWbgPp2L8txHr8edRnHZR+2c+jrxwMtG3JIgxpcF5xYzMC2sT?=
 =?us-ascii?Q?C6MidGxZs5ZTjDJ6QJO+iGhHi/fer8Hektjavc6Lhzwp0mbt7SWwQGrwkGS0?=
 =?us-ascii?Q?eQ+qr50Z3LwdCMkGFlYUfv8wjF3LuBRbKk9nLDJiOIiFIvAjGlZ4/ATNjyg2?=
 =?us-ascii?Q?HiNSOh7atstWPpl6yDNEIidKic/O8pb+JZirF7SF9lf48t2C4zsRzEx3TotQ?=
 =?us-ascii?Q?0Nt0t4JUyjPManiEjZ5idOymdnJBS0rayW66jnHW+aDi9LTI1CuzYjgGUaCF?=
 =?us-ascii?Q?Btpmkwli1fEE4ITqNBT7bbjSdxV9zBosiE/dy7+RwqtKclGpiAanUF3pP0uU?=
 =?us-ascii?Q?AaKxI70RgrOmbIpu8gjToKhiUirD5qJTwLUh5n9Jevda5EqBHVreY0Z9HHqc?=
 =?us-ascii?Q?nqPKuk6FybCevIk3jiv8yIrwbYYmZFV6qjUhkHYuS0RNpriEvnQ6j+G9WgUS?=
 =?us-ascii?Q?1b8Hhz4Yn24ZfrmgPCIcb27wURo/CLJ9tFEeKopR+8nTPAMmXM79KlxyoVNI?=
 =?us-ascii?Q?q/PYinWa2Ev7vYiblGKnmuLQt5OAqkI5qs+1ozStS+Jqz3PfpAlMoQPfkqMx?=
 =?us-ascii?Q?+SidlU7xBkhqasEqZFS4IUjTlUH9ChK9VRqsQdff036m1vD3myKBT3KtIJ1x?=
 =?us-ascii?Q?R+WOV02wlQe0T2PoIjJH33kBvB+mx1jk63RZSNS1zwGSf19m5fzxMxHl+dBH?=
 =?us-ascii?Q?fhRhX2vfsQplC5/oChEupJjdsjywwmqO?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 10:18:09.0432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 835b8ab9-620c-473e-a14d-08dd6b86579d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000CD.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5956

From: Guomin Chen <Guomin.Chen@cixtech.com>

Add a dt-binding for the Cixtech Mailbox Controller.

Reviewed-by: Peter Chen <peter.chen@cixtech.com>
Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
---
 .../bindings/mailbox/cix,sky1-mbox.yaml       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/cix,sky1-mbox.yaml b/Documentation/devicetree/bindings/mailbox/cix,sky1-mbox.yaml
new file mode 100644
index 000000000000..98cee3bc0638
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/cix,sky1-mbox.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/cix,sky1-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cixtech mailbox controller
+
+maintainers:
+  - Guomin Chen <Guomin.Chen@cixtech.com>
+
+description:
+  The Cixtech mailbox controller, used in the Cixtech Sky1 SoC,
+  is used for message transmission between multiple processors
+  within the SoC, such as the AP, PM, audio DSP, SensorHub MCU,
+  and others
+
+  Each Cixtech mailbox controller is unidirectional, so they are
+  typically used in pairs-one for receiving and one for transmitting.
+
+  Each Cixtech mailbox supports 11 channels with different transmission modes
+    channel 0-7 - Fast channel with 32bit transmit register and IRQ support
+    channel 8   - Doorbell mode,using the mailbox as an interrupt-generating
+                   mechanism.
+    channel 9   - Fifo based channel with 32*32bit depth fifo and IRQ support
+    channel 10  - Reg based channel with 32*32bit transmit register and
+                   Doorbell+transmit acknowledgment IRQ support
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
+    description: Common mailbox binding property to identify the number
+        of cells required for the mailbox specifier. Should be 1
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
+        mbox_ap2pm: mailbox@30000000 {
+            compatible = "cix,sky1-mbox";
+            reg = <0 0x30000000 0 0x10000>;
+            interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH 0>;
+            #mbox-cells = <1>;
+            cix,mbox-dir = <0>; /* 0:tx; 1:rx */
+        };
+
+        mbox_pm2ap: mailbox@30010000 {
+            compatible = "cix,sky1-mbox";
+            reg = <0 0x30010000 0 0x10000>;
+            interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH 0>;
+            #mbox-cells = <1>;
+            cix,mbox-dir = <1>; /* 0:tx; 1:rx */
+        };
+    };
-- 
2.34.1


