Return-Path: <linux-kernel+bounces-240179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8309269F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE201C22734
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA441946DF;
	Wed,  3 Jul 2024 21:05:47 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408181891DE;
	Wed,  3 Jul 2024 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040747; cv=none; b=EU1GVoHUi12eEWbv9qb+vbqMP8V/UfolasTAwCCzT1Z3EwpCNU223g+pNcVQo/6lEKrppQk76qdV3z+4CJlkXYcpB/McjoBPNl+/7vED6qojAL4SnEl5fKtF7Qj1e5tEOq1A2trxSYyKEGd04/AAZat7o6Oo41rcSbLD7Sart4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040747; c=relaxed/simple;
	bh=UJ4SomrNAifkC+H2I5nHG1qfFCc+yDmbMiV4O2CtnUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J20Y6Z+LPf3T5MU+2bgVbv5JCH7sNgNOKMKlSvM/wvV2yqRsslBMP1vsrvK8bTIGVpGpK1EtSi1zs69AkZZyAsbi90fop7GneZFSLZQeL/Ib21WKtmIu/Kszq0mQqMiDeDpi90sBJDvtBgfVKI8u2KZ8Y1F2sgNNLZcH3xvNyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sP7AR-0000bE-Um; Wed, 03 Jul 2024 23:05:32 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add Rock 5 ITX board
Date: Wed,  3 Jul 2024 23:05:23 +0200
Message-Id: <20240703210524.776455-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703210524.776455-1-heiko@sntech.de>
References: <20240703210524.776455-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding for the Rock 5 ITX board, build around the rk3588.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index d2e887415d5dc..7ddb008f52d1a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -826,6 +826,11 @@ properties:
           - const: radxa,rock-5b
           - const: rockchip,rk3588
 
+      - description: Radxa ROCK 5ITX
+        items:
+          - const: radxa,rock-5itx
+          - const: rockchip,rk3588
+
       - description: Radxa ROCK S0
         items:
           - const: radxa,rock-s0
-- 
2.39.2


