Return-Path: <linux-kernel+bounces-325824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448E4975EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B2A1C22737
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD32837B;
	Thu, 12 Sep 2024 01:52:46 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190AF46426
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726105966; cv=none; b=VV/64xPTM7tQRXZN987DK8hPDx7rvlzFplH5rdj01x3lKvnj4e9vbC/w+6wEBesxfbFhwCIEYx6hizGl83qUUqoNHXKi6JqxIvqjDq6WDBYpWqxdG086vGDA/S/OdsoKh7G7Jzimh0Jv7+tPDMnGe7jM2VG93SwpjFc7zocPnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726105966; c=relaxed/simple;
	bh=JeRXXPgn+TRl4Iq4SQ1scfIOIxwla4oOGj+VaLfBKIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hz5H5Lo1T9d9JSmaoCeDBlvCBZvw5gopvztbZi9SQD12JqdVk2MrbN4wq9SwkzctiQm1Iwf87lyiKV9XfHNnl92fYwLXaovDoHuS0e4Eh+mep39Q4cOedCEqSSXb7ys7veCjZOKyX9Ta+02N5b3sWMwkxyZdBmW0/KYdEzhatrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X40nG5CmLz20nDL;
	Thu, 12 Sep 2024 09:52:34 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 634E81401F1;
	Thu, 12 Sep 2024 09:52:41 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 09:52:41 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <alexander.deucher@amd.com>
CC: <liaoyu15@huawei.com>, <xiexiuqi@huawei.com>,
	<linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<sunpeng.li@amd.com>, <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: remove unneeded semicolon
Date: Thu, 12 Sep 2024 09:48:50 +0800
Message-ID: <20240912014850.1016005-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)

Remove unneeded semicolon.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 92238ff333a4..7595355281c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -421,7 +421,7 @@ unsigned int dml2_calc_max_scaled_time(
 
 void dml2_extract_writeback_wm(struct dc_state *context, struct display_mode_lib_st *dml_core_ctx)
 {
-	int i, j = 0;;
+	int i, j = 0;
 	struct mcif_arb_params *wb_arb_params = NULL;
 	struct dcn_bw_writeback *bw_writeback = NULL;
 	enum mmhubbub_wbif_mode wbif_mode = PACKED_444_FP16; /*for now*/
-- 
2.33.0


