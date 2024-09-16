Return-Path: <linux-kernel+bounces-330158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5F4979A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814951C22AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C3F7BB15;
	Mon, 16 Sep 2024 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhzJuYuf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11923537F5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726462513; cv=none; b=PLt+gWa/dj+suspr4ZvOoiVenj/k/0r+YDv6sQQwmHcg4yMG3Fech1fL1TCb5jtV3RHc+jidFm5TnGRfzDB9q1d+XvlBtVjG/EOFJXuRFvy1VzYNe64OZTwAiIgR80kf7KgVGqr+LRG5ZbCnzzSHHZmxuzJGInK5+I4mAwlzwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726462513; c=relaxed/simple;
	bh=cANcuEvroi/E14l5en3+HBW+goBjAa4ylZzoZw/EXrQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FzW+0yqcoXK09W6WrXDG521XNhRWspGPzgtkuX+FXXrpkPsXaDLNqXf7ubTa5kGlZPOeYQkJBHnYQ2qvzgdCjZt9jYP7STsEwMPr1Yc3HPJ6muOcrPVIBe+0D1ajN1w/TRl3vcvOATYfL0QoaT1wOXV+BcWKpZaso6WRdRoVBck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhzJuYuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B5C4CECE;
	Mon, 16 Sep 2024 04:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726462512;
	bh=cANcuEvroi/E14l5en3+HBW+goBjAa4ylZzoZw/EXrQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dhzJuYufySXVq6GxSycnMX6jjyQNxNkVXbBfuXKHV///obuihuRk9PqAo1mxgaY1k
	 2eym4fLl06cb6QoJiB08K46VUaNYz8iqbPBtQSPFQPEndSGvRWVI3dF8K8wqpSbwAM
	 zm2Vl2WQ81E0N68y3EfIpuloAjvD2VbgOrN3FFtcWDDw1Wit1drMm5mwD8bpXtcdIj
	 MKTYUvs0nUBPc//IsrALYjV7eE6XvXlyT9MW1KjEyPdRKBCkUmZgRlu1KkZ3j/0BXf
	 1DE7l/nMn9VxUhmeVFzFN0UOaHovbV1dMSlyFGM0LFcsQ1gtROS1SVGynCSaCBWpsd
	 4zMWuCDUEA+Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEBA3809A80;
	Mon, 16 Sep 2024 04:55:15 +0000 (UTC)
Subject: Re: [GIT PULL] ras/core for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240909125425.GAZt7wAapqHkBB-5cG@fat_crate.local>
References: <20240909125425.GAZt7wAapqHkBB-5cG@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240909125425.GAZt7wAapqHkBB-5cG@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.12_rc1
X-PR-Tracked-Commit-Id: 793aa4bf192d0ad07cca001a596f955d121f5c10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0a63f0e1a9506c79df997e70f7fad95a8236b1c
Message-Id: <172646251441.3235832.6359264334406400746.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 04:55:14 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Sep 2024 14:54:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.12_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0a63f0e1a9506c79df997e70f7fad95a8236b1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

