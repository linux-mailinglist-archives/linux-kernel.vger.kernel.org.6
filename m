Return-Path: <linux-kernel+bounces-416269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332D29D42B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED26A2816DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3832F1AE014;
	Wed, 20 Nov 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyeQh1QC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98276158A13
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132302; cv=none; b=prZojtzI5DqzCkMtWDwhbcp6yIwUxAvMPtm22JksFz1aZCORC7vATzTUMIZW3oA0zsH9CzFAsqiKSVyWGTSsNOvw+Nbg4Jr4+pEjPe6yw3amYiM7nvmA16o8+Zwjg/etaFlQuNKxUGYC+4utJqGHzbkj6J9kqtgBaQeerXsG1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132302; c=relaxed/simple;
	bh=7Qu6SVBKN+IoSSjgG3AtvWrxW+Nuln1SKZsScO3+4BY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aNKyj5l21DyyM5E0iVjkWH0vNnVA9jVrNch8Un5K3aO5hJLzdHoQmPngiA+kFAr4hZG4gOHsByj3kWDseEG5nYpRZFvQiCjoE5ewFPlGK8lwDsuvBuX6JnYvSPB0egLugrX8xSWpR4GNTkkVkFv25EgNK+HQ1Pk17rKjRQttI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyeQh1QC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71106C4CECD;
	Wed, 20 Nov 2024 19:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732132302;
	bh=7Qu6SVBKN+IoSSjgG3AtvWrxW+Nuln1SKZsScO3+4BY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kyeQh1QCkKpq1P5mvHrxiugpoRcUdBKaZsSNW6lB81NWPPA5G7dk3Zsvkkg+lpqAl
	 GUibOT4M6akR6spmh5S4i0imlUaR1U3Ed+NOVNcpkSbciT4d7IydyjPM0oZkuPTD9j
	 JDeL31pqst0CLVrlMyltNwVjNtV+oXiOXcQmJGYzphZ4xGatav2zMVhrn7ZIg446zp
	 jAPIpGGTTHu05jkw99O197Y+En0ZDMVakHGoL5WNuPuwpYYEIXnoJX1sR9RWsXpW3H
	 JiEiZkb1FMq1Wvbe3PmOFfUcxJLc5OeubWmTWWLKd0rtruoCLqopy/W/jCtPRldAmf
	 JNDT0KNRJtJRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F343809A80;
	Wed, 20 Nov 2024 19:51:55 +0000 (UTC)
Subject: Re: [GIT PULL] ftrace: Updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118113807.7071ee24@gandalf.local.home>
References: <20241118113807.7071ee24@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118113807.7071ee24@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.13
X-PR-Tracked-Commit-Id: 36a367b8912a3aac023d9e35c815f7b1e609f4a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aad3a0d084513e811233ad48bf234fbfcfcd0a14
Message-Id: <173213231390.1329460.18344795944492887419.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 19:51:53 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Donglin Peng <pengdonglin@xiaomi.com>, Oleg Nesterov <oleg@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 11:38:07 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aad3a0d084513e811233ad48bf234fbfcfcd0a14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

