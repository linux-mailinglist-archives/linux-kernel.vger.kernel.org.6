Return-Path: <linux-kernel+bounces-227804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49BC9156B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7217C28404C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC661A08D0;
	Mon, 24 Jun 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLkJjKWM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E4B1A08B5;
	Mon, 24 Jun 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255205; cv=none; b=SfUL/HEMeoQpflXqUPMgKr8IjwbIQQyrEfzRHgUywb5QTqwtZqN5CUiEHyN4EeDkDCwlUvh8gm7kLWECnws9/l9DObfb20PWZDqElD5GXk/F82H6H904xZ+5eE8msUI81OS972vGqvJxkCT2pUkzYqNgQBCdjYQc3XCUbAPLH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255205; c=relaxed/simple;
	bh=ifor4lfEILQq+iyRob2G2KmxkOnUR5SGECIZXYqxfOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udcXZTBujGi0BN6wlEFDBY/O0UCtWOxU7Ckcv3K71pgui3wS4BhE/1bfqNKS3rkhm7tQWGoKe7SCVI7nEtsTzX2txU6F4pL7qEB71qO3FORof/JtjwbNCn3GU9LBIDbYbw6czR8AonqGPQb0x+QvJVW5uXxMfsNnd0h6VA4k8so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLkJjKWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C9AC4AF09;
	Mon, 24 Jun 2024 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719255204;
	bh=ifor4lfEILQq+iyRob2G2KmxkOnUR5SGECIZXYqxfOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLkJjKWMHX74vqZUgc3yCPWKwnfk+0ATw15aE0JAt+uDKLo0KoE+NaVa9sxR13OXG
	 NCvnS8OPUOKt/QsYK7w3bTGDKx2tUDlK6BSDPbq7ENn33gbR/upWWR/4uzOBP48fN1
	 UuC+daOqXnItjN2qrIEOc7irDwhLira01v3y0eQ6zsBkzvEgzkYQeEMH0qToSw3KJP
	 r2BcOJli3DxSI0sTQzK0wVCFWsov0S0XVeb8Dz0ystQS0lFriYB0J11LLlK848G5xn
	 Y/MMAUzYCE4zLEl18z/l+GtMdF8vr7efcX/MozDBdklCjjPHcw2FNH7Z8PbnIEzy/Z
	 2i80q037m7fng==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] Docs/maintainer/maintainer-entry-profile: add DAMON maintainer profile
Date: Mon, 24 Jun 2024 11:53:11 -0700
Message-Id: <20240624185312.94537-7-sj@kernel.org>
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

DAMON has its maintainer entry profile document, but it's not listed on
the existing profiles section of maintainer-entry-profile.rst.  Add it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/maintainer/maintainer-entry-profile.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
index b49fb6dc4d0c..cda5d691e967 100644
--- a/Documentation/maintainer/maintainer-entry-profile.rst
+++ b/Documentation/maintainer/maintainer-entry-profile.rst
@@ -109,3 +109,4 @@ to do something different in the near future.
    ../driver-api/vfio-pci-device-specific-driver-acceptance
    ../nvme/feature-and-quirk-policy
    ../filesystems/xfs/xfs-maintainer-entry-profile
+   ../mm/damon/maintainer-profile
-- 
2.39.2


