Return-Path: <linux-kernel+bounces-217052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C05B590AA14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EABD1F25F68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D97C193064;
	Mon, 17 Jun 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alDX5D99"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D5194C63;
	Mon, 17 Jun 2024 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617106; cv=none; b=qY9Dh0iwnrWH4APJOg6JUDPg+TTBB4ggNtvNISMs3qR/BihRW2YnIjR+28fZqSB4oYlX5Drx/pK3z0MES6Fa5XJC4V6wbQxFlDNJP+3xtrhxEz/tKQenw0kCze39Uie2cKQ1CqCBwVzZbe0GOyvGJvhR1BY6d44o3iJGSTK/MWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617106; c=relaxed/simple;
	bh=yWJGKp7TUnjWkI+yKdb5oOAuziHvtOUn8hbW128UrP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bO6lJKj0ZMTDUKKbPn5Yps/TTtJjHCsLN2ioV02JjoymyXQ0BMaTS0/otHBZmPDYOQRxdFhKdefw+ulBrSYv8JT/OhjtR2ePDSpXZKhio7+kTRWCvC2DH+Sa8/eHIsx10FzQb9/UWkgGRqbCvyHYKaJoeIzl5VzvesSxuJvA0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alDX5D99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39AA2C4DDF7;
	Mon, 17 Jun 2024 09:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718617105;
	bh=yWJGKp7TUnjWkI+yKdb5oOAuziHvtOUn8hbW128UrP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=alDX5D997VTsSXo/OeKB41JUrrGY88OjFsth96Ua3DCIfYoOJSAMyBN0FK0bIW19Y
	 hcaWBfezJNSHlarMumTKFPDeGH3DsMLj/AouArRRV0e7H9oYPrd5kY6+ZdGMJYO0nH
	 dI+txLhx+EaTrqzSibSftPfrE+klDinf88fAJX4P8bSH4s/Am7pXZsoj4p4h9NzXmN
	 YTV04CN/Gta68XCw+/UuUMJRvlQfelU7/YWzx417/xvSZjynYhhAFIcZ0PgjnIurP0
	 m3e8YPnYCrMdNEmj5Fciyb8CvnqfG1Xvd6Eau325LIL86J2FNxNT9Ih968eHDGQSqr
	 +nRsvratlOoVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E46C2BB85;
	Mon, 17 Jun 2024 09:38:25 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 17 Jun 2024 12:37:01 +0300
Subject: [PATCH v10 27/38] ASoC: dt-bindings: ep93xx: Document Audio Port
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-ep93xx-v10-27-662e640ed811@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
In-Reply-To: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718617100; l=848;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=2DHMH5gyVKrv/Zk+FD8HvqWkgva1cQdPwzXr84HYqOY=;
 b=9/Y2zO6prOhde1GRRjeUr2zqZIwD2QS/u79bqPUyRNxLUYFpjbOyJlbZIzNQyvMp6h0ffN6uz/Q9
 uTw5eUS6CYw0atVF4hcKVtmIXMJYvqkKrAkT4o3b17GrvF2s2Z+S
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



