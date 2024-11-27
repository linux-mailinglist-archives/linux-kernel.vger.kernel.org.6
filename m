Return-Path: <linux-kernel+bounces-423984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC48A9DAF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8201628263D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6992040B3;
	Wed, 27 Nov 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLlaP90p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045E2040AA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743698; cv=none; b=JVHGbZS2GY7sGSkhd1ZKcfQytJRxB15uYizNR0KFyrkwb4E8jMUSAjvrwK1EkskBMzHcq2pyNcgRfhfzCYR0XCmNi5xqkbSvUoJWkV60v2haDDpa8ajur9wnjJBv5prCWMedZrm8TLmxTYwLv/CCvBzqh1D6BoPmzayAakldMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743698; c=relaxed/simple;
	bh=nc4VGgFgqPxZAnrTPPdaf9P6KV1LWtiTb48wFdK0etk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WoviVVjXey+o5M6yUavC1eaKFtBEy3ef+9Vg7ONmgoZCwTaLQuZEuBBd7BkmIGEKXOKZJ97npMP3L3wi78KX8Z8gn23kE2nafBH6pt1v88OZwUXIcwD9tqz765i26ENCO7+El53bvadUmhnshtofunIB/YGUIIxmnWhNIx030lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLlaP90p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DD8C4CECC;
	Wed, 27 Nov 2024 21:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732743698;
	bh=nc4VGgFgqPxZAnrTPPdaf9P6KV1LWtiTb48wFdK0etk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iLlaP90px+PxkmsMhCzzOSr8f/aaeIUA5hOBUWSKRgjZDojBve+IVXClljwyNfzBr
	 m1MHulJ7oaws03JBHW44kHeGjUAuISnU3wpEQJktPMjwph6oz27GbuUr9qzsfoGdRh
	 z3LXbiqQfRM9Fvz9JV153mbYH7lKzqZfIpoRecar1iVEsMPowHM5iJabiKC0gncIcb
	 P4+L/W3Cn6jVgx/F/YSZWcorDbFPzNLVjK0448j5VWOMpAPe1u+3Hu4goMbiDEzcxx
	 thOUeFXQtGHIoiR7SnoB5usO4o5+xgcMwzm3OudGAGHVhkB/B+mqDLmKfbvlrmjhYR
	 lUI50JtIZjiAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC087380A944;
	Wed, 27 Nov 2024 21:41:52 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy subsystem updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0cL1hAJ0BivGXQh@vaman>
References: <Z0cL1hAJ0BivGXQh@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0cL1hAJ0BivGXQh@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.13
X-PR-Tracked-Commit-Id: 32f4a76b8e7cedec9f9aedbfc43626536bba8350
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ce9a5ffca7cb74efe6e981e42f82d0838fd31cd
Message-Id: <173274371142.1220377.5228905853392644264.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 21:41:51 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 17:38:54 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ce9a5ffca7cb74efe6e981e42f82d0838fd31cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

