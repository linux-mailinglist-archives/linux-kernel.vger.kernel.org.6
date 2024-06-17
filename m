Return-Path: <linux-kernel+bounces-218283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECF190BC17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C0CB23BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90BA19AD4A;
	Mon, 17 Jun 2024 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV+YpJmD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9819AA56
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655644; cv=none; b=gZMqN7DomBOD07UpDvACesc7kmA99wh1Mr0GozVXT2J+gB1MyVGEkUy7aYF1DuG4rPTLjrVpVhENiCQGZ8fx94TO1eOtKYU9GxfwovvuEFLXQYTzOtsyDc8geImuPFWru1ZczpNe/+akH/PSlnhNYXiAgz9/9lY+L/0bH37tfAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655644; c=relaxed/simple;
	bh=7RbJqna+1T4cSobG4TDyCX5HgcApAHuCihoDRzcd2uI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Bp7e6YMicc9xTnpG1Z9sqkVopcnvZjHfrx/0kIk60BEfzPJPYZcM/0scGRAYjv6ASSHqb14oPqJfpZn9XcpA5sWkdp1I9sEh7Mq/PZBHUImADxzd6FzC4+1AhWqDd3IrcIiTr6Kpqlr8YVYHqPWGwoqoazwBZsdOO4fQRFwi9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV+YpJmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2E92C2BD10;
	Mon, 17 Jun 2024 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718655643;
	bh=7RbJqna+1T4cSobG4TDyCX5HgcApAHuCihoDRzcd2uI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GV+YpJmDL/7A/lI5/sw1eNFzzWCqg1fUQu3SwNh7l9/Sv/sx+DXcCUHQ0MKoZ7Fn+
	 YsMVn3Th3Nlkyn7qhmhaWaOWZswD0igiae+lTpa2TC8AkkfkrRNnrN9QG9x995jm6E
	 AydBuzjGZIXoudoxjKScTSy7hU6SrWPmbKODsYSTh9wjOgnH+IycZVrkP90rvnySiQ
	 CMFB82PMhg1EBVuzg909o15ul9ZUhipbjZ4QRp5/aUn7NDlh8w16FQpjlegcaXf4be
	 mu5E3YmeYZedC97CHsrcvv2y+LCM2ZJ0nr59M87HmSM5gEZ9I5ipjgLVvs2JwnsUWI
	 beKhXYI4i0rJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A86CCC4167D;
	Mon, 17 Jun 2024 20:20:43 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <202406171116.7CBA01391@keescook>
References: <202406171116.7CBA01391@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202406171116.7CBA01391@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc5
X-PR-Tracked-Commit-Id: 1ab1a422c0daedbd76f9f25c297eca48986ddea0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cf81d7b0d926fd1080529bda3f6151ff91c9178
Message-Id: <171865564367.9005.2805062215210119099.pr-tracker-bot@kernel.org>
Date: Mon, 17 Jun 2024 20:20:43 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>, Christian Schrefl <chrisi.schrefl@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Paul Moore <paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Jun 2024 11:16:53 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cf81d7b0d926fd1080529bda3f6151ff91c9178

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

