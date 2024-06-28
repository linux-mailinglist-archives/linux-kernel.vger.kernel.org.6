Return-Path: <linux-kernel+bounces-234185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75D891C366
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B99D2854EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E8A1C68AE;
	Fri, 28 Jun 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LT2CM+aO"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710B1C9EB0;
	Fri, 28 Jun 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591081; cv=none; b=R+2gVEpxg4ymwS1OrLsvKZsBkQJnIMdU4o526sYGgRL9J+pDsHZrwN3iaPUv3gd1Od6IIpFGOw8JeQhQfVaXm2DtyefyK77mqJV9yDnc5aCnVlmY67/f6mMb+zBG4JYZLsUi3Ag59U5gHt5TbZGb8r2pIv0kIfF9l2tqwxVqH80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591081; c=relaxed/simple;
	bh=9cxRQXUGtJv7JNNra6p9zDW5Nf/OAQ+E3UnoYMO7OtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrGL691W2QHFdZUwYmnakftquk2jjfu5tBctMQPjb6Wp5UHzBJXrMd2PuldGu3DOM4y3E5/dQJC6NDTjJdECcFGk7HEOI7GV1gXuTQ2opGQk/7pcwdRwNe2HDup8NYzxJR1xy00LAjnp64uVtw+vcYhTZXEHZraM85hdZSEpus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LT2CM+aO; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6002F20008;
	Fri, 28 Jun 2024 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719591077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GNVGkUX8ZaaNTIrGwh8Ca2lsAslgj1ujCLGjjdcvZ0=;
	b=LT2CM+aOWu3nBweF0RFZqgaeC0YihaG5hvNNFQGYTtDRjphbQo7CaBJI+e5ViTTQTd/6J3
	eyOCAGrgpgWPyXMt+A6fzViLK9gd7HOEiQ84stFw6fcsb+GYBiJF0wHBV522SdHS2l/uD8
	tjQPs04bKKaZdLAC6Lma64RDGIIEAOTJ66Y1x+r8ciW6gAkDyhgHU/GNAKyyOcepqxBwZ4
	1iLf2ww3BNd2N2XWjNf3tkSqvUeJBoVmw0PS+/qJnUhWEwqGsB/98rpelwYYG1DlyO2iUr
	ROQ9R0iyd78WLCbl8XfPfVvBQKtshHMxRzEJmDNJ5SU6AUWWKAUxQJp1HHrO8g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 28 Jun 2024 18:11:15 +0200
Subject: [PATCH 1/2] Revert "dt-bindings: reset: mobileye,eyeq5-reset: add
 bindings"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-mbly-reset-v1-1-2a8294fd4392@bootlin.com>
References: <20240628-mbly-reset-v1-0-2a8294fd4392@bootlin.com>
In-Reply-To: <20240628-mbly-reset-v1-0-2a8294fd4392@bootlin.com>
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


