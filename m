Return-Path: <linux-kernel+bounces-545531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B672A4EE39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DF9174EDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DA625F979;
	Tue,  4 Mar 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Kpf9Gqre"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9562780E6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119426; cv=none; b=kZym3f7fUZY6gIMb5++E5suyWPtUrN1cpgxgPXnu0g7oWaVK4ZVtf7rXUxJA8u3oYULolZwBy7mHT8T7k41q1SGpM0c76ATixRgoqp3JHjH4x6KAqfGbmyWRbeYtaYR+2jqlrzIg4dqaRE9BMl/4WU2F7QKbggCgizy2KvXl+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119426; c=relaxed/simple;
	bh=ti3aFRm2XLD+p490ujwQOzXNV8wHWv6NpXNQoM03SW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbpNabCCFAtktq9YZBtKqUOwP0+r5yiZsXafWprXjaN6uwa0uw5lySdRkxsLBpnhY+s0WQkXHnLHgIaBLrUgo+pSEf+z5tHEnv/3V0ugR9tms5RakWcu/9l3rVC3qt8oTVVv6UPREopFYAqxLIfVMPzB9f1h/qsoR4Dc3DVaSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Kpf9Gqre; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741119424; bh=VymoCBuQbJVOZiQ8kCmp23B7JKJ6M1aDwHI+dP/rK28=;
 b=Kpf9GqreTuqafx+ed87COjLL/9d/ZsZvmWvP8EMRqAQu1DGb+6bmJqDUFA/kcOM1GxLq2Hwj5
 ub6nTTwXH5k+0HI1UFWlDiimdIP1fxpUl7CCHvi3eV58GKg22I+YEeMDzD2mo4kwzfHw7khbPUR
 xbjvS8vlvGjzrKqWz0URf+mWqqEDj6cyIsrZDQ0RE7ufHea9Dajcn7+DqYuhsFp6FkPSu7uXrr+
 LoiYO0wqVozhSOO1V882ganRdyw7/47i9gaWcpr4CW54StWcCqZI+y61qT3xvGmYrkB7JCOFDmV
 PhGt5nAgo8o/g4hMn8Jl2WxsYVCPQkfnh1kKaQ67ztWg==
X-Forward-Email-ID: 67c75fbd66a4509299dbdfaa
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Add maskrom button to Radxa E20C
Date: Tue,  4 Mar 2025 20:16:37 +0000
Message-ID: <20250304201642.831218-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304201642.831218-1-jonas@kwiboo.se>
References: <20250304201642.831218-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Radxa E20C has two buttons, one SARADC maskrom button and one GPIO user
button.

Add support for the maskrom button using a adc-keys node, also add the
regulators used by SARADC controller.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
index b378774d2a4e..5346ef457c2a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
@@ -19,6 +19,20 @@ chosen {
 		stdout-path = "serial0:1500000n8";
 	};
 
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-maskrom {
+			label = "MASKROM";
+			linux,code = <KEY_SETUP>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -61,6 +75,35 @@ led-wan {
 			linux,default-trigger = "netdev";
 		};
 	};
+
+	vcc_1v8: regulator-1v8-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	vcc_3v3: regulator-3v3-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_sys: regulator-5v0-vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
 };
 
 &pinctrl {
@@ -85,6 +128,11 @@ wan_led_g: wan-led-g {
 	};
 };
 
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0m0_xfer>;
-- 
2.48.1


