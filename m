Return-Path: <linux-kernel+bounces-310591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE05967ECB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85280B2138F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6276F1514CC;
	Mon,  2 Sep 2024 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG6eFj7e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC142AB9;
	Mon,  2 Sep 2024 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725254981; cv=none; b=qAkJPUnrEhjVucMjUgz6XTMC5pbAeb8qXmD5MX/V8GHeCRN+rZ55ROhUcrSkHenfdq+kySz3RyU9xToA/lmTnB7QqrVp72Pm63Wmnv4FsdCrDKq3NH4ZVvRBYrIwG5FP9eAEcr17Dt3v2mmZuNSJDTRl2aSe1fHObYiBfuMaiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725254981; c=relaxed/simple;
	bh=HiB1pHFfUI4P2CUYJCGF3+be/QQQUfYSofVQKfy81l8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GcW7H0llZRmu7o83VNf8bC/KPm3XCqTsBeeb3f7hJ5WngV+BUVQWQShYnU9yi9OieIXYeSxWLffqZPT1VZ2oFawhbTroubYCmiZhf5dTWOp1tFIfbFscDCKkXDSJEmJnxL/CIEnU53PdoTadP4D87GcDTrnl0CwXYYs4I7tclfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG6eFj7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27179C4CEC2;
	Mon,  2 Sep 2024 05:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725254981;
	bh=HiB1pHFfUI4P2CUYJCGF3+be/QQQUfYSofVQKfy81l8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=lG6eFj7e9SSO2nGNINyGRUMnxLhtcChHHwaELx6/J/SyJmVePQsMPxwyF/WL9hYkh
	 mkMCvl9g4oIFmv0RkM+WxoqLsdgJqu/JN+muvKWJFWF6UwVE18+X+WWWrT0gHbDpwf
	 3VyiRe6Tbo0TRF9WDL8YKJx6yK8Ie4vyMEHZBgau1LDw5sMqgI+EMBL7c03MPc5sWJ
	 KtoKqhNhV4A9F3mkYl8+XxDrYrK0MRAaivcWXe9oQwCYmT7ysp2hSSGeuvGjUs4jKH
	 SXeME1J0Uazn4dPAd1j8niqdhi3bodGhTssnsCWkjaBC5wVUfZxrq7lb52Cwxn++UF
	 5AMobgCkGd9oQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5C7CD13CF;
	Mon,  2 Sep 2024 05:29:41 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 02 Sep 2024 13:29:39 +0800
Subject: [PATCH] arm64: dts: amlogic: c3: fix dtbcheck warning
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-fix_warning-v1-1-037029c584fc@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAEJN1WYC/x2MQQqAIBAAvyJ7TrA1xPpKRIitthcLhQrCvycdh
 2HmhUKZqcAkXsh0ceEjNeg7AX53KZLkrTGgwkGNCmXgZ71dTpyiNN4GbTB4qzW04szU9H+bl1o
 /1gYeY10AAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725254979; l=3537;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=3Plhy3KgHss93IzBZRmdUv/l5YYTAOs01NTzF3Jk9sU=;
 b=QAn+zi5Iwq0XYzO4SZDdR9VXLHnf+pXbKVAVhwHQzWrOcpmd15qb0eRPwUvzl4QKJkEMNKOGn
 UWeDZ3hvWTRCsSxy5sCcLPH1atZ5C/50llxtb0sXcFhaY+2iQUdAjAp
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Fix warning when use W=1 to build dtb, as following error:

arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi:65.7-76.4: Warning
(unit_address_vs_reg): /sram: node has a reg or ranges property,
but no unit name

arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi:168.34-413.6: Warning
(unit_address_vs_reg): /soc/bus@fe000000/pinctrl@4000: node has a
unit name, but no reg or ranges property

arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi:168.34-413.6: Warning
(simple_bus_reg): /soc/bus@fe000000/pinctrl@4000: missing or empty
reg/ranges property

arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts:205.9-245.4:
Warning (avoid_unnecessary_addr_size): /soc/bus@fe000000/spi@56000
/nand@0: unnecessary #address-cells/#size-cells without "ranges",
"dma-ranges" or child "reg" property

Fixes: d4bd8f3023b6 ("arm64: dts: amlogic: add C3 AW419 board")
Fixes: 520b792e8317 ("arm64: dts: amlogic: add some device nodes for C3")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202409010005.A7tSzgEn-lkp@intel.com/
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Fix some warning when use W=1 to make dtb_check.
---
 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts |  2 --
 arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts |  2 --
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi            | 10 +++++-----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
index b8d2037afc00..a6736ad2a648 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409.dts
@@ -208,8 +208,6 @@ nand@0 {
 		spi-max-frequency = <83000000>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		status = "disabled";
 
 		partitions {
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
index 4477a2659e27..45f8631f9feb 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
@@ -208,8 +208,6 @@ nand@0 {
 		spi-max-frequency = <83000000>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		status = "disabled";
 
 		partitions {
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index c0ce776ec463..d0cda759c25d 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -62,7 +62,7 @@ pwrc: power-controller {
 		};
 	};
 
-	sram {
+	sram@7f50e00 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x07f50e00 0x0 0x100>;
 		#address-cells = <1>;
@@ -169,11 +169,11 @@ periphs_pinctrl: pinctrl@4000 {
 				compatible = "amlogic,c3-periphs-pinctrl";
 				#address-cells = <2>;
 				#size-cells = <2>;
-				ranges;
+				ranges = <0x0 0x0 0x0 0x4000 0x0 0x02de>;
 
-				gpio: bank@4000 {
-					reg = <0x0 0x4000 0x0 0x004c>,
-					      <0x0 0x4100 0x0 0x01de>;
+				gpio: bank@0 {
+					reg = <0x0 0x0 0x0 0x004c>,
+					      <0x0 0x100 0x0 0x01de>;
 					reg-names = "mux", "gpio";
 					gpio-controller;
 					#gpio-cells = <2>;

---
base-commit: 1565ad6d5afc023cc4cc721513c9be28b902dee8
change-id: 20240902-fix_warning-6c8f362fc833

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



