Return-Path: <linux-kernel+bounces-331545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F797AE2B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88314B2A98C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D874016B38B;
	Tue, 17 Sep 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="BFmaCbYL"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40085169AE4;
	Tue, 17 Sep 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566030; cv=pass; b=Qrb+84RN0eY0V1HtqoeUgzPa/uuoT5AxUkBfJSMaulCM9gu0efA4BHGB9kbCS1ZcYrBGlTNGxn1WoeS0E8xnMMXLFBLAN1BeKQEEct4RZ+o1wbCQuB7TEEpD+ki38TaHepQMPnsu1Z4YZlVBAlY9uurZtOAX4gE7hEMJlmBcW7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566030; c=relaxed/simple;
	bh=fjMaab45+pbBhcWskkwLh7ZFuxcKK4idnJPlPFyB5hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WcZRG9LYcaRJ9hP08VWy0yQFMyA8vDMkgUMdM8KppaT4emrXugHPdTty1MW0UWSuuQtVIG317tojrfLwuTgxVqhFTJhea386BfCIb7yPao2Kk6WfG6z1BWgCLbAzZWJT0F8L+tS5Qm5lV0Pq6k1+C4PMHq7x/QbP7ZnEN0Zx5W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=BFmaCbYL; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1726566022; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fA07oXHUQRzPwkAI09zDfiHWFwOrWVfA7gr7+m7SUKQYSqiHF1My3UxpjjQKvloWf0Uev79oXLEIS+YlcN/HluU7XbAFItkAsrvfHR3VOwA12lphazT8+NonJM/Sq+nC0ffo2vfY2RWRolvMQIjR9iBGHSqwyBpMSERLDjerlgU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726566022; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r/CPzEUqg0JVM57s+c79LCWGpHgUgoF/PtjNWw5wmT4=; 
	b=POGElNvYLB+0J6rURvCvruqpv1cxl0hsQ4IVb93YBMavQxSFRC2tMqKx4vjUYBA/JYYDgVlFdPyyi3QC3os2Yh0HG2Pdi5Fqxy3gYnt7QvSI7YAafE3wCM2pNs5WhmgFJZZjWnE1ZNexJxoN/uhweVn+D4oSMQqoiAfGEpXo4lY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726566022;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=r/CPzEUqg0JVM57s+c79LCWGpHgUgoF/PtjNWw5wmT4=;
	b=BFmaCbYLpI51Xw/E/5j5MWGV79lipmbvBFip4uE2HFpjWHyQxPWRabf48RJvQu+L
	rd2N4HbIk1aQz+WLv+8eczUeve2CovFXaJAnQoCXlx0mqXfRPjTGgnTxcdZptkj4qai
	KDkm+g1Ol4k2c3vWhW4cZY0tofrbkOpOm3gRh94HSBVcBrjBYHOj7KWfFlziF0uHMu2
	IkME3FK3oYGX99oYs6d2ofLA/Agwkcxr1AWSgzWEFfnQkIqr6wTJwTqi/GicaXFft3Y
	RctW005LsYi7fVwS7qV/1pgFbG1srrUAzY9aF6Em6O5kLFdvBjVtLcVlhqyzy/9j4eF
	6qZgVl9CFA==
Received: by mx.zohomail.com with SMTPS id 17265660210421019.1959058619678;
	Tue, 17 Sep 2024 02:40:21 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] dt-bindings: usb: genesys,gl850g: allow downstream device subnodes
Date: Tue, 17 Sep 2024 17:40:08 +0800
Message-ID: <20240917094008.283529-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

As this binding describes USB hubs, it's natural for them to have
downstream devices.

Change "additionalProperties" to "unevaluatedProperties" to allow
properties defined in usb-device.yaml (for DT cells properties) and add
a pattern-based downstream device subnode rule to match those subnodes.

These changes allow downstream devices get defined under the hub.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
This patch is sent to fix the problems shown for the patchset at [1],
which declares a MAC-address-less ethernet adapter subnode of the GL850G
to have its MAC address set from the bootloader.

[1] https://lore.kernel.org/linux-arm-kernel/172623730520.4076253.7175037716930825765.robh@kernel.org/

 .../devicetree/bindings/usb/genesys,gl850g.yaml          | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
index fc833363cfb49..6fe2d356dcbde 100644
--- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -62,7 +62,14 @@ allOf:
         peer-hub: true
         vdd-supply: true
 
-additionalProperties: false
+patternProperties:
+  "^.*@[0-9a-f]{1,2}$":
+    description: The hard wired USB devices
+    type: object
+    $ref: /schemas/usb/usb-device.yaml
+    additionalProperties: true
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.46.0


