Return-Path: <linux-kernel+bounces-184155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D24B8CA34A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1336F1F2242C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC6F139584;
	Mon, 20 May 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTb+EUbA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A091384A3
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237019; cv=none; b=WEjLCGb/bsldV3xnTkyOMnyjFxIR2wXGexYJOJ52moCr/kPAWbUc2n+gR0dteXjYhkxCsgu21ttlxV3GjejzBtnsDADH3HOKbzM55WJOhHlhAUK5fyN4iB5lWVznYz0cnA/u0cO+FB+7LbcM8W/VOGPs667OW9flXRyvFhIXUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237019; c=relaxed/simple;
	bh=LXSUUECeY4XGsL7QYyf+TXUuVGBlieNNwYUMtHidaqE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tk2fLT67Bc2ZB4m7wEs9S7vQw7WrepgLVDQz0mOWUaSRcQ6pjCQmNJCNXdOOLHv63aqsdJww4u8Fnv7Y7LKt94327cKgKsNqwKqBcLcFcC/ehtJ+9pSkJiJ8uyDp3qq4R8skJjqZRQEQss40v5jzYPANqKcSkQJv7qarlaqlsjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTb+EUbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B4BDC2BD10;
	Mon, 20 May 2024 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716237019;
	bh=LXSUUECeY4XGsL7QYyf+TXUuVGBlieNNwYUMtHidaqE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OTb+EUbAbXv9bhBO4rBXIP7Cx+DlLSsv3bcc0BuFmCPtCVxlCHbwxP5iOl7qUtz9N
	 HDumJOrV7UM6ZFsUurMdEO5ZbxPSierzoDds6ShQtdOT5Of88+NZP8D8d5mN6tACbm
	 ZE/eosaEWWgfNNc5z10D3YPAPDAGxofvX4DwnLm6Lt3Wo5ssGiTyND0BuUQa1JO61q
	 QLB5bAAi8RAiHaPQECx4xEc/PIefs6itzXkaRo6ZgwPy4gw7w9/flLL2ZW2uZ/AS2u
	 RqbPNUpmYZsr7Xt9Ala9Pcx0iBzUPYZmkiNa2dMw+vDDfhIhT3QqZ8Hahur0Tai64o
	 Cb+U0Pz9Erg3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB91CC54BDA;
	Mon, 20 May 2024 20:30:18 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkumXs7POGImbr-k@google.com>
References: <ZkumXs7POGImbr-k@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <ZkumXs7POGImbr-k@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.10.rc1
X-PR-Tracked-Commit-Id: 16409fdbb8828d7ae829bc4ac4e09e7ff02f8878
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72ece20127a366518d91c5ab8e9dd8bf7d7fdb2f
Message-Id: <171623701895.8142.8608336086340569971.pr-tracker-bot@kernel.org>
Date: Mon, 20 May 2024 20:30:18 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 19:37:02 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.10.rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72ece20127a366518d91c5ab8e9dd8bf7d7fdb2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

