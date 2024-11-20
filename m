Return-Path: <linux-kernel+bounces-415204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF8A9D32E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C441F23724
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603140BE5;
	Wed, 20 Nov 2024 04:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mitchellaugustin.com header.i=mitchell@mitchellaugustin.com header.b="Bp4N9Jq7"
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8C12E5B;
	Wed, 20 Nov 2024 04:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732076444; cv=pass; b=R3wCUM/PS0f1z6wMuNZFbzZbwiyYH4sRPgR9racpn5Sz4DqaRFsCDnwJ3CWdrLhrhkP5lRHOixix7YEV6KixmNAipziw/bOnV/1G2e5bOcL/nDfJGkc4lPeOvR58qGBiV/MRSLB+So5J7TzKsXi5H4QFQs1mHEpwxfKO1J86slU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732076444; c=relaxed/simple;
	bh=t90Hvawi2GNI9kzppLaoXPkcjXAE5P6hvgCMwrNY7fE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Q58XFOz+GLBncf+SnoI+vCvlnsGLdI5HwhFOALR1DJpCpsbOQ9yAXt2afkghiIqNp7Mt5ZwXaI3hiDLBTjVew8//f4Uhyw7tbh5o9/oWm4IuACLpS1tOw+7wijmZIhq6cdcvUO8dA3s/lReMLFtHwt2dD4eZ0k7j5uhLuzeGwz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitchellaugustin.com; spf=pass smtp.mailfrom=mitchellaugustin.com; dkim=pass (1024-bit key) header.d=mitchellaugustin.com header.i=mitchell@mitchellaugustin.com header.b=Bp4N9Jq7; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitchellaugustin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mitchellaugustin.com
ARC-Seal: i=1; a=rsa-sha256; t=1732076433; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=idoQIJ4KCvdu1Sg9CvbMe5X5LgmayH+sSk1EkdnhFnLNr2U6izhV8Pzd7q4GJOY48Hnd6pr00/qpzRH3/Sjy+xwzvvttDbW7btTDd5oNph/wCIAW6AFes9ArauoibDpqJYYBvl7CxjxD18d6LCTp/F0T+I2lC8AlU1q1w41EuCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732076433; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=rHEmzLKlp/AfS0Aq2l3BoB05N22t3t44AF62MSrMzV4=; 
	b=fU0phTGd7Ek9L8eU3WSWDmZdth8h2149KZ0ODiQD1gAPgFfFgdLYI4mwx2gA2hjeyP33+x/ruwFwQ1aOsNh8Paza/yDp8xVVWtFKSI+j3jRp2+ZVeMT8QLPOM0YsEg6i/0PuOFp0HSbtQGOGbfd8ZDDsTJDwXT5shURKuT8imAs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mitchellaugustin.com;
	spf=pass  smtp.mailfrom=mitchell@mitchellaugustin.com;
	dmarc=pass header.from=<mitchell@mitchellaugustin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732076433;
	s=zoho; d=mitchellaugustin.com; i=mitchell@mitchellaugustin.com;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=rHEmzLKlp/AfS0Aq2l3BoB05N22t3t44AF62MSrMzV4=;
	b=Bp4N9Jq79vMQ7MhC24KY+5xlq0M4Wb+sWsjFQl+lwq9wq3tSZ9uXRdxCmozXZUYf
	KLFSWDChnJMDCtffVfG1o0JNlsaYtXfgw+VUX6l8BYwkjb4Pfg7594GtdDAvmd68mhb
	9jhhsSrI8hqMFThNEykFhGLPMk6M+6DQFEtSrjdE=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1732076431271434.04917164835854; Tue, 19 Nov 2024 20:20:31 -0800 (PST)
Date: Tue, 19 Nov 2024 20:20:31 -0800
From: Mitchell Augustin <mitchell@mitchellaugustin.com>
To: "Corentin Chary" <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	"Hans de Goede" <hdegoede@redhat.com>,
	=?UTF-8?Q?=22Ilpo_J=C3=A4rvinen=22?= <ilpo.jarvinen@linux.intel.com>,
	"platform-driver-x86" <platform-driver-x86@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19347cce78e.1107b2a6f515198.6482303922487401469@mitchellaugustin.com>
In-Reply-To: <1933b52f4cc.d2378f8b154603.5100196514130862791@mitchellaugustin.com>
References: <1933b52f4cc.d2378f8b154603.5100196514130862791@mitchellaugustin.com>
Subject: Re: platform/x86: asus-wmi: Keyboard backlight brightness does not
 work correctly on Asus ROG Zephyrus G15
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Nevermind, upon further digging I found https://lore.kernel.org/all/20240713074733.77334-2-luke@ljones.dev/, which wasn't pulled into
my downstream kernel yet and verified that it does work for me.

Thanks,
Mitchell Augustin


---- On Sun, 17 Nov 2024 10:11:52 -0800 Mitchell Augustin  wrote ---

 > Hello, 
 >  
 > On my Zephyrus G15 (GA503RM-G15.R93060), 
 >  my keyboard brightness controls do not work. I believe I have traced 
 > this down to being a kernel issue, based on the fact that my Gnome 
 > control center slider and `asusctl -k` do result in 
 > `/sys/class/leds/asus::kbd_backlight/brightness` being updated, but the 
 > changed value of `/sys/class/leds/asus::kbd_backlight/brightness` is not 
 >  reflective of the actual brightness of my keyboard, which always 
 > remains unchanged. (I can also confirm that other keyboard/fan control 
 > features do work, such as the keyboard profile switcher, custom fan 
 > curves, etc. - so it just seems to be the brightness that is broken.) 
 >  
 > If this is likely just a case where I would need to poke around my hardware to 
 > find the correct values to write for brightness control to work on my 
 > specific SKU, I would be happy to do that and contribute it back here, but I 
 > will need some guidance on where to look for that info. 
 >  
 > Let me know if that would be helpful, or if there's any other info I can provide to help fix this bug. 
 >  
 > Thanks, 
 >  
 > Mitchell Augustin 
 > 


