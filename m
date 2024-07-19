Return-Path: <linux-kernel+bounces-257650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F75937D01
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0411C219B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD5814882E;
	Fri, 19 Jul 2024 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1efbUBS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAAA147C96;
	Fri, 19 Jul 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721417917; cv=none; b=uOgtm9Qg0XhA+kB4GGudo4JpNir/GF8WCeHiSkyBxwBmeGQaW9tP2dJ7DMv8qG5Sc7blrZm3+F5oFliLLTOolDZOPvruGIpAHdO77gUzFIHMb6pkziEruB/FuBEcSmtryAt8vTKuy2Q6B8lJMmt1x+89VBoECs5MGvRKX83E4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721417917; c=relaxed/simple;
	bh=a8DihCHl2xNnjVE3GsCRvXas3D1QG67EDDuAnZBG2sA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D/B1D0bv1x51KDexdSxvc5L4R0gSzYcivjtQrLaLxEdbYqRCrYDE+ZVPKosSpbjZPh+pfZczbrvBLP/pz7sQpk040ZBUdPLt5AypRnXREMjodp7QJLYzgupsdhTsDm8rR/+vpGy7nQHQrmUUDvk0FIZU+7cjt5qDR9kKhvMG2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1efbUBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62439C32782;
	Fri, 19 Jul 2024 19:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721417917;
	bh=a8DihCHl2xNnjVE3GsCRvXas3D1QG67EDDuAnZBG2sA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I1efbUBSeuh6mnD9MEQsSW9I+c95NR+r8nMQ5//7G1p7i5820789PHdd0QR5x5jea
	 KEMi92xDSL+AAYdG5wbsJCeUlkRO2J6Ck7hwaH5OqcOrtNt8EZt5fnCO31o65W0Qfr
	 +gQAuDduKFOQljcEO8snCPCfNpGgdYSyW+LRJ1vHLI1l3Het6kuFbMGUCERT5aRpTd
	 +eIIr9J4ulIevFBWtYRnQU0Rbh/9BXGAJRs2V7FL0QTGKrBMqYr6YWpR86uaS8rljO
	 y1U8Wk8XcARmGSqZoIASm5bzEm0ARC4AgtD218d8eyEnzOTXaYLMwLDFJ4n8oAawF5
	 9QXnBld9/52JA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AAD7C43335;
	Fri, 19 Jul 2024 19:38:37 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240718202519.3609846-1-sboyd@kernel.org>
References: <20240718202519.3609846-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240718202519.3609846-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 589eb11498fbf7de7a1bc8ff1f4b7592687dfd46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4f9285520584977127946a22eab2adfbc87d1bf
Message-Id: <172141791736.26000.11386217962004903643.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 19:38:37 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jul 2024 13:25:18 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4f9285520584977127946a22eab2adfbc87d1bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

