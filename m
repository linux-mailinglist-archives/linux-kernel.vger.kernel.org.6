Return-Path: <linux-kernel+bounces-403855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E689C3BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390141F221A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9FB17DFE3;
	Mon, 11 Nov 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="vqlNucr5"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC7178368;
	Mon, 11 Nov 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320838; cv=none; b=jxxLebGZeCGYHJypgIKu+JpRlVAtWSlqy+bbM+aunVbZ8GE+9ICpwbWr6uQL5sCEwNoDCm5uZyXyZjlaoRNZ0ayHm35OgnPtrrgo/qeJQdMwdbomRDi5Cfvs11ohBFzcnkjGrDZkjORRfu0H8VIHyUwnhqJTXvBo0RD5HhlDJ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320838; c=relaxed/simple;
	bh=qX0tOYFqdWmuVqzHqRPWO3tk21m/yO9VzTojXGyzIUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JbSThanmPqqDk72CPL1InSYeaNAU8LF362OYvwOPMzmlgGT53IdL4AwIfhTeK7d7D9tnCHfFBNjk8S5/X2HHJDZhMcWdHEGC80OT6kmFkS/pH1YGo2Pd1w3OMu8x8wjSZ/LLdqlT2XET7ImZMeLNbKe/qJ7lQICh09cf12Ddres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=vqlNucr5; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=n9I/rsmSPkccC1qV3PhdqkeMEIkBVG7v4CKI1grF8vI=; b=vqlNucr5OrPliBOoYg4LK2nrG8
	+l2fK1YdtaqFOk8wG83po4WzeXgBgBwcCKvMI8tBhlq9+r4vvXWucaCDEQ8/+qD+w1HV0CMwvqv8T
	IJR3pjs1nPjq26EUEfgXlS+cO4sAhWIMUzFYiQLSShpeE5CzZqzvanxedgOlqpXutNQ5EpkDMYidD
	omYjwbOXSV8UIV0wO45TWZznjoGjWg8IwBaSyD/aoQJmRLf3HwtK35pomRCrry7/TitImQuRaWtL6
	X/PptMbWvq2rgkFeWq+hN7FX6bdEY8damEuoBJvypk4HlErm4uGJn24HQgK8SIGrNpZQgAHlS5S7L
	k9+yMVGA==;
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	sre@kernel.org
Subject: [PATCH v2] dt-bindings: mfd: bd71828: Use charger resistor in mOhm instead of MOhm
Date: Mon, 11 Nov 2024 11:27:01 +0100
Message-Id: <20241111102701.358133-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently there was some confusion regarding milliohm vs. megaohm.
(m/M). Use microohms to be able to properly specify the charger
resistor like other drivers do. This is not used yet by mainline code
yet. Specify a current sense resistor in milliohms range rather then
megaohms range in the examples.

CC: sre@kernel.org
Reported-by: Matti Vaittinen <mazziesaccount@gmail.com>
Closes: https://lore.kernel.org/imx/6dcd724a-a55c-4cba-a45b-21e76b1973b0@gmail.com/T/#mf590875a9f4d3955cd1041d7196ff0c65c0a7e9d
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Changes in V2:
- typo fix

 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml  | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
index fa17686a64f7..09e7d68e92bf 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
@@ -55,14 +55,15 @@ properties:
     minimum: 0
     maximum: 1
 
-  rohm,charger-sense-resistor-ohms:
-    minimum: 10000000
-    maximum: 50000000
+  rohm,charger-sense-resistor-micro-ohms:
+    minimum: 10000
+    maximum: 50000
+    default: 30000
     description: |
       BD71827 and BD71828 have SAR ADC for measuring charging currents.
       External sense resistor (RSENSE in data sheet) should be used. If some
-      other but 30MOhm resistor is used the resistance value should be given
-      here in Ohms.
+      other but 30mOhm resistor is used the resistance value should be given
+      here in microohms.
 
   regulators:
     $ref: /schemas/regulator/rohm,bd71828-regulator.yaml
@@ -114,7 +115,7 @@ examples:
             #gpio-cells = <2>;
             gpio-reserved-ranges = <0 1>, <2 1>;
 
-            rohm,charger-sense-resistor-ohms = <10000000>;
+            rohm,charger-sense-resistor-micro-ohms = <10000>;
 
             regulators {
                 buck1: BUCK1 {
-- 
2.39.5


