Return-Path: <linux-kernel+bounces-176048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562938C2941
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3181F2331A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9A1224FD;
	Fri, 10 May 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVHRURnD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9181D6A8
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362156; cv=none; b=fFfivC1dZOPZQ9yrcfl3mykiF2tr4lczDJbPdkGOy0ucgeBAsGmIF0fArajPBPa031H2CjgifFqIVEak8ABUCbQBXCsiyIr2OemNqDYxmlMDv7cGGXcgn6s+gXrSM0gxmaPUqA2eHzxgYvcbyWJKmr/DP5ARgDbtLaXv/uBOYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362156; c=relaxed/simple;
	bh=zc2xxw9lIDu57dymoX24rcX1CU3BpS2I9Piill4IUkQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l60gA3Qc64JcX0Jp1EMAbjzS5keH7DAx/zoJZgSpFrdA3Om8a++ECrnmkab7iFxI3SAStYu0A+Eg2xP90E0DEjKGW4KTQO1J6bL4erHUaE4P2ELwO3Pcw6Oyp+RZwV5hZ+loYgFQkJ+mG2SkfpW5Uc5pu2bGzncgPnFDHRzuyW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVHRURnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B7B7C4AF07;
	Fri, 10 May 2024 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362156;
	bh=zc2xxw9lIDu57dymoX24rcX1CU3BpS2I9Piill4IUkQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AVHRURnDHCiLERaNk0QT1qFsVylgWs+71P8aiDENKlu8zd5jJH66cJ1qkHhUSXUZK
	 Qn4Zmy5XhBMQSdt42wklaVyOZ87k+m/NKi5bkEzXgq0rJ8FA/sCIC1VLYv8M9CLj73
	 MwGnHyPGFxE9dWmVEoadkZ3Hl2lDiL6BKVW8/2lpgDZXcjp0FZ9Ep9LXWnpYAiDgtm
	 SK72bw6Le2UUtbHO3JFjQzl3ew6MNgd4tEOpVtlzCdbDjgp4vJ2XSfcfND5ORR23H5
	 IeSDAs2hohKxMSw20+FvvcP/jTE0uo9cWkqRH7xAlUVUWlxkxx1xd2U14ytG7N6QaJ
	 hHCKcDO83V5yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 711FAE7C112;
	Fri, 10 May 2024 17:29:16 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <5a083c1fa21b73db20ea4b8a8c86a5c9.broonie@kernel.org>
References: <5a083c1fa21b73db20ea4b8a8c86a5c9.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5a083c1fa21b73db20ea4b8a8c86a5c9.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-rc7
X-PR-Tracked-Commit-Id: 2a4b49bb58123bad6ec0e07b02845f74c23d5e04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99dff4849691214627bf2d6d53b05a269cb898fb
Message-Id: <171536215645.32093.5132205854842351912.pr-tracker-bot@kernel.org>
Date: Fri, 10 May 2024 17:29:16 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 12:58:12 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99dff4849691214627bf2d6d53b05a269cb898fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

