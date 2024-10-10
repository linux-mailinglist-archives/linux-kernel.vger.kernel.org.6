Return-Path: <linux-kernel+bounces-359406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD7998B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892811C25226
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876AC1CEACF;
	Thu, 10 Oct 2024 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iTf8Wn0a"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC121C9DE5;
	Thu, 10 Oct 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572898; cv=none; b=Swv13MfQbb8QShnfuBoj5NOWjcKKXxYC6qRlwCcfRqitfTESpJeDg2S1F0k09TV4JAQHOEXbfD6XAF99g9yu56QCUxRQe+/rKTWeIh3EdbiXX1mF0HkOUqdKJBgcx1gwIUt/4eMsTFfZ3mmjp7j12L+JgziT+2Y2lY1rAGSpnLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572898; c=relaxed/simple;
	bh=wD4i9kj/9audO4B4bzXaWXVPo7h0jiAhECyhyOHq/1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWd4NyjPQy5NLLRZq0DNDNsY/FZPELZ+dou/+tf2G5OY4WAMgr0sLFDeVdp40eNETKErMTlvLlSRk8+Mt9FEnPAKKGlpy3IBKwaTH2B0dKd4TUQWCiHn9NuRotLOKnc7HzKybiQo4ntzUuivcpXJJ5bqZNZ7Gn8XS0RJpoO9Pdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iTf8Wn0a; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF13A1C0004;
	Thu, 10 Oct 2024 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728572888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YNBiAIMY5vY73m87Shuq7HuEaUnsKbDGfj0sIKXoEg=;
	b=iTf8Wn0aGkGTEZdNtHdcMECbuLWCy9mXdN8rCdsruUa1+g4zBODdhyUXZoFRdvJDtvvt87
	Nzh7HHBaWT8QXnm1/z49JFihNcJ9aQ/SCbpb0m93dkF68PnhvMnw0hQAOA2I0eQRYxm2Zb
	r/qPGrk8ixKWlIEZ7JTC95k5hWLIOW6iGrU4zuKwbakrqWd70lo5bfK4sUooS/8F9mcXmS
	wXoInCNNoehbvzwWOUf/yMVrVW+f0f0NxOCLWARhfkw89kNru5wURMmRmo13NxL+abQmvQ
	SA+wlS6riQ2M/mK+ZaNn/sJqwafhRdY8dbYNV122Emz+smEnn9NYVO0qeu3Z5Q==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 10 Oct 2024 17:07:07 +0200
Subject: [PATCH v5 2/2] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-sg2002-v5-2-a0f2e582b932@bootlin.com>
References: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>
In-Reply-To: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>
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
X-Mailer: b4 0.14.2
X-GND-Sasl: thomas.bonnefille@bootlin.com

LicheeRV Nano B [1] is an embedded development platform based on the SOPHGO
SG2002 chip, the B(ase) version is deprived of Wifi/Bluetooth and Ethernet.

Add only support for UART and SDHCI.

Link: https://wiki.sipeed.com/hardware/en/lichee/RV_Nano/1_intro.html [1]

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/Makefile                |  1 +
 .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 95 ++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
index 57ad82a61ea6fc25f72d0ade991e33feaa53266e..47d4243a8f35a7d5572dbf5ef9899297b908afde 100644
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
index 0000000000000000000000000000000000000000..86a712b953a5acd5926120db61354243f5580a05
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
@@ -0,0 +1,95 @@
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
+&pinctrl {
+	uart0_cfg: uart0-cfg {
+		uart0-pins {
+			pinmux = <PINMUX(PIN_UART0_TX, 0)>,
+				 <PINMUX(PIN_UART0_RX, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+	};
+
+	sdhci0_cfg: sdhci0-cfg {
+		sdhci0-clk-pins {
+			pinmux = <PINMUX(PIN_SD0_CLK, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <16100>;
+			power-source = <3300>;
+		};
+
+		sdhci0-cmd-pins {
+			pinmux = <PINMUX(PIN_SD0_CMD, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+
+		sdhci0-data-pins {
+			pinmux = <PINMUX(PIN_SD0_D0, 0)>,
+				 <PINMUX(PIN_SD0_D1, 0)>,
+				 <PINMUX(PIN_SD0_D2, 0)>,
+				 <PINMUX(PIN_SD0_D3, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+
+		sdhci0-cd-pins {
+			pinmux = <PINMUX(PIN_SD0_CD, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+	};
+};
+
+&sdhci0 {
+	pinctrl-0 = <&sdhci0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.47.0


