Return-Path: <linux-kernel+bounces-252820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F166C931870
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDDB281938
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47751C687;
	Mon, 15 Jul 2024 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5NLxTUi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6F5E556
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060636; cv=none; b=ZnL6iuC0YYdaRlGZF2WgDIhA0T23cdiYVkpZJjxe6ACr10zu35kpUaYzgPmpXLrS/y6VHsgYOIr49joBBsF/9VqsMM9VDzyAL1KYDFoPBJTYBxNDwtplrQHIU11RunCu5a3S4qdd3/4S6mCKwk95XEoIbqs+rRyzpmj39Ezwrjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060636; c=relaxed/simple;
	bh=oU+dePIc4bD2w4dmTJjBNZQcz797MNwXxYk6btnTiXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d/enwlxdKMgNtQJZT97CdH2xJ4hHNdzNqI0gcyPoTEQmua7XAEZ+LWwAWmm31pSSZDp+fxk6a1oTjLzLTDXYZlzxrcF1H4XBuTBGExMiOhz4XGTPzWM03JpW0GsKZwsBhXiE/ZIF0HJzVBFJU1jDrAk2Q/TEuS9aLn8b/meT5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5NLxTUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE29C32782;
	Mon, 15 Jul 2024 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721060635;
	bh=oU+dePIc4bD2w4dmTJjBNZQcz797MNwXxYk6btnTiXk=;
	h=Date:From:To:Cc:Subject:From;
	b=e5NLxTUizcRtR0/fVrbijlI/b23nlaGypiE/sPhbxpDls3SLtXceXMh+SBzQ0nFDp
	 FLD09+u/fZ+ge+4rMtD9DcV04Tq3jefcccHNbOdM3Kpj2L/JTUwRkyH5ZdT8WXdTco
	 d/3b3pi6WxUvYTOFeLjL6Fnz64wR42zou6nhyopKs54jMRl+ObqHuTBAhzCoS3WSg7
	 EK690vsYnE0PXzan8qmvpRSt21BECy99otnLDOk/ZysZefAQ90aqqjJStaj+imR2vb
	 ByTDZloz8s3vkScBq3upql4zwlAf8eG+X4HcHnmcIcSeHvVmUQW96hYEg8gkZtpnZW
	 Yx4EcOz7PDZrA==
Date: Mon, 15 Jul 2024 09:23:54 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [GIT PULL] seccomp updates for v6.11-rc1
Message-ID: <202407150923.7A3B3FD@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this seccomp update for v6.11-rc1.

Thanks!

-Kees

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.11-rc1

for you to fetch changes up to f0c508faea645da58d6ae6b644a1b68020d5a9d2:

  selftests/seccomp: check that a zombie leader doesn't affect others (2024-06-28 09:37:11 -0700)

----------------------------------------------------------------
seccomp updates for v6.11-rc1

- interrupt SECCOMP_IOCTL_NOTIF_RECV when all users exit (Andrei Vagin)

- Update selftests to check for expected NOTIF_RECV exits (Andrei Vagin)

----------------------------------------------------------------
Andrei Vagin (4):
      seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV when all users have exited
      seccomp: release task filters when the task exits
      selftests/seccomp: add test for NOTIF_RECV and unused filters
      selftests/seccomp: check that a zombie leader doesn't affect others

 kernel/exit.c                                 |   3 +-
 kernel/seccomp.c                              |  30 ++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 131 ++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 7 deletions(-)

-- 
Kees Cook

