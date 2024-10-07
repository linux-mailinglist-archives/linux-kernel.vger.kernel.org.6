Return-Path: <linux-kernel+bounces-353432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D710E992DBE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761CA1F23B40
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B4B1D47D7;
	Mon,  7 Oct 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BrsEJo3U"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2B1D4176;
	Mon,  7 Oct 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308971; cv=none; b=M7FcEU8/r0qI9tQB3enQhSLzg/oVdOfKCpRk7B5kfv4shqKnQA3gpyIZtTG/dcfkPVbOrn6v5oDLjCQJfP8SQYMhPJOkgaGW7rWV2QR+8qjLzQx8xVqM24UpPh/Aj94qwpjV7ohcC3ozpOlW75UsulTOKXPDg5WmbAwf9r4v7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308971; c=relaxed/simple;
	bh=A8nr6O5Lz6IK4+gB621YaIzYGTSb2w/7vI7+3SS/KdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=slDXQCBGH2f0umo/OKrL5Fx+d5IS2WubCcCQl77qC0nwf5aGWj9hdSbXVGteVh9SRoX13zYu1qj2NVySL5IwtKnOzsOSco8TPFMJaXeT+nRuPZYO8Nj+X+lavVvYNzTb80r2mVIkH0Cmm9+8X5vMu9oRX8rF8/lKcMcpBjnD2EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BrsEJo3U; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0F221C000C;
	Mon,  7 Oct 2024 13:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728308961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A06h/MNKLVqWjmb0yChITBfxW2fZMzKtn2/HmfN+h8=;
	b=BrsEJo3ULRbFbpIodh8m3COjM50szNCJDl0y5VWPnfDj6OnkO+0X8C9/6mLsS4xORg4JYG
	NWMEE3YFSZv/oSCxUngitlxnBXd3fctgiYVIyJ62LC4ev0izF+33POppd89geazkccOTgL
	A49Bxe8lctnTUWDeSWAlpzelX9mOqrscFv9r8KzCDFrM456RAwE1gc8I5Ka7ZjHyS4A2XJ
	kCN/AsBYlBX9402Yi/9FK+tYfMduh1p+SQc2XuOmAgStYE8lO7h/GO7cCcKwJ0oUP1nK6Y
	JFFitnMVp0u1LaV8vEyldGFFr7wLc3Qv9t10fb/V7usilsLFWib7EhZ9Ho3ZZg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 07 Oct 2024 15:49:16 +0200
Subject: [PATCH v5 1/4] Revert "dt-bindings: clock: mobileye,eyeq5-clk: add
 bindings"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241007-mbly-clk-v5-1-e9d8994269cb@bootlin.com>
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com>
In-Reply-To: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: theo.lebrun@bootlin.com

Switch from one sub-node per functionality in the system-controller to a
single node representing the entire OLB instance. This is the
recommended approach for controllers handling many different
functionalities; it is a single controller and should be represented by
a single devicetree node.

The clock bindings is removed and all properties will be described by:
soc/mobileye/mobileye,eyeq5-olb.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/clock/mobileye,eyeq5-clk.yaml         | 51 ----------------------
 1 file changed, 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
deleted file mode 100644
index 2d4f2cde1e589100f19d84db09050a591c6b9644..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
+++ /dev/null
@@ -1,51 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/clock/mobileye,eyeq5-clk.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mobileye EyeQ5 clock controller
-
-description:
-  The EyeQ5 clock controller handles 10 read-only PLLs derived from the main
-  crystal clock. It also exposes one divider clock, a child of one of the PLLs.
-  Its registers live in a shared region called OLB.
-
-maintainers:
-  - Grégory Clement <gregory.clement@bootlin.com>
-  - Théo Lebrun <theo.lebrun@bootlin.com>
-  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
-
-properties:
-  compatible:
-    const: mobileye,eyeq5-clk
-
-  reg:
-    maxItems: 2
-
-  reg-names:
-    items:
-      - const: plls
-      - const: ospi
-
-  "#clock-cells":
-    const: 1
-
-  clocks:
-    maxItems: 1
-    description:
-      Input parent clock to all PLLs. Expected to be the main crystal.
-
-  clock-names:
-    items:
-      - const: ref
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - "#clock-cells"
-  - clocks
-  - clock-names
-
-additionalProperties: false

-- 
2.46.2


