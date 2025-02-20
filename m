Return-Path: <linux-kernel+bounces-523277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEEAA3D4A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29063188B8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A501EDA20;
	Thu, 20 Feb 2025 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="QjHWmZwR"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1E1E9B38
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043533; cv=none; b=LmZhb7OYI6XX2kMDydM3GoqcE6AofR5d/PmXowpeo3xmkchddjfjM0M9d1CL7R3xWrAOsZ8Rz3lekl2HBCSzGzWeYhOyIdI+oFK0fX+JQdK4uEUyY9/P+b+/gGdiAHRBhQe9UfwgBcSlFQGczPsbfDlMpsIlMWh/Ul8wJIiy3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043533; c=relaxed/simple;
	bh=ozFkjRwIC/1y/YomaBS/k4K+ZqQMk5kDJUNz71TAgW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O6kEuwAUbHUvW8zivbUntCDV8ikMbXMip3t5HvjT3jOZnpXYxcuwVW7gYBteEHWze3AB4Jkd9zGDUYBCl9oy33L+R/XwYJ1Zx2UEAcw+Ki5jJbwRUTX3E+hbvvZTfxoCt/zigpA2Bh1+3Rxm2szVgNx2G3h7UgSpPtK8t+WzVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=pass smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=QjHWmZwR; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1740043527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVW5J4glcstwL8pO5zARxAOWRima9waQoO3il9sQJ8k=;
	b=QjHWmZwR7bQMYAU4Chhs4VFlZcVdo4os87BaSwNf+wmx56BU1r47OELc83vGIAuQ4kMWZh
	0ulZjI0wgGqYfISlW+ISnTqFTsT4RNR6ICEDZFJP0qyXgC4Ea42GQak93qUZtI55fmD3Jn
	TiZ+hGNLtNFfekaQTeSOJdwHiaAHu1GkCVmllU4yJ85NqCeZ3AupW9f7DGcn+JQPR/lJsH
	JtcM8IQhlmDr/b9ulpkR17L74rEZPJo+Qu4tsuWSSmrG/9/vE4mQqNvy0ofXnbFWkibtsk
	ekYP0A2orN0SjuVPDiRZ6M+UvcpoyMOXNVOgqexukJJ37fVJTAPuCC67qrwNEQ==
From: John Watts <contact@jookia.org>
Date: Thu, 20 Feb 2025 20:25:10 +1100
Subject: [PATCH] riscv: dts: allwinner: d1: Add thermal sensor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-thermal-v1-1-5168ddfc86e8@jookia.org>
X-B4-Tracking: v=1; b=H4sIAPX0tmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3ZKM1KLcxBxdCwPjlFTLlESD5FQzJaDqgqLUtMwKsEnRsbW1AKz
 VjWxZAAAA
X-Change-ID: 20250220-thermal-803de9da0ce6
To: Maxim Kiselev <bigunclemax@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, 
 John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1740043512; l=2043;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=kcBR7kSu99tIXz9DSLnGY6m94ZbCPKA4Lxb+LGfH64U=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAc8TVZ0UIlxel4wmURqW5qmq
 81E7hOouwLxFGMuHDMJGNdKfClHAoXoeh58TiOyTwhFF1SevY3l+ME1EWr8kQBgUAAUcA
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
X-Migadu-Flow: FLOW_OUT

From: Maxim Kiselev <bigunclemax@gmail.com>

This patch adds a thermal sensor controller node for the D1/T113s.
Also it adds a THS calibration data cell to efuse node.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: John Watts <contact@jookia.org>
[John Watts: Remove disabled status]
---
This is a quick fixed version of Maxim Kiselev's patch from here:

https://lore.kernel.org/all/20231217210629.131486-4-bigunclemax@gmail.com/

It removes the disabled status as requested. I've tested it by adding thermal
zones to my board and it works from what I can see.
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index e4175adb028da2be539e7aa316206fec4810adfc..cc3f9cc9b8ed20121924cc932412a6b6342a2f86 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -166,6 +166,18 @@ gpadc: adc@2009000 {
 			#io-channel-cells = <1>;
 		};
 
+		ths: thermal-sensor@2009400 {
+			compatible = "allwinner,sun20i-d1-ths";
+			reg = <0x02009400 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(58) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			#thermal-sensor-cells = <0>;
+		};
+
 		dmic: dmic@2031000 {
 			compatible = "allwinner,sun20i-d1-dmic",
 				     "allwinner,sun50i-h6-dmic";
@@ -426,6 +438,10 @@ sid: efuse@3006000 {
 			reg = <0x3006000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@14 {
+				reg = <0x14 0x4>;
+			};
 		};
 
 		crypto: crypto@3040000 {

---
base-commit: eca631b8fe808748d7585059c4307005ca5c5820
change-id: 20250220-thermal-803de9da0ce6

Best regards,
-- 
John Watts <contact@jookia.org>


