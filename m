Return-Path: <linux-kernel+bounces-319899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6304D97038B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5411C2160A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE28165EE9;
	Sat,  7 Sep 2024 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvW/ROfV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8841494B2
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725732825; cv=none; b=f56BK9OqFKidvM9zL2ShWkSvcKwKL9hXrXdwaIjUU+iACBv78H8NzLNM0z0YyNTycjbL2jVCwd0KDuZvNOmSb/tKgxipM4PtjfrmfHAAF3cWf08JVQmKGXOHEqLSpiFpx37Dii+62OLvXpFu0RvyzIoeMNilFj+JW4f/sPfWm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725732825; c=relaxed/simple;
	bh=1QRs/hXcDuMPlPwjRdAIdFMnT2wRDH2lePDLsIIQMwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QnfJXasb7+NJt58p/CoUOk+/H+qVgbm/fajSW6uM+/paNoDwJ5YfS9kBxja34TWsW1aAy8OcaKKoAQ9DtGrX8VKiUkOz+YPuXa0O13n0HnLW0xPiUMH0G7jmZL0ATLQN1xBZpOcxPI/AqEEn18Lnn9aGHyQtiFNmWR/OhDdpwF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvW/ROfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7699DC4CEC2;
	Sat,  7 Sep 2024 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725732824;
	bh=1QRs/hXcDuMPlPwjRdAIdFMnT2wRDH2lePDLsIIQMwI=;
	h=Date:From:To:Cc:Subject:From;
	b=QvW/ROfVZ1T7gULV8cZlOuT9aV0eL6lOwnxACV5ZUIwXsWnNo0mcFFRuv0aHYJHAJ
	 12r6OPUxhJ5VGpViyAvuZK+xpqObeBVfU404HKl8PipWU+gOsulF8lCrNA1q1mpC20
	 2fPEnTE1Nxohw0KLgZs/VdlQCazHSLVSfBCp8umJp0HrUW40csGf76GPthpNzKu4BF
	 d/mDrGe/W+lmGa36QILxx7tezjhd5Ox8QnBkHyzEVSuqPtdhB+UAT6tJcOw179NKEW
	 YGUnsr/dkkHtZiQhStFMjQGaVFY4DM5WPa3a5ZCvwPeZIhqRPfHLGtshf5o+FDHP6f
	 fTKYj5IDUhOtg==
Date: Sat, 7 Sep 2024 08:13:43 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH sched_ext/for-6.12] sched_ext; Add missing static to
 scx_dump_data
Message-ID: <ZtyX11O5oaRe_7M7@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From 9d547798509340cb4f3fd95accaf78178ee353ae Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sat, 7 Sep 2024 08:11:25 -1000

scx_dump_data is only used inside ext.c but doesn't have static. Add it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409070218.RB5WsQ07-lkp@intel.com/
---
Applied to sched_ext/for-6.12.

Thanks.

 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 02cc45f7d81b..d9b6882760d9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -968,7 +968,7 @@ struct scx_dump_data {
 	struct scx_bstr_buf	buf;
 };
 
-struct scx_dump_data scx_dump_data = {
+static struct scx_dump_data scx_dump_data = {
 	.cpu			= -1,
 };
 
-- 
2.46.0


