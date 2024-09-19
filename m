Return-Path: <linux-kernel+bounces-333218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8304E97C580
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58AD1C2364F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B93019AD6A;
	Thu, 19 Sep 2024 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1MUdQ5y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD531993BD
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732817; cv=none; b=pAxDUw6+GbLnbuTFGIyiGicbXFGojBIhhBFWI2jZgwZDPKGPDTW2C1IZQkidjoPZGJBMT/ULxymq7Mp9iIDtqjJE6CVIlVfV6X+virEPCvkPTH9Xm9N36yFE25Ef9HMufJPTVD4WaXT2qX4F7V9Htg1SeekV4XMw2km+yhXF2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732817; c=relaxed/simple;
	bh=haWpeIWPcrYoLNwaxqGIfRTDE90TWE139CvZELA6Aik=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nVjjgX39RGTpa5yxf9Iss2tSdA57g59SPA4IvJV+juGeQ0+RbrJqNu5HXPXxfssaX9dQ4+fWZNuT59FTEJZmJPiY/DYNqCPR4IMQOakEyUjOtfhozzM5YfL/R7167UEYrPA8IfDC0J6jZqzw894RSF0ZqKFq5hjShWtc7PG5dR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1MUdQ5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A149C4CEC4;
	Thu, 19 Sep 2024 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726732817;
	bh=haWpeIWPcrYoLNwaxqGIfRTDE90TWE139CvZELA6Aik=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M1MUdQ5yMiCXnG28ebjzbWKcMw2cL7XAZqXTe1zemsPNXfhYsrm162GjgdkPf1lkV
	 AphlBbdZJV+Iz+CyXmbT/nllPFezqK7FfvOt6QAR0sNFFpWVCtLsX7phC+DhJKnZ+d
	 dMNVQEH+aNOqH6hJ8gxZmUWNf0NXi4ql9T+aMQwg+O71hoaMzWXXIdG1UBpbU4wodA
	 pJvFMmLd3AfW0/OGOwnJWrL921+O4XAO4WqbY0VDCHixoNg/daHY93jI/MxZvxXdf6
	 719U4pKmNG8sLRoBeAGsJr9kBsoiM+bgjCr6VDCYOY4nzTcgLFhgU8f6ogIpxcsF6m
	 CEwz7GBdYVs5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE42D3809A80;
	Thu, 19 Sep 2024 08:00:20 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2409181132240.31206@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2409181132240.31206@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2409181132240.31206@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024091602
X-PR-Tracked-Commit-Id: 0aa04373bca5044a3cb4d5125de792872e971ed2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a65b3c3ed49a3b8068c002e98c90f8594927ff25
Message-Id: <172673281951.1388805.16050303221202289430.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 08:00:19 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Sep 2024 15:04:51 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024091602

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a65b3c3ed49a3b8068c002e98c90f8594927ff25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

