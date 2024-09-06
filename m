Return-Path: <linux-kernel+bounces-318083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B5B96E81F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EA4286360
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11DE48CFC;
	Fri,  6 Sep 2024 03:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWBKSk0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2424642D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592809; cv=none; b=BookR8mBi9ZNlZOB/o2LqijeFHqgx0hRz/z5x87uFN+03oOsYSEd8YPZvDKVq+RewVkrnMQ96waOy/zyzlzci8KYniMs221jCtGXa3q/4nqBpMfH1d5Bpm7orRkoSKCyn0wfEqellGLN0bFvJMNV0TDFHh8+kcZAv13ClCpsJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592809; c=relaxed/simple;
	bh=3WAR0BE74gAAiW5ZnkxV5CumUayrBH1ari7PW2VB5j4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gD52EFHvkM44LfZmcSVFenimUwDlekAeIsereOg5/anzRVVUb3iWJN/787IQFyr685XVRtj22EWBmcLC28Rkga1hrTzJcYheJCO5o4ihF77u6obsz0nbkA8LlvsnvBpbs5i34j7hilYdP46/bLyD6MkEHbK224hUxNd5xnnJOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWBKSk0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8C1C4CEC3;
	Fri,  6 Sep 2024 03:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725592809;
	bh=3WAR0BE74gAAiW5ZnkxV5CumUayrBH1ari7PW2VB5j4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UWBKSk0+GzQ3RELvmScZbEDw43m24pWZX+vDJaqKmRkQj91dxcNO7fudfv9GqkWqY
	 +ArBwe4ZFmN2h7TpCMPySYCTCmwIX5Jl+BP1VDmC2KL1gXhAWO31LbldxVxZm1+eoB
	 8e9E9px6w1Oq3hFxyrpKibPfCDjJnau3uizgM0FPSnyvivg8jvJ2Qy9IkMRbSNSJ7P
	 GE0Wa6jyUamU/InQEcJQufD/SuVqV78mj+AeMZbKwPwoYX0c9Fx/2ItzrrN2q5Ms92
	 i6ZsP8FeKozNSOb2NYBrEzl0lL87xs5t2Klm5zNLxd8S7JNfLKBxOC+IgeCsWt8+rZ
	 4lkj9JwBjTugg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34BEA3806654;
	Fri,  6 Sep 2024 03:20:11 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.11-stub
From: pr-tracker-bot@kernel.org
In-Reply-To: <328dea14aef5ae409040961478b6a083.broonie@kernel.org>
References: <328dea14aef5ae409040961478b6a083.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <328dea14aef5ae409040961478b6a083.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.11-stub
X-PR-Tracked-Commit-Id: 1a5caec7f80ca2e659c03f45378ee26915f4eda2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a66044754a7b1f2784031f679fb25ba465595b2
Message-Id: <172559280986.1917326.14908746127523806257.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 03:20:09 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 05 Sep 2024 23:09:25 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.11-stub

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a66044754a7b1f2784031f679fb25ba465595b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

