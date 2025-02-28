Return-Path: <linux-kernel+bounces-537956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C48AA492E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2D518952A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F821DF97D;
	Fri, 28 Feb 2025 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azJ8TAnB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7561DEFC6;
	Fri, 28 Feb 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729875; cv=none; b=Mm7Y6d+PoGAJIRZkOM27FY1elNanFIWesVzQhRAO7sQHjmxSgxBAmPxdVw3Xz9LYsKTkLJMf2ZaLNFSNfX4NZDTgM69UihFnp786XJ8IIHnVp+KIeb/96gjnpuY1j9SlmncucysIYiIfReaNB72tKUQSbPT948lC5/zB6ZYY1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729875; c=relaxed/simple;
	bh=qclF5RziGVkBEvVZQqyLYKAdgb+35oYJQiogxiNf9tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbH52yoYC2aCT5yL6Uj51nk8K2LcUtHDwUU+B3JEXSRqm50e9qXQXjyyWnUkhj0fzIsNuBejEkMlF3SVCkYg8l89jB34nu5D7EwN+D1G9ITIaTQcATYZjMdiaPSnOSEAV2YN0ndJHgPXfpxRQStaNhTpAWShW75XhWvbjKSjsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azJ8TAnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2E1CC4CEE5;
	Fri, 28 Feb 2025 08:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740729875;
	bh=qclF5RziGVkBEvVZQqyLYKAdgb+35oYJQiogxiNf9tI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=azJ8TAnBSVd9E4xryncpwYxjmCrt7LKSTxTH6icuiX9bYCh0EJUkcvmLTGoaLbC91
	 vvlNAX7i1UMpShEe8JATEmTo9hrxuJ9CksqHhAHsYBY7enUbemOVHy+5kGPHHCEUaF
	 9Xh+XU95N1wHAQetPXpPQamsPP4LAPGNZ4yQflrnTOxheH+C6zdLjrsM5Ilm+nFBwD
	 F/kDe4UXIEh1M+NLTYWnrJa29zvwlqxBeQ+o6xEacHfXr2SterDiom5ZF8hLU2Ur9X
	 6b0zmP1j8zizosDMIWq+BdOlBNdy9raTNXFP5ZORwvBxSTnFNFJ8hqn1Htw4uhQ11k
	 uXS5VcdIiZpdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BCBC282C9;
	Fri, 28 Feb 2025 08:04:34 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Date: Fri, 28 Feb 2025 16:04:09 +0800
Subject: [PATCH v3 1/6] dt-bindings: clock: meson: Add audio power domain
 for s4 soc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-audio_drvier-v3-1-dbfd30507e4c@amlogic.com>
References: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
In-Reply-To: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com, 
 jiebing chen <jiebing.chen@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740729872; l=1660;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=uJ4Qa4aXJPLqZsf/j77ROeiKcn94cDW8vS8T/9MHHao=;
 b=7P167RBJ6BxgHSA35fu6wKaUYR4qXSmTQ8Uz0DAk0J4gnWzl7E7aa37NHs4369qaLnS0or1NH
 /fIUnGYGCHEC2cJT65yYsp8o6vKon/3nLYCnAsN9iEKmLAdi7kQaPXq
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

From: jiebing chen <jiebing.chen@amlogic.com>

Audio power domain found on S4 device. It need to enable before audio work.

Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
---
 .../bindings/clock/amlogic,axg-audio-clkc.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
index fd7982dd4ceab82389167079c2258a9acff51a76..364783c6f7572b09d57de2b35d33adb7bcf7db18 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
+++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
@@ -21,6 +21,7 @@ properties:
       - amlogic,axg-audio-clkc
       - amlogic,g12a-audio-clkc
       - amlogic,sm1-audio-clkc
+      - amlogic,s4-audio-clkc
 
   '#clock-cells':
     const: 1
@@ -100,6 +101,9 @@ properties:
   resets:
     description: internal reset line
 
+  power-domains:
+    description: audio controller power
+
 required:
   - compatible
   - '#clock-cells'
@@ -116,12 +120,26 @@ allOf:
             enum:
               - amlogic,g12a-audio-clkc
               - amlogic,sm1-audio-clkc
+              - amlogic,s4-audio-clkc
     then:
       required:
         - '#reset-cells'
     else:
       properties:
         '#reset-cells': false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,s4-audio-clkc
+    then:
+      required:
+        - power-domains
+
+    else:
+      properties:
+        power-domains: false
 
 additionalProperties: false
 

-- 
2.43.0



