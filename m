Return-Path: <linux-kernel+bounces-567401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B29A68586
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B64179B55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55515250C0D;
	Wed, 19 Mar 2025 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9VlyrM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E124EF9D;
	Wed, 19 Mar 2025 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368000; cv=none; b=PPIWMhAUXcYmrUdvupMjAa3FI5+GznEnQxofuaU+XPo8pruteTcNYQgEGMn/ln2/8wtr3KVslkb8TZZ056NAomzCwnpUSgpUzGxLUFndBoaYlT6FRAGUPWSJK3xXdNmcJqqKH5/JJDjMYrF4ZY7PjjfXXoK95MrHQv+yaKdIZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368000; c=relaxed/simple;
	bh=Ql7EGFG/PFq+6KXj+pWudx+1SnRRrD+fDH+0tiFHkvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LltvObqsTE9qihwcSMUWcSlVfM7rdkduftsOiIW8YCKi3533/rrHhkQVshqyYjBP5PHQrpEgy18+sYhdiDuk8Hwqq07/vOWnJdlg1e2vN3bjbWPfa4RbggF9uEdC+E7XTvrlt+sUZb3z4yOiQKIaELiDKyDnfUIN2H+Cn5fKPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9VlyrM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 377F0C4CEF4;
	Wed, 19 Mar 2025 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742368000;
	bh=Ql7EGFG/PFq+6KXj+pWudx+1SnRRrD+fDH+0tiFHkvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T9VlyrM6zrC89fBozqu6SZhSM+3S7h/yvFu8sdWdgeRPNHAZOfI59PTEx2IGswF97
	 gZvDwdynE7L++XgWJPWRtRGf5tDsDE9WxIdTP83lLusnVRNVwnmSoMaM61B2iUeNcq
	 OkqtJF4wJhqh0Mh/C0RiZNotl0Rlz7JxNHz+MCAW8LSHmr9+nyXSMOLe2YvnPqsU2V
	 jH7S0Bm2PfXM0eLf3iwA3BuRE+iuQkA2Cxyiw6nuIEalsYL5PEjmobNQwsTQsxB9VZ
	 wdXJ1O4dBmZT/LN3hv/zixroxrr3zOLLCEclIfij3+U7ZT3c1fM3gkQNb0Lh8KPepH
	 Xb5lMHdXT+a9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26306C35FFF;
	Wed, 19 Mar 2025 07:06:40 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Date: Wed, 19 Mar 2025 15:04:46 +0800
Subject: [PATCH v4 3/6] dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-audio_drvier-v4-3-686867fad719@amlogic.com>
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
In-Reply-To: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742367998; l=814;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=yLn4ez8IBN5cqEFPit7mp5UgBhrhZLIZZw6YIL6gw/A=;
 b=e6gBxP0yd9AcDHNIKk7MOMdffmCK5QQs+DzwAku9qiIQVEPren5nNifcqcL8KAOYuZoFfCxfr
 DSwBjFkHmj7C1mqPF+kGAAiDJJsSkwZ6pb+2/Q9WHMPc8q1BcDw45d4
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



