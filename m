Return-Path: <linux-kernel+bounces-314859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E7E96BA11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11551F22325
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835381D5CF8;
	Wed,  4 Sep 2024 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="Ad7NrR3Q"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C421CC893;
	Wed,  4 Sep 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448536; cv=none; b=P6UPRIdCxHuZQupg8BVZSDZj5GUtgrR0xh7hQI0fALqYassRu8bcO+P3IlAKSCYhEcmTbolbLv05ZlLEN0qQq7fuw8G8wIDirG7mqXdssu/C24kHIO0dfGO6V8cpTHYDDy0I9hPRx4TGxkWlH7lhe6OjUFZZ7t4zXkVaSQqVBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448536; c=relaxed/simple;
	bh=iJiFUUR6r6XzbjeO1+NulT2TCnusmo0k/pwIcsMy0fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRWasYvSHlXxYTGcyQaZfyb8U0SEMfWQtxZeEZCKsEIROeWfhTi9ENwYlDMxry39a7sbWcdY1sqW3XNixTZHCo2Opy0fpYFfCqfaJgjEMn3hFvOSwxYdWsBkXYZ9CCC8KqS75ZaSKOQa5bBjpAHYTEoQAMDQzssP5qIj6onl8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=Ad7NrR3Q; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.162.211])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 01FA478923;
	Wed,  4 Sep 2024 19:15:31 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 01FA478923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725448532;
	bh=rhj8sVgaAGXTLO1FMWJkRb4+EeFqD5VaEGffMpbzXDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ad7NrR3Q6P/9O9CHRVHn9/xIYA9qINkK+YVP8mKqc+RfZRmFxnFtB1POi0lXubBi9
	 kCd8RIiQ8IefiAUHdvmUu/MkAY48BHGPqzjx1E7uhmvWG+e9Uzcs9V6RwoeCbVX8kr
	 uf6pKYDuB/FmQApk7g9+hbHXxS9sd1wqBP5g19dA=
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
Date: Wed,  4 Sep 2024 19:14:55 +0800
Message-ID: <20240904111456.87089-3-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904111456.87089-1-bigfoot@classfun.cn>
References: <20240904111456.87089-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents Ariaboard Photonicat which is a router based on the
RK3568 SoC.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..b2c83c9b287a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -49,6 +49,11 @@ properties:
               - anbernic,rg-arc-s
           - const: rockchip,rk3566
 
+      - description: Ariaboard Photonicat RK3568
+        items:
+          - const: ariaboard,photonicat
+          - const: rockchip,rk3568
+
       - description: ArmSoM Sige7 board
         items:
           - const: armsom,sige7
-- 
2.46.0


