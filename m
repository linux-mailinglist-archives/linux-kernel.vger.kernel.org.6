Return-Path: <linux-kernel+bounces-342018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39E39889AA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5821F21E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9031C1AA0;
	Fri, 27 Sep 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MztSNPIE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0169157A72
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457904; cv=none; b=Dpbs1GdGCkkoIFP0tL4gzatTAswnGcAV9EMd2lAz2AHxR7oav8uaicLyoBbTcQTcMVcETqDltPSxXR7/pb8/LMxnXMD1pgPJcfo1l3a+f+tmznwEmEO3Bh38dX77rhz+Ht/hG9qZc3iMyKT8GoFspwU0EUZZZGQh7WafBv3LLqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457904; c=relaxed/simple;
	bh=29dxwTfWq+jhUNeQ8ohqaNoFh2DsIBUvD4bZBGhlTbc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CBSkcQDDgKT4RbxHEWmUWmqJ/39GL3j8kvQ59w+sWXeSZzEU5ec463akQzCGEnHV8P8I2wSdGHC8Zrg0dlRcnF02ugWxoiEwQ73+QtxE8BUcSTC/iQ94tnxkbAk6V3vLeJkoB4xX+BKhXP0vqJhWvYybxNPjkpV0atHNao5v+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MztSNPIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F47C4CEC4;
	Fri, 27 Sep 2024 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727457904;
	bh=29dxwTfWq+jhUNeQ8ohqaNoFh2DsIBUvD4bZBGhlTbc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MztSNPIE4ghBgM/bjz8najz9Lrs9e/k02wRH4Oks+KNFDxoTOkOobh3cF9ss276id
	 iK3Gu6qEi2unV6Wn6FFPHn1lTYKX8tEc2Zd/wSAvcmpxCvjJGq6Y3177iSLdIWfIFG
	 f018eUEi5FNqErUDZBVQXxUH+AnvOsHEFj/bZehntjX98KIGtcmC9n2l0Oi9DT9ION
	 7JXv8aEKrBBQhMZJf9pkkY2IdrHnwi7kcpiSUgPofUaCuf4TKVqk6ZI/e0Qjot92Pv
	 MHFbxDAR3pd2OK+/vU7y1U4D7kslO79uB5hqpdnnb8R20p04XjOmOcKadnyY+AQdBL
	 u5HWofIMGmaBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7130B3809A80;
	Fri, 27 Sep 2024 17:25:08 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.12-rc1a
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240927094337.32387-1-jgross@suse.com>
References: <20240927094337.32387-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240927094337.32387-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12-rc1a-tag
X-PR-Tracked-Commit-Id: 47ffe0578aee45fed3a06d5dcff76cdebb303163
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 653608c67ae3dce1c5dee8c620ce6016e174bbd1
Message-Id: <172745790700.2030610.15308881267088417646.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 17:25:07 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 11:43:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12-rc1a-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/653608c67ae3dce1c5dee8c620ce6016e174bbd1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

