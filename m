Return-Path: <linux-kernel+bounces-540632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05871A4B313
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B52F188B2FC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10CA1E9B19;
	Sun,  2 Mar 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FHv+LKRi"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2EAD39
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932522; cv=none; b=P792ueb3GDoY4XBM8nzx/jlPykr39t9DAsx/B3y2kKPm+jwMW3yvF955PoNXKek4Uo03+xGf9yXhwn3E4LxxaPtujH6wigeqYJIycqV655NDpHJ76BfAbho84HiakV44b3DyEdsSsC2tm03QNZ40Nn3C0hkx5VijniJokwEANyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932522; c=relaxed/simple;
	bh=IjiqYfOaFT/5bcZk8bWzCldlSR2W+8zYw0RxG3snBeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IxKMgAFlTTP5BcF+ADqV6Ks0pEmHvX2lvXjnp3+FfYAZzrCtt8s12O4mvyDLSADhPlzRNvrs0Mzggqg4YZdc5SyzbSXiLSleVsCu4wG1MbZ0yZCAVYV1cbQzuEI7w6EAwpLmVGN8xuNGPJ3IvNMmMId3u6I6zAshu7gUXP8vfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FHv+LKRi; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id om4YtTJnYVX8Kom4btOvoD; Sun, 02 Mar 2025 17:21:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740932510;
	bh=iipt5Yn3YiPOXNMgfxQ8YWRnO9V/lrPEOyeJI1wMlbY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FHv+LKRiGR6lZ+NPxG9FsMoGQDc4hl+YDqaTSvO5ym240lMZXEu4ax7mz5cGl7FIC
	 UC40eL+bsSFicmSFH/DxOtIkjdPktO/02UssrVWWlgt7fb0N+rVKib1BXMKFrVRC/n
	 CTLwl1P3pRCMY52ndBh/TgcbFtjfObZUHZlxz9ft7/se4NPyDiJmp51QfsBPuTIrZQ
	 OkET8rq2EMnNjZWDjXVEXXJy6k9WX9ELhZRVvy6IAb+Mct2mc2Ovhao1MAZZGh8Ad9
	 Wtt0NLoKKPlZdtBGokikHSZRBbC2bKC4ppAk3Q+17p98n7puYLhvmug4OQvBnJ6WlC
	 6wS+NiJxWDrrg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Mar 2025 17:21:50 +0100
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
Subject: [PATCH 0/2] bus: qcom-ssc-block-bus:  Fix some error handling paths
Date: Sun,  2 Mar 2025 17:21:33 +0100
Message-ID: <cover.1740932040.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 should be straight forward. It removes some ioumap() from
resources allocated with devm_ioremap_resource().

Patch 2 is more speculative. It releases some resources in the error
handling path of the probe, as done in the .remove() function.


Finally, the .remove() function also has some 
	pm_runtime_disable(&pdev->dev);
	pm_clk_destroy(&pdev->dev);
calls.

Usually pm_runtime_disable() is paired with pm_runtime_enable() and I
would expect some pm_clk_add(() calls related to pm_clk_destroy().
Neither exists.

So I wonder if these 2 calls are correct in the .remove() function.
Thought?

Christophe JAILLET (2):
  bus: qcom-ssc-block-bus: Remove some duplicated iounmap() calls
  bus: qcom-ssc-block-bus: Fix the error handling path of
    qcom_ssc_block_bus_probe()

 drivers/bus/qcom-ssc-block-bus.c | 34 ++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 15 deletions(-)

-- 
2.48.1


