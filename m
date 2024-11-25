Return-Path: <linux-kernel+bounces-421701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB4F9D8EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713A9284B93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686891CEE8A;
	Mon, 25 Nov 2024 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVzBC1Xp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094916EB4C;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574913; cv=none; b=l5fmsakyj/YG12XiYSu04ZL+AgNWXERp/2vceCmlicIZYMaDmB4wVFC/oORMNFawRT2qgrma5BwNf2IQ5gXKZtZ93EMk9D4jR9771Ez+ABW7CnXsElJFPuXT3joS8tEUj5fRuYIToS9QEorNIXECYM9XzYGD+vZJm+HQ8+aC9l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574913; c=relaxed/simple;
	bh=1YvxV8C4GkKt1E6xAgYL7xkTCqRPwy3DRHYl12fL4dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UBT97MvDB3guz0Oj8msXzTky9hWIDGWFzLPBj5rTFq6LkgfdV2CuR/pORSoWEpnM/BxPYbyMrtnRsGyuCk4b+soZO9JusUgdKUdCtaQcNpm4KUmwbLnA5KahHRCSYoVp6YLq7Whie+zFeEBHOpn8RKLm6up7igwENrHTRKqSBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVzBC1Xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7008EC4CED2;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732574913;
	bh=1YvxV8C4GkKt1E6xAgYL7xkTCqRPwy3DRHYl12fL4dI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IVzBC1XpwCvbhtnrTMj+xdAI4nZuiMTM/hB2QL7klazQDRDPBsEKBQgDsTHQFAzvL
	 1pFoR+w6XqhB7LoJgBwFs4908OODXXPTybe3Jj5p4FsjsgNjZk9+ESrUF2pUmwrpNE
	 vUzBVL6Jjlx1wyqkx605EZf0V1jKOBd6UQ3XQ3JR5AetoqzhSqW4fVEl1KIUTShp8/
	 yFNb3UO8iUjP9tYEj85Xnt3GcFIy9us0bS1bZTmExs8d/GLznuyBMLD4yTQXCvXC9Z
	 ZpfrjTqg9soNFdzXKlAqAVEgMx+8o6macdDkVODrSpmluwL+10dk0OzRP3Z1C8zhbd
	 hmGWc+Rjpcmvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C1CD59D80;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Mon, 25 Nov 2024 23:47:18 +0100
Subject: [PATCH v4 1/3] dt-bindings: w1: ds2482: Add vcc-supply property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241125-ds2482-add-reg-v4-1-475a7a08df96@gmail.com>
References: <20241125-ds2482-add-reg-v4-0-475a7a08df96@gmail.com>
In-Reply-To: <20241125-ds2482-add-reg-v4-0-475a7a08df96@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732574911; l=796;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=WhOk1GuCMyF4Uqf/5Sr9VOiQAo2chWTloYZnv0gVBic=;
 b=Mt0KSI5VQmxEkYJyd8KMircjnZuR1rnRl422s8YGfgHGL+Ovv5LmXtQg/tf4DB0L965lnLizP
 fis4uIHSCgNBSYIZJp5MgSD1nOXviUd8ZS0Tpcgs0VlcZ27MobjYgrN
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

From: Kryštof Černý <cleverline1mc@gmail.com>

ds2482 has a VCC pin, accepting 2.9-5.5 V.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/w1/maxim,ds2482.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
index 422becc6e1fa8d58665c5586ebdc611cd0b2c760..fe6b3f9a3f8bbd00366c3e36aad3ffa72ec1a31f 100644
--- a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
+++ b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
@@ -25,6 +25,8 @@ properties:
   reg:
     maxItems: 1
 
+  vcc-supply: true
+
 required:
   - compatible
   - reg

-- 
2.39.5



