Return-Path: <linux-kernel+bounces-251866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1456930AD1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2AF1C20F3A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F3913B59C;
	Sun, 14 Jul 2024 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsHNIYVX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078DBA2B;
	Sun, 14 Jul 2024 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720975029; cv=none; b=L9nKncOl8MyJS37yjUgf+WP9JfIrU3jlDY/XVK4oZ02d7xwiqkCG2W2ZS3f/w/qCvG5qN1u/ZOQ3SQ69FOsNwqvfmKZlRT5PTWEi42Q0e00+Bs908dBvswpmU6/CaHRWvzkko04bPf2FIE8QIJuY1xdvc3m2VDxJsKeQ+i/8iVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720975029; c=relaxed/simple;
	bh=iFb7WkHEuYBTrq9bZxmOdwzULAlpIBozkhsDRHg4v7E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aj3VuEkVHeFVFmMZ4xEyczn44+D5LmlMPhFbCosLCGTH2loxNV3eo1CcAFTwRHO2DhbReB4Xw3kpIqgQwLsV9sFfpOefT2J1byOqkjlbJHFeU/zI4y/brZgqYE1U2Pwje2jPEkCqivtbFYiKlhWhVWDu9cIHlS7KofZGX5HpseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsHNIYVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB889C116B1;
	Sun, 14 Jul 2024 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720975029;
	bh=iFb7WkHEuYBTrq9bZxmOdwzULAlpIBozkhsDRHg4v7E=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=dsHNIYVXU2PLGGT4szYu+i+TUeqaeO0IdFMKbVh5OtY9B1Q7lKqkdIROl8NlS2tNN
	 vmfnbCPFf4nTwvDxTjq8Xd80F+ZMm0lR86TB9BHGWFg2d2SEDhYjE7TGwkbws40+WW
	 f90YPNSUmNabWn+8DKYnJGySq1SdTdV3W8JmQfG+zdI37pQQ6ZyaD7SqjfPL/JbERu
	 MzooPDbg0qSG374IrvEeuGdNlGUgXvR94q/QxTg/OrhqRzdX7Uz4TAWo1QhhZo4X1l
	 eZV0JI1u3nruCQadOQqsBzGkOdkvaMgPZaLePtmNMG4JqFqKnhUk6hqb4PaQcZYm7D
	 o01d1C70lrpig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D4F0CE0B34; Sun, 14 Jul 2024 09:37:08 -0700 (PDT)
Date: Sun, 14 Jul 2024 09:37:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, kernel-team@meta.com
Subject: [GIT PULL] Generic torture-test changes for v6.11
Message-ID: <181de733-a175-41d8-8f83-6c4597723099@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

When the merge window opens, please pull this generic torture-test
update from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/torture.2024.07.12a
  # HEAD: d4641fa67d3dcc24d108cbfc4e47d0312ef49947: scftorture: Make torture_type static (2024-05-30 15:31:51 -0700)

----------------------------------------------------------------
Torture-test updates for v6.11

This pull request adds MODULE_DESCRIPTION() to torture.c, locktorture.c,
and scftorture.c, and also adds static to a global variable that is used
only in scftorture.c.

----------------------------------------------------------------
Jeff Johnson (4):
      torture: Add MODULE_DESCRIPTION()
      locktorture: Add MODULE_DESCRIPTION()
      scftorture: Add MODULE_DESCRIPTION()
      scftorture: Make torture_type static

 kernel/locking/locktorture.c | 1 +
 kernel/scftorture.c          | 3 ++-
 kernel/torture.c             | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

