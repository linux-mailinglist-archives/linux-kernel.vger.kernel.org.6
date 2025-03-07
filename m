Return-Path: <linux-kernel+bounces-550687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B64EA562F3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556AA16915D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB161E1E1E;
	Fri,  7 Mar 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkWJ0Xx6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F51E1DF0;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337364; cv=none; b=DqUztiBAc0aKzu06xNd0LtfTE6ElwIF7EqmlJYdsJxTx6CtO+jN0SvCavgHLVpDuICKrotUKcNipRkBwb/6xRPiwOq38u0E2p3pjVoqrJvxWLJTZCoETwM8zuq4R0fVpquuuDp9k2X9LfghSEE7lqEFRg9DIeywJixhpKH2HklQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337364; c=relaxed/simple;
	bh=nihZMnrVDd7TJRXIuYb/tP7cMRc4zru34Wv/fPSdlu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nXoH3wmKgvruf5O6JeYWVBxAG9RZGCdmufkVltYEWlqCsZ9OVNwK4CH87x5rGcwLKOlnmuUEkWeG0GDWecKavGexkiG66pgMJCc2NDyoQxNtWafKxxD7W6yCXbeLiKV5L4Gj3b8e3CT0Uu5SQgtDqUJIgoZkGm1ysGc6qzjHl5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkWJ0Xx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29963C4CED1;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741337364;
	bh=nihZMnrVDd7TJRXIuYb/tP7cMRc4zru34Wv/fPSdlu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qkWJ0Xx6lFCGYcbgqSPnBDdYk1/MLKXeJWCxowuFML76xmbH2ZOdyIabuZ1ul875X
	 stpwHhw5HCnQ88y/bCIdp4g0+9twqCyHzMXn5YkeUg7woeXyzF/yMw/8h8niFNHoPp
	 oFWMfS1oLUV2Uu3S9xNg9/pIWFgMR0csXDoFmdA3yz29BAJw2nMakWP5p8ytg1ipi8
	 EAp6wk7jbc/kKbuSV52SfeGfl3Bk8rTWbjXZsxqPpuATY35s6NbEpjGtlZwWscgVgs
	 htkonqj7R1VhOeh6rdyI9ItV6T3vFLRKWb3FA29uscEJeTQPThls86SMdhD6YBeH0J
	 hngmDwcbqpzug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1403FC282D0;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 07 Mar 2025 16:49:22 +0800
Subject: [PATCH v4 1/4] dt-bindings: interrupt-controller: Add support for
 Amlogic A4 and A5 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-irqchip-gpio-a4-a5-v4-1-d03a9424151b@amlogic.com>
References: <20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com>
In-Reply-To: <20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741337362; l=1746;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=xKF/9ztq9L+jNut2ufcUJxWS/0WXkNy4prgakjvZ2cY=;
 b=OR8fxCTg1IY7uojg5DIL8MhPQP8C/gDZ6JeRHuYUrFPAw96ZC7hGynk4ZYFcnep0hI0KGxqap
 dmmXaYAAiHmDOqwbdpmmJfzZ/9esuVEw3gsfG9oyjWUWebYGpY2ps88
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Update dt-binding document for GPIO interrupt controller
of Amlogic A4 and A5 SoCs

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../interrupt-controller/amlogic,meson-gpio-intc.yaml | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
index a93744763787..3d60d9e9e208 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
@@ -35,6 +35,9 @@ properties:
               - amlogic,meson-sm1-gpio-intc
               - amlogic,meson-a1-gpio-intc
               - amlogic,meson-s4-gpio-intc
+              - amlogic,a4-gpio-intc
+              - amlogic,a4-gpio-ao-intc
+              - amlogic,a5-gpio-intc
               - amlogic,c3-gpio-intc
               - amlogic,t7-gpio-intc
           - const: amlogic,meson-gpio-intc
@@ -49,7 +52,7 @@ properties:
 
   amlogic,channel-interrupts:
     description: Array with the upstream hwirq numbers
-    minItems: 8
+    minItems: 2
     maxItems: 12
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
@@ -60,6 +63,20 @@ required:
   - "#interrupt-cells"
   - amlogic,channel-interrupts
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: amlogic,a4-gpio-ao-intc
+then:
+  properties:
+    amlogic,channel-interrupts:
+      maxItems: 2
+else:
+  properties:
+    amlogic,channel-interrupts:
+      minItems: 8
+
 additionalProperties: false
 
 examples:

-- 
2.37.1



