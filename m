Return-Path: <linux-kernel+bounces-445078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B029F10EC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186DD282983
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B451E25F8;
	Fri, 13 Dec 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Nqnlcbvs"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76131DFDB8;
	Fri, 13 Dec 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103585; cv=none; b=uOQCYpiWe6coDhJpvlieEE3YmWxHd/UuXvrofL0iTd6iB1fOlcwIVxy8XFV+ArCdJaWnS5IhrPKv6sjhHgdVIRc/27W0QnfxGnPANmXeE3W25DD1BmWCk7+RRut5m78UBEs67WSXtChiMFmnKOrFIluu3b026CApPvOQy7GvLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103585; c=relaxed/simple;
	bh=0MjicvKkhLgq/ktWt38IRvLCNv/297HKJ3K0CUMj+eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bgKr2jBwZTG/jPs0phAcY93qAB5czLLRW9d1+QDVmqPkxPIWy8OLWRzqMsKTljG9fJte0dS8jks4uM0kNTJTzRsZUTF1tC+48DbjWtJJEtdKIwB7Acy3YXs3cD5XSbw5YmT6nOcDgH8VAgb6XPqDFCZx4iXMOrr/RfmQHrZ+Yec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Nqnlcbvs; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D9055403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734103577; bh=pAmWCifknZ0BZ1v9Uey7D7W3oWlObrlPtqSCFV0f4LY=;
	h=From:To:Cc:Subject:Date:From;
	b=Nqnlcbvs/synvKJqDep9n3cH1GOVvIYTdnCFmtV+QJqVU31l+Kd06YEgGElZQ0+FS
	 xmt3MveaRxnklWMczE3SKgjvZsNoWq3Dn0yzeXSl/cxgu5Kg0mqkHbj9iNRprwtVqo
	 iQu9/Nq5U7XwGU76dJs9By8Xib9fw7+VTuXYXhhFmU62j1U7rFmVGVR3DIhtHT/j37
	 CNEzg+UwrJzGgKvSCDoArKLC6jy8Ru0+11sVugeyHPvFR5agHnU4sapX9U8ergUUg9
	 aJv64t9oByspHoznZFBE7pb+8/0l4Yb7QL4gJezQTekqglUh9iiIP1ha6Cu9ttWm/4
	 4RvHYXGHtfwBw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D9055403FA;
	Fri, 13 Dec 2024 15:26:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation fix for 6.13
Date: Fri, 13 Dec 2024 08:26:16 -0700
Message-ID: <87pllvy57r.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.13-fix

for you to fetch changes up to d9339496729f1471b8dc326face17c4cf108b027:

  scripts/kernel-doc: Get -export option working again (2024-12-11 09:15:26 -0700)

----------------------------------------------------------------
A single fix for a docs-build regression caused by the EXPORT_SYMBOL_NS()
mass change.

----------------------------------------------------------------
Akira Yokosawa (1):
      scripts/kernel-doc: Get -export option working again

 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

