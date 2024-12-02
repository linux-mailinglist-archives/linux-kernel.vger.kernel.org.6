Return-Path: <linux-kernel+bounces-428105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA269E0A34
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B084163E8C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C3D1DE4C9;
	Mon,  2 Dec 2024 17:37:20 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A51DE3D4;
	Mon,  2 Dec 2024 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161040; cv=none; b=ppr96aIevbNcVhxf/aeObSPRQPhbmwlZe+U9PTTYkjWnWZcJEpzlh2WLsoNKd/62mOLlYNhHreMFd1uHkFCpwUbns4aXliU+YF1ls7nUoiHpEKM4OmEPYOmJzV9RkppPe7POk5jrKD+3qu/E/XMlIfOtjdYrx+1UguMui6X0/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161040; c=relaxed/simple;
	bh=lY0nwyYr+hmQ+gxMvBOC1ASF88vvV9gPtMJ8xzolTD8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KPzeotjFAQgM6gsYyOD9ZpVxOxHfzpvnfgZ2E9rB2Pjt7NaK9P7TH41bfjqKLXArpL0IZ2HHjzBgWfifZcoDJntF0MfHvmo+7/I/xvFY5eyHKONhQPM9JJ058xoJxYqaGyC2MNWIMRdFoB5np3hI6YB5QVXa1tRHt3zE0Rd/piY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8FC5492009D; Mon,  2 Dec 2024 18:37:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8C5DF92009C;
	Mon,  2 Dec 2024 17:37:15 +0000 (GMT)
Date: Mon, 2 Dec 2024 17:37:15 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: kernel: Rename read/write_c0_ecc to
 read/writec0_errctl
In-Reply-To: <20241202153937.27640-1-tsbogend@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2412021732560.44939@angie.orcam.me.uk>
References: <20241202153937.27640-1-tsbogend@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Dec 2024, Thomas Bogendoerfer wrote:

> CP0 register 26 is used as ECC register for legacy cores, but newer
> cores (MIPS32/MIPS64) use it as an ErrCtl register. Since the kernel only
> uses CP0 26 as ErrCtl register rename the access functions to the more
> fitting name.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>

 Makes sense to me, thanks!

 NB there are further subtleties here, e.g. the 20Kc has DErrCtl at select 
0 and IErrCtl at select 1.

  Maciej

