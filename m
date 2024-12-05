Return-Path: <linux-kernel+bounces-432947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72839E5238
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92F91882541
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522DB1DA634;
	Thu,  5 Dec 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS8VrOWC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08F42A8F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394407; cv=none; b=NVMw51BMerwqffYUGQn0IKF/OZVbPoP1fM/vxM+dPZQ5X0AQgOcKVQ5N2rJeri/JaGBACmAGqw+HR/6ahPdhhl2cHNwDykCYBpAJtSBRJHLsuEEgGQnEilitA7jZfCmuES5zeNSdezgaco4ubXnTADbouaNtlqt8Ijhm9PD90us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394407; c=relaxed/simple;
	bh=P4PrA/fffvi0p1QaMG3G10Hb7RkRI6SN2B10WacWwzw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N2OXHcRBMlducnWjps2FtSQoY9svdYsvD/J/6ko0whwigFTy1OmiP/eSxUTKqU9phfCSahzMYoo17vgZ9rKq0A0wMKbSooPxj7OHR/e+V3k3XL6badicLxs2DoKOghL8gI2YLLfz8bXI5cWk6ry4VjYJUqSaDddZFMQqd2i9hhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS8VrOWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EE3C4CED6;
	Thu,  5 Dec 2024 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733394407;
	bh=P4PrA/fffvi0p1QaMG3G10Hb7RkRI6SN2B10WacWwzw=;
	h=Date:From:To:Cc:Subject:From;
	b=bS8VrOWC+bzA6xVSBg3xofDUGW3cCTd1YbTZ4z8aEq4+eDoTBN6I47Zm8NGIe0A91
	 8Fih5377sSfTuWtrB/GQeWZZ64h9sH5awAay4qCNOmNKfvWCo4V5bI39+Z3cs/dXNc
	 cqlsmrfy+LGR/Un7rasliB20hGHxZYLKTC8P86UjYEhSU2U9WK2A/gaZn8U9kdhvUa
	 PY6I7vUaPP1fEg0jOEsqXoWXdn2BOyQqbL8QE5SdYTrwd/HqcAW2CghtZjcIQ5diSo
	 8O5iuzxNEir9rWqjHJ5dYHrGUTa22Pg1wqPU6QX2mZaX9JyG0811EUXR3tvriM13i2
	 /YXggxppdaWGw==
Date: Thu, 5 Dec 2024 11:26:43 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <hpj2hhd5dyxo76p7d6a2dcwxzskcliqq3o5iwdygsvjfqadwii@xccheb7kfxu2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024120501

to receive

=====
- a regression fix in suspend/resume for i2c-hid (Kenny Levinsen)
- a fix with wacom driver assuming a name can not be null (WangYuli)
- a couple of consitfy changes/fixes (Thomas Weiﬂschuh)
- a couple of selftests/hid fixes (Maximilian Heyne & Benjamin
  Tissoires) 
=====

----------------------------------------------------------------
Benjamin Tissoires (1):
      selftests/hid: fix kfunc inclusions with newer bpftool

Kenny Levinsen (1):
      HID: i2c-hid: Revert to using power commands to wake on resume

Maximilian Heyne (1):
      selftests: hid: fix typo and exit code

Thomas Weiﬂschuh (2):
      HID: bpf: constify hid_ops
      HID: bpf: drop unneeded casts discarding const

WangYuli (1):
      HID: wacom: fix when get product name maybe null pointer

 drivers/hid/bpf/hid_bpf_dispatch.c                  | 17 ++++-------------
 drivers/hid/hid-core.c                              |  2 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                  | 20 ++++++++++++--------
 drivers/hid/wacom_sys.c                             |  3 ++-
 include/linux/hid_bpf.h                             |  2 +-
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 19 +++++++++++--------
 tools/testing/selftests/hid/run-hid-tools-tests.sh  | 16 +++++++++-------
 7 files changed, 40 insertions(+), 39 deletions(-)

Cheers,
Benjamin

