Return-Path: <linux-kernel+bounces-370617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2379A2FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7525282448
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483441D3573;
	Thu, 17 Oct 2024 21:23:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0029176FA7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200209; cv=none; b=fJ2JIhQ/MEFdb7RjHiWwuLhOZLkWEny/oxNer4YoVq3f+yKYJthwkAv9y2O1Xus39CuCq7QjYVjTxX/YeFYN9bQDRPYh6XtcPjdItq8067zKcDGHTJ51CaBeX82jXvFC8KgpXDmB3EwO568DGtp9Baj3EsIqcaxqh4AuPNATRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200209; c=relaxed/simple;
	bh=aEK4bJNDMhQvEOqY3np4qo3icaikc195g1yh7hhYeA8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=i94lf82PKjiletQJ0B/9n+MoH6xyLgoYCqCp73iIDveYEa488UjhymY5Nme7OwLVGzUbIvKCuvJ39MWy6t8EamF1hxBrvVCkQ3G3ZhwNEpFdYLbMPrn1ZnCGUAfSnSsQybSmm16RMqO2b+JTn5wy6qAEEpnGj+e9AoJcoDNWJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C46C4CEC3;
	Thu, 17 Oct 2024 21:23:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t1XyL-00000003wCS-447W;
	Thu, 17 Oct 2024 17:23:53 -0400
Message-ID: <20241017212328.560060762@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 17 Oct 2024 17:23:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 0/6] rtla: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: 13216486e3ede30d6910a22e0e15988b7016366b


Tomas Glozar (6):
      tools/build: Add libcpupower dependency detection
      rtla: Add optional dependency on libcpupower
      rtla/utils: Add idle state disabling via libcpupower
      rtla/timerlat: Add --deepest-idle-state for top
      rtla/timerlat: Add --deepest-idle-state for hist
      rtla: Documentation: Mention --deepest-idle-state

----
 .../tools/rtla/common_timerlat_options.rst         |   8 ++
 tools/build/Makefile.feature                       |   1 +
 tools/build/feature/Makefile                       |   4 +
 tools/build/feature/test-libcpupower.c             |   8 ++
 tools/tracing/rtla/Makefile                        |   2 +
 tools/tracing/rtla/Makefile.config                 |  10 ++
 tools/tracing/rtla/README.txt                      |   4 +
 tools/tracing/rtla/src/timerlat_hist.c             |  42 +++++-
 tools/tracing/rtla/src/timerlat_top.c              |  42 +++++-
 tools/tracing/rtla/src/utils.c                     | 150 +++++++++++++++++++++
 tools/tracing/rtla/src/utils.h                     |  13 ++
 11 files changed, 282 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-libcpupower.c

