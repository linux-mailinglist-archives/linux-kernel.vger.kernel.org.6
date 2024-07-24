Return-Path: <linux-kernel+bounces-261488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CD93B7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9B71C24233
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468D16D4D1;
	Wed, 24 Jul 2024 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOaOF6yp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3D71CAAF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852329; cv=none; b=WuXqwEeljyg1NAAqB2nMkrutNYct/LqGy56quPOTRQ6sK11bH7ZaCf52bCUy+jKMGCRgYBalV4Mfdxu9MZhkAFQxujZj1ZvOgBiiHrj8nxpX0bcjp0iZs3T2SxjUOlg04zeQKUHPx/ajvArIrrYgD3XplNX6fETw1Z5SKQYQUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852329; c=relaxed/simple;
	bh=QagbB8/T5zAujD9yiqQczEpkcmdTDIjsHaoEB01RboM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TejX+iDsSO0o/sso3LMwIqGfXBrM4nbpE+n9Qlnrh/1PLZb1zLirCj5pn3O3WSOTM7CwgHzu5wMbWaHn6zsmoFEF5acwJMgcSFzoyKejEC9Lc8a9N1+e0d3WyaRflQDexV7wCR9hECRIn7c+k12FB+/X+G0jWUyrHnY2Dl6Ewu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOaOF6yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2AFBC4AF0C;
	Wed, 24 Jul 2024 20:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721852328;
	bh=QagbB8/T5zAujD9yiqQczEpkcmdTDIjsHaoEB01RboM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oOaOF6ypXgBy87I+w19aOdYBZ58l8q0qaHBqqW+D6Klpi3LhKnevi8UuK0aQqmAvK
	 C0mdf7iHOZLFMwN98UTlHucoW6g8TMwqhoqvROhmxWRB2Hztk7l6snm3oMbUz6gHiz
	 VolnG7DWbtBfan9ehfgcdLgjT6Rt7eTzzdo/ohrQ/27jBE+pFKltYlEBLns553p2MD
	 XVXDNJ6aWvgZA3H1O/V/N/RH21ucUPQM501xVu2Pw1VE/yzqeHf8bgvqnQRHHNH1O6
	 hSBy68I+wnFNgu8tR5K+bngWiZMsspuo/tmUX8VHrpo1+3nCu/jh5e/OMcBYcasWC6
	 838/hQNzvXFtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C32DDC43443;
	Wed, 24 Jul 2024 20:18:48 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZqCxra3XNXK7WbOb@matsya>
References: <ZqCxra3XNXK7WbOb@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZqCxra3XNXK7WbOb@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.11
X-PR-Tracked-Commit-Id: 2a011c3c12e8de461fb1fdce85fa38d308c4eb8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c33ffdb70cc6df4105160f991288e7d2567d7ffa
Message-Id: <172185232879.2896.7610909167998490371.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jul 2024 20:18:48 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jul 2024 13:17:57 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c33ffdb70cc6df4105160f991288e7d2567d7ffa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

