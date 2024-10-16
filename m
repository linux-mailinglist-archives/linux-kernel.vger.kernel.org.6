Return-Path: <linux-kernel+bounces-368748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EAE9A146D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881C0283AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994CF1D2215;
	Wed, 16 Oct 2024 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArKmJApu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A21D14FA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111897; cv=none; b=gpWeVWyUaw+S7kOvZHNAs4w2HKoCC8ToYm6ftwbx4UV1RSdL9/mqXHHaTuOE368/uhmqI5ol9Iusu/Ic/XZKEc3jLXabM9kWOpuLB1aRlpI2yonoPRRVD39Cw0jvA2a0hquOuU5lshQFIP6eHLubHOPlZ5ibeiB69RnL5Ah8ow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111897; c=relaxed/simple;
	bh=nlbGYvs5fC23YEOAffqw/dmlHnsRXYPAlB3wjGqOwUM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l4RU5LR6WVwazldzUXI1nYkJ6KJ+DpkSCOVJp8dL+ZvKsEkfRlaXj6QPOPtkPAtu6Z1alcl0U6HkJBJGpONVQHyk2TqO4lFaaQe+lbC6Id8kpPCRiFA5Nd5cnHg0iI9LvUsINqK2gLNy3JMo0a4jj02HYio9ap42HTq/x6oJMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArKmJApu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF41C4CEC5;
	Wed, 16 Oct 2024 20:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729111896;
	bh=nlbGYvs5fC23YEOAffqw/dmlHnsRXYPAlB3wjGqOwUM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ArKmJApugfPOntI4p/bDMmbGJxwrcqRIBPDACS/HzVqWO9O71JEA2lR59k2VzpH8k
	 0okLMfNhzpdw6YkIZeODmMiSfmL15ep+l/IyhVdNK2DECWOYjPDM/MLttDszznEx7s
	 qKK4GE7hsYjrrncENYzDADiycfinl3MW7k3y5jyfmqYPZf50jkWnM6zODoAVVNxLwW
	 APYDxLB0yBzfNAVNriqS1zuGZBl/SSBPP7p0FxmQfpDmMvg4FA79cfCWwcy0yWV5s2
	 bkwngnl5CwsoNR33moQvbPLQaPiW5S2+rGHF3iM8tyUqLB6wggeJb169yvsUoQSC+0
	 IvmShi2MyUAUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713A13822D30;
	Wed, 16 Oct 2024 20:51:43 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zw7Syx6dUES0a_R5@slm.duckdns.org>
References: <Zw7Syx6dUES0a_R5@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zw7Syx6dUES0a_R5@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc3-fixes
X-PR-Tracked-Commit-Id: 60e339be100d7d49e13616bd8b4b1b864f0a64a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dff6584301ddeb147ae306b140ccf2e128e29030
Message-Id: <172911190193.1955101.18309260484712245882.pr-tracker-bot@kernel.org>
Date: Wed, 16 Oct 2024 20:51:41 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, sched-ext@meta.com, David Vernet <void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 15 Oct 2024 10:38:35 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dff6584301ddeb147ae306b140ccf2e128e29030

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

