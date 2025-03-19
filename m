Return-Path: <linux-kernel+bounces-567752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014A8A68A01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A453BF975
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C6925484D;
	Wed, 19 Mar 2025 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [210.12.148.147])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4300C1AB50D;
	Wed, 19 Mar 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.12.148.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381493; cv=none; b=PC2re5qzHsqrjK0LhKCfti83rlfzHVuxLWFZ9c1dq/2JsTOtk0KwZWsHeb9u1Pe3RvsOWs+YnUxSXkfPjv3jjqDmqje96x/4qJ0HR7BGz+KNvo/dSRQV++5C/KBWJmPszUQxuwQw/GK57Y3N0kia5HH3QEZ43vUl98jtSfRaaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381493; c=relaxed/simple;
	bh=gYSCdIi8TyNW1DwAcRwNxoVGP7/ycEQBkqAOmDQNm2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=duQxkfSFi8tiydPPVp+on1/+6aLqQIPNHfgEfHAf3S1SVOBHbUhjQJjOBXRDxLdGZoT1d6ZYzDVHrhHVQuCDPURtdaIDOshapKRlNROwBPJz47elu9JNWyijxW1HKMaaEnyeSQz3UxC6gsozFLXwRRCklMVsIARRkgUf08MsgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=didiglobal.com; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=210.12.148.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 601)
	id 16D971C5914A; Wed, 19 Mar 2025 18:44:14 +0800 (CST)
From: chentaotao <chentaotao@didiglobal.com>
To: a.hindborg@kernel.org
Cc: boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chentao325@qq.com,
	chentaotao <chentaotao@didiglobal.com>
Subject: [PATCH] rust: block: Remove unnecessary comma in introduction
Date: Wed, 19 Mar 2025 18:44:12 +0800
Message-Id: <20250319104412.50625-1-chentaotao@didiglobal.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The comma after "methods" was not needed and has been removed for
better readability and correctness.

Signed-off-by: chentaotao <chentaotao@didiglobal.com>
---
 rust/kernel/block/mq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index fb0f393c1..ee8f34f40 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -23,7 +23,7 @@
 //! IO requests are passed to the driver as [`kernel::types::ARef<Reques=
t>`]
 //! instances. The `Request` type is a wrapper around the C `struct requ=
est`.
 //! The driver must mark end of processing by calling one of the
-//! `Request::end`, methods. Failure to do so can lead to deadlock or ti=
meout
+//! `Request::end` methods. Failure to do so can lead to deadlock or tim=
eout
 //! errors. Please note that the C function `blk_mq_start_request` is im=
plicitly
 //! called when the request is queued with the driver.
 //!
--=20
2.34.1


