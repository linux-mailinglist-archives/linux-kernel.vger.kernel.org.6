Return-Path: <linux-kernel+bounces-310416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A97A967C7B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 00:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1A3B21555
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422FB186E34;
	Sun,  1 Sep 2024 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qO8zXEx4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB21865EE
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725228301; cv=none; b=YlGiUoke3talyo2sE7YmZxP8qRUrCRcop5jcrBlXqjT7rz+dhyudDVF8nnOBvCIwj/zm/vNB+CtfXfLkImGotQJk/SgK356PSYzSgQgIMcJsrK1lKN5lYNAxvNu6NLo7uunbz6kANWMQin3h4m6/yUbrGXhMVLXeC2hvRJevCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725228301; c=relaxed/simple;
	bh=ZlUmHDajsOZmYQAlj792Z42e4nyBKhMJnOGUn0WujpE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UlR1EyjbhN77PbeWMvgTmX0mwPSK2w2UHAwon9COmdipt6XHfoamYaaFrOsX8h+H/ZNS/lNmyH/alFEV5NKbEvcvoWHi8GFfMF//Kb4zmST8CpRViMnLBEifhSo2GfV2RL8IDQZbFS3ACfV6WgCquTB+EBczlrxYz5IezKRu/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qO8zXEx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190EAC4CEC3;
	Sun,  1 Sep 2024 22:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725228301;
	bh=ZlUmHDajsOZmYQAlj792Z42e4nyBKhMJnOGUn0WujpE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qO8zXEx4D3IPwNqxG7jGmp8t2tBByTMU+RicwndB4rgThwZELEVMOeAJXhry62xzg
	 fCYvXvHGrFxBqx49ANb3o+6PrRShfS/elMXCOY/miQZm3bJTOKCF6qAOgArkIKm6w6
	 AHqMw1897u2u2mbWLQjNmpD5IVWmNEwB38/l+QHFo24fcY/Bv/sizIUfoggn2JxSi/
	 NOFLhGcbY2zO2fQyL5KP0HV6Dr2WrHz35Y2B/poOBDbRBkxgHN/MAga0t52NeB+QjK
	 b4IBqSRFNOONcBKUmEV9TJOnOQ3APR/a7sH7+ThgK2zNZ4oIkIi3tSzGDM4SsKWLUQ
	 DKLj6eeJIGD6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB21D3822C86;
	Sun,  1 Sep 2024 22:05:02 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <172519097872.1871736.3370698904129727994.tglx@xen13>
References: <172519097408.1871736.16401401125691449823.tglx@xen13> <172519097872.1871736.3370698904129727994.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172519097872.1871736.3370698904129727994.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-09-01
X-PR-Tracked-Commit-Id: a547a5880cba6f287179135381f1b484b251be31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9f016e72b5cc7d4d68fac51f8e72c8c7a69c06e
Message-Id: <172522830153.3406256.3573595344005149468.pr-tracker-bot@kernel.org>
Date: Sun, 01 Sep 2024 22:05:01 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  1 Sep 2024 13:44:04 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-09-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9f016e72b5cc7d4d68fac51f8e72c8c7a69c06e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

