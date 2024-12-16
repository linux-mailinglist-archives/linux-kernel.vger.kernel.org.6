Return-Path: <linux-kernel+bounces-447671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A6A9F35E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68711889247
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8680204588;
	Mon, 16 Dec 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="htrA2Fha"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07E126C0D;
	Mon, 16 Dec 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366113; cv=none; b=jhuyWuZWNiSEv/jqMlCblehdrXojt2YLgCU4HBeepyzza944ACcGTdOa1DWCCqk27gRDYb9FtG7+AjxWmSB7lBhlORe5xDkcq9GMEVTyuFrt7JsK95flnO7yoM9TTf0aHYWSGJZuVBidbQ24uKcWL55/8SHlcAmBhcTB6W11HEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366113; c=relaxed/simple;
	bh=8PGg1G9b1WHVgepNl8Ghc72WJKymlCdHjYTkwVljtOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efcgirsWx+vaLD4IBspAFuiPOnRonLvwy9XPxI7cR1HnJ0/bEb4vKI2rSZxRpg3z6iOmLf4t5kchyLMWqqoQHbonYcP/awuu0mD6C9Osw7aES9XCVG17QV5eTv7V632N/Sl2dT3qUabDTJLEJk3FOSy3Bb7uvMFIRyd4IpdJpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=htrA2Fha; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7BB560010;
	Mon, 16 Dec 2024 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734366103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sivQPTpUdlYTIBcNtvH0D2TYdDsv/PsI4e+5O1AdUCA=;
	b=htrA2FhaEEDqp8Sy2dplXT/ZTxDVMM6gf7lAjbSsbNsNX9pZs5vBaKwDCPKiuXLohwOVy4
	os8fXBD6fzDCj+wx4I3BgpJxzA7ss14uZiCwQw5VB9ZVs8mSjWOpALQuk3fdv/WOGHqqzZ
	zSwS7FM55L6qqDoG08biFs3pdmqZxUISRwyz4Aa7AK4jlX4eHsQoWs5p8HDghgLnh10g1z
	15WQppkB0kVI+Bl02Jd2a48FnIcbibWK1Yc/WJ62HQHoOJJGIvO05+dkRVDayo+SUaTIfU
	hkFrWxeufe3Q3g7jS79pHCx5lrGmmePW4WNPO5aSzC+KfdgbWJ9iwBz1+HPzMQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 16 Dec 2024 17:21:34 +0100
Subject: [PATCH v2 1/2] dt-bindings: display: simple: Add Tianma
 TM070JDHG34-00 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-tianma_tm070jdhg34-v2-1-0b319a0bac39@bootlin.com>
References: <20241216-tianma_tm070jdhg34-v2-0-0b319a0bac39@bootlin.com>
In-Reply-To: <20241216-tianma_tm070jdhg34-v2-0-0b319a0bac39@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

Add the Tianma Micro-electronics TM070JDHG34-00 7.0" LVDS LCD TFT panel.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
 - fix inverted lines
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 18b63f356bb4bbf6d2c8e58b13ebb14c5f4004ad..fc334a8aa6d914c1222a9767fec4ae5beb147031 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -280,6 +280,8 @@ properties:
       - team-source-display,tst043015cmhx
         # Tianma Micro-electronics TM070JDHG30 7.0" WXGA TFT LCD panel
       - tianma,tm070jdhg30
+        # Tianma Micro-electronics TM070JDHG34-00 7.0" WXGA (1280x800) LVDS TFT LCD panel
+      - tianma,tm070jdhg34-00
         # Tianma Micro-electronics TM070JVHG33 7.0" WXGA TFT LCD panel
       - tianma,tm070jvhg33
         # Tianma Micro-electronics TM070RVHG71 7.0" WXGA TFT LCD panel

-- 
2.34.1


