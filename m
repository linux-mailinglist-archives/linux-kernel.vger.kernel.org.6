Return-Path: <linux-kernel+bounces-436191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7239E824E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B57188195E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE6194A64;
	Sat,  7 Dec 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o+NFop28"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A70158874;
	Sat,  7 Dec 2024 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733607184; cv=none; b=I8oDqcj43TaKMbS4Ofnykkb2TO6d/3EyN/eK3p8eeu/kOa+022m/0+NW3r+LNT0Ss0MDF82Kv0u+ev0Hi2Rx3/GR632ifWj2lbosFiPF5pM8vG1ZdDBKdRGeajIUK3T+7xpbA46cQ+00xHi1bundcYv23l9jzvF6rlOeIm9Siqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733607184; c=relaxed/simple;
	bh=SCcXEr+KFbRx8TCn5PCWtq/V3Qw/KVqvlgOoYmZD3W0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYJ7/O4KF55PL+xWt4FMQWpFJ1N/HHb9cFaAOw/gw64xFwUPyiW6+v+vXO9BOuQKaDxTc3Y7mHyJqqIsXXR5ZA6uNqMOFydbf8KqF9HC+f5Gmy3phnPALXqo2+Tkfz6QXbiUEhTXL5eeJ7aA9u4vqRvz0WyEUyZatEyBTBstLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o+NFop28; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733607174;
	bh=SCcXEr+KFbRx8TCn5PCWtq/V3Qw/KVqvlgOoYmZD3W0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o+NFop28mM500kuvIyn5uKh7Rj4QxJjpNp7hffTFtXdprwLi0l6rdUmTL3xbvbyp2
	 Xf5+kYrylwa/BUuH9Ctihrm3sRlElxK4/TDj4kYVJgWe3OkxXyM+WTAVtxMXRW5krc
	 jepubeIiCpliycVLelRSWix216s9lQIx8WCoyiOHkUKrCRS7QBH76zckpS6YbUKXEU
	 /tS+ySluGVWV78/KznNMy7QlhO8YU/MQjg4EpIBfvcYZhoNMnhxh/IXv8vn5Yx5Okk
	 V/6rOYNTJuN2VvtGH2z40mZ/ZrpKZsNuIKv6kJfTOsULB9jlHf/yFp4U6btnAINWG7
	 1qgiAcUA9IMjg==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B809B17E3806;
	Sat,  7 Dec 2024 22:32:54 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 07 Dec 2024 23:32:27 +0200
Subject: [PATCH 4/4] arm64: dts: rockchip: Enable HDMI1 on rock-5b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241207-rk3588-hdmi1-v1-4-ca3a99b46a40@collabora.com>
References: <20241207-rk3588-hdmi1-v1-0-ca3a99b46a40@collabora.com>
In-Reply-To: <20241207-rk3588-hdmi1-v1-0-ca3a99b46a40@collabora.com>
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
Radxa ROCK 5B.

While at it, switch the position of &vop_mmu and @vop to maintain the
alphabetical order.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 42 +++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index c44d001da16978bbbb8a93d652893a786e9ea79b..bf9e4dc601555050d8857e03b2f1fb5fe2cadaac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -49,6 +49,17 @@ hdmi0_con_in: endpoint {
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
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -220,10 +231,30 @@ hdmi0_out_con: endpoint {
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
 &hdptxphy_hdmi0 {
 	status = "okay";
 };
 
+&hdptxphy1 {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
@@ -891,11 +922,11 @@ &usb_host2_xhci {
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
 
@@ -905,3 +936,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
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
2.47.0


