Return-Path: <linux-kernel+bounces-295334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B389599C4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54A71C21578
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255A120ABE1;
	Wed, 21 Aug 2024 10:17:41 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B58192D78;
	Wed, 21 Aug 2024 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235460; cv=none; b=LjAg8wy51VLmIYSnOFuELAXs1bn10qFdKVtmdjpSrt6TUQqwBxtt7Uk7kqqMA2CjAswNBsYcKTR8XxE/LOxxVMCUNy8cD4gfVnmLNAf3vkB5ELLh5cbTbz5Sx3FiW4RnVG6aZBYKnoc9H5oIH2xdoYGuRdegorRKyydy6fJ9cdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235460; c=relaxed/simple;
	bh=WXpWpDj6u1kbFSTz0P97O4IsgFpnj592RVxhfybBcOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnwQUV9OlIA1RvY/gL1FxRqQ6f1NHtXmhruZBG1Hhm4mNwY7Av1VF6FWTyZ4l4D6+2Qf2JnrS/SiHl6friJF8qoaaYgIeIusam4VCALTXiCFleRlyitOvR9gDMV8/TaOxUectDXZB6CPz8UZcwkxmsJguNNvHnlPhTOTimD58oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:ac20::1])
	by smtp.qiye.163.com (Hmail) with ESMTPA id E8AC47E01D8;
	Wed, 21 Aug 2024 18:10:50 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v3 3/4] arm64: dts: qcom: ipq6018: move mp5496 regulator out of soc dtsi
Date: Wed, 21 Aug 2024 18:10:24 +0800
Message-Id: <20240821101025.858961-4-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821101025.858961-1-amadeus@jmu.edu.cn>
References: <20240821101025.858961-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEtKVktOQk1CSE4ZQ0tMTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQRoYSUtBQUpZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-HM-Tid: 0a91746af0a203a2kunme8ac47e01d8
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OlE6Azo4CzI4GioxNDgtIik9
	GTQwC0hVSlVKTElPSUhOS05KQkNLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBGhhJS0FBSllXWQgBWUFPTUhMNwY+

Some IPQ60xx SoCs don't come with the mp5496 pmic chip. The mp5496
pmic was never part of the IPQ60xx SoC, it's optional, so we moved
it out of the soc dtsi.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts |  1 +
 arch/arm64/boot/dts/qcom/ipq6018-rdp.dtsi    | 32 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi        | 14 ---------
 3 files changed, 33 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq6018-rdp.dtsi

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index f5f4827c0e17..e71e8c851246 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "ipq6018.dtsi"
+#include "ipq6018-rdp.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ6018/AP-CP01-C1";
diff --git a/arch/arm64/boot/dts/qcom/ipq6018-rdp.dtsi b/arch/arm64/boot/dts/qcom/ipq6018-rdp.dtsi
new file mode 100644
index 000000000000..bb56c1245f92
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq6018-rdp.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * IPQ6018 RDP board common device tree source
+ */
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-mp5496-regulators";
+
+		ipq6018_s2: s2 {
+			regulator-min-microvolt = <725000>;
+			regulator-max-microvolt = <1062500>;
+			regulator-always-on;
+		};
+	};
+};
+
+&CPU0 {
+	cpu-supply = <&ipq6018_s2>;
+};
+
+&CPU1 {
+	cpu-supply = <&ipq6018_s2>;
+};
+
+&CPU2 {
+	cpu-supply = <&ipq6018_s2>;
+};
+
+&CPU3 {
+	cpu-supply = <&ipq6018_s2>;
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 33062417781a..6f365705e2d8 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -43,7 +43,6 @@ CPU0: cpu@0 {
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&ipq6018_s2>;
 			#cooling-cells = <2>;
 		};
 
@@ -56,7 +55,6 @@ CPU1: cpu@1 {
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&ipq6018_s2>;
 			#cooling-cells = <2>;
 		};
 
@@ -69,7 +67,6 @@ CPU2: cpu@2 {
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&ipq6018_s2>;
 			#cooling-cells = <2>;
 		};
 
@@ -82,7 +79,6 @@ CPU3: cpu@3 {
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-supply = <&ipq6018_s2>;
 			#cooling-cells = <2>;
 		};
 
@@ -184,16 +180,6 @@ glink-edge {
 			rpm_requests: rpm-requests {
 				compatible = "qcom,rpm-ipq6018", "qcom,glink-smd-rpm";
 				qcom,glink-channels = "rpm_requests";
-
-				regulators {
-					compatible = "qcom,rpm-mp5496-regulators";
-
-					ipq6018_s2: s2 {
-						regulator-min-microvolt = <725000>;
-						regulator-max-microvolt = <1062500>;
-						regulator-always-on;
-					};
-				};
 			};
 		};
 	};
-- 
2.25.1


