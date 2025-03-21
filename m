Return-Path: <linux-kernel+bounces-570730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C53A6B401
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619AF4858BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6FF1E9900;
	Fri, 21 Mar 2025 05:22:35 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A73271B4F09;
	Fri, 21 Mar 2025 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742534555; cv=none; b=qOc+if1cwuP9dqLjcEoeMltsNs6wFLgPmSyKBA1lw/IHrVEXvOAHIJ3+QEBwen6tJfQcR87cE6Cs3GRtrgELgNMTOEKUp8UXIK18dMCaoCubksvLbVz+aIRQ/ERPxq/NU/bULjmuOCHIkTo7W/MAKhYn4EIatg9u/4IXp7aQkHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742534555; c=relaxed/simple;
	bh=9TtVjL3c0DThRBgOl+sMcY2Rd1Z7nPPrnj9100/UhkA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RFcbEy7Dp91JSUN/c0KUx52QD1gCWQQiwQ7hYdTZ59gIsO3ulFjdc9FdM2V+dk+leTxPsMNJYw7f96uoVSKIvEUgROamgOZ0QDoIGHw90vWD4j6xKhLVywOgd1NwcmbMa9BHNaFd0JuqEp7HWrxM/wGr6qxFlmRTJnpbUcfxfQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.19])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id F3642180E55DF8;
	Fri, 21 Mar 2025 13:21:40 +0800 (CST)
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ02-ACTMBX-01.didichuxing.com (10.79.65.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Mar 2025 13:22:10 +0800
Received: from OneApple (10.79.64.102) by BJ03-ACTMBX-07.didichuxing.com
 (10.79.71.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.11; Fri, 21 Mar
 2025 13:22:09 +0800
Date: Fri, 21 Mar 2025 13:22:08 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.65.19
From: Taotao Chen <chentaotao@didiglobal.com>
To: <a.hindborg@kernel.org>
CC: <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <chentao325@qq.com>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: [PATCH v2] rust: block: Remove unnecessary comma in introduction
Message-ID: <Z9z3gCdqa+GN91SA@OneApple>
Mail-Followup-To: a.hindborg@kernel.org, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, chentao325@qq.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BJ01-PUBMBX-01.didichuxing.com (10.79.64.22) To
 BJ03-ACTMBX-07.didichuxing.com (10.79.71.34)

The comma before "methods" was not needed and has been removed
for better readability and correctness.

Signed-off-by: Taotao Chen <chentaotao@didiglobal.com>
---
 v1 -> v2 : Corrected message: removed comma was before "methods" not after.
 rust/kernel/block/mq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index fb0f393c1cea..ee8f34f40899 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -23,7 +23,7 @@
 //! IO requests are passed to the driver as [`kernel::types::ARef<Request>`]
 //! instances. The `Request` type is a wrapper around the C `struct request`.
 //! The driver must mark end of processing by calling one of the
-//! `Request::end`, methods. Failure to do so can lead to deadlock or timeout
+//! `Request::end` methods. Failure to do so can lead to deadlock or timeout
 //! errors. Please note that the C function `blk_mq_start_request` is implicitly
 //! called when the request is queued with the driver.
 //!
-- 
2.34.1


