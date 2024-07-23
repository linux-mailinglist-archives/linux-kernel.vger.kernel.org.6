Return-Path: <linux-kernel+bounces-260221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D035C93A4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649D2284B90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F711586EE;
	Tue, 23 Jul 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkPZ3fws"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3DD14A4C9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754289; cv=none; b=rSW2XsrdU61yrG+Eo7inAWUQyGEyOW4f7pCYH85t5iPXW7OpwWMpP8JZFljXhKzIIqxGwTq6ur5D0cli5TJvNcax/WA9prqWv/PkmC4O1/lQ8yd2qfAeQ5R9FzbaVT15qfTZF1+Ucx1IVpL4LnF8MX/hiVHLis0A3/8V1QLZqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754289; c=relaxed/simple;
	bh=c9PTkqL79X9Umrqdh+Bo1GOF1r7hj47eNw6X8ZB17/8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Bms8ZTleTP8JNBL60JjfIL4YIqRrSWV3R5RmanQwjfXO7nVCSgIMc1vmQFzdlNpO2YOLJJkzh/2uARF7fmiOqsgWLz/Z41In/hvd5TfmNvWe4Q85m63TjdSlqKPNSVbAwrchBe7Qs9AENN/iyj29xdfbNO8L8VfNZR2aPFMRBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkPZ3fws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A069CC4AF0A;
	Tue, 23 Jul 2024 17:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721754289;
	bh=c9PTkqL79X9Umrqdh+Bo1GOF1r7hj47eNw6X8ZB17/8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VkPZ3fwsKbz/89gVVa0On0IUWocaM1U6SoFkuuKwgs5SkAYfFAc9CiALLGyD2mtHz
	 IxY1ztuxk6aKWmAVijRk+kWyrNGvslKmtjopiPx6CF9gQ5kY09cJZq+0EQGrkWFSaY
	 +h9Lc0Jv6abmq9znV35mGWBSli4y98hVHlLwIkC1j0xB7lD7NMpif3CkNWljAUlzMx
	 sA2rUP03kLQ7NVg3zAn786SywTdp9u8KOHhcx69Fnzj7ke5AdGonV37pmRgiS5PoZW
	 xRP2/aAo9186b+9mhm4bpkJg0a+3mSSxKtfvm/DNwk23gBzgzKG+Jsv5lGUmhX3gqF
	 W1XwHVzs84l3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95790C43443;
	Tue, 23 Jul 2024 17:04:49 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for hsi-6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <g6m7rjparpj2iy27hgi347ctlf7qq7xyetonu2p5ylcwvzw7za@rjzn7mtxgjjq>
References: <g6m7rjparpj2iy27hgi347ctlf7qq7xyetonu2p5ylcwvzw7za@rjzn7mtxgjjq>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <g6m7rjparpj2iy27hgi347ctlf7qq7xyetonu2p5ylcwvzw7za@rjzn7mtxgjjq>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.11
X-PR-Tracked-Commit-Id: f02cfe6950479b04fb75cf8424a852af7c50d3ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5d2be66705c5ebec8a691707ab427d937c91b7a
Message-Id: <172175428960.5236.18141204084743219416.pr-tracker-bot@kernel.org>
Date: Tue, 23 Jul 2024 17:04:49 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jul 2024 23:10:06 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5d2be66705c5ebec8a691707ab427d937c91b7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

