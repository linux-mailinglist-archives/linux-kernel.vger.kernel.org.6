Return-Path: <linux-kernel+bounces-258338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CBE938689
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 00:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F111828111E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 22:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226E10979;
	Sun, 21 Jul 2024 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gZBiWND3"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931E8F70
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721602059; cv=none; b=lUOfUq1GJl+IW0tKwR0ijElTafIbN55NuknjQShip2XhPpZu3yn5zqrHVYmwbw3t4mPAHg5zYFws4zi3pxYC2KcPaYuvmy2SE5YqbaBsvTmvFa7/YcA3TnkpuAe+Ca/6uq3KirpnCOcgRynecjn/sX6CQzO2JjCHNhur96HqSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721602059; c=relaxed/simple;
	bh=jQHt9oddEnrbq4RAeZbYiFddt4cRNzfFtmyBd6u6RDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlPHTpXJoujKNigv7lerw2YM+B21vYH6uqSmjhyAHQyx1FhglcFVHCevb27nemFPNz1LNs/oqow0mn4+7f7TcqLWT+oyDL/1109Pn6DnygzZ0wP6xhH0VLtK7zO+E/BpI/xhpIt5GWZB9nc/Hvq8SVH+MDXgUulEHEjI87AyUp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gZBiWND3; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=wf1GcxlknvwtSORWOuDI5n4xTrP0+G3GLVBIf0VT1mw=; b=gZBiWND3aypWTmTI
	h+XQY32WJWiph7fRg/Qy0UzPZYXN7dLP2NuNWRXVNtJ+NQuq0WUlyz7RbSwZPTUGnsZm8/QoMjUMb
	RUcVelFNQEnQJmqgahb3DywwWhij14i+1aDs+ZXyG0attjR/H4Bqhvk9FHF3eCDW/oOHVbD9O33w1
	7GwKtn+OPoO45ZfLNWs39Uayjqgzv+ldfAjzMUe0efu0M1DAjaHUXSsTrxVOCmNvCazF1bmVo15Nz
	AeDYlBOn7Kyk64zaTfewvzwEN6SGh2IxNnnFvBmaWXfZEX7t4z22cBb1pFH01+uvto3AtJgGg2kKZ
	JorPotgMGNXZ1BBZVA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sVfL4-00CdPe-1s;
	Sun, 21 Jul 2024 22:47:34 +0000
Date: Sun, 21 Jul 2024 22:47:34 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: "Gupta, Nipun" <nipun.gupta@amd.com>
Cc: nikhil.agarwal@amd.com, abhijit.gangurde@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdx: remove unused struct 'cdx_mcdi_copy_buffer'
Message-ID: <Zp2QBoqAjKjABfJD@gallifrey>
References: <20240530233436.224461-1-linux@treblig.org>
 <01c9b471-705c-40f9-bb82-90a6cb651ff7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <01c9b471-705c-40f9-bb82-90a6cb651ff7@amd.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 22:46:55 up 74 days, 10:00,  1 user,  load average: 0.01, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Gupta, Nipun (nipun.gupta@amd.com) wrote:
> 
> 
> On 5/31/2024 5:04 AM, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'cdx_mcdi_copy_buffer' has been unused since the original
> > commit eb96b740192b ("cdx: add MCDI protocol interface for firmware
> > interaction").
> > 
> > Looking at lkml,  it was used in the V1 posting but was removed
> > somewhere before V6.
> > 
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> Acked-by: Nipun Gupta <nipun.gupta@amd.com>

Hi Nipun,
  Do you know who would pick this one up? I don't think it's made it's
way into -next yet.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

