Return-Path: <linux-kernel+bounces-248932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0287592E405
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08B3285DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD4A1598EC;
	Thu, 11 Jul 2024 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZE5BXLR5"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B02F1586F5;
	Thu, 11 Jul 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692106; cv=none; b=jYiVXuC9n8B0arjHxz0qKNlJ5L2QLaazjvc0MD6AsLxemXxUDVJaUbU43obN2yyx/r7rApm0K3f5GhQDtz5qkRiCqgnBAzEmOnZcSq8+DFHxR8nYnDzthMPs+raN4SxP4fNKZAqq6AKPaobsUPjP0Whbj15L/pl/gypUDOZ41wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692106; c=relaxed/simple;
	bh=5KKw6M74A/DclraUTuoBJCsigKAUo94+LXOXkaaNZcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDTTw8MSitIfaIHQ7xPG/ndz2mGCDDPj5XvcpmmCG1GJt7XH2oGOpfTjwi/OEMgsyZj2XqDqm8Z14GpSTbvgnfSgYr1A/byl/VIAIPoTlWdISxR8skNU4tkYNn4ndjsnYa9LCYIJBBhip9Ufk3llrhL1Ily+KcQunZlOapF7SFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZE5BXLR5; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CE8F24000B;
	Thu, 11 Jul 2024 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720692097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ES8mi7d+KSw4EqedKB92e7v4sIMF0mwW3Ict+VP51AU=;
	b=ZE5BXLR57bsa5m7g8Ihks6LcaGQ8UnM1nMs8mFExm5NEkou3gUFQKZ5WJlV6Hi/mb3mBig
	VQ8y4xj4eCAKeWRL45ml+xuVcdRPNQO+QAqrvHBlQbxTMMyK3MHUDMsyoSyOEsL29K7QjM
	KaOnaur4TlpZ8lYTSQGGW/B0HSRH/GCzEPAWsnBxzKHhCBVqD4E3JMaAS5reQ7aMDUPX78
	uG1cyGb/JsYfIPC9EP0anORiJlLY/RduY1LULOrZVOoXlXr8gjEVCM4i5WF5w/9tgvKQYW
	n5w0uZcDg/CWZjlcyFzBd2O/JPdBBBXTYkRRFZuoHAW53+dJ4qikKbQ45B2tXQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 11 Jul 2024 12:01:31 +0200
Subject: [PATCH v4 4/4] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-sg2002-v4-4-d97ec2367095@bootlin.com>
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
In-Reply-To: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

LicheeRV Nano B [1] is an embedded development platform based on the SOPHGO
SG2002 chip, the B(ase) version is deprived of Wifi/Bluetooth and Ethernet.

Add only support for UART and SDHCI.

Link: https://wiki.sipeed.com/hardware/en/lichee/RV_Nano/1_intro.html [1]

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/Makefile                |  1 +
 .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 54 ++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
index 57ad82a61ea6..47d4243a8f35 100644
--- a/arch/riscv/boot/dts/sophgo/Makefile
+++ b/arch/riscv/boot/dts/sophgo/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
+dtb-$(CONFIG_ARCH_SOPHGO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
diff --git a/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts b/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
new file mode 100644
index 000000000000..fc98b6a0ddf7
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
@@ -0,0 +1,54 @@
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
+	model = "LicheeRV Nano B";
+	compatible = "sipeed,licheerv-nano-b", "sipeed,licheerv-nano", "sophgo,sg2002";
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&osc {
+	clock-frequency = <25000000>;
+};
+
+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};

-- 
2.45.2


