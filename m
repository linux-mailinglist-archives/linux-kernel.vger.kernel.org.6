Return-Path: <linux-kernel+bounces-422975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1199DA0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE3D161811
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881CC3D551;
	Wed, 27 Nov 2024 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmDtaeln"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1553208C4;
	Wed, 27 Nov 2024 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732675271; cv=none; b=VPHfN9C8a6KXjZpixALBqaEENTUF+V6WIpdkhodVxjKzDAp38gXoJobRf0SqhuHDpQPI48TP1zeRtAQue32MaRKvTivgryvPHqYP7/+vBO4Eqvd7xLzcuzyFukLVZldnUTJ2EOmiQRx68Ia7rihFR53iw8SyF5O51Wk0cyr7ahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732675271; c=relaxed/simple;
	bh=h27qhjkEnsMB7/r19fPhgc8+x0fXjn8FdF3bWMEsQ1o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p8uZJauYHJSUdatzx4V9Cle7kfhS4D5ydScAXhg8RRVdCSad/EaZc3Z1nBn3pOoiCKMdvJnAgLPgRLFkd/XgjbE8B+Q0m4if7WcVDwkpZXktRF5gP9Q52xQnr/949ENOyfuc8a9W3o1l/YMhieQqRPulujQfgWsFwEOs/OQSHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmDtaeln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18D5C4CECF;
	Wed, 27 Nov 2024 02:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732675270;
	bh=h27qhjkEnsMB7/r19fPhgc8+x0fXjn8FdF3bWMEsQ1o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gmDtaeln3H6x6jk3i7v+Ja87+gbhz7HHWESt3YmT5VeisG51PLLNcYmXoMl2HIFxs
	 bunLtvCKqps5stKWG8RY6zMgXJeyUOH8jdGhl8juZKR90/4YdHYn+xPzcDxkAsFdC3
	 o/prNkzqo4D5iPK4nqTAUccETT9o+zlVGaZFlnXw5s5imHqzefOclh29yaB9FLbtFr
	 SGIANk3URXur2WgMwRtq7DEyn3eai87m57BEBzpgBobJk2RgUntPILwqZvD+JG6LfQ
	 kEw/TMfsYq9h6uCkyrO/Hh6HpoWQKX7YNjXXPSZru82zplYQq5OQBUpZv+UD9PcgTt
	 J5hyT/197Nmsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC53809A00;
	Wed, 27 Nov 2024 02:41:24 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.13-rc1 (take 2)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241126041820.1054214-1-linux@roeck-us.net>
References: <20241126041820.1054214-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241126041820.1054214-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.13-rc1-take2
X-PR-Tracked-Commit-Id: 998b5a78a9ce1cc4378e7281e4ea310e37596170
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 727968ff2e8c9c30f9b2c6f290494fa11a71706d
Message-Id: <173267528363.617991.10828415129599591757.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 02:41:23 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Nov 2024 20:18:20 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.13-rc1-take2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/727968ff2e8c9c30f9b2c6f290494fa11a71706d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

