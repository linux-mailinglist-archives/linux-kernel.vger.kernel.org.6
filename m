Return-Path: <linux-kernel+bounces-560479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E806AA60521
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13CF7ADC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C141F941B;
	Thu, 13 Mar 2025 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a59F3BN1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0641F8BC0;
	Thu, 13 Mar 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741907461; cv=none; b=mn7crtWpYK5F2xfjvi4X1g2yCuBHEsICzoNgMtZkkfELPkw2AsPCnL3wBg2FgTxJkJv+AhKACKg4N32MiNpVGuFGMOLG/uEgiLe4T/XWUTayMR22513yBr6ZF5QPrWfYjvThZWRVtvgWh1kb9wa6jJLq6PLYw0vJ2YcikL2bqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741907461; c=relaxed/simple;
	bh=KS2yDSQRD5SU3vS+jOOmaz2xUBc5Ay1LiOZbJ7uVdFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXBS+SYIfAu8oZCOQyblfWCGPMHEwNSzwd0jza5Y1hfmD/Kefs0CTLTJg19A+vRGgKpv5AramS9BaxyUOcSNu/2335aWWhh+Wz+FWbZZjmz5RFl7zEL31hhg/s+WHyX7dv4SM7jHfw6oSZArDojAViRLqur1+NcAz6G3kvo1jkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a59F3BN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E3B9C4CEEA;
	Thu, 13 Mar 2025 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741907461;
	bh=KS2yDSQRD5SU3vS+jOOmaz2xUBc5Ay1LiOZbJ7uVdFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a59F3BN171SoZoup7W9FWYHJcR8PQGpl6JPxtnoxyZPBNUjWX6rbyR5Zu8vUTs0dL
	 xDTyYTJVxLzo6fJsnxgq8j/xXYfawBkAVLJViLcpnrbQhf+aUieNVKa5WOP8GDtjQJ
	 LdkTVIl6BjSgVU2KZd4c9hx11KNuv232dgdYMm7aQuhT/ZveugX3t7hgO11CMQ2r3e
	 CO+nZkt+tjBBdn04FXZ6ICJHAv8PWgdSMnl5AoFGbCgd0umHu0eMU4hpYxDkAY+Ppc
	 9/7pjZlrHrw7WJkZ99quN7C7gqQLSjvy5OU/bzpzlnTcLFuPqnnte1tObQL+Aqieol
	 Ynoat3pThlyWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15474C35FF1;
	Thu, 13 Mar 2025 23:11:01 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 14 Mar 2025 00:10:59 +0100
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: Add Ugoos AM3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-ugoos-am3-v2-1-422104b0cec5@posteo.net>
References: <20250314-ugoos-am3-v2-0-422104b0cec5@posteo.net>
In-Reply-To: <20250314-ugoos-am3-v2-0-422104b0cec5@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741907460; l=1023;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=5cSMNKg21bi7irPRvrIi1guYYUp67v6kD7IHJg+8xbU=;
 b=S/2RElaFOIwhwBy1p6gnq2FHNtTl0Uwx3R6e3so2rZAQV8z0N2wsMMgJYBCTdflA9hpgYFjTm
 AQ6jHvEW98wCFgHgmzwBOhBDYAHDhGe0ZIp8jON8TyS/urBQ8mzmEyr
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

The Ugoos AM3 is a small set-top box based on the Amlogic S912 SoC.

  https://ugoos.com/ugoos-am3-16g

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- fix vendor name in patch subject
- add Krzysztof's ACK
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 0647851ae1f55a27bfb148252532bcf15ca905bf..779568f158ce985e1d12fbee73418549cfc58705 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -127,6 +127,7 @@ properties:
               - minix,neo-u9h
               - nexbox,a1
               - tronsmart,vega-s96
+              - ugoos,am3
               - videostrong,gxm-kiii-pro
               - wetek,core2
           - const: amlogic,s912

-- 
2.48.0.rc1.219.gb6b6757d772



