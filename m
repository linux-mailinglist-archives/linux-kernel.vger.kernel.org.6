Return-Path: <linux-kernel+bounces-571994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43953A6C51E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0752189E29D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F88522AE75;
	Fri, 21 Mar 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTxgJFyt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB51EE005
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592415; cv=none; b=M7mnau4fEo7yKiSpsNt0qZ64dGP9/V1gmKjd8M0hprR6j3i/7g3INvrUDvq/RJoIHeQUet/5W9xYfO7dJ5sPOSEkOmDE+IzU4fBQStFFIcqGhtFMFNXMvgbMBan4IfUMk24Fu6jaGDYN8+5CWeX07KcQfLF7KQO1kRMZTwP0h14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592415; c=relaxed/simple;
	bh=vYrmCyAySdUWIQLE1Idsw/eusAvF8uLcPBv0jZBzRYw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J0DuARbsY6bda82FQzvLwGSGytOxoee7xirE+Q+LHNjSxGrjtOlUtZZmclhabNrjgEaoq7fZ1f+bupun9oclGsImZUnG6r/hXpLaiZHbJWCFKeZD5FVDc8Ix1deb6vkX4o37/tumfHt+jkQRWBFWkWj6gcRjQhPM6g8KM05n990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTxgJFyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707D6C4CEE3;
	Fri, 21 Mar 2025 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742592414;
	bh=vYrmCyAySdUWIQLE1Idsw/eusAvF8uLcPBv0jZBzRYw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hTxgJFytPZtvik2PcYxYl8TvYgQnJ6Eiyut4laYllYmWBJ6og9XTZd8fXs3NPcgGx
	 QhvIT9s1UESxBfCQR5dmlYSdQ18pSzoRgBi6HINdxnNtitjllyX0hfGn5QCO4KNU0V
	 spo09quDdkgtaVyeu0I6D3wC+WcCqv+eq4Sv8X5/03cmArfElXKTVlCpIJsHL+XnmA
	 iomKZf41iKOCC1lSE3xGdqoZQh3+qrRSM1wZgmn11iwo6b70VEGNeVA/2ChwIaTVjc
	 FFb2y7fytFbb7ezMdN7depUe7ZiD39raGB56hyFJ+sEDRaLFq/zrmXP6Pa3cVKEO8p
	 YkkanTzQB3wkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE7953806659;
	Fri, 21 Mar 2025 21:27:31 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.14-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <50c80a2096aa0f389fffb34dfffc82ba.broonie@kernel.org>
References: <50c80a2096aa0f389fffb34dfffc82ba.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <50c80a2096aa0f389fffb34dfffc82ba.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.14-rc7
X-PR-Tracked-Commit-Id: b65439d9015024c37c6b8a17c0569ec44675a979
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21d1ccf0e97d533d5dee470f5adce45358a0f996
Message-Id: <174259245020.2631089.7311818380052873527.pr-tracker-bot@kernel.org>
Date: Fri, 21 Mar 2025 21:27:30 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Mar 2025 14:38:53 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21d1ccf0e97d533d5dee470f5adce45358a0f996

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

