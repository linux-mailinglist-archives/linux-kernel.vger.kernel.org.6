Return-Path: <linux-kernel+bounces-411871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3786A9D009F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 20:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E901E287691
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5E193416;
	Sat, 16 Nov 2024 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4QE2tSX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844B19149F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731784910; cv=none; b=bQQrREB1X3/oYEysXUZ2FmABTWSisHjQMo702+90rWHDBuRx8PD3DO9LUFkXhXuTZP04LVqFOOAeztDDBQNYQL0fCtTFt6ZD73Er9gt+MVO9POXvxVaRKDALwyqSAkhwbpfxSyHUncjdNWz9vAciFjwb8PSj4zSE1qmZiAey3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731784910; c=relaxed/simple;
	bh=WbUdSxlc3q5lehZx5f3tsliR3cB2s3MlmMy36a/VhOk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oKI/h4PLztqJZ4pkHESlArQT7SANZyDLHxD4Ai+5+uLvtO6IGOvxMtXA8JuDooTDjwAYLS4vEVd8CTrqqhFF6wFHH9Ood/WpjBH75f5nNtpl9m6vOZZbnIXwvHJ0B5iEVHEYqGXXQbAzbtNyTGAi1Xy8inZO+jhYdGEFcSuD0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4QE2tSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AE1C4CEC3;
	Sat, 16 Nov 2024 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731784909;
	bh=WbUdSxlc3q5lehZx5f3tsliR3cB2s3MlmMy36a/VhOk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J4QE2tSXF6EAja8cQtYQ3DMd0asO4TobvScNdNGyK4xS9WKxo8zqE4DgMuFTtRBB2
	 9+ssW4Ok6PaC3pYfKkaU5J9GItYCP/is5FwskmVTwNZ25FOYXIwvtsTxEvMC+FHsMq
	 S1p63t/j/8bqGt92gMqFwIR7PWomzsqRZY3MPoSS+PkAcB5eqSGBgBp7ZGqchzpfC8
	 GapT95MOQSZqXtlIDgFhTIrriQC54x/c9IDmU4rxYaI9E2ps0ZxO3R6bk1SxpTh4yM
	 ZZo3Y8ecfKoQGT7/qhKQr65x2Pe7tr/Wg6rVtNuE/0JYXqTbPjjp3EdmOsjLOo1ucd
	 FhevvgTDJehHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB31C3809A80;
	Sat, 16 Nov 2024 19:22:01 +0000 (UTC)
Subject: Re: [GIT PULL] ring-buffer: Revert previous fix as it wasn't the actual
 fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241114104149.1da4f584@gandalf.local.home>
References: <20241114104149.1da4f584@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241114104149.1da4f584@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.12-rc7
X-PR-Tracked-Commit-Id: 580bb355bcae7e9a6606ce9644af09b2a793f1bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09663753bb7c50b33f8e5fa562c20ce275b88237
Message-Id: <173178492061.2978276.16032400648699376027.pr-tracker-bot@kernel.org>
Date: Sat, 16 Nov 2024 19:22:00 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Nov 2024 10:41:49 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-ringbuffer-v6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09663753bb7c50b33f8e5fa562c20ce275b88237

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

