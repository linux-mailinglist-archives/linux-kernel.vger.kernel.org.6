Return-Path: <linux-kernel+bounces-409149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802209C87FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2961F23DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92051F9A90;
	Thu, 14 Nov 2024 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="V/o9xvwC";
	dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="hstPvBvq"
Received: from mailout03.agenturserver.de (mailout03.agenturserver.de [153.92.196.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DED1F80CC;
	Thu, 14 Nov 2024 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.92.196.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581194; cv=none; b=gtgpMjuMXbfTv0t9rnKt6Yan41zAaTS1L3fiQUwMzVzBI5jRjTmtDCWfOgTCb/YKBfRHb46Lg1bvY8dsQ2Z5CPgKZxKi4c9Yzu0MfMR2YQ4Cgdt1yfD4ROjgemWw9/eniOAl0PG1uIQh0Vn0ua0+oaX8c4ukEEmfn/+ejiPYOP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581194; c=relaxed/simple;
	bh=1yKZBsrmbsF6kF5B9YtEPnmfTYTaYvIykPUY7tTIHpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptuz75ycjEkUSb4dktc832jin5I1VpYle2ir3XqbgNEp+/dyBt3bRpIXQR3T7JBXBhfTCWipj1FWYROqI+GBVdrcq80GWH2GQ8NrN/4zyB8tF9uU3LMT2XzsUZkE7Anlq5LV/h5fNAMg8AFNxSkOaFE1rcyZYuyUqKieNcUx+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de; spf=pass smtp.mailfrom=merzmedtech.de; dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=V/o9xvwC; dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=hstPvBvq; arc=none smtp.client-ip=153.92.196.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merzmedtech.de
Received: from mail02.agenturserver.de (mail02.internal [192.168.51.35])
	by mailout03.agenturserver.de (Postfix) with ESMTP id 622685C0D;
	Thu, 14 Nov 2024 11:38:59 +0100 (CET)
Received: from XXX.XXX.XXX.XXX (XXXXX.XX [XXX.XXX.XXX.XXX])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: h.v.raven@merzmedtech.de)
	by mail.agenturserver.de (Postfix) with ESMTPSA id D8562A11D2;
	Thu, 14 Nov 2024 11:38:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver2048; t=1731580739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfv3j2YG3Vwz9KlYvvd33JzAfbZu2GDlSoP2XF8fHuk=;
	b=V/o9xvwCWbSpoMH3b1BbX1wcybIcLlh+9OSYlPI9ldwlMI7ua88m6fzvjx0/B2YEXkFIrr
	MCFEbHA0z0HU13sgU+47Ndk/TJzUCfdgNq5bRuNqEMAl1lySzdTPGTThV4gabdvoV7VaoJ
	74CVzJuL2H8uCWjs7gzCrba6Gue3wzM6ZICDdqSNgbQJYKwlNMkAEyBxUVnYkE/0tux5ig
	aWXBUKugd5nuLYex2t8l00Fjf+cjLLSw/R6AN17EK9xpmElbmFNa5/Tsg6A+t1h6kMGR9M
	Dj5ki7P8PYGjn/9ZbaLW9I5+8zBE53Dy36/5nI3OeiTcsu7oGRnWBn/YFePCwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver; t=1731580739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfv3j2YG3Vwz9KlYvvd33JzAfbZu2GDlSoP2XF8fHuk=;
	b=hstPvBvq4LwyHOexcMBhX2Gp+3jY+NRfJLHI7nMyHoctnEqNRwi6A91LiAn+uqIWXQj+8f
	NAwES2jwonOpP1ZMwg+Fzi6muFXGteC/W4PfsVYkq4HMpSSasZXnxZQOnnCSe4NlspN8vj
	FHmxn8LQJhXoFwil7sBnOX0RAfWlZ5s=
From: "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
Date: Thu, 14 Nov 2024 11:38:39 +0100
Subject: [PATCH 2/2] ASoC: dt-bindings: simple-mux: add idle-state property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-simple-mux-idle-state-v1-2-0b082dd6549b@merzmedtech.de>
References: <20241114-simple-mux-idle-state-v1-0-0b082dd6549b@merzmedtech.de>
In-Reply-To: <20241114-simple-mux-idle-state-v1-0-0b082dd6549b@merzmedtech.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <aleandre.belloni@bootlin.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366;
 i=h.v.raven@merzmedtech.de; h=from:subject:message-id;
 bh=1yKZBsrmbsF6kF5B9YtEPnmfTYTaYvIykPUY7tTIHpA=;
 b=owEBzQIy/ZANAwAKAQP8mG1lSaY7AcsmYgBnNdNBa86yUOPT9tJFc0YnHgTRBA9wJzjnihiYu
 WtGpP4yKgGJApMEAAEKAH0WIQRfy2xFNGjRY609IOcD/JhtZUmmOwUCZzXTQV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0NUZDQjZDNDUzNDY
 4RDE2M0FEM0QyMEU3MDNGQzk4NkQ2NTQ5QTYzQgAKCRAD/JhtZUmmO9vRD/93OSQzK0gDCjcQas
 gQcO7FeibYKWBTT214napppTj2KEf7q2H+f1dycgkYNQQcCkMi35Wrm34DOO2ydl1j0XDJUcFGn
 NFUmPBjoFvsHjGMec+hHiS/Qk8CQPvsVpiTjAajNn/ihXgLxHq30iIdpA3FA73IHJmRbH/9zYpE
 XmxpVapogYQDwg+mCQK30RO5MJv9WXlOn0JDFLm6Eu0rs3GDmUDxkPMfWfWJX3uZXrkV5parPdy
 7HeH3m641jRpOW6GnUUp4WYq2mUzHvGn0RDT1AgueUgS01m5GQRL4f79Af1rl/8Jz7YxWSw6ssA
 E2s6u9CaA8NBXPE1DJI7/fiWF9p1FgN4D4aGkpjTp30CT5dMJ+BBevxVVlAz1EHvOL2YARhdSGz
 OrH/4GmUdG6Yg2d+CiWQL0wSJKuInZMiAGDV+aGDDl1g0v02OiYtRVnO8xIAfSWX0/nmS0xgmFW
 o5mpb+EjYlcUTRx0UPH6A60HEWd3lcJOkYeG+liQUjSYPkgRjh8+rI1XRUEQrskVYZqJh3R47g+
 PJ9gAIEQ+cVKpbPygmr80fg/OE0ZoEFTWjU66HbBinlcSgm6NxjKS9PuBX3/YZAATZwlliickpu
 aPJpeIloTQD6UctOPkqaudKPQKHw/a3UKLNYa7d88LjzBJRt3BmpphVsI0deIzx6axfg==
X-Developer-Key: i=h.v.raven@merzmedtech.de; a=openpgp;
 fpr=7A67B9A9F57B4F324AB6B8EB045B81F5FB5BA3AE
X-purgate-original-type: clean
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1368
X-purgate-ID: 155922::1731580739-D8CA1432-45DBD76D/0/0

simple-mux immediately activates the new output, even when it is powered
down. This can be undesirable in some cases, for example when a
mechanical relais is used.
Adds "idle-state" property from the mux controller to select the output
state to be used when the mux is powered down.

Signed-off-by: Hendrik v. Raven <h.v.raven@merzmedtech.de>
---
 Documentation/devicetree/bindings/sound/simple-audio-mux.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
index 194ac1d4f4f5f40a9bc44e8cd0acbf2eab708365..9b1bda4852e160618ffd349d2f7c90645d5b3e03 100644
--- a/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
@@ -29,6 +29,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/string-array
     maxItems: 2
 
+  idle-state:
+    description: If present specifies the state when the mux is powered down
+    $ref: /schemas/mux/mux-controller.yaml#/properties/idle-state
+
   sound-name-prefix: true
 
 required:
@@ -43,4 +47,5 @@ examples:
         compatible = "simple-audio-mux";
         mux-gpios = <&gpio 3 0>;
         state-labels = "Label_A", "Label_B";
+        idle-state = <0>;
     };

-- 
2.47.0


