Return-Path: <linux-kernel+bounces-262024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7526493BF95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B5E28368E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD9E198A36;
	Thu, 25 Jul 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="HhCCd74X"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69391386C0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721901735; cv=none; b=pPlzkY8wYXfFVDUYOpI+e65F8FIJGDaDSEyDRj0Z/MAIkNk7MAoQqTmHfhs1/OZfAgTFdQZsQPvvJtxIeOZb9UGrI4Co5FdS8w5BAAEooHywzLVzQttzzvvNCkAEbWG4RAIQYmv6yQHk0Jr5IJn8AC4uHDKqv0ym1swBlFRNmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721901735; c=relaxed/simple;
	bh=p+Z5HvyEPim/F1tWvZI+HNA0DlL1e4SOzJ7rO1Ny+aY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aNVJE2obbQA3qT0jrFhq6Qx3vspl8sImDxo3XtJNo060AcZyz1FXAdowLC1htAyffGfL5bY23g6Rd/vZay1h43xoEOGvhCnHeLNueg8yHxzokSlMxDtass07zptr3VqQ1cbRdUej3IZcztoquWc4vIlCCQCP2qQR61Pcp8aHAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=HhCCd74X; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9I2sR
	fuLQW3UShmM+4GOY23wPHqbjvfCFwdmpTEeOoo=; b=HhCCd74X8MkaLe9AXSil2
	6HIn9RFhwK2GPm/w6i1rkFJAxNvqsot0jPzdu4AZBUp+mD5ae0Uqf/9mpWh9WYH4
	VaDrnVwDMtwu1TSmyZGH/4rIerZAxUv3TNhJ9xYafDY5YTnPzjFvWAIjLwQgYkqq
	dsMgTWvLvahqcNbXCDwhBI=
Received: from aitest.fmshzj.com.cn (unknown [61.152.128.138])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDX38iRIqJmg+7lAg--.3368S2;
	Thu, 25 Jul 2024 18:01:53 +0800 (CST)
From: wmx129674@126.com
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	ARC-MX <wmx129674@126.com>
Subject: [PATCH] drivers:regulator:fan53555:add new device chip id
Date: Thu, 25 Jul 2024 18:01:51 +0800
Message-Id: <20240725100151.2609466-1-wmx129674@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX38iRIqJmg+7lAg--.3368S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw45Ar1ruF1fKFyUXw17GFg_yoWDGwcEk3
	45Ja4xCrZ8Zan7K3WIqFsIqry5Kr40vr4fuF1UKrW3X3s8Aw15AFWj9F17Ar45XFWUJFnI
	yF18AFykCrySgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREl4iUUUUUU==
X-CM-SenderInfo: pzp0ijazwxkqqrswhudrp/1tbiThknCGVLbrlNYwABsu

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
index 17c9bf2043859..c8a2e9405906a 100644
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


