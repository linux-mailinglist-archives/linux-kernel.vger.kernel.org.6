Return-Path: <linux-kernel+bounces-179202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4116E8C5CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7277E1C21157
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55736181CFD;
	Tue, 14 May 2024 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoT0Nr9W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E52181BA9
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715723087; cv=none; b=jaHMVMw5jaFGWLYj4UQagT8fCALkrLPF8JBuquLX2NtOpRjkbKRJkbf5qAcxkHl9FhHPtcRC6s4GBFszLqjWCr3QXd87HSCBlV84mH91rYy1NTFBFPoIY/tv3y1/SRpFMPP8XlNlgFWn70aYH0iP7fCjD5GSaOdppUtVbl8S/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715723087; c=relaxed/simple;
	bh=9mURX/IsecpeoCCUHl6C1Q1T9qB5xqW5iEwrP6X+3CE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=npY58CW6qFk05KeJlrc+hyXaEv6VLphBZo1qXzVuPU6UIWr2MjJQpB4+Y0nRII+kun7UY3y3sCOlBj8ZC1ToGWN0SmGWafld2X5A7FuDOD7E0WrcSsxTxBsanuC3cd3uJm1WutfzZZmzWO8mmK3CsbAv0ZhMm7dsEzL2847cwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoT0Nr9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 777BFC2BD10;
	Tue, 14 May 2024 21:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715723087;
	bh=9mURX/IsecpeoCCUHl6C1Q1T9qB5xqW5iEwrP6X+3CE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OoT0Nr9Wujjv76JuwUlA8dOAjxlyCPY4rH3wbiXjs+Q2nIYWbSNytcP3/TIEcReD/
	 pIWEu7aR8YzJI5ONY0oYotRBuv2qPmyRXJ87PlhAyfFvD5U3DFGCJIbGKl6yBewCVN
	 eUaUEiUbRfKjfOIhGnBmYG4tHFT67ApUpQPSr1pzN7UFNChorEEFLlKSLY2vjidToj
	 Oh3C1Xp3L8NBNk/j8gHnQWdsvgExveafM6CK7Nx9bf+CPyhUcxjLbqMIgY41+QGn+w
	 Q2cN0lLL6y/QfJqV3HNC7qoFkFLD3qu8MN0Vx+bKGmKj3oI436ovDnecyIen5fNs2S
	 0rizsYB5KaBug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69508C433A2;
	Tue, 14 May 2024 21:44:47 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <be1cf843f7131a702c3eebab6abaa82d.broonie@kernel.org>
References: <be1cf843f7131a702c3eebab6abaa82d.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <be1cf843f7131a702c3eebab6abaa82d.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.10
X-PR-Tracked-Commit-Id: 9b1fe0510494c989ab6a131ce8b97cdd02a1c869
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fffe418b2f97ebf1e65267852169a00c682152a5
Message-Id: <171572308742.14334.6928944796168861592.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 21:44:47 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 10:38:26 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fffe418b2f97ebf1e65267852169a00c682152a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

