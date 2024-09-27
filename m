Return-Path: <linux-kernel+bounces-341978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE83988927
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AF1282B62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482F18872F;
	Fri, 27 Sep 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnJ6YnG8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D13FB9F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454906; cv=none; b=LqeVyVwQsaag8u5cHHHjsKntxcyMt20NlyrSZo8HhMQxG6x/fy9vHlHarlxUTTePS/7ixYUVex2JaAAHAMJZFNDzK7NbHSSywgIFFMU6t9TayOwhKqpackft2KzLdrs5IQOdtd5/Dgd9qZaywzQljr4q2nnoYXcgKU6Py35Ar90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454906; c=relaxed/simple;
	bh=lJrv7v5km3JV28ChPyiNStioWTJlaYmLsTMRz2kDGrk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gonp9Xzu2PrSgCLLKREqUpNYdd77AW4DmuJTqScVt2xgBA9QeuEUSstNtfbpd5iUCDpAKhMZhP+tzVDK8ay3Xx2UDhM3BXeZk4098NhQwrZYwM6oxvxltLuvq1ew/TOVRUMhuSq+/IgmBhmC8d9t5pmXgUIqs+vujOgXtx3MRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnJ6YnG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C49C4CEC4;
	Fri, 27 Sep 2024 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727454906;
	bh=lJrv7v5km3JV28ChPyiNStioWTJlaYmLsTMRz2kDGrk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WnJ6YnG8KQXkyZsejLegy5Vtg4IXvjeuETf2mcn1o9Wf5i7GQQb37KI9AlEtCIwAs
	 CnrwptqoPgHEsg46BBGqGpLT5HaA81FAvLne1W64lHPTsDNA7TS0HdAqhWhWQv8qIL
	 Ff4kTGOqerXvY5v/Q4SOCxViqNDTlPCEJ58BzvqNVA+6kgQAd6ZcqLHm/sL2NHw/M/
	 GwqZpPsGwg2YXLdXVzivjD3ozw/g39snnrHBh5G3iX/FatceymHvsVu/+9UVLHXcaV
	 R5Odyk/H77SNEurQduCKQztpUm7oEx0nmYatt2hnX6KJIUASf980PVFsxlK4VIButt
	 pFl6Y/ZLcZavA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EFF3809A80;
	Fri, 27 Sep 2024 16:35:10 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZvZe76mpNqBp18Ts@kroah.com>
References: <ZvZe76mpNqBp18Ts@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvZe76mpNqBp18Ts@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.12-rc1
X-PR-Tracked-Commit-Id: eb46cb321f1f3f3102f4ad3d61dd5c8c06cdbf17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5f0e38e7ece5b35577faa9bfbe5ec56091ec76b
Message-Id: <172745490881.2017197.9137107828620214396.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 16:35:08 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 09:29:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5f0e38e7ece5b35577faa9bfbe5ec56091ec76b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

