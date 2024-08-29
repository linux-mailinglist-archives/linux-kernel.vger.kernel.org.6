Return-Path: <linux-kernel+bounces-307408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EEA964D40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CC32846AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425411B86D6;
	Thu, 29 Aug 2024 17:52:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB062192B85;
	Thu, 29 Aug 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953932; cv=none; b=q9er8Sk5rGO5I0h05ZFXuS7gdYxxHvRLRIQv1Ll9XYEq2C61KfMlSS1VwKUFR6J3ZbbDDhRP6G/6qFtflyviMnhspaPajRAOkYLHrY1GPHivBL1I12uGd9xq4QW/S4NQq8qpxSR5lBHsiSlUAXI8DsMaS2TMJcSnMBtewdVu3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953932; c=relaxed/simple;
	bh=ESZuqFIWVyEMgaTlyXT0Y8qtcw9XqCdOqGNg4RP9yd8=;
	h=From:Subject:Date:Message-ID:To; b=d0BXUHefqaZ8oPUJAmrj9KC3SLC1GLil9yd4b3jQDB38yZUEyuwYELqg42U5iDcann9tHcYlgI1KnGgBTSQKF27PPP50iNrOjYDEaE5FCmf5idKkcBfxDeET3dJiViveSTYGfKFw8NyUDzCNFLLAmChanXdnjAK//e5r4CPJArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32356C4CEC1;
	Thu, 29 Aug 2024 17:52:12 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.48-rt40
Date: Thu, 29 Aug 2024 17:51:36 -0000
Message-ID: <172495389627.1085130.107610818721726814@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.48-rt40 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 19508ada13b9d9ad8a10e1ed8c461a222e8a29ac

Or to build 6.6.48-rt40 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.48.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.48-rt40.patch.xz


Enjoy!
Clark

