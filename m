Return-Path: <linux-kernel+bounces-235245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DEC91D232
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6571F213BE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BD1153563;
	Sun, 30 Jun 2024 14:59:10 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162E12CDBE;
	Sun, 30 Jun 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719759549; cv=none; b=Yhm7JYNA2gwgLek+i56XgF/hqn0NAKk9vbefqIhs6iGNo2yMQq9auXf+nZ27tvaLUtwJE7LdnH4dHGxVuIqLgFhkUN84f5j1IacvfeAYVOIsvXFuUKnd8pmTeGLCWRMAQt/vnZMW3AVvuThAKsDRfvDHqsNoPW6VNIqopeMCH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719759549; c=relaxed/simple;
	bh=fRMjtpuXIYvbpTQDAQK4oU2XSt0OZh0MHx2Yg1WVqXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFxbxpPmw3q/wC6QOpFTINreBxxoiivtEd21UpG9gK3izfQJyCA/pNmtmT90xVyHEb1qPb1WwR0q26XOcxaguufmG0hT/vQ4chsZ3mCnsx+HJbi0jNo4UC4C3py82pH7+1uboVAJPTIDwGjzkl2YJy297uFU7yDELiBY6ua6WIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 2DE5320027C;
	Sun, 30 Jun 2024 14:52:15 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id E16EFA008A; Sun, 30 Jun 2024 15:52:42 +0200 (CEST)
Date: Sun, 30 Jun 2024 15:52:42 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pcmcia: add missing MODULE_DESCRIPTION() macros
Message-ID: <ZoFjKv-xrW-XIqqI@shine.dominikbrodowski.net>
References: <20240607-md-drivers-pcmcia-v1-1-6014889a1324@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-md-drivers-pcmcia-v1-1-6014889a1324@quicinc.com>


Am Fri, Jun 07, 2024 at 03:02:58PM -0700 schrieb Jeff Johnson:
> On x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/pcmcia_rsrc.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/yenta_socket.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/i82092.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE(). This includes files which did not
> produce a warning with the x86 allmodconfig since they may cause this
> warning with other configurations.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Thanks, applied to pcmcia-next (although without the change to rsrc_mgr.c,
as that was commented out anyway, and with a few modifications to the
descriptions.

Best,
	Dominik

