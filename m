Return-Path: <linux-kernel+bounces-436193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F19E8251
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D00B18821CF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CBF154435;
	Sat,  7 Dec 2024 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="oWTrBWvG"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75CBD27E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733607341; cv=none; b=e0FU4avlu0kwj6zwVhy5f8ZFKFkPND0z9e9MwrYRQSoRaLYf6sQm/wlqoSroO6YUr5Jy+Gpn/drM/Cij8oNjwnm80ZxHjrdiqFK2wzDNvjKavyL3HDNfbtUj3S+9Vqrz9jAOp82rPLUGOv3nbOJcraZIU7/BsJ8ZjBMiNOLzzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733607341; c=relaxed/simple;
	bh=l52dFGLHGTqFMz+PPK1bTD97WwJw4J0tyC8BdjHB3JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BosjrSyyXnQ3FORxerkSG2vixrMVaSIWBopjEPACUNTdFgRJKyfVbH1G/dmCN5SrrSisnJVTtHaq+6YE4SIY7UR3staE6ctk5zn9Ld2PU5KHygK5LPTCfJHTo8Sry0PuT3hc7q3EcQz5VMrk/5UtHrFymrrvR+B1EbIzyy50TMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=oWTrBWvG; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=H/THJ6MK8FAxWM9go2fH8jyav9zXsKFgHcGRTFxSEWw=; b=oWTrBWvGOUApsdxq
	JE89lKtzPUWaJZmkjyDmMNlt/O0BtxSx+H5Q1q7fKRRPAhqats9YfzriwBQ2vDjtX5i+rZ01M94oI
	C2NJeTeCaglBFXUQhATcXi/xijuCW+SXfUPCWMYGfmzPWkyuWl2iI3ajYpuZn9nLU+drbUNY+5vTG
	LEWvpgHYtnxbk59kww14vzDKs0xMgPYsKFe2E44R3yeBPl9YJAjS8dIoTLM+9MvDoqwHwrLNqCkVs
	mBIevTM1XOd4ICg5dr5o6stAKNq74Exozc6tfl90DB5vq2AOkhghCMYCQ2GS4O4wLXSEpof7uT6mp
	AA/ibP9LFtMDJJFCNg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tK2Se-0042oX-39;
	Sat, 07 Dec 2024 21:35:36 +0000
Date: Sat, 7 Dec 2024 21:35:36 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] extcon: Remove deadcode
Message-ID: <Z1S_qH4M-5Tubk3r@gallifrey>
References: <Z1Jg2zRT9ecClJH7@gallifrey>
 <20241103160535.268705-1-linux@treblig.org>
 <CGME20241206022643epcas1p1db6da634d4da398f553b7dd3cfa3339f@epcms1p2>
 <20241207045814epcms1p21e267fe70a87d06cdd4c531248f193e9@epcms1p2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241207045814epcms1p21e267fe70a87d06cdd4c531248f193e9@epcms1p2>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:34:40 up 213 days,  8:48,  1 user,  load average: 0.03, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* MyungJoo Ham (myungjoo.ham@samsung.com) wrote:
> From: Dr. David Alan Gilbert / linux@treblig.org
> >* linux@treblig.org (linux@treblig.org) wrote:
> >> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >> 
> >> extcon_get_edev_name() has been unused since it was added in 2015 by
> >> commit 707d7550875a ("extcon: Add extcon_get_edev_name() API to get the
> >> extcon device name")
> >> 
> >> extcon_get_property_capability() has been unused since it was added
> >> in 2016 by
> >> commit ceaa98f442cf ("extcon: Add the support for the capability of each
> >> property")
> >> (It seems everyone just uses extcon_get_property)
> >> 
> >> extcon_set_property_sync() has been unused since it was added in 2016
> >> by
> >> commit a580982f0836 ("extcon: Add the synchronization extcon APIs to
> >> support the notification")
> >> Everyone seems to use the none _sync version, and there's one place
> >> where they just call sync after it.
> >> 
> >> Remove them.
> >> 
> >> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >
> >Gentle ping please; no rush.
> >
> >Dave

Thanks for the reply,

> It's not a dead code.
> 
> Example: https://github.com/diphons/D8G_Kernel_oxygen/blob/b0717c360f5485badf824fb51cdc8174e2e0a7cb/drivers/usb/dwc3/dwc3-msm.c#L2992
> 
> There are drivers (usually .ko) using them, usually Android mobile devices.

Ah hmm;  ok, I'll drop that.
Of course it would be great to get some of these upstreamed rather than us
having mysterious interfaces lying around for ~10 years!

Dave

> Cheers,
> MyungJoo
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

