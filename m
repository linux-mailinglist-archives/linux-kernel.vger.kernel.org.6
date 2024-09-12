Return-Path: <linux-kernel+bounces-326671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F18976B88
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933281C23C22
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF7C1BAEF0;
	Thu, 12 Sep 2024 14:05:16 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88711B12E7;
	Thu, 12 Sep 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149916; cv=none; b=TTh3FC2Ja5VF5JhFbcxTBHFOv8QeP5PrDGzr+oGLyLil4ibGrfnxf0LPxNBxBQC6JjFNtyY9Cx92/OgbILLoVTtCl20xkxhZp0dG02eWRdtV1f/Aov8QkM0ije31sFwVyAWPV6rKOyzRBTswt/Mp8ewLwINRswdc6I7gskdYh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149916; c=relaxed/simple;
	bh=tvZT+EY1C/xob+ZGzamqIunjoJ/WdRSA+cwBY5rQqDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUDd463E5tDXWadIZpHCqxS1OyhWJF24Nz9F7tAQvXrclg5fm5R0QQGcap+ICUpEqCz5cEsPKQxuhk4gGtpppNZ8pRRCKl+vnk222qhQNoWG/M2Ozp7S11daHqXqw+EhaAUt1wAnYGL6alFL+Ra9HuDJy5+9ErfmLjTI+kVYfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BACED227AB5; Thu, 12 Sep 2024 16:05:09 +0200 (CEST)
Date: Thu, 12 Sep 2024 16:05:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jon Kohler <jon@nutanix.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Tony Krowiak <akrowiak@linux.ibm.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>, Rohit Shenoy <rshenoy@nvidia.com>,
	Tarun Gupta <targupta@nvidia.com>
Subject: Re: [PATCH] vfio-mdev: reinstate VFIO_MDEV Kconfig
Message-ID: <20240912140509.GA893@lst.de>
References: <20240912141956.237734-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912141956.237734-1-jon@nutanix.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 12, 2024 at 07:19:55AM -0700, Jon Kohler wrote:
> Reinstate Kconfig setup for CONFIG_VFIO_MDEV to help support out of
> tree drivers that use VFIO_MDEV library (e.g. Nvidia GPU drivers).

NAK.  This is an internal symbol and the kernel could not care less
about out of tree driver.  Get the drivers upstream if you care
aboyut them.


