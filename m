Return-Path: <linux-kernel+bounces-327229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5529C977299
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883901C233AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359731C0DD9;
	Thu, 12 Sep 2024 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnxq/xTU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955251C175F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172108; cv=none; b=IrcXMbMgel1jQBCCrThf1jyrIxMOl/F0cMN+GD0+rjgA98O9kIPdW2iMCq/44riQ5RN9QouqtPLqD3WqnK+2KrgpJEVEWgTfq3UsdKuqxsIP4P/oVL4xVE9JJWBx5A3PuMma/A6c2Nm/tBLXdpJn87db1/jFuJfwmqBAXtcGkdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172108; c=relaxed/simple;
	bh=BY/nMIl8gVt2eO0JCfBQjP8aUlLdXOO4DYz+gvc/Pzs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=thHymJ7L22gWLDIOgM1lEvpfWCCnzU7nupBokU5U+V63rE6v9HCD1Nd0mm1vazPNym4Ke+Nv5HINjUyiCxfJlnfAmAmWVM/tv11Cyl4DqZWgyB6n5SmHBezvikSovYZbcOGRQZng/WjghGDk9FXx5x2/55FmMT4LLBsx/oZHNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnxq/xTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DE3C4CEC3;
	Thu, 12 Sep 2024 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726172108;
	bh=BY/nMIl8gVt2eO0JCfBQjP8aUlLdXOO4DYz+gvc/Pzs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hnxq/xTUKQfDt+rRz6hrI3CQVtb5lkBFo2sEQ/+B5LTz+bfDV/4OI/VmfDDjkVGEb
	 8Y+fFdj9rVP2X/e3HCDtLiik2aYWZhB/oOY2SuSZGt0ZooR63m+pC7uGWRXAUwZp3H
	 0/wuk9+S0mkt00AFlVyTB/ypL6IMrKhILK+vODxk5U5d4psW5/Jh6vJ4LaO5dUjJmL
	 CEDnixc4Xh265SX7FzV7A8oj5ztLuiNeMV3v2c+88rEJAA+bfcadvQ2hvjBmjF+wXv
	 IKa8hcL2GsN7G21SisSrLxl4tearpQvNo8im73YuIITV32Fv4C6AOk7/izs0nAeEbY
	 kGWVc/oI/BVbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1583822D1B;
	Thu, 12 Sep 2024 20:15:10 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.11-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-61f22aea-eea4-4ed5-a803-92fa9df853cd@palmer-ri-x1c9>
References: <mhng-61f22aea-eea4-4ed5-a803-92fa9df853cd@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-61f22aea-eea4-4ed5-a803-92fa9df853cd@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc8
X-PR-Tracked-Commit-Id: 7c1e5b9690b0e14acead4ff98d8a6c40f2dff54b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8581ae1ea0d203a71851b21455c2d5167ba00e50
Message-Id: <172617210959.1705632.12738653586746207738.pr-tracker-bot@kernel.org>
Date: Thu, 12 Sep 2024 20:15:09 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 09:25:44 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8581ae1ea0d203a71851b21455c2d5167ba00e50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

