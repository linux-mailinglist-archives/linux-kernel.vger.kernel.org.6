Return-Path: <linux-kernel+bounces-384936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944209B305F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219FBB22D12
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529091DACAA;
	Mon, 28 Oct 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A9E7NSti"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8ED1D88A4
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118926; cv=none; b=Zi58Y7LRr93Hh3O6AXJ8Y751ZYPGgzJZm9vhiaWgcVL00A7wfKc+wGH7EHE1M0IVeRXECWDTmHXo5cyIVjbITe8rNUkPXPKh7c2iquaBA9WaypDb88R39X5nt4/seZbJfFXTTbcDJAE+J/I91H3eok4acOnaV+/rriEU6uwLitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118926; c=relaxed/simple;
	bh=bM6C+bFnr0G2LMJ8gswA/V4V0gtpkY/DOVKFE2g5qtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gC9LZvLLVe3bbVkneNp3PI9c1g2cZnH6qdvOq+akUbJcIexWCD4J8DVRoIe/sdplMEecsJGsIcTkrkbQ65T0/3NoRRkNlZc/A2ZIqaGar0QRxbMYw9iXLgB/mwI40jdgZ0dMhx5sRFmEnRZbWoTfnZV6pN6qvsMpSBeqVEGfJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A9E7NSti; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=6GXIR
	h4j3i518ko1cqgv7mz2+TyzA7OmqSNKoxe1+2M=; b=A9E7NStithBvNIB9BsLnn
	uH8DNRgS8Bm0O9kkjTt2Kll5x3tPSjEXKPicflFAAWmWxQfLY27+Bn180LQHfuW9
	G+sCg6nCF8sBojvmhDWh+ZEZtP8K9K4lGtLwOHHTrrkh5E6SYFKxhLWL/am11grn
	+uyjNaBMJsH9yN0cFFeIi8=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3f+b5hB9nytgkBw--.9113S3;
	Mon, 28 Oct 2024 20:35:09 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 1/3] arm64: dts: rockchip: Enable HDMI0 for rk3588 Cool Pi CM5 EVB
Date: Mon, 28 Oct 2024 20:34:56 +0800
Message-ID: <20241028123503.384866-2-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028123503.384866-1-andyshrk@163.com>
References: <20241028123503.384866-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f+b5hB9nytgkBw--.9113S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWfZw48Kw18Xr13GFW5GFg_yoW8Ww17p3
	ZxurZ5GFZ3WFW7tw45Arn7tFs0yws5urW3GwnxZFy7tr4agFnYyw18GwnavFyDZFZrZayx
	CF1kJF1j9r4Dtr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEU73DUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxGGXmcfhCYMvQAAsR

As the hdmi-qp controller recently get merged, we can enable the
HDMI0 display on this board now.

Signed-off-by: Andy Yan <andyshrk@163.com>

---

Changes in v2:
- Remove enable-gpios as it is unevaluated
- Remove pinctrl setting as it use the default

 .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
index a4946cdc3bb3..010a1f2761e6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588-coolpi-cm5.dtsi"
 
 / {
@@ -22,6 +23,17 @@ backlight: backlight {
 		pwms = <&pwm2 0 25000 0>;
 	};
 
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi0_out_con>;
+			};
+		};
+	};
+
 	leds: leds {
 		compatible = "gpio-leds";
 
@@ -214,3 +226,38 @@ &usb_host1_ehci {
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&hdmi0 {
+	status = "okay";
+};
+
+&hdmi0_in {
+	hdmi0_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi0>;
+	};
+};
+
+&hdmi0_out {
+	hdmi0_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&hdptxphy_hdmi0 {
+	status = "okay";
+};
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi0_in_vp0>;
+	};
+};
-- 
2.43.0


