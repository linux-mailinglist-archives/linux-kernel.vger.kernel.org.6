Return-Path: <linux-kernel+bounces-563122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C00A6373D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDB9188F1E4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764C21EEA29;
	Sun, 16 Mar 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1GSjW2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB91EDA19
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742153299; cv=none; b=jVJLOutOH9+watd19vdAc/boOHfaovHTjLYjRqPoIdN/UOy53/t2ZsLIHfBlqrT1CDPOPl2hBNbQKjFmjoHKbdKwCZBtPh7FQT/3jApsnYgwsqduzAi2RmzfB3i1HZ/UW7Sg3H3NWinBaSnpU3MixomJxABEvMSzhF07QdVXG3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742153299; c=relaxed/simple;
	bh=MUjtwgIZz7j4PRg5R2tkXug63BWHk3d3uNOIpZBuMDw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oTsgqR6/J9DfER9403Vc944xcS9G/AvXGGX9EoMZ6fJvNdcrDdB6t41vID0xzQCQwh6OcYOU6ljOGviypR1+NwK36RPtOjHwyIbE3ikSRnswUPsnaYQD6cj4pUqUi3drXzKbMSxmsuaY0t7mACmIiES5pfjfNqldbMPyJLR+OK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1GSjW2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563ABC4CEEE;
	Sun, 16 Mar 2025 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742153299;
	bh=MUjtwgIZz7j4PRg5R2tkXug63BWHk3d3uNOIpZBuMDw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U1GSjW2zJJeR7wTxIXKFi9M6NA1J4A0XyFV0om5AaQp1N28ZdxP+Idsc3rUm8fxwb
	 aY8V57VqzDzCpNDgw7GV8LZxRfJMaIL6RfL9Z8C+Y4Iuzc1vFJbI+hpmQPyzQqQMAQ
	 mfhX6xIAfpZWq8JHXvqAsjjtCHzyRwQv6Nyg2zkGQyyfBBh8rFjbHgJLddWXC7HvnI
	 wR9I8RjCuMSfAOjc5smvQJ6aU3V/KXV2loYoIMQnilwUBhbHwUBvL3E669WOrmcRXv
	 Z98OSrIxJNg11CkjU65qfqSwkSxoovYI2SI+41HD3D0OdhLIb/YLq9c645zC7gIspM
	 lWTKAoLrDOzgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3F380CFF2;
	Sun, 16 Mar 2025 19:28:55 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fix for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250316131827.4d989e91@batman.local.home>
References: <20250316131827.4d989e91@batman.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250316131827.4d989e91@batman.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.14-rc5
X-PR-Tracked-Commit-Id: 0b4ffbe4888a2c71185eaf5c1a02dd3586a9bc04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad87a8d0c435a97e2bdcf714d7e1a84ab5fda1ad
Message-Id: <174215333435.2863831.77659748166409051.pr-tracker-bot@kernel.org>
Date: Sun, 16 Mar 2025 19:28:54 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tengda Wu <wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Mar 2025 13:18:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad87a8d0c435a97e2bdcf714d7e1a84ab5fda1ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

