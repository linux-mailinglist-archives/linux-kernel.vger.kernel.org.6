Return-Path: <linux-kernel+bounces-553126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F4BA5842F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C8C7A523F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC41DBB3A;
	Sun,  9 Mar 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm2b6Dhj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037F2628C;
	Sun,  9 Mar 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526186; cv=none; b=jRjNKXSNUJwkJ7K32Lm+Uy2Sq4eNC5pffJNnYpgVstpy4iJIXbofUus40l7Z2QCECItbNqTlKPmPyE7eV9B9d1iey40216CszLyv0hDKgjXOUMQaXL+vFQuFKtqHuiitXfH40ZAcTPJ2jsBjlH3egHL+D/wSHOOWebvuNGhrklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526186; c=relaxed/simple;
	bh=PoF8AvGS4wt5+cR37V0qaAD2Fcupg7Px2u0q9M3aolg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BKGSeMym1mUXhV1fgg1iLmoSdcNkVKaQckWHVMToyO/a04Rw4+x+GJxwxW425DmVgLTuSn/tzs0Iiv2SXi0aa0elbdPmi4w1BEWg2uKlos2htN50HB6d3MWLdgPSChsXS3I2+JOGOohtZand6dIkkwUIv4hwAzBQiFvFyePZcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm2b6Dhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 715BDC4CEE5;
	Sun,  9 Mar 2025 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741526185;
	bh=PoF8AvGS4wt5+cR37V0qaAD2Fcupg7Px2u0q9M3aolg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dm2b6DhjwyWpdZ36SDGlonr6xvckWaUBh0BCVRppKwuI1jaVzfSxd2GaRKCdw3Sqw
	 +fa9YwsdY42lY8fT5SW7/LUbeJ5CafICKhNlKlR3g7wAxHlk10WoLH1w1bB/VxNow0
	 zRPZaJxms9za9ikLeHkVeTQgptw445CdIuTlkyaSjCUUHyEF+JJgFuGcL4ihBL24Jp
	 0ZT4Eu7viAnlIs1BrwGjPA56sfSfe6DKnwK4h/J8lvEl3NjPYwXL4fY2bJZiXwK0bd
	 R7e1hRP2JIvzdDIZgxghUiVgm1syMtiWG7ODmjf+A1ntfjDNMTKbBxSjleNfK0uA4U
	 Gv6+TbQBC4/Eg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58638C28B30;
	Sun,  9 Mar 2025 13:16:25 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 09 Mar 2025 14:16:20 +0100
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: Add Ogoos AM3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250309-ugoos-am3-v1-1-38cab5a4725b@posteo.net>
References: <20250309-ugoos-am3-v1-0-38cab5a4725b@posteo.net>
In-Reply-To: <20250309-ugoos-am3-v1-0-38cab5a4725b@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741526184; l=888;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=cqqIMQAjsp7Lgq4pj0jk6mh06cp/exYekgA28kwLzGU=;
 b=MQdcbQ2DByDgPVBjz4/nCnfDMhGmDOXtL9cjBlqd/eSMIt6t2TQd3pYRCHyLK2iNWWYrpO+kI
 EHtBqcvSJfVAnhfzDFzxTwEEF+ptaGvBd6jxsVOa1Y/4QUCAeLFM1zN
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

The Ugoos AM3 is a small set-top box based on the Amlogic S912 SoC.

  https://ugoos.com/ugoos-am3-16g

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
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



