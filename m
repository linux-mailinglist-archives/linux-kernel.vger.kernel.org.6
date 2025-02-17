Return-Path: <linux-kernel+bounces-517686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69145A38476
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B993B7A60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6AE21C9E6;
	Mon, 17 Feb 2025 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJUDj7Uq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF2821C192;
	Mon, 17 Feb 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798041; cv=none; b=kq2fcbXbbBNCM7lu7QI8HGkEw5Fzp2dVIkiYr8hx6M7g7qlvKKGGf+Wdo4K6SBp25KU8xzKcvGvO1Oeh57NvsIPfTRpveXwZs2de6+lVUdH5Z6jGUwEBeLR9x0wbKznShlZP3nJ5ASo3urfcpOubEyC4C5PDPUm5pXZSED5OfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798041; c=relaxed/simple;
	bh=w4r9lnxn7sqsNE3KWaJopKWBLuYC6f5wRbkt5y/Q6Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fw6zTztUOKRKD+Gt+g1SyfFYx0ONu+wxbQ3TWnTNut032X5bio7H/96BGVND0gUUQ2P+jCOMsg0vipVlu9mZLoxZou02+h8CPHNNcj/aZioKd83ZRWMiVoAispN3AbphkJJzKRwe2VWRxS3yQ/JLndDT+uureYPUQaIq0zlI5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJUDj7Uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA71C4CED1;
	Mon, 17 Feb 2025 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739798040;
	bh=w4r9lnxn7sqsNE3KWaJopKWBLuYC6f5wRbkt5y/Q6Pk=;
	h=From:To:Cc:Subject:Date:From;
	b=oJUDj7UqvID+hjCoFOi6b1ew4PuLIGJ/kN0fcMYxfWsRTpsUNKBRylxR7QDmtIors
	 FoH7905zTMw7WZmqWD+yZa+i/VzrXe8x2imsUTHr8EiUMpFK4k64HvXTuDIA6bcxTi
	 mdDK1xecw4i7y/INz0XuWiY1S4NnUOhgOUEyTZFSqlBPz6PZ3TVEZOgQp3QXmanhDm
	 F5ioEtci9GJ5i/guQu6NfujdlvjCvyP2nq9aQz0yiuiXlKCJdVqlOUGkDwNoKdYNL6
	 awmDMcipzdQYImjIGDoPANUt/MR3Syn2q/tBkFBVgIFSAPXzZjDOEx4nGmgXEdjaO0
	 9pte0NiscM8NQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nihar Chaithanya <niharchaithanya@gmail.com>,
	Rohit Chavan <roheetchavan@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] static: gpib: hp82341: add MODULE_DESCRIPTION
Date: Mon, 17 Feb 2025 14:13:35 +0100
Message-Id: <20250217131356.3759347-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

One more description turned out to be missing

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/gpib/hp_82341/hp_82341.o

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/gpib/hp_82341/hp_82341.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index 800f99c05566..cf5cd1edc41d 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -16,6 +16,7 @@
 #include <linux/isapnp.h>
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("GPIB driver for hp 82341a/b/c/d boards");
 
 static unsigned short read_and_clear_event_status(gpib_board_t *board);
 static void set_transfer_counter(struct hp_82341_priv *hp_priv, int count);
-- 
2.39.5


