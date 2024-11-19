Return-Path: <linux-kernel+bounces-413761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2161A9D1E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF17A1F22512
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6DE77111;
	Tue, 19 Nov 2024 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohG8TabB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E636A33F7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983497; cv=none; b=obY4KifM8qy9jG0778MbKkVWoqdUkI4AqQd6rptlkfZi5P+ryK5SZx51xVq2suZyql5r8lZPeU0axIeiPXUnPMBoVXz0Czl5pebrBj5UzD1R9EomRj+QEOjZSNIhU4jyICUHkuc0GLL/ciU64LyRBkvx4wU2nu1typW+yYE2SMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983497; c=relaxed/simple;
	bh=DcRycOtiWzofjQackcuJsMNNRJZFf5batUiKIeIjTGM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HEOfEuP1SgE1BCB+wWN8m+aIK+qF9QFo3B8wC0D5tB1es7FhGBclX05Y1o9LrXJ5CHCkdV+xKXHiIvUQXl0oeFXEW6rcw3cKIblDREbOpKg1metaTyIWUxuR/OEkBauwPdthh7y6KDhJsvxQx+pI6qAlTcH1Y6KayH4IIBBgu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohG8TabB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B65BC4CECC;
	Tue, 19 Nov 2024 02:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731983495;
	bh=DcRycOtiWzofjQackcuJsMNNRJZFf5batUiKIeIjTGM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ohG8TabBr07GkO5beMswccvk4DUHOTthPE1QMQ8kP9tXt3jUazbtB4Jf0S/yUFOxF
	 8d4DtMT/QwM7IKGyTq58uDhXUwzEXGeoOnxa3i/jFGmjq/A88WmLjPw4lvcDMDOOQQ
	 6z2RR6Q6JlKHF7AZx91ZIFaUEw0/vXcF7lQeEZP+RMulyREIYGuPSEWuO3r1oISnPW
	 GL/xH5IZw7t4E8CjdubSXEsa0Fun9vtEMy17HgqQZBbIk2dzgWwJhC1BzRrndCzB4+
	 kfKcFGWYqCLSKPCzotvmDWe+bI07If1PL7BFd7YphND9pMCEx/fk0n2pp77VVajKRX
	 PGr53z/mNQ7qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E723809A80;
	Tue, 19 Nov 2024 02:31:48 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115162301.28457-1-jgross@suse.com>
References: <20241115162301.28457-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115162301.28457-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.13-rc1-tag
X-PR-Tracked-Commit-Id: afc545da381ba0c651b2658966ac737032676f01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 158f238aa69d91ad74e535c73f552bd4b025109c
Message-Id: <173198350689.78263.3549741561220661524.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 02:31:46 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 17:23:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.13-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/158f238aa69d91ad74e535c73f552bd4b025109c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

