Return-Path: <linux-kernel+bounces-253206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75478931E27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10701B21FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB7B17C8B;
	Tue, 16 Jul 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LihvekB0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15116111AA;
	Tue, 16 Jul 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091114; cv=none; b=jFX0JMeex66LjT7MjhiX5nvyb9klDevngoYe2PHMDpyrwIh7kSqBEJSp4pcuCa9atHSiKJ92B1LD+vhSNIdZSOSRARtlBoa1ltZ8IBgog3ROOHVhK9LfRnfN1UMiy6BJfCIg3fKi+Kp+kClQTxZ4wYs5AVo0JlD2M8T8Wr0yIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091114; c=relaxed/simple;
	bh=nPEtIbOu7thhLJFHVcq0F0Az8iig5YuFnq5JrHXFObI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WESskOnMG2OaqmRSHwgBIG2D59bOyaK1XMrcD142uCwMcRGe35QUlSX1Ep8EgulPf3Yv4krPYcRb4K2kl2Mp4UR3D4aArT0oJoTpfyqHC1tJ8mn7HOA7c+GDFItv356vDz8xKs3wGHk0z9Ykt5zbDiu+9SCXl56PcACrE7TLj+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LihvekB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D32E0C4AF1B;
	Tue, 16 Jul 2024 00:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721091113;
	bh=nPEtIbOu7thhLJFHVcq0F0Az8iig5YuFnq5JrHXFObI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LihvekB0hqpidRCSaTpTg4ksogDxuK9rQe8ecxOcJURiA64atdsxoFeHAM5ZhO6Ki
	 8UHa9yM9b7VtxgUv0dL90RnUILPaiqKA2nYICy735xfZMu35xLztx1mxTMI9lwLl6y
	 sRwMlhFlgL5ND16wiQ8JaZFWldlfoRAbTh+rZW8KCJ2uJSUFMSPklPsxyANKnUtGqz
	 VS8+++qsAVFgnGzB7ameCu+SdbWR2hI7FXTGS1LijRv7sJnyWXqdKmz59abZhMjGIG
	 9uOrLK6IXbTbO28kSRElLRcccuMLPnwVuEBNc2oQP+JXI5wgds1boqoD2A5DC2HQz1
	 Z/GppRRv78GFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3491C433E9;
	Tue, 16 Jul 2024 00:51:53 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform-firmware changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpSicQDtkyR5r4vF@tzungbi-laptop>
References: <ZpSicQDtkyR5r4vF@tzungbi-laptop>
X-PR-Tracked-List-Id: <chrome-platform.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZpSicQDtkyR5r4vF@tzungbi-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.11
X-PR-Tracked-Commit-Id: fc2c1d716d4a879dd52c612ea19a7f994f08748d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdf471c348c1200ca243775b4b8d6eaa6d7f3979
Message-Id: <172109111379.26590.12857063636885974448.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 00:51:53 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, briannorris@chromium.org, jwerner@chromium.org, groeck@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 12:15:45 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdf471c348c1200ca243775b4b8d6eaa6d7f3979

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

