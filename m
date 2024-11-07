Return-Path: <linux-kernel+bounces-399330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C66A9BFD87
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D33F1C21982
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A681917E7;
	Thu,  7 Nov 2024 05:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qDg32I1I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024CC18858E;
	Thu,  7 Nov 2024 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730956491; cv=none; b=UmnLiG3FgEV6BwtlAtbHIQtmjOVwSgmx0vujDQNx22JuHTn66NhpgNYIzpR9P8CJYGOdQOrf5h9kZJBwm+b7CabnN+746/QetEB38SYdB2Q0Ms1FKpVLRCu5OB14s2dvA6lr++O3D9gfpbN03uAMH0a1IYrk9FZ2hvpoUoRqVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730956491; c=relaxed/simple;
	bh=iWGb3Yl9quIHI+wNbOzG+7sm0t9ullzXkfB6TkNObxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAAfDcU3+zNWLislUz3n3r4vSd81O5PPkjqTutmPcsW6LfMCV/FSHkKMcdhhqCC2ehrq7IPlg42Iwal2P2+HV+mFYx7BmJGg0t8W2BXm0CFD0K38CdIOPS3DZ6sZhc7BShWPkEcRk897/H7rx5wgXkaKfNyuO9rlyYTYp9WXFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qDg32I1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB45C4CECC;
	Thu,  7 Nov 2024 05:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730956490;
	bh=iWGb3Yl9quIHI+wNbOzG+7sm0t9ullzXkfB6TkNObxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDg32I1IACZtoMDuRxAlSPTrcanjkn58Pdda3Y5Q0sOeVXZ+/Cf7Z0XKPE2V9OQRu
	 HJLL3kvWSROiS31MQwIuhUFSJtd56pm7i/LJqdEqXkPZBUGC9DmHdXO5y4J1G3h9Mc
	 eQn3PAdfGFffix5yG/t+uCgicuNo1hge1I2d1Wz4=
Date: Thu, 7 Nov 2024 06:14:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Haowei Cheng(Harvey)" <harvey.cheng@fibocom.com>
Cc: "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?=
 0001-usb-mtu3-fix-panic-in-mtu3_gadget_wakeup.patch
Message-ID: <2024110735-lunacy-salvation-684c@gregkh>
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

Also, wait, why in the world are you using RNDIS when it is documented
to be an insecure and broken protocol?  Do you really trust both sides
of that connection?  If so, that's fine, but if not, please do not use
that protocol at all.

thanks,

greg k-h

