Return-Path: <linux-kernel+bounces-334638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7853697D9D7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08F31F234EE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72693185950;
	Fri, 20 Sep 2024 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="SgUhMKDw"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083E185920
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726860992; cv=none; b=Hj8VSoOTihkrunGNtrZ5ru/cziRq8RneaIR/AtgutgeEEtcdmq8V02+Eb/ZhD5XQt1+byz3J4cybrd1dCtOCKAoNzLzl/yIIWCeoAeAboFf9H0zAtDo6IjOM0vPXhrhK2Ci4f3rcgr4uTd2HbsW2GZc4XcezzNuAjumqBpWqPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726860992; c=relaxed/simple;
	bh=7vlRbQcwd0pMoUrdjMHi2lDH5TbuFKu9CR3Uy6Y21Mc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=i0sfI9JlGeYFOhNcSuQxKlPfNRnepbEwWsRI1xKtXjPIAtWj36dtN1oxlOTjgwcCbDsrJ4VleV69AwvPjiYNDJkHjlymMMmTCDda3qUXZ946eEbyuX6lYO2kj6wKgJ88m7V1JqXAuUWhLUegd+PWQciWlkmuUvipC+hc/J0ASV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=SgUhMKDw; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726860983; x=1727120183;
	bh=W8v8r2h7r1KU/mFKXhHA1+p2uQE6A/CCsuxkOZmGugU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SgUhMKDwN+kHcXx3O1FnKQPDv5pmihiXB889vm105UM1H7d7kqI+CF0uZ9BUJedOk
	 rOvw0Up8ZeNQxrgF7ACiZmIZXfcKP7N3HA1NMoMH3w4wH1BEwriSP5i/pQvgS4xnUj
	 /nJPRF8rclUnWuMDMhogdJd6pHBE3IbmSJroRQC3zYUWRGlgHbL/nSYJpj//3uadVh
	 zXZ/T8KMANzKSXw0dz6D73YI1cqfPKI0nSJ0HIiCGl27gk4Shp6Rtp7taUPv7LVwIZ
	 DMLYuvW4yUU0+ezz9H9xDJEgVG23v1CULtSATGml8Wo0SLW4gKydqc55BdUBS/jJPE
	 YaXRBn5xtiGMA==
Date: Fri, 20 Sep 2024 19:36:17 +0000
To: gregkh@linuxfoundation.org, tdavies@darkphysics.net, philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 0/6] staging: rtl8192e: Fix alignment to open parentheses
Message-ID: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 2e49eaab5358febfe06682868e7aa778d14617b3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series aligns the code to open parentheses to improve readability.

v2: Split patch into smaller patches and refine them, exclude files conflic=
ting
    with https://lore.kernel.org/linux-staging/Zung-0ClV_527-_e@kernel-710/=
T/#t

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>

Dominik Karol Pi=C4=85tkowski (6):
  staging: rtl8192e: r8190P_rtl8256.c: Fix alignment to open parentheses
  staging: rtl8192e: rtl_ps.c: Fix alignment to open parentheses
  staging: rtl8192e: rtllib_rx.c: Fix alignment to open parentheses
  staging: rtl8192e: rtllib_softmac.c: Fix alignment to open parentheses
  staging: rtl8192e: rtllib_softmac_wx.c: Fix alignment to open
    parentheses
  staging: rtl8192e: rtllib_wx.c: Fix alignment to open parentheses

 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |  9 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c          | 91 +++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 60 ++++++------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  | 60 ++++++------
 drivers/staging/rtl8192e/rtllib_wx.c          |  3 +-
 6 files changed, 103 insertions(+), 122 deletions(-)

--=20
2.34.1



