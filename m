Return-Path: <linux-kernel+bounces-536152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54757A47C19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6484D166108
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF779227E82;
	Thu, 27 Feb 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CY15q0GJ"
Received: from mail-m1973193.qiye.163.com (mail-m1973193.qiye.163.com [220.197.31.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B07228CBA;
	Thu, 27 Feb 2025 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655498; cv=none; b=E/ChQV1OEppN9TJhAGHlXWBGRFtsV82BC5rFSvCCQXEdG+nHdaQXJkCcE5VO2sM9FbzbYDr+gQLNHOMsvN48dCpNKkUbOP+W4hdS+xtLSfbD3BNRyU3QdM4EPxAACUWpsZB12ZXYdwVP3eertNi/1fB0laA3vT69nB4SqQO8YKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655498; c=relaxed/simple;
	bh=Oxki5UMokR7Ja4E61zs28SwTAymTU14ipJd1f2JHKws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m9QUJUI50TId4MsdMPTAyJ5dDYwfn3GTylg/Cu1Iw26U3rThBUMhl28Oev31hH1vnS2lK+krOxDau4aHBP5G1J8QaD+Tfmu7kvlcG2efG6wxYvkyCvuSmTbDlvexSlpQXjLmDm3xjcconjmAyu0quUYW9KrFgipNNZcU+qqwnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CY15q0GJ; arc=none smtp.client-ip=220.197.31.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65f97f9;
	Thu, 27 Feb 2025 19:19:41 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	ulf.hansson@linaro.org,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 14/15] arm64: dts: rockchip: add core dtsi for RK3562 Soc
Date: Thu, 27 Feb 2025 19:19:12 +0800
Message-Id: <20250227111913.2344207-15-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227111913.2344207-1-kever.yang@rock-chips.com>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNJT1YfT0xDS0JDS0MaQh9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a954722405903afkunmc65f97f9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6DRw4ITINFQ0XEkMvHlYa
	EAIaFB1VSlVKTE9LTU5OSkNITkpIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCTkNMSDcG
DKIM-Signature:a=rsa-sha256;
	b=CY15q0GJmMHFU+pSgVF35BW5TRDNfNc84EujbbEvJbMhEnRLp7LsMMtck7hf/C4MazN/pz9IWXU7x/JZVXdY1ZtYIHUJUGYCpnFoM8SIzB8beWC50qiLNqRSmkhV1q14D4mhgRzXD/WIZfyi+IkBNhpqoG6V040A7gYDgRkJjjg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=rpLKDVwKzkCT1kaH5uKymcxe+IVKx9vpTZt34DSrTsc=;
	h=date:mime-version:subject:message-id:from;

From: Finley Xiao <finley.xiao@rock-chips.com>

RK3562 is a Soc from Rockchip, which embedded with quad
ARM Cortex-A53.


Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- remove i2c/serial/spi alias
- add soc node

Changes in v2:
- remove grf in cru
- Update some properties order

 .../boot/dts/rockchip/rk3562-pinctrl.dtsi     | 2352 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3562.dtsi      | 1374 ++++++++++
 2 files changed, 3726 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3562-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3562.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3562-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3562-pinctrl.dtsi
new file mode 100644
index 000000000000..b311448d77a3
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3562-pinctrl.dtsi
@@ -0,0 +1,2352 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ */
+
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rockchip-pinconf.dtsi"
+
+/*
+ * This file is auto generated by pin2dts tool, please keep these code
+ * by adding changes at end of this file.
+ */
+&pinctrl {
+	cam {
+		/omit-if-no-ref/
+		camm0_clk0_out: camm0-clk0-out {
+			rockchip,pins =
+				/* camm0_clk0_out */
+				<3 RK_PB2 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		camm0_clk1_out: camm0-clk1-out {
+			rockchip,pins =
+				/* camm0_clk1_out */
+				<3 RK_PB3 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		camm1_clk0_out: camm1-clk0-out {
+			rockchip,pins =
+				/* camm1_clk0_out */
+				<4 RK_PB1 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		camm1_clk1_out: camm1-clk1-out {
+			rockchip,pins =
+				/* camm1_clk1_out */
+				<4 RK_PB7 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		cam_clk2_out: cam-clk2-out {
+			rockchip,pins =
+				/* cam_clk2_out */
+				<3 RK_PB4 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		cam_clk3_out: cam-clk3-out {
+			rockchip,pins =
+				/* cam_clk3_out */
+				<3 RK_PB5 2 &pcfg_pull_none>;
+		};
+	};
+
+	can0 {
+		/omit-if-no-ref/
+		can0m0_pins: can0m0-pins {
+			rockchip,pins =
+				/* can0_rx_m0 */
+				<3 RK_PA1 4 &pcfg_pull_none>,
+				/* can0_tx_m0 */
+				<3 RK_PA0 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		can0m1_pins: can0m1-pins {
+			rockchip,pins =
+				/* can0_rx_m1 */
+				<3 RK_PB7 6 &pcfg_pull_none>,
+				/* can0_tx_m1 */
+				<3 RK_PB6 6 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		can0m2_pins: can0m2-pins {
+			rockchip,pins =
+				/* can0_rx_m2 */
+				<0 RK_PC7 2 &pcfg_pull_none>,
+				/* can0_tx_m2 */
+				<0 RK_PC6 2 &pcfg_pull_none>;
+		};
+	};
+
+	can1 {
+		/omit-if-no-ref/
+		can1m0_pins: can1m0-pins {
+			rockchip,pins =
+				/* can1_rx_m0 */
+				<1 RK_PB7 4 &pcfg_pull_none>,
+				/* can1_tx_m0 */
+				<1 RK_PC0 5 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		can1m1_pins: can1m1-pins {
+			rockchip,pins =
+				/* can1_rx_m1 */
+				<0 RK_PC1 4 &pcfg_pull_none>,
+				/* can1_tx_m1 */
+				<0 RK_PC0 4 &pcfg_pull_none>;
+		};
+	};
+
+	clk {
+		/omit-if-no-ref/
+		clk_32k_in: clk-32k-in {
+			rockchip,pins =
+				/* clk_32k_in */
+				<0 RK_PB0 1 &pcfg_pull_none>;
+		};
+	};
+
+	clk0 {
+		/omit-if-no-ref/
+		clk0_32k_out: clk0-32k-out {
+			rockchip,pins =
+				/* clk0_32k_out */
+				<0 RK_PB0 2 &pcfg_pull_none>;
+		};
+	};
+
+	clk1 {
+		/omit-if-no-ref/
+		clk1_32k_out: clk1-32k-out {
+			rockchip,pins =
+				/* clk1_32k_out */
+				<2 RK_PA1 3 &pcfg_pull_none>;
+		};
+	};
+
+	cpu {
+		/omit-if-no-ref/
+		cpu_pins: cpu-pins {
+			rockchip,pins =
+				/* cpu_avs */
+				<0 RK_PB7 3 &pcfg_pull_none>;
+		};
+	};
+
+	dsm {
+		/omit-if-no-ref/
+		dsm_pins: dsm-pins {
+			rockchip,pins =
+				/* dsm_aud_ln */
+				<1 RK_PB4 5 &pcfg_pull_none>,
+				/* dsm_aud_lp */
+				<1 RK_PB3 5 &pcfg_pull_none>,
+				/* dsm_aud_rn */
+				<1 RK_PB6 6 &pcfg_pull_none>,
+				/* dsm_aud_rp */
+				<1 RK_PB5 6 &pcfg_pull_none>;
+		};
+	};
+
+	emmc {
+		/omit-if-no-ref/
+		emmc_bus8: emmc-bus8 {
+			rockchip,pins =
+				/* emmc_d0 */
+				<1 RK_PA0 1 &pcfg_pull_up_drv_level_2>,
+				/* emmc_d1 */
+				<1 RK_PA1 1 &pcfg_pull_up_drv_level_2>,
+				/* emmc_d2 */
+				<1 RK_PA2 1 &pcfg_pull_up_drv_level_2>,
+				/* emmc_d3 */
+				<1 RK_PA3 1 &pcfg_pull_up_drv_level_2>,
+				/* emmc_d4 */
+				<1 RK_PA4 1 &pcfg_pull_up_drv_level_2>,
+				/* emmc_d5 */
+				<1 RK_PA5 1 &pcfg_pull_up_drv_level_2>,
+				/* emmc_d6 */
+				<1 RK_PA6 1 &pcfg_pull_up_drv_level_2>,
+				/* emmc_d7 */
+				<1 RK_PA7 1 &pcfg_pull_up_drv_level_2>;
+		};
+
+		/omit-if-no-ref/
+		emmc_clk: emmc-clk {
+			rockchip,pins =
+				/* emmc_clk */
+				<1 RK_PB1 1 &pcfg_pull_up_drv_level_2>;
+		};
+
+		/omit-if-no-ref/
+		emmc_cmd: emmc-cmd {
+			rockchip,pins =
+				/* emmc_cmd */
+				<1 RK_PB0 1 &pcfg_pull_up_drv_level_2>;
+		};
+
+		/omit-if-no-ref/
+		emmc_strb: emmc-strb {
+			rockchip,pins =
+				/* emmc_strb */
+				<1 RK_PB2 1 &pcfg_pull_none>;
+		};
+	};
+
+	eth {
+		/omit-if-no-ref/
+		ethm0_pins: ethm0-pins {
+			rockchip,pins =
+				/* eth_clk_25m_out_m0 */
+				<4 RK_PB1 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		ethm1_pins: ethm1-pins {
+			rockchip,pins =
+				/* eth_clk_25m_out_m1 */
+				<2 RK_PA1 2 &pcfg_pull_none>;
+		};
+	};
+
+	fspi {
+		/omit-if-no-ref/
+		fspi_pins: fspi-pins {
+			rockchip,pins =
+				/* fspi_clk */
+				<1 RK_PB1 2 &pcfg_pull_none>,
+				/* fspi_d0 */
+				<1 RK_PA0 2 &pcfg_pull_none>,
+				/* fspi_d1 */
+				<1 RK_PA1 2 &pcfg_pull_none>,
+				/* fspi_d2 */
+				<1 RK_PA2 2 &pcfg_pull_none>,
+				/* fspi_d3 */
+				<1 RK_PA3 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		fspi_csn0: fspi-csn0 {
+			rockchip,pins =
+				/* fspi_csn0 */
+				<1 RK_PB0 2 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		fspi_csn1: fspi-csn1 {
+			rockchip,pins =
+				/* fspi_csn1 */
+				<1 RK_PB2 2 &pcfg_pull_none>;
+		};
+	};
+
+	gpu {
+		/omit-if-no-ref/
+		gpu_pins: gpu-pins {
+			rockchip,pins =
+				/* gpu_avs */
+				<0 RK_PC0 3 &pcfg_pull_none>;
+		};
+	};
+
+	i2c0 {
+		/omit-if-no-ref/
+		i2c0_xfer: i2c0-xfer {
+			rockchip,pins =
+				/* i2c0_scl */
+				<0 RK_PB1 1 &pcfg_pull_none_smt>,
+				/* i2c0_sda */
+				<0 RK_PB2 1 &pcfg_pull_none_smt>;
+		};
+	};
+
+	i2c1 {
+		/omit-if-no-ref/
+		i2c1m0_xfer: i2c1m0-xfer {
+			rockchip,pins =
+				/* i2c1_scl_m0 */
+				<0 RK_PB3 1 &pcfg_pull_none_smt>,
+				/* i2c1_sda_m0 */
+				<0 RK_PB4 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2c1m1_xfer: i2c1m1-xfer {
+			rockchip,pins =
+				/* i2c1_scl_m1 */
+				<4 RK_PB4 5 &pcfg_pull_none_smt>,
+				/* i2c1_sda_m1 */
+				<4 RK_PB5 5 &pcfg_pull_none_smt>;
+		};
+	};
+
+	i2c2 {
+		/omit-if-no-ref/
+		i2c2m0_xfer: i2c2m0-xfer {
+			rockchip,pins =
+				/* i2c2_scl_m0 */
+				<0 RK_PB5 1 &pcfg_pull_none_smt>,
+				/* i2c2_sda_m0 */
+				<0 RK_PB6 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2c2m1_xfer: i2c2m1-xfer {
+			rockchip,pins =
+				/* i2c2_scl_m1 */
+				<3 RK_PD2 5 &pcfg_pull_none_smt>,
+				/* i2c2_sda_m1 */
+				<3 RK_PD3 5 &pcfg_pull_none_smt>;
+		};
+	};
+
+	i2c3 {
+		/omit-if-no-ref/
+		i2c3m0_xfer: i2c3m0-xfer {
+			rockchip,pins =
+				/* i2c3_scl_m0 */
+				<3 RK_PA0 1 &pcfg_pull_none_smt>,
+				/* i2c3_sda_m0 */
+				<3 RK_PA1 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2c3m1_xfer: i2c3m1-xfer {
+			rockchip,pins =
+				/* i2c3_scl_m1 */
+				<4 RK_PA5 5 &pcfg_pull_none_smt>,
+				/* i2c3_sda_m1 */
+				<4 RK_PA6 5 &pcfg_pull_none_smt>;
+		};
+	};
+
+	i2c4 {
+		/omit-if-no-ref/
+		i2c4m0_xfer: i2c4m0-xfer {
+			rockchip,pins =
+				/* i2c4_scl_m0 */
+				<3 RK_PB6 5 &pcfg_pull_none_smt>,
+				/* i2c4_sda_m0 */
+				<3 RK_PB7 5 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2c4m1_xfer: i2c4m1-xfer {
+			rockchip,pins =
+				/* i2c4_scl_m1 */
+				<0 RK_PA5 2 &pcfg_pull_none_smt>,
+				/* i2c4_sda_m1 */
+				<0 RK_PA4 2 &pcfg_pull_none_smt>;
+		};
+	};
+
+	i2c5 {
+		/omit-if-no-ref/
+		i2c5m0_xfer: i2c5m0-xfer {
+			rockchip,pins =
+				/* i2c5_scl_m0 */
+				<3 RK_PC2 1 &pcfg_pull_none_smt>,
+				/* i2c5_sda_m0 */
+				<3 RK_PC3 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2c5m1_xfer: i2c5m1-xfer {
+			rockchip,pins =
+				/* i2c5_scl_m1 */
+				<1 RK_PC7 4 &pcfg_pull_none_smt>,
+				/* i2c5_sda_m1 */
+				<1 RK_PD0 4 &pcfg_pull_none_smt>;
+		};
+	};
+
+	i2s0 {
+		/omit-if-no-ref/
+		i2s0m0_lrck: i2s0m0-lrck {
+			rockchip,pins =
+				/* i2s0_lrck_m0 */
+				<3 RK_PA4 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m0_mclk: i2s0m0-mclk {
+			rockchip,pins =
+				/* i2s0_mclk_m0 */
+				<3 RK_PA2 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m0_sclk: i2s0m0-sclk {
+			rockchip,pins =
+				/* i2s0_sclk_m0 */
+				<3 RK_PA3 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m0_sdi0: i2s0m0-sdi0 {
+			rockchip,pins =
+				/* i2s0_sdi0_m0 */
+				<3 RK_PB1 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m0_sdi1: i2s0m0-sdi1 {
+			rockchip,pins =
+				/* i2s0_sdi1_m0 */
+				<3 RK_PB0 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m0_sdi2: i2s0m0-sdi2 {
+			rockchip,pins =
+				/* i2s0_sdi2_m0 */
+				<3 RK_PA7 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m0_sdi3: i2s0m0-sdi3 {
+			rockchip,pins =
+				/* i2s0_sdi3_m0 */
+				<3 RK_PA6 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m0_sdo0: i2s0m0-sdo0 {
+			rockchip,pins =
+				/* i2s0_sdo0_m0 */
+				<3 RK_PA5 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m0_sdo1: i2s0m0-sdo1 {
+			rockchip,pins =
+				/* i2s0_sdo1_m0 */
+				<3 RK_PA6 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m0_sdo2: i2s0m0-sdo2 {
+			rockchip,pins =
+				/* i2s0_sdo2_m0 */
+				<3 RK_PA7 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m0_sdo3: i2s0m0-sdo3 {
+			rockchip,pins =
+				/* i2s0_sdo3_m0 */
+				<3 RK_PB0 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m1_lrck: i2s0m1-lrck {
+			rockchip,pins =
+				/* i2s0_lrck_m1 */
+				<1 RK_PC4 3 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m1_mclk: i2s0m1-mclk {
+			rockchip,pins =
+				/* i2s0_mclk_m1 */
+				<1 RK_PC6 3 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m1_sclk: i2s0m1-sclk {
+			rockchip,pins =
+				/* i2s0_sclk_m1 */
+				<1 RK_PC5 3 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m1_sdi0: i2s0m1-sdi0 {
+			rockchip,pins =
+				/* i2s0_sdi0_m1 */
+				<1 RK_PC1 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m1_sdi1: i2s0m1-sdi1 {
+			rockchip,pins =
+				/* i2s0_sdi1_m1 */
+				<1 RK_PC2 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m1_sdi2: i2s0m1-sdi2 {
+			rockchip,pins =
+				/* i2s0_sdi2_m1 */
+				<1 RK_PD3 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m1_sdi3: i2s0m1-sdi3 {
+			rockchip,pins =
+				/* i2s0_sdi3_m1 */
+				<1 RK_PD4 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m1_sdo0: i2s0m1-sdo0 {
+			rockchip,pins =
+				/* i2s0_sdo0_m1 */
+				<1 RK_PC3 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m1_sdo1: i2s0m1-sdo1 {
+			rockchip,pins =
+				/* i2s0_sdo1_m1 */
+				<1 RK_PD1 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m1_sdo2: i2s0m1-sdo2 {
+			rockchip,pins =
+				/* i2s0_sdo2_m1 */
+				<1 RK_PD2 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s0m1_sdo3: i2s0m1-sdo3 {
+			rockchip,pins =
+				/* i2s0_sdo3_m1 */
+				<2 RK_PA1 5 &pcfg_pull_none>;
+		};
+	};
+
+	i2s1 {
+		/omit-if-no-ref/
+		i2s1m0_lrck: i2s1m0-lrck {
+			rockchip,pins =
+				/* i2s1_lrck_m0 */
+				<3 RK_PC6 2 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m0_mclk: i2s1m0-mclk {
+			rockchip,pins =
+				/* i2s1_mclk_m0 */
+				<3 RK_PC4 2 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m0_sclk: i2s1m0-sclk {
+			rockchip,pins =
+				/* i2s1_sclk_m0 */
+				<3 RK_PC5 2 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m0_sdi0: i2s1m0-sdi0 {
+			rockchip,pins =
+				/* i2s1_sdi0_m0 */
+				<3 RK_PD0 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m0_sdi1: i2s1m0-sdi1 {
+			rockchip,pins =
+				/* i2s1_sdi1_m0 */
+				<3 RK_PD1 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m0_sdi2: i2s1m0-sdi2 {
+			rockchip,pins =
+				/* i2s1_sdi2_m0 */
+				<3 RK_PD2 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m0_sdi3: i2s1m0-sdi3 {
+			rockchip,pins =
+				/* i2s1_sdi3_m0 */
+				<3 RK_PD3 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m0_sdo0: i2s1m0-sdo0 {
+			rockchip,pins =
+				/* i2s1_sdo0_m0 */
+				<3 RK_PC7 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m0_sdo1: i2s1m0-sdo1 {
+			rockchip,pins =
+				/* i2s1_sdo1_m0 */
+				<4 RK_PB4 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m0_sdo2: i2s1m0-sdo2 {
+			rockchip,pins =
+				/* i2s1_sdo2_m0 */
+				<4 RK_PB5 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m0_sdo3: i2s1m0-sdo3 {
+			rockchip,pins =
+				/* i2s1_sdo3_m0 */
+				<4 RK_PB6 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m1_lrck: i2s1m1-lrck {
+			rockchip,pins =
+				/* i2s1_lrck_m1 */
+				<3 RK_PB4 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m1_mclk: i2s1m1-mclk {
+			rockchip,pins =
+				/* i2s1_mclk_m1 */
+				<3 RK_PB2 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m1_sclk: i2s1m1-sclk {
+			rockchip,pins =
+				/* i2s1_sclk_m1 */
+				<3 RK_PB3 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m1_sdi0: i2s1m1-sdi0 {
+			rockchip,pins =
+				/* i2s1_sdi0_m1 */
+				<3 RK_PC1 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m1_sdi1: i2s1m1-sdi1 {
+			rockchip,pins =
+				/* i2s1_sdi1_m1 */
+				<3 RK_PC0 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m1_sdi2: i2s1m1-sdi2 {
+			rockchip,pins =
+				/* i2s1_sdi2_m1 */
+				<3 RK_PB7 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m1_sdi3: i2s1m1-sdi3 {
+			rockchip,pins =
+				/* i2s1_sdi3_m1 */
+				<3 RK_PB6 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m1_sdo0: i2s1m1-sdo0 {
+			rockchip,pins =
+				/* i2s1_sdo0_m1 */
+				<3 RK_PB5 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m1_sdo1: i2s1m1-sdo1 {
+			rockchip,pins =
+				/* i2s1_sdo1_m1 */
+				<3 RK_PB6 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m1_sdo2: i2s1m1-sdo2 {
+			rockchip,pins =
+				/* i2s1_sdo2_m1 */
+				<3 RK_PB7 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s1m1_sdo3: i2s1m1-sdo3 {
+			rockchip,pins =
+				/* i2s1_sdo3_m1 */
+				<3 RK_PC0 1 &pcfg_pull_none>;
+		};
+	};
+
+	i2s2 {
+		/omit-if-no-ref/
+		i2s2m0_lrck: i2s2m0-lrck {
+			rockchip,pins =
+				/* i2s2_lrck_m0 */
+				<1 RK_PD6 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m0_mclk: i2s2m0-mclk {
+			rockchip,pins =
+				/* i2s2_mclk_m0 */
+				<2 RK_PA1 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m0_sclk: i2s2m0-sclk {
+			rockchip,pins =
+				/* i2s2_sclk_m0 */
+				<1 RK_PD5 1 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m0_sdi: i2s2m0-sdi {
+			rockchip,pins =
+				/* i2s2_sdi_m0 */
+				<2 RK_PA0 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m0_sdo: i2s2m0-sdo {
+			rockchip,pins =
+				/* i2s2_sdo_m0 */
+				<1 RK_PD7 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m1_lrck: i2s2m1-lrck {
+			rockchip,pins =
+				/* i2s2_lrck_m1 */
+				<4 RK_PA1 3 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m1_mclk: i2s2m1-mclk {
+			rockchip,pins =
+				/* i2s2_mclk_m1 */
+				<3 RK_PD6 3 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m1_sclk: i2s2m1-sclk {
+			rockchip,pins =
+				/* i2s2_sclk_m1 */
+				<4 RK_PB1 4 &pcfg_pull_none_smt>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m1_sdi: i2s2m1-sdi {
+			rockchip,pins =
+				/* i2s2_sdi_m1 */
+				<3 RK_PD4 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m1_sdo: i2s2m1-sdo {
+			rockchip,pins =
+				/* i2s2_sdo_m1 */
+				<3 RK_PD5 4 &pcfg_pull_none>;
+		};
+	};
+
+	isp {
+		/omit-if-no-ref/
+		isp_pins: isp-pins {
+			rockchip,pins =
+				/* isp_flash_trigin */
+				<3 RK_PC1 2 &pcfg_pull_none>,
+				/* isp_flash_trigout */
+				<3 RK_PC3 2 &pcfg_pull_none>,
+				/* isp_prelight_trigout */
+				<3 RK_PC2 2 &pcfg_pull_none>;
+		};
+	};
+
+	jtag {
+		/omit-if-no-ref/
+		jtagm0_pins: jtagm0-pins {
+			rockchip,pins =
+				/* jtag_cpu_mcu_tck_m0 */
+				<0 RK_PD1 2 &pcfg_pull_none>,
+				/* jtag_cpu_mcu_tms_m0 */
+				<0 RK_PD0 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		jtagm1_pins: jtagm1-pins {
+			rockchip,pins =
+				/* jtag_cpu_mcu_tck_m1 */
+				<1 RK_PB5 2 &pcfg_pull_none>,
+				/* jtag_cpu_mcu_tms_m1 */
+				<1 RK_PB6 2 &pcfg_pull_none>;
+		};
+	};
+
+	npu {
+		/omit-if-no-ref/
+		npu_pins: npu-pins {
+			rockchip,pins =
+				/* npu_avs */
+				<0 RK_PC1 3 &pcfg_pull_none>;
+		};
+	};
+
+	pcie20 {
+		/omit-if-no-ref/
+		pcie20m0_pins: pcie20m0-pins {
+			rockchip,pins =
+				/* pcie20_clkreqn_m0 */
+				<0 RK_PA6 1 &pcfg_pull_none>,
+				/* pcie20_perstn_m0 */
+				<0 RK_PB5 2 &pcfg_pull_none>,
+				/* pcie20_waken_m0 */
+				<0 RK_PB6 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie20m1_pins: pcie20m1-pins {
+			rockchip,pins =
+				/* pcie20_clkreqn_m1 */
+				<3 RK_PA6 4 &pcfg_pull_none>,
+				/* pcie20_perstn_m1 */
+				<3 RK_PB0 4 &pcfg_pull_none>,
+				/* pcie20_waken_m1 */
+				<3 RK_PA7 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pcie20_buttonrstn: pcie20-buttonrstn {
+			rockchip,pins =
+				/* pcie20_buttonrstn */
+				<0 RK_PB0 3 &pcfg_pull_none>;
+		};
+	};
+
+	pdm {
+		/omit-if-no-ref/
+		pdmm0_clk0: pdmm0-clk0 {
+			rockchip,pins =
+				/* pdm_clk0_m0 */
+				<3 RK_PA6 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pdmm0_clk1: pdmm0-clk1 {
+			rockchip,pins =
+				/* pdm_clk1_m0 */
+				<3 RK_PA2 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pdmm0_sdi0: pdmm0-sdi0 {
+			rockchip,pins =
+				/* pdm_sdi0_m0 */
+				<3 RK_PB1 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pdmm0_sdi1: pdmm0-sdi1 {
+			rockchip,pins =
+				/* pdm_sdi1_m0 */
+				<3 RK_PB0 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pdmm0_sdi2: pdmm0-sdi2 {
+			rockchip,pins =
+				/* pdm_sdi2_m0 */
+				<3 RK_PA7 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pdmm0_sdi3: pdmm0-sdi3 {
+			rockchip,pins =
+				/* pdm_sdi3_m0 */
+				<3 RK_PA0 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pdmm1_clk0: pdmm1-clk0 {
+			rockchip,pins =
+				/* pdm_clk0_m1 */
+				<4 RK_PB7 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pdmm1_clk1: pdmm1-clk1 {
+			rockchip,pins =
+				/* pdm_clk1_m1 */
+				<4 RK_PB1 5 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pdmm1_sdi0: pdmm1-sdi0 {
+			rockchip,pins =
+				/* pdm_sdi0_m1 */
+				<4 RK_PA7 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pdmm1_sdi1: pdmm1-sdi1 {
+			rockchip,pins =
+				/* pdm_sdi1_m1 */
+				<4 RK_PB0 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pdmm1_sdi2: pdmm1-sdi2 {
+			rockchip,pins =
+				/* pdm_sdi2_m1 */
+				<4 RK_PA5 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		pdmm1_sdi3: pdmm1-sdi3 {
+			rockchip,pins =
+				/* pdm_sdi3_m1 */
+				<4 RK_PA6 4 &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		/omit-if-no-ref/
+		pmic_int: pmic-int {
+			rockchip,pins =
+				<0 RK_PA3 0 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		soc_slppin_gpio: soc-slppin-gpio {
+			rockchip,pins =
+				<0 RK_PA2 0 &pcfg_output_low>;
+		};
+
+		/omit-if-no-ref/
+		soc_slppin_slp: soc-slppin-slp {
+			rockchip,pins =
+				<0 RK_PA2 1 &pcfg_pull_none>;
+		};
+	};
+
+	pmu {
+		/omit-if-no-ref/
+		pmu_pins: pmu-pins {
+			rockchip,pins =
+				/* pmu_debug */
+				<0 RK_PA5 3 &pcfg_pull_none>;
+		};
+	};
+
+	pwm0 {
+		/omit-if-no-ref/
+		pwm0m0_pins: pwm0m0-pins {
+			rockchip,pins =
+				/* pwm0_m0 */
+				<0 RK_PC3 2 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm0m1_pins: pwm0m1-pins {
+			rockchip,pins =
+				/* pwm0_m1 */
+				<1 RK_PC5 4 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm1 {
+		/omit-if-no-ref/
+		pwm1m0_pins: pwm1m0-pins {
+			rockchip,pins =
+				/* pwm1_m0 */
+				<0 RK_PC4 2 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm1m1_pins: pwm1m1-pins {
+			rockchip,pins =
+				/* pwm1_m1 */
+				<1 RK_PC6 4 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm2 {
+		/omit-if-no-ref/
+		pwm2m0_pins: pwm2m0-pins {
+			rockchip,pins =
+				/* pwm2_m0 */
+				<0 RK_PC5 2 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm2m1_pins: pwm2m1-pins {
+			rockchip,pins =
+				/* pwm2_m1 */
+				<1 RK_PC7 3 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm3 {
+		/omit-if-no-ref/
+		pwm3m0_pins: pwm3m0-pins {
+			rockchip,pins =
+				/* pwm3_m0 */
+				<0 RK_PA7 1 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm3m1_pins: pwm3m1-pins {
+			rockchip,pins =
+				/* pwm3_m1 */
+				<1 RK_PD0 3 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm4 {
+		/omit-if-no-ref/
+		pwm4m0_pins: pwm4m0-pins {
+			rockchip,pins =
+				/* pwm4_m0 */
+				<0 RK_PB7 2 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm4m1_pins: pwm4m1-pins {
+			rockchip,pins =
+				/* pwm4_m1 */
+				<1 RK_PD1 4 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm5 {
+		/omit-if-no-ref/
+		pwm5m0_pins: pwm5m0-pins {
+			rockchip,pins =
+				/* pwm5_m0 */
+				<0 RK_PC2 2 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm5m1_pins: pwm5m1-pins {
+			rockchip,pins =
+				/* pwm5_m1 */
+				<1 RK_PD2 4 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm6 {
+		/omit-if-no-ref/
+		pwm6m0_pins: pwm6m0-pins {
+			rockchip,pins =
+				/* pwm6_m0 */
+				<0 RK_PC1 2 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm6m1_pins: pwm6m1-pins {
+			rockchip,pins =
+				/* pwm6_m1 */
+				<1 RK_PD3 4 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm7 {
+		/omit-if-no-ref/
+		pwm7m0_pins: pwm7m0-pins {
+			rockchip,pins =
+				/* pwm7_m0 */
+				<0 RK_PC0 2 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm7m1_pins: pwm7m1-pins {
+			rockchip,pins =
+				/* pwm7_m1 */
+				<1 RK_PD4 4 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm8 {
+		/omit-if-no-ref/
+		pwm8m0_pins: pwm8m0-pins {
+			rockchip,pins =
+				/* pwm8_m0 */
+				<3 RK_PA4 2 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm8m1_pins: pwm8m1-pins {
+			rockchip,pins =
+				/* pwm8_m1 */
+				<1 RK_PC1 4 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm9 {
+		/omit-if-no-ref/
+		pwm9m0_pins: pwm9m0-pins {
+			rockchip,pins =
+				/* pwm9_m0 */
+				<3 RK_PA5 2 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm9m1_pins: pwm9m1-pins {
+			rockchip,pins =
+				/* pwm9_m1 */
+				<1 RK_PC2 4 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm10 {
+		/omit-if-no-ref/
+		pwm10m0_pins: pwm10m0-pins {
+			rockchip,pins =
+				/* pwm10_m0 */
+				<1 RK_PB5 5 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm10m1_pins: pwm10m1-pins {
+			rockchip,pins =
+				/* pwm10_m1 */
+				<1 RK_PC3 4 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm11 {
+		/omit-if-no-ref/
+		pwm11m0_pins: pwm11m0-pins {
+			rockchip,pins =
+				/* pwm11_m0 */
+				<1 RK_PB6 5 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm11m1_pins: pwm11m1-pins {
+			rockchip,pins =
+				/* pwm11_m1 */
+				<1 RK_PC4 4 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm12 {
+		/omit-if-no-ref/
+		pwm12m0_pins: pwm12m0-pins {
+			rockchip,pins =
+				/* pwm12_m0 */
+				<4 RK_PA1 4 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm12m1_pins: pwm12m1-pins {
+			rockchip,pins =
+				/* pwm12_m1 */
+				<3 RK_PB4 5 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm13 {
+		/omit-if-no-ref/
+		pwm13m0_pins: pwm13m0-pins {
+			rockchip,pins =
+				/* pwm13_m0 */
+				<4 RK_PA4 3 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm13m1_pins: pwm13m1-pins {
+			rockchip,pins =
+				/* pwm13_m1 */
+				<3 RK_PB5 5 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm14 {
+		/omit-if-no-ref/
+		pwm14m0_pins: pwm14m0-pins {
+			rockchip,pins =
+				/* pwm14_m0 */
+				<3 RK_PC5 4 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm14m1_pins: pwm14m1-pins {
+			rockchip,pins =
+				/* pwm14_m1 */
+				<1 RK_PD7 5 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwm15 {
+		/omit-if-no-ref/
+		pwm15m0_pins: pwm15m0-pins {
+			rockchip,pins =
+				/* pwm15_m0 */
+				<3 RK_PC6 4 &pcfg_pull_none_drv_level_1>;
+		};
+
+		/omit-if-no-ref/
+		pwm15m1_pins: pwm15m1-pins {
+			rockchip,pins =
+				/* pwm15_m1 */
+				<2 RK_PA0 5 &pcfg_pull_none_drv_level_1>;
+		};
+	};
+
+	pwr {
+		/omit-if-no-ref/
+		pwr_pins: pwr-pins {
+			rockchip,pins =
+				/* pwr_ctrl0 */
+				<0 RK_PA2 1 &pcfg_pull_none>,
+				/* pwr_ctrl1 */
+				<0 RK_PA3 1 &pcfg_pull_none>;
+		};
+	};
+
+	ref {
+		/omit-if-no-ref/
+		ref_pins: ref-pins {
+			rockchip,pins =
+				/* ref_clk_out */
+				<0 RK_PA0 1 &pcfg_pull_none>;
+		};
+	};
+
+	rgmii {
+		/omit-if-no-ref/
+		rgmiim0_miim: rgmiim0-miim {
+			rockchip,pins =
+				/* rgmii_mdc_m0 */
+				<4 RK_PB2 2 &pcfg_pull_none>,
+				/* rgmii_mdio_m0 */
+				<4 RK_PB3 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim0_rx_er: rgmiim0-rx_er {
+			rockchip,pins =
+				/* rgmii_rxer_m0 */
+				<4 RK_PB0 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim0_rx_bus2: rgmiim0-rx_bus2 {
+			rockchip,pins =
+				/* rgmii_rxd0_m0 */
+				<4 RK_PA5 2 &pcfg_pull_none>,
+				/* rgmii_rxd1_m0 */
+				<4 RK_PA6 2 &pcfg_pull_none>,
+				/* rgmii_rxdv_m0 */
+				<4 RK_PA7 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim0_tx_bus2: rgmiim0-tx_bus2 {
+			rockchip,pins =
+				/* rgmii_txd0_m0 */
+				<4 RK_PA2 2 &pcfg_pull_none>,
+				/* rgmii_txd1_m0 */
+				<4 RK_PA3 2 &pcfg_pull_none>,
+				/* rgmii_txen_m0 */
+				<4 RK_PA4 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim0_rgmii_clk: rgmiim0-rgmii_clk {
+			rockchip,pins =
+				/* rgmii_rxclk_m0 */
+				<4 RK_PA1 2 &pcfg_pull_none>,
+				/* rgmii_txclk_m0 */
+				<3 RK_PD6 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim0_rgmii_bus: rgmiim0-rgmii_bus {
+			rockchip,pins =
+				/* rgmii_rxd2_m0 */
+				<3 RK_PD7 2 &pcfg_pull_none>,
+				/* rgmii_rxd3_m0 */
+				<4 RK_PA0 2 &pcfg_pull_none>,
+				/* rgmii_txd2_m0 */
+				<3 RK_PD4 2 &pcfg_pull_none>,
+				/* rgmii_txd3_m0 */
+				<3 RK_PD5 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim0_clk: rgmiim0-clk {
+			rockchip,pins =
+				/* rgmiim0_clk */
+				<4 RK_PB7 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim1_miim: rgmiim1-miim {
+			rockchip,pins =
+				/* rgmii_mdc_m1 */
+				<1 RK_PC7 2 &pcfg_pull_none>,
+				/* rgmii_mdio_m1 */
+				<1 RK_PD0 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim1_rx_er: rgmiim1-rx_er {
+			rockchip,pins =
+				/* rgmii_rxer_m1 */
+				<2 RK_PA0 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim1_rx_bus2: rgmiim1-rx_bus2 {
+			rockchip,pins =
+				/* rgmii_rxd0_m1 */
+				<1 RK_PD4 2 &pcfg_pull_none>,
+				/* rgmii_rxd1_m1 */
+				<1 RK_PD7 2 &pcfg_pull_none>,
+				/* rgmii_rxdv_m1 */
+				<1 RK_PD6 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim1_tx_bus2: rgmiim1-tx_bus2 {
+			rockchip,pins =
+				/* rgmii_txd0_m1 */
+				<1 RK_PD1 2 &pcfg_pull_none>,
+				/* rgmii_txd1_m1 */
+				<1 RK_PD2 2 &pcfg_pull_none>,
+				/* rgmii_txen_m1 */
+				<1 RK_PD3 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim1_rgmii_clk: rgmiim1-rgmii_clk {
+			rockchip,pins =
+				/* rgmii_rxclk_m1 */
+				<1 RK_PC6 2 &pcfg_pull_none>,
+				/* rgmii_txclk_m1 */
+				<1 RK_PC3 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim1_rgmii_bus: rgmiim1-rgmii_bus {
+			rockchip,pins =
+				/* rgmii_rxd2_m1 */
+				<1 RK_PC4 2 &pcfg_pull_none>,
+				/* rgmii_rxd3_m1 */
+				<1 RK_PC5 2 &pcfg_pull_none>,
+				/* rgmii_txd2_m1 */
+				<1 RK_PC1 2 &pcfg_pull_none>,
+				/* rgmii_txd3_m1 */
+				<1 RK_PC2 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		rgmiim1_clk: rgmiim1-clk {
+			rockchip,pins =
+				/* rgmiim1_clk */
+				<1 RK_PD5 2 &pcfg_pull_none>;
+		};
+	};
+
+	rmii {
+		/omit-if-no-ref/
+		rmii_pins: rmii-pins {
+			rockchip,pins =
+				/* rmii_clk */
+				<1 RK_PD5 5 &pcfg_pull_none>,
+				/* rmii_mdc */
+				<1 RK_PC7 5 &pcfg_pull_none>,
+				/* rmii_mdio */
+				<1 RK_PD0 5 &pcfg_pull_none>,
+				/* rmii_rxd0 */
+				<1 RK_PD4 5 &pcfg_pull_none>,
+				/* rmii_rxd1 */
+				<1 RK_PD7 6 &pcfg_pull_none>,
+				/* rmii_rxdv_crs */
+				<1 RK_PD6 5 &pcfg_pull_none>,
+				/* rmii_rxer */
+				<2 RK_PA0 6 &pcfg_pull_none>,
+				/* rmii_txd0 */
+				<1 RK_PD1 5 &pcfg_pull_none>,
+				/* rmii_txd1 */
+				<1 RK_PD2 5 &pcfg_pull_none>,
+				/* rmii_txen */
+				<1 RK_PD3 5 &pcfg_pull_none>;
+		};
+	};
+
+	sdmmc0 {
+		/omit-if-no-ref/
+		sdmmc0_bus4: sdmmc0-bus4 {
+			rockchip,pins =
+				/* sdmmc0_d0 */
+				<1 RK_PB3 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc0_d1 */
+				<1 RK_PB4 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc0_d2 */
+				<1 RK_PB5 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc0_d3 */
+				<1 RK_PB6 1 &pcfg_pull_up_drv_level_2>;
+		};
+
+		/omit-if-no-ref/
+		sdmmc0_clk: sdmmc0-clk {
+			rockchip,pins =
+				/* sdmmc0_clk */
+				<1 RK_PC0 1 &pcfg_pull_up_drv_level_2>;
+		};
+
+		/omit-if-no-ref/
+		sdmmc0_cmd: sdmmc0-cmd {
+			rockchip,pins =
+				/* sdmmc0_cmd */
+				<1 RK_PB7 1 &pcfg_pull_up_drv_level_2>;
+		};
+
+		/omit-if-no-ref/
+		sdmmc0_det: sdmmc0-det {
+			rockchip,pins =
+				/* sdmmc0_detn */
+				<0 RK_PA4 1 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		sdmmc0_pwren: sdmmc0-pwren {
+			rockchip,pins =
+				/* sdmmc0_pwren */
+				<0 RK_PA5 1 &pcfg_pull_none>;
+		};
+	};
+
+	sdmmc1 {
+		/omit-if-no-ref/
+		sdmmc1_bus4: sdmmc1-bus4 {
+			rockchip,pins =
+				/* sdmmc1_d0 */
+				<1 RK_PC1 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc1_d1 */
+				<1 RK_PC2 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc1_d2 */
+				<1 RK_PC3 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc1_d3 */
+				<1 RK_PC4 1 &pcfg_pull_up_drv_level_2>;
+		};
+
+		/omit-if-no-ref/
+		sdmmc1_clk: sdmmc1-clk {
+			rockchip,pins =
+				/* sdmmc1_clk */
+				<1 RK_PC6 1 &pcfg_pull_up_drv_level_2>;
+		};
+
+		/omit-if-no-ref/
+		sdmmc1_cmd: sdmmc1-cmd {
+			rockchip,pins =
+				/* sdmmc1_cmd */
+				<1 RK_PC5 1 &pcfg_pull_up_drv_level_2>;
+		};
+
+		/omit-if-no-ref/
+		sdmmc1_det: sdmmc1-det {
+			rockchip,pins =
+				/* sdmmc1_detn */
+				<1 RK_PD0 1 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		sdmmc1_pwren: sdmmc1-pwren {
+			rockchip,pins =
+				/* sdmmc1_pwren */
+				<1 RK_PC7 1 &pcfg_pull_none>;
+		};
+	};
+
+	spdif {
+		/omit-if-no-ref/
+		spdifm0_pins: spdifm0-pins {
+			rockchip,pins =
+				/* spdif_tx_m0 */
+				<3 RK_PA1 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		spdifm1_pins: spdifm1-pins {
+			rockchip,pins =
+				/* spdif_tx_m1 */
+				<0 RK_PB7 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		spdifm2_pins: spdifm2-pins {
+			rockchip,pins =
+				/* spdif_tx_m2 */
+				<1 RK_PB7 2 &pcfg_pull_none>;
+		};
+	};
+
+	spi0 {
+		/omit-if-no-ref/
+		spi0m0_pins: spi0m0-pins {
+			rockchip,pins =
+				/* spi0_clk_m0 */
+				<0 RK_PC3 3 &pcfg_pull_none_drv_level_3>,
+				/* spi0_miso_m0 */
+				<0 RK_PC5 3 &pcfg_pull_none_drv_level_3>,
+				/* spi0_mosi_m0 */
+				<0 RK_PC4 3 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		spi0m0_csn0: spi0m0-csn0 {
+			rockchip,pins =
+				/* spi0m0_csn0 */
+				<0 RK_PC2 3 &pcfg_pull_none_drv_level_3>;
+		};
+		/omit-if-no-ref/
+		spi0m0_csn1: spi0m0-csn1 {
+			rockchip,pins =
+				/* spi0m0_csn1 */
+				<0 RK_PB7 1 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		spi0m1_pins: spi0m1-pins {
+			rockchip,pins =
+				/* spi0_clk_m1 */
+				<3 RK_PB5 4 &pcfg_pull_none_drv_level_3>,
+				/* spi0_miso_m1 */
+				<3 RK_PC0 4 &pcfg_pull_none_drv_level_3>,
+				/* spi0_mosi_m1 */
+				<3 RK_PB4 4 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		spi0m1_csn0: spi0m1-csn0 {
+			rockchip,pins =
+				/* spi0m1_csn0 */
+				<3 RK_PB7 4 &pcfg_pull_none_drv_level_3>;
+		};
+		/omit-if-no-ref/
+		spi0m1_csn1: spi0m1-csn1 {
+			rockchip,pins =
+				/* spi0m1_csn1 */
+				<3 RK_PB6 4 &pcfg_pull_none_drv_level_3>;
+		};
+	};
+
+	spi1 {
+		/omit-if-no-ref/
+		spi1m0_pins: spi1m0-pins {
+			rockchip,pins =
+				/* spi1_clk_m0 */
+				<3 RK_PD6 4 &pcfg_pull_none_drv_level_3>,
+				/* spi1_miso_m0 */
+				<4 RK_PA3 4 &pcfg_pull_none_drv_level_3>,
+				/* spi1_mosi_m0 */
+				<4 RK_PA2 4 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		spi1m0_csn0: spi1m0-csn0 {
+			rockchip,pins =
+				/* spi1m0_csn0 */
+				<3 RK_PD7 4 &pcfg_pull_none_drv_level_3>;
+		};
+		/omit-if-no-ref/
+		spi1m0_csn1: spi1m0-csn1 {
+			rockchip,pins =
+				/* spi1m0_csn1 */
+				<4 RK_PA0 4 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		spi1m1_pins: spi1m1-pins {
+			rockchip,pins =
+				/* spi1_clk_m1 */
+				<1 RK_PC0 4 &pcfg_pull_none_drv_level_3>,
+				/* spi1_miso_m1 */
+				<1 RK_PB4 4 &pcfg_pull_none_drv_level_3>,
+				/* spi1_mosi_m1 */
+				<1 RK_PB3 4 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		spi1m1_csn0: spi1m1-csn0 {
+			rockchip,pins =
+				/* spi1m1_csn0 */
+				<1 RK_PB6 4 &pcfg_pull_none_drv_level_3>;
+		};
+		/omit-if-no-ref/
+		spi1m1_csn1: spi1m1-csn1 {
+			rockchip,pins =
+				/* spi1m1_csn1 */
+				<1 RK_PB5 4 &pcfg_pull_none_drv_level_3>;
+		};
+	};
+
+	spi2 {
+		/omit-if-no-ref/
+		spi2m0_pins: spi2m0-pins {
+			rockchip,pins =
+				/* spi2_clk_m0 */
+				<4 RK_PB6 4 &pcfg_pull_none_drv_level_3>,
+				/* spi2_miso_m0 */
+				<3 RK_PD2 4 &pcfg_pull_none_drv_level_3>,
+				/* spi2_mosi_m0 */
+				<3 RK_PD3 4 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		spi2m0_csn0: spi2m0-csn0 {
+			rockchip,pins =
+				/* spi2m0_csn0 */
+				<4 RK_PB5 4 &pcfg_pull_none_drv_level_3>;
+		};
+		/omit-if-no-ref/
+		spi2m0_csn1: spi2m0-csn1 {
+			rockchip,pins =
+				/* spi2m0_csn1 */
+				<4 RK_PB4 4 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		spi2m1_pins: spi2m1-pins {
+			rockchip,pins =
+				/* spi2_clk_m1 */
+				<2 RK_PA1 4 &pcfg_pull_none_drv_level_3>,
+				/* spi2_miso_m1 */
+				<2 RK_PA0 4 &pcfg_pull_none_drv_level_3>,
+				/* spi2_mosi_m1 */
+				<1 RK_PD7 4 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		spi2m1_csn0: spi2m1-csn0 {
+			rockchip,pins =
+				/* spi2m1_csn0 */
+				<1 RK_PD6 4 &pcfg_pull_none_drv_level_3>;
+		};
+		/omit-if-no-ref/
+		spi2m1_csn1: spi2m1-csn1 {
+			rockchip,pins =
+				/* spi2m1_csn1 */
+				<1 RK_PD5 4 &pcfg_pull_none_drv_level_3>;
+		};
+	};
+
+	tsadc {
+		/omit-if-no-ref/
+		tsadcm0_pins: tsadcm0-pins {
+			rockchip,pins =
+				/* tsadc_shut_m0 */
+				<0 RK_PA1 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		tsadcm1_pins: tsadcm1-pins {
+			rockchip,pins =
+				/* tsadc_shut_m1 */
+				<0 RK_PA2 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		tsadc_shut_org: tsadc-shut-org {
+			rockchip,pins =
+				/* tsadc_shut_org */
+				<0 RK_PA1 2 &pcfg_pull_none>;
+		};
+	};
+
+	uart0 {
+		/omit-if-no-ref/
+		uart0m0_xfer: uart0m0-xfer {
+			rockchip,pins =
+				/* uart0_rx_m0 */
+				<0 RK_PD0 1 &pcfg_pull_up>,
+				/* uart0_tx_m0 */
+				<0 RK_PD1 1 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart0m1_xfer: uart0m1-xfer {
+			rockchip,pins =
+				/* uart0_rx_m1 */
+				<1 RK_PB3 2 &pcfg_pull_up>,
+				/* uart0_tx_m1 */
+				<1 RK_PB4 2 &pcfg_pull_up>;
+		};
+	};
+
+	uart1 {
+		/omit-if-no-ref/
+		uart1m0_xfer: uart1m0-xfer {
+			rockchip,pins =
+				/* uart1_rx_m0 */
+				<1 RK_PD1 1 &pcfg_pull_up>,
+				/* uart1_tx_m0 */
+				<1 RK_PD2 1 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart1m0_ctsn: uart1m0-ctsn {
+			rockchip,pins =
+				/* uart1m0_ctsn */
+				<1 RK_PD4 1 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart1m0_rtsn: uart1m0-rtsn {
+			rockchip,pins =
+				/* uart1m0_rtsn */
+				<1 RK_PD3 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		uart1m1_xfer: uart1m1-xfer {
+			rockchip,pins =
+				/* uart1_rx_m1 */
+				<4 RK_PA6 3 &pcfg_pull_up>,
+				/* uart1_tx_m1 */
+				<4 RK_PA5 3 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart1m1_ctsn: uart1m1-ctsn {
+			rockchip,pins =
+				/* uart1m1_ctsn */
+				<4 RK_PB0 3 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart1m1_rtsn: uart1m1-rtsn {
+			rockchip,pins =
+				/* uart1m1_rtsn */
+				<4 RK_PA7 3 &pcfg_pull_none>;
+		};
+	};
+
+	uart2 {
+		/omit-if-no-ref/
+		uart2m0_xfer: uart2m0-xfer {
+			rockchip,pins =
+				/* uart2_rx_m0 */
+				<0 RK_PC1 1 &pcfg_pull_up>,
+				/* uart2_tx_m0 */
+				<0 RK_PC0 1 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart2m0_ctsn: uart2m0-ctsn {
+			rockchip,pins =
+				/* uart2m0_ctsn */
+				<0 RK_PC2 1 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart2m0_rtsn: uart2m0-rtsn {
+			rockchip,pins =
+				/* uart2m0_rtsn */
+				<0 RK_PC3 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		uart2m1_xfer: uart2m1-xfer {
+			rockchip,pins =
+				/* uart2_rx_m1 */
+				<3 RK_PA1 2 &pcfg_pull_up>,
+				/* uart2_tx_m1 */
+				<3 RK_PA0 2 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart2m1_ctsn: uart2m1-ctsn {
+			rockchip,pins =
+				/* uart2m1_ctsn */
+				<3 RK_PA2 2 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart2m1_rtsn: uart2m1-rtsn {
+			rockchip,pins =
+				/* uart2m1_rtsn */
+				<3 RK_PA3 2 &pcfg_pull_none>;
+		};
+	};
+
+	uart3 {
+		/omit-if-no-ref/
+		uart3m0_xfer: uart3m0-xfer {
+			rockchip,pins =
+				/* uart3_rx_m0 */
+				<4 RK_PB5 6 &pcfg_pull_up>,
+				/* uart3_tx_m0 */
+				<4 RK_PB4 6 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart3m0_ctsn: uart3m0-ctsn {
+			rockchip,pins =
+				/* uart3m0_ctsn */
+				<4 RK_PB6 3 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart3m0_rtsn: uart3m0-rtsn {
+			rockchip,pins =
+				/* uart3m0_rtsn */
+				<3 RK_PD1 4 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		uart3m1_xfer: uart3m1-xfer {
+			rockchip,pins =
+				/* uart3_rx_m1 */
+				<3 RK_PC0 3 &pcfg_pull_up>,
+				/* uart3_tx_m1 */
+				<3 RK_PB7 3 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart3m1_ctsn: uart3m1-ctsn {
+			rockchip,pins =
+				/* uart3m1_ctsn */
+				<3 RK_PB6 3 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart3m1_rtsn: uart3m1-rtsn {
+			rockchip,pins =
+				/* uart3m1_rtsn */
+				<3 RK_PC1 3 &pcfg_pull_none>;
+		};
+	};
+
+	uart4 {
+		/omit-if-no-ref/
+		uart4m0_xfer: uart4m0-xfer {
+			rockchip,pins =
+				/* uart4_rx_m0 */
+				<3 RK_PD1 3 &pcfg_pull_up>,
+				/* uart4_tx_m0 */
+				<3 RK_PD0 3 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart4m0_ctsn: uart4m0-ctsn {
+			rockchip,pins =
+				/* uart4m0_ctsn */
+				<3 RK_PC5 3 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart4m0_rtsn: uart4m0-rtsn {
+			rockchip,pins =
+				/* uart4m0_rtsn */
+				<3 RK_PC6 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		uart4m1_xfer: uart4m1-xfer {
+			rockchip,pins =
+				/* uart4_rx_m1 */
+				<1 RK_PD5 3 &pcfg_pull_up>,
+				/* uart4_tx_m1 */
+				<1 RK_PD6 3 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart4m1_ctsn: uart4m1-ctsn {
+			rockchip,pins =
+				/* uart4m1_ctsn */
+				<2 RK_PA0 3 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart4m1_rtsn: uart4m1-rtsn {
+			rockchip,pins =
+				/* uart4m1_rtsn */
+				<1 RK_PD7 3 &pcfg_pull_none>;
+		};
+	};
+
+	uart5 {
+		/omit-if-no-ref/
+		uart5m0_xfer: uart5m0-xfer {
+			rockchip,pins =
+				/* uart5_rx_m0 */
+				<1 RK_PB7 3 &pcfg_pull_up>,
+				/* uart5_tx_m0 */
+				<1 RK_PC0 3 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart5m0_ctsn: uart5m0-ctsn {
+			rockchip,pins =
+				/* uart5m0_ctsn */
+				<1 RK_PB5 3 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart5m0_rtsn: uart5m0-rtsn {
+			rockchip,pins =
+				/* uart5m0_rtsn */
+				<1 RK_PB6 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		uart5m1_xfer: uart5m1-xfer {
+			rockchip,pins =
+				/* uart5_rx_m1 */
+				<3 RK_PA7 5 &pcfg_pull_up>,
+				/* uart5_tx_m1 */
+				<3 RK_PA6 5 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart5m1_ctsn: uart5m1-ctsn {
+			rockchip,pins =
+				/* uart5m1_ctsn */
+				<3 RK_PA0 5 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart5m1_rtsn: uart5m1-rtsn {
+			rockchip,pins =
+				/* uart5m1_rtsn */
+				<3 RK_PA1 5 &pcfg_pull_none>;
+		};
+	};
+
+	uart6 {
+		/omit-if-no-ref/
+		uart6m0_xfer: uart6m0-xfer {
+			rockchip,pins =
+				/* uart6_rx_m0 */
+				<0 RK_PC7 1 &pcfg_pull_up>,
+				/* uart6_tx_m0 */
+				<0 RK_PC6 1 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart6m0_ctsn: uart6m0-ctsn {
+			rockchip,pins =
+				/* uart6m0_ctsn */
+				<0 RK_PC4 1 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart6m0_rtsn: uart6m0-rtsn {
+			rockchip,pins =
+				/* uart6m0_rtsn */
+				<0 RK_PC5 1 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		uart6m1_xfer: uart6m1-xfer {
+			rockchip,pins =
+				/* uart6_rx_m1 */
+				<4 RK_PB0 5 &pcfg_pull_up>,
+				/* uart6_tx_m1 */
+				<4 RK_PA7 5 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart6m1_ctsn: uart6m1-ctsn {
+			rockchip,pins =
+				/* uart6m1_ctsn */
+				<4 RK_PA2 3 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart6m1_rtsn: uart6m1-rtsn {
+			rockchip,pins =
+				/* uart6m1_rtsn */
+				<4 RK_PA3 3 &pcfg_pull_none>;
+		};
+	};
+
+	uart7 {
+		/omit-if-no-ref/
+		uart7m0_xfer: uart7m0-xfer {
+			rockchip,pins =
+				/* uart7_rx_m0 */
+				<3 RK_PC7 3 &pcfg_pull_up>,
+				/* uart7_tx_m0 */
+				<3 RK_PC4 3 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart7m0_ctsn: uart7m0-ctsn {
+			rockchip,pins =
+				/* uart7m0_ctsn */
+				<3 RK_PD2 3 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart7m0_rtsn: uart7m0-rtsn {
+			rockchip,pins =
+				/* uart7m0_rtsn */
+				<3 RK_PD3 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		uart7m1_xfer: uart7m1-xfer {
+			rockchip,pins =
+				/* uart7_rx_m1 */
+				<1 RK_PB3 3 &pcfg_pull_up>,
+				/* uart7_tx_m1 */
+				<1 RK_PB4 3 &pcfg_pull_up>;
+		};
+	};
+
+	uart8 {
+		/omit-if-no-ref/
+		uart8m0_xfer: uart8m0-xfer {
+			rockchip,pins =
+				/* uart8_rx_m0 */
+				<3 RK_PB3 3 &pcfg_pull_up>,
+				/* uart8_tx_m0 */
+				<3 RK_PB2 3 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart8m0_ctsn: uart8m0-ctsn {
+			rockchip,pins =
+				/* uart8m0_ctsn */
+				<3 RK_PB4 3 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart8m0_rtsn: uart8m0-rtsn {
+			rockchip,pins =
+				/* uart8m0_rtsn */
+				<3 RK_PB5 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		uart8m1_xfer: uart8m1-xfer {
+			rockchip,pins =
+				/* uart8_rx_m1 */
+				<3 RK_PD5 3 &pcfg_pull_up>,
+				/* uart8_tx_m1 */
+				<3 RK_PD4 3 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart8m1_ctsn: uart8m1-ctsn {
+			rockchip,pins =
+				/* uart8m1_ctsn */
+				<3 RK_PD7 3 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart8m1_rtsn: uart8m1-rtsn {
+			rockchip,pins =
+				/* uart8m1_rtsn */
+				<4 RK_PA0 3 &pcfg_pull_none>;
+		};
+	};
+
+	uart9 {
+		/omit-if-no-ref/
+		uart9m0_xfer: uart9m0-xfer {
+			rockchip,pins =
+				/* uart9_rx_m0 */
+				<4 RK_PB3 3 &pcfg_pull_up>,
+				/* uart9_tx_m0 */
+				<4 RK_PB2 3 &pcfg_pull_up>;
+		};
+
+		/omit-if-no-ref/
+		uart9m0_ctsn: uart9m0-ctsn {
+			rockchip,pins =
+				/* uart9m0_ctsn */
+				<4 RK_PB4 3 &pcfg_pull_none>;
+		};
+		/omit-if-no-ref/
+		uart9m0_rtsn: uart9m0-rtsn {
+			rockchip,pins =
+				/* uart9m0_rtsn */
+				<4 RK_PB5 3 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		uart9m1_xfer: uart9m1-xfer {
+			rockchip,pins =
+				/* uart9_rx_m1 */
+				<3 RK_PC3 3 &pcfg_pull_up>,
+				/* uart9_tx_m1 */
+				<3 RK_PC2 3 &pcfg_pull_up>;
+		};
+	};
+
+	vo {
+		/omit-if-no-ref/
+		vo_pins: vo-pins {
+			rockchip,pins =
+				/* vo_lcdc_clk */
+				<4 RK_PB7 1 &pcfg_pull_none_drv_level_4>,
+				/* vo_lcdc_d0 */
+				<4 RK_PA4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d1 */
+				<4 RK_PA5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d2 */
+				<4 RK_PB2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d3 */
+				<3 RK_PC4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d4 */
+				<3 RK_PC5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d5 */
+				<3 RK_PC6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d6 */
+				<3 RK_PC7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d7 */
+				<3 RK_PD0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d8 */
+				<4 RK_PA6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d9 */
+				<4 RK_PA7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d10 */
+				<3 RK_PD1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d11 */
+				<3 RK_PD2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d12 */
+				<3 RK_PD3 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d13 */
+				<3 RK_PD4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d14 */
+				<3 RK_PD5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d15 */
+				<3 RK_PD6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d16 */
+				<4 RK_PB0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d17 */
+				<4 RK_PB1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d18 */
+				<4 RK_PB3 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d19 */
+				<3 RK_PD7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d20 */
+				<4 RK_PA0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d21 */
+				<4 RK_PA1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d22 */
+				<4 RK_PA2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d23 */
+				<4 RK_PA3 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_den */
+				<4 RK_PB6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_hsync */
+				<4 RK_PB4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_vsync */
+				<4 RK_PB5 1 &pcfg_pull_none_drv_level_3>;
+		};
+	};
+};
+
+/*
+ * This part is edited handly.
+ */
+&pinctrl {
+	vo {
+		/omit-if-no-ref/
+		bt1120_pins: bt1120-pins {
+			rockchip,pins =
+				/* vo_lcdc_clk */
+				<4 RK_PB7 1 &pcfg_pull_none_drv_level_4>,
+				/* vo_lcdc_d3 */
+				<3 RK_PC4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d4 */
+				<3 RK_PC5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d5 */
+				<3 RK_PC6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d6 */
+				<3 RK_PC7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d7 */
+				<3 RK_PD0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d10 */
+				<3 RK_PD1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d11 */
+				<3 RK_PD2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d12 */
+				<3 RK_PD3 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d13 */
+				<3 RK_PD4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d14 */
+				<3 RK_PD5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d15 */
+				<3 RK_PD6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d19 */
+				<3 RK_PD7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d20 */
+				<4 RK_PA0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d21 */
+				<4 RK_PA1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d22 */
+				<4 RK_PA2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d23 */
+				<4 RK_PA3 1 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		bt656_pins: bt656-pins {
+			rockchip,pins =
+				/* vo_lcdc_clk */
+				<4 RK_PB7 1 &pcfg_pull_none_drv_level_4>,
+				/* vo_lcdc_d3 */
+				<3 RK_PC4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d4 */
+				<3 RK_PC5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d5 */
+				<3 RK_PC6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d6 */
+				<3 RK_PC7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d7 */
+				<3 RK_PD0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d10 */
+				<3 RK_PD1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d11 */
+				<3 RK_PD2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d12 */
+				<3 RK_PD3 1 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		rgb3x8_pins_m0: rgb3x8-pins-m0 {
+			rockchip,pins =
+				/* vo_lcdc_clk */
+				<4 RK_PB7 1 &pcfg_pull_none_drv_level_4>,
+				/* vo_lcdc_d3 */
+				<3 RK_PC4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d4 */
+				<3 RK_PC5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d5 */
+				<3 RK_PC6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d6 */
+				<3 RK_PC7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d7 */
+				<3 RK_PD0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d10 */
+				<3 RK_PD1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d11 */
+				<3 RK_PD2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d12 */
+				<3 RK_PD3 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_den */
+				<4 RK_PB6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_hsync */
+				<4 RK_PB4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_vsync */
+				<4 RK_PB5 1 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		rgb3x8_pins_m1: rgb3x8-pins-m1 {
+			rockchip,pins =
+				/* vo_lcdc_clk */
+				<4 RK_PB7 1 &pcfg_pull_none_drv_level_4>,
+				/* vo_lcdc_d13 */
+				<3 RK_PD4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d14 */
+				<3 RK_PD5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d15 */
+				<3 RK_PD6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d19 */
+				<3 RK_PD7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d20 */
+				<4 RK_PA0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d21 */
+				<4 RK_PA1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d22 */
+				<4 RK_PA2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d23 */
+				<4 RK_PA3 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_den */
+				<4 RK_PB6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_hsync */
+				<4 RK_PB4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_vsync */
+				<4 RK_PB5 1 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		rgb565_pins: rgb565-pins {
+			rockchip,pins =
+				/* vo_lcdc_clk */
+				<4 RK_PB7 1 &pcfg_pull_none_drv_level_4>,
+				/* vo_lcdc_d3 */
+				<3 RK_PC4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d4 */
+				<3 RK_PC5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d5 */
+				<3 RK_PC6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d6 */
+				<3 RK_PC7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d7 */
+				<3 RK_PD0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d10 */
+				<3 RK_PD1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d11 */
+				<3 RK_PD2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d12 */
+				<3 RK_PD3 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d13 */
+				<3 RK_PD4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d14 */
+				<3 RK_PD5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d15 */
+				<3 RK_PD6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d19 */
+				<3 RK_PD7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d20 */
+				<4 RK_PA0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d21 */
+				<4 RK_PA1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d22 */
+				<4 RK_PA2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d23 */
+				<4 RK_PA3 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_den */
+				<4 RK_PB6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_hsync */
+				<4 RK_PB4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_vsync */
+				<4 RK_PB5 1 &pcfg_pull_none_drv_level_3>;
+		};
+
+		/omit-if-no-ref/
+		rgb666_pins: rgb666-pins {
+			rockchip,pins =
+				/* vo_lcdc_clk */
+				<4 RK_PB7 1 &pcfg_pull_none_drv_level_4>,
+				/* vo_lcdc_d2 */
+				<4 RK_PB2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d3 */
+				<3 RK_PC4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d4 */
+				<3 RK_PC5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d5 */
+				<3 RK_PC6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d6 */
+				<3 RK_PC7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d7 */
+				<3 RK_PD0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d10 */
+				<3 RK_PD1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d11 */
+				<3 RK_PD2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d12 */
+				<3 RK_PD3 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d13 */
+				<3 RK_PD4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d14 */
+				<3 RK_PD5 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d15 */
+				<3 RK_PD6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d18 */
+				<4 RK_PB3 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d19 */
+				<3 RK_PD7 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d20 */
+				<4 RK_PA0 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d21 */
+				<4 RK_PA1 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d22 */
+				<4 RK_PA2 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_d23 */
+				<4 RK_PA3 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_den */
+				<4 RK_PB6 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_hsync */
+				<4 RK_PB4 1 &pcfg_pull_none_drv_level_3>,
+				/* vo_lcdc_vsync */
+				<4 RK_PB5 1 &pcfg_pull_none_drv_level_3>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3562.dtsi b/arch/arm64/boot/dts/rockchip/rk3562.dtsi
new file mode 100644
index 000000000000..ced9c5f56ae7
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3562.dtsi
@@ -0,0 +1,1374 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ */
+
+#include <dt-bindings/clock/rockchip,rk3562-cru.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/power/rockchip,rk3562-power.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/reset/rockchip,rk3562-cru.h>
+#include <dt-bindings/soc/rockchip,boot-mode.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	compatible = "rockchip,rk3562";
+
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
+	};
+
+	xin32k: clock-xin32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+	};
+
+	xin24m: clock-xin24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "xin24m";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			clocks = <&scmi_clk ARMCLK>;
+			cpu-idle-states = <&CPU_SLEEP>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <138>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			clocks = <&scmi_clk ARMCLK>;
+			cpu-idle-states = <&CPU_SLEEP>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <138>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			clocks = <&scmi_clk ARMCLK>;
+			cpu-idle-states = <&CPU_SLEEP>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <138>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			clocks = <&scmi_clk ARMCLK>;
+			cpu-idle-states = <&CPU_SLEEP>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <138>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+			CPU_SLEEP: cpu-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <120>;
+				exit-latency-us = <250>;
+				min-residency-us = <900>;
+			};
+		};
+	};
+
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <825000 825000 1150000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <825000 825000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <825000 825000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <925000 925000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1000000 1000000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1608000000 {
+			opp-supported-hw = <0xf9 0xffff>;
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <1037500 1037500 1150000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1125000 1125000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <1150000 1150000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+	};
+
+	gpu_opp_table: opp-table-gpu {
+		compatible = "operating-points-v2";
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <825000 825000 1000000>;
+		};
+		opp-400000000 {
+		opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <825000 825000 1000000>;
+		};
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <825000 825000 1000000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <825000 825000 1000000>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <900000 900000 1000000>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <950000 950000 1000000>;
+		};
+		opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+		};
+	};
+
+	arm_pmu: arm-pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	firmware {
+		scmi: scmi {
+			compatible = "arm,scmi-smc";
+			shmem = <&scmi_shmem>;
+			arm,smc-id = <0x82000010>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scmi_shmem: scmi-shmem@10f000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x0010f000 0x0 0x100>;
+		};
+
+		usbdrd_dwc3: usb@fe500000 {
+			compatible = "rockchip,rk3562-dwc3", "snps,dwc3";
+			reg = <0x0 0xfe500000 0x0 0x400000>;
+			clocks = <&cru CLK_USB3OTG_REF>, <&cru CLK_USB3OTG_SUSPEND>,
+				 <&cru ACLK_USB3OTG>, <&cru PCLK_PHP>;
+			clock-names = "ref_clk", "suspend_clk", "bus_clk", "pipe";
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3562_PD_PHP>;
+			resets = <&cru SRST_USB3OTG>;
+			dr_mode = "otg";
+			phys = <&u2phy_otg>;
+			phy-names = "usb2-phy";
+			phy_type = "utmi_wide";
+			snps,dis_enblslpm_quirk;
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,dis-del-phy-power-chg-quirk;
+			snps,dis-tx-ipgap-linecheck-quirk;
+			snps,dis_rxdet_inp3_quirk;
+			snps,parkmode-disable-hs-quirk;
+			snps,parkmode-disable-ss-quirk;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@fe901000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xfe901000 0 0x1000>,
+			      <0x0 0xfe902000 0 0x2000>,
+			      <0x0 0xfe904000 0 0x2000>,
+			      <0x0 0xfe906000 0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		usb_host0_ehci: usb@fed00000 {
+			compatible = "generic-ehci";
+			reg = <0x0 0xfed00000 0x0 0x40000>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru HCLK_USB2HOST>, <&cru HCLK_USB2HOST_ARB>,
+				 <&u2phy>;
+			phys = <&u2phy_host>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		usb_host0_ohci: usb@fed40000 {
+			compatible = "generic-ohci";
+			reg = <0x0 0xfed40000 0x0 0x40000>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru HCLK_USB2HOST>, <&cru HCLK_USB2HOST_ARB>,
+				 <&u2phy>;
+			phys = <&u2phy_host>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		qos_dma2ddr: qos@fee03800 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee03800 0x0 0x20>;
+		};
+
+		qos_mcu: qos@fee10000 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee10000 0x0 0x20>;
+		};
+
+		qos_dft_apb: qos@fee10100 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee10100 0x0 0x20>;
+		};
+
+		qos_gmac: qos@fee10200 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee10200 0x0 0x20>;
+		};
+
+		qos_mac100: qos@fee10300 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee10300 0x0 0x20>;
+		};
+
+		qos_dcf: qos@fee10400 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee10400 0x0 0x20>;
+		};
+
+		qos_cpu: qos@fee20000 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee20000 0x0 0x20>;
+		};
+
+		qos_gpu: qos@fee30000 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee30000 0x0 0x20>;
+		};
+
+		qos_npu: qos@fee40000 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee40000 0x0 0x20>;
+		};
+
+		qos_rkvdec: qos@fee50000 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee50000 0x0 0x20>;
+		};
+
+		qos_vepu: qos@fee60000 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee60000 0x0 0x20>;
+		};
+
+		qos_isp: qos@fee70000 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee70000 0x0 0x20>;
+		};
+
+		qos_vicap: qos@fee70100 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee70100 0x0 0x20>;
+		};
+
+		qos_vop: qos@fee80000 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee80000 0x0 0x20>;
+		};
+
+		qos_jpeg: qos@fee90000 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee90000 0x0 0x20>;
+		};
+
+		qos_rga_rd: qos@fee90100 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee90100 0x0 0x20>;
+		};
+
+		qos_rga_wr: qos@fee90200 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfee90200 0x0 0x20>;
+		};
+
+		qos_pcie: qos@feea0000 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfeea0000 0x0 0x20>;
+		};
+
+		qos_usb3: qos@feea0100 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfeea0100 0x0 0x20>;
+		};
+
+		qos_crypto_apb: qos@feeb0000 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfeeb0000 0x0 0x20>;
+		};
+
+		qos_crypto: qos@feeb0100 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfeeb0100 0x0 0x20>;
+		};
+
+		qos_dmac: qos@feeb0200 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfeeb0200 0x0 0x20>;
+		};
+
+		qos_emmc: qos@feeb0300 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfeeb0300 0x0 0x20>;
+		};
+
+		qos_fspi: qos@feeb0400 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfeeb0400 0x0 0x20>;
+		};
+
+		qos_rkdma: qos@feeb0500 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfeeb0500 0x0 0x20>;
+		};
+
+		qos_sdmmc0: qos@feeb0600 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfeeb0600 0x0 0x20>;
+		};
+
+		qos_sdmmc1: qos@feeb0700 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfeeb0700 0x0 0x20>;
+		};
+
+		qos_usb2: qos@feeb0800 {
+			compatible = "rockchip,rk3562-qos", "syscon";
+			reg = <0x0 0xfeeb0800 0x0 0x20>;
+		};
+
+		pmu_grf: syscon@ff010000 {
+			compatible = "rockchip,rk3562-pmu-grf", "syscon", "simple-mfd";
+			reg = <0x0 0xff010000 0x0 0x10000>;
+
+			reboot_mode: reboot-mode {
+				compatible = "syscon-reboot-mode";
+				offset = <0x220>;
+				mode-normal = <BOOT_NORMAL>;
+				mode-loader = <BOOT_BL_DOWNLOAD>;
+				mode-recovery = <BOOT_RECOVERY>;
+				mode-bootloader = <BOOT_FASTBOOT>;
+			};
+		};
+
+		sys_grf: syscon@ff030000 {
+			compatible = "rockchip,rk3562-sys-grf", "syscon";
+			reg = <0x0 0xff030000 0x0 0x10000>;
+		};
+
+		peri_grf: syscon@ff040000 {
+			compatible = "rockchip,rk3562-peri-grf", "syscon";
+			reg = <0x0 0xff040000 0x0 0x10000>;
+		};
+
+		ioc_grf: syscon@ff060000 {
+			compatible = "rockchip,rk3562-ioc-grf", "syscon";
+			reg = <0x0 0xff060000 0x0 0x30000>;
+		};
+
+		usbphy_grf: syscon@ff090000 {
+			compatible = "rockchip,rk3562-usbphy-grf", "syscon";
+			reg = <0x0 0xff090000 0x0 0x8000>;
+		};
+
+		pipephy_grf: syscon@ff098000 {
+			compatible = "rockchip,rk3562-pipephy-grf", "syscon";
+			reg = <0x0 0xff098000 0x0 0x8000>;
+		};
+
+		cru: clock-controller@ff100000 {
+			compatible = "rockchip,rk3562-cru";
+			reg = <0x0 0xff100000 0x0 0x40000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			assigned-clocks = <&cru PLL_GPLL>, <&cru PLL_CPLL>,
+					  <&cru PLL_HPLL>;
+			assigned-clock-rates = <1188000000>, <1000000000>,
+					       <983040000>;
+		};
+
+		i2c0: i2c@ff200000 {
+			compatible = "rockchip,rk3562-i2c", "rockchip,rk3399-i2c";
+			reg = <0x0 0xff200000 0x0 0x1000>;
+			clocks = <&cru CLK_PMU0_I2C0>, <&cru PCLK_PMU0_I2C0>;
+			clock-names = "i2c", "pclk";
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_xfer>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		uart0: serial@ff210000 {
+			compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xff210000 0x0 0x100>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_PMU1_UART0>, <&cru PCLK_PMU1_UART0>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		spi0: spi@ff220000 {
+			compatible = "rockchip,rk3562-spi", "rockchip,rk3066-spi";
+			reg = <0x0 0xff220000 0x0 0x1000>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cru CLK_PMU1_SPI0>, <&cru PCLK_PMU1_SPI0>;
+			clock-names = "spiclk", "apb_pclk";
+			dmas = <&dmac 13>, <&dmac 12>;
+			dma-names = "tx", "rx";
+			num-cs = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0m0_csn0 &spi0m0_csn1 &spi0m0_pins>;
+			status = "disabled";
+		};
+
+		pwm0: pwm@ff230000 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff230000 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm0m0_pins>;
+			clocks = <&cru CLK_PMU1_PWM0>, <&cru PCLK_PMU1_PWM0>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm1: pwm@ff230010 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff230010 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm1m0_pins>;
+			clocks = <&cru CLK_PMU1_PWM0>, <&cru PCLK_PMU1_PWM0>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm2: pwm@ff230020 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff230020 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm2m0_pins>;
+			clocks = <&cru CLK_PMU1_PWM0>, <&cru PCLK_PMU1_PWM0>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm3: pwm@ff230030 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff230030 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm3m0_pins>;
+			clocks = <&cru CLK_PMU1_PWM0>, <&cru PCLK_PMU1_PWM0>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pmu: power-management@ff258000 {
+			compatible = "rockchip,rk3562-pmu", "syscon", "simple-mfd";
+			reg = <0x0 0xff258000 0x0 0x1000>;
+
+			power: power-controller {
+				compatible = "rockchip,rk3562-power-controller";
+				#power-domain-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "okay";
+
+
+				power-domain@RK3562_PD_GPU {
+					reg = <RK3562_PD_GPU>;
+					pm_qos = <&qos_gpu>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@RK3562_PD_NPU {
+					reg = <RK3562_PD_NPU>;
+					pm_qos = <&qos_npu>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@RK3562_PD_VDPU {
+					reg = <RK3562_PD_VDPU>;
+					pm_qos = <&qos_rkvdec>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@RK3562_PD_VI {
+					reg = <RK3562_PD_VI>;
+					#power-domain-cells = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					pm_qos = <&qos_isp>,
+						 <&qos_vicap>;
+
+					power-domain@RK3562_PD_VEPU {
+						reg = <RK3562_PD_VEPU>;
+						pm_qos = <&qos_vepu>;
+					#power-domain-cells = <0>;
+					};
+				};
+
+				power-domain@RK3562_PD_VO {
+					reg = <RK3562_PD_VO>;
+					#power-domain-cells = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					pm_qos = <&qos_vop>;
+
+					power-domain@RK3562_PD_RGA {
+						reg = <RK3562_PD_RGA>;
+						pm_qos = <&qos_rga_rd>,
+							 <&qos_rga_wr>,
+							 <&qos_jpeg>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				power-domain@RK3562_PD_PHP {
+					reg = <RK3562_PD_PHP>;
+					pm_qos = <&qos_pcie>,
+						 <&qos_usb3>;
+					#power-domain-cells = <0>;
+				};
+			};
+		};
+
+		gpu: gpu@ff320000 {
+			compatible = "rockchip,rk3562-mali", "arm,mali-bifrost";
+			reg = <0x0 0xff320000 0x0 0x4000>;
+			clocks = <&cru CLK_GPU>, <&cru CLK_GPU_BRG>,
+				 <&cru ACLK_GPU_PRE>;
+			clock-names = "clk_gpu", "clk_gpu_brg", "aclk_gpu";
+			dynamic-power-coefficient = <820>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&power RK3562_PD_GPU>;
+			#cooling-cells = <2>;
+			status = "disabled";
+		};
+
+		pcie2x1: pcie@ff500000 {
+			compatible = "rockchip,rk3562-pcie", "rockchip,rk3568-pcie";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x0 0xff>;
+			clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
+				 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
+				 <&cru CLK_PCIE20_AUX>;
+			clock-names = "aclk_mst", "aclk_slv",
+				      "aclk_dbi", "pclk", "aux";
+			device_type = "pci";
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "sys", "pmc", "msg", "legacy", "err", "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie2x1_intc 0>,
+					<0 0 0 2 &pcie2x1_intc 1>,
+					<0 0 0 3 &pcie2x1_intc 2>,
+					<0 0 0 4 &pcie2x1_intc 3>;
+			linux,pci-domain = <0>;
+			max-link-speed = <2>;
+			num-ib-windows = <8>;
+			num-viewport = <8>;
+			num-ob-windows = <2>;
+			num-lanes = <1>;
+			phys = <&combphy_pu PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			power-domains = <&power RK3562_PD_PHP>;
+			ranges = <0x01000000 0x0 0xfc100000 0x0 0xfc100000 0x0 0x100000
+				  0x02000000 0x0 0xfc200000 0x0 0xfc200000 0x0 0x1e00000
+				  0x03000000 0x3 0x00000000 0x3 0x00000000 0x0 0x40000000>;
+			reg = <0x0 0xfe000000 0x0 0x400000>,
+			      <0x0 0xff500000 0x0 0x10000>,
+			      <0x0 0xfc000000 0x0 0x100000>;
+			reg-names = "dbi", "apb", "config";
+			resets = <&cru SRST_PCIE20_POWERUP>;
+			reset-names = "pipe";
+			status = "disabled";
+
+			pcie2x1_intc: legacy-interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		spi1: spi@ff640000 {
+			compatible = "rockchip,rk3066-spi";
+			reg = <0x0 0xff640000 0x0 0x1000>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cru CLK_SPI1>, <&cru PCLK_SPI1>;
+			clock-names = "spiclk", "apb_pclk";
+			dmas = <&dmac 15>, <&dmac 14>;
+			dma-names = "tx", "rx";
+			num-cs = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1m0_csn0 &spi1m0_csn1 &spi1m0_pins>;
+			status = "disabled";
+		};
+
+		spi2: spi@ff650000 {
+			compatible = "rockchip,rk3066-spi";
+			reg = <0x0 0xff650000 0x0 0x1000>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cru CLK_SPI2>, <&cru PCLK_SPI2>;
+			clock-names = "spiclk", "apb_pclk";
+			dmas = <&dmac 17>, <&dmac 16>;
+			dma-names = "tx", "rx";
+			num-cs = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi2m0_csn0 &spi2m0_csn1 &spi2m0_pins>;
+			status = "disabled";
+		};
+
+		uart1: serial@ff670000 {
+			compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xff670000 0x0 0x100>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart2: serial@ff680000 {
+			compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xff680000 0x0 0x100>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: serial@ff690000 {
+			compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xff690000 0x0 0x100>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart4: serial@ff6a0000 {
+			compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xff6a0000 0x0 0x100>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_UART4>, <&cru PCLK_UART4>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart5: serial@ff6b0000 {
+			compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xff6b0000 0x0 0x100>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_UART5>, <&cru PCLK_UART5>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart6: serial@ff6c0000 {
+			compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xff6c0000 0x0 0x100>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_UART6>, <&cru PCLK_UART6>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart7: serial@ff6d0000 {
+			compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xff6d0000 0x0 0x100>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_UART7>, <&cru PCLK_UART7>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart8: serial@ff6e0000 {
+			compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xff6e0000 0x0 0x100>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_UART8>, <&cru PCLK_UART8>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart9: serial@ff6f0000 {
+			compatible = "rockchip,rk3562-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xff6f0000 0x0 0x100>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_UART9>, <&cru PCLK_UART9>;
+			clock-names = "baudclk", "apb_pclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@ff700000 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff700000 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm4m0_pins>;
+			clocks = <&cru CLK_PWM1_PERI>, <&cru PCLK_PWM1_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm5: pwm@ff700010 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff700010 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm5m0_pins>;
+			clocks = <&cru CLK_PWM1_PERI>, <&cru PCLK_PWM1_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm6: pwm@ff700020 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff700020 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm6m0_pins>;
+			clocks = <&cru CLK_PWM1_PERI>, <&cru PCLK_PWM1_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm7: pwm@ff700030 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff700030 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm7m0_pins>;
+			clocks = <&cru CLK_PWM1_PERI>, <&cru PCLK_PWM1_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm8: pwm@ff710000 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff710000 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm8m0_pins>;
+			clocks = <&cru CLK_PWM2_PERI>, <&cru PCLK_PWM2_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm9: pwm@ff710010 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff710010 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm9m0_pins>;
+			clocks = <&cru CLK_PWM2_PERI>, <&cru PCLK_PWM2_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm10: pwm@ff710020 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff710020 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm10m0_pins>;
+			clocks = <&cru CLK_PWM2_PERI>, <&cru PCLK_PWM2_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm11: pwm@ff710030 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff710030 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm11m0_pins>;
+			clocks = <&cru CLK_PWM2_PERI>, <&cru PCLK_PWM2_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm12: pwm@ff720000 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff720000 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm12m0_pins>;
+			clocks = <&cru CLK_PWM3_PERI>, <&cru PCLK_PWM3_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm13: pwm@ff720010 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff720010 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm13m0_pins>;
+			clocks = <&cru CLK_PWM3_PERI>, <&cru PCLK_PWM3_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm14: pwm@ff720020 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff720020 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm14m0_pins>;
+			clocks = <&cru CLK_PWM3_PERI>, <&cru PCLK_PWM3_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		pwm15: pwm@ff720030 {
+			compatible = "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";
+			reg = <0x0 0xff720030 0x0 0x10>;
+			#pwm-cells = <3>;
+			pinctrl-names = "active";
+			pinctrl-0 = <&pwm15m0_pins>;
+			clocks = <&cru CLK_PWM3_PERI>, <&cru PCLK_PWM3_PERI>;
+			clock-names = "pwm", "pclk";
+			status = "disabled";
+		};
+
+		saradc0: adc@ff730000 {
+			compatible = "rockchip,rk3562-saradc";
+			reg = <0x0 0xff730000 0x0 0x100>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			#io-channel-cells = <1>;
+			clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
+			clock-names = "saradc", "apb_pclk";
+			resets = <&cru SRST_P_SARADC>;
+			reset-names = "saradc-apb";
+			status = "disabled";
+		};
+
+		u2phy: usb2-phy@ff740000 {
+			compatible = "rockchip,rk3562-usb2phy";
+			reg = <0x0 0xff740000 0x0 0x10000>;
+			clocks = <&cru CLK_USB2PHY_REF>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			clock-output-names = "usb480m_phy";
+			rockchip,usbgrf = <&usbphy_grf>;
+			status = "disabled";
+
+			u2phy_otg: otg-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "otg-bvalid", "otg-id", "linestate";
+				status = "disabled";
+			};
+
+			u2phy_host: host-port {
+				#phy-cells = <0>;
+				interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
+				status = "disabled";
+			};
+		};
+
+		combphy_pu: phy@ff750000 {
+			compatible = "rockchip,rk3562-naneng-combphy";
+			reg = <0x0 0xff750000 0x0 0x100>;
+			#phy-cells = <1>;
+			clocks = <&cru CLK_PIPEPHY_REF>, <&cru PCLK_PIPEPHY>,
+				 <&cru PCLK_PHP>;
+			clock-names = "ref", "apb", "pipe";
+			assigned-clocks = <&cru CLK_PIPEPHY_REF>;
+			assigned-clock-rates = <100000000>;
+			resets = <&cru SRST_PIPEPHY>;
+			reset-names = "phy";
+			rockchip,pipe-grf = <&peri_grf>;
+			rockchip,pipe-phy-grf = <&pipephy_grf>;
+			status = "disabled";
+		};
+
+		sfc: spi@ff860000 {
+			compatible = "rockchip,sfc";
+			reg = <0x0 0xff860000 0x0 0x10000>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+			clock-names = "clk_sfc", "hclk_sfc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		sdhci: mmc@ff870000 {
+			compatible = "rockchip,rk3562-dwcmshc", "rockchip,rk3588-dwcmshc";
+			reg = <0x0 0xff870000 0x0 0x10000>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			assigned-clocks = <&cru BCLK_EMMC>, <&cru CCLK_EMMC>;
+			assigned-clock-rates = <200000000>, <200000000>;
+			clocks = <&cru CCLK_EMMC>, <&cru HCLK_EMMC>,
+				 <&cru ACLK_EMMC>, <&cru BCLK_EMMC>,
+				 <&cru TMCLK_EMMC>;
+			clock-names = "core", "bus", "axi", "block", "timer";
+			resets = <&cru SRST_C_EMMC>, <&cru SRST_H_EMMC>,
+				 <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
+				 <&cru SRST_T_EMMC>;
+			reset-names = "core", "bus", "axi", "block", "timer";
+			max-frequency = <200000000>;
+			status = "disabled";
+		};
+
+		sdmmc0: mmc@ff880000 {
+			compatible = "rockchip,rk3562-dw-mshc",
+				     "rockchip,rk3288-dw-mshc";
+			reg = <0x0 0xff880000 0x0 0x10000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <200000000>;
+			clocks = <&cru HCLK_SDMMC0>, <&cru CCLK_SDMMC0>,
+				 <&cru SCLK_SDMMC0_DRV>, <&cru SCLK_SDMMC0_SAMPLE>;
+			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+			resets = <&cru SRST_H_SDMMC0>;
+			reset-names = "reset";
+			fifo-depth = <0x100>;
+			status = "disabled";
+		};
+
+		sdmmc1: mmc@ff890000 {
+			compatible = "rockchip,rk3562-dw-mshc",
+				     "rockchip,rk3288-dw-mshc";
+			reg = <0x0 0xff890000 0x0 0x10000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <200000000>;
+			clocks = <&cru HCLK_SDMMC1>, <&cru CCLK_SDMMC1>,
+				 <&cru SCLK_SDMMC1_DRV>, <&cru SCLK_SDMMC1_SAMPLE>;
+			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+			resets = <&cru SRST_H_SDMMC1>;
+			reset-names = "reset";
+			fifo-depth = <0x100>;
+			status = "disabled";
+		};
+
+		otp: otp@ff930000 {
+			compatible = "rockchip,rk3562-otp";
+			reg = <0x0 0xff930000 0x0 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cru CLK_USER_OTPC_NS>, <&cru CLK_SBPI_OTPC_NS>,
+				 <&cru PCLK_OTPC_NS>, <&cru PCLK_OTPPHY>;
+			clock-names = "usr", "sbpi", "apb_pclk", "phy";
+			resets = <&cru SRST_USER_OTPC_NS>, <&cru SRST_SBPI_OTPC_NS>,
+				 <&cru SRST_P_OTPC_NS>, <&cru SRST_P_OTPPHY>;
+			reset-names = "usr", "sbpi", "apb", "phy";
+
+			cpu_code: cpu-code@2 {
+				reg = <0x02 0x2>;
+			};
+
+			otp_cpu_version: cpu-version@8 {
+				reg = <0x08 0x1>;
+				bits = <3 3>;
+			};
+
+			otp_id: id@a {
+				reg = <0x0a 0x10>;
+			};
+
+			cpu_leakage: cpu-leakage@1a {
+				reg = <0x1a 0x1>;
+			};
+
+			log_leakage: log-leakage@1b {
+				reg = <0x1b 0x1>;
+			};
+
+			npu_leakage: npu-leakage@1c {
+				reg = <0x1c 0x1>;
+			};
+
+			gpu_leakage: gpu-leakage@1d {
+				reg = <0x1d 0x1>;
+			};
+		};
+
+		dmac: dma-controller@ff990000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0xff990000 0x0 0x4000>;
+			arm,pl330-periph-burst;
+			clocks = <&cru ACLK_DMAC>;
+			clock-names = "apb_pclk";
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+		};
+
+		i2c1: i2c@ffa00000 {
+			compatible = "rockchip,rk3562-i2c", "rockchip,rk3399-i2c";
+			reg = <0x0 0xffa00000 0x0 0x1000>;
+			clocks = <&cru CLK_I2C1>, <&cru PCLK_I2C1>;
+			clock-names = "i2c", "pclk";
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1m0_xfer>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@ffa10000 {
+			compatible = "rockchip,rk3562-i2c", "rockchip,rk3399-i2c";
+			reg = <0x0 0xffa10000 0x0 0x1000>;
+			clocks = <&cru CLK_I2C2>, <&cru PCLK_I2C2>;
+			clock-names = "i2c", "pclk";
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2m0_xfer>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@ffa20000 {
+			compatible = "rockchip,rk3562-i2c", "rockchip,rk3399-i2c";
+			reg = <0x0 0xffa20000 0x0 0x1000>;
+			clocks = <&cru CLK_I2C3>, <&cru PCLK_I2C3>;
+			clock-names = "i2c", "pclk";
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c3m0_xfer>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@ffa30000 {
+			compatible = "rockchip,rk3562-i2c", "rockchip,rk3399-i2c";
+			reg = <0x0 0xffa30000 0x0 0x1000>;
+			clocks = <&cru CLK_I2C4>, <&cru PCLK_I2C4>;
+			clock-names = "i2c", "pclk";
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c4m0_xfer>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@ffa40000 {
+			compatible = "rockchip,rk3562-i2c", "rockchip,rk3399-i2c";
+			reg = <0x0 0xffa40000 0x0 0x1000>;
+			clocks = <&cru CLK_I2C5>, <&cru PCLK_I2C5>;
+			clock-names = "i2c", "pclk";
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c5m0_xfer>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		wdt: watchdog@ffa60000 {
+			compatible = "rockchip,rk3562-wdt", "snps,dw-wdt";
+			reg = <0x0 0xffa60000 0x0 0x100>;
+			clocks = <&cru CLK_WDTNS>, <&cru PCLK_WDTNS>;
+			clock-names = "tclk", "pclk";
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		gmac0: ethernet@ffa80000 {
+			compatible = "rockchip,rk3562-gmac", "snps,dwmac-4.20a";
+			reg = <0x0 0xffa80000 0x0 0x10000>;
+			clocks = <&cru CLK_GMAC_125M_CRU_I>, <&cru CLK_GMAC_50M_CRU_I>,
+				 <&cru PCLK_GMAC>, <&cru ACLK_GMAC>;
+			clock-names = "stmmaceth", "clk_mac_ref",
+				      "pclk_mac", "aclk_mac";
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			resets = <&cru SRST_A_GMAC>;
+			reset-names = "stmmaceth";
+			rockchip,grf = <&sys_grf>;
+			rockchip,php-grf = <&ioc_grf>;
+			snps,axi-config = <&gmac0_stmmac_axi_setup>;
+			snps,mixed-burst;
+			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
+			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
+			snps,tso;
+			status = "disabled";
+
+			mdio0: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+			};
+
+			gmac0_stmmac_axi_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <4>;
+				snps,rd_osr_lmt = <8>;
+				snps,blen = <0 0 0 0 16 8 4>;
+			};
+
+			gmac0_mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <1>;
+				queue0 {};
+			};
+
+			gmac0_mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <1>;
+				queue0 {};
+			};
+		};
+
+		saradc1: adc@ffaa0000 {
+			compatible = "rockchip,rk3562-saradc";
+			reg = <0x0 0xffaa0000 0x0 0x100>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			#io-channel-cells = <1>;
+			clocks = <&cru CLK_SARADC_VCCIO156>, <&cru PCLK_SARADC_VCCIO156>;
+			clock-names = "saradc", "apb_pclk";
+			resets = <&cru SRST_P_SARADC_VCCIO156>;
+			reset-names = "saradc-apb";
+			status = "disabled";
+		};
+
+		gmac1: ethernet@ffb30000 {
+			compatible = "rockchip,rk3562-gmac", "snps,dwmac-4.20a";
+			reg = <0x0 0xffb30000 0x0 0x10000>;
+			clocks = <&cru CLK_MAC100_50M_MATRIX>, <&cru CLK_MAC100_50M_MATRIX>,
+				 <&cru PCLK_MAC100>, <&cru ACLK_MAC100>;
+			clock-names = "stmmaceth", "clk_mac_ref",
+				      "pclk_mac", "aclk_mac";
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq";
+			resets = <&cru SRST_A_MAC100>;
+			reset-names = "stmmaceth";
+			rockchip,grf = <&sys_grf>;
+			rockchip,php-grf = <&ioc_grf>;
+			status = "disabled";
+
+			mdio1: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <0x1>;
+				#size-cells = <0x0>;
+			};
+		};
+
+		pinctrl: pinctrl {
+			compatible = "rockchip,rk3562-pinctrl";
+			rockchip,grf = <&ioc_grf>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			gpio0: gpio@ff260000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x0 0xff260000 0x0 0x100>;
+				clocks = <&cru PCLK_PMU0_GPIO0>, <&cru DBCLK_PMU0_GPIO0>;
+				gpio-controller;
+				gpio-ranges = <&pinctrl 0 0 32>;
+				interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+			};
+
+			gpio1: gpio@ff620000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x0 0xff620000 0x0 0x100>;
+				clocks = <&cru PCLK_PERI_GPIO1>, <&cru DCLK_PERI_GPIO1>;
+				gpio-controller;
+				gpio-ranges = <&pinctrl 0 32 32>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+			};
+
+			gpio2: gpio@ff630000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x0 0xff630000 0x0 0x100>;
+				clocks = <&cru PCLK_PERI_GPIO2>, <&cru DCLK_PERI_GPIO2>;
+				gpio-controller;
+				gpio-ranges = <&pinctrl 0 64 32>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+			};
+
+			gpio3: gpio@ffac0000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x0 0xffac0000 0x0 0x100>;
+				clocks = <&cru PCLK_GPIO3_VCCIO156>, <&cru DCLK_BUS_GPIO3>;
+				gpio-controller;
+				gpio-ranges = <&pinctrl 0 96 32>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+			};
+
+			gpio4: gpio@ffad0000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x0 0xffad0000 0x0 0x100>;
+				clocks = <&cru PCLK_GPIO4_VCCIO156>, <&cru DCLK_BUS_GPIO4>;
+				gpio-controller;
+				gpio-ranges = <&pinctrl 0 128 32>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+			};
+		};
+	};
+};
+
+#include "rk3562-pinctrl.dtsi"
-- 
2.25.1


