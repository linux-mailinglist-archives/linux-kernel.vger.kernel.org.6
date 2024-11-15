Return-Path: <linux-kernel+bounces-410775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58519CE0D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B867283831
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6041CDA18;
	Fri, 15 Nov 2024 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="cS+R5H3J"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862D21B85EB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679257; cv=none; b=cIUXDelnE2+m4z+zZQ9zMnbKbkQmzbzAjkZjJp80MNG/TB0vredu4Buyvj6hLZAKKakdQidqJDQC9/kJHrI2W2Vv+hnBtACR4BApsr7c4Ao5ausaxacrqytV6qDFr8tEEVLSgcUkLonguDPE12JmmBgKfx42wXinbDwz8GGhK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679257; c=relaxed/simple;
	bh=O5EZBTdv+9Ec4m/iL06DJ9+nMWiGAD13ynW8aKjN0GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/LvHrb1Zgkl/TzaMLW7AgQJ+dGI1sZhK3nw3z0W8zyZN5aBrDzk1VSSZ5NzthvvAJReh0St3pQM2xqR5hSI/Wp4hyVOGKWv4IXQgkTz/1az4LluLyrHyVhjNoSoYyf/lFkdVD/0X6CRGPhYNeiSOp8LGuhpPSm5LRjRpexhWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=cS+R5H3J; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=zc5o8/zy9t1b970o4k5HJWlyozukbl2RkQKUf+Sh4hw=; b=cS+R5H3JAy8PI5E8
	CU0JWfp4M26biisS8XVpBVA9YfSThxJaiB0ZO4+RwFoSbggQvVQ7/Q+MkN9BmgfCo6+xx2jxJYMH2
	iOxdRAg+1nFtugqyEESuBAId01ZnWu3RSa1vyJ15vEtGOKQ8IdJ50unmiFtbrhZ8GancUtRWLy+ap
	JMPIKM22DHfk02s/PTTpGo4aikagqH10ar0q5VuTmljn4j23Ywt0YbnauQZUY2xjDm0xir3QgEUZI
	bOnQ8qo4EkTe8PKpF8pDGXL1bzW6SNVc0Dh2tIC3pYoi4/MdX/6QEPd+ox1zOHd5GyqJc+R+R1skb
	QZoAKbXCRr29rYfEjg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tBwsW-0007lZ-00;
	Fri, 15 Nov 2024 14:00:52 +0000
Date: Fri, 15 Nov 2024 14:00:51 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: stuyoder@gmail.com, ioana.ciornei@nxp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Of fsl_mc_allocator_driver_exit
Message-ID: <ZzdUE1E7ypErPuSz@gallifrey>
References: <ZzdRhcE2kG5z6NLk@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZzdRhcE2kG5z6NLk@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:00:20 up 191 days,  1:14,  1 user,  load average: 0.01, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Note  Laurentiu's address bounses:

Final-Recipient: rfc822;laurentiu.tudor@nxp.com
Status: 5.0.0
Remote-MTA: dns; nxp-com.mail.protection.outlook.com
Diagnostic-Code: smtp; 550 5.4.1 Recipient address rejected: Access denied.
+[DU2PEPF00028D04.eurprd03.prod.outlook.com 2024-11-15T13:49:57.944Z 08DD047932C9EF2B]

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> Hi,
>   One of my scripts noticed that fsl_mc_allocator_driver_exit()
> was added explicitly in
> commit 1e8ac83b6caf ("bus: fsl-mc: add fsl_mc_allocator cleanup function")
> 
> but appears to be unused; given it's a cleanup function it feels like
> it should be wired up _somewhere_.
> 
> However, I know nothing of this driver, so it feels best to ask you.
> 
> Thanks in advance,
> 
> Dave
> 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

