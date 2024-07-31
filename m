Return-Path: <linux-kernel+bounces-268626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9606A94271B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76F91C22811
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8D189518;
	Wed, 31 Jul 2024 06:43:20 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0397189507
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408200; cv=none; b=LK3cdej1wi0bJob5r02wAIxfZAO7+DB4Seq0JqegzBfU111W/hDZRSI2hOjZAryQi66h8bKW/JlMwYsYv6DJMTgdgVHmu+WH5yx3PU2iSbvf72sibiQDcAGaV8vcfLz9/UVNVMlvgyX5maFjBzGeYFxpIu338TBPgRUIlZQahrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408200; c=relaxed/simple;
	bh=7Li77XwYqtUeV1mfADfw7EVDdNJwUPpriVinOfu5wFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=psnyJaXaUrMQ+52/RvatLUjIfFHOTvCUE9ngahaLMO/WTQzAO5QbL5PVRqg4c+FfZnX3+HofJuBO8ljK3v31Ao74ImmLb0xAfoTco5KITWG0YezvgDNuP12sq+uzPpjmKmCe3oYYx6X1rZ6m3c0EontlbO8YyfAa+QUjAyAS5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366a9dcfd00d-9d818;
	Wed, 31 Jul 2024 14:43:12 +0800 (CST)
X-RM-TRANSID:2ee366a9dcfd00d-9d818
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.102])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee966a9dcef34b-10ed8;
	Wed, 31 Jul 2024 14:43:12 +0800 (CST)
X-RM-TRANSID:2ee966a9dcef34b-10ed8
From: bajing <bajing@cmss.chinamobile.com>
To: ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	bajing <bajing@cmss.chinamobile.com>
Subject: [PATCH] accel: drm_accel: remove incorrect comments
Date: Wed, 31 Jul 2024 14:42:53 +0800
Message-Id: <20240731064253.24523-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

accel_minor_replace is of type void, so remove the explanation of the return value in the comments.

Signed-off-by: bajing <bajing@cmss.chinamobile.com>
---
 drivers/accel/drm_accel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
index 16c3edb8c46e..09fb64444cc6 100644
--- a/drivers/accel/drm_accel.c
+++ b/drivers/accel/drm_accel.c
@@ -161,8 +161,6 @@ void accel_minor_remove(int index)
  * This function access the accel minors idr structure and replaces the pointer
  * that is associated with an existing id. Because the minor pointer can be
  * NULL, we need to explicitly pass the index.
- *
- * Return: 0 for success, negative value for error
  */
 void accel_minor_replace(struct drm_minor *minor, int index)
 {
-- 
2.39.3




