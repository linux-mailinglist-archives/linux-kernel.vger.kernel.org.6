Return-Path: <linux-kernel+bounces-556516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B3BA5CB05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F43B89FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6E8260A2C;
	Tue, 11 Mar 2025 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mZ3OR8ic"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AD25F7A0;
	Tue, 11 Mar 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711247; cv=none; b=MWL9GPyzN4wp4RXeuBMgFqmuZgUtYNvFeVYeGdYcCm2I96oqdCWhVen0SLILEV5rr34R2rMytY9/7jG+asaJh3Lj1y0EMYaZHTwIbldQ9BKZ9qKLDv0AFKeBbgOGiLJhfl38pV/R6G+b28V66XOASX4HIajfAI3o8GkFD2/lpYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711247; c=relaxed/simple;
	bh=FR+TQ7IoYaYLtZWEe3fw99UjOZhDA4qtth/MrlAO4y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0rCU2Jg/LZFdyBQ1744B9OEFQJ78nxR4RUwytm5y4NeeR2N2C4STE+pGP7PsVzTzE0z/4wYpjhlijYc+mJCBYNoyQ+2LVEfYnh0Ka7ATCzBNe4LUxoAXqwqm90+yvZMzIFS1nOlHO7wG/B63al0ATSHaJhIszgHbVBUjR0WmkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mZ3OR8ic; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 132F920482;
	Tue, 11 Mar 2025 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741711237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwRj3/sA6od74HspiG+LeXG1W4lQcyhzblNIrSKlp8w=;
	b=mZ3OR8ic9LwHH0OOgpotkPyhycgU52iRWfyQ//il3bg4WCxEBfcNeHiyia9cCA4cABkeqv
	oToMRUtgr5YCuMZTfAa7I+4aq131MVUp4pi5Bp+t3QGvriJh0ywO0bMNsz05r+7dgOjmNF
	YqWMPU01OmZaR6+kkYpi8ha3ndIc7/Gf73hMHObGDw9c7gQYXmyGkg9rstwvBCDMlYO1kj
	w7TbyWKz+cs9TSVuPZrjbbSV/6/N0Ag2y0JoHeVJTBwfMS34DfbLmfbBgB4xlt9J5Vu+1+
	7aU45+l5SdUXRACO32IxH0UKrAfaMaMtL4WBYdp1ao+vbUR6Wg9IvvqVKd/BnQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 11 Mar 2025 17:40:05 +0100
Subject: [PATCH 1/2] dt-bindings: display: simple: Add POWERTIP
 PH128800T004-ZZA01 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-add-powertip-ph128800t004-v1-1-7f95e6984cea@bootlin.com>
References: <20250311-add-powertip-ph128800t004-v1-0-7f95e6984cea@bootlin.com>
In-Reply-To: <20250311-add-powertip-ph128800t004-v1-0-7f95e6984cea@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=FR+TQ7IoYaYLtZWEe3fw99UjOZhDA4qtth/MrlAO4y8=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBn0Gd85w3aJW2dzKqQs82zsF7hcfR7uOrfKX2IH
 d2d2l1TtzWJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ9BnfAAKCRDRgEFAKaOo
 NkmdEADKhR/HrGsGt1ueHHwAP+8WlZ4vTL+iL5lVNtKHiNFjP0zbG0Z6D5wQDIXgWOp1HwiQtrq
 RZBaJU0oOgr2DovSrKsKzyEtpzrC1y9Eca0Vm7PtfSroPrL3taMlgySKVTduBN5zSxLxN0nAGCb
 pgQyG+a4MAAnankJAbNkyRBGnFXrfuQluNC2U7pS5T5rUjUo4HO/bdGNLTiZ+59aNZT4cgQt8r9
 P+WeJ/L5a/jjHHeOlM7CMIMh5AwPOtg8kjk1gbXw5dFhZLy3VWNNdnfZGoJoR9j41/KtbQdQpxJ
 hVXEKNngtDFpnY298d91XmtM/Z23vZbrIWKma+771zeJvdCItTBWTeRwHFhIF2SzmRKtJIHAs7L
 kaakeX3u2NSdaRArSWOSnrsax/g+5XTMZrL+SbejG6nMgQa0Az4p2jippIQZGuyYM7W6INnOD3N
 R/1qXCh1EjxV+3DgTA65Y9dsOEyn5NM8FJv0vSwiF16xDvSbCxiKLpfQee5YWz0p7naGFF1U88q
 Deba9jfFkD7yOqb+sGpr7Q04p144WlaCL+NtLJTWc+z+wuXikR8v8hfJTcwglxUt9rPkA9eCCEg
 HvMY+CYmx2lP63wOUuFKb7XULFCT2KWO6G7FzpxTJeMP+13bs7H7JqPnMJTSqPy87UeQQRgDJs6
 GwUambZSMl8FibQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrn
 hgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhihgvrhhrhidrrhgvughinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com

Add POWERTIP PH128800T004-ZZA01 10.1" LCD-TFT LVDS panel compatible
string.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index e3ee3a332bb7e1736a8d44773b0aef4873153be1..6bd46614d4b91200b56b0b72c825df5761c934ef 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -244,6 +244,8 @@ properties:
       - osddisplays,osd070t1718-19ts
         # One Stop Displays OSD101T2045-53TS 10.1" 1920x1200 panel
       - osddisplays,osd101t2045-53ts
+        # POWERTIP PH128800T004-ZZA01 10.1" WXGA TFT LCD panel
+      - powertip,ph128800t004-zza01
         # POWERTIP PH128800T006-ZHC01 10.1" WXGA TFT LCD panel
       - powertip,ph128800t006-zhc01
         # POWERTIP PH800480T013-IDF2 7.0" WVGA TFT LCD panel

-- 
2.47.0


