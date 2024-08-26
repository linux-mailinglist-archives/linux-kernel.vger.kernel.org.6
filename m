Return-Path: <linux-kernel+bounces-301209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0026795EDC0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC522838BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29F81465A4;
	Mon, 26 Aug 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOirCdii"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125C146581;
	Mon, 26 Aug 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666003; cv=none; b=IpjeAkJxgqRe7bk5w9j+cb9ykX7Y6m6MsFuiSr3LWVIq8sV/YlLTGqpA8PHjtK7TNi9EOeURIHQtKlowYBurQQNwisa0lUYVIO8cqheZEiUznXuCm/ef7/Y4rFK+vM9MB2Y86Mf0+VgrCYPi0Cnd+rf0IP8o00faRxkY7F7dclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666003; c=relaxed/simple;
	bh=Ug/x3tr45hzvv7fRR3FhamGYtug56GmKsRN/db9q/jI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SD+fKD3MVNL7qp2baeL7oKKLnmjlulRZTI8lvKXFPF/UVsbTTvsYWEdY1vxLoYYd2qar3IUTy1Us9xOKZKaAN3KYtYz0NRJUZ5P1JkzJNkrnTzx/Odh1dSn2MH47y6EfkBk/V8l9vYsdfL8bYIlz/FXX5F0hFjI8Z04b4pOyT54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOirCdii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47B1BC5141B;
	Mon, 26 Aug 2024 09:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724666003;
	bh=Ug/x3tr45hzvv7fRR3FhamGYtug56GmKsRN/db9q/jI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=QOirCdiiAMbXNgmY0OPUvJIXyj2Lgo6OVl+j4ceWPMAupwz7Ct4VfCGBVGzi9sEjA
	 GHpqllboW/X8n+rPl63bHmtp+I6OfTE6HQWcLHTx88+ss0A3jdCRZc1kDgCN9sn5K6
	 sXi5teD68OGIuVhtC/BILdpMmbwKFpjsxP44D2LGfIQLe/451dN0z4PAbIF02l7eee
	 T7u8o3g34/MBPqjRvSLfa0cAvw+Nlx+50lXNr00a1id5wBzWWJVHjMHN3GINUuNoBb
	 Fkju/uWOM/5powcLNVR6DycChK1v3+ZF0wIlNOvCf3JCj3hoRoE39RX23lov1fhoxt
	 ZirRrBf35Of4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E83FC5321D;
	Mon, 26 Aug 2024 09:53:23 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Aug 2024 12:53:08 +0300
Subject: [PATCH] ASoC: dt-bindings: cirrus,cs4271: Convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-cs4271-yaml-v1-1-dad3f0b041ef@maquefel.me>
X-B4-Tracking: v=1; b=H4sIAINQzGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyMz3eRiEyNzQ93KxNwc3VRjC0sDI2ODlKSkNCWgjoKi1LTMCrBp0bG
 1tQC/5/+UXQAAAA==
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724666002; l=5234;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=GRy6WLVokizOeb8p/5VYo3MDJi8y2Fw/p8AH0P7Qby4=;
 b=KYGDv2HkUyItR7HwIF+XvufSO8R8sBZ+eAHBsn2VvLtiVE4+a3K2u1oxbIC0zZzvtlGZ+dFSIRDF
 h7II+WYDBzVKLjW3VIpnxy8/z1C64ndgm2cZ6qw70Xj0NUfgbd6A
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Convert the Cirrus Logic CS4271 audio CODEC bindings to DT schema.

Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Link: https://lore.kernel.org/all/20240715-ep93xx-v11-0-4e924efda795@maquefel.me
---
This is complementary patch to ep93xx DT conversion series.

Based on "ASoC: dt-bindings: cirrus,cs4270: Convert to dtschema" patch.
---
 .../devicetree/bindings/sound/cirrus,cs4271.yaml   | 91 ++++++++++++++++++++++
 Documentation/devicetree/bindings/sound/cs4271.txt | 57 --------------
 2 files changed, 91 insertions(+), 57 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml
