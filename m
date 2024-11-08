Return-Path: <linux-kernel+bounces-400978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5546E9C149A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4291F213A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89077194C69;
	Fri,  8 Nov 2024 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="ZmTEsfrt"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA8112C499;
	Fri,  8 Nov 2024 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731036309; cv=none; b=eDMWo/9lOJkvfVcrmGnbvYuxXDucmaWyqQJ8b34s79fvEOkPsc9DrOXwSQCFgFN6qjw0iYeofwsjmBuhqseeaxOIjzBFqG3xVEkMzQGHiyTwdwvFow0J30HUxCIP3052LjWgQsJR7gUMhNfUakLQxoYB+28SQV+jcqtatLl+Jq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731036309; c=relaxed/simple;
	bh=EUAFm+q8R02D1MaeFtFtbopcDftvXEo22myrQVGgRd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iyo579kmr47VHYacKuQ08YYQlmibSIZfJKxPWjpSFLQJDKzgKye6KytExNUW1XgaLBoACB61iu50mKH+tyGBwR1SQHMLmIbQNg1FFKuh05+68lYlJ5CXD+rBIQ80qPu0bjrM0ALHVBqD1k4WWTP0/sFdqLl2vWU7yjAHz8hAMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=ZmTEsfrt; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.160.23])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 575A178916;
	Fri,  8 Nov 2024 11:19:02 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 575A178916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1731035943;
	bh=dQP8Y8gCRO39Dr51y0JWnPu5CMHKF0ukyLE8PoZMioM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmTEsfrtvbBbghv9edSx0MkjI/YBhaPH4+fhk9LNJrpINBMyRkVyRcYmHvXps4Sse
	 i+wXk1Udb0qjN7LTIdFtTTYRjmWI5fz3XNj6HEeTsdKWYCWBaFs174dkTfH4cI5FOc
	 WYOpXcUULVXwFo3XJieyIc/UafwuPReiekOb3Qpw=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
Date: Fri,  8 Nov 2024 11:18:46 +0800
Message-ID: <20241108031847.700606-3-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108031847.700606-1-bigfoot@classfun.cn>
References: <20241108031847.700606-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents Ariaboard Photonicat which is a router based on RK3568 SoC.

Link: https://ariaboard.com/
Link: https://photonicat.com/

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 687823e58c22..28408e08b374 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -49,6 +49,11 @@ properties:
               - anbernic,rg-arc-s
           - const: rockchip,rk3566
 
+      - description: Ariaboard Photonicat
+        items:
+          - const: ariaboard,photonicat
+          - const: rockchip,rk3568
+
       - description: ArmSoM Sige7 board
         items:
           - const: armsom,sige7
-- 
2.47.0


