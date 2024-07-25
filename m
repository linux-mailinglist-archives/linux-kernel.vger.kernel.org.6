Return-Path: <linux-kernel+bounces-262022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A2493BF91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA59AB221E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A5F196D9E;
	Thu, 25 Jul 2024 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DaqL7OHi"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347901386C0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721901678; cv=none; b=ZWdkVEMjZDsNcvxdDslqBPUjILllf0scSYZp26szw6VfHzvTtPyaiJZ+YWyGWgtm4uIWB9Iq0xU0XDwfA9glJ3bOMqc25VyTeZWuGVqmtNfkGKt8NJnWA52IVH+cOlzwgJB4wXik/XcrZ+vm9K7Z1jvIqOOkJAcb9TVs8k7InYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721901678; c=relaxed/simple;
	bh=YHDVXQi5BxSIOKDstA8wIMMEMNfWsKr0Dr0pw4dckM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QSuJVPbY9Yi96AI3LbDZhOpZ+e+l0qil7/v4rLAawkIf6Y+88WoNCbD/lc1DvOwUKVSHILgsgN8N8aQpf9Jge/knF3d9iJiLSp/13oUb40NfkO4YwAg/6xZcTSsFeJUJlFOB9xv8NL7sSl48VqZZiSjaBHN2acyENITswmPScuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=DaqL7OHi; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Hca6h
	01j5FlhQQcA+gE2xI+AjnHWSmz0alsrufjOPIY=; b=DaqL7OHiJKq0EQ1c7elk5
	bLUKzQL1eRwlZQjCu8j2Ft+RKj8wok2QwMshRK2MOarSf1XX/3WIW7vs2UtlAgbi
	H17F/P8B1bHGxKOSIItnbBTM6kefbFqreModawf0VIXcpYsvXFXIEWPhN41BB2EU
	6myhs5n03TrgEVHbmWotP8=
Received: from aitest.fmshzj.com.cn (unknown [61.152.128.138])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3vwZXIqJmDQ2sAg--.26299S2;
	Thu, 25 Jul 2024 18:00:56 +0800 (CST)
From: wmx129674@126.com
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	ARC-MX <wmx129674@126.com>
Subject: [PATCH] drivers:regulator:fan53555:add new device chip id
Date: Thu, 25 Jul 2024 18:00:53 +0800
Message-Id: <20240725100053.2609059-1-wmx129674@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vwZXIqJmDQ2sAg--.26299S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw45Ar1ruF1fKFyUXw17GFg_yoWDGrcEk3
	45Ja4xCrZ8Zan7G3WIqFsxXry5Kr40vr4fuF1UKrW3X345Aw1YyFWj9F17Ar45XFWUJFnr
	AF18AFykCrWSgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRE9NVJUUUUU==
X-CM-SenderInfo: pzp0ijazwxkqqrswhudrp/1tbiehgnCGV206OdqgAAsZ

From: ARC-MX <wmx129674@126.com>

drivers:regulator:fan53555

When I use fan53555, I see an error:

 FAN53555-regulator 0-0060: Chip ID 0 with rev 12 not supported!

So I fixed this bug

Signed-off-by: ARC-MX <wmx129674@126.com>
---
 drivers/regulator/fan53555.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 17c9bf204..c8a2e9405 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -113,6 +113,7 @@ enum {
 enum {
 	FAN53555_CHIP_REV_00 = 0x3,
 	FAN53555_CHIP_REV_13 = 0xf,
+	FAN53555_CHIP_REV_23 = 0xc,
 };
 
 enum {
@@ -301,6 +302,10 @@ static int fan53555_voltages_setup_fairchild(struct fan53555_device_info *di)
 			di->vsel_min = 800000;
 			di->vsel_step = 10000;
 			break;
+		case FAN53555_CHIP_REV_23:
+			di->vsel_min = 600000;
+			di->vsel_step = 12500;
+			break;
 		default:
 			dev_err(di->dev,
 				"Chip ID %d with rev %d not supported!\n",
-- 
2.25.1


