Return-Path: <linux-kernel+bounces-565670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB36A66D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E1D3B6648
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CE52036E4;
	Tue, 18 Mar 2025 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kmvMKdA/"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC091EF387;
	Tue, 18 Mar 2025 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284736; cv=none; b=dFvd1Q6UQmHJkuzve2gDJ+6GhdVN5QZGjOn+/01y6M2VhqEZCqpc5nqphSnlWwqo5Vmf6+s14/9XyCtzVVPoKgGMedWyyojG3KQC4lHxUqY9ii07DTP4lVJMaRjsDxNMQHueQ6YB/1hzFjhrQnTUADREnfkNmSPr9emiliIgTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284736; c=relaxed/simple;
	bh=Vz8+P48bcNn9gWrsjf1ZjKPYHDM2ym6S6tQO3SUDfzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K876arIf9QC3Ph0USsWigkZ0A1IwMgP6mkPtOOxIH+UYqgSaCAoTgsPXo4YCNPJ588hPVA3PejvkeN8q1KpflTVJjK+wSWn1ecq8RvHPH3FjqJkUlr5vhsC4Kwa9WJe2CgmAcI/6zj8ewKvI8nZ4bsdrq0hqg8Si0q+ejrzUz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kmvMKdA/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3148F44539;
	Tue, 18 Mar 2025 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742284731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AiSuKsR+xQ+tI63uSyVHlaQ0SQ3FNe4GMa6crmOM510=;
	b=kmvMKdA/cLpCaxBbEN4mLe6QIe0wTZjj3zr01h40QMIiNH1es5fATFBEb7HT5NvhSinMTq
	9KTnfwIISeGHU+BSnATp9U/wJif7v+VJbe6u105h5fb0q62I8nnIfqB4ppIvA/5uWlErNL
	vzoph4t+VOqz3LwSLFePT0Y/A9ydM9aHZJI2W5xXf6Wb5HcBDv6AKupGQeSRFOdCMBVF+M
	8DyhQtLCtJ77JnaO1N5wMnoDgNsC/vU+I4adJgxuMzQwB70WhakT+AtvcB0s9qml9Jwum1
	nmpNwOaju+Qk9Ugqmr4i/qFPwtPh2vgiJyy4BpmMsx693QvBB6m168chTfsyCQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 18 Mar 2025 08:58:28 +0100
Subject: [PATCH 1/2] dt-bindings: display: simple: Add NLT NL13676BC25-03F
 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-b4-add-nlt-nl13676bc25-03f-v1-1-67e0f8cf2e6f@bootlin.com>
References: <20250318-b4-add-nlt-nl13676bc25-03f-v1-0-67e0f8cf2e6f@bootlin.com>
In-Reply-To: <20250318-b4-add-nlt-nl13676bc25-03f-v1-0-67e0f8cf2e6f@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Vz8+P48bcNn9gWrsjf1ZjKPYHDM2ym6S6tQO3SUDfzE=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBn2Se5F1Yf5WNw0q7ymsodPkYlQoQt3PE0ZHXIo
 ird2AKJNxeJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ9knuQAKCRDRgEFAKaOo
 NqoOD/9yqpD31nORryFmXIllq9dqzJNhW0Ztq46TD4OIKGM7jZ3emqBVKh/+Cd55h+b1kiQV4hH
 B5Xa7BAgXvy3c9l0+GOf6guZBF6GUxF79+CuCHsm1r+4/MlzBu9oRwIw8TZBLd3BfmYNV0MyH9/
 rKHEV3iJ6z6G0qmaH+FdJ6cEi70JybI14Pt3Ke6n1RWlu0U3E/eR/197f9+KCvBFhh4dncVYgUZ
 PLThdU9NCQ5nnI667pBNlB0JjemgpTQrZJ8mupd26U3R2etEPF3pHgHDLDWw6H7Xj89QDTgbZ3X
 BI8DJF24wNH1ECsejnLFz3SmF9LMsxgmPvHKQD2WIaGo4Tjhbft1XZtsFoSVt79YVNpSrKrb127
 b/MVhMO/OyGyggSCKaiYpE4SdZIWfuOoic+w+ewpY/s/Ptj1Lhnuz5ynC9oNu7wTCNBJoFq3OdJ
 316ySHLD84Gv0VTswXm4HH8RjN+VurVOX5kdjdGKK5JFpjhNmyIlHiVxCFOY+0jr5UKHidwStL1
 EX/6x7ie1a87XXB0v/JKhJVSIln7esZldAzROmzR5bhzRENl76TR/QpYpqno85xaADZLUoJOCsI
 5M2hhR5GZm3S6DaUKsLxz/crvnAMtNwYdQEMKAW31i8mMid2Lm3ttbbocTxiiUQytiB2vRM1fJ6
 gsJ5ziMYFWvecnQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedukeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhveeileeitdeufeefvdegueeijeeigfeujeffgfevgeefleduveffieeggeeifeenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepqhhuihgtpghjvghsshiihhgrnhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprghnthhonhhinhdrghhouggrr
 hgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com

Add NLT NL13676BC25-03F 15.6" LCD-TFT LVDS panel compatible string.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index e3ee3a332bb7..60d93f18f63d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -224,6 +224,8 @@ properties:
       - netron-dy,e231732
         # Newhaven Display International 480 x 272 TFT LCD panel
       - newhaven,nhd-4.3-480272ef-atxl
+        # NLT Technologies, Ltd. 15.6" WXGA (1366×768) LVDS TFT LCD panel
+      - nlt,nl13676bc25-03f
         # New Vision Display 7.0" 800 RGB x 480 TFT LCD panel
       - nvd,9128
         # OKAYA Electric America, Inc. RS800480T-7X0GP 7" WVGA LCD panel

-- 
2.47.0


