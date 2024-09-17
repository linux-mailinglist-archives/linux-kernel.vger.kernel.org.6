Return-Path: <linux-kernel+bounces-331755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D539397B0DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3E82891C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C417BB25;
	Tue, 17 Sep 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaR+c848"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABDD1898E4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580397; cv=none; b=Bg13juUHotve0hV//RUab2OA0tqGc29DAyoMJKE4EF5TPoW9Se5e29CghCylRoIo3v+x/h8BE5fOXewnlMPZnlN9M++k+t2ucSwWye52HY5F/OKXmyF0XL6tVZ5DA4G67VH02H/UVgLa3wf1c7XcU8NzmrvWuw8QAkcotJlq8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580397; c=relaxed/simple;
	bh=rQ0Z/uEE2comVhM8DsqXIi0ymZi7seH0e+ffAGjr0J0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N19Q8g3bUZxV6bffT76cNoZozTyvde7QF5tWd5eMUvLiKWZn8Ni4y9lrNO5sUgNxiBr/8MrcxJpnC1Uqz+R7OtcuSDj661KgrMHqg8XMMXRP3Z2o/j434PEIvnhEwpSgSZkKIsiY8RGJ7oPoIMSteQavhsbxHezZy8pQvW7rD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaR+c848; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815C2C4CED4;
	Tue, 17 Sep 2024 13:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580397;
	bh=rQ0Z/uEE2comVhM8DsqXIi0ymZi7seH0e+ffAGjr0J0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PaR+c848arwNirMbc8Z7q4zGwc97VNBGwomaNVBSmZtXgAVQCp08wVb65ETVYFDSe
	 7BkEfJ6uI+5iOH3bx8Y1ecjhg4pc+sFPqjjHhEkTm/8VC+AchEPuQcJOa5msECJQIj
	 Xgtpm4Mrj1LuoGd0FwKWBs2XY+BHVaXKWAC9OULZujfc7qlgMAUCVoSNo2Nqx3nNOW
	 ESQqdN6zRaDrtGNUZDwgQZaf6WjsocxkfRi/xd/hXU6qq/6I28JlNh1nzwZ4298M0d
	 Q+PFBrtNrLyvxLz8O9QlSnkDQvhalPZQ7RMEXt4qsgaagHLAXbeXgvcIszM2FKWKBb
	 0oG+2k2lW93Dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710033809A80;
	Tue, 17 Sep 2024 13:40:00 +0000 (UTC)
Subject: Re: [GIT pull] x86/platform for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172656199380.2471820.14920924502861484723.tglx@xen13>
References: <172656198112.2471820.6226852046770294674.tglx@xen13> <172656199380.2471820.14920924502861484723.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172656199380.2471820.14920924502861484723.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2024-09-17
X-PR-Tracked-Commit-Id: 22f42697265589534df9b109fe0b0efa36896509
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3233da6c014b421f16dce27955fa4a803b50474
Message-Id: <172658039916.145065.14787094315623029034.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 13:39:59 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 10:54:17 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2024-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3233da6c014b421f16dce27955fa4a803b50474

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

