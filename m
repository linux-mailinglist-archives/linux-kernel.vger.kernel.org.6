Return-Path: <linux-kernel+bounces-245596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4358F92B4C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB8E1C21FD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F81581E3;
	Tue,  9 Jul 2024 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OG5NbqLD"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2673156677;
	Tue,  9 Jul 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519650; cv=none; b=DRADQNkC34yMG1SEGZdBV97eK4OcI9+whWZr0kYXh1oHp5v1LJdP9/pLPHUKfofvXHn6z5WGWF6umCcr1wXy/sNbaOsz3vih+0mq8i3gnQHZAuiL3R0zA/zfKrqvaL7/kHSjWuojV4utRwzD3wlKp58sAK9HQjT/QVIlRI0JTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519650; c=relaxed/simple;
	bh=5KKw6M74A/DclraUTuoBJCsigKAUo94+LXOXkaaNZcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ysezp/X4hLQVaSIH/lqRDP6dOcLLOpVNMJPtd6+PtJE7QQQWF90Hn/ccDimT15c3H4XATnSAQvebhXapDeDefmUyAxh6hZGnigNatIXzYQpTSPVh3usVdT35fK2uV1ceECvVBdeWPJA7lzHsPr07ykgkCCkBPC2wTcI4nHxgo0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OG5NbqLD; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89A6C4000D;
	Tue,  9 Jul 2024 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720519646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ES8mi7d+KSw4EqedKB92e7v4sIMF0mwW3Ict+VP51AU=;
	b=OG5NbqLDCZjIVYYEUEpydKqEgnUS2ISHAhyus72wN8mPU9VLi8sNlv2ZeyIq+gaPg/twZO
	DSk9KwzEfjEtR/MVQPOBArnRqobi0nK4vodab2PZIGka9JLfE/yWCZnFbBEbNWFlvIfkIl
	rNholjGdHPOw+N8qT1cQF9VPoKXbVb86Q6Ik0ItnuAuu6VUbMMyZEBNHsDXwpTGkDhk130
	1FUzp2yeuX7fVYc2xjRgrB+7JpCSdV6zwyIxeGrxbo0j4+JmIERL6Ovy6psxcDMkhBv2y/
	NOme7KpDrtvuNmv4ifF5hitt6J0ZsfvMHfyAEAghDIYngs7x6GIdY5A3TkdI+w==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Tue, 09 Jul 2024 12:07:20 +0200
Subject: [PATCH v3 5/5] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-sg2002-v3-5-af779c3d139d@bootlin.com>
References: <20240709-sg2002-v3-0-af779c3d139d@bootlin.com>
In-Reply-To: <20240709-sg2002-v3-0-af779c3d139d@bootlin.com>
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


