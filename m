Return-Path: <linux-kernel+bounces-421746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5A49D8F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A94B2771F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 00:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14951653;
	Tue, 26 Nov 2024 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YgY6nboN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81379137E;
	Tue, 26 Nov 2024 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732580013; cv=none; b=f08Vcu0oV3MbhuuwbwmOkwBksp/hj2yuC9pPEha9JmB9bDCJo/blYtSBN1vm+5QJJ7hCnesQwTBY2pBB1Sv5+gPOFFGJ/U9p+x8wFCuKyegyqh0LKSRyKFrsafyoa4qkV26etNY8RnMuo+mH+bHlLSP3g0H/sLDMJmuBTdCBHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732580013; c=relaxed/simple;
	bh=yQtdLmoxCN2ejbSwx1WCZyGOxXnDgm8MFgZWVZCqcJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KWC9AnBYgEI9UaEVuic26nCwkUSxsqY2ENSYOgCBxINqSoq94xaNY3IxnF9NI2wedICkGuiMd1J3RajAOk8utx8AE67u5MHvQn0wizs73Tjf/MGwjiRl3UnYz7WBa9nGzqyLxW1+IH94dLCvBc2J6pnancd+6exlFCfb6wT3T9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YgY6nboN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C7D97403E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1732579998; bh=2ASgOcXgtOTHWnJjuUAfQm8tVEk6xdvSbKgdmBIlmys=;
	h=From:To:Cc:Subject:Date:From;
	b=YgY6nboNKTOKGlfVOypiz/nVQWlNqp1Eliw0wYL6vXH44i9SMSYwbSHfFu3VYlaxz
	 ekWm+G/HDJPlxfO/5zkAcU/z5lSCrxCL0QeBJI6cToCc9KCXXQ1djMnI710NB5wR9I
	 QYtBFAmQwIV24NAUWKowwSajnveS0Vr9r1cHrfg9BnOZFZ0JHAG4QyPfq3cqj5UXSc
	 +r3S4f0/JDv39FsVl2SsmmkHOXaOtA0MvqaYam3TGaAR9JK+01JgGHQxlevq2T87HR
	 XVYpIkMAeQjRVDejGFSOqRJLa6sq67S1cflc5EhD6Bk6rzIQvxiGpvum7rYlshH/Xz
	 /wwrsDm1OE6SA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C7D97403E4;
	Tue, 26 Nov 2024 00:13:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] A bit more documentation for 6.13
Date: Mon, 25 Nov 2024 17:13:17 -0700
Message-ID: <8734jeam3m.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit c818d5c64c9a8cc14853d716bf7ce6674a6126d0:

  Documentation/CoC: spell out enforcement for unacceptable behaviors (2024=
-11-15 14:31:59 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.13-2

for you to fetch changes up to 83a474c11e8cb59e230a43365cb42fa00d3bddaa:

  docs: Add debugging guide for the media subsystem (2024-11-22 10:48:12 -0=
700)

----------------------------------------------------------------
A few late-arriving fixes, plus two more significant changes that were
*almost* ready at the beginning of the merge window:

- A new document on debugging techniques from Sebastian Fricke

- A clarification on MODULE_LICENSE terms meant to head off the sort of
  confusion that led to the recent Tuxedo Computers mess.

----------------------------------------------------------------
Javier Carrasco (1):
      Documentation: pwrseq: Fix trivial misspellings

Pavel Tikhomirov (1):
      docs: core-api/gfp_mask-from-fs-io: indicate that vmalloc supports GF=
P_NOFS/GFP_NOIO

Randy Dunlap (2):
      Documentation: filesystems: update filename extensions
      Documentation: kernel-doc: enumerate identifier *type*s

Sebastian Fricke (2):
      docs: Add debugging section to process
      docs: Add debugging guide for the media subsystem

Uwe Kleine-K=C3=B6nig (1):
      docs/licensing: Clarify wording about "GPL" and "Proprietary"

 Documentation/admin-guide/media/index.rst          |   5 +
 Documentation/core-api/gfp_mask-from-fs-io.rst     |  20 +-
 Documentation/doc-guide/kernel-doc.rst             |   1 +
 Documentation/driver-api/pwrseq.rst                |   8 +-
 Documentation/filesystems/autofs.rst               |   2 +-
 Documentation/filesystems/dlmfs.rst                |   2 +-
 Documentation/filesystems/fsverity.rst             |   2 +-
 Documentation/filesystems/path-lookup.rst          |   2 +-
 Documentation/filesystems/path-lookup.txt          |   2 +-
 .../filesystems/ramfs-rootfs-initramfs.rst         |   2 +-
 Documentation/kernel-hacking/hacking.rst           |   2 +-
 .../driver_development_debugging_guide.rst         | 223 ++++++++++++++++
 Documentation/process/debugging/index.rst          |  78 ++++++
 .../debugging/media_specific_debugging_guide.rst   | 180 +++++++++++++
 .../debugging/userspace_debugging_guide.rst        | 280 +++++++++++++++++=
++++
 Documentation/process/index.rst                    |   8 +-
 Documentation/process/license-rules.rst            |  18 +-
 17 files changed, 804 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/process/debugging/driver_development_debu=
gging_guide.rst
 create mode 100644 Documentation/process/debugging/index.rst
 create mode 100644 Documentation/process/debugging/media_specific_debuggin=
g_guide.rst
 create mode 100644 Documentation/process/debugging/userspace_debugging_gui=
de.rst

