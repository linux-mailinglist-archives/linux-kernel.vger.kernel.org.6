Return-Path: <linux-kernel+bounces-404047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5DB9C3E85
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD89B20977
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2314519D067;
	Mon, 11 Nov 2024 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G/lFo9Rk"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1B139578
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328590; cv=none; b=uXfR7EQvWywZcQUghtvISkAygH9qSS27JxXerlLptgkVD+SiDouLxYr8xwGIQiLi2aVdWxPWYViDdLKYl8ydPKMMcUPVOw+E4nuCqTfyWA4VbHG9xmEeSXZJJtmE5/tvFG3euLssDtqzV2d8e3pQrJXNYKBLWtny6/Ew/qOcWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328590; c=relaxed/simple;
	bh=m85eO5DNfe2gc3x0BXHy/++ZQG4BdHLfBBIkB1TSw3g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q9Az39VlM/r0YP1SC2EoQ35cgjHzvJfSj98qcSLN7lxmRBvAo3urzm1gOLy4XGNVniRXmm+lmBCOrMnl+8EHPs5MvvQKQAENcZ8wnsZfpzBMIUWrA5KBON50HTzf+7PaJX/0yOyAh26UbLM4ijclm5eyBnpJU3/jozHkQLDqKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G/lFo9Rk; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24BF91BF204;
	Mon, 11 Nov 2024 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731328584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=trb/73fr8oplgOFNAbd36nCrZAk6oSoc9zUaNRyfOSY=;
	b=G/lFo9Rk29xrIml6PsnMC3ySH9Ao/M/QhGlQBXQIDKrsLFpm+Grjy2VB0hoUlQHbV17w0+
	UYFTtku4A3rJouRMgR6sjSMPYvQuq9qXYytYnWjwkaday+nJgasLVE5s41B23UPgHe0tlS
	pVrQLjtS4v91waVKQHXHvP/UPQIpQIOrnPqa//49geQWgFgDSGL0kTxAnw3vc1yPUVEgEu
	NhTAtcinBI1eaWmYv3Tr3ozu6vivLDKs/yesaRx54MLynDjvvQARpJyYpAMQOQI7AntreE
	KJ/KEZtV4D2+Lwy1kKdbkoI0O/a2+Rj7Fie+LaMLG4ffapiEwwknAMdFMs5brg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v3 0/4] DRM: small improvements
Date: Mon, 11 Nov 2024 13:36:19 +0100
Message-Id: <20241111-drm-small-improvements-v3-0-a9f576111b41@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEP6MWcC/4XNQQrCMBCF4auUrI1k0hJTV95DXMR0ageapCQlK
 KV3N+1GEMTl/2C+WVjCSJjYuVpYxEyJgi9RHypmB+MfyKkrzaSQDQjQvIuOJ2fGkZObYsjo0M+
 JQweisRaE1IKV4yliT88dvt5KD5TmEF/7nwzb+pfMwAW3tgaFYFpt28s9hHkkf7TBsQ3N8gOBU
 D8hWaBeoTTYa3WCL2hd1zd+sya5BwEAAA==
X-Change-ID: 20241018-drm-small-improvements-1d104cc10280
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

This series brings small improvements to the DRM documentation, logging and
a warning on an incorrect code path.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v3:
- patch 3: various fixes suggested by Jani Nikula and kernel test robot
- Updated reviewed-by tags
- Link to v2: https://lore.kernel.org/r/20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com

Changes in v2:
- Added patches 3 and 4
- Updated reviewed-by tags
- Link to v1: https://lore.kernel.org/r/20241018-drm-small-improvements-v1-0-cc316e1a98c9@bootlin.com

---
Luca Ceresoli (4):
      drm/drm_mode_object: fix typo in kerneldoc
      drm/atomic-helper: improve CRTC enabled/connectors mismatch logging message
      drm/mode_object: add drm_mode_object_read_refcount()
      drm/connector: warn when cleaning up a refcounted connector

 drivers/gpu/drm/drm_atomic_helper.c |  5 +++--
 drivers/gpu/drm/drm_connector.c     |  6 ++++++
 drivers/gpu/drm/drm_mode_object.c   | 17 +++++++++++++++++
 include/drm/drm_mode_object.h       |  3 ++-
 4 files changed, 28 insertions(+), 3 deletions(-)
---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241018-drm-small-improvements-1d104cc10280

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


