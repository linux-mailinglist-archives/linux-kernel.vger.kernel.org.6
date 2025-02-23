Return-Path: <linux-kernel+bounces-527979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DF4A411F7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 22:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDD416F047
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A38C23F277;
	Sun, 23 Feb 2025 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VXHMR+T2"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885AB288DA;
	Sun, 23 Feb 2025 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740346992; cv=none; b=HmddjJ9FBSQh/s7Hz54QXsZb1rb+5LAonYLNSg9iPSxFAybO1Pm1tAkFWXtF3gJPe+eAYKzMMQChe1l0rAtdNrzPzsqVurOIn8GWYbEYoEM12taW9v2bnfh0GFVvDpk5fNp5bkdNeUFhxW1zvWxGlzgIFkymJRl5AVUSaLmJlZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740346992; c=relaxed/simple;
	bh=YiCbKAMI8ItG8w1Xt7VwuCUfo3aw4uZjliERsHSzwpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKMhTXqhD7ooHHDmkSgvA/rK7CWgWHhQp0xWACPsYgoE1VYrjxf5HYBfqAMhRH6CdFPHwPK7CgDxqekVOC4NfQGc+CM5CI776u5u9av7zbUjWmI6EUahhd0w8qzWBq1uNewRAElwKLbBykTFQlS3BR2Co2H9pYPm9hRf2igHNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VXHMR+T2; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=wqhPYelRI9w8kPH+DxFgKT67v+9/rXFIBWG/hG5C3TQ=; b=VXHMR+T2i1Nl3z8k
	h2nQplqOMz5KQo+TP3TlXDxfwu/I+T/Lj+N9ZAA0rezbkBusLv2tMAFxyKEdOwAqZDYPxLYRELXf1
	Ov1iM9oB+aoARdQwsGA4JRGQJHsnjB2R150tErOCRCLvr8ErpW+EEJpBRPoKiQAHDx6/DUrtj5cMi
	EG8E5CZNJx1F6POpHHRbceOz45jvTEfbCNq7W4pKPuGJ8nebjbjwhV91XjqLmvnxLTBOc78/VLMa6
	ik5zEMoX97SuOSg7Cf/bamEFRap1wu5VwY1VKuZZ5ih+uSvn/aAMn45DQ4JoR821Ia/G1EV+fFtCE
	sUxxsXCA0E4zws2j+w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tmJke-000Drl-2H;
	Sun, 23 Feb 2025 21:43:04 +0000
Date: Sun, 23 Feb 2025 21:43:04 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: olpi: Remove unused otg_ulpi_create
Message-ID: <Z7uWaAmPPTZD05k-@gallifrey>
References: <20250223160602.91916-1-linux@treblig.org>
 <3315dad1-52a8-4ae7-be65-6b9ccf3dfbfe@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3315dad1-52a8-4ae7-be65-6b9ccf3dfbfe@omp.ru>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:42:30 up 291 days,  8:56,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Sergey Shtylyov (s.shtylyov@omp.ru) wrote:
> On 2/23/25 7:06 PM, linux@treblig.org wrote:
> 
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > otg_ulpi_create() has been unused since 2022's
> > commit 8ca79aaad8be ("ARM: pxa: remove unused pxa3xx-ulpi")
> > 
> > Remove it.
> > 
> > The devm_ variant is still used.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  drivers/usb/phy/phy-ulpi.c | 23 -----------------------
> 
>    Probably s/olpi/ulpi/ in the subject then?

Oops, thanks!

Dave

> >  include/linux/usb/ulpi.h   |  9 ---------
> >  2 files changed, 32 deletions(-)
> > [...]
> MBR, Sergey
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

