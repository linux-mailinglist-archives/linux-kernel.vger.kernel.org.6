Return-Path: <linux-kernel+bounces-395771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78E9BC2B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68A3B2128A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869141CFA9;
	Tue,  5 Nov 2024 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNomAKIf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FD8F62;
	Tue,  5 Nov 2024 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770674; cv=none; b=hU0j1osdKlLS0WGqZnPGNYsF3nxBXQ7Z/6VXYBpptoaY71MvFkzA9TyyYT/ZKNZy4zsxw49Z7x0fVm9u0QO2IUZEzyFyPv89rrV4M1zizitWSu18rfUJDMVNTXd4TYQhk7u5PtxJxnLnAdw9iIxrGq+WzpM6x7NaWiXZPVBeD5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770674; c=relaxed/simple;
	bh=Ey24GEdH76YotImuVoSeUAcRFspWSTyDjvx/6Eh9bQ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cdxh3V45DKN4qfA+U1Tv/YmtqTNpzprxFLyBZqJJy1XH1QSadbSmJ6tv2XktcqYDGwJm9I8LDNE9dXYVim6Zjvu22ArgdweAmF2oHjtvStascf+wWBrICjq5s8KO7F+fM/ZSkGtBeZRGqIL61X+Cl2UNvQn0F3GC9up2/7lmmc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNomAKIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A55C4CECE;
	Tue,  5 Nov 2024 01:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730770673;
	bh=Ey24GEdH76YotImuVoSeUAcRFspWSTyDjvx/6Eh9bQ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WNomAKIfH6Y1wh1TfZs+yK8WDuHbfs7DbAzJClHvj288uq/Uo66G7RcGfe5afKBrc
	 Cets2Vjo77hTG2kBz8Hl6Z54v71ruoe4o3fuYA1ReVTNAIiRY9Evpx2L0rGmb93azd
	 7iXqu7WPUiCN/ZQ9T0HQQu6JBznmi1Gs1OUA080dPuqbBxp0/TnDuY7zHZhwJ0fVUK
	 ds1OX4eoAyMFWociKYbAKWpilltaZ8Pf5Vzn2a2LqVqzT+rFl8VFtVVz3pLXiE9Ogc
	 ioYTor9lKtc7FmHOMKMKkiWR3TGboW8UX1FXdwzvXzuNM9yn5x5vnYObcVzTUGa29T
	 pd0Yh0/iN4/DQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1653809A80;
	Tue,  5 Nov 2024 01:38:03 +0000 (UTC)
Subject: Re: [GIT PULL] soc: fixes for 6.12, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <89b2c3f7-2740-4d85-b17b-ff7cb30c38a6@app.fastmail.com>
References: <89b2c3f7-2740-4d85-b17b-ff7cb30c38a6@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <89b2c3f7-2740-4d85-b17b-ff7cb30c38a6@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.12-2
X-PR-Tracked-Commit-Id: bbfbb57958635912ba472925622f2bb0bab5f06c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e1b3cc9d7f790145a80cb705b168f05dab65df2
Message-Id: <173077068232.79719.6602076160879176034.pr-tracker-bot@kernel.org>
Date: Tue, 05 Nov 2024 01:38:02 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 04 Nov 2024 23:18:26 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e1b3cc9d7f790145a80cb705b168f05dab65df2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

