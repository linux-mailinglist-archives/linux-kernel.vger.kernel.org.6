Return-Path: <linux-kernel+bounces-515551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A51D1A3662D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8848172773
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659E71D7985;
	Fri, 14 Feb 2025 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVo93mP+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80EE1A83E7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561348; cv=none; b=B9+qucELUVBRozpEYfDb1P+Mru3EeXzkAecl0OGwnrdKTDDR4HnFCEzVNlJ4rqpiZxdUDyRy+Ty7EMKDGOWqSRYV943QOBIJPyLhOIB0o6Z5PYHvNAslaxbo2zTP35cWl4jKrxS/WpO8/kY477hHZ88MrIDbcv1vHU2pZC048kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561348; c=relaxed/simple;
	bh=+7VksNpa/3dm1L9BXsVMsG9uSGO5yzfD5zy/e98F5Qc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=icUJ/rZjaZ1C2QDQ9dgbXtWOOpcU+Dd5iU2YHacvys78Ky6yUTq5T+jl066ukc1r81itGNnm1I/UIOHfFAL4pL0FtIYKfR1WySba8g246VwerIFQULQS+GFp03fE7uhhce3xlHnMkpeKY1mQNJ/riNRtVGOa0GRvILNcDJChNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVo93mP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5E9C4CED1;
	Fri, 14 Feb 2025 19:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739561348;
	bh=+7VksNpa/3dm1L9BXsVMsG9uSGO5yzfD5zy/e98F5Qc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WVo93mP+Gq1VLD80oxxdl1UoOYzCJaDpFAoMRwJdfhVrbLKdx1hMe/zO3EWs5HVJS
	 BnZ5Emzzqy9CzQaYLwDUpA1JpGX5lag1jdI0aHWtsnvRMkrXAgTg+rjkGrTi97/Jbl
	 0C9/70kYaN6js1GQ22GT0RjQZsO64kp6aQrwY24OyD0yzfcp9emD4yDiil7G5RjXeW
	 T1HuIJxL7YSZR5DOn8pu2gcF+H32NNuNwSimJM2pmg8hHnBi3OWe5xb/95nwoxFmdE
	 y/ydsWI+9OYIMIaP4iLllEYrTvr24lZDKYjQgwfX8c3iAMEEFeUgZtCwd6ti9z1w0e
	 H2Gm5Opc3GRgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF9F380CEE8;
	Fri, 14 Feb 2025 19:29:38 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250214075955.17913-1-jgross@suse.com>
References: <20250214075955.17913-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250214075955.17913-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.14-rc3-tag
X-PR-Tracked-Commit-Id: 75ad02318af2e4ae669e26a79f001bd5e1f97472
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd31a1bea3c94e01cb7b998485d2d7b14bdc8101
Message-Id: <173956137749.2081923.16521924563935375721.pr-tracker-bot@kernel.org>
Date: Fri, 14 Feb 2025 19:29:37 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 08:59:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.14-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd31a1bea3c94e01cb7b998485d2d7b14bdc8101

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

