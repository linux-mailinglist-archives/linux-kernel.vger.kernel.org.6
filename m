Return-Path: <linux-kernel+bounces-440934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7299EC69C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C364162A78
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092781D31B5;
	Wed, 11 Dec 2024 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cECFL9IM"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83AE78F40
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904623; cv=none; b=p+rHFTmJMvqUTipDK+nsndQC1Onxh8TwfNrkrMngPMGco/TZllFzGr2LPqm3nV4Sxp+xU40Kmc9cQLa2NN5SdNNr7LI2RBvMLOAD2uexJNGpeX8kZ8zgRETJrWHYZetJmxgObLTQLAhhrr6xYD6EnQqjokf9aGf8TBTUOIOhjEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904623; c=relaxed/simple;
	bh=x/3cVCUpzAhOpEw+7z2TPHl/SsFdcRmPaFhG2P9DH80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=caFfNtSMEJ08kmBkjwoMuek3y/PX1ZJzgts78/DWZmEZXl8UFD0Mq+ubrpJEGsBRdDycPdUuBY8/fNRtKlEbAhv+PzSV94afhe+cDA28/BcKy4Scm+GqinnKW6f9FS32EleuM3Vk7/g63PtDnEis8HqNaEOZZcubN7PPxN5CnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cECFL9IM; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mQm1u
	vjIsSLKX1NCTmzRbVV+Pyt+NBj1qYuWZf6ZoPU=; b=cECFL9IM+csblVlU5IZlh
	QdMBbqVWaewIV4RK+oo04dpWynfXscFS14r+GY0Ac9/YKeXoHI0l1Pa7OXDTgymG
	ON7vz7eDxODvHkqlzoYrQIExecorcVYOVbXNX+le10WmRznUpXFEVfOvaKQO4Fdk
	AaOG5Rzxa2bwx8xTnjZNEI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3112xSFlnXyutAA--.20304S2;
	Wed, 11 Dec 2024 16:09:31 +0800 (CST)
From: Yue Hu <zbestahu@163.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	zbestahu@163.com,
	Yue Hu <zbestahu@gmail.com>
Subject: [PATCH] MAINTAINERS: erofs: update Yue Hu's email address
Date: Wed, 11 Dec 2024 16:09:18 +0800
Message-Id: <20241211080918.8512-1-zbestahu@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3112xSFlnXyutAA--.20304S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr15Cw4DAFyfXw48KF45ZFb_yoWxZwb_Ca
	s7Jrs7Xws8JFsIyw4kGF9rAr4Yqr4kGr4xZan7J3yxXa4qkr45t3sIvr1Sg34DCrs5GrZx
	XF93Jasa9rWaqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiiSd5UUUUU==
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBaw+yEWdZP2jd7AAAsf

From: Yue Hu <zbestahu@gmail.com>

The current email address is no longer valid, use my gmail instead.

Signed-off-by: Yue Hu <zbestahu@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bdae0faf000c..f57155874eea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8368,7 +8368,7 @@ F:	include/video/s1d13xxxfb.h
 EROFS FILE SYSTEM
 M:	Gao Xiang <xiang@kernel.org>
 M:	Chao Yu <chao@kernel.org>
-R:	Yue Hu <huyue2@coolpad.com>
+R:	Yue Hu <zbestahu@gmail.com>
 R:	Jeffle Xu <jefflexu@linux.alibaba.com>
 R:	Sandeep Dhavale <dhavale@google.com>
 L:	linux-erofs@lists.ozlabs.org
-- 
2.25.1


