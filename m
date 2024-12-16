Return-Path: <linux-kernel+bounces-447708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C489F3649
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E228164CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306DB19DF8D;
	Mon, 16 Dec 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gtREOcAP"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C98289A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367272; cv=none; b=V1WGxv3nBpEpDJ76CAwfqOCHfOk5dQO+kY8/1XjXvBa3sHW8yZAObpIS4NQMVXQpN0NY+IRWhOUXiQ7MeWR30X9xy3jpl/JXNPAlQ7Mvt/h8xYH/R0rxnKKg/rkNZMki1zf0zvz41eSW/BW6I3hJDM/pPV3lYPBHEt2B3n3fxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367272; c=relaxed/simple;
	bh=m85eO5DNfe2gc3x0BXHy/++ZQG4BdHLfBBIkB1TSw3g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tloEAHOOly09NUIoKWuFPheoqr+VZgIV5YGzJS+fmJbju+RkdoDNy/pkOAaHBmAIt0enG3VIFT2tH8E4JqFK7k7pCdhlWP8DZhpdtUqlLzLMiaGe3bgZBPE2OP5iAIqsJBL0IF3ibE8SpqNwqzvOIYbThF6m0apeSNnv7gXoSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gtREOcAP; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B290CE0002;
	Mon, 16 Dec 2024 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734367268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=trb/73fr8oplgOFNAbd36nCrZAk6oSoc9zUaNRyfOSY=;
	b=gtREOcAPR0Sa0uNd7CyF/HGlB9KIuf97MfeAeY7kA9HiphnbKKNZnR7lue8fSwoQmP4Agi
	/9NsLDwQu7/wKyQZIYFNmhz6Zy1ePTHiBU6qjhFZm1044Sm17GnsK+rIAu+DK9rDH/0E7F
	g/+Je1FZIu1VfRBFs9VvotZMtng1BtR/7Ob0wxixhMNCzKMvG9a6QRrwrhQX6q4wLtNFuW
	Gi+NPAT/UjuAcRS//wLhBSxTLDJJUOd8lwJ4XccEiQ+2Y6Pvm6YtTK8uX5EAV3V6DvVHLO
	fN+DPsFplnijmxOTWRF+S5rFGtv0+h8nGALXOFSG5qvubQP3l/cjWHDLMEuV8Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH RESEND v3 0/4] DRM: small improvements
Date: Mon, 16 Dec 2024 17:40:47 +0100
Message-Id: <20241216-drm-small-improvements-v3-0-78bbc95ac776@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
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


