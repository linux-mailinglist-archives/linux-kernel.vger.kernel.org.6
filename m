Return-Path: <linux-kernel+bounces-253209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DE1931E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F6F1F21CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B960863D0;
	Tue, 16 Jul 2024 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdQl3/cz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864B2AE74;
	Tue, 16 Jul 2024 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091123; cv=none; b=mLG4i9oxklJQhVG7ETrTEIdnEL7y2UrK6aMWoNE3TeSoKjOGfwyGjLV11zxDQ/oM3ZfqEHECXNtXBiANPfsmmDyWl989M3AP2Q8g7D+Y4CeA7hg1O3RyWUSNHQuYOD95yrMPwWzn1sAUepgimbUXL6Fd5xiacDXFJ249CAQkWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091123; c=relaxed/simple;
	bh=7E1cGbVkLyF0FvfmFetq/JB0rcJvHyjsBaJYzwVT4eU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=edCZAlj8HXQE237fbOXOxLc4lf498uHK4HrUpSY8g175xdg8kr0q23PKjGYGxoYyDoAHXvbWtH8yBVVtDd7U/IciPTTe0WYUtEFvci1XonV+s84INnPxiR2+AyY9C3dNcIDF9EgYzRElwSjIuUzwzMf8XDTb75GK6w9Ydn5++sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdQl3/cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0954C32782;
	Tue, 16 Jul 2024 00:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721091122;
	bh=7E1cGbVkLyF0FvfmFetq/JB0rcJvHyjsBaJYzwVT4eU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HdQl3/czQDY82lQUtUiySkYYNGVWqyZh00QxC1Y3qsRps+PjcR+WgkTYmkwO8So4J
	 z76+OEZdRbRoPm7iqnQYb+CVvXRs2dTnc51g2pNz7GaAumBFLy2DPOU0uVjcFKpFLU
	 IzXbUoNLXWwZdQxpluZxv7K1gvdu/3LU1WWhZ6Wlo+pXaFdtNr+QAm2EDNJiOjaZ6y
	 yh6vi09J5wEnZiZSuqGlIuXok419ZxGc0RuBH/alvTIMULgbb/MciPcTwCEojt40bB
	 tlHUo/RA3majIu0smMR+zlKV2v/s45vN+UFJZMj/pJDUsIcvGM19t4drEoj3BWtkkZ
	 kEfHvRzrVCk1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7398C433E9;
	Tue, 16 Jul 2024 00:52:02 +0000 (UTC)
Subject: Re: [GIT PULL] pmdomain updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715100312.175281-1-ulf.hansson@linaro.org>
References: <20240715100312.175281-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715100312.175281-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.11
X-PR-Tracked-Commit-Id: 67ce905f5f725c0ff4675b1aea381df0d80a5f03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d46ede31887ff511a75c2544a2b2739703c3c1cd
Message-Id: <172109112287.26590.14017080086285786448.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 00:52:02 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 12:03:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d46ede31887ff511a75c2544a2b2739703c3c1cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

