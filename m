Return-Path: <linux-kernel+bounces-397816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1FF9BE102
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7401C23256
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10E11D4169;
	Wed,  6 Nov 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sDM/n7i0"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D318FC79;
	Wed,  6 Nov 2024 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881997; cv=none; b=sGrpiVnLUqU1yCw1yRgd8L/4bRdxKJvi+Ila2GmXshN4/MWNqm8ubEtRgKtozDwyDiPn/bgJhGTC65QWm3ecX/rpF8HFC1gh27v+kMtS2mtik2mD299cs5qxBKzBoBO8spGUcmoLY4CaePMygw0uHIsLQIhpXt4mM47t5czK+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881997; c=relaxed/simple;
	bh=l/J2r2gnvW8sHdlJg1SoSDEB5itJThkr63VOiSlCIRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RZ4qu3Yz7ZoyYFaOGywvkBUlazGENK02I6Q9VAWaMUn2a0Bzo16X7Z35G+GPINFtn+4gg8AzdoNmm2J7auKs8MeGS8jddOrY+I9OzqnMjbSKj/LMCuEUY9/EqjPDeEP6ZpsywoIE4TZUaaW7GoqWRdLOW3EtDmzdvl1jooTzyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sDM/n7i0; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730881993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TmaL8PPJ/UHeiTUk6acBviC2uKf2V/Awig/1ks3o27s=;
	b=sDM/n7i0llCDpO1gtMBjWsGXMbtUl8T1D+TNuuOKe7bk9Qyz65Y6Mwy+b46gNzf/IU0Oi+
	zAKgjbLMPi++GYk4r00/dDzqZp8VFt2SrTl9G+7n5rTykhrWFr3qsuz04ceXAuIWmEPnUv
	pz+/p32PyMrv7dM/LF3E0C5KYt6MIWZN6ojp0D04qA/NGV9XoxrjxbJKmJDFwyI6u69SQc
	rvy/u4W2pfQF0OSD/KPK6MbwZXfWBGCTVc9Y8LMfBPp0jlTL0+Np0RHFhm14kKXu3ivSy9
	9ixjBHohVratdR1BPcY14eX14SRq76V+0Jdp65XRnGd7+LPn+xumj/4Hgj1Jxw==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alchark@gmail.com,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2] arm64: dts: rockchip: Add OPP voltage ranges to RK3399 OP1 SoC dtsi
Date: Wed,  6 Nov 2024 09:33:08 +0100
Message-Id: <dbee35c002bda99e44f8533623d94f202a60da95.1730881777.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add support for voltage ranges to the CPU, GPU and DMC OPPs defined in the
SoC dtsi for Rockchip OP1, as a variant of the Rockchip RK3399.  This may be
useful if there are any OP1-based boards whose associated voltage regulators
are unable to deliver the exact voltages; otherwise, it causes no functional
changes to the resulting OPP voltages at runtime.

These changes cannot cause stability issues or any kind of damage, because
it's perfectly safe to use the highest voltage from an OPP group for each OPP
in the same group.  The only possible negative effect of using higher voltages
is wasted energy in form of some additionally generated heat.

Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v2:
      - Fixed one wrong application of a vim macro [1] that somehow slipped
        through the cracks, as pointed out by Alexey [2]
    
    Link to v1: https://lore.kernel.org/linux-rockchip/806d5e2a07ae0c81d9907bbe8bec4e3e1138b392.1730838347.git.dsimic@manjaro.org/T/#u
    
    [1] https://lore.kernel.org/linux-rockchip/0c237c49fae03bdad99be04053285ea2@manjaro.org/
    [2] https://lore.kernel.org/linux-rockchip/CABjd4Yyt6WiY5E5DbyjnboFvsTpp33dydkGMF7AwMB9m7bfX6A@mail.gmail.com/

 arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi | 52 ++++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
index b24bff511513..c4f4f1ff6117 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
@@ -12,125 +12,125 @@ cluster0_opp: opp-table-0 {
 
 		opp00 {
 			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <800000 800000 1150000>;
 			clock-latency-ns = <40000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <825000>;
+			opp-microvolt = <825000 825000 1150000>;
 		};
 		opp02 {
 			opp-hz = /bits/ 64 <816000000>;
-			opp-microvolt = <850000>;
+			opp-microvolt = <850000 850000 1150000>;
 		};
 		opp03 {
 			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt = <900000>;
+			opp-microvolt = <900000 900000 1150000>;
 		};
 		opp04 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <975000>;
+			opp-microvolt = <975000 975000 1150000>;
 		};
 		opp05 {
 			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <1100000>;
+			opp-microvolt = <1100000 1100000 1150000>;
 		};
 		opp06 {
 			opp-hz = /bits/ 64 <1512000000>;
-			opp-microvolt = <1150000>;
+			opp-microvolt = <1150000 1150000 1150000>;
 		};
 	};
 
 	cluster1_opp: opp-table-1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
 		opp00 {
 			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <800000 800000 1250000>;
 			clock-latency-ns = <40000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <800000 800000 1250000>;
 		};
 		opp02 {
 			opp-hz = /bits/ 64 <816000000>;
-			opp-microvolt = <825000>;
+			opp-microvolt = <825000 825000 1250000>;
 		};
 		opp03 {
 			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt = <850000>;
+			opp-microvolt = <850000 850000 1250000>;
 		};
 		opp04 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <900000>;
+			opp-microvolt = <900000 900000 1250000>;
 		};
 		opp05 {
 			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <975000>;
+			opp-microvolt = <975000 975000 1250000>;
 		};
 		opp06 {
 			opp-hz = /bits/ 64 <1608000000>;
-			opp-microvolt = <1050000>;
+			opp-microvolt = <1050000 1050000 1250000>;
 		};
 		opp07 {
 			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <1150000>;
+			opp-microvolt = <1150000 1150000 1250000>;
 		};
 		opp08 {
 			opp-hz = /bits/ 64 <2016000000>;
-			opp-microvolt = <1250000>;
+			opp-microvolt = <1250000 1250000 1250000>;
 		};
 	};
 
 	gpu_opp_table: opp-table-2 {
 		compatible = "operating-points-v2";
 
 		opp00 {
 			opp-hz = /bits/ 64 <200000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <800000 800000 1075000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <297000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <800000 800000 1075000>;
 		};
 		opp02 {
 			opp-hz = /bits/ 64 <400000000>;
-			opp-microvolt = <825000>;
+			opp-microvolt = <825000 825000 1075000>;
 		};
 		opp03 {
 			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <850000>;
+			opp-microvolt = <850000 850000 1075000>;
 		};
 		opp04 {
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <925000>;
+			opp-microvolt = <925000 925000 1075000>;
 		};
 		opp05 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <1075000>;
+			opp-microvolt = <1075000 1075000 1075000>;
 		};
 	};
 
 	dmc_opp_table: opp-table-3 {
 		compatible = "operating-points-v2";
 
 		opp00 {
 			opp-hz = /bits/ 64 <400000000>;
-			opp-microvolt = <900000>;
+			opp-microvolt = <900000 900000 925000>;
 		};
 		opp01 {
 			opp-hz = /bits/ 64 <666000000>;
-			opp-microvolt = <900000>;
+			opp-microvolt = <900000 900000 925000>;
 		};
 		opp02 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <900000>;
+			opp-microvolt = <900000 900000 925000>;
 		};
 		opp03 {
 			opp-hz = /bits/ 64 <928000000>;
-			opp-microvolt = <925000>;
+			opp-microvolt = <925000 925000 925000>;
 		};
 	};
 };

