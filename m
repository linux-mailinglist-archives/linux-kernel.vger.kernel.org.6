Return-Path: <linux-kernel+bounces-516445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055BAA37198
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 02:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D7E3AC650
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 01:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACDE199BC;
	Sun, 16 Feb 2025 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDQcdkr4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5577117C68
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739669466; cv=none; b=nrYzJGZye7KKxY3wpYGLiiP0qaPFe6n+eguMaAVnb8K+Ptml4qMJY2eVfeHqzEU4qvDl7lOTZPXlvdp7QQXivQsftfRWDyaPi/xcuNpckvDHIzkxE4x+i+TULzERT/EJf2JnIQC+tO0P5TlavJ1SuGnKY5KDk4GKkSx6Ej3WisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739669466; c=relaxed/simple;
	bh=hFFiHr4E91F1fXunggl9DiCUDyEf1CzEFej5WKG/cnY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U7/+B8KVcBzjZCLwFxy+/AnMMaoweBEo9AqAyo/S0uTT5ZziL0YhhOodZe8ZBweZ4/uqXRnFvoVo1TjCZ8uhpGecZip1QoNt8Z5aPMXS+Hj+gAp61KXe56SxSmlq2GiiPKTsmccg97+5sAbBfoyyTcT5PXa3qpf5V5MipOmcl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDQcdkr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BBFC4CEDF;
	Sun, 16 Feb 2025 01:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739669466;
	bh=hFFiHr4E91F1fXunggl9DiCUDyEf1CzEFej5WKG/cnY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cDQcdkr4tOgcqu3Y1WdbVlvoijYzD9IyPR9YXFnpalFgwTt0glySrh+VpA+ymsavn
	 1wSYceDX39E2K9wNqEwjnXbSHKkCV48pA0fo9Sd3JsZHOSnX9JSyi/1tRlPJARK9t9
	 UoK8M21rKLeJzX2L9Vmwesy8tMDo2pEHEwN+DeaPciH6toahDPdhdN36WQkkR9gs+d
	 0nbAq3diVgIOY9erk1g7Znx5oiCsM5bi/GPLt/k3mX/xfJibVk/5wDhG0iXqsTenSA
	 EwtsbZnpIdjrbU6jjuG06YMarQf9d3drPOb2iycoyDxDrQYSuMNpquVTEx+raYGh4L
	 5LnOG35Gu1g3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EF3380AA7E;
	Sun, 16 Feb 2025 01:31:37 +0000 (UTC)
Subject: Re: [GIT PULL] ring-buffer: Fixes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250215144719.404616dc@batman.local.home>
References: <20250215144719.404616dc@batman.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250215144719.404616dc@batman.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ring-buffer-v6.14-rc2
X-PR-Tracked-Commit-Id: 97937834ae876f29565415ab15f1284666dc6be3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5784d8c93eb0c3b26cbaa86237c3b106657fc0c1
Message-Id: <173966949574.2369003.11483158069375403184.pr-tracker-bot@kernel.org>
Date: Sun, 16 Feb 2025 01:31:35 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Feb 2025 14:47:19 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ring-buffer-v6.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5784d8c93eb0c3b26cbaa86237c3b106657fc0c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

