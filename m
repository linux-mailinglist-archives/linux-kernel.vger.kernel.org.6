Return-Path: <linux-kernel+bounces-548976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7DDA54BA2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8531A174D20
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0420D516;
	Thu,  6 Mar 2025 13:10:33 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25720C499;
	Thu,  6 Mar 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266633; cv=none; b=lPTtjRvWjVOOaEfqB8rvmQKM5VX4ofE1um3ohNdG3MGu2SrclLYXS5i9h7QqPDK4YhKBefyWZzOgc+4DjEPVbSr7KeTVANrRuz7Cw5JRGwVYKXtkeMi7C+JJu4R+sx60eYdrB8ypUPwfsavaztp9UeS7pP5sJ/aBz1YIsZgMobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266633; c=relaxed/simple;
	bh=fxDXot0edkGnucFpCM+6BrrZJon5UATf1D+bJ9W9Okw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nid/mOaZiMnhNfK/mGjBnrLK24zBWwGM8jt+nVvASyRT1FIRVz2mPST9UpPEqKFPWaM2pCGJ7sApKDzv2KQWydcCYt5P5IOjY6jFAL5xq2ZkYuBmsimgQrxAQVmm3N5iVqJYC45QpWcyU+OnNvvsJuQBBTV/dwVW75jmYd+/wdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id d2ca2cf2;
	Thu, 6 Mar 2025 21:10:26 +0800 (GMT+08:00)
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
Subject: [PATCH 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Thu,  6 Mar 2025 21:10:16 +0800
Message-Id: <20250306131016.281290-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306131016.281290-1-amadeus@jmu.edu.cn>
References: <20250306131016.281290-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkIaVh1LGB5CTB4eTx4ZTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a956b94261403a2kunmd2ca2cf2
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kwg6UQw4FzIDTTMZTk1PDhgT
	NzoKFD9VSlVKTE9KSU1NTUlNTU1DVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUpCT0w3Bg++

Same as RK3568, RK3528 uses SCMI clk instead of ARMCLK.
Add SCMI clk for CPU, GPU and RNG will also use it.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 0c0e7f151462..aa68c2fef2f3 100644
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
 
@@ -110,6 +129,19 @@ gmac0_clk: clock-gmac50m {
 		#clock-cells = <0>;
 	};
 
+	sram@10f000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x0010f000 0x0 0x100>;
+		ranges = <0 0x0 0x0010f000 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		scmi_shmem: sram@0 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x100>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges = <0x0 0xfe000000 0x0 0xfe000000 0x0 0x2000000>;
-- 
2.25.1


