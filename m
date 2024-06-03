Return-Path: <linux-kernel+bounces-198666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086DD8D7BD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0DC1C20E45
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4E72AEE1;
	Mon,  3 Jun 2024 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uqxOBull"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE92942A;
	Mon,  3 Jun 2024 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396858; cv=none; b=Ss9lrs+dxlvSbhZIJ9m4I1xY4eOX2Vq13I0ZQJBuIu9tAN083Bs//tQkSmG6lBAHpRodkA80HSvRJXi+IELLn5IVRz/qzSN/XSQkTpsEa6PJH02koyn011P9Qs+rMBAKMh+9VCz/MRyE9m+ANvz1nCGH/DjTZoEHzFmNfdPANgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396858; c=relaxed/simple;
	bh=Ixgu9gEpoO7nBwh5VUEu4mUMBJ7nDgpJMH3OkVxAQHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTrWnEMGrVRtUk4HyrcGMQMJ4C27xERLyFn/DHQ32KFmHKh8Eyl2j9/tgk6cjk2XPiHT+kbdzV3BQfKVf3OYNCdFEQe07GTvGhuxKv5jfWZNtEwRE3aOYm1XLiU1ndumpqL4vEzyyk9b/3JsmYSByVFF7kmDPIt9rpdwtV4mDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uqxOBull; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018E9C2BD10;
	Mon,  3 Jun 2024 06:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717396857;
	bh=Ixgu9gEpoO7nBwh5VUEu4mUMBJ7nDgpJMH3OkVxAQHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqxOBullKy/kLR6dCqAW2ltEtgOT+3uwMkTkByyPkVepQEB8eTOcEeGSe3Nd3HYP4
	 0Z4AVORhYT9QuT8uyC38ZIEpE5tDkFbQKeAvIHm4La3jFOtKaBYiR+e7Jx69hojRkd
	 orUls1T+QTJnXk6AeS6nXkJzXI8snIzjyIFbO+R0=
Date: Mon, 3 Jun 2024 08:41:05 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Qianbin Zheng (NSB)" <qianbin.zheng@nokia-sbell.com>
Cc: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: fsl: Enable usb snoop on PPC64
Message-ID: <2024060342-neuron-trapeze-4e2d@gregkh>
References: <20240531091926.3324847-1-qianbin.zheng@nokia-sbell.com>
 <HE1PR07MB4169B7A47CC7105A9FC3E993ACFF2@HE1PR07MB4169.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR07MB4169B7A47CC7105A9FC3E993ACFF2@HE1PR07MB4169.eurprd07.prod.outlook.com>

On Mon, Jun 03, 2024 at 01:46:50AM +0000, Qianbin Zheng (NSB) wrote:
> Turn on usb snooping on PPC64.

This says what you are doing, but not _why_ you are doing it?

What changed to allow this to now work properly?

thanks,

greg k-h

