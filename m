Return-Path: <linux-kernel+bounces-292591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C37957185
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FABF282D55
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837D6181339;
	Mon, 19 Aug 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odoXyvs4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E64183CDE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087050; cv=none; b=CAponaUBNGvmJ5LiFmXQwcC2aInTBAn3PL3RLvTpz0PoCWelNbq8j7iHtNgU4xtyUGUJi8kDyX07OjUZ7+XSVFvtstEraXaFDVzapHkof2LjMO/cGQL2vsznxnsLXGME96gbKTbJeSrtjNbiqc+QsV+qNekGUyXmeLON4zHExe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087050; c=relaxed/simple;
	bh=Si+3cgCjrwGd4XdjMtUPTgCR9eQEfzZUd5XeXV2TXd4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C8fO/QPWPN6VTyJBtOccunWCx/PgwrWtJ42xWazRHRtoJnEiclHyxVmdTPhbcnq9d+//BhNOZpPVVeYi/G3fbWdLFe2+QV5q9sRZHU8OWljvMsyVA1yjNeErULZ1mgSiQTvqwiJJEb4LHhl5ynbfnnGIt3OmUuAjK923GUv3sOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odoXyvs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F46C32782;
	Mon, 19 Aug 2024 17:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724087049;
	bh=Si+3cgCjrwGd4XdjMtUPTgCR9eQEfzZUd5XeXV2TXd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=odoXyvs4cLs5txFjAp/1Oxa0blDl1JDuUkeXzWmftiNmMfxaxphQw/qwXvjjnzO94
	 Jk9ZAjcorofj7R9wnyrgyke2XlRvF2cIAXckueU2WXhtKToHN8p4LCrIjkyy2X8R3m
	 Zjz1/+CHDL6Sz71tRs+ODETzKkMkB1T3yiI5Uj51sQhxUZ92iW3LnHqWuqg76kAmKY
	 DjmWfGWjUQoHFtibqk7P36WwBadyOgUUnoI+glssqWgc9z8IbuJyEwwe+E+C5D/2N4
	 AvvcnI7qt/mzy+hfeYXddnMWu3saPqPX4MjcMMTtYPr2pkuGiSWAGm/n3UYJKhLLIW
	 IDthIRg/6DjEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8CF3823097;
	Mon, 19 Aug 2024 17:04:09 +0000 (UTC)
Subject: Re: [GIT PULL] printk fixup for 6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZsM8BVQ7l5RQiVIW@pathway.suse.cz>
References: <ZsM8BVQ7l5RQiVIW@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZsM8BVQ7l5RQiVIW@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.11-rc5
X-PR-Tracked-Commit-Id: bcc954c6caba01fca143162d5fbb90e46aa1ad80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0da640826ba3b6506b4996a6b23a429235e6923
Message-Id: <172408704850.597229.8612221780593236234.pr-tracker-bot@kernel.org>
Date: Mon, 19 Aug 2024 17:04:08 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, Ryo Takakura <takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 19 Aug 2024 14:35:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0da640826ba3b6506b4996a6b23a429235e6923

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

