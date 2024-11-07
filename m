Return-Path: <linux-kernel+bounces-399328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D099BFD82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2091F22C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B0B18FDBC;
	Thu,  7 Nov 2024 05:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OJQiW6Tb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D77F9;
	Thu,  7 Nov 2024 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730956432; cv=none; b=mRVXL98G/wih+2pTG8nF62BSRxz+4vRK2Kz5Ic29SJ9lLVUJsHW06G2C0bFAFTpghavJIKSv+oUpzEAtrHmAyDmxL2AgPN/is70tgqqUUCTCOWVuJuBbHUvDJg9jbyqHDxdGmwA6E75C7Ixvi9+6wMaJpjqzXJLazRIDSCJrG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730956432; c=relaxed/simple;
	bh=XU5d9EvYNAXm7syZXOkrkzihF12wfuon3QHGq0L5hjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZZ7eDwHGOw11b+pjKkcHADmnbYc6aKwkW5axbje2nFII/Zsga4mlMLniC+ZpEjKKLN8eayE4XAtRf2nt6uiLx4QYO3+LOxA019ytwQS5T0Ur8vW8JqdgKT0rntPqy5tQzhcvCc3vMLtYviftkYk2iTwLThpP9JCDHVTmgC1GJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OJQiW6Tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB757C4CECC;
	Thu,  7 Nov 2024 05:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730956431;
	bh=XU5d9EvYNAXm7syZXOkrkzihF12wfuon3QHGq0L5hjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJQiW6TbRLQTAUf/tFxceEc5Fq13cvElbCVuIPf4YGliOYyFlGGoRo+CVjFVbbutx
	 6pg58vCsg06SZM0wXGQU6JjpR9F011lGD1d6nVhKjC/jVyPpHqrWWu7WxJLYWN6u8v
	 fZsa4dNddcFBEKpP+D1OHlsn8CTCb+a3wL6s6QR0=
Date: Thu, 7 Nov 2024 06:13:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Haowei Cheng(Harvey)" <harvey.cheng@fibocom.com>
Cc: "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?=
 0001-usb-mtu3-fix-panic-in-mtu3_gadget_wakeup.patch
Message-ID: <2024110735-entertain-parish-7b45@gregkh>
References: <SEZPR02MB54953820B2A9EEBD807D0ED18E512@SEZPR02MB5495.apcprd02.prod.outlook.com>
 <2024110512-popcorn-germless-01be@gregkh>
 <SEZPR02MB5495A8637098B92CDEBBFC6C8E532@SEZPR02MB5495.apcprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR02MB5495A8637098B92CDEBBFC6C8E532@SEZPR02MB5495.apcprd02.prod.outlook.com>

On Wed, Nov 06, 2024 at 07:39:59PM +0000, Haowei Cheng(Harvey) wrote:
> Hi greg k-h，
> 
> We found during development that when there are data packets to be sent on the USB RNDIS network card,
>  unplugging the USB cable will trigger a certain probability of system warning or panic.
> We observed that the mtu3_gadget_wakeup function uses the usleep_range_state function,
> which has certain scenario limitations. Therefore, we made this optimization.

Please do not top-post :(

Just resend your patch properly, in a format that we can apply it in,
and we will be glad to review and discuss it that way.

Look for thousands of examples on the lists for how to do this, as well
as the documentation in the kernel tree itself which explains this in
way-too-much detail.

thanks,

greg k-h

