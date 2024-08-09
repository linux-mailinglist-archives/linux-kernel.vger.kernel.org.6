Return-Path: <linux-kernel+bounces-280657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF8494CD61
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65101F22416
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2501190490;
	Fri,  9 Aug 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mGEVNzHB"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805E16C698;
	Fri,  9 Aug 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195971; cv=none; b=dVaB95MItoBM1gOuEjfzOxGUUhZFa0NgrGd4EBeZLz4TCMUlyIPr9LUnVZM3Vly9Hbv8Jr9rtYNrkXVGGCyY2b7JNFOL/FR532GfA+aN8cLYStyiTCL9wCew2tS9jiKhHzUicq449YGKp1wOnqk67xSoLJ8u/0vdEl7yHNrH5xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195971; c=relaxed/simple;
	bh=4KW1ROBDhFMm2b3dGG4xSpJKmeyZw3F35ER4kQ/Yf4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uoWGGMohdfxZsvf0R0AeoSIQ1iUueRRFUoYe8VojAP0+e+w/Qxgs5WiLFQ/TP2PZtf9qZr8ZXX3ss0jD+AhuGgOhjLPJ8RMoXZklCqwJmGodsIeBmsME0GSeVRsz5k6Gd+t6TWMpxNpkAPngkPO4Nf6OoOUOb8QIA9puZroVNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mGEVNzHB; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723195964; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gZ93c15PmjBf9iKf8+aNnVB3ru9vORti3RxMK+6EHUM=;
	b=mGEVNzHBtfTlt6BggMg57l4EPMorFIQZ1a1xV5wwXMjmgat3eNn8afiYDyUKjenXjQep8MbWjFxEnon5gGhB1VDlwxansZTE/hVQQAs0lsDPSECn8qxhQdi5tQwEu9RCXDPQq0IglVXJwZ+DW0QSMBMXGQVbWNBjgQomVGXYHcg=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WCPTBTz_1723195963)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 17:32:44 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: axboe@kernel.dk,
	christoph.boehmwalder@linbit.com
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drbd: Add missing kernel-doc function comments.
Date: Fri,  9 Aug 2024 17:32:33 +0800
Message-Id: <20240809093233.8627-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing kernel-doc function comments to enhance code readability and
maintainability in accordance with the kernel coding standards.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/block/drbd/drbd_bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 85ca000a0564..746bb75ab2a4 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1213,6 +1213,7 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
 /**
  * drbd_bm_read() - Read the whole bitmap from its on disk location.
  * @device:	DRBD device.
+ * @peer_device:	DRBD peer device.
  */
 int drbd_bm_read(struct drbd_device *device,
 		 struct drbd_peer_device *peer_device) __must_hold(local)
@@ -1224,6 +1225,7 @@ int drbd_bm_read(struct drbd_device *device,
 /**
  * drbd_bm_write() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
+ * @peer_device:	DRBD peer device.
  *
  * Will only write pages that have changed since last IO.
  */
@@ -1236,6 +1238,7 @@ int drbd_bm_write(struct drbd_device *device,
 /**
  * drbd_bm_write_all() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
+ * @peer_device:	DRBD peer device.
  *
  * Will write all pages.
  */
@@ -1258,6 +1261,7 @@ int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_ho
 /**
  * drbd_bm_write_copy_pages() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
+ * @peer_device:	DRBD peer device.
  *
  * Will only write pages that have changed since last IO.
  * In contrast to drbd_bm_write(), this will copy the bitmap pages
-- 
2.32.0.3.g01195cf9f


