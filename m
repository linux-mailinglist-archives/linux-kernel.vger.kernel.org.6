Return-Path: <linux-kernel+bounces-254159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545B932F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FA3282031
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7AA1A072A;
	Tue, 16 Jul 2024 18:03:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3611A01B3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152987; cv=none; b=moQY2pyqLtd3rijGBXhUoSYeP1IZQEU1b1TPfFpPBo6TsVTpFL9MGbd2V8VnV+7NDnZMjVVkR7Nataw58AKdV2HNxI2GCIcyNL0IN2/T0UP6iBuhhmTTfiQV6DP90RCkSggFSvGtZPi+YrPG/NJhq7I4ihn8P0VPFRYdnac+BN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152987; c=relaxed/simple;
	bh=PMSItOgaVO5uTOiyK4ac/g8IpH5aPjnsDZh3Bav6XtI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=RZwlKyyz+H//yTElfm5QcpXje3cNlt7XpD0U5DZ4zFDEFwA+rg6OJQ4dl1HDM8e1DbmMw/GBbnaNIEAChruJtFNA6hQkY2Pn481Ji2KIACQwzjb08ezrxyoXMm289LHRo1QMp0RKI0KZzdc/cm1E04X996SP4Y+TgsyigJuUmsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3C3C4AF0B;
	Tue, 16 Jul 2024 18:03:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sTmW0-000000006tn-2coB;
	Tue, 16 Jul 2024 14:03:04 -0400
Message-ID: <20240716180223.593493907@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 16 Jul 2024 14:02:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] ring-buffer: Last minute updates for 6.11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: b96c312551b241bc17226c5347c6d6b38a1efd3e


Dan Carpenter (1):
      tracing: Fix NULL vs IS_ERR() check in enable_instances()

Thorsten Blum (1):
      ring-buffer: Use vma_pages() helper function

----
 kernel/trace/ring_buffer.c | 8 ++++----
 kernel/trace/trace.c       | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

