Return-Path: <linux-kernel+bounces-180132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3FC8C6A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DCD285874
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7315667D;
	Wed, 15 May 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMuQsBPV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390743144
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790153; cv=none; b=Pa1XMZk0dSzWQnMzlhqKK5Kb5tUmoCN0jsJzheCtffY82T/Uk1cq03C/tPxDmrIdTkHaQhtqQ7WTm0x7jDNTL2Vm7M4R5hzkcu2dydLY1yfJgmlomYhQAxhSVAbdVyfUvpX3LTzLrpGwhbsw3xK94dUjTCaRUUDYNTSK2APg0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790153; c=relaxed/simple;
	bh=/DDr0YT9qTvIH8iY/nkjsMi+kyIIH9WChrEk5EOyyhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k7zH9gqc4W2AYHrCH8X9bidZxLLvOO75a9+vv2nWuvQFSyLlMsnoxIpNq4PA5hd6JTuu934SLAr47y936xMYRrYSukxHzeu7M0ns2qunj3NHga4fqK3vNvvlPXwiOHSB+c5Hw+yaEIZlJrUfHfj7wzryd4dpmJVx9cYlevfC6Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMuQsBPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D031C4AF07;
	Wed, 15 May 2024 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715790153;
	bh=/DDr0YT9qTvIH8iY/nkjsMi+kyIIH9WChrEk5EOyyhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMuQsBPVFE9G3d5i5R0ExhGgGiXVCJ/s2Y1he2/H+0JkCz80s/dSst6Sq+7MLFzlN
	 T54HdhZdqTPIOL3ELWxuo/FYCYv7pue4M/xZ+Y9UsWNcqaV9e+x0JAvON47oOE2HnK
	 ZyM08aasJNuuQgsWi8vt7l/vpSd0W4Nb9o+b1bgnW+Wi2QhAVHg6v4Ol23oG0CNXVD
	 22BnXdUzw7Yyu08u5Hs7pwde0h846B6tyFfXzQ1VPoku34uKxDyB4x2PJ4MK0PgEI9
	 LqJ0GixpowXUDbVM4HK2Vpg7LNlzTGS5XnSPVd0RQ9aG4pdCKBbvAikH0unHIZGWAF
	 k/ZX6wf9wb6XA==
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
Subject: [PATCH 1/2] MAINTAINERS: Change habanalabs maintainer and git repo path
Date: Wed, 15 May 2024 19:22:21 +0300
Message-Id: <20240515162222.12958-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515162222.12958-1-ogabbay@kernel.org>
References: <20240515162222.12958-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because I left habana, Ofir Bitton is now the habanalabs driver
maintainer.

The git repo also changed location to the Habana GitHub website.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index abd4dbe2c653..5bd45a919aff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9431,11 +9431,11 @@ S:	Maintained
 F:	block/partitions/efi.*
 
 HABANALABS PCI DRIVER
-M:	Oded Gabbay <ogabbay@kernel.org>
+M:	Ofir Bitton <obitton@habana.ai>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 C:	irc://irc.oftc.net/dri-devel
-T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
+T:	git https://github.com/HabanaAI/drivers.accel.habanalabs.kernel.git
 F:	Documentation/ABI/testing/debugfs-driver-habanalabs
 F:	Documentation/ABI/testing/sysfs-driver-habanalabs
 F:	drivers/accel/habanalabs/
-- 
2.34.1


