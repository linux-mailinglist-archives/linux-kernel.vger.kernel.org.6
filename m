Return-Path: <linux-kernel+bounces-300783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9544395E84E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE442817BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCEB824AF;
	Mon, 26 Aug 2024 06:16:26 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC1E56C;
	Mon, 26 Aug 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652986; cv=none; b=YgfKKzuexd4bhXxKchyfplXPDkdzVLPYCwiyOrpG9515xMJgEhLG+uz0sw4qXWbC1tEe1VUhTn61rRKpL1T20noU9LR47N7LzwHj0lB5mIz2YFX12vOuCgRBXdEP5TrDvfXgkAWAri1IF6Sz+tN1brR92vfzEvU+o90NZBhQaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652986; c=relaxed/simple;
	bh=g74OlygRler6h/4umWQSjDC2iYs4gSsSM6qYR45cwX8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UGnMJ0M69MkZDfABdE3bYNRy8b/1hcNIc5T0O3A+ZIHEUcjDQxT2sPS6MCgYD9AH9a9GM8NNnFro+enKgLXzmrZJjD+lrske2OWW3ZcLWC5Dg/9embPWWnYwdQVxA1xqVp6hvFeb99oxp51iUMYsTF7pRjioSrzMs4yV0AE4DXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WsgPD22bdz1xvc9;
	Mon, 26 Aug 2024 14:14:24 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id EAB711A016C;
	Mon, 26 Aug 2024 14:16:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 14:16:20 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <robh@kernel.org>, <saravanak@google.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <krzk@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 0/3] of: Simplify with scoped for each OF child loop
Date: Mon, 26 Aug 2024 14:24:05 +0800
Message-ID: <20240826062408.2406734-1-ruanjinjie@huawei.com>
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

Use for_each_child_of_node_scoped() to simplify code.

Changes in v2:
- Merge them into one patchset as Krzysztof suggested.

Jinjie Ruan (3):
  of: overlay: Simplify with scoped for each OF child loop
  of/platform: Simplify with scoped for each OF child
  of: resolver: Simplify with scoped for each OF child loop

 drivers/of/overlay.c  | 12 +++---------
 drivers/of/platform.c | 14 ++++----------
 drivers/of/resolver.c | 12 ++++--------
 3 files changed, 11 insertions(+), 27 deletions(-)

-- 
2.34.1


