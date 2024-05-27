Return-Path: <linux-kernel+bounces-190430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1DA8CFE1E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB80283525
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1857E13C8F9;
	Mon, 27 May 2024 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C8qDiWZ+"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667813B794;
	Mon, 27 May 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805717; cv=none; b=U80/2w+RMFrkcn+oW54tDyXJhhX5HPtmMPfL/wpmJRfmGiRd2z9cPWVW1CSK1KKRYDNb7BVAJdnENdEYSszApGtrSCLxpzDIWUascP0GBbiz7VvgW7hhXKBQqcKwQsSPi0uyYhnuEh72PT6Xe4LoB0GNIsWKsOh4QYpscEMD9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805717; c=relaxed/simple;
	bh=wBDoPpS3HC83CyDFJS3wlrqWFRvwsmCF5f0hTI6RD1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XR0gL5b+wFgPfgww1sVT8AH+o9n6Wlb95NoQ0PdZEkroj+1ffJIc0EvpJUMDgIM4DsN6kqgNtRD2V7a6hy4av1DTupudFvbZ1IROHfsmYggIv4eHRMaDbdb7r3nHETjc8IrFAHvVWJUgnCrUt3o3hyq6zl+ExlQGZFg3gX1wobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C8qDiWZ+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 111DE20003;
	Mon, 27 May 2024 10:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716805707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGTOM0pfiSCveUfaceYtAyHVg+Ep/GypPt5E5h7VYhY=;
	b=C8qDiWZ+ZcP7lbEetHICu5+RHu/QzNHwaRfaMT5c9rHwTyWtpVwralRDGgb1U7+M3Wyuy4
	5sbuZxFxQvSPTqC6csIygrHHkP7k4ecR9LXvAtYK0ROIQp6eGGoZfEL8NM5d4+xRZNtuSd
	Qrt4Xm5XNwyjkIvPekmpmHgGahCO6ptOj9Oo686PV/U+8+4qvhbSVHtqJ2vYQ3JhAmtq3i
	eE20RGfMufo2L2E73dVS95n3M7lvT4pvIdRZ26QjdvMwp22dP0IvW6ha5fAeKDkn6Ssihr
	LF+9D6vOJ1Q+mC936oA9OB5E6uAmk2SpBMo0sQppKE3l33BrpOMCfgIpz63CuQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Mon, 27 May 2024 12:28:21 +0200
Subject: [PATCH 5/5] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-sg2002-v1-5-1b6cb38ce8f4@bootlin.com>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
In-Reply-To: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Chao Wei <chao.wei@sophgo.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

LicheeRV Nano [1] is an embedded development platform base on the SOPHGO
SG2002 chip.

Add only support for UART.

Link: https://wiki.sipeed.com/hardware/en/lichee/RV_Nano/1_intro.html
[1]

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/Makefile                |  1 +
 .../boot/dts/sophgo/sg2002-lichee-rv-nano.dts      | 25 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
index 57ad82a61ea6..5759b21805dc 100644
--- a/arch/riscv/boot/dts/sophgo/Makefile
+++ b/arch/riscv/boot/dts/sophgo/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
+dtb-$(CONFIG_ARCH_SOPHGO) += sg2002-licheerv-nano.dtb
 dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
diff --git a/arch/riscv/boot/dts/sophgo/sg2002-lichee-rv-nano.dts b/arch/riscv/boot/dts/sophgo/sg2002-lichee-rv-nano.dts
new file mode 100644
index 000000000000..aaad2733801b
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2002-lichee-rv-nano.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+ */
+
+/dts-v1/;
+
+#include "sg2002.dtsi"
+
+/ {
+	model = "LicheeRV Nano";
+	compatible = "sipeed,licheerv-nano", "sophgo,sg2002";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};

-- 
2.45.1


