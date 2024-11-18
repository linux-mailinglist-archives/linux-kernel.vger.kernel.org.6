Return-Path: <linux-kernel+bounces-413177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1B99D149D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E9F2833E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE101AE01D;
	Mon, 18 Nov 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI4Cfr50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96221991C8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944439; cv=none; b=ffefWqmLM5ydBPNO6TIttg9DHGgFntyNxZdSkwiBZeGVuAIwzY4VpplWnPHw+gyQ0P3rbdLQAdfKKIJFP40dHWtwfpnNWThxJp6peFPSXa79c8cxojxx2oRqSEbdI/cKtickhfxn6D0Sd1PttFIjU7sUZvwZKFEfv/JwDExt8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944439; c=relaxed/simple;
	bh=dCIpcRJOFAu0YQtEzjLzx/9Xx8PoRr9ebJYSbNidsLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N2/V09XLoNmmVP22YlHS4l5kBNAKkHnb2SOuxD9EpaQezB1P6UivObXhNBiPaECTXZAfDyIdcjFC6VfgXoIBK5lTTxC55GGxl3aZsyS/VE0pPyT9JJdqGlUKXP5eh/2Spdd2xHo4VyDS8yczZYafqcqcS0xyiHKnFWsxL6gKPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI4Cfr50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E36CC4CECC;
	Mon, 18 Nov 2024 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731944439;
	bh=dCIpcRJOFAu0YQtEzjLzx/9Xx8PoRr9ebJYSbNidsLI=;
	h=Date:From:To:Cc:Subject:From;
	b=mI4Cfr508pvSao94Oyj7RTfgOgurB0PR+VmZ8u9Ql9Gqglk0iQdxzd+B4FknYbQgQ
	 OdRYCOhfpbWSpcfEe+L1iccLfF/wWSy24gn5TxfYta8s1EcWtrRbNkcyEQTmDl/qZC
	 4REXi5q2JHCIRs9sdbSlmMXBr47DjJDLeJ3Rwct0HwPhez0b2N+Zbds+gXRwHCFXLo
	 //Qd2B5HZhTGK4kstHkVmO8+tEiz50StHI461kW21Hhm4xqrKdWdFIwAowL/Frk6NR
	 ksR2IoFjGEesbGM5vgFbEmQSg6sAPFV3MWwbjyNAtzGJvsvJP1Puu4XeKBNEoMftiA
	 F+nZ7j9U85Avw==
Date: Mon, 18 Nov 2024 05:40:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Changes for v6.13
Message-ID: <Zztf9nRuKNjH34Bd@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.13

for you to fetch changes up to 85f0d8e39affb7b88401b1e0542230a7af985b96:

  workqueue: Reduce expensive locks for unbound workqueue (2024-11-15 06:43:39 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.13

- Maximum concurrency limit of 512 which was set a long time ago is too low
  now. A legitimate use (BPF cgroup release) of system_wq could saturate it
  under stress test conditions leading to false dependencies and deadlocks.
  While the offending use was switched to a dedicated workqueue, use the
  opportunity to bump WQ_MAX_ACTIVE four fold and document that system
  workqueue shouldn't be saturated. Workqueue should add at least a warning
  mechanism for cases where system workqueues are saturated.

- Recent workqueue updates to support more flexible execution topology made
  unbound workqueues use per-cpu worker pool frontends which pushed up
  workqueue flush overhead. As consecutive CPUs are likely to be pointing to
  the same worker pool, reduce overhead by switching locks only when
  necessary.

----------------------------------------------------------------
Chen Ridong (2):
      workqueue: doc: Add a note saturating the system_wq is not permitted
      workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048

Wangyang Guo (1):
      workqueue: Reduce expensive locks for unbound workqueue

 Documentation/core-api/workqueue.rst |  9 +++++++--
 include/linux/workqueue.h            |  2 +-
 kernel/workqueue.c                   | 22 ++++++++++++++++++----
 3 files changed, 26 insertions(+), 7 deletions(-)

-- 
tejun

