Return-Path: <linux-kernel+bounces-264259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B974993E0D2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2341C20C3F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3DF188CA7;
	Sat, 27 Jul 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khw4NPeD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BF8187848
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110844; cv=none; b=E/VLo3NyE5HT+/1yLdPTsKC3Ip2KxzCqkaDWlfgmI/tnhufrZqDn9aVZ2h6gKM5RwaJEQ6+h8//xtJ36GbWfloBAjisCSTrNFQuq3spYVILxk1z0q0YOrEECtHeHixotUx41Wq+tnou0POIminQfiu44Fb3+Aoy3S5JXF3YXb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110844; c=relaxed/simple;
	bh=N15eqej5zl/9CSy17/FtPx7zY3tAyThmf6l1cHBjOE4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fIaDC6XmMvBp1FL9MhgTTEvxb+7zRLse9ZlA2C8vbAG9TewMrIYRC/D7YBJ2EXKtBtJFmqj543Ot+Bv3qwfl3YO9YVE4NQ2RiO7YJL46yFGfAnedEb7Rt4yK9QQ1xb/9ZdCoaD16bnDcpvBkcSY3+2pqovS6Qy44E2zz1Iejc+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khw4NPeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDD4CC4AF0F;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110843;
	bh=N15eqej5zl/9CSy17/FtPx7zY3tAyThmf6l1cHBjOE4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=khw4NPeD7+ufvdc4ReKEf3ng3s7LC1cUy40JO5bTdyz4qt95qPfiVZafxbjEjIch/
	 i+393b/Sx7Qx26F04drFOEB8EqfSDuTTHv9FJGnV6qO/b1d3Idls50hEqMCc3LQ2dG
	 nWBQX2qGh28srD9NahcAPxAJXF9R3jU+ujc1GW+J4xXnDQ/5VF9EmGixF4PvH4brGy
	 zIkpUn3i4VG5klgnT5Eb2PWOVHiDHHcxd0c6FY7HqttAqrccWzGCR2b4w2YGNsk8HS
	 qGqZvZTdfDAiA1Lx8QOltBryi2Pvg79hwiYlqaJtrnqqzvqhDfjUyZvbPmo4OXxbHb
	 kHc9gb/erifPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5DBEC4333D;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.11-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <e50192fb5b0b56a8af3c45c47d235cf5.broonie@kernel.org>
References: <e50192fb5b0b56a8af3c45c47d235cf5.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e50192fb5b0b56a8af3c45c47d235cf5.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.11-merge-window
X-PR-Tracked-Commit-Id: e975d955c07cbc2cd6a83a5d8235d8373441fdb9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 560e805047ad38898b423ef456e5368260e199fb
Message-Id: <172211084374.16614.4703959590518169667.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:07:23 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 19:38:35 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.11-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/560e805047ad38898b423ef456e5368260e199fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

