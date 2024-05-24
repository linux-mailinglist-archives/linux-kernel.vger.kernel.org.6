Return-Path: <linux-kernel+bounces-188941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D10C8CE8D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F86B20F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6A512F368;
	Fri, 24 May 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVcePM3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3323D76
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569126; cv=none; b=YQDyfBJzgLxqwqk4iU+hZ5wRBJqmJCFQvI3BzWeKN2x/2asn5abg31k03UhA4RUVuLoXm2Jrp4U5dgZWU4DmolnUM7tagxYUfft6c2bjc89mT0Y2ADzgCqUfTrOUhaPE54KVyx0B7I+hAfjouM2jgZ7FJgCaQmqbpgBZR7dhaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569126; c=relaxed/simple;
	bh=VE8qg68nZPwNjA6Q0XTg5dVqXarGnbaZjRYSOy/mcpw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AMk6feJ8D6skv0xuClXla4cjoIJCxi00f4C7axdWyc5g68thu1lgu8Nk/ImfPfBUyADhsJcXAdgtq+g/OcCm7DdfT1SVaf5hs6Ljx3PfnQ2J5/HKw9aNXFb4Q8AimFumUgqouB6irJXAbfFPEe+qGUMAgaxE2JmXwit93evMvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVcePM3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D21CCC32782;
	Fri, 24 May 2024 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716569125;
	bh=VE8qg68nZPwNjA6Q0XTg5dVqXarGnbaZjRYSOy/mcpw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FVcePM3/RUY3uZCQXZEti0jZijuwRAQuYnrTo5NcVA1ovn38XCFoofUDLZzyvF3ne
	 0yZ8MWFgGbEynd7elwCS7gcp77wggeUF9kXd1d+V1PZYr5tTnuGBEu5BjFT+XZFDwa
	 SSMI+0aNxMGL7Jk4+rgRdzGNhVEZuAC3UaNu69Ez+ZLy8n0JQ+edfmXmbyKi87FE+S
	 b4gvQjF4b+enaL/cWDu9GEwcgwUYk/XrEA+N4Vw5mMNCYds6BISe3NjxxJuQOIJm3t
	 wO4BtB3gwKWDp5vMS+astceMHvvBRHaEhMekEuWpIscMTd9Qxwjo/ATeA31poIXXXE
	 mw94lUzqpcABA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C784CC32766;
	Fri, 24 May 2024 16:45:25 +0000 (UTC)
Subject: Re: [GIT PULL] tracefs/eventfs: Fixes and cleanups for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240523174419.1e5885a5@gandalf.local.home>
References: <20240523174419.1e5885a5@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240523174419.1e5885a5@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tracefs-v6.10
X-PR-Tracked-Commit-Id: 2dd00ac1d38afba1b59e439abc300a9b0ce696bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0eb03c7e8e2a4cc3653eb5eeb2d2001182071215
Message-Id: <171656912579.29701.16740873194804586676.pr-tracker-bot@kernel.org>
Date: Fri, 24 May 2024 16:45:25 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masahiro Yamada <masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 May 2024 17:44:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tracefs-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0eb03c7e8e2a4cc3653eb5eeb2d2001182071215

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

