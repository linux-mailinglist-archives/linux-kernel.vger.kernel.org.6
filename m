Return-Path: <linux-kernel+bounces-294847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E7959352
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE6FB22E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7388215572C;
	Wed, 21 Aug 2024 03:25:20 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07563FD4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724210720; cv=none; b=By3vVmFB0jmc21htaok+7yr/D8iMpncYCEcEJY01r8dwqdUSwJdz5w9LrEsgSZs7S9HXfIdkncHMQjPm7Fo2vdot4M831i1ven/ED/RORVxWRsxdfOM3pGKIFtUsa1xP57NHKAg96ExqzCL722Hc98rZrslSPUfQ6dA5C5CzxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724210720; c=relaxed/simple;
	bh=n5cR9lJCZsSx5Y5+GeaitWM3H54zHzB6RHVB6Oxv1Io=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pn+HLjf6959LTZB/beq00ITt6hAC7zOjnJWQGPZbPsZnWj1vbnZlkkyhhPtQT92Ef02vxB0ikOFyRp49V1IvIme+4CqHomjZ2TP8Xb8oODeN7NWaOkfH5TRpOSAU9kQtF8RF/6dXV2sAN5Y5cJaWk1eNiAZbPNkJ9MExO5Vww3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WpWrV4MmSzpSwQ;
	Wed, 21 Aug 2024 11:23:38 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BAF3140138;
	Wed, 21 Aug 2024 11:25:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 11:25:09 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <akpm@linux-foundation.org>, <sunjunchao2870@gmail.com>
CC: <lihongbo22@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] scripts: make macro_checker.py executable
Date: Wed, 21 Aug 2024 11:32:39 +0800
Message-ID: <20240821033239.2233508-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Set 755 for script macro_checker.py as other scripts.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 scripts/macro_checker.py | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 scripts/macro_checker.py

diff --git a/scripts/macro_checker.py b/scripts/macro_checker.py
old mode 100644
new mode 100755
-- 
2.34.1


