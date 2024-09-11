Return-Path: <linux-kernel+bounces-325354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F0D975865
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028C02824A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1631AED39;
	Wed, 11 Sep 2024 16:27:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CC8224CC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072074; cv=none; b=o024esWiof2t5ZZ5HjIinSj95XOUaVhTl2lVVe4QgD9niQ0mI+2DkAsyZ3uPrfZBUjuYfrrGfVlMWjBUz6CDK7ntgRrH+l7kKFbgcOtBi2HW7mmGsalgGZOsNVp4YAhOtt0E6sS6LpEj3BgqhVRD0C9LT1Ps+9Ef77cobxOtR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072074; c=relaxed/simple;
	bh=MwwTG81xidDegm3v33//o4xc0Hekl76Gv6L89kf8ubQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=iC1y/gWzTM4I6C57+qRLjzXyTs8LQJe56PqgPzPcwQgfOF3yn5tSAr0dCC0TwWzOa5ndUL2t8TifEVSSTBgOfbK1I0FbWoMQjRWST4UaX/viHlqHv9C3+t43JBxXYK64Tyk9Xtsa+SjHsLeczIpOCpS3vUDW3Lrd1Y321VvGaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02723C4CEC0;
	Wed, 11 Sep 2024 16:27:53 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1soQCD-00000000fa0-3f5Q;
	Wed, 11 Sep 2024 12:27:57 -0400
Message-ID: <20240911162729.318348827@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 11 Sep 2024 12:27:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] selftest/ring-buffer: Test updates for 6.12
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: 75d7ff9aa0ae1a8d1b3f9c8c87dde3a4fbe9a2cf


Vincent Donnefort (2):
      selftests/ring-buffer: Verify the entire meta-page padding
      selftests/ring-buffer: Handle meta-page bigger than the system

----
 tools/testing/selftests/ring-buffer/map_test.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

