Return-Path: <linux-kernel+bounces-294949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A42CE9594B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41843B2411F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7715C157;
	Wed, 21 Aug 2024 06:33:29 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742F21876
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222009; cv=none; b=jeLNjvSX0yYnZUY3jtiAK3uQyrPpZIQVoHd3qa2l/p81EcDxuTGx423TsVHNDS1PVAjgWBgLnRkayP3yWfKUJ4CS5Br/66T2gHVBhAl+tUkVh3xAE7QMNyvFMUMnICNb7nYaKpLEhvWmhZV26CD87qmqngs9nWT8uxPgJcGxZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222009; c=relaxed/simple;
	bh=kwhobS9D/gnXBhOdLUL0347oKlgTWA+m/KRp4EpUMss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X1ks8WhvZLAPTdhyd6gj+dj+LQRvwNMPvsPpa1B72Regts0BqIO8vd2aWBVmxjQwBXhJe2xI8HV0rQ6u3ICxDSYDq97tTYckBHWJmfjCNExmPA8+Kcg9ui/x6zTYCvZ7Z7DdOZ6CZ/tvRffz0BIOg567bLtyBgfOG31vgowT49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wpc322wRPzyR9t;
	Wed, 21 Aug 2024 14:33:02 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id D0D4E1401E0;
	Wed, 21 Aug 2024 14:33:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Aug
 2024 14:33:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chaitanya.dhere@amd.com>, <jun.lei@amd.com>, <harry.wentland@amd.com>,
	<sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>,
	<alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<alex.hung@amd.com>, <aurabindo.pillai@amd.com>, <colin.i.king@gmail.com>,
	<dillon.varone@amd.com>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/5] drm/amd/display: Make some symobols static
Date: Wed, 21 Aug 2024 14:40:35 +0800
Message-ID: <20240821064040.2292969-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Make some symobols static.

Jinjie Ruan (5):
  drm/amd/display: Make core_dcn4_g6_temp_read_blackout_table static
  drm/amd/display: Make core_dcn4_ip_caps_base static
  drm/amd/display: Make dcn35_hubp_funcs static
  drm/amd/display: Make dcn401_dsc_funcs static
  drm/amd/display: Make dcn35_fpga_funcs static

 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 2 +-
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c   | 2 +-
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c         | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.34.1


