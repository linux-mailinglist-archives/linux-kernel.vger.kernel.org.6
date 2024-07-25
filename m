Return-Path: <linux-kernel+bounces-262023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5914C93BF94
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899161C21777
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC56196DA2;
	Thu, 25 Jul 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oH9rAvw+"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6178196D9D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721901734; cv=none; b=o/NtLiCFkSy5+qQhhyAHfR+8A1l53E1keMq4Zr2ITSUhvf6vYOyEJu7KTytKxJRiWyLTFWAhSvAn+FqdFIrBaEobTugTGIndLqVGH7dS4HKp+XkQHgKdy7pTA7ndSpCaa9MriTo2VRaVQXYDzp54sHWmPTgOKGi1fRxLx1IEZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721901734; c=relaxed/simple;
	bh=p+Z5HvyEPim/F1tWvZI+HNA0DlL1e4SOzJ7rO1Ny+aY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OC1m1BGLL+XcjhYlTeMpy49/n/fi4Utn+IKXWSAfDnHHGui3/YVeh7+8/UrEex2imWyE3Hq1AMe7x0mQo0gL3rMX6gr5wG6LoI17PF6vDSq+0KooTTL56VnTFA493UzOHvJCp4sARUhvE5Lx5/T4INcbJQcohhgdA1HrrPLadsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=oH9rAvw+; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9I2sR
	fuLQW3UShmM+4GOY23wPHqbjvfCFwdmpTEeOoo=; b=oH9rAvw+csdoW4eagzU5Q
	6wMFUQf/sHxmpr+M8A/eVKQ5w6ghoG2qML1fFN6gOHZkRGkvtrCEnETtJpaMZmeF
	WK1gi9ZQJ6OGTMIuv/uDYOgtM9Q2RSiiW9Lu5igWK+QOCmRkH/VUnQ/ZngCsYNgq
	KInoBmMS1qwQsMuSbdtsfI=
Received: from aitest.fmshzj.com.cn (unknown [61.152.128.138])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3P9P4HqJm4SG4Ag--.53260S2;
	Thu, 25 Jul 2024 17:46:33 +0800 (CST)
From: wmx129674@126.com
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	ARC-MX <wmx129674@126.com>
Subject: [PATCH] drivers:regulator:fan53555:add new device chip id
Date: Thu, 25 Jul 2024 17:46:30 +0800
Message-Id: <20240725094630.2605801-1-wmx129674@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P9P4HqJm4SG4Ag--.53260S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw45Ar1ruF1fKFyUXw17GFg_yoWDGwcEk3
	45Ja4xCrZ8Zan7K3WIqFsIqry5Kr40vr4fuF1UKrW3X3s8Aw15AFWj9F17Ar45XFWUJFnI
	yF18AFykCrySgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRN73v7UUUUU==
X-CM-SenderInfo: pzp0ijazwxkqqrswhudrp/1tbiThonCGVLbrkOLAAAsg

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


