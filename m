Return-Path: <linux-kernel+bounces-551641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B04FA56F0E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E27170098
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E0240608;
	Fri,  7 Mar 2025 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWiKNvZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354321ADD1;
	Fri,  7 Mar 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368700; cv=none; b=fg4Mwa1iBGYYriyOQxtkQ6KvprnxUtB1e30CefJFYRgF+yMCi/BsfafaY1zTwL0g0inY+nWDt4JlT7X4n4nUbFSBz3fcikb52PR4/H2BNQg7+IcAYzOWye4sWuLeqTE/2VvAvJXM+wPv4PbaN4SKXL7ZgyL5+ASC2j0ZY3OdXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368700; c=relaxed/simple;
	bh=NX4ZcWSneclt5lEgyEtCTmV3g+v3QbM1MtlATHzWpow=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EXwa4fMMi0c4yPLEta9FHUB9zuWsQZoV/Rbol/a9vvCWE1OWiHKW5B16eotnAuBsyh7GklFVdjcjNK/tshxAL8c9M5fF7TsHmx+BN+MzeobUpN/k7UUVhMMCf17+AtYe0wytGHzefAiVYthwG9+/H9twwmdXjqXKuQxVpRSCxnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWiKNvZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B16CC4CED1;
	Fri,  7 Mar 2025 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741368699;
	bh=NX4ZcWSneclt5lEgyEtCTmV3g+v3QbM1MtlATHzWpow=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IWiKNvZkGBLcV+HsvWjJANvakHPuY8mElrF8BGILV7bTxATJN4KR7tQcsMLW4vHp6
	 NsLggyPYf558A0fS43gBDd72WSQaqAQIijxWqBzwcO/Q7k+QzLUg0RPlAwHpp2sfnl
	 Ef0lU/Ep3R6U1JFu+6nyMWzDskGA3+IO1y0Mccd4euFNTOiCKnVbXEZREmSvRraM9d
	 deXKD/GFz6uHH/Kto3Da8EB/P/chnXszyyDEzp5L0oisuWD/Q3/Rdav225wwUiQNCs
	 oJaxKN+ixrCrOs32LHuPzwTOuQFCs8WyURtelEFmaMoxLHUHX+QKF1G5rmtxNH63Mp
	 IzG0oRJ/oQsYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D71380CFD7;
	Fri,  7 Mar 2025 17:32:14 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.14-4
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20250307115821-1780710253@linux.intel.com>
References: <pdx86-pr-20250307115821-1780710253@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20250307115821-1780710253@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.14-4
X-PR-Tracked-Commit-Id: 376a8c2a144397d9cf2a67d403dd64f4a7ff9104
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8aed61b8334e00f4fe5de9f2df1cd183dc328a9d
Message-Id: <174136873268.2423139.12973561050293747008.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 17:32:12 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 07 Mar 2025 11:58:21 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.14-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8aed61b8334e00f4fe5de9f2df1cd183dc328a9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

