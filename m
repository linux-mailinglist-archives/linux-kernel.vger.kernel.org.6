Return-Path: <linux-kernel+bounces-572397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621CFA6C9F2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C278B3BDCFC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3F1FCF62;
	Sat, 22 Mar 2025 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdx6jGj4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F141D5165
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742643975; cv=none; b=t5y4k8v29aApvP+Td1z/4vBPOIyVq8QEMfAp+BHCJ6GIDBPELmiVqZnXVltj16cnOzH99rrD4n9PHHDKhYMNpq9g8IOixEcssC6S1UwDPWOKWjcdYff9l7Fv5Rg6t59bSMZvdGND5IJ2K7BCnv0mDmyLokbxL1Tk0u+JlC8GVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742643975; c=relaxed/simple;
	bh=YyderJ6EITbepArlmJ509aj1ic1BWBOtbNMclChs2Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UCzACbr5616ogiHKULRvkHXuvhNOfVupEqxwLimNL+xUcNj7uwsgxy9es2fjuW+ko0QbxRkrSf7xZlPB2fkpn8EfPHMIOw6Vq8G20VPYOWDnpd1LNYtXkv1M+TYXUO/Nsw8EFAP7STsdvYAD7zt/yDKykBbwIDFO6uvkNd9n1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdx6jGj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EBCC4CEDD;
	Sat, 22 Mar 2025 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742643973;
	bh=YyderJ6EITbepArlmJ509aj1ic1BWBOtbNMclChs2Jw=;
	h=Date:From:To:Cc:Subject:From;
	b=bdx6jGj4hNSs+FZ4jaU7aViOIymLL0wG5lAMp94eN6cYs/VVAHEgS2SJa+JXo6seM
	 k+d5ZHcDVeDXExyY8TaV7whM8Y9AjtA3lve6Ld3FiIX1Pp8dcCPziez+51jjwkHt9Z
	 8zYVB7nCxRMm4QvbynL/fJbU+bdPEh5jW25eWiLx96SKiTbmb8wNf6nOB5Or9OhwLG
	 0Bp5om5SJtqUk/Vv1LZ5kIWe4+O62D6w+eXqaqyWK0Wn6HErQukz8blIlf4vzihuLr
	 AqbCTi/LyXKlSApUl/6nWTUq6ZR3VXXOZxFdhnFurQgkvK7QrKBgYYuMEAnYOMVbVV
	 0lRjc6vhUXQpA==
Date: Sat, 22 Mar 2025 12:46:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/build updates for v6.15
Message-ID: <Z96jAWGvYzZOM6O4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/build Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2025-03-22

   # HEAD: e471a86a8c523eccdfd1c4745ed7ac7cbdcc1f3f x86/boot: Add back some padding for the CRC-32 checksum

x86/build updates for v6.15:

 - Drop CRC-32 checksum and the build tool that generates it
   (Ard Biesheuvel)

 - Fix broken copy command in genimage.sh when making isoimage
   (Nir Lichtman)

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (2):
      x86/boot: Drop CRC-32 checksum and the build tool that generates it
      x86/boot: Add back some padding for the CRC-32 checksum

Nir Lichtman (1):
      x86/build: Fix broken copy command in genimage.sh when making isoimage


 Documentation/arch/x86/boot.rst        |  10 --
 arch/x86/boot/Makefile                 |   7 +-
 arch/x86/boot/compressed/vmlinux.lds.S |   2 +-
 arch/x86/boot/genimage.sh              |   5 +-
 arch/x86/boot/setup.ld                 |   2 +
 arch/x86/boot/tools/.gitignore         |   2 -
 arch/x86/boot/tools/build.c            | 247 ---------------------------------
 7 files changed, 9 insertions(+), 266 deletions(-)
 delete mode 100644 arch/x86/boot/tools/.gitignore
 delete mode 100644 arch/x86/boot/tools/build.c

