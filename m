Return-Path: <linux-kernel+bounces-413473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507EB9D197E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86E728316C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24F81E6329;
	Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DE1E501C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960867; cv=none; b=hzUwfI4v5aSlI+2Sqp3FnZdLCepvLEFNdjkPRQNgTftLJtOFVX0q/yNnqHzisWhBkr0WmBTdHMHL5I1MHtTKswkRynY4Eg9hpqvMmpM/qDYBn7Dt/BYk3xXOlO85piOEJHCuOpONQpw4sdbZAV54+CaZ9k257TN9tA0DhFLk4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960867; c=relaxed/simple;
	bh=e2WEIj4YU4LbJs20MxJiLz1Ou0xWiqgMw4+nNqRjV0Q=;
	h=Message-ID:Date:From:To:Cc:Subject; b=nnpEkSpxMc1Klbq3nfyVSU8eYjt3cgQC6kP8sxzjzkA6Z0YdcpTC6SMJCVrIdRrqDYZUa/+04JplAx4aMYmnNiiwFJMDYkpZsGeBT1sG9xz88O2R5jLiuua+YiAPMn3RfKUfeQqXJsvlUp6Oo5+fuJ6o1ysyyXklOVNJhdjBQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34C4C4CED1;
	Mon, 18 Nov 2024 20:14:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tD89C-0000000D8wb-3sU6;
	Mon, 18 Nov 2024 15:14:58 -0500
Message-ID: <20241118201431.871648641@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 18 Nov 2024 15:14:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 0/4] tools/tracing: Last minute updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/for-next

Head SHA1: 355e9195bf25b828efc853417600179678c85ac0


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
 3 files changed, 32 insertions(+), 28 deletions(-)

