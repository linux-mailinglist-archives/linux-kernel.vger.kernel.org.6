Return-Path: <linux-kernel+bounces-197865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB58D8D702A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB521C20E1B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95EB15099F;
	Sat,  1 Jun 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="EZSb5/Cq"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC928C04;
	Sat,  1 Jun 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247868; cv=none; b=PNHJBB8OV4CFiFQ7zNjI4bTAwg4FrOoda2w3obJb9C9iXUi3GFmtQavnbw/45xmHJ+1h/bDRnvRycbLiIGCVR2zny51KQWk+n1KqQitaHgwK/D9OuxFnmQw61UJIdYCZNWnnKrr4RX9q8a3dp49Afyz1PE6ImLZ7tL4yJEbRprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247868; c=relaxed/simple;
	bh=uPrCuZ3Ei1gyQy6K3DGtuOuETYkHUYBNhjUla7mAorM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsusO+1dFrFnYd/VXf/HelPqy9KpQ7pvwK11t2GGrfTRumA63A8e4UmnDYGcqjSXVil9Pr4o7uxlnE1YVMlFs+WDNmHQ6NjyR57vCpEsvXbv3bZdDDwq3favHmi12O+YuFCFr2YCpNJXyuN4GL/3tbxHDJT2RNRgyWotw/GuzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=EZSb5/Cq; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=+y8rnCbC5QYKXVWHLiiou6eTUqBo3oGctM0zE1/ZJ80=; b=EZSb5/CqKPBNHJzR
	J84wFQs4vKAStZzwd6SKyRUqCb5dzJYiW9prWsuHarTAosPzeqoAVT8E5S9VcP17AgwHlK4iohKqc
	mZsm2eaOzPVw5Qj9MaeAulNyqr7frQN9XQxwqxDDF/iFu0bYFCQzQjD65bD8R2x2SJdTUeOoK2d5Z
	M1QUmSPjQW5nA0ynqi1kmcTCPmxoAz2HdU2OzqUgu8uJgZ55YrWAhp6KB+mJqPRVLp+zDWEpyG2tn
	gS3owc/dNz9LwX4W6W0QwAh3cOKbk0EtJ4CRcVB07E7fU87xH71LnDVso660IxMF6BfXwUwg7qajL
	FFv2T/ASn/EWeJXYBw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sDOcB-003jPL-14;
	Sat, 01 Jun 2024 13:17:43 +0000
Date: Sat, 1 Jun 2024 13:17:43 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8712u: remove unused struct
 'zero_bulkout_context'
Message-ID: <Zlsfd9Eq5jecxRZq@gallifrey>
References: <20240529000814.233690-1-linux@treblig.org>
 <971c164f-5ebf-44cb-8cff-3a09c63bb77e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <971c164f-5ebf-44cb-8cff-3a09c63bb77e@gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:16:28 up 24 days, 30 min,  1 user,  load average: 0.01, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Philipp Hortmann (philipp.g.hortmann@gmail.com) wrote:
> On 5/29/24 02:08, linux@treblig.org wrote:
> 
> please remove the following line:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> To me it is not important which commit introduced the struct. This is not a
> bug. So I would omit this lines and use instead just:
> Remove struct zero_bulkout_context as it is unused.
> > 'zero_bulkout_context' is unused since the original
> > commit 2865d42c78a9 ("staging: r8712u: Add the new driver to the
> > mainline kernel").
> > 
> please remove the following line:
> > Remove it. >

v2 sent just now with changes as requested.
(Although I think you're the only person who has asked
to remove that detail, most seem to like it as a hint
as to whether there's some reason it's unused).

Dave

> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >   drivers/staging/rtl8712/usb_ops_linux.c | 7 -------
> >   1 file changed, 7 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
> > index b2181e1e2d38..0a3451cdc8a1 100644
> > --- a/drivers/staging/rtl8712/usb_ops_linux.c
> > +++ b/drivers/staging/rtl8712/usb_ops_linux.c
> > @@ -26,13 +26,6 @@
> >   #define	RTL871X_VENQT_READ	0xc0
> >   #define	RTL871X_VENQT_WRITE	0x40
> > -struct zero_bulkout_context {
> > -	void *pbuf;
> > -	void *purb;
> > -	void *pirp;
> > -	void *padapter;
> > -};
> > -
> >   uint r8712_usb_init_intf_priv(struct intf_priv *pintfpriv)
> >   {
> >   	pintfpriv->piorw_urb = usb_alloc_urb(0, GFP_ATOMIC);
> 
> 
> Hi David,
> 
> I would prefer the following changes:
> Subject: please change from r8712u which is the compiled driver name to
> folder name of the driver: rtl8712
> 
> Please also consider the above hints.
> 
> If you send in a second version of this patch please use a change history.
> Description from Dan under:
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
> 
> Please contact me for any questions.
> 
> Thanks for your support.
> 
> Bye Philipp
> 
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

