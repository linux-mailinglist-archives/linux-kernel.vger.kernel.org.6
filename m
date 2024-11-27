Return-Path: <linux-kernel+bounces-423265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E579DA52E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691EA1651D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A419644B;
	Wed, 27 Nov 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1TBUVjk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7B1946A8;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701176; cv=none; b=trg16iKkbsIqD3CX+PrUkqp3cTMzQ0pCZ5S1Yd/0plrxEnpwdYTzWzbqwx5b5Y/eq9a4Nchlzetq4LM3ZYWmQTnFfwMja83WSqOGZrGNCdo4/D0cngN3T9OHjhaEpmjl2g5Dgq0Fc3PPvmdHKcQ2jlxnchcGdj4rH2xbCiJfcsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701176; c=relaxed/simple;
	bh=x9YfcGI+ZMh7plS2PDtsRxbl863X2kEq1VSJEDKldzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O0i/V92Co4oGYWT62hO3zFEvf8nPAumPkixJv5DNgbLNiUhFjjP2wUxsUOqNwbgDaJ34nj5W510L9OIoA5KMC0iuy1aq2XhAB1ooVlyE2VPLDRL9XTuQQce9NzaBIc10kIL/V96ja/uHj9u7EjY+CbQC16n3/GRP3WCn+VpzVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1TBUVjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47E9EC4CEDF;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732701176;
	bh=x9YfcGI+ZMh7plS2PDtsRxbl863X2kEq1VSJEDKldzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E1TBUVjk2slqZ6IodrOc5R6f2TUTezGdCT6av+1D5xr94H4XGgnlpV8SD2hDxk0Ms
	 metmA9HDfw/7l6wPrhOweQ6FxCjf9psYIvURHtCH6ftIoZNiUhniWV1Ke41ybT8+OO
	 tr+/PtN86aspHfrG5oXYsf/jFLHzU9DBnFsCRwPvafIhE4L7RCjagkg0noin1iRx11
	 C3Z61q76Xh+G+RpOd/23OnS8yRhmu5tP1TnL5Dk4yTPEmgBp7l6GLM4xCzA7WmS30T
	 F/+rPjWGk99cb/wlnql2oM8WAjYlJ65qRevnWz+Hgxe4snWQPKutRADGogO9w9SqG/
	 yQ3epybzjTbcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4047BD609C8;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 27 Nov 2024 10:52:31 +0100
Subject: [PATCH RESEND 4/5] arm64: dts: apple: t600x: Add spi controller
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-asahi-spi-dt-v1-4-907c9447f623@jannau.net>
References: <20241127-asahi-spi-dt-v1-0-907c9447f623@jannau.net>
In-Reply-To: <20241127-asahi-spi-dt-v1-0-907c9447f623@jannau.net>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3545; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=+9ZFqpJ8nwSbJAAJz7hiOfMfbrOzc9lBaAhTOBlh010=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnS3199Sg2//E4+fn39gr8z9iw1ZC4Jid5v77g+cdvFKy
 KucK12bO0pZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExkyQuGf6bVaaJWXWxFL6cs
 7D9faSL91MUl4IFpUJ6Qk2llmHu2BsP/evaFlfb16mfeP72zwN9ypVlO7uSpM5dcfNMsFrB8tc5
 TTgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Janne Grunau <j@jannau.net>

Apple silicon devices have one or more SPI devices. Add device tree
nodes for all known controllers. The missing ones could be guessed and
tested with a little effort but since the devices expose no pins and
no new devices are expected there is no point in spending the effort.
SPI is used for spi-nor and input devices like keyboard, trackpad,
touchscreen and fingerprint reader. Only the spi-nor flash has upstream
drivers. Support for it will be added in a following commit.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t600x-common.dtsi    |  7 +++++++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi      | 28 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi | 14 +++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t600x-common.dtsi b/arch/arm64/boot/dts/apple/t600x-common.dtsi
index fa8ead69936366999786cdd4910266ee08b5ca7a..87dfc13d74171f62bf3087401918d9d41eaac560 100644
--- a/arch/arm64/boot/dts/apple/t600x-common.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-common.dtsi
@@ -362,6 +362,13 @@ clkref: clock-ref {
 		clock-output-names = "clkref";
 	};
 
+	clk_200m: clock-200m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+		clock-output-names = "clk_200m";
+	};
+
 	/*
 	 * This is a fabulated representation of the input clock
 	 * to NCO since we don't know the true clock tree.
diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index b1c875e692c8fb9c0af46a23568a7b0cd720141b..e9b3140ba1a996eeb91b3f60470833060b632bd2 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -163,6 +163,34 @@ i2c5: i2c@39b054000 {
 		status = "disabled";
 	};
 
+	spi1: spi@39b104000 {
+		compatible = "apple,t6000-spi", "apple,spi";
+		reg = <0x3 0x9b104000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1107 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clk_200m>;
+		pinctrl-0 = <&spi1_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_spi1>;
+		status = "disabled";
+	};
+
+	spi3: spi@39b10c000 {
+		compatible = "apple,t6000-spi", "apple,spi";
+		reg = <0x3 0x9b10c000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1109 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clkref>;
+		pinctrl-0 = <&spi3_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_spi3>;
+		status = "disabled";
+	};
+
 	serial0: serial@39b200000 {
 		compatible = "apple,s5l-uart";
 		reg = <0x3 0x9b200000 0x0 0x1000>;
diff --git a/arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi b/arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
index b31f1a7a2b3fc36e7dfa480d27012d6d0fd56f97..1a994c3c1b79f088d685e13d1dc16e7d1e6546f4 100644
--- a/arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
@@ -36,6 +36,20 @@ i2c5_pins: i2c5-pins {
 			<APPLE_PINMUX(101, 1)>;
 	};
 
+	spi1_pins: spi1-pins {
+		pinmux = <APPLE_PINMUX(10, 1)>,
+			<APPLE_PINMUX(11, 1)>,
+			<APPLE_PINMUX(32, 1)>,
+			<APPLE_PINMUX(33, 1)>;
+	};
+
+	spi3_pins: spi3-pins {
+		pinmux = <APPLE_PINMUX(52, 1)>,
+			<APPLE_PINMUX(53, 1)>,
+			<APPLE_PINMUX(54, 1)>,
+			<APPLE_PINMUX(55, 1)>;
+	};
+
 	pcie_pins: pcie-pins {
 		pinmux = <APPLE_PINMUX(0, 1)>,
 				<APPLE_PINMUX(1, 1)>,

-- 
2.47.0



