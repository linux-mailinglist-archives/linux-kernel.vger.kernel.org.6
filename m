Return-Path: <linux-kernel+bounces-517875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF1CA386E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94BB164FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD95E22370C;
	Mon, 17 Feb 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="Jk4cR9Mg"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D522333E;
	Mon, 17 Feb 2025 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803629; cv=pass; b=C588M22o8QkksIT4ZRbP0DIQud9ahry8+dq/DTq4FHckm6rWIyeRSpsMF9knXovfO/0f0OTpX+OjpD3aPSt0PHTIQFpXenL7H3w9J0t/wnLY92tO24mQNIhRcF3jbELs3GhTMQyYCpIfiP+zZZatNh0SXp+vY4UIvXMP0qhAPhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803629; c=relaxed/simple;
	bh=2kDeGFPRU5ySinR8BTj8CnBGsOS8PfC/VAHys1rOVcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IT981AIV8m9+L6j6TeZFkRN3PoZjVKRDyaAqRCmc1ZMkFapLe5fL2UMHSYBHdgOK5ODDBqKSIGOyLe4UiCBdtU6tHgH9zGPuOwxu1iuRIwrML5zU7HlJ1l/rSeDiEB5eJXfBMBXPqprPaHK+kW7MsYUc0IqS5R7ew9ybxr/ZwVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=Jk4cR9Mg; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1739803585; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NEiXNyaUnQNcDD/3M4HGswGeK0aiNIzEyaWOD6OYcRY1Yts/ZsNBlZqI1PO6/+qd8CiVf4Z74LgxrxFt3ZF0o3hsbwJDQmDozybkQpJee9Nwu47MoEgmeKx4c9xvzVpIZkK7u9z5anSaKDvOwNXfBizqJVviGJ70SZmSxM2yOE4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739803585; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Syb9XStZ74dZ9UjkC86uQY//S07l8lYvVVc6rFRliac=; 
	b=Y7F3obk5zEMPYG69EUQKtLKHfFAfVASqIZjhH5YZKxp5eAzlhTDMdDi5QVxIDp+WmsQxpuvdbbG5Z/C4wRbSn6/xCYqrEZrucRkG0yfuz3slp4vmmcseN7KwwvdCeS398IMF112dSYBnOV4I8XZdBcYR32R87RDuJZW+/sGueVU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739803585;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=Syb9XStZ74dZ9UjkC86uQY//S07l8lYvVVc6rFRliac=;
	b=Jk4cR9Mg/3Brb4Q4WEgmjUc/b3sScSv5n9wvSP6XEhPg+qYsH+5RFXwGfIthcrT7
	ZsbOGl7AbQJu/dTzbSfsyXUuOSrVYuHg2IJbpZeIKlDpvlVKq9+3XXvaoheRrwSg/D3
	QuESQ9xGxEzTH+wIIL028D4y2RTMUp4LaVv2NQMk=
Received: by mx.zohomail.com with SMTPS id 1739803582319344.185427226967;
	Mon, 17 Feb 2025 06:46:22 -0800 (PST)
From: Xukai Wang <kingxukai@zohomail.com>
Date: Mon, 17 Feb 2025 22:45:18 +0800
Subject: [PATCH v4 3/3] riscv: dts: canaan: Add clock initial support for
 K230
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-b4-k230-clk-v4-3-5a95a3458691@zohomail.com>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
In-Reply-To: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xukai Wang <kingxukai@zohomail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Troy Mitchell <TroyMitchell988@gmail.com>
X-Mailer: b4 0.14.2
Feedback-ID: rr080112272ae0dc6991c3de45d50b17cb0000fc8b1965e0e7c7867f8ee55a8061aab85b70c5ab7e4b8db1fe:zu08011227fc2bc9e2965e4fdb2f0c4b990000037bfd554c706be2b262157e58b81390c7fde98544147a77b5:rf0801122c6a9a65707d9fb9f7c57d64af0000a1040f8a940d2f1b116a7e43e5239e46863e3323289a3158bed9cc3d6397:ZohoMail
X-ZohoMailClient: External

This patch provides basic support for the K230 clock, which does not
cover all clocks.

The clock tree of the K230 SoC consists of OSC24M,
PLLs and sysclk.

Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
---
 arch/riscv/boot/dts/canaan/k230.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
index 95c1a3d8fb1192e30113d96d3e96329545bc6ae7..e50ba03c2c21597e5f7d04a652db08f84101cbfb 100644
--- a/arch/riscv/boot/dts/canaan/k230.dtsi
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -3,6 +3,7 @@
  * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
  */
 
+#include <dt-bindings/clock/canaan,k230-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 /dts-v1/;
@@ -65,6 +66,13 @@ apb_clk: apb-clk-clock {
 		#clock-cells = <0>;
 	};
 
+	osc24m: clock-24m {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24m";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -138,5 +146,29 @@ uart4: serial@91404000 {
 			reg-shift = <2>;
 			status = "disabled";
 		};
+
+		sysclk: clock-controller@91102000 {
+			compatible = "canaan,k230-clk";
+			reg = <0x0 0x91102000 0x0 0x1000>,
+			      <0x0 0x91100000 0x0 0x1000>;
+			clocks = <&osc24m>;
+			clock-output-names = "CPU0_ACLK", "CPU0_PLIC", "CPU0_NOC_DDRCP4",
+					     "CPU0_PCLK", "PMU_PCLK", "HS_HCLK_HIGH_SRC",
+					     "HS_HCLK_HIGH_GATE", "HS_HCLK_SRC",
+					     "HS_SD0_HS_AHB_GAT", "HS_SD1_HS_AHB_GAT",
+					     "HS_SSI1_HS_AHB_GA", "HS_SSI2_HS_AHB_GA",
+					     "HS_USB0_HS_AHB_GA", "HS_USB1_HS_AHB_GA",
+					     "HS_SSI0_AXI", "HS_SSI1", "HS_SSI2",
+					     "HS_QSPI_AXI_SRC", "HS_SSI1_ACLK_GATE",
+					     "HS_SSI2_ACLK_GATE", "HS_SD_CARD_SRC",
+					     "HS_SD0_CARD_TX", "HS_SD1_CARD_TX",
+					     "HS_SD_AXI_SRC", "HS_SD0_AXI_GATE",
+					     "HS_SD1_AXI_GATE", "HS_SD0_BASE_GATE",
+					     "HS_SD1_BASE_GATE", "HS_OSPI_SRC",
+					     "HS_USB_REF_51M", "HS_SD_TIMER_SRC",
+					     "HS_SD0_TIMER_GATE", "HS_SD1_TIMER_GATE",
+					     "HS_USB0_REFERENCE", "HS_USB1_REFERENCE";
+			#clock-cells = <1>;
+		};
 	};
 };

-- 
2.34.1


