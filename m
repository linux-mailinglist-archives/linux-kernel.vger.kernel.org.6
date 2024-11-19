Return-Path: <linux-kernel+bounces-414868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FBA9D2E87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A331F2399D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7CD1D2F74;
	Tue, 19 Nov 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY5uHU19"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9D1D172E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043187; cv=none; b=YUsx7ovzDLRzq+/4qLfKLkSABPyU6OKxnakuy7JRbaVEw08+nxPmbUyaYZotG7B6lR8KjxNUo28P4VXEcQIhgS5qz8rX88bNbHhvG6rcxKRLJa9yzJ7hYn169obB0G+EIJ9pN/cjjFDRG4eXDFqsyu72Bp8Ja0fkxZVs8JgiU/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043187; c=relaxed/simple;
	bh=5Y5BHwaNriHPOJ7JwAHxKooAiiTuDadmcwCUi1qCXJQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ceyE9D2/z2CknKanJAh1ycC4MO1W+RkzHD2Fu5MhDY/VlNIo5QzGv4O3I6px7milu+65cGVNfQ6zND/I6p1WshjRvCALn77MExSZDLO9uHtDvdVOlx1RaGRp7L1uSLkS9FIsnvNCTkSKQL/5HEUcI+H4yR2c6XlHrnJz380Ke5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY5uHU19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377B6C4CECF;
	Tue, 19 Nov 2024 19:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732043187;
	bh=5Y5BHwaNriHPOJ7JwAHxKooAiiTuDadmcwCUi1qCXJQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jY5uHU19djo0LgBTUNdC+rmIrf76/ah/EcrQeIZsYbYAnWJzRw5g8WH+yhO0GQTtC
	 LZjqoou5IRY+VTgEt50Zgd0D6ze55LEQM0SdiGTSD0l1DwR9+BgDZGj6nvgma308b/
	 9fdy/PjH0Rvdbs8DPHqrCHe9Bpx0U6KmXWO2JTO/FbKPOqZuBIBO3wNxKI5R0EXhtA
	 szKmjZOQ/tWpUS2tADM8RNvza0gg9gPDqqp3PSCd5W6qdpfBbLX1F6alpyWzVkloOh
	 Xh2YAE2KEIbOAqmhCdlO8J2ij2aLGfbrCagb9BAswj56zckJKI0oxRUufDm1sr19i/
	 0QLJbVND7J9Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACBD3809A80;
	Tue, 19 Nov 2024 19:06:39 +0000 (UTC)
Subject: Re: [GIT PULL] CSD-lock changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <d3f76f84-9d4c-4fdb-9642-6eed9c62f8c7@paulmck-laptop>
References: <d3f76f84-9d4c-4fdb-9642-6eed9c62f8c7@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d3f76f84-9d4c-4fdb-9642-6eed9c62f8c7@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/csd-lock.2024.11.16a
X-PR-Tracked-Commit-Id: 9861f7f66f98a6358c944c17a5d4acd07abcb1a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 311e062ad504bdf49e93cb88a22ba04d5134111c
Message-Id: <173204319847.653509.4457310969830921659.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 19:06:38 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, riel@surriel.com, neeraj.upadhyay@kernel.org, leobras@redhat.com, tglx@linutronix.de, peterz@infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Nov 2024 10:37:34 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/csd-lock.2024.11.16a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/311e062ad504bdf49e93cb88a22ba04d5134111c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

