Return-Path: <linux-kernel+bounces-535012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF94A46DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D681F7A53BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D19722425A;
	Wed, 26 Feb 2025 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5LBJcCF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDD2755E8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606363; cv=none; b=SFU+TSMIV2aQCh2epZVwACUoQnMFVPPaO212NGc9Xnxt+yyyBfRe6KceVfRhcN5/HdqFItlryZwiO2KS5kRT5IDEP/BPHOFTNOZ0F6vWGYI0MlR4wnV3HthnRv0pPSvMQQFHXSIQCOLRojuegGZwtEEYBv4YcseCkj8hWTv7Pm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606363; c=relaxed/simple;
	bh=NvvKpkGJzKdBmVdSHKvQeCudG/o+fIuupyMwACZw6HI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tr1h6Wbujh/ifXt7VfaqpXh/aMR5re2YZk1S+PoXPr9vA7hjDWNxP40sDlTnMA1d3K3i8ou7wCDUxq9JhwAnGGVToKWAFQhPlCm6sleOmXGH8G3TR3PEW3nQIyJ8StY/Gi/1UIC2+1YAHwU2/AwPFvfaNZijoVwSr8ngPRbaNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5LBJcCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DA2C4CED6;
	Wed, 26 Feb 2025 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606363;
	bh=NvvKpkGJzKdBmVdSHKvQeCudG/o+fIuupyMwACZw6HI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o5LBJcCFBqyCoA++2jNtm3R0cIbpiA4fvf6SgVlzLtdQ+asVhSB7LKMvYjT1x13hE
	 VLND1A5cbzE61RfdFL271EGHoPI5cHHimkTypQQRWvWKAHBuNU1IXtFfpVmxgXpZZs
	 PiOy97pkX8staCy2dVhKTH/D+OALpguRyVdkDOh5uQh8b6qpvpqa/QAQgJra8Vp+0E
	 xsIjPjAVdB9aYbCrXqseiIDQ0LWXtTeqUPKcAYyB9vK9VQBSLdYPTJzcPK8NBHv8c/
	 yURKRRh/KD9iasb7yv+y05D6zGQQaZsDEdGMUtrhQpE/e779gd2tp13OqBx1IMAWRh
	 QJPP5D02QL28Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71720380CFE5;
	Wed, 26 Feb 2025 21:46:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.14-4 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <8ce77d4d-cd19-472b-a526-0c80feb2b028@linux.ibm.com>
References: <8ce77d4d-cd19-472b-a526-0c80feb2b028@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <8ce77d4d-cd19-472b-a526-0c80feb2b028@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.14-4
X-PR-Tracked-Commit-Id: eff2eb592efd73f00590d578c3d6021f604df62c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c76a2e4baae7a3f76ad2cdaef5c59871bcfb2b6
Message-Id: <174060639499.856033.7692007895567117596.pr-tracker-bot@kernel.org>
Date: Wed, 26 Feb 2025 21:46:34 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Donnellan <ajd@linux.ibm.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Feb 2025 09:28:52 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.14-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c76a2e4baae7a3f76ad2cdaef5c59871bcfb2b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

