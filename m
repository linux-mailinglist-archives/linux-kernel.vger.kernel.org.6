Return-Path: <linux-kernel+bounces-294952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5589594B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3D528149D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9876816F0DD;
	Wed, 21 Aug 2024 06:33:34 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1D16EBE7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222014; cv=none; b=jjfExALIMSzMWodAHEXxBZlqfLe9h/1y2xvbmjGFG5FvfpFneFWc17knfJy+PhyeKCz+grs98wXYCLaEjqXEQ/FBolQB/M955YM8yoqlZCob8pF4+9jrEe+WJSLNqDjRfDkxE/mwlXCP55+9A5s90LXVHEhbFpNCbajs5scCiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222014; c=relaxed/simple;
	bh=vC5cyqq06VbM2r6qxqNojYU0cF7NclfVRFwc761ZWI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDEQq5CbgZ3F5IJMtuwxXTVXNDQOhQq4o/+D071oFdp+JNbboxYbtnm56ADq6RfBVDpvy3aYNQlYsjE5Ee2xw5iitFCTjpuSDuI9tqLNfgNC98JTqTBJtk182G5LgGX4o5apKf9sVIdAUeFNEOkkgRxFHuqtnMTAVyL+DDTdqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wpc3T4SCwz1j6gm;
	Wed, 21 Aug 2024 14:33:25 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E9F5180019;
	Wed, 21 Aug 2024 14:33:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Aug
 2024 14:33:26 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chaitanya.dhere@amd.com>, <jun.lei@amd.com>, <harry.wentland@amd.com>,
	<sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>,
	<alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<alex.hung@amd.com>, <aurabindo.pillai@amd.com>, <colin.i.king@gmail.com>,
	<dillon.varone@amd.com>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 4/5] drm/amd/display: Make dcn401_dsc_funcs static
Date: Wed, 21 Aug 2024 14:40:39 +0800
Message-ID: <20240821064040.2292969-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821064040.2292969-1-ruanjinjie@huawei.com>
References: <20240821064040.2292969-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sparse tool complains as follows:

drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/dcn401/dcn401_dsc.c:30:24: warning:
	symbol 'dcn401_dsc_funcs' was not declared. Should it be static?

This symbol is not used outside of dcn401_dsc.c, so marks it static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index 6acb6699f146..61678b0a5a1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -27,7 +27,7 @@ static void dsc401_disconnect(struct display_stream_compressor *dsc);
 static void dsc401_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
 static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
 
-const struct dsc_funcs dcn401_dsc_funcs = {
+static const struct dsc_funcs dcn401_dsc_funcs = {
 	.dsc_get_enc_caps = dsc401_get_enc_caps,
 	.dsc_read_state = dsc401_read_state,
 	.dsc_validate_stream = dsc401_validate_stream,
-- 
2.34.1