new file mode 100644
index 000000000000..dd104483ab81
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,cs4271.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS4271 audio CODEC
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+description:
+  The CS4271 is a stereo audio codec. This driver supports both the I2C
+  and the SPI bus.
+
+allOf:
+  - $ref: dai-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: cirrus,cs4271
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  '#sound-dai-cells':
+    const: 0
+
+  reset-gpio:
+    description:
+      This pin will be deasserted before communication to the codec starts.
+    maxItems: 1
+
+  va-supply:
+    description: Analog power supply.
+
+  vd-supply:
+    description: Digital power supply.
+
+  vl-supply:
+    description: Serial Control Port power supply.
+
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
+  cirrus,amuteb-eq-bmutec:
+    description:
+      When given, the Codec's AMUTEB=BMUTEC flag is enabled.
+    type: boolean
+
+  cirrus,enable-soft-reset:
+    description: |
+      The CS4271 requires its LRCLK and MCLK to be stable before its RESET
+      line is de-asserted. That also means that clocks cannot be changed
+      without putting the chip back into hardware reset, which also requires
+      a complete re-initialization of all registers.
+
+      One (undocumented) workaround is to assert and de-assert the PDN bit
+      in the MODE2 register. This workaround can be enabled with this DT
+      property.
+
+      Note that this is not needed in case the clocks are stable
+      throughout the entire runtime of the codec.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cs4271: codec@0 {
+            compatible = "cirrus,cs4271";
+            reg = <0>;
+            reset-gpio = <&gpio0 1 0>;
+        };
+    };
+
+...
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/sound/cs4271.txt b/Documentation/devicetree/bindings/sound/cs4271.txt
deleted file mode 100644
index 6e699ceabacd..000000000000
--- a/Documentation/devicetree/bindings/sound/cs4271.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-Cirrus Logic CS4271 DT bindings
-
-This driver supports both the I2C and the SPI bus.
-
-Required properties:
-
- - compatible: "cirrus,cs4271"
-
-For required properties on SPI, please consult
-Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Required properties on I2C:
-
- - reg: the i2c address
-
-
-Optional properties:
-
- - reset-gpio: 	a GPIO spec to define which pin is connected to the chip's
-		!RESET pin
- - cirrus,amuteb-eq-bmutec:	When given, the Codec's AMUTEB=BMUTEC flag
-				is enabled.
- - cirrus,enable-soft-reset:
-	The CS4271 requires its LRCLK and MCLK to be stable before its RESET
-	line is de-asserted. That also means that clocks cannot be changed
-	without putting the chip back into hardware reset, which also requires
-	a complete re-initialization of all registers.
-
-	One (undocumented) workaround is to assert and de-assert the PDN bit
-	in the MODE2 register. This workaround can be enabled with this DT
-	property.
-
-	Note that this is not needed in case the clocks are stable
-	throughout the entire runtime of the codec.
-
- - vd-supply:	Digital power
- - vl-supply:	Logic power
- - va-supply:	Analog Power
-
-Examples:
-
-	codec_i2c: cs4271@10 {
-		compatible = "cirrus,cs4271";
-		reg = <0x10>;
-		reset-gpio = <&gpio 23 0>;
-		vd-supply = <&vdd_3v3_reg>;
-		vl-supply = <&vdd_3v3_reg>;
-		va-supply = <&vdd_3v3_reg>;
-	};
-
-	codec_spi: cs4271@0 {
-		compatible = "cirrus,cs4271";
-		reg = <0x0>;
-		reset-gpio = <&gpio 23 0>;
-		spi-max-frequency = <6000000>;
-	};
-

---
base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
change-id: 20240826-cs4271-yaml-e3890230dbbf

Best regards,
-- 
Nikita Shubin <nikita.shubin@maquefel.me>



