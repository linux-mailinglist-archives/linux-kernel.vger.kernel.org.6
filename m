Return-Path: <linux-kernel+bounces-336539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C624C983C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029071C22605
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73A3EA9A;
	Tue, 24 Sep 2024 04:44:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EEF347C7;
	Tue, 24 Sep 2024 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727153062; cv=none; b=oZQ/y3ckQEyOcaIaarOZumRBNVHGetNkCJuJqOMUJv/trUqP92eZ2wB7rDNSbaDkM5wtxhLinooS5mcBB4mJCn2M/PKniOmRc89rX/HyRLYkAFki9vY7BF2/w3yu4sY9gEyTrc5brLThymAZ9/JQM30moWGd1SoqnjueBZODljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727153062; c=relaxed/simple;
	bh=g2mPIipiJlH4tYYn+yl6Vjn4Dkwd+g5d/jiNPSYfRDU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=pi+39PKBoeMnBpB3xGWgZFSZs92+JrVQsYeQ9pHXYrWbIKf9X8L6D1QhkRH4Q1PoIocclK1Tc5H6sdc6W7xVt9IETSSptBhVmy2eepMN8qkP06UoUeGJWpy9RBFe6T+6Dt3gHOekVGcZGxlV82tzxYFUJNGaTiznUYoUR1WNTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E45CC4CEC6;
	Tue, 24 Sep 2024 04:44:20 +0000 (UTC)
Message-ID: <f9dfef64-a4fe-406c-9daf-1bf46cd23d65@linux-m68k.org>
Date: Tue, 24 Sep 2024 14:44:18 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v6.12
To: torvalds@linux-foundation.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux/m68k <linux-m68k@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the m68knommu git tree changes for v6.12.

Only a single change, cleaning up white space in debug message.

Regards
Greg




The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b63:

   Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.12

for you to fetch changes up to aa99969ef591ca44cbafb320ceceb106792baee3:

   m68k: remove trailing space after \n newline (2024-09-09 08:33:35 +1000)

----------------------------------------------------------------
m68knommu: updates and fixes for v6.12

Fixes include:
. remove trailing space in pr_debug message

----------------------------------------------------------------
Colin Ian King (1):
       m68k: remove trailing space after \n newline

  arch/m68k/kernel/setup_no.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

