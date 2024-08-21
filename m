Return-Path: <linux-kernel+bounces-294953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8139594BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3411C212DD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FF816F265;
	Wed, 21 Aug 2024 06:33:34 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A016EB4C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222014; cv=none; b=OYWvook938h2dW1ExqFQ0d6qomWTKIoxJteww/BGHZbMql/QUQKRMEB93x64sPurgoXEZkdDcr0hPPLRktuZhfpqmXwRZiyQEjrurFYW6OsAG4flxE2hehQsjkyAKJkbIeS0EUfos8FtIHD2rV98VqizkPZWtQxIVkXG6AzeJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222014; c=relaxed/simple;
	bh=PWTf8UijejMlRKS7sKs/5eMUgE0pYuR+BKx0IE2J2NA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCuAFXw7A7xO+hM6e7VWL/d9TX9ArVeNIRzm3Sq/wKS59ecx5/EWVAiOrQjJw4biUzr4axed4DRiwyo46QTqKALAuNSNxE8RcNgJw/I8l06uTShLef2l1Xe7xUaRiYPM8e2s2NYwt4kJxZOHAC5mJhYSLlcH8h47brfVQ4xbUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wpc3S1MNTz1S8Dh;
	Wed, 21 Aug 2024 14:33:24 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id D0ECB1A016C;
	Wed, 21 Aug 2024 14:33:26 +0800 (CST)
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
Subject: [PATCH -next 3/5] drm/amd/display: Make dcn35_hubp_funcs static
Date: Wed, 21 Aug 2024 14:40:38 +0800
Message-ID: <20240821064040.2292969-4-ruanjinjie@huawei.com>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/hubp/dcn35/dcn35_hubp.c:191:19: warning:
	symbol 'dcn35_hubp_funcs' was not declared. Should it be static?

This symbol is not used outside of dcn35_hubp.c, so marks it static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index 771fcd0d3b99..d1f05b82b3dd 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -188,7 +188,7 @@ void hubp35_program_surface_config(
 	hubp35_program_pixel_format(hubp, format);
 }
 
-struct hubp_funcs dcn35_hubp_funcs = {
+static struct hubp_funcs dcn35_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
 	.hubp_program_surface_flip_and_addr = hubp3_program_surface_flip_and_addr,
-- 
2.34.1


