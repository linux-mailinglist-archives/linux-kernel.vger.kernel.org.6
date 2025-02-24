Return-Path: <linux-kernel+bounces-529511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD1AA42736
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6136A3B5BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062B261593;
	Mon, 24 Feb 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="tP4zyfNX"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F00221F00;
	Mon, 24 Feb 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412518; cv=none; b=PgSlT/W32zoOvyLlw9p37p/3b8IgnHIsxbwQpiF2lXMUITo0XNvZ6EJBrOcIgDEZQIHm9Ij50Ht6Nc6+6Hs7kNxKq/SPG4zySL2chB93bwOM85RYxjTiB/bIiJYYUliRkY88gx9Lbf4qh9oNJNaotRlCF8CQoDwFA/4Gtbg0AqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412518; c=relaxed/simple;
	bh=zUqgJStw7LAI5K7zUabnJlCU9IfT32qqy1wWSMnNcCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eyk4luAUIWV0xjhMmWzgYJoAd4BGkWe8ebKYngAxFtXEyBmgeTg6oq8A7j08smPQkL2FBeZxcR/W06G7DCSmpLXeNrXJ76ilnyK+sQdoj6aUpwcAX+JlJDmdDeMwkXHV7MltCCMJSeO6EPP9tA21s/1KClE31hTYR4uV+yHtY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=tP4zyfNX; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 10D2D1FB68;
	Mon, 24 Feb 2025 16:55:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740412507;
	bh=+1ZoflOzJXeYt9WTAcrPFAGrSpNtmA3nQiz905jptCk=; h=From:To:Subject;
	b=tP4zyfNXvNXxjSpuOUYQR4sT0JrwQbpKB+VV6qSX71UVhCke+8iGYpznuECeKO82J
	 ZkHCtpJJMsrbMojhYu175wtYJ4Afv3/YGuV1QAvkNP0oFEGixv40oeiR31oPsJ2OMW
	 6Cc36vNJbK3VsxP+t5T1BgQf9JTLtd3Tk4VNmzrHcj/2Be8hxD0gANRdXzveYIiVyQ
	 srt075bonoXcCgw3GxAG928P0krpowUIylpfGKwRGWKjPrQUOfxtuTT3NN4dwKd/22
	 NRsoBdSDgPGZz0C5+o3+blrOkLlKqK50MretDGbQJ8uEW4ooNy7i15ORqgNXVZmbVk
	 wzhy3m/ahT89w==
From: Francesco Dolcini <francesco@dolcini.it>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC and EQ support
Date: Mon, 24 Feb 2025 16:54:58 +0100
Message-Id: <20250224155500.52462-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224155500.52462-1-francesco@dolcini.it>
References: <20250224155500.52462-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Add two properties to select the IN1L/DMICDAT1 and IN2R/DMICDAT2
functionality:
- wlf,in1l-as-dmicdat1
- wlf,in1r-as-dmicdat2

Add a property to describe the GPIO configuration registers, that can be
used to set the four multifunction pins:
- wlf,gpio-cfg

Add a property to describe the mic bias control registers:
- wlf,mic-cfg

Add two properties to describe the Dynamic Range Controller (DRC),
allowing multiple named configurations where each config sets the 4 DRC
registers (R40-R43):
- wlf,drc-cfg-regs
- wlf,drc-cfg-names

Add three properties to describe the equalizer (ReTune Mobile), allowing
multiple named configurations (associated with a samplerate) that set
the 24 (R134-R157) EQ registers:
- wlf,retune-mobile-cfg-regs
- wlf,retune-mobile-cfg-names
- wlf,retune-mobile-cfg-rates

Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
v2: Added an example of how to use the ReTune Mobile config properties
v1: https://lore.kernel.org/lkml/20250206163152.423199-4-francesco@dolcini.it/
---
 .../devicetree/bindings/sound/wlf,wm8904.yaml | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
index 329260cf0fa0..f4338efaee18 100644
--- a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
@@ -38,6 +38,74 @@ properties:
   DCVDD-supply: true
   MICVDD-supply: true
 
