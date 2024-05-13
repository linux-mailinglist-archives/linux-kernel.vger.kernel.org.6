Return-Path: <linux-kernel+bounces-177812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C498C44EA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EBF1C22C94
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018F157A7D;
	Mon, 13 May 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p89TrQwz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88C156890
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616907; cv=none; b=LYptJ8Mr3o8P8I7644XB49WTrZdUouWKygbeyH+Zx80x4EpfGb/cbf43k5ephY/h/ECcSnqqa6fJnBpFT4zv1gi2eNFtmIhJJJlzHKJ4/614e7ToOpy82/IUxXf+oGuz+9ucOljsNSQaKPxD5ttMssP4p1iQzvEgVBE0qJNJ1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616907; c=relaxed/simple;
	bh=MgG0xvf71xpcp1gKtNXNJwbKp5uyl8H2joqH7EL11XE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a0m/b2vcdFapV5wsgRjrVDCnvDY+xAe/elIG7e8kM862t5UTFLnjG5wcdzRzH5+xJOPzLFbuzCat0mbzO5ZQ8OLGbqSFsn1f5kPV0USsLtVZ6DuWOOE/gbrary0jHaDSQWc5abaiPWD9tmHB+uTOBKdWhkbUqf0u+cAjnAkKx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p89TrQwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AADF1C4AF0A;
	Mon, 13 May 2024 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616907;
	bh=MgG0xvf71xpcp1gKtNXNJwbKp5uyl8H2joqH7EL11XE=;
	h=Subject:From:In-Reply-To:References:Date:To:List-Id:Cc:From;
	b=p89TrQwzmo8nW3SMkHhfAzcAsYpulWg6W7QH0tG+Jm79mXtv3yucV8zPtuGUbjzkw
	 5i4fs4m0naor3crHoRWW/uujk98oO/kw+l7x2So9umtn6W/glrmrw4bExnhFaVqlSg
	 Mirk8mw6QY7ghY7d2XPGg7gXIuz9361O+vvimCdY6Nw2y76axHvcDJta1y6Za9V4d4
	 u/5U2bU8eY8r8gBW/5dkc4z0USk7hszMUDtrV4olq6+2mqA4jlbYFL1jKPJwvOV7I2
	 X7QwOMR18lGSIxaQ8gwUOwbsCW8GzKAxhP6Gsy+a1GHuwSA8tF+RI20BgURgqg1d9B
	 5QJN4mHnLkG8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0761C433F2;
	Mon, 13 May 2024 16:15:07 +0000 (UTC)
Subject: Re: [GIT PULL 2/4] soc: drivers for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <1cba2868-92f1-45af-be93-2ad6cb59e86a@app.fastmail.com>
References: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com> <1cba2868-92f1-45af-be93-2ad6cb59e86a@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1cba2868-92f1-45af-be93-2ad6cb59e86a@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.10
X-PR-Tracked-Commit-Id: 1c97fe39fbac69b2e1070ace7f625a8224116ffd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14a60290edf6d947b9e2210f7a223bcc6af1716a
Message-Id: <171561690763.7727.5783087295060611560.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 16:15:07 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 23:12:05 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-drivers-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14a60290edf6d947b9e2210f7a223bcc6af1716a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

