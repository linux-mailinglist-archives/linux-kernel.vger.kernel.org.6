Return-Path: <linux-kernel+bounces-303017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9BD960637
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBEA1C225CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4219D89C;
	Tue, 27 Aug 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6efe963"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2419D08C;
	Tue, 27 Aug 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752166; cv=none; b=GFfLqzTvJoQzyLXBmPEc367kDe2AisS/QpgiqSqd5FOi+WOkKdJVYReZI+A2OKWc8wB2jxrBdzrYqd4hlPTfEXUPdAgxtfXb0dHi+s3XFtA3MlU9O7nkJQimhfXpmaBR6sbFbl3bQOL2Qaw/ZGp1qf1MWHio1YGQMwNe7CpAb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752166; c=relaxed/simple;
	bh=iNv0wXI/nZ2z5SOuqcqXrsK/xbtmVdJN9dDrdIhkckA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=obtx7yVGRDRSdOe/basVkntHtiFNk23uaivAEQKl6wtaE8ZJfJluKTuX5c3yH021xPg1kQIs81/Eba9MlNVbovSNfKZEgRCkXqbediqEG7HaHt70SMpNMnotS4ZHy8vezFKFrNHSFQ2HKsq0WKB7lpO5Fh+03KWKnGFo+Wug0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6efe963; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BA2EC8B7A0;
	Tue, 27 Aug 2024 09:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724752165;
	bh=iNv0wXI/nZ2z5SOuqcqXrsK/xbtmVdJN9dDrdIhkckA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=m6efe963aikBlmBhRqaTVUulhOdaT4cjDm/1j/0YdxqwbMmDmMrDs7/iwT4WFfZ0m
	 XX/CII9ZXyE2UsDQX0tmAaYdviMiVM7ioj69UrG80UxKottHMzx3aYWb7+miq3TXlx
	 lmr+eXov3od5Z+s/WxREQOmLLYGWs5Z80MPpX9nPNsSsVdfMrA8WTJ2RKVNeO/atkq
	 P4xkN5zsY8B4J7nB+xgJsaU2IqZqeR8/Bv9mVl86JH/bpKMU/Pgt3OHMpixQRl9W/0
	 6Dddej6zkITmhmlNKqQmTgyJN/DL9FnASLjw42MMy/79Hmc48Nu4zleZufD8hx22v2
	 wp5IHSDNN7jEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0F6C5320E;
	Tue, 27 Aug 2024 09:49:25 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 27 Aug 2024 12:49:18 +0300
Subject: [PATCH v2] ASoC: dt-bindings: cirrus,cs4271: Convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-cs4271-yaml-v2-1-20b639bd2a0a@maquefel.me>
X-B4-Tracking: v=1; b=H4sIAB2hzWYC/23MSw7CIBSF4a00dyzm8ohWR+7DdADlYklKW0GJT
 cPexY4d/ic53waJoqcE12aDSNknP081xKGBftDTg5i3tUGgUNiKE+uTEmfOVh1GRrK9oJBojXF
 QH0sk5z+7du9qDz695rjueOa/9b+TOePMaisdGlSc3C3o55scjcdA0JVSvjDanr2oAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724752164; l=6248;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=4hAM2qL86gmfVW6M1IUn1jvplDjSBUff8BfQwZfoSlA=;
 b=F4EY2DVdZyxGiRFpX4+LQPbfC0BRiL2fvywxvUxP0BDwb9NF29/Lbz2oshDfXHqVwbb8hmERjTxN
 BiYqtcioBLMvM5HrHTQEuuKRT0IM87+/iaglQzO7cZFMwBifmI24
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Convert the Cirrus Logic CS4271 audio CODEC bindings to DT schema.

Add missing spi-cpha, spi-cpol, '#sound-dai-cells' and port, as they
are already being used in the DTS and the driver for this device.

Based on Animesh Agarwal cs42xx8 conversion patch.

Keep the original 'reset-gpio' used in bindings,
instead of 'reset-gpios' used in cs42xx8.

Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://lore.kernel.org/all/20240715-ep93xx-v11-0-4e924efda795@maquefel.me
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
This is complementary patch to ep93xx DT conversion series.

Based on "ASoC: dt-bindings: cirrus,cs4270: Convert to dtschema" patch.

Krzysztof, thank you very much for quick review!
---
Changes in v2:
Krzysztof Kozlowski:
- fix SoB above link
- replace 'driver' with 'device'
- mention properties not present in original bindings
- mention using 'gpio-reset' instead of 'gpios-reset'
- dropped unused label
- use defines for gpio bindings
- newline at end of file
- Link to v1: https://lore.kernel.org/r/20240826-cs4271-yaml-v1-1-dad3f0b041ef@maquefel.me
---
 .../devicetree/bindings/sound/cirrus,cs4271.yaml   | 101 +++++++++++++++++++++
 Documentation/devicetree/bindings/sound/cs4271.txt |  57 ------------
 2 files changed, 101 insertions(+), 57 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml
new file mode 100644
index 000000000000..cc5b48ceafa4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml
@@ -0,0 +1,101 @@
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
+  The CS4271 is a stereo audio codec. This device supports both the I2C
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
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cs4271@0 {
+            compatible = "cirrus,cs4271";
+            reg = <0>;
+            #sound-dai-cells = <0>;
+            spi-max-frequency = <6000000>;
+            spi-cpol;
+            spi-cpha;
+            reset-gpio = <&gpio0 1 GPIO_ACTIVE_LOW>;
+            port {
+                endpoint {
+                    remote-endpoint = <&i2s_ep>;
+                };
+            };
+        };
+    };
+
+...
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



