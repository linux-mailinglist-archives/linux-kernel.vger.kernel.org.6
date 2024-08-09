Return-Path: <linux-kernel+bounces-281358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB1D94D5EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A33EB217BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29B6145324;
	Fri,  9 Aug 2024 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wqjv+a84"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C5A41;
	Fri,  9 Aug 2024 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226396; cv=none; b=cdT6PG2i2ti3sN4iQK/3PK/XdvIZzvuWDpUEeXiEsyy5gxQhCyIddXXCeeL7HBK788Fx0foG3JI46zGH1JBHfQSc8KYPll/zYS5wQ5tx4yoL7jCyYycRgcO6AKFv30LTbM9TemFJasq/iIA7T0KExrbdKTm32ILLjNRu2hqysd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226396; c=relaxed/simple;
	bh=nypHS1EE4qUC0zdtMb6b97DiChKfbQlclfQLdGn7M/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a+4kXoP1yhCW46QInuSfIn2uMzvYSzEZx8JpIHzzyBCbxcd/PjZnM5usT3eQy+D/fsWxIOHd6/H0oGrGa9DC1C3PAQhEmCeqDauM5rj/Xvo68/D9VB29le0nfNoeBoiCu6OTtCUQ5mIwgqMS5u6yZsxoXEIHExYTEFnIPcfdb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wqjv+a84; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D85420003;
	Fri,  9 Aug 2024 17:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723226392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xAub0mkPJ87xzsTXaBjAQ8FSWOArTO6I288vqwLrdYQ=;
	b=Wqjv+a84Ko1Fp2vlL/me5E8Q6bdXY+NpnPLT86U22+ahV6L2JllKhqWejwTpJeYjnMQliT
	RaxRcjyyTNwbFA6FYv0Mlc/01cmPslLEfQ3PtjzToVtyMR8I//KonRmam76Teqkh+wxMx9
	rdoVeEJvFXtIZryjwEk91Sa+kM8axhxr27qbIEogOOe/mJwzgR1QjZYJef+6HFO968tzBW
	55n0OOwFH/YDe0/+ElGJGVk3kw+5mGxlFPNYBW3/wNddw48eA1fNwF13BM6RcoOkb6E8Vz
	nYwvrkYPqz0hf2hLqmhh8+j4o/T1zth2/h1WXgGWOlOrl7IV5lx0UYIDxpUCIg==
Date: Fri, 9 Aug 2024 19:59:49 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: Marius Vlad <marius.vlad@collabora.com>,
	Jim Shargo <jshargo@google.com>, daniel@ffwll.ch,
	brpol@chromium.org, corbet@lwn.net, dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com, hirono@chromium.org, jshargo@chromium.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mairacanal@riseup.net, mduggan@chromium.org, melissa.srw@gmail.com,
	mripard@kernel.org, rodrigosiqueiramelo@gmail.com,
	tzimmermann@suse.de, maarten.lankhorst@linux.intel.com
Subject: [RFC] Adds support for ConfigFS to VKMS!
Message-ID: <ZrZZFQW5RiG12ApN@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	Marius Vlad <marius.vlad@collabora.com>,
	Jim Shargo <jshargo@google.com>, daniel@ffwll.ch,
	brpol@chromium.org, corbet@lwn.net, dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com, hirono@chromium.org, jshargo@chromium.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mairacanal@riseup.net, mduggan@chromium.org, melissa.srw@gmail.com,
	mripard@kernel.org, rodrigosiqueiramelo@gmail.com,
	tzimmermann@suse.de, maarten.lankhorst@linux.intel.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-GND-Sasl: louis.chauvet@bootlin.com

Hi everyone,

I'm excited to share some good news! I've recently completed the addition 
of a ConfigFS interface to VKMS, which allows to configure VKMS from 
user-space, at runtime. You should be able to:
- Create new devices
- Create planes/crtc/encoders
- Configure rotation, color range, color encoding
- Link planes, crtc and encoders.

The entire series can be found on my GitHub repository:
https://github.com/Fomys/linux/tree/b4/new-configfs

This series is big, consisting of over 40 commits. Although it's not 
completely cleaned up, all commits compile successfully and (almost) pass 
checkpatch.

I plan to split this series into several smaller ones:

 - Adding support for additional color formats
	4a4f75873cca..d74006d7f9c4
 - Reintroducing the writeback algorithm
	9e74d259e1be..f839dcf6a7d8
 - Clarifying documentation
	b3bfd0ba2283..93945f0fbfc7
 - Properly splitting headers
	c70018038572..67258bd8a180
 - Switching to drmm_ helpers
	844e701e1d6d..f3050d125f64
 - Using a proper platform device driver
	4658f99dfe3e..a3258e4d7550
 - Introducing a vkms_config structure
	95ad6da46638..5b2d080b4626
 - Adding ConfigFS support
	866ad75102ae..f900ad18ab8c

What's currently missing:

 - A deep cleanup to ensure checkpatch compliance and proper
   functionality for every commit
 - Updating documentation
 - Reviews 

The primary area where I need assistance is reviews and testers. I'm aware 
that Maìra is very busy and can't review quickly, but any other 
individuals who can test and/or review this series would be greatly 
appreciated.

My next step is to add connector support, but as I will use this work and 
my previous series [1], I would like to see it merged first.

If any of the original authors would like to be credited for 
their contributions, please let me know. I rewrote most of the code, but 
the general idea was originally from them.

José, I am sorry, I think I missed your mail where you told me you already 
reviewed some commits: 

> I reviewed the first 9 patches and added a few comments on your
> GitHub fork.

I am not able to find any comments, can you send me the link to the page 
with them? I would like to read/apply them before submitting the first 
part of the series.

Thanks for your time,
Louis Chauvet

[1]: https://lore.kernel.org/all/20240809-yuv-v10-0-1a7c764166f7@bootlin.com/

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

