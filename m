Return-Path: <linux-kernel+bounces-550819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA829A56480
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B82173A25
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A366E20E00C;
	Fri,  7 Mar 2025 10:00:27 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34601C84B5;
	Fri,  7 Mar 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341627; cv=none; b=TyPfpJHFkOpdQUDe40KLH5YgbLy+o6SRhdMv/UX7KlhMXiHlIszVEFc5LJmtrHC3u75MxZ36j36gG4/9RMMyXbiG0ovZf2czuXhF4ZmQOVEoSDdb/vtxWjBkRBjc9aYgYnnC+13AoQf3ARmbmBhKGFa6Jq5KobcikeijQTTW4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341627; c=relaxed/simple;
	bh=DiPMgeHh9xyknUW6LnuQhDW7UZ9GfyV1CexkRlWvDlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkbFrFFW1Vya11sHrRmlJmrHwpvy6pAyMDBwPW1AaEJXnwK+ekBOsxY4Ktg8H29WqZjpUaB4EU6sfkHyBvHmgxYRkyx68eAq3cFh/Z2GYWA2xxpXMMVSfX7oUtHcvxyhHEDBt9A5vpIWvTXfq6VP8iuTVZNahy4CS2KLmliHHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:3300:467f:62a0:f2ba:1721])
	by smtp.qiye.163.com (Hmail) with ESMTP id d586ba79;
	Fri, 7 Mar 2025 18:00:13 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v3 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Fri,  7 Mar 2025 18:00:08 +0800
Message-Id: <20250307100008.789129-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307100008.789129-1-amadeus@jmu.edu.cn>
References: <20250307100008.789129-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQkgaVksaTxhOTBgaTBpPGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUhIS0tBT01MHUFNSRpLQR1JGRpBSkxJSllXWRYaDx
	IVHRRZQVlPS0hVSktJSEJLQ1VKS0tVSkJZBg++
X-HM-Tid: 0a95700c5ecc03a2kunmd586ba79
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6GRw4LTJDOjY3Ti83OAgi
	PBgaCkJVSlVKTE9KSE9KTUpPT09IVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSEhLS0FPTUwdQU1JGktBHUkZGkFKTElKWVdZCAFZQUpDQ0I3Bg++

Same as RK3568, RK3528 uses SCMI clk instead of ARMCLK.
Add SCMI clk for CPU, GPU and RNG will also use it.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 6403946e1700..e59a6eaff60c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -59,6 +59,7 @@ cpu0: cpu@0 {
 			reg = <0x0>;
 			device_type = "cpu";
 			enable-method = "psci";
+			clocks = <&scmi_clk SCMI_CLK_CPU>;
 		};
 
 		cpu1: cpu@1 {
@@ -66,6 +67,7 @@ cpu1: cpu@1 {
 			reg = <0x1>;
 			device_type = "cpu";
 			enable-method = "psci";
+			clocks = <&scmi_clk SCMI_CLK_CPU>;
 		};
 
 		cpu2: cpu@2 {
@@ -73,6 +75,7 @@ cpu2: cpu@2 {
 			reg = <0x2>;
 			device_type = "cpu";
 			enable-method = "psci";
+			clocks = <&scmi_clk SCMI_CLK_CPU>;
 		};
 
 		cpu3: cpu@3 {
@@ -80,6 +83,22 @@ cpu3: cpu@3 {
 			reg = <0x3>;
 			device_type = "cpu";
 			enable-method = "psci";
+			clocks = <&scmi_clk SCMI_CLK_CPU>;
+		};
+	};
+
+	firmware {
+		scmi: scmi {
+			compatible = "arm,scmi-smc";
+			arm,smc-id = <0x82000010>;
+			shmem = <&scmi_shmem>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
 		};
 	};
 
@@ -88,6 +107,18 @@ psci {
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scmi_shmem: shmem@10f000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x0010f000 0x0 0x100>;
+			no-map;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.25.1


