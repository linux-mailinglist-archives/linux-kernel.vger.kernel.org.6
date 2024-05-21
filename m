Return-Path: <linux-kernel+bounces-184470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B968CA722
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D56F4B21289
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA8208B8;
	Tue, 21 May 2024 03:46:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D71DDD7;
	Tue, 21 May 2024 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716263212; cv=none; b=DWPKhl60/dKES0/EaE1tZN84PTSrz1Lk0m9egqPm6eptL6gHjjta1myy7DuHnIoZePmzE1FiT/HbLpngE5ly8pQsLJvj4HqOesO+4tMBAW91oeuAT13mOEMvaCsQYNL5k4Wgj/v8kLRkU2/OA++PZsnFQ+khvmF4BWXWQ9wv1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716263212; c=relaxed/simple;
	bh=q8WU/bvou9Lhzlp/nXStXTEwRfxjVi3eMBqbzw9+ltg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=DX/nLkX1WqqSQv3s8kWiNU7rlV+mEOOmTb9gqndRBw1Fx6ii2Oe+cjeRupeRtSCFp9WfXrEJ7Xe53/oV8sTwckX6zFpjZe1X4w25BTgIW5qoc122gv9UX84/CsvRpqJ5T7XeEiY04J3kcwxvmyj5vGV9jPmdGaGY7Y0pX8pJMUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB71DC32782;
	Tue, 21 May 2024 03:46:50 +0000 (UTC)
Message-ID: <f797b514-239b-43a8-8ad3-7fa67ebdcb28@linux-m68k.org>
Date: Tue, 21 May 2024 13:46:48 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v6.10
To: torvalds@linux-foundation.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux/m68k <linux-m68k@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the m68knommu git tree changes for v6.10.

Only a single change, to remove the use of a kernel config option
from a m68k specific uapi header.

Regards
Greg




The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

   Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.10

for you to fetch changes up to a5044ce7d1d94cd37be99e86964aa054f7e5564c:

   m68k: Avoid CONFIG_COLDFIRE switch in uapi header (2024-05-07 08:55:23 +1000)

----------------------------------------------------------------
m68knommu: updates and fixes for v6.10

 remove use of kernel config option from uapi header

----------------------------------------------------------------
Thomas Huth (1):
       m68k: Avoid CONFIG_COLDFIRE switch in uapi header

  arch/m68k/include/uapi/asm/ptrace.h | 2 +-
  scripts/headers_install.sh          | 1 -
  2 files changed, 1 insertion(+), 2 deletions(-)

