Return-Path: <linux-kernel+bounces-326448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E461C97687C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BB31C23206
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E631A2646;
	Thu, 12 Sep 2024 12:00:09 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB01A2620
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142409; cv=none; b=b/o4SSV+kgSR3hTcAJsgg4TATJeUQkelEAucQf4A3K2g9n7upm5P5Zo/4M8QvfBoTsROKKmFHa2/PPNFY9Cb7bydl8yy4B4l1vYVZKHRcWP4vofQQ+yYTVHU73p6bbvoROhWWn3l7bWALB1PJYgWNJ8vljMDnSnBnWPSdbadGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142409; c=relaxed/simple;
	bh=Ms3qlUeNVVO8lIWJS6SpVzLZzbIPRR/UG4FHFiY4lIU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPh4Qox7w3KNfTd/Erx5DoBijNpz2cj/1GhuaxKiLILhFzFKEbSbey1UuPlqjwbv2F2EohNmJYX5N1+BIY7dnb1cscB6tsaD7VPYccAd0FdSd4ulL+IoQotVGdSi8ij7lrRMw2ajWkAc79iCyfkv7Pwj/Ofe8WlgyZ81Ckt4X0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X4GG33R2wz69WY;
	Thu, 12 Sep 2024 19:59:55 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id C0B211800FF;
	Thu, 12 Sep 2024 20:00:02 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 20:00:02 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <apw@canonical.com>, <joe@perches.com>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>,
	<linux-kernel@vger.kernel.org>, <dwaipayanray1@gmail.com>,
	<lukas.bulwahn@gmail.com>
Subject: [PATCH 0/2] checkpatch: update deprecated_apis map
Date: Thu, 12 Sep 2024 19:56:13 +0800
Message-ID: <20240912115615.1029452-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500003.china.huawei.com (7.185.36.200)

Remove useless APIs and add new APIs in the deprecated_apis map.

Yu Liao (2):
  checkpatch: remove RCU APIs in deprecated_apis map
  checkpatch: add del_timer[_sync] to the deprecated list

 scripts/checkpatch.pl | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

-- 
2.33.0


