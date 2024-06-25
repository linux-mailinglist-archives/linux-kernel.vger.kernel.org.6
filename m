Return-Path: <linux-kernel+bounces-228939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C80E9168E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51B31F23186
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54F161936;
	Tue, 25 Jun 2024 13:32:27 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FA1607B0;
	Tue, 25 Jun 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322347; cv=none; b=hS0xMJF6ZClSjwAcww4xoGgm57/IXtB+r5X7gorjQaJN8qHzZohjuLjEIguuTU+Asx7W4gts9fmANVAn4KClgo/ElYPcq2F5RQQVfiT6/UDfIK1PBuSkTjZGyevNgvCMv6t3zdXHCsqnPrSzjmk/+yOXl1dUdJ/eEcrYd8gtUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322347; c=relaxed/simple;
	bh=7cRZ7RSanbNqP4/UsuFatp5+Yyy3gQFuJtGygSMSx4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pOkaPIv6tZOpfushsJmxJAtWIuirmarBt7m5f4qI/M0EPsYWFzn8Yv9IlZlDQviQ3FDhfU03o6mFC42BEJcjrL5zFLR3uTIMwwlUYnGVs9MA51k4M8f2SLEeHUrnRlTcKyWTBilK/bNLnFMNn5LyM+hzehy7HbeixeT3mLSeaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (91ec5716.dsl.pool.telekom.hu [::ffff:145.236.87.22])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000720C2.00000000667AC6E1.00006109; Tue, 25 Jun 2024 15:32:16 +0200
Message-ID: <c0a9e15e7926e098bdea97a7d31c32427e0910c9.camel@irl.hu>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad
 330-17IKB 81DM
From: Gergo Koteles <soyer@irl.hu>
To: Rauty <rautyrauty@gmail.com>, alsa-devel@alsa-project.org,
  tiwai@suse.com
Cc: perex@perex.cz, kailang@realtek.com,
  sbinding@opensource.cirrus.com, luke@ljones.dev,
  shenghao-ding@ti.com, simont@opensource.cirrus.com,
  foss@athaariq.my.id, rf@opensource.cirrus.com, wzhd@ustc.edu,
  linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 15:32:16 +0200
In-Reply-To: <CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
References: <20240615125457.167844-1-rauty@altlinux.org>
	 <2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
	 <CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
	 <CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hey Rauty,

On Mon, 2024-06-24 at 11:25 +0300, Rauty wrote:
> I haven't changed the patch yet, but it's already in the stable-queue:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/t=
ree/queue-5.10/alsa-hda-realtek-enable-headset-mic-on-ideapad-330-1.patch
> Do you still need changes from me?

I still think this breaks Duet 7 sound, because snd_hda_pick_fixup
function picks the PCI SSIDs before Codec SSIDs.
But maybe I missed something.

Takashi, what do you think?

Best regards,
Gergo Koteles


