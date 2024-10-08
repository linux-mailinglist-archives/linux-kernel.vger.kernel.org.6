Return-Path: <linux-kernel+bounces-355437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A1E995241
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CFC1C22533
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A20A1E0080;
	Tue,  8 Oct 2024 14:46:49 +0000 (UTC)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080AC1E00B0;
	Tue,  8 Oct 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398808; cv=none; b=jwczSQp4aUfEUT8qS87atuqrIMSWMmOKTp5TsMMsnGZLIcWnS9ccBwmU+MnRTCYu9dK37vAxvTALWldP55Iss3tTqARRX6ZbU7bkUP5gvOCNjjCSMU/EOlN4QONYcuz22IcfQm6VAUwqSDio5RyDDlk1T+IzT0pd7S0AxAEQ6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398808; c=relaxed/simple;
	bh=kT3NhxvfHxuqPkC4RI3HFR331tknzG2lE1lDQioM8FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTNGolJi/a6r2/ijkqsTPvYjc73zFBHrSBZzAroRTND1xKvcXzibjpvxpluW22keEN0w+fonI4HXXHoOyqZF71SEE0yQcgmXMZPdR+/qtwBWyOI7HKwm6ag171z3BeLIdeMvxBKUtu4lWdpMZtN5iXIR7DyL9Zi9ii65D7qP2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68F52BFB3E;
	Tue,  8 Oct 2024 16:38:38 +0200 (CEST)
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH v3 1/4] dt-bindings: vendor-prefixes: Add Jenson Display
Date: Tue,  8 Oct 2024 16:37:43 +0200
Message-ID: <20241008143804.126795-2-frieder@fris.de>
In-Reply-To: <20241008143804.126795-1-frieder@fris.de>
References: <20241008143804.126795-1-frieder@fris.de>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v3:
* Add A-b tag from Krzysztof (thanks!)

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


