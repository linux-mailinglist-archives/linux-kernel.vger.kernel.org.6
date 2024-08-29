Return-Path: <linux-kernel+bounces-306342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885A963DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FFA284688
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54033189F37;
	Thu, 29 Aug 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfSIb9dO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DD161914;
	Thu, 29 Aug 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918002; cv=none; b=rWs33tYi/naZYgQctV33DEwUzmrRb+Wdt5h3O9+GTyJplL7XNxCjUDP0tHAmTBA349FXLcudhOHyB7W0xkvY5SllffPZYu31AAUh3S/9IVqfjn6+oYZ/rzUJEJVjfMXvyX7t0FEeAsn9dyhKWYp3PGu2yXyOBGqONA+9c5qiSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918002; c=relaxed/simple;
	bh=MALyCXTtIxsCApUreBkRFcSk6W24UuS5XvmmThIBw8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V9HYWcdARF59iVoWbHmLNCuHuVpSDSQF5KW3UeWqk0nqXO86/90X3E33D9dS3CPfVEDenf+UzW0l3Fh6fwYEhwb5BVltzKSpvVXNEA5vnlPidgeeIZRkg0evftdnu1VgcEWwTP4IjFJEwE0BCFDINbzc0Hc+dhbqO+QxSDf1eKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfSIb9dO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2002C4CEC2;
	Thu, 29 Aug 2024 07:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724918001;
	bh=MALyCXTtIxsCApUreBkRFcSk6W24UuS5XvmmThIBw8A=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kfSIb9dOQzB7pCiuTYv/iHuXandmoYtN/5CO+2RCvIsh6KD2qabHcWCzblMuO+nQq
	 Jcylz+yiz7cr2k5rm+x2oGNtzSbreOuaN/oaXStPERoTJkX5Y+tdV59PEp+GGfBJpR
	 m1HcBHRCZlIurLLImEdl7QEyil0XYK/PsoLRnU86i8zZwhWswRdlF1QUi5BSHk3ngL
	 RSATqOJzCVL3gHyDupJg+lG1xif85TsaiE9UwEzJk4kjbbIqjzXALapDo0vUcZUizF
	 JHxCiTWoG3Adaf8BhXMhXCxttYwPtNCRrqCJM2pVxLbZsGU9pO0DMFJwx3jtsq5d2r
	 ZgXBYW+7o3uhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B1C6FD35;
	Thu, 29 Aug 2024 07:53:21 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 29 Aug 2024 10:52:57 +0300
Subject: [PATCH v3] ASoC: dt-bindings: cirrus,cs4271: Convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-cs4271-yaml-v3-1-f1624cc838f6@maquefel.me>
X-B4-Tracking: v=1; b=H4sIANgo0GYC/23MSw7CIBSF4a00jMVcLk0fjtyHcQDlYkn6EpTYN
 N27tCObODwn+f6FBfKOArtkC/MUXXDjkIY8Zaxp1fAg7kzaDAFzqLDgTcixFHxWfcdJVjWgBKO
 1ZUlMnqz77LXbPe3Whdfo5z0exfb+70TBBTfKSAsackH22qvnmyx1557YVor4q8ujxqQRdCFrb
 VCBOup1Xb/6oFTd5gAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724918001; l=6406;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=z7uDltoTHvw5cc3nOCnjkHGx/Fb83ySX2YkvThsXBos=;
 b=LMCxjrGcr6110qPTrlSie3q8RPtnQwXGzjKdeQm5fVV7iZ3I+trPusyJPq7oncQGE9m3oOW08Fqa
 xBAjY1MYCtT1GeN+jaHOh/c64yg/aU1HKx3ca12rKdPZ0BuvXkXn
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

Switch to 'reset-gpios' and drop legacy 'reset-gpio' used in original
bindings.

Based on Animesh Agarwal cs42xx8 conversion patch.

Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://lore.kernel.org/all/20240715-ep93xx-v11-0-4e924efda795@maquefel.me
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
This is complementary patch to ep93xx DT conversion series.

Based on "ASoC: dt-bindings: cirrus,cs4270: Convert to dtschema" patch.

Krzysztof, thank you once again for your patience.
---
Changes in v3:
- Switch to 'reset-gpios'
- Use 'codec' for node name
- Link to v2: https://lore.kernel.org/r/20240827-cs4271-yaml-v2-1-20b639bd2a0a@maquefel.me

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
index 000000000000..68fbf5cc208f
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
+  reset-gpios:
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
+        codec@0 {
+            compatible = "cirrus,cs4271";
+            reg = <0>;
+            #sound-dai-cells = <0>;
+            spi-max-frequency = <6000000>;
+            spi-cpol;
+            spi-cpha;
+            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
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



