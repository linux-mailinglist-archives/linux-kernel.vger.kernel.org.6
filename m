Return-Path: <linux-kernel+bounces-267846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5322294172E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F2BB24D13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444D21A38DB;
	Tue, 30 Jul 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O18uA9Dh"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E0518B473;
	Tue, 30 Jul 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355590; cv=none; b=OPVUH8e7aoswcR05dFSqKJ0o/keuOJ4AySDCNF/OoyJXx+U2ugBI6W4GQ+u3OqTRbKwOSZkGPLoL1wgD8kzTMnkXsPQ2kHmI1C1mfHIA3b8mlNLPMxMyeak0wDzwg+1637QfqXxjk23ZFIMzshUYcivU/eK28gy2ZjeXTFa4dd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355590; c=relaxed/simple;
	bh=9cxRQXUGtJv7JNNra6p9zDW5Nf/OAQ+E3UnoYMO7OtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQloD2XXt6UyMmSq5jxJ5p+F89g/TS0Zjkx2Rdk+JyTu8wNWyMPaQpH29c/4bGwwF0egZaMj2VgXPezma3zGXWpmAgI0zoIhoR+AtfDFv1a1mf2GkC9UovjwSHc4BzNyNVHTz7cj5vF59vV7ctuch2+Dc/UOWT2H/YRumtUyNow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O18uA9Dh; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21733C0007;
	Tue, 30 Jul 2024 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722355586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GNVGkUX8ZaaNTIrGwh8Ca2lsAslgj1ujCLGjjdcvZ0=;
	b=O18uA9DhEvIRIhFg5dPa3a4hJZJf8Nyzb1TcGXf8xICldZ4wxa/rGTcM9MrlUaoGiFJBRi
	9lK18NlCIfxl5t0QkviVNeKpkC7MKXVhC/TlyEi2i4wSxb9BhC7Hnw7nt7bQRGxygEa8xN
	S4Or781EcA13e7sllwOC/B02jXPKpO8gdMyS433vY17kfRm0oxYXd6P4qisexMbY8hnVGs
	CT5PCQ8B8OZat2aiQrtEIQkrtTHynrrU13pocUBp/6VEoTE//hWqkZFLhV6faldWh4HZoQ
	qJdbaeQQmMtUK/N2YLFRvolpQ6OP4pOEEK1Ex64rb0KKr6KQpPmmESOlk/vvFQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 30 Jul 2024 18:06:22 +0200
Subject: [PATCH RESEND v2 1/2] Revert "dt-bindings: reset:
 mobileye,eyeq5-reset: add bindings"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240730-mbly-reset-v2-1-00b870a6a2ff@bootlin.com>
References: <20240730-mbly-reset-v2-0-00b870a6a2ff@bootlin.com>
In-Reply-To: <20240730-mbly-reset-v2-0-00b870a6a2ff@bootlin.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: theo.lebrun@bootlin.com

Switch from one sub-node per functionality in the system-controller to a
single node representing the entire OLB instance. This is the
recommended approach for controllers handling many different
functionalities; it is a single controller and should be represented by
a single devicetree node.

The reset bindings is removed and all properties will be described by:
soc/mobileye/mobileye,eyeq5-olb.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/reset/mobileye,eyeq5-reset.yaml       | 43 ----------------------
 1 file changed, 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml b/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
deleted file mode 100644
index 062b4518347b..000000000000
--- a/Documentation/devicetree/bindings/reset/mobileye,eyeq5-reset.yaml
+++ /dev/null
@@ -1,43 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/reset/mobileye,eyeq5-reset.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mobileye EyeQ5 reset controller
-
-description:
-  The EyeQ5 reset driver handles three reset domains. Its registers live in a
-  shared region called OLB.
-
-maintainers:
-  - Grégory Clement <gregory.clement@bootlin.com>
-  - Théo Lebrun <theo.lebrun@bootlin.com>
-  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
-
-properties:
-  compatible:
-    const: mobileye,eyeq5-reset
-
-  reg:
-    maxItems: 3
-
-  reg-names:
-    items:
-      - const: d0
-      - const: d1
-      - const: d2
-
-  "#reset-cells":
-    const: 2
-    description:
-      The first cell is the domain (0 to 2 inclusive) and the second one is the
-      reset index inside that domain.
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - "#reset-cells"
-
-additionalProperties: false

-- 
2.45.2


