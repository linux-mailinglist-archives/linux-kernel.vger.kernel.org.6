Return-Path: <linux-kernel+bounces-319328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3579896FB2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53CA28A844
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176ED1B85C9;
	Fri,  6 Sep 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQW9h7Jn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF801B85C4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646879; cv=none; b=n+ClZxpu6k+WSUaKAZRi3WYoWoy6d+H3bsIfBgZhnjqYKl6AOe0l2ed8LvOeGYs+MjuheYSpt//RzDvzCOeu/McLoyiqIgsnCeCo6+ImlOBEWs/mVoAag68wnWx2U1Gxp9sqPoAeWz2xJ2+Ink5BvWfWBveXqMhsfe2IroZSOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646879; c=relaxed/simple;
	bh=zK90XD0m8M9jdMIZaYZa6++j3Ep0bZZOZR9M+gk+PK8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EvqnPnFOyGjgriPbG5/V5Ct4JZ9WwNmIEBBOrI0zYlVl+xGb4OCfg2qS1y7930EFj+3LNSWqDyu57SaX4cflja+Cl8l86+VLarPPXOlaSaY+vqTiQUBkLO7cYrfQ+y0uLEaJB7fzkaKw3T7Lb7xQfkeZBELpt5vHtYlINEyD/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQW9h7Jn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F46C4CEC4;
	Fri,  6 Sep 2024 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725646879;
	bh=zK90XD0m8M9jdMIZaYZa6++j3Ep0bZZOZR9M+gk+PK8=;
	h=Date:From:To:Cc:Subject:From;
	b=HQW9h7Jnw42g+UEaTl+g6wkqOxorrVN4AAZkMwZd+kF3xu14cTEVpoKWy5VmTY/bQ
	 uOvwvrbRBmWgcW8Pe+61BSqrCedeycL9p57bkO72snm2dApK4HpsllvVp6u7SdiqIy
	 vU3n90enNyh+8wupHuPlI90umPZu/9IfRHIPN6WeDEBgWm5t4NOtA+PTcV1Kw7ItWp
	 sg5SDKUzkGF6n3iAwndLqDvDz4/DCbx/EWClAvcaJkp71NHAviMLXBi14t6Jgj2dPF
	 zGTL4IVkr8hJQTww7oTr3rfDIFjDANQL1UjMbupIaNjnObxS2osBDTGlIFnnI+MtKo
	 c7qe5IPcln0hw==
Date: Fri, 6 Sep 2024 08:21:17 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.12] sched_ext: Add missing static to
 scx_has_op[]
Message-ID: <ZttIHbL6fibcRN_x@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From 02e65e1c1282b8e38638de238ac7410846898348 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 6 Sep 2024 08:18:55 -1000

scx_has_op[] is only used inside ext.c but doesn't have static. Add it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409062337.m7qqI88I-lkp@intel.com/
---
Applied to sched_ext/for-6.12.

Thanks.

 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index bd8cb37b4b2e..02cc45f7d81b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -865,7 +865,7 @@ static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
-struct static_key_false scx_has_op[SCX_OPI_END] =
+static struct static_key_false scx_has_op[SCX_OPI_END] =
 	{ [0 ... SCX_OPI_END-1] = STATIC_KEY_FALSE_INIT };
 
 static atomic_t scx_exit_kind = ATOMIC_INIT(SCX_EXIT_DONE);
-- 
2.46.0


