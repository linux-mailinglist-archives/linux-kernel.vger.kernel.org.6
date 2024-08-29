Return-Path: <linux-kernel+bounces-306042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C13E963854
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5221B285ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262F83E49D;
	Thu, 29 Aug 2024 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZWbewJv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646B17547
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899649; cv=none; b=fmeHSKfPfjBeEIDnIWspRLYOMCuz1fgPUBjYJl7tHVJ5kbbYDBRKZVAKQEYSY4cNii0eCZpog8TmUNOYaThJ/sfJPrAH3/LG5MuRcCQWQKFXKOd1fhypFnuUAreliDXPwZIPyQDdjV/At1Yr4nknPRzzCtF4cw2Fqe7iZ7sFxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899649; c=relaxed/simple;
	bh=irIslndlaxchlvja7CvsUDMwG7MY8fRLfeiRdBMKHn0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tLShKhdfpOn2B6+Doz6M0JfO5g96rljBJn6lFW8NRIi6nAHRFWQO77bXSYnXkMYhWqX/rkdMxwQ2smTq0ocYon/BQVTj9ILpXfSgMMqu1AmzojfmqRu2aQFb5sROs59AKHcvNtDEbOaRebI44mOGq9l5XO2A2EvNcK9eVjeTqTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZWbewJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8A5C4CEC0;
	Thu, 29 Aug 2024 02:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724899649;
	bh=irIslndlaxchlvja7CvsUDMwG7MY8fRLfeiRdBMKHn0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tZWbewJvvzQ79MJj8t4kQkLFyQEYpF1c5hpjkvCBb4Pqn+OG1h3zze3f4tRetE7X8
	 w8MK316ME8o4awPfPGFYn5wbeR3NPQXef7QBCHX++wnOjzn83CaxYtgIjshOEQeQsc
	 iD1WlpalqYf1oivosnS0p6gCRY8euuXAl1VGb8l0KZcQ2eGI1rCjNgbp9oSzUtUpj9
	 ggvtzz7ZKUXv2Xs+wDP45kWiDGXzmYvWpvz8crkKfeorRuHoKqwVVvHnslpG0D71Eg
	 FcpFt54w/prmks1WIRu/ofe7GFgsLidOvnfKLFK7oL5YiD6wn8AnFxJjaWu/yQuuFd
	 35HdtLnMy1YPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0333809A80;
	Thu, 29 Aug 2024 02:47:30 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240829004246.3433304-1-Jason@zx2c4.com>
References: <20240829004246.3433304-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240829004246.3433304-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.11-rc6-for-linus
X-PR-Tracked-Commit-Id: 28f5df210d06beb5920cf80446f1c27456c14b92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5d547aa7b51467b15d9caa86b116f8c2507c72a
Message-Id: <172489964943.1501603.9117179467892007111.pr-tracker-bot@kernel.org>
Date: Thu, 29 Aug 2024 02:47:29 +0000
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 29 Aug 2024 02:42:46 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.11-rc6-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5d547aa7b51467b15d9caa86b116f8c2507c72a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

