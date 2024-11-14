Return-Path: <linux-kernel+bounces-409187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C367A9C887B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1ED1F24EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0989B1F8F09;
	Thu, 14 Nov 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="ZyW6YcKq";
	dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="by9pYlkv"
Received: from mailout04.agenturserver.de (mailout04.agenturserver.de [185.15.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94C1F7799;
	Thu, 14 Nov 2024 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.15.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582582; cv=none; b=c0fagIz3cXwRRsEn3ChqDrz7u3WLpnVCx2+F0F219WNNKu9+wb4tMQGA4xxL9TMb7RBHv6dEc+tzPXcu+bxsfp1rV1IJBSrgm4NGSDKWYHJQoWyMHwRJqJLwkdGAqlmM9SnTYObTnwKjxl9zNnvk2NyVqsr2pN8E4GZZLXflj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582582; c=relaxed/simple;
	bh=sOIKMyPbWIG0Poeysyr0+AYJjRTNBgvPpZH6foQNaJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qn8Xj0ao43JXjIEGnfo2FR/L6Rl4qEp5M+Gqm5cxx0WOGbyYjUr7l28CxwqKJquHv6L+PlVz5Cvwpf3/8tOcGHqP6VJRvCAGpCZ/b3J99lYTuakTo7aK/n+wJsAIoB+V6VWISj9vlrgatDXPoVlMryWoco485f6YeVbHII3hU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de; spf=pass smtp.mailfrom=merzmedtech.de; dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=ZyW6YcKq; dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=by9pYlkv; arc=none smtp.client-ip=185.15.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merzmedtech.de
Received: from mail03.agenturserver.de (mail03.internal [192.168.51.40])
	by mailout04.agenturserver.de (Postfix) with ESMTP id F18FB6DF9;
	Thu, 14 Nov 2024 12:01:34 +0100 (CET)
Received: from XXX.XXX.XXX.XXX (XXXXX.XX [XXX.XXX.XXX.XXX])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: h.v.raven@merzmedtech.de)
	by mail.agenturserver.de (Postfix) with ESMTPSA id 0BA5561386;
	Thu, 14 Nov 2024 12:01:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver2048; t=1731582094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1r/C7JDOyrIOwKHw39KLfomSLJd9p0Mbsxy76eb7RGI=;
	b=ZyW6YcKqoSmIjQLcDMKmQJX7+Lj74kdIYawGrzAxHE6/sr0Nw9LGXlOoV+95AVcHTLlicH
	R3WfJZlLtCZdUu/iN6IS/icQbLcSeaDQifny2KC/VhoPDOg/GXFrNHWYANnsJay24Ht9O3
	l2q/8Jb7Dqo1oM/4xe714cm/W84B+CTepT7NlBm32Bt9CfeCbCijB8Owk+mvFhcnGYzslL
	vj4yWG2yqlgjvUsx0cZtbJd7eM/Rz0TiEOPcXz7z/8tXPN1AG4nJxGHEyacv9jsollYfR0
	aUpPkuVc88SOqGv8xS4um7TjtynFjIZ5nwZX8fsRwjHSCsoHcirV+Ctea5v2WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver; t=1731582094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1r/C7JDOyrIOwKHw39KLfomSLJd9p0Mbsxy76eb7RGI=;
	b=by9pYlkvTd4sO8D9rkKKiS5DMC96dTPlEeA37+Ia0RN/swvFvyVQXIKGduNWnBrEao1P6m
	0wpHCgX7jF9waPxwM8TOnRmyC7oVB4F/PIZK5pPDcQFqDBPkSDQw7oOr3LRdb3XAObN+Ze
	0OBE384NqiD/orF0+VE5In5POi4tw6U=
From: "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
Date: Thu, 14 Nov 2024 12:01:26 +0100
Subject: [PATCH v2 2/2] ASoC: dt-bindings: simple-mux: add idle-state
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-simple-mux-idle-state-v2-2-a30cb37d2be2@merzmedtech.de>
References: <20241114-simple-mux-idle-state-v2-0-a30cb37d2be2@merzmedtech.de>
In-Reply-To: <20241114-simple-mux-idle-state-v2-0-a30cb37d2be2@merzmedtech.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <aleandre.belloni@bootlin.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401;
 i=h.v.raven@merzmedtech.de; h=from:subject:message-id;
 bh=sOIKMyPbWIG0Poeysyr0+AYJjRTNBgvPpZH6foQNaJk=;
 b=owEBzQIy/ZANAwAKAQP8mG1lSaY7AcsmYgBnNdiMcDABgsb+/G2G3pOUZmMSP2mj5v6uLq8Mk
 y5nKLftdiWJApMEAAEKAH0WIQRfy2xFNGjRY609IOcD/JhtZUmmOwUCZzXYjF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0NUZDQjZDNDUzNDY
 4RDE2M0FEM0QyMEU3MDNGQzk4NkQ2NTQ5QTYzQgAKCRAD/JhtZUmmO/qwD/9zouXzECH6g1oPjm
 vps0H7wpNcRCZr2wi5JAyB9n55k1jFQ8QCqc55li/YKTli5ARGMvORO+LGJfxD4E5o36QDLlyMj
 9FZRBTZraJUWcqEwj1EXOib80tBASgZNzdaF+qK6UR2M39oPkWF56zcDV5GyYQAkpQqN00fEx/p
 OSawB29Rd/feUFtRku836MuFISX0CjxuHJbOx8NKaZJAatDJdearAho21Z7O6g5c7sGX0vCA58S
 WJDrY0UlbzozvoM9baYBeqJFbdhT2NHBqqR4B/qdIn5U6q7IsifN7/Itfuoubm9/W4UGkFIH07B
 eNgoAbj/Kc2rwH1y88UBaUCCy5hRzfdUkAh3ooEM61/FykCY+oEKJttgQTRkpjlcf74axd3fUCs
 xFuZM2OQfhr+z+NOCAWWh2cLFSQCzb1mwWRuyhGnigabgC03paJftuz+VWNjY0/lTn/nBp5PEL3
 wqQe0g6Zg0Q36/w25nuUnM5V4nJ05C1iXWwLM6a9YDxm0D/o5mshAJfkjbf3hRYeszuGETRMHGV
 EIwLuzectoYJazpj4iY4azQQ9kzaWlV7d5QPyFPlMJVBrA3K0fReScjqVhxLR9nkW3hTPPnh+19
 o1NerlBSxkAFQs7nm1Y6kgm54TnC6BDUpvVJDVMVRt7oKQzr1BDOe7/sJhib1KMcy25A==
X-Developer-Key: i=h.v.raven@merzmedtech.de; a=openpgp;
 fpr=7A67B9A9F57B4F324AB6B8EB045B81F5FB5BA3AE
X-purgate-original-type: suspect.url-count
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1403
X-purgate-ID: 155922::1731582094-1D5D8432-FA75ECAB/2/61233497599

simple-mux immediately activates the new output, even when it is powered
down. This can be undesirable in some cases, for example when a
mechanical relais is used.
Adds "idle-state" property from the mux controller to select the output
state to be used when the mux is powered down.

Signed-off-by: Hendrik v. Raven <h.v.raven@merzmedtech.de>
---
Changes in v2:
- No changes
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


