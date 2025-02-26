Return-Path: <linux-kernel+bounces-534117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF67A462F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3825A1895BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C771221C9E7;
	Wed, 26 Feb 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BCIPI4pU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9787421D3C3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580491; cv=none; b=NA5LK6f6SmpCT+UVTHjmz7XGbUyyku12Ha9UIF+68rGxC7tp5SfBgZ6V9pC/IQeRR/5Fa+kfel5l1Zu3HRKAlP1nMuU7xOYYdfFUdBi6oayxPaSfQgMi9j42IJj5gDjsUwwzyMu3Z454QsBsj6Ewl1pYDruAAXemwQJ9fTW/Pi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580491; c=relaxed/simple;
	bh=fsVj2Aus3xQzzjk0qAqr0Apz0tN8gWLbCfqS98wb8y8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRsW3/+Y0ex0/n/44hS5t0U3bsgJ+YRf6r9GWfPyCoGnP53p69L95fKJhALGCuHh6xmzyAESQFqtUHvozSzr0LcRcZD1xUPOsmFJo2K6WSz4vmxVcuU8DPIVqSqM20E+672VBUS3SsbAZTFj7raViZpOJFzzCVVzABSFvQEHksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BCIPI4pU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740580489; x=1772116489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fsVj2Aus3xQzzjk0qAqr0Apz0tN8gWLbCfqS98wb8y8=;
  b=BCIPI4pU5n78NQD0iww2X5rHeyd9lPTHvxJQpLyL1urbSAKGPBeXKm4b
   6sJ9mCuvVYLx5t08du+ZCYJfx5BeI3jcp8Vwtc84jvWds3gXQ5etyPkId
   i2WOwJFhF+Vm5AdaeQnbNvpCuQM5emMke+lYKJkASMn5ygbkm+Iw8p01s
   yZvwUGhWAjs0jNO7jwfpdVms/bn+vZWXM8vlXu2Qrs46+PvlcUkVGvl2t
   aA62p0pjdCE53BvZVqPHEeiu1wwX2oCR6nVnk8Vo40FU703rkxc9uCp91
   3PUfft3X4EgDGXt1glBThT47dbzkahwiuOvA+QOAFnWVU51TEWbjxCPdS
   g==;
X-CSE-ConnectionGUID: ZF1JjHn6RqyhKjwOKIMcxA==
X-CSE-MsgGUID: A9pe4hv+SyiQoyQRgDR0Yg==
X-IronPort-AV: E=Sophos;i="6.13,317,1732604400"; 
   d="scan'208";a="37753840"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2025 07:34:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 26 Feb 2025 07:34:06 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 26 Feb 2025 07:34:05 -0700
Date: Wed, 26 Feb 2025 15:32:12 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
CC: <Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <herve.codina@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] reset: mchp: sparx5: Fix for lan966x
Message-ID: <20250226143212.h2rtfxbbspdnmybq@DEN-DL-M31836.microchip.com>
References: <20250225105329.3037853-1-horatiu.vultur@microchip.com>
 <b31fa21c7bd352fe77d50da82c4d2c333b8566d8.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <b31fa21c7bd352fe77d50da82c4d2c333b8566d8.camel@pengutronix.de>

The 02/26/2025 11:27, Philipp Zabel wrote:
> 
> On Di, 2025-02-25 at 11:53 +0100, Horatiu Vultur wrote:
> > With the blamed commit it seems that lan966x doesn't seem to boot
> > anymore when the internal CPU is used.
> > The reason seems to be the usage of the devm_of_iomap, if we replace
> > this with of_iomap, this seems to fix the issue as we use the same
> > region also for other devices.
> 
> So the issue is the devm_request_mem_region() called by
> devm_ioremap_resource()?

That is correct.

> 
> Wouldn't it be easier to switch to devm_ioremap() instead?

That would be easier and the change set will be also smaller.

> 
> regards
> Philipp

-- 
/Horatiu

