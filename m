Return-Path: <linux-kernel+bounces-254326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E880F9331D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4471285751
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481A81A2C11;
	Tue, 16 Jul 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ9jcHqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886991A257F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157945; cv=none; b=BmzQqXMGcl3KiELcFiVFPg5ZmCM9M8Q9i6jfVciHJ3ubimi9qUyOj1VDKAKRlH9DXohjwkKsXxmmOnAz6yHd7UaVP5wDBKN9cxGrh6va4R+DvednkONTPJcTVyUwuIfUOPjYzSqLP4n7o1AIPJdlR2VOvquHI1DMPTrKJ7aP4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157945; c=relaxed/simple;
	bh=OFSdpYLxcFKvMimim1E6mS4nzxf0z7jRMTgPHulwg5g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Hl9SBhsqVaKNzzcOseRqXiWr0yWKyOOGgLw3la4HXVlihzCwrPaewbAAV5hKNJ8vDkPkTVqyX/A96cpVHF6GH2H78+pvK6UeJ90uoo8MXxsq/9jPD9tYo8yjb6LoMXkfarIzwnCycyiPMQ910XzZIxihml9mBGWnXDf5vXKX+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ9jcHqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B534C4AF0B;
	Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721157945;
	bh=OFSdpYLxcFKvMimim1E6mS4nzxf0z7jRMTgPHulwg5g=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=HQ9jcHqSmr9ht1nDQ2Kjbo4Oj0Am5HJGthbfTpcVzaoAVQIB7BOlonT1ZaeZ9btb9
	 lsTFE9M315DbfJL+u4X74DUH9HtTacRvqGht5xjfBEC816cmKyznmU8FrgH2rETSmf
	 xcsVUqCLP/G3PKWRGToMSboF7YS+RVnXGiF0fx+CWIkrnS4a2Y5b0dmQtG6dO84+Ha
	 xEbo0XcYT0sOT1V4mOtNSM0x09pxyyPk87quNfDrwUteE83YTzhIZspGqoNKWhtMNN
	 8VIC+d4+SzJXjJwlTsmnakitZA9hNVnsvFaoAb6hfeomtJHagOVYHiZXbJmVxhYUxD
	 QLlGZpQnuNhjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51D18C43443;
	Tue, 16 Jul 2024 19:25:45 +0000 (UTC)
Subject: Re: [GIT PULL 1/4] soc: driver updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <1df9dda1-1f40-4e13-b79b-350690295ab5@app.fastmail.com>
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com> <1df9dda1-1f40-4e13-b79b-350690295ab5@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lore.kernel.org>
X-PR-Tracked-Message-Id: <1df9dda1-1f40-4e13-b79b-350690295ab5@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.11
X-PR-Tracked-Commit-Id: 49e24c80d3c81c43e2a56101449e1eea32fcf292
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc0f7c3f97bc6e888bf4be28a9da9dbd3735d2b4
Message-Id: <172115794532.10577.5205731531656423345.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 19:25:45 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 23:05:40 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc0f7c3f97bc6e888bf4be28a9da9dbd3735d2b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

