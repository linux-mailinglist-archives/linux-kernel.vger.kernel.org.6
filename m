Return-Path: <linux-kernel+bounces-331341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9197AB7B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE8A1C27B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B415DBDD;
	Tue, 17 Sep 2024 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omDZV2+h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62815C132
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554949; cv=none; b=hJjPaARlZUjO+9B4dM3pzYaKLROjKYnNSJ9haOlA6T28wuhgCWbz+/UOsNl5nt+/ao6aYx7hxyUqErF173D2+Cbdfi+KmOXJv2GKAPHW/URSHEnUMnf1vuu9EsViluFLVx/f0iUjZXBC3qS3IwNZiXQDLYLbgRx8jfzZnlKTHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554949; c=relaxed/simple;
	bh=UM1zMw+JxBB1D0NkcTuIGt7VK8MX5xj0XlLSsxDm9zE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZYLJrQ11rBWLaPKRkCFS/A3DoMumtsubZpCjUGU0G/HtONPZCISMDD36ZEOoQc6/Hu/Jf2869lvZRqqS2Uf6ANJsRSclA0syyVMbSJ/xbFHOaR656oUf8EhaEWWwAgJ0K3VWkD89RfSnyPEANHUtF4pLJIOaHEs5M3k8JoM9SSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omDZV2+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919EFC4CED0;
	Tue, 17 Sep 2024 06:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726554949;
	bh=UM1zMw+JxBB1D0NkcTuIGt7VK8MX5xj0XlLSsxDm9zE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=omDZV2+hJSbVd/zKweiwEw2DhC3adjr1Qs5RnqMWTiTdsHeROuBg9x43mceTn/OcT
	 aobCFKr4inz3GJrpPjAsxE4qGnK1xIbIDeZVQZM2abOAnrnIQLds/gBtFxKbuYhste
	 cQdRAGN8ABPcoDSzDckOqbG5+d6UksY49yfGsCcDBrtWTVhIDPIb/re38OQVOEkuzK
	 R/77eoHu+/nVVMPCyuQDYc0cBoMAXf3c0WibLmyeIXZlOE79J1W14V63HMimS9blBv
	 7tFnIMdIFCAkXPkmsii2bYa7TmVGab2ppVOdshtyIDIrmYv64tSrXZQKzEXwWdukij
	 lE2G2VSIdv3IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C803809A80;
	Tue, 17 Sep 2024 06:35:52 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172647589071.2450257.3792507929959687176.tglx@xen13>
References: <172647588843.2450257.3544233832195550173.tglx@xen13> <172647589071.2450257.3792507929959687176.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172647589071.2450257.3792507929959687176.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-09-16
X-PR-Tracked-Commit-Id: a6fe30d1e3657991c832702cecb44576128d7fa3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb69d86550b3f47be50fa5751d31ebbdb71b18ee
Message-Id: <172655495110.13787.1354592582577812941.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 06:35:51 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 10:38:36 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-09-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb69d86550b3f47be50fa5751d31ebbdb71b18ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

