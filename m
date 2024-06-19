Return-Path: <linux-kernel+bounces-220927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584BC90E94A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6E71C232C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A7213D521;
	Wed, 19 Jun 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FwP8avy5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2213AA35;
	Wed, 19 Jun 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796248; cv=none; b=qwy42J4LUqvmE4ojmlmGyQVg2P/ENMgJ2iwk+JVndDAFVzYIiREZNV7KvNnWHQpIaP8TcZPap091zL3sbtQsHGg87PElsQDHX176YNQPpKyP6/3gBKxv0+ukhPjY4h+7u2N2YVjIdDyvuKBDRC/T3g/FeSKXuykcZRDpcLQi27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796248; c=relaxed/simple;
	bh=AV5LSZIG/WMszq3J8MtYG9PvEEq/aTIOyQDB0X109wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMXWa9z4hEQPstWIJDKBQuK5NVC1IqHUShoZ7V8CnDx68nHMbYYL6Ow63529ZCHGcQYuANmU7y5sobkPGBPY4Pjd4qSjYJZWHZ4pHMXS6nhxjHFpd40xEypYwwciqCtSyb9tbCJD0qNsNsZp5OA/ZEmZmPXD4deZO79nyyFumb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FwP8avy5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718796244;
	bh=AV5LSZIG/WMszq3J8MtYG9PvEEq/aTIOyQDB0X109wc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FwP8avy5dAwvwdOlLtou8tozI2k5wcyByghYeut1TKw0+e5ZZAt+gbJDqqk8YN2hD
	 wZQRxjTntX6go2AyfSNmTVGLhj2Mj7+Ye/FUWrVDsEuB0am7qT6d07dO0mP3tyo7YW
	 yC6uMXEigm2DfpxrS5HR6hW9dsPp5+yZqIrCCYNvKBb1RrJQ4Lxqtl0RvyEe9+MAYD
	 OngLHbDw0JM71JZ6NxEG/YeH6HDKq3uciUWVe8dkKkBCryZIiVBkekCkOhJ76/G0uT
	 Amy0JLRfO5syXKBIPbOBnIKA3KR5OkiY3zqNb6zear39Xyc7xdluyzS4qEAWUDtS7g
	 obiqi15KXDp3g==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8C4C237821D1;
	Wed, 19 Jun 2024 11:24:04 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 19 Jun 2024 14:23:31 +0300
Subject: [PATCH 2/5] dt-bindings: mfd: rk809: Add missing audio codec
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-rk809-fixes-v1-2-fa93bc5313f4@collabora.com>
References: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
In-Reply-To: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Furkan Kardame <f.kardame@manjaro.org>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

The RK809 MFD provides a RK817 compatible audio codec, supported by the
rk817_codec driver.

This has been already in use by several boards: rk3566-quartz64-b,
k3566-roc-pc, rk3568-evb1-v10, rk3568-lubancat-2, rk3568-odroid-m1,
rk3568-rock-3a.  However, dtbs_check fails for all of them:

  DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
  rk3568-rock-3a.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks', 'codec' do not match any of the regexes: 'pinctrl-[0-9]+'
    from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#

Document the missing audio codec properties as found on the
rockchip,rk817 schema.

Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../devicetree/bindings/mfd/rockchip,rk809.yaml    | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index a327d73f3c43..cadfb5f1c631 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 description: |
   Rockchip RK809 series PMIC. This device consists of an i2c controlled MFD
-  that includes regulators, an RTC, and power button.
+  that includes regulators, an RTC, a power button and an audio codec.
 
 properties:
   compatible:
@@ -93,6 +93,34 @@ properties:
         unevaluatedProperties: false
     unevaluatedProperties: false
 
+  clocks:
+    description:
+      The input clock for the audio codec.
+
+  clock-names:
+    description:
+      The clock name for the codec clock.
+    items:
+      - const: mclk
+
+  '#sound-dai-cells':
+    description:
+      Needed for the interpretation of sound dais.
+    const: 0
+
+  codec:
+    description: |
+      The child node for the codec to hold additional properties. If no
+      additional properties are required for the codec, this node can be
+      omitted.
+    type: object
+    additionalProperties: false
+    properties:
+      rockchip,mic-in-differential:
+        type: boolean
+        description:
+          Describes if the microphone uses differential mode.
+
 allOf:
   - if:
       properties:

-- 
2.45.2


