Return-Path: <linux-kernel+bounces-565890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99219A670A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275743AB1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65231207DFC;
	Tue, 18 Mar 2025 10:00:31 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53C206F3E;
	Tue, 18 Mar 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292031; cv=none; b=YnrvuMEMBuSAUxd5gz/k/5DkoVdqTJNt4uJ1OZCq+Wz7GNHrJ/4Dbq/QaIUcfTDBowm93Nb/vXsLQqXuVxPOtb8LxAnPMB/hEj9USJCAKMB+8duqSVvuDimvVKTpOZ7Sh4yrnFvCFhwT2Bf2ePSpSWHJUMOIJoIgaH7q6qjxiyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292031; c=relaxed/simple;
	bh=lD3gJY+HaMyGBmTOC1XyXZhjQQNQKMlPiv7u9gDoo4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VMjI118gBnR2yE4M1ZVj0PMAQXrTONOeyhIRiIK/kr1vHnS1JjvZ+z/L3RWLSMYC6oLflg3+JedkQMAl/zeZlfdTtU1BgdQzm622rGTKmWtG4hJDZ0th8KKQRowbePP0+ROYbNjBKdOGoVqpE2NrT6EptkCOjVWb7rVs+QcdSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.202])
	by smtp.qiye.163.com (Hmail) with ESMTP id eac37606;
	Tue, 18 Mar 2025 18:00:19 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Yao Zi <ziyao@disroot.org>
Cc: Rob Herring <robh@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 2/3] arm64: dts: rockchip: Add DMA controller for RK3528
Date: Tue, 18 Mar 2025 18:00:09 +0800
Message-Id: <20250318100010.2253408-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250318100010.2253408-1-amadeus@jmu.edu.cn>
References: <20250318100010.2253408-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTUNPVkpCGhhDH0tCSxoYS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk9VSUtJWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a95a8b2690503a2kunmeac37606
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6Hyo4FTJJGEstAg8CGBIU
	PTZPFEtVSlVKTE9JSUJJS0lLSUtKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VJS0lZV1kIAVlBSklDTTcG

Add DMA controller dt node for RK3528 SoC.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 7f1ffd6003f5..ad77e0ef70f2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -493,6 +493,24 @@ sdhci: mmc@ffbf0000 {
 			status = "disabled";
 		};
 
+		dmac: dma-controller@ffd60000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0xffd60000 0x0 0x4000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			arm,pl330-periph-burst;
+			clocks = <&cru ACLK_DMAC>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+		};
+
 		pinctrl: pinctrl {
 			compatible = "rockchip,rk3528-pinctrl";
 			rockchip,grf = <&ioc_grf>;
-- 
2.25.1


