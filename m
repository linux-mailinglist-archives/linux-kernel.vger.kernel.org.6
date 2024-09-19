Return-Path: <linux-kernel+bounces-333137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF797C46E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F65B23427
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39BD18E368;
	Thu, 19 Sep 2024 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIGkzB+s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295418DF6A;
	Thu, 19 Sep 2024 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728493; cv=none; b=bjwEugrG82/gI8sk25109orfgqcRyGBJi38+IzttJ8U651hu0BBVTuYhIaa2B3Mf8GFcXvz6pexyz/DfFkqOOEArJU+XUZiBElweLqRCiKbc166v7N24ZshWBy3Id/HSCMEhaqAWyVh7cH+sT3K5p5OlmCxSwKO3gOj9MqGNk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728493; c=relaxed/simple;
	bh=3n3dADMeK4Rke6nAqfmPa57qveTCD9hQa9AW5s0w3oA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jLGa13FYYWdbJGlEzMP5R7jh8GvXOV1OWAg+pPGbX5FLKll/PqouuYQB91L7wV40mdbd8f74jrJs9xRSDMhjZc87YEF92yZGq6O7KkEbRXizIByP+1r9IiPslgFDEf2y5cDq857xssyTPAUhpxfIjdJw01GVRq30tg6saFbmIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIGkzB+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0730C4CEC4;
	Thu, 19 Sep 2024 06:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726728492;
	bh=3n3dADMeK4Rke6nAqfmPa57qveTCD9hQa9AW5s0w3oA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vIGkzB+spPI2LAKb1vxXfT4nvoYFQ7wAu3WLPeKlhCsMH+0FvIKYF/ZVCsPlPgNsv
	 caDfX1ILT6SDyNm62tFRAOiM1S6onC69UDi31dU17XSY7p4oOdtJ4HldlBPcWluBQc
	 /k0Vqhy9/LCiuOTC8rVpEXnhgp8JhGMYklKyQPBJC3OUy5XlmlyAHx0s1nrlrZf83q
	 WC61uUpZjwOXO4mHUhczHTosblCQVpdZVpYub8f2ul9TxEfq5Esxoo/bxEQk36V+Uz
	 rlKg8kQEli3KC9MwPEjPKxUwxxU2bXfVunISKjhDtQibvwE0jJh2bPPRBysYMskDkP
	 OBi//P+rzWHRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBAEF3809A80;
	Thu, 19 Sep 2024 06:48:15 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes and updates for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zumu14EgYx4LhqTx@p100>
References: <Zumu14EgYx4LhqTx@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zumu14EgYx4LhqTx@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.12-rc1
X-PR-Tracked-Commit-Id: 5d698966fa7b452035c44c937d704910bf3440dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54450af662369efbd4cb438ce7b553dfffa00f07
Message-Id: <172672849445.1360580.8790815854499878882.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 06:48:14 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, John David Anglin <dave.anglin@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 18:31:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54450af662369efbd4cb438ce7b553dfffa00f07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

