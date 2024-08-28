Return-Path: <linux-kernel+bounces-304564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284FE9621DE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F931F233F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F8F15C122;
	Wed, 28 Aug 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="vw9qPjav"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EFD15853A;
	Wed, 28 Aug 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831817; cv=none; b=N63kjPba7wU1/9UGwLjpcd/oAD7xpi0lFMi9gNt3LCwsR48rL0dBKF/Mgpv/Z8aFVZgsFDJGMRu7IeUMeRgdNZE1T0MX8AyorhKu0nCuxucvGMpz5+x6m+3YjeRe347Sn01h2VUUdjEAqbfxAlQKJVxxf/TLNExdkdUcpcN5qQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831817; c=relaxed/simple;
	bh=iCWomby8+xSsS4Igpf/cDPEhBdObvXe6mqI/WxHe0eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuhefVndKKRdIVCczJEu6zSvT6jhO1RbJF9pSXvNc3Zu7PJ0oc0jK2nqvIxcrqwkJB97Pi9SQjhhE2Ze9oMIsVWiPiczjFXZAQipNcco4LtDAt1Ad+1OFDb+hqAfIo4dPTZz9Oim3jWRvpdmpybWu3cwVGTJGAv4ScjhWdrcEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=vw9qPjav; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2CCBBFB4D;
	Wed, 28 Aug 2024 09:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1724831312; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=DvgDIM/6H/fMQJqK3ZP97pGfOFk/+VHN2TzlDnkzWJ8=;
	b=vw9qPjavhuc35hOuiB9Sk00GFLUsXDf7Ab2H4CnUx4KCcyooPpmo7yh3XKZba6PdP9xX6R
	JnzSSCeSaw2y2DlHkZvGcDg3sKDlShqcVXOk4ycQSpH4j3eTXRYJOUPcTmhGYEJrA/yIrg
	+rIeq2fUjBeGibOEvsJdIenRTjHbQ5g6bsqSvmYzNSP/9nSvm7ZDM3gYrZ/Am/s/GpiO/G
	g/KLFk6HCvtQLB1Fe71xPT8ADa2z6IjCV6mdtD1TLrEOx2AYcGD1AHswF1nnbPVq1wMUzh
	fErldOtJ/DLSkZpP68n1+htWnBtbVH5Jc6+GzvEZXEZKHOQ34Cj0pacYh0z4lA==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add Jenson Display
Date: Wed, 28 Aug 2024 09:46:53 +0200
Message-ID: <20240828074753.25401-2-frieder@fris.de>
In-Reply-To: <20240828074753.25401-1-frieder@fris.de>
References: <20240828074753.25401-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add vendor prefix for manufacturer Jenson Display (http://jensondisplay.com).

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* Add link to commit message
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc03..2b483eb5e364c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -750,6 +750,8 @@ patternProperties:
     description: Japan Display Inc.
   "^jedec,.*":
     description: JEDEC Solid State Technology Association
+  "^jenson,.*":
+    description: Jenson Display Co. Ltd.
   "^jesurun,.*":
     description: Shenzhen Jesurun Electronics Business Dept.
   "^jethome,.*":
-- 
2.46.0


