Return-Path: <linux-kernel+bounces-180135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130BB8C6A80
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9579528622D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561DC156F2C;
	Wed, 15 May 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibTtL+uL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12C156C5B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790156; cv=none; b=KTv6UogyEC2SLnC500aSOAukLE14III+m/jBdb9lCGRf0mteRDjewUfkNBEpmiiZO1Z1wrs8RSD880Ec8V5uhXaA64N4nmwxi78YLUhodI6dE4CiD/zplwKYcF5Vy69TatReCLn7AJfsnHZPOtd1P2n8UcbQZbcrt/8y49aYUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790156; c=relaxed/simple;
	bh=1viUCWYrFo3uJS3ITlLVjLhbJegaUQZ/hfRHcrqV1Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kwqw3w91npx3m9A35dvYlxSlO8dBcsRHGHIMP0NBQbwPp1xCfSoyuzgW1f8RPFmATJR1CF5oK8jKkg8+EpLyThuxbmDytXSgmSZ6CnupKL0+lh6d8YIxp+xrSxI80FWjQEbMOo1BDWHnPukygYU+C/NnodnQ8JpmUo6AeGayukA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibTtL+uL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D079C32789;
	Wed, 15 May 2024 16:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715790156;
	bh=1viUCWYrFo3uJS3ITlLVjLhbJegaUQZ/hfRHcrqV1Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibTtL+uLJranPiNsBTX+/GMRHyz2iKB/WQ8gLVpD71k1Hws4qZM+QoLzxv5PZXAn8
	 9AoFHU2e/ic36BY5VFFU0Sp/hdqsckvYOD2VSdfyhGCWTslhpKt5hSiYKRH7mMRB6s
	 9MxW0PV+vSnDyqI0pzQZAovZy9wkzvJ1ZL+f6tBKEIO2XRa0gjn6PatVtmDT8ItekS
	 pN1G3M+K/+EVbNtwKUEAqvqOX7Y0KRrJSP2vMmcpyhhrvyqgbewkcppylYelYj8HI6
	 YXpJ9izKrIIYLjscrL2AGowSIKtyfbU9QrshM0dDhMdXzEbrJP8+ITWeH+7zWmklMR
	 HgGkTF8nCu5jA==
From: Oded Gabbay <ogabbay@kernel.org>
To: linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Ofir Bitton <obitton@habana.ai>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 2/2] MAINTAINERS: update Xe driver maintainers
Date: Wed, 15 May 2024 19:22:22 +0300
Message-Id: <20240515162222.12958-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515162222.12958-1-ogabbay@kernel.org>
References: <20240515162222.12958-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit

Because I left Intel, I'm removing myself from the list
of Xe driver maintainers.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bd45a919aff..2469607ff5b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10863,7 +10863,6 @@ F:	include/uapi/drm/i915_drm.h
 
 INTEL DRM XE DRIVER (Lunar Lake and newer)
 M:	Lucas De Marchi <lucas.demarchi@intel.com>
-M:	Oded Gabbay <ogabbay@kernel.org>
 M:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
 L:	intel-xe@lists.freedesktop.org
 S:	Supported
-- 
2.34.1


