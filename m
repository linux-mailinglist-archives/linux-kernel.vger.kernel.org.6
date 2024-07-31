Return-Path: <linux-kernel+bounces-268962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4805F942BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BDF2812DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBF61AAE17;
	Wed, 31 Jul 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gG4CkjtF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB5208A4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420625; cv=none; b=Rk24062Z3MUZdsTvBxUU12DIdRh7EsNYZojB0A+BI6GTMpNcWWCi4iASg9P9JI0vnUPBxuTybTlSqpBcQsHnRCmy++sQiB3xo9OV2ir8I8TQdS9sHMn80OJpReNpRM35VnaMQ+yKLPCHDk2QJDcSl5IEYfpPTpLkSvRagKtI/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420625; c=relaxed/simple;
	bh=s4b8FXMKIENOpUiprH6jG5cJVVw9kqOTmdW46Lh/AY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCi1D9XlOd0cIAcuF0+Nu+H3esikPJMoHSvxTIFuGHBeBdmsHW8DyCzYJKWq6+Lr89iUSv7/yUNn7SJIlNumfL+U4MZF+uhvQNSCgRNKAXERbrsJfZ/2HglZFn67YHUVOhAxP19KSlMeCzghdyi/gQUkXHNMv3w5cyjHVaJRPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gG4CkjtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB975C116B1;
	Wed, 31 Jul 2024 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722420624;
	bh=s4b8FXMKIENOpUiprH6jG5cJVVw9kqOTmdW46Lh/AY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gG4CkjtFXqbs2KLCQ+Z/6FqtTWJ1oJkkRXkyUHQ27d7/6rUwxUQXpMyoY8+EWoOen
	 +gGDbJ7Q5NxHr5/0OudkMTaci09XTV8Ua7OJTqYWpjSdeyD30jp+JfdVqD62+hpVmk
	 Q6fjXdODTm2xewgweIQfhBm9PHlE5U6gu6O8b908=
Date: Wed, 31 Jul 2024 12:10:21 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBbUEFUQ0ggdjJdIHVzYjogZ2FkZ2V0OiB1dmM6IEZpeGVzIHRo?=
 =?utf-8?Q?e?= abnormal enumeration problem of mobile phone as UVC camera.
Message-ID: <2024073148-carport-drivable-5bf2@gregkh>
References: <TYUPR06MB621792398C6E5CF084D4586DD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB621792398C6E5CF084D4586DD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jul 31, 2024 at 10:01:45AM +0000, 胡连勤 wrote:
> Hello linux community expert:
> 
> I see no "Fixes:" tag here :(
>  ----- Modify the email title Fixed -> Fixes

Please read the kernel documentation for how to mark something with a
Fixes tag correctly.

thanks,

greg k-h

