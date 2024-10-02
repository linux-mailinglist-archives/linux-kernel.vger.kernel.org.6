Return-Path: <linux-kernel+bounces-347837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F2198DF74
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2B9B20EE0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047131D0BBE;
	Wed,  2 Oct 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeS/NRFY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9FA23CE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883637; cv=none; b=nE8QrSMl5cvKgB4c83ug/qvFG0Wbm1gv4kvpvEVEROnIc4RrxR/fKBARc0by3tEUPzBj5FAQ2noV8fnNv+7ODaKd6jKE8RZ/eRT/nORDsCGS76PuDEXxsvduoXopXx9FP8d+5DrKBeqYm6SKQup8wfGRIA1+reUmA16DzQq3kqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883637; c=relaxed/simple;
	bh=OkutdsehYfhKa63RW83v4rB0AcBdrGGB4BzZAD10i/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tV1aiDPNF1Ye+xyPX3pGvs/zMU3rObtIDc6LvdZ6BkOKTdjAuHBSzleUHTZKgij8f7CCtAWX4wUlyygtLoQMGUeCWdufyUq8PBYRA6tuGDyXEsuhT4nTVVybXhTA90ihRAXITiKo4uJ+yyi6RgTXXss7T7WD9W2lO5tE3ZXWWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeS/NRFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEFDC4CEC2;
	Wed,  2 Oct 2024 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727883636;
	bh=OkutdsehYfhKa63RW83v4rB0AcBdrGGB4BzZAD10i/g=;
	h=Date:From:To:Cc:Subject:From;
	b=VeS/NRFY2UBvpSNlkTGDfsJ0y+Yle6pwQ/o2UMZSyhmQdJPlwP9isUjo51ZOCdBYX
	 oGpn1oIDmBF7/oG4WVJvi85Sn4s3aLc0GHhk1EFiGu+OjxGYUD+gYUHPfINkTZrWWX
	 wTaoPt76KTQOUcWkmcxPshsRt9NLzuIyyLMfHNpSlC0BF2qrkD6g0n2NtX37JWHy8r
	 pyXeZ9+ZElerj0x9KQVf44P7CDadXyhHWYElyfOuuwapLfO04lrnWJPqWfKNLew1xJ
	 Batusn9NfYEs1/I2NLA54u6LWEq3K187hC0HTcQ0PlUZKRV2X4H12yakWIG9hTD5AP
	 RFi9lGZ4y7okQ==
Date: Wed, 2 Oct 2024 17:40:33 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fix for 6.12-rc1
Message-ID: <z75zg2bvyec6pwsrewzrlydn65f5pjknpnbgvi2pnsmpdr65pf@ja4tba66xuyu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024090201

to receive

=====
- a small missing fix from the new HID-BPF code introduced in v6.11.
  This was missed because the BPF tree was then more permissive, but is
  less now, in v6.12-rc1. This lead to the HID-BPF CI failing
  completely, which is a good thing I guess, because it exposed the
  problem.
=====

Thanks.

----------------------------------------------------------------
Benjamin Tissoires (1):
      HID: bpf: fix cfi stubs for hid_bpf_ops

 drivers/hid/bpf/hid_bpf_struct_ops.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

