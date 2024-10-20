Return-Path: <linux-kernel+bounces-373073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4599A51D1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 02:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7572A1C2114C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 00:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2BE33EC;
	Sun, 20 Oct 2024 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOrCN8h9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F72F43
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729385954; cv=none; b=Y7AK9tkdSHGsj09461lEGTkk3393w8Y74hI4p4P7sa/t0pOWICOI8LmEh7uBuRaOPSYq8GhD+Gi1PP18P5S26aU0aOYW/pFRFARIWQXVgf9n15XD6TGCKcg8PBkttR8kY04PsbEdcZtMXh4AXUkZaV5PFTobeKtn9bskAQ0LZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729385954; c=relaxed/simple;
	bh=bjKJ68V2jKvvaD2ONEsfjOYugNfTiZ7VBNqftkS3AeU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TeMdgcbaS0SMup4d2CnGwPeIWTiOYwiomoTu0Ad15sVrzVxGuj95JOJQi3jdi5j29KO3+yOldZr7jQB/wS6c4ezUUMrN/Ie3dTqOyNWBL+keeOhSqSGwGAlRBNkYz4hbL0phAlQx6aigRjcPp80BhbJiaoNJlAbOf76fc1eaupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOrCN8h9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB071C4CEC5;
	Sun, 20 Oct 2024 00:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729385953;
	bh=bjKJ68V2jKvvaD2ONEsfjOYugNfTiZ7VBNqftkS3AeU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dOrCN8h90gWPeqmSw3ltOyyvscq1efMFbf0IJbH5gfGdow36Xo4wxPUAjlBaejskT
	 +J8j8wkND0ZBD0BEXQ9ASg/ugLoI3vpCf4BrqX8/YxJ17zKbWiZRF2h/jPB4ZuLHxt
	 qQyHZpjf45pqexaYovATG8v8f4ugULfcP5OsIsI9cJHrR7W16OMVoC66eRbG238yaZ
	 H1wfMDSxcpFH+PAYPM7uf5n86XUyRAxJocENh2BFPeK6jApcCt5gpjahzITtQGJ0ZY
	 cFTkvetzpmNOZgBR6iEBj3yPrEymW3VFTHz3O75DNQHeuz7EHS1FKi7Y3znB1owASN
	 uUkarJ8R2y1tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0AB3805CC0;
	Sun, 20 Oct 2024 00:59:20 +0000 (UTC)
Subject: Re: [GIT PULL] ftrace: Two fixes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241019144427.5d469ed0@rorschach.local.home>
References: <20241019144427.5d469ed0@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241019144427.5d469ed0@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.12-rc3
X-PR-Tracked-Commit-Id: fae4078c289a2f24229c0de652249948b1cd6bdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06526daaff9058947293244d28a32280d9218d8e
Message-Id: <172938595938.3503243.8286990974419949219.pr-tracker-bot@kernel.org>
Date: Sun, 20 Oct 2024 00:59:19 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 19 Oct 2024 14:44:27 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06526daaff9058947293244d28a32280d9218d8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

