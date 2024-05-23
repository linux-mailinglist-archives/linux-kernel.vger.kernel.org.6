Return-Path: <linux-kernel+bounces-187985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D448CDB8D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35C41F230DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DE585297;
	Thu, 23 May 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1fy7NJu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573BD84FB1
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497361; cv=none; b=i45xxHvPfqmQAioUK2smD/Bl99cxTkO1rC2TffEZazLtf0r9rqJuwDfgQzymfld9YbJtFpS69bJgX5yFbFUxakQdgamCnibuCgg+zvZhSm8yyxzKLR77prVNtcYylp0xk9wBVYaPBJeLZiklHKjovdHltLztwFBncXZQGIAJ5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497361; c=relaxed/simple;
	bh=sE5LdrfRbtc5RihEkwMMPQocx59A0eaEmY01/DKE0AQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HR6umsCpMms6bjZ/VNT23pn7fM9WlVQqlJJBIVhlkjDujsqaSYBPF/k4tIvWeTaOiMfS5v037eZvTPTtrlZu5bmZn6UFAdsoykxL24cYJ1HRA+COXFmzg2Wf0Cfda+2+wFBIKtK0l1nUhYkPBrMnoThOeaqwjRXcPH06rXgb0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1fy7NJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1AB0C2BD10;
	Thu, 23 May 2024 20:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716497360;
	bh=sE5LdrfRbtc5RihEkwMMPQocx59A0eaEmY01/DKE0AQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O1fy7NJuwy2izmdqqrpkq3lKtLg5/kT8JeYopv8dq1T8F7OukJMKOg2fzouxfWThI
	 KZsdkKCuMksRPu2unYe97FpYQtOSovFmxhwPehOXryQKFIpiA9qzxjSpBAJJzpdwY7
	 4yyQpJymgsPXshrmNdrGEqJ/XRhup//lRERO6u61RE9NQwgm/uJqvlmmDrS8OVqNiM
	 YMj3CZ0aRj93q/Eq1pM4+qQxUmcsz/WDbeecQHNR+yrpQeawUJ22fqH3/PUXsNzzy+
	 2E1XBadWTYnIaE0f9oNEgk5z1CL7EqRIOKdCtZN7nyKEBVMAv/F/WggrvGXw6t9wQI
	 3Io4F5c7EPAlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B17D4C54BB2;
	Thu, 23 May 2024 20:49:20 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.10-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <e6cfc0e5425a26caf92012a9021e6a47.broonie@kernel.org>
References: <e6cfc0e5425a26caf92012a9021e6a47.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e6cfc0e5425a26caf92012a9021e6a47.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.10-merge-window
X-PR-Tracked-Commit-Id: 7ba822189e6060a8a2833b721d430f833bf0db43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09f8f2c4ca4263b40f766238a92ef9c5f93ea5a5
Message-Id: <171649736072.28255.9570261418373653619.pr-tracker-bot@kernel.org>
Date: Thu, 23 May 2024 20:49:20 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 May 2024 12:47:59 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.10-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09f8f2c4ca4263b40f766238a92ef9c5f93ea5a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

