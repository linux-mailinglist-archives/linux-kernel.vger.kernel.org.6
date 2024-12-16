Return-Path: <linux-kernel+bounces-447670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E019F35DC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F388C18866F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E34193430;
	Mon, 16 Dec 2024 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IkTkBLd4"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9A7E59A;
	Mon, 16 Dec 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366111; cv=none; b=syndHegTC7TMj4A1xCzjT4Lmgtbtkh26Tb1vvMaeiQRXPneSZ9c8QD4T5QQLpAuEf86Vx/rmQiXjkGijO4isXK9C0V2nPIHL/BavxCJ8PxYiEAypnB/2G9lANQ8f8ncOTvbJavhXOErfVKreL8zILhyQSx5W/rULwHHEH85mURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366111; c=relaxed/simple;
	bh=LusuNw+ynrgMhhpQnBmNGQm2sD5IkS9yrEJVyAnd1Uc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tAv2mnQam32DaEELLJ1Lwmho2A/gMGM7rLRc3OyecGbnvsNJF+TJeErFgv2GJXlGBBy8rysqcLy1Z5DQXQBWiAtg4r/tFO9ZWQNyBSqG4RvbAJtumnXDV7/Ss2lu5sjnVu/YfrR37FTR52M9Isi0vAuuN+FtwTl4UAt56mtR0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IkTkBLd4; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23F0860009;
	Mon, 16 Dec 2024 16:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734366101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t1mh2dckR/amPlNQm3YVhlVqC5XhRzRpWGW62xADCBE=;
	b=IkTkBLd4/DVxLmXLHac44D051wZMPkIS6PddyzGN5OSNQ6UcCSNZQdUTy0Ia5kIoMEqfnu
	DAQnigY7Y5J6X+DvPRIuvN3T4ycAredKkHnDbRUz7KzqwTGEiaj5okALbnkBpamkcFjNj/
	fXcTiUr3dq9KxYkd9jfFXg6mjTHp/tNazDLTEmHk58FCCHNyolENiyn6vSnsrVZOEpcW8z
	e+CRwEiUYoJ1udsHrrhHULKmdT3Q8EfdVJtZ+Kq+cS9A/CUyvtxp074rfT2U25LuzwDd5z
	ceGxHIJDjBazuEadew49E+YFRl1/oH4LKCxY+EVAhtZNvQW38888rQj0zh2RgQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/2] drm/panel: simple: Add Tianma TM070JDHG34-00 DT
 bindings and driver support
Date: Mon, 16 Dec 2024 17:21:33 +0100
Message-Id: <20241216-tianma_tm070jdhg34-v2-0-0b319a0bac39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI1TYGcC/32NQQ7CIBBFr9LMWsyAhKqr3sM0Bii0YywYII2m6
 d3FHsDle8l/f4XsErkM12aF5BbKFEMFcWjATjqMjtFQGQQKyQVHVkiHWd/LjC0+hmk8SabQmrO
 UaLiSUIev5Dy99+itrzxRLjF99o+F/+zf3MIZsos3rXfKKOuxMzGWJ4WjjTP027Z9AZj98lC2A
 AAA
X-Change-ID: 20241210-tianma_tm070jdhg34-60cb8440b164
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

This small series adds DT bindings and panel-simple implementation for the
Tianma TM070JDHG34-00 7" panel. Due to how the datasheet computes the
blanking time, a quirk is needed in the timing implementation. A comment
documents that in patch 2.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Fix bindings patch
- add Reviewed-by tag
- Link to v1: https://lore.kernel.org/r/20241210-tianma_tm070jdhg34-v1-0-9fb7fe6b6cf0@bootlin.com

---
Luca Ceresoli (2):
      dt-bindings: display: simple: Add Tianma TM070JDHG34-00 panel
      drm/panel: simple: Add Tianma TM070JDHG34-00 panel support

 .../bindings/display/panel/panel-simple.yaml       |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 42 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
---
base-commit: 2ade8304e5fce7b972ef46011946186f1466c9bf
change-id: 20241210-tianma_tm070jdhg34-60cb8440b164

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


