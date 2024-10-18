Return-Path: <linux-kernel+bounces-371934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74D9A424E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C053228100E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAA720101C;
	Fri, 18 Oct 2024 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WsssNF1X"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76E200C83
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265218; cv=none; b=sPouCP0j8Qz1pqHIzkoM7ELxnn+FyOtKSaXCnmlmh7ykO9DCXP5sHHPRZO3/9aV5d5CSsOs+cYclYXUzbo4TVTDYoypsdItSFIHInUoA65+xEhzrG4rDa2ExMDxlvKr5WvZ1aLD9/OTSqyEXaTC8Op9QJL23CPw1hH+JnPdtoJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265218; c=relaxed/simple;
	bh=9OVt4BiZUFTTUT5/h4qo95MXxVqfNHBQRpl7ieS4h88=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J5jE7RmbIj+8zGaTNXadKpAE1yJt9dwj/ml29/8+7SLi/sPzDJrzfE51nFog1jD6FOTPGoH3df2mWM/Gjnm5SLuJO+1nRck8LsrJ3opEjElTP3BZaqBYHJFpDN26XJtn9+22dEiL2tDZu0f40D58M/P3CFCRJo8NMQquMKSKeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WsssNF1X; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D9DE1BF203;
	Fri, 18 Oct 2024 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729265213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TG8RWBSK2bTH646gRr6lFAfcbscaoDUNNoOIg1fRYxM=;
	b=WsssNF1XcVNWqmT7zIazglhReTSN6CXdg+ZQtruMu56/PjqTn6YnSiYLcrbjNYiRkk1dnV
	bVdX5FZULyxT39aHYjLiWsFJ1YvtNQ8BronV+vm2wP6RsTZLbEtI2b8byWu+2x4H9mR36f
	SLzcCBJHny1buuP8018BMLo3gyDHJUaO/wbebug5Y0r6K8aCuVEa0AGG+SO/28nnMHLZfL
	cAejsmp1nVSMQWAsqQGjNt2SxQiF89xppL2ktN19PwNCFSLJa2lIdNBohHf7Bs97ij4zs9
	OFjDzNfpQzrZmO6Z8yFAhn+yd4Reybama+slUxHK6yG2zTCLYOSgyXX60nZd6A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/2] DRM: small improvements
Date: Fri, 18 Oct 2024 17:26:50 +0200
Message-Id: <20241018-drm-small-improvements-v1-0-cc316e1a98c9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADp+EmcC/x3MQQqEMAxA0atI1gaS4kLmKoMLaeNMwFZJRATp3
 S0u3+L/G1xMxeHT3WByqutWGrjvIP7n8hPU1AyBwsDEIybL6HleV9S823ZKlnI4cmIaYmQKI0G
 Ld5NFr3f8nWp9AKYjWNFoAAAA
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: luca.ceresoli@bootlin.com

This series brings two small improvements to the DRM documentation and
logging.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (2):
      drm/drm_mode_object: fix typo in kerneldoc
      drm/atomic-helper: improve CRTC enabled/connectors mismatch logging message

 drivers/gpu/drm/drm_atomic_helper.c | 5 +++--
 include/drm/drm_mode_object.h       | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 75aa74d52f43e75d0beb20572f98529071b700e5
change-id: 20241018-drm-small-improvements-1d104cc10280

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


