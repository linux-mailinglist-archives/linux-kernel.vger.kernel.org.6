Return-Path: <linux-kernel+bounces-197599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48D8D6CEE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D39B252A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AFE13698E;
	Fri, 31 May 2024 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2EZG9mJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422B13664A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198817; cv=none; b=Y/RS6iKUJN61G8P0dfOUhnJYSKbAyNxFzfawuygAcZW9qk9smcU8UPu7BtF2Wpb1upvE1s9aHLTDuPTJeZsAzL4WBJUzERDUpCx1gQGPDAWNA/Sw7H/ojPwtTZbAF71u6GxZ0VvWTYrvJ5P7XwlnuKwWveD+Vyxa7X8b2bhulsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198817; c=relaxed/simple;
	bh=SKfPDB00gni6QaDb5sO1rj8fe2YaKKbKr1/tVM8Qu9o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s2+SAVtAm+ZS1HrN/EKh+2RczqAnoYiMo+3Q4FSCy9KGDjfLLMK+XE7HUW7BgfvI1z7f7cjIP0ZT3L1NJi1NFh4sVRP90VrRZ5xCu3XJb58lvLanfRYEaUvm1AdHSM5moPQ7XylUoP5RWJtKtdL6OiKAwWCV2pIyqVD5TRLkKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2EZG9mJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5905C4AF07;
	Fri, 31 May 2024 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717198816;
	bh=SKfPDB00gni6QaDb5sO1rj8fe2YaKKbKr1/tVM8Qu9o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S2EZG9mJx80kerNMLKaPEpqI5ViX2HB84mlw9ebbTJzZTIt6T8achuZ1CIsr8x2nj
	 v3/xcYiJgrLkTF/KloAIxZwmKeKigTUh3m3kb575CIVm7wMmZrlRCisfLnxcfXW/I2
	 wYG/hGucH0mx0Y0xyNF93yvJxS3gBgE1CqPp8o+e8KanjrYS+vIMmn4yWjOfv8hlaI
	 Mw4buF7ik7U7Bc+86qgEB+/lpFNsUrnFpm7Jt9lpb4l9mgv8O7NRiWwF8hqDTmQSCW
	 9aeX6Gh6ex8xPnK10PZcg7MFRUZ+DiW8u/6Ls0/5G1zD82C/dKdNg41kT2ZCyIrvjx
	 WQtoksek/1DRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C79A7DEA712;
	Fri, 31 May 2024 23:40:16 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <61fbae7ae23cc7bdb6d20621db77ebb4.broonie@kernel.org>
References: <61fbae7ae23cc7bdb6d20621db77ebb4.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <61fbae7ae23cc7bdb6d20621db77ebb4.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.10-rc1
X-PR-Tracked-Commit-Id: 72b6a2d6506843375c7b91197f49ef38ca0c6d0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28add42dc226a4e7caf139407df714820b389bbc
Message-Id: <171719881681.1891.5462045575910139462.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 23:40:16 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 May 2024 17:55:36 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28add42dc226a4e7caf139407df714820b389bbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

