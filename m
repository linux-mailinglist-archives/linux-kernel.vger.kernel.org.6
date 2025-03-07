Return-Path: <linux-kernel+bounces-551218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C201A5697B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C34179627
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B221C174;
	Fri,  7 Mar 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Mo0x84ke"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660821ADA4;
	Fri,  7 Mar 2025 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355580; cv=none; b=Oj+jLlrroXTNcrpAVhvtbw5MRZgU+KBsWPKVCDh6U1sM1WRfGo/bSuNcYUcvCQcLLclFhOBmyH3XBJwcWf0AaWcJH4qfk5zh4GX4WC5vw5O+0FOQEyvBKiF57FuN9HxpIkAsfkgfVHjCyu4JJUcKnRH7Lr44YcdIQenxvjgkOnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355580; c=relaxed/simple;
	bh=Od6D72LtNAMPbLwzDAQxeC4wk3gi9aIVnefj/cQVamw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/XiQLa8lMtWz9Z5G+rexqwkBLH+y9L2IL/DCHmgkiPfXhX4GL69GYgvBppnSbSgFrGQn+WvPVZhujGOj0sZZSp6gUedQgdpKfrgpoq6XtldbzY0navT9dKa+zOweYBZTgUTnsttklCjHNQpJzJJZvffSAH0XMfQrYAKDmKbrEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Mo0x84ke; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 150A11F9EA;
	Fri,  7 Mar 2025 14:52:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1741355570;
	bh=Z5nm/lv2OLvGxdFwaVYPQynpg+lJGQH7DwZvpkzVLJE=; h=From:To:Subject;
	b=Mo0x84keh3caRmgSKdmo17s28XLMhWooE90Pbcx2jI31CefwYSdS0Eb9ks7Hyi/PE
	 LJaf0IIv3r3ki/MMhbdCQiCFdAWr5rjAbt6CmF1sA+kpscjYW36VExXoOOwBEGCPf+
	 lsjt28dLsCprMRE93f6N7EI5GYCuRn7QWZM5ynASDW9e1riNngr3+h1DUK9be4h/dH
	 OSCIbNAIgnezYDniOe0JJKDcP/kqkruZmh35Yfw8iWhkV+0HurZdBufer4PHRTCsL2
	 x/rWDXafdCV739fP/WLSeKWqgS9qv218h+V1bqfOGrAKdvM0Gk3shtrg8AlqTE6vg1
	 YdIF1UPWJNVbg==
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
Subject: [PATCH v3 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC and EQ support
Date: Fri,  7 Mar 2025 14:52:42 +0100
Message-Id: <20250307135244.100443-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307135244.100443-1-francesco@dolcini.it>
References: <20250307135244.100443-1-francesco@dolcini.it>
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
- wlf,retune-mobile-cfg-hz
- wlf,retune-mobile-cfg-rates

Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
v3: v2 did not pass dt_binding_check, this is now fixed.
    Fixed a DT compilation error by moving a misplaced closing bracket.
    Changed 'retune-mobile-cfg-names' to be a nonunique-string-array.
    Renamed 'retune-mobile-cfg-rates' to 'retune-mobile-cfg-hz',
        dropped the 'ref' because it is now a standard unit suffix prop.
    Redid line wrapping to be compliant with the DTS style guidelines.
v2: Added an example of how to use the ReTune Mobile config properties
v1: https://lore.kernel.org/lkml/20250206163152.423199-4-francesco@dolcini.it/
---
 .../devicetree/bindings/sound/wlf,wm8904.yaml | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
index 329260cf0fa0..4ad8681cb266 100644
--- a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
@@ -38,6 +38,72 @@ properties:
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
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      List of strings for the available retune modes.
+      If absent, retune is disabled.
+
+  wlf,retune-mobile-cfg-hz:
+    description:
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
+  wlf,retune-mobile-cfg-names: [ 'wlf,retune-mobile-cfg-hz', 'wlf,retune-mobile-cfg-regs' ]
+  wlf,retune-mobile-cfg-regs: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-hz' ]
+  wlf,retune-mobile-cfg-hz: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-regs' ]
+
 required:
   - compatible
   - reg
@@ -70,5 +136,55 @@ examples:
             DBVDD-supply = <&reg_1p8v>;
             DCVDD-supply = <&reg_1p8v>;
             MICVDD-supply = <&reg_1p8v>;
+
+            wlf,drc-cfg-names = "default", "peaklimiter", "tradition", "soft",
+                                "music";
+            /*
+             * Config registers per name, respectively:
+             * KNEE_IP = 0,   KNEE_OP = 0,     HI_COMP = 1,   LO_COMP = 1
+             * KNEE_IP = -24, KNEE_OP = -6,    HI_COMP = 1/4, LO_COMP = 1
+             * KNEE_IP = -42, KNEE_OP = -3,    HI_COMP = 0,   LO_COMP = 1
+             * KNEE_IP = -45, KNEE_OP = -9,    HI_COMP = 1/8, LO_COMP = 1
+             * KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1
+             */
+            wlf,drc-cfg-regs = /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
+                               /bits/ 16 <0x04af 0x324b 0x0010 0x0408>,
+                               /bits/ 16 <0x04af 0x324b 0x0028 0x0704>,
+                               /bits/ 16 <0x04af 0x324b 0x0018 0x078c>,
+                               /bits/ 16 <0x04af 0x324b 0x0010 0x050e>;
+
+            /* GPIO1 = DMIC_CLK, don't touch others */
+            wlf,gpio-cfg = <0x0018 0xffff 0xffff 0xffff>;
+
+            wlf,retune-mobile-cfg-names = "bassboost", "bassboost", "treble";
+            wlf,retune-mobile-cfg-hz = <48000 44100 48000>;
+            /*
+             * Config registers per name, respectively:
+             * EQ_ENA,  100 Hz,  300 Hz,  875 Hz, 2400 Hz, 6900 Hz
+             *      1,   +6 dB,   +3 dB,    0 dB,    0 dB,    0 dB
+             *      1,   +6 dB,   +3 dB,    0 dB,    0 dB,    0 dB
+             *      1,   -2 dB,   -2 dB,    0 dB,    0 dB,   +3 dB
+             * Each one uses the defaults for ReTune Mobile registers 140-157
+             */
+            wlf,retune-mobile-cfg-regs = /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc>,
+                                         /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5
+                                                    0xf145 0x0bd5 0x0075 0x1c58
+                                                    0xf3d3 0x0a54 0x0568 0x168e
+                                                    0xf829 0x07ad 0x1103 0x0564
+                                                    0x0559 0x4000>,
+
+                                         /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc>,
+                                         /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5
+                                                    0xf145 0x0bd5 0x0075 0x1c58
+                                                    0xf3d3 0x0a54 0x0568 0x168e
+                                                    0xf829 0x07ad 0x1103 0x0564
+                                                    0x0559 0x4000>,
+
+                                         /bits/ 16 <0x1 0xa 0xa 0xc 0xc 0xf>,
+                                         /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5
+                                                    0xf145 0x0bd5 0x0075 0x1c58
+                                                    0xf3d3 0x0a54 0x0568 0x168e
+                                                    0xf829 0x07ad 0x1103 0x0564
+                                                    0x0559 0x4000>;
         };
     };
-- 
2.39.5


