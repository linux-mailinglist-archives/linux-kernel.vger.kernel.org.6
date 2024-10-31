Return-Path: <linux-kernel+bounces-390058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145739B7502
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71222828DE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E654C192B70;
	Thu, 31 Oct 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="fm+gozSy"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783D150981;
	Thu, 31 Oct 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358217; cv=none; b=IRFXagBrweSulfcFTylsgh4wXCUsalCzXedkhVi5y3kaP6cK/ikcf0qD9HXqsPSHEg7Nf09KbZ85MymduRqjsij/9nffxhql2TyB3HwhhY80tzVV2ddFyc2Jy1u6iYI8y7wTVbKGOwSf+xGOP2SiYIpnCheRKrZdxjtlKNwVopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358217; c=relaxed/simple;
	bh=uG2apc/l46v55IsDCKvsKsBsQ3G+4vM+sV5vj2eVN7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+jo5oO6VD7FWUX3sj994VWkmiK/mdM2VZHS1D7LM/8fqrQN49eLthXhRisepnbbdgdEd/5nZocXuzm7QSzFrw1/09u/n7YWAtc+JwqDUqDPDITdq8YK4mhF4ThHHZbsd2uOkFLzWFZOmZs76FiXoEUtVty5v6NVnioD3/7OY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=fm+gozSy; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730358205;
	bh=uG2apc/l46v55IsDCKvsKsBsQ3G+4vM+sV5vj2eVN7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fm+gozSyaRIJon1mAHV2EYtzITXTjiBBwxHmNkcZGiuhJiQiyWT4zD90JbMpUDE0d
	 S04ooXRzJo52QdbCtL62mgyXMJJXkSE9VzTG4ZGtaOreeZWv8vV0B/ArJcOJjl9/76
	 RTHrGnMksj+1bEtALdhPNhUEMYcRiAqdQoQi5LQXC3BTMXCAfPjajHgsABMMfVtcMP
	 85d7BJ3e+Fx9MJpeIecwdabc6G/ejJz0UJN0xMhGgAn1xHqkMFJTQb1XyUNsg9xumy
	 kRonWaNviblBc7rHjJzmlGidcT21mG2Tz0GdkBEqqy6WxXwbEd6S/KUzYBPj9vjGu5
	 GOJVi+JvbMg6w==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Cody Eksal <masterr3c0rd@epochal.quest>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] arm64: allwinner: a100: Add MMC related nodes
Date: Thu, 31 Oct 2024 04:02:22 -0300
Message-ID: <20241031070232.1793078-10-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yangtao Li <frank@allwinnertech.com>

The A100 has 3 MMC controllers, one of them being especially targeted to
eMMC. Let's add nodes on dts.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index f6162a107641..29ac7716c7a5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -169,12 +169,83 @@ pio: pinctrl@300b000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			mmc0_pins: mmc0-pins {
+				pins = "PF0", "PF1", "PF2", "PF3",
+				       "PF4", "PF5";
+				function = "mmc0";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			/omit-if-no-ref/
+			mmc1_pins: mmc1-pins {
+				pins = "PG0", "PG1", "PG2", "PG3",
+				       "PG4", "PG5";
+				function = "mmc1";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			mmc2_pins: mmc2-pins {
+				pins = "PC0", "PC1", "PC5", "PC6",
+				       "PC8", "PC9", "PC10", "PC11",
+				       "PC13", "PC14", "PC15", "PC16";
+				function = "mmc2";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB9", "PB10";
 				function = "uart0";
 			};
 		};
 
+		mmc0: mmc@4020000 {
+			compatible = "allwinner,sun50i-a100-mmc";
+			reg = <0x04020000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc@4021000 {
+			compatible = "allwinner,sun50i-a100-mmc";
+			reg = <0x04021000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC1>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc1_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc@4022000 {
+			compatible = "allwinner,sun50i-a100-emmc";
+			reg = <0x04022000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC2>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc2_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		uart0: serial@5000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x05000000 0x400>;
-- 
2.47.0


