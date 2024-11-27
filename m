Return-Path: <linux-kernel+bounces-423739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4A69DAC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625D0282E08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BFB20100C;
	Wed, 27 Nov 2024 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="lgfdp3Tt"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2664200BA3;
	Wed, 27 Nov 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726324; cv=none; b=s+Pi+rf8Tr6pS9VjOeAZEOthnQvuCCabroAt70KLBUWUhbIrrk8MdIaqriBl84cpsrO+IvtRpTx6uvwjvnHr8e4fF+ob28oEbDqTYA3lyH4PC0BN6cYtytW4XfqK//rZunx8wXOj9tVpVN/ZMaqCqX4PrPC1uDS411GOLLWv0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726324; c=relaxed/simple;
	bh=W1zPE0EBVV5XXFYVY9qF1SmP5fH7nLvG/zs5AJRUmCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLxY2ckVkbbcUso01nFdA2dk7hsGLFvzYIAdV9Gso/dGeTn9ZqJbGkVSeVgpPYCvFczziXYd+B6asVJAPWdo7nRgbphqZcKfjCbYQ0ExgFNjXYCgcvvgv5yzcJDNV6a/FYMFEIOeCK17KBbWEq0k/GegfiffEFrVHe2w1fuVTkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=lgfdp3Tt; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63CA2BFB92;
	Wed, 27 Nov 2024 17:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1732725872; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1czmU5HryxYDFCAjqA43ualDjKgjhaED/d0vTrFAZXM=;
	b=lgfdp3Tt2cGDgyZ/6cwY0Zdga57uMo7Oj1ogXGpd0ny4kkvNWE8aO1XDUD0PFE+kO+dTlq
	NmjZpCooVNOjCI9x4fvrbA+BNlPotfbsTK01cgTvkchWiY4zM76cgdVDjwb3GAm1CaNff5
	X4klzEJ3yDQ1HdLtX4LjazH+IgZve+4bZjn/iSiSrk2Ep4bOjWRP4DuD8BOj6NFAIrkWOV
	Z3chmNDzYEuzl0xMyMIp038mqg6MYFZaJc0EY1iu83yEIBKz7hE/ASxJ/BaxvuqOQpdXhS
	08K947hasnuz6R7ZYe4Dn+cL+mQDBOrA+UWCvUSaa8TWphnAAdYDbx4zTlBNzQ==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Joy Zou <joy.zou@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 02/11] dt-bindings: regulator: pca9450: Add sd-vsel-gpios to read back LDO5 status
Date: Wed, 27 Nov 2024 17:42:18 +0100
Message-ID: <20241127164337.613915-3-frieder@fris.de>
In-Reply-To: <20241127164337.613915-1-frieder@fris.de>
References: <20241127164337.613915-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

In order to know the current status (which of the two control
registers is used) for the LDO5 regulator, we need to route back the
USDHC_VSELECT signal by setting the SION bit in the IOMUX.

By adding the according GPIO as sd-vsel-gpios to the LDO5 node, we
allow the regulator driver to sample the current status of the
SD_VSEL signal that is used to select the correct control register.

The SD_VSEL on the PMIC is always an input. It's driven by the SoC's
VSELECT signal (controlled by the USDHC controller) and we use the
SION bit in the IOMUX to internally loop back the signal in order to
sample it using the GPIO.

As the SD_VSEL pin is directly routed to the LDO5 regulator in the
PMIC, make the sd-vsel-gpios property part of the LDO5 node.

SoC                                  PMIC
+-----------------------+           +-------------------+
|                       |           |                   |
|                       |           |                   |
|  GPIO <----------+    |           |                   |
|                  |    |    SD_VSEL|   +-------+       |
|  USDHC_VSELECT ->+------------------->| LDO5  |       |
|                       |           |   +-------+       |
|                       |           |                   |
+-----------------------+           +-------------------+

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* extend commit message
* split into two patches (revert old sd-vsel-gpios separately)
---
 .../regulator/nxp,pca9450-regulator.yaml       | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 79fc0baf5fa2f..5d0d684186c96 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -41,8 +41,24 @@ properties:
     description: |
       list of regulators provided by this controller
 
+    properties:
+      LDO5:
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single LDO5 regulator.
+
+        properties:
+          sd-vsel-gpios:
+            description:
+              GPIO that can be used to read the current status of the SD_VSEL
+              signal in order for the driver to know if LDO5CTRL_L or LDO5CTRL_H
+              is used by the hardware.
+
+        unevaluatedProperties: false
+
     patternProperties:
-      "^LDO[1-5]$":
+      "^LDO[1-4]$":
         type: object
         $ref: regulator.yaml#
         description:
-- 
2.46.1


