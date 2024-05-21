Return-Path: <linux-kernel+bounces-185322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78B38CB37A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3677EB227A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292A114884F;
	Tue, 21 May 2024 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZPR/Y0v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4621105
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316050; cv=none; b=Izq3KsTDRBzVAsg2RCJnBcEu38SFdhPGsp/Lbl0u8U1KSpqMhd+jERZvZO0iuyKRPqDrlyPhxLT7SNam+gq76mtYuOa8aiRnnXHnyCpABoqWmb/x0nDRRd4SuNR/M8cXvJVmz+GInvXPtD21cLo3tUgpnVFBE7xdPO7BLlBq8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316050; c=relaxed/simple;
	bh=ve8IZ09HaQoQeCRKX4a6ODqwQgK/WQedhFRqcmodyFI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FVW7ITFFlbij/Xx9JBAZDta5St33Wg7k8RD3LakWWD4mP0df0QnVxlKtNCRqeubCzJbgNfpihtlSnvUCwObm+L00CCrZtT98+4JJpwYtjnzbFFgDnzuAx9NmOBMC7edxu5nAA9zW7ln16Dlo+SPfE54/panN3DmPUnilGXodgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZPR/Y0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AFBEC2BD11;
	Tue, 21 May 2024 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716316050;
	bh=ve8IZ09HaQoQeCRKX4a6ODqwQgK/WQedhFRqcmodyFI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mZPR/Y0vrFCambjb3Niz59wijIcNC3NesyodU9Re8lpy3bZlXD5DDhxVVKTkIDk4p
	 OMaesXAP5ejZk9A/jVIYoF2JF/2+VD3Cp1B9Js6wBwhtT+yKZPLZZIR0YKUU0HJiT4
	 4EJhv0qpDfpMUMbk+2lPA9a07BtKpbsfgjslliX+hysXnxfTpUR9adrLfGyafr6/ln
	 yeq1vFHLFDA7KAlFzDkwQ2qipaUASuN5zXFuNNsWcVMZyMteHW+K5boZ7HLmBWFiZT
	 SI0TY9liwx8hdH+5U/uqAFAayt8lYmM3wU2GRPXe5f9Z8IVdPDYQK4N+e/jw9J6Sb0
	 9zFeANb6NqRSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D30DC54BB2;
	Tue, 21 May 2024 18:27:30 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkxNrbkVaSGSWSA_@matsya>
References: <ZkxNrbkVaSGSWSA_@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkxNrbkVaSGSWSA_@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.10-rc1
X-PR-Tracked-Commit-Id: 28059ddbee0eb92730931a652e16a994499a7858
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4e034b4c43f289a4d96144e209f47f453aae4f8
Message-Id: <171631605024.31501.16663059239799003529.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 18:27:30 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 13:00:53 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4e034b4c43f289a4d96144e209f47f453aae4f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

