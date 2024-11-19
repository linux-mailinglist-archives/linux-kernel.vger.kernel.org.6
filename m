Return-Path: <linux-kernel+bounces-414913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E9C9D2F31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B0DB29278
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C31D7984;
	Tue, 19 Nov 2024 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb2JgOlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F871D6DB7;
	Tue, 19 Nov 2024 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045969; cv=none; b=JGz52JPSfOdEzt6d7XQdSh5Y4drIvBRgtD9Q+XMA8iAf4ODGjulFYuy0TXt+SFJyCOCZV4Wgh9gQ4fEnWvV9cZSmsDxd27g5SaDXFMeM7+n+uVb10158yhJFpGj183kyE0J7fTtpQElNpeJRrvo+Ry8BK72k6701Eni2U+bhrEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045969; c=relaxed/simple;
	bh=pVgLmaGnmWjxTibFya1D1B6MMxM01ybL2YMX+BSB9xM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dfkRrKH6b5aX4Wv7/0PcYUkHsCnlgwo43okJtMSOyWDpXM+1IwogtzPjd2dljRDSS0QvmqUYcxsVEOAyfpHMAQlEMHXnHtVcRg1b8O6qUmCQZJd6/QGTGZYH4DoGvNQ+OWzx/ib19NrfrhfSW15hplFV7jlul1nN+qdH8R79+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb2JgOlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F2BC4CED1;
	Tue, 19 Nov 2024 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732045969;
	bh=pVgLmaGnmWjxTibFya1D1B6MMxM01ybL2YMX+BSB9xM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zb2JgOlAR1Q1j/90K5QAli5dqsejDSTjFNflEYGbjYjQ7NNnfLc2HI0/zT8kqZqZ1
	 liXajUO39P1z04A03BXH3tlpaPg5NFtHwz83/pcNhHD2uitkSWfBDovUTVflnZQC9W
	 h7Gy/llbn1WXo+X7empvFxCJ1etUbC7qITRTsDNwi4F3QUhM6ersoQkMYggw+EE/NL
	 8laGc2qKiLwIyMb0Yl7PM+iXLZd7/jNkbxPd5kdjkJcXVKC19DV3pOSIuCFc+Utspj
	 X+0Nx6Wtw9MHtcwLnL6po49BBLWHbKmah3mTYpcHJbf2DZtfMXvGasmd/dNUvRMBjl
	 EdlgTQffRo3Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710793809A80;
	Tue, 19 Nov 2024 19:53:02 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzsN9wNpuDnGqKnM@pavilion.home>
References: <ZzsN9wNpuDnGqKnM@pavilion.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzsN9wNpuDnGqKnM@pavilion.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.13
X-PR-Tracked-Commit-Id: d8dfba2c606ac9fa763ce3c51dcbf7335544b815
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cdf2d19038fa266806d15603d691dc2fd774858
Message-Id: <173204598093.668199.8245962651305524885.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 19:53:00 +0000
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 10:50:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.release.v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cdf2d19038fa266806d15603d691dc2fd774858

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

