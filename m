Return-Path: <linux-kernel+bounces-561017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 782FEA60C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F48D7A305D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE7B1DFDAE;
	Fri, 14 Mar 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjTrZ4fo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB91DF98D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942781; cv=none; b=Y8bsLqhUYsnUIkzOWXp9y1FQ7JKpI3b2SKDsocv+K/9wmAPfIY2prsZnqG3N73ycgiyt8hOBRVllJphnOEV00F6ZcB7Z8pCVFrlcqA3S43FQtOtE8a7nJ/RkxptSyPcR9HMbpp8KRFhKsZ/AhWvx4PoMX98YD9IqZDeEgEYyNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942781; c=relaxed/simple;
	bh=1AuhTTwym8ZiEhPHHXjGf6cveKLzhSFxbirQjF+OwYc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=plUVB025umf5ic33blNDZ2K1E8dgIQuL79usd6GUlDmPHS06NUUJ89vMbSxln1uRBgwmwHM1dVcqN6U9ysqIskR/ORCkyXsdcG6TMxSFa/kOD7qOaBY+CBsHf1axDR+X3XsaJoNK8uoCApFxkipm2jffBgUKf9tRge+nzjo6goI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjTrZ4fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD01EC4CEEB;
	Fri, 14 Mar 2025 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741942780;
	bh=1AuhTTwym8ZiEhPHHXjGf6cveKLzhSFxbirQjF+OwYc=;
	h=Date:From:To:Cc:Subject:From;
	b=AjTrZ4foNlGW7mesTBeWiIT2eWFAMwUy1XPwLy/0qZLT/5SaeaGrEfw4p5J3lLlOY
	 vLgAOYlXp/bUqWmZOPdpJKCGBmDoyweUV/bTLR16OECmxl3aAqxQ27Ixh8zu5PxuxJ
	 ZP61mUZ1zs0TcyMz89iMqHykZZCEi6kagokiSebO7Q7vungem1/KhBO0T0xMx9LTxr
	 GXqCC50mTYiQcFE9cVuJn9MajYvT0G4xIEliKsUfdYsa9yWr+4gB9WhmlEr+h2eiUi
	 PH1qWKD5QdjYVy9YNoCgtnHFDVROPYCooRdYy4zK9XpjLYMq009uZauxObwyiRvJi2
	 UFTK9D/5LEn/g==
Date: Fri, 14 Mar 2025 09:59:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core kernel fix
Message-ID: <Z9Pv-InPlIE03148@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull the latest core/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2025-03-14

   # HEAD: 366fef794bd2b7c2e9df933f6828dd9739bfba84 <linux/cleanup.h>: Allow the passing of both iomem and non-iomem pointers to no_free_ptr()

Fix a Sparse false positive warning triggered by no_free_ptr().

 Thanks,

	Ingo

------------------>
Ilpo Järvinen (1):
      <linux/cleanup.h>: Allow the passing of both iomem and non-iomem pointers to no_free_ptr()


 include/linux/cleanup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index ec00e3f7af2b..ee2614adb785 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -212,7 +212,7 @@ const volatile void * __must_check_fn(const volatile void *val)
 { return val; }
 
 #define no_free_ptr(p) \
-	((typeof(p)) __must_check_fn(__get_and_null(p, NULL)))
+	((typeof(p)) __must_check_fn((__force const volatile void *)__get_and_null(p, NULL)))
 
 #define return_ptr(p)	return no_free_ptr(p)
 

