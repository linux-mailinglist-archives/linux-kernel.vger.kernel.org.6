Return-Path: <linux-kernel+bounces-528488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90822A41854
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9911727C1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8C24BBE4;
	Mon, 24 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0fY0Vr7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E854245016;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=n1P5vc3NzoN9hXXmg9hl11xK0LtirnDBhKFvInA+ncrut37o8Sa+LS9ur2CTElFqAx0Tb4qptAaaEyZCI959ip+yKoM2W92X3bL1mgSqpHvU/hODwzGnOYfyE91S0ajOLTsOsMpAw3DNXlards585LVD/8ZzV8lAlttyHuDyTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=UcUtD1ZVE/t/e49mIRjHjGIlObJeJfXBstuSw82d2G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QasaxGPM5AYmI1aww5hJvvw3Rbzyze9ISDNw2hEs+ejOlL41vk8MYXDhvy5C5OArnMZNLhmqKnV8E0zh3KLXSOvNReh1o6aJnUeekEDYnpJZlRtlxCWZn1oxiHuUAYMXmRr9ivpH0ug2OAq1ItSjU1HpXzWkU5jMEIVs879MkQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0fY0Vr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97AEC4CEEA;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388142;
	bh=UcUtD1ZVE/t/e49mIRjHjGIlObJeJfXBstuSw82d2G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0fY0Vr7r35L49wncFdUWrtJI3o5U77qS87mf8aKhhwzES20EOSeFLzyypoE1q0ky
	 TclNGUhMfdCpmnw0GI8G65red6UhcFs366zAlh9WKf8cSs6iG11n6kfgVnxmRqjvzA
	 TDs0GTA+Rk74Ga27QDS5XfLfwUBPhLwtDjBFhHNyQ/UhLc9OR1vBlTsxyCX4fWOqjO
	 SlhE1hJ/LiH+IeImj44mcYq2jy+ZOwDhaRozfeii+6FwsNomC5KNwHncllVZQ53s5x
	 cV+XfYy5Kq0mCHijyYHwshrS0DUf+BZphGXbUjfKAIyTN57ZPnn0zibG4zRzN9qs+4
	 aS6VsY3MOUWvg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUSS-00000003p3g-3izA;
	Mon, 24 Feb 2025 10:09:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/39] docs: driver-api/infiniband.rst: fix Kerneldoc markup
Date: Mon, 24 Feb 2025 10:08:10 +0100
Message-ID: <64e7949439c5fc39f2c9441027ad02bc60cbf0dd.1740387599.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
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


