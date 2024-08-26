Return-Path: <linux-kernel+bounces-302244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812F395FB94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEEC28302A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993911993BD;
	Mon, 26 Aug 2024 21:23:49 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03CB13C8EA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707429; cv=none; b=og4eKMTF4OMSqPXl64dn0azicAjkaz3Zg9iTDL6twkmjFptZ4BAGqz274K6b71ZjiNegOFS+/uiWOrb/MhKJ2wtPPvc+iw+yVds3Yi79baBSB8luERNUQu9FTkipv9hmwX8e9Kww8303ohendpJE5CyUb4LoP8U34PRBxdwgetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707429; c=relaxed/simple;
	bh=tg4FG3gnn4wsUsXMgSc1EDgDopNHuoZayLRDtOQjQPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaMCsoTTki1yId7ZbyR/RGvUGzMCZS3kvLuA39DG0r/9N/5mzMF5UAkIB00lAJPuGspIMFixsRXHMWFrGH1qsfWl5NmrVt9IFcTlu676K4N031IfbCr21laSjXHWds2KOym5y2Bhneuj43RAX9BQHNMcQnnmytrhxzRAgmEm0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 79b27532-63f1-11ef-8e5b-005056bd6ce9;
	Tue, 27 Aug 2024 00:23:45 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 0/2] iio: imu: st_lsm6dsx: Clean up ACPI/fwnode code paths
Date: Tue, 27 Aug 2024 00:22:38 +0300
Message-ID: <20240826212344.866928-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a couple of cleanups that should not affect any functionality.

Andy Shevchenko (2):
  iio: imu: st_lsm6dsx: Use iio_read_acpi_mount_matrix() helper
  iio: imu: st_lsm6dsx: Remove useless dev_fwnode() calls

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 93 ++------------------
 1 file changed, 7 insertions(+), 86 deletions(-)

-- 
2.46.0


