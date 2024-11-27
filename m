Return-Path: <linux-kernel+bounces-423263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFFF9DA52C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F415E283E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58533195FD1;
	Wed, 27 Nov 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9f+zsvY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855F191F7C;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701176; cv=none; b=mMBhZqSbRnU2IDn5CTQP4L2uOneEg+SjGcFRg5C+YvM+NlUro1Js89jFGeYxQqU5SFOwaMFBQeZj+tdCcNFPQiavzkpC+nZm3F58e6KOkvziHlz+BdTR0ChT6lAl/nBig3OTRNzRVaCV4uWYO8+3Y9UGbjg1yhPu6YVmCfTHw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701176; c=relaxed/simple;
	bh=qVYc4PRjCoyP3Y+OwwdNDXlkVWUjStNQm+XzC7o5J8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L3J6ywkONabvjRQ7YleepN8fs1VTN1ZEfAALbTPHmrr4BNO64A+YjPQQIzzRWyqI/6OglaoirKPKxyPm1w10HTN8ijGHaqf5RL6+k6eqscxcJtachYONmwAjWXDzpiKDmp62CRiMT8gW3wAwztKpV5e/wiv1e/LvP+vZ9K/Qn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9f+zsvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A889C4CED9;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732701176;
	bh=qVYc4PRjCoyP3Y+OwwdNDXlkVWUjStNQm+XzC7o5J8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o9f+zsvYC09+kZeR1wKs0hTR1xuo2kMQx8dNVa+kbQhG0StCap70herRilGL1gQM6
	 y0aJKW2G6j9rWDH/JTfQA1hDymWJFR7gZUR2n3L17acAf8NO1h3C2ASGifCgeCxrkV
	 om4ZETumO9JZa3uQ/wJ56plUJmYOOGKNokeA4qRggt8K1vX80DEahZMMlW9a5zx4Sr
	 xW4qhTbmgBjmGITbmO6iXuUw27Fz5D8u8OopAFCcQmLCGibZQ6PKDOP6kyg38zJ1BW
	 62uaEg2Fdv5GbLdGOV8c32lTJFFTWYmebfb9U964v18nBUoxLydGYnomh5VLOu+LTa
	 46wQkrTqJLc3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E80D609C7;
	Wed, 27 Nov 2024 09:52:56 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 27 Nov 2024 10:52:30 +0100
Subject: [PATCH RESEND 3/5] arm64: dts: apple: t8112: Add spi controller
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-asahi-spi-dt-v1-3-907c9447f623@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2887; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=qBexsIdH/GqhHy7brZ1sYsseqom1YJB59+/UbwP2L/Y=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnS3199kAmQMk2+x5WvrHfMw5Uo4lqjkNf2z8uwpv4oFR
 SR+zH7QUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCLvQxn+aTnqPhVYlLAo+aBo
 cJ3LG/eF4bsv/E8oe1I3deYaE5lCdUaGPQ3nF77cwKvEGcNsMbVAVDTmm0HD8VdH1WMPscZUvj/
 PAwA=
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
 arch/arm64/boot/dts/apple/t8112.dtsi | 44 +++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index 1666e6ab250bc0be9b8318e3c8fc903ccd3f3760..58d88f1ef92a32061765bd3b569fdae0255dcd7e 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -349,6 +349,13 @@ clkref: clock-ref {
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
@@ -467,6 +474,34 @@ fpwm1: pwm@235044000 {
 			status = "disabled";
 		};
 
+		spi1: spi@235104000 {
+			compatible = "apple,t8112-spi", "apple,spi";
+			reg = <0x2 0x35104000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 749 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_200m>;
+			pinctrl-0 = <&spi1_pins>;
+			pinctrl-names = "default";
+			power-domains = <&ps_spi1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi3: spi@23510c000 {
+			compatible = "apple,t8112-spi", "apple,spi";
+			reg = <0x2 0x3510c000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 751 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkref>;
+			pinctrl-0 = <&spi3_pins>;
+			pinctrl-names = "default";
+			power-domains = <&ps_spi3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		serial0: serial@235200000 {
 			compatible = "apple,s5l-uart";
 			reg = <0x2 0x35200000 0x0 0x1000>;
@@ -626,13 +661,20 @@ i2c4_pins: i2c4-pins {
 					 <APPLE_PINMUX(130, 1)>;
 			};
 
-			spi3_pins: spi3-pins {
+			spi1_pins: spi1-pins {
 				pinmux = <APPLE_PINMUX(46, 1)>,
 					<APPLE_PINMUX(47, 1)>,
 					<APPLE_PINMUX(48, 1)>,
 					<APPLE_PINMUX(49, 1)>;
 			};
 
+			spi3_pins: spi3-pins {
+				pinmux = <APPLE_PINMUX(93, 1)>,
+					<APPLE_PINMUX(94, 1)>,
+					<APPLE_PINMUX(95, 1)>,
+					<APPLE_PINMUX(96, 1)>;
+			};
+
 			pcie_pins: pcie-pins {
 				pinmux = <APPLE_PINMUX(162, 1)>,
 					 <APPLE_PINMUX(163, 1)>,

-- 
2.47.0



