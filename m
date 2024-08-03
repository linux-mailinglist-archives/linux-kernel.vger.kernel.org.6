Return-Path: <linux-kernel+bounces-273385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2DC9468A1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC12F1C20C66
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 08:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D624514D718;
	Sat,  3 Aug 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="ebbxUNfa"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAA17173C;
	Sat,  3 Aug 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722672654; cv=none; b=V3IplkhS2UUUdycGb1xLQTK9FI63HGrCNEwIzVDVHOtno4H7p5h+KruR0NOZSp8BhG/gbGZCDgtCCR3Lu6k4oWOM7OtYCvW+NaUbb0/ScvhDY9ELTcy0VVUNLHMmXesPf3t/Z0RgatRTw6U58nEEfMZ7e4v5eYl0DU+4mU0eVb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722672654; c=relaxed/simple;
	bh=FkcYtlmddf6NYrg57vXu2fJt6dx+Qgx7jkxyhH9TrXk=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=CO/kRFDNFqYHrVUnRsUEh1AedtZdahuACyIiudYXoGEbEmSuopsQbEtHrwIOBN6RWtNwPHk4JJDYz4QeexLSSSvn0HpPsO5V+l4rxJuyoB9yYUU+7T1wpPKdVSpfmVYz58T0gMrgklvntJ79/GQCD9azc5r+9bIuApSYguZDjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=ebbxUNfa; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722672649; x=1723277449; i=deller@gmx.de;
	bh=Qa5vx4DnbC6bBFNxo53rhlDyVa7w+bnw/DeUS+ya9q4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:
	 References:To:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ebbxUNfaRhICY/6l9lUgF+oKXIPlPkPJBvtXXCcLlvofMBsHMKvNvIqBIeFAsVc7
	 so26zcuHzKo1N+OlaiATdhCQlB9+XrvpnmZQL1ZxXc4k98KSKWNyAZsrfJPa3YRv4
	 KupffH0l3ZezoPOo5o8ZexGIKjyTq/BtVSLZdY0aqJQ43rAFmXToQz3TFMtb7PFzf
	 KeUm1cZH477B7uSOUoGPmvvS7GOtrK84SbZyihjmxPeTINWn82Q0LnSSIbwbojsXr
	 8kHuE9YMe+b9uAQsrKPvBocbr6iGgObz8NvY+adnGwiTmpmePTa5/5xmyZT7CAXJf
	 GhqMt46fnHk81Pk/aQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.33]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1shkaL11tM-00JlrP; Sat, 03
 Aug 2024 10:10:49 +0200
Message-ID: <7ab022d9-c1f3-446f-b27e-1d95f725e75b@gmx.de>
Date: Sat, 3 Aug 2024 10:10:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GIT PULL] parisc architecture fixes for v6.11-rc2
References: <Zq1B366giNrrbU3W@p100>
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>,
 linux-parisc <linux-parisc@vger.kernel.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <Zq1B366giNrrbU3W@p100>
X-Forwarded-Message-Id: <Zq1B366giNrrbU3W@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kOrloD4yD2JadP+FAQ2mI3YZm6/O67E2hwxwoxEh4a/nZDyPlKb
 Pudiwhj4YCvI3x0VE2bXctjqqnMsDQKyStqWO8d7geDEYIVj0rFGJSdWxL8lPWJPq17y72S
 FddRbc0LMp0SQ5kAP/tRLa3fukevniw7Ag8Z+VlddtzgElEKzEJTSAfSntNAD811A69mYNR
 eF+2Ltphz1fo5639ofR5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mcKuhzmrkeg=;UNJG7B4wcl6+EqLP3xD3sTizvOo
 bMwHa6rigyDmpbIBVaN4lquSxXbP/9krkC0KkorsbFaowAdLLAZ7IVXHdSTVg3I6SAqM8K3vJ
 xKiWjBfesgsFBmih3w4kwEF8fp5iYW/T6/t0DOwvvLi8kawi6a67QGLjlLXRV9GR8qiY1n77S
 rAOQRliAhMLHVjCm3CqgdEHCOW4Ulji7rbThHxHaOujmsMIDTKtKJxYQb0iyY814wri8AAxV1
 ppiMdyZbx/FZPGdTNQNWiFwQ66c/M6RU5Opg/TzK/2uMLIlNETpDbwunHnoT/o1XVa2emR05E
 +HjQZMA5iPoGuDxQFRAk6YB2/Hx8jVYa9tz+elteJ7G/nrVu8kLzO4dMQkswoC2ewswuAooH5
 9t1LeLtiiK0lqaN/RM27kbdPmIJyA52pccV9MYcieE2b+7C82oWNiUOzGI+KnL/zve6sASGab
 TdWMUO/6KbsHZNUhrZaeGfO0ij9CPYFwQEh9FgD+K8jhhrxcm8fWM/gKTq/VLm/NCMaDMgsg2
 vtUH/gsatNCzrIqcTd07afKYD6DmkBAEM9bjwrcWFSU0+r8PixAfmniPMRoPAhelUGs4mfWi+
 2v19IO4N6FuOr+B8a1ls51jR8OCdiM9qPprZrJmtl9Opx30qfhlSJcqHq9RgFHdOb+Lb4jRM7
 LPLSeXQxZftpY51HX/CwmPKjbYvl4YRMl35g6xV2PyQB79SEvw6p8JBxSmKIfmQsTkXQD0xPF
 M1qPecUM7SZuRZrPdeta7vSxcFJe4zNF3ULxET/VEtZKzyId44h7X1eKsGklXH52P1jY3a1iZ
 eeJBBj1GfRdE+G6xunIC1dig==

Hi Linus,

Please pull to receive two fixes from Mikulas Patocka for the parisc architecture for 6.11-rc2.

The fixes avoid unaligned memory access warnings when calling BPF functions
and fix possible DMA corruptions.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.11-rc2

for you to fetch changes up to 7ae04ba36b381bffe2471eff3a93edced843240f:

   parisc: fix a possible DMA corruption (2024-07-29 16:19:07 +0200)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.11-rc2:

- fix unaligned memory accesses when calling BPF functions
- adjust memory size constants to fix possible DMA corruptions

----------------------------------------------------------------
Mikulas Patocka (2):
       parisc: fix unaligned accesses in BPF
       parisc: fix a possible DMA corruption

  arch/parisc/Kconfig             |  1 +
  arch/parisc/include/asm/cache.h | 11 ++++++++++-
  arch/parisc/net/bpf_jit_core.c  |  2 +-
  3 files changed, 12 insertions(+), 2 deletions(-)

