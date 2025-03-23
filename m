Return-Path: <linux-kernel+bounces-572733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95671A6CDE1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 06:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF717A5E7C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 05:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B6E2010E6;
	Sun, 23 Mar 2025 05:08:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8292E3380
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742706535; cv=none; b=S3zN9K+YgmWbJSDDw7EQ35TEbii6bb676uXAiNH9u07F4ShwS9tQbo57Rnipion4PzAwo3U/pMKU14TYvXIY/HWO5u/D176sorTdfkkezBa67Px8tD6BMVyz4zkgxiQiaKsgmQPu/7IczXiJyL26ARjqLrErMrHIiReUFqKesS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742706535; c=relaxed/simple;
	bh=enhFoASdbZBLzZOJ1TNInotqkoPm0PXyDsOUmPBFQGY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=eaJ3biWOTtk1UjaGi4b8m5D0qaObnbx3pwTYsPpAu8cOj+3gVLg9ns5OR3yR3w3kxFEsNUc14KwUrPyxp8P1uxPxjR2gQMUqsTCjSM5tsXOeKhn9w68lkBQ7f4PkO6Q/wgmF6FnoqnReQqvFDgX2u8jCgb13m9tpxVj2BJhlIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBEEC4CEEA;
	Sun, 23 Mar 2025 05:08:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twDaX-00000001wz6-1gCO;
	Sun, 23 Mar 2025 01:09:33 -0400
Message-ID: <20250323050914.459621318@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 01:09:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] ring-buffer: Updates for 6.15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: 0e5d1a4b22bca3d9a9a2d2ba79ed67c5e74607d7


Jiapeng Chong (1):
      ring-buffer: Remove the unused variable bmeta

Masami Hiramatsu (Google) (2):
      tracing: Fix a compilation error without CONFIG_MODULES
      tracing: Skip update_last_data() if cleared and remove active check for save_mod()

Steven Rostedt (1):
      tracing: Initialize scratch_size to zero to prevent UB

----
 kernel/trace/ring_buffer.c |  3 ---
 kernel/trace/trace.c       | 35 ++++++++++++++++-------------------
 2 files changed, 16 insertions(+), 22 deletions(-)

