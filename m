Return-Path: <linux-kernel+bounces-535072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34BA46E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BEF7A8B71
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCFF25CC82;
	Wed, 26 Feb 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfWKP/nq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420C25CC77
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608701; cv=none; b=Wv9mjMZ88cdTQFuqAbsf9ET2/laJ45xD/1T4j+Jap+2gDzAjvLl9sL9yzjpLX1RshCAEEyFZr1FH8IiqDH/h8FKLjm27wyOr0earfAOwu1GXkxbBz/fTfDF9hqVsvwTpzHkuXDygSXMMizO5tRGbvcvqX9VS+X+AePRHjmsaEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608701; c=relaxed/simple;
	bh=OkoQ3l6IPdca9uOE6oau+ZEXhf4+vW3mhpq4qAjeYd4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QTwULD1mLTbPpABvDyxRniPTX3Q8TWVtXTFPmKyuq5osfGsR4Y55nNHTVHsvJzYkLuxbqrm2DBPvStV/l35bLJXT+J17NnmZL9rrPwqyJhSp558lYgfR1hbd/LJS4kRfO9o4iB0QQ962GeAA4fsM7oAm9I1HPDyclyaFS8sUFUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfWKP/nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5D3C4CED6;
	Wed, 26 Feb 2025 22:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740608700;
	bh=OkoQ3l6IPdca9uOE6oau+ZEXhf4+vW3mhpq4qAjeYd4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OfWKP/nq8zkY+WIhMW82xiCCXOxOmeZ+dgTb6xuX23h9g88oOAEQpdmJdmYMkMqfc
	 qdZQWvM6BT3UifXHo3RIu5voVkst27/BI4hfTYLAmmUQQ+FuD+Nk0/0qEhw/QiPhbC
	 BzyYMlkg8E3auDlqp6vRckcFR0i5EpfSkLshqj/EQuo1+5njDQuiqQRKBw5JpzzoFo
	 G5ZVHSaQba1kz1PPTLjBqIq/BjMkZkK2pOtxptrhDliAyDWCeItgU/IvYtolKU3t4y
	 1VVSZ3aMn7WZsdRKMV6oMVikfxI7px9SCnYNPbGBcCs7WIARdz4aywpzxx2LSF/47X
	 B0RIJ2WkiunlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF92380CFE5;
	Wed, 26 Feb 2025 22:25:33 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: A fix for v6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z7-AF0Oi6TF24bl5@slm.duckdns.org>
References: <Z7-AF0Oi6TF24bl5@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z7-AF0Oi6TF24bl5@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.14-rc4-fixes
X-PR-Tracked-Commit-Id: 8fef0a3b17bb258130a4fcbcb5addf94b25e9ec5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6d3c4e535dfffc69cdbad0c12003a8a1e75f88f
Message-Id: <174060873223.866718.9006977479747923103.pr-tracker-bot@kernel.org>
Date: Wed, 26 Feb 2025 22:25:32 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Andrea Righi <arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Feb 2025 10:56:55 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.14-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6d3c4e535dfffc69cdbad0c12003a8a1e75f88f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

