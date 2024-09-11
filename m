Return-Path: <linux-kernel+bounces-325499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0EA975A69
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9F61C23341
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520291B4C4A;
	Wed, 11 Sep 2024 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ0vavJ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FA187543
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079460; cv=none; b=MuI7ZISG+r+fD7zQCaVhGTmIC7hoY++vgswGkavX5V9ZO3/aT24Mu1fm2k1246t691yqqV7TzPc9Zoavx6d5OtwNXWzRgahO/2/pOgWerEFg0icoNf6jNRfMdygHxye9n/csHyjRpiIaAnL195O0RZsFakDkZYnh5qzM4nlW50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079460; c=relaxed/simple;
	bh=PJu19hHRtBZxiY71l+HTEvh4vWY6Vbzn9N0RtMa9Em8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P0zftf3gAvLOEpo8MaOMZALbFpKl5mhUMbbmTxuzbgyBEV7kqq3R6YYGMIgoN1pLaCyqHYeG31aM3qo70U7ljhd0aRcnAn0LnLNtIU4wJJQvzoiX0NrmP1XUbHQM8X9xppn5lCk4tg2slvll2QGm7lV1V2fxix1No0fhcr9WRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ0vavJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE63C4CEC0;
	Wed, 11 Sep 2024 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726079460;
	bh=PJu19hHRtBZxiY71l+HTEvh4vWY6Vbzn9N0RtMa9Em8=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=EZ0vavJ4S+kyuOk4960uPV7NkQH3zQ5QtMD7xoAFxITYoBQKHLRW0w13gzg+3twW3
	 tbM+bmS6/khiUVIQCFMg+P5STS9QCAFkPqFnX0VKPZIOqdrJhirgqryR9l8GfkBUFl
	 Os+QZmmAgbNMl6f5uuZ6QBSFMMIskEysEkKeZHYpMH07H6JASxqpAitJaOAOktkBML
	 er5V85NJcwlKj1M5LPxv+qIzCulgaPmnNT7ZUeTGPON8ju0F/aD7vtLG6rkvI+giQX
	 jlVuKFuAjcveaAxr+p9xQhGiWpKC/bAbUItawr3NesIL8DtDSzR43rQF2rabPUzKGl
	 vDud/VQY+Y7uQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3233806656;
	Wed, 11 Sep 2024 18:31:02 +0000 (UTC)
Subject: Re: [GIT PULL] ARM: SoC fixes for 6.11, part 3
From: pr-tracker-bot@kernel.org
In-Reply-To: <58c9776e-0e3a-4b00-bea8-47a7bcf2af37@app.fastmail.com>
References: <58c9776e-0e3a-4b00-bea8-47a7bcf2af37@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <58c9776e-0e3a-4b00-bea8-47a7bcf2af37@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.11-3
X-PR-Tracked-Commit-Id: 0e7af99aef5f58b4bae00e45fd1c2626a987f7bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77f587896757708780a7e8792efe62939f25a5ab
Message-Id: <172607946129.1012158.17735590154685557004.pr-tracker-bot@kernel.org>
Date: Wed, 11 Sep 2024 18:31:01 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 11 Sep 2024 15:08:02 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.11-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77f587896757708780a7e8792efe62939f25a5ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

