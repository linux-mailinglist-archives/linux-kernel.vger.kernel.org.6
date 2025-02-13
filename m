Return-Path: <linux-kernel+bounces-513944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BDBA3507D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEB5189018B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0F426980C;
	Thu, 13 Feb 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+jHe6NS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AF266B7F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739482199; cv=none; b=VCWZwfKPkWcGzOd1hvM1225bDsoB9rqAASR9w3CG++T6T1NCi8rpFCHBR2XWWH9ip5tel2hurugjSkjTHwhY/9Yf9dnkyLljTpC+KaIh+Vk3XTLf1u0vvZa6LUYocGb3jHSBEXFBELJ/6t7CFVtIDx/lF82shyWkITMCIBC4SwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739482199; c=relaxed/simple;
	bh=/r3/NkYk182o9DO2nDr28dlQylFHuhkdfL6ecAi+PeY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uRrfKRzap+2IHzJgGLmI2J0UA4W2lAdg/m4V79p4YTn/aSfjwQybK5g72fNcjcHKTaZLd+HJZfQbqAtzPJhYjcSLacJ8ux1Sq0OE7Bk57qvdX3JmQGMINeJeabGc84hs/KfeoWHY2jhF9Gmg15AvXhm/F8SigceRDgIUXHV/iEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+jHe6NS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E35CC4CEE5;
	Thu, 13 Feb 2025 21:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739482199;
	bh=/r3/NkYk182o9DO2nDr28dlQylFHuhkdfL6ecAi+PeY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O+jHe6NSUoM8aLaXGhDEGdFCpseQouc2Ux+pvR4y27V7mi0YNd9cBJyDLLxaGXEH+
	 z2UmGA/Nc0IHUVlccOQ/thBtfXgzVw9YG4wP8ZacXEhQtQWAvsQ4c8cvnhK53i/CST
	 tTfp0NP8gJjkaLMz1JsSnEl2nrNXkqAW2lYqsZ0v4hRAo6klkqVJBYGyWrIvUO616p
	 ej3n9r8IJrszKrNz9Urzvp6q67+yx0CX42SHCdOpYWxMMOcUSnCcuYpWe7tDJmt+8v
	 O0X0dXTlFGc4KgDjSgFPldQJcIw8gQCY9x9Z78wQXdbR+D/So5bmfS/LsoNStpg9hC
	 NbkkTjcIWdeCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBF74380CEF1;
	Thu, 13 Feb 2025 21:30:29 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <e25038550cd571bab188a0e61e2c2b2c.broonie@kernel.org>
References: <e25038550cd571bab188a0e61e2c2b2c.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e25038550cd571bab188a0e61e2c2b2c.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.14-rc2
X-PR-Tracked-Commit-Id: 35e21de48e693af1dcfdbf2dc3d73dcfa3c8f2d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85cc5751db7cc3211945bc380c944de6fe6979d1
Message-Id: <173948222846.1382339.1721834139806394692.pr-tracker-bot@kernel.org>
Date: Thu, 13 Feb 2025 21:30:28 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Feb 2025 19:00:14 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85cc5751db7cc3211945bc380c944de6fe6979d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

