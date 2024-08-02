Return-Path: <linux-kernel+bounces-272107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD4394571D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A8BB2190C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AA21C698;
	Fri,  2 Aug 2024 04:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=main.intartek.com header.i=@main.intartek.com header.b="EJ+jyo3i"
Received: from intartek.com (intartek.com [185.20.185.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D1256D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.20.185.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722573262; cv=none; b=sRnSiQlJhhiJuPnH5Zfeeg3/gWgjxoCLgf0tj0kA3vPUGg84LdM5Kp8pDWj2vRXCiApQownyrR5oBkHKgjlBJK0US87nXXpa1bhr5fQlbJMaFqeJg9TdgUK7NZxp6a8b8odNGJKrGnxbrzmtMyzFcWaQ65y3Evly7zsgwJFu6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722573262; c=relaxed/simple;
	bh=iH49m874iFMj1mm2n+tVAsWr2wUrbnY3NWfgcNbq4Fs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQalJB25VaSdwuXlQdQ9RmvFqNEM5QDhxSz+rKlRd8ZTCUXMJZKS1haH20M3eusXT0zA4B4KR3DMyIgC2ng5Ad8FVRmdRpqPgga8gbZcTG6ljf2ZWfSh+EGqZfkgcDM/H3V7OWeDbwjZqmwDw3eZxpR8mQ2GoYVNnMeET8R1CPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=main.intartek.com; spf=pass smtp.mailfrom=main.intartek.com; dkim=pass (2048-bit key) header.d=main.intartek.com header.i=@main.intartek.com header.b=EJ+jyo3i; arc=none smtp.client-ip=185.20.185.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=main.intartek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=main.intartek.com
Received: from 239.32.165.34.bc.googleusercontent.com (239.32.165.34.bc.googleusercontent.com [34.165.32.239])
	by intartek.com (Postfix) with ESMTPA id 7773A81F94
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 04:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=main.intartek.com;
	s=202406; t=1722572396;
	bh=iH49m874iFMj1mm2n+tVAsWr2wUrbnY3NWfgcNbq4Fs=;
	h=Reply-To:From:To:Subject:Date:From;
	b=EJ+jyo3iAiuUkS6bcJHedsLG5O0lzFgH3CgWjEiFsPvRtHJKlCdYm39XH75cuKPwn
	 ZBn49qNAx6uxgHLsgvhL6fekcQ4MGfC+IBq1ZZ+3P0e6qSTHCSzjah9j/6mq6WvTTU
	 Aij77qTwiN7KbOViEuVJ8Qf/JbWi1KmrY7aJyfTFJmAQF1duVAMBg4A05FI0A2vyKV
	 4oW/THNDnvu93wpLsUqkhrWcS9S7Q90tSvMHV9G1rIXeaXKkozoQ4Tewy76xGVVmP0
	 vYbK6QFedWSiVyAbW2FRrgmdkpBtDVlU5why9iIE1ceNXDBQc849acfQw+tT+OCY0h
	 LkNoCzPmfe25w==
Reply-To: "Antonov|DPR" <antonov@neftelensk.su>
From: "Antonov|DPR" <privateservices@main.intartek.com>
To: linux-kernel@vger.kernel.org
Subject: Kazakhstan Crude Oil Product Offer REF:svzfff01
Date: 2 Aug 2024 04:19:55 +0000
Message-ID: <20240802041955.96DFC2711B0F81A3@main.intartek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dear linux-kernel,

I hope this message finds you well. My name is Antonov, and I am=20
a sales representative authorized by leading refineries in=20
Kazakhstan to negotiate the sale of crude oil products worldwide.

If you are interested in purchasing crude oil products, we can=20
facilitate the process. The refinery has sufficient product=20
allocation to supply to serious buyers.

We currently offer a range of products including Petcoke, Ultra-
Low Sulphur Diesel, East Siberia-Pacific Ocean (ESPO) Blend,=20
Russian Light Cycle Oil (LCO), LNG, LPG, Jet Fuel, and more. All=20
our products meet SGS and GOST-R standards, and we guarantee=20
timely delivery.

Thank you for your attention. I look forward to your response and=20
to discussing further details.

Best regards,=20=20
Antonov

Message REF1: jaahuqi02Q
Message Timestamp: 8/2/2024 4:19:55 a.m.

