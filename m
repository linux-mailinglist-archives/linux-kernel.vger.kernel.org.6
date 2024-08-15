Return-Path: <linux-kernel+bounces-288052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A095323C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB044B236FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36671B29C7;
	Thu, 15 Aug 2024 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2+x2rFc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB301A7065;
	Thu, 15 Aug 2024 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730527; cv=none; b=h8Y2JTWjhe/SYiShdQk5gtn1LhienAQxT8ikHMU+dqiUtZk4vepOOcHxA2TiwZN66i0b0g50Dusy5Y7Q9NSc3zjA+RHfTIDo4mWlGOQyNQ0K0s3tU2drC7PSNepQcXUkvMKeffHC09CAvVhSTILoTWyghyzRz6U6Bzr4DiqBcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730527; c=relaxed/simple;
	bh=JZMd4+f34uhJRPeHFtVoTqHmc3yDcFsa+kBqeuczd+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoTYAxRYCE5D1tZxvXjW6A+/u5zmD/kAyMpgxStaEmnlZ4XRzuyhp1phe1F8KO9w8Y7WRKi8FK/YKxG/48kN1FW/TCPWNgvPYW59zNip5p16Nga2BWJthqIOLgJ0jI8KVqHr6CdQp9IDHjvLqloAGutXJLfcszfSYYjPY7MSQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2+x2rFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E84EC4AF0A;
	Thu, 15 Aug 2024 14:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730526;
	bh=JZMd4+f34uhJRPeHFtVoTqHmc3yDcFsa+kBqeuczd+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2+x2rFcDFttOTB4PyU0eOZBRvG2nDbfIxSOodEYZH7OsMbfa8C6VA+Be3sdPX1Lv
	 J/n2mS7OxgxvL5+0bE5ziwi6qe4EnofJhR/DMPk7ePRWYBI3ZrC86Nau2q1m7NdVtD
	 pB/wcPd+Nr9voi0a+k7zQaerWWwwaasFnuG+VVjpFziVP6CmL32mWUCXYkVGkpWJaO
	 r65/H7OsMwv6WcbrrNBHrF+8kTn782D84bU3BTcJSVv8oc9djexwE42LuykR6HzLzq
	 1AQ+rLh6mWSzK5Czau0tBFPzcZQpjvvrxF4EvzxwC3a6DsgG9t00mXCvv+ni5X6Qex
	 uc+2k3XMvEDeA==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/11] dt-bindings: clk: microchip: mpfs: remove first reg region
Date: Thu, 15 Aug 2024 15:01:13 +0100
Message-ID: <20240815-fernlike-levitate-6004f5f46d66@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-shindig-bunny-fd42792d638a@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3015; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=P+jscb60JU82jJ4ESec10lLvcGcMyUAEOrlQ0J21yqA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uPTulboK7Lpz54fhTcOvDbOaZrhZnPIr79Vk6b9wa d4+Dr6rHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIjTsjw28//ueVk9atyDsy uVp62qaM0lNuv3cl3ur0yH7uyiq+tZ/hn72DPOvLqq+/dYsfRW73nrb6Ovs7tvCyhImWn55a5wW 3cwIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The first reg region in this binding is not exclusively for clocks, as
evidenced by the dual role of this device as a reset controller at
present. The first region is however better described by a simple-mfd
syscon, but this would have require a significant re-write of the
devicetree for the platform, so the easy way out was chosen when reset
support was first introduced. The region doesn't just contain clock and
reset registers, it also contains pinctrl and interrupt controller
functionality, so drop the region from the clock binding so that it can
be described instead by a simple-mfd syscon rather than propagate this
incorrect description of the hardware to the new pic64gx SoC.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/microchip,mpfs-clkcfg.yaml | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
index e4e1c31267d2..df861eb73e86 100644
--- a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
+++ b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
@@ -22,16 +22,23 @@ properties:
     const: microchip,mpfs-clkcfg
 
   reg:
-    items:
-      - description: |
-          clock config registers:
-          These registers contain enable, reset & divider tables for the, cpu,
-          axi, ahb and rtc/mtimer reference clocks as well as enable and reset
-          for the peripheral clocks.
-      - description: |
-          mss pll dri registers:
-          Block of registers responsible for dynamic reconfiguration of the mss
-          pll
+    oneOf:
+      - items:
+          - description: |
+              clock config registers:
+              These registers contain enable, reset & divider tables for the, cpu,
+              axi, ahb and rtc/mtimer reference clocks as well as enable and reset
+              for the peripheral clocks.
+          - description: |
+              mss pll dri registers:
+              Block of registers responsible for dynamic reconfiguration of the mss
+              pll
+      - items:
+          - description: |
+              mss pll dri registers:
+              Block of registers responsible for dynamic reconfiguration of the mss
+              pll
+
 
   clocks:
     maxItems: 1
@@ -69,11 +76,9 @@ examples:
   - |
     #include <dt-bindings/clock/microchip,mpfs-clock.h>
     soc {
-            #address-cells = <2>;
-            #size-cells = <2>;
-            clkcfg: clock-controller@20002000 {
+            clkcfg: clock-controller@3E001000 {
                 compatible = "microchip,mpfs-clkcfg";
-                reg = <0x0 0x20002000 0x0 0x1000>, <0x0 0x3E001000 0x0 0x1000>;
+                reg = <0x3E001000 0x1000>;
                 clocks = <&ref>;
                 #clock-cells = <1>;
         };
-- 
2.43.0


