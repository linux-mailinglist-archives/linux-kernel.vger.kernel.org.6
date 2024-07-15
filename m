Return-Path: <linux-kernel+bounces-252261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319949310BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E057828224E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A3A1862A1;
	Mon, 15 Jul 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0JOZpOS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6018508B;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033961; cv=none; b=Ke11r1jjkOoX0irxu1h9qFNj+0zlb1K6l49FUBNIB6txqQjZPWd588PzlG+hlcLCvyBAv5nwN+F5s1B4hFk4OtG+VYGPPkq9UD9LhlfGVrtlnqHiQYaHxd8yChJPqwfSpqLiMuwfq/iSqhwiR60DZW4WhpznHSz3BiXXxNdvhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033961; c=relaxed/simple;
	bh=LDdV5iZmQZqylIgJ/osRTNrvBIzVQCfS1jrSLC+xklo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFLNM0xSEBsONPTGaM7oe5lJo4p/YEaj33sm0jV8Evs6g4b5EiUDCoa/XuOueDJtBfUCHzM5Hlm1JqfGcg0yI9157FJM58W8Hr0O0a78HtHjOxQOuk2XqRrNWGK8Driy4fZspPkVnv30re39whSsBskhqWJrzVX9OArVaeBQTVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0JOZpOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D9D6C4AF0F;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721033961;
	bh=LDdV5iZmQZqylIgJ/osRTNrvBIzVQCfS1jrSLC+xklo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T0JOZpOS26qka/RgQVUeN73Jeil6A6m+9QScjfmmzkwJR6fmw9xytb6lPYFaCnArm
	 +G9gZwknY9YQzSDjCB/54aIeK6mMOOHLYe7pTeJyh6FusA9+9oVtYDFy7EdSKjA93e
	 MTyFA+c+g3rR5He1z+ckW8gF+ejdR9Ecv/jWZ/GgsQqr6VLXu0Zvm5SeY4EHyhnQQ9
	 erISPYITOGv+JiDdI0mSnKT2acso8OuWd8WMsMoIAydbYk1Cbwz/yxjbLuC+9bRn7C
	 4XKKP8dxTXpZLkDDM5O6wwXEL+6gjam48CHd8ht4l0VB33B11/ViKuERaSVemF/c04
	 OGigfY/5T4ryQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D347C3DA5E;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 15 Jul 2024 16:59:19 +0800
Subject: [PATCH v2 1/6] dt-bindings: arm: amlogic: meson-gx-ao-secure:
 support more SoCs.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-soc_info-v2-1-3836c8cc27a5@amlogic.com>
References: <20240715-soc_info-v2-0-3836c8cc27a5@amlogic.com>
In-Reply-To: <20240715-soc_info-v2-0-3836c8cc27a5@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721033959; l=1215;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=JnJJMZRxCaqyyKyFb5/FDU56hz+XcWAtbQbfxps+Two=;
 b=R7XvE+qSM+fzrD7PJUeJk4zhQ3FJjbtgdSphOmak7wX7g75WfqKiSV9MZNFg9EFKX5uCRppIm
 k6cKatYUS6PA1DkZHCfZ+EKvWAeQOxUI+MH34a3rvaPlTlfEOMzPjfo
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add dt-binding document for ao-secure of Amlogic SoCs(S4,C3,T7,A4).

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
index 7dff32f373cb..b4f6695a6015 100644
--- a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
@@ -25,10 +25,18 @@ select:
 
 properties:
   compatible:
-    items:
-      - const: amlogic,meson-gx-ao-secure
-      - const: syscon
-
+    oneOf:
+      - items:
+          - const: amlogic,meson-gx-ao-secure
+          - const: syscon
+      - items:
+          - enum:
+              - amlogic,a4-ao-secure
+              - amlogic,c3-ao-secure
+              - amlogic,s4-ao-secure
+              - amlogic,t7-ao-secure
+          - const: amlogic,meson-gx-ao-secure
+          - const: syscon
   reg:
     maxItems: 1
 

-- 
2.37.1



