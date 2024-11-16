Return-Path: <linux-kernel+bounces-411661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003DC9CFD7F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849B4B23BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FD2194C7D;
	Sat, 16 Nov 2024 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wRmvFl/+"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89485193079;
	Sat, 16 Nov 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731749653; cv=none; b=FGYKvR2Al1eX3RLAHjYdgcsYli9NEcG7NBWFT5eawXn2M2jk2glWKbOngDuDAVPvg/73Ol3vLB00SCP5P3wW/K5SjdoDaoRvXbOzk82jO3xOmNUjFWbNdPq41+XvNDuc2yWcsxfxpoGcjLglLOi4YkSKcRKNVqT65m2mkb2pOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731749653; c=relaxed/simple;
	bh=eoTB7BZYrZWM7Gl6BS3klFfm+UZ1S4B7t1Lr4Isf4M0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqEOCHPSQPZL6ICrBkBSxPhlPLljfQgIkKhCM5H9REc0RYzJV1KC4YRCmiS0ZZzaQx1wkipBZRGVfNtocQqde9VLE2Dq+IPSqsQ/u6qwqNGTtI21ZHrrUbrDfERg/E1+Mfq7DLBqVyr0XGp8nIpngxhMZvm+w/MERDleceB3h9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wRmvFl/+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bxC//Yl3wCklAz+DoIJKymAZfLtnvQ+I7hppBHxivSI=; t=1731749651; x=1732181651;
	 b=wRmvFl/+JYEMgFX1yTB5CgjXD8T0AohXah/Bdh5Cmhxy/q48304fT2NH91la7lVgEPs1XVoik2
	OLiA+5K8LCOtnEaspqGMK6iPws02l66O1kMHcW6YuVgtyLfyNqHJOO7S1PqGTYVVD+KHWnRIjt+2Q
	SMjy4CF4Rtmc0ExyEUoBXBiH5YuQicqvHeE65RbeLcOe8TPfvmOLLGvDU7qIJ2ON6duZu8v5ea4s2
	juY6TmVSZ4MLV4R8xnc8b+ltTFCiRjZ0ModWTaURzYt04467kGk59jUohxG4rsXrrWbVLpd7Tqqzl
	Qp20Mm7ETfO6aw+ajhDZeMVBjC5IjKRuQAo6Q==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1tCFBo-0000BI-H8; Sat, 16 Nov 2024 10:34:00 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] docs: reminder to not expose potentially private email addresses
Date: Sat, 16 Nov 2024 10:33:57 +0100
Message-ID: <cover.1731749544.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1731749651;fe049c94;
X-HE-SMSGID: 1tCFBo-0000BI-H8

Remind developers to not expose private email addresses, as some people
become upset if their addresses end up in the lore archives or the Linux
git tree -- especially when it comes to bugzilla.kernel.org.

This fixes a few issues along the way that came up during preparation or
review of the change.

Ciao, Thorsten

---
v2:
- Intial version starting with "2", as the second patch was posted
  before.

Thorsten Leemhuis (2):
  docs: 5.Posting: mentioned Suggested-by: tag
  docs: clarify rules wrt tagging other people

 Documentation/process/5.Posting.rst          | 21 ++++++++--
 Documentation/process/submitting-patches.rst | 44 ++++++++++++++------
 2 files changed, 49 insertions(+), 16 deletions(-)


base-commit: 623e5747c680d3854b6b9882d9907096bc63580d
-- 
2.45.0


