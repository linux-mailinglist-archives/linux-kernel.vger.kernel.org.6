Return-Path: <linux-kernel+bounces-421748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D25B9D8F84
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2096FB246E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 00:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0993C28FF;
	Tue, 26 Nov 2024 00:18:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E9161;
	Tue, 26 Nov 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732580285; cv=none; b=ZzeuGZfms+Ye9Cwv+8H+GzYkiBt6g89FzCP9KUoqP+Jk1DUTvPPHa4d2LkFzKd1LgnLEIMAngzzp/OP+yMWm6cKHa5suaG/Zma4cStKWJAJPsaWjDxfvRCDKtvjcl7p5F0uKPuM4U+BBXfzyiGW8JhhDoy6tKEiqg7HgSqslXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732580285; c=relaxed/simple;
	bh=XpZzREiabdDFApiaCmXV2f8tb3EWHvbIG0aZ+Ba+9Q8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=F2SinEcecaSvwmFGlDmpNMlqUvNNbsoLI/f9IjmpeWdh70Xy0/jVsW5LqlO4DsmiqS/AyDTi/76/ct7kyZ+FKblpVEUh3ZvQq77RLk5VAPAmNgFikI8VyCZ7mHr7ZcHwwYmJw0N0guNc5sLCXdQ2ddEfoHmZzJXMQmyksCJb6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDABC4CECE;
	Tue, 26 Nov 2024 00:18:03 +0000 (UTC)
Message-ID: <81259608-5796-41ab-9832-0c8312e05b46@linux-m68k.org>
Date: Tue, 26 Nov 2024 10:18:01 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v6.13
To: torvalds@linux-foundation.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux/m68k <linux-m68k@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the m68knommu git tree changes for v6.13.

A couple of small fixes. One to fix compilation when including the FEC driver
(for compile testing) but the specific hardware does not have the hardware module.
And another to fix a typo in the config name used in an ifdef.

Regards
Greg




The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:

   Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.13

for you to fetch changes up to 63a24cf8cc330e5a68ebd2e20ae200096974c475:

   m68k: coldfire/device.c: only build FEC when HW macros are defined (2024-11-11 08:57:01 +1000)

----------------------------------------------------------------
m68knommu: updates and fixes for v6.13

Fixes include:
. only include FEC platform entries when hardware supports it
. fix typo in ifdef config name

----------------------------------------------------------------
Antonio Quartulli (1):
       m68k: coldfire/device.c: only build FEC when HW macros are defined

Jean-Michel Hautbois (1):
       m68k: mcfgpio: Fix incorrect register offset for CONFIG_M5441x

  arch/m68k/coldfire/device.c     | 8 ++++----
  arch/m68k/include/asm/mcfgpio.h | 2 +-
  2 files changed, 5 insertions(+), 5 deletions(-)

