Return-Path: <linux-kernel+bounces-375464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCDA9A963E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF1C1C22E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C873313AD2F;
	Tue, 22 Oct 2024 02:29:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879D1386B3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729564169; cv=none; b=RuF2S7O2qsIBVI2ad/mxp4Ldf6M1fYHMLvcWw/0VhlFW8hd5KEMP8eCO8W4Gf5yAibNNNmOISUMMarQPatUz2Jpu7pIGciZC7+2h6g+/7EyR1JpNxxaliU5Ks35/+gfSGimepm++KUmzBLux4WP0zqVHdvAE2F/dZwXOXiRQktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729564169; c=relaxed/simple;
	bh=bWdl/kUGb1bds9VCbnIoAmBO9LuBFWsH+21J/lcIY2c=;
	h=Message-ID:Date:From:To:Cc:Subject; b=VvkIoMxqRNyJtRidFa9bSixEXncgzI612h5U5l187oUP2CoVKTattK039X0z+Uehf2rCoRXWWnf7nPHYnEVsSO+UlpvqGNQeCCLQVINpUxAnLR26jgbdJJr4okPDkVbM6WmRoq23j7IvixxXon5MT8VlhdNd5+1r4FE/oiicqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C5BC4CEE6;
	Tue, 22 Oct 2024 02:29:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t34ep-00000004dxT-0XMB;
	Mon, 21 Oct 2024 22:30:03 -0400
Message-ID: <20241022022919.695045683@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 21 Oct 2024 22:29:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH v2 0/3] ring-buffer: Updates for 6.13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

I screwed up and tested and pushed the wrong branch to linux-next. This is
the correct branch (also tested).

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: 514da6924e8647eb89aa879e73a19eaed8bcf669


Julia Lawall (1):
      ring-buffer: Reorganize kerneldoc parameter names

Petr Pavlu (1):
      ring-buffer: Limit time with disabled interrupts in rb_check_pages()

Thorsten Blum (1):
      ring-buffer: Use str_low_high() helper in ring_buffer_producer()

----
 kernel/trace/ring_buffer.c           | 100 +++++++++++++++++++++++++----------
 kernel/trace/ring_buffer_benchmark.c |   4 +-
 2 files changed, 75 insertions(+), 29 deletions(-)

