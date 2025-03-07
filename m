Return-Path: <linux-kernel+bounces-550688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09BA562F4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC301890294
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C761E5B6C;
	Fri,  7 Mar 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md0ZYSPb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4481E1DF1;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337364; cv=none; b=Ck/KfpBMv2X1E4GgYxIRvi948Om7LkPFgilzogrjeAzRpEcH4fR9ospRzH8Ewcfe3vlK1INqO/fgsVRmEavbqC7pvT0JczcNEHqsWMAL2KPFqqTrol+k3Mb3Ptt+DbcTB69tUX5rd7o/TC+t8HNlEXehls60Qylqxrf8SCYt8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337364; c=relaxed/simple;
	bh=qXZhNxUy9y5s5LhZ9M7FyoFK7Zgj7Uh6fOjZphxmzps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=odyzzCBuiPpezYFVwMV+UrKEGXUco+ie5JwoGFmTzumZY+BNagYXzU16Tw15dLvCc4AVRjCHp5N9eh+ot2LB0kbGJ1OVLnYtgEJ9O68P1wg6AwSSaRhmPMAVgyZCgKnfSx3JmdZUeZoswp+qqntLwvNFELetysEAqgNw/MclDKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md0ZYSPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 516BEC4CEEC;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741337364;
	bh=qXZhNxUy9y5s5LhZ9M7FyoFK7Zgj7Uh6fOjZphxmzps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=md0ZYSPb/P4FG91UXlUfP2JGoesWUYXKU6FFDIzB4h3LxXNr28DrKdPoIadcSw1td
	 WheHs9cPzaRgBvO7v2LR52Sy94QCFnrrew8s48R7eVBuWrDfmD4C9F4VCR+4NZS2qw
	 mcCKKGV/x6+o3wLciBIUpmWyBTpaiwcsC3L/XZq+EcBfUO2j6xRMa43aakO5aKKHIH
	 n0VKmgRk9UqQ0MWYrx8Dw+QCBBzPMKqEXB7c+FistIZnCd9MGcRvT2yfnlKqeui9IY
	 9Va9dWQbTvFasY0KN7m9RTQtzY7ryOAtFTQTJd1nH68suWo6oxo+yzXSgZRO9zRh88
	 8juk5dXq5s2Ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457A1C28B26;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 07 Mar 2025 16:49:25 +0800
Subject: [PATCH v4 4/4] arm64: dts: Add gpio_intc node for Amlogic A5 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-irqchip-gpio-a4-a5-v4-4-d03a9424151b@amlogic.com>
References: <20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com>
In-Reply-To: <20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741337362; l=835;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=+kt3Jevc/8KR/ZsMbFbD2TjHFreHkm3hzIePStnSOmI=;
 b=MDQNhpdNEmkPri99GvIxngM3EfyIFOe+NJ0Srzmz1WprEJbTfp6YR1nPfH1MJS4gpS2u/UlyM
 ytnOe21oduvDDXuMsMalh1fGthEyI4xBGzR+e/Dx3ltOplUp/EH6KP3
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
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
index 17a6316de891..32ed1776891b 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
@@ -48,3 +48,15 @@ pwrc: power-controller {
 		};
 	};
 };
+
+&apb {
+	gpio_intc: interrupt-controller@4080 {
+		compatible = "amlogic,a5-gpio-intc",
+			     "amlogic,meson-gpio-intc";
+		reg = <0x0 0x4080 0x0 0x20>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		amlogic,channel-interrupts =
+			<10 11 12 13 14 15 16 17 18 19 20 21>;
+	};
+};

-- 
2.37.1



