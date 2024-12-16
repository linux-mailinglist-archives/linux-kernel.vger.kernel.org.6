Return-Path: <linux-kernel+bounces-448195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9369F3CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CB016D450
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B729B1D5CD1;
	Mon, 16 Dec 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSHeJLgu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096F1D5ADB
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384143; cv=none; b=BHDoGxuZrYJ5tnjKISnax+qu4/5narfQbhdd0QZMa6JX9Q5Is25axYQ2xKw5sB7N5A+HLSJ77ieztq/r+dkqOBf+Y7jbtgcHhKn+xCApEnmpa1ini/6WnxPH8T4PAiuk/NNNbtl1HggWWDOqLTeHGR7eIoMFr7Brg30ROIOeuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384143; c=relaxed/simple;
	bh=BtD+KDsatqmbrAO+cP/aGgEByIZp7auYPo+Z2NoC1nc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BN36xsrteMO0zaB+cweyYZQo0rn2e0RhPSTmiyzX/wUvA5l1BS+Vd3P1nT/4d1QSLwFq0t97qaNXxpyF2+DtmbUwhZttz2GxfWlWpMXABclVZcJwhauPz2+VDZhuiTy6h2n/dLSaV1qrk+YHjtcs5UikWJLEnRPPtbBsPa4XIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSHeJLgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E52C4CED0;
	Mon, 16 Dec 2024 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734384142;
	bh=BtD+KDsatqmbrAO+cP/aGgEByIZp7auYPo+Z2NoC1nc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LSHeJLguUnyTDHHxBh8dBeR6rNOFIkTHpWaZP2yxd+7xPemSSR4G+Sn/QlgA7nv2c
	 HHvWeq8yE/vgGU/V4lhjUeh9Fo25wn1f87YMvjeh8yzTob+vmcdpun/3TOTMVr/fUM
	 kOe4F+HmgNISEmr7ThEZsC0gd0KOXU0Nu7c5/bVEC4PNHY+X5tMj5WBITKd9p+kCwX
	 YhUAWiUn6gFzBZsyikyMlj2ngw0wxfgyf7D5+Xwq1k0e4cgyjyrwz8N22PsJEnXBBZ
	 U0W2wuOCYiifNpOxoRpBxbkS4PlhTXGLMGXnrRk55t2TOvvzI+wsAyM6UNDARC+yU5
	 e6SO4O5ddjz+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC6893806656;
	Mon, 16 Dec 2024 21:22:40 +0000 (UTC)
Subject: Re: [GIT PULL] soc: fixes for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <cccdf954-3374-414c-81fb-658df16325fc@app.fastmail.com>
References: <cccdf954-3374-414c-81fb-658df16325fc@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <cccdf954-3374-414c-81fb-658df16325fc@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.13
X-PR-Tracked-Commit-Id: f578281000c50cae991c40e1f68b2fc0b1b9e60e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f44d154d6e3d633d4c49a5d6aed8a0e4684ae25e
Message-Id: <173438415948.354515.11626612676903026198.pr-tracker-bot@kernel.org>
Date: Mon, 16 Dec 2024 21:22:39 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Dec 2024 17:21:06 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f44d154d6e3d633d4c49a5d6aed8a0e4684ae25e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

