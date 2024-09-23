Return-Path: <linux-kernel+bounces-336363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F0983A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201D728302B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C415573D;
	Mon, 23 Sep 2024 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeBq7+Og"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E31553A1
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130890; cv=none; b=lNI8GyXwdgXnqElVO7+TyJzgPcbJHlS4WwyipIJkgouwIzBAUI+8VPYcIW6LYCRbomWaZiMxoQ6i71YRNc3o7+9E5VyHg9Nf+NHZXwp0BcNYULq3vs5VJmPf/5OYWOL5TTGgXZKif0q0MtFLGe4yARlpIW8HrcMotstgDESGFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130890; c=relaxed/simple;
	bh=06j1j4ZfgmQ2T9t/N1WnngAyoNaWl2mltjyS7yyIf0U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nJUWMuXEsCmQLQyi6k8X357rfj+NUbo1L7AhrF63iefiXtulHEROxCS9SMAGTEsD44tUGZI69PZfPZMU4yBmeV7LDpXV8B3+QndrgB0Ox5d6zWZyYGEXIxv8sYUcfvc/uNXUl7P34/ToY+gD2/mXY9z+EAkF/ys51KekU+ozdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeBq7+Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE24C4CEC4;
	Mon, 23 Sep 2024 22:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727130890;
	bh=06j1j4ZfgmQ2T9t/N1WnngAyoNaWl2mltjyS7yyIf0U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PeBq7+OgR1RroglgzOWBmnEssX4C0cJjZMBqz2J7vCyP5zOKedE7mMh02RhNYB8Lb
	 ZPU1Gez+Q2r458+Y+9Oju+IWMzpT3nZX48mEC17+Ilud4UDtVCtLUnN4DmlCgECej5
	 SA75SjMdefu4G5FCi9lakOXLENy+xGa8ajD2CSYdyJ52oLTlK6dONrc30+7EU9sxgS
	 nmF85KXBsar1FoZuiec+BPS71ZOdn8gA0jU5RNEifljGfIKHJLXqwWDeXjw9ruSlC9
	 4uYruQ7Ww8IhA9scoWlZ6dG6G4uJHCBZSmxZNvyS+8WEaGE/5gk3hDfa2iXGkXj+3l
	 lZEme7e+qUhAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C41113809A8F;
	Mon, 23 Sep 2024 22:34:53 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240923155054.GB7545@google.com>
References: <20240923155054.GB7545@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240923155054.GB7545@google.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.12
X-PR-Tracked-Commit-Id: 64c38866500b0bda4363fb994d545557dffb017c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2debe057fcc962e865d57800e39e029887812b4
Message-Id: <172713089260.3509221.13777087878642066918.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 22:34:52 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 16:50:54 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2debe057fcc962e865d57800e39e029887812b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

