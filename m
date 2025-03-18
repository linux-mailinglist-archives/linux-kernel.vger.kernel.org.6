Return-Path: <linux-kernel+bounces-565669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C59A66D35
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE96163882
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84987202F60;
	Tue, 18 Mar 2025 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OcOTzBWj"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C051F9A8B;
	Tue, 18 Mar 2025 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284735; cv=none; b=PgXNkYgFj9ctxIbAHSnuO9ZoIjuNky2sFcWiYrVyR2v2csb2ITOFj7lbkt/b9kkV9Tavu3w1yG3Pf9/ZBq5qHCoIlQxgc17UQfiS5UdMEJFOVY5c30w6qDZUdidEhzpdoiioD+r1i/lGf4+aEnStPFu07EXTsfFKFMdfDTShFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284735; c=relaxed/simple;
	bh=/YTs9cU8ULer4Fb+jefyvYbbD+cxlf0i/GS6i1fBfX0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ORkgY3XUi+VofkGYm3eHtAdu77rqI+GRfJK2zmKlRxMFosv7Y1pfvU0fl9OGZFXuYUdsgkzkH0XyqE0mRchVbnvjgERhTdDOaoS7JgbljnaaSUZNMX17OKEcUJKwDgMWi5FXsw7c16X2A08cMWvwJDBFtElYclIK4eaiw/nsny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OcOTzBWj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0FB844546;
	Tue, 18 Mar 2025 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742284731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E578/GSWCsWnqwEkiPnLlBcESnf5QKksDe4RlGkn5Sg=;
	b=OcOTzBWjUOPC212xhPokYRhO/F5KrzIHi9z8hJle8RW6172GWhcFA5WoLVHrDMWPuetYul
	8Rlltu+q/47QnavmtssxH/03p+P9auOdgaRXb1zvOrBCzlw4ZRtwPfYFWegswAMhuZr8lQ
	B+VlxUsj/K5wwmH+G6rU+sbF1q/Wa2hoAb+vUrvOYwec/YV6fpDcJyGYELXnceSEkRhvK3
	IpwWKVJcsanNA/vMiMgmUnAcGmfisx7dMhQNVseDPazQZpkv/WNSb0nbJQEb0dCnYmh+RY
	QK4EkdothAHNrRK1DWBLD120h1+ZAmkxU8oZOLIK1KVcgRzOObebfxnJdBimYA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/2] Add NLT NL13676BC25-03F panel support
Date: Tue, 18 Mar 2025 08:58:27 +0100
Message-Id: <20250318-b4-add-nlt-nl13676bc25-03f-v1-0-67e0f8cf2e6f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKMn2WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Nj3SQT3cSUFN28nBIgNjQ2MzdLSjYy1TUwTtM1S7SwSEtKMjW2NEt
 WAhpQUJSallkBNjw6trYWAL9yEMxsAAAA
X-Change-ID: 20250313-b4-add-nlt-nl13676bc25-03f-6a88fbb5396c
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=764;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=/YTs9cU8ULer4Fb+jefyvYbbD+cxlf0i/GS6i1fBfX0=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBn2Se5TCFCSVl+n4jCzn3XlEwyp4i8r2uCkbqY1
 3RegzkGV3iJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ9knuQAKCRDRgEFAKaOo
 Nic4EACAIccHu05AUx/bJlZ7iQ1AAqOKDZGI64Nw3FEQz4qVLFDXvLOdW+E4aAtuv56g99zU4wM
 syqQKPWmAVi8EONINcMggmeA9qva8O814ggTr1Nxw+LECDDUVw/zGQaAUdtol+g1kfwbKiFi4kQ
 0OAaYxXKVPRXOmEZJyitgMpaSKok5J3kjyM/jPGq5Q0HhBw+GKtHRgpmoLy4N+teqwB+Ynsmzne
 rPoEcdUgTorR2T79mhTyW3OInUSyBM40hSeK584tY3xU5QsbEDgUrJIDer1UtX8ITES2t8wFJkZ
 EkvEWbF2tNPhzCCzQOHUwIUYaSP5QkI8WiVIUVYhwUEeEbA+UEaX/u4GcUu6UPPCDhhFhQphLMv
 5rx+DB9zPG+1ivckuHLdZIT6Zimm1zhwskQrwkMLLETo5LbtDS3BFXlIkbLOkLPkEeS5Bnkyqbz
 NOyOc3MjUSRV/AnyJRHs4DsbuB1JlbsF8HeXst5407+5AYT/HB7Cj1oJPg2jQ+MqrgNfJ/VHH4B
 yc/9Oalr80yZOKegsoLkIidF/PlJEdlPxPdmuE6vOaXSkJ02U4rl3TPp0UUU8+JDcWxz6aA9rRZ
 AE2DaGdCq8VoU2a383jon1sVSe44lpkl2Q3Cbpx9QzwFMR8bDyBj7GuqlQ1reuDJYsmbJjCjkxJ
 XeWCTquV4x8ai9A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedukeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduvdefkeffteeluedvgffhjeegffduveegfffghfejteejkedvgfeuvedtudejkeenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepqhhuihgtpghjvghsshiihhgrnhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgus
 egsohhothhlihhnrdgtohhmpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com

The NLT NL13676BC25-03F panel is a 15.6" LCD-TFT LVDS panel. It is a
single port display unlike the NLT NL192108AC18-02D. Add a binding and a
panel entry under panel-simple.c.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      dt-bindings: display: simple: Add NLT NL13676BC25-03F panel
      drm/panel: simple: Add NLT NL13676BC25-03F panel entry

 .../bindings/display/panel/panel-simple.yaml       |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)
---
base-commit: 0fed89a961ea851945d23cc35beb59d6e56c0964
change-id: 20250313-b4-add-nlt-nl13676bc25-03f-6a88fbb5396c

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


