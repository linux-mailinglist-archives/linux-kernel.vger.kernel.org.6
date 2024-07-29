Return-Path: <linux-kernel+bounces-265363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E16E93F00C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAADB283037
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33913CF82;
	Mon, 29 Jul 2024 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAoR5vUS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625141EA91
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242660; cv=none; b=lQf/4qDnl1zwGrcIv7aHwRRut/ZUrOm+CsQU8W7ufsxKoJOGsV+n6vxfo1lcl2T2xuS7zN53MwDgNPXDLENlE8qRac3zxgDls4cW2dWC/j00EmParjO1CYc18HaqHLQrZVXVljKW8hySP5i979YXJ4sWkqurNId0T3VI2UDMKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242660; c=relaxed/simple;
	bh=xzBjwswUzw7ofs0IjaJ17EBcwXfB6AopJ3/iLcXTYm8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F3aHzBW55mOg3O/dCkZcN3wjTqGLx+cKoYbjIs67lu7WLnQJKKczTK6i41MyzjlorFAsTNG1bRxCLpfiLa2SfAfvG9fb9qvYhXWbMS5M6Ras7aV1P8AaNbYhrAs96bt5zWtlpZaFkw/nNLeud7LQSkYG0ixUbYbEsYZYgqxq/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAoR5vUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE31C32786;
	Mon, 29 Jul 2024 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722242660;
	bh=xzBjwswUzw7ofs0IjaJ17EBcwXfB6AopJ3/iLcXTYm8=;
	h=Date:From:To:Cc:Subject:From;
	b=WAoR5vUS+wAz+D3dcNXs/rTZg1JruIACmssMsiNOikOWJW1/SRUtZxqsMVSJYSRad
	 C/WuMc4DeqUbqQoudUl6SCD5zvbvOlAq53Hdi6MezrGQrAiwZmnMDPBEWoK+rq66mw
	 FyzvM9aK7ome6HQRjw69mUFzhvbU1R+48KrMQ6zTPrC6LTm1UPfDjAbd5ntpQRftYb
	 jqmhMNAh/VMY33pDEszfZeGJDliP9bYBIRCwlNIj1uANXIIQ9VyQ8B+TYgnVxz+QcQ
	 bm1U/W8NUOnxDHKtuGnVwHsDfd6Hh2vcAx6LkdG7mlzedwo+/nuQfZ/YGDaJvQiEug
	 htgonFmTIQF9A==
Date: Mon, 29 Jul 2024 10:44:16 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes for 6.11
Message-ID: <l5otbjtybgwldxsmg7cqeh5ecbenu6rhal4rewjwsfe6hham46@szo6q2kcg3ir>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024072901

to receive fixes that should go into 6.11:

====
- fixes for HID-BPF after the merge with the bpf tree (in v6.11-rc1)
  (Arnd Bergmann and Benjamin Tissoires)
- some tool type fix for the Wacom driver (Tatsunosuke Tobita)
- A reorder of the sensor discovery to ensure the HID AMD SFH is removed
  when no sensors are available (Basavaraj Natikar)
====

Thanks,
----------------------------------------------------------------
Arnd Bergmann (1):
      hid: bpf: add BPF_JIT dependency

Basavaraj Natikar (1):
      HID: amd_sfh: Move sensor discovery before HID device initialization

Benjamin Tissoires (4):
      selftests/hid: fix bpf_wq new API
      selftests/hid: disable struct_ops auto-attach
      HID: bpf: prevent the same struct_ops to be attached more than once
      selftests/hid: add test for attaching multiple time the same struct_ops

Tatsunosuke Tobita (2):
      HID: wacom: Modify pen IDs
      HID: wacom: more appropriate tool type categorization

 drivers/hid/amd-sfh-hid/amd_sfh_client.c            | 18 +++++++++++-------
 drivers/hid/bpf/Kconfig                             |  2 +-
 drivers/hid/bpf/hid_bpf_struct_ops.c                |  5 +++++
 drivers/hid/wacom_wac.c                             | 67 ++++++++++---------------------------------------------------------
 tools/testing/selftests/hid/hid_bpf.c               | 26 ++++++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c             |  2 +-
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h |  2 +-
 7 files changed, 55 insertions(+), 67 deletions(-)

 ---

 Cheers,
 Benjamin

