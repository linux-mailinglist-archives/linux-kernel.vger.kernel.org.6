Return-Path: <linux-kernel+bounces-569453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9EEA6A332
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E44F8A6D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9F224890;
	Thu, 20 Mar 2025 10:00:22 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626EA224883
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742464821; cv=none; b=LY+uju/M1Rdx6Bz4PS4KLBDv+3AS4kpNj1CG3LhyPZWPDv5vUpSlV50OLcso6332/ip4fbpshIERqZhgXmEKcbi5yB58hiMr+U2cj6AraZVwVFsPAAF4uJD84qL8jfiAsXA8VZHqs/eJe+1gBW9f3K2S1ulIMKbye2oZnSDxGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742464821; c=relaxed/simple;
	bh=Rhr1XuDSO0EXKlC3cUF613tOmZO6+20At8GYPF2/Jxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bei6xgmryjHd3xWjbA0+fnVs6jhR7mGUfI9ZMpOE9y4gxTLCsy5p+yaHhzelcG7S2K/iziVGIwENLGvvjefXQl8lBfFjc5F7qn1qwzx//zBbsylh9kgGsQhgPcBgtjDixQG/FCr/OWb7UGx6bkWn3gAHCQaIm0VlLHBgvDujvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:27b0:1bde:abfc:3838:af13])
	by smtp.qiye.163.com (Hmail) with ESMTP id ef1b293d;
	Thu, 20 Mar 2025 18:00:07 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jonas Karlman <jonas@kwiboo.se>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency scaling support
Date: Thu, 20 Mar 2025 18:00:02 +0800
Message-Id: <20250320100002.332720-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320100002.332720-1-amadeus@jmu.edu.cn>
References: <20250320100002.332720-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0xLVh5NSh1LSkIeGk9JSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUlMGUtBShkfHkEaGR0YQUhDSENBGh1KSFlXWRYaDx
	IVHRRZQVlPS0hVSktISk5MTlVKS0tVSkJLS1kG
X-HM-Tid: 0a95b2fef1df03a2kunmef1b293d
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NCo6Ojo5IzJREEI1TRYUMSoV
	NDIaCxFVSlVKTE9JT01PQ0tDSEpNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSUwZS0FKGR8eQRoZHRhBSENIQ0EaHUpIWVdZCAFZQU9LTkg3Bg++

By default, the CPUs on RK3528 operates at 1.5GHz. Add CPU frequency and
voltage mapping to the device tree to enable dynamic scaling via cpufreq.

The OPP values come from downstream kernel[1], and voltage is chosen from
the one that makes the actual frequency close to the displayed frequency.

[1] https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3528.dtsi

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 621fc19ac0b3..9dae18c3c770 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -61,6 +61,7 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			enable-method = "psci";
 			clocks = <&scmi_clk SCMI_CLK_CPU>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu1: cpu@1 {
@@ -69,6 +70,7 @@ cpu1: cpu@1 {
 			device_type = "cpu";
 			enable-method = "psci";
 			clocks = <&scmi_clk SCMI_CLK_CPU>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu2: cpu@2 {
@@ -77,6 +79,7 @@ cpu2: cpu@2 {
 			device_type = "cpu";
 			enable-method = "psci";
 			clocks = <&scmi_clk SCMI_CLK_CPU>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu3: cpu@3 {
@@ -85,6 +88,7 @@ cpu3: cpu@3 {
 			device_type = "cpu";
 			enable-method = "psci";
 			clocks = <&scmi_clk SCMI_CLK_CPU>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 	};
 
@@ -103,6 +107,66 @@ scmi_clk: protocol@14 {
 		};
 	};
 
+	cpu0_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <825000 825000 1100000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <825000 825000 1100000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <825000 825000 1100000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <850000 850000 1100000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <850000 850000 1100000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <925000 925000 1100000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <975000 975000 1100000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1037500 1037500 1100000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <1100000 1100000 1100000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
-- 
2.25.1


