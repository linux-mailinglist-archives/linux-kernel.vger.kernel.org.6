Return-Path: <linux-kernel+bounces-234670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA591C94C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F011C22364
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A3824A1;
	Fri, 28 Jun 2024 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDc7DmPL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3A13AD12;
	Fri, 28 Jun 2024 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719614879; cv=none; b=rPa9Pmr/XvxvJ4Bi2dEIIObrpLZQSO5Ci4EB6Iu5km3e7WIkhc4G3Refw9/LlVatPX4LXFLtdhAioTVRXXOxP2JpWc32QaTbtEhF7WGvgbmMH1C8HamGCqxsm2RcBLj0tA901iPE2ShGkxWGBUFblUaanQw7NmXKrrTGOta7mpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719614879; c=relaxed/simple;
	bh=nUc92aZzSmfiZuXR49U6JmcFa5EHLz6CQ+N7uWdpTs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nilKth8KVZ9Neu11s9BnSRaF24BvBJRKkPgeLYXSoVFahscBkhqL+LtrboBmTkU5I/oerbJ+GawWhNwMx1kQ5WkW3tZPhE1tM85R0iVm/RA3d7oh9s1Vaavoo/SrSsLd80dcs0UQLOR2485JEoNM10l45/NgzbMPiD0FhdBoRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDc7DmPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2776CC116B1;
	Fri, 28 Jun 2024 22:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719614879;
	bh=nUc92aZzSmfiZuXR49U6JmcFa5EHLz6CQ+N7uWdpTs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDc7DmPLroi2czVUHCWkUx98Qq6Ly5uXIwqCdBlmX/qEe/+BScaunkpGRq82/V1JR
	 mgP05KFUjNODgqpZpsVSQdjK7vnWuDZqAMwz7l030CPkZobFSWwtm6VnXomoV7Nv9U
	 6qN5dVl2lDlxlcx0nMWytwtBupSI7AH1CZwtlMLHNtFHnefS6jCCKvnHTpb8GRVHYK
	 6zRMOKTXkpEEpsEftCfMFwhGcNadOXALh3EaZxEwGyM5PUD5IjUR8QLM3Mby5NX/IR
	 ViyDJ9e0gN2cMnPLLLGvQu918CJ5P+CXPrDFLLctkgH2Mf/vk8xmuiH9qNi5hSAu8W
	 Nnf6IjdmFurvA==
Received: by pali.im (Postfix)
	id 155F47A6; Sat, 29 Jun 2024 00:47:56 +0200 (CEST)
Date: Sat, 29 Jun 2024 00:47:55 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell OptiPlex 7060 to DMI table
Message-ID: <20240628224755.kxbyydhpoqeyyyzy@pali>
References: <20240628214723.19665-1-W_Armin@gmx.de>
 <20240628215704.i6ohbuz2zgegr27p@pali>
 <b4e555cf-dae3-4af3-98b7-15633eb3cc63@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4e555cf-dae3-4af3-98b7-15633eb3cc63@gmx.de>
User-Agent: NeoMutt/20180716

On Saturday 29 June 2024 00:43:08 Armin Wolf wrote:
> Am 28.06.24 um 23:57 schrieb Pali Rohár:
> 
> > On Friday 28 June 2024 23:47:23 Armin Wolf wrote:
> > > The BIOS on this machine is buggy and will in some cases return
> > > an error when trying to get the fan state, but reading of the
> > > RPM values and the temperature sensors still works.
> > Does this error affects machine usage (e.g. freeze of CPU or some
> > erratic fan behavior)? Or just kernel does not receive fan state and is
> > unable to report meaningful value to userspace?
> 
> Basically, it seems that the BIOS will return an error if the to-be-returned fan state is less than 2.
> Everything else seems to work.

Ok, if there is no negative impact then fine for me.

Acked-by: Pali Rohár <pali@kernel.org>

> Thanks,
> Armin Wolf
> 
> > > Closes: https://github.com/vitorafsr/i8kutils/issues/38
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > ---
> > >   Documentation/hwmon/dell-smm-hwmon.rst | 2 ++
> > >   drivers/hwmon/dell-smm-hwmon.c         | 7 +++++++
> > >   2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> > > index 977263cb57a8..74905675d71f 100644
> > > --- a/Documentation/hwmon/dell-smm-hwmon.rst
> > > +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> > > @@ -360,6 +360,8 @@ Firmware Bug                                            Affected Machines
> > >   ======================================================= =================
> > >   Reading of fan states return spurious errors.           Precision 490
> > > 
> > > +                                                        OptiPlex 7060
> > > +
> > >   Reading of fan types causes erratic fan behaviour.      Studio XPS 8000
> > > 
> > >                                                           Studio XPS 8100
> > > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > > index 48a81c64f00d..c75bfe93f2f6 100644
> > > --- a/drivers/hwmon/dell-smm-hwmon.c
> > > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > > @@ -1263,6 +1263,13 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
> > >   			DMI_MATCH(DMI_PRODUCT_NAME, "MP061"),
> > >   		},
> > >   	},
> > > +	{
> > > +		.ident = "Dell OptiPlex 7060",
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7060"),
> > > +		},
> > > +	},
> > >   	{
> > >   		.ident = "Dell Precision",
> > >   		.matches = {
> > > --
> > > 2.39.2
> > > 

