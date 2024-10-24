Return-Path: <linux-kernel+bounces-380699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AC69AF4AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94901B21E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84695216A0C;
	Thu, 24 Oct 2024 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpqnZfZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F6C18784C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729805373; cv=none; b=tQbs5tgXnsB6jK+4UFc5s1pp/j/ZjrfydMQ0htv3qC/nyE12c40aK1ff8ZA/QrmlbRFo3A/bC17bam94zEF+gujAAZmWlDE2c9uGVOJa5nOtuEZ7kBfHcOHtsb9gVZz225z1H9RZqAPu6zZxy3YNRY0TtnqAA2KNE2ZQL9FKTo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729805373; c=relaxed/simple;
	bh=VQGe16tYfTlnL1QJjw+PS3a5aw84KdJ8J1KjqPy+cwo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Gf52sxoo2v+P7ErOy122f6ZyjZS8xazPgp4Qb96poMgUdd7gEDcqbNR/mXVcpN8Nkx4mO3ofWo0BgxfU3ft3sIxTJjwod0IuXle38IJ97j3TKQOrUtSH2SYC4w4ACxvcqIvNo3Dyi9QLl4O2JQbZU4Uf8/UmdGlddaTndyEX5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpqnZfZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE1CC4CEC7;
	Thu, 24 Oct 2024 21:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729805372;
	bh=VQGe16tYfTlnL1QJjw+PS3a5aw84KdJ8J1KjqPy+cwo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MpqnZfZSjTnbIm42woQk26NawBBp0mz0AL1q2t4QH8qqO7Ejwb1pbKtQ+5Z9NjaGV
	 EQyfgGRDixbN9hjzZ4UC+mNern0r3Ur08EOKF+CHmXc4D0sJvtkOfkufZUMFneeeo+
	 S3+JbYOLO3Ih3u5mUA5k4aANQztKXgywQrZ8DAwKECCYf93we35xzF+orLJ4nq10Aa
	 /XYfl9Q+ch8z2rbQmsCf7VhTjjW74hzWCHVbdEHljYK67oQZ861L9m4zQDodOANzFy
	 rF/oLN2SQMTYGVPkQqFJBRDh+Yjv2iAzZ49GPTpjbqQupUlIpvfIXqioOaqtvcOtae
	 oAe4h/aPKxPfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1D3380DBDC;
	Thu, 24 Oct 2024 21:29:40 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.12-rc4-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241023233600.d309ab5fa8421e97d041bbc0@kernel.org>
References: <20241023233600.d309ab5fa8421e97d041bbc0@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241023233600.d309ab5fa8421e97d041bbc0@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.12-rc4.2
X-PR-Tracked-Commit-Id: 0b6e2e22cb23105fcb171ab92f0f7516c69c8471
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2cd8e4592c04b6725611ccce60f2d0f85383f09
Message-Id: <172980537925.2393082.15138599552074506500.pr-tracker-bot@kernel.org>
Date: Thu, 24 Oct 2024 21:29:39 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Leo Yan <leo.yan@arm.com>, Mikel Rychliski <mikel@mikelr.com>, Viktor Malik <vmalik@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 23 Oct 2024 23:36:00 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.12-rc4.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2cd8e4592c04b6725611ccce60f2d0f85383f09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

