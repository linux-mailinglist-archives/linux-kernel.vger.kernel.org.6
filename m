Return-Path: <linux-kernel+bounces-255858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F89345C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1202852EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74038DFC;
	Thu, 18 Jul 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHcsy1U/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05C42052;
	Thu, 18 Jul 2024 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266038; cv=none; b=gl7o8VfBwwXb87wZwcic0MNIi5ZQlMiznQXSY/3vpeTFaJmXfp46pJlSmdrEMed1Fzug1GzUaBfHQql4Acxdah7kqvHAd2vSdyZvoBxBknE4pU9E8maZG+ZAvr0/UW5cBS1avoX6lpIwQDDf4qxV/LvnZplUn5zCVIhIp/2NOuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266038; c=relaxed/simple;
	bh=P0WL2gTNHZVwy74zCJoBg2e197Tztu461C2tZavqREE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KyysCtrpYlXvXDBjJew+XpP/wP0tX8yi1XNVazdbXuqRz2fwtpFVBh4i0u0e98jOX4tgJdupUa7hjLU92fgRkYGSYqGjYSLziWhPXx3+khyW71CpRe+zghejzDspTy+WeWIZBJi6o3KbMS6DPeb3r7qMmEtJlYeBx4JlvNj0tHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHcsy1U/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 909AEC2BD10;
	Thu, 18 Jul 2024 01:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721266038;
	bh=P0WL2gTNHZVwy74zCJoBg2e197Tztu461C2tZavqREE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LHcsy1U/WQ5foOfX0RdiH62B+i6aJqXvlmAfvYhE6i8GzSZ6+maRFjbjjuqabAuph
	 KkbAbsk6+99Z5puWHPEPfQSZL3Gbkm7AzHlQ0CZrE8T9gIUpvVJokfRkTF621pkDpy
	 vGjoTChjHNjFfbbiOvxf0K3rDwgVVJW8mFhim6zQblSm51XXRPxQDq1mcVTFBstGX+
	 85HHgvgnKobj567Gp0askxOG+fKvrwBYkga2HiKEa0V923ogk0YyQZLtvBNElb39iE
	 qHdIpnsAbVkCLIV4FxXOcpI15fp1p6fBuGr6eHwFSUcxGBFray6UmLmdo5L0eupT74
	 RRvzg06bCFqeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 828EAC433E9;
	Thu, 18 Jul 2024 01:27:18 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.11-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20240716131410-2360330733@linux.intel.com>
References: <pdx86-pr-20240716131410-2360330733@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20240716131410-2360330733@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-1
X-PR-Tracked-Commit-Id: d8b17a364ec48239fccb65efe74bb485e79e6743
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5cb6b2bbff9cdd32aab635ad464a1ee299a63bd
Message-Id: <172126603853.24030.11803407645034082507.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 01:27:18 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 13:14:10 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5cb6b2bbff9cdd32aab635ad464a1ee299a63bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

