Return-Path: <linux-kernel+bounces-268832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5DC942A02
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54EB9B23241
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6061A8BE5;
	Wed, 31 Jul 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hh2G9NJB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628023BB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417324; cv=none; b=KRn1Brh9eWsHriumDna8da7VafDY85SmXlSBNM9Pil+o9oeqyr8YaqjJRaoylayGClDETw2CtkXHaORa+FgxIJeB2gwpJisd7ZANeFeet8pyJDMShfyFmutd11sO7JfYkfDyOs1Edq1MRWbKTg7teDOt200K335fAoVTJA1KSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417324; c=relaxed/simple;
	bh=VUVEJWIPuADA7hUespGWuReHx2Ybc1MeYfyOMJsyXeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ0KTPqaSCzDzT83fkwtpsQMPtDsLiItFb+4ViPGaS2bHS2YOrVtU2XkNTEFRL0fJ6usJxUrYM4U7+gRoeWMd61rpYq2fpKo7TCuwGjsTFx8IKzD9Oab+3f239F6C5xRuC61yDD/S5PPqEznuH/0IM+wGkNpN9QrxqC824KKVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hh2G9NJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E42C116B1;
	Wed, 31 Jul 2024 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722417323;
	bh=VUVEJWIPuADA7hUespGWuReHx2Ybc1MeYfyOMJsyXeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hh2G9NJBoT6FoAjP2hGcmhcf9JZ+HuGFR2sBFiWL4KNX048LlttUH1gKyYRkD6Bz8
	 UfaeyPEbkzmsBvPuAg0JYAw2neai+siS0xfZDoAWPOWce3SsyHKExr1OHeYlaks6Z9
	 9s6PC7QXShGiVRj1E1bnpo+E4h/77oRX8ABz3piw=
Date: Wed, 31 Jul 2024 11:15:19 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjFdIHVz?=
 =?utf-8?Q?b=3A_gadget=3A_uvc=3A_Fixed_th?= =?utf-8?Q?e?= abnormal
 enumeration problem of mobile phone as UVC camera.
Message-ID: <2024073132-perjurer-coeditor-40a3@gregkh>
References: <TYUPR06MB6217A8530C44FD14D0ECA18CD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <TYUPR06MB62176DB2198FF5E5AF5825DED2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB62176DB2198FF5E5AF5825DED2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Wed, Jul 31, 2024 at 08:46:25AM +0000, 胡连勤 wrote:
> Hello linux community expert:
> 
> The following are answers to several questions about this patch:
> 
> 1.Why does the dwc3 controller matter here?  What about other controllers?
>  We have tested that both the dwc3 controller and the mtu3 controller 
>  have such problems under the uvc function combination.
> 
> 2.Why was this set to be true to start with?  What commit id does this
> fix?  Should it be backported to older kernels, and if so, how far back?
>  Set to true for commit records:
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f277bf27cf5cd56bcd1c4b95ae140f61680a6e83
>  
>  It seems that the f_uvc driver logic is optimized, and the code logic is more reasonable.

Please use the proper "Fixes:" tag on the commit.

>  
>  kernel5.10, kernel 5.15, kernel6.1, and kernel6.6 versions all need to be synchronized, 
>  From the current point of view, these kernel versions will be compatible with Android 14 and newer versions.

So this has never worked at all?  How is that possible?  Others have
used this properly, are you sure nothing is wrong somewhere else?

thanks,

greg k-h

