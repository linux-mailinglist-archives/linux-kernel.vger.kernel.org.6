Return-Path: <linux-kernel+bounces-440067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF4A9EB83B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F99163860
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4D023ED5F;
	Tue, 10 Dec 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bzbjBktf"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC123ED47;
	Tue, 10 Dec 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851706; cv=none; b=OqZ7j7wSQ7NU/HX/2ytcbEctO1CDRi0MNaNndOJjHINfnn0PxEhO7B7TtNE96dGzVPEAt2wtBrb9GJPDNOuav6SDQmcGGkR7+Q1O1N7C6tFIa5ESeBjAXeGl0DkBM7v3vl3vNaqJsEIdvkNhzRwlt1iC7PtFDFRaXhBFek7Begc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851706; c=relaxed/simple;
	bh=JA4VTDDE0boUbvpNqxrwwyUkwoBYeW1dhK1ycdnllPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLuhFlQ0s7IDYSYa0wlMfb7b+dSGrbLixOrobs4012ySABIwrT349baq6tDvZbow5bCKEh+XMilJ+aNFVvV6YJ2mUThFwfnQ2MCwR6aNiV4ENv/cnBwPU7FHU/FOCkAWZMFQ+OMF24dR5dX0u/cHezIcqJUMzyAAcGG+EZn7Myw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bzbjBktf; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D59C1C0004;
	Tue, 10 Dec 2024 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733851702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GS+vwpanwrRpzMg7vBXvtfqStuSko6swxapbB+Fqz7M=;
	b=bzbjBktfb1UgmR3w1TS8MKybm/SazVNPyZM1gbStEmydfyUmYmfGy3lVhfpo1165aHsvs5
	0IwIoz5bw+W7EvAtIG6h3z8LMNDg41aOrbn7J4tn2ZE4Kz8d/ZjfOOPJZkJRAoxJXnTFAY
	ze5EdcZ9cOGEHIVlm0HFogMZwTZDe/Oz8s+Dn5yytmRJgwWjNXftia9mss1S1Imr7JgyMh
	yFEl0WYuv+65ct7tFrT7v68c8CZbWtT8MaoP4HnHNLkXkeJ0N5E42ZflgW8A5BEp1XEC/H
	1fyYbwgxKfbNiu7eRrjSSbJQmjlD4stfzgxBW+cHU7uUv7H1Xy/ru8otwm8iEw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 10 Dec 2024 18:28:03 +0100
Subject: [PATCH 1/2] dt-bindings: display: simple: Add Tianma
 TM070JDHG34-00 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-tianma_tm070jdhg34-v1-1-9fb7fe6b6cf0@bootlin.com>
References: <20241210-tianma_tm070jdhg34-v1-0-9fb7fe6b6cf0@bootlin.com>
In-Reply-To: <20241210-tianma_tm070jdhg34-v1-0-9fb7fe6b6cf0@bootlin.com>
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
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 18b63f356bb4bbf6d2c8e58b13ebb14c5f4004ad..30f655e82666bb1aa227edd26bd8d3621a39e74f 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -281,6 +281,8 @@ properties:
         # Tianma Micro-electronics TM070JDHG30 7.0" WXGA TFT LCD panel
       - tianma,tm070jdhg30
         # Tianma Micro-electronics TM070JVHG33 7.0" WXGA TFT LCD panel
+      - tianma,tm070jdhg34-00
+        # Tianma Micro-electronics TM070JDHG34-00 7.0" WXGA (1280x800) LVDS TFT LCD panel
       - tianma,tm070jvhg33
         # Tianma Micro-electronics TM070RVHG71 7.0" WXGA TFT LCD panel
       - tianma,tm070rvhg71

-- 
2.34.1


