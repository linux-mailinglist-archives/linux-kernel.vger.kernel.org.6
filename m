Return-Path: <linux-kernel+bounces-294954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2429594BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEA9281A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF016EB5F;
	Wed, 21 Aug 2024 06:33:35 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5716E86F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222015; cv=none; b=M6cAyVHeZaVhgrFnE/oSM8TGGhBaVhhNHAsRJmR2Z6cbLVx9P3Rn0czH0DYLP0/Re23nT7qqSti+cNBIlmUbcnTAde/iNKoMNTxRMRUT9L9ZSEp/VIKQ2bL4JLoGkRC02JQkw1L5NUqgpyUH7O4h/nZHQhfX5yzqvww0ZZXDbn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222015; c=relaxed/simple;
	bh=7DkuXzSr/qwppCrdDSX1LNvus7p8EM8yAVqhCae8yTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFKa73bmZm3oosS19yIBBSBshduzze+xsfWK7/QB3zgzxEbyWlxKG1SNxkc+orE9/cS73EVFtRzz89OHfE+Y5kYu4aWdGkLtHgfY885T+Bm/kYQTTOspoEsFDUeoYNAXi7uQRTQX+tpJOmlwx2/L7Lrt/eiwygNL2Zb37O6MvyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wpc1H0j0jz1xvdD;
	Wed, 21 Aug 2024 14:31:31 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 843731401F3;
	Wed, 21 Aug 2024 14:33:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Aug
 2024 14:33:24 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chaitanya.dhere@amd.com>, <jun.lei@amd.com>, <harry.wentland@amd.com>,
	<sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>,
	<alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<alex.hung@amd.com>, <aurabindo.pillai@amd.com>, <colin.i.king@gmail.com>,
	<dillon.varone@amd.com>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 1/5] drm/amd/display: Make core_dcn4_g6_temp_read_blackout_table static
Date: Wed, 21 Aug 2024 14:40:36 +0800
Message-ID: <20240821064040.2292969-2-ruanjinjie@huawei.com>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:6853:56: warning:
	symbol 'core_dcn4_g6_temp_read_blackout_table' was not declared. Should it be static?

This symbol is not used outside of dml2_core_dcn4_calcs.c, so marks it static.

And not want to change it, so mark it const.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index c3c4d8d9525c..0c24f15d5067 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -6850,7 +6850,8 @@ struct dml2_core_internal_g6_temp_read_blackouts_table {
 	} entries[DML_MAX_CLK_TABLE_SIZE];
 };
 
-struct dml2_core_internal_g6_temp_read_blackouts_table core_dcn4_g6_temp_read_blackout_table = {
+static const struct dml2_core_internal_g6_temp_read_blackouts_table
+	core_dcn4_g6_temp_read_blackout_table = {
 	.entries = {
 		{
 			.uclk_khz = 96000,
-- 
2.34.1


