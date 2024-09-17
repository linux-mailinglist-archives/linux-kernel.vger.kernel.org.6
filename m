Return-Path: <linux-kernel+bounces-331834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DB497B1C9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FEDB270E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DF7198E76;
	Tue, 17 Sep 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRAsGDbn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A2198A35
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585214; cv=none; b=IJ6t4sGudYm4H5JrSjFpeu988QQzw8LCsohal7lQdlQhxhvCtx9Rm1iFsOJzni3HhC2fSxjhPieQrshMQJPDSsqitRJ1qB81FACdzstCgFVLfezF6Hox9V1du89FOiE3kxRDmbjPZ6srjcj1QbJTD3BZmi0H1X1CsZUiEnx5/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585214; c=relaxed/simple;
	bh=ZfgA4/JViSBsV8tmHW2to/KT72ZyzCULt7YAReA3E2I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d9co7UPGnM3W/muQqkEEzRAa2CqnMBeW2oNN+wjFoExK5Sr7VqrWNWC+ofaYn5wPYmLmXLp1HZpGk8D3ZZcyMwq8TyeO1OHGWI1PNw+8w5rgCz1Bl5w4WEo/Quf81NrJgdqN9AqUyykMLMCklmsbRToAvRT8gCb9qYSQ8LzWtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRAsGDbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9CEC4CEC7;
	Tue, 17 Sep 2024 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726585214;
	bh=ZfgA4/JViSBsV8tmHW2to/KT72ZyzCULt7YAReA3E2I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VRAsGDbn7kuTSErHGp7cLF6ciRRmALC3ywZRtwcLcBqfgCIuKhHH4pq999Z7HrBMM
	 enVX+MmlQDdBt6dlovswk+F0nw2MS4MU34vGtwxlHGrPdREzFXxTVTJHifrrlv70iJ
	 k+Z7PUzX1nnhHsJR6AYhE/LQqMaWXgbIS77pmKwc+smEvzZH/Gp4gaNJabgnQeZSU4
	 VRefB3xpo+kjIv5hzuQ/GGn5+lOle3XmqjRR/x6/TUHdVP10owEBWuZ9u1SCh6QtFj
	 n3UIBW1unEAwy+0+7GOZn1kzYYwZDWLe3QKWxZpRoBSnc3JpEF2e7e3dHKno4fh4cL
	 6ZG0Yet/wEE8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8393809A80;
	Tue, 17 Sep 2024 15:00:17 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240916143207.995330-1-geert@linux-m68k.org>
References: <20240916143207.995330-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240916143207.995330-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.12-tag1
X-PR-Tracked-Commit-Id: b90fae5df91744e45e683c17bb1a38e466770df3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8202cc803f3d0a0a7f7e4c08ce575634a0220406
Message-Id: <172658521641.168423.13820957370081838369.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 15:00:16 +0000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 16:32:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.12-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8202cc803f3d0a0a7f7e4c08ce575634a0220406

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

