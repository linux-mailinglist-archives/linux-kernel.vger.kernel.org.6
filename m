Return-Path: <linux-kernel+bounces-242365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F944928727
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC97284F69
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD822148FFC;
	Fri,  5 Jul 2024 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csVwHVGT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD93148823;
	Fri,  5 Jul 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176828; cv=none; b=VDCNDDdbbRVwtU/t9PLqmZnujzezCnjDOU7aUeqoY58ay4/B70OpiJU6sQHyFdk7YJGCCeCraEqZmSUTUPcxBvCKxJv2+o5MdeHJZ0EeUBv0RVT2iqhuYdo3ALdP4AT2mrb8Tc0MJk+YQKpZCmGAO2YmYwF3c0ZCcFYOPR8lmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176828; c=relaxed/simple;
	bh=deZ5CVzki2dlQ1nDscybgPumpHVNxsbMWwIchAdcmkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqjsp6Yp9zx2Ho+dQcJKzS6TaHEpSh6NPk+p3iLJtcfJRi1ENTEB6CSCUBZmBGVY+W9YG6dw5LAQDGv+MBro7jt8x3qOoSL3FbxetolIPIa+WpXM1Wcx68tYEKof9+zb5x0LpooQFfX6LrQFM4g6uNWHagLaFPFiIVhB0/zsvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csVwHVGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA67C4AF0F;
	Fri,  5 Jul 2024 10:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720176827;
	bh=deZ5CVzki2dlQ1nDscybgPumpHVNxsbMWwIchAdcmkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csVwHVGT0qIEKP81HIkI7H373oS6WdQcSDvc17RPERcwdxU9p8otnjJYWtaFaWiW/
	 ljzgwPGF7Ud6Su2g0NSnLya6NlNkMc9HBMZjqZt9H93OKRwRYR7f11E1DLuFGobzET
	 BY23GCTRXouM2+HWjATQ73JiPue6gbjLdE3U1UMfHmrJEtREl9cl65BUsjf1l4BbTO
	 eeXQhXl/hOmntyMp3qMnzKni6Gpg41NN+MxN1FOut5AYCnBP5cEL8xwYLNVSTGHTw6
	 5yIxn1JpFQYHRgqnzVYyS2loXL+YtfH7h7TsR70VDx0QAZJHWqtBFrFLoETIiaCJzE
	 67PPORvysyQ7g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sPgZa-000000006nP-1sJC;
	Fri, 05 Jul 2024 12:53:50 +0200
Date: Fri, 5 Jul 2024 12:53:50 +0200
From: Johan Hovold <johan@kernel.org>
To: vanillanwang <vanillanwang@163.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Rolling RW350-GL variants
Message-ID: <ZofQvjc0T6RXFOMz@hovoldconsulting.com>
References: <20240531024012.29805-1-vanillanwang@163.com>
 <Zn0SY4nQzESrQ4xw@hovoldconsulting.com>
 <5273fe7a.9647.190823077a9.Coremail.vanillanwang@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5273fe7a.9647.190823077a9.Coremail.vanillanwang@163.com>

On Fri, Jul 05, 2024 at 05:18:52PM +0800, vanillanwang wrote:
> >Can you be more specific about the other interface?
> 
> Hi Johan:
> On usbmode=64, the ports are: 
> 
>   MBIM(MI0)+GNSS(MI2)+AP log(MI3) + AP META(MI4) + ADB(MI5) + MD AT(MI6) + MD META(MI7) + NPT(MI8) + Debug(MI9).

Ok, thanks, I'll amend the commit message with this.

Johan

