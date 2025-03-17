Return-Path: <linux-kernel+bounces-563849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D03A64975
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388E27A4A74
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5812405E0;
	Mon, 17 Mar 2025 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="UjlMnIZF";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="XlHN6XJz"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F90F22FF39;
	Mon, 17 Mar 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206686; cv=none; b=YEXXH9CWSvHZZnT5nBssTp6aal0+7n4wtjwHL+8VS5PXRIskjIIWBXRuEIHx+w1ASb2KwmDEBzF58921swjYbc4mr4EVgMNyJDYQAnOIYkR9JyZQTpVJKPI49Y6HfpbsRN+VkrRB3gtCIWE6UJ0k+dPsrFDyAGRbbsAgOBfzxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206686; c=relaxed/simple;
	bh=2VsTy8c8XLPO7On7Fj05WnP0izo3zONJErudj6K9Gnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roKBQ6F3jsnvHjLo/mK7wr7JiFLRKDWksonR7kG5BAw2BkWI0TOtGtSSiLCnvcxZjfU6+eIFKeudpqeCPvpnRjY71d+U8eCzezfLKMf8va0prOm4DhMZxsFIPxvKkxepPgFv8noxwP1YrqBVNz+pJdr3SPum3lrFTNJFrFnm80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=UjlMnIZF; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=XlHN6XJz; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742206682;
	bh=o0SUnxH7TH+uR9swaSzIuxKQA7MmHPp+RPHamZ6KPBI=; l=1215;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UjlMnIZFrj/wTlTyUmwkxBunV22eu8eyrTFyjGWyOkWVg7IYE9063YJbvXZnUfcim
	 xu4ki1lOLCPRA43IuNzxiUjhKvVvXtyBxS+Za75yE2Ae2dDp3o6tMpiyeCXNkOoJRB
	 xg0UbYG2aOq0hyxiPDq4GqZfkc4ZixDZmX+EWpg6MisoCdudgfsDCzQ0ETBJ9IdmXG
	 IDtfN7Ba3awlfO20/125zyZLdjQyUG8K4XHVk/LRgCidnudBLLqRBvIj1P4crO5rUF
	 8opqWAdrfTWsXmGXmMyUxdG5sqAFcX2AzapgPPZtceIpVM+jSOQT/w0FjOqtYb34I5
	 2n1cf1WGKbYmg==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128079:0:AUTH_RELAY)
	(envelope-from <prvs=1170D5C545=cy_huang@richtek.com>); Mon, 17 Mar 2025 18:17:55 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742206675;
	bh=o0SUnxH7TH+uR9swaSzIuxKQA7MmHPp+RPHamZ6KPBI=; l=1215;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XlHN6XJzDdttOAKWlXXogBovncnV+7cSWfoQsZVpBDq9MZGSNvHEeivTRacoKyS59
	 d7b1uveR0C6hvc1fgCS7UwhD7iVRq6ny/BccQu+ZbhCyJQue3D3Vn44wSNlmdh2PpJ
	 CBONH3syXmwuL77Xa0h602yNwfSQkkY6aiDr7sYL3FiWZkIl7fOujQ/USULu0ox1NQ
	 Vc/73BmEDdmR6Z2Lz4zHM5NX1jTmyAp0+IRahniIimf5fd/ANqzPhM/PbXTjKfYnux
	 LBUGZJdhSaFxn7taMS4US5XDjPptx4j0QzXt5at36IJHBojiswCRsXMSmXbwTiSSw5
	 rqboTxlWeKF2Q==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3810274:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 17 Mar 2025 18:05:18 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Mar
 2025 18:05:18 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Mon, 17 Mar 2025 18:05:18 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	ChiYuan Huang <cy_huang@richtek.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH 3/3] regulator: dt-bindings: rtq2208: Remove unnecessary property of fixed LDO VOUT
Date: Mon, 17 Mar 2025 18:06:23 +0800
Message-ID: <d90e57c14869415e6322e8b0bbff14da480a0adb.1742204502.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1742204502.git.cy_huang@richtek.com>
References: <cover.1742204502.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

The 'richtek,fixed-microvolt' is unnecessary. Remove it on the document.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,

The major change is to remove the property. The minor one is to remove one
trailing whitespace that 'checkpatch' found.
---
 .../devicetree/bindings/regulator/richtek,rtq2208.yaml    | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
index 87accc6f13b8..6466406d9096 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
@@ -39,7 +39,7 @@ properties:
 
   interrupts:
     maxItems: 1
-    
+
   richtek,mtp-sel-high:
     type: boolean
     description:
@@ -75,12 +75,6 @@ properties:
         description:
           regulator description for ldo[1-2].
 
-        properties:
-          richtek,fixed-microvolt:
-            description: |
-              This property can be used to set a fixed operating voltage that lies outside
-              the range of the regulator's adjustable mode.
-
 required:
   - compatible
   - reg
-- 
2.34.1


