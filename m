Return-Path: <linux-kernel+bounces-570069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5198A6ABA8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799343BD332
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D9214A7B;
	Thu, 20 Mar 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY5NIcMB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0446188915
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490227; cv=none; b=aey0fWmSOpnBDmofEVOh+XJ8J6VMlI8+TIA50g+Dx4mQ47SbDI7GYwHodxZs/xqC0vwWHMCUX6voSlt6V7zvnGlVB8FoVotA//E/0x/edoi0J9ULxQWXkrYtSVb85vHqGnt9n90xuIBwBUCpUUQTZ3RtPxJvnsNN7TjsOqXBxsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490227; c=relaxed/simple;
	bh=NH78KvajLuHgdDKazPKhm9IM/MqinrVmf3ntVM3CEFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KGDe5+JhS1mNAAZ3QHsZ9daW7SZwfDn+Tij9EjctFqwjGpAWeDBfyHBejmgrrYWz0pRUU1/8NPTgyK+FRFG65RHex5DG36TxC2OFM9fNjVoWkPLrjfteyDtI94KfXLPUSQtIXW/v/IjGbEIC/X5YjdP6l5LEAjjrgHr4L9bLfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY5NIcMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DF0C4CEDD;
	Thu, 20 Mar 2025 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742490226;
	bh=NH78KvajLuHgdDKazPKhm9IM/MqinrVmf3ntVM3CEFE=;
	h=Date:From:To:Cc:Subject:From;
	b=NY5NIcMBpzyM3ZHZWTYNJWaKGfykc7dZcTKQcQtatbtanb4zH/zt6KS9Pty/Yerfn
	 Wg0X6lmQRrPDqnnRZ8PWHoKAAwVeN1v7csYi2OiQt2DG1zJ2IjI2b6RfYdPqa2zkEf
	 ExjTCv9KTBBpyQXBmL7SVgbkBjgzztAacOjw/5uwOV4iflc/hKjIBfiYHKxCo1TIF+
	 XeRZfW+fP+gSlonIlmul04rn4FiHPdRdDCD8QTq5pdEcezUkRv+CFvpcu6AfXkkP6R
	 w8ZSQ+zFTE7auRSPLJbFxj71FcrPzwhWfMOD4mcrMEVaMvPZl/l4pk6/1/HoxRcJM7
	 AvuPJPYGE0FXQ==
Date: Thu, 20 Mar 2025 07:03:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue: Changes for v6.15
Message-ID: <Z9xKcaAZyIwL6FYl@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.15

for you to fetch changes up to 769a72d0bf80892581366082124e9d15b2dd6b08:

  rust: workqueue: define built-in bh queues (2025-02-24 08:13:41 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.15

Just one commit to expose system BH workqueues to rust.

----------------------------------------------------------------
Hamza Mahfooz (1):
      rust: workqueue: define built-in bh queues

 rust/kernel/workqueue.rs | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
tejun

