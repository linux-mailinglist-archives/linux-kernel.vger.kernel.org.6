Return-Path: <linux-kernel+bounces-183229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596998C9617
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 21:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E203C2811EF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 19:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A28B71753;
	Sun, 19 May 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKw0bfuB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742506D1B9
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716147417; cv=none; b=Nz7X+UB9yu1yKRFvbsrfwPi5KWRAFxCZHSk0IV3xzh7GWCJUo/hPpIOnhxQ/M98FH7hU0nB42TooU4YfVfa64c7KY5xv6A5Eq9Ai87ahi7kKWEa1cUGFeG2PBYYI5SEFhswAjNSOWcXJh8+Cgp4wclGZfEYpIX5UMbHdPKXLVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716147417; c=relaxed/simple;
	bh=yz92c1iXTAyGzBaVB+VHzxZy/8ApJAKOqyom+hXVUfY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VKEWWu9Ftl3SpG/Dd8PosJwz/u4iXT2eBX4kUGym9AUDNoiYqtiwlSc+04FEVyo1Q7JSnLx7kytH5l9SRMhqh9M1RDqzr82ESQVxUfHe3gqn/PUOmA0/Dr/Cz5Yur8F4YoqK5LJpIgHlzIK1XPSaDk1KGE+aN5hU/X6DYEGj5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKw0bfuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 535EDC4AF0D;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716147417;
	bh=yz92c1iXTAyGzBaVB+VHzxZy/8ApJAKOqyom+hXVUfY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sKw0bfuBv00EtgapkrBA59jkeTKGs3LUqLeXdt7sm/5MLaGXABxEHrL3Fbfu6Eg4q
	 n6l0swz+HGY7PisfwnpfF8QidrLy+zTXHApdkbUb8X/1/4MkyZOV5QMiRpe6NtJTLB
	 g/j9njvo7gKAid2R6r29H0rq6QCTzT9VFHloF0J5UQoXbd22g77vbgD8ESvyaA2VS+
	 LLR1f+YZDWGj/t2I46X3FtyoHKbUsywNbCWGw9IVj9No+5kGKJzgQEL+FggN9X7ML5
	 /tKQiYLowTVQ0jqIsGr5k8vF6/Ox++4l1RWdh6IlAtdJzJChG0bVA2h3klIot0TzEv
	 3OLnuU46xSv4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 498DEC54BB7;
	Sun, 19 May 2024 19:36:57 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240518152655.GA5820@aspen.lan>
References: <20240518152655.GA5820@aspen.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240518152655.GA5820@aspen.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.10-rc1
X-PR-Tracked-Commit-Id: b2aba15ad6f908d1a620fd97f6af5620c3639742
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a76056285f5d64740b461d70b062225ba80f0ac2
Message-Id: <171614741729.6582.13612010194829053315.pr-tracker-bot@kernel.org>
Date: Sun, 19 May 2024 19:36:57 +0000
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Thorsten Blum <thorsten.blum@toblux.com>, Justin Stitt <justinstitt@google.com>, Liuye <liu.yeC@h3c.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 May 2024 16:26:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a76056285f5d64740b461d70b062225ba80f0ac2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

