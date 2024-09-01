Return-Path: <linux-kernel+bounces-310415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9BC967C7A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 00:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A334B28196E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95F185B62;
	Sun,  1 Sep 2024 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHaYQzml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9B13A41F
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725228299; cv=none; b=VEZyXTVd6S69QGvGiElUJvvrLUvXnnB/6pWxODkHDM8jP172MHZPosUlQsIEJXNc3KE1jHnXkSStBec6FxhGEWKrsUneOAWhdpw0AiPoG5GEpbylxRP/eR1Hr8mr9n0mI8CMIfmKBO/bP3gxTuMs1JgHttnOE3zAAaiYJyvLHIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725228299; c=relaxed/simple;
	bh=ISk4iY8cLyFDGvvXWXS8MZ7gkC0w93F9Ojvmjj4I4Aw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V+UxHc4QsU4p8AQuijCNCBQr9qD5rzjAOT7k+sS0VIOhmb52MtfjAD766eOGXnv1QMka4RXEGk3hkx/h3wfnz0CYo4syo7Oqn6hLeWYkCNmg2Q+vSshxS1YEe4zB7Hbsvq+EDLqeZ+r1JSa0EegzsNvWRKPi5RIF4MlGK1Lkxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHaYQzml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3C1C4CEC6;
	Sun,  1 Sep 2024 22:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725228299;
	bh=ISk4iY8cLyFDGvvXWXS8MZ7gkC0w93F9Ojvmjj4I4Aw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hHaYQzmlkHTxkdUNqBfMoBdqv/oXG3+YlNkydxcOSiXr6TRBu16RKIrOxVJ/zo9VM
	 +SOcQybJWzzT2yQTesxxUepFQesn1ColEGkZRMKwTfTqCoTdZAJkF5NRudEBsxdsIJ
	 Z3jjwoJEzaP8TMVzznjkMVjLPlf+MNHmHByJAcUiIvNexRpWeDz4ixRmFZD6WZMptc
	 KQo6BSgHOJQzRAlBBbva9YsMTmfH/ACXR0+goPH6tBGdiLqFWflpwnDJy75F1YXAE5
	 az93cBEJ3xvDegevrO1UfKcbN4kLQtzJzcZsbGlDr7GfWCv7S8f3twVu9bUAnmffsa
	 fHehM54pxHk6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF63822C86;
	Sun,  1 Sep 2024 22:05:01 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <172519097408.1871736.16401401125691449823.tglx@xen13>
References: <172519097408.1871736.16401401125691449823.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172519097408.1871736.16401401125691449823.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-25
X-PR-Tracked-Commit-Id: 880799fc7a3a127c43143935c1a8767d77c19cae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a754292e88f81acaf26cc5e0cec56b3276029de
Message-Id: <172522830004.3406256.2917787892008241035.pr-tracker-bot@kernel.org>
Date: Sun, 01 Sep 2024 22:05:00 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  1 Sep 2024 13:43:59 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a754292e88f81acaf26cc5e0cec56b3276029de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

