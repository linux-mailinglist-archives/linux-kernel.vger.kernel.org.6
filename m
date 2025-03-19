Return-Path: <linux-kernel+bounces-567520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F16A6874D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0303AD92C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3637211A28;
	Wed, 19 Mar 2025 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="hSqh0GV2"
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7262512E4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374399; cv=none; b=HO7AQlXBXPz4MD3Nr/4gYgdL0aT9gxA+MdUS+/GBCgngBG//5MCHSaOrc2aKfbuCt7uuKzk2OD8jNKXklmoo4NR8vUtD+qYodJU9Zq9wzb6RL9Qd/UGBZE0dLnz8oXPHVWA+8GI+CbGylv0Xpg01JkFiOkOirwDR1Sx3gJ/ybwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374399; c=relaxed/simple;
	bh=5ldBkJx8YWdD5of1eS/VRVCLJPRzWW1hLRrArDoUrc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O6fBASgOKguaqwdDMzd7/CeBJ2C2DFIFut7rnHiH6PY262sm/90gCtBhHVNmHjoTkvd3CsdU7CHQp12WX/+m0lpPImevEjX2Hu5ETk3fO5sGSwkyH3AvMzPhE1AYFY0GI9YeXB0Cq3i/RdlNzSxGn1NYJQBU944RoRW4qVy5p2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=hSqh0GV2; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250319085304cd5475afc80b7166df
        for <linux-kernel@vger.kernel.org>;
        Wed, 19 Mar 2025 09:53:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=jjEIeR231COjG1SmCJb0wnXLxWxliDhLT44HI5pE5M0=;
 b=hSqh0GV2IYf0Ayx9lrcnUZwfDxq3Dzt5BCFUL+8P68QUnho6DGBuwBI8E2awYm9EethsVG
 Gj1McJRF0Say2/EE3iiCMAJZRvG9vnYnyHBBllGvb+yXJMTzwhb8yTvOUPbF7o4t7OOKQgQw
 OY49frEeXlY//VlQd27aRdrj5nkD7m43EPoqDdfaQUd3axLaho+q2riiogXRvTLQ1XyLHb5i
 mrJYY603nC3ca1257M+Ad2ZYHYZcYwmCqqLcAlzUfw0WyE8JNWVWgp3tghORSRZW1FkQe32a
 jLGAG+gm+CFVMjC54F+fvLt93mWbCnUNG7nXinmbIqoXTGf/OPRYGr0Q==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mailmap: Consolidate email addresses of Alexander Sverdlin
Date: Wed, 19 Mar 2025 09:52:46 +0100
Message-ID: <20250319085251.3335678-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Alias all the addresses used in the past and currently to the single
contact address.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 .mailmap | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.mailmap b/.mailmap
index be60c13d2ee15..937abfd8e4182 100644
--- a/.mailmap
+++ b/.mailmap
@@ -31,6 +31,13 @@ Alexander Lobakin <alobakin@pm.me> <alobakin@marvell.com>
 Alexander Lobakin <alobakin@pm.me> <bloodyreaper@yandex.ru>
 Alexander Mikhalitsyn <alexander@mihalicyn.com> <alexander.mikhalitsyn@virtuozzo.com>
 Alexander Mikhalitsyn <alexander@mihalicyn.com> <aleksandr.mikhalitsyn@canonical.com>
+Alexander Sverdlin <alexander.sverdlin@gmail.com> <alexander.sverdlin.ext@nsn.com>
+Alexander Sverdlin <alexander.sverdlin@gmail.com> <alexander.sverdlin@gmx.de>
+Alexander Sverdlin <alexander.sverdlin@gmail.com> <alexander.sverdlin@nokia.com>
+Alexander Sverdlin <alexander.sverdlin@gmail.com> <alexander.sverdlin@nsn.com>
+Alexander Sverdlin <alexander.sverdlin@gmail.com> <alexander.sverdlin@siemens.com>
+Alexander Sverdlin <alexander.sverdlin@gmail.com> <alexander.sverdlin@sysgo.com>
+Alexander Sverdlin <alexander.sverdlin@gmail.com> <subaparts@yandex.ru>
 Alexandre Belloni <alexandre.belloni@bootlin.com> <alexandre.belloni@free-electrons.com>
 Alexandre Ghiti <alex@ghiti.fr> <alexandre.ghiti@canonical.com>
 Alexei Avshalom Lazar <quic_ailizaro@quicinc.com> <ailizaro@codeaurora.org>
-- 
2.48.1


