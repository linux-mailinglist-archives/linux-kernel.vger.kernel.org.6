Return-Path: <linux-kernel+bounces-577328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBE3A71B98
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF80B1898A84
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B415CD55;
	Wed, 26 Mar 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjLPK6hE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454C1F4C9F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005703; cv=none; b=D1c2OIhaKeTpmCtCehPgRA+W2pkQLvAbquViHO0Qp5Sd8v7vNJAOfIkI31F4z8MKPk/dy+zI6jShM0IPWdGZzEFlVsi0pA39l85lNaDG8vnQ/4RzrTwGWm5UBPCC30rPTBEgUez8e8K7GpfsQMvell9FNSus5w9EP7o5aCmwr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005703; c=relaxed/simple;
	bh=vOKAizh5/MPDvANmNq5cDN8/kNrC8LI+3gM0Y2qPuAE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Dupy4fcC1IdfrsnT7nIYyfLgHDUocgPCjXvMzTa6nAXvu9Ap9ldFw6uSLJ6ybwBWEHi439d1PU35gzInEi+DTpdf+Qf+9hc+48lHQDGxPs7/Ee7H6SzjimKWUqTnU1OUNkDhmOSblgPLkW/29ThNAvt82hZ/+oOhHp/ZxLXVF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjLPK6hE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2379C4CEE2;
	Wed, 26 Mar 2025 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743005703;
	bh=vOKAizh5/MPDvANmNq5cDN8/kNrC8LI+3gM0Y2qPuAE=;
	h=From:To:Subject:Date:From;
	b=ZjLPK6hE1mQMJ6Ld2J8jqVj8cyWzqOTAmKKeso0S7mNrKCsk8ukyaRXNiSSgm1nEe
	 16Tx1c80UJt7R6woxbEOvEuY3sfTVXHGcOFj4C0iDvZmZhO/5D6j7qhKrCFsrtLVaY
	 bchDTQC+uAaBIv+DN7Qv7r/YEzCiuykhyuKHJ0LuWje45faMVcI1Bs0GKWqZTOgzo3
	 XY6UIfovwKYYjrRA9EdTx5DFMhnuy8X6YqxD0LLuoku1KanU0s/nXHR+yl+Xy3vuol
	 N9dyyZFsXG9PFBj2K0/Y/2W5hMLf0fcwxJ29T91TAVguyQtq6CJ+fKoW5z72R9r3xn
	 yNrJ7YLUrNUEQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Alex Elder <elder@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>,
	Kees Cook <kees@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Leonard Crestez <cdleonard@gmail.com>
Subject: [PATCH] mailmap: Update my emails
Date: Wed, 26 Mar 2025 18:14:52 +0200
Message-Id: <20250326161454.122270-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

@parity.io was never used in anything. Replace with my current
work email.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 05a3889ae2d3..7d00c6c25901 100644
--- a/.mailmap
+++ b/.mailmap
@@ -304,7 +304,7 @@ Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
 Jan Kuliga <jtkuliga.kdev@gmail.com> <jankul@alatek.krakow.pl>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@linux.intel.com>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko@profian.com>
-Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@parity.io>
+Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@opinsys.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
-- 
2.39.5


