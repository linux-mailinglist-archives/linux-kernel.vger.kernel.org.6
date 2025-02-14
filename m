Return-Path: <linux-kernel+bounces-514242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89390A35490
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B14C16C077
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C7614D2A2;
	Fri, 14 Feb 2025 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ9oiGRa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF11134AB;
	Fri, 14 Feb 2025 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499223; cv=none; b=VHTXXnjFFSDAPXyAaVQRHuw8F6yyFUbTtvOhVun+lSk+yJ3z4CozlL12ME8yaSWYIme56x1qhgOLUx6ZAAoYjq90kl1S8Kp9AR/vYzYqRXjalvlz7Wwdr9+0UhN/bO95UYjuOyjiridwIQwtb1Drgbig4ngcFJuOkYkdSFtxirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499223; c=relaxed/simple;
	bh=LSub8CqtT51oEsBfEsqJC8pxZ3K0fNDMONrc2aB0cWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QRQAEYg6Q4BYfcAon4AtzmPrHr9q/W89EDNmQlOJpEaPR/V5NoTnAHCKfjJcgyq/VBx0iG9dkQEuzIH1eclAG5oEa30tHt+hno1S/i/KJ9tEp62s10xDEOQRGclSG8esqOGUoOE/MZuMyXYpSIzCrXhxdAd2GaJL0Ik3ERj1y+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ9oiGRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60E0DC4CEE6;
	Fri, 14 Feb 2025 02:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739499223;
	bh=LSub8CqtT51oEsBfEsqJC8pxZ3K0fNDMONrc2aB0cWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bQ9oiGRa6vXWIUC8Uk7b/PiGGuvFk7LS17ZhgT3IaLA/EAaL9VRarv8zAqzq8Pydu
	 2VNmJVEBLgwwvN5ADAwbxY71BbXFqtnb365Sx33gY4Ful/Z3ibPMf8AHgjYKeKR9pm
	 ezz7/pFbQQKTer+cT9FLtKU+1IvEWwFdJAaqEQbXqu7pB/3LMCmQtyOSFi+2JQCBFS
	 UkI91lafKeWaC9gC/07rycguqr3R/5I9nBatG0+A/CwErfmsnibdbqZk3vVpHvN/74
	 5ACgyPZwvNsTom4KccF9w+hdSCYEkpI9iqUf/WVVPwXr9ptQ9kWwFrygJGsVYjB2PB
	 +eUB7b2Hw/POQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5036FC021A7;
	Fri, 14 Feb 2025 02:13:43 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Date: Fri, 14 Feb 2025 10:13:41 +0800
Subject: [PATCH v2 2/5] dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-audio_drvier-v2-2-37881fa37c9e@amlogic.com>
References: <20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com>
In-Reply-To: <20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com, 
 jiebing chen <jiebing.chen@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739499221; l=814;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=8OnnUULsGEdY9GdzxZfRzUcuq6+YRMad35rBMkND7OI=;
 b=iVATQz3nlsrKNfdNmI3UNFKCQYbGok4cwuex9n7friBYJiQV3quUPQ+Rddg8QkHgV9QR1gGF/
 y9fUHr7VKXxBAnh53ADeSHASQggTnpJpRiJIjaGFOn9Y1Dop+WwLgNt
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

From: jiebing chen <jiebing.chen@amlogic.com>

add the s4 tocodec compatible

Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
---
 Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
index 23f82bb89750898d20c866015bc2e1a4b0554846..ea669f4359bc81b0f45bc2105c832fc2b11d8441 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - amlogic,sm1-toacodec
+              - amlogic,s4-toacodec
           - const: amlogic,g12a-toacodec
 
   reg:

-- 
2.43.0



