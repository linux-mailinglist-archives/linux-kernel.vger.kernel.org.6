Return-Path: <linux-kernel+bounces-393155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1299B9C7D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6996B2120F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E19146D55;
	Sat,  2 Nov 2024 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="acDK5Lt9"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321F42070;
	Sat,  2 Nov 2024 03:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730516968; cv=none; b=rCjol7HsL4X3WzJ3uj3qLuAwyfnCv5fQSQM8tcpF+LmI3hfpCXxsZ7PaBioyMxPFTeuYYEs7om70riGStSJOjoojfO2I3Ofb4EL/yCW3yoeRgOmgKt2c2WpwYaLnkTRxb8hEWl7uQKNnk2hqpbLO5VqBCTzmjwhIPxKkcvjkltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730516968; c=relaxed/simple;
	bh=geYC7r4H3w86VyqGSsfw/vB/Pc5suyDUj0gAsNSm5uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nCjIGzfK2qTtAcAf5wrbktlJ3TeZaVpDekEu5r5fHfCJi68YCbHYWWXz70D39NhwBbW71GCSgRt6sLXS1VdQoUhOUUOZmza3zxIoZNWJBWGdWeYHZcSBnrlJvToFBd220P1BudivJFCx+R3V7ibCBEmoilod62idp5GaFtjycoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=acDK5Lt9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730516957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k33vTDitf06aKiwfNJDdOoAA6cwqjjJzaXvt5dYrR+I=;
	b=acDK5Lt93Pm2eToay6pQv0CX3Gn3gQagepQd+XDmGCqJOTGy76/7E4lu11S+0yHkuRRMdO
	6C+TBxot+ps8HWtLCfSAqaAhzXhxITcGiOtWZRJjjmGYjXdkGC8byvGtSKtKHH5DgHtI/u
	i7WJiqXaqSbCb86WWTZ8H1ssGB7l6aL8YRf8aejjGrplsAIAPLK4tESkjnlRR9gOh+6IHF
	5UTTwcgwWfcfutiZN/NPzEiG93tqjB9N2WWVYRqPCSYQQonPgm0htkfePbBzUuapFNWeW+
	MfXENjKfwh3d5OBLGnvTSq6818Kkevuca2ZNDFmdgkzgZQJqxu66EiDTBoxMyA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	didi.debian@cknow.org
Subject: [PATCH v2 1/3] arm64: dts: rockchip: Update CPU OPP voltages in RK356x SoC dtsi
Date: Sat,  2 Nov 2024 04:08:59 +0100
Message-Id: <f816cd24b62742dd05a1b7c6fe162bb581c9b3bf.1730516702.git.dsimic@manjaro.org>
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

Update the lower/upper voltage limits and the exact voltages for the Rockchip
RK356x CPU OPPs, using the most conservative values (i.e. the highest per-OPP
voltages) found in the vendor kernel source. [1]

Using the most conservative per-OPP voltages ensures reliable CPU operation
regardless of the actual CPU binning, with the downside of possibly using
a bit more power for the CPU cores than absolutely needed.

Additionally, fill in the missing "clock-latency-ns" CPU OPP properties, using
the values found in the vendor kernel source. [1]

[1] https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi

Related-to: eb665b1c06bc ("arm64: dts: rockchip: Update GPU OPP voltages in RK356x SoC dtsi")
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi |  1 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 0946310e8c12..5c54898f6ed1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -273,6 +273,7 @@ &cpu0_opp_table {
 	opp-1992000000 {
 		opp-hz = /bits/ 64 <1992000000>;
 		opp-microvolt = <1150000 1150000 1150000>;
+		clock-latency-ns = <40000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 0ee0ada6f0ab..534593f2ed0b 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -134,39 +134,45 @@ cpu0_opp_table: opp-table-0 {
 
 		opp-408000000 {
 			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt = <900000 900000 1150000>;
+			opp-microvolt = <850000 850000 1150000>;
 			clock-latency-ns = <40000>;
 		};
 
 		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <900000 900000 1150000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
 		};
 
 		opp-816000000 {
 			opp-hz = /bits/ 64 <816000000>;
-			opp-microvolt = <900000 900000 1150000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
 			opp-suspend;
 		};
 
 		opp-1104000000 {
 			opp-hz = /bits/ 64 <1104000000>;
 			opp-microvolt = <900000 900000 1150000>;
+			clock-latency-ns = <40000>;
 		};
 
 		opp-1416000000 {
 			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <900000 900000 1150000>;
+			opp-microvolt = <1025000 1025000 1150000>;
+			clock-latency-ns = <40000>;
 		};
 
 		opp-1608000000 {
 			opp-hz = /bits/ 64 <1608000000>;
-			opp-microvolt = <975000 975000 1150000>;
+			opp-microvolt = <1100000 1100000 1150000>;
+			clock-latency-ns = <40000>;
 		};
 
 		opp-1800000000 {
 			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <1050000 1050000 1150000>;
+			opp-microvolt = <1150000 1150000 1150000>;
+			clock-latency-ns = <40000>;
 		};
 	};
 

