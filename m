Return-Path: <linux-kernel+bounces-393957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80539BA7EF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620F21F21966
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21218BC14;
	Sun,  3 Nov 2024 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lmg/mFou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A818BBBD
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730665534; cv=none; b=MCMbJRQqEpSd10M48kaM300uPwt3Ffmr5IlYF7z3QXNozE7mfpMAJmvrcSpVkpW2iX7afUtbqpTHm22g77ZgeR+zOy0/PFwndctplQJfSOu1IKxcy8cBWbnT0QpvQezkq7xwITxepce3+4z+BZGWW+Al57ljYiERcug2Xr2uH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730665534; c=relaxed/simple;
	bh=cZwBTGmjr6rfYzjvCjzqt3F2sOSCzluXFpFbdAg6bIM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UF//1zhKGVVCcbOwW/29W48BYVaLaUSOob5UIPpzIvkbzc8c6aK5uiMyjScc5f55SIjVmMWpzKPBTx0JnCm3oWCFKIusF4E9JfcCtFdWMKcuDQuiTdPfqlw+Sn5vn81QUYvpgu8tIKwG4NMzWb9U8YFzmNkUxqCYLgvJ2Dgspgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lmg/mFou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC85C4CECE;
	Sun,  3 Nov 2024 20:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730665534;
	bh=cZwBTGmjr6rfYzjvCjzqt3F2sOSCzluXFpFbdAg6bIM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Lmg/mFouiglb6DAcaZEsbstX9VtAv7eJdOAwDppIfYNrznZE0221lQWhjBQjfnYbA
	 ZpSORstyQdezyIGVgEqV+3kuE6uhz4SAur6xh6rTYFhwUB2cWhVxPvIg4UhEnEyWtb
	 j2BD4DxrArqotIIJKxuFl3TcAmqf1TTgYoqNxaACCKjHYr9SkEaIe6pMY9lYsZO/6L
	 XPAoeNNMOYZoq3GABQO+K7nAlIF0asdR+riphzBAJdyubwTXhI+5g17MUTagNP2W3c
	 bnjuKVZAqncgIanXq4Oq/XXmXFsQIDRc87Yx5UjgE/K0WMlOhPmsg+Hjz73UKZz/l6
	 AnbpabAfXtuvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AAA38363C3;
	Sun,  3 Nov 2024 20:25:44 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy subsystem fixes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZyemfNqanr4J/kd1@vaman>
References: <ZyemfNqanr4J/kd1@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZyemfNqanr4J/kd1@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.12
X-PR-Tracked-Commit-Id: e70d2677ef4088d59158739d72b67ac36d1b132b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5aaa0bc6de9c2649fa15def775a6710c052c966
Message-Id: <173066554290.3246815.1347185153988255135.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 20:25:42 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Nov 2024 22:06:12 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5aaa0bc6de9c2649fa15def775a6710c052c966

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

