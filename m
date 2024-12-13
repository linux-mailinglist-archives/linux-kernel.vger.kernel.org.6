Return-Path: <linux-kernel+bounces-445341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A699F14D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6166F188E767
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8601E572F;
	Fri, 13 Dec 2024 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="N/DUZZyA"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCC188A3B;
	Fri, 13 Dec 2024 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114090; cv=none; b=ZXjQPvdYeLg+3vWjypk0ZKWZTRoEfH1TjRJ4fE/57kJRNrkeAunVhkfKEHqI9hHGm6ogAlL9v3acYty+EbUfAxTPSZ523MIDCzvkq8rjBw+ATVVk/PXx1eMwsghqmle1eNcl10TBh0caTs3EpSsPPaEf6nnaavGHCQic+Tizb/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114090; c=relaxed/simple;
	bh=4Rk14MGbK7ObaOlembCmnHMWeIHbML14bvkFY0+kMDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hD6pBO+R5eLGjEO/bfoz4JiSeKW0XMQkkZ5ayY5iHo7lqblZ9E2EQOT/twdwb54DErxNXeRKeMoYqI12JhP8rxHhKmqQrl/fVhqFmPJTcAHTb01x5ewgTWAzo1FU8etp66nghspRF4ghhVVCgSSyAN8yj0WNjkc0WPwn4BkYwm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=N/DUZZyA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B9BFF403E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734114088; bh=vRb87epXnBywj9W4QAVZfrWdRH92aSVIW+5+17HqZg8=;
	h=From:To:Cc:Subject:Date:From;
	b=N/DUZZyAqmlQixt5t4J5u8uqXJAjWAtHfUGiryd+pdhTWOHVLrW3V9JSM2raThH11
	 XftyNXqyDiUA1fEn+71nMRcw432/MngIg5r44r36iBF6Bm5kkLffbrlmLBLgaTuUK8
	 nJDVPigZjd27AcrJyyw7rkC5qh9pHrMIzV1u58OK+o/k0/O3ATdl/PDB8TsurKsaCA
	 TW3WnZxfvTIP8sUIqAxGpezjY9refuPMbDa4EJMxlvPCtum1x2Kdyr2ca7wMs3IKNV
	 F/iUui62e6vLsBPxE+mobny8OLSbRKLEksFErlhTfwCDuEhPhPCKGBHvksU+QhgaaR
	 mP8w79Usomd1Q==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:5e00:625::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id B9BFF403E4;
	Fri, 13 Dec 2024 18:21:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/3] docs: organize the admin guide
Date: Fri, 13 Dec 2024 11:20:51 -0700
Message-ID: <20241213182057.343527-1-corbet@lwn.net>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our documentation directories inevitably turn into an unorganized
pile of material that is less than friendly to our users; that has
happened with the admin guide.  Reorganize the index.rst file to make
it easier to find the material of interest.

The rendered version of the reworked guide can be viewed at:

  https://static.lwn.net/kerneldoc/admin-guide/

I've not done anything to update or weed out any of the documents
found here, which would be a great next step.  When you have, say, a
document describing how to partition your 50MB disk (ldm.rst), that's
a sign that the cobwebs have started to build up.

Jonathan Corbet (3):
  docs: admin-guide: join the sysfs information in one place
  docs: admin-guide: add some subsection headings
  docs: admin-guide: bring some order to the "everything else" section

 Documentation/admin-guide/index.rst | 163 ++++++++++++++++++----------
 1 file changed, 108 insertions(+), 55 deletions(-)

-- 
2.47.1


