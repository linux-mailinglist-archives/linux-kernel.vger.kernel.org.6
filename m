Return-Path: <linux-kernel+bounces-566115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDDCA6735A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD4E3B73DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A4020D4F9;
	Tue, 18 Mar 2025 12:00:20 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127220C48E;
	Tue, 18 Mar 2025 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299220; cv=none; b=JSdK3SQ6B59eSNVUowEc8x4klPjd77p2AiWCl/+wD+4Aoyp1mTZ9LhnjuceWeY7gznV7iSFTc9hgFOvDK/6YSdsLZVf9h0YYw3s2H/nglkTsN8sXDVF5l9VMFZHmsTMuO9RcjuAlTiB3dCAqOVqyCj1FI0MKFVm2puI8oGLJ1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299220; c=relaxed/simple;
	bh=3DF2Vett98XXx5SRaly2Eg9z3xLCC7Pu1QcbGky8wCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OgybVuM7G+AVSMrsjqJipV9K4XdvCm5Y23TdYqnA/EDEhpXBm7LaSrXPFSHp6Vgp8pNeDkI0fKCAq8jQMzjZKfzjG49NPT14jvLX8E4wCKfje/TOftTf+TAb+5EUzJW8yPxVBN/p+OY6iMHTpT44pknT2m+nQAj5rvjMp9EC2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.202])
	by smtp.qiye.163.com (Hmail) with ESMTP id eaf1c5d0;
	Tue, 18 Mar 2025 20:00:08 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Tue, 18 Mar 2025 20:00:02 +0800
Message-Id: <20250318120003.2340652-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250318120003.2340652-1-amadeus@jmu.edu.cn>
References: <20250318120003.2340652-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkJOVkxKTklKGU1KTkJPTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk9VSUtJWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a95a9201abd03a2kunmeaf1c5d0
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M1E6Myo6KzJKHEsYIVYeKygo
	ITkwFA9VSlVKTE9JSUJCSUtCS01MVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VJS0lZV1kIAVlBSUJMSTcG

Add pwm nodes for RK3528. The PWM core on RK3528 is the same as
RK3328, but the driver does not support interrupts yet.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 80 ++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 1af0d036cf32..621fc19ac0b3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -465,6 +465,86 @@ uart7: serial@ffa28000 {
 			status = "disabled";
 		};
 
+		pwm0: pwm@ffa90000 {
+			compatible = "rockchip,rk3528-pwm",
+				     "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa90000 0x0 0x10>;
+			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
+			clock-names = "pwm", "pclk";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@ffa90010 {
+			compatible = "rockchip,rk3528-pwm",
+				     "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa90010 0x0 0x10>;
+			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
+			clock-names = "pwm", "pclk";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@ffa90020 {
+			compatible = "rockchip,rk3528-pwm",
+				     "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa90020 0x0 0x10>;
+			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
+			clock-names = "pwm", "pclk";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@ffa90030 {
+			compatible = "rockchip,rk3528-pwm",
+				     "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa90030 0x0 0x10>;
+			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
+			clock-names = "pwm", "pclk";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@ffa98000 {
+			compatible = "rockchip,rk3528-pwm",
+				     "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa98000 0x0 0x10>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+			clock-names = "pwm", "pclk";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@ffa98010 {
+			compatible = "rockchip,rk3528-pwm",
+				     "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa98010 0x0 0x10>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+			clock-names = "pwm", "pclk";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@ffa98020 {
+			compatible = "rockchip,rk3528-pwm",
+				     "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa98020 0x0 0x10>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+			clock-names = "pwm", "pclk";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@ffa98030 {
+			compatible = "rockchip,rk3528-pwm",
+				     "rockchip,rk3328-pwm";
+			reg = <0x0 0xffa98030 0x0 0x10>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+			clock-names = "pwm", "pclk";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		saradc: adc@ffae0000 {
 			compatible = "rockchip,rk3528-saradc";
 			reg = <0x0 0xffae0000 0x0 0x10000>;
-- 
2.25.1


