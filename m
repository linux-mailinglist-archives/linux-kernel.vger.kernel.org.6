Return-Path: <linux-kernel+bounces-425416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6079DC1D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66425165960
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B022197A67;
	Fri, 29 Nov 2024 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiN5Z6kQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E647818A6DB;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874182; cv=none; b=BmJK1RDFYAs7px+8omrNXFNMPsgsX1tZQCEBcFIWXcAUb64Fhvvs8mXs1qK6L+6gZ91R09MTg5OMCMpn3ufxr6nJ4LjS23Khk7Yo+6tLXQMqR/yIB6Bsy8TF0iRcrAgYIwwfP7HRLMsgm8iSwU1B1WgUB9oBRUeTPZYF4fteZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874182; c=relaxed/simple;
	bh=1YvxV8C4GkKt1E6xAgYL7xkTCqRPwy3DRHYl12fL4dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWBDdSwJg/S4r8mXH6sS12I4i2GCRV28dd8JSShfEb0k4Pv199wHqeWGG4B3eQO/A24brP9erIRE4WWb5a3weTIL4HdS9SrlIv3QXJmogkewNKRfhJc1Whahkee1gRY8uJw/+8bfeAjYdpQ7Qv26Ui8beYtm+RvswGKuIb1gE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiN5Z6kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81C5AC4CECF;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732874181;
	bh=1YvxV8C4GkKt1E6xAgYL7xkTCqRPwy3DRHYl12fL4dI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BiN5Z6kQDOEMTQU8KWnLqNG6CB1GRDFBzzpVSK6/DG8N5OWl6AkND2zoUdOVYcdNS
	 lBwiG4Ip8pR1xrz9NP/Hzr3C/NcxCSSzzRc0LTgmFEdedyFyQErYe6sDYr3d1tGBn3
	 HcJF63VkxNDf0q/nh7UFv/YHuiXT0aey3ACN3M4xd/RBOjnBjmi6ThSk02A/dYcsCo
	 ImRUR5mqm+TxCUqKI4ltuTMa2+ICVYljjcVCNhpxfgYvI0NNdREUdDoetC6IQcOVRn
	 alARurXyn1xDugkHhXg8Ro6J8hCbaYuMdXmbKC67KeGkL0Z6/TLU0dtZKfsPRqRQgv
	 lc46oOwwFdixg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEEBD6EBF4;
	Fri, 29 Nov 2024 09:56:21 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 29 Nov 2024 10:53:16 +0100
Subject: [PATCH v5 1/4] dt-bindings: w1: ds2482: Add vcc-supply property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241129-ds2482-add-reg-v5-1-af8e83d41344@gmail.com>
References: <20241129-ds2482-add-reg-v5-0-af8e83d41344@gmail.com>
In-Reply-To: <20241129-ds2482-add-reg-v5-0-af8e83d41344@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732874180; l=796;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=WhOk1GuCMyF4Uqf/5Sr9VOiQAo2chWTloYZnv0gVBic=;
 b=WC9V7QwlQnfJ2et7H0gmoJCWIRcKCkev7yxGz3F95kNu4L190ZfJr50c/zN6I3kgROm8dgmsf
 SykRZuPd4zVDF/zQ1KIPQR+LElnStnwRyhZuoMCPx1ixf4VUYaRtUNW
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



