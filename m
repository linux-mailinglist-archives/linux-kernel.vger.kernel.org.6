Return-Path: <linux-kernel+bounces-547697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E316AA50C79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238893A5521
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9714256C9A;
	Wed,  5 Mar 2025 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6SjSP42"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26318255E58;
	Wed,  5 Mar 2025 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206406; cv=none; b=JfVo23zXuOl3VpJEmjFqU6axw00jGMhsJ3zfTFpPn4/R7mbqzbL9HIknob0+l7TxBbS7CKuwzcuiST/oP2QpLy5OsR1J5/zba4jHh3PV16h+O2ZTotLCVTSvE2ZUnEl2dw784AU1NCFrkrZX8NRokGeswURvCAxsa6mRQun+Kng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206406; c=relaxed/simple;
	bh=kuKRm6ObXyU/LdsbRhf//+NRMZ7w2rKpz+i8gcq330U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgxt5BI6kWMuu052O0B0STUGkiE18M5VC6tYejy5M0f69otMBDm3YElLwcdMF9j4XwjBsLFBcmTC90wLCxv7WY40xRPJdZfUtN/BoUNz0AnjaxVkCyE6F1B8TG1aGk0g1x3J/PBoebdb9AN/wx0fWkuwsJPXYhQldLRqyhEwmag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6SjSP42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96FA4C4CEEA;
	Wed,  5 Mar 2025 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741206405;
	bh=kuKRm6ObXyU/LdsbRhf//+NRMZ7w2rKpz+i8gcq330U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A6SjSP42yisLd39mKYxLB5H3Hc/VDZ/YZ6iDObr1sbWkbdBb2Dle/wWbvnZegMcJf
	 VSqqkVRFgdXw6p9CEMOO1qaKxgRV6m6s8s7HgXQtShfUYhvniudiWGpjDTb4ojA2Jq
	 CPIhgV7mKVxE9wMbFpoSbSuaa3jX6O5ynK8uQL+DjChVUyK/y0pAPU83Uc5UD3CIp+
	 mQAT30QoGvQweyArwIcDyS0MCo0wySbbfDRbPmXBQBCQRY1424DooD9gZxOCtA8P1B
	 9cQKAJsb9mKtiU01FwcVWWfOSnTq00r/KUYbGIUPt83Fsmy0E//mjuoskIgfIr7vy+
	 3rW4HNIwgRyqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB8FC19F32;
	Wed,  5 Mar 2025 20:26:45 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Wed, 05 Mar 2025 21:26:41 +0100
Subject: [PATCH 3/3] arm64: dts: apple: Add SPMI controller nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-spmi-v1-3-c98f561fa99f@gmail.com>
References: <20250305-spmi-v1-0-c98f561fa99f@gmail.com>
In-Reply-To: <20250305-spmi-v1-0-c98f561fa99f@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741206403; l=2612;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=Q7f2vFfLkm+JIytIUuMQHuqnolBvgEBZ+1SuUnKYc0w=;
 b=JZGv20ciLYhjLTFooeMI07jT+4fp5RYKV26v46dtFR8aRmrM57U4pr1G/H44VodOpmk1x8BPk
 iwQzu0fKtk/C4HQoPI08ZwGVnguEA/bD3jvRMe4d2dM01yu365divdD
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add device tree entries for the SPMI controller

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 arch/arm64/boot/dts/apple/t600x-die0.dtsi | 7 +++++++
 arch/arm64/boot/dts/apple/t8103.dtsi      | 8 ++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi      | 8 ++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index b1c875e692c8fb9c0af46a23568a7b0cd720141b..d544a35c8af414c583d38b040e1aa753902f1c93 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -53,6 +53,13 @@ wdt: watchdog@2922b0000 {
 		interrupts = <AIC_IRQ 0 631 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	nub_spmi0: spmi@2920a1300 {
+		compatible = "apple,t6000-spmi", "apple,spmi";
+		reg = <0x2 0x920a1300 0x0 0x100>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+	};
+
 	sio_dart_0: iommu@39b004000 {
 		compatible = "apple,t6000-dart";
 		reg = <0x3 0x9b004000 0x0 0x4000>;
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 9b0dad6b618444ac6b1c9735c50cccfc3965f947..0f03dc808cf7c6b7d71afc79dd29d368f957f979 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/apple.h>
+#include <dt-bindings/spmi/spmi.h>
 
 / {
 	compatible = "apple,t8103", "apple,arm-platform";
@@ -604,6 +605,13 @@ pcie_pins: pcie-pins {
 			};
 		};
 
+		nub_spmi: spmi@23d0d9300 {
+			compatible = "apple,t8103-spmi", "apple,spmi";
+			reg = <0x2 0x3d0d9300 0x0 0x100>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
 		pinctrl_nub: pinctrl@23d1f0000 {
 			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x3d1f0000 0x0 0x4000>;
diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index 1666e6ab250bc0be9b8318e3c8fc903ccd3f3760..4b3730c46c4d14a582627f69094b458ec7481da9 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -641,6 +641,14 @@ pcie_pins: pcie-pins {
 			};
 		};
 
+
+		nub_spmi: spmi@23d714000 {
+			compatible = "apple,t8112-spmi", "apple,spmi";
+			reg = <0x2 0x3d714000 0x0 0x100>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
 		pinctrl_nub: pinctrl@23d1f0000 {
 			compatible = "apple,t8112-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x3d1f0000 0x0 0x4000>;

-- 
2.48.1



