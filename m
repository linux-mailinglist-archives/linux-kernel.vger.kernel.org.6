Return-Path: <linux-kernel+bounces-333107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51BC97C3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE1284D72
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D8038DD6;
	Thu, 19 Sep 2024 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6BwNvYg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32252381B8
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726723216; cv=none; b=fjFaun6L08Ko5GWa6DaUzyhXRlcaaZDULjIPH5TGkRUzX+e/fcufH6/HjnJSNlTfBayyhPJSeeQpGe5i6wxi1Gl8pbHM0ki+2GrUxnbp6JmGkNCiPJSgjfE1XaPypGwgwHv4nYhFqhDrJfEOApjn5EWhPNndxD0FaYyolBhIRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726723216; c=relaxed/simple;
	bh=titWnAhy02wiz6yQyvCZh7AkIzYHk1/WsXqkhpCYAmY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DVSIE2D63z8Mcd2d3oYGbvL2SBo6UcJL+AkjlhmFeVQnzgTz6sbArYkiCMXltyBKqQR0NB5Uu1GJoMxR6yzObzV4I9EteoV3noY9WRwVu0qiqUbI1N5VZLwUQvGjt7al81b4vUCguljMFpbJbAMg1TXLtHQdbZI3myy8M3V/Fxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6BwNvYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CA8C4CEC5;
	Thu, 19 Sep 2024 05:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726723216;
	bh=titWnAhy02wiz6yQyvCZh7AkIzYHk1/WsXqkhpCYAmY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P6BwNvYgqbu6FR2mur5BVR+iMOE7q88AMol5ql4er93CsDffMTqC+9aVprY9xdy6f
	 m9ltplYjkr3cbM86pCchdW9ulAjlsmmURtY/+tATTy2zCmSJf6bsUPsCWJvaqbdgGW
	 jPeEI6yKah3PBYFrhAkM9FGHoJATLptCH7nKD0kgSOgPzP+KOikGTj1e2wv2CIsweB
	 TSsQhmPc6ZyGjfElknkL/RTS8rxMy3kLQl4gyXfC/IJXsudUZIToiTK6JwvH+dHdSp
	 Br1hjzw5ygPaRxbown9U8GYwS2rlcLnHTo1S3+8jbuaOH+sK2IH4K3DR1UONGyJcMf
	 BG/zLbhG98iBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2E4313806651;
	Thu, 19 Sep 2024 05:20:19 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <3bf9944a-3809-4a79-99e9-d3b797c25836@oracle.com>
References: <3bf9944a-3809-4a79-99e9-d3b797c25836@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3bf9944a-3809-4a79-99e9-d3b797c25836@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.12
X-PR-Tracked-Commit-Id: 2b59ffad47db1c46af25ccad157bb3b25147c35c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc3804443b4b367aba9eed58bb98959376bce1d1
Message-Id: <172672321790.1036593.4035358694802075421.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 05:20:17 +0000
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 14:45:35 -0500:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc3804443b4b367aba9eed58bb98959376bce1d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

