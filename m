Return-Path: <linux-kernel+bounces-568165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4329A68EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F127ADA54
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F01D5161;
	Wed, 19 Mar 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="qpDiqynX"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73633985;
	Wed, 19 Mar 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394071; cv=none; b=TuK+3GqsahjwO32g7YXnCzMUlDfxD8outGBgSEJjhttqzzCZXziQsR3n59ZaI/AaR0CSok4CPi+9F+Yp3BxXxdfQJAhAqE0pVZtpYtVHaoG9pB/AjJzb1F4seS/x+xAHeF1H56K9bZlUevIlKTfiavocjGnL5rzYDwaBXLvO3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394071; c=relaxed/simple;
	bh=oiZBMkvVALoBsGJUhefCQpJmXlBSC19ELjO72JaUmj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XaIyCQHsitYBdAljluoEE9pEVWnHeDMkv6sfk6o8A/2dM0PRzbw8K/KQgodfNtRxTsCgYVZV1mHY5tz0U3fWNpOnaWK3z/o2tNLs05MSBUaTCf+74MtpzFmvfEmQYNGFb7FMjh9CtfRMSnPOSngNVqWta3Urr5IBMcaARQ+PLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=qpDiqynX; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id A6BC223521;
	Wed, 19 Mar 2025 15:21:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742394067;
	bh=BK4eB0EX5MsLwuGAbXVom0NaaWAFWVZym9BDcRCuG/U=; h=From:To:Subject;
	b=qpDiqynX/+ZGMF1CkvNjjIqY774NxKTh3yE80UYX4oeFtt2vDxY2riIGSQhVNNjhY
	 edlQgX787Wxs/vzSEAt0hSmyVcRjHvSn+KPsE3wxzTU6heREQ2K1ra5zE61vugHJI+
	 6V4Erb5R59jLvxyXmTl3rgLku0nwdOunBuvKZiB8XJ9IibCxdaMq4OCESRk0Hkgege
	 SQms6HXRPRctQXqY+nRaV8t4xkmCRMPaYKCWyO9ItJNlTlHtqasBIZnsNfPF8S1/Rq
	 TR67dYL8yYwb0TuNsA0ZLiBKz0vp7+reyi8O1Tb56k5UyBKiBqyjuS/gNZzBvbSBYo
	 bEv4QLFs4gmlw==
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
Subject: [PATCH v4 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC and EQ support
Date: Wed, 19 Mar 2025 15:20:57 +0100
Message-Id: <20250319142059.46692-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319142059.46692-1-francesco@dolcini.it>
References: <20250319142059.46692-1-francesco@dolcini.it>
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
- wlf,micbias-cfg

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

The set of names and configurations for DRC and ReTune Mobile are
specified by system integrators. The names are exposed directly to
userspace as options that can be selected at runtime.

Adding the DRC and ReTune Mobile data to the DT eases the transition
from pdata, which has handled them this way for over a decade. The
parameters filled in here are almost certainly specific tuning for the
hardware so it makes sense to ship them with the hardware description.

Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
v4: Changed the type of 'drc-cfg-regs' and 'retune-mobile-cfg-regs' to
    'uint16-matrix' instead of 'uint16-array'. Properly specified number
    of elements in each set. Fixed example to be itemized as expected.
    Changed 'mic-cfg' to 'micbias-cfg' to be in line with the wm8994
    binding.
    Added 'wlf,in1r-as-dmicdat2' to the example.
    Expanded descriptions of 'wlf,in1*-as-dmicdat*'.
    Fixed itemization of 'wlf,gpio-cfg' list in the example.
    Expanded the commit message to explain this patch better, with help
    from previous mails from Charles Keepax and Mark Brown.
v3: v2 did not pass dt_binding_check, this is now fixed.
    Fixed a DT compilation error by moving a misplaced closing bracket.
    Changed 'retune-mobile-cfg-names' to be a nonunique-string-array.
    Renamed 'retune-mobile-cfg-rates' to 'retune-mobile-cfg-hz',
        dropped the 'ref' because it is now a standard unit suffix prop.
    Redid line wrapping to be compliant with the DTS style guidelines.
v2: Added an example of how to use the ReTune Mobile config properties
v1: https://lore.kernel.org/lkml/20250206163152.423199-4-francesco@dolcini.it/
---
 .../devicetree/bindings/sound/wlf,wm8904.yaml | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
index 329260cf0fa0..3029a868e5e1 100644
--- a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
@@ -38,6 +38,82 @@ properties:
   DCVDD-supply: true
   MICVDD-supply: true
 
+  wlf,in1l-as-dmicdat1:
+    type: boolean
+    description:
+      Use IN1L/DMICDAT1 as DMICDAT1, enabling the DMIC input path.
+      Can be used separately or together with wlf,in1r-as-dmicdat2.
+
+  wlf,in1r-as-dmicdat2:
+    type: boolean
+    description:
+      Use IN1R/DMICDAT2 as DMICDAT2, enabling the DMIC input path.
+      Can be used separately or together with wlf,in1l-as-dmicdat1.
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
+  wlf,micbias-cfg:
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
+    $ref: /schemas/types.yaml#/definitions/uint16-matrix
+    description:
+      Sets of default register values for R40/41/42/43 (DRC).
+      Each set corresponds to a DRC mode, so the number of sets should equal
+      the length of wlf,drc-cfg-names.
+      If absent, DRC is disabled.
+    items:
+      minItems: 4
+      maxItems: 4
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
+    $ref: /schemas/types.yaml#/definitions/uint16-matrix
+    description:
+      Sets of default register values for R134/.../157 (EQ).
+      Each set corresponds to a retune mode, so the number of sets should equal
+      the length of wlf,retune-mobile-cfg-names.
+      If absent, retune is disabled.
+    items:
+      minItems: 24
+      maxItems: 24
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
@@ -70,5 +146,58 @@ examples:
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
+            wlf,gpio-cfg = <0x0018>, <0xffff>, <0xffff>, <0xffff>;
+
+            /* Use IN1R as DMICDAT2, leave IN1L as an analog input path */
+            wlf,in1r-as-dmicdat2;
+
+            wlf,retune-mobile-cfg-names = "bassboost", "bassboost", "treble";
+            wlf,retune-mobile-cfg-hz = <48000>, <44100>, <48000>;
+            /*
+             * Config registers per name, respectively:
+             * EQ_ENA,  100 Hz,  300 Hz,  875 Hz, 2400 Hz, 6900 Hz
+             *      1,   +6 dB,   +3 dB,    0 dB,    0 dB,    0 dB
+             *      1,   +6 dB,   +3 dB,    0 dB,    0 dB,    0 dB
+             *      1,   -2 dB,   -2 dB,    0 dB,    0 dB,   +3 dB
+             * Each one uses the defaults for ReTune Mobile registers 140-157
+             */
+            wlf,retune-mobile-cfg-regs = /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc
+                                                    0x0fca 0x0400 0x00d8 0x1eb5
+                                                    0xf145 0x0bd5 0x0075 0x1c58
+                                                    0xf3d3 0x0a54 0x0568 0x168e
+                                                    0xf829 0x07ad 0x1103 0x0564
+                                                    0x0559 0x4000>,
+
+                                         /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc
+                                                    0x0fca 0x0400 0x00d8 0x1eb5
+                                                    0xf145 0x0bd5 0x0075 0x1c58
+                                                    0xf3d3 0x0a54 0x0568 0x168e
+                                                    0xf829 0x07ad 0x1103 0x0564
+                                                    0x0559 0x4000>,
+
+                                         /bits/ 16 <0x1 0xa 0xa 0xc 0xc 0xf
+                                                    0x0fca 0x0400 0x00d8 0x1eb5
+                                                    0xf145 0x0bd5 0x0075 0x1c58
+                                                    0xf3d3 0x0a54 0x0568 0x168e
+                                                    0xf829 0x07ad 0x1103 0x0564
+                                                    0x0559 0x4000>;
         };
     };
-- 
2.39.5


