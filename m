Return-Path: <linux-kernel+bounces-528375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB9BA41708
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EC73B1EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41E242934;
	Mon, 24 Feb 2025 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ClcbFF8v"
Received: from mail-m3299.qiye.163.com (mail-m3299.qiye.163.com [220.197.32.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213F24166A;
	Mon, 24 Feb 2025 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384872; cv=none; b=ThX3g6/0RdnBYeb8opZ2a4dhLTU4RzhLEPgSwWGWNQm+4MremfVsR3XetDZcR7tf4daWC5k3KIXrkVkZVeFgWaLfV/fCtavjIhTq7C7OpRfiWLU2qAGSOIigkmsrW2alk3MrBbn1+SEZuOQmLoidDiAqO8wQRK/qekU2aSguhMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384872; c=relaxed/simple;
	bh=MXYZosYNWXPyoge+Rlv4+JeeONSw/MWHUsMxx2PXRTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZQ1d3G3UJurxakejme1/d54wLs9MqpuB7n3bq6VkQaqc4jt7jL8JGUe5wLI+iFtYEahHEy7LRWqFsdrKCIg3VKxIMQPaNm2CPestvaPKpmVnHXuwwzJJHJB8nQxH+mtYMkvcteK0KKNTU1v5sI4C8nzADgXco4prJIktA77UNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ClcbFF8v; arc=none smtp.client-ip=220.197.32.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bfd28856;
	Mon, 24 Feb 2025 16:14:24 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dmitry.baryshkov@linaro.org,
	dianders@chromium.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	boris.brezillon@collabora.com,
	l.stach@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v7 14/15] arm64: dts: rockchip: Add eDP0 node for RK3588
Date: Mon, 24 Feb 2025 16:13:24 +0800
Message-Id: <20250224081325.96724-15-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224081325.96724-1-damon.ding@rock-chips.com>
References: <20250224081325.96724-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx1DGVYYT00YSRkeHkgdShhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9537058ab303a3kunmbfd28856
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzY6Hww6GTIULxMCNj0UERdJ
	AUgKCg9VSlVKTE9LSENPQ01NTExLVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKT0xONwY+
DKIM-Signature:a=rsa-sha256;
	b=ClcbFF8vdYTHK/+iHwpAZokpuDQqcE0ZgpmSgUz1r3gpAm396wQngkvWHbiLg/znOnzIFTCABs+X512he9RzRvY/nLZK7LEqY3wDPDKJ//SM1kBBr64xZm+wInJVL3MHeVzDOWLQHO44ug63cHgv6qxZsgYPUKe76N59HpwaWP8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=0FGcNJWIvGFWgnAJXPV53XsegYYbwW5nYaQTOeqtjiw=;
	h=date:mime-version:subject:message-id:from;

Add support for the eDP0 output on RK3588 SoC.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v3:
- Remove currently unsupported property '#sound-dai-cells'

Changes in v4:
- Remove currently unsupported clock 'spdif'
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 2403a3950128..7e089422c947 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1410,6 +1410,34 @@ hdmi0_out: port@1 {
 		};
 	};
 
+	edp0: edp@fdec0000 {
+		compatible = "rockchip,rk3588-edp";
+		reg = <0x0 0xfdec0000 0x0 0x1000>;
+		clocks = <&cru CLK_EDP0_24M>, <&cru PCLK_EDP0>;
+		clock-names = "dp", "pclk";
+		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH 0>;
+		phys = <&hdptxphy0>;
+		phy-names = "dp";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_EDP0_24M>, <&cru SRST_P_EDP0>;
+		reset-names = "dp", "apb";
+		rockchip,grf = <&vo1_grf>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp0_in: port@0 {
+				reg = <0>;
+			};
+
+			edp0_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	qos_gpu_m0: qos@fdf35000 {
 		compatible = "rockchip,rk3588-qos", "syscon";
 		reg = <0x0 0xfdf35000 0x0 0x20>;
-- 
2.34.1


