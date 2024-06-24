Return-Path: <linux-kernel+bounces-227799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD599156AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE32B1C22010
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B4019FA9B;
	Mon, 24 Jun 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpyChkak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7225619DF76;
	Mon, 24 Jun 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255200; cv=none; b=ch5gfjOzUHEBMtFR+RBmMKJzfrKNLvBkFYJVovfauIeOkgqu0FiWRzg8y3BkKj66tYVCzMuBP3VR5zdxvOIC682Z+f1CFHyS32mN9LCQ/b0/lwNG86EVd3zFsNUtwKFJgnHuuZ9DNZKmdkYsD8ky1lnOtnMNRHnDc0gbrHdwwXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255200; c=relaxed/simple;
	bh=3iuaNYlIUIrwAvKsdT038w1HZlSEJOm5YS4SlS+Qm0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z2hF5W1NacXet42ZdrO56CNHGgZiy4acPSlaMAkMtx4MYZSiEgLIE5Xz0FFUHTFuuxh0feEFVWElKO9zaVwGtcqv2mPyGIgC9WQmeXxwsIU9KUOLnsEuCgentLU7k8mM3Q0JSuo+jgV8uYt8Y1oK6obmX1mPG4umARJlk+iGUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpyChkak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9134AC4AF0A;
	Mon, 24 Jun 2024 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719255200;
	bh=3iuaNYlIUIrwAvKsdT038w1HZlSEJOm5YS4SlS+Qm0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpyChkakCvBDH9pShqIbfVywHANNmLrDMCawTl8TZ7xI6XyKjEkVwhvD1Ie97R4Nq
	 4xkNwEND7ojRY/T8kqrrvZZmYP3y/8T2hyGeP6mCWOzZR4SxepdFLOb/8Sm7HILlbH
	 WlGtHqjHOGUROuK5S+PSYGPOnLsyXw5iKu9asnkoKWMh63QM/G7zJN4qp0lr4TeBlh
	 jYCWO+MlcY/hCwDVl6/JsCiJiCzY+fgISIgGUXuuUT23bzYEskNalQO0X2eIkrdNZX
	 Bs8V3QBiF5Nq5fjbM994PiJ+hSyL6bv42IhiXg1nme56zli8HDeYIcWLF3OKaQuWwI
	 uD5CKIjiVFe+g==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] Docs/process/index: Remove unaligned-memory-access from 'Other material'
Date: Mon, 24 Jun 2024 11:53:06 -0700
Message-Id: <20240624185312.94537-2-sj@kernel.org>
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

'unaligned-memory-access document' is linked on 'Other material' section
of 'core-api/index', which is for unsorted documents.  But it is
actually well organized under 'core-api/' directory, and linked on the
'core-api/index'.  Remove it from 'Other material' section of
'process/index' document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/process/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index de9cbb7bd7eb..f66f9cbd0300 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -116,7 +116,6 @@ lack of a better place.
    magic-number
    clang-format
    ../arch/riscv/patch-acceptance
-   ../core-api/unaligned-memory-access
 
 .. only::  subproject and html
 
-- 
2.39.2


