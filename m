Return-Path: <linux-kernel+bounces-524459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CDFA3E35A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313B319C244E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482462144A6;
	Thu, 20 Feb 2025 18:05:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEE221579C;
	Thu, 20 Feb 2025 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074705; cv=none; b=V6OiLkrEsYV/VSqsCAy7GvuX9k0ij+Mu3kSnPXgbhXNG+Q4meGAJbiK30EOYZrT09eYkFZx0l1NeOu3Z2Lx6dqEUtZ9SW0wAi7/5pFvWRPNJdMdKsvh6ssy6DQwUCUxnhxjxF/TybHV4DWC8abcZy550o2PLjdz3tlt/+T/pQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074705; c=relaxed/simple;
	bh=w3+kiSyJXOb0pNy8ocDnDQd7Cizm2vu6drwZHcAQ1+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbSbVMU2QZHUKleKIG2JD5qz0kjOIl5jkZFn9rRFvJ5xqLkfRDQdpXA6A+wl3AYrPtQu5RJdWmtK5SLUjLPOA5si8pB8Y7Vbb+MAF1XSazb43TiChfk3oVGxxKyK0BX+QUZNRs2GfKlurHo4VjYSgutYAv4k5S1m2Oo/rQnrWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C204F16F3;
	Thu, 20 Feb 2025 10:05:21 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97C743F59E;
	Thu, 20 Feb 2025 10:05:01 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH v6 09/10] arm64: dts: morello: Add support for fvp dts
Date: Thu, 20 Feb 2025 18:04:27 +0000
Message-ID: <20250220180427.3382482-10-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220180427.3382482-1-vincenzo.frascino@arm.com>
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Morello architecture is an experimental extension to Armv8.2-A,
which extends the AArch64 state with the principles proposed in
version 7 of the Capability Hardware Enhanced RISC Instructions
(CHERI) ISA.

Introduce Morello fvp dts.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/boot/dts/arm/Makefile        |  2 +-
 arch/arm64/boot/dts/arm/morello-fvp.dts | 77 +++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/arm/morello-fvp.dts

diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
index 869667bef7c0..f30ee045dc95 100644
--- a/arch/arm64/boot/dts/arm/Makefile
+++ b/arch/arm64/boot/dts/arm/Makefile
@@ -7,4 +7,4 @@ dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += fvp-base-revc.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += corstone1000-fvp.dtb corstone1000-mps3.dtb
-dtb-$(CONFIG_ARCH_VEXPRESS) += morello-sdp.dtb
+dtb-$(CONFIG_ARCH_VEXPRESS) += morello-sdp.dtb morello-fvp.dtb
diff --git a/arch/arm64/boot/dts/arm/morello-fvp.dts b/arch/arm64/boot/dts/arm/morello-fvp.dts
new file mode 100644
index 000000000000..2072c0b72325
--- /dev/null
+++ b/arch/arm64/boot/dts/arm/morello-fvp.dts
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright (c) 2021-2024, Arm Limited. All rights reserved.
+ */
+
+/dts-v1/;
+#include "morello.dtsi"
+
+/ {
+	model = "Arm Morello Fixed Virtual Platform";
+	compatible = "arm,morello-fvp", "arm,morello";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	bp_refclock24mhz: clock-24000000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "bp:clock24mhz";
+	};
+
+	block_0: virtio_block@1c170000 {
+		compatible = "virtio,mmio";
+		reg = <0x0 0x1c170000 0x0 0x200>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	net_0: virtio_net@1c180000 {
+		compatible = "virtio,mmio";
+		reg = <0x0 0x1c180000 0x0 0x200>;
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	rng_0: virtio_rng@1c190000 {
+		compatible = "virtio,mmio";
+		reg = <0x0 0x1c190000 0x0 0x200>;
+		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	p9_0: virtio_p9@1c1a0000 {
+		compatible = "virtio,mmio";
+		reg = <0x0 0x1c1a0000 0x0 0x200>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	kmi_0: kmi@1c150000 {
+		compatible = "arm,pl050", "arm,primecell";
+		reg = <0x0 0x1c150000 0x0 0x1000>;
+		interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_refclock24mhz>, <&bp_refclock24mhz>;
+		clock-names = "KMIREFCLK", "apb_pclk";
+	};
+
+	kmi_1: kmi@1c160000 {
+		compatible = "arm,pl050", "arm,primecell";
+		reg = <0x0 0x1c160000 0x0 0x1000>;
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bp_refclock24mhz>, <&bp_refclock24mhz>;
+		clock-names = "KMIREFCLK", "apb_pclk";
+	};
+
+	eth_0: ethernet@1d100000 {
+		compatible = "smsc,lan91c111";
+		reg = <0x0 0x1d100000 0x0 0x10000>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.43.0


