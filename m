Return-Path: <linux-kernel+bounces-182971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CED8C9259
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AF31F214EB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 21:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209356A8BE;
	Sat, 18 May 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwldij/c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ACC6A8AD
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716066367; cv=none; b=jCAzVLAtIB3SJz4r/pWfi6lkcHTjcHCuCqJDcUf8DGDpHEvt8qRh6qmW9KSNgS2V79HjpXWTVta7fDuXqm9tyh/kyKhd6NYsKcLoY/IaBvVH60BO4NnfGj8RPAsTwe0g6pafQyfg/rdLQtYrmTncMt4ApgGYqhyQY+1+dSd70vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716066367; c=relaxed/simple;
	bh=atbplxsfuDBhSGcbIls+Jh2nRDy8JI2JKPVnlIY9YuI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PRl2Ym4HAJLhb5wst1S3aNfeNE5YMa1ie/EOd0AcXstYEnJhI0arixVIBrD95wt+dCq4Mb3pz/lYmntxlQV7kwZ9826+zeI8YWgSzamA8lw9mG1zeTH7lxIsVlgQ/2YSA2oWVlg79KHXKYhf2dNGR39NHANbpWDEgE+N7ulRh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwldij/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00696C32789;
	Sat, 18 May 2024 21:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716066367;
	bh=atbplxsfuDBhSGcbIls+Jh2nRDy8JI2JKPVnlIY9YuI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dwldij/c8Sq7DMdkvVBD4k2pXwQKUceQ5cmKauiWL6NO9umkc8Ls6N3AVrYmdeQRh
	 caV+LwIhG3W+yYKDESxH8M4R6TNXAGPhXnaznQxlfpeyINyNjJoLLMcTCUU+WSpJ+9
	 95UeqeUwG2wrYkTOusId1V6HpfyD+pK9QaeOaNA3RtsjL+7EQXy4c9SMOq1zUtP/y7
	 X1bfrMFRG853SOX8c+r6jVl34ujuzzVTQWDO4ld1L5TBrcM8s3WF/wt7DemvtbW1r2
	 TlHdL67ZOcBk0O4Lp/T/bCwKhBB9E8Ye8r9IWcWQF31nxeLxdqPx3gI65NwqRiJBJf
	 4BHS5Q7Vhfy0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3C1AC43339;
	Sat, 18 May 2024 21:06:06 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for hsi-6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <zbfu5mueaarwfwj437ephli77aozmahezg7nao5z5bjmoj6fqt@4lqbou74u64i>
References: <zbfu5mueaarwfwj437ephli77aozmahezg7nao5z5bjmoj6fqt@4lqbou74u64i>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <zbfu5mueaarwfwj437ephli77aozmahezg7nao5z5bjmoj6fqt@4lqbou74u64i>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.10
X-PR-Tracked-Commit-Id: c076486b6a28aa584b3e86312442bac09279a015
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56172ac1024d2cb9194ea42fe76d05c0748863f4
Message-Id: <171606636692.2260.3896386259268471083.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 21:06:06 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 May 2024 18:05:02 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56172ac1024d2cb9194ea42fe76d05c0748863f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

