Return-Path: <linux-kernel+bounces-262041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901C93BFDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79E3283434
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6320198E63;
	Thu, 25 Jul 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bXk+3B7P"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787BA1741F0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903148; cv=none; b=jSNMivKz2rKU7eYZ31UoT2fSbpLVjb1K7EFHijlo2iAzOGJK/Vf0U6ustujbBgeaD7GO2nFoFrtyOeeT/eeRfm03XMcHZxTe5ATt0ijhbu6rTI0vwLCphRTIZslxTjeHBT0ShD6+1aWLQlSbuNc34bEE6GwC5gVZAhPOmGCk0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903148; c=relaxed/simple;
	bh=C/9VW2z9cJadjYUSZwaLehbV+m7p8sQ4LIqyf5MnEOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cj1Iw+WCaNBlNC2pk5gzgALpv8lNqVUxkTw8is7mtXxJfv1z0JaESTUbSwbG0AArEBQia81KEIJkP4Q/HaKgnGEjEKH43H0k4HMA/XKo/o/6BHhcvB3Gbfl/lGzlg0RHT7gwBEXAu3Z46MUQrvGSZrM5LbfyphHGTez2eFJfxig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bXk+3B7P; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EyCRf
	B6tAxCdCmORpS9/jo7kTQFrL1PwbJ/RbBawYNw=; b=bXk+3B7PVQmZgtbRcfdKt
	K9B2wiAOHU7PiyRfsH/kUVbCFF6+GOV0Z7MNlGnO5zIJw0XkI++73sLOJSgnwweM
	8oMMUoCjSq4R6wlYBYaOqjlKiPpqsPotrtvQk60/WJcZFq6ENxNU6CRC/yGXGrJ8
	TGTHwyWrnEUTbLlpQ49x8Q=
Received: from aitest.fmshzj.com.cn (unknown [61.152.128.138])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3350DHaJm2jTlAg--.36008S2;
	Thu, 25 Jul 2024 17:38:11 +0800 (CST)
From: wmx129674@126.com
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	ARC-MX <wmx129674@126.com>
Subject: [PATCH] drivers:regulator:fan53555:add new device chip id
Date: Thu, 25 Jul 2024 17:37:48 +0800
Message-Id: <20240725093748.2603941-1-wmx129674@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3350DHaJm2jTlAg--.36008S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw45Ar1ruF1fKFyUXw17GFg_yoWDGFXEk3
	45Ja4xCrZ8Zan7KF1IqFsxtry5Kr40vr4fuF1UKrW3X345Aw15AFWj9FnrAr45XFWUJFnr
	A3W5AFy8CrySgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNWrWDUUUUU==
X-CM-SenderInfo: pzp0ijazwxkqqrswhudrp/1tbijgcnCGVLb8GsUQAAsb

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
index 48f312167e53..34713d78b40e 100644
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