+  wlf,in1l-as-dmicdat1:
+    type: boolean
+    description:
+      Use IN1L/DMICDAT1 as DMICDAT1, enabling the DMIC input path.
+
+  wlf,in1r-as-dmicdat2:
+    type: boolean
+    description:
+      Use IN1R/DMICDAT2 as DMICDAT2, enabling the DMIC input path.
+
+  wlf,gpio-cfg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+    description:
+      Default register values for R121/122/123/124 (GPIO Control).
+      If any entry has the value 0xFFFF, the related register won't be set.
+    default: [0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF]
+
+  wlf,mic-cfg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    description:
+      Default register values for R6/R7 (Mic Bias Control).
+    default: [0, 0]
+
+  wlf,drc-cfg-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      List of strings for the available DRC modes.
+      If absent, DRC is disabled.
+
+  wlf,drc-cfg-regs:
+    $ref: /schemas/types.yaml#/definitions/uint16-array
+    description:
+      Default register values for R40/41/42/43 (DRC).
+      The list must be 4 times the length of wlf,drc-cfg-names.
+      If absent, DRC is disabled.
+
+  wlf,retune-mobile-cfg-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      List of strings for the available retune modes.
+      If absent, retune is disabled.
+
+  wlf,retune-mobile-cfg-rates:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      List of rates for the available retune modes.
+      The list must be the same length as wlf,retune-mobile-cfg-names.
+      If absent, retune is disabled.
+
+  wlf,retune-mobile-cfg-regs:
+    $ref: /schemas/types.yaml#/definitions/uint16-array
+    description:
+      Default register values for R134/.../157 (EQ).
+      The list must be 24 times the length of wlf,retune-mobile-cfg-names.
+      If absent, retune is disabled.
+
+dependencies:
+  wlf,drc-cfg-names: [ 'wlf,drc-cfg-regs' ]
+  wlf,drc-cfg-regs: [ 'wlf,drc-cfg-names' ]
+
+  wlf,retune-mobile-cfg-names: [ 'wlf,retune-mobile-cfg-rates', 'wlf,retune-mobile-cfg-regs' ]
+  wlf,retune-mobile-cfg-regs: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-rates' ]
+  wlf,retune-mobile-cfg-rates: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-regs' ]
+
 required:
   - compatible
   - reg
@@ -70,5 +138,43 @@ examples:
             DBVDD-supply = <&reg_1p8v>;
             DCVDD-supply = <&reg_1p8v>;
             MICVDD-supply = <&reg_1p8v>;
+
+            wlf,drc-cfg-names = "default", "peaklimiter", "tradition", "soft", "music";
+            wlf,drc-cfg-regs =
+                /* coded default: KNEE_IP = KNEE_OP = 0, HI_COMP = LO_COMP = 1  */
+                /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
+                /* coded default: KNEE_IP = -24, KNEE_OP = -6, HI_COMP = 1/4, LO_COMP = 1 */
+                /bits/ 16 <0x04af 0x324b 0x0010 0x0408>,
+                /* coded default: KNEE_IP = -42, KNEE_OP = -3, HI_COMP = 0, LO_COMP = 1 */
+                /bits/ 16 <0x04af 0x324b 0x0028 0x0704>,
+                /* coded default: KNEE_IP = -45, KNEE_OP = -9, HI_COMP = 1/8, LO_COMP = 1 */
+                /bits/ 16 <0x04af 0x324b 0x0018 0x078c>,
+                /* coded default: KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1 */
+                /bits/ 16 <0x04af 0x324b 0x0010 0x050e>;
+
+            wlf,gpio-cfg = <
+                0x0018 /* GPIO1 => DMIC_CLK */
+                0xffff /* GPIO2 => don't touch */
+                0xffff /* GPIO3 => don't touch */
+                0xffff /* GPIO4 => don't touch */
+
+            wlf,retune-mobile-cfg-names = "bassboost", "bassboost", "treble";
+            wlf,retune-mobile-cfg-rates = <48000 44100 48000>;
+            wlf,retune-mobile-cfg-regs =
+                /* bassboost: EQ_ENA = 1, +6 dB @ 100 Hz, +3 dB @ 300 Hz, 0 dB @ 875, 2400, 6900 Hz */
+                /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc>,
+                /* default values for ReTune Mobile registers 140-157 */
+                /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5 0xf145 0x0bd5 0x0075 0x1c58 0xf3d3 0x0a54 0x0568 0x168e 0xf829 0x07ad 0x1103 0x0564 0x0559 0x4000>,
+
+                /* bassboost: EQ_ENA = 1, +6 dB @ 100 Hz, +3 dB @ 300 Hz, 0 dB @ 875, 2400, 6900 Hz */
+                /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc>,
+                /* default values for ReTune Mobile registers 140-157 */
+                /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5 0xf145 0x0bd5 0x0075 0x1c58 0xf3d3 0x0a54 0x0568 0x168e 0xf829 0x07ad 0x1103 0x0564 0x0559 0x4000>,
+
+                /* treble: EQ_ENA = 1, -2 dB @ 100, 300 Hz, 0 dB @ 875, 2400 Hz, +3 dB @ 6900 Hz */
+                /bits/ 16 <0x1 0xa 0xa 0xc 0xc 0xf>,
+                /* default values for ReTune Mobile registers 140-157 */
+                /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5 0xf145 0x0bd5 0x0075 0x1c58 0xf3d3 0x0a54 0x0568 0x168e 0xf829 0x07ad 0x1103 0x0564 0x0559 0x4000>;
+            >;
         };
     };
-- 
2.39.5


