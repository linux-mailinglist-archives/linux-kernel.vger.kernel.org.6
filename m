Return-Path: <linux-kernel+bounces-418808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE289D65CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDE728269B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103BC19F101;
	Fri, 22 Nov 2024 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTch8VXK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1018DF7F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314745; cv=none; b=Uy2fCkCmb8X8jNmfqnhFzvpxtDa6Lv1Wjz4PXGBywNYOyaRBrCQ/TbeJhq05i/dNeIh3uWjHDBaa0ZRF9JV/mggJmKMexu513X/XwfyMbp5Ea667xOvfT+emGfyHHT7596W4w27T3sp+IPjcEiPb6k96oP3DA0kRGHYH2iOLb1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314745; c=relaxed/simple;
	bh=KYSW5HM9xkTMszZTdEBmei8yzvvC4EzqkyvcuDRo+BQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JdEhncRGZ+BeSHGmBonizOKIdm3NuYMqRjVgPoO/E205l+P+pCMAarEOtlnGCr9BOdZFbA4oQ1hZnTSS0eo9p9qykg8AzlP5wf/5Ef8U7gQqyyO3e22WYlrtxcQGNDBxVJphjz87xD6aj41D0Kw2vkaqvcMJn+0+MyJUQq8DooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTch8VXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D7CC4CED2;
	Fri, 22 Nov 2024 22:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732314745;
	bh=KYSW5HM9xkTMszZTdEBmei8yzvvC4EzqkyvcuDRo+BQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HTch8VXKXubiwlXPh7fvwhziL+7vnMXcPe03A8t7T5/pMdsdqZEi+4BHtyuikwy6/
	 VsmBOgJNoOtDJHtlvzmy4nfny03U64cQiSaVrhZfACUrOAKc3kPQ5EmiMVQU73Et+X
	 n2mDVFnHggVPnju5rgCT59peXgU30GQWMbIA2wP9uSTFfXevhGyepmyKOa99SJ1Ryb
	 lW4aMloBu5eWjORo1/8AMhy32izkQweeArIxkp2QgvM8ulQVj7Wjef/gFqoPNbv4BU
	 mQCXNZivouPpqbnwbCsH9LSlJGayUE1r1DWqJIwjkw5Z9+OXUcn0pGBavNygwA6jnQ
	 3U6yo+lcqL+3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF1623809A00;
	Fri, 22 Nov 2024 22:32:38 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241120011829.818599-1-dave.hansen@linux.intel.com>
References: <20241120011829.818599-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241120011829.818599-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_6.13-rc1
X-PR-Tracked-Commit-Id: 62e724494db7954c47b4417769f1225cf98f4d77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5af5d43f848e95019d0e018e67a7a341c6a5e00d
Message-Id: <173231475727.2827182.998817705293133603.pr-tracker-bot@kernel.org>
Date: Fri, 22 Nov 2024 22:32:37 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 17:18:29 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5af5d43f848e95019d0e018e67a7a341c6a5e00d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

