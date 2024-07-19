Return-Path: <linux-kernel+bounces-257067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ACC9374BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EC81C20C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3C078C76;
	Fri, 19 Jul 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEUC92Xt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A11A269;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376492; cv=none; b=WgmobnDw/gHnhBgtwi9xjGk9q7Cdo/emfKGLCEe2luCeNy5H2LdP40G/M5gG5nFSI5OM56aXnouoqO5ZK/8k3yCu5/K+Zzr7PKLRObS908VBJzdVI/8dvtJCILUfD3Zzizm+20xkVWxRe7mtwt/Wnqt00b5gmbyf4b84lMm1rNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376492; c=relaxed/simple;
	bh=3EB5WTUXtz5lawXW+qBeefLxm0XKsLLlzdFFG6e3pxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AXsiXTKgxsRgM6QgWlCJ7iDkCjVuXIsHzhN9RsuBQeK9RMyfaZZRODh2wvpPHCdA0Ae8LifNwyvXZBphm19uH1m3x5MQ9wQ9ccUza8xL8pN+4i+mFsyUlvzZBQH/sZf3XLRgzHnI/qvJHAYYM0lWREcor5bR/i4OMcaLRS6X22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEUC92Xt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25849C4AF0C;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721376492;
	bh=3EB5WTUXtz5lawXW+qBeefLxm0XKsLLlzdFFG6e3pxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NEUC92XtdyzqohamVyUy882BpUbuViaYTpo/FSOqox3H02FmPQwtMiqxlQ7r1BPkr
	 m9IfGbZf4Cxv+BWdFvddxH8TaRqU51oGTYRzjmvVUs7VVM2ulDb+RsqZCALHJYb++g
	 j6jln92wDyKc3pHL86n9LHIr5KLzOtwfffV/gnGrer7ikPR6qdpKYia2BHmBb7eQQ2
	 3ivmBf6YCyQxBcHBpKk8Tv0DbOB3BdoZb057jcbMql2/XiwB8OQVhlTALqlf5nsmb1
	 D1ObHQqLG+SLI0gcLccTttBiL95k7WuDl8OgMKNkrw0M0K6nkmfd3kG5qLcxm6bzGI
	 SvuaOBcTYedBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB3FC3DA70;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 19 Jul 2024 16:08:09 +0800
Subject: [PATCH v3 1/6] dt-bindings: arm: amlogic: meson-gx-ao-secure:
 support more SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-soc_info-v3-1-020a3b687c0c@amlogic.com>
References: <20240719-soc_info-v3-0-020a3b687c0c@amlogic.com>
In-Reply-To: <20240719-soc_info-v3-0-020a3b687c0c@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721376490; l=1263;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=rEHcK7kDOz/ftRyqwGr3Rr5qy1WJIemzIVxERnlZdoA=;
 b=FfZmWKw4yC6wnxyxKyI818xy2bVTST+7yQ4+xM98MMp60iKFVe7ocInoteyPkz6tiqGZpJv8N
 4uIPQykCxl7AbrZ7NJX8VHJHVBnnv7dO2y6B+xaGkSpXODT6mu47faX
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add new compatible for ao-secure of Amlogic SoCs(S4,C3,T7,A4).

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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



