Return-Path: <linux-kernel+bounces-416431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163029D44AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DF41F228B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4BD1C7265;
	Wed, 20 Nov 2024 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt77Y5ec"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE541C9DE6;
	Wed, 20 Nov 2024 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146613; cv=none; b=I4goRinCaW0/fVyhqqU6nbUJBlJGR0WyB617+3eUqjS5HEHvfxduWG16ZzRFJDrYRCTtE6QfdwQ2HFRpa4A3IAlGMmtpQh1zhFrcH3+6YFYMkGk320QrbITmD61WEAEQxuz6JHdQAnUQnuFVgmGG5DsSC4qgMEBXqA99sGOQOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146613; c=relaxed/simple;
	bh=p6VUmk5N75iEPCaOOP9vG4kDiWSfRjIef6HIGUgrU+c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nqdmvJ2RKmuP3wTfmO1R3oY7S1i6vlz0RjZ//uT+xf/CmccJ0tYtss/aCdrz4CfAtqn53ZhUZRqb1k6jSLL7sgofF9xxB+PI5UwmhITYhG6K2voV6sRffczt/o+7KVcl8n3eAv1HLyhfxsU1ASwlmCgREhWXso8TXZwjbMJnhec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt77Y5ec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E23AC4CED3;
	Wed, 20 Nov 2024 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732146613;
	bh=p6VUmk5N75iEPCaOOP9vG4kDiWSfRjIef6HIGUgrU+c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mt77Y5ecdi9/jwtPv3n/Tc/EWWuSgsO8wUaqvaNUxjvz6WYFE6GXJISAKXuOFZxyc
	 TRPbeTcUnEitTtfclH6lmJZ4ylHovpM1RAsEOPFkdX2eDOF5CvhTstdbFteTrc4eRQ
	 CApLtoQhxv6ioITkbjYyquWerWGop4lM/FXmjN+ghYX1fiH2HJp+4K947cn/ZRhhfP
	 XZl1yvfcKzyl3DH+pcTFjL3MJqEk2d7ziYFkRpCus4YiFBFCSdJHweVkaF3P7pMvE3
	 n+/b3k96cEyT6TsZv9pIx54JTdhlTA+fmiNygIIAsBEXrXHtITCL4ye/8d+al4Xu7g
	 jLGNcjIB0y7RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 97B633809A81;
	Wed, 20 Nov 2024 23:50:26 +0000 (UTC)
Subject: Re: [GIT PULL 3/4] soc: defconfig updates for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <77eaecac-c423-494d-91f0-e08322fbb0d8@app.fastmail.com>
References: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com> <77eaecac-c423-494d-91f0-e08322fbb0d8@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lists.linux.dev>
X-PR-Tracked-Message-Id: <77eaecac-c423-494d-91f0-e08322fbb0d8@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.13
X-PR-Tracked-Commit-Id: de6dff2090ddfa74ae53e3e52243a9b9f3ff8526
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06e47dce8fc3ab68c2ea3b5082caab99e8002b80
Message-Id: <173214662551.1393168.2060692360534209256.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 23:50:25 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 00:02:17 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06e47dce8fc3ab68c2ea3b5082caab99e8002b80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

