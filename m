Return-Path: <linux-kernel+bounces-241678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99376927DE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2BA1C22B32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4CF13D275;
	Thu,  4 Jul 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff//8nrG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66413C9CD;
	Thu,  4 Jul 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121817; cv=none; b=cssCrP0MIWGVVRyShJqe2TescZqTEo+R15MPcPujJGj4cbHNWIQpYva2M3b1b3IJC+SnYVWIj3Hz+YNr+Ivgso1Ze2Amgs6fc/jxJAgvp8f1C25a+6meDx6+eQWVHdrW02spKJmSrNs8lZkSzffuFnAL5HrhOOMA/kdrVuiUk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121817; c=relaxed/simple;
	bh=tGOADW+MdGM+DyrIDTtgGvbEQjLcsi6htlEf+jPSOG4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WzSjfaBXiYIeGVxdK0H36Rl8as8urRB/HDnh3WP5Jx7Kc2klqvXticrggsYQpMhen7o64AQ0wQu18nCG4JRW5ZcnA50qAJjj3VTTEI5eZgSASOKutSdteIT3SBtmTYUVAK7aO2ggXvVGx6MC3wYnQVPV3uZ20Ndf5j+C7eOAZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff//8nrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3930C4AF0A;
	Thu,  4 Jul 2024 19:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720121817;
	bh=tGOADW+MdGM+DyrIDTtgGvbEQjLcsi6htlEf+jPSOG4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ff//8nrGkJrXCOLIF1ExV444IA4JdTZxrr8KgaVEcVjfq/UNl5iD40+SsxedrivxM
	 S1MVhxEnOUCGZVakdmEv70pfEUHPGpjjE+fIFoq7i2/NnJyXkjHGrpgAXf/n45mJyh
	 YKyMndcfV1tl6iZv+ey19hs8d6dF8VBUFAX//V8Di6f92Z/3K5l6HLEjQ8ZBJAKjt2
	 IJLpIdsF7wz+ftI5lj5QD2TMe8s2QdJifTbFy+Yizba39f0rs//tofTTljzH7tklRM
	 OYFLgkYw/CqVjrUCH17r/3Ez+TmydsSqLetZAf4iiun0LGY+K7ya7MWNuNF8PPCc6u
	 h4aiI7U63L8FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9F11C433A2;
	Thu,  4 Jul 2024 19:36:56 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240703222728.d5ef62a48ebf19260832ee73@linux-foundation.org>
References: <20240703222728.d5ef62a48ebf19260832ee73@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20240703222728.d5ef62a48ebf19260832ee73@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-07-03-22-23
X-PR-Tracked-Commit-Id: 93aef9eda1cea9e84ab2453fcceb8addad0e46f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8faccfefaf1426a171a60cc35414fc2b1958a2c8
Message-Id: <172012181695.16688.12682281081630534846.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jul 2024 19:36:56 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Jul 2024 22:27:28 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-07-03-22-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8faccfefaf1426a171a60cc35414fc2b1958a2c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

