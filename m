Return-Path: <linux-kernel+bounces-379513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DFD9ADF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F271F217B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575A1B394F;
	Thu, 24 Oct 2024 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dpAjWaHt"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDBF1B21A5;
	Thu, 24 Oct 2024 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760079; cv=none; b=JYmq373trWpCupo5bNXXxjBcJqlsKe8b0fcX+O7t2zB2PW4gQuNDRV5r8WRd7rDMgrWUQtMgVd/njOsnlIY7IjX1kJJJ5Kwhx9Koc37kVmw5PnRuEUrYcrn1IEeLrOJmEWIzwVP36b98bo4iYdeKZPEU2k7UCNX+qsMQPEtERpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760079; c=relaxed/simple;
	bh=vrUZiS946LnNC1goBsI9uFHHOrFkJh/XXG0ZmPcHd/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zyvv0vjwL6MEMsYHaJjRsrwlwi+dCSy9C49EwaWJtUzP0IzGG5j9A0zDOnSy2fBQkca9HJ6y4zo3ntackMlP02Sr/cGVM1MOrllPGYRfHfjYYfKNZz/htQfVo4Vc3Z3VWoGH3XrGyKloRX83V9PHubD/fDsdcxbg1f9wOOenGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dpAjWaHt; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AAE5AC0007;
	Thu, 24 Oct 2024 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729760069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+10B4KImbjx9X9he3t+SIVSJ3nvD1Wd3kENDx0qP1Lc=;
	b=dpAjWaHtVOsMb3jEE4g11ap7V/5VHGmG0njluyPY/YoCh0ELR3FhFc6PnZZ2UVeUfbAZyL
	LhMvVpM+3l9IGdL1bRyycrpgM5tJRx9jupuO4+qO+MDjnsZcWFhjI7KNQl00W/MBWTTHmA
	neuYEOUKBw4bP8k7UFEzJQsMmzQzCdKOgvpqwMRVYjsQ1SrbFWBOwzJAAxQ1DSbDFYaLvE
	TZJMuA4yiH8Zh/ZHtvexOm/ZW0O4REUwMx2nBBGL1q022ykhRsT8Ua+5wJ0zvYnZ09h2Ka
	VGadYwlWJkm1s/dI9DbkDgyS5zpHJCsHvWpzupQ9JWS+gL3sdDNi4YfhnO7G6w==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 24 Oct 2024 10:54:16 +0200
Subject: [PATCH v2 1/2] dt-bindings: usb: Describe TUSB1046 crosspoint
 switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-tusb1046-v2-1-d031b1a43e6d@bootlin.com>
References: <20241024-tusb1046-v2-0-d031b1a43e6d@bootlin.com>
In-Reply-To: <20241024-tusb1046-v2-0-d031b1a43e6d@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-GND-Sasl: romain.gantois@bootlin.com

Describe the Texas Instruments TUSB1046-DCI USB Type-C linear redriver
crosspoint switch. This component is used to handle orientation switching
and DisplayPort altmode multiplexing for Type-C signals.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../devicetree/bindings/usb/ti,tusb1046.yaml       | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,tusb1046.yaml b/Documentation/devicetree/bindings/usb/ti,tusb1046.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f713cac4a8ac8e89c017999bc11e4b3a38d3ac2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,tusb1046.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,tusb1046.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TUSB1046-DCI Type-C crosspoint switch
+
+maintainers:
+  - Romain Gantois <romain.gantois@bootlin.com>
+
+allOf:
+  - $ref: usb-switch.yaml#
+
+properties:
+  compatible:
+    const: ti,tusb1046
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        typec-mux@44 {
+            compatible = "ti,tusb1046";
+            reg = <0x44>;
+
+            mode-switch;
+            orientation-switch;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&typec_controller>;
+                };
+            };
+        };
+    };
+...

-- 
2.47.0


