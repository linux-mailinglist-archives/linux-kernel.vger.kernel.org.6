Return-Path: <linux-kernel+bounces-536219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A0A47CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CAA3A9325
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3864122DF9A;
	Thu, 27 Feb 2025 12:06:30 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760422C331;
	Thu, 27 Feb 2025 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657989; cv=fail; b=muw2t8DlVbKy7R/GXBxvfm1YAplGf6FP1FRgHC7G+oA79NYqli+Me+9cs7F1KSO6Yh8eaDHuXDvnGl0UOy6xbzuY9YpWAUpv+0K+aqmXlB3wHbzWfnZpuJrIqOVXbPmMqSoxF3Q7XeH0PI8s3aGKuz2g6EY24C2LLcE93tsfUmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657989; c=relaxed/simple;
	bh=yBBPuYBkrBcdxy1ozfEAS32xv7C9K+u46gwvg2XIRGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IE64eKqV0h/Ki1dzuFIm3Cm2KmNbhxgGPrJ1An4/pHOXo6hGeXo81ErSSByS8YYzJ2/wfJfQCBMwbECxFSsny/v4zorNmTTl00CsJAh+ScXOiosHYlKy4QRgq37gABPrFuiAZUQKl/AHvWM4o7YOeiK1+DTC+KqADLaYTO0YUPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCpZKKsruBw7GiYZE+iFd0FDwXjxPI6YPoew5G1c4ut0yiTR13D3jxU2G2JPDr+i8n/9PPukY0iqnodVtBkuErAoe6hhfukxRIWi7DqsqzoAyNeU4g8iKEJPcdvGGjw9baUQwAzWX7IZJEC5+mu0kg9WJamN0haD08mAvDvnhRcSf2HtzQ+du2ZNgtmaZOd+o+tlWMkAq6d8mQx6VUYudb9WoSyEYSdh4M1boGUjma3PmiW8PaVjptDBqGQdbPksIhE6YyndWCZo3Try56rh0P1LswsIVJ3ED69i3hfWnen0af2GK5bmLNZxB4heHt2oh7VX5UxeoVOcXFGUFVptGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfY4emG/vLz3ABsBFlzPY6SGHm98iJQyjDTjfIT3f8g=;
 b=yZOKFW5/YhQFd4jIjS83f9tAJP5+2GdGUYg6XeKnHgCQ7fm66OeWFiQoqPwMDeXcpi5x27kM+7lvtRHZRQasYfLbXelm3fr1D8TKYbtRiutyipqC5gTdfCUSeq3eIoRbH/SOSROEdx7AmXtI2KZr0Zk5/fYfmi3M6jGP17pK2k7YEhV+o9mJu7GqtlG7SfpXJ0/BJ4Acu6D290dglI/HRPNPIZsDg1Aua1ayxFDmsVELJc7KOILpfdkmACTo4xh2Y30mylLlXvJtBlkDQ8Df2yswcU1DzusGwd7j1DD7i+u82dk62GoQEr9B87sZpt4fMmNZgJA7dQpIUz9mbjqhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::13) by SI2PR06MB5410.apcprd06.prod.outlook.com
 (2603:1096:4:1ed::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Thu, 27 Feb
 2025 12:06:23 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:300:2d:cafe::1f) by PS2PR01CA0001.outlook.office365.com
 (2603:1096:300:2d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Thu,
 27 Feb 2025 12:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 12:06:22 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 00B46416050B;
	Thu, 27 Feb 2025 20:06:20 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v3 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
Date: Thu, 27 Feb 2025 20:06:19 +0800
Message-Id: <20250227120619.1741431-7-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227120619.1741431-1-peter.chen@cixtech.com>
References: <20250227120619.1741431-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|SI2PR06MB5410:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fd224a5e-4a96-4d0a-8947-08dd5727271f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8FHWZ0uOegiILNutsbxU3ikTG+/4OwGmjvPcaJA6ALLpZPgBoYQYm3Iu8KzN?=
 =?us-ascii?Q?qPQMayyPsaY9IunWVbyUBnEnztz71UMPCgXgHAEhnALM13GA7WyobkQA1Wa2?=
 =?us-ascii?Q?SrNxg3nrwhEgxz7pG7cSqIgO0I3Cz+ck1iRyfbOFvJCqTLjMKAgr0Qmsr5yl?=
 =?us-ascii?Q?1kJst/bm1s009fqHJP/36KQCXInUsnOb0+pVSGc8t9Hsdis9f+aDENK2oe7O?=
 =?us-ascii?Q?X7plkNo4TYldEf1WCBPjaq6IYd7I0detxplzhIeD59WQerYg6YXFPBgjruFb?=
 =?us-ascii?Q?GZynvecPe0Y0Jt8xfQD8I7bV928vCzqEiPidjjAMBdhXodex4tR5RAc+qJ0d?=
 =?us-ascii?Q?gncVgWnkBGTGqns1APYmrd3/AyTAygC/aVSCSKnZF10uNT6wIsOskdC4rNfJ?=
 =?us-ascii?Q?RH2fVplloziOND5OvTiKM+XSgkvI94d0Hsy9IOR8JgBoWRox7hgWz8t5OmAz?=
 =?us-ascii?Q?SSZMXo//DrNUD2A5X4QWq2BA7+ukmbFspcyCx2Nrk5lzncTj1uQJP5n39D5T?=
 =?us-ascii?Q?3PNywU1hCH141dXunbyJ2e8QW2FGWuNd/3rbCTyGIs6woR1ryAAl6CoIAaD5?=
 =?us-ascii?Q?eeT2bz/h3g4RDNtiGRj2XwqW77eMMQ1YdAKcW729RR+9OeA01uM4w0HuC5e6?=
 =?us-ascii?Q?bxXfvP+IeGHIjjOeIelpigeFpHqcPqdfAso5G+a7bCv9xivwqDGkGWN1pbhb?=
 =?us-ascii?Q?Eh4gAUZ1OU6dOMdE2ZTlbZNbRWmfLc60kSDoznjq5P9/XZZhwLqWOK58R8Rc?=
 =?us-ascii?Q?KUXTLQF6D+WgaIxqtDwS8Hxdu/eDOdkSIRPHCbLg4O5DSG11IHX/4q2FR9AS?=
 =?us-ascii?Q?VyVFP2kcCex2YxcKooiBomxkg17MyWJeFLYv8mOzzBlVc0QvrxO1ECnGZf6d?=
 =?us-ascii?Q?YEwICV/Q8fd52md07nSIebrRzwY2yK2MdZhEjWOY8OAIw2MQWUfqGOiAGZVD?=
 =?us-ascii?Q?J+s2fI2RjkuLkz5Hw8s7PcYksbkWwItaT5vpFoem7oCtHSQNokvxbvRnFDX6?=
 =?us-ascii?Q?DHk0Bu3i5GDjd9hUTR/6oOP/ErUyIB1GSNDRmJK2HU3kbvGo7sQHfw+jmodL?=
 =?us-ascii?Q?EdWeUD57HUH2HzT+K2Y7hffmNAkqeak71acR9Z5TFFQ/eplVbirUVGVe5TH+?=
 =?us-ascii?Q?1gjLdl465tO5E3f4CIx+K/iVQr19WIz8pZII9zuSlnsDvlBd6ou0lkpYk5eH?=
 =?us-ascii?Q?YdnAws1evwcx0KXSL/P6l+MA0UKDf1u1OCn/KL9VExORt1L5027bpbbfgmPz?=
 =?us-ascii?Q?XVKKv5dsyt6mpQXZKhyVQ2RK/EYHQjI0xjVsDn3xKJuwPryhqawfKES8Wgg3?=
 =?us-ascii?Q?NRqlTula2cTeMukZ7p3e4E5l13TKlXC9ia8CbwZiXGmjHuRJj9G8oVpfuSVH?=
 =?us-ascii?Q?ICmbFQscLFkkbzhbRwVvzNoLbbluwciJA/tVWlph2n3oEE7adTt8WX8wFvZv?=
 =?us-ascii?Q?yrwpt5H4GDE=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:06:22.6166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd224a5e-4a96-4d0a-8947-08dd5727271f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5410

CIX SKY1 SoC is high performance Armv9 SoC designed by Cixtech,
and Orion O6 is open source motherboard launched by Radxa.
See below for detail:
https://docs.radxa.com/en/orion/o6/getting-started/introduction

In this commit, it only adds limited components for running initramfs
at Orion O6.

Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v3:
- Fix two dts coding sytle issues 

 arch/arm64/boot/dts/Makefile              |   1 +
 arch/arm64/boot/dts/cix/Makefile          |   2 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts |  26 +++
 arch/arm64/boot/dts/cix/sky1.dtsi         | 216 ++++++++++++++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 arch/arm64/boot/dts/cix/Makefile
 create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
 create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 79b73a21ddc2..8e7ccd0027bd 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -13,6 +13,7 @@ subdir-y += bitmain
 subdir-y += blaize
 subdir-y += broadcom
 subdir-y += cavium
+subdir-y += cix
 subdir-y += exynos
 subdir-y += freescale
 subdir-y += hisilicon
diff --git a/arch/arm64/boot/dts/cix/Makefile b/arch/arm64/boot/dts/cix/Makefile
new file mode 100644
index 000000000000..ed3713982012
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_CIX) += sky1-orion-o6.dtb
diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
new file mode 100644
index 000000000000..78f4fcd87216
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright 2025 Cix Technology Group Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include "sky1.dtsi"
+/ {
+	model = "Radxa Orion O6";
+	compatible = "radxa,orion-o6", "cix,sky1";
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x28000000>;
+			linux,cma-default;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
new file mode 100644
index 000000000000..c6d7a48e9893
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright 2025 Cix Technology Group Co., Ltd.
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x0>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu1: cpu@100 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x100>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu2: cpu@200 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x200>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu3: cpu@300 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x300>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu4: cpu@400 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x400>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu5: cpu@500 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x500>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu6: cpu@600 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x600>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu7: cpu@700 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x700>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu8: cpu@800 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x800>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu9: cpu@900 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x900>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu10: cpu@a00 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0xa00>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu11: cpu@b00 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0xb00>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+				core4 {
+					cpu = <&cpu4>;
+				};
+				core5 {
+					cpu = <&cpu5>;
+				};
+				core6 {
+					cpu = <&cpu6>;
+				};
+				core7 {
+					cpu = <&cpu7>;
+				};
+				core8 {
+					cpu = <&cpu8>;
+				};
+				core9 {
+					cpu = <&cpu9>;
+				};
+				core10 {
+					cpu = <&cpu10>;
+				};
+				core11 {
+					cpu = <&cpu11>;
+				};
+			};
+		};
+	};
+
+	pmu-a520 {
+		compatible = "arm,cortex-a520-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-a720 {
+		compatible = "arm,cortex-a720-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-spe {
+		compatible = "arm,statistical-profiling-extension-v1";
+		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		ranges = <0 0 0 0 0x20 0>;
+		dma-ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		gic: interrupt-controller@e010000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
+			      <0x0 0x0e090000 0 0x300000>;       /* GICR * 12 */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0 0x40000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			gic_its: msi-controller@e050000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x0 0x0e050000 0x0 0x30000>;
+				msi-controller;
+				#msi-cells = <1>;
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+		clock-frequency = <1000000000>;
+		arm,no-tick-in-suspend;
+	};
+};
-- 
2.25.1


