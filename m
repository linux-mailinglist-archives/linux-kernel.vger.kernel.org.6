Return-Path: <linux-kernel+bounces-343762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54951989F22
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E091F22005
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16E418BC3F;
	Mon, 30 Sep 2024 10:12:20 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43419189F41
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691140; cv=none; b=cm/q4KwEjKUkIplYwKt5wnoTw46WjHTfDhX1gzzGtjfmFNgFIZlrb3Sq3W+HbfSghL3+UAxg1FR5pY3nurZlPN4JwRWuRwxT1BluRqMa3tQ9d8ZlAcyPltUPu8JjFhmFd8P9oKeubR4L5Hw/jmhYghSlnZIDFfJs6o13sdTg41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691140; c=relaxed/simple;
	bh=eUBTWLEHTTYfn9314r5hOUfqmtnQ9OrF1sL+HLsNBmo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WXlm3Os+JdCO748PDNs3p147i8jpeZF6XtZ3qTtPIP9Zm9riTUVmB2YyR1KA8gEJc0URzT3S9z1H6cc5ZwAzlDIshhMr+ZWiJ48Uqn8E1FopLQcKGr5DflLZghZaJeB08a4xtUWIFp1LVwk9m6r37d0bnVNi9jFxlRWCTaTH4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XHH0t6kFqzFqxh;
	Mon, 30 Sep 2024 18:11:42 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id D8FBB180AE8;
	Mon, 30 Sep 2024 18:12:09 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 30 Sep 2024 18:12:08 +0800
From: shiyongbang <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH drm-dp 0/4] Add dp module in hibmc driver
Date: Mon, 30 Sep 2024 18:06:06 +0800
Message-ID: <20240930100610.782363-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500013.china.huawei.com (7.221.188.12)

From: baihan li <libaihan@huawei.com>

    Realizing the basic display function of DP cable for DP connector
    displaying. Add DP module in hibmc drm driver, which is for Hisilicon
    Hibmc SoC which used for Out-of-band management. Blow is the general
    hardware connection, both the Hibmc and the host CPU are on the same
    mother board.

    +----------+       +----------+      +----- ----+      +----------------+
    |          | PCIe  |  Hibmc   |      |          |      |                |
    |host CPU( |<----->| display  |<---->| dp kapi  |<---->| dp aux moduel  |
    |arm64,x86)|       |subsystem |      |  moduel  |<---->| dp link moduel |
    +----------+       +----------+      +----------+      +----------------+

baihan li (4):
  drm/hisilicon/hibmc: add dp aux in hibmc drivers
  drm/hisilicon/hibmc: add dp link moduel in hibmc drivers
  drm/hisilicon/hibmc: add dp kapi moduel in hibmc drivers
  drm/hisilicon/hibmc: add dp module in hibmc

 drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   | 227 ++++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.h   |  80 ++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  88 ++++
 .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  20 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c  | 258 ++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h  |  48 +++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 390 ++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.h  |  24 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  76 ++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 195 +++++++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  17 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   5 +
 13 files changed, 1429 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c

-- 
2.33.0


