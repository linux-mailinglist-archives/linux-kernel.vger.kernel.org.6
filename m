Return-Path: <linux-kernel+bounces-423738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 768079DAC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06369167B61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD45A201002;
	Wed, 27 Nov 2024 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="T7BE4FLR"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25471428E3;
	Wed, 27 Nov 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726324; cv=none; b=A7d7Ka6yv0WBsgTN3fxndZiP2wFoKd59IqJE/qQQErj9eUIzNgU6X8Qz7ttaqix0UsGFNcabK9TEg5d1OfUrMWGsk865eHIKMCitJKNaQbifn1IrzbVaXHfbgeRj/Hg7XkawO9R88uTbA8tYje88W0DzIEOWpY2mHkpw6WHDS/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726324; c=relaxed/simple;
	bh=/4kyzsf36kcxRdFfTEuviyucuWc6JBAoZXvGWSlhrkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlMfnF2rs3WLLEcm9+gL2/lclyeHQX+1Flov1yO7FG98qZFvxiZjhpb0d+LhRPI4RqiIg36BqwBN/1c7kl+xUYjAfwz345IHhqS9rWF7qSK+oZ3nq+8oa0x8gpE8m35uytPIGm60NiOhtjbp3FpqC3tY27nnLhwkE0eaCaMf/vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=T7BE4FLR; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBB17BFB94;
	Wed, 27 Nov 2024 17:44:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1732725874; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=5HvescA7ggE2G2W5BNg1EgLCr4WOqo5gIMehYGZzaE8=;
	b=T7BE4FLRgYCezCzoNq4KpzDkWOO8N01zGOc8BESWb1Z/Ve1VCRp3pEVhWc/jODEP/f3PJv
	IS1dz85eEh4nSQv3UsQ6PhqNPvxmN+6JZNFPKqgjGgJ7JwkPR1SxNmWifDigV+tJrxCv50
	Y3m3Nc86IxwlaVg91NF5wtrI5GWAWi1etXR9WVmdU0Gm/bJrRcq/oMco+6sbt0xQfLEWdA
	7c9/bjdxIMB8qNGzfOIFhI8QYAIdsSOPH7E0JyCnx47wBTk21Hc5gsg8FW+9lZ5XovkPS4
	+SCxrie03YH51r6vJCfel57g9tBD9JaJWLvTuTdsGxr/K/ojy6AVT4XQKTl/Vw==
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
Subject: [PATCH v2 03/11] dt-bindings: regulator: pca9450: Document nxp,sd-vsel-fixed-low property for LDO5
Date: Wed, 27 Nov 2024 17:42:19 +0100
Message-ID: <20241127164337.613915-4-frieder@fris.de>
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

This new property can be used for boards which have the SD_VSEL tied
to a fixed low level. The voltage of LDO5 is therefore only controlled
by writing to the LDO5CTRL_L register.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* new patch
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml           | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 5d0d684186c96..0e19c54aa5f8a 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -49,6 +49,12 @@ properties:
           Properties for single LDO5 regulator.
 
         properties:
+          nxp,sd-vsel-fixed-low:
+            type: boolean
+            description:
+              Let the driver know that SD_VSEL is hardwired to low level and
+              there is no GPIO to get the actual value from.
+
           sd-vsel-gpios:
             description:
               GPIO that can be used to read the current status of the SD_VSEL
-- 
2.46.1


