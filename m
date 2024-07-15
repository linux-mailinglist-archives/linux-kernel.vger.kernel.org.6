Return-Path: <linux-kernel+bounces-252232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF55B931059
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AD61F21E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C08A18EA7B;
	Mon, 15 Jul 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS7dP7yC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9371862A6;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032805; cv=none; b=VURdM64WLSOcH2D5PPBL5GCcMag6YrI0o5WSnEUC79RAw+PnDgS2MMef86UFJtO5voSx4smcP5XyMf/L4b4BcmoahQAfQk3Xx6XR4isDD5y2qEwOoX0WStPGr/fgVdpUr7drqkq5X/k287bSYLBcQ9VIBppwaO0gLZNhYdUzDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032805; c=relaxed/simple;
	bh=yWJGKp7TUnjWkI+yKdb5oOAuziHvtOUn8hbW128UrP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7Jxe5FkaxvDdZ/cHRS2RVoPpoAN7BxDmbRSG3gArma5odLh6Kg95zolNCsP8Hvc5Dx6Rt+2DJ1O4uxtdIDgMZTafAq+1XZeFWz6bKnxeh1+1UUr0cwPoULO2eYiUA+fEwZdffB9mMkmZx7OVTrFrwDD8EMizv6VwHucMi984OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS7dP7yC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8954AC4AF18;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032804;
	bh=yWJGKp7TUnjWkI+yKdb5oOAuziHvtOUn8hbW128UrP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gS7dP7yCAu1qt8k0UxxyT6U6nBYZcO95GwKeMOmUNaylTzQlnSZfmOPIBsjVUF+V8
	 ERSeCwTgFIWjbWI8IXC7pjBn3f6gzQRD8JEWlnn1n3oacEPseoyAO//a4nj/DeinJo
	 2yr6+ShEWuAwXVvo4QPl+x9m2K1fyOpMtZpYzTLqf6gzXtWGOqS1zRnaiKp2yMSOXX
	 yvxCbO5Cm4aQ19x37tuWXWRj/U1R5JFqgFmSHWbaWiGWwoxq1QKVV5szlA1uYohy/u
	 vAi6/5FEd6lG9B/gnC3KIizVWyOo9ylH/asAD9FFMAMITAE0x6nAljYMkQ0httiaR6
	 tsJo8g+qx+qyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80427C3DA5A;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 15 Jul 2024 11:38:31 +0300
Subject: [PATCH v11 27/38] ASoC: dt-bindings: ep93xx: Document Audio Port
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-ep93xx-v11-27-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721032799; l=848;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=2DHMH5gyVKrv/Zk+FD8HvqWkgva1cQdPwzXr84HYqOY=;
 b=30JTnlO2w3TIQrNaFZO3fJQCOsuvpaovwzhYnMarApTP3eJpFy91fhzjTgRON5R/PIFB8EaTubZw
 JsdVLxP2DMTrFw4VI1uWxw11ptZQgrwHb0CO+bw7KR8xoKUXR4aG
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Document Audio Graph Port support in binding document.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
index 36a320ddf534..4693e85aed37 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
@@ -50,6 +50,10 @@ properties:
       - const: tx
       - const: rx
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - '#sound-dai-cells'

-- 
2.43.2



