Return-Path: <linux-kernel+bounces-183894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C08C9F83
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C3E1F21A07
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D720D136E37;
	Mon, 20 May 2024 15:20:56 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAA136649
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218456; cv=none; b=b/sxHVA+SAfFEERmpa08H2COB1+LlO/Jm7SmkL4dL2YhWdQ0dKRD3YG8jmaveXgnQ3h/fQwc4y6UNL41kRrU+o5iLAYvGEKxdK9xQXEzHO9fMB8c5S33OCoAn2D/J7hwTA0QKRtsH151GpTpnddsJ98pP2BhyMmt3QQ8xHf43iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218456; c=relaxed/simple;
	bh=+pgXsyd6XK8maucGpvWgMKFMQifoc0X71UZE8a2qISw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDFXopNaF2v6wvOG6u4DSG2cwIkiB7FTFehk48U+jvjz0eKf1lX2m3/m+Z4t/Z3dDd2bGO5vhMXdfsFUC9DBXUMDGoIpnMasRR8GfMMEdoL0luH1YKISveAySoljB/G6eV5slBBfp06sGxd4+S1EvMJJLroIfnEDQ7pzLMiwejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FBE768BFE; Mon, 20 May 2024 17:20:50 +0200 (CEST)
Date: Mon, 20 May 2024 17:20:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Christoph Hellwig <hch@lst.de>, richard@nod.at,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
Message-ID: <20240520152049.GB398@lst.de>
References: <20240505001508.255096-1-linux@treblig.org> <20240506070648.GA6506@lst.de> <ZktoVIG500he350_@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZktoVIG500he350_@gallifrey>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 20, 2024 at 03:12:20PM +0000, Dr. David Alan Gilbert wrote:
> * Christoph Hellwig (hch@lst.de) wrote:
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks Christoph; any ideas who might take this?

Probably Richard who is alredy on Cc.


