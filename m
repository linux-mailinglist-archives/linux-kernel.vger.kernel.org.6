Return-Path: <linux-kernel+bounces-336362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F7983A46
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC17F1C202D5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EF91552EE;
	Mon, 23 Sep 2024 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5wbEEcM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65AF154BF8
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130889; cv=none; b=hzyZbTPg61bAByvEqK4Yk+eM4zvvNA7m1/DN/quIGhUoNcQIKcz3fTtx9R0ovXRbOUP/wBHdgkmmW1kD/kAxkpGsr9KUdebqNjN/3/qR17hMI3uq4yxt/qtdCjrsir43NWtZ7r9Q7CKywlgDxbYd+WdU01Vj/kUjfAghv6sV848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130889; c=relaxed/simple;
	bh=V62JcDYYdxWlfOd7nHG7BEMV0rzLUp77/d3O9/FycFU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fwEDZ+D2N+P0i9+6NuRIoBkwbqeLMEX0bJJg696ue9QrFpDjJUj0sxAfx/JXoOsPGCoPuHOn7lZ0fMXq1hwU8/w+SKknbInAbyk3HfI53+44YnwM/6Ku9ed/0ycx+XkQYC1lWPogHCGuEb5go2CQe7yZEPx7GtBi4AzwG93gHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5wbEEcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB648C4CEC4;
	Mon, 23 Sep 2024 22:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727130888;
	bh=V62JcDYYdxWlfOd7nHG7BEMV0rzLUp77/d3O9/FycFU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Z5wbEEcMT7ZyI3e5suNi5DWeU0D/wQ0LHoGptOAOhDkMNZLQdL4Bu0TdzyHoU3y51
	 HqP7J3fqmJzTQtwS5R8O9vy+Ve+o4z373LU4ALtNVEzEJK1TNAAJgs9/A6OVC3UdFT
	 TuBcQBsdRUrVRCEU3xaLI9Z8JjMUsS5jXgs4smgk/gRfx3i/i55G00j/kqRudheZad
	 a3DzLRn7o820iAgx6Net5fe7zWtDg4MHDRcJ+n4DC+8LMoIEN6n0NeyS908fn7KQpz
	 Gh6TYk6lqrtkSSATCEiKVH0PYcc6jS4mOTbNut/U+espsTulqdiBP+9mJ9GYouCCi1
	 c6YROtwjGQWXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6ADCD3809A8F;
	Mon, 23 Sep 2024 22:34:52 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240923154913.GA7545@google.com>
References: <20240923154913.GA7545@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240923154913.GA7545@google.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.12
X-PR-Tracked-Commit-Id: 91dba615c3431daf0132349812f6adc83e123eaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0a53b4f3f3df6b9da31f2e406da8a490122c807
Message-Id: <172713089109.3509221.12232653029875881877.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 22:34:51 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 16:49:13 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0a53b4f3f3df6b9da31f2e406da8a490122c807

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

