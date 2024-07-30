Return-Path: <linux-kernel+bounces-267840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3659416FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3791B27CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891D0189909;
	Tue, 30 Jul 2024 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ll+p92W/"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A64189519;
	Tue, 30 Jul 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355496; cv=none; b=f1FvSa+rClL8Sv2QVXYcQZvGEhSVO0TIsWPwSgPpiuKdicjh7zDgyI4HUMSGb6FcCSn6jQTLLMF/R820nV+lG6RhyB1BwnfYelVIOE8OWx6LQSZcmrzCsPwZE1AkXKbJw68JUqKdhqL+pWpzVMbfMQ2b/hauczX0ge5CMqXmf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355496; c=relaxed/simple;
	bh=4TBs1HYdxNJuW0Zql1GbvVoJVx4d9v9lP7I/XqjzvQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oeNXaCT1DD2SGsZI0o3U+SqJUajPhDJuJkl90wBA9EkzIUzPIxXTSlgrfD4FUS39y3m7FRB9/oPyEioNkQ5X0PtDelL7ya7SRlM/aE9jOakqmOJ27QKP7j3SiB1rPeU9yE3W58b0odglJk2RTg+cWywPq/B3WuqO74Hb3qFH2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ll+p92W/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F479E0002;
	Tue, 30 Jul 2024 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722355486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2PU9k3tCN4PaXJMVba3eK06E41fBInVkusLse/OBtI=;
	b=Ll+p92W/Fdp0qBoQ3JvFfzIO/qOciL/RHekN0oX9snT/WUAcLaLgaPrLk3erKt4WN7nTPG
	aymAXF2qG6iz/CV48iNgmXz2JgPLeEJ7ecYfhddfpzv53xMDiZ7my4gf5jKEKDBnAXusxk
	PvhEsGfqyinjKNFGu0GCkz6JEwMdmbOl86rlOXJKQY19uDIdNCeJH+H7AwNCpZO/NX+Np8
	+Z9tyioOguRh+qk1x+M/pwsw/3UR0qcuM6zMTEVEuJc0kTnICJcxrfv3Ci0xODs0BTuW37
	Pw5+4RNSkZsva50EY13yn63GxQImWefHG1YhQ5aAQqcpIq8kqduPRWWCYsdI7Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 30 Jul 2024 18:04:43 +0200
Subject: [PATCH RESEND v3 1/4] Revert "dt-bindings: clock:
 mobileye,eyeq5-clk: add bindings"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240730-mbly-clk-v3-1-4f90fad2f203@bootlin.com>
References: <20240730-mbly-clk-v3-0-4f90fad2f203@bootlin.com>
In-Reply-To: <20240730-mbly-clk-v3-0-4f90fad2f203@bootlin.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
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

The clock bindings is removed and all properties will be described by:
soc/mobileye/mobileye,eyeq5-olb.yaml

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 .../bindings/clock/mobileye,eyeq5-clk.yaml         | 51 ----------------------
 1 file changed, 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
deleted file mode 100644
index 2d4f2cde1e58..000000000000
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
2.45.2


