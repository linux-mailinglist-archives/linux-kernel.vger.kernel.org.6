Return-Path: <linux-kernel+bounces-552415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20393A579A6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D707A6772
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422521B3940;
	Sat,  8 Mar 2025 10:00:19 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83441953A1;
	Sat,  8 Mar 2025 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741428018; cv=none; b=aEgJ1tdiec5dmmzo+nkNK0nirsmJo4Pb6c//qYOY7RR/jr/9pFOcJRjUa3kiGQyVU1uRqRUutVzMNCJmfnxdGZQ+mPbMQAfEW9ZwU8ymFwQb5T3RAGG1GYUQQyiIBA+S8KXGMptxFmrzN3JJqGqVnMocwbI+QEHvRDIAhBLsBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741428018; c=relaxed/simple;
	bh=/8PtZDm0HENmu8+4NZljUI3Hp7pUmf1vbG73MhOYXT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNBdhhHGS9I4J20Lsc9IU3sHjC5arBZ6+vSdzXcR926wysk2EmllP1kWEE6rKFX+knQPDojEySVfdyriJ8tBiMnNiK2E23ENNV7MJpMOazyDLa1KY9AnCLrIEIoLKyMFKpdCbD/sV8iclHsPakCKVCT4Svmq6TYKELLgUx8Q+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:3300:217:f42e:f419:35e])
	by smtp.qiye.163.com (Hmail) with ESMTP id d8ad0332;
	Sat, 8 Mar 2025 18:00:07 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Rob Herring <robh@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] arm64: dts: rockchip: rk356x: Move SHMEM memory to reserved memory
Date: Sat,  8 Mar 2025 18:00:01 +0800
Message-Id: <20250308100001.572657-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250308100001.572657-1-amadeus@jmu.edu.cn>
References: <20250308100001.572657-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGB5DVkIfSEJKGkpNTEwZSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUhIS0tBSUpMQR1PSR5BHU9KQkFITh5ZV1kWGg8SFR
	0UWUFZT0tIVUpLSU9PT0tVSktLVUtZBg++
X-HM-Tid: 0a957532a0cf03a2kunmd8ad0332
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAw6Eww5DTJWECkIPCs9Dy8V
	Qk4wCzdVSlVKTE9KT0lDS0tMTExIVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSEhLS0FJSkxBHU9JHkEdT0pCQUhOHllXWQgBWUFKTkpJNwY+

0x0 to 0xf0000000 are SDRAM memory areas where 0x10f000 is located.
So move the SHMEM memory of arm_scmi to the reserved memory node.

Fixes: a3adc0b9071d ("arm64: dts: rockchip: add core dtsi for RK3568 SoC")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 4f11141ea146..fd2214b6fad4 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -174,6 +174,18 @@ psci {
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
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
@@ -199,19 +211,6 @@ xin32k: xin32k {
 		#clock-cells = <0>;
 	};
 
-	sram@10f000 {
-		compatible = "mmio-sram";
-		reg = <0x0 0x0010f000 0x0 0x100>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x0 0x0010f000 0x100>;
-
-		scmi_shmem: sram@0 {
-			compatible = "arm,scmi-shmem";
-			reg = <0x0 0x100>;
-		};
-	};
-
 	sata1: sata@fc400000 {
 		compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";
 		reg = <0 0xfc400000 0 0x1000>;
-- 
2.25.1


