Return-Path: <linux-kernel+bounces-263588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B893D7FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82ECBB22F10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0E17DE22;
	Fri, 26 Jul 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oggPMPX6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8417CA10
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017264; cv=none; b=O7F4rROmQJiHEtJTLliZgdo7HDyN3egP5LJ53PG5WJu7Go0H12OFDqUPh80ddA3WaXd8X+WuzVecLimYTYf4wh+p2cGWqguvUocZpreXqNA90G49vMLHbYLOTqzbCkdP0jDkqtrk1do2JHu2hV1wmlotVQnuIPEnWh7Ag/ZuMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017264; c=relaxed/simple;
	bh=SgBSdzLF1DCEMO0g4AFO/kMi9XFz1ly8WKgUglmJLjc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DmvOWEBTOVbXxAMppCSJQA4jb5S+oM2JOW6+QvVzAMAFRHqBr4ev/tDcgr5+a+vq9211K9uBn1WsRwc1NfrS0WbzH0LmLaY/pZBtzoyanRq1wo2yKxQdQ+EkUcK2FqmU2W3iOgCODTeUQ/eKEtha3DvqOv+CHSwglKgcE0rGaCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oggPMPX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02235C32782;
	Fri, 26 Jul 2024 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722017264;
	bh=SgBSdzLF1DCEMO0g4AFO/kMi9XFz1ly8WKgUglmJLjc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oggPMPX6t3UoX8Gu8JMW7l/LDNHQarQlgUXa3iReXKBudhBeWqWTh0vUyoQWldWCj
	 BhtEuJDuZLZVlzphU3LxlAZmcWwJgpQ28Bc2x8+HWR6Suf0j5puQYAMPCnMajfjTFY
	 ugrNH1/J6SSbuDxRi64KaKbfWJNU9UDWIj964HZj156DEcSWLhb4sx74GQ1NalmGiY
	 8cjxmwpkwjQ0t2Wu4C6Vh9WjTbNzee5yFjfBrN/z2gcgtWfqBpk3ah6rBtlKJbkC4F
	 HXJK/MIjLHz3MsPYl3lNP1tnTwigX8JPxf+1D1RQD5362zrNwy/2H3XJ2jPoI9g/uJ
	 yIF8eeD/D1Y/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEC12C43443;
	Fri, 26 Jul 2024 18:07:43 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240725084741.2519888-1-geert@linux-m68k.org>
References: <20240725084741.2519888-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240725084741.2519888-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/auxdisplay-for-v6.11-tag1
X-PR-Tracked-Commit-Id: 2ccfe94bc3ac980d2d1df9f7a0b2c6d2137abe55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f8c4f5062855a83c1f2dbc012c4fa274ce999d4
Message-Id: <172201726397.32235.2523302156677080560.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jul 2024 18:07:43 +0000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jul 2024 10:47:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/auxdisplay-for-v6.11-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f8c4f5062855a83c1f2dbc012c4fa274ce999d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

