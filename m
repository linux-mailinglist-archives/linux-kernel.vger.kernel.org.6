Return-Path: <linux-kernel+bounces-574749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDD2A6E97E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2568A3A7696
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172B253329;
	Tue, 25 Mar 2025 06:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDvKKpim"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102F25291C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742882849; cv=none; b=jOwoQAeS+3kTlMGY0iLyNKpKn2v8ljQ999ezVCltV4QRH6A16CfvzR0U1olgWBDnNhXe2MwV44nnTC7/cGhdAS1bIsSyTPI5VQp+SdUkz8hTwG8csLY4avPNB4Be7v6+gzXwQauUMmh49Z9VfoJiK0cywZUmUmnCkgIvzmxDHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742882849; c=relaxed/simple;
	bh=nHy2n4MhvUGk7ZuD41AOl1nJ7X5+fx2Xd0R1cYwJmJI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aLJQ/sBD3LfU63lD2ierjEyjH/9G7/PBCvsU60I4oGcB2bwkQt6jwjSGXfKg2MPoPdVDhDMTYUaaFAKfUkLUeod64TLXlY2Xf++XCZP3qph84ziPsBUA4rt+5fbe6/DwL2zvFfXM9YxmDAszncYM8AvOKs1CABO06eZImZeYXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDvKKpim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C5EC4CEE8;
	Tue, 25 Mar 2025 06:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742882849;
	bh=nHy2n4MhvUGk7ZuD41AOl1nJ7X5+fx2Xd0R1cYwJmJI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HDvKKpimRmqvCx1NhKCrpLaLIHSz7/exrZJZ53ZEpqZTzyJsZhV6pbHkLFdIP5Vyb
	 /9oJufUtYsxfkD9TATIjzFsVoeJ+tri4FF7yedn6ZOR1Ugi5uyRKkP5tGtjsD5n8A6
	 xGkVKRx/iQPUJ1n/SudIqb6UNF0+6lO2umMAOTf6W/1tA5kqCZUJi0LFN4NweQafq1
	 1ReOIZiXp1q6NpAo8gpNJwVytrXRMPqC9FPnVUItBnGdLzSO65O4vGQbTn8XwKHZX5
	 1gqAZYkOKywtEFs6dba7EMv/XIDZaNsA08iblA9HfxNaaQf7Ic+mJxnd8kld7ggp4h
	 q5TBkH4h7yYSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AF1380DBCD;
	Tue, 25 Mar 2025 06:08:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z96jAWGvYzZOM6O4@gmail.com>
References: <Z96jAWGvYzZOM6O4@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z96jAWGvYzZOM6O4@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2025-03-22
X-PR-Tracked-Commit-Id: e471a86a8c523eccdfd1c4745ed7ac7cbdcc1f3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebfb94d87b35a4b5fc6fda0cf994268555ebe415
Message-Id: <174288288570.109792.10983666775204212505.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 06:08:05 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 12:46:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2025-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebfb94d87b35a4b5fc6fda0cf994268555ebe415

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

