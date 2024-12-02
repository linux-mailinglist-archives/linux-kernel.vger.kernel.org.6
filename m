Return-Path: <linux-kernel+bounces-427725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C3E9E055F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC85916CE3D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AF420C029;
	Mon,  2 Dec 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="d3x+UxdZ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0093720B7FA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149941; cv=none; b=lWrPd908RgUY0381gwqqhxO67mDnA2jiHIZc7XZgE42/fxVtwhZi6Lk6jkbZVcrOUCmS5ALDbNcgMgp4/Jwrz48R/GKYUviFu3HyRkqr5Fpp/RIR+QaTGoVh5fUcRd75r/jezL1Zyp8jSTit1P3tYHE2daqMbyTPQxM6IY3VAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149941; c=relaxed/simple;
	bh=FQOZmUNicupuaj+h7+nIqZLEwfVhlNCxkDeqgMBEpIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UK63OOl31QilVZAEpQP6aK0I88UYk0br58MZ9fRSccSQ5UCxmUBPCL3XxE/2vg8Q7UHUX9tnvJh/GktPpxcrJQEssQpzW34/MvxamumncREQykReyRplK5hrnW7KE1JJseyWEH8anxsxgaI5EzsTZ2MwoScpRnufZsOA/Xfq1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=d3x+UxdZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385f4a4093eso661514f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1733149937; x=1733754737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AFVILEGG6inA8zYmU/doFUBGD/IkzUATf3B1mIzQMQ=;
        b=d3x+UxdZbLevh/ZBKcrsuOUyjOFQULhVF14UVtAk757k+6YDMiVWbX5ICak/lR8ihr
         BsaH3S41avVqHG6VEgaVzL54U4Db7YaslfJ50wOcQzV5Q/PVa3dAf11jhz52X4IaQ7pu
         WCXsgVcGkIuk+n1bYZ/C8cC34jpfv/qjsg+0vw1CroP8ZVZ2UA+blKW8tqrGrlPnrF6c
         vm54BkjHlBzRfY/Mu5vmTCZ5/EQIzhwGzmxNHKUCJuh4rKdUP3LFPA+5Pm9+f7xXHPir
         iDzw36qMwgYc+9cFRhYP2WJt7956NL1VOO8Gk7kQ7rP6xRB5XFPl2Ig77eRpJ7oNHqAI
         sSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149937; x=1733754737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AFVILEGG6inA8zYmU/doFUBGD/IkzUATf3B1mIzQMQ=;
        b=B/YXeHWInuzGy++oO5b1mbJgD0I4Fy+o05ZnksZXvA6+gC0Duu81KX2KwI8COq4BhO
         pckcWsRiXwoAwEz6q+a1bpJEaH8JBRvSIynPFuZxasXy1HgU6blX70yWKsqVCMl4NMFm
         rOUN7pGYAPlfJululnm26avJLlPq4+skerwYuFMXDnibWBfwGyAG/7yem8dC6Iy105aq
         y+2s0rZjd2Q2skpNP1ayu488Kkdsdx3bYc8X5dmo1QZwRD96c0VWE5VxD+35sIvqQCX8
         fKLCIRj9tC09O1YLdevo9V5uiFM1cjVdYLf+xg54I0Mcgatf0BcsOkVnGH/YGxR7jaxr
         1k8g==
X-Forwarded-Encrypted: i=1; AJvYcCVYpgYaogEcpJPBXglDg8hpipegAsDSBTvfhX8TQnRmGArhdx0ljugJHh65+sEIZ424yWYE0LmQW3QQt24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPzQsOY69lQKkDFvv7phgmCGXR0DDaOT3jXeSuoKQTQdB9aNI
	4eBtIOkZIrSw/0mcNmCHp/wJccRy9OhusffhEJxmZiGvCzd13t3TV6nJF8+k+GREzwYmeEKesWp
	Y
X-Gm-Gg: ASbGncvwUfnC9nC/j+HBwd2yYfjC2G0CVkKucjHM2IHwAClBJoqlvRSb2HJp+0R27XD
	gpLBHafz+s+I0TO1IguSBwkDN7uz0bhKqO9OyXiHioqPXLyUVW9odCZFvllg3tgxNP/JySy427h
	f2VgEizZUyuPSFMGAmpBnbV5toUboNPhTZA3CvPMuwLZT1NVnF6+nMwfkfgWPkeR5Gdnq79xxrp
	7DevbuNDoa2GoBFl8oUzQEvo5vR8uYcLnXSNrWFUg==
X-Google-Smtp-Source: AGHT+IEh8wUvPPp6fmiu8qi70G2dLIyR2cy0B8DQH6XpxZjumKSN1WVLLU9bXrhtMfH6hCylA9amQQ==
X-Received: by 2002:a05:6000:4024:b0:385:e4a7:df07 with SMTP id ffacd0b85a97d-385e4a7e08dmr6305010f8f.42.1733149937090;
        Mon, 02 Dec 2024 06:32:17 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1e6sm188429555e9.9.2024.12.02.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:32:16 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 02 Dec 2024 14:31:55 +0000
Subject: [PATCH 2/7] dtbindings: display: Fix BCM2835 HVS bindings for
 BCM2712
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-dt-bcm2712-fixes-v1-2-fac67cc2f98a@raspberrypi.com>
References: <20241202-dt-bcm2712-fixes-v1-0-fac67cc2f98a@raspberrypi.com>
In-Reply-To: <20241202-dt-bcm2712-fixes-v1-0-fac67cc2f98a@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 linux-gpio@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

The previous patch adding the compatible string missed out that
the number of interrupts and clocks changed with BCM2712 too.

Update to validate clock and interrupts for the variants.

Fixes: 6cfcbe548a3a ("dt-bindings: display: Add BCM2712 HVS bindings")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 .../bindings/display/brcm,bcm2835-hvs.yaml         | 77 +++++++++++++++++-----
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
index f91c9dce2a44..ab59edbcf32c 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
@@ -19,12 +19,13 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts:
-    maxItems: 1
+  interrupts: true
 
-  clocks:
-    maxItems: 1
-    description: Core Clock
+  interrupt-names: true
+
+  clocks: true
+
+  clock-names: true
 
 required:
   - compatible
@@ -33,17 +34,61 @@ required:
 
 additionalProperties: false
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - brcm,bcm2711-hvs
-          - brcm,bcm2712-hvs
-
-then:
-  required:
-    - clocks
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm2711-hvs
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Core Clock
+
+      required:
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm2712-hvs
+
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: core
+            - const: disp
+        interrupts:
+          items:
+            - description: Channel 0 End of frame
+            - description: Channel 1 End of frame
+            - description: Channel 2 End of frame
+        interrupt-names:
+          items:
+            - const: ch0-eof
+            - const: ch1-eof
+            - const: ch2-eof
+      required:
+        - clocks
+        - clock-names
+        - interrupt-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm2835-hvs
+
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
 
 examples:
   - |

-- 
2.34.1


