Return-Path: <linux-kernel+bounces-186673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB128CC762
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3291F21A58
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A808146D4E;
	Wed, 22 May 2024 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HewN2SXq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E41EA91;
	Wed, 22 May 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406697; cv=none; b=YRtkDFs9crvED1qNajHjm/+adP2o1dQXkJaBoHAgJsAcke9juEeBqGW95kT2/UVkC1L3CBoIGlM85WNyA2pChpaThAnVuLQCnxBq5c/GhLa7dv1WrWC7pzyI9+KuYEiQ4TpbGISdad/qBXfXc4WwlpiOqgoH6r5WPNU7Zacoi88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406697; c=relaxed/simple;
	bh=+q04VDyueMNnk7eppuB9IefJxJkgFumoFTP8FXOvEaQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Sz5fms81lS70JRMHAo0qqye3X5K3wBcGVNcaY266oYXPPHeytL1HWiZ/jtM52RrC/jioKDBURsR1i9h0F+x1VwhA6gN5Hky2mrh49WUtYbDzFbCrnwOWHOhoTuE/ZN7uH2XkizfLZfPSQelnnDGGZhtc/A8MqJPAtHkhgTkARvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HewN2SXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DDF3C2BBFC;
	Wed, 22 May 2024 19:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716406697;
	bh=+q04VDyueMNnk7eppuB9IefJxJkgFumoFTP8FXOvEaQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HewN2SXqECBmUZObKmhtgRwq+2w+rIyuW1yfs2iIkpj6ekAd4MenH3JHbg5ro6A+V
	 JlNVvSk9oK2JYawho4GfjFnHob08oCs/VojEbcMbwVHnNQmpohI8FIxqwzC76q9uXX
	 UmQ4oq+wiM3177Ip0PEVbbKQKYbKavBAVI9OXR3nznqaMPEwQtcVYmWfnoYxz8QCap
	 LmTdHMMJu5f1vBncOXBxuWdarZ8/bTxQPQ6M5QMtgI+jtBovD7Q3OIF5XOKdA/JxUm
	 UiRpv5yOUWEAnpVLQkbo7hosktUTNIBSuVWvtKI9ozi1KfKAhBni4dMKl8/HNbWonU
	 Z9g4H4tie+/+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34EA0C43618;
	Wed, 22 May 2024 19:38:17 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver changes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zk4GCA9FcWdWtjnt@kroah.com>
References: <Zk4GCA9FcWdWtjnt@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zk4GCA9FcWdWtjnt@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-rc1
X-PR-Tracked-Commit-Id: 51474ab44abf907023a8a875e799b07de461e466
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89601f675b008ed0fd66c060fb23354a106436bb
Message-Id: <171640669721.20241.7085398688933869887.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 19:38:17 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 16:49:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89601f675b008ed0fd66c060fb23354a106436bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

