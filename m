Return-Path: <linux-kernel+bounces-534943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A91A46CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969B21631F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E792566E1;
	Wed, 26 Feb 2025 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfdXKTas"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2423A14A627
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603876; cv=none; b=Ug7YHvv0PIWb/7ao+kGD5/cIhcZ11JtTXaIDYsTcqh1qLyIwVieaw1my7l+qxcG3f4a/syoME6i7DDKmhtx7MfuXZD396SnVV2D0wGwbl47jzmkYJYuoQe7EHDSplILjxxYqr25tfV9xrZoTiC40Qdzp00/JeoeX7BPukxDSquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603876; c=relaxed/simple;
	bh=GbrdlFgikfIWA6HLPg8X/flPei5NOmhtbJNlzYCM2qc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F1Mi7g9o5Puhyv2noALggx1F4IvezAsetWJPfq0XqbujPVu62/Sscv8jvKtym/65/gUJI++4SLRH5+tZ2NXGV2ZYV7MXTnNansgu2x1mxFLv5T227+M3oe+794GAnIPqN51hnupfeeulgMuRNnnaDD3Phf0L9agX++bl3T9LGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfdXKTas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65387C4CED6;
	Wed, 26 Feb 2025 21:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740603875;
	bh=GbrdlFgikfIWA6HLPg8X/flPei5NOmhtbJNlzYCM2qc=;
	h=Date:From:To:Cc:Subject:From;
	b=tfdXKTaslZoE4+ewDVFx4QFnP+ymIQyzRuOIR3uc52eW0vCbTJAFI/cwI6letysFU
	 PC0LYxhJLpaYKwnarVMIRzHdTyTnZXCD2QnfFwiIjWhDd7TEodeeC2vxMq0kuLS7PW
	 744338AezWbiGvNLKZkRIToZRLXgRx+lea5U8DCdUukIx33QIm8xhD+zYaQBrjid63
	 72ZKuq63lzx7wkjRsv5dQyDdhINwWZxmm4RgNx2dw1OKHDAxWIBDLVM7CbNhpflp+X
	 KI+cl3hRCP/+2v7HYWuqIJr+NVYpxb4MVETroZD4Usl8DaA+NCj28C+QMGPSsIZ/O+
	 Bxk8E/Jx/XKVA==
Date: Wed, 26 Feb 2025 11:04:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue:
Message-ID: <Z7-B4sePVIfNpjUH@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e76946110137703c16423baf6ee177b751a34b7e:

  workqueue: Put the pwq after detaching the rescuer from the pool (2025-01-24 09:29:46 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.14-rc4-fixes

for you to fetch changes up to 8221fd1a73044adef712a5c9346a23c2447f629c:

  workqueue: Log additional details when rejecting work (2025-02-14 07:16:33 -1000)

----------------------------------------------------------------
workqueue: An update for v6.14-rc4

This contains a patch improve debug visibility. While it isn't a fix, the
change carries virtually no risk and makes it substantially easier to chase
down a class of problems.

----------------------------------------------------------------
Will Deacon (1):
      workqueue: Log additional details when rejecting work

 kernel/workqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
tejun

