Return-Path: <linux-kernel+bounces-372509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956249A4997
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6DFCB224E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBA318FDD0;
	Fri, 18 Oct 2024 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="beoxhTm/"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90A188010;
	Fri, 18 Oct 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729290076; cv=none; b=je854HVtdXZjhDwwILQR+cpglqCdc5D3H1TLtiYU7bjFXE8jS9Oa6mNLcW+NbGgDkxdJilS0hpY47TDFZ6DnNGdec6LKmEBvkAf3VkmaXyjKbv0t2/eksDHs5gckzhu5/9Pv4r73Qkh7t8zhIu/ZowHdMKXNVr6vt/9tE58Lv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729290076; c=relaxed/simple;
	bh=7AX+UloeEVKGtCsWCJzVMK5wsfs3qcLMFGgDp508ASs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnrqKN/yeJfiSVMtffBpxaEhsFQkMT7PLtEUMB3TfLd5exHdBibDYqvy4iNFTjljMRr6FDI0Yf/yRgKzQVNlsU9I9s0BoMd8jjCiqjyQtkt6mtO8EC11p0sJyW2lZwzWvGbFt1DqXn8N+gwJaI3u7HzDqOztzmtqvXTI6aW/ybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=beoxhTm/; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id C159F177103; Fri, 18 Oct 2024 22:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729290073; bh=7AX+UloeEVKGtCsWCJzVMK5wsfs3qcLMFGgDp508ASs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=beoxhTm/t5XUtiGDsrMqOir9WwDiQKvhwGlIp9sIWzHKxRcHLViu1JP/nM898oFlR
	 ZezrcquVze/jENe0LUNM35so/esHGanHNe8AHCVNsge2F4fmGeb1zU9Vznt9OvL+0n
	 7Cff+dRRkSHFw/7JQI0++RbHXoFw0S0huyjSMKx41M3xf+J8Sa/HJcxazHMDyRFWS/
	 kh7uTgMJ+adjQ7qPfvV+rc1hS4WelPtU8Ks79xUIrG8uTtT0ZNetiM98YD6TVlRuEf
	 XzJyyt/VsuoHOfqwGOlu3hJruQbhvzAFjPNL/Gpyl26QT2H0p21dPbFdAc+lZ7Vj4x
	 t5lRoiwZS5/Nw==
Date: Fri, 18 Oct 2024 22:21:13 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Doug Anderson <dianders@chromium.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: English fixes in kgdb/kdb article
Message-ID: <20241018222113.GA799331@lichtman.org>
References: <20241018163136.GA795979@lichtman.org>
 <20241018175540.GA796909@lichtman.org>
 <CAD=FV=UwNAkam8HFhdPLRCXHf05LUXdJF++d-pvpFrCLtOypPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UwNAkam8HFhdPLRCXHf05LUXdJF++d-pvpFrCLtOypPQ@mail.gmail.com>

On Fri, Oct 18, 2024 at 12:46:14PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Oct 18, 2024 at 10:55 AM Nir Lichtman <nir@lichtman.org> wrote:
> >
> > @@ -201,7 +201,7 @@ Using loadable module or built-in
> >  Configure kgdboc at runtime with sysfs
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > -At run time you can enable or disable kgdboc by echoing a parameters
> > +At run time you can enable or disable kgdboc by writing parameters
> >  into sysfs. Here are two examples:
> 
> In response to v1, Matthew wanted you to change "the sysfs" into
> "sysfs". In the above it's no longer "the sysfs" but it's not part of
> your patch (no "-" of the old line with the "the" and "+" of the new
> line without the "the". Huh? This causes the patch to fail to apply.
> 
> Other than that, this all looks fine to me.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks, sorry about that mistake, will send a v3 with a fix shortly.

