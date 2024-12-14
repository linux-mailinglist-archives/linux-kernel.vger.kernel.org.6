Return-Path: <linux-kernel+bounces-445826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9839F1BEC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D125816A144
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74929CEF;
	Sat, 14 Dec 2024 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmLcgecZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE395262BE
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140130; cv=none; b=nv7RqEw+DSfgbOxxuUbnKdk79g+vXh6KcTIXgefBTJljB9d0kc4wlGKB7/wuIJaq4z6xJqaiOSvVdmuFUMu/8kT0z+LNJjmMU+J7RZsWo4bVL6WqeTsbxXKMWSDUFPFGWF7Imjt4Qto+lJhNK0P+otu193xS6prujN/mIU+xUwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140130; c=relaxed/simple;
	bh=YDpIMAUvfjgNpHixKYLvrNrVEWjyLk2ztw9dFyHMygg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k4Qoi61bqqMQKSm9ZB8iml9c3Tm87/rSgWuivzl2HjtGgSganGE2J9KS4jNRXuj2Iw8Sn3eJIrJfQw3dYMt8XhlLo3UUfp9dLhDy74Z7MaUFp50ALky9YowEPyKSU2RmE2Tc5zXui6K+3ejo+Jt24ANOu9HeRm8zrCP4nLoO2N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmLcgecZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7377C4CED0;
	Sat, 14 Dec 2024 01:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734140130;
	bh=YDpIMAUvfjgNpHixKYLvrNrVEWjyLk2ztw9dFyHMygg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CmLcgecZQnNsVoQLBgLKNzb7zgdq7ZPQhVd33+TPslfVe72EVjeWu9Jdgt27zk7Z8
	 mVSTBSjOxdcsBPVgy4vYjkMIYnt8T8gRn7ehNMmnV8kjHQnPcqdky9ekLha/Xf07cd
	 CI+QLIH5B2inym8lVqG9P7X1qfF+e/TXB7VrPTGqd+bPK61d87bMKxXrUiYUtcY2T+
	 nFL/nUL3yyRCScqm4cl3LGQT1oQcMSNDakIVtGwvlQ07lcH+1KsORyoVtcRxxbw3ij
	 gzGLJ0dXiGtXOMXUCdOjCFzafcEsfh+X4Fhwj8Oj24R8dRhFgxC9s1/W08D9ER52A2
	 Fo/BTx9jdUMYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716EE380A959;
	Sat, 14 Dec 2024 01:35:48 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <9982142531c7617c43646d6e7042267e.broonie@kernel.org>
References: <9982142531c7617c43646d6e7042267e.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9982142531c7617c43646d6e7042267e.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.13-rc2
X-PR-Tracked-Commit-Id: f07ae52f5cf6a5584fdf7c8c652f027d90bc8b74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e1b4861a28841afc3ec4c192845feb411953d56
Message-Id: <173414014693.3218065.3535551297204253293.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 01:35:46 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Dec 2024 00:47:47 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e1b4861a28841afc3ec4c192845feb411953d56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

