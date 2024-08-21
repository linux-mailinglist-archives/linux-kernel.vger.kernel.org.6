Return-Path: <linux-kernel+bounces-294950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800CD9594B7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C20928125E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63516DEBC;
	Wed, 21 Aug 2024 06:33:30 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC516DC1F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222010; cv=none; b=gOye+doqEbtBsslVpuunHCQh4uZR7qGfK9r2Sfh6+ofp0xE5KvXkXEv3z3fCoqUqRTMaYyXa7AaNZ2rWZ6ijSG6Q3iwcrYe/02LqghgdAmRwyS9/CDJG/v3//BrdcUGHBXormrCn/sRVHn0mNW8vQPggoGrO5XC990v+LB/1sTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222010; c=relaxed/simple;
	bh=lkC0Zh/UiGJ0JD60GYFAYNb1xNMY9+35a/qu9kH9FzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wd2blkxudYufHBoZOEOG2OeXGbLPUNKy0vxlifftqgAHJcC9TSnqvsn2STnxdlFiRV1tkDwdyoSYBTHi5KlfRy7LhRrmaa80X8sQieYpcm8KOZZPzstm99OTCOPFGjXj3jsNtROf7RHw8aQE5+QHERMxDb3CzGPd6nBJdda3M+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wpc3S15BKz2Cmct;
	Wed, 21 Aug 2024 14:33:24 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 38FF81401F3;
	Wed, 21 Aug 2024 14:33:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Aug
 2024 14:33:25 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chaitanya.dhere@amd.com>, <jun.lei@amd.com>, <harry.wentland@amd.com>,
	<sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>,
	<alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<alex.hung@amd.com>, <aurabindo.pillai@amd.com>, <colin.i.king@gmail.com>,
	<dillon.varone@amd.com>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/5] drm/amd/display: Make core_dcn4_ip_caps_base static
Date: Wed, 21 Aug 2024 14:40:37 +0800
Message-ID: <20240821064040.2292969-3-ruanjinjie@huawei.com>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c:12:28: warning:
	symbol 'core_dcn4_ip_caps_base' was not declared. Should it be static?

This symbol is not used outside of dcn35_hubp.c, so marks it static.

And do not want to change it, so mark it const.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index 9375c6ae1147..c5ef29596ffd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -9,7 +9,7 @@
 #include "dml2_debug.h"
 #include "lib_float_math.h"
 
-struct dml2_core_ip_params core_dcn4_ip_caps_base = {
+static const struct dml2_core_ip_params core_dcn4_ip_caps_base = {
 	// Hardcoded values for DCN3x
 	.vblank_nom_default_us = 668,
 	.remote_iommu_outstanding_translations = 256,
-- 
2.34.1


