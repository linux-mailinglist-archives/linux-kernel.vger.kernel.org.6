Return-Path: <linux-kernel+bounces-368882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 439669A1608
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D24DEB23183
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD211D47B6;
	Wed, 16 Oct 2024 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="mb+hBcDy"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF1F9C1;
	Wed, 16 Oct 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729120417; cv=pass; b=DDmMPZtptkB7AksOnvxEA17Wqm8h55VMk/2pQnMF3Q42NkIk6Squ671KWwaipZL+HhK9OOEzRVRfvZf3lSLORco8E/JowyYqU3C2eq6oW4KD3EVp4JRMJ9+dcbyt31rhtIwy/DlSKT9XZWZva8qfOswWWXSIHw12oPNJPICRSsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729120417; c=relaxed/simple;
	bh=QxD1wOZue8qPc1r/LIzRLxUq0oQ9AFAao0DTFJagviI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5VsOTkAAkuCvaNT72b0jUsmgFiGuOJeSXTjo6gJfF8+hlrOaKM5fVvnJHsyWKHoQxeH+aM93pny+s2KIwWEF8WkNKuUVvlq5H9oXx7zDoXiU+uxAYAbwv3Dp0ZN5v8gZ6nmpIdDp8MGD1dW41JNE5+zCkUEjLC/wktcz590n5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=mb+hBcDy; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1729120397; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VMp4Hz33bkVA2A8PlupzI4d2ciomAMiIWpcx7UGqCtsbONemkbbCk7wCZwQEW5fM8/DxKHdD670cCBZAsiom5Ogey0nh8Jaobv+E0NHQxDvVGcbnQfxeT48qCEQITcccLTB/DFcY+6bG67bCr0WepkZBHSKYBhcjg0OpEMoXkOE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729120397; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CDKEdyyU+XmoY3MLHY43J+UFi/e5dgEcLdTPDNevPqw=; 
	b=gmRGX5I/OdlXr8eGXebj3qIzxPUs2ZWAzBoeyY/wc8olyuF73FrSNaAenAOKeS7Mn88BTmwOI5heEZ8d0FVM5Qw8pmlN7BoRZIIODAzJ8EPyWDNSwd9S3jZ7nVPlSLcBicmf1bTIXSp5cGpJ400g7bxuhG69SkgEfzRrCQZSeq8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729120397;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CDKEdyyU+XmoY3MLHY43J+UFi/e5dgEcLdTPDNevPqw=;
	b=mb+hBcDyrU/mLAXW3ptn9kZIGtzmCMyDdXEJzqeT+LHXsytk+K2IdKA/s2B64YCw
	d35wme75uT6ktCbBcLiGYkM1um+9iAWhD/NolvBVlGGoy1/89pFj3O1NCOPycnoDvzP
	t5O2eG1v9zAUGLQABvv/ZkZo/i7r5h+ExNOaB5BRlQeZOSD0KNmp8lBFlQGR8L28SvE
	5Lk6RnB29WGhbfyrLq6/+7Vp5QhPpVPy6N1QMYqgkf3JvcpoSB/wmnsdPqpWI7kiizD
	H5O9s1wH/5gG38cArvukG3Qql65ML0AeODX/Vn/6wLanpPxzH1Kw53gTL0UdY3ay578
	PNpcFIW+Ww==
Received: by mx.zohomail.com with SMTPS id 1729120394706502.3949692946112;
	Wed, 16 Oct 2024 16:13:14 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH RESEND 1/2] dt-bindings: arm: sunxi: document RerVision A33-Vstar board
Date: Thu, 17 Oct 2024 07:13:01 +0800
Message-ID: <20241016231302.1042278-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

RerVision A33-Vstar is an evaluation board of their A33-Core1 SoM.

Add its compatible (with the SoM compatible) to the sunxi board DT
binding file.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Resent with Conor's ACK.

 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 4aa15f3668e03..046536d02706f 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -846,6 +846,12 @@ properties:
           - const: allwinner,sun50i-h64
           - const: allwinner,sun50i-a64
 
+      - description: RerVision A33-Vstar (with A33-Core1 SoM)
+        items:
+          - const: rervision,a33-vstar
+          - const: rervision,a33-core1
+          - const: allwinner,sun8i-a33
+
       - description: RerVision H3-DVK
         items:
           - const: rervision,h3-dvk
-- 
2.47.0


