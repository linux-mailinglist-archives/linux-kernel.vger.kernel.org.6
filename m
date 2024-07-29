Return-Path: <linux-kernel+bounces-265199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C3D93EDED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6524B1C21D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976B412D745;
	Mon, 29 Jul 2024 07:03:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48A84A31
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236592; cv=none; b=ZV47p74WWy1A4KBdNVm2/rGFA0F7a/BLlygYVdAuoqQl0ISSsyknnxz/NNZiumLsv575eL8OxdidKu98We+3U2gOHEAoeu69SZZIn/FDQEgJzmPyNSN7sQ7CjIU5YcG0ZURCXtpCzh4urEEWP+UTxZASfs2uL6gu03CEm/eYDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236592; c=relaxed/simple;
	bh=xzeSKTQGlAitcdDu2k+6C3sfK5e2ZsDVVFCUee6pB1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A1bXKeXtJuSuIwOdjPjwXNY7AScTFXxf/ZTiaKZQdus5vNazL4zWvjuIDEtrzswjl9nnrfRGGnkeLUw0mtNFwsymU8w/v5hkA8MLyFrLNgNobYzd5DKOEMwA9AP6StuWBQ3H64uZivuAdAtxeBCIF3DJ7qVRkXaMKcENwu98XfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1sYKP3-0003xR-F8; Mon, 29 Jul 2024 09:02:41 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 29 Jul 2024 09:02:38 +0200
Subject: [PATCH v2 1/2] dt-bindings: display: simple: Document support for
 Innolux G070ACE-LH3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-b4-v6-10-topic-innolux-v2-1-27d32c766ce5@pengutronix.de>
References: <20240729-b4-v6-10-topic-innolux-v2-0-27d32c766ce5@pengutronix.de>
In-Reply-To: <20240729-b4-v6-10-topic-innolux-v2-0-27d32c766ce5@pengutronix.de>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 kernel@pengutronix.de, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add Innolux G070ACE-LH3 7" WVGA (800x480) TFT LCD panel compatible string.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 5067f5c0a2723..e9941a077a20d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -180,6 +180,8 @@ properties:
       - innolux,at070tn92
         # Innolux G070ACE-L01 7" WVGA (800x480) TFT LCD panel
       - innolux,g070ace-l01
+        # Innolux G070ACE-LH3 7" WVGA (800x480) TFT LCD panel with WLED backlight
+      - innolux,g070ace-lh3
         # Innolux G070Y2-L01 7" WVGA (800x480) TFT LCD panel
       - innolux,g070y2-l01
         # Innolux G070Y2-T02 7" WVGA (800x480) TFT LCD TTL panel

-- 
2.45.1


