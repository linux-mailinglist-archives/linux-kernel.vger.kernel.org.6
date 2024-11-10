Return-Path: <linux-kernel+bounces-403392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1BC9C3502
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 23:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A9C1F217D5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2553815853A;
	Sun, 10 Nov 2024 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzhY4X1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA232B9A9;
	Sun, 10 Nov 2024 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731277134; cv=none; b=Iavi7m4ltqoK2spyWU8l//xWSKU3la+7oxGzrzmT2tQU1zYhgl4ZbCrj14aP8wQ7EnL+J4UmCLnnZLcAeVESDr56xt16CdarQOqu+GcGaEen0DtLnIxL0N8KXe01WSEPgntUUjggxXc1H41+c9Aq7GBpVyS2GPXAsKp8CAwy/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731277134; c=relaxed/simple;
	bh=jsHCxWX6oQIvxzlHDE0ckXWm2X+T5B1cqk45fi6Ogmg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AahOvsSaDgq7fPfi3rRGutZfXLM0WueIDWKz6UZshPzfUd0Hzxym1ZJxhjao3f7lTYE93rDZHakgE0H2Mwgv7U+y/kGRxB38RQ/QbZXpsc89WuCSySA8iaM/Wa1L9wsXnY9stCKfy5am+ZknDEFWsl+MNyfUsqEba7cUBKcmXoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzhY4X1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2392AC4CECD;
	Sun, 10 Nov 2024 22:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731277134;
	bh=jsHCxWX6oQIvxzlHDE0ckXWm2X+T5B1cqk45fi6Ogmg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dzhY4X1y1EuZCxEl7sMbQhOQRpQNd/lT0aVlB2GL+PnLY3eX4nPraZNOl3uVFSlF+
	 mIBrruxQmYOp0S++Fs10Z7teZuql7236UTLqID7gXsXA+J70gmDPEcwoUnM0o9D3DJ
	 SitjgDKFD9HXd2LDd4pjpQsrHStWzRuJmBq2Vc9e9oGQc1aQ4W2EAlxBY+z/6IM7fP
	 ff+0rV38RUwxfkbx+SbxNBA6aPvivhTWvO/GLbpcTJHs+kZFH5XHhmX90WC03jp6gK
	 sVCc74+BjoHQ31amxzSUMIbBB0h7m2sCX8uY0VxMWb3TH97SCZVXxeR0GQd0cTkuV/
	 FhfiBDfhkRDjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EDE3809A80;
	Sun, 10 Nov 2024 22:19:05 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241110215155.505460-1-sboyd@kernel.org>
References: <20241110215155.505460-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241110215155.505460-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 714398d8742d5e019a8e5512de2abb8db69ba0a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 541f3d87b6b7eb97073d0e5a46beae5ebcc0ba96
Message-Id: <173127714377.3230522.1466925452959246830.pr-tracker-bot@kernel.org>
Date: Sun, 10 Nov 2024 22:19:03 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 10 Nov 2024 13:51:55 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/541f3d87b6b7eb97073d0e5a46beae5ebcc0ba96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

