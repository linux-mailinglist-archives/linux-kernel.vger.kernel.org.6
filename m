Return-Path: <linux-kernel+bounces-419215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1669D6AE1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D27161D05
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79331183CBE;
	Sat, 23 Nov 2024 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5wzDxcm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83493FC7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732387785; cv=none; b=MZrdhWFfKTl9Gs81n8PRWphjSahbXH4C3UYqHD5Jfc3fBcSSn2+CGkJIcU/lZyQRiC4io/GXs8S7ejKDervFZcvkrSK56+fFoY5tqBUrcP6ffclziwzTcJn8TN+EKlEFNx7o/Ib2YUS+MTULTy7ALJJbYxgt5C9CNSFynNkslUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732387785; c=relaxed/simple;
	bh=4M9H/lWvGEnMetofR10BZ82QIv+evwKdYTWiMw/LMVs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jspb2n2IC7/km6V0+LC5ggYwVinDBejyE/8YErxl1OkALh0SigWxeX989l6MPvJk3whC/3iNpFkrhVlQ7SK5dxqOQwLki4cU1KmxOUuLHJ0Y8w8Mf1UyWmce2MySvPft+4iJ6lx5xG3loenT6zMNfXSKlqzMC7xFq1N027DBUr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5wzDxcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDE4C4CECD;
	Sat, 23 Nov 2024 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732387785;
	bh=4M9H/lWvGEnMetofR10BZ82QIv+evwKdYTWiMw/LMVs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E5wzDxcm8W4UTH2kyAoGdmkwN5TwJEMTOS+aO9B0fVdUS6tYtjTkRWR5UJ/LiF8y9
	 yr35FGuBG21qW1qORlC5ZIBtSjR63YguZGiJ2RAiNCZZAgoVWpGTrVSb7cUdb+v3oK
	 nAqvrSZgL10MU5+/7U5ODjcawvpDgDVsfH2C2qbCOGNTMAxenhmqfe7JEVlALl0+oB
	 /HiyAFfbgCoBX0vww++vT6jqdawSVdobQSiSELz2FdhKgQeI/Q/4ythqLer0sxIHOC
	 wEzXyVLWFrahHQn5PZ3O0fQ29k9otKpb9sbB9RD+JUXBEKsW+vZANLlqPSf24y9xk0
	 mDVgHL5uorRgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345843809A06;
	Sat, 23 Nov 2024 18:49:59 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.13-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87frnih59i.fsf@mpe.ellerman.id.au>
References: <87frnih59i.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87frnih59i.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.13-1
X-PR-Tracked-Commit-Id: 3c592ce7991cdf03bc7d139d790ce58c82c5903b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42d9e8b7ccddee75989283cf7477305cfe3776ff
Message-Id: <173238779776.3055463.14144677345357809416.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 18:49:57 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 00107082@163.com, Julia.Lawall@inria.fr, amachhiw@linux.ibm.com, arnd@arndb.de, bp@alien8.de, christophe.leroy@csgroup.eu, costa.shul@redhat.com, david.hunter.linux@gmail.com, elfring@users.sourceforge.net, gautam@linux.ibm.com, geert+renesas@glider.be, geoff@infradead.org, hbathini@linux.ibm.com, horms@kernel.org, kjain@linux.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lukas.bulwahn@redhat.com, maddy@linux.ibm.com, masahiroy@kernel.org, mchauras@linux.ibm.com, mhiramat@kernel.org, msuchanek@suse.de, nathan@kernel.org, naveen@kernel.org, paulmck@kernel.org, paulo.miguel.almeida.rodenas@gmail.com, ritesh.list@gmail.com, robh@kernel.org, shenlichuan@vivo.com, sourabhjain@linux.ibm.com, thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, vbabka@suse.cz, viresh.kumar@linaro.org, zhangjiao2@cmss.chinamobile.com, zhangzekun11@huawei.com, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.lero
 y@csgroup.eu>, Naveen N Rao <naveen@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Nov 2024 16:46:01 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42d9e8b7ccddee75989283cf7477305cfe3776ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

