Return-Path: <linux-kernel+bounces-445068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0634B9F10B1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166661881D69
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D578C1E25EB;
	Fri, 13 Dec 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld2KUNRI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9831B412E;
	Fri, 13 Dec 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103071; cv=none; b=DQTPw3H19vSvzLJuiTeWNkcR8XJV/WwOvBeWqiFcQAWkG31fylef38J9LVclyoQcy54NJzOlNIKSlfx6Dng3B9dBOSCiONSFDx6bzsGBpA1fce96pgWy96C5E1IyztfqwT8EpVPQQ4XlAonv3DdxZHdF8UeLEsC4LUGDenLoswo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103071; c=relaxed/simple;
	bh=lWRVH5EyN+9dlmjB6nLEBNufjesGoRfBbuBRyqyNPNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYb+oVIWRIpszBiHhZFyBa2hDbY9QLFgDCzApa/OR5to5Z6/pLSWim6X+XfJ3G3h3yLAymsziYm5Yvo9bwHqdw3mLgBHRLq0z9+tQQPF2oZkYOCATD0fNvTJ5Auk6BSqgcoT5SbQIiQts63PifpXUpOtTvme26Ex8RUE2kgXPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld2KUNRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ACAC4CED0;
	Fri, 13 Dec 2024 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734103070;
	bh=lWRVH5EyN+9dlmjB6nLEBNufjesGoRfBbuBRyqyNPNA=;
	h=From:To:Cc:Subject:Date:From;
	b=ld2KUNRIPLC8meS9tClIC43uUlzuXHAAAUOqyTjultGJ652rd0MbV2OUeLrCXdGqE
	 5/TR1+coiTnQKInJpeVSGpZatH8JaajeDRmJJHU/UtQQcnfJ62uVG6i9uazQOSWbaG
	 n2mY0PdVdzrsrdp+MM2twRM0edN++nJJ+kWQYoz/ugfrBC3IvBfqKzFDfXHMCSt6Tb
	 kyFNcSgslXNh2p+t0rKxcZJ4L/1Al0+qRovz3Vxte9asVMro1MrzHEhgk7f1iM3Ls6
	 21Bvg3nw+HzQtxdoKZNDIiUbNJhwk+zxWZN7MGgLNYI9JvFYadAIxcAGZi8JVK2oQB
	 JzM8vmIOJH9iw==
From: cem@kernel.org
To: linux-doc@vger.kernel.org
Cc: cem@kernel.org,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix simple typo on filesystems/porting.rst
Date: Fri, 13 Dec 2024 16:17:40 +0100
Message-ID: <20241213151743.23435-1-cem@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cmaiolino@redhat.com>

Just spotted this while reading the doc.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 Documentation/filesystems/porting.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 92bffcc6747a..2d08fd4a2280 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -313,7 +313,7 @@ done.
 
 **mandatory**
 
-block truncatation on error exit from ->write_begin, and ->direct_IO
+block truncation on error exit from ->write_begin, and ->direct_IO
 moved from generic methods (block_write_begin, cont_write_begin,
 nobh_write_begin, blockdev_direct_IO*) to callers.  Take a look at
 ext2_write_failed and callers for an example.
-- 
2.47.1


