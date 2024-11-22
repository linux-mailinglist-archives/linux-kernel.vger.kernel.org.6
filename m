Return-Path: <linux-kernel+bounces-418811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F270D9D65D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B917F282B13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829661D0E20;
	Fri, 22 Nov 2024 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDF435TM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09941CCEF7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314752; cv=none; b=miXOXVVyBEQzDBmchrsGU0xa3T6dwaAFlne+bU4n5144XDQ0LRqrUaVbfIEdWeXX8R1e/0DDlSq96vyewqfb8X6lNMOroUXvHhe7cXp9Zxm29DA0yGGMN2g3NFrgr0pPFwFJU7AV+nrYZpalcFI4wjJK5psHNC995nSOJ3j+GH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314752; c=relaxed/simple;
	bh=uos1AA8SSyCrNUHEdDuJIWcRmVzNYCnGQuC04RBzWJw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Wq4A3Yw0EgQgYGqvETVxYbJM3lWzvcP2bfkFGYpyQ0sUgghqQxu9OeG8QubzBrCciMyN8zw3o2fiC201pfNML4Biue7PQeNK1bDLx24+kx7feLktZVNBiYkjDLwy5BfoRjXX81nRNHM9r/jpMWRjFv8cvk1KRCspnCsXcbB0H2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDF435TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21A6C4CED7;
	Fri, 22 Nov 2024 22:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732314751;
	bh=uos1AA8SSyCrNUHEdDuJIWcRmVzNYCnGQuC04RBzWJw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kDF435TMhhDrz5gkxKZ/M6vvSsXdmXDh27JBuJIQvS6hjcZ+O4Y8a1g2CHlJBrdLZ
	 +wTfzKiLRUFE6kC1Yh/9E7/LpOCuSkrq0xSC+1wWTmppQaaL3AyWP9YRCdbMA3hpO8
	 /ej1FlYjX78cdDGlW+BW37WLRFRN6e4enmq24+H86MVCk4646pfuECPiyVaSKj53jF
	 WKGqBn6MwJx7PNpq03z87RiX58DPai71h4DuYbLsXjYgD2qZ1KbOAHYhZt2WKSfO4B
	 QgcijJAcIsgsdGVUkCAr8I7bBwQ0sm9deAwDdYM9QGeWmqi2ItuUwXIcSgNW51UIig
	 r1q0RF/LwHh4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B523809A00;
	Fri, 22 Nov 2024 22:32:45 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/tools: Updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241120161011.2f5621c4@gandalf.local.home>
References: <20241120161011.2f5621c4@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241120161011.2f5621c4@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.13
X-PR-Tracked-Commit-Id: 571f8b3f866a6d990a50fe5c89fe0ea78784d70b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b01712311c6e209137c4fa3e7d7920ec509456a
Message-Id: <173231476377.2827182.7220290696463055506.pr-tracker-bot@kernel.org>
Date: Fri, 22 Nov 2024 22:32:43 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Kreimer <algonell@gmail.com>, Ba Jing <bajing@cmss.chinamobile.com>, Eder Zulian <ezulian@redhat.com>, Gabriele Monaco <gmonaco@redhat.com>, Jan Stancek <jstancek@redhat.com>, Tomas Glozar <tglozar@redhat.com>, furkanonder <furkanonder@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Nov 2024 16:10:11 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b01712311c6e209137c4fa3e7d7920ec509456a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

