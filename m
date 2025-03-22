Return-Path: <linux-kernel+bounces-572406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF694A6CA09
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3427017E7D9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135BF1FBE9B;
	Sat, 22 Mar 2025 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7sf2d8I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB23C0B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742645306; cv=none; b=U8Ju5rwRfwqIrLwVVlQEpSODEj4OrV7xH2B/4IqBkcC1aTprUn6c//PSA5lAhLEg2pysz031ijG29xiZghvs+WoJwNn/BH4+LgsgJqdSjFxQ0L9YfPo8j70G4k2JKiPl02xrzDslz7KFk7nIIQu4Urry+3mpi7sRyoJXo/qJEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742645306; c=relaxed/simple;
	bh=VRdik6byE6UxEH0UglQwUPWxDta3cEIwbig8OpMZUtM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LI4gmAX6trLjWAJ1yLx0Sb6x5/HuLzg+QTbU0Lbv68aXz6gNDpud3u+TGdGY5NjCpcaMGyzZ7aejo+nfJ1BUTvChkzUt4gC2k9x5WrQqCSiLo0LEUYoUfnf9VKZ6jPDiFcI9WeaRdEljHPGqqHGhp5ARjUKATuH41xy3t5ZOOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7sf2d8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2997C4CEDD;
	Sat, 22 Mar 2025 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742645305;
	bh=VRdik6byE6UxEH0UglQwUPWxDta3cEIwbig8OpMZUtM=;
	h=Date:From:To:Cc:Subject:From;
	b=f7sf2d8IBdmfUa+qeee0d/sDcj82Wc/QX0apECfHZJljNLzmzT1IEjmRWkIrnYMfE
	 cEDtJmtuNJBXJ7VHjHHfQej9WAOfH5+68/HVcnKOvxTjOyZ1TjbzmvuEc74IIQrxeC
	 ivuJkkmstYTFRiJ5UwV8aXB+yIROAvwXWGpo0J+/rpQJAi3aQE5L9bBkXg3pogECHJ
	 vaboP4QGPiLjHp8ixRsBqUnjUxE4G3WOMf0KjvIM412X+EZTS6CfV9CNUpDyVaKgtD
	 9z0nVaiH/hOltpQOJlYLli5ROTPhunJyIG9hQawWDWvvJjZEU7i7EHTDmLgiTAdxBK
	 JaYz6nnOaNawQ==
Date: Sat, 22 Mar 2025 13:08:22 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/sev updates for v6.15
Message-ID: <Z96oNui7G1OTIyLg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/sev Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-sev-2025-03-22

   # HEAD: f0373cc0907ca7918266a507d6b3b5d75ee839ba x86/sev: Simplify the code by removing unnecessary 'else' statement

x86/sev updates for v6.15:

 - Improve sme_enable() PIC build robustness (Kevin Loughlin)
 - Simplify vc_handle_msr() a bit (Peng Hao)

 Thanks,

	Ingo

------------------>
Kevin Loughlin (1):
      x86/sev: Add missing RIP_REL_REF() invocations during sme_enable()

Peng Hao (1):
      x86/sev: Simplify the code by removing unnecessary 'else' statement


 arch/x86/coco/sev/core.c           | 3 +--
 arch/x86/mm/mem_encrypt_identity.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

