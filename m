Return-Path: <linux-kernel+bounces-537957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9E8A492E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D503B9BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489E41DFD8C;
	Fri, 28 Feb 2025 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jhp/EMTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5C1D5AAD;
	Fri, 28 Feb 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729875; cv=none; b=Ii5N4ZwE5VwKfEZkldhqT4/wdPsTrTtr3poBjc2ctHCyJeqqBnpLdGoXSNc4OJJiK+h56l/05/BOyWS0rma+QeznuhHXbBag28V9hK/V8LdS9ahQBYgQfDrLAWQ7DbXv5S01swf5Q4p16yjaCJHHaF3ug8mMsWSw4J6W7JoJjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729875; c=relaxed/simple;
	bh=Ql7EGFG/PFq+6KXj+pWudx+1SnRRrD+fDH+0tiFHkvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqq9gHceGQQaq0FdBQH5NuXgQHt825dRsaZnOtxSyccMqLcyt5V3Lor8KixLH11aEK6dWM8HYKPi8rNNfEpdle6S8Yz9xk7XQSX8RRvPceBnWX0QUf9hvUcgAZrIa3LzRqgxnpmGQnjmRFsVSlD2LaIBf9Pr9Hmr3hPM6MFebQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jhp/EMTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F0D2C4CEEF;
	Fri, 28 Feb 2025 08:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740729875;
	bh=Ql7EGFG/PFq+6KXj+pWudx+1SnRRrD+fDH+0tiFHkvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jhp/EMTqvni2m/xQ/9kA0/Fq9qK4sYg9ceSvfkiPMvBGmIbaXfVfYRMK0XbPfSdQj
	 kXWWKiJvFlmv5qtCgBkctX2jSWZwRQcqRo3NOwfBDryUmFflbEQ9Pr3y9KOodhkFRB
	 zp7uBlEa2repI20zRN4mZaEc3/lkKVHa0OyDeoOtXix6+FKH+t1wQRGedt5Cqkieua
	 mTr3CEjdVVDdmPcU9o0CnzLZPNNCSFX8WEIJqXiSp3geOQ1vTE1G5ZqOtH1xQdgo/t
	 KIxD3JDNkrZjqE/xk/5rPxgbFzCdzx9S3S6RNiejJrciw98qd4awQkksR62uF+87yJ
	 swqoUyejt971w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226CCC282C5;
	Fri, 28 Feb 2025 08:04:35 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Date: Fri, 28 Feb 2025 16:04:11 +0800
Subject: [PATCH v3 3/6] dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-audio_drvier-v3-3-dbfd30507e4c@amlogic.com>
References: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
In-Reply-To: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740729873; l=814;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=yLn4ez8IBN5cqEFPit7mp5UgBhrhZLIZZw6YIL6gw/A=;
 b=Ln4I8fiQnLMfuiMcRK4BwIzEX2oprZoBT81J9aYb4LCt/OOibp8DXvXsERxzUJ2hkE7YS4brs
 WP3M5XyLV3hCFQSRZ8oPumPoEi5QCB9NJtHnRPPuQRCOpvXvy/3gfNI
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

From: jiebing chen <jiebing.chen@amlogic.com>

Add the s4 tocodec compatible

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



