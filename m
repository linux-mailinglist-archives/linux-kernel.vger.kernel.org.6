Return-Path: <linux-kernel+bounces-183689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362098C9C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E104C1F22A43
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F7436134;
	Mon, 20 May 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DNGKbJlZ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE6856B95
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205766; cv=none; b=JR4adD0xn+CBWnOret4vn7Tk+XLw3cKJtKzmCVZYS/zYpE4PstDxRNUh6OyCfiYE6ddCt4J0CrhFmdRqZoQO34oYTIaSUPF/dvdJlxDKAMrwFWsrZbWaFl+XoghGAAwl2/KyqS3YKRdHiFWaUYPu1YZQfPBBGDtRbfAPHvXOT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205766; c=relaxed/simple;
	bh=t+pjIpHWwVWoGbu51U5Ft4pHw3iODZAWJ3ANRxuiE+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SveLzJOef5Vwm4FEyuUWN8dsf/Cpl8eY8s3XaYb4+ks0uQdhen9JItbFUzvfYO8xjt3T7u4CrKxqKAmrmWxbVM0Dt1u2Mgd7hSaciSXV/qN5aMusBAz9+ItctpZ4TYbbcfJt0xY5eOC7P4mX+eJgwGL+gNfxy85MXTXWC0uVGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DNGKbJlZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3EE90593;
	Mon, 20 May 2024 13:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716205745;
	bh=t+pjIpHWwVWoGbu51U5Ft4pHw3iODZAWJ3ANRxuiE+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNGKbJlZrNf3oQc7C9GUCb1SB0E+JtDzszFNDXDkBa1DqtFAbnvCB/aZkW1JvuX3r
	 Jn2bODQ1RJPZPwMV1RsdsDr3IoFD7YcTWgnVoZXGczuxitFb22ThkCzAa8DauSNzOc
	 u9764CMP3/eryWYwC9FK4JJFaZmf6YsX91VN4t/g=
Date: Mon, 20 May 2024 14:49:07 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: open list <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	David Airlie <airlied@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Oded Gabbay <ogabbay@kernel.org>, Olof Johansson <olof@lixom.net>,
	Lucas Stach <l.stach@pengutronix.de>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: DRM Accel BoF at Linux Plumbers
Message-ID: <20240520114907.GA6275@pendragon.ideasonboard.com>
References: <CAAObsKAw174AhGaA13Hyw0ANW=TxJHpK10+OwQGNMVca85Urdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAObsKAw174AhGaA13Hyw0ANW=TxJHpK10+OwQGNMVca85Urdg@mail.gmail.com>

Hi Tomeu,

On Sat, May 18, 2024 at 10:46:01AM +0200, Tomeu Vizoso wrote:
> Hi,
> 
> I would like to use the chance at the next Plumbers to discuss the
> present challenges related to ML accelerators in mainline.
> 
> I'm myself more oriented towards edge-oriented deployments, and don't
> know enough about how these accelerators are being used in the cloud
> (and maybe desktop?) to tell if there is enough overlap to warrant a
> common BoF.
> 
> In any case, these are the topics I would like to discuss, some
> probably more relevant to the edge than to the cloud or desktop:
> 
> * What is stopping vendors from mainlining their drivers?
> 
> * How could we make it easier for them?
> 
> * Userspace API: how close are we from a common API that we can ask
> userspace drivers to implement? What can be done to further this goal?
> 
> * Automated testing: DRM CI can be used, but would be good to have a
> common test suite to run there. This is probably dependent on a common
> userspace API.
> 
> * Other shared userspace infrastructure (compiler, execution,
> synchronization, virtualization, ...)
> 
> * Firmware-mediated IP: what should we do about it, if anything?
> 
> * Any standing issues in DRM infra (GEM, gpu scheduler, DMABuf, etc)
> that are hurting accel drivers?
> 
> What do people think, should we have a drivers/accel-wide BoF at
> Plumbers? If so, what other topics should we have in the agenda?

I'm interested in attending, even if so far I have limited involvement
in that area. Looking forward we're considering usage of ML accelerators
in libcamera for various purposes, so an open ecosystem will be crucial
for us.

-- 
Regards,

Laurent Pinchart

