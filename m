Return-Path: <linux-kernel+bounces-397125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEA29BD70B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FF21C23557
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA184215F5D;
	Tue,  5 Nov 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="baeAwYAB"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F71215C6A;
	Tue,  5 Nov 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838518; cv=none; b=go5B6AVt4EszwunwDQ4laKYoLrSLykIi37iMTVX0lI3IWQJ91b0IdCbiZrCLksztWDfyjU8o7kRYK4kFR7JwSwt7k91O5Ax87lFCyKUG+yRakpLhM7ZCebHjMnSfQ9r/R2itmo92I0KdXBZin4R+VqKp1QuDQI9CPmXFIuq7REo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838518; c=relaxed/simple;
	bh=QNBJKJXPzdjh+OfEOGf0Uv2mvOVy1KhGeev8FSYyuzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nU2qTM/UE107p4V8BzRkzzO7Sj8aS+H+ih4gT8yeShbkkeDKdUEu5euGB2xmMXYbYSL+UZhu3nA0EtL1PKpPIXLss0tgXygMGaTdtZ1KGxM3w7QPq0tzFc1nkIrqQ7YHMaTAy6mx0Zqpuaye+Rphk987LuXusBkVInlSRO95TPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=baeAwYAB; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730838513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aBHle+OmOKJ3GRYlaXusg7k6eCXaPNAxaIyVWZZMSto=;
	b=baeAwYAByo6F6KHLbMhtp+gExlg0rVpoZqzBs+OCjm3SBE0U0PsJMixAmn16/sJ2pY6UFJ
	xpJAK4HAZRkmK4DUAjS5gPuhkz+dsABoYjuwLh6jtEo2rzVKUHc1J7ti7qDLgOK49T10kL
	C8JPSFyI0DW2+4DSiyzhgt+5L017gSDzDW0OKA8EDM3w7L7DSGQVSutGbgAqjmYnRVtvuE
	ZRcqG8+MWZ3UXpLyfF3n8/9Jzrpjt+q00M1PtZ/V4FNwPQ2mSDyppngYag49qbdU48rrSB
	CDPzml/J1OHCZdEcy/D06ehxXblZdvSp/GzrhiehKdCs/NwC4GAGjCtlJHjFrw==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH] arm64: dts: rockchip: Add OPP voltage ranges to RK3399 OP1 SoC dtsi
Date: Tue,  5 Nov 2024 21:28:22 +0100
Message-Id: <806d5e2a07ae0c81d9907bbe8bec4e3e1138b392.1730838347.git.dsimic@manjaro.org>
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
 arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi | 52 ++++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
index b24bff511513..aa79219471d3 100644
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
 			opp-microvolt = <800000>;
-			clock-latency-ns = <40000>;
+			clock-latency-ns = <40000 40000 1250000>;
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

