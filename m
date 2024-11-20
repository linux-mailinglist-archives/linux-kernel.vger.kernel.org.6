Return-Path: <linux-kernel+bounces-416403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66A9D444A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0723AB225F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69BF1C9B8E;
	Wed, 20 Nov 2024 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx//pW19"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D21C9B82
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143750; cv=none; b=KE9EBxNs7/DV9NhWaLR1j09+YkF1O8n43FN9IUi815KbX6khBaiTDPcmWRrWV4tWUYIfU0l/VVIoUSsWKAhwSD9RiCITfMsF66QUjD1EGZa+NXcHy8JHMM/vJF/slYOjEjQhKvZ8Yyik7CkMkqXlFxmfHap+8fm3VTYd5ZaSleU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143750; c=relaxed/simple;
	bh=0Fh4ru+OrzDi64cCjYU8HWazPhZpZO/1VhEIg3k5Zl0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uoQmiqf4m5nSzeATrp9P5/Ffi8UrbgUutTSLyx27qkiYpPGdd4SkiFWAJlidzdkFC1eZtXmzsdftS22cZSE1aYM+meJuzHf/IQ8WNLhDy/NVWYTKO12JaUvrlyD9ymIwIxdPF1hq2mGx0Z1qfZaLiUfWdCNidgGLp/AI4wFyp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx//pW19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B5FC4CECD;
	Wed, 20 Nov 2024 23:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732143749;
	bh=0Fh4ru+OrzDi64cCjYU8HWazPhZpZO/1VhEIg3k5Zl0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qx//pW192G/17o7U1ODfaNZZZRpUnTtePwd7CSRxYzXVmrNntby/cN0psbRakbf5m
	 AO+dKDhoDbBzsJV0sGQ1GM2jD+Z9H8wk9Yt3nnORgtHErSejKnTSKKyn+ibkWEj8Uo
	 LaqJdgOQLQSgthly3KATZVRovuiP0qORc4aXHgnueS96ibCzE5hKYoRzvx+p9rcegX
	 1DQS+ueWkwiYL73+rzH5POQFY+pomTd5Lu5Eg0OlMcxWDgUZfbhDXi+0wcXyJZA3my
	 Z13GHGAYxdTqj/0bRUpZb2LtmYhbTkrp3uBaGq02avxObR6uikdyghYPAoBd9gtjdc
	 /PGO9DY3K9QfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD313809A80;
	Wed, 20 Nov 2024 23:02:42 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <39293bc3-ad14-4196-8a25-a13d66982b2f@monstr.eu>
References: <39293bc3-ad14-4196-8a25-a13d66982b2f@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <39293bc3-ad14-4196-8a25-a13d66982b2f@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.13
X-PR-Tracked-Commit-Id: eb01f8f3c446ed81e3b2c44b7fbed8a5d6be9d3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f103749785a76c3e06d52fc08bdb695fbde6e042
Message-Id: <173214376138.1381175.233664933347937002.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 23:02:41 +0000
To: Michal Simek <monstr@monstr.eu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 08:05:42 +0100:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f103749785a76c3e06d52fc08bdb695fbde6e042

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

