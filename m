Return-Path: <linux-kernel+bounces-546474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD94BA4FB23
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16523AE303
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB54207663;
	Wed,  5 Mar 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr2nwsWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B2205AD6;
	Wed,  5 Mar 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168979; cv=none; b=TIWkVdS9sHbghKS25R0XH7zR+iO8ufkiCNmkFEs3jSIMtBkpgdEHtrH4xae7rMdzBUUoCVhx8CkjzOompN6/MLFRyG9S4/cAl5KznTcXK2CKCoWBFGJNEvI9oD/+Tj+J/Gr3bzGbM+DSORV8nJXQMDi1cEV15AtiX1dLAfXMos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168979; c=relaxed/simple;
	bh=PniLbk2hKDobEfmisijscUi423JhyWI4OpVr06F9f6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UESwW0XP7Ckp6a+V95wJw++tjas8eyDonBTK3FiHSE9mkwjS3AFvAGwyEZp78TXxMIEyeJrSnvuM7ok93I/syErv1DaZn1mvhFSdVIZbRo7XcFL0rdAstrRGUM3UGFGItroWuYrYZlWzajNiORWeTpeCzG8fa1vCShJrYPs/Q5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr2nwsWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 464B4C4CEE9;
	Wed,  5 Mar 2025 10:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741168979;
	bh=PniLbk2hKDobEfmisijscUi423JhyWI4OpVr06F9f6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Lr2nwsWQjAe4cS/eWfy+cqMUNjkjpefNopzCGVPIP8zvEDjOn+bDMcdpmsnnMj8aK
	 ip9tiLmsyh3rALrLHjkeWL3JIHvuPQqjFe6wNeulWISTclXbCx9T96bCd3gT0CFUsi
	 iBxVdiQG85e4hNRDSVBmgu7CiTpVMTcIokeqMc7s1+hRo+BwciarhB3Eead/IeJM/q
	 m4jss4k4f1k81gEg5rZ/z7Dw9i83GmCwkLl5oE72ntj8R3a8xjYiWAK+LAjV0O1C3J
	 5yKrUouWB94QtHVHORN3AUIJBIL4ZiuP48AJS03WNIU0rYDGO44Ou12gO01HC7EaLh
	 yfL5sZSIwr1Hg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E558C282D9;
	Wed,  5 Mar 2025 10:02:59 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 05 Mar 2025 18:02:56 +0800
Subject: [PATCH v3 1/4] dt-bindings: interrupt-controller: Add support for
 Amlogic A4 and A5 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-irqchip-gpio-a4-a5-v3-1-1eec70352fea@amlogic.com>
References: <20250305-irqchip-gpio-a4-a5-v3-0-1eec70352fea@amlogic.com>
In-Reply-To: <20250305-irqchip-gpio-a4-a5-v3-0-1eec70352fea@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741168977; l=1783;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=OtlX8UcJ+H1FILMyJjS4Bk1MwFvAcPTPGY/5f/EGqhc=;
 b=4wZeRoU6l7Aj8hPhoOsLF5THFXD8UqzSXyDROQXOoEDx/vXtMbkGDyO5kuYWx1z6El7eCqUl9
 3vjbfPxwPt1Bxr853P4Cj7wfw/2NEhT2n7CLT6izVvjs4qUVMVGnvDa
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
 .../amlogic,meson-gpio-intc.yaml                    | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
index a93744763787..3c5853c71efa 100644
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
@@ -49,8 +52,6 @@ properties:
 
   amlogic,channel-interrupts:
     description: Array with the upstream hwirq numbers
-    minItems: 8
-    maxItems: 12
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
 required:
@@ -60,6 +61,22 @@ required:
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
+      minItems: 2
+      maxItems: 12
+else:
+  properties:
+    amlogic,channel-interrupts:
+      minItems: 8
+      maxItems: 12
+
 additionalProperties: false
 
 examples:

-- 
2.37.1



