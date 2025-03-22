Return-Path: <linux-kernel+bounces-572400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FD7A6C9FD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E579A882C79
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5121B9D5;
	Sat, 22 Mar 2025 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpP1mLtc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997FB1FC10F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742644219; cv=none; b=L/X5Pq6THzAas5jgiWxVNJM3XAq2viz6b7ZERuYGU5QwDIQrCPQDrdea5vZu3Fesir3200UOSJosI7xEzbD8aBjvDUKWENNgex2aaaiKKAK8Cts+2F8o9kJ3YJsmU4QB9l7lodD52IqwGDmEeC0rESs7RiWy5TWhOHuLl3aUhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742644219; c=relaxed/simple;
	bh=5K0i6pUYI725Vj79p5Hip9iPFXRRT4dUsWv1J2KuDEw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R5oRmS4wBns4mUj8zOggBj8JzsHxdQU/Yf3OVOZCj5hShB7bdDOKIs0s3d9KV7xCf26ddq0XZ9oMsCzGognp7gbZwc5e0K+H7oXV5RM/+oBr5Y6xQZVUfoD0h55iVM4UmAkRXIzopB2ngGzGWuZ73esEVYimtd5tj9YV5RhgFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpP1mLtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E8DC4CEDD;
	Sat, 22 Mar 2025 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742644219;
	bh=5K0i6pUYI725Vj79p5Hip9iPFXRRT4dUsWv1J2KuDEw=;
	h=Date:From:To:Cc:Subject:From;
	b=TpP1mLtcbvEJgMeZgBE7rTRwAySrI4QumMJO3i0L5I3g7ktW7K/UOZEchFBZan5wk
	 8wF2+5T/OCJ3CMM2vFOSspj64eie0mX1WdpnXuWGOsOb4L9baZCZdcvAMMc/E16nvB
	 nQVOXpGqUtdRfcQQVM2HQRrFPp+Kj8V5sDI4PS5oNNzp0kOA6S4jlW1/4h2zEiRzbh
	 MjOLw8ruw7Py1A5bbXHxXpFrl928KBXxBX0WizYdz75KASW9yn8vuPzST2EHOEn7wS
	 Id2OgO7E5R7vtTFNxRVn8kxfJ9CWYkx9zf1EXRIA2AdYnhDtDnFprAWUoJ36RFrGtq
	 o/IQorNOEwDrQ==
Date: Sat, 22 Mar 2025 12:50:15 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/cleanups for v6.15
Message-ID: <Z96j9-AVdkmXKnId@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/cleanups Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2025-03-22

   # HEAD: ec73859d76db768da97ee799a91eb9c7d28974fe x86/coco: Replace 'static const cc_mask' with the newly introduced cc_get_mask() function

Miscellaneous x86 cleanups by Arnd Bergmann, Charles Han,
Mirsad Todorovac, Randy Dunlap, Thorsten Blum and Zhang Kunbo.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      x86/coco: Replace 'static const cc_mask' with the newly introduced cc_get_mask() function

Charles Han (1):
      x86/delay: Fix inconsistent whitespace

Mirsad Todorovac (1):
      selftests/x86/syscall: Fix coccinelle WARNING recommending the use of ARRAY_SIZE()

Randy Dunlap (1):
      x86/usercopy: Fix kernel-doc func param name in clean_cache_range()'s description

Thorsten Blum (1):
      x86/apic: Use str_disabled_enabled() helper in print_ipi_mode()

Zhang Kunbo (2):
      x86/irq: Fix missing declaration of 'io_apic_irqs'
      x86/platform: Fix missing declaration of 'x86_apple_machine'


 arch/x86/include/asm/coco.h                     | 10 +++++++++-
 arch/x86/include/asm/pgtable_types.h            |  2 +-
 arch/x86/kernel/apic/ipi.c                      |  3 ++-
 arch/x86/kernel/i8259.c                         |  1 +
 arch/x86/kernel/quirks.c                        |  2 ++
 arch/x86/lib/delay.c                            |  2 +-
 arch/x86/lib/usercopy_64.c                      |  2 +-
 tools/testing/selftests/x86/syscall_numbering.c |  3 ++-
 8 files changed, 19 insertions(+), 6 deletions(-)

