Return-Path: <linux-kernel+bounces-239556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1581F926216
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C694B284C2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF56017B4E7;
	Wed,  3 Jul 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GrDtr8Nt"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1FB14D44E;
	Wed,  3 Jul 2024 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014400; cv=none; b=fptdejJLLzBoD2DldB68iv+VE1SvGuNLC2SLCcw06uA08hxjUnguDjhqfV83A0ZIhJCVVe3/uBzSSzXm8opYANX6HHdXGpva8CsS8Z5/eqryjhNWj/4CcXEv52LCykwnedNh/HD6in2FEewPUBT+7mQow8BP8OZ80jkO4XCkrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014400; c=relaxed/simple;
	bh=9cxRQXUGtJv7JNNra6p9zDW5Nf/OAQ+E3UnoYMO7OtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phTaTV/yP4ikwFiG1E+u0FuoVKr8vyvE1mXOluJufUOUy1QsSFvb5DfSP9Q4HTzD0OrTOKJjKvJNJr/sZzRiG+/cFE+2KcAhb4uF4uNQExoRD9nF2erpk+eItVGRsl8LIAAziBkuUcAkg8ppH+OU7LFe8ytpL8aKhsQlqW1QCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GrDtr8Nt; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 159FA40008;
	Wed,  3 Jul 2024 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720014396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GNVGkUX8ZaaNTIrGwh8Ca2lsAslgj1ujCLGjjdcvZ0=;
	b=GrDtr8Nt/eJZ6zrJXRELPVUTgWlK4Rvf4/DINUmXx5qf4jb3SbebYPQouAv7lAN1CL1Bun
	rJ0lTsOeSpN7Q+xG7/Pq7DR8GttpXViea2iRjzjSAyPaY3rPUQXtk/ib5+NYwyXIXfXoT3
	Ap9LkLUo/hykGRX23KBLWvumPEah4YCd+QeUEM3zTkuQ0EhIO4MfIGWmrYbjniqFscBCje
	omG2u3CxNI+HtF5tkm872+DcQxTMRiCWdTabMZyc/+2y8JnlobsD2pvz+KV2eWnmRTdHJt
	Jf3CYi+o1620/bbFPB+ypI4c2czUJgA6FilLvsPgWnqV0oH9JXfWqWk4/dFU/A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 03 Jul 2024 15:46:32 +0200
Subject: [PATCH v2 1/2] Revert "dt-bindings: reset: mobileye,eyeq5-reset:
 add bindings"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240703-mbly-reset-v2-1-3fe853d78139@bootlin.com>
References: <20240703-mbly-reset-v2-0-3fe853d78139@bootlin.com>
In-Reply-To: <20240703-mbly-reset-v2-0-3fe853d78139@bootlin.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15-dev-13183
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


