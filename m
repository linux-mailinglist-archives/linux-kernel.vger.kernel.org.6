Return-Path: <linux-kernel+bounces-185523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BE98CB640
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BCD1F218E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A129148FF1;
	Tue, 21 May 2024 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRldVw0k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4AA2D
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716332564; cv=none; b=Rx1pINlYH0g5Va2rp/weF8nco4o2U5dmtFN4Y3zjdc1TcuyNkD0gXTice+bwUvKMqSEEc+KwCrGtUZ6pxaF2vVmBuBRHJCJwiazc5GhcNlfWUHZgP+GIz6kToMQ+E4ltLGLjqcIeJ6galbPv4knKAA0Xlr5b0bHLM/celwAIK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716332564; c=relaxed/simple;
	bh=Z9ptGN8To4l/mxHq/+mzmoUUexo8QrdnkmyTNOQ8zII=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sszOao3QdXHFHFuQ3JN3dLaMp9nU3qGBBK3TXfRo5aeBkRo8yEeob0A2kKG3fKnwbGEnQ6j9LYoQL91gQQ0VyknwQr6kqFoQjTO3gbaBimCi677y3+dalmuvVBOCWtb2s76RSpPUoSQXaGBwxJbAAu5vXf3eT8T9AEP/SXYOkjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRldVw0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 408C6C2BD11;
	Tue, 21 May 2024 23:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716332564;
	bh=Z9ptGN8To4l/mxHq/+mzmoUUexo8QrdnkmyTNOQ8zII=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VRldVw0kp+mcyLHc+8he23peUazimnSBTz+72EAgGNyK8cmtkS0KpXmYDqiZ+Q5Ag
	 Tg+st54gY7RndM6vH0IfF7Tej9apJtIxwyeE77Zas67lZAESHfnqyXew1KeK6O4Gb1
	 j6FvlKNdtvYcSlM7QWScG73vEKqUJeprSQGxePmzOOxPKlmo/2qTYE+bY+G6Mv7al8
	 SbWzTzcH9lM5v0Rc2l2wv+Gd1sj/r/Hngv9vDScWebAn9i/2SXBX9LTrkC4AEt/ELk
	 qhxyTTojbfQ/3r14y7mZqFxmy4ABiZCcizzlBCZVuLIV7ZuDK9kjE6bLp8bwYBOcEn
	 JmmArA/EqEKiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 363BBC4936D;
	Tue, 21 May 2024 23:02:44 +0000 (UTC)
Subject: Re: [GIT PULL v2] bitmap changes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkqJlKdwMU+LrLqC@yury-ThinkPad>
References: <ZkqJlKdwMU+LrLqC@yury-ThinkPad>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkqJlKdwMU+LrLqC@yury-ThinkPad>
X-PR-Tracked-Remote: https://github.com:/norov/linux.git tags/bitmap-for-6.10v2
X-PR-Tracked-Commit-Id: 5671dca241b9a2f4ecf88d8e992041cfb580e0a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4865a27c66fda6a32511ec5492f4bbec437f512d
Message-Id: <171633256421.31098.8207023545957351603.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 23:02:44 +0000
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, Kyle Meyer <kyle.meyer@hpe.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 19 May 2024 16:21:56 -0700:

> https://github.com:/norov/linux.git tags/bitmap-for-6.10v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4865a27c66fda6a32511ec5492f4bbec437f512d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

