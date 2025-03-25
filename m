Return-Path: <linux-kernel+bounces-576138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40308A70B83
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B31173C19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E751FFC4F;
	Tue, 25 Mar 2025 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXZ5lULs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF51957FC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934648; cv=none; b=R7A42sVtODKIOUDvfoDtDJ0HbzMiNxp4gUeqHxE9zP7xV2umbLlSTNINK04IVhi6kfPh2cq9y7DMJ5ZBjobFkmVjsRV7wh1RDWtv0lx3DhfhfHxfj0z0n27y3zWdxxxQdAUXQ/PDZWA4+y9YMd1G3zCF5RSiTxJO6r8ZkH6tNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934648; c=relaxed/simple;
	bh=bIpMpoSG8GZFy3xLNk7R/EtVlsPfw/frB1qGUMt0l/s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rk6KoxYK1xox2Yx2UDuEioTlXoTzIijQtpKOyg7LOwGTHulkzxEhgRK7Y77MXilB+h3c6S3lw9QCGIeFpGPVu2sSOXUjIh8Eotw8eEPcJUiL5Jg6Amod77mAxBQ6wyQeHifWRWnjJLo6dZXv7ZodDl9INXUdjyBmfkTh4aZ9pKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXZ5lULs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E2AC4CEE4;
	Tue, 25 Mar 2025 20:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742934648;
	bh=bIpMpoSG8GZFy3xLNk7R/EtVlsPfw/frB1qGUMt0l/s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PXZ5lULsDU2cylpwQlBeWku+iz3EclETjycRslQJ95lMMI8ATVGNdPRZCuTK++ajc
	 oqHJLplVjJtomxmfE5BK1DW0JaIt8pZj2umwsq6HORggmoRE6JoIOPrrq1lUzOmJYl
	 Dd4OLFNR/NrWuQxytIbCV0aByt/b1FfE5KeMyLAO+cIgWzhKV1r7LI+U6il22yI7PY
	 Uf3ndUp+kzmHnmI0/aqHooZrrWj8G0wgNsvw/R8zFTySSTxY2aMCSODdvuVIR3Sqg0
	 591yPpN51teKEZXgYYjoMxu7ljZJBCS52v82Eb+ZAjna89y/TiJ2PMGfELvg0rU/Wr
	 FAio3vJ0iiHPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB10F380DBFB;
	Tue, 25 Mar 2025 20:31:25 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <174275225552.1561082.4969731002775597670.tglx@xen13>
References: <174275225552.1561082.4969731002775597670.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <174275225552.1561082.4969731002775597670.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2025-03-23
X-PR-Tracked-Commit-Id: 827bafd527dde5a6e81421e88fb2144adac1f36c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43a7eec035a5b64546c8adefdc9cf96a116da14b
Message-Id: <174293468463.715410.18161492263107296113.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 20:31:24 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 18:51:32 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2025-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43a7eec035a5b64546c8adefdc9cf96a116da14b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

