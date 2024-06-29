Return-Path: <linux-kernel+bounces-234758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EE891CA7A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B3E1C21AB4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19B36FB9;
	Sat, 29 Jun 2024 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="y9FWHy3D"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A81153AC
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719627175; cv=none; b=SIJYkQEIMy35xejJY/l/2VEoTD6u3vApIdF+V5bsVTzbpWAhRWPwGRbLNBKVQdLqmwpc6YYKWKeaZl6pGn0WxS3uoTN7eqw2NWoGLt+z7U9xebCurWPtbPEcBH6cVsyI88ny/+2nyJXhsKeshJW87J5H1wduCZV1uvbTqFqiMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719627175; c=relaxed/simple;
	bh=cq/VRVddy45dedCcio6nv7ZkVGihyGjYP7Zj9CRAmlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kENzqIdkrkVmCn6BFiot1S4mRdXsyk43qh+GDWV9/+7GK+g67O0K6uypi4MzBtNS9yKOMKxhps4tQksbvqnuMFeMMo6VGGnI5PKVuySLBpPAgGta08Nzx6+AlsqMgAQwDlVH9nIT9ntk2oJF/TuhjAQpjsErXNQIe/mAzx5HdkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=pass smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=y9FWHy3D; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jookia.org
X-Envelope-To: jakobl.gm.g@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1719627169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a25bTE27wqTKuFvWrxZNULOpqakyZCl/Q4oa56L0f8o=;
	b=y9FWHy3DWAhkBtX0eh+qqKjdoBwh/Tbuj1OdX/bIUREBXQqQZzz3a+674KhiQMiUfb9I8P
	4BOcdCdEDzwuyeSRovbpBsXuQYZhoOSOL5Dp/AK5YzAVKL49xd06vHUAJsOTECpAf6gez1
	LeZNx++YOfINQGAQ4M9G+gvk1eN9mTT81LvyhIeQ4UUo3HQ6H9d2muxkqLlO+DdVXpCKIC
	YRERKTF9EVvsionjXKvdkQFcmzmL7ThR1S1H91bW4hC5msOaS/v1+DCg22dglSmeNfOv5Z
	wQZMMTVMi6miEimfJW27+OIWWPbnioJsWeX3a4aUC92bor6nN60p//Rhr+YXfQ==
X-Envelope-To: linux-sunxi@lists.linux.dev
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: kirby.nankivell@gmail.com
X-Envelope-To: contact@paulk.fr
X-Envelope-To: mripard@kernel.org
X-Envelope-To: wens@csie.org
X-Envelope-To: jernej.skrabec@gmail.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: samuel@sholland.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Sat, 29 Jun 2024 12:12:30 +1000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Jakob L <jakobl.gm.g@gmail.com>
Cc: linux-sunxi@lists.linux.dev, andre.przywara@arm.com,
	"K. James" <kirby.nankivell@gmail.com>,
	Paul Kocialkowski <contact@paulk.fr>,
	Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Samuel Holland <samuel@sholland.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: T113 TCON Top tinting troubleshooting
Message-ID: <Zn9tjooo9f-oe_3h@titan>
References: <Zn8GVkpwXwhaUFno@titan>
 <CALP2yXcUrCdzyqQx7RQUup3QjfbH4VnMVCPFVXNmmd08GJkKMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALP2yXcUrCdzyqQx7RQUup3QjfbH4VnMVCPFVXNmmd08GJkKMQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Jun 29, 2024 at 01:49:53AM +0200, Jakob L wrote:
> Hi John,
> 
> good find! This seems to fix it on my DSI implementation. Every of the
> recent boots resulted in a pink tint (usually it was green for me, or blue)
> Booted 10 times - no tint.
> 
> So this patch is good, but probably has to be implemented as a quirk?
> 
> Jakob

Hi Jakob,

I'm not sure if this needs to be a quirk: There's not really a reason to
set both DEs to the same output. My thinking right now is to error in
this situation.

However I think we have to somehow track which DEs have been set so we
can pretend they start unset. For example:

DE0: (Unset, LCD0) DE1: (Unset, TVE0)

Setting DE0 to LCD0 should work, then setting DE1 to LCD0 should fail.
Setting DE0 to LCD0 should work, then setting DE0 to TVE0 should work.
Setting DE0 to TVE0 should work, then setting DE1 to TVE0 should fail.

The mechanism here for setting a DE I think would go like this:

1. Check the opposite DE's value
2. If it is duplicate and set, error
3. If it is duplicate and unset, change the opposite DE's value
4. Set the DE
5. Mark it as set

Step three requires finding an unused DE value, this could be done by
inverting the bits of the new DE. Alternatively we could do what
Allwinner does and start with both DEs at different values and the move
instead the current DE value to the opposite DE to avoid conflicts.

'Set' here may make more sense as 'used'.

I'm good at mentally over-engineering things, so if you can think of a
better solution please tell me.

John.

