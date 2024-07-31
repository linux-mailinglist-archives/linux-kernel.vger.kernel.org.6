Return-Path: <linux-kernel+bounces-269153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ECC942E63
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F56F1C21618
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E51E1AED3B;
	Wed, 31 Jul 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oTdRB6HM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F72E40E;
	Wed, 31 Jul 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428692; cv=none; b=Etqs4WB8WrcNoNI6hFmH/sQgttnpo13dUJZ1Y0cZNDEfPsBen5h8+ffZSmkp7jsdSx1hiysZooIIVAfwpncYCbJtbJ2bv3EozKA+sZ5+wMwCSOd551xhRAyziGewhGjVvrf26cbia2VRDH5DhLPgatxWZ34peViZifJSDzfC0aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428692; c=relaxed/simple;
	bh=0anNzBpKovF2Z2rT0OXvMny0oFIf5sDVEn8xg+1pawY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u29wVVYO7vuNBV/D7OeuR9zBMV8m5tvVs8anEIBKbfQXdYpGeTM4DaLSxndHHw/ONVrk+MiN1Z09nQV9ymT1wPM2zH0Yci186Cr6xYI3czyUvKqCNlCRw1D7FEQO5eIyb60q0giabsnbNXs+zkoG8CKp68tt3wjzIK4FxqsTNjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oTdRB6HM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93568C4AF0C;
	Wed, 31 Jul 2024 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722428692;
	bh=0anNzBpKovF2Z2rT0OXvMny0oFIf5sDVEn8xg+1pawY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTdRB6HMNHFR297WQonKbTjScv3qTZcLzSB+y6519LQMDW8ioUiqD3Aj3qKryiVSH
	 mfsQ4Nbi/VH7CdG7kOEQcw79I7uH27HKykzDY7FhRVuNExthFuhndITueXBofTzBER
	 yhALl0QUT4XGdECSAlH8Iahohp0TtNc0BeUBXIbY=
Date: Wed, 31 Jul 2024 14:24:49 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRD?=
 =?utf-8?Q?H_v2=5D_usb=3A_gadget=3A_uvc=3A_Fixes_th?= =?utf-8?Q?e?= abnormal
 enumeration problem of mobile phone as UVC camera.
Message-ID: <2024073151-crown-subdued-5776@gregkh>
References: <TYUPR06MB62175899DECC7A9B0DA0DF01D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024073150-pointless-makeshift-3745@gregkh>
 <TYUPR06MB621773E80A1CF0C4DD78CC5AD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB621773E80A1CF0C4DD78CC5AD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jul 31, 2024 at 12:03:50PM +0000, 胡连勤 wrote:
> Hello linux community expert:
> 
> Q: There  is no fixes tag here :(
> A: Is it necessary to add this fixes tag? I currently don’t know how to add this tag.

Please read Documentation/process/process/submitting-patches.rst for how
to do this.

> Q: Also you have a lot of trailing whitespace on the commit changelog, is that intentional?
> A: There was something wrong with the text editor I was using.
> 
> Note: This is my first time submitting a patch to the Linux community. I am still familiar with the detailed rules and feel very nervous.

Please slow down and read the in-kernel documentation pointed at above.
That should help out a lot here.

thanks,

greg k-h

