Return-Path: <linux-kernel+bounces-437500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BB09E9417
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA031665E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341AB22A1E0;
	Mon,  9 Dec 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y2z1C4ic"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43286225783;
	Mon,  9 Dec 2024 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747436; cv=none; b=T3aHvsfAdbVeaJM8rCKPb5Fi/sWv+I1UkvC04u3sxxxP1vxwI4OH0fC4S/9xGnW47eM5OaT7L4pJAAF/OGIuGZVbhOf6IXqT5g0fOlZhLfJLn7hd5LUm1BUoCqbGuk1bmq6ATm9/xl/yOo8nS7nAM7aBbdghctlNfUltdBJmiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747436; c=relaxed/simple;
	bh=LBWpMXAREluMjNn1J3aP415M5CvgxrIagrx6SQfnA5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHeI7iaXuA9f/z5+dslXl5akUNLsfGCJnvjrc/zm7Wq3zf2nEDzQdOpPjbvFr1yQKmmFpiQVtIqoYG+ahNqrzzTI3ofdwsv9zS8otg3qZbBwDg6CuGGnGsKAjz2bEzJnHekhjxVTiE+abPYtJuCLucnW8SY9oz9kJi4mktR/fuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y2z1C4ic; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=hHFtb
	WxMIZp65Rbn0nrqgPsTaDmioigLj6AKnHkoIQ0=; b=Y2z1C4icsvGdtmS5H9Evi
	YTDDBuK35uqb3Jd3W+U4CI0Q6g7HZfA6wVB4n5ILsbDV5y1LRyHQrDwZXqlBVgJ7
	kkSQjAzXsCYm+OSTKYtIobC/aCA1x+k5oIS86slca9oaoGoPJMpxwj9Ts6xQz4zX
	U9nY80bK9Mt3kVKlYiDLo8=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3Woe44lZnubZICA--.5849S3;
	Mon, 09 Dec 2024 20:29:50 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] arm64: dts: rockchip: Add vop for rk3576
Date: Mon,  9 Dec 2024 20:29:11 +0800
Message-ID: <20241209122943.2781431-2-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209122943.2781431-1-andyshrk@163.com>
References: <20241209122943.2781431-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3Woe44lZnubZICA--.5849S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1rKF43WF17CrW5Gw1rJFb_yoW5GrWkp3
	ZrCrW8Jr4kWF129a9xKryvyrZ5Ja95C3Z7KwnxAF1UKr1Ykr9rKrySgr93J3Zrtr48XanF
	vFs2kry8Krs3Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfqXPUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gCwXmdW3S-iwAACsf

From: Andy Yan <andy.yan@rock-chips.com>

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 70 +++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 70ddedb0c890..45823a758b6e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -393,6 +393,11 @@ opp-950000000 {
 		};
 	};
 
+	display_subsystem: display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vop_out>;
+	};
+
 	firmware {
 		scmi: scmi {
 			compatible = "arm,scmi-smc";
@@ -832,6 +837,70 @@ gpu: gpu@27800000 {
 			status = "disabled";
 		};
 
+		vop: vop@27d00000 {
+			compatible = "rockchip,rk3576-vop";
+			reg = <0x0 0x27d00000 0x0 0x3000>, <0x0 0x27d05000 0x0 0x1000>;
+			reg-names = "vop", "gamma-lut";
+			interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "vop-sys",
+					  "vop-vp0",
+					  "vop-vp1",
+					  "vop-vp2";
+			clocks = <&cru ACLK_VOP>,
+				 <&cru HCLK_VOP>,
+				 <&cru DCLK_VP0>,
+				 <&cru DCLK_VP1>,
+				 <&cru DCLK_VP2>;
+			clock-names = "aclk",
+				      "hclk",
+				      "dclk_vp0",
+				      "dclk_vp1",
+				      "dclk_vp2";
+			iommus = <&vop_mmu>;
+			power-domains = <&power RK3576_PD_VOP>;
+			rockchip,grf = <&sys_grf>;
+			rockchip,pmu = <&pmu>;
+			status = "disabled";
+
+			vop_out: ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				vp0: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				vp1: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				vp2: port@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+			};
+		};
+
+		vop_mmu: iommu@27d07e00 {
+			compatible = "rockchip,rk3576-iommu", "rockchip,rk3568-iommu";
+			reg = <0x0 0x27d07e00 0x0 0x100>, <0x0 0x27d07f00 0x0 0x100>;
+			interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "vop_mmu";
+			clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
+			clock-names = "aclk", "iface";
+			#iommu-cells = <0>;
+			power-domains = <&power RK3576_PD_VOP>;
+			status = "disabled";
+		};
+
 		hdmi: hdmi@27da0000 {
 			compatible = "rockchip,rk3576-dw-hdmi-qp";
 			reg = <0x0 0x27da0000 0x0 0x20000>;
@@ -873,7 +942,6 @@ hdmi_out: port@1 {
 			};
 		};
 
->>>>>>> 2b62c69b3a4c (arm64: dts: rockchip: Add hdmi for rk3576)
 		qos_hdcp1: qos@27f02000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f02000 0x0 0x20>;
-- 
2.34.1


