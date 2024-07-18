Return-Path: <linux-kernel+bounces-255857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D8F9345C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F04E3B227EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5921C36;
	Thu, 18 Jul 2024 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU4rzxE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD01B86E1;
	Thu, 18 Jul 2024 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266034; cv=none; b=DtZns/zUiilkA0W63lF79nViRXqhK7Ltu06tFYx0Jw4ceqGoMESjz34Ck/pD2+CGt6sizVX6m7SldAcY/Hj/+GRgYKt2VfQCOx5oLASQU9TepfSWA9Im/wDc8oeil4PQz29ukoZPk8W8BeOsUT7DZ33OpsAfpbVy6qWXani54iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266034; c=relaxed/simple;
	bh=qMB/Z8D6rlJyTlkgxLAkSlGELdcQyIiViUWDUTvwvmo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nctDBvCu9idCgJHnD+oYolcJfh9cdfj2G7b4ZS3MuCsV5yeZpvaFyuWCq4zfcfAER17FydO31H81+VHNEIqStDt7zgFWAwhMJXGqz8UYjHx7Hb2ME7//AQwQEmJGJi7tWOtxmRCPkNoMlVCy6OCSv6+V58iX1fHg7wGf8FwTa/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU4rzxE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91A14C4AF0E;
	Thu, 18 Jul 2024 01:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721266034;
	bh=qMB/Z8D6rlJyTlkgxLAkSlGELdcQyIiViUWDUTvwvmo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XU4rzxE5jey3+OE/SiV0KhTMxbJndPFOSP08p8DbiaY4fFfF+Cfb6VvjFbwhYYAEx
	 MZX26k7id6hIM4ZtMm6JtVEkB2piz1t2nmFPyoesGG/XsA+EKukejhXTrs91SHURTQ
	 f0E6AOPCeqj557MCIwH6l7CkfkoZtqCaIF6sDN5GN26B7wa47UiCLA5LQPWUbIzQtR
	 epkB6XNNyvbAdIz/GNjTZU5vW7hGE52BlAQLVohZlwn5yvITzUkQkog5NStzjdC4M9
	 RbHzSdWy2VIOZNJzw9HoAj5QGgOV5t0pbPqYem7vnOJF4csIFPQ4/eaaalKpqDxlP+
	 53aDXEXSbS76w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89C5EC433E9;
	Thu, 18 Jul 2024 01:27:14 +0000 (UTC)
Subject: Re: [GIT PULL] hte: Changes for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716181335.954154-1-dipenp@nvidia.com>
References: <20240716181335.954154-1-dipenp@nvidia.com>
X-PR-Tracked-List-Id: <timestamp.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240716181335.954154-1-dipenp@nvidia.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.11-rc1
X-PR-Tracked-Commit-Id: 9e4259716f60c96c069a38e826884ad783dc4eb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b9ac6c2a735f5b1721e0bc7331f8707190f9ef6
Message-Id: <172126603455.24030.8171643356561529823.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 01:27:14 +0000
To: Dipen Patel <dipenp@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, dipenp@nvidia.com, quic_jjohnson@quicinc.com, linux-kernel@vger.kernel.org, timestamp@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 11:13:35 -0700:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b9ac6c2a735f5b1721e0bc7331f8707190f9ef6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

