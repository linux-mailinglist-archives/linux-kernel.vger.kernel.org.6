Return-Path: <linux-kernel+bounces-310800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D770968164
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6672829A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74B9181310;
	Mon,  2 Sep 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="sb3zPMR1"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94A1552FC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264553; cv=none; b=XypVpDki1BiBgupmfLfb2j5cvDXBRsJi2/t/dR0HrGh4WsthIseBfD+hpG3lWTHmF0TBDDGeCOPBh1k866dAVxNAFwkqy72flhQrXw0szvxa3GHcnwX+aehhWW3BmkR0qhGIsOA3GbGYTOVzAzDEul01c+NmXrhxVDPycoMIknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264553; c=relaxed/simple;
	bh=WC3jG9tS1et0+mConJyOnPalBSVJ73PEP2fLyGIzyKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN80gyijSIFEtJG5X3Csd58hrs/Y/J5Qcql4a4n9hQfYn6FuwA4KZoWqjKimbEjV53gUyh+sqFCeaAG5pueaO1EDoGPr1aMzOu0cZjC9hiVyDBGFBh2gm0nTjuWach2YhyRePpd5+hbZ5831A29CWik2sdq2dNhYGkKjha/RlKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=sb3zPMR1; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D24611483EC1;
	Mon,  2 Sep 2024 10:08:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1725264541; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ccJDTPXZcZ9nhWTLUFalOuzqIzRqEigAQpvJAh2sXck=;
	b=sb3zPMR1ZPkD2yV8IsudrWNW6WsugqOVLque75JE0JOlRUk5JfKMUff+wAQspIVCFanhBF
	DZ058uko8CoRNXEd/XJpzlMdYAQ7oruqvnJ4Tg3z538BK4rnB4yyhOMQLjCBrc6exqBdIk
	E242mShcTGaQlWaSjZ9yd/XPpTioyVPHpg1SseFihCiEm8tnkslf2uXhVPjxb43rYzlhUM
	+uHv+xYKSqaA3GHbnB1tYP8yxUCftsMpqbtsUCovKFGSECUwL6wpVI+PZXZLW3SfJsQQj4
	ydt2lYj/j6xB6sfSlUCNtH7cHwObOQoOLP605e/5p2FKS161OUe+puQPZviELw==
Date: Mon, 2 Sep 2024 10:08:49 +0200
From: Alexander Dahl <ada@thorsis.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	"moderated list:MICROCHIP OTPC DRIVER" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v1 07/12] nvmem: microchip-otpc: Add missing register
 definitions
Message-ID: <20240902-countless-applicant-e726bda10200@thorsis.com>
Mail-Followup-To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	"moderated list:MICROCHIP OTPC DRIVER" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-8-ada@thorsis.com>
 <5228af83-b423-4f51-820a-edfc40017ca8@tuxon.dev>
 <20240828-making-gangrene-786ec368b106@thorsis.com>
 <aeed6b52-98df-4515-a3df-5ccc8429e022@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeed6b52-98df-4515-a3df-5ccc8429e022@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

Am Sat, Aug 31, 2024 at 06:33:50PM +0300 schrieb claudiu beznea:
> 
> 
> On 28.08.2024 11:14, Alexander Dahl wrote:
> > Hello Claudiu,
> > 
> > Am Sat, Aug 24, 2024 at 06:54:02PM +0300 schrieb claudiu beznea:
> >>
> >>
> >> On 21.08.2024 13:59, Alexander Dahl wrote:
> >>> According to datasheets DS60001765B for SAMA7G5 and DS60001579G for
> >>> SAM9X60.
> >>>
> >>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> >>> ---
> >>>  drivers/nvmem/microchip-otpc.c | 15 +++++++++++++++
> >>>  1 file changed, 15 insertions(+)
> >>>
> >>> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> >>> index b8ed7412dbca..4630e96243ac 100644
> >>> --- a/drivers/nvmem/microchip-otpc.c
> >>> +++ b/drivers/nvmem/microchip-otpc.c
> >>> @@ -21,9 +21,24 @@
> >>>  #define MCHP_OTPC_AR			(0x8)
> >>>  #define MCHP_OTPC_SR			(0xc)
> >>>  #define MCHP_OTPC_SR_READ		BIT(6)
> >>> +#define MCHP_OTPC_IER			(0x10)
> >>> +#define MCHP_OTPC_IDR			(0x14)
> >>> +#define MCHP_OTPC_IMR			(0x18)
> >>> +#define MCHP_OTPC_ISR			(0x1C)
> >>> +#define MCHP_OTPC_ISR_COERR		BIT(13)
> >>>  #define MCHP_OTPC_HR			(0x20)
> >>>  #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
> >>>  #define MCHP_OTPC_DR			(0x24)
> >>> +#define MCHP_OTPC_BAR			(0x30)
> >>> +#define MCHP_OTPC_CAR			(0x34)
> >>> +#define MCHP_OTPC_UHC0R			(0x50)
> >>> +#define MCHP_OTPC_UHC1R			(0x54)
> >>> +#define MCHP_OTPC_UID0R			(0x60)
> >>> +#define MCHP_OTPC_UID1R			(0x64)
> >>> +#define MCHP_OTPC_UID2R			(0x68)
> >>> +#define MCHP_OTPC_UID3R			(0x6C)
> >>> +#define MCHP_OTPC_WPMR			(0xE4)
> >>> +#define MCHP_OTPC_WPSR			(0xE8)
> >>
> >> Are all these used in driver?
> > 
> > Not all, but some.  What are you implying?  Only add register
> > definitions actually used in the driver? 
> 
> Yes!

Okay.

So if I drop the patch with the warnings on driver probe you did not
like (checking for pre probe error conditions in interrupt register
for example), then it is just the MCHP_OTPC_UID0R and I would squash
that one definition in the last patch adding the nvmem for the UID
then, okay?

Greets
Alex

> 
> > Why?
> 
> Less code to maintain. If it's not used there is no meaning to have it.
> 
> 
> > 
> > Those register offsets won't change, but helped us when debugging.
> > Debug code (e.g. register dump) is not part of the patch series.
> > 
> > Greets
> > Alex
> > 
> >>
> >>>  
> >>>  #define MCHP_OTPC_NAME			"mchp-otpc"
> >>>  #define MCHP_OTPC_SIZE			(11 * 1024)
> 

