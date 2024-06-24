Return-Path: <linux-kernel+bounces-227800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B56BC9156AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDB31F232F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047A91A01B5;
	Mon, 24 Jun 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD81Bvqy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B41A00CE;
	Mon, 24 Jun 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255201; cv=none; b=l8eaV/sDZ7O0Z11ojTFPOm6u0C7oRjb8+kvFqDnYaktLV71u/ImwBLfW4u990dUJaeK3WqOH4JMyZFa4gWGZMxAOkJB5fjnPnp3Ws3Bh9HjeQULaaxFkwBIzNZoai9zTpJTUfmk4tAgWxebk0mZRv7RLM/dODCkawi+/KLfQU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255201; c=relaxed/simple;
	bh=U72EtpzbiKzdfZYMZqZ6j+rqYebEL67up9pZVkZeQk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/paPStSX489BIrpe4ObNURFktsnonkmcaGqo6mGydlyo6e0OyjJ31or1QM6K+X0HE0HXcjxtJi4N8mCVm3du7gjEUsiped4behnJ1GuTbbaLLA7LDUd5W7GMEvkGrIG7Si+x0iWd3ORyyX8/vzjqDWzUZ2N9JXR0636rtUCbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD81Bvqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D914C4AF09;
	Mon, 24 Jun 2024 18:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719255200;
	bh=U72EtpzbiKzdfZYMZqZ6j+rqYebEL67up9pZVkZeQk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FD81BvqyDxLnI+QMw8K7UgCl8zk+gDT9s53JPO30trVFzpSzBqsL9hlbS5j16TCLO
	 uytKpn3jyxu4bq7olou7jE/b2omJkbSMRSgymBTyVO4s6tJPNTkOY7pumlRxha/+aY
	 GKCuDRC589DCAKtEAhc7UFwscsavFdnLzTy6OkKSuPLYQgG/Iq2V37JDIser9Aaj4I
	 fXRzTVfmmMMZUtrcVu0Bfmaq8r11D3bdPKFGfxMccrmkS9KE2lz/kqWU7v+4O6Ou++
	 J5zsWIlu7hp+eP6lYmUYWW76NxWtWWFSXeoex6eD6aCtwoDPOLfZjEzJ4nlf3lemKh
	 uRQ2w6VlP/ljQ==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: SeongJae Park <sj@kernel.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/7] Docs/process/index: Remove riscv/patch-acceptance from 'Other material' section
Date: Mon, 24 Jun 2024 11:53:07 -0700
Message-Id: <20240624185312.94537-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624185312.94537-1-sj@kernel.org>
References: <20240624185312.94537-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'patch-acceptance' on 'Other material' section of 'process/index', which
is for unsorted documents, is actually well organized under
'arch/riscv/' directory, and linked on the index document of the
directory.  Remove it from the 'Other material' section.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/process/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index f66f9cbd0300..08b4eb1e9118 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -115,7 +115,6 @@ lack of a better place.
 
    magic-number
    clang-format
-   ../arch/riscv/patch-acceptance
 
 .. only::  subproject and html
 
-- 
2.39.2


