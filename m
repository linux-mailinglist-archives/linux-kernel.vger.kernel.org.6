Return-Path: <linux-kernel+bounces-327634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A9977897
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67CF1F25C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE61B185B5E;
	Fri, 13 Sep 2024 06:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fgfPBWyx"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6E224CF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207410; cv=none; b=rKwI/b7iHXG9eGwZeLLbrF+7P0CDbXleyiiR4wni7ynPKmiWTuRdrL8G6LzUCFlcrIt/v/UOUIkIHadgu0yL3Iex2Og+jxR+QF/nmSDOs+AWaHZCCPjzEH8QCGzmLTrQzQR7HUgZDmLiOdE9evZTOPicJZaXLKUcQxAfLxlQCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207410; c=relaxed/simple;
	bh=L7wre80hu6LdnbetkrOjv/zQ6n5sVvm0V1oKdr57hks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rmCiMmYfxNIL7Og8dJTdn2e6jXTmz9yDb+7vK2g3Deo+iTNkihD2lHizTibtg4mogH2ulX/3PI45a6NZN8sRyRFbe/s/RKu/7FDVbN4onUul3QdIffD1JUHNwff7Z3Q8PHpL+3jxv2/7P+6LSyiHbrs5SNaoJPYtGbrWgxpt860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fgfPBWyx; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726207399; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IXY6foCUKJL70y4wvAm3n7YmrfSbfkYbIltLyuQlMbk=;
	b=fgfPBWyxZgGNZB5VcrH1mIYmSUD4e7zzq0EGHNv7U+OvilryQRvnchKWMSOFGFOgqznD5PDdEpjeLBf2qsWjwblXvF3bwjXO9nAg/82ZIH/ySlCcK+sNXmeKyGEd/T/ffYLq5nBCGKJwwYp2vdOfpSlznJdRG3rF21Bby1sde9A=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WEtgHGI_1726207383)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 14:03:18 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: lucas.demarchi@intel.com
Cc: thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v3 -next] drm/xe/irq: Remove unneeded semicolon
Date: Fri, 13 Sep 2024 14:02:54 +0800
Message-Id: <20240913060254.26678-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary semicolon in pick_engine_gt().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8757
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v3:
  -Amend the submission information to "Remove unnecessary semicolon in pick_engine_gt()".

 drivers/gpu/drm/xe/xe_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
index 07577b418205..e501002e8a04 100644
--- a/drivers/gpu/drm/xe/xe_irq.c
+++ b/drivers/gpu/drm/xe/xe_irq.c
@@ -280,7 +280,7 @@ static struct xe_gt *pick_engine_gt(struct xe_tile *tile,
 			return tile->media_gt;
 		default:
 			break;
-		};
+		}
 		fallthrough;
 	default:
 		return tile->primary_gt;
-- 
2.32.0.3.g01195cf9f


