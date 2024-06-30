Return-Path: <linux-kernel+bounces-235403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35291D4A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F85B20626
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C714453363;
	Sun, 30 Jun 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="D9EsBDL2"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7B8F72
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719787592; cv=none; b=Hyv7KE7pvujbrOpvRG/D+KQf06q4YwKlu6vowNT6pewug6/FSbzyW5y82ucXDx0UcfgZ8zCN7y1dgFW8mrG0RYf3icJVMi5PEMcVJZ3lOZl1co7t1nbBzYJjHe2Y5bHTd2fDBADEJVWFB/Oo+Zn4JPAAe3eXP5HePUcFWJeLz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719787592; c=relaxed/simple;
	bh=3KYSHImy4sid1JqafwysJRfu6xujcLeRpReG88SWVuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oq+HL1efTyMQMd6lnCbNNJmcXKknrv3I46SlTHBqugEuzI/oHHQZL2sg4ezzaswcoLuIRicrxEtKu3frlPnmOKdH6bX1yRHxdqPmiwvdxVLJyQnGkiVDGr3Rcx96iqozrow3nGftjQKPcnwC2Zqnh+EYlM0NiGpsf3z3HkvjlTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=D9EsBDL2; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=8CNH/yok+eXaazKi2wQ8w+472tdh5r6qdmPijvgJ2KE=; b=D9EsBDL2ZEM25FHb
	QudG/ewHdhJRsEwKyitoT3r42hWBHYjraV+NgGqTrkwogaDeM72ieGIL+S1z30D0ZTBWCrbZ96kXL
	6RyzEk2+/f97xcMGNA0D7HhyUgPcg8xZcyDEhQDnayLrPwR7xJErxNYI9U1ZGjTeAYShXstkqi2KT
	qi+Ee5T8HahMpGs4QOwOPuoxvS8FBT+RREn5W0ehmEVbY1JszpfGUP1F5mcItZ+8/3I1QkzWIqjnX
	JMLRueTr0y4qOEfMk3L5G049n0dnhfcdYoLmqp+2zEkKC0cM7EGNBZGDmQq1o0u3FC1qvVmtDv1IA
	RyTlbtPYeogu1axN/Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sO3JL-009Cng-0i;
	Sun, 30 Jun 2024 22:46:19 +0000
Date: Sun, 30 Jun 2024 22:46:19 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH 1/3] parport: Remove 'drivers' list
Message-ID: <ZoHgOwCFjcYBeOMc@gallifrey>
References: <20240502154823.67235-1-linux@treblig.org>
 <20240502154823.67235-2-linux@treblig.org>
 <ZoHHVcYSOho2Yfro@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZoHHVcYSOho2Yfro@debian>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 22:45:51 up 53 days,  9:59,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Sudip Mukherjee (Codethink) (sudipm.mukherjee@gmail.com) wrote:
> On Thu, May 02, 2024 at 04:48:21PM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > The list has been empty since:
> >  'commit 3275158fa52a ("parport: remove use of devmodel")'
> > 
> > This also means we can remove the 'list_head' from
> > struct parport_driver.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Thanks!


> Greg, can you please take the series.

Dave

> -- 
> Regards
> Sudip
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

