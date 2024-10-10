Return-Path: <linux-kernel+bounces-359948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC26C9992ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C1028885B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB5A1F4FCD;
	Thu, 10 Oct 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNYXfswn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1CF1F4FB7;
	Thu, 10 Oct 2024 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589311; cv=none; b=oTb5VUj6JRREhs5Kfla4MHlFb2XI/7a1c/v5/3Xv/EgnHO43uf3OwUMTXo/w3s4Up1ycFNjn2vR9Yi3YiSkRsoDli48FHO3uHlwPo4r974kJwsBV5Hhcr1K3tbvHQB21vqieuGQnzpcs9yt8Ap/xcgvrYnP5hT3qTyMzL4CVNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589311; c=relaxed/simple;
	bh=t6uCfFtEFICuupnzh9+lQsalBbungN5YYQ9DTMNH93U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E/mx1bFNLhtdCIGtboRqav/+Ruq2kEMpJ09pmFrM6EuS1zbCeiGZqsoD4V7yqHKnSY0EGueh+F6o4cvOv+rc0f9e/oYN2r+npqOZuwNj0OevWGFe5XEMPWOsgkNUT1SCjTo9vdB8tOXbtrR3YyJ3edw2iI6jhJUI18lyyIySnnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNYXfswn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E78C4CEC5;
	Thu, 10 Oct 2024 19:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728589311;
	bh=t6uCfFtEFICuupnzh9+lQsalBbungN5YYQ9DTMNH93U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VNYXfswnGgvPv6wlj5fYj+9C/T3XTv83gpmVjAl+3pi65lqfcbNH0iYCgshciPdk3
	 DJdyYy1HjRluZVefdgcZy3ioczFnvdVtH9uzs6Md5OVyN2C9Hi1B9XnnOAYP69rVc2
	 K5ows3r02FaEFa2xXvidrZ36ZBZN2A8vdPva0Rwv3Ps5PknXuAQ98KZ5PjLnHOQp3d
	 FYU5/ODOSrYN+wwUssFbSw9L/Lmx+lE1vjwcH5vykoMRqsctWDKYmBSMEl5OXv9LgS
	 j9cOm7ecv0tUF+ff8wUQ91Ngja6fGm9F2hFCPt5bL6pJCOGJg1+/sgJRvJMJFN7e/j
	 XZxyubVwicqXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFE33803263;
	Thu, 10 Oct 2024 19:41:56 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241010172641.1027485-1-kuba@kernel.org>
References: <20241010172641.1027485-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241010172641.1027485-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.12-rc3
X-PR-Tracked-Commit-Id: 7b43ba65019e83b55cfacfcfc0c3a08330af54c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d227fcc72223cbdd34d0ce13541cbaab5e0d72f
Message-Id: <172858931549.2148416.5277556015563366735.pr-tracker-bot@kernel.org>
Date: Thu, 10 Oct 2024 19:41:55 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Oct 2024 10:26:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d227fcc72223cbdd34d0ce13541cbaab5e0d72f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

