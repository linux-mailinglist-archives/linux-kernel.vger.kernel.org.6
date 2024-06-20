Return-Path: <linux-kernel+bounces-222360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98E0910051
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8992840F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F150C1A4F19;
	Thu, 20 Jun 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UecRRRRo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3141A4F04
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875643; cv=none; b=FSjKgaAjEtTmOXfhtaZcOcd5pQ+QsQNHGadnGjMkIjS4aznOr9zHJkqmfX88hXWQIsAHV4OJ2qc2PEFejW6SoptrBAwS2o9/HejrlTQNXPh60539EiWrri3VYIP5yxJMelC4YYdYexlbSSMezV+3RpTB34H0laZv0lhQ7Y8eu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875643; c=relaxed/simple;
	bh=bCHCLMYOaomOQpn263u5xjMYWxTXqR46pUfCRYFERUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ke8rBogWwsmT8fBZbaVnkKF2OzB0vJECXsIWtIv0KREEj09yEFtAIQBSnI8OWOcVrUtZqDxefls5z0KjtKBHTCB9QDal/LBQ/GXomZbN/qeusH30SQCPp1U0hIlb+CojBYyAo9Ti++ik1l5S/8uIh6MzeMTi5waZwTufxcWLAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UecRRRRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E8DC4AF07;
	Thu, 20 Jun 2024 09:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718875642;
	bh=bCHCLMYOaomOQpn263u5xjMYWxTXqR46pUfCRYFERUo=;
	h=Date:From:To:Cc:Subject:From;
	b=UecRRRRodgp++UZYOO/JOcS0Qkflc+g194DHdgUOaWgfk5FNoAEgju1stZLycScP7
	 Mz6IYBeWrA8VruCHureT39K3DnTExBwCbRY62r7x7TjerQrGghYKDFsnZwRHTNE1vm
	 ecqQTvept11n1PfpgNbl1l5k9fIqK1mUe1h5eEGE9U0xS1QI5J1CGPPyjMv96NK+GA
	 VNxZOVUYvJcDCAYhKu6LHj12mnUk0cd8yJu51AGrm82Sm9mQCpAuO3IGH+CoTp1H3l
	 QARzaaTdZ+n7VgPt3qbfaHHOT1V3EkBbA1GV64DZ8IxhB5FPTokcI94nNNMUThOzIe
	 SmhbKajBZaBbA==
Date: Thu, 20 Jun 2024 10:27:19 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD fixes for v6.10 
Message-ID: <20240620092719.GF3029315@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good morning Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/mfd tags/mfd-fixes-6.10

for you to fetch changes up to 68f860426d500cfb697b505799244c7dfff604b1:

  mfd: axp20x: AXP717: Fix missing IRQ status registers range (2024-06-14 08:43:39 +0100)

----------------------------------------------------------------
 - Bug Fixes
   - Fix AXP717 PMIC probe and by extension it's consumers

----------------------------------------------------------------
Andre Przywara (1):
      mfd: axp20x: AXP717: Fix missing IRQ status registers range

 drivers/mfd/axp20x.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Lee Jones [李琼斯]

