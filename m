Return-Path: <linux-kernel+bounces-400565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEBD9C0F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADA11C229D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F710217F50;
	Thu,  7 Nov 2024 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fLGm/iU9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78ED2178F2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008900; cv=none; b=lG/nMz4WIXSw+7vADlal7jdWV6RJZGeVBgzvYcEn+tM2j9ml9tZjVFzZ8cy0pr5xwDgtVqBof95H4IgR5gfTF4hDQ4IbB9kQ67G9LwHG19J62KNtXs3afFtm0FdGrBOI/DjhpH1UFmJLuBi0PvOqZXeuL/2+ty3gPjSZ0sXXPbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008900; c=relaxed/simple;
	bh=RO0c7EoopaN1SQrMONOFRGPZT4eehsDieDHwLK5y4+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkehRrLJNbQCUEhbBODf6TXee507UPDNsUhJvuW3KVpsa4CX2O2dVpnzMhWfhEsUPdkXqsLJvE/jRax0gF8we7Nca0Ry5PjNbYlSmJfGJjhsGujfcIMy7mirO/SRyhLKrYmiROs+HVcmF1QRla+3xyKWAteLN4/qMTiisk5awto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fLGm/iU9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:c173:4b:4a04:3a21])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B2E0792;
	Thu,  7 Nov 2024 20:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731008888;
	bh=RO0c7EoopaN1SQrMONOFRGPZT4eehsDieDHwLK5y4+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLGm/iU9sPvAnn5tjy3RYomLWN8cyiFhWWvRWnnRM9g4mdkwHcPj8VlW+G5pyUI1T
	 zx6AHenunLiXvdYbdB2obf1uUVTpwHVXABPVcs98qoNCyAkZUf7+NyV2l1SUnB7c6b
	 VVmUp/zSpJ74TS9VCvXHjwAeXePD98oyNdsS8t1Q=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 1/3] staging: vc04_services: Cleanup TODO entry
Date: Fri,  8 Nov 2024 01:18:04 +0530
Message-ID: <20241107194806.90408-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107194806.90408-1-umang.jain@ideasonboard.com>
References: <20241107194806.90408-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TODO entry "Fix behvaiour of message handling" no longer
applies due to killable completions [1]. Drop the entry from TODO list.

[1] https://lore.kernel.org/all/20240918163100.870596-1-umang.jain@ideasonboard.com/

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/TODO | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
index 2ae75362421b..f6f24600aa86 100644
--- a/drivers/staging/vc04_services/interface/TODO
+++ b/drivers/staging/vc04_services/interface/TODO
@@ -26,12 +26,3 @@ kthreads, userspace, limitations) could be very helpful for reviewers.
 The code follows the 80 characters limitation yet tends to go 3 or 4 levels of
 indentation deep making it very unpleasant to read. This is specially relevant
 in the character driver ioctl code and in the core thread functions.
-
-* Fix behavior of message handling
-
-The polling behavior of vchiq_bulk_transmit(), vchiq_bulk_receive() and
-vchiq_queue_kernel_message() looks broken. A possible signal should be
-propagated back to user space to let the calling task handle it before
-retrying. Hopefully these msleep(1) shouldn't be necessary anymore.
-
-https://lore.kernel.org/linux-staging/CAK8P3a3HGm1cPo4sW9fOY4E8AN8yAq3tevXxU5m8bmtmsU8WKw@mail.gmail.com/
-- 
2.45.2


