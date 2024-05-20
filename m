Return-Path: <linux-kernel+bounces-183972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645F8CA0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EBB281E15
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A6313848E;
	Mon, 20 May 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j44plxLI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CED137939
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716222840; cv=none; b=l6hbFW2fJ8qBvYLJRufcnBVN6U7veHoRdRe32WwyuzL8pdY7cAHwOvLw9XDRRlmhlxiVpFGsGEWZx8UNcZaPFiYfmmikopXFtXE2yjz1h6Iz5iNDapvnEmDeJjwerQBAkX+YO5dCXfEwyS5g5+nSCm6fW+yB2ClhbAD5lHFvYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716222840; c=relaxed/simple;
	bh=3+7dgtdbRKeFV9q5f4JxqU1pRV4ObMy5JibBlPNIc1E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z/QvSvAX6Oq0CVMui0Ct/Wx5EWb1O8ezL+H7K9tX2rRSVIxbr0HYexsUitAQPDWTjqLRak9cYN9eGputras5MYvC8qLCn3vDvqIBywXivP36Di+4UvTtcXOqe4ItLG0RiB6cW137INXDzNH8Jn8FCW/zMUuy6CDN/QwYI2sHabg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j44plxLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 994C4C32789;
	Mon, 20 May 2024 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716222840;
	bh=3+7dgtdbRKeFV9q5f4JxqU1pRV4ObMy5JibBlPNIc1E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j44plxLIQrZ4k2sOHEHKYSIfA3cbh4AouV/NiyRCQzBJjgy3yc1QWFUK2m3NTG5ky
	 o6Wypub+Pedv66S7Ho62Wqz1cNbKSjRp3nAZHArrtdMDMygQDZwi8o2kSLg1EMR5My
	 My3rnOizVWIT5Ys+Rt5252whAjEGlXROJhbxI3T2RP87KGxkKDGG+x5DO3VM32U88P
	 lEvUMfH4irr92kJlznoqwnco5LzNLxTzqOgTQSk9QKIfq2AGz18g8Fhv8U04OFBBLs
	 xq990pggJ9DJDL3hdoeL/NYbd2ndf9p0SMfzYCvgUEieNX7lHgBaAuaDnK5BNFoPnf
	 05uHcpQfqLkiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FDB4C43332;
	Mon, 20 May 2024 16:34:00 +0000 (UTC)
Subject: Re: [GIT PULL] dmi update for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240520101221.463a1ec8@endymion.delvare>
References: <20240520101221.463a1ec8@endymion.delvare>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240520101221.463a1ec8@endymion.delvare>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-v6.10
X-PR-Tracked-Commit-Id: 4d1b28a8119c615f1e932520f9ee1f80bdda5204
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80f9d9023058e156eb09226ac339f56a8411bc8a
Message-Id: <171622284057.31783.1824216704697127937.pr-tracker-bot@kernel.org>
Date: Mon, 20 May 2024 16:34:00 +0000
To: Jean Delvare <jdelvare@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 10:12:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80f9d9023058e156eb09226ac339f56a8411bc8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

