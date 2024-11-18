Return-Path: <linux-kernel+bounces-413535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EB49D1AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A56B23D60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0801E7C1A;
	Mon, 18 Nov 2024 21:41:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24831D0DDE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731966077; cv=none; b=lr5iAKGCw9v6SVF0nScoptLYSp52WjDR+i3obMawKJJVj9bjEZenLCWi0vboIsPmxdhLtGNqal9Q6kqeclteqfsWREXp8Bauw1OPd6gLNM/HxRW08trq51OsaVVLGHvTG4DD5V2gmnnSugh74SqXfHYMpPGV/UfTTaybVStaf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731966077; c=relaxed/simple;
	bh=x+2RgRqhU3HoynVrJ4Q0EZu5OX0UqUefdz3GSofYfho=;
	h=Message-ID:Date:From:To:Cc:Subject; b=QvGBV535soGJELad2bu0NRv2p3q5lT+x4tFAwSsvQYCbzs3fU03G/bDu2Y+WEmatiHy3JXJxehZ+EhufY7SxaxQAzhGCiBIpAuz8x0THgAMhnxJkWgUjTxdtAPKk8dleSit4roQbVilCr+4WL7DgFtx9R8AK0M4nJoqr7Affa4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A067C4CECC;
	Mon, 18 Nov 2024 21:41:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tD9VF-0000000DO3Y-2HRb;
	Mon, 18 Nov 2024 16:41:49 -0500
Message-ID: <20241118214122.136581969@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 18 Nov 2024 16:41:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 0/5] tools/tracing: Last minute updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: 5f99dca95f3c208abb2b8757a2a2bd671d04d7e0


Gabriele Monaco (1):
      verification/dot2: Improve dot parser robustness

Tomas Glozar (1):
      rtla/timerlat: Do not set params->user_workload with -U

furkanonder (3):
      tools/rtla: Improve code readability in timerlat_load.py
      tools/rtla: Enhance argument parsing in timerlat_load.py
      tools/rtla: Improve exception handling in timerlat_load.py

----
 tools/tracing/rtla/sample/timerlat_load.py | 56 ++++++++++++++++--------------
 tools/tracing/rtla/src/timerlat_hist.c     |  2 +-
 tools/tracing/rtla/src/timerlat_top.c      |  2 +-
 tools/verification/dot2/automata.py        | 18 +++++-----
 4 files changed, 41 insertions(+), 37 deletions(-)

