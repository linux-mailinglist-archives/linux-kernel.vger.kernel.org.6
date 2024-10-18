Return-Path: <linux-kernel+bounces-372362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE2C9A47AA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33FD2820EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFAC205E06;
	Fri, 18 Oct 2024 20:07:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C54205131
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282052; cv=none; b=f63BK0w7niQ2i0NBm2cUzar3kxy7yWjoI1nuZKJEfEQvGsgRxW1jTnNgz6GIPxzdEsULIIN2tTCQBYEZV/W2ewPNW2ac8l7+sYSY3b/Ykkckapk2Fso8sruDc4C7tzE6ALWofDtIiuSRbBZgnDkM6B4A8EeTx5aoeFdqtjvFw3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282052; c=relaxed/simple;
	bh=SLTRLxRLs3rIfRnAxj9HoLvJYZ+ZMtHjKpZn3PSCGpk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=rGBTRM7Z0656/B1p3dPiHkhmn19Cr3h5Bq7Qwa0R88A2iWfOYbkxRW1fT2WmTFdluRtRqMQGNZVQuqRN/CDF0Pv/LRf/vMN/vUWMULGzjzrAiwpPw3bDchDZRJzO6XEAGN0XT6u5E8So7ZqRmblQcwp3yEnNgViMnlqxCwtQQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16963C4CEC3;
	Fri, 18 Oct 2024 20:07:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t1tGQ-00000004Ewc-2vfJ;
	Fri, 18 Oct 2024 16:07:58 -0400
Message-ID: <20241018200746.849970367@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 18 Oct 2024 16:07:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] ring-buffer: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: 70c765743423ea51af71865aeb4530bcdf892300


Julia Lawall (1):
      ring-buffer: Reorganize kerneldoc parameter names

Petr Pavlu (1):
      ring-buffer: Limit time with disabled interrupts in rb_check_pages()

Thorsten Blum (1):
      ring-buffer: Use str_low_high() helper in ring_buffer_producer()

----
 kernel/trace/ring_buffer.c           | 99 ++++++++++++++++++++++++++----------
 kernel/trace/ring_buffer_benchmark.c |  4 +-
 2 files changed, 75 insertions(+), 28 deletions(-)

