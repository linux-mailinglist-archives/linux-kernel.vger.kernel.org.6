Return-Path: <linux-kernel+bounces-257747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0DE937E65
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE651B212E7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22173EED3;
	Sat, 20 Jul 2024 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTAjGtic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF22B66E;
	Sat, 20 Jul 2024 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433955; cv=none; b=NaYZ2ZyR6XRkrScpM3Q545u42LLQon73tpQFoCi1H/ubzibk0lWR4SKtqFx7SIOlzeMDI+UFrZIW1BhBlg2NrBLcctS9lAGdQ5vDu1Kzf5EyqZGU1BEhwTPH4yuiNF0y34Ai220VD5yA4VeIKY1G2z0cG+0lG/LqZGwkwAyN9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433955; c=relaxed/simple;
	bh=wkW7T9+wbrfC7qLOj59DHVHicf9Yw+lpNgMEYokv2lg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i07OjC3L3715dblWMCsxICIea44OgD8YdLDx1FBNjX28xmKpL9Hs/S1bliUSOh8zy+KrcPXwcBgdj+vGzd0U5ilq5QnjeZP/YhusbBLn1kFgqFA2Nl/KkCFtvS3W4AHsI5Xik9P+4AgpwQXYQSq01khjakuwqqJk0Fv483J+3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTAjGtic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45190C32782;
	Sat, 20 Jul 2024 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721433955;
	bh=wkW7T9+wbrfC7qLOj59DHVHicf9Yw+lpNgMEYokv2lg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aTAjGtic/BL4U9oDlyoOCNpBqogSauq2mmb+JZr3U93TXGLRoDkNkK1OOtNlOzGFJ
	 P2wmUoCiTiGiR6TTQjZs/FWvV3yX8DAe6wbutXdzsrdrkWH/eRWCeAhrMfuXDYiF72
	 MUMnQ5R53OhC3Zmpe7gTgzMhsfMy70fMPb13Ujifjfr11Vg1v0XXlplnzT7LmdBvnO
	 3K7gGlGGToO8UxvEFVsDNA6pQdsNWTPgIUWQEjDlAXmdGBA2DKHZ3QcDNAJiySCAv/
	 AkqDsYPvXqmedmgl9LS6c2lEhmmgMyDywDWdZ+85JPl6vp9f5wLP5Wy2ygoKUpx04m
	 7OutNcIKKPs0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B44AC4332D;
	Sat, 20 Jul 2024 00:05:55 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver updates for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZppbUEfumxaxy2JV@kroah.com>
References: <ZppbUEfumxaxy2JV@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZppbUEfumxaxy2JV@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc1
X-PR-Tracked-Commit-Id: b727493011123db329e2901e3abf81a8d146b6fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04d17331ca33744e1426fdeee7ba5e975c4b2239
Message-Id: <172143395523.25682.16037034023875383258.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jul 2024 00:05:55 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 14:25:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04d17331ca33744e1426fdeee7ba5e975c4b2239

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

