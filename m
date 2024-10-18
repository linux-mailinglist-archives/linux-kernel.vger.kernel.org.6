Return-Path: <linux-kernel+bounces-371741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA889A3FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEAD1F21174
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D401F4267;
	Fri, 18 Oct 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IXiQstCh"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B271DED5B;
	Fri, 18 Oct 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258274; cv=none; b=FQKLlZs/l7EpLgIYIBtx/SBr5lP07ULUU1LWDEMhSSGl1Bdb8zAah9HL8EnUCkM7BpQDACEi+MJB0V0EDAPV0fkJCgyrnHZDnMJ6s9y5PPGChmUGQr0eH6vRLqyNGHG+1HG5vNh0U6ePs/ah6RxhruueO7wos6wMwvAB+bF7QlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258274; c=relaxed/simple;
	bh=veyfzP7uw6R7kI1xB4tw/cqt196dHxkyFp/I7vZtLxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPSOeCPQQvV05caeuScQW7TfaHD1Yj2R3jN4d3FwiEZzTGOM8/eCSzf4dk6Xhnd9s7EqxWx2SH9BnPQ9kze0hEh/p7SytD516jtYFjYTTCbcPYHazTc0EE45NYbf47zV4/TyV1x1UEUo+mubQCl2/Pui5zh39La9Y2rHzyO4Ny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IXiQstCh; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82B5CFF806;
	Fri, 18 Oct 2024 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729258263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PitjhYsg0bU2gWkq9AYfEsudHjktPPR+C1DN4B+5OYU=;
	b=IXiQstCh2Sagn8sSTKsa0Ofu9yunG6N5DlwiPECD/oSaSnrqVYycgwdyScUzYyif87+u/R
	ymMMOIyEdGiR+Ha0YVrkxZCIYBlQ06m9xPIqG4TtxD9InCqBpMvH/avPww6bVE0V1bm5kl
	0LU2eXR1nhvzQMGBBAjMaTQ5lvCT0bffoHUssH98+zPL798/cfN2B8QcVmHJUBxKUYVAnI
	RQLy3rjcWBCrUnyGFr1vYHq0NLs/xbkUbkuZSymjIJHA21XBmZ0U5tPNBFZnr6ocqZ03Nu
	TRFmwMpKZnW6BKj8hyoBO7qdWiZAimV8HU1AYS/9srwI5a3ELzZsVIn1DZR6pw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Fri, 18 Oct 2024 15:30:48 +0200
Subject: [PATCH 1/2] dt-bindings: usb: Describe TUSB1046 crosspoint switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-tusb1046-v1-1-a38312f18691@bootlin.com>
References: <20241018-tusb1046-v1-0-a38312f18691@bootlin.com>
In-Reply-To: <20241018-tusb1046-v1-0-a38312f18691@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: romain.gantois@bootlin.com

Describe the Texas Instruments TUSB1046-DCI USB Type-C linear redriver
crosspoint switch. This component is used to handle orientation switching
and DisplayPort altmode multiplexing for Type-C signals.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../devicetree/bindings/usb/ti,tusb1046.yaml       | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,tusb1046.yaml b/Documentation/devicetree/bindings/usb/ti,tusb1046.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ce3d10ea40c03618a182f6ef92c285617b173016
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
+              endpoint {
+                remote-endpoint = <&typec_controller>;
+              };
+            };
+        };
+    };
+...

-- 
2.47.0


