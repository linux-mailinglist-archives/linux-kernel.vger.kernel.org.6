Return-Path: <linux-kernel+bounces-386801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7529B480B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA23BB213CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA9205AD5;
	Tue, 29 Oct 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="fqHzAleV"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1A205ABB;
	Tue, 29 Oct 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200288; cv=none; b=GD5iSH1Q24T+al7PUKjVaCmQOQxeScUNdsFN4pTlYwFa+ufr/Tvzu/ES/u7B7wad0Ibjdc139+zdz80p+svucqUIMlpcLX2bPjjZbU0qLdNsbQTYJOABTXC59AkFy/NB5EGIDDbg7q7SzdSLSOQoI8LDDwPCvvBj/NJOV8di04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200288; c=relaxed/simple;
	bh=urUDoiCfGTanskrpk/nVfLsAwra9Azo71xlx8jBbmLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmSu4D5XNx5wgQ60W9RP10ZntP5Lul78lHw0SI3qmg521VF9H56wwfemW9uj6zI5I62vVAjGnJYAzTNUTG1NqK1oLxPn4h+h1eKJ0TxmcqfkV1LhK4NkiYsHVtKlyQ7Il8i5Zn+HRXoZxFEmlJOlaj+9S2WlBETfRd15/chXDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=fqHzAleV; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=2mw6wIsgNp3nO1sAu93Wf091/AE6UwJyrSXnTj9zaeU=; b=fqHzAleV/stfMIIbiD3N63c1sf
	yzq7GY9AxvXpEb+o4IGxW2t5oQupYfLZ5xLw4xscqp42iPsKu6ag+YZbpjQhVoBLh+SLlZvNW93mv
	GAZd32b6xvCMV2U4YojyKb2MUY/oivKBAOleHqbv7KDTNqt9dE1wpPbzox/005QufZoUhjuynQI2U
	amNK1E08EEttq+BIuZ52SMa6MvkapWkwE8vCojubAVq5HNF0khtQWEwwJ++BeBLEB91r/l0tTpjXj
	6qkOy2PrZHsjqgutKsSD5X02/Gn4wHrgHkf5d3/KetD65+fG1McwA4QX7lnLnyrFF0ihg9lRa4+kV
	nqkNrETQ==;
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
Subject: [PATCH] dt-bindings: mfd: bd71828: Use charger resistor in mOhm instead of MOhm
Date: Tue, 29 Oct 2024 12:11:12 +0100
Message-Id: <20241029111112.33386-1-andreas@kemnade.info>
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
yet. Specify a current sense resistor in milliohms range rathes then
megaohms range in the examples.

CC: sre@kernel.org
Reported-by: Matti Vaittinen <mazziesaccount@gmail.com>
Closes: https://lore.kernel.org/imx/6dcd724a-a55c-4cba-a45b-21e76b1973b0@gmail.com/T/#mf590875a9f4d3955cd1041d7196ff0c65c0a7e9d
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
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


