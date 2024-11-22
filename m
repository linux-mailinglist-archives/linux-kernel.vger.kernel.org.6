Return-Path: <linux-kernel+bounces-417968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C29D5B53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5897EB21AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B491CBEB9;
	Fri, 22 Nov 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5/7eM1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EB1BD519;
	Fri, 22 Nov 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265685; cv=none; b=YGS7Iozbbhd049sYlhcq2D6J35hMWWEpn6SPheJMmmDzyL40GC9+nZyXbXoX1qi7Bn+KDowiOX54cr4fQw4fVHRpYoZgz9DkLDBJYgzbGYdrqtxCWBgWTKcVUMG/4OMCs9eeU6Ozp4/adMev2UZB8OI43dVtY8BUy8tj8BQxvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265685; c=relaxed/simple;
	bh=6RH/y43YIHSzWQWpbCD/ykLnwAPY271oVr5DpnnOcys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9mqeUQ1vvEAES3iBbUnll0A+f4aRlwou93IA1uRa/yluyq7+ER1kxl1jMuYhiyYNtDCxUF4R4av3f+9q3bZR26q52tmZthijszhCU01ywVWKmDaMGGXVrsD11FpIlda0kzVaYynfhP0lD8cVDmlv5plxC5rVsZxMxYIfiMjuM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5/7eM1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60274C4CED7;
	Fri, 22 Nov 2024 08:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732265685;
	bh=6RH/y43YIHSzWQWpbCD/ykLnwAPY271oVr5DpnnOcys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T5/7eM1FvRGaZmCofiOtyibcg5jogwF6B8MfOq1aZmsXW10w2ugQYX4hCZPG/tEUa
	 MKBnlj/pxWimOCJqAfwfpjDNgyVtowN+XntQFvG8ggkUTLeC3+IDVH/OgBAtbYxBfd
	 CpRBfBHEcs8Gh8sZlP07q3ENy8GIvqlp2C5D21o5NLxsCEWDALZR+S/+fMX554U/3d
	 Elhsg/UNuQleMEB+WF0nUYaebmGEd8MntBoNZ43TGLdXa/3ESpjAlNLeCcL8zS0/DV
	 aiAM7mFibS5d9dQ91yYH6Z+NA2n+vFxpcvZavdM2/Iy32Q4WugfGaTRSSrYwvuk5Jo
	 rqGZhJ2UXjPrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F4E65D39;
	Fri, 22 Nov 2024 08:54:45 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 22 Nov 2024 09:53:59 +0100
Subject: [PATCH v2 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241122-ds2482-add-reg-v2-3-a5a03ee74da7@gmail.com>
References: <20241122-ds2482-add-reg-v2-0-a5a03ee74da7@gmail.com>
In-Reply-To: <20241122-ds2482-add-reg-v2-0-a5a03ee74da7@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732265684; l=696;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=fq/t3WqU49PJQPpZQn6+x14CxqIiQvaPHmtq+9hs7xQ=;
 b=dBAWTA0O/eR2X7TNdA+AbJgVi/EML/3B5fLsEY9eS3rgvmWGfYBHf4Esgp18AKOjSVLPrsdUx
 GvGY1dmEYbIBoMmeaPEO7U2xERaPWry5Vyilo3Lj1kzbkvz8S1AHkpu
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



