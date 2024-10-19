Return-Path: <linux-kernel+bounces-372585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C159A4AB9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 02:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44811F22AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C801922F4;
	Sat, 19 Oct 2024 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A/gTqk81"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD5329CF6;
	Sat, 19 Oct 2024 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729298604; cv=none; b=CdI4ClV/9pgX0HeHN6m/DTqwTywtrIQjocTnq6lKn97ggLJoURa/VMx0++Wb+I0m6FRdaF3z/EXdfYl7oHhdHPY367sJX75/PLM8VLA5uAILzoRmveE1mLOtwYB5Z+Nj9jVIbAmpTzGGuxn5ZSrdtFEh38LCRltvkg04C5d3AgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729298604; c=relaxed/simple;
	bh=nqf8q4GUqAZCCdp2wBZWAnoftYc47n6AWiSbMm+iR9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UX/9jXm1OCnj6dK3Rmdg0t2iSZ6VsCMXO4xMnt5zCbs4SgyYY+bVIwmHyGbnzc5rouCZTU2FecDnH0sbXqoqpT9NRpXNt+ucKNsM3WbaAzsh+WuCL67opf1h9xxDsDR1hwTEB87cH4qe/1Ffb2a1JCTLVIu88BOruyv7wKp8bS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A/gTqk81; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729298600;
	bh=nqf8q4GUqAZCCdp2wBZWAnoftYc47n6AWiSbMm+iR9U=;
	h=From:Date:Subject:To:Cc:From;
	b=A/gTqk81zv4BjzTzHHkwld7nMQ9bnWiZ6SOhQEKz3gZtlvy9cJKJzJklnlFyPKG3F
	 Mfgd01+FgrIbA5ka1jQlYTvEBdMv1q+yDkktWaQn08ymGAsdubwn031fBCLZG6BrJ5
	 1De2supJN89KEqxJWPeGRe0axbe1WvLZa0c/J9FVxncWrkJsLpn2Cecbmrpgk7w2/8
	 MfXMjrZb/IqvaRSJRkPFXPGsjON5o2t97lEwc3I9DbvUFX9FG6lgZndD++x/Re5tLL
	 9qksKPNZQa8Fd1Grktkhx3VyqT5SHTECEDHUHci3Dl6hD0tPmduJdVnpD3nbzywzLl
	 iQJ4xB6CXPHog==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B8F317E0F6C;
	Sat, 19 Oct 2024 02:43:20 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 19 Oct 2024 03:43:14 +0300
Subject: [PATCH] ASoC: dt-bindings: everest,es8328: Document audio graph
 port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-es8328-doc-port-v1-1-25c1d1b5c65c@collabora.com>
X-B4-Tracking: v=1; b=H4sIAKEAE2cC/x3MywqAIBBA0V+RWTfgo4f2K9EicqzZpGhEEP170
 vIs7n2gUGYqMIoHMl1cOB4VqhGw7suxEbKvBi11q6RySMUabdHHFVPMJyrZd8EaN5B2UKuUKfD
 9H6f5fT8IFNxRYQAAAA==
X-Change-ID: 20241019-es8328-doc-port-1065f8397e29
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 David Yang <yangxiaohua@everest-semi.com>
Cc: Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

The ES8328/ES8388 audio codec is currently used in conjunction with
audio-graph-card to provide an endpoint for binding with the other side
of the audio link.

This is achieved via the 'port' property, which is not supported by the
binding:

  rk3588s-indiedroid-nova.dtb: audio-codec@11: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
    from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#

Document the missing property.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/sound/everest,es8328.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8328.yaml b/Documentation/devicetree/bindings/sound/everest,es8328.yaml
index a0f4670fa38c8435b63566f7383c940b4950caa4..ed18e40dcaacf7eed39fa659795efb1518678379 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8328.yaml
+++ b/Documentation/devicetree/bindings/sound/everest,es8328.yaml
@@ -50,6 +50,10 @@ properties:
   HPVDD-supply:
     description: Regulator providing analog output voltage 3.3V
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - clocks

---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241019-es8328-doc-port-1065f8397e29


