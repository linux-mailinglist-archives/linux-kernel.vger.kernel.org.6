Return-Path: <linux-kernel+bounces-420155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A06699D75D1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060901659DE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03718B494;
	Sun, 24 Nov 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/9EXr+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC3188015;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732465299; cv=none; b=bpqmrJYyCxSgwaUL8xEnL5+Y1pekGicCyHFLBI4U0qUAQokjfy6e6aQhYz/ymBT3QXLu2segYlzzxiaT95eExSJ5px3hnm65Qzxy7r8B7iyhzEvXg9u+vEN0ndykl58G2QEveTw1N9chZNQ5G0/Y/PpIZm1/6cEV0pF4YnDh1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732465299; c=relaxed/simple;
	bh=6RH/y43YIHSzWQWpbCD/ykLnwAPY271oVr5DpnnOcys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQBzmSOkFfoZhGqBY82LtxejVccz7BhNl7aX7qp8RZREreLbVDQv0wc56BOp+XiKGjwwDU6b090k46iIgsN++JIbgTyJxPkSKWllOCDqEI4M9fCWaKckcQFi5BmwPEvnuQIhODcjYNg2XoNbGqglgHbvy3TORl42vE9uIKenDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/9EXr+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A348C4CED9;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732465298;
	bh=6RH/y43YIHSzWQWpbCD/ykLnwAPY271oVr5DpnnOcys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a/9EXr+760OItw/z9axiI5YsALIKrKi8C887TPk7Z4C8RckRVvsr72PsxITLp8ozU
	 NbTgBmC/reDByIl5ZTvZOQtCIC+akYBoZHR1WtkyOT8wWbzCs05ZM87nAFjdtUBY4o
	 IiaxQ+NpjFSMGlpWHYDEMY5btZq5454I9Wb1tCFpQ9RbdYZYHvP4zxAgDFGa1jiM0D
	 /x3VYquuSTMHSDXQPjb1dMbqDjBMEbM05w/SsNKObATwiarDorooWjAxs8NpjKbq1l
	 WON65dW3GiSj7Y3D36KZ0mQEriEl0fD/pQCGw/yyfGWsOwP8rRIJ25aLerQGZGVmqI
	 YxhS8CZ/owmxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C419D10C10;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Sun, 24 Nov 2024 17:21:37 +0100
Subject: [PATCH v3 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241124-ds2482-add-reg-v3-3-806df39c9454@gmail.com>
References: <20241124-ds2482-add-reg-v3-0-806df39c9454@gmail.com>
In-Reply-To: <20241124-ds2482-add-reg-v3-0-806df39c9454@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732465298; l=696;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=fq/t3WqU49PJQPpZQn6+x14CxqIiQvaPHmtq+9hs7xQ=;
 b=czXOr6foGrY/xLdefjSPCXd/v4Uierfub3DgR5oxzD+uzj/UtPpwDIgHWCCEyblG3rVe8wUmi
 5fOZ5O68/pwAKaUw4JZx9ee0Ca1+pKe8te2168UDq4raUOGvt6xmAgE
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

From: Kryštof Černý <cleverline1mc@gmail.com>

ds2482 has a VCC pin, accepting 2.9-5.5 V.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
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



