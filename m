Return-Path: <linux-kernel+bounces-362674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E48599B7EC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9B61C218CB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CBD3FEC;
	Sun, 13 Oct 2024 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="lSzuIXBf"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1A17C9;
	Sun, 13 Oct 2024 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728784064; cv=pass; b=JqAlkDnVTcVLjS5IIt+uIdFCAU/XpJEIDwpZarj52kNERkBFzrBKAp0n4/Phe7TMghZRu8Y4v9UBYqK7n6JitqCMiy0Buz0E1NTSRM/11XWGjKa8vqQLEYhoC9jtcEoNmrwETw1qgL7ynF5glSa4NgfgXxUFOkIoI9Oe3m+qoCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728784064; c=relaxed/simple;
	bh=aKzvzxILTzxEmE0TZZI6Q40SUjVKIobJ6VAIQ+PGjN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwx2KuuJXeOAv4CZNIjlB+h6r+Eu1R+I19163s17wQTPB9WGiCYmIF7Wly/VmkQQnXmRmN6r6g4O6UXBjckKmJA5IHOl1EelZ3qIK5pRMKGO+uJy3rRkA0/YIl+mzt04R0xPl3zlI1eYCbRFr8e0ETzF4Opyc/PhbnYD3h69tmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=lSzuIXBf; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1728784050; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=It0thPt1SNcT8/gZ9ipba0KPZkvMcO0yhXewdMhc5q6qiOuxvp8A04fO99bauARfPxc6oN6hOCl6boFVj5IeoiP0xZXhQDGmFpvuEkRKh2lXncrWO+koLOnd95YRe4NvSUAmOF1qTpZsilKl0KUpR+OrZpotS5YFMOFa/jJOFNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728784050; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3CF9QHK0q8CqBiP+xU9cGsEZFeH+jlJV0LlwJo+Juxw=; 
	b=S4zRqjfveUXpTi3ioluhChRcYrSIz13jfhUxNYplj1fQt08P6/D/n3H4xt/HhaS+h09GBLWZ5oGv1LFWSKNcIwxOb/7+IFst+A8JAwxJvKO10Hb5fUMlBYtIHQK+Mk5KM2bFAe+9rkNl48RSIaY75WPrldxq/DDlFTgS+6Nikbs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728784050;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3CF9QHK0q8CqBiP+xU9cGsEZFeH+jlJV0LlwJo+Juxw=;
	b=lSzuIXBfeygqicWnIYnIEXKy0XUXV9uFb50uXnYYH9yX17Wq62TVXBWY8O41F2wJ
	9GFbDxfj7dbcRa1RbneejTiXZRYG35OtGbBFI0Z1abuJ6GmQK/HddCjcgtV35X8DOaw
	wU5ZIghd9wVBturficgWo9I7K6gjql13rTcxTfxWjB1GCrLBkgdpTk7WPAle2arykZH
	gVzDAs3X0hRZ4egL9pVrEhfzKPbDot3msRZQguvhsN0ddkLDco308KTMcGcHYhLBi1F
	x1e3qPjNV+OkmAH4RElo501fgQ8ieZs21T5qZYhTa5UqGYsdX2t2BsAAB9JL2s01Jxe
	TUr1gqixyQ==
Received: by mx.zohomail.com with SMTPS id 1728784048103929.370436072698;
	Sat, 12 Oct 2024 18:47:28 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 0/2] ALSA: emu10k1: hide MPU-401 ports for Audigy Rx
Date: Sun, 13 Oct 2024 09:47:11 +0800
Message-ID: <20241013014714.7686-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The Audigy Rx card HW has no external MIDI ports (either directly on the
card or as an optional breakout), however the current drivers still
create MPU-401 MIDI ports on it, leads to confusion of DAW software.

Hide the MPU-401 MIDI ports for it.

Icenowy Zheng (2):
  ALSA: emu10k1: add a capability bit for no MIDI
  ALSA: emu10k1: hide ext. MIDI ports for Audigy Rx

 include/sound/emu10k1.h          | 1 +
 sound/pci/emu10k1/emu10k1.c      | 4 +++-
 sound/pci/emu10k1/emu10k1_main.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.47.0


