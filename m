Return-Path: <linux-kernel+bounces-362676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518F399B7EE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085B91F22126
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1287479F0;
	Sun, 13 Oct 2024 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="PkSZTkAT"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39AC1870;
	Sun, 13 Oct 2024 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728784088; cv=pass; b=VYwevKZ/JRpUo90AplZYoHskoyPL9YFS5hwDXYtW6kSOBZYMLlgmXb1MMwvkmgsH3fP3I0o8kRHBotsycMlFt5igVQF3QF/7bxxySebZw/z/VNhkL6ch8Z8lhfdrnU9LWk9D550eA+3JgjHSECvfHhoOl+dVkT1FPLNJHp4iNAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728784088; c=relaxed/simple;
	bh=v5m3CTNEW+D9aVXVPGDzbpijpDQQIxbYHoED16eC4KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRn5PD1zmnm4OL7Sxbruhvj1DXPeqnxjmg+e1jYM2yL4qtFxAfoQF7KjU+3ZgRph8frTGOeNe51YtpJOoG6u+o8m3pDxFCdbLpO5vtQhbu0vRn0ZI6ofVc0v3hzx0JsI2YufIVdqeunLg0VXc9fWbCF6lA9cH9+Nve4ZVitU8oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=PkSZTkAT; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1728784080; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jTjwkYQBfW8q21wC2MrNWLVLsHKui8uzTo5yWxayBdznMS3gc/SwlKZJCZjYwLBwzQ55cbBUNOoibk0Rtj0JconSGZNXWd5Rru1R1MQ5iNmujdm+XWqspcVpY1UE1xDW3NWdBcDHUQz/Oh3iouosp0Sg23h6sRxtA1RaZby9b+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728784080; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xMA0Ve0ifeE4zJVgDILKH1JZGeu87x9vinIyWiXeifc=; 
	b=jDxNw4n9esCeTUR6t9UYT/2KrD83co9F+CJd9F5NfFoxfv8YNRcClQJ7/dtfU6ypZUpHPgRT983u69gvaRRu4dBmTgY0frGUzkhLHQmrH88iYYSBHYi8TDUKxeuJ2y/MLJ05QQ65X2Kmv7LbKm2rL0M7gP9Iwd3a7cS6ik/ZsWI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728784080;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xMA0Ve0ifeE4zJVgDILKH1JZGeu87x9vinIyWiXeifc=;
	b=PkSZTkATw3X9gm1E4R6+hafqWzY+/S8zjk9YLoicQDn3Or686pk7DQzBXSUBPTfL
	fVeazm09aa2ocWes2SjL/RuVq4njMRukIs/dhIm7aMfiJbylbd2Zorp7jWCUCeuoGdG
	XnF1uL9admqUH3mTDzhzGs2eiAIeP61Jr5MoBhCy6NGChBL745U+8g4gQoW2kDoldsU
	pi6AzEoumrI99HtgkXtGMYkT7Uvq21tZFqLRrpuhtMVijjfSzM3KCgGMlMjHlQwo/gP
	lNUvTFI1Tov+s6+T7pVR+vvxpIjL59MyogquiWLvn0znVIT6EXDQAQ00Ox9NgZIQ75Y
	i10+oiP3VA==
Received: by mx.zohomail.com with SMTPS id 1728784077958241.1142985847348;
	Sat, 12 Oct 2024 18:47:57 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/2] ALSA: emu10k1: hide ext. MIDI ports for Audigy Rx
Date: Sun, 13 Oct 2024 09:47:13 +0800
Message-ID: <20241013014714.7686-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241013014714.7686-1-uwu@icenowy.me>
References: <20241013014714.7686-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Audigy Rx is a card w/o any external MIDI ports available.

Set the capability bit to hide its MPU-401 ports to prevent confusion.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 sound/pci/emu10k1/emu10k1_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 5b8a5ba825bdb..c9240126f78e3 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -947,6 +947,7 @@ static const struct snd_emu_chip_details emu_chip_details[] = {
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0108_chip = 1,
+	 .no_midi = 1,
 	 .spk71 = 1,
 	 .adc_1361t = 1,  /* 24 bit capture instead of 16bit */
 	 .ac97_chip = 1},
-- 
2.47.0


