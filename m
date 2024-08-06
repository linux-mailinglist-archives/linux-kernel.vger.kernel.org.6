Return-Path: <linux-kernel+bounces-276324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F45949223
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC0428234E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A0C1EA0DE;
	Tue,  6 Aug 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="snMa1FEY"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C95C1EA0CE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952270; cv=none; b=X2Bb4tk3sJseh7VA+u5jTmeZaZQEAIqq/g99Csn926ThGhb0lWoHi78c7laLLnHum1RbhAnrm0E5EHpZx2bI3cW6nTD+wankSupSmZtcepFE4suuYDZQAUY9NwT6vILWOddr0KKCvYFswuEZb2+LBfoBqTYOOe+qddBlDY9T8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952270; c=relaxed/simple;
	bh=4HSMw/HU7AGAzzVaZuC80Yuo8WSKYY3sDqLnUPMKEzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I0K44F1HXrfSdRDgfeaXjZy3j+jvmrUlM7lTB1UMz3J0xKJJgucjgX+ri7rXQwili7WV5ex1epNzSx4/G/Cg5LzxDl7KcphGBhtb03yXTnVW59IzxJjDflx5q2gRFhcvQzSCFRMUWyvvVWbDGb2HJKCAzclavLgWS5T9m64FKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=snMa1FEY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-156-87-48.elisa-laajakaista.fi [91.156.87.48])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F1D74CD;
	Tue,  6 Aug 2024 15:50:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722952209;
	bh=4HSMw/HU7AGAzzVaZuC80Yuo8WSKYY3sDqLnUPMKEzs=;
	h=From:Subject:Date:To:Cc:From;
	b=snMa1FEY50ru9jiYiXJfB9qXf/ywoncBxtTuB9jWuREAZ3dOLJkUDVvp1dWteswdz
	 lHPZ35EqvNeoU3eA38umKjnID7b4j5PW8116Gcb/QEbXl9XBH/iy4gb2x5r0w8wyAW
	 0k/F83mCpVY40zi2TGlBm9f8IDbL2QCDNG4lop4s=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/3] drm/omap: Minor fixes
Date: Tue, 06 Aug 2024 16:50:26 +0300
Message-Id: <20240806-omapdrm-misc-fixes-v1-0-15d31aea0831@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACIqsmYC/x3LQQqAIBBA0avIrBtQi8iuEi0kp5qFFg5EIN49a
 fn4/AJCmUlgVgUyPSx8pQbTKdhOnw5CDs1gtR30pEe8or9DjhhZNtz5JUFL3lltXB8CQRvvTH9
 o37LW+gGov5eQZAAAAA==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 kernel test robot <lkp@intel.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=857;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=4HSMw/HU7AGAzzVaZuC80Yuo8WSKYY3sDqLnUPMKEzs=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmsio9r372s623W9DcayrF14x5KJ0kKj8dCIrIL
 4DkbYIbXBeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZrIqPQAKCRD6PaqMvJYe
 9dO5D/9wfKM0rKjJvQCyU+XiP1tDzwK1wtBTkUkflysczZXhTLZIv7r9Mng9GqkbgXpZK4vzZG4
 lDPbYAvnhCfcjRAOuWu/+3HrjwyaULnp/6Y9poXIjxNd3gsggzfOkV9TAkJZuNRbMFJjzh+E7W4
 iI9v9y8a52lTl5YvpU9ZrJkNXuF1SPsb9RRnRHlSaimzwMCEo46xRETPwhwqAwO6ELuTZQdNe6z
 UPIgj4hdqOSYs0uc4C25MkRPR9ASuRck1YSMGLC23KAii82mmHJPjSiGnvRWa9ifBsfRTB2v596
 TC7NHidy+GWbt3AlalAS47W6LsVnH0+1MmRr4GRKmsLHFdXXGVeii+Q8UHiGSnhKJ1rX2U9Bnr9
 TZS2AGigbOBMBEBuVXbFjYOfrT9t4mcdWxRiZUaunuMnbMQUMrK/wfrgnjBJ2ve0Asv/b0hWwp0
 u1yxBqMs9smA1RUUDk0dcMb9AQx6UWGdIMHA+vFfsqFDsF+1nU1jAVwPwJBnU1J0gQR18oXYb+8
 ORry5RJ9EDdpERjofem1EaaQ3ZdY10Pqro1gCpvYqNK9ENJCwGEUCcuwxRDg4nYzDO0qO96n24w
 bRj6Yci0JMnyxfF88SVSnn1uRmCfDyoppficRj3+I3tDYiCeEM1jTcdtvU+YkDGfBkFrLup9L1T
 +G20XLENzWH7BvQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

A few minor fixes to omapdrm, mostly to remove sparse or other checker
warnings.

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (3):
      drm/omap: Fix possible NULL dereference
      drm/omap: Hide sparse warnings
      drm/omap: Fix locking in omap_gem_new_dmabuf()

 drivers/gpu/drm/omapdrm/dss/base.c       | 25 ++++++-------------------
 drivers/gpu/drm/omapdrm/dss/omapdss.h    |  3 +--
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c |  6 +++---
 drivers/gpu/drm/omapdrm/omap_drv.c       |  4 ++--
 drivers/gpu/drm/omapdrm/omap_gem.c       | 10 ++--------
 5 files changed, 14 insertions(+), 34 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240806-omapdrm-misc-fixes-2ea920193dde

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


