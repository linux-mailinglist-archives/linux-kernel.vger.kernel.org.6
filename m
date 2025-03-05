Return-Path: <linux-kernel+bounces-545990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85189A4F4EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B435D16F2CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642FD155759;
	Wed,  5 Mar 2025 02:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RJBxt7FU"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59BD45C18;
	Wed,  5 Mar 2025 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143130; cv=none; b=laun7cLd3I18lyvum/AurZGToiq2GxUYs8WskEsKi1lLBVbB1nvkSS19Yqz1HFC+aICcR/Pi7mqLy71+gXKPKWM5jJ9tsFoDJVUKRqqFmStXJJ8AJFBMDpJ0SBKvT37cagaO6zHxQTtAQ1J77RGEaaaX4FW6evcsIKT7bjrv1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143130; c=relaxed/simple;
	bh=BjUzDGG2uqrl5td7fH/jXaBFGM73Wqr8j5jwDS7q0O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5oDsaztRnZBzj65a8Hz1kCzEYJsMfpA04eyod36LqVoTxdjpJbTLeTB7+DXgHyTDtl2VSVzoVXeJDKuCA0FRZ7IK4nPTIN/8WZ+tX7V79faselkKGGxlLkzw3iFTDKqNm3S1m3sxyv9pUvvaVpe1bQqdaZPLh5m4HOLc7RBPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RJBxt7FU; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Hhp6O
	Mq7QEiuEHCE9JTlQzy04Sjlh7bKraEQa8mkuMs=; b=RJBxt7FUWocvfgEoQ2d6a
	SdNr+Ji9Fxpb3xA7zrrLAShod0mLoKRU0bB0lEHIqM0Yd0Ae8Wn9oTmz6rv/Tkv2
	KcK0lD5FfYuUap8PbhzhHg1wrmXE68wW8yGmKfxKv31bj5qXLAPqjbNcDoEQqr6y
	TMdBEi+lOu6Xb5BhxsnYdQ=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCXiC4yvMdnOWxcQQ--.60442S2;
	Wed, 05 Mar 2025 10:51:33 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: detlev.casanova@collabora.com,
	kever.yang@rock-chips.com,
	krzk+dt@kernel.org,
	cl@rock-chips.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] arm64: dts: rockchip: Enable hdmi out display for rk3576-evb-v10
Date: Wed,  5 Mar 2025 10:51:11 +0800
Message-ID: <20250305025128.479245-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXiC4yvMdnOWxcQQ--.60442S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4fGr1kArWxArWkKr1ftFb_yoW8Ww4Up3
	ZrurZxGFZ3WrW2qwnIyF10qFn8tws5AFZxAr17XFy3tr4agas3Kw1fGrn5Z3W5AFW7Z3y3
	uF1kJas09r4qqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOb18UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkBMHXmfHucNUCgAAse

From: Andy Yan <andy.yan@rock-chips.com>

Enable vop and hdmi on rk3576 evb1, so we can get a display output
on this board now.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 .../boot/dts/rockchip/rk3576-evb1-v10.dts     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
index 318e13d2ea55..52ea6917b7de 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3576.dtsi"
 
 / {
@@ -58,6 +59,17 @@ button-vol-up {
 		};
 	};
 
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds: leds {
 		compatible = "gpio-leds";
 
@@ -271,6 +283,26 @@ &eth1m0_rgmii_bus
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&hdptxphy {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 
@@ -734,3 +766,18 @@ &usb_drd1_dwc3 {
 	dr_mode = "host";
 	status = "okay";
 };
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
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};
-- 
2.34.1


