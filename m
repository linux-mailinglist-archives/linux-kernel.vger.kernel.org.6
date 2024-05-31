Return-Path: <linux-kernel+bounces-197469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 175948D6B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD791F28214
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C3F23777;
	Fri, 31 May 2024 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcmxDbuU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C0208D4
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188697; cv=none; b=oz8Gp5SIlQZF9QKav8W4VXqmb7M8TmJI5vE6HCxT63ET7rXmRMuD/+O20XmoQ0irKGiDFbE9dqoK2Ny9mEWx6PAVpK/Ceq6v75wph2KnX9xLW/tmWQ5BP4FoBgKhHWXTV7jK1X/a3aCrvhfViuoRzY7zgVeLs+VeRL+mGntQzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188697; c=relaxed/simple;
	bh=55bSlYJEAc7EgmWTPpn/mJq8zcs3syavLiIafMkwiS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sWWMXoZ8sFQZQ3aup0M7E1inXMED1N28bnHcz2ovXoEwQMd6NQhQETRk0i1kTEs+jdWdNX9ROwhQpeABExCUoKfqpvvQgTypYIouLjI9MHA6gDSZBPOtozfOHnt3ohd9e/WVcWRhLdjYCelfIzszzmBtXlURo0dE9JlLM0qNbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcmxDbuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2902BC116B1;
	Fri, 31 May 2024 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717188697;
	bh=55bSlYJEAc7EgmWTPpn/mJq8zcs3syavLiIafMkwiS8=;
	h=Date:From:To:Cc:Subject:From;
	b=FcmxDbuUHnXwt4EYvROpXNNXkrKhWfGgj35QfKv/O5LfnGbZK4yLFefMcXIQEjAUD
	 v2SDBsrCekrIc9HgP2EK9Sn0X9XinpqLK7Zs2Cd6s/OKGQVh3agpshAyyYlIB6xqBv
	 ObMT8bfjb2aEt6/7+SdqoKIvc4biuPlHhFWhAodI+Vl9SE+1fBew/3Ed4qoRomumV1
	 tg15NvLhpGxYa/RLZFlj80frxK6CqaSq+2iQ8uSynSo02oL30hN+vfXmQh1rHFwwjU
	 PXL6Njzr8bMztANCn9ZkGMw+G83kDqt9TdnDXkDLQmpMcA3T5+94OwgD2qU+886kWQ
	 kgdG6KmxRttyg==
Date: Fri, 31 May 2024 13:51:36 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
	Kees Cook <kees@kernel.org>, Marco Patalano <mpatalan@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [GIT PULL] hardening fixes for v6.10-rc2
Message-ID: <202405311350.388C0A398@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these few hardening fixes for v6.10-rc2.

Thanks!

-Kees

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc2

for you to fetch changes up to 99a6087dfdc65303d26ab5fba2dacd8931b82b08:

  kunit/fortify: Remove __kmalloc_node() test (2024-05-31 13:47:41 -0700)

----------------------------------------------------------------
hardening fixes for v6.10-rc2

- scsi: mpt3sas: Avoid possible run-time warning with long manufacturer strings

- mailmap: update entry for Kees Cook

- kunit/fortify: Remove __kmalloc_node() test

----------------------------------------------------------------
Kees Cook (3):
      scsi: mpt3sas: Avoid possible run-time warning with long manufacturer strings
      mailmap: update entry for Kees Cook
      kunit/fortify: Remove __kmalloc_node() test

 .mailmap                                 |  9 +++++----
 drivers/scsi/mpt3sas/mpt3sas_base.c      |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 14 +++++---------
 lib/fortify_kunit.c                      |  3 ---
 4 files changed, 11 insertions(+), 17 deletions(-)

-- 
Kees Cook

