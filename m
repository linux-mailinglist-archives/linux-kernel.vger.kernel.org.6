Return-Path: <linux-kernel+bounces-521092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC0A3B427
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B32172B78
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D8A1DE2BF;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6LRgT6s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0F11C7B62;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=fNa+oiVNgjD1clXvXd0VY7zalf2HLVtvm0YzFNBOQorytkndW9iWZlvA65MI7PNtWEUes4W0stwndtveLBoZZL8z+XpxfMYOyAcCh/rQaGHy/LXX6ekwdy3oKBZKhyGVjaBD+dcVA6Rn6StNDYSLF0HIBPOaWmkDntEiJeEolY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=UcUtD1ZVE/t/e49mIRjHjGIlObJeJfXBstuSw82d2G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm0J3zxm8CXtZcpiDeE0TzBbACmOp7Wrulnl7hqe95ubn81PDKMIZLRx2bG23zI12vdKYOD+foHa4MDnT1WC83T5D3jSLyITzev7OgzNkrrZZ41TwJcYTFI9Vh6nT3VN3291usXQLM3JI0UDtxMnaF6Tb2d38Y5/FJ65pT53voo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6LRgT6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A16C4CEE8;
	Wed, 19 Feb 2025 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953971;
	bh=UcUtD1ZVE/t/e49mIRjHjGIlObJeJfXBstuSw82d2G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6LRgT6skiHuwnztX0mroM6CF36RVrS/RsNANn8HW+hgqZFCQE6xqRlBntmTN+LqY
	 qp428kYMxsr6jKytvO1VGV3h3RX6yxQOQO7ZKuCpNG7HA12g/PzC89PUOOa+XLuBf7
	 ZW2w9FxXDYZ/jh4ACkkOQ6HwnJsIoypXyq8Afnqgy5S2aqqQ/jjHHz8YKdncrSw5IG
	 AgiNr3ELSehF3Ykl313Bm3Y8xLwoE446AuILHSx0tyoS+yG9pvr0HcVL3vDltaaEBl
	 xzcVNEo+r1oNptQdZ7DHKDWjtYzcysl9k2xR1jtX3jNxGGWB8pBYQDe/8E9akz1KPX
	 wAhJ+sDa5b3Ag==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv4X-097P;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/27] docs: driver-api/infiniband.rst: fix Kerneldoc markup
Date: Wed, 19 Feb 2025 09:32:20 +0100
Message-ID: <033bcbcc6edaadda6dae59a66530e1603ae6948a.1739952783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739952783.git.mchehab+huawei@kernel.org>
References: <cover.1739952783.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

kerneldoc.py extension doesn't handle a "\" character at the end
of the line: it will just merge it to the cmd line, producing
this command:

	scripts/kernel-doc -rst -enable-lineno -function iscsi_iser_pdu_alloc -function iser_initialize_task_headers -function \ -function iscsi_iser_task_init -function iscsi_iser_mtask_xmit -function iscsi_iser_task_xmit -function \ -function iscsi_iser_cleanup_task -function iscsi_iser_check_protection -function \ -function iscsi_iser_conn_create -function iscsi_iser_conn_bind -function \ -function iscsi_iser_conn_start -function iscsi_iser_conn_stop -function \ -function iscsi_iser_session_destroy -function iscsi_iser_session_create -function \ -function iscsi_iser_set_param -function iscsi_iser_ep_connect -function iscsi_iser_ep_poll -function \ -function iscsi_iser_ep_disconnect ./drivers/infiniband/ulp/iser/iscsi_iser.c

which may not work as expected.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/infiniband.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/infiniband.rst b/Documentation/driver-api/infiniband.rst
index 30e142ccbee9..10d8be9e74fe 100644
--- a/Documentation/driver-api/infiniband.rst
+++ b/Documentation/driver-api/infiniband.rst
@@ -77,14 +77,14 @@ iSCSI Extensions for RDMA (iSER)
    :internal:
 
 .. kernel-doc:: drivers/infiniband/ulp/iser/iscsi_iser.c
-   :functions: iscsi_iser_pdu_alloc iser_initialize_task_headers \
-	iscsi_iser_task_init iscsi_iser_mtask_xmit iscsi_iser_task_xmit \
-	iscsi_iser_cleanup_task iscsi_iser_check_protection \
-	iscsi_iser_conn_create iscsi_iser_conn_bind \
-	iscsi_iser_conn_start iscsi_iser_conn_stop \
-	iscsi_iser_session_destroy iscsi_iser_session_create \
-	iscsi_iser_set_param iscsi_iser_ep_connect iscsi_iser_ep_poll \
-	iscsi_iser_ep_disconnect
+   :functions: iscsi_iser_pdu_alloc iser_initialize_task_headers
+               iscsi_iser_task_init iscsi_iser_mtask_xmit iscsi_iser_task_xmit
+               iscsi_iser_cleanup_task iscsi_iser_check_protection
+               iscsi_iser_conn_create iscsi_iser_conn_bind
+               iscsi_iser_conn_start iscsi_iser_conn_stop
+               iscsi_iser_session_destroy iscsi_iser_session_create
+               iscsi_iser_set_param iscsi_iser_ep_connect iscsi_iser_ep_poll
+               iscsi_iser_ep_disconnect
 
 .. kernel-doc:: drivers/infiniband/ulp/iser/iser_initiator.c
    :internal:
-- 
2.48.1


