Return-Path: <linux-kernel+bounces-410850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 711349CE64A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248E71F216DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797F1D514D;
	Fri, 15 Nov 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQJAdcf2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103161D4339;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682737; cv=none; b=LLACLrzDgLSgP+/V/blxIqxk22o01VL5H5CcFriP27oSW9YU1smEh2db9zvclNjh7vJ+iJYgz048Bv+O5LnWC6LktR7Gq4sXf3IjXMVw/KJc5rPjLTKKIwasOSrlBqHn1ZbDzGet9rQ3bYIKoQCnBCfVA8Elk48HCmiMBx7S/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682737; c=relaxed/simple;
	bh=wWL9XhOTeOyRzFVFxjGXg2m2x4739+IAAx+ijemyDe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NhADxaKS7wzEF7mKj0Vi+We/3LxhGtsi752sOLrOULNJE3slSKnQnX4y6YeW3PJFzTGOEfDtuMm9Aa8utEUcK0JQK0rsLi30w+3uI26MBTXZ0qrfvBnIBjaN/l8m2QNEyyjXXl/XRgQqClPEHbpnbvpbxH2dVaAnzeowFTc2EwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQJAdcf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB74FC4CED9;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731682736;
	bh=wWL9XhOTeOyRzFVFxjGXg2m2x4739+IAAx+ijemyDe0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jQJAdcf2qAjiEBeNAcKVMFOa9OAuAO0bVTstX4ughhISy9u8MCHaXU6UJWH7cuZUZ
	 F5WbGsY3n15OMA3xBoI2TrI8c/Hiu8zEBK6yahtfSKDwSJWDTaVpVeCFYM8HpNJnYq
	 ztMgXG7ER0qENq2buwJa04aG4iKj4l/8l6LVamRkgSqxBAT4EoX/6jAAWfsMe7AAdW
	 5o0dI3o3N4a8D6RB3BFqYS/MVg4s1v6+eH2788t9ZzJxZrUGaD8mE4QwbKOYO5uw4x
	 0aPWjPOGhr4fVY9RSKJ7mnKXx8uqi2hNsESdAXZ9meiNI7GLiylt/+gvgP3ESnyrTM
	 EyceZGdEz0OPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA1D68BC8;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 15 Nov 2024 15:58:06 +0100
Subject: [PATCH 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241115-ds2482-add-reg-v1-3-cc84b9aba126@gmail.com>
References: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
In-Reply-To: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731682735; l=781;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=UCNjIrPX7cETnGBQGIv8oPibmNQ+Ah/w0u0cd9E5Xfw=;
 b=fnkTpsmCVfDQgbR4yJ50Yo8UWgWnRZrm+QvcKqLoMy+VNV0jyThRFwjYkNxO3TCPTqmMwIoim
 OST8Plmv159D68kesgnzORJvorsWkIkAFvDssk9upp22e2KDYRuDseX
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

From: Kryštof Černý <cleverline1mc@gmail.com>

Adds the newly added vcc-supply property to bindings.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 Documentation/devicetree/bindings/w1/maxim,ds2482.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
index 422becc6e1fa8d58665c5586ebdc611cd0b2c760..a6b9e0658ec858cb24b21cf64443a061bb43e4ef 100644
--- a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
+++ b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
@@ -25,6 +25,9 @@ properties:
   reg:
     maxItems: 1
 
+  vcc-supply:
+    description: phandle of the regulator that provides the supply voltage.
+
 required:
   - compatible
   - reg

-- 
2.39.5



