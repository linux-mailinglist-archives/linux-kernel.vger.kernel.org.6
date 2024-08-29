Return-Path: <linux-kernel+bounces-307440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE42964D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699012826BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7301D1B86E0;
	Thu, 29 Aug 2024 18:24:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE91B86C0;
	Thu, 29 Aug 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955891; cv=none; b=q9qbkBgvaDstFBG7sU20CK7KVeJwJ91HPWrQV7fy4ASSA/+1awetjiVriysPqvVwFEuXO1tDHAlPRkDVhaVnPrQ7r5Hz6wXs/M8DuBV5ndh8WrxFsju63JiGv9h+Cb4SMyyoKzpr8Ow7/ek7/CTu7wsG7KQK12afcuQPLjc9/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955891; c=relaxed/simple;
	bh=kMfw81PLyOd1h9PmIl9cm8iMLrq17o72xvfRm2dmmLc=;
	h=From:Subject:Date:Message-ID:To; b=PKLGpXoabBH9Pzvd9F5jxaIMPugfFE/wFTeRZaXFaksnrbqYidoeAP1bcka3ZxfyvFxkHxMRBliqpFtpHstovfmUZfmbUpGsVGqlW28ikbx8VuchVPUsTfCQMBxr+Y2vqON8xUgc55v/3FtnlmtmllxaqHXT5gzfMOyHj4sIb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757C6C4CEC2;
	Thu, 29 Aug 2024 18:24:50 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.107-rt39
Date: Thu, 29 Aug 2024 18:24:06 -0000
Message-ID: <172495584642.1224508.179863995946300447@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.107-rt39 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 634306c07406552af4e8f51e06fb4b29b332f368

Or to build 6.1.107-rt39 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.107.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.107-rt39.patch.xz


Enjoy!
Clark

