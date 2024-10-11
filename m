Return-Path: <linux-kernel+bounces-360695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862AE999E20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8CC1C227B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF9209F5C;
	Fri, 11 Oct 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="U90wD8Pt"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A4207A30;
	Fri, 11 Oct 2024 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632464; cv=none; b=Uv0W0reJ+lfupFlMMhFA1goL1zeh2ADloz+UQNIdOUsqM4p7Qmkpa4XqkVKk60kPTJAkiWoHiNZHRuj3iZZ/yO5Z4kVVZ9aokqySTybcidIuLU4mXmB1aO7AjPlucqMsmr7oy3F1ltTx6/EALU1k8T5CY5lPzGBV7c/0DIG9vIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632464; c=relaxed/simple;
	bh=rgE6OlvW6qOB38Xou6XlYIUe/NUH/B5Gy0CvtjQuEaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gDEd3eEcxqE+xismCRAwwv+4RB3zr1141KrId937tfNNg/gQBlmUkUFa6ddPfjzDZpGft3pF4JAD2/dh+QMkoxrAByeb/QrOjL//yJyVEv/33wMxPKtmoJqkk4IjJzcRgtTsHcJCoC2TkQh8o0kP/5pzKQswnu6ECB/wO8MF4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=U90wD8Pt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728632458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zgPNIi6CDgKhY74swwH3oMJQEJfWMJ7I6Zq45/vGuHc=;
	b=U90wD8PtS8apddtBdPM0KI7newobs3XrHYUnND230di8JerkUh4BmJBrsdWeZcVktSWqV7
	H9h1uh1dGJhQB4PBSJySCV9HDS8BCwctHnCQmFi9FcW/+bogYY8OG6d+lcxiKA8+e7Y0Ct
	rrk69/xnmly2WT+WaMBXH6AxBTqsMGy6CS6SJUTRYLhezuWAiIFUaYxeeqnfI0g9teH6Lx
	Nf6yEs43NZDpzxrr1021tLCKHDVV3TppqcNr6UoI5rbHULEzXfHLaO2KaZZndJm6yt0gDQ
	1hY2XFMTEjVoFseCC9DLltt/tm5De8ha0oXewKtGkqe3NDH8RDZeLP8q6Id8VA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Add dtsi file for RK3399S SoC variant
Date: Fri, 11 Oct 2024 09:40:51 +0200
Message-Id: <c32622e4a6897378d9df81c8c3eda1bdb9211e0b.1728632052.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Following the hierarchical representation of the SoC data that's been already
established in the commit 296602b8e5f7 ("arm64: dts: rockchip: Move RK3399
OPPs to dtsi files for SoC variants"), add new SoC dtsi file for the Rockchip
RK3399S SoC, which is yet another variant of the Rockchip RK3399 SoC.

The only perceivable differences between the RK3399S and the RK3399 are in
the supported CPU DVFS OPPs, which result from the RK3399S being binned for
lower maximum CPU frequencies than the regular RK3399 variant.

The RK3399S variant is used in the Pine64 PinePhone Pro only, [1] whose board
dts file included the necessary adjustments to the CPU DVFS OPPs.  This commit
effectively moves those adjustments into the separate RK3399S SoC dtsi file,
following the above-mentioned "encapsulation" approach.

No functional changes are introduced, which was validated by decompiling and
comparing the affected dtb file before and after these changes.

[1] https://wiki.pine64.org/index.php/PinePhone_Pro

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v2:
      - Renamed the new RK3399S SoC variant dtsi file to rk3399-s.dtsi,
        as suggested by Heiko, [2] which has bothered me too, as a rather
        unnecessary file naming inconsistency
      - Adjusted the patch description accordingly, by removing the note
        about the file naming inconsistency...  yay! :)
      - Validated the introduced changes again, in the same way
    
    Link to v1: https://lore.kernel.org/linux-rockchip/59c524a9a12465c21e01b779b42749fae148c41d.1728482151.git.dsimic@manjaro.org/T/#u
    
    [2] https://lore.kernel.org/linux-rockchip/46729153.fMDQidcC6G@diego/

 .../dts/rockchip/rk3399-pinephone-pro.dts     |  23 +---
 arch/arm64/boot/dts/rockchip/rk3399-s.dtsi    | 123 ++++++++++++++++++
 2 files changed, 124 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-s.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 1a44582a49fb..eee6cfb6de01 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -13,7 +13,7 @@
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
-#include "rk3399.dtsi"
+#include "rk3399-s.dtsi"
 
 / {
 	model = "Pine64 PinePhone Pro";
@@ -456,27 +456,6 @@ mpu6500@68 {
 	};
 };
 
-&cluster0_opp {
-	opp04 {
-		status = "disabled";
-	};
-
-	opp05 {
-		status = "disabled";
-	};
-};
-
-&cluster1_opp {
-	opp06 {
-		opp-hz = /bits/ 64 <1500000000>;
-		opp-microvolt = <1100000 1100000 1150000>;
-	};
-
-	opp07 {
-		status = "disabled";
-	};
-};
-
 &io_domains {
 	bt656-supply = <&vcc1v8_dvp>;
 	audio-supply = <&vcca1v8_codec>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
new file mode 100644
index 000000000000..e54f451af9f3
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
+ */
+
+#include "rk3399-base.dtsi"
+
+/ {
+	cluster0_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <825000 825000 1250000>;
+			clock-latency-ns = <40000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <825000 825000 1250000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <850000 850000 1250000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <925000 925000 1250000>;
+		};
+	};
+
+	cluster1_opp: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <825000 825000 1250000>;
+			clock-latency-ns = <40000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <825000 825000 1250000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <825000 825000 1250000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <875000 875000 1250000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <950000 950000 1250000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1025000 1025000 1250000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1100000 1100000 1150000>;
+		};
+	};
+
+	gpu_opp_table: opp-table-2 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <825000 825000 1150000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <297000000>;
+			opp-microvolt = <825000 825000 1150000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <825000 825000 1150000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <875000 875000 1150000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <925000 925000 1150000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1100000 1100000 1150000>;
+		};
+	};
+};
+
+&cpu_l0 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_l1 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_l2 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_l3 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_b0 {
+	operating-points-v2 = <&cluster1_opp>;
+};
+
+&cpu_b1 {
+	operating-points-v2 = <&cluster1_opp>;
+};
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+};

