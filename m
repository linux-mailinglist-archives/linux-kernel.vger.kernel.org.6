Return-Path: <linux-kernel+bounces-263142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8093D1A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8891F2256B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F0F17B435;
	Fri, 26 Jul 2024 11:05:21 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C517B412;
	Fri, 26 Jul 2024 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991921; cv=none; b=WUqlo/ARrg2iXxNR7ffSU3KOUT4pHrQdhhlQHi3I40OfDQjxSYZhTSWhrEiOa0gOeqtT5WbE+J/dkSvE8QxvQvA0ecp2KIZcxaWLP4UZ/B2DdznpDKjR37u5KBFYkSySn9TzjsrWJ9EIYUY6VBKK8GVHMb+TfmE83QMXmAtZ8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991921; c=relaxed/simple;
	bh=oPwXtuOY3Bg2kiUcugVwV0nQfAmXer1mfonhKMYof8A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qv+rpGBDKLJ6dpwYfpUqVhHdw5KfbZGjHNNy5BohFTkzzRiggXuyCW1OgXd1G1dKJIp/qxpqwLJTz0UiqpPrt9fxNAC52xQWbgUOPaim1GXwxcRsNSqn+4moMsuM+nTLJAYEWFbKqrNeTrpEgCfh8tEw6k5bGlAmRTFBSOL6p6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 26 Jul
 2024 19:04:00 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 26 Jul 2024 19:04:00 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <lee@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <soc@kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>, <quic_bjorande@quicinc.com>,
	<geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
	<shawnguo@kernel.org>, <neil.armstrong@linaro.org>,
	<m.szyprowski@samsung.com>, <nfraprado@collabora.com>, <u-kumar1@ti.com>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v1 09/10] arm64: dts: aspeed: Add initial AST2700 EVB device tree
Date: Fri, 26 Jul 2024 19:03:54 +0800
Message-ID: <20240726110355.2181563-10-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

---
 arch/arm64/boot/dts/aspeed/Makefile        |  4 ++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts | 50 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)
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
index 000000000000..187c458e566b
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+
+#include "aspeed-g7.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "AST2700A1-EVB";
+	compatible = "aspeed,ast2700a1-evb", "aspeed,ast2700";
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
+		reg = <0x4 0x00000000 0x0 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		mcu_fw: mcu-firmware@42fe00000 {
+			reg = <0x4 0x2fe00000 0x0 0x200000>;
+			no-map;
+		};
+
+		atf: trusted-firmware-a@430000000 {
+			reg = <0x4 0x30000000 0x0 0x80000>;
+			no-map;
+		};
+
+		optee_core: optee_core@430080000 {
+			reg = <0x4 0x30080000 0x0 0x1000000>;
+			no-map;
+		};
+	};
+};
+
-- 
2.34.1


