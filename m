Return-Path: <linux-kernel+bounces-216424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F257B909F29
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91500282EE5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B064CCC;
	Sun, 16 Jun 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQRziKQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00369535A4
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562273; cv=none; b=nObJEgTrBadOfaLmWyDdVpTmW6gjLkJf0yi5McRdcSukSEva1IJj0HLExON+247H+YiKkUGm9uiOQQLVdXK+kj7DsuXQtCkBVQBYVhwtvAPNDTfa8maNQeGBUoCIIpJTZ+ArXV6IB873sMoUFWY/ib9/P6LuqXpscdkvZ7DnPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562273; c=relaxed/simple;
	bh=TE3sFJ4hK4W2O+xAZDMfS/G+fVNT0sq49ntD19TyLPs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eQ4lbUXNqD6dGlPZq17pn0k208P1UBTbKUHHWz1esWdNjhZyZdZaHoJorjDDgRqE5Nc/h5+nCb34NTfG7MeaHhQ3cdy8X/qdhUn4BpxgKhLqCEqm9qFwneOK7TMveausvmy+O+zHEji6Nrk72R1u+HKKUVZtAVIOoxNFKybFnkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQRziKQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7C38C4AF49;
	Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718562272;
	bh=TE3sFJ4hK4W2O+xAZDMfS/G+fVNT0sq49ntD19TyLPs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eQRziKQXkb1WYVSGPGbFY5UveqvZ4pqo5Xf65CrQ0TGjDTedRk897cOtiUn9+vGCK
	 TAa6AJhshRI1oOdAUTQmnLAyC1D5FjWbpamo+GKJ4DjOixfctLCjCFf5Yy2TaEyQka
	 sPTZ7tGt633gcFgw6zWC/s7c1nfWpgIjXpP9/Ws1swljX1dEzIPQP93JTD9JirwOKU
	 1kc+oAyQAhLzLqDQ/knKljxrFDlJAOX2Gg8aipfPSeRQsIQkcM8FIgZfq6ugV1zDdE
	 o8TwiiZF/dWgCrlzmpy4oQ/XUQ4El59lTZiC/JYssLhB/riJ8lDgAsADlYch2aYF0K
	 0kK4OaeIon0Lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0C1AC43613;
	Sun, 16 Jun 2024 18:24:32 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core / sysfs fixes for 6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zm7DmPaMqUO699gy@kroah.com>
References: <Zm7DmPaMqUO699gy@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zm7DmPaMqUO699gy@kroah.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.10-rc4
X-PR-Tracked-Commit-Id: c0a40097f0bc81deafc15f9195d1fb54595cd6d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e12fa4dd64ace0d7cd461d2e0d4b0cffb1d7e8b8
Message-Id: <171856227285.1143.3946837013344989437.pr-tracker-bot@kernel.org>
Date: Sun, 16 Jun 2024 18:24:32 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Jun 2024 12:51:04 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e12fa4dd64ace0d7cd461d2e0d4b0cffb1d7e8b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

