Return-Path: <linux-kernel+bounces-362536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD799B611
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE17EB21CCF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B3842A8E;
	Sat, 12 Oct 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="asoG9cQm"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3664964D
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728749876; cv=none; b=DziRVG1nBcwFlLCxcafuyf8fKrkOPQtihDfmKRqL+8VJwhQBU0aH/MX7iVP8HecnuEXX8AfRTQes5nHdp5ay2RuEU6OBrjAL80hUoLEwg27TcfMPheldL5s8vfdQF2/NmjHXzSrhp+z3MxbFrHmINmKsE8tU0I3ICB9hllTJqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728749876; c=relaxed/simple;
	bh=379tYbBsC4CafY0fO7zfewLWL7FnAvUIDSefxqVT1QY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=D3pca5K68CR5EGgkX1OBJm9yGNs0GPArwhHO4sy2yUk5aQ3S7XoIHhu3sncFpxvLw6k37v2GwVu2oMdCQJxWw2lqi52QfB5yzANAkaY8iJZFk7sJpP+GiA3/sm7ir9EB+ExcRgsYOg3cVuNArJglddefxFeaDl9UqNWJeDXP6Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=asoG9cQm; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1728749867; x=1729009067;
	bh=qfY7r4piAFfZJolQ2MRNeggx/6z83Jcaq8WpLsS2vqY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=asoG9cQmAp7qC8IzVfHHHFHIlq66oaSxe3JZ57SOVIAIvLfIm2Hrmi0bWPY9CVgBD
	 s/iBJ0ypE50XbPyP1OGWqT7lUFoTL73Ab0gd1NpGpewJg5NSSs0V/U9f24bObRU3RM
	 LkIDKy13Rr8m80NnIccrZvM7GLSK+j6Pm/+VVlnMZJgKc+G00PueCnn744hAvVD0HI
	 DC8bGi8WWqKlzpmC8q6k3lEweN2tvcDQA2BIdKLF4rG7pdIFj8cqIemxbc8Eo7q6FL
	 MOKYMaCh6Gda23bvDL+/Bf+7WsqiCzAgTveLimbtpgOMLK6VqwhCKI5X85y3UMNZra
	 B9MRfsPUY7TJA==
Date: Sat, 12 Oct 2024 16:17:40 +0000
To: florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org, ayushtiw0110@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 0/3] staging: rtl8712: Tidy-up *Algrthm variables
Message-ID: <20241012161638.67030-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 58d280bd7dac88995293ab0889182f63a55394fe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series renames *Algrthm variables in order to avoid using camel case.

While at it, introduce auth_algorithm macros to increase readability by
replacing hardcoded numbers in assignments and comparisons.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>

Dominik Karol Pi=C4=85tkowski (3):
  staging: rtl8712: Rename AuthAlgrthm variable
  staging: rtl8712: Rename PrivacyAlgrthm variable
  staging: rtl8712: Introduce auth_algorithm macros

 drivers/staging/rtl8712/mlme_linux.c          |  7 ++-
 drivers/staging/rtl8712/rtl871x_cmd.c         |  6 +-
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 61 ++++++++++---------
 drivers/staging/rtl8712/rtl871x_ioctl_set.c   |  9 +--
 drivers/staging/rtl8712/rtl871x_mlme.c        | 23 +++----
 drivers/staging/rtl8712/rtl871x_recv.c        |  2 +-
 drivers/staging/rtl8712/rtl871x_security.h    | 13 ++--
 7 files changed, 65 insertions(+), 56 deletions(-)

--=20
2.34.1



