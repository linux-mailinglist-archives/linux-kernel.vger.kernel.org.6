Return-Path: <linux-kernel+bounces-564568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7656DA65791
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5263418850BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D81918EFD4;
	Mon, 17 Mar 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVerRWSJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E318CC10
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227598; cv=none; b=CtH05ph4ThHr/ZKEb6gvm48NLOpzQbVaYkCRv0o+bZplBVmWH80AFFl7T5TxPdwDSc/88nAOo4UM1VMc1D+1wZhx+CjDZsFT+ogwuH18KrDP1EHO96L/QkICtIfIVi+D/kgekb/jEwkLS3arm5OUYfsrMhqNpp4slN48NlOt3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227598; c=relaxed/simple;
	bh=sch0zu2Oe5VOm/n3vXJwoWUqrU9BrF4iqAlInolTg+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DBEapsPrsOaWzDDCeCvzYoX8NNgSbUfyGhzQSNTf++ldVJ9aYpcDjzVmsjQDVRHse+h9+wTNlZdcJw22EE75KQWASJSiFjopsuVuuzHIacA5ypiU84CX8BZP/B+0YUEslEuFRll7DsFl+y+c1wjPrQZZ6DzUve45gL6H49gT7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVerRWSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591FCC4CEE3;
	Mon, 17 Mar 2025 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742227598;
	bh=sch0zu2Oe5VOm/n3vXJwoWUqrU9BrF4iqAlInolTg+A=;
	h=Date:From:To:Cc:Subject:From;
	b=KVerRWSJ82hNs5YXo7ZzBCRSeDiCSemvOlb+2v/a33P7PefRFe97Erpj1P3H9njS8
	 q5osfRdBpytKhPsY/wMfqlMFQ89biFfErq6cuRiWPSUBLJPoSPMlWa9SwZPK7BcifE
	 BptOw7usU2lfteKqJ8fk2KFE073XC2G1BZCAfGzWcwifleUFseDqpKqg3hTRCB7Zop
	 z/bfshsPUsR5IZ0xoY0M+/0kq9PjwDx2zDqyxY30KcUB+57RfS0AcVmynpZWFu0DCE
	 ZHfhQI6y+hX53YubWaFOJLqJXMZUyFJYEr6RtSW+jxC3GnWtUlcf5x9j4naKXDVHgB
	 O715zI0MNiw4Q==
Date: Mon, 17 Mar 2025 09:06:35 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [GIT PULL] pstore update for v6.15-rc1
Message-ID: <202503170906.A32F95E32@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this tiny pstore update for v6.15-rc1.

Thanks!

-Kees

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.15-rc1

for you to fetch changes up to 5674609535bafa834ab014d90d9bbe8e89223a0b:

  pstore: Change kmsg_bytes storage size to u32 (2025-02-10 09:02:14 -0800)

----------------------------------------------------------------
pstore update for v6.15-rc1

- pstore: Change kmsg_bytes storage size to u32

----------------------------------------------------------------
Kees Cook (1):
      pstore: Change kmsg_bytes storage size to u32

 fs/pstore/inode.c    |  2 +-
 fs/pstore/internal.h |  4 ++--
 fs/pstore/platform.c | 11 ++++++-----
 3 files changed, 9 insertions(+), 8 deletions(-)

-- 
Kees Cook

