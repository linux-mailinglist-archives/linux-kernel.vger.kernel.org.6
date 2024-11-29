Return-Path: <linux-kernel+bounces-425942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F8F9DECC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF72D281BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF031A070E;
	Fri, 29 Nov 2024 21:05:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254A39ACC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732914332; cv=none; b=dIk+MC4+UCRRqt4hZtEdPgKxStTtUSsE8jOj1Fp+3HDb3aWCOoWVFoetR5ufiE7NcT4rePXR9mrSa3DO9a/X4G2XOBoJ0wM4uRDYotaxl4cWTQkzk8UP/wskttBom4wSONla2RQ2Nft3sCZxROGXZGGSmabLwFcRbtFAzZg3fwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732914332; c=relaxed/simple;
	bh=qBsoWDj8IOouyTm1auxIDjcz3US9h5Dfjqew0mdmkps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tCkVghMHz6GmnufjmmJQUjST1mhAfv1pgWuhf9/nD22nTrjhzg7iZrTnP0ra0F2C9NcdWyfxc3CkIp1TC2Nz2Ni4hUU3muqQfXVpOZb4O8EDdCoW4xSgcRAibuiLVyC/3cRQaMNjQYfRTuKPjwgs6oj/DJQuSuphMQBWlYL4aGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A28C4CECF;
	Fri, 29 Nov 2024 21:05:30 +0000 (UTC)
Date: Fri, 29 Nov 2024 21:05:28 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.13-rc1
Message-ID: <Z0osmEaBnjdHS3Q0@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the three fixes below that turned up during the merging
window. They are on top of the arm64-upstream tag I sent last week.
There will be at least a couple more next week but I'm waiting for -rc1
because of some dependencies. Thanks.

The following changes since commit 83ef4a378e563d085ddd7214c2a393116b5f3435:

  Merge branch 'for-next/pkey-signal' into for-next/core (2024-11-14 12:07:30 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to dfdf714fed559c09021df1d2a4bb64c0ad5f53bc:

  perf/arm-cmn: Ensure port and device id bits are set properly (2024-11-25 18:53:05 +0000)

----------------------------------------------------------------
arm64 fixes for 6.13-rc1:

- Deselect ARCH_CORRECT_STACKTRACE_ON_KRETPROBE so that tests depending
  on it don't run (and fail) on arm64

- Fix lockdep assert in the Arm SMMUv3 PMU driver

- Fix the port and device ID bits setting in the Arm CMN perf driver

----------------------------------------------------------------
Chun-Tse Shao (1):
      perf/arm-smmuv3: Fix lockdep assert in ->event_init()

Mark Rutland (1):
      arm64: disable ARCH_CORRECT_STACKTRACE_ON_KRETPROBE tests

Namhyung Kim (1):
      perf/arm-cmn: Ensure port and device id bits are set properly

 arch/arm64/Kconfig            |  1 -
 drivers/perf/arm-cmn.c        |  4 ++--
 drivers/perf/arm_smmuv3_pmu.c | 19 +++++++++++--------
 3 files changed, 13 insertions(+), 11 deletions(-)

-- 
Catalin

