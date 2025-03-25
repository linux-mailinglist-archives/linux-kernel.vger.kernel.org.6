Return-Path: <linux-kernel+bounces-574622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D469A6E7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949663AE3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30E18DF81;
	Tue, 25 Mar 2025 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myB4UCJv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4131448E3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863508; cv=none; b=dgKiY1a9gTCzZAIJsxEsTDnr++ecDQKFstXSEYO5eKNzvYfgIFYt1zggWjJuleoSVExJTYlQjFYWBSUYwlBuQm+mzAschrjkE5hLHM3Ip1DTtJK1Yt/tV5r6bOn3O1RmB72HSfGp5ZUPkzR/X59pP7RfWWjKxSOgkJNEBqfXzk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863508; c=relaxed/simple;
	bh=kVnEO2boUHGAoEROXF8vNSm9C6epGBf7ptv8wR0TQjU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Dfsh8ofATF80DER5AI75dqbo8eZLg8xw4wI+TpgrSck+khtaXB/pMyWTGZ0zvVMAXGkVpBDTnVR5O5p0d+39A57a97pL40M6vxLCfLKy6Qsh6vdMO1VmWhqeBue3Zad2+GCYkfNSU+g7pKnc0KbH3vU7KXq/mAhxpSVE3jkSwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myB4UCJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC16C4CEE9;
	Tue, 25 Mar 2025 00:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863508;
	bh=kVnEO2boUHGAoEROXF8vNSm9C6epGBf7ptv8wR0TQjU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=myB4UCJvCmkQJvNnVRnuwQIQetkKwUST8sIew2YMslP35Ox+IpH+DZ4p7uqEnggF3
	 APwvT9L/2h1WlpHxvGWeZvz+n8lxu17Jy7/Xk0yvp+p7N0JfXEzokig89xNux6kb8N
	 4KXUys8NGtARmL1kJ0lM1V83+Ddy0nNtKQT+NMiY7R8zgLLjdWfGF+QiRrxdnEhJ3K
	 UXmdKw5cBmPE4ptbFd50qW+zqUIF+w25MN1AXeRRmRWdh13P27Sitnw58ypayDqSqG
	 pesCkFKOQu5BCeLW8u8z/UYehUrWg4GYXlawO7vpA1PkhlNvQofHOSe9p9gT0HqPNK
	 QEytTTBXzf4tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE8C380664F;
	Tue, 25 Mar 2025 00:45:45 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Changes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z9xKcaAZyIwL6FYl@slm.duckdns.org>
References: <Z9xKcaAZyIwL6FYl@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z9xKcaAZyIwL6FYl@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.15
X-PR-Tracked-Commit-Id: 769a72d0bf80892581366082124e9d15b2dd6b08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b05f8fbe0f6886f7625f5565ece53261cf65738e
Message-Id: <174286354444.36585.5897148933485349527.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 00:45:44 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Mar 2025 07:03:45 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b05f8fbe0f6886f7625f5565ece53261cf65738e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

