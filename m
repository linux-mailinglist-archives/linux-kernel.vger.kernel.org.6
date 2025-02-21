Return-Path: <linux-kernel+bounces-526401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DA9A3FE3D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51409427E28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CB2512FC;
	Fri, 21 Feb 2025 18:04:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41F5253F3E;
	Fri, 21 Feb 2025 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161060; cv=none; b=PvDnna0YscP5eX9jsNZy53ECsX0W7PPNlgza3i7TuLo1sJ2jxdG8SY2OH+5WK+d3Etj8XTE2vXpDxC+JNeUBGMT2C960XZuteyMHfr600u4hNEFRPgUzqZ05fHC8qlk7MEImwpTMWQu43RFUvDIDigYS5hNP+B+VqJsucts+dyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161060; c=relaxed/simple;
	bh=w3+kiSyJXOb0pNy8ocDnDQd7Cizm2vu6drwZHcAQ1+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8vHRH06N041EaAGgHAnsPSyuomzH6+p+c9brU+7lEvkkv24ls8jvlznWM4h3n7vrUc+UHQ6jiHjfsagHbGJTO2ODO4zywIW3/LbLecPIVA5kXTRXIpEASNqhWbnlV97XPTXwDQ7tzjEML8JjNWRlKPBcnr+ABp/xoVb/y1acto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 371F2169C;
	Fri, 21 Feb 2025 10:04:36 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6147C3F59E;
	Fri, 21 Feb 2025 10:04:16 -0800 (PST)
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
Subject: [PATCH v7 09/10] arm64: dts: morello: Add support for fvp dts
Date: Fri, 21 Feb 2025 18:03:48 +0000
Message-ID: <20250221180349.1413089-10-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
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


