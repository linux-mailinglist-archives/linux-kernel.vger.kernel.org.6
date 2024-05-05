Return-Path: <linux-kernel+bounces-169072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8AC8BC2B8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D475B20D77
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7426BFB0;
	Sun,  5 May 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy/qkBh/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBC5FDA5;
	Sun,  5 May 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714929177; cv=none; b=F3ngkMJh7mYn6QnxnuOCwnDEiKop9mlJI6j6ZwT1DwJVZHzvbXI2+zG2hT8awqsLB8POTWcJ7sGUPU6EQzyFPvOCWuL5z6cXdZLdfDB+MEgPfq6qYMrwbNK5VuScgtR/LR4zBX52kPn1T8LpdS0/3WJH3MmDhFyWT7UTOkIivs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714929177; c=relaxed/simple;
	bh=TLrWxOuOKBiUJEi/ZXLikWqlOdz33+N6Z/idgzgYvOI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VOy5HXijKzk5gb+8hKBRy+cso706LIeVgltdMD2KEazER4Fm1kFPotZy34XZFWwjaDV1H2I2aBi+F/kJ8H60z2cGni46GaljqU+wyqHNPd2bJp2WIHZa8emjXh014AjV99+3Wfxd9bgx3FURgz8SdJivF9dm47FJiNW3N0gWNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy/qkBh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C971EC113CC;
	Sun,  5 May 2024 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714929176;
	bh=TLrWxOuOKBiUJEi/ZXLikWqlOdz33+N6Z/idgzgYvOI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jy/qkBh/fu97T+DpZvAqnzUYJIws5tgRAQp7Jeu7uqwM1c/8MwmVUthid1MTOMKFj
	 oKF2cVe5VZQHlTqhIljihBEPxOnkpmCYg1fMa4KvMA1bA89gNyhbw9J/nM0BP23Ukx
	 Yn/ci0p8Znn76159o47+AEfLzgsn2pRa7UxtNOtcKilWjgKxaVZVta5F9q/fJkWleU
	 CPkMXlGifzOrcQGbzgblkONjDwKAAJaENXkaCbkTevLKLCgI34Ury5A0HrhFWLGHu7
	 FOdlJtFBUD3PpdOTDiEemPe0zWJAggJi6mH2yfyMqZhkjnhmCBihpRu93b5KfnZWGz
	 BqAVzxMuRjGNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0EFBC4339F;
	Sun,  5 May 2024 17:12:56 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240504030607.999295-1-sboyd@kernel.org>
References: <20240504030607.999295-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240504030607.999295-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: aacb99de1099346244d488bdf7df489a44278574
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61ccc8c3e59a8bf0b0ae046bbd72bd23846b5fa2
Message-Id: <171492917678.31500.16948879549560305604.pr-tracker-bot@kernel.org>
Date: Sun, 05 May 2024 17:12:56 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  3 May 2024 20:06:06 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61ccc8c3e59a8bf0b0ae046bbd72bd23846b5fa2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

