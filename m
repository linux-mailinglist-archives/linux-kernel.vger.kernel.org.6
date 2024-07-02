Return-Path: <linux-kernel+bounces-237880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64622923F6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DB1281CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD321B581A;
	Tue,  2 Jul 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL1xQkTe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706791B5811
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928088; cv=none; b=AXv7uFIeJdHiSnJYufG/DyiEGmR/7PkTa9wMzrNUYT1U16fk+CZL2Rs1h8gsGE+GpE8DuxKTeJH82hRioRMu56kPBA21J3lbu/rbobuzD1WhX06aSwUr/DgVtkhdFzJ/9q9Bat6Pw3nq/eo6iJe6y5YINpGxtE6wkNIVlKTeXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928088; c=relaxed/simple;
	bh=cvHBMVkFw0cdu8CqXT2tcn8q1A8BbAKQJOw7cbYh+PU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SH95GM8oasa2blKT8+YHmotAhTFrjehAhRHezaAwgc8AqlW+oMF9Qsc/ggag2qD1cWLVfoM//miZJUhIrLyQrSWMbAWnxGqb5oaDKvHivWOyEgHvCTUCW4/BrWivvcTbWoDDYM1N9uRilAH02gupADYUeVdF+5T4DZuNfqGaJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL1xQkTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA54C4AF10;
	Tue,  2 Jul 2024 13:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719928088;
	bh=cvHBMVkFw0cdu8CqXT2tcn8q1A8BbAKQJOw7cbYh+PU=;
	h=Date:From:To:Cc:Subject:From;
	b=hL1xQkTe78IaQIpZ+hZSpilbOGr94FXS4BIXNKzjyG2uTOS+E2N2g4xRNTexbh2oX
	 F6Xvc5pGyU71I9t96h2dd8/1qfxY9Gryak47fH8wHARvc/+sCJrbgL3yEvc+vH5cov
	 vmUGU4lUZGQ4Ysnw7GwqdW3mrzHpzkESeSIS1LVlGxRM1MJDT9YqY6jwxQx1bCUcNP
	 yTOO1txNNUdPBtyzSJzLw1sc/ADkxfKCOpSJu41iyqVYA88dOeCc8g3CkYXJiOGb0G
	 AttlS2lZwy+WzMmMJHgNVjakYmGHSsz39puhca265ag5zm8TfR2yUo5ncy4MBCkNXa
	 17KzUWDxxu+uA==
Date: Tue, 2 Jul 2024 21:48:02 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>,
	Huang Xiaojia <huangxiaojia2@huawei.com>, Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 6.10-rc7
Message-ID: <ZoQFEp+U+689DPdO@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Sandeep Dhavale <dhavale@google.com>,
	Huang Xiaojia <huangxiaojia2@huawei.com>, Chao Yu <chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider these patches for 6.10-rc7?

The most important one fixes possible infinite loops reported by
a smartphone vendor OPPO recently due to some unexpected zero-sized
compressed pcluster out of interrupted I/Os, storage failures, etc.

Another patch fixes global buffer memory leak on unloading, and the
remaining one switches to use super_set_uuid() to keep with the other
filesystems.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc7-fixes

for you to fetch changes up to 9b32b063be1001e322c5f6e01f2a649636947851:

  erofs: ensure m_llen is reset to 0 if metadata is invalid (2024-06-30 10:54:28 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix possible global buffer memory leak when unloading EROFS module;

 - Fix FS_IOC_GETFSUUID ioctl by using super_set_uuid();

 - Reset m_llen to 0 so then it can retry if metadata is invalid.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: ensure m_llen is reset to 0 if metadata is invalid

Huang Xiaojia (1):
      erofs: convert to use super_set_uuid to support for FS_IOC_GETFSUUID

Sandeep Dhavale (1):
      erofs: fix possible memory leak in z_erofs_gbuf_exit()

 fs/erofs/super.c | 2 +-
 fs/erofs/zmap.c  | 2 ++
 fs/erofs/zutil.c | 8 ++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

