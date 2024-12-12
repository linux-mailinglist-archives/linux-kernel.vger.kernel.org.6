Return-Path: <linux-kernel+bounces-443363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D09EEE27
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EE528456D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782C02253E1;
	Thu, 12 Dec 2024 15:53:09 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0E223E75;
	Thu, 12 Dec 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018789; cv=none; b=ekPvpKWWjj4L7CgAeQVPhKQMH7C0rOzVpbiORkiYVGL0R4JvA/X+NW1iEr0D8TTz6s74W+q4YjzoUKK4tOOosQpQ5iaDns5a67Sx1slP5ow7jW5DbH20nfOrBcXbPjN1wNT3/1EIValE9zqkFbIGYsKjq0PEvr3OgM7tjtZIXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018789; c=relaxed/simple;
	bh=AseAYxvnzp9vGsdK1oESWwM6Hxjfx2LV3lcIVuR67cA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fN4cC6V/B0vA9QlJh8rnNWHR5dQOpz3ZAxdgiyLQRkW6YgPFiaNkc2jLK5Sovoyr/7rIhT/9DV1tFZvZDvpYWjwFaULer3/JmMSU/iOYq9DlUhUp8ZAW7faBwgCk4hOVcb6mQFIeGiD+p2vf2osOQ2wMpmhqZT5+8MXNni4OjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 12 Dec
 2024 23:52:42 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 12 Dec 2024 23:52:42 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <tglx@linutronix.de>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <konradybcio@kernel.org>,
	<neil.armstrong@linaro.org>, <johan+linaro@kernel.org>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <soc@lists.linux.dev>
Subject: [PATCH v3 5/6] arm64: dts: aspeed: Add initial AST2700 EVB device tree
Date: Thu, 12 Dec 2024 23:52:36 +0800
Message-ID: <20241212155237.848336-8-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add EVB board of AST2700 in ASPEED Architecture.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 arch/arm64/boot/dts/aspeed/Makefile        |  4 ++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts | 57 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts

diff --git a/arch/arm64/boot/dts/aspeed/Makefile b/arch/arm64/boot/dts/aspeed/Makefile
new file mode 100644
index 000000000000..ffe7e15017cc
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtb-$(CONFIG_ARCH_ASPEED) += \
+	ast2700-evb.dtb
diff --git a/arch/arm64/boot/dts/aspeed/ast2700-evb.dts b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
new file mode 100644
index 000000000000..6dad88c98ce0
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+
+#include "aspeed-g7.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "AST2700A1-EVB";
+	compatible = "aspeed,ast2700-evb", "aspeed,ast2700";
+
+	aliases {
+		serial12 = &uart12;
+	};
+
+	chosen {
+		bootargs = "console=ttyS12,115200n8";
+		stdout-path = &uart12;
+	};
+
+	firmware {
+		optee: optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	memory@400000000 {
+		device_type = "memory";
+		reg = <0x4 0x00000000 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		mcu_fw: mcu-firmware@42fe00000 {
+			reg = <0x4 0x2fe00000 0x200000>;
+			no-map;
+		};
+
+		atf: trusted-firmware-a@430000000 {
+			reg = <0x4 0x30000000 0x80000>;
+			no-map;
+		};
+
+		optee_core: optee_core@430080000 {
+			reg = <0x4 0x30080000 0x1000000>;
+			no-map;
+		};
+	};
+};
+
+&uart12 {
+	status = "okay";
+};
-- 
2.34.1


