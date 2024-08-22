Return-Path: <linux-kernel+bounces-296407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A2495AAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EED21F235D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD9D11CA1;
	Thu, 22 Aug 2024 01:50:59 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16717AD2C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291459; cv=none; b=qJFYCfBb4669HwweBpwGiru+61xNQYztstv/83G8UIh89+8JEN+E76cJy36tbee8fyvh5t2aKmfBflXRobofREkHyyAdmDZ3fG1uYTrZbX0wa6UAKNAu9eW2Y3QgXIHe4iYkMqhzWizAGw/2V9AO06oIPR4HLK5epBUmm/OLJiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291459; c=relaxed/simple;
	bh=u8UGig1F6ki7Yex8DYGeZi0KGl24xqwZn+WdID5SX3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fohalh2Keo0dnHizi9YtrrgZaTIGOnSUaCoOFD6jpLnnpojqatL8Q6US9V8zhRcSBScxB6Zidog5wNZraTZ+ELhZPDjhx358imh2RalnB017q/gVpflXtML/tMbQ8zkeDQg/9ev1FJleZcS5WORBbnet6DNS0caYf1I5ZU5k1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wq5kG3Rh9z13jRl;
	Thu, 22 Aug 2024 09:50:14 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 409EB1800FF;
	Thu, 22 Aug 2024 09:50:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Aug
 2024 09:50:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <nicholas.kazlauskas@amd.com>, <Charlene.Liu@amd.com>,
	<chiahsuan.chung@amd.com>, <hamza.mahfooz@amd.com>, <sungjoon.kim@amd.com>,
	<syed.hassan@amd.com>, <roman.li@amd.com>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 RESEND] drm/amd/display: Remove unused dcn35_fpga_funcs
Date: Thu, 22 Aug 2024 09:58:19 +0800
Message-ID: <20240822015819.3356282-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

dcn35_fpga_funcs is not used anywhere, remove it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Remove it instead of making it static.
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index e2d906327e2e..15977c2d256d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -1068,13 +1068,6 @@ static struct clk_mgr_funcs dcn35_funcs = {
 	.is_ips_supported = dcn35_is_ips_supported,
 };
 
-struct clk_mgr_funcs dcn35_fpga_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
-	.update_clocks = dcn35_update_clocks_fpga,
-	.init_clocks = dcn35_init_clocks_fpga,
-	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
-};
-
 void dcn35_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn35 *clk_mgr,
-- 
2.34.1


