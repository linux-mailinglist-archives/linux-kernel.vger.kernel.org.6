Return-Path: <linux-kernel+bounces-337480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003CE984A99
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D6F28214D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BC1AC8AA;
	Tue, 24 Sep 2024 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoEPYdVG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856561AC8A1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201025; cv=none; b=Bka6Gd1KwGIptore1phOm+3a2Sumjqg7du5LkxkajoKRO1nBpHDW3XjKWEFsh2GYw76YFkyZllV1dEHRU1kKJTliIsOVBeznxx3zXp96O3sfJRCwsRxLAFX0EnzSt8Wg4iqz1AjlHlBoYMaZ6zauoj1aty58yHPLDap2lQZGfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201025; c=relaxed/simple;
	bh=5GA3vak+vcskMnKFtGHLzUYkEuM3WWPC5NN6MPyg4Kk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ew1dKkx1c86I0mcy51TAw+Qg6VnQAcgOGCEU18Xhayc8D/aCVJcPWIUu+LjhLfCL0e/m9EFg5qTck/C8qI9Pj6pFfv13MhGU8jvn3QttegAZYCkWxbYUbi/jc63xk3xb5kkVT7BdOjbzkAMSWIFaqnezDfsu2IhmFMZMctaa/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoEPYdVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18845C4CEC4;
	Tue, 24 Sep 2024 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727201025;
	bh=5GA3vak+vcskMnKFtGHLzUYkEuM3WWPC5NN6MPyg4Kk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IoEPYdVGt3Ca0EdNEt7d0TZeUyXVAqXL7/i3i0Gg70FkMK5G96GQR26i4At4jhou1
	 NpMs1LfCya2oCagxA5jq4bBMD6pD2JivfKjLPE1YC1mMw6+gnbOzDjRkVIZGngUlcz
	 eGzeKM+LKG1lusy9y4H6kEMBm5rC57Qt2Ujex3998wNwHruQHgqlhsmqQgdV3YBTVA
	 hXhst2/mXWi2eHUdJy7yT2/+lz9jpbURy48LRHejMF+jxiD4nadOI/4XTLQNhAFV2Z
	 WYXQb9TyOgNS8MnTpQBzErddcOEOYOl7GqOWzxyK7IUUMEcUs22FsopbTdKOlTT1wP
	 RufONa/pZ4OvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF213806656;
	Tue, 24 Sep 2024 18:03:48 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.12 Merge Window, Part 1
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-664fc7b8-c82b-414e-9c10-8fe7840f2c76@palmer-ri-x1c9>
References: <mhng-664fc7b8-c82b-414e-9c10-8fe7840f2c76@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-664fc7b8-c82b-414e-9c10-8fe7840f2c76@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.12-mw1
X-PR-Tracked-Commit-Id: b3f835cd7339919561866252a11831ead72e7073
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97d8894b6f4c44762fd48f5d29e73358d6181dbb
Message-Id: <172720102732.4145686.16906232207879534539.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 18:03:47 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Sep 2024 08:14:17 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.12-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97d8894b6f4c44762fd48f5d29e73358d6181dbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

