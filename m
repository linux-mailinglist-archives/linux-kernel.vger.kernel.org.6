Return-Path: <linux-kernel+bounces-534945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ABAA46D04
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB83F16AADF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B142580F4;
	Wed, 26 Feb 2025 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUaeggpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A540C257438
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603988; cv=none; b=BHVhSUbTGDrCE2TizyOXC9LqIKO7/zoTESgxdg29AvpsMPM9aqEc1TCg+baG6mA6t5NdjBvWQicAcN3+HEfcaroDkDgJvsnfJVaQAmnu6wQ1Yd3sdcthNfnq7DPelHFNRUPbNpth3NR/wTdrKs6Upc0reYNwo4MKo0oUGY9dAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603988; c=relaxed/simple;
	bh=OY0R6TB/YAUNTM8oXzCwIx4EXx91/mW7qmFjSwpy+Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJL8Qpz/kw7e7kSTlqX8YDaB4fkwrs9cnE1qTvuPTFLGqiwYSUYCOlcs3ZVEkMQCpzbUQQKq3ByWLDtMAhEHnpMjFupguxfiYc9xFWTGK3JZZoPTW6/Re309jiyulbo98AJMpuXGPbubHjUqe9tz6nKOHdSn5Jv3C7FpXuivcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUaeggpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03914C4CED6;
	Wed, 26 Feb 2025 21:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740603988;
	bh=OY0R6TB/YAUNTM8oXzCwIx4EXx91/mW7qmFjSwpy+Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUaeggplRN73gujmJ+aYm7TxroKEhHFMccQmY0E02PfsP4Th6r+XdcMrOENpWbv9k
	 vnhG/w7eB1ysvQaYsX+DyJCOfqMB9DIGvEh+xFJuQwyC/+EjiVTs55Tw9H/0PlMClQ
	 ufXu98eoZ0G2ANpnozQ4JsrVuPRO/npKK53ITPzH/FROs2s60UurB1pze8NnrbzWnT
	 vmp7b5z1b8Zduk5Nzqqq7Q/NVz3+JKsKsIq04rFJZkG57zqw1yVEKgo5rbfVHvzx2f
	 PLoQvhhq8ksLEdqmzEVp2NvM1A2NWqO1Nayzq5OPWVmszcTQ8YnhGr6OOUta+wwkyJ
	 QGeBdLDg7Vf3g==
Date: Wed, 26 Feb 2025 11:06:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL RESEND] workqueue: An update for v6.14-rc4
Message-ID: <Z7-CUy6lWSMfuDeA@slm.duckdns.org>
References: <Z7-B4sePVIfNpjUH@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7-B4sePVIfNpjUH@slm.duckdns.org>

(sorry, sent out the previous one a bit too soon)

The following changes since commit e76946110137703c16423baf6ee177b751a34b7e:

  workqueue: Put the pwq after detaching the rescuer from the pool (2025-01-24 09:29:46 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.14-rc4-fixes

for you to fetch changes up to 8221fd1a73044adef712a5c9346a23c2447f629c:

  workqueue: Log additional details when rejecting work (2025-02-14 07:16:33 -1000)

----------------------------------------------------------------
workqueue: An update for v6.14-rc4

This contains a patch improve debug visibility. While it isn't a fix, the
change carries virtually no risk and makes it substantially easier to chase
down a class of problems.

----------------------------------------------------------------
Will Deacon (1):
      workqueue: Log additional details when rejecting work

 kernel/workqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
tejun

