Return-Path: <linux-kernel+bounces-397183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 710299BD7C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1FDB20EDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F42161F7;
	Tue,  5 Nov 2024 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4hgkrBt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38693383
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843046; cv=none; b=N4bnlGxu4WgDf07IOWy+9ywQOU5t+wSYmeeopmGblEZdv+TZBJUD0BCazQ8TwUqvKdBojYuv13zX5BmnDNb4uep7zUaWkG6JGY7Wuo+EgTaougvZi6Yl5rAI8A4D2XORyVD3uCcfkRAY4IWCmpwfg0dt32kLO5hdOE95tUlt/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843046; c=relaxed/simple;
	bh=k9uXPkBDfxRatNzO2TftLe8CfGjA3UZHGRc6tEFljm8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SADqMiZArmMhP/RIHS0S92SxbPC0LBQCeqIvYftIrOUZOCGSZs5grMqbuU1grz0b0OGQKi5FFbqGlpwHJrpdQwJbvBy5T7ZPwhaWoiznKFyf0LjfMlxjktOMt79E5WqEsAskV2kDU4shFRSQbhS4pVx5zdiUXrU1NKY5lTgqNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4hgkrBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C510C4CED1;
	Tue,  5 Nov 2024 21:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730843045;
	bh=k9uXPkBDfxRatNzO2TftLe8CfGjA3UZHGRc6tEFljm8=;
	h=Date:From:To:Cc:Subject:From;
	b=A4hgkrBtwqgzo08eiI8LHV/KX5dOp7jVNPuw15v0afRfI+XqVYscXNsunxqUgx1Re
	 KELPFZVZeymD0e7hXJ5Ba5PVNDJTLVWzf7e5b70KAXfQZVuu97T/D51euXTJODYOuo
	 Xln5Jxh1E+AKLHukq5r9rGPUsEVpNdXsJ1hNl8gfKdV2/tcyqj0cLkB9edCljt4v40
	 L34FKKadCt6CZXmCNT40oY2U9HbkVUQ5dToPXOScoUEYZpQrbNuTzi1i7iffJVMvbc
	 GU9HmWNKEDq1mWV5+FI9znm8hAK/7fQbmAxWzP8Rr4RPPBFrg4mCA03R3aT9iyhxes
	 GvGO90rePtUtg==
Date: Tue, 5 Nov 2024 11:44:04 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@meta.comm, kernel-team@meta.com
Subject: [PATCH sched_ext/for-6.12-fixes] sched_ext: Add a missing newline at
 the end of an error message
Message-ID: <ZyqRpGpBrsnfHOxy@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applying to sched_ext/for-6.12-fixes.

Thanks.

 kernel/sched/ext.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5225,7 +5225,7 @@ static int scx_ops_enable(struct sched_e
 
 	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
 			   cpu_possible_mask)) {
-		pr_err("sched_ext: Not compatible with \"isolcpus=\" domain isolation");
+		pr_err("sched_ext: Not compatible with \"isolcpus=\" domain isolation\n");
 		return -EINVAL;
 	}
 

