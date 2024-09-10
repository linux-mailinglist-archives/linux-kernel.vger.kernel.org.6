Return-Path: <linux-kernel+bounces-323305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453EE973B19
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADA52842C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12326199FDD;
	Tue, 10 Sep 2024 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nxeYPL6z"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4E198A07
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981057; cv=none; b=MX60rJo1V4N2FgoFT736cQ8vkEkoHVPTZo9aJP9AsjYC+UC8oWn2KaoVNJzcy/Ad+ZoxBYq9QRMf/Ne/hiZzGjIXRd0SP66hDbK1lFHVfI4azqf/MJsdxD+Ea/umcnLLfvkaMj93T80+DCD27SAv0tf6zZgX5TlcEGivofVc0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981057; c=relaxed/simple;
	bh=960cQRauyxrwTPdeiil1TkLRjXkrngbh4XQnoZSNsQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oyWtXNcqNQB04Fa8QeYrq62al9yCMNAz+ZXjqA9Gi04iuOUN17r3R6Mw+Vsr7URTEQXg492xuTdTWVpPdWUJQDN2BM7PO7UAEJYoOiOxChXAZD427zKw3yZAXAfUFUh+nCykOzHKlBIpiclKSN0QLLQ+38YGCt2H9kTop3W9nmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nxeYPL6z; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B73C60004;
	Tue, 10 Sep 2024 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725981052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qCMkHyX9zsIg5QYvx/XfwM5tPByQTzqi6nmFdAR39ww=;
	b=nxeYPL6zJNY1vbvv3gTd43MRpK0CG4/0sgvUVf4zZ9yuwscDc3SltOXtJsaOkD7wRrzvqo
	ACkwM75C9qM4Iy0rkafaO40/3/R72NWt8IAqqyiXLo/g2y8rswKu1HjVkHH4Xu0rmJQK3L
	quoq/Uh3F16VBXcxN7DMBKw2DwM7hmiwwbbXj37H9gv+vHeENne4BUouZPW+Xw7pZzud9q
	99qwDAf1ytL1qml3sKR6V5I+qBuw9GgDezbBSlM3flgrvQpgWZU4QKR0qSUVlPTwsd+Zlw
	TnzN+fuME3gWQyZgZ4YocfcZd1Kk8KUlMH7p6bFdxl6Y+SkxOg+mCf9qlu3p6A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 10 Sep 2024 17:10:45 +0200
Subject: [PATCH] MAINTAINERS: Add myself as VKMS Maintainer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240910-vkms-maintainer-v1-1-e7a6c7a4ae71@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAHRh4GYC/x2MSwqAIBQAryJvnaAWRF0lWvh51SO00JBAvHvSY
 hazmCmQMBImmFmBiJkSXaGJ7BjYQ4cdObnmoIQaxCQFz6dP3GsKTwMjH03vlJLCWmmgVXfEjd7
 /uKy1fj9ERS5hAAAA
X-Change-ID: 20240910-vkms-maintainer-7b3d2210cc1b
To: rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com, 
 mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch, 
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, sean@poorly.run
Cc: thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org, 
 seanpaul@google.com, thomas.petazzoni@bootlin.com, 
 linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2765;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=960cQRauyxrwTPdeiil1TkLRjXkrngbh4XQnoZSNsQE=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm4GF65ozm8WrHG1ZR7e0EHNtWmoCTk8eBEUNiU
 fZJaAYFQ4eJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZuBhegAKCRAgrS7GWxAs
 4rOIEACbz8XPemUjNMaxx5zAyNUvE+W8ii46mr5mHWISNxgD8a0DrMDlxIL79G3rsThQQAau816
 93smtE2tZp/ubwqRqnXiGhaU4fsy53Y316FL5IJlZkE8Ti4lBukQEb8fah75LgcUZj+b7W1KPJD
 IKjI0Wbotg6uIMD979bDfs1eHyNL5BZZzOPPmfIc7jlp8546rbE/DvzfDwey8BUmmN5Ccx5qN/O
 uLoYrv/Ebe19Rg4lNyblQAmnM9TRw6hfpo/YgnohX6R0j7NE4VnT/EVff2NzixPaHWwyKc31fkR
 jGQmELliSTIB23noD81DSSlKtHNV9zwgOa99S1Wt1ISvD6doBeGvjlms1XsVBRgTFzRWgJ2zQhy
 uI1CJg4/X48A6qltR4Te+CZ9T4oaroBoyHCGLHsh7roND5ULHDf39Vr9JXKUcaj+MinSRJBchb4
 eib/rO/8rQW9mV0pjnAqYpZw26+C1BFg/3K6aO2vuR/Drc+fLAtrtUszL6cCv3IOqfHG9JwYtbK
 OP8XjrW8VcZwJwDIhm0Ai4zgFYFqB7mwUrcPxIpV3zrzeRo2e1QdNxFynylG2rfAkuj+2K8X3Om
 tZ0ElUAX37UjjUyqPZJNs7zZF/GmhhpGc61ODy66u7itnJCYdjrIjmlpsJElFM7pjCQqMfyPrEx
 Bd/EN6fWm7CA/JA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

I've been actively working on VKMS to provide new features and
participated in reviews and testing. To help Maìra with her work, add
myself as co-maintainer of VKMS.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Hi everyone,

This series [1] has been waiting for a while now, it was proposed first in
February. The first iterations had few reactions (thanks to Arthur, Pekka,
Maìra, ...), but since v8 (in May) no major issues were reported, Maìra 
seemed satisfied, and only minor cosmetic changes were reported. Two other 
series ([2] and [3]), that I submitted first in May, did not have receive 
any reactions.

In addition, there is also some significant addition to VKMS being 
proposed, such as ConfigFS support, and without a clear maintainer having 
the time to review and approve these changes, these changes have very 
little changes to get in.

VKMS is not a fundamental driver for "normal" Linux users, but I had some 
feedback from userspace developpers that VKMS could be a very good testing 
tool if only it had more features (I think P0xx formats were asked to 
test HDR for example). This could also help to detect issues in DRM core 
by emulating a wide range of configurations.

I believe the only active maintainer is Maìra, but as she's mentioned before,
she doesn't have much time to work on VKMS. So, I'd like to volunteer as a
maintainer. I have plenty of time to dedicate to VKMS.

I hope I've gained enough understanding of VKMS to be helful with this role.
I am eager to move forward and improve this subsystem. I've also talked to Sean
about this, and he agrees that it would be good if I could commit code to
drm-misc.

[1]: https://lore.kernel.org/all/20240809-yuv-v10-0-1a7c764166f7@bootlin.com/
[2]: https://lore.kernel.org/all/20240814-b4-new-color-formats-v2-0-8b3499cfe90e@bootlin.com/
[3]: https://lore.kernel.org/all/20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com/
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10430778c998b57944c1a6c5f07d676127e47faa..62f10356e11ab7fa9c8f79ba63b335eb6580d0a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7340,6 +7340,7 @@ DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
 M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
 M:	Melissa Wen <melissa.srw@gmail.com>
 M:	Maíra Canal <mairacanal@riseup.net>
+M:	Louis Chauvet <louis.chauvet@bootlin.com>
 R:	Haneen Mohammed <hamohammed.sa@gmail.com>
 R:	Daniel Vetter <daniel@ffwll.ch>
 L:	dri-devel@lists.freedesktop.org

---
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240910-vkms-maintainer-7b3d2210cc1b

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


