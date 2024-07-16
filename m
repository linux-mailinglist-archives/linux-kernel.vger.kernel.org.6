Return-Path: <linux-kernel+bounces-253527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA16932282
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE03282C19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F39195806;
	Tue, 16 Jul 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="wpS3EleQ";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="QKhgT1+m"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563424C74
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121135; cv=none; b=GczJmItLqusBx/dzAQxqnlSsZU1sW0HaffRo03+AZ/zYT/S+cYNEUbuEGDEQFuUhAxLnPrY78T0OvHinFp6Se296FfualP6IlOzxZRGIa0ZfTuTO4oC/rmptEeQj3GBsxtq4wf0TPfxkUR9theHMcvp2IOiqtCaReIPG7SIFIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121135; c=relaxed/simple;
	bh=cn8laWEw/R0qZX8Uwjcw/OXji3PxPrYFv8/w0P3h1YM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu5xVy/pWWWAilWvE0KU3khppcnhK8Qrjoc3eOYaSHJNr21yszgaq5eRVysVz3i1toEPnLolfBCtTr3nKFkTh/S9fsC3cuZRz17eTq1lxjbpuzapy0gn1csZpfXFFiCdvVjmsKkFmkZzfDZWKncMJx/Bthx8ZINvj/9j6jhwMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=wpS3EleQ; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=QKhgT1+m; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1721121130;
	bh=oohzZY+Wm0D4VzzqujUnyVhaY5gL4QyC6/knv22SnCU=; l=360;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=wpS3EleQzlwiwFrYtUbN2ofMRAUNkSJ+hcnBGACI7Ng41iHzUhJ69cak1Tl4P1Lg8
	 A2RjPb6b7q5ZhLesekjsbmw8AE1ZHG9CmlPBGvTR538ipWH/+6JC6xyeX5w1xTbAVn
	 3ASRpRj821yAkKoncPor2jIzU7FkCwlxzFJy9u6PusBvbGBKmIse0SE8xYdlLI0UwF
	 whJBzvcXIoUrnIcAB45sgaH0wfAI70Bjo5vYtPppGTGCwVIuY9DhfNQTJRa2pocsNs
	 id3PbEiJu4GOR9FyW+REfXl6ZsoAVA2IqbAHQwkyrqfUWwWoZcr6xLovPAhAnywFvi
	 IhQFb2LNhsx8A==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(3190226:0:AUTH_RELAY)
	(envelope-from <prvs=1925402C87=cy_huang@richtek.com>); Tue, 16 Jul 2024 17:12:09 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1721121129;
	bh=oohzZY+Wm0D4VzzqujUnyVhaY5gL4QyC6/knv22SnCU=; l=360;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=QKhgT1+mjqqB3oZXqLKh+rc5RL6UVsFMpojA1B/a5s1km2phaGuaMXXg6XFjXyNPU
	 cjG1r1BeTZS9sp3GP7xD78IHLntrZ0Q0aRMz3OWY97ix6NNpyRhTBTwZMvql/wwBIu
	 OHEn+WEetRgV5vhH+IqKB3XNwJ5e9LBzoDxkl8lkc5ZTqd/QLsqp7fA9d4RpBwLbTC
	 gnkH1/Oyu9R5e6z9OiK9M2Rj/rDg+Qft9hFKafLMNkuIxuEI2n5fF7GpLM6XS54UIr
	 kf4XC1TnLql7fgJY9jd1qaM7SRQGmExJ6efhHVM6Ucqo3Ax2LTFnlbi7LCWAgchXqi
	 rUZVoO3BA2Q0Q==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(2680356:1:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 16 Jul 2024 17:04:21 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Jul
 2024 17:04:19 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 16 Jul 2024 17:04:19 +0800
Date: Tue, 16 Jul 2024 17:04:19 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Chen Ni <nichen@iscas.ac.cn>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: rt5120: Convert comma to semicolon
Message-ID: <20240716090419.GA17422@linuxcarl2.richtek.com>
References: <20240716084659.1252690-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240716084659.1252690-1-nichen@iscas.ac.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jul 16, 2024 at 04:46:59PM +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Fixes: c0216c0e68f7 ("regulator: rt5120: Add PMIC regulator support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---

Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>

Thanks, it's realy typo.

Best Regards,
ChiYuan

