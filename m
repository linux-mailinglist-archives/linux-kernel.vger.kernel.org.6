Return-Path: <linux-kernel+bounces-178113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362028C48E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5967B23A65
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC171272AA;
	Mon, 13 May 2024 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IutrEA9B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA218612E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636018; cv=none; b=aT5svWux124dsiW6Y1ZnJxLRjDU4ZPCvM0+AgH6H+raHKvR825jTcD7uSi446TLnhLSvnAZQSJfg97wA6JtY5sgo0NB04PKiE5Svl2+FjzfW4WeVWkxpKC9qXJ2lG+fkhzXOu2Wq3u+u+3f6JfC6wajTtiK9Yza16ot2DFdjGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636018; c=relaxed/simple;
	bh=NPEoY07BN7zyypDIgR5w9AtNqjlreGY381GqHPuqTqA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t3TYxK3O7aWmtBj2Q+pzNlinluDQLdoG24xdAdufo9vERP5y1tYMb3lO3ZjDGZDEdOsYoLidBTXpn8h41T2XbSpfoTJN+QwIZsLZBqFRHJ6N+IdKEE6MIB4jTe1sNlKfUqIS6brLmb3HinArFZ9xuepJTAq6ca4bfR0eDZcc+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IutrEA9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C72CDC113CC;
	Mon, 13 May 2024 21:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715636017;
	bh=NPEoY07BN7zyypDIgR5w9AtNqjlreGY381GqHPuqTqA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IutrEA9BkYsBFRAVLL3VZ2j9cA6jk1zdoaB3Z1NVhsWoTL8HDLHG1WpOdMzF0NuER
	 BK0UyIw57PtxvuFd+WMUhQTMWlSMtEp93i7OqCpZ7kF5B7AjrfjLhJ9e4f1qrnu8pr
	 sgRuKkT4AiE8z+V5VajbJ7bLeBhkND6QUd3/W7EgrA1KpTMai6b/MXYbgK7kwfsi26
	 w2Xyke3PCgJJJz2UG6npLbLT5HcP4MfAfPCx+wh6boJr8hYu/2vrbmvCjlLtHHC3yE
	 qBOY1PF9wayrMpyo12df4PAHdlq9aDYuuJKeVbL+ZedXe4oTKnKADc16F+AgUMV71q
	 rO2tKurrbvDTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC4AFC433E9;
	Mon, 13 May 2024 21:33:37 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp update for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202405111220.B75A16497@keescook>
References: <202405111220.B75A16497@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202405111220.B75A16497@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-6.10-rc1
X-PR-Tracked-Commit-Id: e406737b11103752838cf50fd197ec8e9352bbf7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ba58f1ae9b2c07e2b736d187eb25ac8910a7613
Message-Id: <171563601776.15304.10528088979177870221.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 21:33:37 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 May 2024 12:21:04 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ba58f1ae9b2c07e2b736d187eb25ac8910a7613

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

