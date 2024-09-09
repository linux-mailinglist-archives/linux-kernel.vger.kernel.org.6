Return-Path: <linux-kernel+bounces-320880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E59711A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618911F21187
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEA01B9B20;
	Mon,  9 Sep 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaDlVS93"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDCE1B2EC8;
	Mon,  9 Sep 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869537; cv=none; b=WsmAfEBo8vHXkOcpiyWcSBINpXhUSZHNnXSsFSp4gMkvi3mpQIWGXbvH0GFZOBNf/vDHNCcIbcjczyyCbK5X03pwrumsU9dsm9S/WIacT61Bo3Bi/MzF/1YTFNAqmKY/k8YmK29H+LHqQ2WmhUQNdUVjqwz0WAjwpkwR0Sri4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869537; c=relaxed/simple;
	bh=yWJGKp7TUnjWkI+yKdb5oOAuziHvtOUn8hbW128UrP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=un08AixKVUGzWbxXJN4rpIOkxtxc9kPrLRQ12dvhhWNi35uwtq2paQolsXbAhIBOb2lN33QMj7gGrihkrAHt9yP1vksj8Kd/1hDG6PbVw6Wnb4XlHoHSviU+uer2wIhA4rV3hLtE5+8OKZjhHSQtOQdIiAmgoemUwboiC6J+cq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaDlVS93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC03EC4AF0E;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725869536;
	bh=yWJGKp7TUnjWkI+yKdb5oOAuziHvtOUn8hbW128UrP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iaDlVS93boozLlk3kzAe6s2mEVynOOEeCHmAmpqRXR+4Wk17ZHczq59m/v2dCTOjB
	 Y1NoManmkkDWt1EMjz4/dZlUYZ6qPzIf3odlg+BE2zx5DHB0bUm6eur+gJwvEsRouT
	 2ONFj/IWXVRbK+Zhu/FB4CHB2Xh/qQUgLeV8CmQ+Iq5jYAjUupoRdtSDnUwdtiVNw3
	 ivoIc1z5qxooy262Ej+nyB7gyy9rd3MAsTeYtgDYw7t8o5xUK24SgNd0IMykgoCpRN
	 gz4iwux2+J3ETAcrXEr1+6GH4X2EKgx6A8RWShJzmfZTh9Ybfm5DTSj9A8hr6OBmVh
	 e4tjGSQQaRqVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5729ECE582;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 09 Sep 2024 11:10:52 +0300
Subject: [PATCH v12 27/38] ASoC: dt-bindings: ep93xx: Document Audio Port
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-ep93xx-v12-27-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
In-Reply-To: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725869532; l=848;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=2DHMH5gyVKrv/Zk+FD8HvqWkgva1cQdPwzXr84HYqOY=;
 b=8MyybBK4d9fIFMpthcZ3b0164irPRX2xnqBW5iudWL6bK+VKaGynnkfxZpMvIUsXChYCBjyouEdT
 TB3jnh75AyrnRDGhADVEUqsUMpf4y39wqGkG4TUEoKeZBAoYGcYG
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



