Return-Path: <linux-kernel+bounces-412211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C309D0542
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D167D281CD6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE2E1DBB0C;
	Sun, 17 Nov 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy1gP7Yy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000BD1DB55D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731869089; cv=none; b=Vy/x+aUpw6e2CjZwmo2A49haaJ2/ySyAQp20UAswD2URpqoRif9A2DkLGvCqBpbF3scLxX26++Nx6OTpmuCeBNJrKuXJbtRbzaI+cxopJi7JOmcm858sD2seBcZMt8tVHtL2ZCrHfaDPzT9cyBaHz6Gv6FPOXbC9YVijwnCjeBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731869089; c=relaxed/simple;
	bh=ig4tE5R2PftmUJbSGWvSIxhH15jKIn4AFxyKaQ6PGcg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L5ST9rQLdoAKg6ZW6NfFKqzfSP8D+tUUo6rbEfRzceyswsVgk/h9gGHedgXkjiyNnEM40wo4BN+DE/nSQJttA9rq3w1Li+HebuKSt9Cn01xc/hdEscavDBHHV+c3YjjdnfAzG0XEsGlCMiH9k/QNZm8jaNHPgFDS8GA5KRc0Upg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy1gP7Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A60C4CECD;
	Sun, 17 Nov 2024 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731869088;
	bh=ig4tE5R2PftmUJbSGWvSIxhH15jKIn4AFxyKaQ6PGcg=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=gy1gP7YyngA6epeaoZJOJQdMPEqOd2l4rEm3hzPBC0m/XK+1L7qcxfjH3zBBwc/qS
	 nRmNP2LWDVV46Ln3DtpEfpMMm8fLu+/ktSDHp8S1lEAGD6QGiPPBTVfXyo5apEvYON
	 +I0uefn0tvQNbmp+jarOAQUM7YTsM1QQUvuhWupjAh+/AfpBrqxMNcKCdHVKBBAcsN
	 kntPA5XcJGkMsTgaQUU1vUqbWfonyUxvvGMCfiyyGqoc0bvmw660yqiTVzdoA6FbsH
	 I4tmLHRFM+7t6VeYR9Rh0xZ7Dgi/C5Knv2o7vQIKpUWEsd4lsIO9soJ//2tJ5rR5Zk
	 BSnrvBftqO97A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 28A47CE0885; Sun, 17 Nov 2024 10:44:48 -0800 (PST)
Date: Sun, 17 Nov 2024 10:44:48 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	bigeasy@linutronix.de, dan.carpenter@linaro.org,
	boqun.feng@gmail.com
Subject: [GIT PULL] scftorture changes for v6.13
Message-ID: <e7f3c085-674b-4e5a-a97b-fbc70ce20b9c@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

Once the v6.13 merge window opens, please pull these scftorture changes
from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/scftorture.2024.11.16a
  # HEAD: f946cae86d088d02a2f9c0ae0bf8a80359d3f454: scftorture: Handle NULL argument passed to scf_add_to_free_list(). (2024-11-14 16:09:51 -0800)

----------------------------------------------------------------
scftorture changes for v6.13

o	Avoid divide operation.

o	Fix cleanup code waiting for IPI handlers.

o	Move memory allocations out of preempt-disable region of code
	for PREEMPT_RT compatibility.

o	Use a lockless list to avoid freeing memory while interrupts
	are disabled, again for PREEMPT_RT compatibility.

o	Make lockless list scf_add_to_free_list() correctly handle
	freeing a NULL pointer.

----------------------------------------------------------------
Sebastian Andrzej Siewior (5):
      scftorture: Avoid additional div operation.
      scftorture: Wait until scf_cleanup_handler() completes.
      scftorture: Move memory allocation outside of preempt_disable region.
      scftorture: Use a lock-less list to free memory.
      scftorture: Handle NULL argument passed to scf_add_to_free_list().

 kernel/scftorture.c | 54 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 10 deletions(-)

