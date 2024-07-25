Return-Path: <linux-kernel+bounces-262512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F5893C7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6965928333E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9DB19E7DF;
	Thu, 25 Jul 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrMMkasY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D54326286
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721930339; cv=none; b=Z3+nKrM/t5z/1alersZIgQyc8eg/iYDbqw21tJGfqMwGu1EjXsIKSOc9Lm3yAeEJvMsCIrWhblgJQyBh4l+sHTaXpfttIVkdyWdvmIsMR+nJJ//DWazKuTtdPHgvWW0KeJQ5TboDY/tvhtmObZPQjIzHv/QQCI5aM7mdl5cOn+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721930339; c=relaxed/simple;
	bh=3AqFXQBjFKaMlFLKB1DBURvVyDe6fiNMx+td2GS2yxI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PQYsD2qv35BeAef/qapS0uEXZ7ylgoXP1aH6eNI+tsRwuj7lf8uVLXmNwfW4OFgUF0ESB7YpNrTJDCNVuQaRWp57mjj9UmZ2cRVvzzp2feODLSim38PfRgAdyzbthnDpqnq2WYvh1MHO/K7kfDhP0KKx3BYSXQkJsXBVVrp11e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrMMkasY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EEB2C32786;
	Thu, 25 Jul 2024 17:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721930339;
	bh=3AqFXQBjFKaMlFLKB1DBURvVyDe6fiNMx+td2GS2yxI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NrMMkasYcHR8Ag9NK1/h+0ToO2s9eoIo1hFAttSjuTQdxPfv/zfqr0lOr5MHN6IN+
	 jOo2CQCcFHs4aCtsqxHhbW1JMP3IdG+W0PrDFKYS3ClLxbmOhw7vNX1x5Pp1P6qU2P
	 Y2FoeqifGotc5ufBLT79wpyrupNvweft+s5vGusLxyH+8Ouiqlu3/WAPcaYGzab3sr
	 T17EpG49UwR4qs+v9k6TO9ComrFlL5rZCj1vzrfKzjwrTRd5upiGbr8NT7navg6Url
	 TEEhKEmGWkHM23F8SEG7HYJloTf02INKTw1rzP9Cy/h4ktkKllDxUegeFiOb6iU932
	 fLjhJxNEc00eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 356DEC43445;
	Thu, 25 Jul 2024 17:58:59 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZqIAf1uDky0nvwiC@kroah.com>
References: <ZqIAf1uDky0nvwiC@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZqIAf1uDky0nvwiC@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-6.11-rc1-merge-resolution
X-PR-Tracked-Commit-Id: b57d5ffc3ab507d0e19fc8b90b19c76af43fb790
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2a96b7f187fb6a455836d4a6e113947ff11de97
Message-Id: <172193033921.22070.16494399458225968027.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jul 2024 17:58:59 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jul 2024 09:36:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-6.11-rc1-merge-resolution

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2a96b7f187fb6a455836d4a6e113947ff11de97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

