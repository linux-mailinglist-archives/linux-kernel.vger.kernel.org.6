Return-Path: <linux-kernel+bounces-393157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D649B9C80
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C7C1F221D3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B98E14F9FB;
	Sat,  2 Nov 2024 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="wDXukHfA"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FC145346;
	Sat,  2 Nov 2024 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730516970; cv=none; b=ZBKSIfqPiCe2P0fEuOrVvliHUQrbz4EeC/3F6UIgeySy08yeFjfqu7WKheYhX/YXlvT/Y4VCQiGL4tx3uGyeKUb6ZNLT9o7ezV1KLy+sgj7LWFYMf8Dg8ytLL5jCV7RYGH+mrAdjS8wrdu6l/ZLsrDW6cMszc7p0oYIhSn4itEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730516970; c=relaxed/simple;
	bh=6dh0MAiotjwWwOtFUrbib9gSbbYWZgra3wRkLFxr1dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvVS2PeTxxCH9qU7W8+kj+RJqoFsY+1fFa1MN31CdIx7D/GgJegakTyPZ2YtpnUpx/68AYiH8H+sdmE90DNBwlV0hJMFrZ8iYw0V+FpmtHZSbvGGcI+yK9+jXj6n0xiwpUWlnZTpes2tQj0Rp1dCPyoTf6P3+UZ1kgPCNceJzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=wDXukHfA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730516960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtV456hiHBEE5hovxeMqN3o5TuxazmsArwN78vbz390=;
	b=wDXukHfA6HNYzvsoYYpXn/JZDhwNKpoHYwofC33ZNLCvrGMaGB47O6P/sxfUIlABRSaKTt
	uR86CFRY1WKZhzKUoNbXHFyEzxVJNJ9uvEMtk0KrBpGIlfJ6ZAKdMz8V9vCrG5SbNFLlo0
	JuEeZKE5b2cUZgA9WQOPCVQzfTYVSEBKoG+XfJMsXikMj86QVM2ggA1c5gBWbyj77u+Lao
	cRj/82B+DObNtVy+/ayy7WjjChgoEHA5csxo8eOgm/81HVi2kU3eqnTaUuynEjScVpSOlg
	oZqy32vbuL8I5E8Z5NM6cqg/iHTC/cOaz7neYC91XIf7W76jF+LmfTadjNWnnw==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	didi.debian@cknow.org,
	TL Lim <tllim@pine64.org>,
	Marek Kraus <gamiee@pine64.org>,
	Tom Cubie <tom@radxa.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Add new SoC dtsi for the RK3566T variant
Date: Sat,  2 Nov 2024 04:09:01 +0100
Message-Id: <a85b9bdc176c542fea261fe7ef37697aebb42e8b.1730516702.git.dsimic@manjaro.org>
In-Reply-To: <cover.1730516702.git.dsimic@manjaro.org>
References: <cover.1730516702.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add new SoC dtsi file for the RK3566T variant of the Rockchip RK3566 SoC.
The difference between the RK3566T variant and the "full-fat" RK3566 variant
is in fewer supported CPU and GPU OPPs on the RK3566T, and in the absence of
a functional NPU, which we currently don't have to worry about.

Examples of the boards based on the RK3566T include the Pine64 Quartz64 Zero
SBC, [1] which is yet to be supported, the Radxa ROCK 3C, and the Radxa ZERO
3E/3W SBCs, which are both already supported.  Though, Radxa doesn't mention
the use of RK3566T officially, but its official SBC specifications do state
that the maximum frequency for the Cortex-A55 cores on those SBCs is lower
than the "full-fat" RK3566's 1.8 GHz, which makes spotting the presence of
the RK3566T SoC variant rather easy. [2][3][4]  An additional, helpful cue
is that Radxa handles the CPU and GPU OPPs for the RK3566T variant separately
in its downstream kernel source. [5]

The CPU and GPU OPPs supported on the RK3566T SoC variant are taken from the
vendor kernel source, [6] which uses the values of the "opp-supported-hw" OPP
properties to determine which ones are supported on a particular SoC variant.
The actual values of the "opp-supported-hw" properties make it rather easy
to see what OPPs are supported on the RK3566T SoC variant, but that, rather
unfortunately, clashes with the maximum frequencies advertised officially
for the Cortex-A55 CPU cores on the above-mentioned SBCs. [1][2][3][4]  The
vendor kernel source indicates that the maximum frequency for the CPU cores
is 1.4 GHz, while the SBC specifications state that to be 1.6 GHz.  Until
that discrepancy is resolved somehow, let's take the safe approach and use
the lower maximum frequency for the CPU cores.

Update the dts files of the currently supported RK3566T-based boards to use
the new SoC dtsi for the RK3566T variant.  This actually takes the CPU cores
and the GPUs found on these boards out of their earlier overclocks, but it
also means that the officially advertised specifications [1][2][3][4] of the
highest supported frequencies for the Cortex-A55 CPU cores on these boards
may actually be wrong, as already explained above.

The correctness of the introduced changes was validated by decompiling and
comparing all affected board dtb files before and after these changes.

[1] https://wiki.pine64.org/wiki/Quartz64
[2] https://dl.radxa.com/rock3/docs/hw/3c/radxa_rock3c_product_brief.pdf
[3] https://dl.radxa.com/zero3/docs/hw/3e/radxa_zero_3e_product_brief.pdf
[4] https://dl.radxa.com/zero3/docs/hw/3w/radxa_zero_3w_product_brief.pdf
[5] https://github.com/radxa/kernel/commit/2dfd51da472e7ebb5ef0d3db78f902454af826b8
[6] https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi

Cc: TL Lim <tllim@pine64.org>
Cc: Marek Kraus <gamiee@pine64.org>
Cc: Tom Cubie <tom@radxa.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>
Helped-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Helped-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 .../dts/rockchip/rk3566-radxa-zero-3.dtsi     |  2 +-
 .../boot/dts/rockchip/rk3566-rock-3c.dts      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3566t.dtsi     | 90 +++++++++++++++++++
 3 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566t.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
index de390d92c35e..1ee5d96a46a1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
@@ -3,7 +3,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
-#include "rk3566.dtsi"
+#include "rk3566t.dtsi"
 
 / {
 	chosen {
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
index f2cc086e5001..9a8f4f774dbc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
@@ -5,7 +5,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
-#include "rk3566.dtsi"
+#include "rk3566t.dtsi"
 
 / {
 	model = "Radxa ROCK 3C";
diff --git a/arch/arm64/boot/dts/rockchip/rk3566t.dtsi b/arch/arm64/boot/dts/rockchip/rk3566t.dtsi
new file mode 100644
index 000000000000..cd89bd3b125b
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566t.dtsi
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3566-base.dtsi"
+
+/ {
+	cpu0_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <900000 900000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1025000 1025000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
+	gpu_opp_table: opp-table-1 {
+		compatible = "operating-points-v2";
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <850000 850000 1000000>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <850000 850000 1000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <850000 850000 1000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000 900000 1000000>;
+		};
+
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <950000 950000 1000000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+};

