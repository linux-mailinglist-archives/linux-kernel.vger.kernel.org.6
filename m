Return-Path: <linux-kernel+bounces-339517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1535698663B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453521C236F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB701411EE;
	Wed, 25 Sep 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1UtdvQ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7D13E028
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288633; cv=none; b=XwcVaiUY/vNrdnXc940HIQibtuQcuGAoB9SFnrn0cImp71HcHaZDa3Mtb/vJfp8duUJho28JAcpNCvJqbgGCESSR1FxkBLKmD/yD+V2i2nx5vupKjh2qFXMFoEDlxUV06waZ3oLiakQEEbErO1Bjhs2yf89FVE59DVFuco0F+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288633; c=relaxed/simple;
	bh=YVk7NfdCMk3Nxtw4QB4dM435GxhefiOcp38pK1ehJHE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=R2vOZVCA1Pd7prZGBP67f5Nz/4f8fToVpSRhozKS30QwxuHgcrQDQ7OivXnSANHqqrj+Bn1vhPetSyjkmOODFuBK5Srh1NsfmY87T22rGdLRCUEGBa/26puBTpFKhIFcfcYgyhOXBfbDqBnm2gnPUEijboWT8o/nnridYMutr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1UtdvQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4E8C4CEC6;
	Wed, 25 Sep 2024 18:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727288633;
	bh=YVk7NfdCMk3Nxtw4QB4dM435GxhefiOcp38pK1ehJHE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c1UtdvQ2SUQpOJkxQHSQzXK40TAAewVbAhfd1iFyW2/Sy3aa7R20lKMqFSelXWb6N
	 6FKlD9VZ9anB5gfd5XSlZebUrXjvTO9X6wkLkmSMAt+wt3eapOmxW+61fqnVYL1rV7
	 OTidEl4IrkHv8zMEHIwwufdTkuC4WXdG5EkZTxsLlTRFwHAHyScnFcYbsMKmzIepRr
	 Y03ZHP2Vf23yTQlsk4IWsso2pkjALQDIWYYBmXkvE07adNFjGifVRfECrY/Xi3ep9q
	 c3kS3otxzbAle7HEgwJGo6z0F6D3sFTvnl6iKieGX8l8dfL7H9bG8GoQ3A+ALHYKzf
	 KY/tr7VckI3Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E913809A8F;
	Wed, 25 Sep 2024 18:23:57 +0000 (UTC)
Subject: Re: [GIT PULL] clang-format for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240924223210.204379-1-ojeda@kernel.org>
References: <20240924223210.204379-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240924223210.204379-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/clang-format-6.12
X-PR-Tracked-Commit-Id: c147f663b6a5813b9860f3917cc473fb2c462d8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e520813b2de1d58712c29f1b469d38d8dacecf0c
Message-Id: <172728863600.682824.5327746238241727519.pr-tracker-bot@kernel.org>
Date: Wed, 25 Sep 2024 18:23:56 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Sep 2024 00:32:10 +0200:

> https://github.com/ojeda/linux.git tags/clang-format-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e520813b2de1d58712c29f1b469d38d8dacecf0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

