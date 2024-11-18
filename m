Return-Path: <linux-kernel+bounces-413344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0749D17BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652011F210A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B731DE4F4;
	Mon, 18 Nov 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrdw2N5g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55B1AE01D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953437; cv=none; b=sKXdfQfmT+gTUmxxn65IDi/T4URMQ6nl7M9vy2LMjUkn/z5zMgZB/syA1rjo9ARaZjA7U8g5KkRp3c1S55SOFJX7lSC+Lpp0xOJfxwtESQHYQNIWs/xv9L/ELEwNgvQl6Cp+0xJdIL5W/7z60cPGyTiY3g8H3XSoRM9K7TvflOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953437; c=relaxed/simple;
	bh=1LD1OjvX7MvGySu3HX8WI19LSyFazrCL61ZaCKX7ZcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ml0xpkFPMHYxivb4U5G3fQDBmI0RRVH10NehNZzeA2QDbh6W0f/ImhQOtNSV2JT9RUA/e9OBTIBWdludG3vmnb8uFTiTgpqc4hAsxirEzqr9xEtmwDu8q8KfMb4lPbPhZZkEmKUYh+M1gmH6554fFlJuYkTzkvBy3VF6UKGYlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrdw2N5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F70C4CECC;
	Mon, 18 Nov 2024 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731953436;
	bh=1LD1OjvX7MvGySu3HX8WI19LSyFazrCL61ZaCKX7ZcU=;
	h=Date:From:To:Cc:Subject:From;
	b=nrdw2N5gJvOmTtVxzxgUsQpZWYtz3JG8iDTFxxo5aa2rs0ZTd7tQPBpDzKGyLyjOD
	 rYP0ZVRZnEwYtChmqvhMNieULw1VLYNoGeBGJDPM9JCC09+lNUcux5+kFVrIMq0k4N
	 QHba+bnQ4yHix5XK4uTTcU/5ASiznywYl2GtL/nDmRGJLAyQ1b8S/51fALOZRkkbsF
	 LMPCiluRQqqP/uSe0SmuZXOqXR4PNlMZgA/NsEheNRG6K8AzRrTU8xaDDhgiGeBTLl
	 RqXJCwbPIh8O1Pd7zbYkLtVl+6mMfX1HXNm/Am4yvsibjIKV3m4FSjACTb+OBk3Kyu
	 mxzXgFZsCef3g==
Date: Mon, 18 Nov 2024 19:10:32 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] x86/mm changes for v6.13
Message-ID: <ZzuDGEhcbe3slIgt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/mm Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2024-11-18

   # HEAD: 7e33001b8b9a78062679e0fdf5b0842a49063135 x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM

x86/mm changes for v6.13:

 - x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off()
               under CONFIG_DEBUG_VM, to micro-optimize the context-switching
	       code (Rik van Riel)

 - x86/mm/doc: Add missing details in virtual memory layout (Kirill A. Shutemov)

 Thanks,

	Ingo

------------------>
Kirill A. Shutemov (1):
      x86/mm/doc: Add missing details in virtual memory layout

Rik van Riel (1):
      x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM


 Documentation/arch/x86/x86_64/mm.rst | 35 +++++++++++++++++++++++++++++------
 arch/x86/mm/tlb.c                    |  2 +-
 2 files changed, 30 insertions(+), 7 deletions(-)

