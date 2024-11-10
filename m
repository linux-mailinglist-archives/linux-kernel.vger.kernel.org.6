Return-Path: <linux-kernel+bounces-403321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE319C3419
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 18:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CF11F217BE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 17:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EAF145B3F;
	Sun, 10 Nov 2024 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwcYdJ7H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC41428E7;
	Sun, 10 Nov 2024 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731260642; cv=none; b=oUKYgI5MmitsnwPXAbqoXkenKP9F2Q1yK6Cg/YIArovd33lrIWt4LaPh3prInNspeTzHvi1DLTob44h6Pj2QsFM7RrQRmsY73cnryt7aA91DgWJ4NYOIdyk4wDuHtZfkF+40W4dGpCWE6z4p9al9Vyb69i9nzpGHn/JnRMkRNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731260642; c=relaxed/simple;
	bh=UFeYIkpPGaNK7DGkM2yV4J5J9wxhLaV5ec3JEJng1dU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fuG6qY9dIgw5+esUhrA3vTuyENwu8yh+1Jnb4s1QWUHzuz8elO3376Gyww1MWlfDnv4SkrO1dEgGbEZScyvGu27vwJEE6/ufyPvNjdjakmpWBz74i5h9OlSbzCepIvkm/l0S9nEQaPOHko3HS34tQajnHjvc9H3WWDrPcSvqdBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwcYdJ7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B5DC4CED2;
	Sun, 10 Nov 2024 17:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731260641;
	bh=UFeYIkpPGaNK7DGkM2yV4J5J9wxhLaV5ec3JEJng1dU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BwcYdJ7H+Ozzuo85JoUcwkNWlPFYDuuSZcbMjtYx3WALJdNFgDG2ogZhp1dOHpj4F
	 QA2nI0YOYjwaLtJvxSfxUEhzGmC5VjEPxjjFju2xWdNQo0hR24zFHod55xeyH0RTJD
	 QbzSunmZVJekCBr2uxc/F144mHzS69DKKrXzmu06P7MWHaTKPIFN7r1kDw07KNTdYr
	 rLgJmVAbKJ7xulfwVJ9mMeBB2T6BYpZlIjgRIw+Q/9S2zI8hAzEifHiUMv6asBl9X4
	 ueMoieMNJH18g6YRDdCcFksGz2pE6Hy+hxcQV6k4JEnQkefModCpKCAZq9XrXnrK/D
	 dTovLABP8YM+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC2F3809A80;
	Sun, 10 Nov 2024 17:44:12 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzBTXpQKqugWe1vN@kroah.com>
References: <ZzBTXpQKqugWe1vN@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzBTXpQKqugWe1vN@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc7
X-PR-Tracked-Commit-Id: 742afcc22d8eb5dcc67c1dc58ed249851e7cdbdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a558cc34936b48909c0c54f7efac8b6a2c1120a4
Message-Id: <173126065152.3189816.3139789391139795192.pr-tracker-bot@kernel.org>
Date: Sun, 10 Nov 2024 17:44:11 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 10 Nov 2024 07:31:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a558cc34936b48909c0c54f7efac8b6a2c1120a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

