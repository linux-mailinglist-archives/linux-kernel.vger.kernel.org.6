Return-Path: <linux-kernel+bounces-282325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD0994E23F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82AC1F214A5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816F1537C3;
	Sun, 11 Aug 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qYIqQARZ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9310C8E9;
	Sun, 11 Aug 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723393409; cv=none; b=tQePmURuCXZYz7JzeClvvjdTpdCxOpyvThd8QzeryETsaTTseA4EstIxxKc9E1SAXRZTiPSgv1Aasmg3O0Ba0F4sVgxaYPkbY4B2Omcvv2pDaFPxw39xcMWnHTbHxvS9oDGlIc6yBcmy8tbM+TCM804aByi/BJAYdSWhQu/MX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723393409; c=relaxed/simple;
	bh=mbMaQXcJ9pxMH9v+8fhSKC86hP2bA8HqHAsgOeWpPD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaBEz0M2GO7eU46yCxaACoPxOPlnB9Jrz+ciR7OEzBbjodm43cjSjIug/Vu4wVtkP/Pc0q9aIE9FymZelGsz57Omwooghzo3Fq2gdPNLr/PHIm/EyMs8kokqvljPkrLldTUx3Bqha84yrxY8nYUfjo0MreRTXi0DddMKR54yqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qYIqQARZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GwBmTO0fSXXHVUDt3kRYniEUVYID6vswgGU37C59G7Q=; b=qYIqQARZdWNIZQXOZprawbam4m
	nPXfS7ZRUTL26aMSjYYoutHqfwEhvigha/7MxkF7w/5zkU1mBugTkUwWN9nVxpyXBs7xHkOy5O5fB
	sU/Y3BaJ2yAG9OlLn0GgSqyXsSDMI9C7bUr9G/Po8Ht8AzhLNLGa2oBbmLAbIjSmSweU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdBLf-004Vfw-Ny; Sun, 11 Aug 2024 18:23:15 +0200
Date: Sun, 11 Aug 2024 18:23:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com,
	ariane.keller@tik.ee.ethz.ch, daniel@iogearbox.net,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net v2] net: axienet: Fix register defines comment
 description
Message-ID: <2dce7918-d65e-4341-bd1f-6e649e100475@lunn.ch>
References: <1723184769-3558498-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723184769-3558498-1-git-send-email-radhey.shyam.pandey@amd.com>

On Fri, Aug 09, 2024 at 11:56:09AM +0530, Radhey Shyam Pandey wrote:
> In axiethernet header fix register defines comment description to be
> inline with IP documentation. It updates MAC configuration register,
> MDIO configuration register and frame filter control description.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

