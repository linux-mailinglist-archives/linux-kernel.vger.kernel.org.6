Return-Path: <linux-kernel+bounces-408058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C299C79C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C76A283A20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E7D13D8B1;
	Wed, 13 Nov 2024 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9wFQXg1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7C1632FD;
	Wed, 13 Nov 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518337; cv=none; b=WUWsXirXD/JzFfbf4Wq3Uhbfk9n9qE6rWmDu3yrs27+Qkp0kEOI2SDn6B0PY3WfYrx54nQVVh3hFgtKH3HviBlp3Xbg4cJoXSRTlcU1uPn2+/ch6L8GLUu+384qPIbtGBKb7SyxumKlD0CL0hAS1tfXDBMO5HQ/c129/9IGlqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518337; c=relaxed/simple;
	bh=0IK8ela80MlklJQ2okxMIYIYqnECypJoLSCeLQcHzz0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jiBC3ldHDMuj1wA/WGeEBebfASW7USk/3xBAKEH+ctL+0nj0yulbtEp/jtVsUPP0/TtHX6qqNuwEr6rrwFIGpMBq023ts0/qBAC26TFoWgxA9Y71sLfA+PPF+qVP0W6DAptRs0MqmYv6G2SjQH8u6K3pvgIMZ7R28n5pp420yxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9wFQXg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9518DC4CEC3;
	Wed, 13 Nov 2024 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731518337;
	bh=0IK8ela80MlklJQ2okxMIYIYqnECypJoLSCeLQcHzz0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t9wFQXg1QDIX/x/2nzzdAG9g0tLiIvgyS+Qr53DfVLn+3dwYgUk09hrvXcohC62sv
	 F/0g5M20oZoLHXP1numdITXgkRqhwlEg2vWtANu2V35E3ZiHTiMu86wDlnFCyNRGtx
	 kkTiGee3oy+umPtJu8iNRrbyU5FcyN1aq+Zwzgw+4prkKHC6SaiKh0pTzVz++lDS75
	 s6Vk4erNBvqnNelcZlKOrvl83aa949lZhIbko5l55z5StxIoxn5iAvZjkHHSt/yrb9
	 QGFvbOAXzKPKS4ltfmMsxH3wJ3BOCErrgu6qQmhcSlbwOcoSDCixsKIvxIS2FwZhbL
	 tniKN6QaOpppg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349783809A80;
	Wed, 13 Nov 2024 17:19:09 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241112164128.20f96b224ec3e2be9403fee2@linux-foundation.org>
References: <20241112164128.20f96b224ec3e2be9403fee2@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20241112164128.20f96b224ec3e2be9403fee2@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-11-12-16-39
X-PR-Tracked-Commit-Id: dcf32ea7ecede94796fb30231b3969d7c838374c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b49c0ba4eeb31b44462303cac4162476b72c831
Message-Id: <173151834774.1293865.2426936272857059875.pr-tracker-bot@kernel.org>
Date: Wed, 13 Nov 2024 17:19:07 +0000
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Nov 2024 16:41:28 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-11-12-16-39

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b49c0ba4eeb31b44462303cac4162476b72c831

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

