Return-Path: <linux-kernel+bounces-256771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C8B93700F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70221F229A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A818D145FF9;
	Thu, 18 Jul 2024 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKRyutmb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B3145A1F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337986; cv=none; b=QA8KJnuXmjxRumJmb0kDfujYFxs2sUzEFFU6jNMWwApLIUpNDW5yVgL5FUau5NKIuIKOSOviP0AsTZtgLouGon3Z0E9gD3hPYHTgZjEdJZuoe5XASTeTD/WEorZ0dKbplyCCUvBXdUPX9TXLs9aWeETQfR55Zjonja8+gi5usPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337986; c=relaxed/simple;
	bh=Qkls2KryNUb5q2sAoHnsYh2De6QTmL0yvqa+tZqZsrQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FGD1nZ4waV0tdJbOPOuRofczVxfuE4I5sPmfO4/qCIwHIRlguKYlGClxuuUbNRMNEW/aqOhD8u0jdI6SJGoCElPanPE7kuJm1Rae7s3KUlzhw1pSK7C16z7PxE/z0mH9yrbZkPYXjywzrPs9KxzPKd0UtL3rs9owAfcfz8OyIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKRyutmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79315C4AF09;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721337985;
	bh=Qkls2KryNUb5q2sAoHnsYh2De6QTmL0yvqa+tZqZsrQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AKRyutmbNXSmBKS9WTBKv36ZFDXN3vBz972na4+unbw7NVH0u/aVnfIFiyqM22USb
	 M+Humbq4sNJdzX0H6C9YK/5oI8vshSWJCBazS97O5CxCzkUueJ7NuIh7AMIJqMb35S
	 25tr/gMmlGt++BV6ljX66t/GXncsMVnzKRCEddUo0NGdAIW5mth+7hZQ9GHP7K/Bd3
	 jJ4WtJMjByKaMn6YQJwQeP/l4DD6bHKYVX6VX0lCxP82uWz4DoW6S2gyC3ABkCNnJF
	 eqZGS+HB6hLmXMXTmA98Fg5ryU6Tv6ZUFZBJ69sEPoAiC2lrJ+1BmImpS8V9ENInhY
	 atoSGv95PHMTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70400C43443;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/tools: Minor updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716163543.038d461b@rorschach.local.home>
References: <20240716163543.038d461b@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716163543.038d461b@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.11
X-PR-Tracked-Commit-Id: 28beb730ee167e505c86d1a8ae239e97d0136b13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1777e471e11da7cba3db8dfa82822dcef6fd7794
Message-Id: <172133798544.21905.2494816361052993756.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 21:26:25 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Wagner <dwagner@suse.de>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 16:35:43 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1777e471e11da7cba3db8dfa82822dcef6fd7794

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

