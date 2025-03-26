Return-Path: <linux-kernel+bounces-576429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF02A70F24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2DC189C75A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B478129A78;
	Wed, 26 Mar 2025 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f24w4Z/O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960B145B3F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742956807; cv=none; b=qZ2tt26yKndqvitB0RXLyk605q8nhlsv0YbRa2LivJt3p72Dnn/aRzly8z5ut9n8vbDLVRQK7Kfw7SSRXnNy8XW/51AyATZMJingtNIy/ulCqjB5lkY8TKG5KgmY7A3BP1/FMTZnY7Hihhxfl5A/DJgQWPZeEy+iXhh0bmMwDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742956807; c=relaxed/simple;
	bh=Nxov7PimXeuAcKTqVUTOJd+OlkduK11ZR0Yu2enzrJI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LQWNU6kecVneU0v0IqJJRn0hQuMhle7qB0APRt6Z6q3iPomdEHn02Ls2pmpVSm5E1kldYmnmmCqR13vjZDW9LU9uFDZC4KmXJkP425/a4hktf12p0Ik/OOXw/TrtnM6oVDnGF6CEYDGoU5/sYdcYTSLdbq7czJiceSoKVNM6dAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f24w4Z/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353C0C4CEE4;
	Wed, 26 Mar 2025 02:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742956807;
	bh=Nxov7PimXeuAcKTqVUTOJd+OlkduK11ZR0Yu2enzrJI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f24w4Z/OrH/tAPY39O/FCB/Re4O/EHdnUqDKkWKBWtzwQLSGw+BAT6C2bwFxELeo2
	 APp6ytaoIUsRApcohuGMOXtVedrKxtucipy+RFuC6mduOVWQOO5/ubZcMDyRWLLjZl
	 pd0RmtR5yby0MqsVJq30yHgHvQXmQNyhzKXgUyRW+LeoD9bMB/GAAb9hIlShAJR+eh
	 RYKeA6i57WPqV3HAFg25cQIEBYfiybAsTsGNUFVQB9gttVZl/6EHGJjfU9u+9NRGJv
	 fTWNnH1kuU1T4/23HvJ52qTiHrQ9Z2SmTDEvHLtwU2rcRLm2bh3U7EJkSUBABLtoSz
	 4XXTVZgxVcFwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0EE380DBFD;
	Wed, 26 Mar 2025 02:40:44 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <c3bcfe47f04670e9fb5e49afee560a09.broonie@kernel.org>
References: <c3bcfe47f04670e9fb5e49afee560a09.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c3bcfe47f04670e9fb5e49afee560a09.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.15
X-PR-Tracked-Commit-Id: c94764d3f4e503c0c4d56c8f64a8a63645091898
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2ae6e14d7c43e955580de81edb025e7fe56bb6a
Message-Id: <174295684335.817729.644075641823547772.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 02:40:43 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 14:33:10 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2ae6e14d7c43e955580de81edb025e7fe56bb6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

