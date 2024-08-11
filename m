Return-Path: <linux-kernel+bounces-282350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F6B94E2A8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 20:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E771C2074A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38F157467;
	Sun, 11 Aug 2024 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb9ipARR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A91BE71
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723400560; cv=none; b=TIkeimkkSn7fuHQM3gIWQWQ2yDKu8oHpPPo271P315zm3ULL9InL9+An03ZSdE3SuCvHKZAXQWyA+ol+mHcVcHMRHEXgz+5fQvzhr2SB3Y9asM7zcGBHvtGhNBKEXA8SY06dTJlRzrR8nx+AG4ZDx6dGsrjFTmFuEuMP+GBGbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723400560; c=relaxed/simple;
	bh=IK4zx68uuoxd9DZcDz/DpYU5ka+0DEjiNN7vKs7nKGE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PvZBNL7wBM7d5UGBFTcSmUG97DsIqOq7Ss4T7ItyxNbKaVGnt7joO8kZ0w/aZlFckbpDumSzs2rIPfpW7E1BQ54/D/y3iIdsPBVGKG8VSondUhM1YBESpAil0ry4tr+GRkAyuomMCh9pAzZKAefSUQ1d7suYbYCALryFTzj+iFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb9ipARR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B955CC32786;
	Sun, 11 Aug 2024 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723400559;
	bh=IK4zx68uuoxd9DZcDz/DpYU5ka+0DEjiNN7vKs7nKGE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Nb9ipARRW8k0Fbh1JsYNUl3FoL8bdrXxhxllD7OtoJmPLJIu+FtGhGUfrHlEZvo37
	 k4iYB5hryCmiS6Db5NbxwT3tnVzV42s8N30EsubLypsBhVO+YFywHf/Xsn8oCupY+T
	 TMafPNKGLM/Wm4Sp8SqjyUr4yUv+fmLekcZuXDO9vWpOSA5Gpo/GhJBA+h5a7RN8YK
	 8sxU3Zt2V14MG8xFjZ/AvnLufkqKKi0/3BJH8HVBwyVPHT3dbzMg1INig9beFsJMtn
	 Twi3O86LJw1AzSusEi1MrWtXhyhJQkPxbAvsmttCYWjRMsSFLRu2vh7eswflvXBdxX
	 v6ZbTKxwBBmZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0E03823358;
	Sun, 11 Aug 2024 18:22:39 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
References: 
 <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-11
X-PR-Tracked-Commit-Id: 03f9885c60adf73488fe32aab628ee3d4a39598e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56fe0a6a9f8941b154bd6a41ed828e9e1078b67b
Message-Id: <172340055833.238940.8000920842710551030.pr-tracker-bot@kernel.org>
Date: Sun, 11 Aug 2024 18:22:38 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Aug 2024 15:58:05 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56fe0a6a9f8941b154bd6a41ed828e9e1078b67b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

