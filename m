Return-Path: <linux-kernel+bounces-186592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED58CC609
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741E21F23285
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48027146A84;
	Wed, 22 May 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgZV+MwX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229214658D
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401120; cv=none; b=oY/wgyyg3l+cIKLbKd6ZzReCDNM9k5/1m7wX2xp2PXybe5ckkJLSQQqyd70LAOtCxz2T4mfhWHiaBgZhqIV8J8wm+4Zf48sYeJfcM9xOG1iCOc4vri3JEORl7Qn0ekKKJ7Gw7aIy0G/av+/laCFyaE1HkyorTz5letstEt7K9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401120; c=relaxed/simple;
	bh=Q5oKdHIoq5WrBIMj/3SIHeKSQqe0PQGsPZhOJR0ALVc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ka3kueHawA6J9RVPqJA4NW1pmbXvQ0s5bQ+DRX4j2r/Cdcd3mQ2EuBaDDnEgDFLNYlOT+KCeP2TMBA7PczI+qgYIFinCFUb3hPtUI+MIFDmuHVyBOcwGsmaj4Jvxj81ov8BWFmUvhjINOGZ4PxbND5Ndw6P/tgfVQFAPwhzDJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgZV+MwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46332C4AF0A;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716401120;
	bh=Q5oKdHIoq5WrBIMj/3SIHeKSQqe0PQGsPZhOJR0ALVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PgZV+MwXO26epXXeOUwZs1DItQ57L9vfB3zOIJuilU6189y2HgYVQEfgFP/tDqf6O
	 SYl/RSYkco2gaoAQea/oOqPx2ui6LdiOlP5+fEckoSxZRLg+y9tj2d9QNylDjmKrIy
	 hNbaQT9S+3KlwD0gcDNMcJHDJavOp6tnlO7a/m1i+8IvPtK92C0JB1fkUnOPikkvLP
	 HBcxi0laQH4WfmnWNuZhOvoew2lWw0A7etBVrHc9PVrqRdsVWzLTZN3G5MPAme7Fxt
	 i6gP6XVIg6VB9swRmgdWBuawpdoTnHGBCD7K4egmzd612YH7w2ThFQpTTI5FDbuZJm
	 UzTt1XW0mKQjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F134C43619;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAHTX3dJaBOjpy6bkasrezjzydyMWAGEjqOcfhY18XWg=XDjHgw@mail.gmail.com>
References: <CAHTX3dJaBOjpy6bkasrezjzydyMWAGEjqOcfhY18XWg=XDjHgw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHTX3dJaBOjpy6bkasrezjzydyMWAGEjqOcfhY18XWg=XDjHgw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.10
X-PR-Tracked-Commit-Id: 58d647506c92ccd3cfa0c453c68ddd14f40bf06f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f33fda22a775d7c6d9b14757f94a535c0698c73a
Message-Id: <171640112025.25247.77597123698773512.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 18:05:20 +0000
To: Michal Simek <monstr@monstr.eu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 12:40:33 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f33fda22a775d7c6d9b14757f94a535c0698c73a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

