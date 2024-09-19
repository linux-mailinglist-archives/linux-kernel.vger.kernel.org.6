Return-Path: <linux-kernel+bounces-333380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 818BA97C79E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C628C2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ECE13AF2;
	Thu, 19 Sep 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="stGiHox5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45BE13B2B1
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726740045; cv=none; b=PlT/nGW9GjtQ4VOb/X1ZFdPoGTC2H0L/Uvti8VtoKcTpERE9GY059NUSwXrB+Gl0JQhq4cxBea57AoWipMlpii3bLXEboZtF4AQmB/VhKK+mgVRAwNwWeBr/FTq9/XdUoBm6uj/YQdlbHdRghhZwU4i0Ki1fVtbUktOsmYE6vVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726740045; c=relaxed/simple;
	bh=94RuUcGawRwvWOcsu9qanxwlURurYmsMUO8ggudI+cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sa1M1nzVlXq67dEJjKzl7zDF83sHJ8BE9E3W4w1MIz1FANi+C/r6QLI2MQDmQcWQg0H3RVaozaCqgg3uCTmF4r91rOZsxaQ0HI+cs6zwJ3DpyCCrnEdPj2V+2/oppDlusukRg97O4XwRJ9/qWY0okgu447JlIPjm1JBPqdaRuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=stGiHox5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E9D0F42B29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726740037; bh=G+kFK+RM/OaDT2bKx//GO80EBqCAfqPDuGR8XXuCoZo=;
	h=From:To:Cc:Subject:Date:From;
	b=stGiHox5j5nUGlXLREyM7Vq8sd/Yh5OU8rR+e3kjtdf7eZZItNyCGqP7LeG/H7N3R
	 kcWe6j+AnCRxhDg5/oDPFplX2lscwWNEGQIq/HzorP5a2tuaS6zlaCo/6+JXQt9Mi6
	 /Wo/TFPfYdqR2bryN+tqCjluR+1EGm3A7cACade6XEH2LmEDFqfvkSDl/3NZyHj4dX
	 YMQjwqo73p6z6GfOA0ar75zsNsuZL3vt5wAuuGTWyEGPltXX/vPgMq8SNDH4QSYg3+
	 0ldw1hqLcMrExnxQpZqBFBYPfRCDd5Z4PlNPwHPKECpu/T1mGExsMUtXDoHKoEBTh/
	 O0rAiYedKfEDQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E9D0F42B29;
	Thu, 19 Sep 2024 10:00:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: tab-elections@lists.linux.dev, tech-board-discuss@lists.linux.dev
Subject: One more TAB election reminder
Date: Thu, 19 Sep 2024 04:00:33 -0600
Message-ID: <87plp0ezem.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

One last reminder: the 2024 election for members of the Linux Foundation
Technical Advisory board will run from September 20 through 27.  For the
previous announcement with the details, see:

  https://lwn.net/ml/all/87zforv3zc.fsf@trenco.lwn.net

The call for candidates will close, and voting will start, relatively
late in the day on the 20th; the exact timing will depend on when things
finish up at the Linux Plumbers Conference.  Everybody who is eligible
for an automatic ballot or who has requested one will receive a
notification from the CIVS system once voting begins - but only if you
have enabled your email address with CIVS at:

  https://civs1.civs.us/cgi-bin/opt_in.pl

The list of candidates for the five open seats is currently:

  Amit Shah
  Daniel Borkmann
  Dave Hansen
  Jakub Kicinski
  Kees Cook
  Lorenzo Pieralisi
  Shuah Khan

The nomination period will close when voting starts.

For people at the Linux Plumbers Conference, there will be an "ask me
(almost) anything" session with the tab at 9:00AM Friday:

  https://lpc.events/event/18/contributions/1983/

Anybody who is interested in what the TAB is doing or considering
running for a seat is encouraged to attend.

Thanks,

The TAB elections team

