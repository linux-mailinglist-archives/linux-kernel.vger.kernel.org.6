Return-Path: <linux-kernel+bounces-380523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC309AF042
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E37B1C222A5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2324215F44;
	Thu, 24 Oct 2024 18:56:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534452010E5;
	Thu, 24 Oct 2024 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796207; cv=none; b=AUk1xYa1zIeh5e5dsXbKbBbvTIF6uZ6dTOEOCKpG+RzToOS7DccW+ack48paIR/ME/8QRkZ1v617rfozOtsnY7NwxnR4Kz06NmFI+w6nj2AETJ7s6ya3i6QAKs82cgRPSNK+XoA5ZJrVZkNioJxcjjbzlfiqmaExxjKwTYig7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796207; c=relaxed/simple;
	bh=DcpX9tV1QiDuReAFdTjhQFLaRxkeIt4I4szRkKGrWtE=;
	h=From:Subject:Date:Message-ID:To; b=dECU5krHZX6PDiIWj5BBkjLkwOr4nO7C3Q/9B/PfEqgMbhh0AfIiOnNci1EgDCZ2vS3mbuwouze+UCLJjquBlUpB/CaAZvQaGPWt9V0wWTvjOh33CjtfK9AykCndNVm9LlVsqJWZdpTpeJMWFDny7u6olNWdgQdPEfaezQMJrYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B410DC4CEC7;
	Thu, 24 Oct 2024 18:56:46 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.58-rt45
Date: Thu, 24 Oct 2024 18:56:17 -0000
Message-ID: <172979617791.2327480.10815760441971686819@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.58-rt45 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 4df61867f86872b173931d99b3d8aa367fd76029

Or to build 6.6.58-rt45 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.58.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.58-rt45.patch.xz


Enjoy!
Clark

