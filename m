Return-Path: <linux-kernel+bounces-515553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F14A3662E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD18B172AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912931DC998;
	Fri, 14 Feb 2025 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcKyVPVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37411C84AE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561354; cv=none; b=TrGSoYP3i8tmmxnP0XBNNAc4HRA+xEKepHUnByu4am7ceo2JJcN65aiOcJ+zJrP1xVPRF0Tq404Z7IXFSnRa6cA8+f60tv/jVpDtZEYRyYWpfUzbVsokH+AhNKSUdAzjjh5RLF6v9jqvx88BVAQgEYMdwcWpqIBQbpZMBP0T7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561354; c=relaxed/simple;
	bh=awJE9QrgeTEUwszxUtUabCKGns+u81ppwPuPSYbKpEU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pin9Rtj8594jXjHm5YNecw2l8c6tOUruNCHULywPOWnBBJpxInxUbInmnpDnRqRKeTd+xGN7tv/0UZsiFd5lJWNEo+DZ0xBMQESKppZeJAQjgk5ZR0gEGufqXfgwciENEi0UI4BoT9OWobTmZ5bFT0llLXhlfwa/hJWMbw5n3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcKyVPVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADC3C4CED1;
	Fri, 14 Feb 2025 19:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739561353;
	bh=awJE9QrgeTEUwszxUtUabCKGns+u81ppwPuPSYbKpEU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mcKyVPVwpW4TG8psopJCF09SzbcGbFto177o3NsuIuq9x4dqriAGgGCoNWrxGQbVx
	 /SHOSJu+AfXLUq5eejRTsZhNWpQq3BBHYDaz4ZJ2uj6KVdJlTAgXJ9DxEY8utXq5le
	 zvh1x90ThptAPQy3jkxbi8r5FN8FSY5EqnrOT+G9wxfP1MSK720Ll6G7NoMdsc6VPA
	 tfIXjrIH9LVGdmwXktwiqy0LnbIyH4HdgDChj+BK/aLgI2Pu0ATn50RZt2jTqFlInv
	 6CI3qR1XoiVoe8BQf9kUoJ6YLAEgbQzYTkgbWcOFEE15jiXLEquU+p7NBzyGvV9E2Q
	 wFuYYeu1dQY2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34412380CEE8;
	Fri, 14 Feb 2025 19:29:44 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z696A62FFj_UkApm@slm.duckdns.org>
References: <Z696A62FFj_UkApm@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z696A62FFj_UkApm@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.14-rc2-fixes
X-PR-Tracked-Commit-Id: f5717c93a1b999970f3a64d771a1a9ee68cc37d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04f41cbf03ec7221ab0b179e336f4c805ee55520
Message-Id: <173956138282.2081923.1327205931179204322.pr-tracker-bot@kernel.org>
Date: Fri, 14 Feb 2025 19:29:42 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 07:14:43 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.14-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04f41cbf03ec7221ab0b179e336f4c805ee55520

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

