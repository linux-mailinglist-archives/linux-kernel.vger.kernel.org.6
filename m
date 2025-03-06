Return-Path: <linux-kernel+bounces-548921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634B1A54AE0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3593AF142
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D786420C48D;
	Thu,  6 Mar 2025 12:38:27 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B531FC0E5;
	Thu,  6 Mar 2025 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264707; cv=none; b=ejjvRauIvIcks2boFco+zXVKWifNMe2dtl+LX8TpMltzb9+5KdckSaiVHAWj9020hxSWld4WHJO3BjSfnKAq5tKQvv8Hn2MLcYIHvaZ74omR/iLrXO65jKgMQ/HrCcqKc9yPLrLu524xtvKnC5qqZ0jY50rZfj9ZhpChPMWHcss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264707; c=relaxed/simple;
	bh=xxOvVK9Sks7tUoVjapi3LlbR4PhZGDeFV3rJrw00MF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A2KstlmQwYSL/DFMi12w+a2SlGdCTvY7dH4oQ8h/KbYNhjYDlAjn+yspnRybh96PkmgD8ABQ0077kgSdlcqm1HDpcWvW9eXZlgtj/WQxMLrfAfge9jLT4TuPzA2m5ueq6F6OyJUnM7ux0L5VJKCJsMQXCt2bppqOCG/46hlvOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id d2b83ca7;
	Thu, 6 Mar 2025 20:38:21 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Yao Zi <ziyao@disroot.org>
Cc: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Add rk3528 QoS register node
Date: Thu,  6 Mar 2025 20:38:09 +0800
Message-Id: <20250306123809.273655-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306123809.273655-1-amadeus@jmu.edu.cn>
References: <20250306123809.273655-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTxkZVk9ISx9LGEtCHUsZTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktJT09PS1VKS0tVS1
	kG
X-HM-Tid: 0a956b76c86d03a2kunmd2b83ca7
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAg6Hio4QzJMKjM#GiJLIwpN
	PiIwCTBVSlVKTE9KSU1PTEtJSU9OVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQU9CTUk3Bg++

The Quality-of-Service (QsS) node stores/restores specific
register contents when the power domains is turned off/on.
Add QoS node so that they can connect to the power domain.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 160 +++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index b1713ed4d7e2..0c0e7f151462 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -129,6 +129,166 @@ gic: interrupt-controller@fed01000 {
 			#interrupt-cells = <3>;
 		};
 
+		qos_crypto_a: qos@ff200000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200000 0x0 0x20>;
+		};
+
+		qos_crypto_p: qos@ff200080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200080 0x0 0x20>;
+		};
+
+		qos_dcf: qos@ff200100 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200100 0x0 0x20>;
+		};
+
+		qos_dft2apb: qos@ff200200 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200200 0x0 0x20>;
+		};
+
+		qos_dma2ddr: qos@ff200280 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200280 0x0 0x20>;
+		};
+
+		qos_dmac: qos@ff200300 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200300 0x0 0x20>;
+		};
+
+		qos_keyreader: qos@ff200380 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200380 0x0 0x20>;
+		};
+
+		qos_cpu: qos@ff210000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff210000 0x0 0x20>;
+		};
+
+		qos_debug: qos@ff210080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff210080 0x0 0x20>;
+		};
+
+		qos_gpu_m0: qos@ff220000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff220000 0x0 0x20>;
+		};
+
+		qos_gpu_m1: qos@ff220080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff220080 0x0 0x20>;
+		};
+
+		qos_pmu_mcu: qos@ff240000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff240000 0x0 0x20>;
+		};
+
+		qos_rkvdec: qos@ff250000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff250000 0x0 0x20>;
+		};
+
+		qos_rkvenc: qos@ff260000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff260000 0x0 0x20>;
+		};
+
+		qos_gmac0: qos@ff270000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270000 0x0 0x20>;
+		};
+
+		qos_hdcp: qos@ff270080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270080 0x0 0x20>;
+		};
+
+		qos_jpegdec: qos@ff270100 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270100 0x0 0x20>;
+		};
+
+		qos_rga2_m0ro: qos@ff270200 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270200 0x0 0x20>;
+		};
+
+		qos_rga2_m0wo: qos@ff270280 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270280 0x0 0x20>;
+		};
+
+		qos_sdmmc0: qos@ff270300 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270300 0x0 0x20>;
+		};
+
+		qos_usb2host: qos@ff270380 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270380 0x0 0x20>;
+		};
+
+		qos_vdpp: qos@ff270480 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270480 0x0 0x20>;
+		};
+
+		qos_vop: qos@ff270500 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270500 0x0 0x20>;
+		};
+
+		qos_emmc: qos@ff280000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280000 0x0 0x20>;
+		};
+
+		qos_fspi: qos@ff280080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280080 0x0 0x20>;
+		};
+
+		qos_gmac1: qos@ff280100 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280100 0x0 0x20>;
+		};
+
+		qos_pcie: qos@ff280180 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280180 0x0 0x20>;
+		};
+
+		qos_sdio0: qos@ff280200 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280200 0x0 0x20>;
+		};
+
+		qos_sdio1: qos@ff280280 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280280 0x0 0x20>;
+		};
+
+		qos_tsp: qos@ff280300 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280300 0x0 0x20>;
+		};
+
+		qos_usb3otg: qos@ff280380 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280380 0x0 0x20>;
+		};
+
+		qos_vpu: qos@ff280400 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280400 0x0 0x20>;
+		};
+
 		cru: clock-controller@ff4a0000 {
 			compatible = "rockchip,rk3528-cru";
 			reg = <0x0 0xff4a0000 0x0 0x30000>;
-- 
2.25.1


