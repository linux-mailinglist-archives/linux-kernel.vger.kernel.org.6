Return-Path: <linux-kernel+bounces-422905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E3D9D9FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23AD28565F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D981E0094;
	Tue, 26 Nov 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMZStMWT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86C1DFE33;
	Tue, 26 Nov 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664457; cv=none; b=Znswbjr6pV4vP6D7K9sM01PWbdIf6jnXOSeo4MV0LPxkkSU/WL4O51o5uZY/1zSt8Q0braCCjB9ZlGPiQry/Gk8ENSQPiqABSp3oPyhG5MuXanrGhmGi+JAZu8svGwOlHwYgzfu2dJUk5GBfoOu99QSzSZUWtclnNsOW2DBZiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664457; c=relaxed/simple;
	bh=kaJERyrqAPVD/Fj3IghzB1KoS94nVtyJN55+E2QodxY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kfw802Npva2baBmcRt9hzUUS12RN5v3y9L7vmJYajsqBkCxdUIzucC9SxR95pF+tqeUCftgcD++MA8N0PNcZmjbpvRdfNiLl+lhStkEhFrO6l4r0YnmUejFLaQ79NqSYsu3/JijC00uIlCdR4ZDPfuw1sFA+NZvttYZONJ4GA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMZStMWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45D9C4CECF;
	Tue, 26 Nov 2024 23:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732664456;
	bh=kaJERyrqAPVD/Fj3IghzB1KoS94nVtyJN55+E2QodxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aMZStMWTVmFiKNXqH+bVh7NaZGM78/ZV9XbIpQ8q08Qdvs9/GdHIiVcJpV8G7Y/DP
	 Hqr4+yL34ORxzecVqFFq6Yi84elvQrv5JOyQ18wnPyc7WfBgeEu8/LwsPbZLweh6/L
	 +qrjhWV+xO0G+kuzNDBOq01j8Fp2BGoeR1etcEigtimEqFiB2Waj7JXHtB5xB6v9so
	 me6krj424YNnv4/Mv3MUinrioWPPFjGSygneRZOaGQwm4guuS0b5/17mW73BdXcZaE
	 MVH39yTjQw+lM+JXmzI9dBG2GDFMPZ5wKGhCu8wRmE7sKkF5stUJipP1nu9z2v00Fr
	 geeUgl6PUPP1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB03E3809A00;
	Tue, 26 Nov 2024 23:41:10 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fix for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0X1wDdw3sIo25WJ@p100>
References: <Z0X1wDdw3sIo25WJ@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0X1wDdw3sIo25WJ@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.13-rc1
X-PR-Tracked-Commit-Id: a5f05a138a8cac035bf9da9b6ed0e532bc7942c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9160b68e0cf8d57243f17debcb564ce01e327ada
Message-Id: <173266446947.577215.17627222440544688454.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 23:41:09 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, John David Anglin <dave.anglin@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Nov 2024 17:22:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9160b68e0cf8d57243f17debcb564ce01e327ada

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

