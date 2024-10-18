Return-Path: <linux-kernel+bounces-370814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A669A325D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1751C22315
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB4714389F;
	Fri, 18 Oct 2024 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+pjq6nM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C613D881;
	Fri, 18 Oct 2024 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729216849; cv=none; b=YYLrUqIOHlMNNwEDX7QG+CA3fnMqbTO9QreNHStU/OGXo+kqsMUWCg03VWW4iobcoqeL2wdWDjIRX/pQ8JNtru/2g3p0HdhKlQk+FPVQssd9OD/Z5EUlQ8KymTBTdsad1fVaFKkrHV2wfPYLYTt2UMoXu/d+jKrCw2xe3p4mW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729216849; c=relaxed/simple;
	bh=tmeUkOO2+OmDRv6US/Q2MchwJVW2LA5kTuhdFwbQ2+0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mv9bGDlHjalQ5OiWk4/D/Uqi0HDe4zTqshIdCgoJm8B/+sU4mL6ohf9ryCJ3b3pcnvtEF0EAy+fLPXiwoWVovXWcTYKe2B8YTDApbi8mS8bbd9WIiz9ZkHX6e1LxQXO6DCPLYXD9aswcv1X0bi3EK2VwRWo4BKG1qn3p1u4VzTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+pjq6nM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6FDC4CED2;
	Fri, 18 Oct 2024 02:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729216849;
	bh=tmeUkOO2+OmDRv6US/Q2MchwJVW2LA5kTuhdFwbQ2+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E+pjq6nM4ExE0tXd85fxR3+iF29d1Onh5HHP2sdYpxVuLGpWlETm0uJxcgUZ8Sjwq
	 ac/SVljYwFfaofnTkwRsCK1gsoJgQgVYRXxJ4ELPe3bTTm2jHnLPu5W4Zrw01rykNP
	 7ha9o5NOWb2rAR0lOAqb4T5/GMEN0YLiLB86uyph1Rl8ZvtvWTkcfP66KyQgjR3tAd
	 Z69T7k7DCg6ftcSqqvsznIoQ+ZZUO1COIok0fTGG340ijP13Tvbfp/flxSvJxlg+jS
	 a8YLWPGRJOQ2ri5MHbl5YKZGG8Q8v1C96YGav0nzuQMr6kGzfbjGKSFcSQWR6GTjiN
	 alrJ6p+3fLJHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D343809A8A;
	Fri, 18 Oct 2024 02:00:56 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241017224858.2175159-1-sboyd@kernel.org>
References: <20241017224858.2175159-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241017224858.2175159-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 6b5cca7868fdd2499384e21279fdab86bfa04997
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4b82e5808241239cb3ae2bff5a6c6767ea976cb
Message-Id: <172921685505.2658289.12782555293704302481.pr-tracker-bot@kernel.org>
Date: Fri, 18 Oct 2024 02:00:55 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Oct 2024 15:48:58 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4b82e5808241239cb3ae2bff5a6c6767ea976cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

