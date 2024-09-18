Return-Path: <linux-kernel+bounces-332543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90E97BB03
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758D0B2B65B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8568618A92F;
	Wed, 18 Sep 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6i4471P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7918A6DC
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656008; cv=none; b=npsRGXP65umK+t/kTa4hUNxpRYt0ppYBya27YRPacQEVv3R9stSMhyHNtYdny94FrjC/hao2PZh6lssCpan+zOaYJEmU1AQhw0LUyxIsvvUzAcfstiZJuGTebkxJ6/bsT/Ehma3ksy82VlPPk1X6egSc9QSJXX0v6HRxFogX6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656008; c=relaxed/simple;
	bh=zuTXtUGyuemhV6ECkGJaweZ368jvmc2+uOkA8rr0SmI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TmNqRh2VgFxSawUDYFlQSKEel366O6UHMPISNXRHLcPhxnbIuLVkUQfqzPotjaJjcEoMpMZVmno1+pK0nr5lDRVY6dJk8PYAnDtJfD9RD1dNcqhFcuLw4vIsnW/5lcUGSZ8pKAWe80iZZu/Q8tJt1kWw/CvjYdUeJVboCvfB4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6i4471P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A90C4CECE;
	Wed, 18 Sep 2024 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726656007;
	bh=zuTXtUGyuemhV6ECkGJaweZ368jvmc2+uOkA8rr0SmI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K6i4471Pb9t2za55L1hy3tJoMOGdYUVF0OOw3lE95Eda2USAQHnNdahL3JHs1COE9
	 l1eE2MmaZtSwnm24x+kh4wahhaVlBBBwJK6iH0Fw7aw/kFg6FN7DNg677vCOyRoGd3
	 +TsyDWh4OcTbZuu2pVFDIMKnA8ukOTwHHUFRxqdC9kICSEq7921Cgb1xOtQCC0ghLs
	 4Pr7DNNXGVPUPIcvfmlcFBH94wbd+HwDJh4NI+308UGYza3JHgVpMIrjpL3vGNojMs
	 GfXSNDb5j/if/9AOUdhd7inSOtVDbuhEW7o/kjulWYijrIqe0Hr1Vwg8LGaol3AMkd
	 3H2mxvWMdnIfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B50E03806656;
	Wed, 18 Sep 2024 10:40:10 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202409160146.2E6CDE4C2@keescook>
References: <202409160146.2E6CDE4C2@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202409160146.2E6CDE4C2@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.12-rc1
X-PR-Tracked-Commit-Id: c121d5cc3a993cdbfab46a152bdd50227a4d5e8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39b3f4e0db5d85aa82678d9e7bc59f5e56667e2e
Message-Id: <172665600960.763643.17709074038324643542.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 10:40:09 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Dikshita Agarwal <quic_dikshita@quicinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Hongbo Li <lihongbo22@huawei.com>, Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Wajdeczko <michal.wajdeczko@intel.com>, Miguel Ojeda <ojeda@kernel.org>, Vikash Garodia <quic_vgarodia@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 02:39:12 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39b3f4e0db5d85aa82678d9e7bc59f5e56667e2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

