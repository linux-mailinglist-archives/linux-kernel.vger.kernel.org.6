Return-Path: <linux-kernel+bounces-362544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BFF99B623
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 19:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1DC1F21C05
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8BF768FC;
	Sat, 12 Oct 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Y8ZrFlzA"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935CA1E511;
	Sat, 12 Oct 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728752693; cv=none; b=MCEj8ewmjXuGzF1KBtJOGxUyLJaaps6o91LBCf4GlUXIdEmRpAADMKWUi3FIxzKXk0mnbmojDeoS1aMbYfCo0VWKgpBoC34DVMo0EK0QJHTv1+4bdBuIG6NP3GeqtFVwgrB8sGhRX5vVqrbFk6tNqcsOhkZPTsS0fRvHwwRZNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728752693; c=relaxed/simple;
	bh=geYC7r4H3w86VyqGSsfw/vB/Pc5suyDUj0gAsNSm5uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u/9GRgqz+PQZQmpvFDQgvQiaSty2yPqDkZ65dkFb2Vf+S++J3Knvb6wYFSwEW1MqkOPYHAxgT1NeZ7jwPyXFBgCb+V0KomGkuqYpMAyOsCEqnkCHlsGg47MdpLo1pnsU2KfYaNqrXvuidUWQ/CJlvxBYpD7jkIsfwkVTBt9lhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Y8ZrFlzA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728752682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k33vTDitf06aKiwfNJDdOoAA6cwqjjJzaXvt5dYrR+I=;
	b=Y8ZrFlzAV6x5lsKZAiY92mdpte82nlG5tKzWp2AuskhCf6b+l+epD8X811D6hA3RhAgxtW
	uXcgbRAvGAwB95xJFmQvBnpQh8Uc2EcVXb5RJmR94sLMPuzw/TQA05jD1IyhI+ahnfTbb9
	Jogs0U78QGMIBAaGrHa0fTcNiodLbFd7XpwOQww9uK7PpN9EtkTxUrP+lIIvqFWUQAydmN
	XHGwfOoXPlWyYVijHLGl2hu7dXZxPmVF+PRPhVbVLiE9v1B+I1AufHs/Opm2Usd7toerO3
	5EXsBKYbGyBXmF/rPTftPo3t15875n10wdw1JL6y9utEoOKVLOdSI2CtBgQNlg==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH 1/3] arm64: dts: rockchip: Update CPU OPP voltages in RK356x SoC dtsi
Date: Sat, 12 Oct 2024 19:04:34 +0200
Message-Id: <2e1e100284b1edb470d6e7fde021a0f1779336c8.1728752527.git.dsimic@manjaro.org>
In-Reply-To: <cover.1728752527.git.dsimic@manjaro.org>
References: <cover.1728752527.git.dsimic@manjaro.org>
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
 

