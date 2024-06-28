Return-Path: <linux-kernel+bounces-234399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F0691C61D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EA92856B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D37535DC;
	Fri, 28 Jun 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="gPiB1B86"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA734D8C5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600798; cv=none; b=bz3eS/jLWKHJEh8URP/aI+aXg4OXizJJlq8A3bf3r/569rEpjJe8VmOOL4sNcaVjrCb2lZpl0aALMYxvTvMZh+JUYgTxa+F0IpmfYbayQqoTyjOOHQJb0R5NqDh2ZR/gMVB+Y2mMfVT4RCMOvKdcjGCTCH+LiwgO90UovGoUTC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600798; c=relaxed/simple;
	bh=3p90Zo34Va7EB+3tQPrwwyuFwkq4klv/EZHxixPeugg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MrEbJvwsHZZRBy/f4oBclfwzywP1nN6xVe7rMIh2q+6lh1JqhCFYLzrBBqCowmsDljxruER2eKttERkMoeH+KWMD0bbo8VW5tUBMVhECNSP/Ds5W/6ZUGRjztpqP0g4wIDbxPdSNvP3kgROKdh/DeEhhSPvKn0rj08grAHawCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=pass smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=gPiB1B86; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jookia.org
X-Envelope-To: linux-sunxi@lists.linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1719600790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ol5vZWmzYCAtuPZvkV2jmiAnvzmCMXUkEioC5JggsN8=;
	b=gPiB1B86mnE70dlWle33ELiZCWlxK3uL2NGuS12wTJoFk7DW0qoHRufvn35raPdcC/ENqk
	LmdRP691WwONfx8wP5voen+IpJ2/Shes1KRp4fgZ7KPwi54GhJWvtcr+5C/KxQqPbVg6/3
	Bz5NwyO2tK7cNeZy+c4hHcTxkHniTncvX+LPMtS2/SaaLGxIB1/SaWmL4NVJgJnJ1Bf6uR
	5V1DTFASS2eJ5KmXvAedPdJNuY+QGx2W/Wo9sqsuGRVqboK2rNeHdZUQEBes/KoIP01t8T
	L0dP3ZUHcUEcjQsoqfrIWcpPkS2smu5X4g9GigCbZ7V7KUSMai8RH3DWAvc8qg==
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: jakobl.gm.g@gmail.com
X-Envelope-To: kirby.nankivell@gmail.com
X-Envelope-To: contact@paulk.fr
X-Envelope-To: mripard@kernel.org
X-Envelope-To: wens@csie.org
X-Envelope-To: jernej.skrabec@gmail.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: samuel@sholland.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Sat, 29 Jun 2024 04:52:06 +1000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: linux-sunxi@lists.linux.dev
Cc: andre.przywara@arm.com, Jakob L <jakobl.gm.g@gmail.com>,
	"K. James" <kirby.nankivell@gmail.com>,
	Paul Kocialkowski <contact@paulk.fr>,
	Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Samuel Holland <samuel@sholland.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: T113 TCON Top tinting troubleshooting
Message-ID: <Zn8GVkpwXwhaUFno@titan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hello,

On the T113 (and most likely the D1) sometimes the RGB LCD output has strange
artifacts such as:

- A blue tint
- A mostly opaque green tint
- A red tint
- A pink tint

The actual tint seems to differ between boards or chips, and has some
probability of showing up that can range from 50% to 90%.

After a week or so of troubleshooting I've managed to figure out what's
happening here, and I'm not too sure how to fix it.

It appears that the TCON Top on this chip can't mux both mixers to a shared
output. The R40 (and H6?) allows this and prioritizes the DE0 when muxing, but
on the T113 it seems to cause graphical artifacts. Disabling DE1 in the
device tree can help but doesn't solve the problem entirely.

Here's a change that tests this behaviour, it sets DE1 to output to TVE0. DE0
then outputs to LCD0 as usual. I would appreciate if anyone with this issue can
test the above workaround on their boards.
There was a previous discussion here:
https://groups.google.com/g/linux-sunxi/c/HxDBpY5HbbQ/m/mX2O2OYlCwAJ

---8<--- CUT HERE ---8<---

--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -179,7 +179,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 	 * At least on H6, some registers have some bits set by default
 	 * which may cause issues. Clear them here.
 	 */
-	writel(0, regs + TCON_TOP_PORT_SEL_REG);
+	writel(0x20, regs + TCON_TOP_PORT_SEL_REG);
 	writel(0, regs + TCON_TOP_GATE_SRC_REG);
 
 	/*

---8<--- CUT HERE ---8<---

The sunxi display code works around this issue by ensuring DE0 and DE1 never
map to the same output: If you have DE0 set to TVE0 and DE1 set to LCD0,
then tell it to set DE0 to LCD0, it will silently swap TVE0 on to DE1. 

I'm probably going to send a patch that copies this behaviour as it
should just work, but I'd be interested to see if there's anything I'm
missing.

John.

