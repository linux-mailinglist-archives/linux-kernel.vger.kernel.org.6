Return-Path: <linux-kernel+bounces-540634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E66EA4B317
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD05164565
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D33594F;
	Sun,  2 Mar 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WYvIgtEx"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8131DF25C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932583; cv=none; b=FQLfycLmBoOXjM2ja2TucB+8TJ6187Hzd1dEhOlpN6zhfCLK1J1ZWe70y04wQm6IhPUvaLK0fV4qgMe1S2YZaiW1KPqTVsPCHG8ZkQOcOMRd7/b1fUb5oa90eOMhOykvbnIDu3haWs6tnLSwxCGF7TNb8z0PhwdORqRMkjygy0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932583; c=relaxed/simple;
	bh=09g6Coqei+13CyCYJ1cI+TQVdeRHgvvBgjZGZ/PPO4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bsg+xaeafUgFe2cW+dKvNJW1YpEUmAOMjWUwQ/UgRM+yqZtf46wYDwdnkl7eIbgNXo5VsYW3UM/SLNmLuhxG3i/YW9zGsI2lytKjnW/q/8PTbZ2NLz1rt/iYfBOE9I5sM/JdXEkl5orn8KEu/rvg+OhuEWqgZswgTpo9E2QMs6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=WYvIgtEx; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id om4YtTJnYVX8Kom4ltOvuI; Sun, 02 Mar 2025 17:21:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740932519;
	bh=IGEa4U+OHLF8eysA8nCuOd6RrVGeAMmuutlPlvEww+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WYvIgtExkiwYK9SxP67B5vDLTXJK2gxMuJ0CeYnZFr0XH7aktim432IADDboUQzTC
	 i1/y4rElfza+Iedg+IO4dFFGelDI0QZdEswkvtub2Lttf6jKnzDoN5yq+GEkiMHINB
	 KeuRYevyH9bmeKE7iHj8UJD+Yc1/eSnpcjqwSNnW5YNp+8P3k50cs2+cprQOPqZ586
	 wKCHxpU+35MRXDmPHfxsohwjO7x2jNhNulLEcKeOFP5Ggm8m322DUMd6cHeAGNrluZ
	 yGb+s3/PEHtyGIqgqBUp0aUuP8ThqQlT88pn2696G3eiu2XqDAbz+588XFYaisQW6Q
	 aTrpRb9YTTseQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Mar 2025 17:21:59 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: andersson@kernel.org,
	Michael.Srba@seznam.cz,
	konradybcio@kernel.org,
	jeffrey.l.hugo@gmail.com
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] bus: qcom-ssc-block-bus: Remove some duplicated iounmap() calls
Date: Sun,  2 Mar 2025 17:21:34 +0100
Message-ID: <efd06711b126e761a06eb5ef82daf9ad4e116a10.1740932040.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740932040.git.christophe.jaillet@wanadoo.fr>
References: <cover.1740932040.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_mpm_sscaon_config[01] are allocated with devm_ioremap_resource(). So,
they will be unmapped automatically by the manage resource framework.

Remove the incorrect explicit iounmap() calls from the remove function.

Fixes: 97d485edc1d9 ("bus: add driver for initializing the SSC bus on (some) qcom SoCs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/bus/qcom-ssc-block-bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bus/qcom-ssc-block-bus.c b/drivers/bus/qcom-ssc-block-bus.c
index 85d781a32df4..c95a985e3498 100644
--- a/drivers/bus/qcom-ssc-block-bus.c
+++ b/drivers/bus/qcom-ssc-block-bus.c
@@ -356,9 +356,6 @@ static void qcom_ssc_block_bus_remove(struct platform_device *pdev)
 
 	qcom_ssc_block_bus_deinit(&pdev->dev);
 
-	iounmap(data->reg_mpm_sscaon_config0);
-	iounmap(data->reg_mpm_sscaon_config1);
-
 	qcom_ssc_block_bus_pds_disable(data->pds, data->num_pds);
 	qcom_ssc_block_bus_pds_detach(&pdev->dev, data->pds, data->num_pds);
 	pm_runtime_disable(&pdev->dev);
-- 
2.48.1


