Return-Path: <linux-kernel+bounces-520993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FACA3B25D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3227A5B75
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBE21C3BFE;
	Wed, 19 Feb 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiqzQO8e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FAA1C1F1F;
	Wed, 19 Feb 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950147; cv=none; b=FCwbal323+Ye0hAo1S7iE5liBnHIjJt0PX1cokHC8UVPv0AhxzvWbUr1yRkT3KVg1qBT3i4CfEFXPh8wq1xBK33rgffZaQeneYjV89H+le8JK0etPhCJlrFbAp/9fY3SgcM3DPC96uEV9s3oj+vizAv/HgeyTM95iBUYK3/fLdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950147; c=relaxed/simple;
	bh=HknlYHJ8tz+A28RZeAUK2n0RUQjxiS7iSFIcscAs29M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtwAfl+6jCxZji+HbCz+SA5exC1e2kqf0SQjH3kypE/PsrCTqTnWbcxiaC1DyAqoBkXqF3IcifakWfjUMi/uVvRJoyYRj7dSw8gncN1CuG62wwrmOzeE185KzZLKx4m9se5UjDr5fgXEgntHPX5VxA0qdqFitf02R5qSqaWTH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiqzQO8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F822C4AF0C;
	Wed, 19 Feb 2025 07:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739950147;
	bh=HknlYHJ8tz+A28RZeAUK2n0RUQjxiS7iSFIcscAs29M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jiqzQO8eqT3QKHvITTzpTJFutn318T6FeX52wLzdiQ192ziqOgc+XlIVA6rDaDMo2
	 05Nii76TGlENO/gIwUDfA+Eld/7Q0Ac22EFn8dw3hH0zK1eK8RJKSMHzohKczZpv8/
	 7sIyPQUGPlaJZ+JCBT8WRvWd6UN1pWBlT1ThbqvWeTqKm3OkORTA0bn/3Tto8PcpHo
	 0kO+ginu1RcpVYdS1ncERo233E8PmV/frQF8MTTwulg2TIaL96XlL7FEcoPwRBZZBl
	 2F8F5AbcdbYNvXALBinGYEe82FAZXFMkjDf8dYk7OmxWjey1aEUb4lL1uGSwcbBQZD
	 mqx/R0IrlkZ+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C79C021AA;
	Wed, 19 Feb 2025 07:29:07 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 19 Feb 2025 15:29:05 +0800
Subject: [PATCH 3/4] arm64: dts: Add gpio_intc node for Amlogic-A4 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-irqchip-gpio-a4-a5-v1-3-3c8e44ae42df@amlogic.com>
References: <20250219-irqchip-gpio-a4-a5-v1-0-3c8e44ae42df@amlogic.com>
In-Reply-To: <20250219-irqchip-gpio-a4-a5-v1-0-3c8e44ae42df@amlogic.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739950145; l=1112;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=Z5iS0U/t0eDJi8p3yWZRKRxB4HUB3kbspYJzuBGUEvY=;
 b=Xpu310zMvvJOvhySwQFInLA7e/xPbzguo5SyFqGfblvCL+ygDAlaELhoWgnENbuhhJ+xQrKq1
 K3d9dggFYJNBYgcd/0lSOCUkdoLjo6gDAug7q03p0JPQyhUfjKhwdcW
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add GPIO interrupt controller device.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index de10e7aebf21..a06838552f21 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -48,3 +48,24 @@ pwrc: power-controller {
 		};
 	};
 };
+
+&apb {
+	gpio_intc: interrupt-controller@4080 {
+		compatible = "amlogic,a4-gpio-intc",
+			     "amlogic,meson-gpio-intc";
+		reg = <0x0 0x4080 0x0 0x20>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		amlogic,channel-interrupts =
+			<10 11 12 13 14 15 16 17 18 19 20 21>;
+	};
+
+	gpio_ao_intc: interrupt-controller@8e72c {
+		compatible = "amlogic,a4-gpio-ao-intc",
+			     "amlogic,meson-gpio-intc";
+		reg = <0x0 0x8e72c 0x0 0x0c>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		amlogic,channel-interrupts = <140 141>;
+	};
+};

-- 
2.37.1



