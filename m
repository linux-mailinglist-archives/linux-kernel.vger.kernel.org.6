Return-Path: <linux-kernel+bounces-515918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5473EA36A6C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B21B7A02E8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A8B1A317A;
	Sat, 15 Feb 2025 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YHX+RxPr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DE1FDA65;
	Sat, 15 Feb 2025 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580966; cv=none; b=sl8JD3DoSfMUadqWMxztN1cH9sy0jUdOhbRidmGLmFireR5ET2KlBVS+pCw3UwlADEqzOyuuwtUWcslmvuzEPxATwTBjaFsITf2ZMI8DhRiPoq2Hgf7B7nrLZMUujYguzNOuwLjpQ0/L2neWSWtMQP1XS3civAkj4d/8o+zn9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580966; c=relaxed/simple;
	bh=SamXBzmLvsEp0Jz0d1kldxkjLOu7b/3p5uRtusyt+UA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FtbFLjQT6Hy+F6s72C88B+5QAUKGL5Dros6M9+aw2SksS2J7Z3cCNZByP0uDRHjhmZejq9Xe2PD4OnMkfyZ0ORXrZJStkd3PY9wwEjaotE87XnrDuHHbFmWTTTyQLKubLNzbJuwXwE0ImJt0LsIK7qcSFK6LubH70ENo4CjosRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YHX+RxPr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739580959;
	bh=SamXBzmLvsEp0Jz0d1kldxkjLOu7b/3p5uRtusyt+UA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YHX+RxPrOuFbD+K59CXEFQAKW0HgHAw+8zomFsb8XCMPAUAIK9LnBBkYXUAGtoZot
	 Yr2h1HVHvWsManylI0wE8R54lIaqsvDqPHcw2vs5q2C6BjA9mcWMZDMEI7WfPSwrVW
	 DMCHpLcI+jjq/fMurpyrvcxTsp4n55fXyCVl6MyrGYPweNpty1qeQjUbQEKlNGKfcr
	 Y+tcnqZb2JHSTgh1M21nkOsTONZ6mpTln9Y42PVtMw/n/tA4FZaf7RcQExzH+9ILnT
	 3ZxLNvamZHzLkAetsNE+EJAwVrql4HGXdF7lf0OzPagELxU4A4tkAuIX3V4CmPnWx7
	 wox9izcsH8Ifw==
Received: from localhost (144.232.221.87.dynamic.jazztel.es [87.221.232.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 3229D17E1553;
	Sat, 15 Feb 2025 01:55:59 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 15 Feb 2025 02:55:40 +0200
Subject: [PATCH 4/4] arm64: dts: rockchip: Enable HDMI1 on rk3588-evb1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-vop2-hdmi1-disp-modes-v1-4-81962a7151d6@collabora.com>
References: <20250215-vop2-hdmi1-disp-modes-v1-0-81962a7151d6@collabora.com>
In-Reply-To: <20250215-vop2-hdmi1-disp-modes-v1-0-81962a7151d6@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Add the necessary DT changes to enable the second HDMI output port on
Rockchip RK3588 EVB1.

While at it, switch the position of &vop_mmu and @vop to maintain the
alphabetical order.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 42 ++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index 3fd0665cde2ca15cd309919ff751b00e0f53a400..27a7895595ee9fa2f5d5f3096cbe334c1d3792cf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -132,6 +132,17 @@ hdmi0_con_in: endpoint {
 		};
 	};
 
+	hdmi1-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi1_con_in: endpoint {
+				remote-endpoint = <&hdmi1_out_con>;
+			};
+		};
+	};
+
 	pcie20_avdd0v85: regulator-pcie20-avdd0v85 {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie20_avdd0v85";
@@ -364,10 +375,30 @@ hdmi0_out_con: endpoint {
 	};
 };
 
+&hdmi1 {
+	status = "okay";
+};
+
+&hdmi1_in {
+	hdmi1_in_vp1: endpoint {
+		remote-endpoint = <&vp1_out_hdmi1>;
+	};
+};
+
+&hdmi1_out {
+	hdmi1_out_con: endpoint {
+		remote-endpoint = <&hdmi1_con_in>;
+	};
+};
+
 &hdptxphy0 {
 	status = "okay";
 };
 
+&hdptxphy1 {
+	status = "okay";
+};
+
 &i2c2 {
 	status = "okay";
 
@@ -1371,11 +1402,11 @@ &usb_host1_xhci {
 	status = "okay";
 };
 
-&vop_mmu {
+&vop {
 	status = "okay";
 };
 
-&vop {
+&vop_mmu {
 	status = "okay";
 };
 
@@ -1385,3 +1416,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi0_in_vp0>;
 	};
 };
+
+&vp1 {
+	vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI1>;
+		remote-endpoint = <&hdmi1_in_vp1>;
+	};
+};

-- 
2.48.1


