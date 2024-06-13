Return-Path: <linux-kernel+bounces-213705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D029078FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F89A1F243EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EB2149C6F;
	Thu, 13 Jun 2024 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="a1i1kTVX"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF87149C6A;
	Thu, 13 Jun 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297935; cv=none; b=Dc36/+3xJS82mVsmukb0eis0i94FalnuymhW1AifSEBDV1EGhSc9TOkj1Of3hMvr0VcXdoaGoV7m4hUTE6eTXY/OQmJ20kG4E9DeU+kl7/V3iZsLzCFwIUVNNzVEYEk1yEREefXFR4p+4dh6rtsar70otSwXNvwvkHMRm2C7Wik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297935; c=relaxed/simple;
	bh=6u+NhXdFVO3k8i1c1rzwLCRp9nsLuhq6+/8Mt0uxOwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQh4IKLYv+LTjZmGJ6miwo13DTlgxO682OhSxeuoSYh6pl4bKOR83QfYrt/fnHrK3hwE1UMW9zSdT02121yGSpbKSTnw1vF1ureRg04l6A+dGeaWSjSmo62/fK42TBMDCu/ilH3yQNflkch3ZFivNobBw3nZ6/8p8BJOxJI0Avo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=a1i1kTVX; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=poj+Qvco2Pg30XXjoM/PpwizdBw3VYd+GQTsThXG5bs=; b=a1i1kTVXB8yUBOLy
	hDHDkBe61NUkGzaaPux5/CDfTFU2FEYUPua/JLOLmm42jjK8l9ojymlSo6L5cdjGxXTj14VbBvZaZ
	B9M2ZBP4pcmiREGaIwDE+RnxYyneiwCh2PMWpm4Qs4dy37xT6qTNPC4ohr8qMCtYyW3gwM+Q3Qmsw
	fVh1oTBHTI7NFjKxaV6JQLJ4Dsvh7y3vFmWEXx3y838k45wn2LUeLFNKKusVZwGjbOcwbPAEgEmnL
	QHyDsII3+r+Y9PsP5SugW/AWX6iZ2VtC2ChYhnLlvBpGQxi9d5ukqe2ww4HovdCkzPl7/sXgsTD4d
	vEqtjfs+CL9yBm3ICA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sHnmk-0065pg-1C;
	Thu, 13 Jun 2024 16:58:50 +0000
Date: Thu, 13 Jun 2024 16:58:50 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: johan@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: spcp8x5: remove unused struct
 'spcp8x5_usb_ctrl_arg'
Message-ID: <ZmslSsXK3njLZwIy@gallifrey>
References: <20240529234722.130609-1-linux@treblig.org>
 <Zmr0GV57EGwxcYeM@gallifrey>
 <2024061357-lagged-cloud-a2a3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2024061357-lagged-cloud-a2a3@gregkh>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:56:35 up 36 days,  4:10,  1 user,  load average: 0.06, 0.03, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Greg KH (gregkh@linuxfoundation.org) wrote:
> On Thu, Jun 13, 2024 at 01:28:57PM +0000, Dr. David Alan Gilbert wrote:
> > * linux@treblig.org (linux@treblig.org) wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > 'spcp8x5_usb_ctrl_arg' has been unused since the original
> > > commit 619a6f1d1423 ("USB: add usb-serial spcp8x5 driver").
> > > 
> > > Remove it.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > Ping?
> 
> It's only been 2 weeks for a "remove some unused code" type of patch,
> which will be gotten to, but realize that people are traveling and the
> like...  Give it some time.

OK, it was only a gentle ping, not a moan; and that seems to have
unstuck a few others in the large set this is part of.

> In the meantime, why not help review other patches on the list?

Sure, I'll keep an eye out for stuff that doesn't require too much
detailed knowledge of any particular subsystem.

Dave

> thanks,
> 
> greg k-h
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

